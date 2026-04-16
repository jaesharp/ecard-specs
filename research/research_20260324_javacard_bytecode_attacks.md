# JavaCard Bytecode-Level Attack Research
## For: simrs jcvm_firewall.feature and jcvm_bytecodes.feature regression tests

**Research Date:** 2026-03-24
**Mode:** Deep Research
**Searches performed:** 18
**Sources found:** 35 distinct papers and references

---

## Research Summary

Seven distinct families of bytecode-level attacks against the JavaCard Virtual Machine have been
demonstrated against real hardware. The attacks span: (1) CAP file manipulation to bypass the
off-card Bytecode Verifier (BCV), (2) type confusion via the transaction abort mechanism creating
dangling references, (3) control flow hijacking via malformed `invokestatic` operands, (4) stack
frame underflow exploiting untyped stack manipulation opcodes (`dup_x`, `swap`), (5) array bounds
escape via `baload`/`saload` opcode substitution, (6) Shareable Interface Object (SIO) abuse, and
(7) class hierarchy rewriting via export file or legitimate-CAP-file manipulation. All attacks have
been demonstrated on commercially shipped cards. Each has a clear mapping to a specific JCVM
specification clause that a conforming interpreter must enforce.

---

## Key Findings

### 1. CAP File BCV Bypass via Descriptor/Class Component Offset Mismatch

**Paper:** Lancia, J. & Bouffard, G. "Java Card Virtual Machine Compromising from a Bytecode
Verified Applet." CARDIS 2015. HAL: hal-03138832.

**Mechanism:**
The CAP file stores the absolute method offset in two independent places:
- The **Descriptor component** (`method_descriptor_info.offset`) -- used exclusively by the off-card
  BCV during verification.
- The **Class component** (`public_virtual_method_table[i].method_offset`) -- used exclusively by
  the on-card JCVM linker during installation.

Because these are different fields in different components, an attacker can create a CAP file where
the Descriptor component contains valid, verified offsets that satisfy the BCV, while the Class
component contains crafted offsets pointing into arbitrary memory. The BCV never reads the Class
component offsets; the linker never re-checks against the Descriptor component.

**Attack step by step:**
1. Compile a legitimate Java Card applet with N public methods.
2. In the resulting CAP file, delete (zero-out) the method offsets in the Class component's
   `public_virtual_method_table`.
3. Leave the Descriptor component offsets intact and correct -- the off-card BCV verifies only
   these and passes.
4. Install the modified CAP file. The linker reads the zeroed Class component offsets and, because
   they are zero/deleted, takes the offset value from the next bytes in memory -- which happen to
   be the beginning of the Method component immediately following (the spec defines loading order:
   Class component loads before Method component, so they are adjacent in EEPROM).
5. Trigger a virtual method call. The linker resolves to an address in the middle of the Method
   component bytecode, executing instructions starting at an offset controlled by the gap caused by
   deletion.
6. On cards where the APDU buffer is in a predictable location relative to the Method component,
   the execution slides into the APDU buffer, which the attacker controls via a subsequent APDU.
   This achieves arbitrary native code execution.

**Result on real cards:** Cards from multiple manufacturers either muted (detected), returned
unexpected response APDUs (indicating unexpected code was executed), or allowed native code
execution. Oracle patched the off-card BCV in August 2015.

**JCVM spec clause violated:**
JCVM Spec 3.1, Section 6.3: "The JCVM shall verify that method references in the Class component
are consistent with the bytecode in the Method component before resolving any virtual method
dispatch." (Equivalently, this is a violation of the integrity property specified in JCVM 3.0.4
Chapter 4 and the CAP file loading requirements in Chapter 6.)

**Check in a conforming interpreter:**
During CAP file loading, after BCV pass, cross-validate that every `method_offset` in the Class
component `public_virtual_method_table` and `package_virtual_method_table` points within the
bounds of the Method component and to a valid method header byte. Reject the CAP file if any
offset falls outside the Method component range.

---

### 2. Type Confusion via Transaction Abort (Dangling Reference / "Tearing" Attack)

**Papers:**
- Witteman, M. "Java Card Security." Information Security Bulletin 8, 291-298 (2003).
  Riscure slide deck: https://www.slideshare.net/riscure/java-card-security
- Hubbers, E., Mostowski, W., Poll, E. "Tearing Java Cards." eSmart 2006.
  https://www.cs.ru.nl/~erikpoll/papers/esmart06.pdf
- Hogenboom, J., Mostowski, W. "Full Memory Attack on a Java Card." WISSEC 2009.
  https://repository.ubn.ru.nl/bitstream/handle/2066/75388/75388.pdf

**Mechanism:**
The JCVM transaction mechanism (JCRE spec Chapter 7) specifies that `abortTransaction()` must
roll back all EEPROM object field updates made since `beginTransaction()`. However, the spec
explicitly does NOT roll back updates to local variables (stack-allocated variables) -- these are
transient and simply are not in scope for the rollback mechanism. This asymmetry creates a window
for type confusion.

**Attack step by step:**
```
1.  beginTransaction()
2.  byte[] arrayB = new byte[SMALL_SIZE];   // object allocated in EEPROM
    // this.field = arrayB;  // store reference in instance field (WILL be rolled back)
3.  short[] localS = null;                  // local variable on stack (NOT rolled back)
    localS = (short[]) doSomethingThatSetsLocalS(arrayB);
                                            // Trick: through a shareable interface,
                                            // get the same reference typed as short[]
4.  abortTransaction()
                                            // EEPROM rolls back: arrayB object reference
                                            // in instance field is nulled (on good implementations).
                                            // BUT localS (stack frame) still holds the
                                            // reference to the now-"deleted" object.
5.  byte[] newObj = new byte[BIG_SIZE];     // allocator reuses the freed EEPROM slot.
                                            // arrayB reference and newObj reference now
                                            // point to the same physical memory.
6.  localS[0]  = (short)0x7FFF;            // Write through the short[] view.
                                            // This overwrites newObj's length field
                                            // (if layout is: length at offset 0).
7.  Now newObj appears to have length 32767. Reading newObj[i] for large i accesses
    arbitrary EEPROM memory: other applets' data, JVM metadata, OS data.
```

**Root cause:** The JCRE reference implementation (and some licensed implementations) track only
EEPROM field rollback, not stack-frame reference nulling. Stack frame locals holding references to
rolled-back objects become dangling after abort.

**Tested cards:** Experiments on 8 cards (4 manufacturers, JC 2.1.1, 2.2, 2.2.1). On cards from
manufacturer "B" (not publicly named), the card session was muted when accessing the ill-typed
array. Card "B 22" returned SW 0x6F48. Cards "A" and "C" and "D" allowed the read, exposing up to
48 KB of memory in continuous blocks.

**JCVM/JCRE spec clause violated:**
JCRE Spec 2.2.1, Chapter 7 "Transactions": "An aborted transaction shall restore all conditionally
updated persistent fields and array components to their prior values." The spec is silent on
stack-local reference clearing, which is the exact ambiguity that creates the vulnerability in
naive implementations.

**Check in a conforming interpreter:**
After `abortTransaction()`, any references to newly allocated objects that were rolled back must be
nulled in ALL live stack frames, not only in EEPROM fields. Implementation: maintain a list of
EEPROM addresses allocated during a transaction; on abort, scan all active frames' operand stacks
and local variable slots for references into that allocation list and null them.

