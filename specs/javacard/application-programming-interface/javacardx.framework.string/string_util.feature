@javacardx
@javacardx.framework.string
@v3.0.5
@v3.1
@v3.2
Feature: StringUtil and StringException -- String Processing Utilities
  The StringUtil class provides utility methods for working with encoded character
  strings on the Java Card platform, supporting multiple encodings and Unicode
  code point operations. StringException signals encoding or format errors.

  # Source: [JavaCard 3.2 API, StringUtil](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html)
  Background:
    Given a JavaCard runtime environment

  # ========== Encoding Constants ==========
  Scenario Outline: StringUtil defines encoding constants
    Then class StringUtil defines static byte constant "<constant>" for encoding "<encoding>"

    # Source: [JavaCard 3.2 API, <constant>](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html)
    Examples:
      | constant          | encoding                               |
      | UTF_8             | UTF-8                                  |
      | UTF_16            | UTF-16 (with BOM)                      |
      | UTF_16_LE         | UTF-16 Little Endian                   |
      | UTF_16_BE         | UTF-16 Big Endian                      |
      | UCS_2             | UCS-2 (Basic Multilingual Plane)       |
      | GSM_7             | GSM 7-bit default alphabet             |
      | ISO_8859_1        | ISO 8859-1 (Latin-1)                   |
      | PROP_ENCODING_EXT | Platform-proprietary extended encoding |

  # ========== Code Point Operations ==========
  Scenario: StringUtil.codePointCount counts Unicode code points
    When StringUtil.codePointCount(byte[] bArray, short bOff, short bLen, byte encoding) is called
    Then the number of Unicode code points in the encoded string is returned

  # Source: [JavaCard 3.2 API, codePointCount](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#codePointCount(byte%5B%5D,short,short,byte))
  Scenario: StringUtil.codePointAt returns the code point at an index
    When StringUtil.codePointAt(byte[] bArray, short bOff, short bLen, byte encoding, short index) is called
    Then the Unicode code point at the specified code point index is returned as an int

  # Source: [JavaCard 3.2 API, codePointAt](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#codePointAt(byte%5B%5D,short,short,byte,short))
  Scenario: StringUtil.codePointBefore returns the code point before an index
    When StringUtil.codePointBefore(byte[] bArray, short bOff, short bLen, byte encoding, short index) is called
    Then the Unicode code point immediately before the specified code point index is returned

  # Source: [JavaCard 3.2 API, codePointBefore](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#codePointBefore(byte%5B%5D,short,short,byte,short))
  Scenario: StringUtil.offsetByCodePoints returns byte offset for code point offset
    When StringUtil.offsetByCodePoints(byte[] bArray, short bOff, short bLen, byte encoding, short index, short codePointOffset) is called
    Then the byte offset resulting from advancing by codePointOffset code points is returned

  # Source: [JavaCard 3.2 API, offsetByCodePoints](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#offsetByCodePoints(byte%5B%5D,short,short,byte,short,short))
  # ========== Comparison and Search ==========
  Scenario: StringUtil.compare compares two encoded strings
    When StringUtil.compare(byte[] bArray1, short bOff1, short bLen1, byte encoding1, byte[] bArray2, short bOff2, short bLen2, byte encoding2) is called
    Then returns 0 if equal, negative if string1 < string2, positive if string1 > string2

  # Source: [JavaCard 3.2 API, compare](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#compare)
  Scenario: StringUtil.indexOf finds substring position
    When StringUtil.indexOf(byte[] bArray, short bOff, short bLen, byte encoding, byte[] pattern, short pOff, short pLen, byte pEncoding) is called
    Then returns the code point index of the first occurrence of pattern, or -1 if not found

  # Source: [JavaCard 3.2 API, indexOf](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#indexOf)
  Scenario: StringUtil.startsWith checks string prefix
    When StringUtil.startsWith(byte[] bArray, short bOff, short bLen, byte encoding, byte[] prefix, short pOff, short pLen, byte pEncoding) is called
    Then returns true if the string starts with the specified prefix

  # Source: [JavaCard 3.2 API, startsWith](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#startsWith)
  Scenario: StringUtil.endsWith checks string suffix
    When StringUtil.endsWith(byte[] bArray, short bOff, short bLen, byte encoding, byte[] suffix, short sOff, short sLen, byte sEncoding) is called
    Then returns true if the string ends with the specified suffix

  # Source: [JavaCard 3.2 API, endsWith](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#endsWith)
  # ========== Transformation ==========
  Scenario: StringUtil.replace replaces occurrences of a pattern
    When StringUtil.replace is called with source, target, and replacement strings
    Then all occurrences of target in source are replaced with replacement

  # Source: [JavaCard 3.2 API, replace](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#replace)
  Scenario: StringUtil.toLowerCase converts to lower case
    When StringUtil.toLowerCase(byte[] bArray, short bOff, short bLen, byte encoding, byte[] dest, short dOff) is called
    Then a lower-case version of the string is written to dest

  # Source: [JavaCard 3.2 API, toLowerCase](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#toLowerCase)
  Scenario: StringUtil.toUpperCase converts to upper case
    When StringUtil.toUpperCase(byte[] bArray, short bOff, short bLen, byte encoding, byte[] dest, short dOff) is called
    Then an upper-case version of the string is written to dest

  # Source: [JavaCard 3.2 API, toUpperCase](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#toUpperCase)
  Scenario: StringUtil.trim removes leading and trailing whitespace
    When StringUtil.trim(byte[] bArray, short bOff, short bLen, byte encoding, byte[] dest, short dOff) is called
    Then the string with whitespace removed from both ends is written to dest

  # Source: [JavaCard 3.2 API, trim](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#trim)
  Scenario: StringUtil.substring extracts a substring
    When StringUtil.substring(byte[] bArray, short bOff, short bLen, byte encoding, short beginIndex, short endIndex, byte[] dest, short dOff) is called
    Then the substring from beginIndex to endIndex (code point indices) is written to dest

  # Source: [JavaCard 3.2 API, substring](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#substring)
  # ========== Conversion ==========
  Scenario: StringUtil.valueOf converts a boolean to string
    When StringUtil.valueOf(boolean b, byte[] dest, short dOff, byte encoding) is called
    Then "true" or "false" is written to dest in the specified encoding

  # Source: [JavaCard 3.2 API, valueOf](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#valueOf(boolean,byte%5B%5D,short,byte))
  Scenario: StringUtil.parseBoolean parses a boolean from string
    When StringUtil.parseBoolean(byte[] bArray, short bOff, short bLen, byte encoding) is called
    Then returns true if the string is "true" (case-insensitive), false otherwise

  # Source: [JavaCard 3.2 API, parseBoolean](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#parseBoolean)
  Scenario: StringUtil.valueOf converts a short to string
    When StringUtil.valueOf(short value, byte[] dest, short dOff, byte encoding) is called
    Then the decimal string representation of the short value is written to dest

  # Source: [JavaCard 3.2 API, valueOf](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#valueOf(short,byte%5B%5D,short,byte))
  Scenario: StringUtil.parseShortInteger parses a short from string
    When StringUtil.parseShortInteger(byte[] bArray, short bOff, short bLen, byte encoding) is called
    Then the short value parsed from the decimal string is returned
    And StringException with ILLEGAL_NUMBER_FORMAT is thrown for invalid format

  # Source: [JavaCard 3.2 API, parseShortInteger](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#parseShortInteger)
  Scenario: StringUtil.convertTo converts encoding
    When StringUtil.convertTo(byte[] src, short sOff, short sLen, byte srcEncoding, byte[] dest, short dOff, byte destEncoding) is called
    Then the string is transcoded from srcEncoding to destEncoding

  # Source: [JavaCard 3.2 API, convertTo](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#convertTo)
  Scenario: StringUtil.convertFrom converts from platform encoding
    When StringUtil.convertFrom(byte[] src, short sOff, short sLen, byte srcEncoding, byte[] dest, short dOff, byte destEncoding) is called
    Then the string is transcoded from srcEncoding to destEncoding

  # Source: [JavaCard 3.2 API, convertFrom](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#convertFrom)
  Scenario: StringUtil.check validates encoded string data
    When StringUtil.check(byte[] bArray, short bOff, short bLen, byte encoding) is called
    Then returns true if the byte sequence is valid for the specified encoding

  # Source: [JavaCard 3.2 API, check](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringUtil.html#check)
  # ========== StringException ==========
  Scenario Outline: StringException defines reason codes
    Then class StringException defines static short constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringException.html)
    Examples:
      | constant              |
      | UNSUPPORTED_ENCODING  |
      | ILLEGAL_NUMBER_FORMAT |
      | INVALID_BYTE_SEQUENCE |

  Scenario: StringException.throwIt throws a StringException
    When StringException.throwIt(short reason) is called
    Then a StringException is thrown with the specified reason code


# Source: [JavaCard 3.2 API, throwIt](../.refs/javadoc-3.2/api_classic/javacardx/framework/string/StringException.html#throwIt(short))