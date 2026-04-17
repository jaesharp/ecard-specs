@v3.0.5 @v3.1 @v3.2
Feature: MessageDigest -- Cryptographic hash computation
  The MessageDigest class is the base class for hashing algorithms.
  Includes InitializedMessageDigest for setting initial digest state,
  and OneShot variants for transient single-use instances.


  Background:
    Given the abstract class javacard.security.MessageDigest is available

  # ---------------------------------------------------------------------------
  # Algorithm constants
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, MessageDigest](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html)
  # Source: [JavaCard 3.1 API, MessageDigest](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html)
  # Source: [JavaCard 3.2 API, MessageDigest](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html)
  Scenario Outline: MessageDigest algorithm constants have specified values
    # Source: [JavaCard 3.0.5 API, <constant>](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html)
    Then the static field "<constant>" of type byte has value <value>
    And it designates "<description>"

    Examples: Hash algorithms (present since 3.0.5)
      | constant        | value | description                              |
      | ALG_NULL        | 0     | Null digest, no hashing                  |
      | ALG_SHA         | 1     | SHA-1 message digest algorithm           |
      | ALG_MD5         | 2     | MD5 message digest algorithm             |
      | ALG_RIPEMD160   | 3     | RIPE MD-160 message digest algorithm     |
      | ALG_SHA_256     | 4     | SHA-256 message digest algorithm         |
      | ALG_SHA_384     | 5     | SHA-384 message digest algorithm         |
      | ALG_SHA_512     | 6     | SHA-512 message digest algorithm         |
      | ALG_SHA_224     | 7     | SHA-224 message digest algorithm         |
      | ALG_SHA3_224    | 8     | SHA3-224 message digest algorithm        |
      | ALG_SHA3_256    | 9     | SHA3-256 message digest algorithm        |
      | ALG_SHA3_384    | 10    | SHA3-384 message digest algorithm        |
      | ALG_SHA3_512    | 11    | SHA3-512 message digest algorithm        |

  @v3.1 @v3.2
  Scenario: MessageDigest ALG_SM3 constant added in version 3.1
    # Source: [JavaCard 3.1 API, ALG_SM3](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.2 API, ALG_SM3](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html)
    Then the static field "ALG_SM3" of type byte has value 12
    And it designates "SM3 message digest algorithm"

  # ---------------------------------------------------------------------------
  # Digest length constants
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario Outline: MessageDigest length constants specify output size in bytes
    # Source: [JavaCard 3.0.5 API, <constant>](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.1 API, <constant>](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.2 API, <constant>](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html)
    Then the static field "<constant>" of type byte has value <value>
    And it specifies the digest output length in bytes

    Examples: Digest output lengths (present since 3.0.5)
      | constant            | value |
      | LENGTH_MD5          | 16    |
      | LENGTH_RIPEMD160    | 20    |
      | LENGTH_SHA          | 20    |
      | LENGTH_SHA_224      | 28    |
      | LENGTH_SHA_256      | 32    |
      | LENGTH_SHA_384      | 48    |
      | LENGTH_SHA_512      | 64    |
      | LENGTH_SHA3_224     | 28    |
      | LENGTH_SHA3_256     | 32    |
      | LENGTH_SHA3_384     | 48    |
      | LENGTH_SHA3_512     | 64    |

  @v3.1 @v3.2
  Scenario: MessageDigest LENGTH_SM3 constant added in version 3.1
    # Source: [JavaCard 3.1 API, LENGTH_SM3](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.2 API, LENGTH_SM3](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html)
    Then the static field "LENGTH_SM3" of type byte has value 32
    And it specifies the SM3 digest output length in bytes

  # ---------------------------------------------------------------------------
  # Factory methods
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.getInstance creates a MessageDigest object
    # Source: [JavaCard 3.0.5 API, getInstance](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#getInstance(byte,boolean)
    Given a supported message digest algorithm constant
    When MessageDigest.getInstance(algorithm, externalAccess) is called
    Then a MessageDigest instance implementing the requested algorithm is returned

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.getInstance throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, getInstance](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInstance](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#getInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInstance](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#getInstance(byte,boolean)
    Given an unsupported message digest algorithm constant
    When MessageDigest.getInstance(algorithm, externalAccess) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.getInitializedMessageDigestInstance creates an InitializedMessageDigest
    # Source: [JavaCard 3.0.5 API, getInitializedMessageDigestInstance](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#getInitializedMessageDigestInstance(byte,boolean)
    # Source: [JavaCard 3.1 API, getInitializedMessageDigestInstance](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#getInitializedMessageDigestInstance(byte,boolean)
    # Source: [JavaCard 3.2 API, getInitializedMessageDigestInstance](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#getInitializedMessageDigestInstance(byte,boolean)
    Given a supported message digest algorithm constant
    When MessageDigest.getInitializedMessageDigestInstance(algorithm, externalAccess) is called
    Then an InitializedMessageDigest instance is returned

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.isIntermediateMessageDigestSupported checks algorithm support
    # Source: [JavaCard 3.0.5 API, isIntermediateMessageDigestSupported](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#isIntermediateMessageDigestSupported(byte)
    # Source: [JavaCard 3.1 API, isIntermediateMessageDigestSupported](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#isIntermediateMessageDigestSupported(byte)
    # Source: [JavaCard 3.2 API, isIntermediateMessageDigestSupported](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#isIntermediateMessageDigestSupported(byte)
    Given a message digest algorithm constant
    When MessageDigest.isIntermediateMessageDigestSupported(algorithm) is called
    Then it returns true if intermediate digest output is supported for the algorithm, false otherwise

  # ---------------------------------------------------------------------------
  # Instance methods
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.getAlgorithm returns the algorithm identifier
    # Source: [JavaCard 3.0.5 API, getAlgorithm](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#getAlgorithm)
    # Source: [JavaCard 3.1 API, getAlgorithm](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#getAlgorithm)
    # Source: [JavaCard 3.2 API, getAlgorithm](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#getAlgorithm)
    Given a MessageDigest instance
    When getAlgorithm() is called
    Then it returns the algorithm constant used to create this instance

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.getLength returns the digest output length
    # Source: [JavaCard 3.0.5 API, getLength](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#getLength)
    # Source: [JavaCard 3.1 API, getLength](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#getLength)
    # Source: [JavaCard 3.2 API, getLength](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#getLength)
    Given a MessageDigest instance
    When getLength() is called
    Then it returns the byte length of the message digest output

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.update accumulates data for hashing
    # Source: [JavaCard 3.0.5 API, update](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#update(byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, update](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#update(byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, update](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#update(byte%5B%5D,short,short)
    Given a MessageDigest instance
    When update(inBuff, inOffset, inLength) is called
    Then the input data is accumulated for the hash computation

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.doFinal completes the hash computation
    # Source: [JavaCard 3.0.5 API, doFinal](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, doFinal](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, doFinal](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#doFinal(byte%5B%5D,short,short,byte%5B%5D,short)
    Given a MessageDigest instance with accumulated data
    When doFinal(inBuff, inOffset, inLength, outBuff, outOffset) is called
    Then the hash is computed over all accumulated data plus inBuff
    And the digest is written to outBuff at outOffset
    And the number of bytes written is returned
    And the MessageDigest object is reset for a new computation

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.doIntermediateMessageDigest outputs intermediate hash state
    # Source: [JavaCard 3.0.5 API, doIntermediateMessageDigest](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#doIntermediateMessageDigest(byte%5B%5D,short)
    # Source: [JavaCard 3.1 API, doIntermediateMessageDigest](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#doIntermediateMessageDigest(byte%5B%5D,short)
    # Source: [JavaCard 3.2 API, doIntermediateMessageDigest](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#doIntermediateMessageDigest(byte%5B%5D,short)
    Given a MessageDigest instance with accumulated data
    When doIntermediateMessageDigest(outBuff, outOffset) is called
    Then the intermediate digest value is written to outBuff
    And the ongoing hash computation is not disrupted
    And CryptoException with ILLEGAL_USE is thrown if intermediate digests are not supported

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.reset resets the digest computation
    # Source: [JavaCard 3.0.5 API, reset](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#reset)
    # Source: [JavaCard 3.1 API, reset](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#reset)
    # Source: [JavaCard 3.2 API, reset](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#reset)
    Given a MessageDigest instance with accumulated data
    When reset() is called
    Then the message digest object is reset to its initial state

  # ---------------------------------------------------------------------------
  # InitializedMessageDigest -- digest with settable initial state
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: InitializedMessageDigest extends MessageDigest
    # Source: [JavaCard 3.0.5 API, InitializedMessageDigest](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/InitializedMessageDigest.html)
    # Source: [JavaCard 3.1 API, InitializedMessageDigest](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/InitializedMessageDigest.html)
    # Source: [JavaCard 3.2 API, InitializedMessageDigest](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/InitializedMessageDigest.html)
    Given the abstract class javacard.security.InitializedMessageDigest
    Then it extends javacard.security.MessageDigest

  @v3.0.5 @v3.1 @v3.2
  Scenario: InitializedMessageDigest.setInitialDigest sets initial hash state
    # Source: [JavaCard 3.0.5 API, setInitialDigest](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/InitializedMessageDigest.html#setInitialDigest(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.1 API, setInitialDigest](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/InitializedMessageDigest.html#setInitialDigest(byte%5B%5D,short,short,byte%5B%5D,short,short)
    # Source: [JavaCard 3.2 API, setInitialDigest](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/InitializedMessageDigest.html#setInitialDigest(byte%5B%5D,short,short,byte%5B%5D,short,short)
    Given an InitializedMessageDigest instance
    When setInitialDigest(state, stateOffset, stateLength, digestedMsgLenBuf, digestedMsgLenOffset, digestedMsgLenLength) is called
    Then the intermediate state of the digest is set from the provided data
    And digestedMsgLenBuf contains the number of bytes already digested
    And CryptoException with ILLEGAL_VALUE is thrown if the input state length is invalid

  # ---------------------------------------------------------------------------
  # MessageDigest.OneShot -- transient one-shot digest
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.OneShot.open creates a transient one-shot instance
    # Source: [JavaCard 3.0.5 API, open](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#open(byte)
    # Source: [JavaCard 3.1 API, open](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#open(byte)
    # Source: [JavaCard 3.2 API, open](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#open(byte)
    Given a supported message digest algorithm constant
    When MessageDigest.OneShot.open(algorithm) is called
    Then a transient MessageDigest.OneShot instance is returned
    And internal storage is allocated in CLEAR_ON_RESET transient memory

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.OneShot.open throws CryptoException for unsupported algorithm
    # Source: [JavaCard 3.0.5 API, open](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#open(byte)
    # Source: [JavaCard 3.1 API, open](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#open(byte)
    # Source: [JavaCard 3.2 API, open](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#open(byte)
    Given an unsupported message digest algorithm constant
    When MessageDigest.OneShot.open(algorithm) is called
    Then CryptoException is thrown with reason NO_SUCH_ALGORITHM

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.OneShot.close releases the instance
    # Source: [JavaCard 3.0.5 API, close](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html#close)
    # Source: [JavaCard 3.1 API, close](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html#close)
    # Source: [JavaCard 3.2 API, close](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html#close)
    Given a MessageDigest.OneShot instance
    When close() is called
    Then the instance is released for reuse
    And subsequent method calls on this instance throw CryptoException with ILLEGAL_USE

  @v3.0.5 @v3.1 @v3.2
  Scenario: MessageDigest.OneShot provides standard digest operations
    # Source: [JavaCard 3.0.5 API, OneShot](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.1 API, OneShot](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/MessageDigest.html)
    # Source: [JavaCard 3.2 API, OneShot](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/MessageDigest.html)
    Given a MessageDigest.OneShot instance
    Then the following methods are available:
      | method                                                                       |
      | getAlgorithm()                                                               |
      | getLength()                                                                  |
      | update(byte[] inBuff, short inOffset, short inLength)                        |
      | doFinal(byte[] inBuff, short inOffset, short inLength, byte[] outBuff, short outOffset) |
      | doIntermediateMessageDigest(byte[] outBuff, short outOffset)                 |
      | reset()                                                                      |

  # ---------------------------------------------------------------------------
  # InitializedMessageDigest.OneShot -- transient one-shot initialized digest
  # ---------------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  Scenario: InitializedMessageDigest.OneShot.open creates a transient initialized digest
    # Source: [JavaCard 3.0.5 API, open](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/InitializedMessageDigest.html#open(byte)
    # Source: [JavaCard 3.1 API, open](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/InitializedMessageDigest.html#open(byte)
    # Source: [JavaCard 3.2 API, open](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/InitializedMessageDigest.html#open(byte)
    Given a supported message digest algorithm constant
    When InitializedMessageDigest.OneShot.open(algorithm) is called
    Then a transient InitializedMessageDigest.OneShot instance is returned

  @v3.0.5 @v3.1 @v3.2
  Scenario: InitializedMessageDigest.OneShot.close releases the instance
    # Source: [JavaCard 3.0.5 API, close](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/InitializedMessageDigest.html#close)
    # Source: [JavaCard 3.1 API, close](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/InitializedMessageDigest.html#close)
    # Source: [JavaCard 3.2 API, close](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/InitializedMessageDigest.html#close)
    Given an InitializedMessageDigest.OneShot instance
    When close() is called
    Then the instance is released for reuse

  @v3.0.5 @v3.1 @v3.2
  Scenario: InitializedMessageDigest.OneShot provides setInitialDigest and standard operations
    # Source: [JavaCard 3.0.5 API, OneShot](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/security/InitializedMessageDigest.html)
    # Source: [JavaCard 3.1 API, OneShot](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/security/InitializedMessageDigest.html)
    # Source: [JavaCard 3.2 API, OneShot](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/security/InitializedMessageDigest.html)
    Given an InitializedMessageDigest.OneShot instance
    Then the following methods are available:
      | method                                                                                                   |
      | setInitialDigest(byte[] state, short stateOffset, short stateLength, byte[] digestedMsgLenBuf, short digestedMsgLenOffset, short digestedMsgLenLength) |
      | getAlgorithm()                                                                                           |
      | getLength()                                                                                              |
      | update(byte[] inBuff, short inOffset, short inLength)                                                    |
      | doFinal(byte[] inBuff, short inOffset, short inLength, byte[] outBuff, short outOffset)                  |
      | doIntermediateMessageDigest(byte[] outBuff, short outOffset)                                             |
      | reset()                                                                                                  |
