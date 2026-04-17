@v3.0.5 @v3.1 @v3.2
Feature: CryptoException -- Cryptography-related exception
  CryptoException represents a cryptography-related exception.
  The API classes throw Java Card runtime environment-owned instances of CryptoException.
  These are temporary JCRE Entry Point Objects accessible from any applet context.


  Background:
    Given the javacard.security.CryptoException class is available
    And it extends javacard.framework.CardRuntimeException

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, CryptoException](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/CryptoException.html)
  # Source: [JavaCard 3.1 API, CryptoException](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/CryptoException.html)
  # Source: [JavaCard 3.2 API, CryptoException](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/CryptoException.html)
  Scenario Outline: CryptoException reason codes have specified constant values
    # Source: [JavaCard 3.0.5 API, <reason_code>](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/CryptoException.html)
    # Source: [JavaCard 3.1 API, <reason_code>](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/CryptoException.html)
    # Source: [JavaCard 3.2 API, <reason_code>](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/CryptoException.html)
    Then the static field "<reason_code>" of type short has value <value>
    And it indicates "<description>"

    Examples: Reason codes
      | reason_code        | value | description                                                                                |
      | ILLEGAL_VALUE      | 1     | One or more input parameters is out of allowed bounds                                      |
      | UNINITIALIZED_KEY  | 2     | The key is uninitialized                                                                   |
      | NO_SUCH_ALGORITHM  | 3     | The requested algorithm or key type is not supported                                       |
      | INVALID_INIT       | 4     | The signature or cipher object has not been correctly initialized for the requested operation |
      | ILLEGAL_USE        | 5     | The signature or cipher algorithm does not pad the incoming message and input is not block aligned, or method cannot be used because of the configured algorithm or a consistency check failed |

  @v3.0.5 @v3.1 @v3.2
  Scenario: CryptoException constructor accepts a reason code
    # Source: [JavaCard 3.0.5 API, CryptoException](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/CryptoException.html#CryptoException(short)
    # Source: [JavaCard 3.1 API, CryptoException](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/CryptoException.html#CryptoException(short)
    # Source: [JavaCard 3.2 API, CryptoException](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/CryptoException.html#CryptoException(short)
    When a new CryptoException is constructed with a short reason code
    Then the exception stores the specified reason

  @v3.0.5 @v3.1 @v3.2
  Scenario: CryptoException.throwIt throws the JCRE-owned instance
    # Source: [JavaCard 3.0.5 API, throwIt](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/CryptoException.html#throwIt(short)
    # Source: [JavaCard 3.1 API, throwIt](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/CryptoException.html#throwIt(short)
    # Source: [JavaCard 3.2 API, throwIt](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/CryptoException.html#throwIt(short)
    Given the static method "throwIt(short reason)" exists
    When throwIt is called with a reason code
    Then the JCRE-owned instance of CryptoException is thrown with that reason
    And the thrown instance is a temporary JCRE Entry Point Object
    And references to this temporary object cannot be stored in class variables, instance variables, or array components
