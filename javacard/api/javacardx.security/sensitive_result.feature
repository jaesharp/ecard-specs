@javacardx @javacardx.security @v3.0.5 @v3.1 @v3.2
Feature: SensitiveResult -- Secure Result Assertion
  The SensitiveResult class provides assertion methods for re-checking return
  values of security-sensitive operations in a fault-attack resistant manner.
  Methods like Cipher.doFinal, Signature.verify, and AEADCipher.verifyTag set
  their results in an internal state that can be rechecked using these methods.

  This class helps detect fault injection attacks that may alter return values
  between computation and use.

  # Source: [JavaCard 3.2 API, SensitiveResult](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html)

  Background:
    Given a JavaCard runtime environment

  Scenario: SensitiveResult.assertEquals asserts two short values are equal
    When SensitiveResult.assertEquals(short expected, short actual) is called
    Then no exception is thrown if the internal state matches the expected comparison
    And javacard.security.CryptoException is thrown if the assertion fails
    # Source: [JavaCard 3.2 API, assertEquals](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertEquals(short,short))

  Scenario: SensitiveResult.assertTrue asserts the last boolean result was true
    When SensitiveResult.assertTrue() is called
    Then no exception is thrown if the internal boolean state is true
    And javacard.security.CryptoException is thrown if the assertion fails
    # Source: [JavaCard 3.2 API, assertTrue](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertTrue)

  Scenario: SensitiveResult.assertFalse asserts the last boolean result was false
    When SensitiveResult.assertFalse() is called
    Then no exception is thrown if the internal boolean state is false
    And javacard.security.CryptoException is thrown if the assertion fails
    # Source: [JavaCard 3.2 API, assertFalse](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertFalse)

  Scenario: SensitiveResult.assertNegative asserts the last result was negative
    When SensitiveResult.assertNegative() is called
    Then no exception is thrown if the internal state is a negative short value
    # Source: [JavaCard 3.2 API, assertNegative](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertNegative)

  Scenario: SensitiveResult.assertPositive asserts the last result was positive
    When SensitiveResult.assertPositive() is called
    Then no exception is thrown if the internal state is a positive short value
    # Source: [JavaCard 3.2 API, assertPositive](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertPositive)

  Scenario: SensitiveResult.assertZero asserts the last result was zero
    When SensitiveResult.assertZero() is called
    Then no exception is thrown if the internal state is zero
    # Source: [JavaCard 3.2 API, assertZero](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertZero)

  Scenario: SensitiveResult.assertGreaterThan compares the result
    When SensitiveResult.assertGreaterThan(short threshold) is called
    Then no exception is thrown if the internal short state is greater than threshold
    # Source: [JavaCard 3.2 API, assertGreaterThan](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertGreaterThan(short))

  Scenario: SensitiveResult.assertLessThan compares the result
    When SensitiveResult.assertLessThan(short threshold) is called
    Then no exception is thrown if the internal short state is less than threshold
    # Source: [JavaCard 3.2 API, assertLessThan](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#assertLessThan(short))

  Scenario: SensitiveResult.reset clears the internal state
    When SensitiveResult.reset() is called
    Then the internal sensitive result state is cleared
    # Source: [JavaCard 3.2 API, reset](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/SensitiveResult.html#reset)
