@v3.0.5 @v3.1 @v3.2
Feature: APDU - Application Protocol Data Unit
  The APDU class is the communication format between the card and
  off-card applications per ISO 7816-4. It is a temporary Java Card
  runtime environment Entry Point Object. The APDU buffer must be at
  least 133 bytes (5 header + 128 data). The JCRE zeroes the buffer
  before each new message from the CAD. The class is transport protocol
  independent (T=0 or T=1).

  # -------------------------------------------------------------------
  # State Constants
  # -------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, APDU ](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.1 API, APDU ](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.2 API, APDU ](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  Scenario Outline: APDU state constants define the processing lifecycle
    When the constant APDU.<state_name> is accessed
    Then it represents the state "<description>"

    Examples:
      | state_name                    | description                                          |
      | STATE_INITIAL                 | Only the command header is valid                     |
      | STATE_PARTIAL_INCOMING        | Incoming data has partially been received            |
      | STATE_FULL_INCOMING           | All incoming data has been received                  |
      | STATE_OUTGOING                | Data transfer mode is outbound, length not yet known |
      | STATE_OUTGOING_LENGTH_KNOWN   | Outbound mode and outbound length is known           |
      | STATE_PARTIAL_OUTGOING        | Some outbound data transferred but not all           |
      | STATE_FULL_OUTGOING           | All outbound data has been transferred               |

  # Source: [JavaCard 3.0.5 API, APDU ](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#APDU(classdescription)
  # Source: [JavaCard 3.1 API, APDU ](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#APDU(classdescription)
  # Source: [JavaCard 3.2 API, APDU ](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#APDU(classdescription)
  @v3.0.5 @v3.1 @v3.2
  Scenario: State constants are ordered
    Given the APDU state constants
    Then STATE_INITIAL < STATE_PARTIAL_INCOMING
    And STATE_PARTIAL_INCOMING < STATE_FULL_INCOMING
    And STATE_FULL_INCOMING < STATE_OUTGOING
    And STATE_OUTGOING < STATE_OUTGOING_LENGTH_KNOWN
    And STATE_OUTGOING_LENGTH_KNOWN < STATE_PARTIAL_OUTGOING
    And STATE_PARTIAL_OUTGOING < STATE_FULL_OUTGOING

  # Source: [JavaCard 3.0.5 API, APDU ](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.1 API, APDU ](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.2 API, APDU ](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: APDU error state constants have negative values
    When the constant APDU.<error_state> is accessed
    Then its value is negative

    Examples:
      | error_state                   |
      | STATE_ERROR_NO_T0_GETRESPONSE |
      | STATE_ERROR_T1_IFD_ABORT      |
      | STATE_ERROR_IO                |
      | STATE_ERROR_NO_T0_REISSUE     |

  # -------------------------------------------------------------------
  # Protocol Constants
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, APDU ](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.1 API, APDU ](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.2 API, APDU ](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: Protocol type and media constants
    When the constant APDU.<constant_name> is accessed
    Then it is a valid protocol identifier for "<description>"

    Examples:
      | constant_name                     | description                                 |
      | PROTOCOL_MEDIA_MASK               | Media nibble mask in protocol byte           |
      | PROTOCOL_TYPE_MASK                | Type nibble mask in protocol byte            |
      | PROTOCOL_T0                       | ISO 7816 transport protocol type T=0         |
      | PROTOCOL_T1                       | ISO 7816 transport protocol type T=1         |
      | PROTOCOL_MEDIA_DEFAULT            | Contacted Asynchronous Half Duplex           |
      | PROTOCOL_MEDIA_CONTACTLESS_TYPE_A | Contactless Type A                           |
      | PROTOCOL_MEDIA_CONTACTLESS_TYPE_B | Contactless Type B                           |
      | PROTOCOL_MEDIA_CONTACTLESS_TYPE_F | JIS X 6319-4 transport protocol Type F       |
      | PROTOCOL_MEDIA_USB                | USB transport                                |

  # -------------------------------------------------------------------
  # Logical Channel Encoding Constants
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, APDU ](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.1 API, APDU ](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  # Source: [JavaCard 3.2 API, APDU ](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#APDU(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: Logical channel encoding constants
    When the constant APDU.<constant_name> is accessed
    Then it indicates "<description>"

    Examples:
      | constant_name              | description                                             |
      | LC_ENCODING_NO             | CLA does not contain logical channel info               |
      | LC_ENCODING_TYPE_4         | Type 4 encoding, channels 0-3                           |
      | LC_ENCODING_TYPE_4_TYPE_16 | Type 4 and Type 16 encoding, channels 0-19              |

  # -------------------------------------------------------------------
  # Method: getBuffer()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getBuffer](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getBuffer)
  # Source: [JavaCard 3.1 API, getBuffer](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getBuffer)
  # Source: [JavaCard 3.2 API, getBuffer](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getBuffer)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getBuffer returns the APDU buffer byte array
    Given an APDU object received during Applet.process()
    When getBuffer() is called
    Then a byte array reference is returned
    And its length is at least 133 bytes
    And bytes at offsets 0-4 contain the command header (CLA, INS, P1, P2, P3)

  # -------------------------------------------------------------------
  # Method: getProtocol()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getProtocol](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getProtocol)
  # Source: [JavaCard 3.1 API, getProtocol](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getProtocol)
  # Source: [JavaCard 3.2 API, getProtocol](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getProtocol)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getProtocol returns protocol type in low nibble and media in upper nibble
    Given an APDU received over a T=0 contact interface
    When getProtocol() is called
    Then the low nibble matches PROTOCOL_T0
    And the upper nibble matches PROTOCOL_MEDIA_DEFAULT

  # -------------------------------------------------------------------
  # Method: getNAD()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getNAD](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getNAD)
  # Source: [JavaCard 3.1 API, getNAD](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getNAD)
  # Source: [JavaCard 3.2 API, getNAD](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getNAD)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getNAD returns node address byte for T=1
    Given an APDU received over T=1 protocol
    When getNAD() is called
    Then the Node Address byte is returned

  # Source: [JavaCard 3.0.5 API, getNAD](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getNAD)
  # Source: [JavaCard 3.1 API, getNAD](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getNAD)
  # Source: [JavaCard 3.2 API, getNAD](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getNAD)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getNAD returns 0 for T=0 and contactless protocols
    Given an APDU received over T=0 or contactless protocol
    When getNAD() is called
    Then the return value is 0

  # -------------------------------------------------------------------
  # Method: setIncomingAndReceive()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, setIncomingAndReceive](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setIncomingAndReceive)
  # Source: [JavaCard 3.1 API, setIncomingAndReceive](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setIncomingAndReceive)
  # Source: [JavaCard 3.2 API, setIncomingAndReceive](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setIncomingAndReceive)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setIncomingAndReceive is the primary receive method
    Given an APDU in STATE_INITIAL with incoming data
    When setIncomingAndReceive() is called
    Then incoming data bytes are read into the APDU buffer
    And the number of bytes read is returned
    And the APDU state advances to STATE_PARTIAL_INCOMING or STATE_FULL_INCOMING

  # Source: [JavaCard 3.0.5 API, setIncomingAndReceive](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setIncomingAndReceive)
  # Source: [JavaCard 3.1 API, setIncomingAndReceive](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setIncomingAndReceive)
  # Source: [JavaCard 3.2 API, setIncomingAndReceive](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setIncomingAndReceive)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setIncomingAndReceive throws APDUException if called in wrong state
    Given an APDU that is not in STATE_INITIAL
    When setIncomingAndReceive() is called
    Then an APDUException is thrown with reason ILLEGAL_USE

  # -------------------------------------------------------------------
  # Method: receiveBytes(short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, receiveBytes](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#receiveBytes(short)
  # Source: [JavaCard 3.1 API, receiveBytes](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#receiveBytes(short)
  # Source: [JavaCard 3.2 API, receiveBytes](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#receiveBytes(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: receiveBytes reads additional incoming data
    Given an APDU in STATE_PARTIAL_INCOMING
    When receiveBytes(bOff) is called with a valid offset
    Then additional data bytes are read into buffer at bOff
    And the number of bytes read is returned

  # Source: [JavaCard 3.0.5 API, receiveBytes](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#receiveBytes(short)
  # Source: [JavaCard 3.1 API, receiveBytes](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#receiveBytes(short)
  # Source: [JavaCard 3.2 API, receiveBytes](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#receiveBytes(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: receiveBytes throws APDUException for buffer bounds violation
    Given an APDU in STATE_PARTIAL_INCOMING
    When receiveBytes is called with bOff that would cause buffer overflow
    Then an APDUException is thrown with reason BUFFER_BOUNDS

  # -------------------------------------------------------------------
  # Method: getIncomingLength()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getIncomingLength](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getIncomingLength)
  # Source: [JavaCard 3.1 API, getIncomingLength](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getIncomingLength)
  # Source: [JavaCard 3.2 API, getIncomingLength](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getIncomingLength)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getIncomingLength returns the Lc value
    Given an APDU with Lc field indicating 10 bytes of data
    And setIncomingAndReceive() has been called
    When getIncomingLength() is called
    Then the return value is 10

  # Source: [JavaCard 3.0.5 API, getIncomingLength](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getIncomingLength)
  # Source: [JavaCard 3.1 API, getIncomingLength](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getIncomingLength)
  # Source: [JavaCard 3.2 API, getIncomingLength](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getIncomingLength)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getIncomingLength throws APDUException if called before setIncomingAndReceive
    Given an APDU in STATE_INITIAL
    When getIncomingLength() is called
    Then an APDUException is thrown with reason ILLEGAL_USE

  # -------------------------------------------------------------------
  # Method: getOffsetCdata()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getOffsetCdata](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getOffsetCdata)
  # Source: [JavaCard 3.1 API, getOffsetCdata](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getOffsetCdata)
  # Source: [JavaCard 3.2 API, getOffsetCdata](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getOffsetCdata)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getOffsetCdata returns offset for incoming command data
    Given an APDU with standard length encoding
    When getOffsetCdata() is called
    Then the return value is ISO7816.OFFSET_CDATA (5)

  # Source: [JavaCard 3.0.5 API, getOffsetCdata](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getOffsetCdata)
  # Source: [JavaCard 3.1 API, getOffsetCdata](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getOffsetCdata)
  # Source: [JavaCard 3.2 API, getOffsetCdata](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getOffsetCdata)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getOffsetCdata returns extended offset for extended length APDU
    Given an APDU with extended length encoding
    When getOffsetCdata() is called
    Then the return value is ISO7816.OFFSET_EXT_CDATA (7)

  # -------------------------------------------------------------------
  # Method: setOutgoing()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, setOutgoing](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setOutgoing)
  # Source: [JavaCard 3.1 API, setOutgoing](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setOutgoing)
  # Source: [JavaCard 3.2 API, setOutgoing](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setOutgoing)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setOutgoing sets direction to outbound and returns expected Le
    Given an APDU that has completed incoming data processing
    When setOutgoing() is called
    Then the expected response length (Ne) is returned
    And the APDU transitions to STATE_OUTGOING

  # Source: [JavaCard 3.0.5 API, setOutgoing](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setOutgoing)
  # Source: [JavaCard 3.1 API, setOutgoing](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setOutgoing)
  # Source: [JavaCard 3.2 API, setOutgoing](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setOutgoing)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setOutgoing throws APDUException if already in outgoing state
    Given an APDU already in STATE_OUTGOING
    When setOutgoing() is called again
    Then an APDUException is thrown with reason ILLEGAL_USE

  # -------------------------------------------------------------------
  # Method: setOutgoingLength(short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, setOutgoingLength](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  # Source: [JavaCard 3.1 API, setOutgoingLength](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  # Source: [JavaCard 3.2 API, setOutgoingLength](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setOutgoingLength sets the actual response data length
    Given an APDU in STATE_OUTGOING
    When setOutgoingLength(10) is called
    Then the APDU transitions to STATE_OUTGOING_LENGTH_KNOWN

  # Source: [JavaCard 3.0.5 API, setOutgoingLength](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  # Source: [JavaCard 3.1 API, setOutgoingLength](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  # Source: [JavaCard 3.2 API, setOutgoingLength](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setOutgoingLength throws APDUException if not in outgoing state
    Given an APDU not in STATE_OUTGOING
    When setOutgoingLength(10) is called
    Then an APDUException is thrown with reason ILLEGAL_USE

  # Source: [JavaCard 3.0.5 API, setOutgoingLength](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  # Source: [JavaCard 3.1 API, setOutgoingLength](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  # Source: [JavaCard 3.2 API, setOutgoingLength](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setOutgoingLength(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setOutgoingLength throws APDUException for negative length
    Given an APDU in STATE_OUTGOING
    When setOutgoingLength(-1) is called
    Then an APDUException is thrown with reason BAD_LENGTH

  # -------------------------------------------------------------------
  # Method: sendBytes(short, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, sendBytes](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  # Source: [JavaCard 3.1 API, sendBytes](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  # Source: [JavaCard 3.2 API, sendBytes](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: sendBytes sends data from APDU buffer
    Given an APDU in STATE_OUTGOING_LENGTH_KNOWN
    And response data in the buffer
    When sendBytes(bOff, len) is called
    Then len bytes are sent from buffer starting at bOff

  # Source: [JavaCard 3.0.5 API, sendBytes](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  # Source: [JavaCard 3.1 API, sendBytes](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  # Source: [JavaCard 3.2 API, sendBytes](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: sendBytes throws APDUException for buffer bounds violation
    Given an APDU in STATE_OUTGOING_LENGTH_KNOWN
    When sendBytes is called with bOff+len exceeding buffer length
    Then an APDUException is thrown with reason BUFFER_BOUNDS

  # Source: [JavaCard 3.0.5 API, sendBytes](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  # Source: [JavaCard 3.1 API, sendBytes](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  # Source: [JavaCard 3.2 API, sendBytes](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#sendBytes(short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: sendBytes throws APDUException if not in correct state
    Given an APDU not in STATE_OUTGOING_LENGTH_KNOWN or STATE_PARTIAL_OUTGOING
    When sendBytes is called
    Then an APDUException is thrown with reason ILLEGAL_USE

  # -------------------------------------------------------------------
  # Method: sendBytesLong(byte[], short, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, sendBytesLong](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#sendBytesLong(byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, sendBytesLong](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#sendBytesLong(byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, sendBytesLong](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#sendBytesLong(byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: sendBytesLong sends data from an external byte array
    Given an APDU in STATE_OUTGOING_LENGTH_KNOWN
    And an external byte array with response data
    When sendBytesLong(outData, bOff, len) is called
    Then len bytes from outData starting at bOff are sent

  # Source: [JavaCard 3.0.5 API, sendBytesLong](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#sendBytesLong(byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, sendBytesLong](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#sendBytesLong(byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, sendBytesLong](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#sendBytesLong(byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: sendBytesLong throws SecurityException for inaccessible array
    Given an APDU in STATE_OUTGOING_LENGTH_KNOWN
    And a byte array not accessible in the caller's context
    When sendBytesLong is called with that array
    Then a SecurityException is thrown

  # -------------------------------------------------------------------
  # Method: setOutgoingAndSend(short, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, setOutgoingAndSend](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setOutgoingAndSend(short,short)
  # Source: [JavaCard 3.1 API, setOutgoingAndSend](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setOutgoingAndSend(short,short)
  # Source: [JavaCard 3.2 API, setOutgoingAndSend](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setOutgoingAndSend(short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setOutgoingAndSend is a convenience method for short responses
    Given an APDU with response data prepared in the buffer
    When setOutgoingAndSend(bOff, len) is called
    Then it performs setOutgoing, setOutgoingLength, and sendBytes in sequence
    And the APDU transitions to STATE_FULL_OUTGOING

  # -------------------------------------------------------------------
  # Method: setOutgoingNoChaining()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, setOutgoingNoChaining](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#setOutgoingNoChaining)
  # Source: [JavaCard 3.1 API, setOutgoingNoChaining](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#setOutgoingNoChaining)
  # Source: [JavaCard 3.2 API, setOutgoingNoChaining](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#setOutgoingNoChaining)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setOutgoingNoChaining sets outbound without chaining
    Given an APDU that has completed incoming data processing
    When setOutgoingNoChaining() is called
    Then the expected response length (Ne) is returned
    And the APDU transitions to STATE_OUTGOING
    And no chaining mode is used for the response

  # -------------------------------------------------------------------
  # Method: getCurrentState()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getCurrentState](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getCurrentState)
  # Source: [JavaCard 3.1 API, getCurrentState](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getCurrentState)
  # Source: [JavaCard 3.2 API, getCurrentState](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getCurrentState)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getCurrentState returns the current processing state
    Given an APDU in STATE_INITIAL
    When getCurrentState() is called
    Then STATE_INITIAL is returned

  # -------------------------------------------------------------------
  # Method: getCurrentAPDU() / getCurrentAPDUBuffer()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getCurrentAPDU](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getCurrentAPDU)
  # Source: [JavaCard 3.1 API, getCurrentAPDU](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getCurrentAPDU)
  # Source: [JavaCard 3.2 API, getCurrentAPDU](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getCurrentAPDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getCurrentAPDU returns reference to the current APDU during process()
    Given processing is active within Applet.process(APDU)
    When APDU.getCurrentAPDU() is called
    Then a reference to the current APDU object is returned

  # Source: [JavaCard 3.0.5 API, getCurrentAPDUBuffer](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getCurrentAPDUBuffer)
  # Source: [JavaCard 3.1 API, getCurrentAPDUBuffer](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getCurrentAPDUBuffer)
  # Source: [JavaCard 3.2 API, getCurrentAPDUBuffer](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getCurrentAPDUBuffer)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getCurrentAPDUBuffer returns the current APDU buffer
    Given processing is active within Applet.process(APDU)
    When APDU.getCurrentAPDUBuffer() is called
    Then a reference to the current APDU buffer byte array is returned

  # -------------------------------------------------------------------
  # Method: getCLAChannel()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getCLAChannel](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getCLAChannel)
  # Source: [JavaCard 3.1 API, getCLAChannel](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getCLAChannel)
  # Source: [JavaCard 3.2 API, getCLAChannel](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getCLAChannel)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getCLAChannel returns logical channel from CLA byte
    Given an APDU with CLA byte indicating logical channel 2
    When APDU.getCLAChannel() is called
    Then the return value is 2

  # -------------------------------------------------------------------
  # Method: getLogicalChannelEncoding()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getLogicalChannelEncoding](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getLogicalChannelEncoding)
  # Source: [JavaCard 3.1 API, getLogicalChannelEncoding](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getLogicalChannelEncoding)
  # Source: [JavaCard 3.2 API, getLogicalChannelEncoding](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getLogicalChannelEncoding)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getLogicalChannelEncoding returns the CLA encoding type
    Given an APDU with CLA byte conforming to Type 4 encoding
    When getLogicalChannelEncoding() is called
    Then the return value is LC_ENCODING_TYPE_4

  # -------------------------------------------------------------------
  # Method: isCommandChainingCLA()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, isCommandChainingCLA](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#isCommandChainingCLA)
  # Source: [JavaCard 3.1 API, isCommandChainingCLA](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#isCommandChainingCLA)
  # Source: [JavaCard 3.2 API, isCommandChainingCLA](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#isCommandChainingCLA)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isCommandChainingCLA returns true for chained command
    Given an APDU with CLA byte indicating command chaining
    When isCommandChainingCLA() is called
    Then the result is true

  # Source: [JavaCard 3.0.5 API, isCommandChainingCLA](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#isCommandChainingCLA)
  # Source: [JavaCard 3.1 API, isCommandChainingCLA](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#isCommandChainingCLA)
  # Source: [JavaCard 3.2 API, isCommandChainingCLA](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#isCommandChainingCLA)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isCommandChainingCLA returns false for non-chained command
    Given an APDU with CLA byte not indicating command chaining
    When isCommandChainingCLA() is called
    Then the result is false

  # -------------------------------------------------------------------
  # Method: isISOInterindustryCLA()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, isISOInterindustryCLA](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#isISOInterindustryCLA)
  # Source: [JavaCard 3.1 API, isISOInterindustryCLA](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#isISOInterindustryCLA)
  # Source: [JavaCard 3.2 API, isISOInterindustryCLA](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#isISOInterindustryCLA)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isISOInterindustryCLA returns true for interindustry CLA
    Given an APDU with CLA byte 0x00 (ISO interindustry)
    When isISOInterindustryCLA() is called
    Then the result is true

  # -------------------------------------------------------------------
  # Method: isSecureMessagingCLA()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, isSecureMessagingCLA](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#isSecureMessagingCLA)
  # Source: [JavaCard 3.1 API, isSecureMessagingCLA](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#isSecureMessagingCLA)
  # Source: [JavaCard 3.2 API, isSecureMessagingCLA](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#isSecureMessagingCLA)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isSecureMessagingCLA indicates secure messaging in CLA
    Given an APDU with CLA byte indicating secure messaging
    When isSecureMessagingCLA() is called
    Then the result is true

  # -------------------------------------------------------------------
  # Method: isValidCLA()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, isValidCLA](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#isValidCLA)
  # Source: [JavaCard 3.1 API, isValidCLA](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#isValidCLA)
  # Source: [JavaCard 3.2 API, isValidCLA](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#isValidCLA)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isValidCLA returns true for a valid CLA byte
    Given an APDU with a valid CLA byte
    When isValidCLA() is called
    Then the result is true

  # -------------------------------------------------------------------
  # Method: getInBlockSize() / getOutBlockSize()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getInBlockSize](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getInBlockSize)
  # Source: [JavaCard 3.1 API, getInBlockSize](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getInBlockSize)
  # Source: [JavaCard 3.2 API, getInBlockSize](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getInBlockSize)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getInBlockSize returns the configured incoming block size
    When APDU.getInBlockSize() is called
    Then a positive short value is returned representing the incoming block size

  # Source: [JavaCard 3.0.5 API, getOutBlockSize](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#getOutBlockSize)
  # Source: [JavaCard 3.1 API, getOutBlockSize](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#getOutBlockSize)
  # Source: [JavaCard 3.2 API, getOutBlockSize](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#getOutBlockSize)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getOutBlockSize returns the configured outgoing block size
    When APDU.getOutBlockSize() is called
    Then a positive short value is returned representing the outgoing block size

  # -------------------------------------------------------------------
  # Method: waitExtension()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, waitExtension](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDU.html#waitExtension)
  # Source: [JavaCard 3.1 API, waitExtension](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/APDU.html#waitExtension)
  # Source: [JavaCard 3.2 API, waitExtension](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/APDU.html#waitExtension)
  @v3.0.5 @v3.1 @v3.2
  Scenario: waitExtension requests additional processing time from CAD
    Given an APDU being processed
    When APDU.waitExtension() is called
    Then a request for additional processing time is sent to the CAD
