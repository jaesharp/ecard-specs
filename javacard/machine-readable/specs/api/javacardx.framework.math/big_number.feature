@javacardx
@javacardx.framework.math
@v3.0.5
@v3.1
@v3.2
Feature: BigNumber -- Arbitrary Precision Numeric Operations
  The BigNumber class provides operations on large numbers stored as unsigned
  integers in BCD or hexadecimal format. It supports arithmetic operations
  (add, subtract, multiply), comparison, and format conversion.

  # Source: [JavaCard 3.2 API, BigNumber](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html)
  Background:
    Given a JavaCard runtime environment

  # ========== Format Constants ==========
  Scenario: BigNumber defines format constants
    Then class BigNumber defines static byte constant "FORMAT_BCD" for BCD (Binary Coded Decimal) format
    And class BigNumber defines static byte constant "FORMAT_HEX" for hexadecimal (binary) format

  # Source: [JavaCard 3.2 API, BigNumber](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html)
  # ========== Constructor and Initialization ==========
  Scenario: BigNumber constructor creates a new instance with specified maximum size
    When new BigNumber(short maxBytes) is called
    Then a BigNumber instance capable of holding maxBytes of data is created

  # Source: [JavaCard 3.2 API, BigNumber](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#BigNumber(short))
  Scenario: BigNumber.setMaximum sets the maximum byte length
    Given a BigNumber instance
    When setMaximum(short maxBytes) is called
    Then the maximum size is updated and the current value is cleared

  # Source: [JavaCard 3.2 API, setMaximum](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#setMaximum(short))
  Scenario: BigNumber.getMaxBytesSupported returns the platform maximum
    When BigNumber.getMaxBytesSupported() is called
    Then the maximum number of bytes supported by the platform is returned

  # Source: [JavaCard 3.2 API, getMaxBytesSupported](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#getMaxBytesSupported)
  Scenario: BigNumber.init initializes with a byte array value
    Given a BigNumber instance
    When init(byte[] bArray, short bOff, short bLen, byte arrayFormat) is called
    Then the BigNumber is initialized with the value from bArray in the specified format

  # Source: [JavaCard 3.2 API, init](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#init(byte%5B%5D,short,short,byte))
  # ========== Arithmetic Operations ==========
  Scenario: BigNumber.add performs addition
    Given an initialized BigNumber
    When add(byte[] bArray, short bOff, short bLen, byte arrayFormat) is called
    Then the value from bArray is added to the current BigNumber value

  # Source: [JavaCard 3.2 API, add](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#add(byte%5B%5D,short,short,byte))
  Scenario: BigNumber.subtract performs subtraction
    Given an initialized BigNumber
    When subtract(byte[] bArray, short bOff, short bLen, byte arrayFormat) is called
    Then the value from bArray is subtracted from the current BigNumber value

  # Source: [JavaCard 3.2 API, subtract](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#subtract(byte%5B%5D,short,short,byte))
  Scenario: BigNumber.multiply performs multiplication
    Given an initialized BigNumber
    When multiply(byte[] bArray, short bOff, short bLen, byte arrayFormat) is called
    Then the current BigNumber value is multiplied by the value from bArray

  # Source: [JavaCard 3.2 API, multiply](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#multiply(byte%5B%5D,short,short,byte))
  # ========== Comparison ==========
  Scenario: BigNumber.compareTo compares with a byte array value
    Given an initialized BigNumber
    When compareTo(byte[] bArray, short bOff, short bLen, byte arrayFormat) is called
    Then returns 0 if equal, positive if greater, negative if less

  # Source: [JavaCard 3.2 API, compareTo](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#compareTo(byte%5B%5D,short,short,byte))
  Scenario: BigNumber.compareTo compares with another BigNumber
    Given two initialized BigNumber instances
    When compareTo(BigNumber operand) is called
    Then returns 0 if equal, positive if this > operand, negative if this < operand

  # Source: [JavaCard 3.2 API, compareTo](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#compareTo(BigNumber))
  # ========== Conversion and Query ==========
  Scenario: BigNumber.toBytes exports value to byte array
    Given an initialized BigNumber
    When toBytes(byte[] outBuf, short outOff, short outLen, byte arrayFormat) is called
    Then the BigNumber value is written to outBuf in the specified format

  # Source: [JavaCard 3.2 API, toBytes](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#toBytes(byte%5B%5D,short,short,byte))
  Scenario: BigNumber.getByteLength returns the current value length
    Given an initialized BigNumber
    When getByteLength(byte arrayFormat) is called
    Then the byte length needed to represent the current value in the specified format is returned

  # Source: [JavaCard 3.2 API, getByteLength](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#getByteLength(byte))
  Scenario: BigNumber.reset clears the value to zero
    Given an initialized BigNumber
    When reset() is called
    Then the BigNumber value is reset to zero

# Source: [JavaCard 3.2 API, reset](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BigNumber.html#reset)