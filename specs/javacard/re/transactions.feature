@jcre
@transactions
Feature: Transactions and Atomicity
  A transaction is a logical set of updates of persistent data. The Java Card RE
  provides robust support for atomic transactions, so that card data is restored
  to its original pre-transaction state if the transaction does not complete
  normally. This protects against power loss in the middle of a transaction and
  against program errors that might cause data corruption.

  # Source: [JCRE 3.0.5, s7 Transactions and Atomicity](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7 Transactions and Atomicity](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7 Transactions and Atomicity](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  Background:
    Given a Java Card secure element with a compliant JCRE implementation
    And the Java Card RE is initialized

  # ---------------------------------------------------------------------------
  # 7.1 Atomicity
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.1 Atomicity](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.1 Atomicity](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.1 Atomicity](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Single field atomicity guarantee
    Given an update is being performed on a single persistent object field or single class field
    When power is lost during the update
    Then the applet developer shall be able to rely on what the field contains when power is restored
    And the field shall either contain the new value or be restored to its previous value

  # Source: [JCRE 3.0.5, s7.1 Atomicity](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.1 Atomicity](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.1 Atomicity](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Single array component atomicity guarantee
    Given an update is being performed on a single array component of a persistent array
    When power is lost during the update
    Then the array component shall be preserved across CAD sessions
    And the data element shall be restored to its previous value if the update was incomplete

  # Source: [JCRE 3.0.5, s7.1 Atomicity](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.1 Atomicity](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.1 Atomicity](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Block atomicity via Util.arrayCopy
    Given the Util.arrayCopy method is used to copy data
    Then the method guarantees block atomicity
    And either all bytes are correctly copied or the destination array is restored to its previous byte values

  # Source: [JCRE 3.0.5, s7.1 Atomicity](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.1 Atomicity](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.1 Atomicity](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Util.arrayCopyNonAtomic provides no atomicity
    Given the Util.arrayCopyNonAtomic method is used to copy data
    Then the method does not provide atomicity guarantees
    And it does not use the transaction commit buffer even when called with a transaction in progress

  # ---------------------------------------------------------------------------
  # 7.2 Transactions
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.2 Transactions](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.2 Transactions](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.2 Transactions](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: beginTransaction starts atomic set of updates
    Given an applet needs to atomically update several different fields or array components
    When the applet calls JCSystem.beginTransaction
    Then each object update after this point is conditionally updated
    And reading the field or array component back yields its latest conditional value
    But the update is not yet committed to persistent storage

  # Source: [JCRE 3.0.5, s7.2 Transactions](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.2 Transactions](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.2 Transactions](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: commitTransaction commits all conditional updates
    Given a transaction is in progress with conditional updates
    When the applet calls JCSystem.commitTransaction
    Then all conditional updates are committed to persistent storage atomically
    And the transaction is complete

  # Source: [JCRE 3.0.5, s7.2 Transactions](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.2 Transactions](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.2 Transactions](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: abortTransaction undoes all conditional updates
    Given a transaction is in progress with conditional updates
    When the applet calls JCSystem.abortTransaction
    Then all conditionally updated fields and array components are restored to their previous values
    And the transaction is cancelled

  # Source: [JCRE 3.0.5, s7.2 Transactions](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=59)
  # Source: [JCRE 3.1, s7.2 Transactions](../refs/3.1/JCRESpec_3.1.pdf#page=67)
  # Source: [JCRE 3.2, s7.2 Transactions](../refs/3.2/JCRESpec_3.2.pdf#page=69)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Failure prior to commitTransaction restores previous values
    Given a transaction is in progress with conditional updates
    When power is lost or some other system failure occurs prior to completion of commitTransaction
    Then all conditionally updated fields or array components are restored to their previous values

  # ---------------------------------------------------------------------------
  # 7.3 Transaction Duration
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.3 Transaction Duration](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=60)
  # Source: [JCRE 3.1, s7.3 Transaction Duration](../refs/3.1/JCRESpec_3.1.pdf#page=68)
  # Source: [JCRE 3.2, s7.3 Transaction Duration](../refs/3.2/JCRESpec_3.2.pdf#page=70)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Transaction ends on return from applet methods
    Given a transaction is in progress
    When the Java Card RE regains programmatic control upon return from select, deselect, process, install, or uninstall methods
    Then the transaction always ends
    And this is true whether the transaction ends normally with commitTransaction or with an abortion

  # Source: [JCRE 3.0.5, s7.3 Transaction Duration](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=60)
  # Source: [JCRE 3.1, s7.3 Transaction Duration](../refs/3.1/JCRESpec_3.1.pdf#page=68)
  # Source: [JCRE 3.2, s7.3 Transaction Duration](../refs/3.2/JCRESpec_3.2.pdf#page=70)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Transaction duration definition
    Given a transaction has started
    Then the transaction duration is the life of the transaction between the call to beginTransaction
    And either a call to commitTransaction or an abortion of the transaction

  # ---------------------------------------------------------------------------
  # 7.4 Nested Transactions
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.4 Nested Transactions](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=60)
  # Source: [JCRE 3.1, s7.4 Nested Transactions](../refs/3.1/JCRESpec_3.1.pdf#page=68)
  # Source: [JCRE 3.2, s7.4 Nested Transactions](../refs/3.2/JCRESpec_3.2.pdf#page=70)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Nested transactions not supported
    Given a transaction is already in progress
    When JCSystem.beginTransaction is called again
    Then a TransactionException shall be thrown
    And there can be only one transaction in progress at a time

  # Source: [JCRE 3.0.5, s7.4 Nested Transactions](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=60)
  # Source: [JCRE 3.1, s7.4 Nested Transactions](../refs/3.1/JCRESpec_3.1.pdf#page=68)
  # Source: [JCRE 3.2, s7.4 Nested Transactions](../refs/3.2/JCRESpec_3.2.pdf#page=70)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getTransactionDepth reports transaction state
    Given the JCSystem.getTransactionDepth method is called
    Then it returns 0 if no transaction is in progress
    And it returns 1 if a transaction is in progress

  # ---------------------------------------------------------------------------
  # 7.5 Tear or Reset Transaction Failure
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.5 Tear or Reset Transaction Failure](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=60)
  # Source: [JCRE 3.1, s7.5 Tear or Reset Transaction Failure](../refs/3.1/JCRESpec_3.1.pdf#page=68)
  # Source: [JCRE 3.2, s7.5 Tear or Reset Transaction Failure](../refs/3.2/JCRESpec_3.2.pdf#page=70)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Tear or reset restores all conditional updates
    Given a transaction is in progress
    When power is lost (tear) or the card is reset or some other system failure occurs
    Then the Java Card RE shall restore to their previous values all fields and array components conditionally updated since the previous call to beginTransaction
    And this is performed automatically when the Java Card RE reinitializes the card after recovering

  # Source: [JCRE 3.0.5, s7.5 Tear or Reset Transaction Failure](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=60)
  # Source: [JCRE 3.1, s7.5 Tear or Reset Transaction Failure](../refs/3.1/JCRESpec_3.1.pdf#page=68)
  # Source: [JCRE 3.2, s7.5 Tear or Reset Transaction Failure](../refs/3.2/JCRESpec_3.2.pdf#page=70)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: arrayCopyNonAtomic and arrayFillNonAtomic unpredictable after tear
    Given a transaction is in progress
    And Util.arrayCopyNonAtomic or Util.arrayFillNonAtomic has been used during the transaction
    When power is lost or a tear occurs during that transaction
    Then the contents of array components updated using arrayCopyNonAtomic or arrayFillNonAtomic are not predictable
    And no guarantees are provided about their state

  # Source: [JCRE 3.0.5, s7.5 Tear or Reset Transaction Failure](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=60)
  # Source: [JCRE 3.1, s7.5 Tear or Reset Transaction Failure](../refs/3.1/JCRESpec_3.1.pdf#page=68)
  # Source: [JCRE 3.2, s7.5 Tear or Reset Transaction Failure](../refs/3.2/JCRESpec_3.2.pdf#page=70)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object space from failed transaction may be recovered
    Given a transaction failed due to power loss or card reset
    And object instances were created during that transaction
    Then the object space used by those instances may be recovered by the Java Card RE

  # ---------------------------------------------------------------------------
  # 7.6 Aborting a Transaction
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.6.1 Programmatic Abortion](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.6.1 Programmatic Abortion](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.6.1 Programmatic Abortion](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Programmatic abort via abortTransaction
    Given a transaction is in progress
    When the applet calls JCSystem.abortTransaction
    Then all conditionally updated fields and array components since the call to beginTransaction are restored to their previous values
    And JCSystem.getTransactionDepth is reset to 0

  # Source: [JCRE 3.0.5, s7.6.2 Abortion by the Java Card RE](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.6.2 Abortion by the Java Card RE](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.6.2 Abortion by the Java Card RE](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Abortion by the Java Card RE on return with active transaction
    Given an applet returns from select, deselect, process, install, or uninstall
    And an applet-initiated transaction is in progress
    Then the Java Card RE automatically aborts the transaction
    And proceeds as if an uncaught exception was thrown
    And in the case of the select method, selection fails

  # Source: [JCRE 3.0.5, s7.6.2 Abortion by the Java Card RE](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.6.2 Abortion by the Java Card RE](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.6.2 Abortion by the Java Card RE](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Abortion by Java Card RE on uncaught exception during transaction
    Given an uncaught exception is caught by the Java Card RE from select, deselect, process, install, or uninstall
    And an applet-initiated transaction is in progress
    Then the Java Card RE automatically aborts the transaction

  # Source: [JCRE 3.0.5, s7.6.2 Abortion by the Java Card RE](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.6.2 Abortion by the Java Card RE](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.6.2 Abortion by the Java Card RE](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Abort during process results in uncaught exception processing
    Given a transaction is in progress during the process method
    When the Java Card RE aborts the transaction
    Then the response status is determined as described for uncaught exceptions from process
    And the status word ISO7816.SW_UNKNOWN is returned to the CAD

  # ---------------------------------------------------------------------------
  # 7.6.3 Cleanup Responsibilities
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.6.3 Cleanup Responsibilities of the Java Card RE](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.6.3 Cleanup Responsibilities of the Java Card RE](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.6.3 Cleanup Responsibilities of the Java Card RE](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: References to objects created during aborted transaction become null
    Given a transaction is in progress
    And new object instances are created during the transaction
    When the transaction is aborted
    Then references to objects deleted during the aborted transaction can no longer be used to access those objects
    And the Java Card RE shall ensure that such a reference is equivalent to a null reference

  # Source: [JCRE 3.0.5, s7.6.3 Cleanup Responsibilities of the Java Card RE](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.6.3 Cleanup Responsibilities of the Java Card RE](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.6.3 Cleanup Responsibilities of the Java Card RE](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Programmatic abort after object creation may lock up card session
    Given a transaction is in progress
    And objects were created after beginning the transaction
    When JCSystem.abortTransaction is called programmatically
    Then this is deemed to be a programming error
    And the Java Card RE may lock up the card session to force tear or reset processing
    And this is to ensure the security of the card and avoid heap space loss

  # ---------------------------------------------------------------------------
  # 7.7 Transient Objects and Global Arrays
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.7 Transient Objects and Global Arrays](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.7 Transient Objects and Global Arrays](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.7 Transient Objects and Global Arrays](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Transient objects and global arrays excluded from transactions
    Given a transaction is in progress
    When updates are made to transient objects or global arrays
    Then those updates are NOT part of the transaction
    And only updates to persistent objects participate in the transaction
    And updates to transient objects and global arrays are never undone regardless of transaction outcome

  # ---------------------------------------------------------------------------
  # 7.8 Commit Capacity
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.8 Commit Capacity](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.8 Commit Capacity](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.8 Commit Capacity](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Commit capacity limit
    Given platform resources are limited
    Then the number of bytes of conditionally updated data that can be accumulated during a transaction is limited
    And the Java Card technology provides methods to determine how much commit capacity is available
    And the commit capacity represents an upper bound on the number of conditional byte updates available
    And the actual number may be lower due to management overhead

  # Source: [JCRE 3.0.5, s7.8 Commit Capacity](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=61)
  # Source: [JCRE 3.1, s7.8 Commit Capacity](../refs/3.1/JCRESpec_3.1.pdf#page=69)
  # Source: [JCRE 3.2, s7.8 Commit Capacity](../refs/3.2/JCRESpec_3.2.pdf#page=71)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: TransactionException on commit capacity exceeded
    Given a transaction is in progress
    When the commit capacity is exceeded during a transaction
    Then a TransactionException shall be thrown

  # ---------------------------------------------------------------------------
  # 7.9 Context Switching
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s7.9 Context Switching](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=62)
  # Source: [JCRE 3.1, s7.9 Context Switching](../refs/3.1/JCRESpec_3.1.pdf#page=70)
  # Source: [JCRE 3.2, s7.9 Context Switching](../refs/3.2/JCRESpec_3.2.pdf#page=72)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Context switches do not alter transaction state
    Given a transaction is in progress
    When a context switch occurs (e.g., via shareable interface method invocation)
    Then the context switch shall not alter the state of the transaction in progress
    And updates to persistent data continue to be conditional in the new context
    And the transaction persists until it is committed or aborted