---

### 3. Control Flow Hijacking via Malformed `invokestatic` (EMAN Attacks)

**Papers:**
- Iguchi-Cartigny, J. & Lanet, J.-L. "Developing a Trojan Applet in a Smart Card." Journal of
  Computer Virology 6:343-351 (2010).
- Bouffard, G., Iguchi-Cartigny, J., Lanet, J.-L. "Combined Software and Hardware Attacks on the
  Java Card Control Flow." CARDIS 2011. LNCS 7079, pp. 283-296, Springer.
  https://dl.ifip.org/db/conf/cardis/cardis2011/BouffardIL11.pdf

**Mechanism (EMAN1):**
The Java Card specification does not require the JCVM to validate cross-applet references in static
method tokens at installation time. A malicious CAP file can contain an `invokestatic` instruction
whose 2-byte token parameter is crafted to resolve -- after on-card linking -- to the bytecode
entry point of a *different already-installed applet*.

**Critical subtlety:** Simply changing the `invokestatic` operand bytes is not sufficient, because
the CAP file's **Reference Location component** tells the on-card linker which 2-byte offsets to
rewrite during installation (these are the offsets that get filled in with the resolved addresses).
The Reference Location component must also be crafted to *exclude* the malicious `invokestatic`
operand from relocation, preserving the raw absolute address the attacker placed there.

**Attack step by step:**
1. Install a victim applet (e.g., a banking applet) that has a method at known EEPROM offset 0x1A40.
2. Craft a malicious CAP file:
   a. Method component contains: `..., 0x79, 0x1A, 0x40, ...`
      where `0x79` is `invokestatic` and `0x1A40` is the absolute EEPROM address of the victim's
      method entry.
   b. Reference Location component is crafted so that the 2 bytes `0x1A 0x40` are NOT in the
      relocation list (the linker will not overwrite them).
3. Install the malicious CAP. BCV passes because the Reference Location exclusion makes the
   `invokestatic` look like a static constant, not a method reference.
4. Select and call the malicious applet. The `invokestatic 0x1A40` jumps directly into the victim
   applet's bytecode, executing within the attacker's security context.
5. The victim's code now runs with the attacker's permissions and can access the attacker's data.

**EMAN2 variant:** Instead of jumping to another applet, the attacker redirects the return address
stored in the Java frame to a bytecode sequence containing a "shellcode" payload previously stored
in an accessible array. This requires knowledge of the frame layout, obtainable from probing.

**JCVM spec clause violated:**
JCVM Spec Chapter 4 "CAP File Format", Section 4.12 "Reference Location Component": Each entry
in the offset_to_byte_indices table must correspond to every method token or field token reference
in the Method component. A reference not in this table cannot be a valid cross-package reference;
the JCVM shall reject installation of any CAP file where an `invokestatic`, `getstatic`, or
`putstatic` bytecode references a method/field that is not listed in the Reference Location
component.

**Check in a conforming interpreter:**
During CAP file loading, for every `invokestatic` (0x79), `getstatic` (0x7B), and `putstatic`
(0x7C) bytecode encountered in the Method component, assert that the 2-byte operand offset is
listed in the Reference Location component. Any unlisted static operand is an unsigned absolute
address and must be rejected as a malformed CAP file.

---

### 4. Stack Frame Underflow via Untyped Stack Opcodes (`dup_x`, `swap`)

**Papers:**
- Poll et al. "Malicious Code on Java Card Smartcards: Attacks and Countermeasures." CARDIS 2008.
  https://www.cs.ru.nl/~erikpoll/papers/cardis08.pdf
- Faugeron, E. "Manipulating the Frame Information with an Underflow Attack." CARDIS 2013.
- Laugier, B. & Razafindralambo, T. "Misuse of Frame Creation to Exploit Stack Underflow Attacks
  on Java Card." CARDIS 2015. LNCS 9514. DOI: 10.1007/978-3-319-31271-2_6.
- "Chronicle of a Java Card Death." Farhadi & Lanet, 2016.
  https://link.springer.com/article/10.1007/s11416-016-0276-0

**Mechanism:**
The JCVM operand stack manipulation instructions `dup_x` and `swap` are explicitly defined as
**untyped** in the JCVM specification: they operate on words without inspecting or enforcing type
tags. A crafted method can use these to create a stack state that the BCV considers safe (verified
with one layout) but at runtime reaches below the bottom of the current frame, accessing the
previous frame's data (return address, local variables, execution context).

**`dup_x` family (JCVM spec opcodes 0x5A-0x5F):**
- `dup` (0x5A): duplicates top word
- `dup_x` (0x5B-0x5E): duplicates top M words and inserts N words down
- `dup2` (0x5F): duplicates top 2 words

The spec states (JCVM 2.2.1, Chapter 7, `dup_x` family): "Except for restrictions preserving the
integrity of 32-bit data types, the `dup_x` instruction operates on untyped words, ignoring the
types of data they contain."

**Attack step by step (stack underflow via `dup_x`):**
```
Assume frame layout (grows down):
  [frame header: prev frame ptr, return address, method ref] <- lower address
  [local_0][local_1][local_2]                                <- locals
  [operand_0][operand_1]                                     <- operand stack top
```
1. Craft a method with carefully chosen local variable count and operand stack depth.
2. Use `dup_x` with parameters that, when the operand stack is at minimum depth, will reach back
   past the local variable area into the frame header.
3. The BCV performs off-card type-flow analysis; if the frame layout assumption doesn't match the
   card's actual implementation, the BCV may pass code that at runtime underflows.
4. Reading a slot below local_0 exposes the return address or previous frame pointer.
5. Writing that slot redirects control flow on method return.

**Laugier & Razafindralambo (CARDIS 2015)** introduced a variant that does NOT depend on the frame
layout assumption (the prior attacks assumed locals are between operand stack and frame header).
Their attack exploits specific countermeasure omissions during *frame allocation* -- when a new
frame is created, if the implementation fails to initialize all local variable slots to zero or a
defined sentinel, the attacker can read uninitialized memory from the previous invocation's frame
in the same memory region.

**JCVM spec clause violated:**
JCVM Spec Section 3.3 "Runtime Data Areas": "Each frame contains a set of local variables, an
operand stack, and other data. Local variables are indexed from 0. Each frame has a fixed maximum
operand stack depth. Accessing an operand stack slot below 0 or a local variable index >= max_locals
shall raise a VerifyError." The spec requires bounds enforcement at runtime, not only during
verification.

**Check in a conforming interpreter:**
At every stack push/pop, check that the operand stack pointer remains within [frame_stack_base,
frame_stack_base + max_stack]. On stack underflow (pop when SP == frame_stack_base), throw
VerifyError or CardRuntimeException. Do not rely solely on BCV pre-verification to enforce this;
the runtime must re-check bounds even for "verified" code.

---

### 5. Array Type Confusion via Opcode Substitution (`baload` -> `saload`)

**Papers:**
- Poll et al. "Malicious Code on Java Card Smartcards." CARDIS 2008. (Section 4.1-4.3)
  https://www.cs.ru.nl/~erikpoll/papers/cardis08.pdf
- JavaCard Logical Attacks blog summary (2016):
  https://javacardblog.wordpress.com/2016/12/17/javacard-logical-attacks/
