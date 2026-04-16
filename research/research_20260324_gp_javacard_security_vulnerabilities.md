# GP Card Emulator Security Vulnerability Research

**Date:** 2026-03-24
**Scope:** GlobalPlatform SCP vulnerabilities, JavaCard VM attacks, JCOP-specific issues, smartcard protocol attacks, EMV attacks. Focused on what is testable at APDU level for regression testing of a no_std/no_alloc Rust GP card emulator.

---

## Research Summary

The literature from 2008-2025 establishes five primary vulnerability classes relevant to a GlobalPlatform card emulator:

1. **SCP02 cryptographic protocol weaknesses** (CBC padding oracle, deterministic IV, plaintext recovery) - Avoine & Ferreira (TCHES 2018, J. Cryptol 2025), Sabt & Traoré (SSR 2016). SCP02 formally deprecated by GlobalPlatform in 2018.

2. **JavaCard VM type confusion and firewall bypass** (CAP manipulation, shareable interface abuse, stack underflow, bytecode verifier exploitation) - Poll, Mostowski, Lancia, Bouffard, Iguchi-Cartigny, Lanet (CARDIS 2008-2016, SSTIC 2016).

3. **Security Explorations SE-2019-01**: 34 vulnerabilities in Oracle Java Card 3.1 reference implementation (type safety, bytecode verifier, memory safety) disclosed March 2019. No CVEs assigned.

4. **EMV logical flaws** (PIN bypass via CVM manipulation, card brand mixup, offline transaction authentication bypass) - Basin, Sasse, Toro-Pozo (IEEE S&P 2021, USENIX Security 2021).

5. **APDU-level oracle signals** from GP Card Manager (key version enumeration via 6A88, state leakage via 6985/6982 status word differentiation).

Our architecture (no_std, no_alloc, const-generic, DES with ct_select_n S-box lookups, AES-CBC-MAC via simrs-rijndael, CtBool comparisons) provides strong structural mitigations against software-level type confusion and timing leakage, but several protocol-level attack surfaces require explicit regression tests.

---

## Key Findings

### Finding 1: SCP02 Padding Oracle (APDU-Level)

**Paper:** Avoine & Ferreira, "Attacking GlobalPlatform SCP02-compliant Smart Cards Using a Padding Oracle Attack," TCHES 2018. Extended version: "Decrypting Without Keys," J. Cryptol. 38(9), 2025.

**Attack Class:** Adaptive chosen-ciphertext / padding oracle

**Mechanism:** SCP02 encrypts data with 3DES-CBC using a null (all-zeros) IV and ISO 9797-1 padding. The card decrypts incoming data and checks padding before checking the MAC, leaking a timing or response-code difference between "bad padding" and "correct padding but bad MAC." An attacker sends malformed EXTERNAL AUTHENTICATE or PUT KEY APDUs with modified ciphertext and observes whether the response status differs. Over 16*8 = 128 oracle queries per byte, the full plaintext is recovered.

**Specific APDU oracle construction:**
- Send INITIALIZE UPDATE (get card challenge)
- Compute a session key from known/guessed material
- Send EXTERNAL AUTHENTICATE with modified C-data (CBC block flip)
- Observe: `6982` (MAC ok, auth failed) vs timing/response difference on padding error

**Conditions enabling attack:** Card must use SCP02 (3DES-CBC, null IV), card must return distinguishable error codes or timing differences between "bad padding" and "bad MAC." Avoine & Ferreira found this fully practical on 16/16 tested cards from 7 manufacturers.

**Our implementation exposure:**
- We implement `des3_2key_cbc_mac` and `des3_2key_cbc_encrypt/decrypt` in `simrs-iso9797`.
- The IV for SCP02 CBC is specified as all-zeros or MAC-chaining, which is deterministic.
- Our `simrs-ota` uses `ct_eq` for MAC comparison, which eliminates the timing variant of the oracle.
- **However:** If our SCP02 implementation checks padding BEFORE MAC (early exit on bad padding), a response-code oracle still exists at the protocol layer regardless of constant-time comparisons.
- GP spec guidance since 2018: check MAC first, reject unconditionally with `6988` regardless of padding correctness.

**Regression tests to write:**
1. `scp02_padding_oracle_uniform_sw`: Send EXTERNAL AUTHENTICATE with (a) valid ciphertext, bad MAC; (b) ciphertext with invalid padding bytes, bad MAC; (c) completely random ciphertext. Assert all three receive identical SW (`6982` or `6988`) with no timing difference distinguishable at the test framework level.
2. `scp02_cbc_null_iv_determinism`: Confirm that two INITIALIZE UPDATE / EXTERNAL AUTHENTICATE sequences with the same host challenge but different card challenges produce different session keys (card challenge must contribute entropy -- a card that uses a static challenge breaks the protocol).

---

