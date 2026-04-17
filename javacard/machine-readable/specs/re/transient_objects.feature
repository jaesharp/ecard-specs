@jcre
@transient-objects
Feature: Transient Objects
  The Java Card platform does not support the Java programming language keyword
  transient. Instead, Java Card technology provides methods to create transient
  arrays with primitive components or references to Object. Only the contents
  (fields) of a transient object have a transient nature -- the object itself
  persists as long as it is referenced. When a transient object is created, one
  of two events is specified that causes its fields to be cleared.

  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5 Memory Model](../../refs/3.1/JCRESpec_3.1.pdf#page=45)
  # Source: [JCRE 3.2, s5 Memory Model](../../refs/3.2/JCRESpec_3.2.pdf#page=47)
  Background:
    Given a Java Card secure element with a compliant JCRE implementation
    And the Java Card RE is initialized

  # ---------------------------------------------------------------------------
  # 5.1 Transient Objects
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5.1 Transient Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1 Transient Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Transient object existence and persistence of the object itself
    Given a transient object is created via a JCSystem factory method
    Then the object itself exists as long as it is referenced from the stack, local variables, a static field, or a field in another object
    And only the contents (fields) of the object are transient, not the object reference itself

  # ---------------------------------------------------------------------------
  # 5.1.1 Transient Objects Characteristics
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5.1.1 Transient Objects Characteristics](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.1 Transient Objects Characteristics](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Transient fields cleared to default on specified event
    Given a transient object has been created with a specified clear event
    When the specified clear event occurs
    Then the fields of the transient object shall be cleared to the field's default value
    And the default values are zero for numeric types, false for boolean, and null for references

  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5.1.1 Transient Objects Characteristics](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.1 Transient Objects Characteristics](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Transient fields never stored in persistent memory
    Given a transient object has been created
    Then the fields of the transient object shall never be stored in persistent memory technology
    And using current smart card technology, transient object contents can be stored in RAM but never in EEPROM
    And this allows transient objects to be used to store session keys securely

  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5.1.1 Transient Objects Characteristics](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.1 Transient Objects Characteristics](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: No write performance penalty for transient fields
    Given a transient object has been created
    Then writes to the fields of the transient object shall not have a performance penalty
    And transient object contents stored in RAM have a much faster write cycle time than EEPROM

  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5.1.1 Transient Objects Characteristics](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.1 Transient Objects Characteristics](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Transient fields not affected by abortTransaction
    Given a transient object has been created
    And a transaction is in progress
    When the fields of the transient object are modified during the transaction
    And JCSystem.abortTransaction is called
    Then the transient object fields shall NOT be restored to their previous values
    And the transient field retains the value written during the transaction

  # ---------------------------------------------------------------------------
  # 5.1.2 Events That Clear Transient Objects
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s5.1 Events That Clear Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=42)
  # Source: [JCRE 3.1, s5.1.2 Events That Clear Transient Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.2 Events That Clear Transient Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_RESET event clears transient fields
    Given a transient object was created with CLEAR_ON_RESET event type
    When the card is reset (warm or cold reset)
    Then the object's fields (except for the length field) are cleared
    And when a card is powered on, this also causes a card reset and triggers clearing

  # Source: [JCRE 3.0.5, s5.1 Events That Clear Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=42)
  # Source: [JCRE 3.1, s5.1.2 Events That Clear Transient Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.2 Events That Clear Transient Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_RESET preserves across applet selections
    Given a transient object was created with CLEAR_ON_RESET event type
    And the object contains data written by the owning applet
    When the owning applet is deselected and another applet is selected
    Then the CLEAR_ON_RESET transient object fields are preserved
    And the data is available when the owning applet is selected again (within the same power session)

  # Source: [JCRE 3.0.5, s5.1 Events That Clear Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=42)
  # Source: [JCRE 3.1, s5.1.2 Events That Clear Transient Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.2 Events That Clear Transient Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_RESET guarantees data cannot be recovered after power loss
    Given a transient object was created with CLEAR_ON_RESET event type
    Then it is not necessary to clear the fields before power is removed
    But it is necessary to guarantee that the previous contents of such fields cannot be recovered once power is lost

  # Source: [JCRE 3.0.5, s5.1 Events That Clear Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=42)
  # Source: [JCRE 3.1, s5.1.2 Events That Clear Transient Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.2 Events That Clear Transient Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_DESELECT event clears transient fields
    Given a transient object was created with CLEAR_ON_DESELECT event type
    When the owning applet is deselected and no other applets from the same context are active on the card
    Then the object's fields (except for the length field) are cleared
    And because a card reset implicitly deselects the currently selected applet, CLEAR_ON_DESELECT fields are also cleared by the same events as CLEAR_ON_RESET

  # Source: [JCRE 3.0.5, s5.1 Events That Clear Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=42)
  # Source: [JCRE 3.1, s5.1.2 Events That Clear Transient Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=46)
  # Source: [JCRE 3.2, s5.1.2 Events That Clear Transient Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=48)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_DESELECT triggered by explicit deselection
    Given a transient object was created with CLEAR_ON_DESELECT event type
    And the applet is the currently selected applet
    When a SELECT FILE command or MANAGE CHANNEL CLOSE command deselects the applet
    And no other applets from the same context are active on the card
    Then the CLEAR_ON_DESELECT transient object fields are cleared
    And this occurs regardless of whether the SELECT FILE fails, selects a different applet, or reselects the same applet

  # ---------------------------------------------------------------------------
  # 5.2 Temporary Objects
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5.2 Temporary Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=47)
  # Source: [JCRE 3.2, s5.2 Temporary Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=49)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Temporary objects definition and restrictions
    Given temporary objects are short-lived objects for current execution flow computations
    Then they can only be referenced from the execution stack as local variables or method parameters
    And the Java Card RE detects and restricts attempts to store references to temporary objects
    And attempts to store references are restricted as part of the firewall functionality

  # Source: [JCRE 3.0.5, s5 Transient Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=41)
  # Source: [JCRE 3.1, s5.2 Temporary Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=47)
  # Source: [JCRE 3.2, s5.2 Temporary Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=49)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Examples of temporary objects
    Then the following are designated as temporary objects by the Java Card RE:
      | object type            | description                                                        |
      | APDU object            | JCRE Entry Point Object; temporary                                 |
      | JCRE exception objects | All Java Card RE owned exception objects are temporary             |
      | Global arrays          | All global arrays are temporary; the APDU buffer is a global array |
      | Array views            | All array views are temporary objects                              |

  # ---------------------------------------------------------------------------
  # 5.3 Array Views (3.1+ feature)
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.1, s5.3 Array views](../../refs/3.1/JCRESpec_3.1.pdf#page=48)
  # Source: [JCRE 3.2, s5.3 Array views](../../refs/3.2/JCRESpec_3.2.pdf#page=50)
  @v3.1
  @v3.2
  Scenario: Array view characteristics
    Given an array view is created via JCSystem.makeArrayView()
    Then the array view is an array from the Java language perspective and uses the same bytecodes
    And the view elements are mapped to a subset of the actual parent array
    And modifications in the parent array are visible in the view and vice versa
    And the view elements have the exact same type as the parent array elements
    And the view has configurable read/write access rights specified at creation time
    And the view is a temporary object and cannot be stored in class variables, instance variables, or array components
    And the parent array cannot be garbage collected if an array view mapping its elements still exists

  # Source: [JCRE 3.1, s5.3.2 Creating and Using an Array View](../../refs/3.1/JCRESpec_3.1.pdf#page=49)
  # Source: [JCRE 3.2, s5.3.2 Creating and Using an Array View](../../refs/3.2/JCRESpec_3.2.pdf#page=51)
  @v3.1
  @v3.2
  Scenario: Array view creation precondition checks
    When creating an array view the following preconditions are checked:
      | check                                                                                        |
      | The source must be an array accessible from the context creating the view                    |
      | When source is CLEAR_ON_DESELECT transient, active context must be currently selected applet |
      | The range of elements must not go beyond the boundaries of the source array                  |
      | If source is a view, the new view maps actual array elements within the source view range    |
      | The view shall not be granted access rights not allowed on the source array                  |
    Then a view violating any precondition shall not be created
