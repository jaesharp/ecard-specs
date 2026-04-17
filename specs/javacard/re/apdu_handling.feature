@jcre
@apdu-handling
Feature: APDU Class and Protocol Handling
  The APDU class encapsulates access to the ISO 7816-4 based I/O across the card
  serial line. The APDU class is designed to be independent of the underlying I/O
  transport protocol. The Java Card RE may support T=0 or T=1 transport protocols
  or both.

  # Source: [JCRE 3.0.5, s9 API Topics](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9 API Topics](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9 API Topics](../refs/3.2/JCRESpec_3.2.pdf#page=89)
  Background:
    Given a Java Card secure element with a compliant JCRE implementation
    And the Java Card RE is initialized

  # ---------------------------------------------------------------------------
  # 9.1 Resource Use Within the API
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.1 Resource Use Within the API](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.1 Resource Use Within the API](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.1 Resource Use Within the API](../refs/3.2/JCRESpec_3.2.pdf#page=89)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: API implementation resource rules
    Given an API method implementation exists in the Java Card RE
    Then it shall support invocation of API instance methods even when the owner is not the currently selected applet
    And unless specifically called out, the implementation shall not use resources such as transient objects of CLEAR_ON_DESELECT type

  # ---------------------------------------------------------------------------
  # 9.2 Exceptions Thrown by API Classes
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.2 Exceptions Thrown by API Classes](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.2 Exceptions Thrown by API Classes](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.2 Exceptions Thrown by API Classes](../refs/3.2/JCRESpec_3.2.pdf#page=89)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: API exception objects are temporary entry point objects
    Given all exception objects thrown by the API implementation
    Then they shall be temporary Java Card RE Entry Point Objects
    And they cannot be stored in class variables, instance variables, or array components

  # ---------------------------------------------------------------------------
  # 9.3 Transactions Within the API
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.3 Transactions Within the API](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.3 Transactions Within the API](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.3 Transactions Within the API](../refs/3.2/JCRESpec_3.2.pdf#page=89)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: API methods do not alter transaction state
    Given an API method is invoked while a transaction is in progress
    Then unless explicitly called out, API methods shall not initiate or otherwise alter the state of a transaction in progress
    And updates to internal implementation state within API objects must be conditional
    And internal state updates must participate in any ongoing transaction

  # ---------------------------------------------------------------------------
  # 9.4.1 T=0 Specifics for Outgoing Data Transfers
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.4.1 T=0 Specifics for Outgoing Data Transfers](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1 T=0 Specifics for Outgoing Data Transfers](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.4.1 T=0 Specifics for Outgoing Data Transfers](../refs/3.2/JCRESpec_3.2.pdf#page=89)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 expected length (Ne) values
    Given the T=0 transport protocol is in use
    Then setOutgoing and setOutgoingNoChaining return the expected length (Ne) as follows:
      | ISO case | Ne value                       |
      | CASE 1   | Not applicable (assume Case 2) |
      | CASE 2   | P3 (If P3=0, 256)              |
      | CASE 3   | Not applicable (assume Case 4) |
      | CASE 4   | 256                            |

  # Source: [JCRE 3.0.5, s9.4.1.1 Constrained Transfers With No Chaining](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.1 Constrained Transfers With No Chaining](../refs/3.1/JCRESpec_3.1.pdf#page=88)
  # Source: [JCRE 3.2, s9.4.1.1 Constrained Transfers With No Chaining](../refs/3.2/JCRESpec_3.2.pdf#page=90)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 constrained transfer - no chaining mode
    Given the applet has called setOutgoingNoChaining
    Then calls to the waitExtension method shall throw APDUException with reason code ILLEGAL_USE
    And the no chaining protocol sequence shall be followed

  # Source: [JCRE 3.0.5, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.1/JCRESpec_3.1.pdf#page=88)
  # Source: [JCRE 3.2, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.2/JCRESpec_3.2.pdf#page=90)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 CASE 2 constrained transfer when Ne equals Nr
    Given the T=0 protocol is in use with no chaining mode
    And the CAD expected length Ne equals the applet response length Nr
    Then the card sends Nr bytes using the standard T=0 <INS> or <~INS> procedure byte mechanism
    And the card sends <SW1,SW2> completion status on completion of Applet.process

  # Source: [JCRE 3.0.5, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.1/JCRESpec_3.1.pdf#page=88)
  # Source: [JCRE 3.2, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.2/JCRESpec_3.2.pdf#page=90)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 CASE 2 constrained transfer when Nr less than Ne
    Given the T=0 protocol is in use with no chaining mode
    And the applet response length Nr is less than the CAD expected length Ne
    Then the card sends <0x61,Nr> completion status bytes
    And the CAD sends GET RESPONSE command with Ne = Nr
    And the card sends Nr bytes using the standard T=0 procedure byte mechanism
    And the card sends <SW1,SW2> completion status on completion of Applet.process

  # Source: [JCRE 3.0.5, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.1/JCRESpec_3.1.pdf#page=88)
  # Source: [JCRE 3.2, s9.4.1.1.2 ISO 7816-4 CASE 2](../refs/3.2/JCRESpec_3.2.pdf#page=90)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 CASE 2 constrained transfer when Nr greater than Ne
    Given the T=0 protocol is in use with no chaining mode
    And the applet response length Nr is greater than the CAD expected length Ne
    Then the card sends Ne bytes using the standard T=0 procedure byte mechanism
    And the card sends <0x61,(Nr-Ne)> completion status bytes
    And the CAD sends GET RESPONSE command with new Ne <= Nr
    And the card sends (new) Ne bytes using the standard T=0 procedure byte mechanism
    And steps repeat as necessary to send all remaining output data (Nr)
    And the card sends <SW1,SW2> completion status on completion of Applet.process

  # Source: [JCRE 3.0.5, s9.4.1.1.3 ISO 7816-4 CASE 4](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.1.3 ISO 7816-4 CASE 4](../refs/3.1/JCRESpec_3.1.pdf#page=89)
  # Source: [JCRE 3.2, s9.4.1.1.3 ISO 7816-4 CASE 4](../refs/3.2/JCRESpec_3.2.pdf#page=91)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 CASE 4 constrained transfer
    Given the T=0 protocol is in use with no chaining mode and ISO CASE 4
    Then Ne is determined after the following initial exchange:
    And the card sends <0x61,Nr> status bytes
    And the CAD sends GET RESPONSE command with Ne <= Nr
    And the rest of the protocol sequence is identical to CASE 2
    And if the applet aborts early and sends less than Nr bytes, zeros shall be sent to fill the expected length

  # ---------------------------------------------------------------------------
  # 9.4.1.2 Regular Output Transfers (T=0)
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.4.1.2 Regular Output Transfers](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.2 Regular Output Transfers](../refs/3.1/JCRESpec_3.1.pdf#page=89)
  # Source: [JCRE 3.2, s9.4.1.2 Regular Output Transfers](../refs/3.2/JCRESpec_3.2.pdf#page=91)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 regular output transfer (chaining mode)
    Given the no chaining mode is not requested (setOutgoing is used)
    Then any ISO/IEC 7816-3/4 compliant T=0 protocol transfer sequence may be used
    And if the applet aborts early and sends less than Nr bytes, only the data bytes written via APDU send methods are sent to the CAD
    And the waitExtension method may be invoked by the applet at any time to request additional work waiting time using the 0x60 procedure byte

  # ---------------------------------------------------------------------------
  # 9.4.1.3 Additional T=0 Requirements
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.4.1.3 Additional T=0 Requirements](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.3 Additional T=0 Requirements](../refs/3.1/JCRESpec_3.1.pdf#page=89)
  # Source: [JCRE 3.2, s9.4.1.3 Additional T=0 Requirements](../refs/3.2/JCRESpec_3.2.pdf#page=91)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 NO_T0_GETRESPONSE exception
    Given the T=0 output transfer protocol is in use
    And the APDU class is awaiting a GET RESPONSE command from the CAD in reaction to <0x61, xx>
    When the CAD sends a different command on the same or different origin logical channel
    Then the sendBytes or sendBytesLong methods shall throw APDUException with reason code NO_T0_GETRESPONSE

  # Source: [JCRE 3.0.5, s9.4.1.3 Additional T=0 Requirements](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.3 Additional T=0 Requirements](../refs/3.1/JCRESpec_3.1.pdf#page=89)
  # Source: [JCRE 3.2, s9.4.1.3 Additional T=0 Requirements](../refs/3.2/JCRESpec_3.2.pdf#page=91)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=0 NO_T0_REISSUE exception
    Given the T=0 output transfer protocol is in use
    And the APDU class is awaiting a command reissue from the CAD in reaction to <0x6C, xx>
    When the CAD sends a different command on the same or different origin logical channel
    Then the sendBytes or sendBytesLong methods shall throw APDUException with reason code NO_T0_REISSUE

  # Source: [JCRE 3.0.5, s9.4.1.3 Additional T=0 Requirements](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.1.3 Additional T=0 Requirements](../refs/3.1/JCRESpec_3.1.pdf#page=89)
  # Source: [JCRE 3.2, s9.4.1.3 Additional T=0 Requirements](../refs/3.2/JCRESpec_3.2.pdf#page=91)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Calls after T=0 exceptions result in ILLEGAL_USE
    Given a NO_T0_GETRESPONSE or NO_T0_REISSUE exception has been thrown
    When sendBytes or sendBytesLong methods are called after that
    Then an APDUException with reason code ILLEGAL_USE shall be thrown
    And if an ISOException is thrown by the applet after either exception, the Java Card RE discards the response status in its reason code
    And the Java Card RE restarts APDU processing with the newly received command and resumes APDU dispatching

  # ---------------------------------------------------------------------------
  # 9.4.2 T=1 Specifics for Outgoing Data Transfers
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.4.2 T=1 Specifics for Outgoing Data Transfers](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.2 T=1 Specifics for Outgoing Data Transfers](../refs/3.1/JCRESpec_3.1.pdf#page=90)
  # Source: [JCRE 3.2, s9.4.2 T=1 Specifics for Outgoing Data Transfers](../refs/3.2/JCRESpec_3.2.pdf#page=92)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=1 expected length (Ne) values
    Given the T=1 transport protocol is in use
    Then setOutgoing and setOutgoingNoChaining return the expected length (Ne) as follows:
      | ISO case | Ne value          |
      | CASE 1   | 0                 |
      | CASE 2   | Le (If Le=0, 256) |
      | CASE 3   | 0                 |
      | CASE 4   | Le (If Le=0, 256) |

  # Source: [JCRE 3.0.5, s9.4.2.1 Constrained Transfers With No Chaining](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.2.1 Constrained Transfers With No Chaining](../refs/3.1/JCRESpec_3.1.pdf#page=90)
  # Source: [JCRE 3.2, s9.4.2.1 Constrained Transfers With No Chaining](../refs/3.2/JCRESpec_3.2.pdf#page=92)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=1 constrained transfer - no chaining mode
    Given the applet has called setOutgoingNoChaining in T=1 mode
    Then the transport protocol sequence shall not use block chaining
    And the M-bit (more data bit) shall not be set in the PCB of the I-blocks
    And the entire outgoing data (Nr bytes) shall be transferred in one I-block
    And if the applet aborts early and sends less than Nr bytes, zeros shall be sent to complete the remaining length of the block
    And calls to waitExtension shall throw APDUException with reason code ILLEGAL_USE

  # Source: [JCRE 3.0.5, s9.4.2.2 Regular Output Transfers](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.2.2 Regular Output Transfers](../refs/3.1/JCRESpec_3.1.pdf#page=91)
  # Source: [JCRE 3.2, s9.4.2.2 Regular Output Transfers](../refs/3.2/JCRESpec_3.2.pdf#page=93)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=1 regular output transfer (chaining mode)
    Given the no chaining mode is not requested in T=1 mode (setOutgoing is used)
    Then any ISO/IEC 7816-3/4 compliant T=1 protocol transfer sequence may be used
    And if the applet aborts early and sends less than Nr bytes, only the data bytes written via APDU send methods are sent
    And waitExtension method may be invoked; it sends an S-block command with WTX request of INF units

  # Source: [JCRE 3.0.5, s9.4.2.2.1 Chain Abortion by the CAD](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.2.2.1 Chain Abortion by the CAD](../refs/3.1/JCRESpec_3.1.pdf#page=91)
  # Source: [JCRE 3.2, s9.4.2.2.1 Chain Abortion by the CAD](../refs/3.2/JCRESpec_3.2.pdf#page=93)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=1 outbound chain abortion by CAD
    Given the CAD aborts a chained outbound transfer using an S-block ABORT request
    Then the sendBytes or sendBytesLong method shall throw APDUException with reason code T1_IFD_ABORT
    And subsequent calls to sendBytes or sendBytesLong shall result in APDUException with reason code ILLEGAL_USE
    And if an ISOException is thrown by the applet after T1_IFD_ABORT, the Java Card RE discards the response status and restarts APDU processing

  # ---------------------------------------------------------------------------
  # 9.4.3 T=1 Specifics for Incoming Data Transfers
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.4.3 T=1 Specifics for Incoming Data Transfers](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.3 T=1 Specifics for Incoming Data Transfers](../refs/3.1/JCRESpec_3.1.pdf#page=91)
  # Source: [JCRE 3.2, s9.4.3 T=1 Specifics for Incoming Data Transfers](../refs/3.2/JCRESpec_3.2.pdf#page=93)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: T=1 incoming chain abortion by CAD
    Given the CAD aborts a chained inbound transfer using an S-block ABORT request
    Then setIncomingAndReceive or receiveBytes method shall throw APDUException with reason code T1_IFD_ABORT
    And subsequent calls to receiveBytes, sendBytes, or sendBytesLong shall result in APDUException with reason code ILLEGAL_USE
    And if an ISOException is thrown after T1_IFD_ABORT, the Java Card RE discards the response status and restarts APDU processing

  # ---------------------------------------------------------------------------
  # 9.4.4 Extended Length APDU Specifics
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.4.4 Extended Length APDU Specifics](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.4 Extended Length APDU Specifics](../refs/3.1/JCRESpec_3.1.pdf#page=92)
  # Source: [JCRE 3.2, s9.4.4 Extended Length APDU Specifics](../refs/3.2/JCRESpec_3.2.pdf#page=94)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Extended length APDU support and ExtendedLength interface
    Given the implementation supports extended length APDU formats
    Then extended length semantics shall be enabled at the APDU class methods only if the currently selected applet implements javacardx.apdu.ExtendedLength interface
    And the maximum length that can be supported using extended length semantics by the Java Card technology API is 32767
    And if the implementation does not support extended length and the T=0 protocol is in use, an ENVELOPE command (CLA, INS=0xC2) must be forwarded to the currently selected applet
    And if the implementation does not support extended length and the T=1 protocol is in use, the Java Card RE shall respond with SW_WRONG_LENGTH

  # Source: [JCRE 3.0.5, s9.4.4.1.1 Applet.process(APDU) Method](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.4.1.1 Applet.process(APDU) Method](../refs/3.1/JCRESpec_3.1.pdf#page=92)
  # Source: [JCRE 3.2, s9.4.4.1.1 Applet.process(APDU) Method](../refs/3.2/JCRESpec_3.2.pdf#page=94)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Extended length APDU buffer format
    Given the APDU received is a Case 3E or 4E with Lc encoding of extended length
    Then the APDU buffer upon entry to Applet.process(APDU) shall encode the header in its first 7 bytes:
      | offset | content            |
      | 0      | CLA                |
      | 1      | INS                |
      | 2      | P1                 |
      | 3      | P2                 |
      | 4      | 3 byte Lc (byte 1) |
      | 5      | 3 byte Lc (byte 2) |
      | 6      | 3 byte Lc (byte 3) |
    And the 3-byte Lc length may encode a number from 1 to 32767
    And when T=0 is in use for a Case 3E or 4E, the APDU is enclosed in an ENVELOPE command (CLA, INS=0xC2)

  # Source: [JCRE 3.0.5, s9.4.4.1.2-6 Extended Length API Semantics](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.4.1.2-6 Extended Length API Semantics](../refs/3.1/JCRESpec_3.1.pdf#page=93)
  # Source: [JCRE 3.2, s9.4.4.1.2-6 Extended Length API Semantics](../refs/3.2/JCRESpec_3.2.pdf#page=95)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Extended length API method semantics
    Given the applet implements the ExtendedLength interface
    Then APDU.setIncomingAndReceive() returns a number between 0 and 32767 and when 3-byte Lc is used, data is placed at OFFSET_EXT_CDATA (7)
    And APDU.receiveBytes(short) returns a number between 0 and 32767
    And APDU.setOutgoing() returns the number of bytes expected (Le) by the CAD, between 0 and 32767
    And when T=0 is in use for a Case 2E (P3=0) or Case 4 command, setOutgoing returns 32767
    And when T=1 is in use for a Case 2E or Case 4E command and Le is 0x0000 or greater than 32767, setOutgoing returns 32767
    And APDU.setOutgoingLength(short) allows specifying a number between 0 and 32767
    And APDU.sendBytes and APDU.sendBytesLong allow specifying a number between 0 and 32767

  # ---------------------------------------------------------------------------
  # 9.5 Security and Crypto Packages
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.5 Security and Crypto Packages](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.5 Security and Crypto Packages](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.5 Security and Crypto Packages](../refs/3.2/JCRESpec_3.2.pdf#page=97)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Security and crypto getInstance method
    Given the getInstance method is called on MessageDigest, InitializedMessageDigest, Signature, RandomData, KeyAgreement, Checksum, or Cipher
    Then it returns an implementation instance in the context of the calling applet of the requested algorithm
    And the Java Card RE may implement zero or more of the algorithms listed in the API specification
    And when an algorithm that is not implemented is requested, a CryptoException with reason code NO_SUCH_ALGORITHM shall be thrown

  # Source: [JCRE 3.0.5, s9.5 Security and Crypto Packages](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.5 Security and Crypto Packages](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.5 Security and Crypto Packages](../refs/3.2/JCRESpec_3.2.pdf#page=97)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: KeyBuilder.buildKey and KeyPair constructor
    Given the buildKey method of javacard.security.KeyBuilder is called
    Then it returns an implementation instance of the requested Key type
    And when a key type that is not implemented is requested, a CryptoException with reason code NO_SUCH_ALGORITHM is thrown
    And similarly the constructor for javacard.security.KeyPair creates a KeyPair instance for the specified key type
    And all data allocation associated with the implementation instance is performed at construction time

  # Source: [JCRE 3.0.5, s9.5 Security and Crypto Packages](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.5 Security and Crypto Packages](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.5 Security and Crypto Packages](../refs/3.2/JCRESpec_3.2.pdf#page=97)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Crypto object temporary storage across power cycles
    Given MessageDigest, Signature, Cipher, or Checksum objects use temporary storage for intermediate results during update()
    Then this intermediate state need not be preserved across power up and reset
    And MessageDigest is reset to the state it was in when previously initialized via reset()
    And Signature and Cipher are reset to the state they were in when previously initialized via init()
    And Checksum is reset to the state it was in when previously initialized upon a tear or card reset event

  # ---------------------------------------------------------------------------
  # 9.4.5 Checking APDU Consistency
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s9.4.5 Checking APDU consistency](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=78)
  # Source: [JCRE 3.1, s9.4.5 Checking APDU consistency](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.4.5 Checking APDU consistency](../refs/3.2/JCRESpec_3.2.pdf#page=96)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: APDU consistency is applet responsibility
    Given the platform behavior for ill-formed or inconsistent messages may differ depending on protocol layer
    Then it is the responsibility of the application to check the consistency of commands received
    And the applet should verify the APDU class, instruction code, parameters
    And the applet should check the consistency of the data length received with the length in the APDU header
    And the applet should check the format and payload content
    And the applet should check the response data length expected

  # ---------------------------------------------------------------------------
  # 9.7 SensitiveResult Class (3.1+ feature)
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.1, s9.7 SensitiveResult Class](../refs/3.1/JCRESpec_3.1.pdf#page=87)
  # Source: [JCRE 3.2, s9.7 SensitiveResult Class](../refs/3.2/JCRESpec_3.2.pdf#page=98)
  @v3.1
  @v3.2
  Scenario: SensitiveResult class behavior
    Given sensitive methods of the API store their results via the SensitiveResult class
    Then the stored result is unaffected by context switches
    And the stored sensitive result from a method of a Shareable Interface Object is not automatically reset upon switching back to the context of the caller
    And when the JCRE gets back control from the Applet.process method or upon power loss or card reset, the stored sensitive result is reset
    And upon subsequently entering any of the Applet entry point methods the stored result is tagged as Unassigned
