@javacardx
@javacardx.biometry
@v3.0.5
@v3.1
@v3.2
Feature: Biometry 1:1 -- BioTemplate, OwnerBioTemplate, SharedBioTemplate, BioBuilder, BioException
  The javacardx.biometry package provides a framework for biometric 1:1 template
  matching on Java Card. BioTemplate is the base interface for biometric reference
  templates; OwnerBioTemplate extends it with enrollment capabilities; SharedBioTemplate
  is a Shareable interface for cross-applet biometric verification.

  # Source: [JavaCard 3.2 API, biometry package](../.refs/javadoc-3.2/api_classic/javacardx/biometry/package-summary.html)
  Background:
    Given a JavaCard runtime environment

  # ========== BioBuilder Constants ==========
  Scenario Outline: BioBuilder defines biometric type constants
    Then class BioBuilder defines static byte constant "<constant>" for biometric type

    # Source: [JavaCard 3.2 API, BioBuilder](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioBuilder.html)
    Examples:
      | constant        |
      | FACIAL_FEATURE  |
      | VOICE_PRINT     |
      | FINGERPRINT     |
      | IRIS_SCAN       |
      | RETINA_SCAN     |
      | HAND_GEOMETRY   |
      | SIGNATURE       |
      | KEYSTROKES      |
      | LIP_MOVEMENT    |
      | THERMAL_FACE    |
      | THERMAL_HAND    |
      | GAIT_STYLE      |
      | BODY_ODOR       |
      | DNA_SCAN        |
      | EAR_GEOMETRY    |
      | FINGER_GEOMETRY |
      | PALM_GEOMETRY   |
      | VEIN_PATTERN    |
      | PASSWORD        |

  # ========== BioBuilder Factory Methods ==========
  Scenario: BioBuilder.buildBioTemplate creates an OwnerBioTemplate
    When BioBuilder.buildBioTemplate(byte bioType, byte tryLimit) is called
    Then an OwnerBioTemplate instance for the specified biometric type is returned
    And the try limit for failed match attempts is set to tryLimit

  # Source: [JavaCard 3.2 API, buildBioTemplate](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioBuilder.html#buildBioTemplate(byte,byte))
  Scenario: BioBuilder.buildBioTemplate with RID creates an OwnerBioTemplate for a specific provider
    When BioBuilder.buildBioTemplate(byte[] aidBuf, short aidOff, byte aidLen, byte bioType, byte tryLimit) is called
    Then an OwnerBioTemplate for the specified provider (RID) and biometric type is returned

  # Source: [JavaCard 3.2 API, buildBioTemplate](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioBuilder.html#buildBioTemplate(byte%5B%5D,short,byte,byte,byte))
  Scenario: BioBuilder.buildBioTemplate throws BioException for unsupported type
    When buildBioTemplate is called with an unsupported biometric type
    Then BioException is thrown with reason code NO_SUCH_BIO_TEMPLATE

  # Source: [JavaCard 3.2 API, buildBioTemplate](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioBuilder.html#buildBioTemplate(byte,byte))
  # ========== BioTemplate Interface ==========
  Scenario: BioTemplate.isInitialized checks if reference data is loaded
    Given a BioTemplate instance
    When isInitialized() is called
    Then returns true if reference template data has been fully enrolled via doFinal

  # Source: [JavaCard 3.2 API, isInitialized](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#isInitialized)
  Scenario: BioTemplate.isValidated checks if match was successful
    Given a BioTemplate instance
    When isValidated() is called
    Then returns true if a successful match has been performed and not yet reset

  # Source: [JavaCard 3.2 API, isValidated](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#isValidated)
  Scenario: BioTemplate.reset resets the validated state
    Given a BioTemplate that has been validated
    When reset() is called
    Then isValidated returns false

  # Source: [JavaCard 3.2 API, reset](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#reset)
  Scenario: BioTemplate.getTriesRemaining returns remaining match attempts
    Given a BioTemplate instance
    When getTriesRemaining() is called
    Then the number of remaining match attempts before blocking is returned

  # Source: [JavaCard 3.2 API, getTriesRemaining](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#getTriesRemaining)
  Scenario: BioTemplate.getBioType returns the biometric type
    Given a BioTemplate instance
    When getBioType() is called
    Then the biometric type constant (e.g. BioBuilder.FINGERPRINT) is returned

  # Source: [JavaCard 3.2 API, getBioType](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#getBioType)
  Scenario: BioTemplate.getVersion returns the version information
    Given a BioTemplate instance
    When getVersion(byte[] dest, short offset) is called
    Then version information is written to the destination buffer

  # Source: [JavaCard 3.2 API, getVersion](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#getVersion(byte%5B%5D,short))
  Scenario: BioTemplate.getPublicTemplateData retrieves public data
    Given an initialized BioTemplate instance
    When getPublicTemplateData(short publicOffset, byte[] dest, short destOffset, short length) is called
    Then public portion of the template data is copied to dest

  # Source: [JavaCard 3.2 API, getPublicTemplateData](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#getPublicTemplateData(short,byte%5B%5D,short,short))
  Scenario: BioTemplate.initMatch begins a biometric match
    Given an initialized BioTemplate instance
    When initMatch(byte[] candidate, short offset, short length) is called
    Then the match process is initialized with candidate biometric data
    And returns MINIMUM_SUCCESSFUL_MATCH_SCORE or MATCH_NEEDS_MORE_DATA

  # Source: [JavaCard 3.2 API, initMatch](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#initMatch(byte%5B%5D,short,short))
  Scenario: BioTemplate.match continues or completes biometric matching
    Given a BioTemplate with initMatch already called
    When match(byte[] candidate, short offset, short length) is called
    Then the match score is returned
    And if score >= MINIMUM_SUCCESSFUL_MATCH_SCORE, the template is validated

  # Source: [JavaCard 3.2 API, match](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html#match(byte%5B%5D,short,short))
  Scenario: BioTemplate defines match score constants
    Then BioTemplate defines static short constant "MINIMUM_SUCCESSFUL_MATCH_SCORE" as the threshold for validation
    And BioTemplate defines static short constant "MATCH_NEEDS_MORE_DATA" indicating more data is needed

  # Source: [JavaCard 3.2 API, BioTemplate](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioTemplate.html)
  # ========== OwnerBioTemplate Interface ==========
  Scenario: OwnerBioTemplate.init begins enrollment of reference data
    Given an OwnerBioTemplate instance
    When init(byte[] bArray, short offset, short length) is called
    Then enrollment of the biometric reference template begins

  # Source: [JavaCard 3.2 API, init](../.refs/javadoc-3.2/api_classic/javacardx/biometry/OwnerBioTemplate.html#init(byte%5B%5D,short,short))
  Scenario: OwnerBioTemplate.update continues enrollment
    Given an OwnerBioTemplate with init already called
    When update(byte[] bArray, short offset, short length) is called
    Then additional reference data is added to the enrollment

  # Source: [JavaCard 3.2 API, update](../.refs/javadoc-3.2/api_classic/javacardx/biometry/OwnerBioTemplate.html#update(byte%5B%5D,short,short))
  Scenario: OwnerBioTemplate.doFinal completes enrollment
    Given an OwnerBioTemplate with ongoing enrollment
    When doFinal(byte[] bArray, short offset, short length) is called
    Then enrollment is finalized and the template is marked as initialized

  # Source: [JavaCard 3.2 API, doFinal](../.refs/javadoc-3.2/api_classic/javacardx/biometry/OwnerBioTemplate.html#doFinal(byte%5B%5D,short,short))
  Scenario: OwnerBioTemplate.resetUnblockAndSetTryLimit resets the template
    Given a blocked or validated OwnerBioTemplate
    When resetUnblockAndSetTryLimit(byte tryLimit) is called
    Then the template is unblocked and the try counter is reset to tryLimit

  # Source: [JavaCard 3.2 API, resetUnblockAndSetTryLimit](../.refs/javadoc-3.2/api_classic/javacardx/biometry/OwnerBioTemplate.html#resetUnblockAndSetTryLimit(byte))
  Scenario: OwnerBioTemplate.clear erases reference data
    Given an OwnerBioTemplate with enrolled data
    When clear() is called
    Then all reference template data is erased and isInitialized returns false

  # Source: [JavaCard 3.2 API, clear](../.refs/javadoc-3.2/api_classic/javacardx/biometry/OwnerBioTemplate.html#clear)
  # ========== SharedBioTemplate ==========
  Scenario: SharedBioTemplate extends BioTemplate and Shareable
    Then SharedBioTemplate extends both BioTemplate and javacard.framework.Shareable
    And SharedBioTemplate instances can be shared across applet contexts via SIO

  # Source: [JavaCard 3.2 API, SharedBioTemplate](../.refs/javadoc-3.2/api_classic/javacardx/biometry/SharedBioTemplate.html)
  # ========== BioException ==========
  Scenario Outline: BioException defines reason codes
    Then class BioException defines static short constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioException.html)
    Examples:
      | constant              | description                                   |
      | ILLEGAL_VALUE         | Input parameter is invalid                    |
      | INVALID_DATA          | Biometric data is invalid                     |
      | NO_SUCH_BIO_TEMPLATE  | Requested biometric template type unavailable |
      | NO_TEMPLATES_ENROLLED | No templates have been enrolled               |
      | ILLEGAL_USE           | Method called in incorrect state              |

  Scenario: BioException.throwIt throws a BioException
    When BioException.throwIt(short reason) is called
    Then a BioException is thrown with the specified reason code
    And the JCRE may reuse a single BioException instance


# Source: [JavaCard 3.2 API, throwIt](../.refs/javadoc-3.2/api_classic/javacardx/biometry/BioException.html#throwIt(short))