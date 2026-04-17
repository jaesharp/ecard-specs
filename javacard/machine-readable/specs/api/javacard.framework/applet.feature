@v3.0.5 @v3.1 @v3.2
Feature: Applet, AppletEvent, and MultiSelectable
  The abstract Applet class defines a Java Card applet. It must be
  extended by any applet loaded onto, installed into, and executed
  on a Java Card platform. AppletEvent provides an uninstall callback.
  MultiSelectable supports concurrent selection on multiple logical
  channels or I/O interfaces.

  # ===================================================================
  # Applet class
  # ===================================================================

  # -------------------------------------------------------------------
  # Constructor: Applet()
  # -------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, Applet](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html)
  # Source: [JavaCard 3.1 API, Applet](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html)
  # Source: [JavaCard 3.2 API, Applet](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html)
  Scenario: Applet constructor is protected
    Given a class extending Applet
    When the constructor is called from within install()
    Then the Applet instance is created
    And the constructor is accessible only to subclasses

  # -------------------------------------------------------------------
  # Method: install(byte[], short, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, install](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, install](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, install](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: install is called by the JCRE to create an applet instance
    Given a compliant Applet subclass
    When the JCRE calls install(bArray, bOffset, bLength)
    Then the applet performs initialization
    And the applet calls one of the register() methods
    And the installation is considered successful

  # Source: [JavaCard 3.0.5 API, install](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, install](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, install](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: install parameter format uses length-value pairs
    Given the install parameters in bArray at bOffset
    Then bArray[bOffset] is the length Li of instance AID
    And bArray[bOffset+1..bOffset+Li] contains the instance AID bytes
    And bArray[bOffset+Li+1] is the length Lc of control info
    And bArray[bOffset+Li+Lc+2] is the length La of applet data

  # Source: [JavaCard 3.0.5 API, install](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, install](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, install](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: install bLength maximum value is 127
    Given the install method parameter bLength
    Then the maximum value of bLength is 127

  # Source: [JavaCard 3.0.5 API, install](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, install](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, install](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Default install implementation throws ISOException
    Given the base Applet class install method
    When install is called without being overridden
    Then an ISOException is thrown with reason ISO7816.SW_FUNC_NOT_SUPPORTED

  # Source: [JavaCard 3.0.5 API, install](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, install](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, install](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: bArray is zeroed after install returns
    Given the JCRE calls install(bArray, bOffset, bLength)
    When install returns normally
    Then the JCRE zeroes out bArray

  # Source: [JavaCard 3.0.5 API, install](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, install](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, install](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#install(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: bArray reference cannot be stored
    Given the bArray parameter in install()
    Then references to bArray cannot be stored in class variables
    And references to bArray cannot be stored in instance variables
    And references to bArray cannot be stored in array components

  # -------------------------------------------------------------------
  # Method: process(APDU)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, process](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#process(APDU)
  # Source: [JavaCard 3.1 API, process](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#process(APDU)
  # Source: [JavaCard 3.2 API, process](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#process(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: process is called by JCRE to handle an incoming APDU command
    Given a selected applet
    When the JCRE receives an APDU command
    Then process(APDU) is called on the selected applet
    And the 5 header bytes are available in the APDU buffer

  # Source: [JavaCard 3.0.5 API, process](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#process(APDU)
  # Source: [JavaCard 3.1 API, process](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#process(APDU)
  # Source: [JavaCard 3.2 API, process](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#process(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Normal return from process sends SW 9000
    Given process(APDU) returns normally
    Then the JCRE sends status word 0x9000 (SW_NO_ERROR) in the response

  # Source: [JavaCard 3.0.5 API, process](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#process(APDU)
  # Source: [JavaCard 3.1 API, process](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#process(APDU)
  # Source: [JavaCard 3.2 API, process](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#process(APDU)
  @v3.0.5 @v3.1 @v3.2
  Scenario: ISOException from process sends the exception's reason code
    Given process(APDU) throws an ISOException with reason code 0x6A82
    Then the JCRE sends status word 0x6A82 in the response

  # -------------------------------------------------------------------
  # Method: select()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, select](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.1 API, select](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.2 API, select](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#select)
  @v3.0.5 @v3.1 @v3.2
  Scenario: select is called when applet is selected with no group context active
    Given no applet from the same group context is active on any channel
    When a SELECT APDU or MANAGE CHANNEL OPEN command selects this applet
    Then select() is called before the applet processes commands

  # Source: [JavaCard 3.0.5 API, select](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.1 API, select](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.2 API, select](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#select)
  @v3.0.5 @v3.1 @v3.2
  Scenario: select returns true to accept selection
    Given the default Applet.select() implementation
    When select() is called
    Then it returns true

  # Source: [JavaCard 3.0.5 API, select](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.1 API, select](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.2 API, select](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#select)
  @v3.0.5 @v3.1 @v3.2
  Scenario: select returns false to decline selection
    Given a subclass overrides select() to return false
    When select() returns false
    Then the JCRE does not select this applet

  # Source: [JavaCard 3.0.5 API, select](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.1 API, select](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#select)
  # Source: [JavaCard 3.2 API, select](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#select)
  @v3.0.5 @v3.1 @v3.2
  Scenario: MultiSelectable.select is not called when Applet.select is invoked
    Given an applet that implements MultiSelectable
    When Applet.select() is invoked (no group context active)
    Then MultiSelectable.select(boolean) is NOT called

  # -------------------------------------------------------------------
  # Method: deselect()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, deselect](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.1 API, deselect](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.2 API, deselect](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#deselect)
  @v3.0.5 @v3.1 @v3.2
  Scenario: deselect is called when applet is deselected and no group context remains active
    Given a currently selected applet
    And no applet from the same group context is active on any other channel
    When a SELECT or MANAGE CHANNEL CLOSE command deselects this applet
    Then deselect() is called

  # Source: [JavaCard 3.0.5 API, deselect](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.1 API, deselect](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.2 API, deselect](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#deselect)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Default deselect implementation does nothing
    Given the base Applet.deselect() implementation
    When deselect() is called
    Then no action is performed

  # Source: [JavaCard 3.0.5 API, deselect](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.1 API, deselect](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.2 API, deselect](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#deselect)
  @v3.0.5 @v3.1 @v3.2
  Scenario: CLEAR_ON_DESELECT transient objects are cleared after deselect
    Given transient objects of type CLEAR_ON_DESELECT
    When deselect() returns
    Then those transient objects are cleared to default values by the JCRE

  # Source: [JavaCard 3.0.5 API, deselect](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.1 API, deselect](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#deselect)
  # Source: [JavaCard 3.2 API, deselect](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#deselect)
  @v3.0.5 @v3.1 @v3.2
  Scenario: deselect is NOT called on reset or power loss
    Given a selected applet
    When a card reset or power loss occurs
    Then deselect() is NOT called

  # -------------------------------------------------------------------
  # Method: register()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, register](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#register)
  # Source: [JavaCard 3.1 API, register](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#register)
  # Source: [JavaCard 3.2 API, register](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#register)
  @v3.0.5 @v3.1 @v3.2
  Scenario: register() with no arguments uses platform name as instance AID
    Given an Applet subclass within install()
    When register() is called with no arguments
    Then the applet is registered with the JCRE
    And the Java Card platform name of the applet is used as the instance AID

  # Source: [JavaCard 3.0.5 API, register](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#register)
  # Source: [JavaCard 3.1 API, register](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#register)
  # Source: [JavaCard 3.2 API, register](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#register)
  @v3.0.5 @v3.1 @v3.2
  Scenario: register() throws SystemException ILLEGAL_AID if AID is in use
    Given another applet already registered with the same AID
    When register() is called
    Then a SystemException is thrown with reason ILLEGAL_AID

  # Source: [JavaCard 3.0.5 API, register](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#register)
  # Source: [JavaCard 3.1 API, register](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#register)
  # Source: [JavaCard 3.2 API, register](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#register)
  @v3.0.5 @v3.1 @v3.2
  Scenario: register() throws SystemException ILLEGAL_AID if already registered
    Given register() was previously called successfully
    When register() is called again
    Then a SystemException is thrown with reason ILLEGAL_AID

  # -------------------------------------------------------------------
  # Method: register(byte[], short, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, register](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#register(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, register](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#register(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, register](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#register(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: register with AID bytes assigns specified instance AID
    Given an Applet subclass within install()
    And a byte array containing AID bytes of length 7
    When register(bArray, bOffset, bLength) is called
    Then the applet is registered with the specified AID

  # Source: [JavaCard 3.0.5 API, register](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#register(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, register](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#register(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, register](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#register(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: register with AID throws SystemException ILLEGAL_VALUE for bad length
    Given an Applet subclass within install()
    When register is called with bLength less than 5 or greater than 16
    Then a SystemException is thrown with reason ILLEGAL_VALUE

  # -------------------------------------------------------------------
  # Method: selectingApplet()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, selectingApplet](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#selectingApplet)
  # Source: [JavaCard 3.1 API, selectingApplet](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#selectingApplet)
  # Source: [JavaCard 3.2 API, selectingApplet](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#selectingApplet)
  @v3.0.5 @v3.1 @v3.2
  Scenario: selectingApplet returns true during the SELECT APDU that selected this applet
    Given process() is handling the SELECT APDU that selected this applet
    When selectingApplet() is called
    Then the result is true

  # Source: [JavaCard 3.0.5 API, selectingApplet](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#selectingApplet)
  # Source: [JavaCard 3.1 API, selectingApplet](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#selectingApplet)
  # Source: [JavaCard 3.2 API, selectingApplet](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#selectingApplet)
  @v3.0.5 @v3.1 @v3.2
  Scenario: selectingApplet returns false for other SELECT APDUs
    Given process() is handling a SELECT APDU for file selection (not applet selection)
    When selectingApplet() is called
    Then the result is false

  # -------------------------------------------------------------------
  # Method: reSelectingApplet() -- since 3.0.4
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, reSelectingApplet](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#reSelectingApplet)
  # Source: [JavaCard 3.1 API, reSelectingApplet](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#reSelectingApplet)
  # Source: [JavaCard 3.2 API, reSelectingApplet](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#reSelectingApplet)
  @v3.0.5 @v3.1 @v3.2
  Scenario: reSelectingApplet returns true when applet is being re-selected
    Given the currently selected applet was just deselected on this logical channel
    And the same applet is being selected again
    When reSelectingApplet() is called from select(), process(), or deselect()
    Then the result is true

  # Source: [JavaCard 3.0.5 API, reSelectingApplet](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#reSelectingApplet)
  # Source: [JavaCard 3.1 API, reSelectingApplet](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#reSelectingApplet)
  # Source: [JavaCard 3.2 API, reSelectingApplet](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#reSelectingApplet)
  @v3.0.5 @v3.1 @v3.2
  Scenario: reSelectingApplet returns false for first-time selection
    Given the applet was not previously selected on this channel
    When reSelectingApplet() is called
    Then the result is false

  # -------------------------------------------------------------------
  # Method: getShareableInterfaceObject(AID, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getShareableInterfaceObject](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#getShareableInterfaceObject(AID,byte)
  # Source: [JavaCard 3.1 API, getShareableInterfaceObject](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#getShareableInterfaceObject(AID,byte)
  # Source: [JavaCard 3.2 API, getShareableInterfaceObject](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#getShareableInterfaceObject(AID,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getShareableInterfaceObject is called by JCRE for inter-applet sharing
    Given a client applet requests a shareable interface
    When the JCRE calls getShareableInterfaceObject(clientAID, parameter) on the server applet
    Then the server applet may return a Shareable interface object or null

  # Source: [JavaCard 3.0.5 API, getShareableInterfaceObject](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Applet.html#getShareableInterfaceObject(AID,byte)
  # Source: [JavaCard 3.1 API, getShareableInterfaceObject](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Applet.html#getShareableInterfaceObject(AID,byte)
  # Source: [JavaCard 3.2 API, getShareableInterfaceObject](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Applet.html#getShareableInterfaceObject(AID,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Default getShareableInterfaceObject returns null
    Given the base Applet class implementation
    When getShareableInterfaceObject is called
    Then null is returned

  # ===================================================================
  # AppletEvent interface
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, uninstall](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AppletEvent.html#uninstall)
  # Source: [JavaCard 3.1 API, uninstall](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/AppletEvent.html#uninstall)
  # Source: [JavaCard 3.2 API, uninstall](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/AppletEvent.html#uninstall)
  @v3.0.5 @v3.1 @v3.2
  Scenario: uninstall is called by JCRE when applet is being removed
    Given an applet that implements AppletEvent
    When the JCRE is removing the applet
    Then AppletEvent.uninstall() is called
    And the applet can perform cleanup operations

  # ===================================================================
  # MultiSelectable interface
  # ===================================================================

  # Source: [JavaCard 3.0.5 API, select](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  # Source: [JavaCard 3.1 API, select](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  # Source: [JavaCard 3.2 API, select](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  @v3.0.5 @v3.1 @v3.2
  Scenario: MultiSelectable.select is called when an applet from same group is already active
    Given an applet that implements MultiSelectable
    And another applet from the same group context is active on another channel
    When this applet is selected
    Then MultiSelectable.select(appInstAlreadyActive) is called
    And appInstAlreadyActive indicates if this instance is already active

  # Source: [JavaCard 3.0.5 API, select](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  # Source: [JavaCard 3.1 API, select](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  # Source: [JavaCard 3.2 API, select](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  @v3.0.5 @v3.1 @v3.2
  Scenario: MultiSelectable.select returns true to accept selection
    Given a MultiSelectable applet
    When select(boolean) returns true
    Then the applet is selected and ready to process APDUs

  # Source: [JavaCard 3.0.5 API, select](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  # Source: [JavaCard 3.1 API, select](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  # Source: [JavaCard 3.2 API, select](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/MultiSelectable.html#select(boolean)
  @v3.0.5 @v3.1 @v3.2
  Scenario: MultiSelectable.select returns false to decline selection
    Given a MultiSelectable applet
    When select(boolean) returns false
    Then the applet declines selection

  # Source: [JavaCard 3.0.5 API, deselect](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/MultiSelectable.html#deselect(boolean)
  # Source: [JavaCard 3.1 API, deselect](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/MultiSelectable.html#deselect(boolean)
  # Source: [JavaCard 3.2 API, deselect](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/MultiSelectable.html#deselect(boolean)
  @v3.0.5 @v3.1 @v3.2
  Scenario: MultiSelectable.deselect is called with active instance flag
    Given a MultiSelectable applet being deselected on one channel
    When another instance from the same group is still active
    Then MultiSelectable.deselect(appInstStillActive=true) is called

  # Source: [JavaCard 3.0.5 API, deselect](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/MultiSelectable.html#deselect(boolean)
  # Source: [JavaCard 3.1 API, deselect](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/MultiSelectable.html#deselect(boolean)
  # Source: [JavaCard 3.2 API, deselect](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/MultiSelectable.html#deselect(boolean)
  @v3.0.5 @v3.1 @v3.2
  Scenario: MultiSelectable.deselect with no remaining active instances
    Given a MultiSelectable applet being deselected
    And no other instance from the same group is still active
    When deselect is called
    Then MultiSelectable.deselect(appInstStillActive=false) is called
