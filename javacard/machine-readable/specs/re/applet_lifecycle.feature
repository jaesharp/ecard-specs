@jcre @applet-lifecycle
Feature: Java Card Applet Lifecycle
  An applet instance's lifetime begins when it is successfully registered with
  the Java Card RE via the Applet.register method. The Java Card RE initiates
  interactions with the applet via its public methods install, select, deselect,
  and process. An applet shall implement the static install(byte[],short,byte)
  method. A Java Card RE implementation shall call an applet's install, select,
  deselect, and process methods as described in this specification.

  # Source: [JCRE 3.0.5, s3 Java Card Applet Lifetime](../../../3.0.5/JCRESpec_3.0.5.pdf#page=18)
  # Source: [JCRE 3.1, s3 Java Card Applet Lifetime](../../../3.1/JCRESpec_3.1.pdf#page=21)
  # Source: [JCRE 3.2, s3 Java Card Applet Lifetime](../../../3.2/JCRESpec_3.2.pdf#page=21)

  Background:
    Given a Java Card secure element with a compliant JCRE implementation
    And the Java Card RE is initialized

  # ---------------------------------------------------------------------------
  # 3.1 install Method
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.1 install Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=18)
  # Source: [JCRE 3.1, s3.1 install Method](../../../3.1/JCRESpec_3.1.pdf#page=21)
  # Source: [JCRE 3.2, s3.1 install Method](../../../3.2/JCRESpec_3.2.pdf#page=21)
  Scenario: install method invocation for applet creation
    Given an applet is being installed on the smart card
    When the Java Card RE calls install(byte[],short,byte)
    Then the applet instance does not yet exist at the time of the call
    And the install method shall create an instance of the Applet subclass using its constructor
    And the install method shall register the instance via Applet.register()
    And the install method obtains initialization parameters from the incoming byte array parameter

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.1 install Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=18)
  # Source: [JCRE 3.1, s3.1 install Method](../../../3.1/JCRESpec_3.1.pdf#page=21)
  # Source: [JCRE 3.2, s3.1 install Method](../../../3.2/JCRESpec_3.2.pdf#page=21)
  Scenario: install method called once per instance
    Given an applet is being installed
    When the Java Card RE calls the Applet.install method
    Then the static install(byte[],short,byte) method is called once for each applet instance created
    And the Java Card RE shall not call the applet's constructor directly

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.1 install Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=18)
  # Source: [JCRE 3.1, s3.1 install Method](../../../3.1/JCRESpec_3.1.pdf#page=21)
  # Source: [JCRE 3.2, s3.1 install Method](../../../3.2/JCRESpec_3.2.pdf#page=21)
  Scenario: Successful installation via Applet.register
    Given the install method is executing
    When the applet calls Applet.register() or Applet.register(byte[],short,byte)
    And the call to Applet.register completes without an exception
    Then the installation is considered successful
    And the Java Card RE can mark the applet as available for selection
    And only one applet instance can be successfully registered each time install is called

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.1 install Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=18)
  # Source: [JCRE 3.1, s3.1 install Method](../../../3.1/JCRESpec_3.1.pdf#page=21)
  # Source: [JCRE 3.2, s3.1 install Method](../../../3.2/JCRESpec_3.2.pdf#page=21)
  Scenario: Unsuccessful installation - register not called
    Given the install method is executing
    When the install method does not call the Applet.register method
    Then the installation is deemed unsuccessful
    And the Java Card RE shall perform all cleanup when it regains control
    And all conditional updates to persistent storage shall be returned to the state prior to calling install

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.1 install Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=18)
  # Source: [JCRE 3.1, s3.1 install Method](../../../3.1/JCRESpec_3.1.pdf#page=21)
  # Source: [JCRE 3.2, s3.1 install Method](../../../3.2/JCRESpec_3.2.pdf#page=21)
  Scenario: Unsuccessful installation - exception before register
    Given the install method is executing
    When an exception is thrown from within the install method prior to calling Applet.register
    Then the installation is deemed unsuccessful
    And the Java Card RE shall perform all cleanup when it regains control
    And all conditional updates to persistent storage shall be returned to the state prior to calling install

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.1 install Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=18)
  # Source: [JCRE 3.1, s3.1 install Method](../../../3.1/JCRESpec_3.1.pdf#page=21)
  # Source: [JCRE 3.2, s3.1 install Method](../../../3.2/JCRESpec_3.2.pdf#page=21)
  Scenario: Unsuccessful installation - Applet.register throws exception
    Given the install method is executing
    When the Applet.register method throws an exception
    Then the installation is deemed unsuccessful
    And the Java Card RE shall perform all cleanup when it regains control
    And all conditional updates to persistent storage shall be returned to the state prior to calling install

  # ---------------------------------------------------------------------------
  # 3.2 select Method
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.2 select Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.2 select Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.2 select Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Applet selection via SELECT FILE APDU
    Given an applet is in a suspended state
    When the Java Card RE receives a SELECT FILE APDU command matching the applet's AID
    Then the Java Card RE shall deselect the previously selected applet first
    And the Java Card RE shall invoke the applet's select method
    And the applet becomes the currently selected applet

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.2 select Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.2 select Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.2 select Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Applet selection via MANAGE CHANNEL OPEN
    Given an applet is registered on the card
    When the Java Card RE receives a MANAGE CHANNEL OPEN command
    Then applet selection can also occur on the new logical channel
    And selection causes the applet to become the currently selected applet on that channel

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.2 select Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.2 select Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.2 select Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Multiselectable applet selection notification
    Given the applet is already selected on another logical channel
    When the applet is being selected on a new logical channel (multiselection)
    Then the Java Card RE shall invoke MultiSelectable.select instead of Applet.select

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.2 select Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.2 select Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.2 select Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Applet declines selection by returning false
    Given the applet's select method is invoked
    When the select method returns false
    Then the Java Card RE returns ISO7816.SW_APPLET_SELECT_FAILED to the CAD
    And the Java Card RE state is set to indicate that no applet is selected on that channel

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.2 select Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.2 select Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.2 select Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Applet declines selection by throwing exception
    Given the applet's select method is invoked
    When the select method throws an exception
    Then the Java Card RE returns ISO7816.SW_APPLET_SELECT_FAILED to the CAD
    And the Java Card RE state is set to indicate that no applet is selected on that channel

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.2 select Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.2 select Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.2 select Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: selectingApplet returns true during select
    Given the applet's select method is being invoked
    When the applet calls Applet.selectingApplet()
    Then the method shall return true
    And it shall continue to return true during the subsequent process method call for the SELECT FILE APDU

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.2 select Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.2 select Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.2 select Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: SELECT FILE APDU forwarded to process after successful select
    Given the applet's select method returns true
    Then the actual SELECT FILE APDU command is supplied to the applet via the subsequent process method call
    And the applet can examine the APDU contents and respond with data
    And the applet can flag errors by throwing an ISOException with the appropriate status word
    And the status word and optional response data are returned to the CAD

  # ---------------------------------------------------------------------------
  # 3.3 process Method
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.3 process Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.3 process Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.3 process Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: APDU command dispatching to process method
    Given an applet is the currently selected applet
    When the Java Card RE receives an APDU command (except MANAGE CHANNEL)
    Then the Java Card RE preprocesses the APDU
    And passes an instance of the APDU class to the process(APDU) method of the currently selected applet

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.3 process Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.3 process Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.3 process Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: SELECT FILE may change currently selected applet before process
    Given an applet is the currently selected applet
    When a SELECT FILE APDU command is received that matches a different applet
    Then the currently selected applet may change prior to the call to process
    And the actual change occurs before the call to the select method of the new applet

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.3 process Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.3 process Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.3 process Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Automatic 0x9000 status word on normal return from process
    Given an applet's process method is executing
    When the process method returns normally
    Then the Java Card RE automatically appends 0x9000 as the completion response status word
    And the status word is appended to any data already sent by the applet

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.3 process Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.3 process Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.3 process Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Transaction abort on normal return with active transaction
    Given an applet's process method is executing
    And an applet-initiated transaction is in progress
    When the process method returns normally
    Then the Java Card RE aborts the transaction
    And the Java Card RE returns the status word ISO7816.SW_UNKNOWN to the CAD

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.3 process Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.3 process Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.3 process Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: ISOException thrown during process
    Given an applet's process method is executing
    When the applet throws an ISOException with an appropriate status word
    Then the Java Card RE catches the exception
    And returns the status word from the ISOException to the CAD

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.3 process Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=19)
  # Source: [JCRE 3.1, s3.3 process Method](../../../3.1/JCRESpec_3.1.pdf#page=22)
  # Source: [JCRE 3.2, s3.3 process Method](../../../3.2/JCRESpec_3.2.pdf#page=22)
  Scenario: Other exception thrown during process
    Given an applet's process method is executing
    When any exception other than ISOException is thrown during process
    Then the Java Card RE catches the exception
    And returns the status word ISO7816.SW_UNKNOWN to the CAD

  # ---------------------------------------------------------------------------
  # 3.4 deselect Method(s)
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.4 deselect Method(s)](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.4 deselect Method(s)](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.4 deselect Method(s)](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Deselection on SELECT FILE for different applet
    Given an applet is the currently selected applet
    When the Java Card RE receives a SELECT FILE APDU matching a different applet's AID
    Then the Java Card RE calls Applet.deselect on the currently selected applet
    And the deselect method allows the applet to perform cleanup operations

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.4 deselect Method(s)](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.4 deselect Method(s)](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.4 deselect Method(s)](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Deselection on MANAGE CHANNEL CLOSE
    Given an applet is the currently selected applet on a logical channel
    When the Java Card RE receives a MANAGE CHANNEL CLOSE command for that channel
    Then applet deselection is requested
    And the deselect method is called on the applet

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.4 deselect Method(s)](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.4 deselect Method(s)](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.4 deselect Method(s)](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: MultiSelectable.deselect for concurrently selected applet
    Given a multiselectable applet is selected on more than one logical channel
    When the applet is being deselected from one channel but remains active on another
    Then the Java Card RE calls MultiSelectable.deselect instead of Applet.deselect

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.4 deselect Method(s)](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.4 deselect Method(s)](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.4 deselect Method(s)](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: selectingApplet returns false during deselect
    Given an applet's deselect method is being invoked
    When the applet calls Applet.selectingApplet()
    Then the method shall return false

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.4 deselect Method(s)](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.4 deselect Method(s)](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.4 deselect Method(s)](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Exceptions from deselect caught by Java Card RE
    Given an applet's deselect method is being invoked
    When the deselect method throws an exception
    Then the exception is caught by the Java Card RE
    And the applet is still deselected regardless of the exception

  # ---------------------------------------------------------------------------
  # 3.5 uninstall Method
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.5 uninstall Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.5 uninstall Method](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.5 uninstall Method](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: uninstall method invocation before deletion
    Given the Java Card RE is preparing to delete an applet instance
    And the applet implements the javacard.framework.AppletEvent interface
    When the Java Card RE calls the uninstall method
    Then the applet is informed of the deletion request
    And upon return the Java Card RE checks for reference dependencies before deleting the applet instance

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.5 uninstall Method](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.5 uninstall Method](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.5 uninstall Method](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: uninstall may be called multiple times
    Given an applet implements AppletEvent
    Then the uninstall method may be called multiple times
    And it is called once for each applet deletion attempt

  # ---------------------------------------------------------------------------
  # 3.6 Power Loss and Reset
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.6 Power Loss and Reset](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.6 Power Loss and Reset](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.6 Power Loss and Reset](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Power loss conditions
    Then power loss occurs under one of the following conditions:
      | condition                                                                           |
      | The card is withdrawn from the CAD                                                  |
      | Contactless-only mode: card loses carrier energy from RF field (POWER OFF state)     |
      | Contactless-only mode: receives S-block DESELECT command (HALT state)                |
      | Contactless-only mode: SWP deactivation/activation or HCI event field on/off         |
      | A mechanical or electrical failure occurs on the card                                |

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.6 Power Loss and Reset](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.6 Power Loss and Reset](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.6 Power Loss and Reset](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Card reset behavior - transient data
    Given power is reapplied to the card and card reset occurs (warm or cold)
    Then the Java Card RE shall ensure that transient data is reset to the default value

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.6 Power Loss and Reset](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.6 Power Loss and Reset](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.6 Power Loss and Reset](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Card reset behavior - transaction abort
    Given power is reapplied to the card and card reset occurs
    Then the transaction in progress, if any, when power was lost or reset occurred is aborted

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.6 Power Loss and Reset](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.6 Power Loss and Reset](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.6 Power Loss and Reset](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Card reset behavior - implicit deselection
    Given power is reapplied to the card and card reset occurs
    Then all applet instances that were active when power was lost become implicitly deselected
    And the deselect method is NOT called during implicit deselection

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.6 Power Loss and Reset](../../../3.0.5/JCRESpec_3.0.5.pdf#page=20)
  # Source: [JCRE 3.1, s3.6 Power Loss and Reset](../../../3.1/JCRESpec_3.1.pdf#page=23)
  # Source: [JCRE 3.2, s3.6 Power Loss and Reset](../../../3.2/JCRESpec_3.2.pdf#page=23)
  Scenario: Card reset behavior - default applet selection
    Given power is reapplied to the card and card reset occurs
    And the Java Card RE implements default applet selection
    Then the default applet is selected as the active applet instance for the basic logical channel (channel 0)
    And the default applet's select method is called
    But if no default applet is designated, the Java Card RE indicates no applet is active on the basic channel

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.6.1 Concurrent Operations Over Multiple Interfaces](../../../3.0.5/JCRESpec_3.0.5.pdf#page=21)
  # Source: [JCRE 3.1, s3.6.1 Concurrent Operations Over Multiple Interfaces](../../../3.1/JCRESpec_3.1.pdf#page=24)
  # Source: [JCRE 3.2, s3.6.1 Concurrent Operations Over Multiple Interfaces](../../../3.2/JCRESpec_3.2.pdf#page=24)
  Scenario: Contactless I/O interface reset conditions
    Then the following conditions are deemed a reset of the contactless I/O interface:
      | condition                                                                               |
      | ISO 14443 S-block DESELECT command results in proximity card entering HALT state         |
      | Loss of RF field results in proximity card entering POWER OFF state                      |
      | Contactless interface accessed via SWP is logically reset                                |

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s3.6.1 Concurrent Operations Over Multiple Interfaces](../../../3.0.5/JCRESpec_3.0.5.pdf#page=21)
  # Source: [JCRE 3.1, s3.6.1 Concurrent Operations Over Multiple Interfaces](../../../3.1/JCRESpec_3.1.pdf#page=24)
  # Source: [JCRE 3.2, s3.6.1 Concurrent Operations Over Multiple Interfaces](../../../3.2/JCRESpec_3.2.pdf#page=24)
  Scenario: Contactless reset behavior on dual-interface card
    Given a card concurrently operates on both contacted and contactless I/O interfaces
    When the contactless I/O interface is reset
    Then the transaction in progress on the contactless interface, if any, must be aborted
    And each applet instance active on a contactless logical channel must be deselected
    And all logical channels open on the contactless interface are implicitly closed
    And CLEAR_ON_DESELECT transient data for contactless-only applet instances is reset to default
    And the ongoing contacted session must not be affected