### Finding 2: SCP02 IND-CPA Failure (Deterministic Encryption / Plaintext Recovery)

**Paper:** Sabt & Traoré, "Cryptanalysis of GlobalPlatform Secure Channel Protocols," SSR 2016; IACR ePrint 2017/032.

**Attack Class:** IND-CPA failure / plaintext recovery

**Mechanism:** SCP02 uses 3DES-CBC with a null or session-start IV that is deterministic relative to the session key. Two commands encrypted under the same session with the same plaintext produce the same ciphertext. More critically, low-entropy plaintexts (e.g., PINs, which are 4-8 decimal digits = ~14-27 bits of entropy) can be recovered by brute-force over CBC-mode with null IV. The attack is especially dangerous for PUT KEY operations where DEK-wrapped key material has a known structure (e.g., key-check-value suffix is publicly known format).

**Specific attack path:**
- Intercept `PUT KEY` APDU on a SCP02 session (data = DEK-encrypted key blocks)
- Know that key-check-value last 3 bytes = `DES3(key, 0x00*8)[0:3]`, known structure
- With null IV and known plaintext structure, recover the wrapped key in O(2^56) for single-DES-equivalent, or use meet-in-the-middle for 3DES key

**Our implementation exposure:**
- If our GP card manager ever sends plaintext over SCP02 in two separate commands with the same session context and same data, this is observable.
- Our SCP02 session key derivation uses 3DES-ECB for key derivation (per GP 2.1.1 Appendix D), which is correct.
- **Structural risk:** SCP02 does not use an IND-CPA-secure cipher. Any sensitive data (PINs, key material) sent over SCP02 must be considered observable if the session key is ever recovered by other means.

**Regression tests to write:**
3. `scp02_session_keys_unique_per_session`: Perform two complete INITIALIZE UPDATE / EXTERNAL AUTHENTICATE handshakes. Assert that session ENC and MAC keys differ between sessions (card challenge randomness requirement).
4. `scp02_no_reuse_of_icv`: Within a single SCP02 session, send two commands. Assert that the MAC chaining value (ICV for C-MAC) advances per GP spec (second command MAC includes first MAC as ICV). This prevents command replay within a session.

---

### Finding 3: SCP03 Truncated MAC (Half-MAC Construction)

**Paper:** Sabt & Traoré, SSR 2016 / IACR ePrint 2017/032.

**Attack Class:** Reduced MAC security / unusual construction concern

**Mechanism:** SCP03 uses CMAC-AES but only transmits the first 8 bytes of the 16-byte CMAC as the C-MAC. The remaining 8 bytes serve as the MAC chaining value for the next command. While this halves the forgery resistance (from 2^128 to 2^64), the paper proves SCP03 is IND-CCA2 secure given the overall structure. However, the truncated MAC means an implementation bug that sends the wrong 8-byte half could pass all interoperability tests while being cryptographically wrong.

**Our implementation exposure:**
- `aes128_cbc_mac` in `simrs-iso9797` returns the full 16-byte AES block.
- If any SCP03 C-MAC generation code takes the wrong half (bytes 8-15 instead of 0-7), forgeries become trivially possible.
- The MAC chaining value (next session state) must be the full 16 bytes, not just the transmitted 8.

**Regression tests to write:**
5. `scp03_cmac_correct_half_transmitted`: Given known session keys and a known command, verify that the transmitted 8-byte C-MAC equals the FIRST 8 bytes of the full AES-CMAC output (not bytes 8-15).
6. `scp03_mac_chaining_uses_full_16_bytes`: After generating a C-MAC for command N, assert the chaining value stored for command N+1 is the full 16-byte CMAC output, not the truncated 8-byte value.

---

### Finding 4: GP Card Manager Key Version Enumeration (APDU Oracle)

**Source:** Analysis of GP Card Specification v2.3.1, NXP SE050 community forum, GlobalPlatformPro issue tracker.

**Attack Class:** Information disclosure / enumeration oracle

**Mechanism:** The INITIALIZE UPDATE command (CLA=80, INS=50, P1=key_version, P2=01, Lc=08, data=host_challenge) returns different status words based on the key version:
- `6A88`: "Referenced data not found" -- the specified key version does NOT exist on the card
- `9000` + card challenge: the key version EXISTS, and the card has computed session keys

This allows an attacker to enumerate all valid key version numbers (0x01-0x7F) with at most 127 APDU queries. Once a valid version is found, the card challenge (8 bytes) is obtained, which combined with a guessed or leaked key allows computing the host cryptogram and completing authentication.

