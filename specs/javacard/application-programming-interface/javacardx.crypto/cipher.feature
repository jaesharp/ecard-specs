@javacardx
@javacardx.crypto
@v3.0.5
@v3.1
@v3.2
Feature: Cipher and Cipher.OneShot -- Symmetric and Asymmetric Cipher Operations
  The Cipher class is the abstract base class for cipher algorithms. Implementations
  must extend this class and implement all abstract methods.

  A tear or card reset event resets an initialized Cipher object to a state where the
  key and mode remain as previously initialized, but other initial values (such as IV)
  revert to defaults (e.g. zeroed IV for CBC/CFB/CTR/XTS modes).

  For algorithms supporting transient key data sets (e.g. AES), the Cipher object key
  becomes uninitialized on clear events associated with the Key object used to initialize it.

  Even if a transaction is in progress, update of intermediate result state in the
  implementation instance shall not participate in the transaction.

  # Source: [JavaCard 3.2 API, Cipher](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  Background:
    Given a JavaCard runtime environment

  # ========== Algorithm Constants ==========
  Scenario Outline: Cipher defines legacy combined algorithm constants
    Then class Cipher defines static byte constant "<constant>"
    And the constant represents cipher algorithm "<description>"

    # Source: [JavaCard 3.2 API, <constant>](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
    Examples:
      | constant                    | description                                                                        |
      | ALG_DES_CBC_NOPAD           | DES in CBC mode or triple DES in outer CBC mode, no padding                        |
      | ALG_DES_CBC_ISO9797_M1      | DES in CBC mode or triple DES in outer CBC mode, ISO 9797 method 1 padding         |
      | ALG_DES_CBC_ISO9797_M2      | DES in CBC mode or triple DES in outer CBC mode, ISO 9797 method 2 padding         |
      | ALG_DES_CBC_PKCS5           | DES in CBC mode or triple DES in outer CBC mode, PKCS#5 padding                    |
      | ALG_DES_ECB_NOPAD           | DES in ECB mode, no padding                                                        |
      | ALG_DES_ECB_ISO9797_M1      | DES in ECB mode, ISO 9797 method 1 padding                                         |
      | ALG_DES_ECB_ISO9797_M2      | DES in ECB mode, ISO 9797 method 2 padding                                         |
      | ALG_DES_ECB_PKCS5           | DES in ECB mode, PKCS#5 padding                                                    |
      | ALG_RSA_PKCS1               | RSA with PKCS#1 v1.5 padding                                                       |
      | ALG_RSA_NOPAD               | RSA with no padding                                                                |
      | ALG_RSA_PKCS1_OAEP          | RSA with PKCS#1-OAEP (IEEE 1363-2000) padding, SHA-1 default for scheme and MGF1   |
      | ALG_AES_BLOCK_128_CBC_NOPAD | AES block size 128 in CBC mode, no padding                                         |
      | ALG_AES_BLOCK_128_ECB_NOPAD | AES block size 128 in ECB mode, no padding                                         |
      | ALG_AES_CBC_ISO9797_M1      | AES block size 128 in CBC mode, ISO 9797 method 1 padding                          |
      | ALG_AES_CBC_ISO9797_M2      | AES block size 128 in CBC mode, ISO 9797 method 2 padding                          |
      | ALG_AES_CBC_PKCS5           | AES block size 128 in CBC mode, PKCS#5 padding                                     |
      | ALG_AES_ECB_ISO9797_M1      | AES block size 128 in ECB mode, ISO 9797 method 1 padding                          |
      | ALG_AES_ECB_ISO9797_M2      | AES block size 128 in ECB mode, ISO 9797 method 2 padding                          |
      | ALG_AES_ECB_PKCS5           | AES block size 128 in ECB mode, PKCS#5 padding                                     |
      | ALG_KOREAN_SEED_ECB_NOPAD   | Korean SEED (KISA) in ECB mode, no padding                                         |
      | ALG_KOREAN_SEED_CBC_NOPAD   | Korean SEED (KISA) in CBC mode, no padding                                         |
      | ALG_AES_CTR                 | AES in counter (CTR) mode                                                          |
      | ALG_AES_CFB                 | AES in Cipher Feedback (CFB) mode                                                  |
      | ALG_AES_XTS                 | AES in XEX Tweakable Block Cipher with Ciphertext Stealing (XTS) per IEEE Std 1619 |

  Scenario Outline: Cipher defines deprecated algorithm constants
    Then class Cipher defines deprecated static byte constant "<constant>"
    And the constant should not be used because "<reason>"

    # Source: [JavaCard 3.2 API, <constant>](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
    Examples:
      | constant                    | reason                                                         |
      | ALG_RSA_ISO14888            | ISO 14888 algorithms are intended for signatures               |
      | ALG_RSA_ISO9796             | ISO 9796-1 algorithm was withdrawn by ISO in July 2000         |
      | ALG_AES_BLOCK_192_CBC_NOPAD | NIST FIPS PUB 197 only supports block size of 128 bits for AES |
      | ALG_AES_BLOCK_192_ECB_NOPAD | NIST FIPS PUB 197 only supports block size of 128 bits for AES |
      | ALG_AES_BLOCK_256_CBC_NOPAD | NIST FIPS PUB 197 only supports block size of 128 bits for AES |
      | ALG_AES_BLOCK_256_ECB_NOPAD | NIST FIPS PUB 197 only supports block size of 128 bits for AES |

  Scenario Outline: Cipher defines raw cipher algorithm constants for three-argument getInstance
    Then class Cipher defines static byte constant "<constant>"
    And the constant is used for the cipherAlgorithm parameter of getInstance(byte, byte, boolean)

    # Source: [JavaCard 3.2 API, <constant>](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
    Examples:
      | constant               | description                                            |
      | CIPHER_AES_CBC         | AES with block size 128 in CBC mode                    |
      | CIPHER_AES_ECB         | AES with block size 128 in ECB mode                    |
      | CIPHER_DES_CBC         | DES in CBC mode                                        |
      | CIPHER_DES_ECB         | DES in ECB mode                                        |
      | CIPHER_KOREAN_SEED_CBC | Korean SEED in CBC mode                                |
      | CIPHER_KOREAN_SEED_ECB | Korean SEED in ECB mode                                |
      | CIPHER_RSA             | RSA cipher                                             |
      | CIPHER_AES_CTR         | AES in counter (CTR) mode, PAD_NULL only               |
      | CIPHER_AES_CFB         | AES in Cipher Feedback (CFB) mode, PAD_NULL only       |
      | CIPHER_AES_XTS         | AES in XTS mode per IEEE Std 1619, PAD_NULL only       |
      | CIPHER_SM4_ECB         | SM4 block cipher in ECB mode with 128-bit input blocks |
      | CIPHER_SM4_CBC         | SM4 block cipher in CBC mode with 128-bit input blocks |
      | CIPHER_SM2             | SM2 encryption per GM/T 0003.4-2012, PAD_NULL only     |

  Scenario Outline: Cipher defines padding algorithm constants
    Then class Cipher defines static byte constant "<constant>"
    And the constant is used for the paddingAlgorithm parameter

    # Source: [JavaCard 3.2 API, <constant>](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
    Examples:
      | constant                      | description                                                            |
      | PAD_NULL                      | No discrete padding algorithm                                          |
      | PAD_NOPAD                     | No padding; data must be block-aligned                                 |
      | PAD_ISO9797_M1                | ISO 9797 method 1 padding                                              |
      | PAD_ISO9797_M2                | ISO 9797 method 2 padding                                              |
      | PAD_PKCS5                     | PKCS#5 padding                                                         |
      | PAD_PKCS1                     | PKCS v1.5 padding                                                      |
      | PAD_PKCS1_OAEP                | PKCS#1-OAEP (IEEE 1363-2000) with SHA-1 default                        |
      | PAD_PKCS1_OAEP_SHA224         | PKCS#1-OAEP with SHA-224                                               |
      | PAD_PKCS1_OAEP_SHA256         | PKCS#1-OAEP with SHA-256                                               |
      | PAD_PKCS1_OAEP_SHA384         | PKCS#1-OAEP with SHA-384                                               |
      | PAD_PKCS1_OAEP_SHA512         | PKCS#1-OAEP with SHA-512                                               |
      | PAD_PKCS1_OAEP_SHA3_224       | PKCS#1-OAEP with SHA3-224                                              |
      | PAD_PKCS1_OAEP_SHA3_256       | PKCS#1-OAEP with SHA3-256                                              |
      | PAD_PKCS1_OAEP_SHA3_384       | PKCS#1-OAEP with SHA3-384                                              |
      | PAD_PKCS1_OAEP_SHA3_512       | PKCS#1-OAEP with SHA3-512                                              |
      | PAD_PKCS1_OAEP_EXT_PARAMETERS | PKCS#1-OAEP with configurable digest for scheme and MGF1 (since 3.2)   |
      | PAD_PKCS1_PSS                 | PKCS#1-PSS (IEEE 1363-2000) for Signature, salt length = digest length |
      | PAD_PKCS1_PSS_EXT_PARAMETERS  | PKCS#1-PSS with configurable salt and MGF1 digest (since 3.2)          |
      | PAD_ISO9797_1_M1_ALG3         | ISO 9797-1 MAC algorithm 3 with method 1 (Signature only)              |
      | PAD_ISO9797_1_M2_ALG3         | ISO 9797-1 MAC algorithm 3 with method 2 / EMV'96 (Signature only)     |
      | PAD_ISO9796                   | ISO/IEC 9796-2 scheme 1 (Signature only)                               |
      | PAD_ISO9796_MR                | ISO/IEC 9796-2 scheme 1 with message recovery (Signature only)         |
      | PAD_ISO9796_MR_SCHEME_2       | ISO/IEC 9796-2 scheme 2 with message recovery (since 3.1)              |
      | PAD_ISO9796_MR_SCHEME_3       | ISO/IEC 9796-2 scheme 3 with message recovery (since 3.1)              |
      | PAD_ISO9796_MR_SCHEME_1_OPT_2 | ISO/IEC 9796-2 scheme 1 trailer option 2 with recovery (since 3.2)     |
      | PAD_ISO9796_MR_SCHEME_2_OPT_2 | ISO/IEC 9796-2 scheme 2 trailer option 2 with recovery (since 3.2)     |
      | PAD_ISO9796_MR_SCHEME_3_OPT_2 | ISO/IEC 9796-2 scheme 3 trailer option 2 with recovery (since 3.2)     |
      | PAD_RFC2409                   | RFC 2409 padding (Signature only)                                      |

  Scenario: Cipher defines mode constants
    Then class Cipher defines static byte constant "MODE_DECRYPT" for decryption mode
    And class Cipher defines static byte constant "MODE_ENCRYPT" for encryption mode

  # Source: [JavaCard 3.2 API, MODE_DECRYPT](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  # Source: [JavaCard 3.2 API, MODE_ENCRYPT](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  # ========== Factory Methods ==========
  Scenario: Cipher.getInstance with legacy algorithm constant
    When getInstance(byte algorithm, boolean externalAccess) is called
    Then a Cipher object instance of the selected algorithm is returned
    And if externalAccess is true, the instance is a Shareable interface object

  # Source: [JavaCard 3.2 API, getInstance](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#getInstance(byte,boolean))
  Scenario: Cipher.getInstance with raw cipher and padding algorithm
    When getInstance(byte cipherAlgorithm, byte paddingAlgorithm, boolean externalAccess) is called
    Then a Cipher object instance with the selected cipher and padding algorithms is returned
    And if externalAccess is true, the instance is a Shareable interface object

  # Source: [JavaCard 3.2 API, getInstance](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#getInstance(byte,byte,boolean))
  Scenario: Cipher.getInstance throws CryptoException for unsupported algorithm
    When getInstance is called with an unsupported algorithm constant
    Then CryptoException is thrown with reason code NO_SUCH_ALGORITHM

  # Source: [JavaCard 3.2 API, getInstance](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#getInstance(byte,boolean))
  # ========== Initialization ==========
  Scenario: Cipher.init with key and mode
    Given a Cipher instance obtained via getInstance
    When init(Key theKey, byte theMode) is called
    Then the Cipher is initialized for the specified mode with default parameters
    And CBC/CFB/CTR/XTS modes use zeroed IV as default

  # Source: [JavaCard 3.2 API, init](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#init(Key,byte))
  Scenario: Cipher.init with key, mode and algorithm-specific parameters
    Given a Cipher instance obtained via getInstance
    When init(Key theKey, byte theMode, byte[] bArray, short bOff, short bLen) is called
    Then the Cipher is initialized with the specified parameters (e.g. IV for CBC modes)

  # Source: [JavaCard 3.2 API, init](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#init(Key,byte,byte%5B%5D,short,short))
  Scenario: Cipher.init throws CryptoException for invalid mode
    Given a Cipher instance
    When init is called with an undefined mode value
    Then CryptoException is thrown with reason code ILLEGAL_VALUE

  # Source: [JavaCard 3.2 API, init](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#init(Key,byte))
  Scenario: Cipher.init throws CryptoException for uninitialized key
    Given a Cipher instance
    When init is called with an uninitialized Key
    Then CryptoException is thrown with reason code UNINITIALIZED_KEY

  # Source: [JavaCard 3.2 API, init](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#init(Key,byte))
  Scenario: Cipher.init throws CryptoException for inconsistent key type
    Given a Cipher instance
    When init is called with a Key inconsistent with the Cipher algorithm
    Then CryptoException is thrown with reason code ILLEGAL_VALUE

  # Source: [JavaCard 3.2 API, init](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#init(Key,byte))
  # ========== Encryption/Decryption Operations ==========
  Scenario: Cipher.update processes partial input data
    Given an initialized Cipher instance
    When update(byte[] inBuff, short inOffset, short inLength, byte[] outBuff, short outOffset) is called
    Then intermediate encrypted/decrypted output is written to outBuff
    And the method returns the number of bytes output
    And partial blocks may be buffered internally

  # Source: [JavaCard 3.2 API, update](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#update(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: Cipher.doFinal completes the cipher operation
    Given an initialized Cipher instance with possible prior update calls
    When doFinal(byte[] inBuff, short inOffset, short inLength, byte[] outBuff, short outOffset) is called
    Then all remaining input is processed and final encrypted/decrypted output is produced
    And the Cipher is reset for a new operation with the same key and mode
    And the method returns the number of bytes output

  # Source: [JavaCard 3.2 API, doFinal](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: Cipher.doFinal throws CryptoException if not initialized
    Given a Cipher instance that has not been initialized
    When doFinal is called
    Then CryptoException is thrown with reason code INVALID_INIT

  # Source: [JavaCard 3.2 API, doFinal](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: NOPAD cipher throws CryptoException for non-block-aligned data
    Given a Cipher initialized with a NOPAD algorithm (e.g. ALG_DES_CBC_NOPAD)
    When doFinal is called with data that is not block-aligned
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, ALG_DES_CBC_NOPAD](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  Scenario: RSA NOPAD cipher throws CryptoException for misaligned or oversized data
    Given a Cipher initialized with ALG_RSA_NOPAD
    When doFinal is called with data not block-aligned or >= modulus size
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, ALG_RSA_NOPAD](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  Scenario: RSA PKCS1 cipher limits input length
    Given a Cipher initialized with ALG_RSA_PKCS1
    When encrypting, total input bytes must not exceed k-11 where k is modulus size in bytes

  # Source: [JavaCard 3.2 API, ALG_RSA_PKCS1](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  Scenario: SM2 cipher does not allow update operations
    Given a Cipher initialized with CIPHER_SM2
    When update is called
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, CIPHER_SM2](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  # ========== Query Methods ==========
  Scenario: Cipher.getAlgorithm returns the legacy algorithm constant
    Given a Cipher instance created with a legacy algorithm constant
    When getAlgorithm() is called
    Then the legacy algorithm byte constant is returned

  # Source: [JavaCard 3.2 API, getAlgorithm](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#getAlgorithm)
  Scenario: Cipher.getCipherAlgorithm returns the raw cipher algorithm
    Given a Cipher instance created with getInstance(byte, byte, boolean)
    When getCipherAlgorithm() is called
    Then the raw cipher algorithm byte constant (e.g. CIPHER_AES_CBC) is returned

  # Source: [JavaCard 3.2 API, getCipherAlgorithm](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#getCipherAlgorithm)
  Scenario: Cipher.getPaddingAlgorithm returns the padding algorithm
    Given a Cipher instance created with getInstance(byte, byte, boolean)
    When getPaddingAlgorithm() is called
    Then the padding algorithm byte constant (e.g. PAD_PKCS5) is returned

  # Source: [JavaCard 3.2 API, getPaddingAlgorithm](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#getPaddingAlgorithm)
  # ========== Cipher.OneShot ==========
  Scenario: Cipher.OneShot is a JCRE-owned temporary Entry Point Object
    Then Cipher.OneShot instances are JCRE-owned temporary Entry Point Objects
    And references to OneShot cannot be stored in class variables, instance variables, or array components
    And the platform must support at least one OneShot instance

  # Source: [JavaCard 3.2 API, OneShot](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  Scenario: Cipher.OneShot.open creates a one-shot cipher instance
    When Cipher.OneShot.open(byte cipherAlgorithm, byte paddingAlgorithm) is called
    Then a OneShot Cipher instance is returned for one-shot ciphering operations

  # Source: [JavaCard 3.2 API, open](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#open(byte,byte))
  Scenario: Cipher.OneShot.close releases the instance for reuse
    Given an open Cipher.OneShot instance
    When close() is called
    Then the instance is released back to the JCRE for reuse
    And any subsequent method calls throw CryptoException with ILLEGAL_USE

  # Source: [JavaCard 3.2 API, close](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#close)
  Scenario: Cipher.OneShot is released on applet entry point return
    Given a Cipher.OneShot instance in use
    When control returns from any Applet entry point method to the JCRE
    Then the OneShot instance is automatically released

  # Source: [JavaCard 3.2 API, OneShot](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  Scenario: Cipher.OneShot is released on tear or card reset
    Given a Cipher.OneShot instance in use
    When a tear or card reset event occurs
    Then the OneShot instance is automatically released

  # Source: [JavaCard 3.2 API, OneShot](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)
  Scenario: Cipher.OneShot.doFinal performs complete cipher operation
    Given an initialized Cipher.OneShot instance
    When doFinal(byte[] inBuff, short inOffset, short inLength, byte[] outBuff, short outOffset) is called
    Then the complete encrypted/decrypted output is produced in one call

  # Source: [JavaCard 3.2 API, doFinal](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: Cipher.OneShot.update is not supported
    Given an initialized Cipher.OneShot instance
    When update is called
    Then CryptoException is thrown with reason code ILLEGAL_USE

  # Source: [JavaCard 3.2 API, update](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html#update(byte%5B%5D,short,short,byte%5B%5D,short))
  # ========== AES-XTS Key Format ==========
  Scenario: AES-XTS cipher requires concatenated dual keys
    Given a Cipher initialized with CIPHER_AES_XTS
    Then the key is parsed as Key1 | Key2 of equal size
    And KeyBuilder.LENGTH_AES_256 provides 128-bit Key1 and 128-bit Key2
    And KeyBuilder.LENGTH_AES_512 provides 256-bit Key1 and 256-bit Key2


# Source: [JavaCard 3.2 API, CIPHER_AES_XTS](../.refs/javadoc-3.2/api_classic/javacardx/crypto/Cipher.html)