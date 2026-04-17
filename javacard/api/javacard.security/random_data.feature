@v3.0.5 @v3.1 @v3.2
Feature: RandomData -- Random number generation
  The RandomData abstract class provides a source of random or pseudo-random data.
  Includes the RandomData.OneShot inner class for transient one-shot usage.


  Background:
    Given the abstract class javacard.security.RandomData is available

  # ---------------------------------------------------------------------------
  # Algorithm constants
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, RandomData](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html)
  # Source: [JavaCard 3.1 API, RandomData](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html)
  # Source: [JavaCard 3.2 API, RandomData](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html)
  Scenario Outline: RandomData algorithm constants have specified values
    # Source: [JavaCard 3.0.5 API, <constant>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html)
    # Source: [JavaCard 3.1 API, <constant>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html)
    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: RandomData algorithms
      | constant          | value | description                                          |
      | ALG_PSEUDO_RANDOM | 1     | Pseudo-random number generation (deprecated)         |
      | ALG_SECURE_RANDOM | 2     | Cryptographically secure random number generation    |

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: RandomData algorithm constants added since version 3.0
    # Source: [JavaCard 3.0.5 API, <constant>](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html)
    # Source: [JavaCard 3.1 API, <constant>](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html)
    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    @v3.0.5 @v3.1 @v3.2
    Examples: Algorithms since 3.0
      | constant            | value | description                                                    |
      | ALG_TRNG            | 3     | True random number generator (may block)                       |
      | ALG_PRESEEDED_DRBG  | 4     | Deterministic random bit generator, pre-seeded                 |
      | ALG_FAST            | 5     | Fast random, not necessarily cryptographically secure           |
      | ALG_KEYGENERATION   | 6     | Random suitable for key generation                             |

  # ---------------------------------------------------------------------------
  # Factory methods
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.getInstance with externalAccess creates a RandomData object
    # Source: [JavaCard 3.0.5 API, getInstance](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#getInstance(byte,boolean)
    Given a supported random data algorithm constant
    When RandomData.getInstance(algorithm, externalAccess) is called
    Then a RandomData instance implementing the requested algorithm is returned

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.getInstance throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, getInstance](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#getInstance(byte,boolean)
    Given an unsupported random data algorithm constant
    When RandomData.getInstance(algorithm, externalAccess) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.0.5 @v3.1 @v3.2
  Scenario: Deprecated RandomData.getInstance(byte) creates a RandomData object
    # Source: [JavaCard 3.0.5 API, getInstance](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#getInstance(byte)
    # Source: [JavaCard 3.1 API, getInstance](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#getInstance(byte)
    # Source: [JavaCard 3.2 API, getInstance](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#getInstance(byte)
    Given a supported random data algorithm constant
    When the deprecated RandomData.getInstance(algorithm) is called
    Then a RandomData instance is returned

  # ---------------------------------------------------------------------------
  # Instance methods
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.nextBytes fills buffer with random data
    # Source: [JavaCard 3.0.5 API, nextBytes](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#nextBytes(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, nextBytes](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#nextBytes(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, nextBytes](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#nextBytes(byte%5B%5D,short,short)
    Given a RandomData instance
    When nextBytes(buffer, offset, length) is called
    Then the buffer region is filled with random data
    And the number of bytes generated is returned

  @v3.0.5 @v3.1 @v3.2
  Scenario: Deprecated RandomData.generateData fills buffer with random data
    # Source: [JavaCard 3.0.5 API, generateData](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#generateData(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, generateData](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#generateData(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, generateData](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#generateData(byte%5B%5D,short,short)
    Given a RandomData instance
    When the deprecated generateData(buffer, offset, length) is called
    Then the buffer region is filled with random data

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.setSeed supplements the random data seed
    # Source: [JavaCard 3.0.5 API, setSeed](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#setSeed(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, setSeed](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#setSeed(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, setSeed](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#setSeed(byte%5B%5D,short,short)
    Given a RandomData instance
    When setSeed(buffer, offset, length) is called with seed data
    Then the seed data supplements the internal seeding

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.getAlgorithm returns the algorithm identifier
    # Source: [JavaCard 3.0.5 API, getAlgorithm](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#getAlgorithm)
    # Source: [JavaCard 3.1 API, getAlgorithm](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#getAlgorithm)
    # Source: [JavaCard 3.2 API, getAlgorithm](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#getAlgorithm)
    Given a RandomData instance
    When getAlgorithm() is called
    Then it returns the algorithm constant used to create this instance

  # ---------------------------------------------------------------------------
  # RandomData.OneShot -- transient one-shot random generation
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.OneShot.open creates a transient one-shot instance
    # Source: [JavaCard 3.0.5 API, open](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#open(byte)
    # Source: [JavaCard 3.1 API, open](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#open(byte)
    # Source: [JavaCard 3.2 API, open](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#open(byte)
    Given a supported random data algorithm constant
    When RandomData.OneShot.open(algorithm) is called
    Then a transient RandomData.OneShot instance is returned
    And internal storage is allocated in CLEAR_ON_RESET transient memory

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.OneShot.open throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, open](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#open(byte)
    # Source: [JavaCard 3.1 API, open](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#open(byte)
    # Source: [JavaCard 3.2 API, open](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#open(byte)
    Given an unsupported random data algorithm constant
    When RandomData.OneShot.open(algorithm) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.OneShot.close releases the instance
    # Source: [JavaCard 3.0.5 API, close](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html#close)
    # Source: [JavaCard 3.1 API, close](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html#close)
    # Source: [JavaCard 3.2 API, close](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html#close)
    Given a RandomData.OneShot instance
    When close() is called
    Then the instance is released for reuse
    And subsequent method calls on this instance throw CryptoException with ILLEGAL_USE

  @v3.0.5 @v3.1 @v3.2
  Scenario: RandomData.OneShot provides nextBytes, setSeed, getAlgorithm
    # Source: [JavaCard 3.0.5 API, OneShot](../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/RandomData.html)
    # Source: [JavaCard 3.1 API, OneShot](../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/RandomData.html)
    # Source: [JavaCard 3.2 API, OneShot](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/RandomData.html)
    Given a RandomData.OneShot instance
    Then the following methods are available:
      | method                                          |
      | nextBytes(byte[] buffer, short offset, short length) |
      | setSeed(byte[] buffer, short offset, short length)   |
      | getAlgorithm()                                       |
