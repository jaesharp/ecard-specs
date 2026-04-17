@v3.0.5 @v3.1 @v3.2
Feature: Exception Classes
  The javacard.framework package defines a hierarchy of exception
  classes. CardException is the base checked exception with a reason
  code. CardRuntimeException is the base unchecked exception with a
  reason code. Specific exception classes extend these bases for
  particular subsystems: APDU, ISO, System, Transaction, PIN, and User.

  # ===================================================================
  # CardException (checked, extends java.lang.Exception)
  # ===================================================================

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, CardException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardException.html#CardException(short)
  # Source: [JavaCard 3.1 API, CardException](../../refs/javadoc-3.1/api_classic/javacard/framework/CardException.html#CardException(short)
  # Source: [JavaCard 3.2 API, CardException](../../refs/javadoc-3.2/api_classic/javacard/framework/CardException.html#CardException(short)
  Scenario: CardException construction with reason code
    When a CardException is constructed with reason 0x0001
    Then the exception is created
    And getReason() returns 0x0001

  # Source: [JavaCard 3.0.5 API, getReason](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardException.html#getReason)
  # Source: [JavaCard 3.1 API, getReason](../../refs/javadoc-3.1/api_classic/javacard/framework/CardException.html#getReason)
  # Source: [JavaCard 3.2 API, getReason](../../refs/javadoc-3.2/api_classic/javacard/framework/CardException.html#getReason)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardException.getReason returns the reason code
    Given a CardException with reason 0x1234
    When getReason() is called
    Then the return value is 0x1234

  # Source: [JavaCard 3.0.5 API, setReason](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardException.html#setReason(short)
  # Source: [JavaCard 3.1 API, setReason](../../refs/javadoc-3.1/api_classic/javacard/framework/CardException.html#setReason(short)
  # Source: [JavaCard 3.2 API, setReason](../../refs/javadoc-3.2/api_classic/javacard/framework/CardException.html#setReason(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardException.setReason updates the reason code
    Given a CardException with reason 0x0001
    When setReason(0x0002) is called
    Then getReason() returns 0x0002

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/CardException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/CardException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardException.throwIt throws JCRE-owned instance
    When CardException.throwIt(0x0001) is called
    Then a JCRE-owned CardException is thrown with reason 0x0001

  # ===================================================================
  # CardRuntimeException (unchecked, extends java.lang.RuntimeException)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, CardRuntimeException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardRuntimeException.html#CardRuntimeException(short)
  # Source: [JavaCard 3.1 API, CardRuntimeException](../../refs/javadoc-3.1/api_classic/javacard/framework/CardRuntimeException.html#CardRuntimeException(short)
  # Source: [JavaCard 3.2 API, CardRuntimeException](../../refs/javadoc-3.2/api_classic/javacard/framework/CardRuntimeException.html#CardRuntimeException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardRuntimeException construction with reason code
    When a CardRuntimeException is constructed with reason 0x0001
    Then the exception is created
    And getReason() returns 0x0001

  # Source: [JavaCard 3.0.5 API, getReason](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardRuntimeException.html#getReason)
  # Source: [JavaCard 3.1 API, getReason](../../refs/javadoc-3.1/api_classic/javacard/framework/CardRuntimeException.html#getReason)
  # Source: [JavaCard 3.2 API, getReason](../../refs/javadoc-3.2/api_classic/javacard/framework/CardRuntimeException.html#getReason)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardRuntimeException.getReason returns the reason code
    Given a CardRuntimeException with reason 0x5678
    When getReason() is called
    Then the return value is 0x5678

  # Source: [JavaCard 3.0.5 API, setReason](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardRuntimeException.html#setReason(short)
  # Source: [JavaCard 3.1 API, setReason](../../refs/javadoc-3.1/api_classic/javacard/framework/CardRuntimeException.html#setReason(short)
  # Source: [JavaCard 3.2 API, setReason](../../refs/javadoc-3.2/api_classic/javacard/framework/CardRuntimeException.html#setReason(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardRuntimeException.setReason updates the reason code
    Given a CardRuntimeException
    When setReason(0x0003) is called
    Then getReason() returns 0x0003

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/CardRuntimeException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/CardRuntimeException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/CardRuntimeException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CardRuntimeException.throwIt throws JCRE-owned instance
    When CardRuntimeException.throwIt(0x0001) is called
    Then a JCRE-owned CardRuntimeException is thrown with reason 0x0001

  # ===================================================================
  # ISOException (extends CardRuntimeException)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, ISOException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISOException.html#ISOException(short)
  # Source: [JavaCard 3.1 API, ISOException](../../refs/javadoc-3.1/api_classic/javacard/framework/ISOException.html#ISOException(short)
  # Source: [JavaCard 3.2 API, ISOException](../../refs/javadoc-3.2/api_classic/javacard/framework/ISOException.html#ISOException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: ISOException construction with status word
    When an ISOException is constructed with sw 0x6A82
    Then the exception is created
    And getReason() returns 0x6A82

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISOException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/ISOException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/ISOException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: ISOException.throwIt throws JCRE-owned instance with status word
    When ISOException.throwIt(ISO7816.SW_FILE_NOT_FOUND) is called
    Then a JCRE-owned ISOException is thrown with reason 0x6A82

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/ISOException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/ISOException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/ISOException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: ISOException thrown from process() causes JCRE to send that status word
    Given an applet's process() method
    When ISOException.throwIt(0x6985) is called
    Then the JCRE sends status word 0x6985 in the response APDU

  # ===================================================================
  # APDUException (extends CardRuntimeException)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, APDUException ](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDUException.html#APDUException(fieldsummary)
  # Source: [JavaCard 3.1 API, APDUException ](../../refs/javadoc-3.1/api_classic/javacard/framework/APDUException.html#APDUException(fieldsummary)
  # Source: [JavaCard 3.2 API, APDUException ](../../refs/javadoc-3.2/api_classic/javacard/framework/APDUException.html#APDUException(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: APDUException reason code constants
    When the constant APDUException.<reason_name> is accessed
    Then it represents the APDU error condition "<description>"

    Examples:
      | reason_name        | description                                                     |
      | ILLEGAL_USE        | Method called in incorrect APDU state or sequence               |
      | BUFFER_BOUNDS      | APDU buffer access would exceed bounds                          |
      | BAD_LENGTH         | Bad length value                                                |
      | IO_ERROR           | I/O error during communication                                  |
      | NO_T0_GETRESPONSE  | T=0 GET RESPONSE not received from CAD                          |
      | T1_IFD_ABORT       | T=1 IFD ABORT received                                         |
      | NO_T0_REISSUE      | T=0 command reissue not received from CAD                       |

  # Source: [JavaCard 3.0.5 API, APDUException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDUException.html#APDUException(short)
  # Source: [JavaCard 3.1 API, APDUException](../../refs/javadoc-3.1/api_classic/javacard/framework/APDUException.html#APDUException(short)
  # Source: [JavaCard 3.2 API, APDUException](../../refs/javadoc-3.2/api_classic/javacard/framework/APDUException.html#APDUException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: APDUException construction with reason code
    When an APDUException is constructed with reason ILLEGAL_USE
    Then the exception is created with that reason code

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/APDUException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/APDUException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/APDUException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: APDUException.throwIt throws JCRE-owned instance
    When APDUException.throwIt(APDUException.IO_ERROR) is called
    Then a JCRE-owned APDUException is thrown with reason IO_ERROR

  # ===================================================================
  # SystemException (extends CardRuntimeException)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, SystemException ](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SystemException.html#SystemException(fieldsummary)
  # Source: [JavaCard 3.1 API, SystemException ](../../refs/javadoc-3.1/api_classic/javacard/framework/SystemException.html#SystemException(fieldsummary)
  # Source: [JavaCard 3.2 API, SystemException ](../../refs/javadoc-3.2/api_classic/javacard/framework/SystemException.html#SystemException(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: SystemException reason code constants
    When the constant SystemException.<reason_name> is accessed
    Then it represents the system error condition "<description>"

    Examples:
      | reason_name      | description                                                    |
      | ILLEGAL_VALUE    | One or more input parameters is out of allowed bounds          |
      | NO_TRANSIENT_SPACE | No room in volatile memory for requested transient object    |
      | ILLEGAL_TRANSIENT | Transient object creation not allowed in current context      |
      | ILLEGAL_AID      | Input AID parameter is not a legal AID value                   |
      | NO_RESOURCE      | Insufficient resource in the card for the request              |
      | ILLEGAL_USE      | Requested function is not allowed                              |

  # Source: [JavaCard 3.0.5 API, SystemException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SystemException.html#SystemException(short)
  # Source: [JavaCard 3.1 API, SystemException](../../refs/javadoc-3.1/api_classic/javacard/framework/SystemException.html#SystemException(short)
  # Source: [JavaCard 3.2 API, SystemException](../../refs/javadoc-3.2/api_classic/javacard/framework/SystemException.html#SystemException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: SystemException construction with reason code
    When a SystemException is constructed with reason ILLEGAL_VALUE
    Then the exception is created with that reason code

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SystemException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/SystemException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/SystemException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: SystemException.throwIt throws JCRE-owned instance
    When SystemException.throwIt(SystemException.ILLEGAL_VALUE) is called
    Then a JCRE-owned SystemException is thrown with reason ILLEGAL_VALUE

  # ===================================================================
  # TransactionException (extends CardRuntimeException)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, TransactionException ](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/TransactionException.html#TransactionException(fieldsummary)
  # Source: [JavaCard 3.1 API, TransactionException ](../../refs/javadoc-3.1/api_classic/javacard/framework/TransactionException.html#TransactionException(fieldsummary)
  # Source: [JavaCard 3.2 API, TransactionException ](../../refs/javadoc-3.2/api_classic/javacard/framework/TransactionException.html#TransactionException(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: TransactionException reason code constants
    When the constant TransactionException.<reason_name> is accessed
    Then it represents the transaction error condition "<description>"

    Examples:
      | reason_name      | description                                                    |
      | IN_PROGRESS      | A transaction is already in progress                           |
      | NOT_IN_PROGRESS  | No transaction is currently in progress                        |
      | BUFFER_FULL      | Commit buffer is full                                          |
      | INTERNAL_FAILURE | Internal JCRE problem during transaction                       |
      | ILLEGAL_USE      | Transaction usage error                                        |

  # Source: [JavaCard 3.0.5 API, TransactionException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/TransactionException.html#TransactionException(short)
  # Source: [JavaCard 3.1 API, TransactionException](../../refs/javadoc-3.1/api_classic/javacard/framework/TransactionException.html#TransactionException(short)
  # Source: [JavaCard 3.2 API, TransactionException](../../refs/javadoc-3.2/api_classic/javacard/framework/TransactionException.html#TransactionException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: TransactionException construction with reason code
    When a TransactionException is constructed with reason IN_PROGRESS
    Then the exception is created with that reason code

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/TransactionException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/TransactionException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/TransactionException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: TransactionException.throwIt throws JCRE-owned instance
    When TransactionException.throwIt(TransactionException.BUFFER_FULL) is called
    Then a JCRE-owned TransactionException is thrown with reason BUFFER_FULL

  # ===================================================================
  # PINException (extends CardRuntimeException)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, PINException ](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PINException.html#PINException(fieldsummary)
  # Source: [JavaCard 3.1 API, PINException ](../../refs/javadoc-3.1/api_classic/javacard/framework/PINException.html#PINException(fieldsummary)
  # Source: [JavaCard 3.2 API, PINException ](../../refs/javadoc-3.2/api_classic/javacard/framework/PINException.html#PINException(fieldsummary)
  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: PINException reason code constants
    When the constant PINException.<reason_name> is accessed
    Then it represents the PIN error condition "<description>"

    Examples:
      | reason_name   | description                                                       |
      | ILLEGAL_VALUE | Input parameter value is out of bounds                            |
      | ILLEGAL_STATE | PIN state does not permit the requested operation                 |

  # Source: [JavaCard 3.0.5 API, PINException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PINException.html#PINException(short)
  # Source: [JavaCard 3.1 API, PINException](../../refs/javadoc-3.1/api_classic/javacard/framework/PINException.html#PINException(short)
  # Source: [JavaCard 3.2 API, PINException](../../refs/javadoc-3.2/api_classic/javacard/framework/PINException.html#PINException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: PINException construction with reason code
    When a PINException is constructed with reason ILLEGAL_VALUE
    Then the exception is created with that reason code

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PINException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/PINException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/PINException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: PINException.throwIt throws JCRE-owned instance
    When PINException.throwIt(PINException.ILLEGAL_VALUE) is called
    Then a JCRE-owned PINException is thrown with reason ILLEGAL_VALUE

  # ===================================================================
  # UserException (extends CardException -- checked)
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, UserException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/UserException.html)
  # Source: [JavaCard 3.1 API, UserException](../../refs/javadoc-3.1/api_classic/javacard/framework/UserException.html)
  # Source: [JavaCard 3.2 API, UserException](../../refs/javadoc-3.2/api_classic/javacard/framework/UserException.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: UserException default construction with reason 0
    When a UserException is constructed with no arguments
    Then the exception is created with reason 0

  # Source: [JavaCard 3.0.5 API, UserException](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/UserException.html#UserException(short)
  # Source: [JavaCard 3.1 API, UserException](../../refs/javadoc-3.1/api_classic/javacard/framework/UserException.html#UserException(short)
  # Source: [JavaCard 3.2 API, UserException](../../refs/javadoc-3.2/api_classic/javacard/framework/UserException.html#UserException(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: UserException construction with reason code
    When a UserException is constructed with reason 0x0042
    Then the exception is created with reason 0x0042

  # Source: [JavaCard 3.0.5 API, throwIt](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/UserException.html#throwIt(short)
  # Source: [JavaCard 3.1 API, throwIt](../../refs/javadoc-3.1/api_classic/javacard/framework/UserException.html#throwIt(short)
  # Source: [JavaCard 3.2 API, throwIt](../../refs/javadoc-3.2/api_classic/javacard/framework/UserException.html#throwIt(short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: UserException.throwIt throws JCRE-owned instance
    When UserException.throwIt(0x0042) is called
    Then a JCRE-owned UserException is thrown with reason 0x0042

  # ===================================================================
  # JCRE-owned Exception Instances -- General Properties
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, SystemException ](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SystemException.html#SystemException(classdescription)
  # Source: [JavaCard 3.1 API, SystemException ](../../refs/javadoc-3.1/api_classic/javacard/framework/SystemException.html#SystemException(classdescription)
  # Source: [JavaCard 3.2 API, SystemException ](../../refs/javadoc-3.2/api_classic/javacard/framework/SystemException.html#SystemException(classdescription)
  @v3.0.5 @v3.1 @v3.2
  Scenario: JCRE-owned exceptions are temporary Entry Point Objects
    Given a JCRE-owned exception instance (e.g., SystemException)
    Then it can be accessed from any applet context
    And references to it cannot be stored in class or instance variables
    And references to it cannot be stored in array components
