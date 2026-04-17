@javacardx
@javacardx.apdu
@v3.0.5
@v3.1
@v3.2
Feature: ExtendedLength -- Extended Length APDU Support Marker Interface
  The ExtendedLength interface is a tagging interface that applets must implement
  to indicate support for extended length APDU commands and responses as defined
  in ISO 7816-4.

  When an applet implements this interface, the JCRE will accept and deliver
  extended length APDU commands (Lc and Le fields up to 65535 bytes) to the applet.

  # Source: [JavaCard 3.2 API, ExtendedLength](../../refs/javadoc-3.2/api_classic/javacardx/apdu/ExtendedLength.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: Applet implementing ExtendedLength receives extended APDUs
    Given an applet class that implements the ExtendedLength interface
    When an extended length APDU command is received with Lc or Le exceeding 255
    Then the JCRE delivers the full extended APDU to the applet

  # Source: [JavaCard 3.2 API, ExtendedLength](../../refs/javadoc-3.2/api_classic/javacardx/apdu/ExtendedLength.html)
  Scenario: Applet not implementing ExtendedLength cannot receive extended APDUs
    Given an applet class that does not implement ExtendedLength
    When an extended length APDU command is received
    Then the JCRE does not deliver the extended APDU to the applet


# Source: [JavaCard 3.2 API, ExtendedLength](../../refs/javadoc-3.2/api_classic/javacardx/apdu/ExtendedLength.html)