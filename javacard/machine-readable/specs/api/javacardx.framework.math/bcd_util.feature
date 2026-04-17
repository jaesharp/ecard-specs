@javacardx @javacardx.framework.math @v3.0.5 @v3.1 @v3.2
Feature: BCDUtil -- Binary Coded Decimal Utility
  The BCDUtil class provides utility methods for converting between hexadecimal
  (binary) and BCD (Binary Coded Decimal) formats, and for validating BCD data.

  # Source: [JavaCard 3.2 API, BCDUtil](../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BCDUtil.html)

  Background:
    Given a JavaCard runtime environment

  Scenario: BCDUtil.getMaxBytesSupported returns the platform maximum
    When BCDUtil.getMaxBytesSupported() is called
    Then the maximum number of bytes supported for BCD conversion is returned
    # Source: [JavaCard 3.2 API, getMaxBytesSupported](../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BCDUtil.html#getMaxBytesSupported)

  Scenario: BCDUtil.convertToHex converts BCD to hexadecimal
    When BCDUtil.convertToHex(byte[] bcdArray, short bOff, short bLen, byte[] hexArray, short hexOff) is called
    Then the BCD value is converted to its hexadecimal (binary) representation
    And the number of hex bytes written is returned
    # Source: [JavaCard 3.2 API, convertToHex](../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BCDUtil.html#convertToHex(byte%5B%5D,short,short,byte%5B%5D,short))

  Scenario: BCDUtil.convertToBCD converts hexadecimal to BCD
    When BCDUtil.convertToBCD(byte[] hexArray, short hexOff, short hexLen, byte[] bcdArray, short bOff) is called
    Then the hexadecimal (binary) value is converted to BCD representation
    And the number of BCD bytes written is returned
    # Source: [JavaCard 3.2 API, convertToBCD](../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BCDUtil.html#convertToBCD(byte%5B%5D,short,short,byte%5B%5D,short))

  Scenario: BCDUtil.isBCDFormat validates BCD data
    When BCDUtil.isBCDFormat(byte[] bArray, short bOff, short bLen) is called
    Then returns true if all bytes in the range contain valid BCD digits (0x00-0x99)
    And returns false if any byte contains an invalid BCD nibble
    # Source: [JavaCard 3.2 API, isBCDFormat](../../refs/javadoc-3.2/api_classic/javacardx/framework/math/BCDUtil.html#isBCDFormat(byte%5B%5D,short,short))
