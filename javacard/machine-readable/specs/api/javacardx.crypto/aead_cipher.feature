@javacardx
@javacardx.crypto
@v3.0.5
@v3.1
@v3.2
Feature: AEADCipher -- Authenticated Encryption with Associated Data
  The AEADCipher class is the abstract base class for AEAD ciphers, extending Cipher.
  Examples include AES-GCM (NIST SP 800-38D) and AES-CCM (RFC 3610).

  AEAD cipher instances are obtained via Cipher.getInstance and cast to AEADCipher.

  A tear or card reset resets the AEADCipher to a state where key and mode are
  preserved but other initial values (tagSize, messageLen, IV, nonce) are reset to 0.

  # Source: [JavaCard 3.2 API, AEADCipher](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html)
  Background:
    Given a JavaCard runtime environment

  # ========== Algorithm Constants ==========
  Scenario Outline: AEADCipher defines algorithm constants
    Then class AEADCipher defines static byte constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html)
    Examples:
      | constant       | description                                                             |
      | ALG_AES_GCM    | AES in Galois/Counter Mode per NIST SP 800-38D                          |
      | ALG_AES_CCM    | AES in Counter with CBC-MAC mode per RFC 3610                           |
      | CIPHER_AES_GCM | Raw cipher algorithm for getInstance(byte, byte, boolean) with PAD_NULL |
      | CIPHER_AES_CCM | Raw cipher algorithm for getInstance(byte, byte, boolean) with PAD_NULL |

  # ========== Initialization ==========
  Scenario: AEADCipher.init with key and mode uses default nonce
    Given an AEADCipher instance (e.g. ALG_AES_GCM)
    When init(Key theKey, byte theMode) is called
    Then the cipher is initialized with a 12-byte zeroed IV for GCM mode

  # Source: [JavaCard 3.2 API, init](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#init(Key,byte))
  Scenario: AEADCipher.init with key, mode, and IV
    Given an AEADCipher instance
    When init(Key theKey, byte theMode, byte[] bArray, short bOff, short bLen) is called
    Then the cipher uses bArray as the IV for GCM mode

  # Source: [JavaCard 3.2 API, init](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#init(Key,byte,byte%5B%5D,short,short))
  Scenario: AEADCipher.init with full parameters for offline mode (CCM)
    Given an AEADCipher instance for ALG_AES_CCM
    When init(Key, byte, byte[] nonceBuf, short nonceOff, short nonceLen, short adataLen, short messageLen, short tagSize) is called
    Then the cipher is initialized with explicit nonce, AAD length, message length, and tag size
    And this form is required for offline cipher modes like CCM

  # Source: [JavaCard 3.2 API, init](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#init(Key,byte,byte%5B%5D,short,short,short,short,short))
  Scenario: AEADCipher.init throws INVALID_INIT for wrong cipher mode variant
    Given an AEADCipher for an online mode algorithm (e.g. GCM)
    When the offline-mode init (with adataLen, messageLen, tagSize) is called
    Then CryptoException is thrown with reason code INVALID_INIT

  # Source: [JavaCard 3.2 API, init](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#init(Key,byte,byte%5B%5D,short,short,short,short,short))
  Scenario: AEADCipher.init throws CryptoException for uninitialized key
    When init is called with an uninitialized Key
    Then CryptoException is thrown with reason code UNINITIALIZED_KEY

  # Source: [JavaCard 3.2 API, init](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#init(Key,byte))
  # ========== AAD Processing ==========
  Scenario: AEADCipher.updateAAD provides associated data
    Given an initialized AEADCipher instance
    When updateAAD(byte[] aadBuf, short aadOff, short aadLen) is called
    Then the AAD is included in authentication tag computation but not in ciphertext

  # Source: [JavaCard 3.2 API, updateAAD](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#updateAAD(byte%5B%5D,short,short))
  Scenario: AEADCipher.updateAAD called in wrong state
    Given an AEADCipher where data update has already begun
    When updateAAD is called
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, updateAAD](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#updateAAD(byte%5B%5D,short,short))
  Scenario: AEADCipher.updateAAD for CCM exceeds declared AAD size
    Given an AEADCipher initialized for ALG_AES_CCM with a specific adataLen
    When total AAD bytes provided via updateAAD exceed adataLen
    Then CryptoException is thrown with reason code ILLEGAL_VALUE

  # Source: [JavaCard 3.2 API, updateAAD](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#updateAAD(byte%5B%5D,short,short))
  # ========== Update and DoFinal ==========
  Scenario: AEADCipher.update processes message data
    Given an initialized AEADCipher with AAD already provided
    When update(byte[] inBuff, short inOffset, short inLength, byte[] outBuff, short outOffset) is called
    Then encrypted/decrypted output is produced
    And for stream-based AEAD (GCM/CCM), n input bytes produce n output bytes

  # Source: [JavaCard 3.2 API, update](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#update(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: AEADCipher.update for CCM without required AAD
    Given an AEADCipher initialized for ALG_AES_CCM with adataLen > 0
    When update is called before providing the required AAD
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, update](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#update(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: AEADCipher.update for CCM exceeds declared message size
    Given an AEADCipher initialized for ALG_AES_CCM with a specific messageLen
    When update payload exceeds the declared messageLen
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, update](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#update(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: AEADCipher.doFinal completes encryption/decryption and resets state
    Given an initialized AEADCipher instance with prior update calls
    When doFinal(byte[] inBuff, short inOffset, short inLength, byte[] outBuff, short outOffset) is called
    Then final output is produced
    And the cipher is reset: key and mode preserved, nonce/IV/tagSize/messageLen reset to 0
    And tagSize is retained for subsequent retrieveTag/verifyTag calls

  # Source: [JavaCard 3.2 API, doFinal](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: AEADCipher.doFinal for CCM validates total message size
    Given an AEADCipher initialized for ALG_AES_CCM
    When doFinal is called and total message size does not match the declared messageLen
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, doFinal](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short))
  # ========== Tag Operations ==========
  Scenario: AEADCipher.retrieveTag retrieves authentication tag after encryption
    Given an AEADCipher in MODE_ENCRYPT after doFinal has been called
    When retrieveTag(byte[] tagBuf, short tagOff, short tagLen) is called
    Then tagLen bytes of the computed authentication tag are written to tagBuf
    And the return value is tagLen

  # Source: [JavaCard 3.2 API, retrieveTag](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#retrieveTag(byte%5B%5D,short,short))
  Scenario: AEADCipher.retrieveTag throws ILLEGAL_USE before doFinal or in decrypt mode
    Given an AEADCipher in MODE_DECRYPT or before doFinal has been called
    When retrieveTag is called
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, retrieveTag](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#retrieveTag(byte%5B%5D,short,short))
  Scenario: AEADCipher.retrieveTag throws ILLEGAL_VALUE for CCM mismatched tag length
    Given an AEADCipher for ALG_AES_CCM initialized with a specific tagSize
    When retrieveTag is called with tagLen different from the initialized tagSize
    Then CryptoException is thrown with reason code ILLEGAL_VALUE

  # Source: [JavaCard 3.2 API, retrieveTag](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#retrieveTag(byte%5B%5D,short,short))
  Scenario: AEADCipher.verifyTag verifies authentication tag after decryption
    Given an AEADCipher in MODE_DECRYPT after doFinal has been called
    When verifyTag(byte[] receivedTagBuf, short receivedTagOff, short receivedTagLen, short requiredTagLen) is called
    Then returns true if the first requiredTagLen bytes of the received tag match the computed tag
    And returns false if receivedTagLen < requiredTagLen

  # Source: [JavaCard 3.2 API, verifyTag](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#verifyTag(byte%5B%5D,short,short,short))
  Scenario: AEADCipher.verifyTag throws ILLEGAL_USE before doFinal or in encrypt mode
    Given an AEADCipher in MODE_ENCRYPT or before doFinal has been called
    When verifyTag is called
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, verifyTag](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#verifyTag(byte%5B%5D,short,short,short))
  Scenario: AEADCipher.verifyTag throws ILLEGAL_VALUE for unsupported tag length
    When verifyTag is called with an unsupported tag length
    Then CryptoException is thrown with reason code ILLEGAL_VALUE

# Source: [JavaCard 3.2 API, verifyTag](../../../refs/javadoc-3.2/api_classic/javacardx/crypto/AEADCipher.html#verifyTag(byte%5B%5D,short,short,short))