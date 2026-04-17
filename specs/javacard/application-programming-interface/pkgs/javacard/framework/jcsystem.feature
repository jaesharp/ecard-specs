@v3.0.5
@v3.1
@v3.2
Feature: JCSystem - Java Card System Class
  JCSystem includes methods to control applet execution, resource
  management, atomic transaction management, object deletion, and
  inter-applet object sharing. All methods are static. It also
  controls persistence and transience of objects.

  # -------------------------------------------------------------------
  # Transience Event Constants
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, JCSystem ](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.1 API, JCSystem ](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.2 API, JCSystem ](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Transience event code constants
    When the constant JCSystem.<constant_name> is accessed
    Then it indicates "<description>"

    Examples:
      | constant_name          | description                                                       |
      | NOT_A_TRANSIENT_OBJECT | Object is not transient                                           |
      | CLEAR_ON_RESET         | Contents cleared on card reset or power on                        |
      | CLEAR_ON_DESELECT      | Contents cleared on applet deselection or in CLEAR_ON_RESET cases |

  # -------------------------------------------------------------------
  # Memory Type Constants
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, JCSystem ](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.1 API, JCSystem ](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.2 API, JCSystem ](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Memory type constants
    When the constant JCSystem.<constant_name> is accessed
    Then it indicates "<description>"

    Examples:
      | constant_name                  | description                                |
      | MEMORY_TYPE_PERSISTENT         | Persistent memory type                     |
      | MEMORY_TYPE_TRANSIENT_DESELECT | Transient memory of CLEAR_ON_DESELECT type |
      | MEMORY_TYPE_TRANSIENT_RESET    | Transient memory of CLEAR_ON_RESET type    |

  # -------------------------------------------------------------------
  # Array Type Constants
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, JCSystem ](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.1 API, JCSystem ](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.2 API, JCSystem ](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: Array type constants
    When the constant JCSystem.<constant_name> is accessed
    Then it indicates the "<type>" array type

    Examples:
      | constant_name      | type    |
      | ARRAY_TYPE_BOOLEAN | boolean |
      | ARRAY_TYPE_BYTE    | byte    |
      | ARRAY_TYPE_SHORT   | short   |
      | ARRAY_TYPE_INT     | int     |
      | ARRAY_TYPE_OBJECT  | Object  |

  # -------------------------------------------------------------------
  # Array View Attribute Constants (3.2 only)
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, JCSystem ](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.1 API, JCSystem ](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  # Source: [JavaCard 3.2 API, JCSystem ](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#JCSystem(fieldsummary)
  @v3.2
  Scenario Outline: Array view attribute constants
    When the constant JCSystem.<constant_name> is accessed
    Then it configures an array view with the "<attribute>" attribute

    Examples:
      | constant_name      | attribute |
      | ATTR_READABLE_VIEW | read      |
      | ATTR_WRITABLE_VIEW | write     |

  # -------------------------------------------------------------------
  # Transient Array Creation
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.2 API, makeTransientByteArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte))
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeTransientByteArray creates a transient byte array
    Given the applet needs a transient byte array of length 32
    When JCSystem.makeTransientByteArray(32, CLEAR_ON_RESET) is called
    Then a byte array of length 32 is returned
    And the array is transient with CLEAR_ON_RESET semantics

  # Source: [JavaCard 3.0.5 API, makeTransientByteArray](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  # Source: [JavaCard 3.1 API, makeTransientByteArray](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  # Source: [JavaCard 3.2 API, makeTransientByteArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeTransientByteArray throws SystemException for negative length
    When JCSystem.makeTransientByteArray(-1, CLEAR_ON_RESET) is called
    Then a SystemException is thrown with reason ILLEGAL_VALUE

  # Source: [JavaCard 3.0.5 API, makeTransientByteArray](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  # Source: [JavaCard 3.1 API, makeTransientByteArray](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  # Source: [JavaCard 3.2 API, makeTransientByteArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeTransientByteArray throws SystemException for insufficient transient space
    When JCSystem.makeTransientByteArray is called with a length exceeding available transient memory
    Then a SystemException is thrown with reason NO_TRANSIENT_SPACE

  # Source: [JavaCard 3.0.5 API, makeTransientByteArray](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  # Source: [JavaCard 3.1 API, makeTransientByteArray](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  # Source: [JavaCard 3.2 API, makeTransientByteArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeTransientByteArray(short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeTransientByteArray throws SystemException for invalid event code
    When JCSystem.makeTransientByteArray(10, invalidEvent) is called
    Then a SystemException is thrown with reason ILLEGAL_VALUE

  # Source: [JavaCard 3.0.5 API, makeTransientShortArray](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeTransientShortArray(short,byte)
  # Source: [JavaCard 3.1 API, makeTransientShortArray](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeTransientShortArray(short,byte)
  # Source: [JavaCard 3.2 API, makeTransientShortArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeTransientShortArray(short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeTransientShortArray creates a transient short array
    When JCSystem.makeTransientShortArray(16, CLEAR_ON_DESELECT) is called
    Then a short array of length 16 is returned
    And the array is transient with CLEAR_ON_DESELECT semantics

  # Source: [JavaCard 3.0.5 API, makeTransientBooleanArray](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeTransientBooleanArray(short,byte)
  # Source: [JavaCard 3.1 API, makeTransientBooleanArray](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeTransientBooleanArray(short,byte)
  # Source: [JavaCard 3.2 API, makeTransientBooleanArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeTransientBooleanArray(short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeTransientBooleanArray creates a transient boolean array
    When JCSystem.makeTransientBooleanArray(8, CLEAR_ON_RESET) is called
    Then a boolean array of length 8 is returned

  # Source: [JavaCard 3.0.5 API, makeTransientObjectArray](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeTransientObjectArray(short,byte)
  # Source: [JavaCard 3.1 API, makeTransientObjectArray](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeTransientObjectArray(short,byte)
  # Source: [JavaCard 3.2 API, makeTransientObjectArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeTransientObjectArray(short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeTransientObjectArray creates a transient Object array
    When JCSystem.makeTransientObjectArray(4, CLEAR_ON_DESELECT) is called
    Then an Object array of length 4 is returned

  # -------------------------------------------------------------------
  # Transience Check
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, isTransient](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  # Source: [JavaCard 3.1 API, isTransient](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  # Source: [JavaCard 3.2 API, isTransient](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: isTransient returns NOT_A_TRANSIENT_OBJECT for persistent objects
    Given a persistent byte array
    When JCSystem.isTransient(theObj) is called
    Then the return value is NOT_A_TRANSIENT_OBJECT

  # Source: [JavaCard 3.0.5 API, isTransient](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  # Source: [JavaCard 3.1 API, isTransient](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  # Source: [JavaCard 3.2 API, isTransient](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: isTransient returns CLEAR_ON_RESET for transient reset arrays
    Given a byte array created with makeTransientByteArray(CLEAR_ON_RESET)
    When JCSystem.isTransient(theObj) is called
    Then the return value is CLEAR_ON_RESET

  # Source: [JavaCard 3.0.5 API, isTransient](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  # Source: [JavaCard 3.1 API, isTransient](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  # Source: [JavaCard 3.2 API, isTransient](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#isTransient(Object)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: isTransient returns CLEAR_ON_DESELECT for transient deselect arrays
    Given a byte array created with makeTransientByteArray(CLEAR_ON_DESELECT)
    When JCSystem.isTransient(theObj) is called
    Then the return value is CLEAR_ON_DESELECT

  # -------------------------------------------------------------------
  # Global Arrays
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, makeGlobalArray](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeGlobalArray(byte,short)
  # Source: [JavaCard 3.1 API, makeGlobalArray](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeGlobalArray(byte,short)
  # Source: [JavaCard 3.2 API, makeGlobalArray](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeGlobalArray(byte,short)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: makeGlobalArray creates a global CLEAR_ON_RESET transient array
    When JCSystem.makeGlobalArray(ARRAY_TYPE_BYTE, 64) is called
    Then a global CLEAR_ON_RESET transient byte array of length 64 is returned
    And the array is accessible from any applet context

  # -------------------------------------------------------------------
  # Transaction Control
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, beginTransaction](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#beginTransaction)
  # Source: [JavaCard 3.1 API, beginTransaction](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#beginTransaction)
  # Source: [JavaCard 3.2 API, beginTransaction](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#beginTransaction)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: beginTransaction starts an atomic transaction
    Given no transaction is in progress
    When JCSystem.beginTransaction() is called
    Then an atomic transaction begins
    And updates to persistent data are journaled

  # Source: [JavaCard 3.0.5 API, beginTransaction](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#beginTransaction)
  # Source: [JavaCard 3.1 API, beginTransaction](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#beginTransaction)
  # Source: [JavaCard 3.2 API, beginTransaction](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#beginTransaction)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: beginTransaction throws TransactionException if already in progress
    Given a transaction is already in progress
    When JCSystem.beginTransaction() is called
    Then a TransactionException is thrown with reason IN_PROGRESS

  # Source: [JavaCard 3.0.5 API, commitTransaction](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#commitTransaction)
  # Source: [JavaCard 3.1 API, commitTransaction](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#commitTransaction)
  # Source: [JavaCard 3.2 API, commitTransaction](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#commitTransaction)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: commitTransaction commits all journaled updates atomically
    Given a transaction is in progress with pending updates
    When JCSystem.commitTransaction() is called
    Then all pending updates are committed atomically

  # Source: [JavaCard 3.0.5 API, commitTransaction](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#commitTransaction)
  # Source: [JavaCard 3.1 API, commitTransaction](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#commitTransaction)
  # Source: [JavaCard 3.2 API, commitTransaction](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#commitTransaction)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: commitTransaction throws TransactionException if no transaction in progress
    Given no transaction is in progress
    When JCSystem.commitTransaction() is called
    Then a TransactionException is thrown with reason NOT_IN_PROGRESS

  # Source: [JavaCard 3.0.5 API, abortTransaction](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#abortTransaction)
  # Source: [JavaCard 3.1 API, abortTransaction](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#abortTransaction)
  # Source: [JavaCard 3.2 API, abortTransaction](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#abortTransaction)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: abortTransaction discards all pending updates
    Given a transaction is in progress with pending updates
    When JCSystem.abortTransaction() is called
    Then all pending updates are discarded
    And persistent data reverts to state before beginTransaction

  # Source: [JavaCard 3.0.5 API, abortTransaction](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#abortTransaction)
  # Source: [JavaCard 3.1 API, abortTransaction](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#abortTransaction)
  # Source: [JavaCard 3.2 API, abortTransaction](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#abortTransaction)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: abortTransaction throws TransactionException if no transaction in progress
    Given no transaction is in progress
    When JCSystem.abortTransaction() is called
    Then a TransactionException is thrown with reason NOT_IN_PROGRESS

  # Source: [JavaCard 3.0.5 API, getTransactionDepth](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getTransactionDepth)
  # Source: [JavaCard 3.1 API, getTransactionDepth](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getTransactionDepth)
  # Source: [JavaCard 3.2 API, getTransactionDepth](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getTransactionDepth)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getTransactionDepth returns 0 when no transaction in progress
    Given no transaction is in progress
    When JCSystem.getTransactionDepth() is called
    Then the return value is 0

  # Source: [JavaCard 3.0.5 API, getTransactionDepth](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getTransactionDepth)
  # Source: [JavaCard 3.1 API, getTransactionDepth](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getTransactionDepth)
  # Source: [JavaCard 3.2 API, getTransactionDepth](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getTransactionDepth)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getTransactionDepth returns 1 when a transaction is in progress
    Given a transaction is in progress
    When JCSystem.getTransactionDepth() is called
    Then the return value is 1

  # Source: [JavaCard 3.0.5 API, getMaxCommitCapacity](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getMaxCommitCapacity)
  # Source: [JavaCard 3.1 API, getMaxCommitCapacity](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getMaxCommitCapacity)
  # Source: [JavaCard 3.2 API, getMaxCommitCapacity](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getMaxCommitCapacity)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getMaxCommitCapacity returns total commit buffer size
    When JCSystem.getMaxCommitCapacity() is called
    Then a short value representing total commit buffer bytes is returned

  # Source: [JavaCard 3.0.5 API, getUnusedCommitCapacity](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getUnusedCommitCapacity)
  # Source: [JavaCard 3.1 API, getUnusedCommitCapacity](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getUnusedCommitCapacity)
  # Source: [JavaCard 3.2 API, getUnusedCommitCapacity](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getUnusedCommitCapacity)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getUnusedCommitCapacity returns remaining commit buffer bytes
    When JCSystem.getUnusedCommitCapacity() is called
    Then a short value representing remaining commit buffer bytes is returned

  # -------------------------------------------------------------------
  # AID Lookup and Applet Information
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, getAID](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getAID)
  # Source: [JavaCard 3.1 API, getAID](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getAID)
  # Source: [JavaCard 3.2 API, getAID](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAID)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getAID returns the current applet's AID
    Given an applet that has called register()
    When JCSystem.getAID() is called from within that applet
    Then the JCRE-owned AID instance for the current applet is returned

  # Source: [JavaCard 3.0.5 API, getAID](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getAID)
  # Source: [JavaCard 3.1 API, getAID](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getAID)
  # Source: [JavaCard 3.2 API, getAID](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAID)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getAID returns null if register has not been called
    Given an applet that has not called register()
    When JCSystem.getAID() is called
    Then null is returned

  # Source: [JavaCard 3.0.5 API, lookupAID](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#lookupAID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, lookupAID](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#lookupAID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, lookupAID](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#lookupAID(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: lookupAID returns AID of an installed applet
    Given an applet is installed with a known AID
    And a byte array containing that AID
    When JCSystem.lookupAID(buffer, offset, length) is called
    Then the JCRE-owned AID instance for that applet is returned

  # Source: [JavaCard 3.0.5 API, lookupAID](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#lookupAID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, lookupAID](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#lookupAID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, lookupAID](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#lookupAID(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: lookupAID returns null for unknown AID
    Given no applet is installed with the specified AID
    When JCSystem.lookupAID(buffer, offset, length) is called
    Then null is returned

  # Source: [JavaCard 3.0.5 API, getPreviousContextAID](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getPreviousContextAID)
  # Source: [JavaCard 3.1 API, getPreviousContextAID](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getPreviousContextAID)
  # Source: [JavaCard 3.2 API, getPreviousContextAID](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getPreviousContextAID)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getPreviousContextAID returns AID of previous context
    Given applet A calls applet B via shareable interface
    When JCSystem.getPreviousContextAID() is called from applet B's context
    Then the AID of applet A is returned

  # Source: [JavaCard 3.0.5 API, getAppletShareableInterfaceObject](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getAppletShareableInterfaceObject(AID,byte)
  # Source: [JavaCard 3.1 API, getAppletShareableInterfaceObject](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getAppletShareableInterfaceObject(AID,byte)
  # Source: [JavaCard 3.2 API, getAppletShareableInterfaceObject](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAppletShareableInterfaceObject(AID,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getAppletShareableInterfaceObject obtains a shareable interface
    Given a server applet with a shareable interface
    When JCSystem.getAppletShareableInterfaceObject(serverAID, parameter) is called
    Then the server applet's getShareableInterfaceObject is invoked
    And the resulting Shareable object is returned to the client

  # Source: [JavaCard 3.0.5 API, isAppletActive](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#isAppletActive(AID)
  # Source: [JavaCard 3.1 API, isAppletActive](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#isAppletActive(AID)
  # Source: [JavaCard 3.2 API, isAppletActive](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#isAppletActive(AID)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: isAppletActive returns true for an active applet
    Given an applet is currently selected on a logical channel
    When JCSystem.isAppletActive(theAppletAID) is called
    Then the result is true

  # -------------------------------------------------------------------
  # Memory Information
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, getAvailableMemory](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(byte)
  # Source: [JavaCard 3.1 API, getAvailableMemory](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(byte)
  # Source: [JavaCard 3.2 API, getAvailableMemory](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getAvailableMemory returns available memory for specified type
    When JCSystem.getAvailableMemory(MEMORY_TYPE_PERSISTENT) is called
    Then a short value indicating available persistent memory is returned

  # Source: [JavaCard 3.0.5 API, getAvailableMemory](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(short%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getAvailableMemory](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(short%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getAvailableMemory](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(short%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getAvailableMemory with short array buffer stores 32-bit result
    Given a short array buffer of length 2
    When JCSystem.getAvailableMemory(buffer, 0, MEMORY_TYPE_PERSISTENT) is called
    Then the available memory in bytes is stored as two shorts (high word, low word)

  # Source: [JavaCard 3.0.5 API, getAvailableMemory](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getAvailableMemory](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getAvailableMemory](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAvailableMemory(byte%5B%5D,short,byte)
  @v3.1
  @v3.2
  Scenario: getAvailableMemory with byte array buffer stores 32-bit result
    Given a byte array buffer of length 4
    When JCSystem.getAvailableMemory(buffer, 0, MEMORY_TYPE_PERSISTENT) is called
    Then the available memory in bytes is stored as 4 bytes (big-endian)

  # -------------------------------------------------------------------
  # Logical Channel and Version
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.1 API, getAssignedChannel](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getAssignedChannel)
  # Source: [JavaCard 3.2 API, getAssignedChannel](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAssignedChannel)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getAssignedChannel returns the current logical channel number
    Given an applet selected on logical channel 2
    When JCSystem.getAssignedChannel() is called
    Then the return value is 2

  # Source: [JavaCard 3.0.5 API, getVersion](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#getVersion)
  # Source: [JavaCard 3.1 API, getVersion](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#getVersion)
  # Source: [JavaCard 3.2 API, getVersion](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getVersion)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getVersion returns major and minor API version
    When JCSystem.getVersion() is called
    Then a short value is returned with major version in high byte and minor version in low byte

  # -------------------------------------------------------------------
  # Object Deletion
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, isObjectDeletionSupported](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#isObjectDeletionSupported)
  # Source: [JavaCard 3.1 API, isObjectDeletionSupported](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#isObjectDeletionSupported)
  # Source: [JavaCard 3.2 API, isObjectDeletionSupported](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#isObjectDeletionSupported)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: isObjectDeletionSupported indicates platform capability
    When JCSystem.isObjectDeletionSupported() is called
    Then true or false is returned based on platform support

  # Source: [JavaCard 3.0.5 API, requestObjectDeletion](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#requestObjectDeletion)
  # Source: [JavaCard 3.1 API, requestObjectDeletion](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#requestObjectDeletion)
  # Source: [JavaCard 3.2 API, requestObjectDeletion](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#requestObjectDeletion)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: requestObjectDeletion triggers the garbage collector
    Given object deletion is supported
    When JCSystem.requestObjectDeletion() is called
    Then the JCRE reclaims unreferenced persistent objects

  # Source: [JavaCard 3.0.5 API, requestObjectDeletion](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#requestObjectDeletion)
  # Source: [JavaCard 3.1 API, requestObjectDeletion](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#requestObjectDeletion)
  # Source: [JavaCard 3.2 API, requestObjectDeletion](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#requestObjectDeletion)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: requestObjectDeletion throws SystemException if not supported
    Given object deletion is not supported
    When JCSystem.requestObjectDeletion() is called
    Then a SystemException is thrown with reason ILLEGAL_USE

  # -------------------------------------------------------------------
  # Array Views (3.2 only)
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, makeByteArrayView](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/JCSystem.html#makeByteArrayView(byte%5B%5D,short,short,short,Shareable)
  # Source: [JavaCard 3.1 API, makeByteArrayView](../../../.refs/javadoc-3.1/api_classic/javacard/framework/JCSystem.html#makeByteArrayView(byte%5B%5D,short,short,short,Shareable)
  # Source: [JavaCard 3.2 API, makeByteArrayView](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeByteArrayView(byte%5B%5D,short,short,short,Shareable)
  @v3.2
  Scenario: makeByteArrayView creates a view on a byte array
    Given a persistent byte array of length 100
    When JCSystem.makeByteArrayView(array, 10, 20, ATTR_READABLE_VIEW, service) is called
    Then a byte array view of length 20 starting at offset 10 is returned
    And the view has read-only access

  # Source: [JavaCard 3.2 API, makeShortArrayView](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeShortArrayView(short%5B%5D,short,short,short,Shareable))
  @v3.2
  Scenario: makeShortArrayView creates a view on a short array
    Given a persistent short array of length 50
    When JCSystem.makeShortArrayView(array, 0, 10, ATTR_WRITABLE_VIEW, service) is called
    Then a short array view of length 10 is returned
    And the view has write access

  # Source: [JavaCard 3.2 API, makeBooleanArrayView](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeBooleanArrayView(boolean%5B%5D,short,short,short,Shareable))
  @v3.2
  Scenario: makeBooleanArrayView creates a view on a boolean array
    Given a persistent boolean array
    When JCSystem.makeBooleanArrayView(array, offset, length, attributes, service) is called
    Then a boolean array view is returned

  # Source: [JavaCard 3.2 API, makeArrayView](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#makeArrayView(Object,short,short,short,Shareable))
  @v3.2
  Scenario: makeArrayView creates a generic array view
    Given an array of any supported type
    When JCSystem.makeArrayView(array, offset, length, attributes, service) is called
    Then an array view is returned

  # Source: [JavaCard 3.2 API, isArrayView](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#isArrayView(Object))
  @v3.2
  Scenario: isArrayView returns true for an array view
    Given an array view created with makeByteArrayView
    When JCSystem.isArrayView(object) is called
    Then the result is true

  # Source: [JavaCard 3.2 API, isArrayView](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#isArrayView(Object))
  @v3.2
  Scenario: isArrayView returns false for a regular array
    Given a standard byte array
    When JCSystem.isArrayView(object) is called
    Then the result is false

  # Source: [JavaCard 3.2 API, getAttributes](../../../.refs/javadoc-3.2/api_classic/javacard/framework/JCSystem.html#getAttributes(Object))
  @v3.2
  Scenario: getAttributes returns the attributes of an array view
    Given a byte array view created with ATTR_READABLE_VIEW
    When JCSystem.getAttributes(view) is called
    Then ATTR_READABLE_VIEW is returned