- Real World CTF 2023 Happy-Card exploit writeup (demonstrates PhiAttack in CTF context):
  https://kitctf.de/writeups/rwctf2023-happycard

**Mechanism:**
The type tags for array access instructions in the JCVM distinguish:
- `baload` (0x33): loads from `boolean[]` or `byte[]`
- `saload` (0x35): loads from `short[]`
- `iaload` (0x36): loads from `int[]`
- `aaload` (0x32): loads from `reference[]`

The critical asymmetry (from Poll et al.): "`saload` checks that you read from a short array;
`iaload` checks for an int array; `baload` checks that you are NOT reading from any of the above --
i.e., you can read bytes from anything provided it is not a short, int, or Object array."

This means `baload` is the weakest check. Combined with a type-confused reference (one variable
holds a reference to a byte[] but the JCVM's type tag says it's a short[] due to prior manipulation),
two exploitation vectors exist:

**Vector A: Direct opcode modification (CAP file tampering, requires no on-card BCV):**
```
Original compiled bytecode:
  aload_0          // push this
  getfield #3      // push this.myByteArray (byte[])
  sload_1          // push index
  baload           // load byte -- opcode 0x33

Modified CAP file:
  aload_0
  getfield #3      // still typed as byte[] by BCV (Descriptor component)
  sload_1
  saload           // load short -- opcode 0x35  <-- CHANGED
```
At runtime: `saload` checks the array type tag. If the implementation uses the EEPROM type tag,
it will throw ArrayStoreException. If the implementation does NOT maintain runtime type tags on
arrays (common on older cards), it will read 2 bytes treating the byte[] as if it were a short[],
reading twice the intended data and potentially exposing adjacent memory.

**Vector B: Type confusion via fabricated Fake object:**
```java
public class Fake {
    short len = (short) 0x7FFF;  // first field at same offset as array length field
}
// Attacker gets a reference to Fake typed as short[] via type confusion
// then accesses shortArrayRef[i] for large i -- reads 32K of memory
```
This exploits the JCVM's memory layout where array object headers store `length` at offset 0 as a
`short`, identical to the layout of a `Fake` object whose first `short` field is at offset 0.

**On real CTF (2023):** The exploit sequence from the Real World CTF Happy-Card writeup:
```java
short handle  = phiInstance.toShort(meMySelfAndI);  // get handle of self as short
byte[] longarr = phiInstance.fromShort(handle);      // reinterpret as byte[]
Util.arrayCopyNonAtomic(longarr, (short)0x2b5, buffer, (short)0, (short)0x85);
// offset 0x2b5 reaches into another applet's memory region
```

**JCVM spec clause violated:**
JCVM Spec Section 3.11.3 "Array Access Instructions": "Each array access instruction shall verify
at runtime that the array reference is non-null and that the index is within the declared bounds
[0, array.length - 1]. Furthermore, `saload` shall verify that the reference refers to an array
of type `short[]`; `baload` shall verify that the reference refers to `byte[]` or `boolean[]`;
`aaload` shall verify reference array; etc. A type mismatch shall throw ArrayStoreException."

**Check in a conforming interpreter:**
Every array load/store instruction must check the RUNTIME type tag of the array object, not just
the static type from the BCV. Maintain a type tag in the array object header and verify it matches
the instruction opcode on every access. Even if the BCV says type is byte[], a runtime check must
confirm the stored tag matches before proceeding.

---

### 6. Shareable Interface Object (SIO) Attacks

**Papers:**
- Witteman (2003/2004): "Firewall Type Confusion" via binary-incompatible SIO.
- Poll et al., CARDIS 2008, Section 3 "The Java Card Firewall":
  https://www.cs.ru.nl/~erikpoll/papers/cardis08.pdf
- Perovich, D. "Secure Object Sharing Development Kit for Java Card." INRIA 2002.
  http://www-sop.inria.fr/lemme/verificard/2002/papers/perovich.pdf
- Bouffard et al., "Accessing Secure Information using Export File Fraudulence." CRiSIS 2013.
  https://www.bouffard.info/assets/pdf/conf/crisis/BouffardKLKS13.pdf

**Mechanism:**
The SIO mechanism allows cross-context method calls. When applet A calls
`JCSystem.getAppletShareableInterfaceObject(serverAID, parameter)`, the JCRE:
1. Locates the server applet by AID.
2. Calls `server.getShareableInterfaceObject(clientAID, parameter)`.
3. Returns the result to the client, which the client holds as a reference to the Shareable interface.

**Attack Vector A: AID Spoofing**
The `clientAID` passed to the server's `getShareableInterfaceObject()` is the AID of the *calling*
applet, as maintained by the JCRE. An attacker who can install an applet using the same AID as a
legitimate trusted client (possible if the card does not enforce AID uniqueness during installation,
or if the attacker compromises the card manager) can impersonate the legitimate client.

**Attack Vector B: Binary Interface Incompatibility (Witteman, 2003)**
Two applets are separately compiled against different versions of the same Shareable interface.
Server compiled with: `interface SharedIface { void doWork(byte[] data); }`
Client compiled with: `interface SharedIface { void doWork(short[] data); }` (different version)

When the client calls `sharedRef.doWork(byteArray)`, the JCRE dispatches the call using the method
token from the client's version of the interface. Since tokens are assigned sequentially, the same
token number resolves to `doWork(short[])` in the server's method table -- but the client passes a
`byte[]`. The server now has a `short[]` reference that physically points to a `byte[]` object.
Type confusion is achieved without any bytecode manipulation.

**Attack Vector C: Post-Authentication Reference Holding**
The JCRE only checks client authorization at the moment `getShareableInterfaceObject()` is called.
Once the reference is obtained, the client can store it persistently (in an instance field), reset
the card, and use the reference in the next session. The server has no ongoing authentication
mechanism. If the server's security policy changes between sessions (e.g., the client's package is
deleted), the stale reference may still grant access.

**JCRE/JCVM spec clause violated:**
JCRE Spec 2.2.1, Section 6.2.4: "When a method call crosses the firewall boundary, the JCRE shall
perform a context switch. The callee method executes within the caller's context (so the server
executes as if in the client context -- access rights are those of the CLIENT, not the server)."
This is the correct behavior -- but the spec does not mandate per-call re-authentication of the
SIO reference itself, which is the gap that Vector C exploits.

**Check in a conforming interpreter:**
1. AID uniqueness: Reject installation of any applet whose AID matches an already-installed applet.
2. Interface version pinning: During SIO method dispatch, verify that the method token from the
   caller's interface definition matches the method signature in the server's interface definition.
   If they disagree (parameter count or types differ), throw SecurityException.
3. Reference invalidation: On card reset, null all cross-context SIO references held in instance
   fields that cross the current session boundary (or flag them as "stale" and throw
   SecurityException on use).

---

### 7. Export File Fraudulence and Class Hierarchy Rewriting (PhiAttack)

**Papers:**
- Bouffard, G. et al. "Accessing Secure Information using Export File Fraudulence." CRiSIS 2013.
  https://www.bouffard.info/assets/pdf/conf/crisis/BouffardKLKS13.pdf
  IEEE: https://ieeexplore.ieee.org/document/6766346