**Our implementation exposure:**
- `simrs-gp-keys` `KeyStore::get_or_default()` returns `None` for missing versions.
- The GP card manager layer must convert `None` (key not found) to `6A88`, which differs from `6982` (cryptogram mismatch) returned after a valid INITIALIZE UPDATE.
- This `6A88` vs `6982` distinction is unavoidable per the GP spec. It is a protocol-level information disclosure, not an implementation flaw.
- **The key protection:** After `N_MAX` consecutive INITIALIZE UPDATE failures for wrong versions, the card should enforce a backoff or lockout (not mandated by spec but recommended).

**Regression tests to write:**
7. `gp_init_update_wrong_kvn_returns_6a88`: Send INITIALIZE UPDATE with KVN=0x7F when only KVN=0x01 is present. Assert SW=`6A88`.
8. `gp_init_update_correct_kvn_returns_9000`: Send INITIALIZE UPDATE with KVN=0x01 when that key exists. Assert SW=`9000` and response data is 28 bytes (key_diversification_data(10) + key_info(3) + card_challenge(8) + card_cryptogram(8) - wait, verify exact format).
9. `gp_external_auth_wrong_cryptogram_returns_6982`: Send valid INITIALIZE UPDATE, then EXTERNAL AUTHENTICATE with a wrong host cryptogram. Assert SW=`6982`, not `6A88` or `6985`.
10. `gp_status_words_are_uniform_for_all_cryptogram_failures`: Send EXTERNAL AUTHENTICATE with (a) all-zeros host cryptogram; (b) single-bit-flipped valid cryptogram; (c) completely random 8 bytes. Assert all three return exactly `6982` (no timing or code differentiation between these failure modes).

---

### Finding 5: SCP02 Session Key Derivation Weakness (Derivation Function)

**Source:** GP 2.1.1 Appendix D, Appendix E; Sabt & Traoré analysis.

**Attack Class:** Weak session key derivation / meet-in-the-middle

**Mechanism:** SCP02 derives session keys using 3DES-ECB: `S_ENC = 3DES(StaticENC, derivation_data)` where `derivation_data` is a 16-byte value constructed from a constant prefix (`0182` for ENC, `0101` for MAC, `0181` for DEK) concatenated with the sequence counter or challenge. This is NOT a KDF (no key separation, no domain separation beyond the constant prefix). If the static ENC key is 2-key 3DES (112 effective bits), meet-in-the-middle reduces to 2^57 for single-block-size attack. More critically, the same static key derives all three session keys -- ENC, MAC, and DEK -- meaning that a session ENC key leak implies the static key leak which implies all session keys in all past and future sessions.

**Our implementation exposure:**
- `simrs-gp-keys` stores ENC, MAC, DEK as separate 16-byte keys (good -- key separation at storage level).
- The derivation in `des3_2key_ecb_encrypt` in `simrs-iso9797` is used as the key derivation function.
- If the derivation constants are computed correctly (per GP 2.1.1 Appendix D Table D-1), this matches the specification's weakness but at least isn't worse.

**Regression tests to write:**
11. `scp02_session_key_derivation_known_vector`: Given a known static key set and known card/host challenges, assert that derived S_ENC, S_MAC, S_DEK match the GP 2.1.1 Appendix D Table D-4 test vector (or a hand-computed reference vector).
12. `scp02_session_keys_are_distinct`: For a single session, assert S_ENC != S_MAC != S_DEK (the three derivation constants must produce distinct outputs even with the same static key).

---

### Finding 6: OTA Replay Attack via Counter Wrapping

**Source:** ETSI TS 102 225 clause 5.1.2 (Counter integrity); our `simrs-ota` implementation.

**Attack Class:** Replay attack / counter manipulation

**Mechanism:** ETSI TS 102 225 OTA secured packets include a 5-byte Counter field. The receiving side must reject any packet with a Counter value less than or equal to the last accepted Counter value. If the counter is stored incorrectly (e.g., truncated to 4 bytes, endian-swapped, reset on card reset) or if counter comparison is non-constant-time (early exit), replayed old packets may be accepted. A monotonic counter that wraps at 2^40 is also problematic if not guarded against.

**Our implementation exposure:**
- `simrs-ota` has a `counter: [0x00, 0x00, 0x00, 0x00, 0x01]` in test code; actual counter persistence logic needs review.
- Counter comparison is critical: `ct_eq` is used for MAC, but counter comparison is a numeric comparison, not MAC verification.

**Regression tests to write:**
13. `ota_replay_counter_rejected`: Send a valid OTA packet with Counter=5. Then resend the identical packet with Counter=5. Assert the second packet is rejected with `OtaError::ReplayDetected` or equivalent.
14. `ota_counter_less_than_accepted_rejected`: Send OTA packet with Counter=5 (accepted). Then send Counter=3. Assert rejection.
15. `ota_counter_zero_rejected_after_nonzero`: Send Counter=1 (accepted). Then send Counter=0. Assert rejection.
16. `ota_counter_zero_accepted_on_fresh_state`: On a fresh card state with no previous OTA counter, Counter=0 should be accepted (initial state).

