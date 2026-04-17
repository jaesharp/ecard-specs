@v3.0.5
@v3.1
@v3.2
Feature: KeyBuilder -- Key object factory
  The KeyBuilder class is a key object factory. It provides static methods
  to build key objects for all supported cryptographic key types.

  Background:
    Given the class javacard.security.KeyBuilder is available

  # ---------------------------------------------------------------------------
  # Legacy TYPE_ constants for buildKey(byte, short, boolean)
  # ---------------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, KeyBuilder](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
  # Source: [JavaCard 3.1 API, KeyBuilder](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
  # Source: [JavaCard 3.2 API, KeyBuilder](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder DES key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: DES key types
      | constant                    | value | description                                      |
      | TYPE_DES_TRANSIENT_RESET    | 1     | DESKey with CLEAR_ON_RESET transient key data    |
      | TYPE_DES_TRANSIENT_DESELECT | 2     | DESKey with CLEAR_ON_DESELECT transient key data |
      | TYPE_DES                    | 3     | DESKey with persistent key data                  |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder RSA key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: RSA key types
      | constant                                | value | description                                                |
      | TYPE_RSA_PUBLIC                         | 4     | RSAPublicKey                                               |
      | TYPE_RSA_PRIVATE                        | 5     | RSAPrivateKey (modulus/exponent form)                      |
      | TYPE_RSA_CRT_PRIVATE                    | 6     | RSAPrivateCrtKey (Chinese Remainder Theorem form)          |
      | TYPE_RSA_PRIVATE_TRANSIENT_RESET        | 22    | RSAPrivateKey with CLEAR_ON_RESET transient key data       |
      | TYPE_RSA_PRIVATE_TRANSIENT_DESELECT     | 23    | RSAPrivateKey with CLEAR_ON_DESELECT transient key data    |
      | TYPE_RSA_CRT_PRIVATE_TRANSIENT_RESET    | 24    | RSAPrivateCrtKey with CLEAR_ON_RESET transient key data    |
      | TYPE_RSA_CRT_PRIVATE_TRANSIENT_DESELECT | 25    | RSAPrivateCrtKey with CLEAR_ON_DESELECT transient key data |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder DSA key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: DSA key types
      | constant                            | value | description                                             |
      | TYPE_DSA_PUBLIC                     | 7     | DSAPublicKey                                            |
      | TYPE_DSA_PRIVATE                    | 8     | DSAPrivateKey                                           |
      | TYPE_DSA_PRIVATE_TRANSIENT_RESET    | 26    | DSAPrivateKey with CLEAR_ON_RESET transient key data    |
      | TYPE_DSA_PRIVATE_TRANSIENT_DESELECT | 27    | DSAPrivateKey with CLEAR_ON_DESELECT transient key data |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder EC F2M key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: EC F2M key types
      | constant                               | value | description                                                 |
      | TYPE_EC_F2M_PUBLIC                     | 9     | ECPublicKey for operations over fields of characteristic 2  |
      | TYPE_EC_F2M_PRIVATE                    | 10    | ECPrivateKey for operations over fields of characteristic 2 |
      | TYPE_EC_F2M_PRIVATE_TRANSIENT_RESET    | 28    | ECPrivateKey F2M with CLEAR_ON_RESET transient key data     |
      | TYPE_EC_F2M_PRIVATE_TRANSIENT_DESELECT | 29    | ECPrivateKey F2M with CLEAR_ON_DESELECT transient key data  |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder EC FP key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: EC FP key types
      | constant                              | value | description                                               |
      | TYPE_EC_FP_PUBLIC                     | 11    | ECPublicKey for operations over large prime fields        |
      | TYPE_EC_FP_PRIVATE                    | 12    | ECPrivateKey for operations over large prime fields       |
      | TYPE_EC_FP_PRIVATE_TRANSIENT_RESET    | 30    | ECPrivateKey FP with CLEAR_ON_RESET transient key data    |
      | TYPE_EC_FP_PRIVATE_TRANSIENT_DESELECT | 31    | ECPrivateKey FP with CLEAR_ON_DESELECT transient key data |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder AES key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: AES key types
      | constant                    | value | description                                      |
      | TYPE_AES_TRANSIENT_RESET    | 13    | AESKey with CLEAR_ON_RESET transient key data    |
      | TYPE_AES_TRANSIENT_DESELECT | 14    | AESKey with CLEAR_ON_DESELECT transient key data |
      | TYPE_AES                    | 15    | AESKey with persistent key data                  |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder Korean SEED key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Korean SEED key types
      | constant                            | value | description                                             |
      | TYPE_KOREAN_SEED_TRANSIENT_RESET    | 16    | KoreanSEEDKey with CLEAR_ON_RESET transient key data    |
      | TYPE_KOREAN_SEED_TRANSIENT_DESELECT | 17    | KoreanSEEDKey with CLEAR_ON_DESELECT transient key data |
      | TYPE_KOREAN_SEED                    | 18    | KoreanSEEDKey with persistent key data                  |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder HMAC key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: HMAC key types
      | constant                     | value | description                                       |
      | TYPE_HMAC_TRANSIENT_RESET    | 19    | HMACKey with CLEAR_ON_RESET transient key data    |
      | TYPE_HMAC_TRANSIENT_DESELECT | 20    | HMACKey with CLEAR_ON_DESELECT transient key data |
      | TYPE_HMAC                    | 21    | HMACKey with persistent key data                  |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder DH key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: DH key types
      | constant                           | value | description                                            |
      | TYPE_DH_PUBLIC                     | 32    | DHPublicKey for DH operations                          |
      | TYPE_DH_PUBLIC_TRANSIENT_DESELECT  | 33    | DHPublicKey with CLEAR_ON_DESELECT transient key data  |
      | TYPE_DH_PUBLIC_TRANSIENT_RESET     | 34    | DHPublicKey with CLEAR_ON_RESET transient key data     |
      | TYPE_DH_PRIVATE                    | 35    | DHPrivateKey for DH operations                         |
      | TYPE_DH_PRIVATE_TRANSIENT_DESELECT | 36    | DHPrivateKey with CLEAR_ON_DESELECT transient key data |
      | TYPE_DH_PRIVATE_TRANSIENT_RESET    | 37    | DHPrivateKey with CLEAR_ON_RESET transient key data    |

  # ---------------------------------------------------------------------------
  # TYPE_ constants added in 3.1
  # ---------------------------------------------------------------------------
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder TYPE_ constants added in version 3.1
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Domain parameter and new key types since 3.1
      | constant               | value | description                                              |
      | TYPE_DH_PARAMETERS     | 38    | DH domain parameter key for buildKeyWithSharedDomain     |
      | TYPE_DSA_PARAMETERS    | 39    | DSA domain parameter key for buildKeyWithSharedDomain    |
      | TYPE_EC_F2M_PARAMETERS | 40    | EC F2M domain parameter key for buildKeyWithSharedDomain |
      | TYPE_EC_FP_PARAMETERS  | 41    | EC FP domain parameter key for buildKeyWithSharedDomain  |
      | TYPE_GENERIC_SECRET    | 42    | GenericSecretKey with persistent key data                |
      | TYPE_SM4               | 43    | SM4Key with persistent key data                          |
      | TYPE_XEC               | -1    | XECKey (returned by getType for XEC keys)                |

  # ---------------------------------------------------------------------------
  # ALG_TYPE_ constants for buildKey(byte, byte, short, boolean)
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder ALG_TYPE_ algorithmic key type constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>
    And it is used as the algorithmicKeyType parameter of buildKey(byte, byte, short, boolean)

    Examples: Algorithmic key types (present since 3.0.5)
      | constant                   | value |
      | ALG_TYPE_DES               | 1     |
      | ALG_TYPE_AES               | 2     |
      | ALG_TYPE_DSA_PUBLIC        | 3     |
      | ALG_TYPE_DSA_PRIVATE       | 4     |
      | ALG_TYPE_EC_F2M_PUBLIC     | 5     |
      | ALG_TYPE_EC_F2M_PRIVATE    | 6     |
      | ALG_TYPE_EC_FP_PUBLIC      | 7     |
      | ALG_TYPE_EC_FP_PRIVATE     | 8     |
      | ALG_TYPE_HMAC              | 9     |
      | ALG_TYPE_KOREAN_SEED       | 10    |
      | ALG_TYPE_RSA_PUBLIC        | 11    |
      | ALG_TYPE_RSA_PRIVATE       | 12    |
      | ALG_TYPE_RSA_CRT_PRIVATE   | 13    |
      | ALG_TYPE_DH_PUBLIC         | 14    |
      | ALG_TYPE_DH_PRIVATE        | 15    |
      | ALG_TYPE_EC_F2M_PARAMETERS | 16    |
      | ALG_TYPE_EC_FP_PARAMETERS  | 17    |
      | ALG_TYPE_DSA_PARAMETERS    | 18    |
      | ALG_TYPE_DH_PARAMETERS     | 19    |

  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder ALG_TYPE_ constants added in version 3.1
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type byte has value <value>

    Examples: Algorithmic key types since 3.1
      | constant                | value |
      | ALG_TYPE_GENERIC_SECRET | 20    |
      | ALG_TYPE_SM4            | 21    |

  # ---------------------------------------------------------------------------
  # XEC key attributes (added in 3.1)
  # ---------------------------------------------------------------------------
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder XEC key attribute constants
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And it designates "<description>"

    Examples: XEC key attributes
      | constant     | value  | description                             |
      | ATTR_PUBLIC  | 0      | Attribute for creating an XECPublicKey  |
      | ATTR_PRIVATE | -32768 | Attribute for creating an XECPrivateKey |

  # ---------------------------------------------------------------------------
  # Key length constants
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder DES key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value represents the key size in bits

    Examples: DES key lengths
      | constant         | value |
      | LENGTH_DES       | 64    |
      | LENGTH_DES3_2KEY | 128   |
      | LENGTH_DES3_3KEY | 192   |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder RSA key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value represents the key size in bits

    Examples: RSA key lengths
      | constant        | value |
      | LENGTH_RSA_512  | 512   |
      | LENGTH_RSA_736  | 736   |
      | LENGTH_RSA_768  | 768   |
      | LENGTH_RSA_896  | 896   |
      | LENGTH_RSA_1024 | 1024  |
      | LENGTH_RSA_1280 | 1280  |
      | LENGTH_RSA_1536 | 1536  |
      | LENGTH_RSA_1984 | 1984  |
      | LENGTH_RSA_2048 | 2048  |
      | LENGTH_RSA_3072 | 3072  |
      | LENGTH_RSA_4096 | 4096  |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder DSA key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value represents the key size in bits

    Examples: DSA key lengths
      | constant        | value |
      | LENGTH_DSA_512  | 512   |
      | LENGTH_DSA_768  | 768   |
      | LENGTH_DSA_1024 | 1024  |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder EC FP key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value represents the key size in bits

    Examples: EC prime field key lengths
      | constant         | value |
      | LENGTH_EC_FP_112 | 112   |
      | LENGTH_EC_FP_128 | 128   |
      | LENGTH_EC_FP_160 | 160   |
      | LENGTH_EC_FP_192 | 192   |
      | LENGTH_EC_FP_224 | 224   |
      | LENGTH_EC_FP_256 | 256   |
      | LENGTH_EC_FP_384 | 384   |
      | LENGTH_EC_FP_521 | 521   |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder EC F2M key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value represents the key size in bits

    Examples: EC binary field key lengths
      | constant          | value |
      | LENGTH_EC_F2M_113 | 113   |
      | LENGTH_EC_F2M_131 | 131   |
      | LENGTH_EC_F2M_163 | 163   |
      | LENGTH_EC_F2M_193 | 193   |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder AES key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value represents the key size in bits

    Examples: AES key lengths (present since 3.0.5)
      | constant       | value |
      | LENGTH_AES_128 | 128   |
      | LENGTH_AES_192 | 192   |
      | LENGTH_AES_256 | 256   |

  @v3.1
  @v3.2
  Scenario: KeyBuilder LENGTH_AES_512 constant added in version 3.1
    # Source: [JavaCard 3.1 API, LENGTH_AES_512](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, LENGTH_AES_512](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "LENGTH_AES_512" of type short has value 512
    And it represents a key made of two AES-256 keys

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyBuilder LENGTH_KOREAN_SEED_128 constant
    # Source: [JavaCard 3.0.5 API, LENGTH_KOREAN_SEED_128](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, LENGTH_KOREAN_SEED_128](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, LENGTH_KOREAN_SEED_128](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "LENGTH_KOREAN_SEED_128" of type short has value 128

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder HMAC key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value is expressed in bytes (block size of the underlying hash)

    Examples: HMAC key lengths
      | constant                      | value |
      | LENGTH_HMAC_SHA_1_BLOCK_64    | 64    |
      | LENGTH_HMAC_SHA_256_BLOCK_64  | 64    |
      | LENGTH_HMAC_SHA_384_BLOCK_128 | 128   |
      | LENGTH_HMAC_SHA_512_BLOCK_128 | 128   |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyBuilder DH key length constants
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "<constant>" of type short has value <value>
    And the value represents the key size in bits

    Examples: DH key lengths
      | constant       | value |
      | LENGTH_DH_1024 | 1024  |
      | LENGTH_DH_2048 | 2048  |

  @v3.1
  @v3.2
  Scenario: KeyBuilder LENGTH_SM4 constant added in version 3.1
    # Source: [JavaCard 3.1 API, LENGTH_SM4](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html)
    # Source: [JavaCard 3.2 API, LENGTH_SM4](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html)
    Then the static field "LENGTH_SM4" of type short has value 128
    And it represents the SM4 key size in bits

  # ---------------------------------------------------------------------------
  # Factory methods
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildKey(byte, short, boolean) creates a legacy key object
    # Source: [JavaCard 3.0.5 API, buildKey](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,short,boolean)
    # Source: [JavaCard 3.1 API, buildKey](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,short,boolean)
    # Source: [JavaCard 3.2 API, buildKey](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,short,boolean)
    Given a valid TYPE_ constant and key length
    When KeyBuilder.buildKey(keyType, keyLength, keyEncryption) is called
    Then a Key object of the specified type and length is returned
    And if keyEncryption is true, the key implements javacardx.crypto.KeyEncryption

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildKey(byte, short, boolean) throws for unsupported type/length
    # Source: [JavaCard 3.0.5 API, buildKey](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,short,boolean)
    # Source: [JavaCard 3.1 API, buildKey](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,short,boolean)
    # Source: [JavaCard 3.2 API, buildKey](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,short,boolean)
    Given an unsupported key type or key length
    When KeyBuilder.buildKey(keyType, keyLength, keyEncryption) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildKey(byte, byte, short, boolean) creates a key with memory type
    # Source: [JavaCard 3.0.5 API, buildKey](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,byte,short,boolean)
    # Source: [JavaCard 3.1 API, buildKey](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,byte,short,boolean)
    # Source: [JavaCard 3.2 API, buildKey](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,byte,short,boolean)
    Given a valid ALG_TYPE_ constant and memory type
    When KeyBuilder.buildKey(algorithmicKeyType, keyMemoryType, keyLength, keyEncryption) is called
    Then a Key object of the specified algorithmic type with the specified memory type is returned
    And the memory type controls whether key data is persistent or transient

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildKey(byte, byte, short, boolean) throws for unsupported combination
    # Source: [JavaCard 3.0.5 API, buildKey](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,byte,short,boolean)
    # Source: [JavaCard 3.1 API, buildKey](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,byte,short,boolean)
    # Source: [JavaCard 3.2 API, buildKey](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#buildKey(byte,byte,short,boolean)
    Given an unsupported algorithmic key type, memory type, or key length combination
    When KeyBuilder.buildKey(algorithmicKeyType, keyMemoryType, keyLength, keyEncryption) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildXECKey creates an XEC key object
    # Source: [JavaCard 3.1 API, buildXECKey](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#buildXECKey(NamedParameterSpec,short,boolean)
    # Source: [JavaCard 3.2 API, buildXECKey](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#buildXECKey(NamedParameterSpec,short,boolean)
    Given a valid NamedParameterSpec for an XEC curve (e.g., X25519, Ed25519)
    And attributes set to ATTR_PUBLIC or ATTR_PRIVATE combined with a memory type
    When KeyBuilder.buildXECKey(params, attributes, keyEncryption) is called
    Then an XECKey (XECPublicKey or XECPrivateKey) is returned for the specified curve

  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildXECKey throws for unsupported curve
    # Source: [JavaCard 3.1 API, buildXECKey](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#buildXECKey(NamedParameterSpec,short,boolean)
    # Source: [JavaCard 3.2 API, buildXECKey](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#buildXECKey(NamedParameterSpec,short,boolean)
    Given an unsupported NamedParameterSpec
    When KeyBuilder.buildXECKey(params, attributes, keyEncryption) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildKeyWithSharedDomain creates a key sharing domain parameters
    # Source: [JavaCard 3.1 API, buildKeyWithSharedDomain](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#buildKeyWithSharedDomain(byte,byte,Key,boolean)
    # Source: [JavaCard 3.2 API, buildKeyWithSharedDomain](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#buildKeyWithSharedDomain(byte,byte,Key,boolean)
    Given a valid ALG_TYPE_ constant and a domain parameter key
    When KeyBuilder.buildKeyWithSharedDomain(algorithmicKeyType, keyMemoryType, domainParameters, keyEncryption) is called
    Then a Key object is returned that shares domain parameters with the provided key

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyBuilder.getMemoryType returns the memory type of a key
    # Source: [JavaCard 3.0.5 API, getMemoryType](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyBuilder.html#getMemoryType(Key)
    # Source: [JavaCard 3.1 API, getMemoryType](../../../refs/javadoc-3.1/api_classic/javacard/security/KeyBuilder.html#getMemoryType(Key)
    # Source: [JavaCard 3.2 API, getMemoryType](../../../refs/javadoc-3.2/api_classic/javacard/security/KeyBuilder.html#getMemoryType(Key)
    Given a Key object
    When KeyBuilder.getMemoryType(key) is called
    Then the memory type byte is returned indicating persistent, CLEAR_ON_RESET, or CLEAR_ON_DESELECT
