@javacardx
@javacardx.apdu
@v3.0.5
@v3.1
@v3.2
Feature: APDUUtil -- APDU CLA Byte Analysis Utility
  The APDUUtil class provides static utility methods for analyzing the CLA byte
  of APDU commands per ISO 7816-4. All methods are static and throw
  NullPointerException or ArrayIndexOutOfBoundsException for invalid buffer access.

  # Source: [JavaCard 3.2 API, APDUUtil](../../../refs/javadoc-3.2/api_classic/javacardx/apdu/util/APDUUtil.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: APDUUtil.getCLAChannel extracts the logical channel from CLA byte
    When getCLAChannel(byte[] buffer, short offset) is called with a valid APDU buffer
    Then the logical channel number encoded in the CLA byte is returned
    And for ISO interindustry CLA, bits b1-b2 (or extended channel encoding) are decoded

  # Source: [JavaCard 3.2 API, getCLAChannel](../../../refs/javadoc-3.2/api_classic/javacardx/apdu/util/APDUUtil.html#getCLAChannel(byte%5B%5D,short))
  Scenario: APDUUtil.isSecureMessagingCLA detects secure messaging
    When isSecureMessagingCLA(byte[] buffer, short offset) is called
    Then returns true if the CLA byte indicates secure messaging per ISO 7816-4
    And returns false otherwise

  # Source: [JavaCard 3.2 API, isSecureMessagingCLA](../../../refs/javadoc-3.2/api_classic/javacardx/apdu/util/APDUUtil.html#isSecureMessagingCLA(byte%5B%5D,short))
  Scenario: APDUUtil.isCommandChainingCLA detects command chaining
    When isCommandChainingCLA(byte[] buffer, short offset) is called
    Then returns true if the CLA byte indicates command chaining per ISO 7816-4
    And returns false otherwise

  # Source: [JavaCard 3.2 API, isCommandChainingCLA](../../../refs/javadoc-3.2/api_classic/javacardx/apdu/util/APDUUtil.html#isCommandChainingCLA(byte%5B%5D,short))
  Scenario: APDUUtil.isISOInterindustryCLA detects ISO interindustry class
    When isISOInterindustryCLA(byte[] buffer, short offset) is called
    Then returns true if the CLA byte indicates an ISO 7816-4 interindustry command
    And returns false for proprietary CLA values

  # Source: [JavaCard 3.2 API, isISOInterindustryCLA](../../../refs/javadoc-3.2/api_classic/javacardx/apdu/util/APDUUtil.html#isISOInterindustryCLA(byte%5B%5D,short))
  Scenario: APDUUtil.isValidCLA validates the CLA byte
    When isValidCLA(byte[] buffer, short offset) is called
    Then returns true if the CLA byte is a valid command class byte per ISO 7816-4
    And returns false for invalid CLA values (e.g. 0xFF)

# Source: [JavaCard 3.2 API, isValidCLA](../../../refs/javadoc-3.2/api_classic/javacardx/apdu/util/APDUUtil.html#isValidCLA(byte%5B%5D,short))