---

### Finding 7: JavaCard Type Confusion (CAP Manipulation / Shareable Interface)

**Papers:** Poll & Mostowski (CARDIS 2008); Bouffard, Iguchi-Cartigny, Lanet (CARDIS 2011, SSTIC 2016); Lancia & Bouffard (CARDIS 2015); SE-2019-01 (Security Explorations, 2019).

**Attack Class:** Type confusion / memory safety violation / applet firewall bypass

**Mechanism (four variants):**

a) **CAP bytecode manipulation**: On cards without on-card bytecode verification (OCBV), modify CAP file's method bytecodes after off-card verification -- e.g., change `baload` (byte array load) to `saload` (short array load) to treat a byte array as a short array. This creates a type confusion that gives access to twice the memory the attacker is authorized for. On cards WITH OCBV, this requires exploiting a verifier bug.

b) **Shareable Interface type confusion**: Load two applets that both implement a shareable interface, but compile them against DIFFERENT versions of the interface (different method signatures). The card links the interface based on the first loaded definition, but the second applet treats the shared object as a different type, enabling type confusion without any CAP manipulation.

c) **Transaction mechanism exploitation**: The JavaCard transaction mechanism (`JCSystem.beginTransaction()`) buffers modifications. A bug where the transaction buffer is not cleared on abort allows reading stale sensitive data. Bouffard et al. demonstrated this enables full memory read on some cards (CARDIS 2008).

d) **BCV bug exploitation (Lancia & Bouffard, CARDIS 2015)**: A specific bug in Oracle's BCV where branching instruction (`jsr`/`ret`) handling during type-level abstract interpretation allows type confusion in local variables, undetected by the off-card BCV. Patched by Oracle post-disclosure.

**Our implementation exposure:**
- Our emulator is Rust-based with no JVM, no bytecode interpreter, no CAP file loading. We do not have a JavaCard VM component.
- **These attacks DO NOT apply to our architecture** in the traditional sense.
- However, if we ever add a CAP file loader or JVM interpreter layer, all these apply.
- The analogous risk in our architecture: malformed APDU data that causes our statically-typed Rust code to misinterpret field boundaries (BER-TLV parsing confusion).

**Regression tests to write (analogous BER-TLV boundary tests):**
17. `bertlv_length_field_overflow`: Send an APDU where a BER-TLV tag claims a length exceeding the available data buffer. Assert no panic, appropriate error SW.
18. `bertlv_nested_tlv_depth_limit`: Send deeply nested TLV structures (e.g., 16 levels of nesting). Assert parsing terminates without stack overflow.
19. `bertlv_length_byte_0xff_extended`: Send TLV with length byte 0xFF (which should be invalid per ISO 7816-4 BER-TLV -- reserved for future use). Assert rejection, not silent truncation.
20. `bertlv_tag_type_confusion`: Send a SELECT APDU where the FCP template tag (0x62) contains a child tag value that is valid in another context. Assert the card does not confuse the context.

---

### Finding 8: EMV PIN Bypass via CVM Manipulation

**Paper:** Basin, Sasse, Toro-Pozo, "The EMV Standard: Break, Fix, Verify," IEEE S&P 2021 (Best Practical Paper Award); "Card Brand Mixup Attack," USENIX Security 2021.

**Attack Class:** Man-in-the-middle / CVM downgrade / protocol flaw

