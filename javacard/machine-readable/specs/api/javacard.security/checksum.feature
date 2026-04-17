@v3.0.5
@v3.1
@v3.2
Feature: Checksum -- CRC and error-detection code computation
  The Checksum class is the base class for CRC (cyclic redundancy check)
  and other error-detection code computations.

  Background:
    Given the abstract class javacard.security.Checksum is available

  # ---------------------------------------------------------------------------
  # Algorithm constants
  # ---------------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, Checksum](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html)
  # Source: [JavaCard 3.1 API, Checksum](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html)
  # Source: [JavaCard 3.2 API, Checksum](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Checksum algorithm constants have specified values
    # Source: [JavaCard 3.0.5 API, <constant>](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Checksum algorithms
      | constant          | value | description                   |
      | ALG_ISO3309_CRC16 | 1     | ISO 3309 compliant 16-bit CRC |
      | ALG_ISO3309_CRC32 | 2     | ISO 3309 compliant 32-bit CRC |

  # ---------------------------------------------------------------------------
  # Factory method
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Checksum.getInstance creates a Checksum object for a supported algorithm
    # Source: [JavaCard 3.0.5 API, getInstance](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html#getInstance(byte,boolean)
    Given a supported checksum algorithm constant
    When Checksum.getInstance(algorithm, externalAccess) is called
    Then a Checksum instance implementing the requested algorithm is returned

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Checksum.getInstance throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, getInstance](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html#getInstance(byte,boolean)
    Given an unsupported checksum algorithm constant
    When Checksum.getInstance(algorithm, externalAccess) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  # ---------------------------------------------------------------------------
  # Instance methods
  # ---------------------------------------------------------------------------
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Checksum.init initializes the checksum object with a seed value
    # Source: [JavaCard 3.0.5 API, init](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html#init(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, init](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html#init(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, init](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html#init(byte%5B%5D,short,short)
    Given a Checksum instance
    When init(bArray, bOff, bLen) is called with initial seed data
    Then the checksum object is initialized for computation
    And CryptoException with ILLEGAL_VALUE is thrown if bLen is not the correct length for the algorithm

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Checksum.doFinal computes the checksum over input data
    # Source: [JavaCard 3.0.5 API, doFinal](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, doFinal](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, doFinal](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short)
    Given a Checksum instance that has been initialized
    When doFinal(inBuff, inOffset, inLength, outBuff, outOffset) is called
    Then the checksum is computed over the accumulated data and inBuff
    And the result is written to outBuff at outOffset
    And the checksum object is reset for a new computation

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Checksum.update accumulates data for checksum computation
    # Source: [JavaCard 3.0.5 API, update](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html#update(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, update](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html#update(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, update](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html#update(byte%5B%5D,short,short)
    Given a Checksum instance that has been initialized
    When update(inBuff, inOffset, inLength) is called
    Then the data is accumulated for the ongoing checksum computation

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Checksum.getAlgorithm returns the algorithm identifier
    # Source: [JavaCard 3.0.5 API, getAlgorithm](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/Checksum.html#getAlgorithm)
    # Source: [JavaCard 3.1 API, getAlgorithm](../../../refs/javadoc-3.1/api_classic/javacard/security/Checksum.html#getAlgorithm)
    # Source: [JavaCard 3.2 API, getAlgorithm](../../../refs/javadoc-3.2/api_classic/javacard/security/Checksum.html#getAlgorithm)
    Given a Checksum instance
    When getAlgorithm() is called
    Then it returns the algorithm constant used to create this instance
