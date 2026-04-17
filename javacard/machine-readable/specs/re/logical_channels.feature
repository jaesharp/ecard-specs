@jcre @logical-channels
Feature: Logical Channels
  Logical channels enable multiple applet instances to be concurrently selected
  on a single card. The Java Card RE uses SELECT FILE and MANAGE CHANNEL OPEN
  APDUs to designate the active applet instance for a logical channel session.
  A platform may support between 1 and 20 logical channels per I/O interface.
  Channel 0 is the basic logical channel, which is permanent and cannot be closed.

  # Source: [JCRE 3.0.5, s4 Logical Channels and Applet Selection](../../../3.0.5/JCRESpec_3.0.5.pdf#page=24)
  # Source: [JCRE 3.1, s4 Logical Channels and Applet Selection](../../../3.1/JCRESpec_3.1.pdf#page=27)
  # Source: [JCRE 3.2, s4 Logical Channels and Applet Selection](../../../3.2/JCRESpec_3.2.pdf#page=27)

  Background:
    Given a Java Card secure element with a compliant JCRE implementation
    And the Java Card RE is initialized

  # ---------------------------------------------------------------------------
  # 4.1 Logical Channels Overview
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.1 Logical Channels Overview](../../../3.0.5/JCRESpec_3.0.5.pdf#page=24)
  # Source: [JCRE 3.1, s4.1 Logical Channels Overview](../../../3.1/JCRESpec_3.1.pdf#page=27)
  # Source: [JCRE 3.2, s4.1 Logical Channels Overview](../../../3.2/JCRESpec_3.2.pdf#page=27)
  Scenario: Active applet instance definition
    Given an applet instance is currently selected on at least one logical channel
    Then it is considered an active applet instance
    And an active applet instance can be active on up to forty logical channels (20 per interface, 2 interfaces)
    And each active applet instance from a distinct context executes with a distinct CLEAR_ON_DESELECT transient memory segment

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.1 Logical Channels Overview](../../../3.0.5/JCRESpec_3.0.5.pdf#page=24)
  # Source: [JCRE 3.1, s4.1 Logical Channels Overview](../../../3.1/JCRESpec_3.1.pdf#page=27)
  # Source: [JCRE 3.2, s4.1 Logical Channels Overview](../../../3.2/JCRESpec_3.2.pdf#page=27)
  Scenario: Currently selected applet instance definition
    Given an applet instance is processing the current command
    Then it is the currently selected applet instance
    And there can only be one currently selected applet instance at a given time

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.1 Logical Channels Overview](../../../3.0.5/JCRESpec_3.0.5.pdf#page=24)
  # Source: [JCRE 3.1, s4.1 Logical Channels Overview](../../../3.1/JCRESpec_3.1.pdf#page=27)
  # Source: [JCRE 3.2, s4.1 Logical Channels Overview](../../../3.2/JCRESpec_3.2.pdf#page=27)
  Scenario: Basic logical channel after card reset
    When a card reset occurs on the contacted I/O interface
    Then only logical channel number 0 (the basic logical channel) becomes active
    And the basic logical channel is permanent and can never be closed as long as the I/O interface remains activated

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.1 Logical Channels Overview](../../../3.0.5/JCRESpec_3.0.5.pdf#page=24)
  # Source: [JCRE 3.1, s4.1 Logical Channels Overview](../../../3.1/JCRESpec_3.1.pdf#page=27)
  # Source: [JCRE 3.2, s4.1 Logical Channels Overview](../../../3.2/JCRESpec_3.2.pdf#page=27)
  Scenario: Conditions when no applet is active on a channel
    Then no applet is active on a logical channel when one of the following occurs:
      | condition                                                                                  |
      | Card reset and no default applet for basic channel, or default applet rejects selection      |
      | PICC activation and no default applet for basic channel, or default applet rejects selection |
      | MANAGE CHANNEL OPEN on basic channel opens new channel with no designated default applet     |
      | MANAGE CHANNEL OPEN issued on non-basic channel where no applet is active                   |
      | SELECT FILE command fails when attempting to select an applet instance                      |

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.1 Logical Channels Overview](../../../3.0.5/JCRESpec_3.0.5.pdf#page=24)
  # Source: [JCRE 3.1, s4.1 Logical Channels Overview](../../../3.1/JCRESpec_3.1.pdf#page=27)
  # Source: [JCRE 3.2, s4.1 Logical Channels Overview](../../../3.2/JCRESpec_3.2.pdf#page=27)
  Scenario: Non-multiselectable applet protection
    Given an applet is not designed to be aware of multiple sessions
    And the applet is written for a single logical channel environment
    When the applet is running on a Java Card Platform supporting logical channels
    Then the Java Card RE must guarantee that the applet is not selected more than once
    And the applet is not selected concurrently with another applet from the same context

  # ---------------------------------------------------------------------------
  # 4.3 Multiselectable Applets
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: Multiselectable applet interface requirement
    Given an applet has the capability of being selected on multiple logical channels at the same time
    Or the applet accepts other applets belonging to the same context being selected simultaneously
    Then the applet is referred to as a multiselectable applet
    And it shall implement the javacard.framework.MultiSelectable interface
    And all applets within a CAP file shall be multiselectable or none shall be

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: Context active definition and multiselection attempt
    Given an applet's context is active when either the applet itself or another applet from the same context is active
    When an attempt is made to select an applet instance when its context is already active
    Then this is referred to as a multiselection attempt
    And if successful, the applet instance becomes multiselected

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: First selection in context uses Applet.select
    Given an applet instance is not currently active and is the first one selected in its context
    When the applet is selected
    Then Applet.select method is called

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: Subsequent multiselection uses MultiSelectable.select
    Given another applet instance from the same context is already active
    When a multiselection attempt occurs on this applet or another applet in the same context
    Then MultiSelectable.select method shall be called
    And the applet instance may accept or reject the multiselection attempt

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: Non-multiselectable applet rejects multiselection
    Given an applet does not implement the MultiSelectable interface
    When a multiselection attempt is made on the applet
    Then the selection shall be rejected by the Java Card RE

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: Multiselection case 1 - two instances same context share transient segment
    Given two distinct applet instances from within the same context are multiselected
    Then each applet instance shares the same CLEAR_ON_DESELECT memory transient segment
    And the applet instances share objects within the context firewall as well as their transient data
    And the Java Card RE shall not reset this CLEAR_ON_DESELECT transient segment until all applet instances within the context are deselected

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: Multiselection case 2 - same instance on multiple channels
    Given the same applet instance is multiselected on two different logical channels simultaneously
    Then it shares the CLEAR_ON_DESELECT memory segment space across logical channels
    And the Java Card RE shall not reset the CLEAR_ON_DESELECT transient objects until all applet instances within the context are deselected

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.3 Multiselectable Applets](../../../3.0.5/JCRESpec_3.0.5.pdf#page=29)
  # Source: [JCRE 3.1, s4.3 Multiselectable Applets](../../../3.1/JCRESpec_3.1.pdf#page=32)
  # Source: [JCRE 3.2, s4.3 Multiselectable Applets](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: MultiSelectable.deselect called when still active elsewhere
    Given a multiselected applet instance is deselected from one logical channel
    And the applet instance is the last active applet instance in its context on that channel but remains active on other channels
    Then MultiSelectable.deselect is called with appInstStillActive set to true
    And only when the multiselected applet instance is the last active instance in the context is Applet.deselect called

  # ---------------------------------------------------------------------------
  # 4.5 Opening and Closing Logical Channels
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.5 Opening and Closing Logical Channels](../../../3.0.5/JCRESpec_3.0.5.pdf#page=32)
  # Source: [JCRE 3.1, s4.5 Opening and Closing Logical Channels](../../../3.1/JCRESpec_3.1.pdf#page=36)
  # Source: [JCRE 3.2, s4.5 Opening and Closing Logical Channels](../../../3.2/JCRESpec_3.2.pdf#page=36)
  Scenario: Two ways to open a logical channel
    Then there are two ways to open a logical channel:
      | method                                                                                           |
      | SELECT FILE APDU with logical channel number in CLA byte; opens channel if currently closed       |
      | MANAGE CHANNEL OPEN APDU command; opens a channel from another already-open logical channel       |

  # ---------------------------------------------------------------------------
  # 4.5.1 MANAGE CHANNEL OPEN
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.6.1 Applet Selection with MANAGE CHANNEL OPEN](../../../3.0.5/JCRESpec_3.0.5.pdf#page=34)
  # Source: [JCRE 3.1, s4.6.1 Applet Selection with MANAGE CHANNEL OPEN](../../../3.1/JCRESpec_3.1.pdf#page=37)
  # Source: [JCRE 3.2, s4.6.1 Applet Selection with MANAGE CHANNEL OPEN](../../../3.2/JCRESpec_3.2.pdf#page=38)
  Scenario: MANAGE CHANNEL OPEN step-by-step processing
    Given the Java Card RE receives a MANAGE CHANNEL OPEN command on an I/O interface
    # Step 1: CLA and variant parsing
    Then the MANAGE CHANNEL OPEN command uses CLA=%b000000cc* or CLA=%0100dddd*, INS=0x70, P1=0
    And two variants are supported: P2=0 (RE assigns channel) and P2=channel number (specified)
    # Step 1 errors:
    And if the command has non-zero secure messaging bits in CLA when SM is not supported, the RE responds with 0x6882 (SW_SECURE_MESSAGING_NOT_SUPPORTED)
    And if the specified logical channel number is greater than 3 for Type 4 only or 19 otherwise, the RE responds with 0x6A81 (SW_FUNC_NOT_SUPPORTED)
    # Step 2: Origin channel not open
    And if the origin logical channel on that I/O interface is not open, the RE responds with 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED)
    # Step 3: Basic channel only
    And if the RE supports only the basic logical channel on that I/O interface, the RE responds with 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED)
    # Step 4: P2=0 variant checks
    And if P2=0 and the expected length (Le) is not equal to 1, the RE responds with 0x6C01
    And if P2=0 and resources for the new logical channel are not available, the RE responds with 0x6A81 (SW_FUNC_NOT_SUPPORTED)
    # Step 5: P2!=0 variant checks
    And if P2!=0 and the specified channel is not supported, not available, or already open, the RE responds with 0x6A86 (SW_INCORRECT_P1P2)
    # Step 6: Channel is now open
    And the new logical channel on the I/O interface is now open and becomes the assigned channel
    # Step 7: Determine candidate applet
    And if origin is basic channel (0): pick default applet for new channel if defined, otherwise no applet is active
    And if origin is not basic channel: pick the active applet on the origin channel if any, otherwise no applet is active
    # Step 8: Non-multiselectable check
    And if the candidate applet is not multiselectable and its context is active, the RE closes the new channel and responds with 0x6985 (SW_CONDITIONS_NOT_SATISFIED)
    # Step 9: Assign CLEAR_ON_DESELECT segment
    And if the candidate applet's context is active, assign the existing CLEAR_ON_DESELECT segment for that context
    And if the context is not active, assign a new zero-filled CLEAR_ON_DESELECT segment
    # Step 10: Selection accept check
    And if candidate context is active, call MultiSelectable.select with appInstAlreadyActive=true if same instance is already active
    And if candidate context is not active, call Applet.select
    And if select throws an exception, returns false, or returns true during an active transaction, the RE closes the new channel and responds with 0x6999 (SW_APPLET_SELECT_FAILED)
    # Step 11: Success
    And the RE responds with 0x9000 (and if P2=0, includes 1 data byte with the newly assigned channel number)
    And the MANAGE CHANNEL command is never forwarded to the applet instance

  # ---------------------------------------------------------------------------
  # 4.7.1 MANAGE CHANNEL CLOSE
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.7.1 MANAGE CHANNEL CLOSE Command](../../../3.0.5/JCRESpec_3.0.5.pdf#page=38)
  # Source: [JCRE 3.1, s4.7.1 MANAGE CHANNEL CLOSE Command](../../../3.1/JCRESpec_3.1.pdf#page=42)
  # Source: [JCRE 3.2, s4.7.1 MANAGE CHANNEL CLOSE Command](../../../3.2/JCRESpec_3.2.pdf#page=42)
  Scenario: MANAGE CHANNEL CLOSE step-by-step processing
    Given the Java Card RE receives a MANAGE CHANNEL CLOSE command on an I/O interface
    # Step 1: CLA and command parsing
    Then the MANAGE CHANNEL CLOSE command uses CLA=%b000000cc* or CLA=%0100dddd*, INS=0x70, P1=0x80, and P2 specifies the logical channel to close
    And if the command has non-zero secure messaging bits in CLA when SM is not supported, the RE responds with 0x6882 (SW_SECURE_MESSAGING_NOT_SUPPORTED)
    # Step 2: Origin channel not open
    And if the origin logical channel on the I/O interface is not open, the RE responds with 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED)
    # Step 3: Basic channel only
    And if the RE supports only the basic logical channel on the I/O interface, the RE responds with 0x6881 (SW_LOGICAL_CHANNEL_NOT_SUPPORTED)
    # Step 4: Cannot close basic channel
    And if the specified logical channel to close is the basic logical channel (channel 0) or the channel number is greater than 3 for Type 4 only or greater than 19 otherwise, the RE responds with 0x6A81 (SW_FUNC_NOT_SUPPORTED)
    # Step 5: Channel open - deselect and close
    And if the specified logical channel to close is currently open, deselect the active applet instance (if any) as described in the Applet Deselection procedure, and close the channel, and respond with 0x9000
    # Step 6: Already closed
    And if the specified logical channel is closed or not available on that I/O interface, the RE responds with warning 0x6200 (SW_WARNING_STATE_UNCHANGED)

  # ---------------------------------------------------------------------------
  # 4.2 Default Applets
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.2.1 Card Reset Behavior](../../../3.0.5/JCRESpec_3.0.5.pdf#page=27)
  # Source: [JCRE 3.1, s4.2.1 Card Reset Behavior](../../../3.1/JCRESpec_3.1.pdf#page=30)
  # Source: [JCRE 3.2, s4.2.1 Card Reset Behavior](../../../3.2/JCRESpec_3.2.pdf#page=31)
  Scenario: Card reset behavior for default applet
    Given a card reset (or power on) occurs on the contacted I/O interface
    Then the Java Card RE performs its initialization
    And checks if its internal state indicates a default applet instance for the basic logical channel
    And if so, makes this applet the currently selected applet on the basic logical channel and calls select
    And if select throws an exception or returns false, or returns true during an active transaction, the RE sets no applet active on the basic channel
    And when a default applet becomes active upon card reset it shall not require its process method to be called (no SELECT FILE APDU)
    And the Java Card RE ensures the ATR was sent and the card is ready to accept APDU commands

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.2.2 Proximity Card (PICC) Activation Behavior](../../../3.0.5/JCRESpec_3.0.5.pdf#page=28)
  # Source: [JCRE 3.1, s4.2.2 Proximity Card (PICC) Activation Behavior](../../../3.1/JCRESpec_3.1.pdf#page=31)
  # Source: [JCRE 3.2, s4.2.2 Proximity Card (PICC) Activation Behavior](../../../3.2/JCRESpec_3.2.pdf#page=31)
  Scenario: PICC activation behavior for default applet
    Given the PICC activation sequence completes successfully on the contactless interface
    Then the Java Card RE performs initialization if the contacted interface is not already active
    And checks for a default applet instance for the basic logical channel on the contactless I/O interface
    And if the default applet is not multiselectable and its context is already active on contacted interface, no applet is active on contactless basic channel
    And otherwise makes the default applet the currently selected applet on the contactless basic channel
    And calls MultiSelectable.select if the applet's context is active on contacted, or Applet.select otherwise
    And if select throws an exception or returns false or returns true during an active transaction, no applet is active
    And the default applet shall not require its process method to be called

  @v3.0.5 @v3.1 @v3.2
  # Source: [JCRE 3.0.5, s4.2.3 Default Applet Selection on Opening New Channel](../../../3.0.5/JCRESpec_3.0.5.pdf#page=28)
  # Source: [JCRE 3.1, s4.2.3 Default Applet Selection Behavior on Opening a New Channel](../../../3.1/JCRESpec_3.1.pdf#page=31)
  # Source: [JCRE 3.2, s4.2.3 Default Applet Selection Behavior on Opening a New Channel](../../../3.2/JCRESpec_3.2.pdf#page=32)
  Scenario: Default applet on opening a new channel
    Given a MANAGE CHANNEL command is issued on the basic logical channel and a new channel is opened
    When there is a designated default applet instance for the newly opened channel
    Then the Java Card RE makes this applet the currently selected applet on the new channel
    And calls the applet's select method (MultiSelectable.select if required)
    And if select throws an exception, returns false, or returns true during active transaction, the new channel is closed
    And the process method is not called during default applet selection because there is no SELECT FILE APDU
    And a MANAGE CHANNEL or SELECT FILE command opens new channels only on the same I/O interface