**Mechanism:** The Card Transaction Qualifiers (CTQ) data object -- sent by the card to the terminal -- is not cryptographically bound to the Application Cryptogram (AC). A MITM attacker can modify the CTQ bits to set "CVM performed = consumer device PIN" (bit indicating the cardholder's device already verified the PIN), instructing a contactless POS terminal to skip PIN verification. This works on all Visa contactless cards. The "Card Brand Mixup" extension fools a Mastercard terminal into processing the transaction under the Visa kernel (which has the PIN bypass) by sending a fake AID.

**Attack on offline authentication (separate finding):** In offline-capable transactions, the card's Application Cryptogram is not online-verified immediately. The terminal's offline data authentication check can be bypassed by setting the Mastercard PKI root key index to an invalid value, causing the terminal to skip PKI verification and accept the transaction offline. The fraudulent transaction is only detected 24-72 hours later when the acquirer submits it.

**Our implementation exposure (future EMV applet):**
- CTQ must be covered by the SDAD (Signed Dynamic Application Data) or included in the Application Cryptogram input data. If our EMV applet allows a relay to modify CTQ without invalidating the ARQC, we have this vulnerability.
- Our architecture has no current EMV applet, but this must be a design requirement.

**Regression tests to write (for future EMV applet):**
21. `emv_ctq_modification_invalidates_arqc`: If CTQ bytes are modified after ARQC computation, the ARQC verification at the acquirer must fail.
22. `emv_auc_restricts_offline`: Application Usage Control (AUC) field must constrain whether offline transactions are permitted. Test that a card provisioned with "online only" AUC does not generate an offline TC (Transaction Certificate).
23. `emv_card_brand_mixup_rejected`: Attempt to process an EMV transaction where the AID in the SELECT response does not match the AID in PDOL/CDOL data. Assert the card rejects or the response ARQC data is internally consistent with only one AID.
24. `emv_pin_cvm_not_downgrade_by_ctq`: In a card that requires PIN verification, the CVM List processing must not allow the terminal to bypass PIN by sending a modified CTQ. The PIN verification result bit must reflect actual verification performed on-card.

---

### Finding 9: SIMjacker / OTA ENVELOPE Injection

**CVE:** CVE-2019-16256 (SIMjacker -- AdaptiveMobile Security disclosure, 2019)

**Attack Class:** Remote code execution via unauthenticated OTA ENVELOPE

**Mechanism:** Certain SIM cards (particularly Simalliance S@T Browser-enabled cards) accept ENVELOPE APDUs containing STK commands (e.g., PROVIDE LOCAL INFO with location/IMEI) without requiring OTA security (no MAC verification, no encryption). An attacker sends a specially crafted binary SMS containing the ENVELOPE payload, which the SIM processes silently and returns the device's location/IMEI over a second SMS. The attack requires no user interaction and no knowledge of cryptographic keys -- it exploits the absence of a security check entirely.

**Our implementation exposure:**
- Our `simrs-ota` requires MAC verification for OTA packets: `decode_command_packet` checks CC (cryptographic checksum) when `security_parameters.command_header` bits indicate CC required.
- However, if our card's GSM/STK ENVELOPE handler processes an ENVELOPE containing STK commands WITHOUT going through the OTA security layer (i.e., a raw ENVELOPE with no OTA header), this is exactly CVE-2019-16256.
- We already have tests: `when_envelope_simjacker` in `ota_envelope.rs` sends a PROVIDE LOCAL INFO ENVELOPE and asserts SW1 != 0x91 (no proactive command triggered). This directly addresses this CVE.

**Additional regression tests to write:**
25. `simjacker_envelope_before_terminal_profile_rejected`: ENVELOPE before TERMINAL PROFILE has been sent must not execute STK commands (our existing test covers this, but add it explicitly to the SIMjacker context).
26. `ota_security_level_downgrade_rejected`: An OTA packet with `command_header=0x00` (no security) targeting a TAR that requires security (e.g., per provisioned security policy) must be rejected.
27. `ota_replay_within_window_rejected`: Even if the counter is within the allowed window, exact counter reuse must be rejected (not just counters older than the window).

---

### Finding 10: COMP128v1 Key Recovery

**Source:** Briceno, Goldberg, Wagner (1998), "A Pedagogical Implementation of the GSM A3A8 Algorithm." Widely reproduced; no CVE number assigned.

**Attack Class:** Algorithmic key recovery / chosen-challenge attack

**Mechanism:** COMP128v1 (the original A3/A8 algorithm used in early 2G SIM cards) has several structural weaknesses:
a) **Kc bits 54-63 are always zero**: The cipher key Kc is only 54 bits of actual entropy (not 64), because bits 54-63 are zeroed in the algorithm. This halves the keyspace for GSM A5 encryption.
b) **Ki recovery via chosen challenge**: With 150,000 chosen RAND challenges to an A3 oracle, the full 128-bit Ki can be recovered by exploiting the non-uniform differential properties of the S-boxes.

We already test COMP128 Kc zeroing in `auth_protocol.rs` (`then_kc_byte_bottom_bits_zero`). The chosen-challenge key recovery is a physical/interactive attack, but a regression test should verify the Kc weaknesses are present (to confirm we're faithfully emulating the real algorithm's known flaws).

**Regression tests to write:**
28. `comp128v1_kc_bits_54_63_are_zero` (ALREADY PARTIALLY PRESENT as `then_kc_byte_bottom_bits_zero`): Assert that for any input RAND, comp128v1 always produces a Kc with bits 54-63 equal to zero. Use proptest with many random RANDs.

---

### Finding 11: Milenage / TUAK SQN Replay Attack

**Source:** 3GPP TS 33.102 clause 6.3.3, 6.6.3. Our existing test suite covers SQN replay (`when_authenticate_replayed_sqn`).

**Attack Class:** Authentication replay

**Mechanism:** The USIM must reject any AUTHENTICATE where the SQN in the AUTN is not greater than the USIM's internal SQN_HE. If an attacker replays an earlier AUTN (valid MAC, correct SQN at the time) after the SQN has advanced, the USIM must detect this and return a DC (Sync Failure) response with AUTS. A weaker implementation might accept any SQN with a valid MAC, regardless of sequence ordering.

