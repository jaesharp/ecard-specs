@v3.0.5 @v3.1 @v3.2
Feature: Shareable, SensitiveArrays, and Resources
  The Shareable interface identifies objects that can be shared across
  applet contexts via the inter-applet communication mechanism.
  SensitiveArrays provides methods to create and manage integrity-
  sensitive arrays. Resources (since 3.1) provides access to applet
  resource data configured during installation.

  # ===================================================================
  # Shareable Interface
  # ===================================================================

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, Shareable](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Shareable.html)
  # Source: [JavaCard 3.1 API, Shareable](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Shareable.html)
  # Source: [JavaCard 3.2 API, Shareable](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Shareable.html)
  Scenario: Shareable is a tagging interface with no methods
    Given the Shareable interface definition
    Then it declares no methods
    And it serves as a marker for objects shareable across applet contexts

  # Source: [JavaCard 3.0.5 API, Shareable](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Shareable.html)
  # Source: [JavaCard 3.1 API, Shareable](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Shareable.html)
  # Source: [JavaCard 3.2 API, Shareable](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Shareable.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: A shared interface must extend Shareable
    Given an applet wishes to expose a service interface to other applets
    When the service interface extends Shareable
    Then the interface can be returned from Applet.getShareableInterfaceObject()
    And a client applet can obtain it via JCSystem.getAppletShareableInterfaceObject()

  # Source: [JavaCard 3.0.5 API, Shareable](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Shareable.html)
  # Source: [JavaCard 3.1 API, Shareable](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Shareable.html)
  # Source: [JavaCard 3.2 API, Shareable](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Shareable.html)
  @v3.0.5 @v3.1 @v3.2
  Scenario: Only Shareable interface methods are accessible across contexts
    Given an object implementing a Shareable sub-interface
    And a client applet holds a reference to the Shareable interface
    When the client invokes a method defined in the Shareable sub-interface
    Then the method executes in the server applet's context

  # ===================================================================
  # SensitiveArrays Class
  # ===================================================================

  # -------------------------------------------------------------------
  # Method: isIntegritySensitiveArraysSupported()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, isIntegritySensitiveArraysSupported](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitiveArraysSupported)
  # Source: [JavaCard 3.1 API, isIntegritySensitiveArraysSupported](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitiveArraysSupported)
  # Source: [JavaCard 3.2 API, isIntegritySensitiveArraysSupported](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitiveArraysSupported)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isIntegritySensitiveArraysSupported indicates platform capability
    When SensitiveArrays.isIntegritySensitiveArraysSupported() is called
    Then true or false is returned based on platform support

  # -------------------------------------------------------------------
  # Method: makeIntegritySensitiveArray(byte, byte, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, makeIntegritySensitiveArray](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SensitiveArrays.html#makeIntegritySensitiveArray(byte,byte,short)
  # Source: [JavaCard 3.1 API, makeIntegritySensitiveArray](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/SensitiveArrays.html#makeIntegritySensitiveArray(byte,byte,short)
  # Source: [JavaCard 3.2 API, makeIntegritySensitiveArray](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/SensitiveArrays.html#makeIntegritySensitiveArray(byte,byte,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: makeIntegritySensitiveArray creates an integrity-sensitive array
    Given integrity-sensitive arrays are supported
    When SensitiveArrays.makeIntegritySensitiveArray(type, event, length) is called
    Then an integrity-sensitive array of the specified type and length is returned

  # -------------------------------------------------------------------
  # Method: isIntegritySensitive(Object)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, isIntegritySensitive](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitive(Object)
  # Source: [JavaCard 3.1 API, isIntegritySensitive](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitive(Object)
  # Source: [JavaCard 3.2 API, isIntegritySensitive](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitive(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isIntegritySensitive returns true for integrity-sensitive arrays
    Given an array created with makeIntegritySensitiveArray
    When SensitiveArrays.isIntegritySensitive(obj) is called
    Then the result is true

  # Source: [JavaCard 3.0.5 API, isIntegritySensitive](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitive(Object)
  # Source: [JavaCard 3.1 API, isIntegritySensitive](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitive(Object)
  # Source: [JavaCard 3.2 API, isIntegritySensitive](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/SensitiveArrays.html#isIntegritySensitive(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: isIntegritySensitive returns false for regular arrays
    Given a standard byte array
    When SensitiveArrays.isIntegritySensitive(obj) is called
    Then the result is false

  # -------------------------------------------------------------------
  # Method: assertIntegrity(Object)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, assertIntegrity](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SensitiveArrays.html#assertIntegrity(Object)
  # Source: [JavaCard 3.1 API, assertIntegrity](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/SensitiveArrays.html#assertIntegrity(Object)
  # Source: [JavaCard 3.2 API, assertIntegrity](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/SensitiveArrays.html#assertIntegrity(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: assertIntegrity verifies array integrity
    Given an integrity-sensitive array with valid integrity
    When SensitiveArrays.assertIntegrity(obj) is called
    Then no exception is thrown

  # Source: [JavaCard 3.0.5 API, assertIntegrity](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SensitiveArrays.html#assertIntegrity(Object)
  # Source: [JavaCard 3.1 API, assertIntegrity](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/SensitiveArrays.html#assertIntegrity(Object)
  # Source: [JavaCard 3.2 API, assertIntegrity](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/SensitiveArrays.html#assertIntegrity(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: assertIntegrity throws SystemException for corrupted array
    Given an integrity-sensitive array with compromised integrity
    When SensitiveArrays.assertIntegrity(obj) is called
    Then a SystemException is thrown

  # -------------------------------------------------------------------
  # Method: clearArray(Object)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, clearArray](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/SensitiveArrays.html#clearArray(Object)
  # Source: [JavaCard 3.1 API, clearArray](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/SensitiveArrays.html#clearArray(Object)
  # Source: [JavaCard 3.2 API, clearArray](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/SensitiveArrays.html#clearArray(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: clearArray zeros an integrity-sensitive array
    Given an integrity-sensitive byte array
    When SensitiveArrays.clearArray(obj) is called
    Then all elements are set to their default values (0)

  # ===================================================================
  # Resources Class (since 3.1)
  # ===================================================================

  # -------------------------------------------------------------------
  # Method: getResources()
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getResources](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Resources.html#getResources)
  # Source: [JavaCard 3.1 API, getResources](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Resources.html#getResources)
  # Source: [JavaCard 3.2 API, getResources](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Resources.html#getResources)
  @v3.1 @v3.2
  Scenario: getResources returns the Resources instance for the current applet
    Given an applet with associated resource data
    When Resources.getResources() is called
    Then a Resources instance is returned or null if no resources exist

  # -------------------------------------------------------------------
  # Method: getSize(short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.1 API, getSize](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Resources.html#getSize(short)
  # Source: [JavaCard 3.2 API, getSize](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Resources.html#getSize(short)
  @v3.1 @v3.2
  Scenario: getSize returns the size of a resource
    Given a Resources instance with a resource at resourceId 0
    When getSize(0) is called
    Then the size in bytes of that resource is returned

  # -------------------------------------------------------------------
  # Method: getView(short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.1 API, getView](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Resources.html#getView(short)
  # Source: [JavaCard 3.2 API, getView](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Resources.html#getView(short)
  @v3.1 @v3.2
  Scenario: getView returns a read-only byte array view of a resource
    Given a Resources instance with a resource at resourceId 0
    When getView(0) is called
    Then a read-only byte array view of the resource data is returned

  # -------------------------------------------------------------------
  # Method: getView(short, short, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.1 API, getView](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Resources.html#getView(short,short,short)
  # Source: [JavaCard 3.2 API, getView](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Resources.html#getView(short,short,short)
  @v3.1 @v3.2
  Scenario: getView with offset and length returns a partial view
    Given a Resources instance with a resource at resourceId 0
    When getView(0, offset, length) is called
    Then a read-only byte array view of the specified portion is returned
