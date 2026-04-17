@javacardx @javacardx.framework.tlv @v3.0.5 @v3.1 @v3.2
Feature: BER-TLV -- Tag-Length-Value Framework (BERTag, BERTLV, Constructed/Primitive variants, TLVException)
  The javacardx.framework.tlv package provides a framework for constructing and
  parsing BER-TLV (Basic Encoding Rules - Tag Length Value) data structures
  as used in ISO 7816-4 and related standards.

  BERTag is the abstract base for tags: PrimitiveBERTag and ConstructedBERTag.
  BERTLV is the abstract base for TLV structures: PrimitiveBERTLV and ConstructedBERTLV.

  # Source: [JavaCard 3.2 API, tlv package](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv package)

  Background:
    Given a JavaCard runtime environment

  # ========== BERTag Constants ==========

  Scenario: BERTag defines tag class mask constants
    Then class BERTag defines static byte constant "BER_TAG_CLASS_MASK_UNIVERSAL" for universal class
    And class BERTag defines static byte constant "BER_TAG_CLASS_MASK_APPLICATION" for application class
    And class BERTag defines static byte constant "BER_TAG_CLASS_MASK_CONTEXT_SPECIFIC" for context-specific class
    And class BERTag defines static byte constant "BER_TAG_CLASS_MASK_PRIVATE" for private class
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag defines tag type constants
    Then class BERTag defines static byte constant "BER_TAG_TYPE_CONSTRUCTED" for constructed tags
    And class BERTag defines static byte constant "BER_TAG_TYPE_PRIMITIVE" for primitive tags
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  # ========== BERTag Static Methods ==========

  Scenario: BERTag.getInstance creates a BERTag from byte array
    When BERTag.getInstance(byte[] bArray, short bOff) is called
    Then a BERTag instance (Primitive or Constructed) is created from the encoded tag bytes
    # Source: [JavaCard 3.2 API, getInstance](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html#getInstance(byte%5B%5D,short))

  Scenario: BERTag.size returns the number of encoded tag bytes
    Then BERTag.size(byte[] bArray, short bOff) returns the number of bytes of the encoded tag
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.tagNumber returns the tag number
    Then BERTag.tagNumber(byte[] bArray, short bOff) returns the tag number
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.isConstructed checks whether a tag is constructed
    Then BERTag.isConstructed(byte[] bArray, short bOff) returns true if the tag is constructed
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.tagClass returns the tag class mask constant
    Then BERTag.tagClass(byte[] bArray, short bOff) returns the tag class mask constant
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.toBytes encodes a tag into a byte array
    Then BERTag.toBytes(short tagNum, byte tagClass, boolean isConstructed, byte[] outArray, short bOff) encodes a tag
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.verifyFormat validates tag encoding
    Then BERTag.verifyFormat(byte[] bArray, short bOff) validates tag encoding
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  # ========== BERTag Instance Methods ==========

  Scenario: BERTag.init initializes a tag from encoded bytes
    Given a BERTag instance
    Then init(byte[] bArray, short bOff) initializes the tag from encoded bytes
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.size returns the number of encoded tag bytes for an instance
    Given a BERTag instance
    Then size() returns the number of encoded tag bytes
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.tagNumber returns the tag number for an instance
    Given a BERTag instance
    Then tagNumber() returns the tag number
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.isConstructed checks whether an instance tag is constructed
    Given a BERTag instance
    Then isConstructed() returns true if the tag is constructed
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.tagClass returns the tag class for an instance
    Given a BERTag instance
    Then tagClass() returns the tag class
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.toBytes serializes the tag to a byte array
    Given a BERTag instance
    Then toBytes(byte[] dest, short bOff) serializes the tag
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  Scenario: BERTag.equals compares tags for equality
    Given a BERTag instance
    Then equals(BERTag otherTag) compares tags for equality
    # Source: [JavaCard 3.2 API, BERTag](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTag.html)

  # ========== PrimitiveBERTag ==========

  Scenario: PrimitiveBERTag can be initialized from components
    Given a PrimitiveBERTag instance
    When init(short tagNumber, byte tagClass) is called
    Then the tag is initialized as a primitive tag with the given number and class
    # Source: [JavaCard 3.2 API, init](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTag.html#init(short,byte))

  Scenario: PrimitiveBERTag can be initialized from encoded bytes
    Given a PrimitiveBERTag instance
    When init(byte[] bArray, short bOff) is called
    Then the tag is initialized from the encoded BER tag bytes
    And TLVException with MALFORMED_TAG is thrown if the encoded tag is not primitive
    # Source: [JavaCard 3.2 API, init](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTag.html#init(byte%5B%5D,short))

  # ========== ConstructedBERTag ==========

  Scenario: ConstructedBERTag can be initialized from components
    Given a ConstructedBERTag instance
    When init(short tagNumber, byte tagClass) is called
    Then the tag is initialized as a constructed tag with the given number and class
    # Source: [JavaCard 3.2 API, init](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/ConstructedBERTag.html#init(short,byte))

  Scenario: ConstructedBERTag can be initialized from encoded bytes
    Given a ConstructedBERTag instance
    When init(byte[] bArray, short bOff) is called
    Then the tag is initialized from the encoded BER tag bytes
    And TLVException with MALFORMED_TAG is thrown if the encoded tag is not constructed
    # Source: [JavaCard 3.2 API, init](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/ConstructedBERTag.html#init(byte%5B%5D,short))

  # ========== BERTLV ==========

  Scenario: BERTLV.getInstance creates a BERTLV from byte array
    When BERTLV.getInstance(byte[] bArray, short bOff, short bLen) is called
    Then a BERTLV instance (Primitive or Constructed) is parsed from the encoded TLV bytes
    # Source: [JavaCard 3.2 API, getInstance](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTLV.html#getInstance(byte%5B%5D,short,short))

  Scenario: BERTLV static methods operate on encoded TLV data
    Then BERTLV.getTag(byte[] bArray, short bOff) returns the tag portion of the TLV
    And BERTLV.getLength(byte[] bArray, short bOff) returns the length field value
    And BERTLV.verifyFormat(byte[] bArray, short bOff, short bLen) validates TLV encoding
    # Source: [JavaCard 3.2 API, BERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTLV.html)

  Scenario: BERTLV instance provides tag, length, and serialization
    Given a BERTLV instance
    Then init(byte[] bArray, short bOff, short bLen) parses the TLV from bytes
    And getTag() returns the BERTag of this TLV
    And getLength() returns the value length
    And size() returns the total encoded size (tag + length + value)
    And toBytes(byte[] dest, short bOff) serializes the entire TLV
    # Source: [JavaCard 3.2 API, BERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/BERTLV.html)

  # ========== PrimitiveBERTLV ==========

  Scenario: PrimitiveBERTLV.init initializes with tag and value
    Given a PrimitiveBERTLV instance
    Then init(PrimitiveBERTag tag, byte[] vArray, short vOff, short vLen) initializes with tag and value
    # Source: [JavaCard 3.2 API, PrimitiveBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTLV.html)

  Scenario: PrimitiveBERTLV.init parses from encoded bytes
    Given a PrimitiveBERTLV instance
    Then init(byte[] bArray, short bOff, short bLen) parses from encoded bytes
    # Source: [JavaCard 3.2 API, PrimitiveBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTLV.html)

  Scenario: PrimitiveBERTLV.getValue copies the value to a destination array
    Given a PrimitiveBERTLV instance
    Then getValue(byte[] dest, short dOff) copies the value to dest
    # Source: [JavaCard 3.2 API, PrimitiveBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTLV.html)

  Scenario: PrimitiveBERTLV.getValueOffset returns the offset of the value in encoded bytes
    Given a PrimitiveBERTLV instance
    Then getValueOffset(byte[] bArray, short bOff) returns the offset of the value in encoded bytes
    # Source: [JavaCard 3.2 API, PrimitiveBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTLV.html)

  Scenario: PrimitiveBERTLV.appendValue appends to the value
    Given a PrimitiveBERTLV instance
    Then appendValue(PrimitiveBERTag tag, byte[] vArray, short vOff, short vLen) appends to the value
    # Source: [JavaCard 3.2 API, PrimitiveBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTLV.html)

  Scenario: PrimitiveBERTLV.replaceValue replaces the current value
    Given a PrimitiveBERTLV instance
    Then replaceValue(byte[] vArray, short vOff, short vLen) replaces the current value
    # Source: [JavaCard 3.2 API, PrimitiveBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTLV.html)

  Scenario: PrimitiveBERTLV static appendValue creates from tag and value
    When PrimitiveBERTLV.appendValue(byte[] bArray, short bOff, byte[] vArray, short vOff, short vLen) is called
    Then a primitive TLV is written to bArray with the value appended
    # Source: [JavaCard 3.2 API, appendValue](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/PrimitiveBERTLV.html#appendValue(byte%5B%5D,short,byte%5B%5D,short,short))

  # ========== ConstructedBERTLV ==========

  Scenario: ConstructedBERTLV manages constructed TLV with child TLVs
    Given a ConstructedBERTLV instance
    Then init(ConstructedBERTag tag, BERTLV[] childTLVs, short childOff, short childLen) initializes with children
    And init(byte[] bArray, short bOff, short bLen) parses from encoded bytes
    And init(ConstructedBERTag tag, byte[] vArray, short vOff, short vLen) initializes from encoded value
    And append(BERTLV aTLV) appends a child TLV
    And delete(BERTag aTag, short occurrence) removes a child TLV by tag
    And find(BERTag aTag) finds a child TLV by tag
    And findNext(BERTag aTag, BERTLV aTLV, short occurrence) finds subsequent children
    # Source: [JavaCard 3.2 API, ConstructedBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/ConstructedBERTLV.html)

  Scenario: ConstructedBERTLV static methods operate on encoded TLVs
    Then ConstructedBERTLV.append(byte[] bArray, short bOff, byte[] childBuf, short childOff, short childLen) appends child
    And ConstructedBERTLV.find(byte[] bArray, short bOff, BERTag tag) finds child offset
    And ConstructedBERTLV.findNext(byte[] bArray, short bOff, short startOff, BERTag tag) finds next child
    # Source: [JavaCard 3.2 API, ConstructedBERTLV](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/ConstructedBERTLV.html)

  # ========== TLVException ==========

  Scenario Outline: TLVException defines reason codes
    Then class TLVException defines static short constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/TLVException.html)
    Examples:
      | constant                         |
      | INVALID_PARAM                    |
      | ILLEGAL_SIZE                     |
      | EMPTY_TAG                        |
      | EMPTY_TLV                        |
      | MALFORMED_TAG                    |
      | MALFORMED_TLV                    |
      | INSUFFICIENT_STORAGE             |
      | TAG_SIZE_GREATER_THAN_127        |
      | TAG_NUMBER_GREATER_THAN_32767    |
      | TLV_SIZE_GREATER_THAN_32767      |
      | TLV_LENGTH_GREATER_THAN_32767    |

  Scenario: TLVException.throwIt throws a TLVException
    When TLVException.throwIt(short reason) is called
    Then a TLVException is thrown with the specified reason code
    # Source: [JavaCard 3.2 API, throwIt](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/framework/tlv/TLVException.html#throwIt(short))
