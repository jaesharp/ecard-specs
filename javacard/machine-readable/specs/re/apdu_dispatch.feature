@jcre @apdu-dispatch
Feature: APDU Command Dispatching
  The Java Card RE intercepts all APDU messages coming into the card, performs
  card management functions (such as selecting or deselecting applet instances),
  and forwards APDU messages to the appropriate applet instance. The Java Card RE
  dispatches APDUs based on the CLA byte logical channel encoding and the command
  type (SELECT FILE, MANAGE CHANNEL, or other).

  # Source: [JCRE 3.0.5, s4 Logical Channels and Applet Selection](../../../3.0.5/JCRESpec_3.0.5.pdf#page=24)
  # Source: [JCRE 3.1, s4 Logical Channels and Applet Selection](../../../3.1/JCRESpec_3.1.pdf#page=27)
  # Source: [JCRE 3.2, s4 Logical Channels and Applet Selection](../../../3.2/JCRESpec_3.2.pdf#page=27)

  Background:
    Given a Java Card secure element with a compliant JCRE implementation
    And the Java Card RE is initialized
    And at least one applet is installed and registered

  # ---------------------------------------------------------------------------
  # 4.4 Forwarding APDU Commands To a Logical Channel
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.0.5/JCRESpec_3.0.5.pdf#page=31)
  # Source: [JCRE 3.1, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.1/JCRESpec_3.1.pdf#page=34)
  # Source: [JCRE 3.2, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.2/JCRESpec_3.2.pdf#page=34)
  Scenario: CLA byte logical channel encoding - Type 4
    Given the platform supports Type 4 logical channel encoding
    Then interindustry CLA byte values 0x0X and 0x1X encode channel numbers 0-3 in bits (b2,b1)
    And proprietary CLA byte values 0x8X, 0x9X, 0xAX, 0xBX encode channel numbers 0-3
    And the two least significant bits (b2,b1) of the X nibble encode channel numbers 0-3

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.0.5/JCRESpec_3.0.5.pdf#page=31)
  # Source: [JCRE 3.1, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.1/JCRESpec_3.1.pdf#page=34)
  # Source: [JCRE 3.2, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.2/JCRESpec_3.2.pdf#page=34)
  Scenario: CLA byte logical channel encoding - Type 16
    Given the platform supports Type 16 logical channel encoding
    Then interindustry CLA byte values 0x4Y, 0x5Y, 0x6Y, 0x7Y encode channel numbers 4-19 in nibble Y (b4-b1)
    And proprietary CLA byte values 0xCY, 0xDY, 0xEY, 0xFY encode channel numbers 4-19
    And CLA byte 0xFX cannot encode logical channel 19 because CLA=0xFF is reserved for Protocol Type Selection

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.0.5/JCRESpec_3.0.5.pdf#page=31)
  # Source: [JCRE 3.1, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.1/JCRESpec_3.1.pdf#page=34)
  # Source: [JCRE 3.2, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.2/JCRESpec_3.2.pdf#page=34)
  Scenario: APDU dispatching by CLA byte channel information
    Given an APDU command is received
    When the Java Card RE processes the CLA byte
    Then it determines based on supported encoding types whether the command has logical channel information
    And if logical channel information is encoded, the card dispatches the APDU to the appropriate logical channel
    And all other APDU commands are forwarded to the basic logical channel (channel 0) on that I/O interface

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.0.5/JCRESpec_3.0.5.pdf#page=31)
  # Source: [JCRE 3.1, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.1/JCRESpec_3.1.pdf#page=34)
  # Source: [JCRE 3.2, s4.4 Forwarding APDU Commands To a Logical Channel](../../../3.2/JCRESpec_3.2.pdf#page=34)
  Scenario: APDU forwarded as-is to applet
    Given the Java Card RE dispatches an APDU to an applet instance
    Then the Java Card RE always forwards the command "as is" to the appropriate applet instance
    And the Java Card RE does not clear the logical channel encoding bits of the CLA byte
    And the applet should use APDU class methods (isISOInterindustryCLA, getCLAChannel, etc.) to parse the CLA byte

  # ---------------------------------------------------------------------------
  # 4.6.2 Applet Selection with SELECT FILE
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.6.2 Applet Selection with SELECT FILE](../../../3.0.5/JCRESpec_3.0.5.pdf#page=35)
  # Source: [JCRE 3.1, s4.6.2 Applet Selection with SELECT FILE](../../../3.1/JCRESpec_3.1.pdf#page=39)
  # Source: [JCRE 3.2, s4.6.2 Applet Selection with SELECT FILE](../../../3.2/JCRESpec_3.2.pdf#page=39)
  Scenario: SELECT FILE step-by-step processing
    Given the Java Card RE receives a SELECT FILE command on an I/O interface
    # Step 1: CLA byte and DF Name
    Then the Applet SELECT FILE command uses INS=0xA4, P1=0x04 ("Selection by DF name")
    And for Type 4: CLA=%b000000cc* where cc specifies channel 0-3
    And for Type 16: CLA=%0100dddd* where dddd specifies channels 4-19
    And otherwise: CLA=0x00
    And if the CLA value does not conform to supported encoding, or has non-zero secure messaging bits, the command is not an Applet SELECT FILE and is forwarded as a regular APDU
    And the Java Card RE shall support "exact DF name(AID)" with P2=%b0000xx00 and the RFU variant P2=%b0001xx00
    # Step 2: Channel resources check
    And if resources for the specified logical channel are not available, the RE responds with 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED)
    # Step 3: Channel not open opens it
    And if the specified logical channel is not open, it is now opened and no applet is active on it; the specified channel is the assigned channel
    # Step 4: AID match search
    And the Java Card RE searches the internal applet table for an applet instance with a matching AID
    And if a match is found, it is picked as the candidate applet instance
    And if no AID match is found and there is no active applet, the RE responds with 0x6999 (SW_APPLET_SELECT_FAILED)
    And if no AID match is found but there is an active applet, the SELECT FILE is forwarded to that applet's process method
    # Step 5: Non-multiselectable context check
    And if the candidate applet is not multiselectable and its context is active, the RE responds with 0x6985 (SW_CONDITIONS_NOT_SATISFIED) and may deselect the current applet
    # Step 6: Assign CLEAR_ON_DESELECT segment
    And if any applet from the same context is active on another channel, assign the same CLEAR_ON_DESELECT segment
    And otherwise assign a new zero-filled CLEAR_ON_DESELECT segment
    # Step 7: Selection accept check
    And if candidate context is active, call MultiSelectable.select(appInstAlreadyActive) with context switch
    And if candidate context is not active, call Applet.select with context switch
    And if select throws exception, returns false, or returns true during active transaction, no applet is active and RE responds with 0x6999 (SW_APPLET_SELECT_FAILED)
    # Step 8: Forward SELECT FILE to process
    And the RE sets the candidate as currently selected and calls Applet.process with the SELECT FILE APDU
    And a context switch into the applet instance's context occurs
    And the response from process is sent as the response to the SELECT FILE command

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.6.2 Applet Selection with SELECT FILE](../../../3.0.5/JCRESpec_3.0.5.pdf#page=35)
  # Source: [JCRE 3.1, s4.6.2 Applet Selection with SELECT FILE](../../../3.1/JCRESpec_3.1.pdf#page=39)
  # Source: [JCRE 3.2, s4.6.2 Applet Selection with SELECT FILE](../../../3.2/JCRESpec_3.2.pdf#page=39)
  Scenario: Reselection of already-active applet still deselects first
    Given an applet is the active applet instance on a specified logical channel
    When a SELECT FILE command with the same matching AID is received on the same channel
    Then the Java Card RE still goes through the process of deselecting the applet instance and then selecting it
    And reselection could fail, leaving the card in a state where no applet is active on that channel

  # ---------------------------------------------------------------------------
  # 4.7 Applet Deselection
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.7 Applet Deselection](../../../3.0.5/JCRESpec_3.0.5.pdf#page=38)
  # Source: [JCRE 3.1, s4.7 Applet Deselection](../../../3.1/JCRESpec_3.1.pdf#page=41)
  # Source: [JCRE 3.2, s4.7 Applet Deselection](../../../3.2/JCRESpec_3.2.pdf#page=42)
  Scenario: Applet deselection procedure
    Given an applet instance is being deselected (MANAGE CHANNEL CLOSE or SELECT FILE for different applet)
    When the applet is active on more than one logical channel or another applet from the same context is also active
    Then the RE sets the applet as currently selected and calls MultiSelectable.deselect(appInstStillActive)
    And appInstStillActive is set to true if the same applet instance is still active on another logical channel
    And a context switch occurs into the applet instance's context
    But when the applet is only selected on one channel and no other context applet is active
    Then the RE sets the applet as currently selected and calls Applet.deselect
    And upon return or uncaught exception, the RE clears the fields of all CLEAR_ON_DESELECT transient objects in the context
    And the deselection is always successful even if the deselect method throws an exception

  # ---------------------------------------------------------------------------
  # 4.8 Other Command Processing
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.8 Other Command Processing](../../../3.0.5/JCRESpec_3.0.5.pdf#page=39)
  # Source: [JCRE 3.1, s4.8 Other Command Processing](../../../3.1/JCRESpec_3.1.pdf#page=42)
  # Source: [JCRE 3.2, s4.8 Other Command Processing](../../../3.2/JCRESpec_3.2.pdf#page=43)
  Scenario: Non-SELECT non-MANAGE-CHANNEL APDU dispatching
    Given an APDU other than SELECT FILE or MANAGE CHANNEL is received
    When the logical channel is determined from the CLA byte
    And the logical channel number is unsupported or the channel is not open
    Then the RE responds with 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED)

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.8 Other Command Processing](../../../3.0.5/JCRESpec_3.0.5.pdf#page=39)
  # Source: [JCRE 3.1, s4.8 Other Command Processing](../../../3.1/JCRESpec_3.1.pdf#page=42)
  # Source: [JCRE 3.2, s4.8 Other Command Processing](../../../3.2/JCRESpec_3.2.pdf#page=43)
  Scenario: No active applet on logical channel for other command
    Given an APDU other than SELECT FILE or MANAGE CHANNEL is received
    And no active applet instance exists on the logical channel for dispatching
    Then the RE responds with 0x6999 (SW_APPLET_SELECT_FAILED)

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.8 Other Command Processing](../../../3.0.5/JCRESpec_3.0.5.pdf#page=39)
  # Source: [JCRE 3.1, s4.8 Other Command Processing](../../../3.1/JCRESpec_3.1.pdf#page=42)
  # Source: [JCRE 3.2, s4.8 Other Command Processing](../../../3.2/JCRESpec_3.2.pdf#page=43)
  Scenario: Context switch on other command dispatch to applet
    Given an APDU other than SELECT FILE or MANAGE CHANNEL is received
    And there is an active applet instance on the logical channel
    Then the Java Card RE sets the active applet instance on the origin channel as the currently selected applet instance
    And invokes the process method passing the APDU as a parameter
    And a context switch from the Java Card RE context to the currently selected applet instance's context occurs
    And when the process method exits, the VM switches back to the Java Card RE context
    And the Java Card RE sends the response APDU and waits for the next command
    And the CLA byte in the command header contains the origin channel number in its least significant bits