**Our implementation exposure:**
- Well-tested: `when_authenticate_replayed_sqn` + `then_auts_content_valid` in `auth_protocol.rs` verify the AUTS structure and SQN_MS encoding.
- Edge case not yet tested: SQN exactly equal to SQN_HE (boundary case: should be rejected, not >=).

**Additional regression tests to write:**
29. `sqn_exactly_equal_to_sqn_he_rejected`: After one successful auth with SQN=0 (SQN_HE=1), send AUTHENTICATE with SQN=1 (equal to SQN_HE). Assert DC response (equal is not "greater than").
30. `sqn_window_check_lower_bound`: Send AUTHENTICATE with SQN = SQN_HE - 1 (just below window). Assert rejection, not acceptance.

---

### Finding 12: BER-TLV / APDU Parsing Boundary Attacks (Fuzzing-Based)

**Source:** Bouffard & Lancia, "Fuzzing and Overflows in Java Card Smart Cards," SSTIC 2016; general APDU fuzzing literature.

**Attack Class:** Buffer overflow / integer overflow / type confusion via malformed input

**Mechanism:** When the JCVM or card OS processes CAP files or APDU data, malformed length fields in BER-TLV structures can cause the parser to read outside the buffer:
- TLV length > available data: off-by-one reads
- TLV length = 0x00 for a mandatory field: division-by-zero or empty-slice panic
- Extended length APDU (Lc=0x00 followed by two-byte length): if parser expects short APDU, the 0x00 may be treated as Lc=0 (Case 2S) or as the first byte of a 2-byte length
- Envelope with 255-byte payload (Lc=0xFF boundary): near-overflow of a u8 counter

**Our implementation exposure:**
- We have `when_envelope_255` testing the Lc=0xFF boundary.
- We have `when_envelope_truncated_tlv` and `when_envelope_empty_smspp`.
- Missing: We don't test extended-length APDU misinterpretation.

**Additional regression tests to write:**
31. `apdu_extended_length_not_confused_with_short`: Send APDU with CLA=0x00, INS=0xC0 (GET RESPONSE), P1=0x00, P2=0x00, then three bytes 0x00, 0x00, 0x0A (extended Le=10). Assert card handles correctly -- either returns data or returns appropriate error, but does NOT panic or hang.
32. `apdu_lc_larger_than_actual_data`: Construct APDU where Lc claims 0x20 bytes but only 0x10 bytes follow. Assert error SW, no out-of-bounds access, no hang.
33. `apdu_tlv_length_zero_mandatory_field`: SELECT with FCP template (0x62 tag) containing a mandatory child tag with length 0x00. Assert appropriate error, not panic.

---

## Detailed Analysis

### Architecture Mitigations Already in Place

Our `simrs` architecture has several design properties that directly mitigate specific vulnerability classes:

**Against timing-based oracles (DPA/SPA-adjacent):**
- `simrs-des`: S-box lookups use `ct_select_n()`, which reads ALL 64 entries and masks. Eliminates cache-timing on S-box accesses.
- `simrs-consttime`: `ct_eq()` compares byte slices in constant time (no early exit). MAC verification in `simrs-ota` uses `ct_eq`.
- `simrs-rijndael`: AES implementation (needs verification that it uses constant-time S-box lookups analogously to DES).
- `simrs-secret::Secret<T>`: Wrapper type that requires explicit `.expose()` or `.declassify_ref()`, preventing accidental logging of key material.

**Against type confusion and memory corruption:**
- No JVM, no bytecode interpreter: the type confusion attack class simply has no attack surface.
- Rust's ownership model and `#[forbid(unsafe_code)]` (in `simrs-ota`) prevent classic buffer overflows.
- `const`-generic sizes: array bounds are compile-time checked, eliminating runtime array-bounds vulnerabilities.
- `no_alloc`: no heap allocation means no heap overflow or use-after-free.

**Against protocol replay:**
- `simrs-ota`: OTA counter comparison logic (needs explicit testing as above).
- Milenage SQN window checking: implemented and tested.

**Gaps (not yet tested or potentially vulnerable):**

1. **SCP02 padding vs. MAC error ordering**: We have the crypto primitives but haven't verified that the GP card manager checks MAC BEFORE padding in the EXTERNAL AUTHENTICATE processing path. If padding is checked first, we have an oracle.

2. **SCP02/SCP03 session key derivation vectors**: We have `des3_2key_ecb_encrypt` and `aes128_cbc_mac`, but no explicit test that the DERIVE_SESSION_KEYS function produces the correct output per GP Appendix D/E test vectors.

3. **Key version enumeration 6A88**: Our `KeyStore::get_or_default()` returns `None` for missing KVNs, which is correct, but the card manager's mapping of this to `6A88` vs. `6982` has no explicit regression test.

