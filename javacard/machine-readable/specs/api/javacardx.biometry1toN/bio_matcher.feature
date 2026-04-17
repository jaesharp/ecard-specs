@javacardx @javacardx.biometry1toN @v3.0.5 @v3.1 @v3.2
Feature: Biometry 1:N -- BioMatcher, BioTemplateData, and Supporting Classes
  The javacardx.biometry1toN package provides a framework for biometric 1:N
  matching on Java Card. BioMatcher manages a collection of BioTemplateData
  objects and supports matching a candidate against multiple enrolled templates.

  Bio1toNBuilder is the factory class. BioMatcher is the base matching interface.
  OwnerBioMatcher extends it with enrollment management. SharedBioMatcher is Shareable.
  BioTemplateData holds individual template data. OwnerBioTemplateData allows enrollment.
  SharedBioTemplateData is Shareable.

  # Source: [JavaCard 3.2 API, biometry1toN package](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN package)

  Background:
    Given a JavaCard runtime environment

  # ========== Bio1toNBuilder Constants ==========

  Scenario Outline: Bio1toNBuilder defines biometric type constants
    Then class Bio1toNBuilder defines static byte constant "<constant>" for biometric type

    # Source: [JavaCard 3.2 API, Bio1toNBuilder](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/Bio1toNBuilder.html)
    Examples:
      | constant           |
      | FACIAL_FEATURE     |
      | VOICE_PRINT        |
      | FINGERPRINT        |
      | IRIS_SCAN          |
      | RETINA_SCAN        |
      | HAND_GEOMETRY      |
      | SIGNATURE          |
      | KEYSTROKES         |
      | LIP_MOVEMENT       |
      | THERMAL_FACE       |
      | THERMAL_HAND       |
      | GAIT_STYLE         |
      | BODY_ODOR          |
      | DNA_SCAN           |
      | EAR_GEOMETRY       |
      | FINGER_GEOMETRY    |
      | PALM_GEOMETRY      |
      | VEIN_PATTERN       |
      | PASSWORD           |

  # ========== Bio1toNBuilder Factory Methods ==========

  Scenario: Bio1toNBuilder.buildBioMatcher creates an OwnerBioMatcher
    When Bio1toNBuilder.buildBioMatcher(byte bioType, byte tryLimit, short maxNbOfBioTemplateData) is called
    Then an OwnerBioMatcher for the specified biometric type is returned
    And the matcher can hold up to maxNbOfBioTemplateData template entries
    # Source: [JavaCard 3.2 API, buildBioMatcher](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/Bio1toNBuilder.html#buildBioMatcher(byte,byte,short))

  Scenario: Bio1toNBuilder.buildBioTemplateData creates an OwnerBioTemplateData
    When Bio1toNBuilder.buildBioTemplateData(byte bioType) is called
    Then an OwnerBioTemplateData for the specified biometric type is returned
    # Source: [JavaCard 3.2 API, buildBioTemplateData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/Bio1toNBuilder.html#buildBioTemplateData(byte))

  # ========== BioMatcher Interface ==========

  Scenario: BioMatcher.isInitialized checks if the matcher has enrolled templates
    Given a BioMatcher instance
    When isInitialized() is called
    Then returns true if at least one BioTemplateData has been enrolled
    # Source: [JavaCard 3.2 API, isInitialized](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#isInitialized)

  Scenario: BioMatcher.isValidated checks match validation state
    Given a BioMatcher instance
    When isValidated() is called
    Then returns true if a successful 1:N match has been performed
    # Source: [JavaCard 3.2 API, isValidated](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#isValidated)

  Scenario: BioMatcher.reset clears validation state
    Given a validated BioMatcher
    When reset() is called
    Then isValidated returns false
    # Source: [JavaCard 3.2 API, reset](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#reset)

  Scenario: BioMatcher.getTriesRemaining returns remaining attempts
    Given a BioMatcher instance
    When getTriesRemaining() is called
    Then the number of remaining match attempts is returned
    # Source: [JavaCard 3.2 API, getTriesRemaining](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#getTriesRemaining)

  Scenario: BioMatcher.getBioType returns the biometric type
    Given a BioMatcher instance
    When getBioType() is called
    Then the biometric type constant is returned
    # Source: [JavaCard 3.2 API, getBioType](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#getBioType)

  Scenario: BioMatcher.initMatch begins a 1:N match
    Given an initialized BioMatcher
    When initMatch(byte[] candidate, short offset, short length) is called
    Then the match process starts against all enrolled BioTemplateData entries
    # Source: [JavaCard 3.2 API, initMatch](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#initMatch(byte%5B%5D,short,short))

  Scenario: BioMatcher.match continues the 1:N matching
    Given a BioMatcher with initMatch already called
    When match(byte[] candidate, short offset, short length) is called
    Then the best match score across all enrolled templates is returned
    # Source: [JavaCard 3.2 API, match](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#match(byte%5B%5D,short,short))

  Scenario: BioMatcher.getMaxNbOfBioTemplateData returns the capacity
    Given a BioMatcher instance
    When getMaxNbOfBioTemplateData() is called
    Then the maximum number of BioTemplateData entries the matcher can hold is returned
    # Source: [JavaCard 3.2 API, getMaxNbOfBioTemplateData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#getMaxNbOfBioTemplateData)

  Scenario: BioMatcher.getIndexOfLastMatchingBioTemplateData returns the matched index
    Given a BioMatcher after a successful match
    When getIndexOfLastMatchingBioTemplateData() is called
    Then the index of the best-matching BioTemplateData is returned
    # Source: [JavaCard 3.2 API, getIndexOfLastMatchingBioTemplateData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#getIndexOfLastMatchingBioTemplateData)

  Scenario: BioMatcher.getBioTemplateData retrieves a template by index
    Given a BioMatcher with enrolled templates
    When getBioTemplateData(short index) is called
    Then the BioTemplateData at the specified index is returned
    # Source: [JavaCard 3.2 API, getBioTemplateData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html#getBioTemplateData(short))

  Scenario: BioMatcher defines match score constants
    Then BioMatcher defines static short constant "MINIMUM_SUCCESSFUL_MATCH_SCORE"
    And BioMatcher defines static short constant "MATCH_NEEDS_MORE_DATA"
    # Source: [JavaCard 3.2 API, BioMatcher](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioMatcher.html)

  # ========== OwnerBioMatcher Interface ==========

  Scenario: OwnerBioMatcher.putBioTemplateData enrolls a template
    Given an OwnerBioMatcher instance
    When putBioTemplateData(short index, BioTemplateData bioTemplateData) is called
    Then the BioTemplateData is stored at the specified index in the matcher
    # Source: [JavaCard 3.2 API, putBioTemplateData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/OwnerBioMatcher.html#putBioTemplateData(short,BioTemplateData))

  Scenario: OwnerBioMatcher.resetUnblockAndSetTryLimit resets the matcher
    Given a blocked OwnerBioMatcher
    When resetUnblockAndSetTryLimit(byte tryLimit) is called
    Then the matcher is unblocked and tries remaining is reset to tryLimit
    # Source: [JavaCard 3.2 API, resetUnblockAndSetTryLimit](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/OwnerBioMatcher.html#resetUnblockAndSetTryLimit(byte))

  # ========== BioTemplateData Interface ==========

  Scenario: BioTemplateData.getBioType returns the biometric type
    Given a BioTemplateData instance
    When getBioType() is called
    Then the biometric type constant is returned
    # Source: [JavaCard 3.2 API, getBioType](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioTemplateData.html#getBioType)

  Scenario: BioTemplateData.isInitialized checks enrollment state
    Given a BioTemplateData instance
    When isInitialized() is called
    Then returns true if template data has been fully enrolled via doFinal
    # Source: [JavaCard 3.2 API, isInitialized](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioTemplateData.html#isInitialized)

  Scenario: BioTemplateData.getPublicData retrieves public template data
    Given an initialized BioTemplateData
    When getPublicData(short publicOffset, byte[] dest, short destOffset, short length) is called
    Then public template data is copied to dest
    # Source: [JavaCard 3.2 API, getPublicData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/BioTemplateData.html#getPublicData(short,byte%5B%5D,short,short))

  # ========== OwnerBioTemplateData Interface ==========

  Scenario: OwnerBioTemplateData enrollment lifecycle
    Given an OwnerBioTemplateData instance
    When init(byte[] bArray, short offset, short length) is called to begin enrollment
    And update(byte[] bArray, short offset, short length) is called to continue
    And doFinal(byte[] bArray, short offset, short length) is called to finalize
    Then the template data is fully enrolled and isInitialized returns true
    # Source: [JavaCard 3.2 API, OwnerBioTemplateData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/OwnerBioTemplateData.html)

  Scenario: OwnerBioTemplateData.clear erases template data
    Given an enrolled OwnerBioTemplateData
    When clear() is called
    Then all template data is erased and isInitialized returns false
    # Source: [JavaCard 3.2 API, clear](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/OwnerBioTemplateData.html#clear)

  # ========== SharedBioMatcher and SharedBioTemplateData ==========

  Scenario: SharedBioMatcher extends BioMatcher and Shareable
    Then SharedBioMatcher extends both BioMatcher and javacard.framework.Shareable
    # Source: [JavaCard 3.2 API, SharedBioMatcher](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/SharedBioMatcher.html)

  Scenario: SharedBioTemplateData extends BioTemplateData and Shareable
    Then SharedBioTemplateData extends both BioTemplateData and javacard.framework.Shareable
    # Source: [JavaCard 3.2 API, SharedBioTemplateData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/SharedBioTemplateData.html)

  # ========== Bio1toNException ==========

  Scenario Outline: Bio1toNException defines reason codes
    Then class Bio1toNException defines static short constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/Bio1toNException.html)
    Examples:
      | constant                             |
      | ILLEGAL_VALUE                        |
      | INVALID_DATA                         |
      | UNSUPPORTED_BIO_TYPE                 |
      | NO_BIO_TEMPLATE_ENROLLED             |
      | ILLEGAL_USE                          |
      | BIO_TEMPLATE_DATA_CAPACITY_EXCEEDED  |
      | MISMATCHED_BIO_TYPE                  |

  Scenario: Bio1toNException.throwIt throws a Bio1toNException
    When Bio1toNException.throwIt(short reason) is called
    Then a Bio1toNException is thrown with the specified reason code
    # Source: [JavaCard 3.2 API, throwIt](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/biometry1toN/Bio1toNException.html#throwIt(short))
