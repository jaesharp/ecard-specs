@javacardx
@javacardx.security.cert
@v3.1
@v3.2
Feature: Certificate and CertificateParser -- Digital Certificate Framework
  The javacardx.security.cert package provides a framework for parsing and
  managing digital certificates on Java Card. Certificate is the abstract base.
  CertificateParser provides parsing and building operations.
  CertificateException signals certificate processing errors.

  # Source: [JavaCard 3.2 API, cert package](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/package-summary.html)
  Background:
    Given a JavaCard runtime environment

  # ========== Certificate ==========
  Scenario: Certificate.getType returns the certificate type
    Given a Certificate instance
    When getType() is called
    Then the certificate type identifier is returned

  # Source: [JavaCard 3.2 API, getType](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/Certificate.html#getType)
  Scenario: Certificate.getPublicKey extracts the subject public key
    Given a Certificate instance
    When getPublicKey(javacard.security.PublicKey key) is called
    Then the subject's public key from the certificate is loaded into the provided key object

  # Source: [JavaCard 3.2 API, getPublicKey](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/Certificate.html#getPublicKey(PublicKey))
  Scenario: Certificate.verify verifies the certificate signature
    Given a Certificate instance
    When verify(javacard.security.PublicKey signingKey) is called
    Then the certificate's signature is verified using the provided signing key
    And returns true if the signature is valid, false otherwise

  # Source: [JavaCard 3.2 API, verify](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/Certificate.html#verify(PublicKey))
  # ========== CertificateParser ==========
  Scenario: CertificateParser defines type constants
    Then class CertificateParser defines static byte constant "TYPE_X509_DER" for DER-encoded X.509 certificates

  # Source: [JavaCard 3.2 API, TYPE_X509_DER](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateParser.html)
  Scenario: CertificateParser.getInstance creates a parser instance
    When CertificateParser.getInstance(byte certType) is called
    Then a CertificateParser for the specified certificate type is returned

  # Source: [JavaCard 3.2 API, getInstance](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateParser.html#getInstance(byte))
  Scenario: CertificateParser.buildCert builds a Certificate from DER data
    Given a CertificateParser instance
    When buildCert(byte[] certBuf, short certOff, short certLen, CertificateParser.KeyHandler keyHandler) is called
    Then a Certificate object is constructed from the DER-encoded data
    And the KeyHandler callback is used to build the public key

  # Source: [JavaCard 3.2 API, buildCert](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateParser.html#buildCert)
  Scenario: CertificateParser.parseCert parses a certificate using a handler
    Given a CertificateParser instance
    When parseCert(byte[] certBuf, short certOff, short certLen, CertificateParser.ParserHandler handler) is called
    Then the certificate is parsed and fields are delivered to the handler callbacks

  # Source: [JavaCard 3.2 API, parseCert](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateParser.html#parseCert)
  # ========== CertificateParser.KeyHandler ==========
  Scenario: CertificateParser.KeyHandler is a callback for public key construction
    Then CertificateParser.KeyHandler is an interface with a method to build a PublicKey from parsed data

  # Source: [JavaCard 3.2 API, KeyHandler](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateParser.html)
  # ========== CertificateParser.ParserHandler ==========
  Scenario: CertificateParser.ParserHandler is a callback for certificate field processing
    Then CertificateParser.ParserHandler is an interface with methods to receive parsed certificate fields

  # Source: [JavaCard 3.2 API, ParserHandler](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateParser.html)
  # ========== CertificateException ==========
  Scenario Outline: CertificateException defines reason codes
    Then class CertificateException defines static short constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateException.html)
    Examples:
      | constant                   |
      | INVALID_ENCODING           |
      | INVALID_PARAM              |
      | MISSING_DATA               |
      | INVALID_SIGNATURE          |
      | PARSER_HANDLER_EXCEPTION   |
      | PARSER_HANDLER_INVALID_KEY |

  Scenario: CertificateException.throwIt throws a CertificateException
    When CertificateException.throwIt(short reason) is called
    Then a CertificateException is thrown with the specified reason code


# Source: [JavaCard 3.2 API, throwIt](../../../../.refs/javadoc-3.2/api_classic/javacardx/security/cert/CertificateException.html#throwIt(short))