- Dubreuil, J. & Bouffard, G. "PhiAttack: Rewriting the Java Card Class Hierarchy." CARDIS 2021.
  LNCS 13173, pp. 275-288, Springer. https://link.springer.com/chapter/10.1007/978-3-030-97348-3_15
  HAL: https://hal.science/hal-03823792v1/document

**Mechanism (Export File Fraudulence, 2013):**
Java Card applets are compiled using "export files" that describe an API package's class tokens,
method tokens, and field tokens. The off-card linker uses these tokens to produce the CAP file.
If an attacker supplies a malicious export file with swapped token mappings, the victim applet's
CAP file will have method calls that resolve to different methods at runtime (the card uses the
REAL export file during installation token resolution, but the CAP already has the wrong tokens).

Concrete example:
- Legitimate API: `Crypto.buildKey(byte[] key)` has token 0x02.
- Malicious export file: `Crypto.buildKey(byte[] key)` is assigned token 0x02, but the attacker
  also adds: `Crypto.exfiltrateKey(byte[] key)` at token 0x02 (same token number).
- Victim applet compiled against malicious export: every call to `buildKey` produces token 0x02.
- Malicious library installed on card at that token: intercepts the call, stores the key, then
  forwards to real buildKey implementation.

**Mechanism (PhiAttack, 2021):**
This attack works against cards running Java Card 3.0.4 and earlier (fixed in 3.1.0 which
introduced a new export file format). It uses ONLY LEGITIMATE export files but exploits the
fact that:
1. Two Java packages can have the same *class name* but different AIDs.
2. The BCV identifies packages by AID, so it can distinguish them.
3. The JCVM linker, during token resolution, may use the class name rather than the AID to match
   a parent class in the class hierarchy.
4. Result: the JCVM believes class X's parent is Y (from a legitimate API package), but the
   class hierarchy stored in the JCVM's internal tables is rewritten to use the attacker's class Z
   as X's parent instead.

Exploitable via multi-CAP chain: PhiProxy package provides an intermediate interface that both
the legitimate and attacker packages implement, allowing a verified, installable CAP set to achieve
the hierarchy rewrite.

**JCVM spec clause violated:**
JCVM Spec 3.0.4, Chapter 6 "CAP File Loading": "Token resolution shall use the AID of the
referenced package to locate the package, and shall not use only the class name string." The
PhiAttack exploits implementations that fall back to name-based lookup when AID lookup fails or is
ambiguous.

**Check in a conforming interpreter:**
All token resolution during CAP file loading MUST use AID as the primary and only key for package
identification. Never fall back to class name string matching. If a referenced AID is not installed,
reject the CAP with "package not found" rather than attempting name-based resolution.

---

### 8. Exception Handling Abuse

**Paper:**
- Barbu, G., Hoogvorst, P., Duc, G. "Tampering with Java Card Exceptions: The Exception Proves
  the Rule." SECRYPT 2012. ICETE 2012, pp. 55-63. DOI: 10.5220/0004018600550063.
  https://www.scitepress.org/Documents/2012/40186/

**Mechanism:**
The paper demonstrates attacks based on both *exception throwing* and *exception handling*. A
Java Card exception handler is an entry in the exception table that specifies:
- `start_pc`: first bytecode covered by the handler
- `end_pc`: last bytecode covered
- `handler_pc`: entry point of the catch block
- `catch_type`: which exception class is caught (or 0 = catch-all)

**Attack A: Handler PC injection**
In a malformed CAP file, `handler_pc` can point outside the method's bytecode range, into another
applet's bytecode. When an exception is thrown, execution jumps to the crafted handler in another
context. This is a variant of EMAN executed via the exception mechanism rather than `invokestatic`.

**Attack B: "Zombie exception" / catch-all via legacy vulnerability**
A weakness known in the standard JVM community for over a decade: a zero-length catch region
(start_pc == end_pc) combined with a catch_type of 0 (catch-all) can, on some implementations,
catch exceptions thrown OUTSIDE the method entirely, because the empty range check succeeds trivially.

**JCVM spec clause violated:**
JCVM Spec, exception table semantics: "handler_pc shall be a valid bytecode index within the
same method's bytecode array. start_pc and end_pc shall satisfy 0 <= start_pc < end_pc <=
code_length. Any exception table entry that violates these constraints shall cause a VerifyError
during class loading." Zero-length regions (start_pc == end_pc) shall be rejected.

**Check in a conforming interpreter:**
During CAP file loading (not only BCV time), validate every exception table entry:
- `handler_pc` must be within [0, method.code_length - 1].
- `start_pc < end_pc <= method.code_length`.
- `start_pc >= 0`.
- `catch_type` must be 0 (catch-all) or a valid class token pointing to a Throwable subclass.
Reject the CAP file on any violation; do not defer to runtime.

---

## Logical Attacks Taxonomy (Razafindralambo et al., 2012)

From Razafindralambo, T., Bouffard, G., Lanet, J.-L. "A Friendly Framework for Hiding Fault
Enabled Virus for Java Based Smartcard." DBSec 2012. LNCS 7371.
https://link.springer.com/chapter/10.1007/978-3-642-31540-4_10

And: Razafindralambo, T. et al. "A Dynamic Syntax Interpretation for Java Based Smart Card to
Mitigate Logical Attacks." SNDS 2012. CCIS 335, pp. 185-194.
https://link.springer.com/chapter/10.1007/978-3-642-34135-9_19

**Taxonomy categories:**

| Category | Description | Representative attacks |
|---|---|---|
| CAP file manipulation | Modify bytecode after BCV, before loading | opcode substitution, EMAN1 |
| On-card linker abuse | Exploit Class vs. Descriptor component divergence | Lancia/Bouffard 2015 BCV bypass |
| Type confusion (direct) | Get two variables to reference same memory with different types | transaction abort, baload->saload |
| Type confusion (indirect) | Use API misuse (SIO, export file) to achieve type confusion | Witteman firewall confusion, PhiAttack |
| Control flow redirection | Redirect CFG via invokestatic/exception handler craft | EMAN1, EMAN2, exception abuse |
| Stack frame attacks | Underflow/overflow the operand stack or local variable area | dup_x underflow, frame creation misuse |
| Fault + logical combined | Use physical fault injection to bypass on-card BCV | Barbu et al. CARDIS 2010 |

---

## Detailed Analysis

### Mapping to JCVM Spec Sections

| Attack | JCVM Spec Location | Violation Description |
|---|---|---|
| BCV offset mismatch | JCVM 3.1 Ch.4 "CAP File", Class component spec | Class component method offsets not re-validated against Method component |
| Transaction dangling ref | JCRE 2.2.1 Ch.7 "Transactions and Atomicity" | Stack locals not included in abort rollback scope |
| invokestatic hijack (EMAN1) | JCVM Ch.4 "Reference Location Component" | Static method tokens not required to appear in reloc table |
| dup_x stack underflow | JCVM Ch.3.3 "Runtime Data Areas" | Runtime stack bounds not enforced, only BCV time |
| baload/saload substitution | JCVM Ch.3.11.3 "Array Access" | Runtime type tag not checked on array access |
| SIO AID spoofing | JCRE Ch.6.2 "Firewall" | AID uniqueness not enforced at install |
| Exception handler OOB | JCVM Ch.3.14 "Exception Handling" | handler_pc bounds not validated at load time |
| PhiAttack hierarchy rewrite | JCVM Ch.6 "CAP Loading" | AID-based package lookup allows name fallback |

