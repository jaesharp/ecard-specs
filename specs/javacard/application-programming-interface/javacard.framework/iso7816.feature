@v3.0.5
@v3.1
@v3.2
Feature: ISO7816 - ISO 7816 Constants Interface
  The ISO7816 interface encapsulates constants related to ISO 7816-3
  and ISO 7816-4. It contains only static fields: status word constants
  (SW_ prefix), APDU header offset constants (OFFSET_ prefix), and
  command class/instruction constants.

  # -------------------------------------------------------------------
  # APDU Header Offset Constants
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, ISO7816 ](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  # Source: [JavaCard 3.1 API, ISO7816 ](../.refs/javadoc-3.1/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  # Source: [JavaCard 3.2 API, ISO7816 ](../.refs/javadoc-3.2/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: APDU header offset constants have correct values
    When the constant ISO7816.<offset_name> is accessed
    Then its byte value is <value>
    And it is used to index into the APDU buffer

    Examples:
      | offset_name      | value |
      | OFFSET_CLA       | 0     |
      | OFFSET_INS       | 1     |
      | OFFSET_P1        | 2     |
      | OFFSET_P2        | 3     |
      | OFFSET_LC        | 4     |
      | OFFSET_CDATA     | 5     |
      | OFFSET_EXT_CDATA | 7     |

  # -------------------------------------------------------------------
  # Command CLA/INS Constants
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, ISO7816 ](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  # Source: [JavaCard 3.1 API, ISO7816 ](../.refs/javadoc-3.1/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  # Source: [JavaCard 3.2 API, ISO7816 ](../.refs/javadoc-3.2/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Command class and instruction constants have correct values
    When the constant ISO7816.<constant_name> is accessed
    Then its byte value is <hex_value>

    Examples:
      | constant_name             | hex_value |
      | CLA_ISO7816               | 0x00      |
      | INS_SELECT                | 0xA4      |
      | INS_EXTERNAL_AUTHENTICATE | 0x82      |

  # -------------------------------------------------------------------
  # Response Status Word Constants
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, ISO7816 ](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  # Source: [JavaCard 3.1 API, ISO7816 ](../.refs/javadoc-3.1/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  # Source: [JavaCard 3.2 API, ISO7816 ](../.refs/javadoc-3.2/api_classic/javacard/framework/ISO7816.html#ISO7816(fieldsummary)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Status word constants have correct values
    When the constant ISO7816.<sw_name> is accessed
    Then its short value is <hex_value>
    And its description is "<description>"

    Examples:
      | sw_name                           | hex_value | description                                     |
      | SW_NO_ERROR                       | 0x9000    | No Error                                        |
      | SW_BYTES_REMAINING_00             | 0x6100    | Response bytes remaining                        |
      | SW_WARNING_STATE_UNCHANGED        | 0x6200    | Warning, card state unchanged                   |
      | SW_WRONG_LENGTH                   | 0x6700    | Wrong length                                    |
      | SW_LOGICAL_CHANNEL_NOT_SUPPORTED  | 0x6881    | Card does not support logical channel operation |
      | SW_SECURE_MESSAGING_NOT_SUPPORTED | 0x6882    | Card does not support secure messaging          |
      | SW_LAST_COMMAND_EXPECTED          | 0x6883    | Last command in chain expected                  |
      | SW_COMMAND_CHAINING_NOT_SUPPORTED | 0x6884    | Command chaining not supported                  |
      | SW_SECURITY_STATUS_NOT_SATISFIED  | 0x6982    | Security condition not satisfied                |
      | SW_FILE_INVALID                   | 0x6983    | File invalid                                    |
      | SW_AUTHENTICATION_METHOD_BLOCKED  | 0x6983    | Authentication method blocked                   |
      | SW_DATA_INVALID                   | 0x6984    | Data invalid                                    |
      | SW_CONDITIONS_NOT_SATISFIED       | 0x6985    | Conditions of use not satisfied                 |
      | SW_COMMAND_NOT_ALLOWED            | 0x6986    | Command not allowed (no current EF)             |
      | SW_APPLET_SELECT_FAILED           | 0x6999    | Applet selection failed                         |
      | SW_WRONG_DATA                     | 0x6A80    | Wrong data                                      |
      | SW_FUNC_NOT_SUPPORTED             | 0x6A81    | Function not supported                          |
      | SW_FILE_NOT_FOUND                 | 0x6A82    | File not found                                  |
      | SW_RECORD_NOT_FOUND               | 0x6A83    | Record not found                                |
      | SW_FILE_FULL                      | 0x6A84    | Not enough memory space in the file             |
      | SW_INCORRECT_P1P2                 | 0x6A86    | Incorrect parameters (P1,P2)                    |
      | SW_WRONG_P1P2                     | 0x6B00    | Incorrect parameters (P1,P2)                    |
      | SW_CORRECT_LENGTH_00              | 0x6C00    | Correct Expected Length (Le)                    |
      | SW_INS_NOT_SUPPORTED              | 0x6D00    | INS value not supported                         |
      | SW_CLA_NOT_SUPPORTED              | 0x6E00    | CLA value not supported                         |
      | SW_UNKNOWN                        | 0x6F00    | No precise diagnosis                            |

  # Source: [JavaCard 3.0.5 API, ISO7816 ](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISO7816.html#ISO7816(classdescription)
  # Source: [JavaCard 3.1 API, ISO7816 ](../.refs/javadoc-3.1/api_classic/javacard/framework/ISO7816.html#ISO7816(classdescription)
  # Source: [JavaCard 3.2 API, ISO7816 ](../.refs/javadoc-3.2/api_classic/javacard/framework/ISO7816.html#ISO7816(classdescription)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Status words with _00 suffix require low byte customization
    Given the constant SW_CORRECT_LENGTH_00 with value 0x6C00
    When an applet needs to indicate the correct Le is 0x25
    Then it computes the status word as (SW_CORRECT_LENGTH_00 + (0x0025 & 0xFF))
    And the resulting status word is 0x6C25

  # Source: [JavaCard 3.0.5 API, ISO7816 ](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISO7816.html#ISO7816(classdescription)
  # Source: [JavaCard 3.1 API, ISO7816 ](../.refs/javadoc-3.1/api_classic/javacard/framework/ISO7816.html#ISO7816(classdescription)
  # Source: [JavaCard 3.2 API, ISO7816 ](../.refs/javadoc-3.2/api_classic/javacard/framework/ISO7816.html#ISO7816(classdescription)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SW_BYTES_REMAINING_00 requires low byte customization
    Given the constant SW_BYTES_REMAINING_00 with value 0x6100
    When an applet needs to indicate 0x10 bytes remaining
    Then it computes the status word as (SW_BYTES_REMAINING_00 + (0x0010 & 0xFF))
    And the resulting status word is 0x6110
