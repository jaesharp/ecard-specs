@javacardx
@javacardx.security.derivation
@v3.1
@v3.2
Feature: DerivationFunction and KDF Specifications -- Key Derivation Framework
  The javacardx.security.derivation package provides a framework for key derivation
  functions (KDFs). DerivationFunction is the abstract base. DerivationFunction.OneShot
  provides efficient single-use derivation. Various Spec classes configure specific
  KDF algorithms.

  # Source: [JavaCard 3.2 API, derivation package](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/package-summary.html)
  Background:
    Given a JavaCard runtime environment

  # ========== Algorithm Constants ==========
  Scenario Outline: DerivationFunction defines algorithm constants
    Then class DerivationFunction defines static byte constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html)
    Examples:
      | constant                    | description                                           |
      | ALG_KDF_COUNTER_MODE        | NIST SP 800-108 KDF in Counter Mode                   |
      | ALG_KDF_DPI_MODE            | NIST SP 800-108 KDF in Double Pipeline Iteration Mode |
      | ALG_KDF_FEEDBACK_MODE       | NIST SP 800-108 KDF in Feedback Mode                  |
      | ALG_PRF_TLS11               | TLS 1.1 Pseudo-Random Function                        |
      | ALG_PRF_TLS12               | TLS 1.2 Pseudo-Random Function                        |
      | ALG_HKDF_EXPAND_LABEL_TLS13 | TLS 1.3 HKDF-Expand-Label                             |
      | ALG_KDF_IEEE_1363           | IEEE 1363 KDF                                         |
      | ALG_KDF_ICAO_MRTD           | ICAO MRTD Key Derivation                              |
      | ALG_KDF_ANSI_X9_63          | ANSI X9.63 KDF                                        |
      | ALG_KDF_HKDF                | HKDF (HMAC-based Key Derivation Function)             |

  # ========== Factory Method ==========
  Scenario: DerivationFunction.getInstance creates a derivation function
    When DerivationFunction.getInstance(byte algorithm, boolean externalAccess) is called
    Then a DerivationFunction instance for the specified algorithm is returned
    And CryptoException with NO_SUCH_ALGORITHM is thrown if the algorithm is not supported

  # Source: [JavaCard 3.2 API, getInstance](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#getInstance(byte,boolean))
  # ========== Initialization ==========
  Scenario: DerivationFunction.init initializes with a KDF specification
    Given a DerivationFunction instance
    When init(javacard.security.KDFParameterSpec spec) is called
    Then the derivation function is initialized with the parameters from the spec

  # Source: [JavaCard 3.2 API, init](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#init(KDFParameterSpec))
  Scenario: DerivationFunction.getAlgorithm returns the algorithm
    Given a DerivationFunction instance
    When getAlgorithm() is called
    Then the algorithm constant is returned

  # Source: [JavaCard 3.2 API, getAlgorithm](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#getAlgorithm)
  # ========== Key Material Generation ==========
  Scenario: DerivationFunction.nextBytes derives key material into a byte array
    Given an initialized DerivationFunction
    When nextBytes(byte[] outBuf, short outOff, short outLen) is called
    Then outLen bytes of derived key material are written to outBuf

  # Source: [JavaCard 3.2 API, nextBytes](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#nextBytes(byte%5B%5D,short,short))
  Scenario: DerivationFunction.nextBytes derives key material into a Key object
    Given an initialized DerivationFunction
    When nextBytes(javacard.security.SecretKey key) is called
    Then derived key material is loaded directly into the Key object

  # Source: [JavaCard 3.2 API, nextBytes](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#nextBytes(SecretKey))
  Scenario: DerivationFunction.lastBytes derives final key material into a byte array
    Given an initialized DerivationFunction
    When lastBytes(byte[] outBuf, short outOff, short outLen) is called
    Then the final outLen bytes of derived material are written and the function is reset

  # Source: [JavaCard 3.2 API, lastBytes](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#lastBytes(byte%5B%5D,short,short))
  Scenario: DerivationFunction.lastBytes derives final key material into a Key
    Given an initialized DerivationFunction
    When lastBytes(javacard.security.SecretKey key) is called
    Then derived key material is loaded into the Key and the function is reset

  # Source: [JavaCard 3.2 API, lastBytes](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#lastBytes(SecretKey))
  # ========== DerivationFunction.OneShot ==========
  Scenario: DerivationFunction.OneShot.open creates a one-shot instance
    When DerivationFunction.OneShot.open(byte algorithm) is called
    Then a JCRE-owned temporary OneShot instance is returned
    And the instance must be closed after use

  # Source: [JavaCard 3.2 API, open](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#open(byte))
  Scenario: DerivationFunction.OneShot.close releases the instance
    Given an open DerivationFunction.OneShot instance
    When close() is called
    Then the instance is released for reuse by the JCRE

  # Source: [JavaCard 3.2 API, close](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/DerivationFunction.html#close)
  # ========== KDF Specification Classes ==========
  Scenario: KDFCounterModeSpec provides NIST SP 800-108 Counter Mode parameters
    Then KDFCounterModeSpec provides getAlgorithm(), getSecret(), getInputDataBeforeCounter(), getInputDataAfterCounter(), getOutputLength(), getCounterLength()

  # Source: [JavaCard 3.2 API, KDFCounterModeSpec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/KDFCounterModeSpec.html)
  Scenario: KDFFeedbackModeSpec provides NIST SP 800-108 Feedback Mode parameters
    Then KDFFeedbackModeSpec provides getAlgorithm(), getSecret(), getInputData(), getIV(), getOutputLength(), getCounterLength()

  # Source: [JavaCard 3.2 API, KDFFeedbackModeSpec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/KDFFeedbackModeSpec.html)
  Scenario: KDFDoublePipelineIterationModeSpec provides NIST SP 800-108 DPI Mode parameters
    Then KDFDoublePipelineIterationModeSpec provides getAlgorithm(), getSecret(), getInputData(), getOutputLength(), getCounterLength()

  # Source: [JavaCard 3.2 API, KDFDoublePipelineIterationModeSpec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/KDFDoublePipelineIterationModeSpec.html)
  Scenario: KDFHmacSpec provides HKDF parameters
    Then KDFHmacSpec provides getAlgorithm(), getSecret(), getInfo(), getSalt(), getOutputLength()

  # Source: [JavaCard 3.2 API, KDFHmacSpec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/KDFHmacSpec.html)
  Scenario: KDFAnsiX963Spec provides ANSI X9.63 parameters
    Then KDFAnsiX963Spec provides getAlgorithm(), getSecret(), getSharedInfo(), getOutputLength()

  # Source: [JavaCard 3.2 API, KDFAnsiX963Spec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/KDFAnsiX963Spec.html)
  Scenario: KDFIcaoMrtdSpec provides ICAO MRTD parameters
    Then KDFIcaoMrtdSpec provides getAlgorithm(), getSecret(), getCounter()

  # Source: [JavaCard 3.2 API, KDFIcaoMrtdSpec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/KDFIcaoMrtdSpec.html)
  Scenario: KDFIeee1363Spec provides IEEE 1363 parameters
    Then KDFIeee1363Spec provides getAlgorithm(), getSecret(), getParameters()

  # Source: [JavaCard 3.2 API, KDFIeee1363Spec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/KDFIeee1363Spec.html)
  Scenario: TLSPseudoRandomFunctionSpec provides TLS PRF parameters
    Then TLSPseudoRandomFunctionSpec provides getSecret(), getSeed()

  # Source: [JavaCard 3.2 API, TLSPseudoRandomFunctionSpec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/TLSPseudoRandomFunctionSpec.html)
  @v3.2
  Scenario: TLSKDFExpandLabelSpec provides TLS 1.3 HKDF-Expand-Label parameters
    Then TLSKDFExpandLabelSpec provides getAlgorithm(), getSecret(), getLabelPrefix(), getLabel(), getContext(), getOutputLength()
    And TLSKDFExpandLabelSpec defines static byte constant "LABEL_PREFIX_TLS13" for TLS 1.3 label prefix
    And TLSKDFExpandLabelSpec defines static byte constant "LABEL_PREFIX_DTLS13" for DTLS 1.3 label prefix


# Source: [JavaCard 3.2 API, TLSKDFExpandLabelSpec](../../refs/javadoc-3.2/api_classic/javacardx/security/derivation/TLSKDFExpandLabelSpec.html)