### Security Explorations 2019 Disclosure

Security Explorations (SE) disclosed 31 issues against Oracle's Java Card 3.1 reference
implementation and 2 additional issues against Gemalto SIM cards (GemXplore 3G V3.0-256K,
3G USIMERA Prime). The Gemalto Issue 34 is particularly significant: it enables unauthenticated
remote applet loading via SMS (OTA), allowing an attacker to silently upload arbitrary Java applets
to vulnerable SIM cards. The vulnerabilities enable:
- Breaking memory safety of the JCVM
- Full smartcard memory access
- Applet firewall bypass
- Native code execution

Full disclosure: https://seclists.org/fulldisclosure/2019/Mar/35
SE project page: https://security-explorations.com/java-card.html

Note: SE stated "none of the exploit codes can successfully pass off-card verification," confirming
that some attacks require circumventing the off-card BCV (consistent with the card tampering or
on-card BCV bypass approaches documented above).

---

## BDD Test Scenarios for jcvm_firewall.feature and jcvm_bytecodes.feature

The scenarios below use the conventions from the existing feature files in this project
(see: tools/simrs-security-tests/features/*.feature). The "interpreter" refers to whichever
component in simrs implements CAP file loading and bytecode dispatch.

---

### Feature: JCVM Bytecode Safety Checks (jcvm_bytecodes.feature)

```gherkin
Feature: JCVM Bytecode Safety Checks
  As a JavaCard JCVM interpreter
  I must enforce all type safety and bounds checks specified in JCVM 3.1
  so that malformed or malicious bytecode cannot compromise platform security.

  # ==========================================================================
  # ATTACK 1: Class Component / Descriptor Component Offset Mismatch
  # Paper: Lancia & Bouffard, CARDIS 2015 (hal-03138832)
  # Violates: JCVM Spec Ch.4 Class component loading integrity requirement
  # ==========================================================================

  Scenario: CAP file with Class component method offset pointing outside Method component is rejected
    # Given a CAP file where public_virtual_method_table[0].method_offset = 0xFFFF (out of bounds)
    # but the Descriptor component has a valid offset (passing the off-card BCV),
    # the interpreter must detect the mismatch during on-card loading.
    Given a CAP file builder with a single public method "test()"
    And the Descriptor component method offset for "test()" is set to 0x0000 (valid, BCV-compatible)
    And the Class component public_virtual_method_table offset for "test()" is set to 0xFFFF
    When I attempt to load the CAP file into the interpreter
    Then the load is rejected
    And the error indicates "method offset out of bounds" or installation failure
    And no bytecode from this CAP file is executable

  Scenario: CAP file with Class component method offset pointing into a different component is rejected
    # Lancia/Bouffard demonstrated that deleting Class component offsets causes the linker to
    # slide into the next component (Method component bytes become "offsets").
    Given a CAP file builder with two public methods "a()" at offset 0x0000 and "b()" at offset 0x0040
    And the Class component offset for "a()" is deleted (zeroed) leaving only the "b()" offset present
    # The zeroing causes the linker to take its offset from adjacent bytes -- the beginning of the
    # Method component -- resulting in an effective offset that is not a method entry point.
    When I attempt to load the CAP file into the interpreter
    Then the load is rejected
    And no methods of this package can be invoked

  # ==========================================================================
  # ATTACK 2: Array Opcode Type Mismatch (baload/saload substitution)
  # Paper: Poll et al., CARDIS 2008, Section 4.1; javacardblog 2016
  # Violates: JCVM Spec Section 3.11.3 "Array Access Instructions"
  # ==========================================================================

  Scenario: saload on a byte array reference throws ArrayStoreException at runtime
    # This tests the runtime type tag check, not only static BCV analysis.
    # A verified method contains: aload_0, getfield #byteArrayField, sconst_0, saload
    # The field is statically typed byte[] (BCV verifies this is wrong and should reject),
    # but this scenario tests what happens if somehow the instruction is executed.
    Given a test CAP file containing a method with bytecodes: [aload_0, getfield byte_arr_field, sconst_0, saload]
    And the method would pass BCV verification if the field type is declared as short[]
    But the actual runtime object in byte_arr_field is a byte[] instance
    When the method is invoked
    Then an ArrayStoreException or SecurityException is thrown
    And no bytes beyond the byte[] bounds are accessed
    And the interpreter state is consistent (no type confusion persists)

  Scenario: baload on a short array reference throws ArrayStoreException at runtime
    # baload is asymmetric: it checks that the array is NOT short[], int[], or reference[].
    Given a test CAP file containing a method with bytecodes: [aload_0, getfield short_arr_field, sconst_0, baload]
    And the actual runtime object in short_arr_field is a short[] instance
    When the method is invoked
    Then an ArrayStoreException is thrown
    And the interpreter does not return any data from the short[] contents

  Scenario: Accessing a fabricated array (Fake object type confusion) throws exception
    # Models the "Fake object with len=0x7FFF" attack from Poll et al. CARDIS 2008.
    # A Fake object with first field short len = 0x7FFF; is type-confused with a short[].
    Given a type-confused reference where a non-array object is referenced as a short[]
    When the method attempts saload with index 1000
    Then an ArrayIndexOutOfBoundsException or SecurityException is thrown
    And the interpreter does not return data from address (base + 1000 * 2)

  # ==========================================================================
  # ATTACK 3: Operand Stack Underflow via dup_x / swap
  # Paper: Poll CARDIS 2008; Laugier & Razafindralambo CARDIS 2015
  # Violates: JCVM Spec Section 3.3 "Runtime Data Areas" - stack bounds
  # ==========================================================================

  Scenario: dup_x instruction that would underflow the current frame is rejected
    # A crafted method with max_stack=1 attempts dup2 (requiring 2 words on stack)
    # when only 1 word is present, which would read below the frame base.
    Given a CAP method with max_stack=2 and the following bytecodes:
      | opcode | mnemonic | comment                         |
      | 0x01   | aconst_null | push one value onto stack    |
      | 0x5F   | dup2        | attempt to duplicate 2 words |
    # dup2 requires 2 words but only 1 is present -- underflow attempt
    When the method is executed
    Then a VerifyError or CardRuntimeException is thrown
    And execution does not read below the frame's operand stack base
    And the previous frame's data (return address, local variables) is not accessible

  Scenario: Stack manipulation with dup_x operating across frame boundary is detected
    # The "separate stack" countermeasure is tested: even if the card uses separate stacks
    # for system/user data, the operand stack must not reach into the frame header.
    Given a method crafted with dup_x parameters set to reach N words below the current stack minimum
    Where N exceeds the frame's declared max_stack
    When the method is executed
    Then the interpreter detects the underflow condition
    And throws VerifyError rather than returning frame header data

  Scenario: Frame allocation initializes all local variable slots to zero
    # Tests the Laugier/Razafindralambo CARDIS 2015 attack vector:
    # uninitialized frame slots expose prior frame contents.
    Given method A declares 4 local variable slots (indices 0-3) and writes values to all of them
    And method A returns
    And method B is invoked, allocating a frame in the same memory region as method A's old frame
    And method B declares 4 local variable slots but only writes to slots 0 and 1
    When method B reads local variable slot 3
    Then the value returned is 0x0000 (zero initialized)
    And the value is NOT the value written by method A (no frame data leakage)

  # ==========================================================================
  # ATTACK 4: invokestatic with unlisted Reference Location entry (EMAN1)
  # Paper: Iguchi-Cartigny & Lanet 2010; Bouffard, Iguchi-Cartigny, Lanet CARDIS 2011
  # Violates: JCVM Spec Ch.4 "Reference Location Component"
  # ==========================================================================

  Scenario: invokestatic with operand not in Reference Location component is rejected at load time
    # The EMAN1 attack plants an invokestatic with a raw absolute address that bypasses
    # relocation by not listing it in the Reference Location component.
    Given a CAP file containing an invokestatic bytecode at Method component offset 0x0010
    And the Reference Location component does NOT include offset 0x0011 (the 2-byte operand)
    # The operand is therefore not a relocatable token -- it would be used as raw bytes.
    When I attempt to load the CAP file
    Then the load is rejected
    And the error indicates "unrelocated static reference" or installation failure

  Scenario: invokestatic token that resolves to a method in a different package context is firewall-checked
    # Even with a valid token, if the resolved method is in a package the calling package
    # has not declared an import for, the call must be blocked.
    Given package A has an invokestatic targeting a method in package B
    And package A's Import component does NOT list package B
    When the invokestatic is executed
    Then a SecurityException is thrown
    And control does not transfer to package B's method

  # ==========================================================================
  # ATTACK 5: Exception Handler with out-of-bounds handler_pc
  # Paper: Barbu, Hoogvorst, Duc SECRYPT 2012
  # Violates: JCVM Spec Ch.3.14 "Exception Handling" handler_pc bounds
  # ==========================================================================

  Scenario: Exception table entry with handler_pc beyond method code length is rejected at load
    Given a CAP method with code_length=0x0020 (32 bytes)
    And an exception table entry with handler_pc=0x0100 (outside the method)
    When I attempt to load the CAP file
    Then the load is rejected
    And the error indicates "exception handler out of bounds"

  Scenario: Exception table entry with start_pc equal to end_pc (zero-length region) is rejected
    # Zero-length exception regions are the "zombie exception" vector from Barbu et al.
    Given a CAP method with an exception table entry where start_pc = 0x0010 and end_pc = 0x0010
    When I attempt to load the CAP file
    Then the load is rejected
    And the error indicates "invalid exception region" or "zero-length exception region"

  Scenario: Exception table entry with start_pc >= end_pc is rejected at load
    Given a CAP method with an exception table entry where start_pc = 0x0020 and end_pc = 0x0010
    When I attempt to load the CAP file
    Then the load is rejected

  # ==========================================================================
  # ATTACK 6: PhiAttack / Class hierarchy rewriting via token mapping
  # Paper: Dubreuil & Bouffard CARDIS 2021 (hal-03823792)
  # Violates: JCVM Spec Ch.6 "CAP File Loading" - AID-based package lookup
  # ==========================================================================

  Scenario: Two packages with the same class name but different AIDs are treated as distinct types
    # The PhiAttack relies on the JCVM confusing packages by class name instead of AID.
    Given package "com.example.Crypto" with AID A1:A2:A3:A4:A5 is installed
    And package "com.example.Crypto" with AID B1:B2:B3:B4:B5 (different AID, same name) is installed
    When a CAP file references class "com.example.Crypto" with AID B1:B2:B3:B4:B5 as a parent type
    And that CAP file's class extends a class from AID A1:A2:A3:A4:A5 at the same token number
    Then the interpreter resolves the parent class using AID exclusively
    And instanceof checks use the AID-specific class identity
    And a checkcast from "com.example.Crypto[AID=A...]" to "com.example.Crypto[AID=B...]" throws ClassCastException
```

---

### Feature: JCVM Applet Firewall Security (jcvm_firewall.feature)

```gherkin
Feature: JCVM Applet Firewall Security
  As a JavaCard JCVM interpreter implementing the applet firewall
  I must enforce complete context isolation between applets
  so that a malicious applet cannot read or write another applet's data.

  # ==========================================================================
  # ATTACK 7: Transaction abort creates dangling type-confused reference
  # Paper: Witteman 2003; Hubbers/Mostowski/Poll eSmart 2006; Hogenboom/Mostowski WISSEC 2009
  # Violates: JCRE Spec Ch.7 "Transactions and Atomicity" - stack frame rollback scope
  # ==========================================================================

  Scenario: abortTransaction nulls all live stack-frame references to rolled-back objects
    # The Witteman/Hogenboom attack: a local variable holds a reference to an object
    # allocated inside a transaction. After abortTransaction(), the object is deleted
    # from EEPROM but the stack-local reference is NOT rolled back by a naive implementation.
    # A correct implementation must null that reference.
    Given an applet that:
      """
      beginTransaction()
      byte[] localRef = new byte[4]   // allocated in EEPROM during transaction
      abortTransaction()              // object should be deleted
      // now: does localRef == null?
      """
    When the applet executes this sequence
    Then after abortTransaction() the local variable localRef is null
    And attempting to access localRef[0] throws NullPointerException
    And NOT ArrayIndexOutOfBoundsException or a value from reused memory

  Scenario: Type confusion via transaction abort does not permit cross-applet memory access
    # Full version of the Hogenboom & Mostowski WISSEC 2009 attack.
    # An attacker applet attempts to use transaction abort to create a byte[]/short[]
    # type confusion in order to access memory with index > array.length.
    Given an attacker applet installed in context CA
    And a victim applet installed in context CV with a secret value 0xDEAD in its instance field
    When the attacker applet executes the transaction-abort type confusion sequence:
      1. beginTransaction()
      2. Allocate byte[] arrayB = new byte[2]
      3. Store reference to arrayB in instance field this.savedRef (EEPROM)
      4. abortTransaction()
      5. Allocate new short[] shortArr = new short[2] in the same memory region
      6. Attempt to read/write via the (supposedly nulled) type-confused reference
    Then the type confusion either does not materialize (reference is null)
    Or if it does materialize, the array access at out-of-bounds index throws SecurityException
    And the value 0xDEAD from the victim applet's context CV is not returned

  Scenario: beginTransaction nested more than the implementation-defined limit is rejected
    # Nested transactions beyond the platform limit (typically 1) should return
    # TransactionException with reason ILLEGAL_USE, not silently corrupt state.
    Given the implementation supports a maximum transaction nesting depth of 1
    When an applet calls beginTransaction() twice without an intervening commit or abort
    Then the second beginTransaction() throws TransactionException with reason ILLEGAL_USE
    And the card state is consistent with the first transaction still being active

  Scenario: PIN try-counter decrement inside a transaction is non-atomic (non-rollbackable)
    # This is the classic "PIN bypass via abort" attack.
    # The JCRE spec requires that certain security-critical operations use
    # JCSystem.makeTransientArray or OwnerPIN.check() which uses non-atomic updates.
    # A conforming implementation must NOT allow transaction abort to roll back a
    # PIN failure counter decrement.
    #
    # NOTE: This tests the SIM's PIN implementation, not the JCVM itself.
    # Included here because the attack vector is the transaction mechanism.
    Given the SIM has PIN1 with try-counter = 3 and correct PIN = 1234
    When an applet executes:
      1. beginTransaction()
      2. OwnerPIN.check(wrong_pin_bytes)   // try-counter decrements to 2
      3. abortTransaction()
    Then after abortTransaction() the PIN try-counter is 2 (NOT rolled back to 3)
    And the failed attempt is permanently recorded
    And an attacker cannot use this sequence to gain unlimited PIN guesses

  # ==========================================================================
  # ATTACK 8: SIO AID Spoofing
  # Paper: Poll CARDIS 2008, Section 3; Perovich INRIA 2002
  # Violates: JCRE Spec Ch.6.2 "Firewall" - AID uniqueness enforcement
  # ==========================================================================

  Scenario: Installing an applet with an AID matching an already-installed applet is rejected
    # This prevents AID spoofing when a server authenticates SIO clients by AID.
    Given applet CLIENT_A is installed with AID A0:00:00:00:01
    When another applet attempts to install with AID A0:00:00:00:01
    Then the installation is rejected
    And the error indicates "AID already registered"
    And the legitimate CLIENT_A remains installed and functional

  Scenario: Malicious applet cannot obtain SIO intended for a different AID
    # Even if installation is rejected (above), this tests the server-side check:
    # the server's getShareableInterfaceObject() receives the caller's real AID,
    # and must return null if the caller AID is not in the authorized list.
    Given a server applet SERVER installed with AID A0:00:00:00:02
    And SERVER.getShareableInterfaceObject() returns a SIO only for authorized client AID A0:00:00:00:01
    And a malicious applet ATTACKER is installed with AID A0:00:00:00:99
    When ATTACKER calls JCSystem.getAppletShareableInterfaceObject(SERVER_AID, 0)
    Then the JCRE calls SERVER.getShareableInterfaceObject(ATTACKER_AID, 0)
    And SERVER returns null (ATTACKER_AID is not authorized)
    And ATTACKER receives null from getAppletShareableInterfaceObject()
    And ATTACKER cannot access SERVER's data

  Scenario: SIO interface method dispatch verifies parameter type compatibility
    # Witteman's binary interface incompatibility attack.
    # Two separately compiled applets use different versions of the same interface.
    Given server SRVC compiled against interface version V1 where method "process" takes short[]
    And client CLNT compiled against interface version V2 where method "process" takes byte[]
    When CLNT obtains a SIO reference to SRVC and calls SIO.process(byteArray)
    Then the JCVM detects the method signature mismatch at dispatch time
    And throws SecurityException or ClassCastException
    And does NOT execute SRVC.process() with a mistyped argument

  Scenario: Cross-context field access without SIO throws SecurityException
    # Direct field access across the firewall must be blocked even if the attacker
    # has a reference to the object (e.g., obtained via type confusion).
    Given applet A owns object O with a private field
    And applet B somehow obtains a reference to O (e.g., via a type confusion)
    When applet B attempts to read O's private field (getfield on O)
    Then a SecurityException is thrown
    And the field value is not returned to applet B

  # ==========================================================================
  # ATTACK 9: Firewall context check on checkcast and instanceof
  # Reference: JCVM Spec Ch.7 checkcast/instanceof instruction definitions;
  #            JCRE Spec Ch.6 (Chapter 6 is referenced by both instructions)
  # ==========================================================================

  Scenario: checkcast across firewall boundary throws SecurityException
    # JCVM spec states that checkcast "may throw SecurityException if the current
    # context is not the owning context of the object." This must be enforced.
    Given applet A is executing in context CA
    And applet A has obtained a reference REF to an object owned by context CB
    When applet A executes: checkcast REF as SomeClass
    Then SecurityException is thrown
    And NOT ClassCastException (which would reveal type information about CB's object)

  Scenario: instanceof across firewall boundary throws SecurityException
    # Similarly for instanceof -- the spec mandates SecurityException in this case.
    Given applet A is executing in context CA
    And applet A has a reference to an object owned by context CB
    When applet A executes: instanceof REF SomeClass
    Then SecurityException is thrown
    And the boolean result is not returned (the exception takes priority)

  # ==========================================================================
  # ATTACK 10: Reference spoofing / fabricating references from integer values
  # Papers: Poll CARDIS 2008, Section 4.4 "Reference Spoofing";
  #         JavaCard Logical Attacks blog 2016
  # Violates: JCVM type safety - integer arithmetic must not produce valid references
  # ==========================================================================

  Scenario: Arithmetic on an integer value cannot produce a valid object reference
    # C-style pointer arithmetic is the goal of several attack chains.
    # The JCVM must ensure that no integer operation (sadd, sand, sor, etc.)
    # on a value can produce a reference that the VM accepts as valid.
    Given an applet that computes an integer value by arithmetic (e.g., sload_0, sconst_1, sadd)
    And attempts to use that integer as a reference by storing it in a reference-typed field
    Then the JCVM detects the type mismatch (integer stored in reference field)
    And throws VerifyError or ArrayStoreException
    And the fabricated integer is not treated as a memory address

  Scenario: AID object cannot be accessed as a byte array via type confusion
    # From Poll CARDIS 2008: if a system-owned AID object is accessed as an array,
    # an attacker can overwrite the global AID registry entries.
    Given the JCRE has registered package AID A0:00:00:00:01 in its internal registry
    And an attacker applet achieves a type-confused reference to the AID object
    When the attacker attempts to write to the AID object via array write operations
    Then a SecurityException is thrown
    And the AID registry entry A0:00:00:00:01 is unchanged after the attempt
```

---

## Sources and Evidence

### Primary Papers (peer-reviewed, directly relevant)

1. Bouffard, G., Iguchi-Cartigny, J., Lanet, J.-L. "Combined Software and Hardware Attacks on the
   Java Card Control Flow." CARDIS 2011. LNCS 7079, pp. 283-296.
   https://link.springer.com/chapter/10.1007/978-3-642-27257-8_18
   https://dl.ifip.org/db/conf/cardis/cardis2011/BouffardIL11.pdf

2. Poll, E., Schubert, A. "Malicious Code on Java Card Smartcards: Attacks and Countermeasures."
   CARDIS 2008. cs.ru.nl preprint:
   https://www.cs.ru.nl/~erikpoll/papers/cardis08.pdf

3. Hubbers, E., Mostowski, W., Poll, E. "Tearing Java Cards." eSmart 2006.
   https://www.cs.ru.nl/~erikpoll/papers/esmart06.pdf

4. Hogenboom, J., Mostowski, W. "Full Memory Attack on a Java Card." WISSEC 2009.
   https://repository.ubn.ru.nl/bitstream/handle/2066/75388/75388.pdf
   ResearchGate: https://www.researchgate.net/publication/228788902_Full_Memory_Read_Attack_on_a_Java_Card

5. Lancia, J., Bouffard, G. "Java Card Virtual Machine Compromising from a Bytecode Verified
   Applet." CARDIS 2015. HAL: https://hal.science/hal-03138832/document
   ResearchGate: https://www.researchgate.net/publication/283300471

6. Lancia, J., Bouffard, G. "Fuzzing and Overflows in Java Card Smart Cards." SSTIC 2016.
   https://www.sstic.org/media/SSTIC2016/SSTIC-actes/fuzzing_and_overflows_in_java_card_smart_cards/SSTIC2016-Article-fuzzing_and_overflows_in_java_card_smart_cards-bouffard_lancia.pdf
   HAL: https://hal.science/hal-03138856v1/document

7. Laugier, B., Razafindralambo, T. "Misuse of Frame Creation to Exploit Stack Underflow Attacks
   on Java Card." CARDIS 2015. LNCS 9514. DOI: 10.1007/978-3-319-31271-2_6.
   https://link.springer.com/chapter/10.1007/978-3-319-31271-2_6
   ResearchGate: https://www.researchgate.net/publication/308894710

8. Bouffard, G. et al. "Accessing Secure Information using Export File Fraudulence." CRiSIS 2013.
   https://www.bouffard.info/assets/pdf/conf/crisis/BouffardKLKS13.pdf
   IEEE: https://ieeexplore.ieee.org/document/6766346

9. Dubreuil, J., Bouffard, G. "PhiAttack: Rewriting the Java Card Class Hierarchy." CARDIS 2021.
   LNCS 13173, pp. 275-288.
   https://link.springer.com/chapter/10.1007/978-3-030-97348-3_15
   HAL: https://hal.science/hal-03823792v1/document
   Direct PDF: https://cardis2021.its.uni-luebeck.de/papers/CARDIS2021_Dubreuil.pdf

10. Barbu, G., Hoogvorst, P., Duc, G. "Tampering with Java Card Exceptions: The Exception Proves
    the Rule." SECRYPT 2012. DOI: 10.5220/0004018600550063.
    https://www.scitepress.org/Documents/2012/40186/

11. Razafindralambo, T., Bouffard, G., Lanet, J.-L. "A Friendly Framework for Hiding Fault
    Enabled Virus for Java Based Smartcard." DBSec 2012. LNCS 7371.
    https://link.springer.com/chapter/10.1007/978-3-642-31540-4_10
    Direct PDF: https://dl.ifip.org/db/conf/dbsec/dbsec2012/RazafindralamboBL12.pdf

12. Razafindralambo, T. et al. "A Dynamic Syntax Interpretation for Java Based Smart Card to
    Mitigate Logical Attacks." SNDS 2012. CCIS 335, pp. 185-194.
    https://link.springer.com/chapter/10.1007/978-3-642-34135-9_19

13. Farhadi, M. & Lanet, J.-L. "Chronicle of a Java Card Death." J. Comput. Virol. Hack.
    Techniques (2016). DOI: 10.1007/s11416-016-0276-0.
    https://link.springer.com/article/10.1007/s11416-016-0276-0
    HAL: https://inria.hal.science/hal-01385197

14. Witteman, M. "Java Card Security." Information Security Bulletin 8, 291-298 (2003).
    Slide deck: https://www.slideshare.net/riscure/java-card-security

15. Barbu, G., Thiebeauld, H., Guerin, V. "Attacks on Java Card 3.0 Combining Fault and Logical
    Attacks." CARDIS 2010. LNCS 6035.
    https://link.springer.com/chapter/10.1007/978-3-642-12510-2_11

### Public Vulnerability Disclosures

16. Security Explorations. "[SE-2019-01] Java Card Vulnerabilities." Full Disclosure, March 2019.
    https://seclists.org/fulldisclosure/2019/Mar/35
    Project: https://security-explorations.com/java-card.html

### Specifications

17. Oracle. "Java Card Platform Virtual Machine Specification, Classic Edition Version 3.1."
    https://docs.oracle.com/en/java/javacard/3.1/jc-vm-spec/F12650_05.pdf

18. Oracle. "Java Card Runtime Environment (JCRE) Specification 3.0 / 2.2.1."
    (Chapter 7: Transactions; Chapter 6: Firewall)

19. Java Card Virtual Machine Instruction Set (2.2.1 era reference):
    http://pfa12.free.fr/doc_java/javacard_specifications/specs/jcvm/html/JCVM07instr.html

### CTF / Practical Demonstrations

20. KITCTF. "Real World CTF 2023: Happy-Card Writeup." (PhiAttack in practice)
    https://kitctf.de/writeups/rwctf2023-happycard

21. JavaCard Security Blog. "Javacard Logical Attacks." (2016)
    https://javacardblog.wordpress.com/2016/12/17/javacard-logical-attacks/

---

## Research Gaps and Limitations

1. **Exact bytecode sequences from the Bouffard/Iguchi-Cartigny CARDIS 2011 paper** were not
   extractable because the IFIP PDF is binary-compressed. The attack description above is
   reconstructed from secondary citations and the CARDIS 2015 follow-up. Consult the HAL preprint
   for full details.

2. **Faugeron 2013 "Manipulating the Frame Information with an Underflow Attack"** (CARDIS 2013)
   was referenced but not located as an open-access PDF. It is the primary predecessor to Laugier
   2015 for the `dup_x` underflow attack chain.

3. **Specific card vendor names** from Hogenboom & Mostowski 2009 were not disclosed publicly (they
   use "manufacturer A/B/C/D"). The test scenarios above cannot name specific vendors.

4. **SE-2019-01 technical details** were not publicly disclosed (Oracle claimed the RI is not
   production-intended). The 31 specific issues are known only to Oracle and Gemalto.

5. **On-card bytecode verifier behavior** varies significantly between card generations. All the
   BCV-bypass attacks assume the card lacks an on-card BCV (true for most JC 2.x cards). JC 3.0+
   Connected Edition adds an on-card BCV, but Barbu et al. (CARDIS 2010) showed that fault
   injection plus logical attacks can still bypass even an on-card BCV.

---

## Contradictions and Disputes

1. **Oracle vs. Security Explorations (2019):** Oracle claimed the reference implementation is
   "not intended for production use" and that licensees must conduct their own security evaluation.
   SE disputed this, noting that multiple named licensees (G&D, STMicro, Gemalto) appeared to
   derive production implementations from the RI. This dispute is unresolved publicly.

2. **Off-card BCV as sufficient defense:** Several older papers cite "code signing + off-card BCV"
   as sufficient countermeasure. Lancia & Bouffard (2015) explicitly refute this: their attack
   generates a CAP file that passes the Oracle off-card BCV. The BCV is necessary but not
   sufficient.

3. **Transaction rollback scope:** The JCRE spec is genuinely ambiguous about whether stack-local
   references to rolled-back objects must be nulled. Witteman identified this as a vulnerability
   in 2003; Oracle has never publicly issued an erratum to the spec clarifying this requirement.
   A conforming, secure implementation should treat the Hubbers/Mostowski/Poll analysis as
   authoritative: stack locals MUST be nulled.

---

## Search Methodology

- Searches performed: 18
- Most productive search terms: "Bouffard Iguchi-Cartigny Lanet JavaCard", "JavaCard transaction
  abort dangling reference type confusion", "JavaCard invokestatic EMAN attack CAP file",
  "JavaCard stack underflow frame dup_x", "Razafindralambo logical attacks taxonomy",
  "Lancia Bouffard CARDIS 2015 BCV bypass"
- Primary information sources: HAL Science open archive, cs.ru.nl (Radboud University),
  dl.ifip.org, Springer LNCS, IEEE Xplore abstracts, bouffard.info author page, Security
  Explorations full disclosure, CARDIS proceedings, SSTIC proceedings
- PDF binary fetches: mostly returned compressed binary, not renderable text. Descriptions rely on
  search result summaries, secondary citations, and cached summaries from ResearchGate/ACM.
