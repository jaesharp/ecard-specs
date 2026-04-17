@javacardx
@javacardx.security.cert
@v3.1
@v3.2
Feature: X509Certificate -- X.509 Certificate Field Access
  The X509Certificate class extends Certificate to provide access to X.509-specific
  fields and extensions. It defines constants for TBS (To Be Signed) certificate
  fields and provides handlers for extensions.

  # Source: [JavaCard 3.2 API, X509Certificate](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html)
  Background:
    Given a JavaCard runtime environment

  # ========== Field Constants ==========
  Scenario Outline: X509Certificate defines TBS field constants
    Then class X509Certificate defines static byte constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html)
    Examples:
      | constant                  | description                          |
      | FIELD_TBS_VERSION         | X.509 certificate version (v1/v2/v3) |
      | FIELD_TBS_SERIAL_NUMBER   | Certificate serial number            |
      | FIELD_TBS_SIGNATURE_ALG   | Signature algorithm identifier       |
      | FIELD_TBS_ISSUER          | Issuer distinguished name            |
      | FIELD_TBS_NOT_BEFORE      | Validity period start                |
      | FIELD_TBS_NOT_AFTER       | Validity period end                  |
      | FIELD_TBS_SUBJECT         | Subject distinguished name           |
      | FIELD_TBS_PUBLIC_KEY_INFO | Subject public key info              |
      | FIELD_TBS_ISSUER_UID      | Issuer unique identifier (v2/v3)     |
      | FIELD_TBS_SUBJECT_UID     | Subject unique identifier (v2/v3)    |

  # ========== Field Access ==========
  Scenario: X509Certificate.getVersion returns the certificate version
    Given an X509Certificate instance
    When getVersion() is called
    Then the X.509 version number is returned (1, 2, or 3)

  # Source: [JavaCard 3.2 API, getVersion](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html#getVersion)
  Scenario: X509Certificate.getField retrieves a specific TBS field
    Given an X509Certificate instance
    When getField(byte fieldId, byte[] dest, short destOff) is called
    Then the raw DER-encoded field data is copied to dest
    And the number of bytes written is returned

  # Source: [JavaCard 3.2 API, getField](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html#getField(byte,byte%5B%5D,short))
  Scenario: X509Certificate.getExtension retrieves a specific extension
    Given a v3 X509Certificate instance
    When getExtension(byte[] oid, short oidOff, short oidLen, byte[] dest, short destOff) is called
    Then the extension value for the specified OID is copied to dest

  # Source: [JavaCard 3.2 API, getExtension](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html#getExtension(byte%5B%5D,short,short,byte%5B%5D,short))
  Scenario: X509Certificate.getExtensions iterates extensions via handler
    Given a v3 X509Certificate instance
    When getExtensions(X509Certificate.ExtensionHandler handler) is called
    Then each extension is delivered to the handler callback

  # Source: [JavaCard 3.2 API, getExtensions](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html#getExtensions(ExtensionHandler))
  # ========== Handler Interfaces ==========
  Scenario: X509Certificate.FieldHandler receives field data during parsing
    Then X509Certificate.FieldHandler is an interface for receiving TBS field data

  # Source: [JavaCard 3.2 API, FieldHandler](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html)
  Scenario: X509Certificate.ExtensionHandler receives extension data during parsing
    Then X509Certificate.ExtensionHandler is an interface for receiving extension data


# Source: [JavaCard 3.2 API, ExtensionHandler](../../../refs/javadoc-3.2/api_classic/javacardx/security/cert/X509Certificate.html)