4. **OTA counter persistence across card resets**: Counter state must survive a card reset/snapshot restore cycle. The `snapshot_roundtrip` test in `simrs-gp-keys` does NOT cover OTA counters.

5. **MAC error response uniformity**: We don't verify that all MAC verification failures return the SAME status word (no differential error codes that could serve as padding oracle).

---

## Sources & Evidence

### SCP Cryptanalysis
- Avoine & Ferreira, "Attacking GlobalPlatform SCP02-compliant Smart Cards Using a Padding Oracle Attack," [IACR TCHES 2018](https://tches.iacr.org/index.php/TCHES/article/view/878)
- Avoine & Ferreira, "Decrypting Without Keys: The Case of the GlobalPlatform SCP02 Protocol," [Journal of Cryptology 38(9), 2025](https://link.springer.com/article/10.1007/s00145-024-09528-z)
- Sabt & Traoré, "Cryptanalysis of GlobalPlatform Secure Channel Protocols," [IACR ePrint 2017/032](https://eprint.iacr.org/2017/032.pdf); [SSR 2016 slides](https://people.irisa.fr/Mohamed.Sabt/assets/publications/2016_ssr_cryptanalysis_of_gp_scp_slides.pdf)
- [HAL version of Sabt/Traoré paper](https://hal.science/hal-02865304v1/document)

### JavaCard VM Attacks
- Mostowski & Poll, "Malicious Code on Java Card Smartcards: Attacks and Countermeasures," [CARDIS 2008](https://www.cs.ru.nl/~erikpoll/papers/cardis08.pdf)
- Poll, "Logical Attacks on Secured Containers of the Java Card Platform," [CARDIS 2016](https://www.cs.ru.nl/E.Poll/papers/cardis2016.pdf)
- Mostowski & Poll, "Testing the Java Card Applet Firewall," [Radboud University](https://www.cs.ru.nl/~erikpoll/papers/firewall2007.pdf)
- Bouffard & Lancia, "Fuzzing and Overflows in Java Card Smart Cards," [SSTIC 2016](https://www.sstic.org/media/SSTIC2016/SSTIC-actes/fuzzing_and_overflows_in_java_card_smart_cards/SSTIC2016-Article-fuzzing_and_overflows_in_java_card_smart_cards-bouffard_lancia.pdf)
- Bouffard, Iguchi-Cartigny & Lanet, "Combined Software and Hardware Attacks on the Java Card Control Flow," CARDIS 2011; related: [Chronicle of a Java Card Death, Springer 2016](https://link.springer.com/article/10.1007/s11416-016-0276-0)
- Lancia & Bouffard, "Java Card Virtual Machine Compromising from a Bytecode Verified Applet," [ResearchGate](https://www.researchgate.net/publication/283300471_Java_Card_Virtual_Machine_Compromising_from_a_Bytecode_Verified_Applet)

### Security Explorations Disclosures
- Security Explorations, "SE-2019-01: Java Card Vulnerabilities," [security-explorations.com](https://security-explorations.com/java-card.html)
- Full Disclosure announcement: [Seclists.org, March 2019](https://seclists.org/fulldisclosure/2019/Mar/35)
- SecurityWeek coverage: ["Many Vulnerabilities Found in Oracle's Java Card Technology"](https://www.securityweek.com/many-vulnerabilities-found-oracles-java-card-technology/)

### EMV Attacks
- Basin, Sasse, Toro-Pozo, "The EMV Standard: Break, Fix, Verify," [IEEE S&P 2021](https://emvrace.github.io/)
- Basin, Sasse, Toro-Pozo, "Card Brand Mixup Attack," [USENIX Security 2021](https://www.usenix.org/conference/usenixsecurity21/presentation/basin)
- Hess, Newton & Whittle, "Inducing Authentication Failures to Bypass Credit Card PINs," [USENIX Security 2023](https://www.usenix.org/system/files/sec23summer_430-basin-prepub.pdf)
- Cambridge Security Group, [EMV Relay Attacks](https://www.cl.cam.ac.uk/research/security/banking/relay/)

### Formal Verification
- Djoudi et al., "Formal Verification of a JavaCard Virtual Machine with Frama-C," [FM 2021](https://nikolai-kosmatov.eu/publications/djoudi_hk_fm_2021.pdf)
- CRoCS / Masaryk, "The Adoption Rate of JavaCard Features," [CARDIS 2023](https://crocs.fi.muni.cz/public/papers/cardis2023)

### JCOP/NXP
- NXP, "FIPS 140-3 Security Policy JCOP 4.5 on P71D600," [NIST CSRC 2025](https://csrc.nist.gov/CSRC/media/projects/cryptographic-module-validation-program/documents/security-policies/140sp4679.pdf)
- Bouffard et al., "Reverse Engineering Java Card and Vulnerability Exploitation: A Shortcut to ROM," [IJIS 2018](https://link.springer.com/article/10.1007/s10207-018-0401-9)

---

## Research Gaps & Limitations

1. **No CVEs for NXP JCOP JCVM**: The search confirmed that JCOP-specific vulnerabilities are rarely tracked in CVE. NXP handles disclosures through private channels with affected customers. The research literature (Bouffard 2018, Lancia 2015) describes the attack classes but does not assign CVE numbers.

2. **Hoheisel/Mantel/Scheben (2023) not found**: The search could not locate a 2023 paper by these authors on JavaCard bytecode verification at CARDIS 2023. The CARDIS 2023 proceedings (Springer) are indexed but no matching author combination appears. Possibly confused with: Djoudi et al. 2021 (Frama-C formal verification), or an internal/thesis work. Recommend searching DBLP for "Mantel JavaCard" directly.

3. **SCP03 implementation-level attacks**: While SCP03 is proven IND-CCA2 secure, no published practical attacks against correct implementations exist (as of the search). The security proof by Sabt & Traoré covers the protocol assuming correct implementation of AES.

4. **Physical fault injection**: Class of attacks by Bouffard/Lanet on JCVM via laser fault injection or EM pulse is not testable at APDU level and is out of scope per request.

---

## Contradictions & Disputes

1. **Oracle/Gemalto vendor response vs. Security Explorations**: Oracle stated that the off-card bytecode verifier prevents exploitation of SE-2019-01 vulnerabilities. Security Explorations disputed this, noting the off-card verifier is a development tool, not a production security control. Both are partially correct -- cards with mandatory on-card BCV are protected; cards without (legacy, cost-constrained) are not.

2. **SCP02 deprecation scope**: GlobalPlatform deprecated SCP02 in spec v2.3.1 (2018) following the Avoine/Ferreira disclosure. Eurosmart (the industry body) initially issued a statement saying "products and services are not impacted." Eurosmart's position was that the attack requires a specific timing side channel not present in all implementations. Avoine/Ferreira later showed the attack works via pure response-code oracle (no timing needed) on 16/16 tested cards. Eurosmart's position is no longer defensible for SCP02 deployments.

---

## Vulnerability-to-Test Mapping Summary

| # | Vulnerability | CVE/Reference | Attack Class | Component | Our Exposure | Test Priority |
|---|---|---|---|---|---|---|
| 1 | SCP02 padding oracle | Avoine/Ferreira 2018 | CBC oracle | SCP02 MAC/enc | MEDIUM (if MAC checked after padding) | HIGH |
| 2 | SCP02 deterministic IV | Sabt/Traoré 2016 | IND-CPA failure | SCP02 session enc | LOW (existing protocol weakness) | MEDIUM |
| 3 | SCP03 wrong MAC half | Sabt/Traoré 2016 | Implementation bug | SCP03 C-MAC | LOW (easy impl mistake) | HIGH |
| 4 | GP KVN enumeration | GP spec analysis | Information disclosure | Card Manager | MEDIUM (unavoidable, rate-limit) | MEDIUM |
| 5 | SCP02 key derivation | GP spec / Sabt 2016 | Weak KDF | SCP02 session keys | LOW (spec-mandated weakness) | MEDIUM |
| 6 | OTA counter replay | ETSI TS 102 225 | Replay | OTA layer | MEDIUM (counter logic) | HIGH |
| 7 | JC type confusion | CARDIS 2008-2016 | Type confusion | JCVM | NONE (no JVM) | LOW (analogous TLV tests) |
| 8 | EMV PIN bypass | Basin S&P 2021 | Protocol flaw | EMV applet (future) | N/A now | MEDIUM (future) |
| 9 | SIMjacker OTA | CVE-2019-16256 | Unauth code exec | STK/ENVELOPE | ALREADY TESTED | DONE |
| 10 | COMP128 Kc zeros | Briceno 1998 | Algorithmic weakness | COMP128 | PARTIALLY TESTED | DONE |
| 11 | Milenage SQN replay | 3GPP TS 33.102 | Replay | USIM auth | ALREADY TESTED | DONE |
| 12 | TLV boundary | SSTIC 2016 | Overflow | APDU parser | PARTIALLY TESTED | HIGH |

---

## Search Methodology

- Searches performed: 14 web searches + 5 page fetches
- Most productive search terms: "SCP02 padding oracle Avoine", "JavaCard type confusion firewall bypass CARDIS", "EMV PIN bypass Basin Sasse", "SIMjacker CVE-2019-16256", "GlobalPlatform INITIALIZE UPDATE 6A88 oracle"
- Primary information sources: IACR ePrint, Springer CARDIS proceedings, USENIX Security, IEEE S&P, HAL open archive, security-explorations.com, GlobalPlatform specification documents
- Research depth: Deep (14 tool calls, 3 architecture file reads, full bibliography)
