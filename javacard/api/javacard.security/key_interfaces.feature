@v3.0.5 @v3.1 @v3.2
Feature: Key interfaces -- Cryptographic key type hierarchy
  The javacard.security package defines a hierarchy of key interfaces for
  all supported cryptographic key types. Key is the root interface; SecretKey,
  PublicKey, and PrivateKey are the main sub-interfaces. Algorithm-specific
  interfaces extend these for RSA, EC, DSA, DH, AES, DES, HMAC, and others.


  # ===========================================================================
  # Key -- root interface
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, security ](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security#security(keyinterfaces)
  # Source: [JavaCard 3.1 API, security ](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security#security(keyinterfaces)
  # Source: [JavaCard 3.2 API, security ](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security#security(keyinterfaces)
  Scenario: Key interface defines base key operations
    # Source: [JavaCard 3.0.5 API, Key](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Key.html)
    # Source: [JavaCard 3.1 API, Key](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/Key.html)
    # Source: [JavaCard 3.2 API, Key](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/Key.html)
    Given the interface javacard.security.Key is available
    Then the following methods are defined:
      | method              | return_type | description                                        |
      | isInitialized()     | boolean     | Reports whether the key has been initialized        |
      | clearKey()          | void        | Clears the key data and resets initialization state |
      | getType()           | byte        | Returns the key type (KeyBuilder TYPE_ constant)    |
      | getSize()           | short       | Returns the key size in bits                        |

  # ===========================================================================
  # Marker interfaces: SecretKey, PublicKey, PrivateKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: SecretKey is a marker interface extending Key
    # Source: [JavaCard 3.0.5 API, SecretKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/SecretKey.html)
    # Source: [JavaCard 3.1 API, SecretKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/SecretKey.html)
    # Source: [JavaCard 3.2 API, SecretKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/SecretKey.html)
    Given the interface javacard.security.SecretKey is available
    Then it extends javacard.security.Key
    And it defines no additional methods

  @v3.0.5 @v3.1 @v3.2
  Scenario: PublicKey is a marker interface extending Key
    # Source: [JavaCard 3.0.5 API, PublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/PublicKey.html)
    # Source: [JavaCard 3.1 API, PublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/PublicKey.html)
    # Source: [JavaCard 3.2 API, PublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/PublicKey.html)
    Given the interface javacard.security.PublicKey is available
    Then it extends javacard.security.Key
    And it defines no additional methods

  @v3.0.5 @v3.1 @v3.2
  Scenario: PrivateKey is a marker interface extending Key
    # Source: [JavaCard 3.0.5 API, PrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/PrivateKey.html)
    # Source: [JavaCard 3.1 API, PrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/PrivateKey.html)
    # Source: [JavaCard 3.2 API, PrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/PrivateKey.html)
    Given the interface javacard.security.PrivateKey is available
    Then it extends javacard.security.Key
    And it defines no additional methods

  # ===========================================================================
  # AESKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: AESKey extends SecretKey with key data accessors
    # Source: [JavaCard 3.0.5 API, AESKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/AESKey.html)
    # Source: [JavaCard 3.1 API, AESKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/AESKey.html)
    # Source: [JavaCard 3.2 API, AESKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/AESKey.html)
    Given the interface javacard.security.AESKey is available
    Then it extends javacard.security.SecretKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: AESKey.setKey sets the AES key data
    # Source: [JavaCard 3.0.5 API, setKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/AESKey.html#setKey(byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, setKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/AESKey.html#setKey(byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, setKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/AESKey.html#setKey(byte%5B%5D,short)
    Given an AESKey instance
    When setKey(keyData, kOff) is called
    Then the key data is set from the buffer and the key becomes initialized
    And CryptoException with ILLEGAL_VALUE is thrown if the input length does not match key size
    And CryptoException with ILLEGAL_USE is thrown if the key data is weak or semi-weak (DES)

  @v3.0.5 @v3.1 @v3.2
  Scenario: AESKey.getKey retrieves the AES key data
    # Source: [JavaCard 3.0.5 API, getKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/AESKey.html#getKey(byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, getKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/AESKey.html#getKey(byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, getKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/AESKey.html#getKey(byte%5B%5D,short)
    Given an initialized AESKey instance
    When getKey(keyData, kOff) is called
    Then the key data is copied to the buffer
    And the byte length of the key data is returned
    And CryptoException with UNINITIALIZED_KEY is thrown if the key is not initialized

  # ===========================================================================
  # DESKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: DESKey extends SecretKey with key data accessors
    # Source: [JavaCard 3.0.5 API, DESKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DESKey.html)
    # Source: [JavaCard 3.1 API, DESKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DESKey.html)
    # Source: [JavaCard 3.2 API, DESKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DESKey.html)
    Given the interface javacard.security.DESKey is available
    Then it extends javacard.security.SecretKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: DESKey.setKey sets the DES key data
    # Source: [JavaCard 3.0.5 API, setKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DESKey.html#setKey(byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, setKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DESKey.html#setKey(byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, setKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DESKey.html#setKey(byte%5B%5D,short)
    Given a DESKey instance
    When setKey(keyData, kOff) is called
    Then the key data is set from the buffer and the key becomes initialized

  @v3.0.5 @v3.1 @v3.2
  Scenario: DESKey.getKey retrieves the DES key data
    # Source: [JavaCard 3.0.5 API, getKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DESKey.html#getKey(byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, getKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DESKey.html#getKey(byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, getKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DESKey.html#getKey(byte%5B%5D,short)
    Given an initialized DESKey instance
    When getKey(keyData, kOff) is called
    Then the key data is copied to the buffer
    And the byte length of the key data is returned

  # ===========================================================================
  # RSAPublicKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: RSAPublicKey extends PublicKey with modulus and exponent accessors
    # Source: [JavaCard 3.0.5 API, RSAPublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RSAPublicKey.html)
    # Source: [JavaCard 3.1 API, RSAPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RSAPublicKey.html)
    # Source: [JavaCard 3.2 API, RSAPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RSAPublicKey.html)
    Given the interface javacard.security.RSAPublicKey is available
    Then it extends javacard.security.PublicKey

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: RSAPublicKey getter and setter methods
    # Source: [JavaCard 3.0.5 API, <method>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RSAPublicKey.html)
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RSAPublicKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RSAPublicKey.html)
    Given an RSAPublicKey instance
    Then the method "<method>" is available with signature "<signature>"

    Examples: RSAPublicKey methods
      | method       | signature                                                        |
      | setModulus   | void setModulus(byte[] buffer, short offset, short length)        |
      | setExponent  | void setExponent(byte[] buffer, short offset, short length)      |
      | getModulus   | short getModulus(byte[] buffer, short offset)                     |
      | getExponent  | short getExponent(byte[] buffer, short offset)                   |

  # ===========================================================================
  # RSAPrivateKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: RSAPrivateKey extends PrivateKey with modulus/exponent form
    # Source: [JavaCard 3.0.5 API, RSAPrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RSAPrivateKey.html)
    # Source: [JavaCard 3.1 API, RSAPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RSAPrivateKey.html)
    # Source: [JavaCard 3.2 API, RSAPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RSAPrivateKey.html)
    Given the interface javacard.security.RSAPrivateKey is available
    Then it extends javacard.security.PrivateKey

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: RSAPrivateKey getter and setter methods
    # Source: [JavaCard 3.0.5 API, <method>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RSAPrivateKey.html)
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RSAPrivateKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RSAPrivateKey.html)
    Given an RSAPrivateKey instance
    Then the method "<method>" is available with signature "<signature>"

    Examples: RSAPrivateKey methods
      | method       | signature                                                        |
      | setModulus   | void setModulus(byte[] buffer, short offset, short length)        |
      | setExponent  | void setExponent(byte[] buffer, short offset, short length)      |
      | getModulus   | short getModulus(byte[] buffer, short offset)                     |
      | getExponent  | short getExponent(byte[] buffer, short offset)                   |

  # ===========================================================================
  # RSAPrivateCrtKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: RSAPrivateCrtKey extends PrivateKey with CRT components
    # Source: [JavaCard 3.0.5 API, RSAPrivateCrtKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RSAPrivateCrtKey.html)
    # Source: [JavaCard 3.1 API, RSAPrivateCrtKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RSAPrivateCrtKey.html)
    # Source: [JavaCard 3.2 API, RSAPrivateCrtKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RSAPrivateCrtKey.html)
    Given the interface javacard.security.RSAPrivateCrtKey is available
    Then it extends javacard.security.PrivateKey

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: RSAPrivateCrtKey getter and setter methods for CRT components
    # Source: [JavaCard 3.0.5 API, <method>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RSAPrivateCrtKey.html)
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RSAPrivateCrtKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RSAPrivateCrtKey.html)
    Given an RSAPrivateCrtKey instance
    Then the method "<method>" is available with signature "<signature>"

    Examples: RSAPrivateCrtKey CRT component methods
      | method  | signature                                                     |
      | setP    | void setP(byte[] buffer, short offset, short length)           |
      | setQ    | void setQ(byte[] buffer, short offset, short length)           |
      | setDP1  | void setDP1(byte[] buffer, short offset, short length)         |
      | setDQ1  | void setDQ1(byte[] buffer, short offset, short length)         |
      | setPQ   | void setPQ(byte[] buffer, short offset, short length)          |
      | getP    | short getP(byte[] buffer, short offset)                        |
      | getQ    | short getQ(byte[] buffer, short offset)                        |
      | getDP1  | short getDP1(byte[] buffer, short offset)                      |
      | getDQ1  | short getDQ1(byte[] buffer, short offset)                      |
      | getPQ   | short getPQ(byte[] buffer, short offset)                       |

  # ===========================================================================
  # ECKey (shared domain parameters for EC keys)
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: ECKey defines EC domain parameter accessors
    # Source: [JavaCard 3.0.5 API, ECKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECKey.html)
    # Source: [JavaCard 3.1 API, ECKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECKey.html)
    # Source: [JavaCard 3.2 API, ECKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECKey.html)
    Given the interface javacard.security.ECKey is available
    Then it is used by both ECPublicKey and ECPrivateKey

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: ECKey domain parameter setter methods
    # Source: [JavaCard 3.0.5 API, <method>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECKey.html)
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECKey.html)
    Given an ECKey instance
    Then the setter method "<method>" is available with signature "<signature>"

    Examples: ECKey domain parameter setters
      | method         | signature                                                          |
      | setFieldFP     | void setFieldFP(byte[] buffer, short offset, short length)          |
      | setFieldF2M    | void setFieldF2M(short e)                                          |
      | setFieldF2M    | void setFieldF2M(short e1, short e2, short e3)                     |
      | setA           | void setA(byte[] buffer, short offset, short length)                |
      | setB           | void setB(byte[] buffer, short offset, short length)                |
      | setG           | void setG(byte[] buffer, short offset, short length)                |
      | setR           | void setR(byte[] buffer, short offset, short length)                |
      | setK           | void setK(short K)                                                  |

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: ECKey domain parameter getter methods
    # Source: [JavaCard 3.0.5 API, <method>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECKey.html)
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECKey.html)
    Given an ECKey instance
    Then the getter method "<method>" is available with signature "<signature>"

    Examples: ECKey domain parameter getters
      | method   | signature                                                |
      | getField | short getField(byte[] buffer, short offset)               |
      | getA     | short getA(byte[] buffer, short offset)                   |
      | getB     | short getB(byte[] buffer, short offset)                   |
      | getG     | short getG(byte[] buffer, short offset)                   |
      | getR     | short getR(byte[] buffer, short offset)                   |
      | getK     | short getK()                                              |

  @v3.0.5 @v3.1 @v3.2
  Scenario: ECKey.copyDomainParametersFrom copies domain parameters from another key
    # Source: [JavaCard 3.0.5 API, copyDomainParametersFrom](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECKey.html#copyDomainParametersFrom(ECKey)
    # Source: [JavaCard 3.1 API, copyDomainParametersFrom](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECKey.html#copyDomainParametersFrom(ECKey)
    # Source: [JavaCard 3.2 API, copyDomainParametersFrom](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECKey.html#copyDomainParametersFrom(ECKey)
    Given an ECKey instance
    When copyDomainParametersFrom(ecKey) is called with another ECKey
    Then the domain parameters (field, A, B, G, R, K) are copied from the source key

  # ===========================================================================
  # ECPublicKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: ECPublicKey extends PublicKey and ECKey with public point accessor
    # Source: [JavaCard 3.0.5 API, ECPublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECPublicKey.html)
    # Source: [JavaCard 3.1 API, ECPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECPublicKey.html)
    # Source: [JavaCard 3.2 API, ECPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECPublicKey.html)
    Given the interface javacard.security.ECPublicKey is available
    Then it extends javacard.security.PublicKey and javacard.security.ECKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: ECPublicKey.setW and getW access the public point W
    # Source: [JavaCard 3.0.5 API, ECPublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECPublicKey.html)
    # Source: [JavaCard 3.1 API, ECPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECPublicKey.html)
    # Source: [JavaCard 3.2 API, ECPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECPublicKey.html)
    Given an ECPublicKey instance
    Then setW(byte[] buffer, short offset, short length) sets the public point W
    And getW(byte[] buffer, short offset) retrieves the public point W

  # ===========================================================================
  # ECPrivateKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: ECPrivateKey extends PrivateKey and ECKey with secret scalar accessor
    # Source: [JavaCard 3.0.5 API, ECPrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECPrivateKey.html)
    # Source: [JavaCard 3.1 API, ECPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECPrivateKey.html)
    # Source: [JavaCard 3.2 API, ECPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECPrivateKey.html)
    Given the interface javacard.security.ECPrivateKey is available
    Then it extends javacard.security.PrivateKey and javacard.security.ECKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: ECPrivateKey.setS and getS access the secret scalar S
    # Source: [JavaCard 3.0.5 API, ECPrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/ECPrivateKey.html)
    # Source: [JavaCard 3.1 API, ECPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/ECPrivateKey.html)
    # Source: [JavaCard 3.2 API, ECPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/ECPrivateKey.html)
    Given an ECPrivateKey instance
    Then setS(byte[] buffer, short offset, short length) sets the secret scalar S
    And getS(byte[] buffer, short offset) retrieves the secret scalar S

  # ===========================================================================
  # DSAKey (shared domain parameters for DSA keys)
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: DSAKey defines DSA domain parameter accessors
    # Source: [JavaCard 3.0.5 API, DSAKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DSAKey.html)
    # Source: [JavaCard 3.1 API, DSAKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DSAKey.html)
    # Source: [JavaCard 3.2 API, DSAKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DSAKey.html)
    Given the interface javacard.security.DSAKey is available
    Then it is used by both DSAPublicKey and DSAPrivateKey

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: DSAKey domain parameter methods
    # Source: [JavaCard 3.0.5 API, <method>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DSAKey.html)
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DSAKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DSAKey.html)
    Given a DSAKey instance
    Then the method "<method>" is available with signature "<signature>"

    Examples: DSAKey domain parameter methods
      | method | signature                                                   |
      | setP   | void setP(byte[] buffer, short offset, short length)         |
      | setQ   | void setQ(byte[] buffer, short offset, short length)         |
      | setG   | void setG(byte[] buffer, short offset, short length)         |
      | getP   | short getP(byte[] buffer, short offset)                      |
      | getQ   | short getQ(byte[] buffer, short offset)                      |
      | getG   | short getG(byte[] buffer, short offset)                      |

  # ===========================================================================
  # DSAPublicKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: DSAPublicKey extends PublicKey and DSAKey
    # Source: [JavaCard 3.0.5 API, DSAPublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DSAPublicKey.html)
    # Source: [JavaCard 3.1 API, DSAPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DSAPublicKey.html)
    # Source: [JavaCard 3.2 API, DSAPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DSAPublicKey.html)
    Given the interface javacard.security.DSAPublicKey is available
    Then it extends javacard.security.PublicKey and javacard.security.DSAKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: DSAPublicKey.setY and getY access the public value Y
    # Source: [JavaCard 3.0.5 API, DSAPublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DSAPublicKey.html)
    # Source: [JavaCard 3.1 API, DSAPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DSAPublicKey.html)
    # Source: [JavaCard 3.2 API, DSAPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DSAPublicKey.html)
    Given a DSAPublicKey instance
    Then setY(byte[] buffer, short offset, short length) sets the public value Y
    And getY(byte[] buffer, short offset) retrieves the public value Y

  # ===========================================================================
  # DSAPrivateKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: DSAPrivateKey extends PrivateKey and DSAKey
    # Source: [JavaCard 3.0.5 API, DSAPrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DSAPrivateKey.html)
    # Source: [JavaCard 3.1 API, DSAPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DSAPrivateKey.html)
    # Source: [JavaCard 3.2 API, DSAPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DSAPrivateKey.html)
    Given the interface javacard.security.DSAPrivateKey is available
    Then it extends javacard.security.PrivateKey and javacard.security.DSAKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: DSAPrivateKey.setX and getX access the private value X
    # Source: [JavaCard 3.0.5 API, DSAPrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DSAPrivateKey.html)
    # Source: [JavaCard 3.1 API, DSAPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DSAPrivateKey.html)
    # Source: [JavaCard 3.2 API, DSAPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DSAPrivateKey.html)
    Given a DSAPrivateKey instance
    Then setX(byte[] buffer, short offset, short length) sets the private value X
    And getX(byte[] buffer, short offset) retrieves the private value X

  # ===========================================================================
  # DHKey (shared domain parameters for DH keys)
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: DHKey defines DH domain parameter accessors
    # Source: [JavaCard 3.0.5 API, DHKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DHKey.html)
    # Source: [JavaCard 3.1 API, DHKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DHKey.html)
    # Source: [JavaCard 3.2 API, DHKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DHKey.html)
    Given the interface javacard.security.DHKey is available
    Then it is used by both DHPublicKey and DHPrivateKey

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: DHKey domain parameter methods
    # Source: [JavaCard 3.0.5 API, <method>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DHKey.html)
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DHKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DHKey.html)
    Given a DHKey instance
    Then the method "<method>" is available with signature "<signature>"

    Examples: DHKey domain parameter methods
      | method | signature                                                   |
      | setP   | void setP(byte[] buffer, short offset, short length)         |
      | setQ   | void setQ(byte[] buffer, short offset, short length)         |
      | setG   | void setG(byte[] buffer, short offset, short length)         |
      | getP   | short getP(byte[] buffer, short offset)                      |
      | getQ   | short getQ(byte[] buffer, short offset)                      |
      | getG   | short getG(byte[] buffer, short offset)                      |

  # ===========================================================================
  # DHPublicKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: DHPublicKey extends PublicKey and DHKey
    # Source: [JavaCard 3.0.5 API, DHPublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DHPublicKey.html)
    # Source: [JavaCard 3.1 API, DHPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DHPublicKey.html)
    # Source: [JavaCard 3.2 API, DHPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DHPublicKey.html)
    Given the interface javacard.security.DHPublicKey is available
    Then it extends javacard.security.PublicKey and javacard.security.DHKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: DHPublicKey.setY and getY access the public value Y
    # Source: [JavaCard 3.0.5 API, DHPublicKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DHPublicKey.html)
    # Source: [JavaCard 3.1 API, DHPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DHPublicKey.html)
    # Source: [JavaCard 3.2 API, DHPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DHPublicKey.html)
    Given a DHPublicKey instance
    Then setY(byte[] buffer, short offset, short length) sets the public value Y
    And getY(byte[] buffer, short offset) retrieves the public value Y

  # ===========================================================================
  # DHPrivateKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: DHPrivateKey extends PrivateKey and DHKey
    # Source: [JavaCard 3.0.5 API, DHPrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DHPrivateKey.html)
    # Source: [JavaCard 3.1 API, DHPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DHPrivateKey.html)
    # Source: [JavaCard 3.2 API, DHPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DHPrivateKey.html)
    Given the interface javacard.security.DHPrivateKey is available
    Then it extends javacard.security.PrivateKey and javacard.security.DHKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: DHPrivateKey.setX and getX access the private value X
    # Source: [JavaCard 3.0.5 API, DHPrivateKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/DHPrivateKey.html)
    # Source: [JavaCard 3.1 API, DHPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/DHPrivateKey.html)
    # Source: [JavaCard 3.2 API, DHPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/DHPrivateKey.html)
    Given a DHPrivateKey instance
    Then setX(byte[] buffer, short offset, short length) sets the private value X
    And getX(byte[] buffer, short offset) retrieves the private value X

  # ===========================================================================
  # HMACKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: HMACKey extends SecretKey with variable-length key data
    # Source: [JavaCard 3.0.5 API, HMACKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/HMACKey.html)
    # Source: [JavaCard 3.1 API, HMACKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/HMACKey.html)
    # Source: [JavaCard 3.2 API, HMACKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/HMACKey.html)
    Given the interface javacard.security.HMACKey is available
    Then it extends javacard.security.SecretKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: HMACKey.setKey sets the HMAC key data with explicit length
    # Source: [JavaCard 3.0.5 API, setKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/HMACKey.html#setKey(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, setKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/HMACKey.html#setKey(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, setKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/HMACKey.html#setKey(byte%5B%5D,short,short)
    Given an HMACKey instance
    When setKey(keyData, kOff, kLen) is called
    Then the HMAC key data is set from the buffer with the specified length

  @v3.0.5 @v3.1 @v3.2
  Scenario: HMACKey.getKey retrieves the HMAC key data
    # Source: [JavaCard 3.0.5 API, getKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/HMACKey.html#getKey(byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, getKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/HMACKey.html#getKey(byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, getKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/HMACKey.html#getKey(byte%5B%5D,short)
    Given an initialized HMACKey instance
    When getKey(keyData, kOff) is called
    Then the key data is copied to the buffer and the byte length is returned

  # ===========================================================================
  # KoreanSEEDKey
  # ===========================================================================

  @v3.0.5 @v3.1 @v3.2
  Scenario: KoreanSEEDKey extends SecretKey
    # Source: [JavaCard 3.0.5 API, KoreanSEEDKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KoreanSEEDKey.html)
    # Source: [JavaCard 3.1 API, KoreanSEEDKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KoreanSEEDKey.html)
    # Source: [JavaCard 3.2 API, KoreanSEEDKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KoreanSEEDKey.html)
    Given the interface javacard.security.KoreanSEEDKey is available
    Then it extends javacard.security.SecretKey

  @v3.0.5 @v3.1 @v3.2
  Scenario: KoreanSEEDKey.setKey and getKey access key data
    # Source: [JavaCard 3.0.5 API, KoreanSEEDKey](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KoreanSEEDKey.html)
    # Source: [JavaCard 3.1 API, KoreanSEEDKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KoreanSEEDKey.html)
    # Source: [JavaCard 3.2 API, KoreanSEEDKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KoreanSEEDKey.html)
    Given a KoreanSEEDKey instance
    Then setKey(byte[] keyData, short kOff) sets the Korean SEED key data
    And getKey(byte[] keyData, short kOff) retrieves the key data and returns byte length

  # ===========================================================================
  # GenericSecretKey (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: GenericSecretKey extends SecretKey for generic secret data
    # Source: [JavaCard 3.1 API, GenericSecretKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/GenericSecretKey.html)
    # Source: [JavaCard 3.2 API, GenericSecretKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/GenericSecretKey.html)
    Given the interface javacard.security.GenericSecretKey is available
    Then it extends javacard.security.SecretKey

  @v3.1 @v3.2
  Scenario: GenericSecretKey.setKey sets the generic secret key data
    # Source: [JavaCard 3.1 API, setKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/GenericSecretKey.html#setKey(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, setKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/GenericSecretKey.html#setKey(byte%5B%5D,short,short)
    Given a GenericSecretKey instance
    When setKey(keyData, kOff, kLen) is called
    Then the key data is set from the buffer with the specified length

  @v3.1 @v3.2
  Scenario: GenericSecretKey.getKey retrieves the generic secret key data
    # Source: [JavaCard 3.1 API, getKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/GenericSecretKey.html#getKey(byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, getKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/GenericSecretKey.html#getKey(byte%5B%5D,short)
    Given an initialized GenericSecretKey instance
    When getKey(keyData, kOff) is called
    Then the key data is copied to the buffer and the short length is returned

  # ===========================================================================
  # SM4Key (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: SM4Key extends SecretKey for SM4 algorithm
    # Source: [JavaCard 3.1 API, SM4Key](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/SM4Key.html)
    # Source: [JavaCard 3.2 API, SM4Key](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/SM4Key.html)
    Given the interface javacard.security.SM4Key is available
    Then it extends javacard.security.SecretKey

  @v3.1 @v3.2
  Scenario: SM4Key.setKey and getKey access key data
    # Source: [JavaCard 3.1 API, SM4Key](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/SM4Key.html)
    # Source: [JavaCard 3.2 API, SM4Key](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/SM4Key.html)
    Given an SM4Key instance
    Then setKey(byte[] keyData, short kOff) sets the SM4 key data
    And getKey(byte[] keyData, short kOff) retrieves the key data and returns byte length

  # ===========================================================================
  # XECKey (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: XECKey defines extended elliptic curve key operations
    # Source: [JavaCard 3.1 API, XECKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/XECKey.html)
    # Source: [JavaCard 3.2 API, XECKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/XECKey.html)
    Given the interface javacard.security.XECKey is available
    Then it is the base interface for XECPublicKey and XECPrivateKey

  @v3.1 @v3.2
  Scenario Outline: XECKey methods
    # Source: [JavaCard 3.1 API, <method>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/XECKey.html)
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/XECKey.html)
    Given an XECKey instance
    Then the method "<method>" is available with signature "<signature>"

    Examples: XECKey methods
      | method              | signature                                                         |
      | getParams           | NamedParameterSpec getParams()                                    |
      | getEncodingLength   | short getEncodingLength()                                         |
      | getEncoded          | short getEncoded(byte[] value, short offset)                      |
      | setEncoded          | void setEncoded(byte[] value, short offset, short length)         |

  # ===========================================================================
  # XECPublicKey (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: XECPublicKey extends XECKey and PublicKey
    # Source: [JavaCard 3.1 API, XECPublicKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/XECPublicKey.html)
    # Source: [JavaCard 3.2 API, XECPublicKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/XECPublicKey.html)
    Given the interface javacard.security.XECPublicKey is available
    Then it extends javacard.security.XECKey and javacard.security.PublicKey
    And it defines no additional methods beyond those inherited

  # ===========================================================================
  # XECPrivateKey (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: XECPrivateKey extends XECKey and PrivateKey
    # Source: [JavaCard 3.1 API, XECPrivateKey](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/XECPrivateKey.html)
    # Source: [JavaCard 3.2 API, XECPrivateKey](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/XECPrivateKey.html)
    Given the interface javacard.security.XECPrivateKey is available
    Then it extends javacard.security.XECKey and javacard.security.PrivateKey
    And it defines no additional methods beyond those inherited

  # ===========================================================================
  # AlgorithmParameterSpec (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: AlgorithmParameterSpec is a marker interface for algorithm parameters
    # Source: [JavaCard 3.1 API, AlgorithmParameterSpec](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/AlgorithmParameterSpec.html)
    # Source: [JavaCard 3.2 API, AlgorithmParameterSpec](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/AlgorithmParameterSpec.html)
    Given the interface javacard.security.AlgorithmParameterSpec is available
    Then it defines no methods
    And it serves as a type-safe tag for algorithm parameter objects

  # ===========================================================================
  # NamedParameterSpec (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: NamedParameterSpec provides named curve/parameter specifications
    # Source: [JavaCard 3.1 API, NamedParameterSpec](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/NamedParameterSpec.html)
    # Source: [JavaCard 3.2 API, NamedParameterSpec](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/NamedParameterSpec.html)
    Given the class javacard.security.NamedParameterSpec is available
    Then it implements javacard.security.AlgorithmParameterSpec

  @v3.1 @v3.2
  Scenario: NamedParameterSpec.getInstance creates a NamedParameterSpec for a standard name
    # Source: [JavaCard 3.1 API, getInstance](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/NamedParameterSpec.html#getInstance(short)
    # Source: [JavaCard 3.2 API, getInstance](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/NamedParameterSpec.html#getInstance(short)
    Given a valid standard name constant
    When NamedParameterSpec.getInstance(stdName) is called
    Then a NamedParameterSpec instance is returned
    And CryptoException with NO_SUCH_ALGORITHM is thrown for an unsupported name

  @v3.1 @v3.2
  Scenario: NamedParameterSpec.getName returns the standard name constant
    # Source: [JavaCard 3.1 API, getName](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/NamedParameterSpec.html#getName)
    # Source: [JavaCard 3.2 API, getName](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/NamedParameterSpec.html#getName)
    Given a NamedParameterSpec instance
    When getName() is called
    Then the short standard name constant is returned

  @v3.1 @v3.2
  Scenario Outline: NamedParameterSpec EdDSA and XDH curve constants
    # Source: [JavaCard 3.1 API, <constant>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/NamedParameterSpec.html)
    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/NamedParameterSpec.html)
    Then the static field "<constant>" of type short has value <value>
    And it designates "<description>"

    Examples: EdDSA and XDH named curves
      | constant  | value | description                                |
      | ED25519   | 257   | Ed25519 Edwards curve for EdDSA signatures  |
      | ED448     | 514   | Ed448 Edwards curve for EdDSA signatures    |
      | X25519    | 259   | X25519 Montgomery curve for key agreement   |
      | X448      | 516   | X448 Montgomery curve for key agreement     |

  @v3.1 @v3.2
  Scenario Outline: NamedParameterSpec NIST SECP curve constants
    # Source: [JavaCard 3.1 API, <constant>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/NamedParameterSpec.html)
    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/NamedParameterSpec.html)
    Then the static field "<constant>" of type short has value <value>

    Examples: NIST SECP named curves
      | constant    | value |
      | SECP192R1   | 4097  |
      | SECP224R1   | 4098  |
      | SECP256R1   | 4099  |
      | SECP384R1   | 4100  |
      | SECP521R1   | 4101  |

  @v3.1 @v3.2
  Scenario Outline: NamedParameterSpec Brainpool curve constants
    # Source: [JavaCard 3.1 API, <constant>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/NamedParameterSpec.html)
    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/NamedParameterSpec.html)
    Then the static field "<constant>" of type short has value <value>

    Examples: Brainpool named curves
      | constant          | value |
      | BRAINPOOLP192R1   | 8195  |
      | BRAINPOOLP192T1   | 8196  |
      | BRAINPOOLP224R1   | 8197  |
      | BRAINPOOLP224T1   | 8198  |
      | BRAINPOOLP256R1   | 8199  |
      | BRAINPOOLP256T1   | 8200  |
      | BRAINPOOLP320R1   | 8201  |
      | BRAINPOOLP320T1   | 8202  |
      | BRAINPOOLP384R1   | 8203  |
      | BRAINPOOLP384T1   | 8204  |
      | BRAINPOOLP512R1   | 8205  |
      | BRAINPOOLP512T1   | 8206  |

  @v3.1 @v3.2
  Scenario Outline: NamedParameterSpec other curve constants
    # Source: [JavaCard 3.1 API, <constant>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/NamedParameterSpec.html)
    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/NamedParameterSpec.html)
    Then the static field "<constant>" of type short has value <value>
    And it designates "<description>"

    Examples: Other named curves
      | constant  | value | description                        |
      | FRP256V1  | 1025  | French FRP256V1 curve               |
      | SM2       | 768   | SM2 curve for Chinese cryptography  |

  # ===========================================================================
  # PrimalityTestParamSpec (added in 3.1)
  # ===========================================================================

  @v3.1 @v3.2
  Scenario: PrimalityTestParamSpec defines primality test configuration
    # Source: [JavaCard 3.1 API, PrimalityTestParamSpec](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/PrimalityTestParamSpec.html)
    # Source: [JavaCard 3.2 API, PrimalityTestParamSpec](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/PrimalityTestParamSpec.html)
    Given the interface javacard.security.PrimalityTestParamSpec is available
    Then it extends javacard.security.AlgorithmParameterSpec

  @v3.1 @v3.2
  Scenario Outline: PrimalityTestParamSpec test type constants
    # Source: [JavaCard 3.1 API, <constant>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/PrimalityTestParamSpec.html)
    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/PrimalityTestParamSpec.html)
    Then the static field "<constant>" of type short has value <value>

    Examples: Primality test types
      | constant           | value |
      | MILLER_RABIN_TEST  | 1     |
      | FERMAT_TEST        | 2     |

  @v3.1 @v3.2
  Scenario: PrimalityTestParamSpec methods
    # Source: [JavaCard 3.1 API, PrimalityTestParamSpec](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/PrimalityTestParamSpec.html)
    # Source: [JavaCard 3.2 API, PrimalityTestParamSpec](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/PrimalityTestParamSpec.html)
    Given a PrimalityTestParamSpec implementation
    Then getType() returns the primality test type constant
    And getRounds() returns the number of test rounds

  # ===========================================================================
  # SM2KeyAgreementParameterSpec (added in 3.2)
  # ===========================================================================

  @v3.2
  Scenario: SM2KeyAgreementParameterSpec defines SM2 key exchange parameters
    # Source: [JavaCard 3.2 API, SM2KeyAgreementParameterSpec](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/SM2KeyAgreementParameterSpec.html)
    Given the interface javacard.security.SM2KeyAgreementParameterSpec is available
    Then it extends javacard.security.AlgorithmParameterSpec

  @v3.2
  Scenario Outline: SM2KeyAgreementParameterSpec methods
    # Source: [JavaCard 3.2 API, <method>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/SM2KeyAgreementParameterSpec.html)
    Given an SM2KeyAgreementParameterSpec implementation
    Then the method "<method>" is available with return type "<return_type>"

    Examples: SM2KeyAgreementParameterSpec methods
      | method                  | return_type       |
      | getInitiatorID          | byte[]            |
      | getResponderID          | byte[]            |
      | isInitiator             | boolean           |
      | getLength               | short             |
      | getEphemeralPrivateKey  | XECPrivateKey     |
      | getEphemeralPublicKey   | byte[]            |
      | getConfirmationValue    | byte[]            |
