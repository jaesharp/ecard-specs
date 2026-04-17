@v3.0.5
@v3.1
@v3.2
Feature: Signature -- Digital signature and MAC computation
  The Signature class is the base class for Signature algorithms.
  Includes SignatureMessageRecovery for signatures with message recovery,
  and Signature.OneShot for transient single-use instances.

  Background:
    Given the abstract class javacard.security.Signature is available

  # ---------------------------------------------------------------------------
  # Mode constants
  # ---------------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, Signature](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
  # Source: [JavaCard 3.1 API, Signature](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
  # Source: [JavaCard 3.2 API, Signature](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Signature mode constants have specified values
    # Source: [JavaCard 3.0.5 API, <constant>](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>

    Examples: Signature modes
      | constant    | value |
      | MODE_SIGN   | 1     |
      | MODE_VERIFY | 2     |

  # ---------------------------------------------------------------------------
  # Legacy ALG_ algorithm constants (single-constant factory style)
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Signature legacy DES MAC algorithm constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: DES MAC algorithms
      | constant                       | value | description                                      |
      | ALG_DES_MAC4_NOPAD             | 1     | DES 4-byte MAC, no padding                       |
      | ALG_DES_MAC8_NOPAD             | 2     | DES 8-byte MAC, no padding                       |
      | ALG_DES_MAC4_ISO9797_M1        | 3     | DES 4-byte MAC, ISO 9797 method 1                |
      | ALG_DES_MAC8_ISO9797_M1        | 4     | DES 8-byte MAC, ISO 9797 method 1                |
      | ALG_DES_MAC4_ISO9797_M2        | 5     | DES 4-byte MAC, ISO 9797 method 2                |
      | ALG_DES_MAC8_ISO9797_M2        | 6     | DES 8-byte MAC, ISO 9797 method 2                |
      | ALG_DES_MAC4_PKCS5             | 7     | DES 4-byte MAC, PKCS#5 padding                   |
      | ALG_DES_MAC8_PKCS5             | 8     | DES 8-byte MAC, PKCS#5 padding                   |
      | ALG_DES_MAC4_ISO9797_1_M2_ALG3 | 19    | DES 4-byte MAC, ISO 9797-1 method 2, algorithm 3 |
      | ALG_DES_MAC8_ISO9797_1_M2_ALG3 | 20    | DES 8-byte MAC, ISO 9797-1 method 2, algorithm 3 |
      | ALG_DES_MAC4_ISO9797_1_M1_ALG3 | 47    | DES 4-byte MAC, ISO 9797-1 method 1, algorithm 3 |
      | ALG_DES_MAC8_ISO9797_1_M1_ALG3 | 48    | DES 8-byte MAC, ISO 9797-1 method 1, algorithm 3 |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Signature legacy RSA algorithm constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: RSA signature algorithms
      | constant                     | value | description                                         |
      | ALG_RSA_SHA_ISO9796          | 9     | RSA with SHA-1, ISO 9796 padding                    |
      | ALG_RSA_SHA_PKCS1            | 10    | RSA with SHA-1, PKCS#1 v1.5 padding                 |
      | ALG_RSA_MD5_PKCS1            | 11    | RSA with MD5, PKCS#1 v1.5 padding                   |
      | ALG_RSA_RIPEMD160_ISO9796    | 12    | RSA with RIPEMD-160, ISO 9796 padding               |
      | ALG_RSA_RIPEMD160_PKCS1      | 13    | RSA with RIPEMD-160, PKCS#1 v1.5 padding            |
      | ALG_RSA_SHA_RFC2409          | 15    | RSA with SHA-1, RFC 2409 padding                    |
      | ALG_RSA_MD5_RFC2409          | 16    | RSA with MD5, RFC 2409 padding                      |
      | ALG_RSA_SHA_PKCS1_PSS        | 21    | RSA with SHA-1, PKCS#1 PSS padding                  |
      | ALG_RSA_MD5_PKCS1_PSS        | 22    | RSA with MD5, PKCS#1 PSS padding                    |
      | ALG_RSA_RIPEMD160_PKCS1_PSS  | 23    | RSA with RIPEMD-160, PKCS#1 PSS padding             |
      | ALG_RSA_SHA_ISO9796_MR       | 30    | RSA with SHA-1, ISO 9796 with message recovery      |
      | ALG_RSA_RIPEMD160_ISO9796_MR | 31    | RSA with RIPEMD-160, ISO 9796 with message recovery |
      | ALG_RSA_SHA_224_PKCS1        | 39    | RSA with SHA-224, PKCS#1 v1.5 padding               |
      | ALG_RSA_SHA_256_PKCS1        | 40    | RSA with SHA-256, PKCS#1 v1.5 padding               |
      | ALG_RSA_SHA_384_PKCS1        | 41    | RSA with SHA-384, PKCS#1 v1.5 padding               |
      | ALG_RSA_SHA_512_PKCS1        | 42    | RSA with SHA-512, PKCS#1 v1.5 padding               |
      | ALG_RSA_SHA_224_PKCS1_PSS    | 43    | RSA with SHA-224, PKCS#1 PSS padding                |
      | ALG_RSA_SHA_256_PKCS1_PSS    | 44    | RSA with SHA-256, PKCS#1 PSS padding                |
      | ALG_RSA_SHA_384_PKCS1_PSS    | 45    | RSA with SHA-384, PKCS#1 PSS padding                |
      | ALG_RSA_SHA_512_PKCS1_PSS    | 46    | RSA with SHA-512, PKCS#1 PSS padding                |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Signature legacy DSA and ECDSA algorithm constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: DSA/ECDSA algorithms
      | constant          | value | description        |
      | ALG_DSA_SHA       | 14    | DSA with SHA-1     |
      | ALG_ECDSA_SHA     | 17    | ECDSA with SHA-1   |
      | ALG_ECDSA_SHA_256 | 33    | ECDSA with SHA-256 |
      | ALG_ECDSA_SHA_384 | 34    | ECDSA with SHA-384 |
      | ALG_ECDSA_SHA_224 | 37    | ECDSA with SHA-224 |
      | ALG_ECDSA_SHA_512 | 38    | ECDSA with SHA-512 |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Signature legacy AES MAC algorithm constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: AES MAC algorithms
      | constant              | value | description                              |
      | ALG_AES_MAC_128_NOPAD | 18    | AES 128-bit MAC, no padding              |
      | ALG_AES_MAC_192_NOPAD | 35    | AES 192-bit MAC, no padding (deprecated) |
      | ALG_AES_MAC_256_NOPAD | 36    | AES 256-bit MAC, no padding (deprecated) |
      | ALG_AES_CMAC_128      | 49    | AES CMAC 128-bit MAC                     |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Signature legacy HMAC algorithm constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: HMAC algorithms
      | constant           | value | description          |
      | ALG_HMAC_SHA1      | 24    | HMAC with SHA-1      |
      | ALG_HMAC_SHA_256   | 25    | HMAC with SHA-256    |
      | ALG_HMAC_SHA_384   | 26    | HMAC with SHA-384    |
      | ALG_HMAC_SHA_512   | 27    | HMAC with SHA-512    |
      | ALG_HMAC_MD5       | 28    | HMAC with MD5        |
      | ALG_HMAC_RIPEMD160 | 29    | HMAC with RIPEMD-160 |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature legacy Korean SEED MAC constant
    # Source: [JavaCard 3.0.5 API, ALG_KOREAN_SEED_MAC_NOPAD](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, ALG_KOREAN_SEED_MAC_NOPAD](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, ALG_KOREAN_SEED_MAC_NOPAD](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "ALG_KOREAN_SEED_MAC_NOPAD" of type byte has value 32
    And it designates "Korean SEED 128-bit MAC, no padding"

  # ---------------------------------------------------------------------------
  # New-style SIG_CIPHER_ constants (decomposed factory style)
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Signature SIG_CIPHER_ cipher algorithm constants present since 3.0.5
    # Source: [JavaCard 3.0.5 API, <constant>](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Cipher algorithm identifiers for decomposed Signature.getInstance
      | constant                   | value | description                          |
      | SIG_CIPHER_DES_MAC4        | 1     | DES in MAC4 mode                     |
      | SIG_CIPHER_DES_MAC8        | 2     | DES in MAC8 mode                     |
      | SIG_CIPHER_RSA             | 3     | RSA cipher for signatures            |
      | SIG_CIPHER_DSA             | 4     | DSA cipher for signatures            |
      | SIG_CIPHER_ECDSA           | 5     | ECDSA cipher (DER-encoded output)    |
      | SIG_CIPHER_AES_MAC128      | 6     | AES in MAC128 mode                   |
      | SIG_CIPHER_HMAC            | 7     | HMAC cipher for signatures           |
      | SIG_CIPHER_KOREAN_SEED_MAC | 8     | Korean SEED in MAC mode              |
      | SIG_CIPHER_ECDSA_PLAIN     | 9     | ECDSA cipher (plain, non-DER output) |
      | SIG_CIPHER_AES_CMAC128     | 10    | AES CMAC 128-bit                     |

  @v3.1
  @v3.2
  Scenario Outline: Signature SIG_CIPHER_ constants added in version 3.1
    # Source: [JavaCard 3.1 API, <constant>](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Cipher algorithm identifiers since 3.1
      | constant              | value | description                              |
      | SIG_CIPHER_SM2        | 11    | SM2 signature cipher                     |
      | SIG_CIPHER_SM4_MAC128 | 12    | SM4 in MAC128 mode                       |
      | SIG_CIPHER_EDDSA      | 13    | EdDSA signature cipher (general)         |
      | SIG_CIPHER_EDDSAPH    | 14    | EdDSA prehash signature cipher (general) |

  @v3.2
  Scenario Outline: Signature SIG_CIPHER_ constants added in version 3.2
    # Source: [JavaCard 3.2 API, <constant>](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Cipher algorithm identifiers since 3.2
      | constant                   | value | description                            |
      | SIG_CIPHER_EDDSA_ED25519   | 15    | EdDSA Ed25519 signature cipher         |
      | SIG_CIPHER_EDDSA_ED448     | 16    | EdDSA Ed448 signature cipher           |
      | SIG_CIPHER_EDDSAPH_ED25519 | 17    | EdDSA prehash Ed25519 signature cipher |
      | SIG_CIPHER_EDDSAPH_ED448   | 18    | EdDSA prehash Ed448 signature cipher   |

  # ---------------------------------------------------------------------------
  # Factory methods
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getInstance with legacy single algorithm creates a Signature
    # Source: [JavaCard 3.0.5 API, getInstance](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getInstance(byte,boolean)
    Given a supported legacy ALG_ signature algorithm constant
    When Signature.getInstance(algorithm, externalAccess) is called
    Then a Signature instance implementing the requested algorithm is returned

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getInstance with decomposed parameters creates a Signature
    # Source: [JavaCard 3.0.5 API, getInstance](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getInstance(byte,byte,byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getInstance(byte,byte,byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getInstance(byte,byte,byte,boolean)
    Given valid messageDigestAlgorithm, cipherAlgorithm, and paddingAlgorithm constants
    When Signature.getInstance(messageDigestAlgorithm, cipherAlgorithm, paddingAlgorithm, externalAccess) is called
    Then a Signature instance implementing the composed algorithm is returned

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getInstance throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, getInstance](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getInstance(byte,boolean)
    Given an unsupported signature algorithm constant
    When Signature.getInstance(algorithm, externalAccess) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  # ---------------------------------------------------------------------------
  # Initialization
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.init initializes for signing or verification with a key
    # Source: [JavaCard 3.0.5 API, init](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#init(Key,byte)
    # Source: [JavaCard 3.1 API, init](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#init(Key,byte)
    # Source: [JavaCard 3.2 API, init](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#init(Key,byte)
    Given a Signature instance
    When init(theKey, theMode) is called with a valid Key and MODE_SIGN or MODE_VERIFY
    Then the signature object is initialized for the specified mode
    And CryptoException with ILLEGAL_VALUE is thrown if the key is incompatible
    And CryptoException with UNINITIALIZED_KEY is thrown if the key has not been initialized

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.init with IV initializes with additional initialization data
    # Source: [JavaCard 3.0.5 API, init](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#init(Key,byte,byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, init](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#init(Key,byte,byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, init](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#init(Key,byte,byte%5B%5D,short,short)
    Given a Signature instance
    When init(theKey, theMode, bArray, bOff, bLen) is called
    Then the signature object is initialized with key and IV data

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.setInitialDigest sets initial digest state
    # Source: [JavaCard 3.0.5 API, setInitialDigest](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#setInitialDigest(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, setInitialDigest](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#setInitialDigest(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, setInitialDigest](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#setInitialDigest(byte%5B%5D,short,short,byte%5B%5D,short,short)
    Given a Signature instance
    When setInitialDigest(state, stateOffset, stateLength, digestedMsgLenBuf, digestedMsgLenOffset, digestedMsgLenLength) is called
    Then the intermediate hash state is restored for continued signature computation

  # ---------------------------------------------------------------------------
  # Signing and verification
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.update accumulates data for signature computation
    # Source: [JavaCard 3.0.5 API, update](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#update(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, update](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#update(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, update](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#update(byte%5B%5D,short,short)
    Given an initialized Signature instance
    When update(inBuff, inOffset, inLength) is called
    Then the data is accumulated for the ongoing signature operation
    And CryptoException with INVALID_INIT is thrown if the signature object is not initialized

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.sign produces a signature over the accumulated data
    # Source: [JavaCard 3.0.5 API, sign](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#sign(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, sign](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#sign(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, sign](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#sign(byte%5B%5D,short,short,byte%5B%5D,short)
    Given an initialized Signature instance in MODE_SIGN
    When sign(inBuff, inOffset, inLength, sigBuff, sigOffset) is called
    Then the signature is computed over all accumulated data plus inBuff
    And the signature bytes are written to sigBuff at sigOffset
    And the number of signature bytes is returned
    And the Signature object is reset for a new operation

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.verify checks a signature against accumulated data
    # Source: [JavaCard 3.0.5 API, verify](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#verify(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, verify](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#verify(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, verify](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#verify(byte%5B%5D,short,short,byte%5B%5D,short,short)
    Given an initialized Signature instance in MODE_VERIFY
    When verify(inBuff, inOffset, inLength, sigBuff, sigOffset, sigLength) is called
    Then the signature is verified against the accumulated data plus inBuff
    And true is returned if the signature is valid, false otherwise
    And the Signature object is reset for a new operation

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.signPreComputedHash signs a pre-computed hash
    # Source: [JavaCard 3.0.5 API, signPreComputedHash](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#signPreComputedHash(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, signPreComputedHash](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#signPreComputedHash(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, signPreComputedHash](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#signPreComputedHash(byte%5B%5D,short,short,byte%5B%5D,short)
    Given an initialized Signature instance in MODE_SIGN
    When signPreComputedHash(hashBuff, hashOffset, hashLength, sigBuff, sigOffset) is called
    Then the signature is computed directly over the provided hash value
    And the signature bytes are returned

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.verifyPreComputedHash verifies against a pre-computed hash
    # Source: [JavaCard 3.0.5 API, verifyPreComputedHash](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#verifyPreComputedHash(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, verifyPreComputedHash](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#verifyPreComputedHash(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, verifyPreComputedHash](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#verifyPreComputedHash(byte%5B%5D,short,short,byte%5B%5D,short,short)
    Given an initialized Signature instance in MODE_VERIFY
    When verifyPreComputedHash(hashBuff, hashOffset, hashLength, sigBuff, sigOffset, sigLength) is called
    Then the signature is verified directly against the provided hash value
    And true is returned if valid, false otherwise

  # ---------------------------------------------------------------------------
  # Query methods
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getAlgorithm returns the legacy algorithm identifier
    # Source: [JavaCard 3.0.5 API, getAlgorithm](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getAlgorithm)
    # Source: [JavaCard 3.1 API, getAlgorithm](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getAlgorithm)
    # Source: [JavaCard 3.2 API, getAlgorithm](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getAlgorithm)
    Given a Signature instance
    When getAlgorithm() is called
    Then it returns the legacy ALG_ constant, or 0 if created with the decomposed factory

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getMessageDigestAlgorithm returns the digest component
    # Source: [JavaCard 3.0.5 API, getMessageDigestAlgorithm](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getMessageDigestAlgorithm)
    # Source: [JavaCard 3.1 API, getMessageDigestAlgorithm](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getMessageDigestAlgorithm)
    # Source: [JavaCard 3.2 API, getMessageDigestAlgorithm](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getMessageDigestAlgorithm)
    Given a Signature instance created with the decomposed factory
    When getMessageDigestAlgorithm() is called
    Then it returns the MessageDigest algorithm constant

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getCipherAlgorithm returns the cipher component
    # Source: [JavaCard 3.0.5 API, getCipherAlgorithm](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getCipherAlgorithm)
    # Source: [JavaCard 3.1 API, getCipherAlgorithm](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getCipherAlgorithm)
    # Source: [JavaCard 3.2 API, getCipherAlgorithm](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getCipherAlgorithm)
    Given a Signature instance created with the decomposed factory
    When getCipherAlgorithm() is called
    Then it returns the SIG_CIPHER_ constant

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getPaddingAlgorithm returns the padding component
    # Source: [JavaCard 3.0.5 API, getPaddingAlgorithm](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getPaddingAlgorithm)
    # Source: [JavaCard 3.1 API, getPaddingAlgorithm](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getPaddingAlgorithm)
    # Source: [JavaCard 3.2 API, getPaddingAlgorithm](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getPaddingAlgorithm)
    Given a Signature instance created with the decomposed factory
    When getPaddingAlgorithm() is called
    Then it returns the padding algorithm constant from javacardx.crypto.Cipher

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.getLength returns the signature output length
    # Source: [JavaCard 3.0.5 API, getLength](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#getLength)
    # Source: [JavaCard 3.1 API, getLength](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#getLength)
    # Source: [JavaCard 3.2 API, getLength](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#getLength)
    Given an initialized Signature instance
    When getLength() is called
    Then it returns the byte length of the signature output
    And CryptoException with INVALID_INIT is thrown if the object is not initialized

  # ---------------------------------------------------------------------------
  # SignatureMessageRecovery -- signatures with message recovery
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SignatureMessageRecovery provides signature with message recovery
    # Source: [JavaCard 3.0.5 API, SignatureMessageRecovery](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/SignatureMessageRecovery.html)
    # Source: [JavaCard 3.1 API, SignatureMessageRecovery](../../../.refs/javadoc-3.1/api_classic/javacard/security/SignatureMessageRecovery.html)
    # Source: [JavaCard 3.2 API, SignatureMessageRecovery](../../../.refs/javadoc-3.2/api_classic/javacard/security/SignatureMessageRecovery.html)
    Given the interface javacard.security.SignatureMessageRecovery is available
    Then it provides methods for signing and verifying with message recovery

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SignatureMessageRecovery.init initializes for signing or verification
    # Source: [JavaCard 3.0.5 API, init](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/SignatureMessageRecovery.html#init(Key,byte)
    # Source: [JavaCard 3.1 API, init](../../../.refs/javadoc-3.1/api_classic/javacard/security/SignatureMessageRecovery.html#init(Key,byte)
    # Source: [JavaCard 3.2 API, init](../../../.refs/javadoc-3.2/api_classic/javacard/security/SignatureMessageRecovery.html#init(Key,byte)
    Given a SignatureMessageRecovery instance
    When init(theKey, theMode) is called
    Then the object is initialized for sign or verify mode

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SignatureMessageRecovery.beginVerify starts verification with recovery
    # Source: [JavaCard 3.0.5 API, beginVerify](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/SignatureMessageRecovery.html#beginVerify(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, beginVerify](../../../.refs/javadoc-3.1/api_classic/javacard/security/SignatureMessageRecovery.html#beginVerify(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, beginVerify](../../../.refs/javadoc-3.2/api_classic/javacard/security/SignatureMessageRecovery.html#beginVerify(byte%5B%5D,short,short)
    Given a SignatureMessageRecovery instance initialized in MODE_VERIFY
    When beginVerify(sigAndRecDataBuff, buffOffset, sigLength) is called
    Then the recovered message bytes are returned in the buffer
    And the count of recovered bytes is returned

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SignatureMessageRecovery.sign produces a signature with message recovery
    # Source: [JavaCard 3.0.5 API, sign](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/SignatureMessageRecovery.html#sign(byte%5B%5D,short,short,byte%5B%5D,short,short%5B%5D,short)
    # Source: [JavaCard 3.1 API, sign](../../../.refs/javadoc-3.1/api_classic/javacard/security/SignatureMessageRecovery.html#sign(byte%5B%5D,short,short,byte%5B%5D,short,short%5B%5D,short)
    # Source: [JavaCard 3.2 API, sign](../../../.refs/javadoc-3.2/api_classic/javacard/security/SignatureMessageRecovery.html#sign(byte%5B%5D,short,short,byte%5B%5D,short,short%5B%5D,short)
    Given a SignatureMessageRecovery instance initialized in MODE_SIGN
    When sign(inBuff, inOffset, inLength, sigBuff, sigOffset, recMsgLen, recMsgLenOffset) is called
    Then the signature is produced
    And the recovered message length is stored in recMsgLen

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SignatureMessageRecovery.verify completes verification
    # Source: [JavaCard 3.0.5 API, verify](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/SignatureMessageRecovery.html#verify(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, verify](../../../.refs/javadoc-3.1/api_classic/javacard/security/SignatureMessageRecovery.html#verify(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, verify](../../../.refs/javadoc-3.2/api_classic/javacard/security/SignatureMessageRecovery.html#verify(byte%5B%5D,short,short)
    Given a SignatureMessageRecovery instance after beginVerify
    When verify(inBuff, inOffset, inLength) is called
    Then true is returned if the signature is valid, false otherwise

  # ---------------------------------------------------------------------------
  # Signature.OneShot -- transient one-shot signature
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.OneShot.open creates a transient one-shot Signature instance
    # Source: [JavaCard 3.0.5 API, open](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#open(byte,byte,byte)
    # Source: [JavaCard 3.1 API, open](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#open(byte,byte,byte)
    # Source: [JavaCard 3.2 API, open](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#open(byte,byte,byte)
    Given valid messageDigestAlgorithm, cipherAlgorithm, and paddingAlgorithm constants
    When Signature.OneShot.open(messageDigestAlgorithm, cipherAlgorithm, paddingAlgorithm) is called
    Then a transient Signature.OneShot instance is returned
    And internal storage is allocated in CLEAR_ON_RESET transient memory

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.OneShot.open throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, open](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#open(byte,byte,byte)
    # Source: [JavaCard 3.1 API, open](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#open(byte,byte,byte)
    # Source: [JavaCard 3.2 API, open](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#open(byte,byte,byte)
    Given an unsupported combination of digest, cipher, and padding
    When Signature.OneShot.open(messageDigestAlgorithm, cipherAlgorithm, paddingAlgorithm) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.OneShot.close releases the instance
    # Source: [JavaCard 3.0.5 API, close](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html#close)
    # Source: [JavaCard 3.1 API, close](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html#close)
    # Source: [JavaCard 3.2 API, close](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html#close)
    Given a Signature.OneShot instance
    When close() is called
    Then the instance is released for reuse
    And subsequent method calls throw CryptoException with ILLEGAL_USE

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Signature.OneShot provides full Signature operations
    # Source: [JavaCard 3.0.5 API, OneShot](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.1 API, OneShot](../../../.refs/javadoc-3.1/api_classic/javacard/security/Signature.html)
    # Source: [JavaCard 3.2 API, OneShot](../../../.refs/javadoc-3.2/api_classic/javacard/security/Signature.html)
    Given a Signature.OneShot instance
    Then the following methods are available:
      | method                                                                                                  |
      | init(Key theKey, byte theMode)                                                                          |
      | init(Key theKey, byte theMode, byte[] bArray, short bOff, short bLen)                                   |
      | setInitialDigest(byte[], short, short, byte[], short, short)                                            |
      | update(byte[] inBuff, short inOffset, short inLength)                                                   |
      | sign(byte[] inBuff, short inOffset, short inLength, byte[] sigBuff, short sigOffset)                    |
      | verify(byte[] inBuff, short inOffset, short inLength, byte[] sigBuff, short sigOffset, short sigLength) |
      | signPreComputedHash(byte[], short, short, byte[], short)                                                |
      | verifyPreComputedHash(byte[], short, short, byte[], short, short)                                       |
      | getAlgorithm()                                                                                          |
      | getMessageDigestAlgorithm()                                                                             |
      | getCipherAlgorithm()                                                                                    |
      | getPaddingAlgorithm()                                                                                   |
      | getLength()                                                                                             |
