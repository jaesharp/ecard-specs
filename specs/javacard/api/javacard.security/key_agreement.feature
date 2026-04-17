@v3.0.5
@v3.1
@v3.2
Feature: KeyAgreement -- Shared secret computation
  The KeyAgreement class is the base class for key agreement algorithms.
  It provides functionality for computing a shared secret between two or more parties.

  Background:
    Given the abstract class javacard.security.KeyAgreement is available

  # ---------------------------------------------------------------------------
  # Algorithm constants (present since 3.0.5)
  # ---------------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, KeyAgreement](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyAgreement.html)
  # Source: [JavaCard 3.1 API, KeyAgreement](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html)
  # Source: [JavaCard 3.2 API, KeyAgreement](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: KeyAgreement algorithm constants present since 3.0.5
    # Source: [JavaCard 3.0.5 API, <constant>](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyAgreement.html)
    # Source: [JavaCard 3.1 API, <constant>](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html)
    # Source: [JavaCard 3.2 API, <constant>](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: EC-based key agreement algorithms
      | constant                | value | description                                                |
      | ALG_EC_SVDP_DH          | 1     | EC Diffie-Hellman secret value derivation (with SHA-1 KDF) |
      | ALG_EC_SVDP_DH_KDF      | 1     | Alias for ALG_EC_SVDP_DH                                   |
      | ALG_EC_SVDP_DHC         | 2     | EC Diffie-Hellman with cofactor (with SHA-1 KDF)           |
      | ALG_EC_SVDP_DHC_KDF     | 2     | Alias for ALG_EC_SVDP_DHC                                  |
      | ALG_EC_SVDP_DH_PLAIN    | 3     | EC Diffie-Hellman plain secret value derivation (no KDF)   |
      | ALG_EC_SVDP_DHC_PLAIN   | 4     | EC Diffie-Hellman with cofactor, plain (no KDF)            |
      | ALG_EC_PACE_GM          | 5     | EC PACE Generic Mapping key agreement                      |
      | ALG_EC_SVDP_DH_PLAIN_XY | 6     | EC Diffie-Hellman plain, returns both X and Y coordinates  |
      | ALG_DH_PLAIN            | 7     | Diffie-Hellman plain modular exponentiation key agreement  |

  # ---------------------------------------------------------------------------
  # Algorithm constants added in 3.1
  # ---------------------------------------------------------------------------
  @v3.1
  @v3.2
  Scenario Outline: KeyAgreement algorithm constants added in version 3.1
    # Source: [JavaCard 3.1 API, <constant>](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html)
    # Source: [JavaCard 3.2 API, <constant>](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Algorithms since 3.1
      | constant | value | description                              |
      | ALG_XDH  | 8     | X25519/X448 key agreement using XEC keys |
      | ALG_SM2  | 9     | SM2 key exchange protocol                |

  # ---------------------------------------------------------------------------
  # Algorithm constant added in 3.2
  # ---------------------------------------------------------------------------
  @v3.2
  Scenario: KeyAgreement ALG_SM2_WITH_CONFIRMATION constant
    # Source: [JavaCard 3.2 API, ALG_SM2_WITH_CONFIRMATION](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html)
    Then the static field "ALG_SM2_WITH_CONFIRMATION" of type byte has value 10
    And it designates "SM2 key exchange protocol with key confirmation"

  # ---------------------------------------------------------------------------
  # Factory method
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyAgreement.getInstance creates a KeyAgreement object
    # Source: [JavaCard 3.0.5 API, getInstance](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyAgreement.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html#getInstance(byte,boolean)
    Given a supported key agreement algorithm constant
    When KeyAgreement.getInstance(algorithm, externalAccess) is called
    Then a KeyAgreement instance implementing the requested algorithm is returned

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyAgreement.getInstance throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, getInstance](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyAgreement.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html#getInstance(byte,boolean)
    Given an unsupported key agreement algorithm constant
    When KeyAgreement.getInstance(algorithm, externalAccess) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  # ---------------------------------------------------------------------------
  # Instance methods
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyAgreement.init initializes with a private key
    # Source: [JavaCard 3.0.5 API, init](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyAgreement.html#init(PrivateKey)
    # Source: [JavaCard 3.1 API, init](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html#init(PrivateKey)
    # Source: [JavaCard 3.2 API, init](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html#init(PrivateKey)
    Given a KeyAgreement instance
    When init(privKey) is called with a valid PrivateKey
    Then the key agreement is initialized for secret generation
    And CryptoException with ILLEGAL_VALUE is thrown if the key is incompatible
    And CryptoException with UNINITIALIZED_KEY is thrown if the key is not initialized

  @v3.1
  @v3.2
  Scenario: KeyAgreement.init with AlgorithmParameterSpec initializes with parameters
    # Source: [JavaCard 3.1 API, init](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html#init(PrivateKey,AlgorithmParameterSpec)
    # Source: [JavaCard 3.2 API, init](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html#init(PrivateKey,AlgorithmParameterSpec)
    Given a KeyAgreement instance for ALG_SM2 or ALG_SM2_WITH_CONFIRMATION
    When init(privKey, params) is called with a PrivateKey and AlgorithmParameterSpec
    Then the key agreement is initialized with the provided parameters

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyAgreement.generateSecret computes the shared secret
    # Source: [JavaCard 3.0.5 API, generateSecret](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyAgreement.html#generateSecret(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, generateSecret](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html#generateSecret(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, generateSecret](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html#generateSecret(byte%5B%5D,short,short,byte%5B%5D,short)
    Given an initialized KeyAgreement instance
    When generateSecret(publicData, publicOffset, publicLength, secret, secretOffset) is called
    Then the shared secret is computed using the other party's public data
    And the secret is written to the output buffer
    And the number of bytes written is returned
    And CryptoException with INVALID_INIT is thrown if the object is not initialized
    And CryptoException with ILLEGAL_VALUE is thrown if the public data is invalid

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyAgreement.getAlgorithm returns the algorithm identifier
    # Source: [JavaCard 3.0.5 API, getAlgorithm](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/KeyAgreement.html#getAlgorithm)
    # Source: [JavaCard 3.1 API, getAlgorithm](../../refs/javadoc-3.1/api_classic/javacard/security/KeyAgreement.html#getAlgorithm)
    # Source: [JavaCard 3.2 API, getAlgorithm](../../refs/javadoc-3.2/api_classic/javacard/security/KeyAgreement.html#getAlgorithm)
    Given a KeyAgreement instance
    When getAlgorithm() is called
    Then it returns the algorithm constant used to create this instance
