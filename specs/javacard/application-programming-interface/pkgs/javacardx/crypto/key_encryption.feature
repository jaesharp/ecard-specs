@javacardx
@javacardx.crypto
@v3.0.5
@v3.1
@v3.2
Feature: KeyEncryption -- Encrypted Key Data Access Interface
  The KeyEncryption interface defines methods to enable encrypted key data access
  to a key implementation. When a Cipher is set on a Key implementing this interface,
  key data provided to set methods is decrypted using the specified Cipher before storage.

  # Source: [JavaCard 3.2 API, KeyEncryption](../../../.refs/javadoc-3.2/api_classic/javacardx/crypto/KeyEncryption.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: KeyEncryption.setKeyCipher assigns a decryption cipher
    Given a Key object implementing the KeyEncryption interface
    When setKeyCipher(Cipher keyCipher) is called with a valid Cipher
    Then subsequent key set methods will decrypt input key data using the specified Cipher

  # Source: [JavaCard 3.2 API, setKeyCipher](../../../.refs/javadoc-3.2/api_classic/javacardx/crypto/KeyEncryption.html#setKeyCipher(Cipher))
  Scenario: KeyEncryption.setKeyCipher with null disables decryption
    Given a Key object implementing the KeyEncryption interface
    When setKeyCipher(null) is called
    Then no decryption is performed on input key data in set methods

  # Source: [JavaCard 3.2 API, setKeyCipher](../../../.refs/javadoc-3.2/api_classic/javacardx/crypto/KeyEncryption.html#setKeyCipher(Cipher))
  Scenario: KeyEncryption.getKeyCipher retrieves the current cipher
    Given a Key object implementing KeyEncryption with a Cipher set
    When getKeyCipher() is called
    Then the previously set Cipher object is returned

  # Source: [JavaCard 3.2 API, getKeyCipher](../../../.refs/javadoc-3.2/api_classic/javacardx/crypto/KeyEncryption.html#getKeyCipher)
  Scenario: KeyEncryption.getKeyCipher returns null when no cipher set
    Given a Key object implementing KeyEncryption with default state
    When getKeyCipher() is called
    Then null is returned indicating no decryption is performed


# Source: [JavaCard 3.2 API, getKeyCipher](../../../.refs/javadoc-3.2/api_classic/javacardx/crypto/KeyEncryption.html#getKeyCipher)