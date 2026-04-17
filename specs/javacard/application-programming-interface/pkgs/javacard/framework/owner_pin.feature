@v3.0.5
@v3.1
@v3.2
Feature: PIN, OwnerPIN, OwnerPINBuilder, OwnerPINx, and OwnerPINxWithPredecrement
  The PIN interface defines personal identification number functionality.
  OwnerPIN is the concrete implementation with update capability.
  OwnerPINBuilder provides a factory method. OwnerPINx extends PIN
  with administrative methods. OwnerPINxWithPredecrement extends
  OwnerPINx with pre-decremented try counter semantics.

  # ===================================================================
  # PIN Interface
  # ===================================================================
  # -------------------------------------------------------------------
  # Method: PIN.getTriesRemaining()
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, getTriesRemaining](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#getTriesRemaining)
  # Source: [JavaCard 3.1 API, getTriesRemaining](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#getTriesRemaining)
  # Source: [JavaCard 3.2 API, getTriesRemaining](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#getTriesRemaining)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.getTriesRemaining returns remaining incorrect attempts
    Given a PIN with try limit 3 and no failed attempts
    When getTriesRemaining() is called
    Then the return value is 3

  # -------------------------------------------------------------------
  # Method: PIN.check(byte[], short, byte)
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.check returns true and sets validated flag for correct PIN
    Given a PIN with value {0x31, 0x32, 0x33, 0x34}
    When check is called with the correct PIN bytes
    Then the result is true
    And the validated flag is set
    And the try counter is reset to the try limit

  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.check returns false and decrements try counter for wrong PIN
    Given a PIN with try limit 3 and 3 tries remaining
    When check is called with an incorrect PIN
    Then the result is false
    And the validated flag is reset
    And the try counter is decremented to 2

  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.check blocks the PIN when try counter reaches zero
    Given a PIN with 1 try remaining
    When check is called with an incorrect PIN
    Then the result is false
    And the try counter reaches 0
    And the PIN is blocked

  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.check on a blocked PIN always returns false
    Given a blocked PIN
    When check is called with the correct PIN
    Then the result is false

  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.check with NullPointerException still decrements try counter
    Given a PIN with 3 tries remaining
    When check is called with a null pin array
    Then a NullPointerException is thrown
    And the validated flag is set to false
    And the try counter is decremented

  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.check with ArrayIndexOutOfBoundsException still decrements try counter
    Given a PIN with 3 tries remaining
    When check is called with offset+length exceeding pin array length
    Then an ArrayIndexOutOfBoundsException is thrown
    And the validated flag is set to false
    And the try counter is decremented

  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.check internal state updates do not participate in transactions
    Given a transaction is in progress
    When check is called on a PIN
    Then the try counter, validated flag, and blocking state updates bypass the transaction

  # -------------------------------------------------------------------
  # Method: PIN.isValidated()
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, isValidated](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#isValidated)
  # Source: [JavaCard 3.1 API, isValidated](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#isValidated)
  # Source: [JavaCard 3.2 API, isValidated](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#isValidated)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.isValidated returns true after successful check
    Given a PIN that has been successfully validated via check()
    When isValidated() is called
    Then the result is true

  # Source: [JavaCard 3.0.5 API, isValidated](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#isValidated)
  # Source: [JavaCard 3.1 API, isValidated](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#isValidated)
  # Source: [JavaCard 3.2 API, isValidated](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#isValidated)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.isValidated returns false before any check
    Given a PIN that has not been validated since card reset
    When isValidated() is called
    Then the result is false

  # -------------------------------------------------------------------
  # Method: PIN.reset()
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, reset](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#reset)
  # Source: [JavaCard 3.1 API, reset](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#reset)
  # Source: [JavaCard 3.2 API, reset](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#reset)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.reset clears the validated flag when set
    Given a PIN that has been validated
    When reset() is called
    Then the validated flag is cleared
    And isValidated() returns false

  # Source: [JavaCard 3.0.5 API, reset](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/PIN.html#reset)
  # Source: [JavaCard 3.1 API, reset](../../../.refs/javadoc-3.1/api_classic/javacard/framework/PIN.html#reset)
  # Source: [JavaCard 3.2 API, reset](../../../.refs/javadoc-3.2/api_classic/javacard/framework/PIN.html#reset)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: PIN.reset does nothing when validated flag is not set
    Given a PIN that has not been validated
    When reset() is called
    Then no action is performed

  # ===================================================================
  # OwnerPIN Class
  # ===================================================================
  # -------------------------------------------------------------------
  # Constructor: OwnerPIN(byte, byte)
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, OwnerPIN](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  # Source: [JavaCard 3.1 API, OwnerPIN](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  # Source: [JavaCard 3.2 API, OwnerPIN](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPIN construction with valid parameters
    When an OwnerPIN is constructed with tryLimit 3 and maxPINSize 8
    Then the OwnerPIN is successfully created
    And the validated flag is false
    And getTriesRemaining() returns 3

  # Source: [JavaCard 3.0.5 API, OwnerPIN](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  # Source: [JavaCard 3.1 API, OwnerPIN](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  # Source: [JavaCard 3.2 API, OwnerPIN](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPIN construction with tryLimit less than 1 throws PINException
    When an OwnerPIN is constructed with tryLimit 0 and maxPINSize 8
    Then a PINException is thrown with reason ILLEGAL_VALUE

  # Source: [JavaCard 3.0.5 API, OwnerPIN](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  # Source: [JavaCard 3.1 API, OwnerPIN](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  # Source: [JavaCard 3.2 API, OwnerPIN](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#OwnerPIN(byte,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPIN construction with maxPINSize less than 1 throws PINException
    When an OwnerPIN is constructed with tryLimit 3 and maxPINSize 0
    Then a PINException is thrown with reason ILLEGAL_VALUE

  # -------------------------------------------------------------------
  # Method: OwnerPIN.update(byte[], short, byte)
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, update](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#update(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, update](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#update(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, update](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#update(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPIN.update sets a new PIN value and resets try counter
    Given an OwnerPIN with tryLimit 3
    When update(pin, offset, length) is called with new PIN bytes
    Then the PIN value is updated
    And the try counter is reset to the try limit

  # Source: [JavaCard 3.0.5 API, update](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#update(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, update](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#update(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, update](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#update(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPIN.update with length exceeding maxPINSize throws PINException
    Given an OwnerPIN with maxPINSize 4
    When update is called with a 5-byte PIN
    Then a PINException is thrown with reason ILLEGAL_VALUE

  # -------------------------------------------------------------------
  # Method: OwnerPIN.resetAndUnblock()
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, resetAndUnblock](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#resetAndUnblock)
  # Source: [JavaCard 3.1 API, resetAndUnblock](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#resetAndUnblock)
  # Source: [JavaCard 3.2 API, resetAndUnblock](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#resetAndUnblock)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPIN.resetAndUnblock clears validated flag and unblocks
    Given a blocked OwnerPIN
    When resetAndUnblock() is called
    Then the validated flag is cleared
    And the try counter is reset to the try limit
    And the PIN is no longer blocked

  # -------------------------------------------------------------------
  # Method: OwnerPIN.reset() -- overrides PIN.reset()
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, reset](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#reset)
  # Source: [JavaCard 3.1 API, reset](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#reset)
  # Source: [JavaCard 3.2 API, reset](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#reset)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPIN.reset resets validated flag and resets try counter if validated
    Given a validated OwnerPIN with 2 tries remaining
    When reset() is called
    Then the validated flag is cleared
    And the try counter is reset to the try limit

  # -------------------------------------------------------------------
  # Protected Methods: getValidatedFlag / setValidatedFlag
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, getValidatedFlag](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#getValidatedFlag)
  # Source: [JavaCard 3.1 API, getValidatedFlag](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#getValidatedFlag)
  # Source: [JavaCard 3.2 API, getValidatedFlag](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#getValidatedFlag)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getValidatedFlag returns internal validated boolean state
    Given an OwnerPIN subclass
    When getValidatedFlag() is called
    Then it returns the current validated flag value

  # Source: [JavaCard 3.0.5 API, setValidatedFlag](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPIN.html#setValidatedFlag(boolean)
  # Source: [JavaCard 3.1 API, setValidatedFlag](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPIN.html#setValidatedFlag(boolean)
  # Source: [JavaCard 3.2 API, setValidatedFlag](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPIN.html#setValidatedFlag(boolean)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: setValidatedFlag allows subclass to override validated state
    Given an OwnerPIN subclass
    When setValidatedFlag(true) is called
    Then getValidatedFlag() returns true

  # ===================================================================
  # OwnerPINBuilder Class
  # ===================================================================
  # -------------------------------------------------------------------
  # Constants
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, OwnerPINBuilder ](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINBuilder.html#OwnerPINBuilder(fieldsummary)
  # Source: [JavaCard 3.1 API, OwnerPINBuilder ](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINBuilder.html#OwnerPINBuilder(fieldsummary)
  # Source: [JavaCard 3.2 API, OwnerPINBuilder ](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINBuilder.html#OwnerPINBuilder(fieldsummary)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario Outline: OwnerPINBuilder PIN type constants
    When the constant OwnerPINBuilder.<constant_name> is accessed
    Then it identifies a PIN implementation type

    Examples:
      | constant_name                 |
      | OWNER_PIN                     |
      | OWNER_PIN_X                   |
      | OWNER_PIN_X_WITH_PREDECREMENT |

  # -------------------------------------------------------------------
  # Method: buildOwnerPIN(byte, byte, byte)
  # -------------------------------------------------------------------
  # Source: [JavaCard 3.0.5 API, buildOwnerPIN](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  # Source: [JavaCard 3.1 API, buildOwnerPIN](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  # Source: [JavaCard 3.2 API, buildOwnerPIN](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: buildOwnerPIN creates an OwnerPIN instance
    When OwnerPINBuilder.buildOwnerPIN(OWNER_PIN, 3, 8) is called
    Then an OwnerPIN instance is returned with tryLimit 3 and maxPINSize 8

  # Source: [JavaCard 3.0.5 API, buildOwnerPIN](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  # Source: [JavaCard 3.1 API, buildOwnerPIN](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  # Source: [JavaCard 3.2 API, buildOwnerPIN](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: buildOwnerPIN creates an OwnerPINx instance
    When OwnerPINBuilder.buildOwnerPIN(OWNER_PIN_X, 5, 8) is called
    Then a PIN instance implementing OwnerPINx is returned

  # Source: [JavaCard 3.0.5 API, buildOwnerPIN](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  # Source: [JavaCard 3.1 API, buildOwnerPIN](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  # Source: [JavaCard 3.2 API, buildOwnerPIN](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINBuilder.html#buildOwnerPIN(byte,byte,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: buildOwnerPIN creates an OwnerPINxWithPredecrement instance
    When OwnerPINBuilder.buildOwnerPIN(OWNER_PIN_X_WITH_PREDECREMENT, 5, 8) is called
    Then a PIN instance implementing OwnerPINxWithPredecrement is returned

  # ===================================================================
  # OwnerPINx Interface
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, update](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINx.html#update(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, update](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINx.html#update(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, update](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINx.html#update(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPINx.update sets a new PIN value
    Given an OwnerPINx instance
    When update(pin, offset, length) is called
    Then the PIN value is changed

  # Source: [JavaCard 3.0.5 API, getTryLimit](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINx.html#getTryLimit)
  # Source: [JavaCard 3.1 API, getTryLimit](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINx.html#getTryLimit)
  # Source: [JavaCard 3.2 API, getTryLimit](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINx.html#getTryLimit)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPINx.getTryLimit returns the maximum try count
    Given an OwnerPINx created with tryLimit 5
    When getTryLimit() is called
    Then the return value is 5

  # Source: [JavaCard 3.0.5 API, setTryLimit](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINx.html#setTryLimit(byte)
  # Source: [JavaCard 3.1 API, setTryLimit](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINx.html#setTryLimit(byte)
  # Source: [JavaCard 3.2 API, setTryLimit](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINx.html#setTryLimit(byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPINx.setTryLimit changes the try limit
    Given an OwnerPINx instance
    When setTryLimit(10) is called
    Then the try limit is updated to 10

  # Source: [JavaCard 3.0.5 API, setTriesRemaining](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINx.html#setTriesRemaining(byte)
  # Source: [JavaCard 3.1 API, setTriesRemaining](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINx.html#setTriesRemaining(byte)
  # Source: [JavaCard 3.2 API, setTriesRemaining](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINx.html#setTriesRemaining(byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPINx.setTriesRemaining sets the current try counter
    Given an OwnerPINx instance with tryLimit 5
    When setTriesRemaining(3) is called
    Then getTriesRemaining() returns 3

  # ===================================================================
  # OwnerPINxWithPredecrement Interface
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, check](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINxWithPredecrement.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, check](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINxWithPredecrement.html#check(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, check](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINxWithPredecrement.html#check(byte%5B%5D,short,byte)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPINxWithPredecrement.check pre-decrements before comparison
    Given an OwnerPINxWithPredecrement with 3 tries remaining
    When check is called with the correct PIN
    Then the try counter is first decremented to 2
    And then the PIN comparison succeeds
    And the try counter is restored to the try limit

  # Source: [JavaCard 3.0.5 API, decrementTriesRemaining](../../../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/OwnerPINxWithPredecrement.html#decrementTriesRemaining)
  # Source: [JavaCard 3.1 API, decrementTriesRemaining](../../../.refs/javadoc-3.1/api_classic/javacard/framework/OwnerPINxWithPredecrement.html#decrementTriesRemaining)
  # Source: [JavaCard 3.2 API, decrementTriesRemaining](../../../.refs/javadoc-3.2/api_classic/javacard/framework/OwnerPINxWithPredecrement.html#decrementTriesRemaining)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: OwnerPINxWithPredecrement.decrementTriesRemaining decrements counter
    Given an OwnerPINxWithPredecrement with 3 tries remaining
    When decrementTriesRemaining() is called
    Then getTriesRemaining() returns 2
