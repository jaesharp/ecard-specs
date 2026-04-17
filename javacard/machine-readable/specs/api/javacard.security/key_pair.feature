@v3.0.5 @v3.1 @v3.2
Feature: KeyPair -- Asymmetric key pair container and generator
  The KeyPair class is a container for a key pair (a public key and a private key).
  It does not enforce any security, and when initialized, should be treated like a PrivateKey.
  It also provides a key generation method.


  Background:
    Given the final class javacard.security.KeyPair is available

  # ---------------------------------------------------------------------------
  # Algorithm type constants
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, KeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html)
  # Source: [JavaCard 3.1 API, KeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html)
  # Source: [JavaCard 3.2 API, KeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html)
  Scenario Outline: KeyPair algorithm type constants have specified values
    # Source: [JavaCard 3.0.5 API, <constant>](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: KeyPair algorithm types
      | constant    | value | description                                                              |
      | ALG_RSA     | 1     | RSA key pair                                                             |
      | ALG_RSA_CRT | 2     | RSA key pair with private key in Chinese Remainder Theorem form          |
      | ALG_DSA     | 3     | DSA key pair                                                             |
      | ALG_EC_F2M  | 4     | EC key pair for operations over fields of characteristic 2 with polynomial basis |
      | ALG_EC_FP   | 5     | EC key pair for operations over large prime fields                       |
      | ALG_DH      | 6     | DH key pair for modular exponentiation based Diffie-Hellman KeyAgreement |

  # ---------------------------------------------------------------------------
  # Constructors
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: KeyPair(byte, short) constructs an uninitialized key pair
    # Source: [JavaCard 3.0.5 API, KeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#KeyPair(byte,short)
    # Source: [JavaCard 3.1 API, KeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#KeyPair(byte,short)
    # Source: [JavaCard 3.2 API, KeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#KeyPair(byte,short)
    Given a valid algorithm type ALG_RSA and key length 2048
    When new KeyPair(algorithm, keyLength) is constructed
    Then a KeyPair instance is created with uninitialized keys
    And the encapsulated key objects implement the appropriate Key interfaces for the algorithm
    And genKeyPair() must be called to initialize the key values

  @v3.0.5 @v3.1 @v3.2
  Scenario: KeyPair(byte, short) throws CryptoException for unsupported algorithm/size
    # Source: [JavaCard 3.0.5 API, KeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#KeyPair(byte,short)
    # Source: [JavaCard 3.1 API, KeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#KeyPair(byte,short)
    # Source: [JavaCard 3.2 API, KeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#KeyPair(byte,short)
    Given an unsupported algorithm type or key size combination
    When new KeyPair(algorithm, keyLength) is constructed
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.0.5 @v3.1 @v3.2
  Scenario: KeyPair(PublicKey, PrivateKey) wraps existing key objects
    # Source: [JavaCard 3.0.5 API, KeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#KeyPair(PublicKey,PrivateKey)
    # Source: [JavaCard 3.1 API, KeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#KeyPair(PublicKey,PrivateKey)
    # Source: [JavaCard 3.2 API, KeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#KeyPair(PublicKey,PrivateKey)
    Given matching PublicKey and PrivateKey objects of the same algorithm and size
    When new KeyPair(publicKey, privateKey) is constructed
    Then a KeyPair instance is created containing references to the provided keys
    And no exception is thrown if the key objects are uninitialized

  @v3.0.5 @v3.1 @v3.2
  Scenario: KeyPair(PublicKey, PrivateKey) throws for mismatched keys
    # Source: [JavaCard 3.0.5 API, KeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#KeyPair(PublicKey,PrivateKey)
    # Source: [JavaCard 3.1 API, KeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#KeyPair(PublicKey,PrivateKey)
    # Source: [JavaCard 3.2 API, KeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#KeyPair(PublicKey,PrivateKey)
    Given PublicKey and PrivateKey objects with different algorithms or key sizes
    When new KeyPair(publicKey, privateKey) is constructed
    Then CryptoException is thrown with reason ILLEGAL_VALUE

  # ---------------------------------------------------------------------------
  # Key generation
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: genKeyPair() generates new key values for the encapsulated keys
    # Source: [JavaCard 3.0.5 API, genKeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.1 API, genKeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.2 API, genKeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#genKeyPair)
    Given a KeyPair instance for ALG_RSA with key length 2048
    When genKeyPair() is called
    Then the public and private key objects are initialized with new key values
    And an internal secure random number generator is used
    And the keys are suitable for use with Signature, Cipher, and KeyAgreement

  @v3.0.5 @v3.1 @v3.2
  Scenario: genKeyPair() retains pre-initialized RSA public exponent
    # Source: [JavaCard 3.0.5 API, genKeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.1 API, genKeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.2 API, genKeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#genKeyPair)
    Given a KeyPair instance for ALG_RSA
    And the public key exponent is pre-initialized
    When genKeyPair() is called
    Then the pre-initialized exponent value is retained
    And if no exponent is pre-initialized, a default value of 65537 is used

  @v3.0.5 @v3.1 @v3.2
  Scenario: genKeyPair() retains pre-initialized EC domain parameters
    # Source: [JavaCard 3.0.5 API, genKeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.1 API, genKeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.2 API, genKeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#genKeyPair)
    Given a KeyPair instance for ALG_EC_FP
    And the Field, A, B, G, and R parameters of the public key are pre-initialized
    When genKeyPair() is called
    Then the pre-initialized parameters are retained

  @v3.0.5 @v3.1 @v3.2
  Scenario: genKeyPair() throws CryptoException for invalid pre-initialized parameters
    # Source: [JavaCard 3.0.5 API, genKeyPair](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.1 API, genKeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#genKeyPair)
    # Source: [JavaCard 3.2 API, genKeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#genKeyPair)
    Given a KeyPair instance with invalid pre-initialized parameters
    When genKeyPair() is called
    Then CryptoException is thrown with reason ILLEGAL_VALUE

  @v3.1 @v3.2
  Scenario: genKeyPair(AlgorithmParameterSpec) generates keys with custom parameters
    # Source: [JavaCard 3.1 API, genKeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#genKeyPair(AlgorithmParameterSpec)
    # Source: [JavaCard 3.2 API, genKeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#genKeyPair(AlgorithmParameterSpec)
    Given a KeyPair instance
    And an AlgorithmParameterSpec implementation for primality testing or key derivation
    When genKeyPair(params) is called
    Then the key generation uses the specified algorithm parameters
    And if params is null, behavior is the same as genKeyPair()

  @v3.1 @v3.2
  Scenario: genKeyPair(AlgorithmParameterSpec) supports PrimalityTestParamSpec
    # Source: [JavaCard 3.1 API, genKeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#genKeyPair(AlgorithmParameterSpec)
    # Source: [JavaCard 3.2 API, genKeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#genKeyPair(AlgorithmParameterSpec)
    Given a KeyPair instance for ALG_RSA
    And a PrimalityTestParamSpec configured for Miller-Rabin or Fermat testing
    When genKeyPair(params) is called
    Then the primality test is customized per the specification

  @v3.1 @v3.2
  Scenario: genKeyPair(AlgorithmParameterSpec) throws for unsupported params
    # Source: [JavaCard 3.1 API, genKeyPair](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#genKeyPair(AlgorithmParameterSpec)
    # Source: [JavaCard 3.2 API, genKeyPair](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#genKeyPair(AlgorithmParameterSpec)
    Given a KeyPair instance
    And an AlgorithmParameterSpec with no valid interfaces or an invalid combination
    When genKeyPair(params) is called
    Then CryptoException is thrown with reason ILLEGAL_VALUE

  # ---------------------------------------------------------------------------
  # Accessor methods
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: getPublic() returns the public key component
    # Source: [JavaCard 3.0.5 API, getPublic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#getPublic)
    # Source: [JavaCard 3.1 API, getPublic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#getPublic)
    # Source: [JavaCard 3.2 API, getPublic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#getPublic)
    Given a KeyPair instance
    When getPublic() is called
    Then a reference to the public key component is returned

  @v3.0.5 @v3.1 @v3.2
  Scenario: getPrivate() returns the private key component
    # Source: [JavaCard 3.0.5 API, getPrivate](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyPair.html#getPrivate)
    # Source: [JavaCard 3.1 API, getPrivate](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/KeyPair.html#getPrivate)
    # Source: [JavaCard 3.2 API, getPrivate](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/KeyPair.html#getPrivate)
    Given a KeyPair instance
    When getPrivate() is called
    Then a reference to the private key component is returned
