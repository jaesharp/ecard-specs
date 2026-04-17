@v3.0.5 @v3.1 @v3.2
Feature: Util - Common Utility Functions
  The Util class contains common utility functions. All methods are
  static. Some methods may be implemented as native functions for
  performance. Methods arrayCopy, arrayCopyNonAtomic, arrayFill,
  arrayFillNonAtomic, and setShort handle persistence of array objects
  with atomic transaction semantics where applicable.

  # -------------------------------------------------------------------
  # Method: arrayCopy(byte[], short, byte[], short, short)
  # -------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  Scenario: arrayCopy copies bytes and returns destOff+length
    Given a source byte array src containing {0x01, 0x02, 0x03, 0x04}
    And a destination byte array dest of length 10
    When Util.arrayCopy(src, 0, dest, 2, 4) is called
    Then the return value is 6
    And dest[2..5] contains {0x01, 0x02, 0x03, 0x04}

  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopy handles overlapping src and dest correctly
    Given src and dest refer to the same array
    When Util.arrayCopy(array, 0, array, 2, 4) is called
    Then the copy is performed as if via a temporary array
    And no data corruption occurs

  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopy to persistent dest is performed atomically
    Given dest is a persistent byte array
    And a transaction may or may not be in progress
    When Util.arrayCopy(src, 0, dest, 0, length) is called
    Then the entire copy is performed atomically

  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopy throws TransactionException if commit capacity exceeded
    Given a persistent destination array
    And the copy length exceeds remaining commit capacity
    When Util.arrayCopy is called
    Then a TransactionException is thrown
    And no copy is performed

  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopy with null src throws NullPointerException
    When Util.arrayCopy(null, 0, dest, 0, 4) is called
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopy with null dest throws NullPointerException
    When Util.arrayCopy(src, 0, null, 0, 4) is called
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopy with negative srcOff throws ArrayIndexOutOfBoundsException
    When Util.arrayCopy(src, -1, dest, 0, 4) is called
    Then an ArrayIndexOutOfBoundsException is thrown

  # Source: [JavaCard 3.0.5 API, arrayCopy](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopy](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopy](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopy(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopy with srcOff+length exceeding src length throws ArrayIndexOutOfBoundsException
    Given src is a byte array of length 4
    When Util.arrayCopy(src, 2, dest, 0, 4) is called
    Then an ArrayIndexOutOfBoundsException is thrown
    And no copy is performed

  # -------------------------------------------------------------------
  # Method: arrayCopyNonAtomic(byte[], short, byte[], short, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, arrayCopyNonAtomic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopyNonAtomic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopyNonAtomic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopyNonAtomic copies bytes without transaction participation
    Given a source array and a persistent destination array
    And a transaction is in progress
    When Util.arrayCopyNonAtomic(src, 0, dest, 0, 4) is called
    Then the copy is performed outside the transaction
    And power loss during copy may leave dest partially modified

  # Source: [JavaCard 3.0.5 API, arrayCopyNonAtomic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopyNonAtomic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopyNonAtomic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopyNonAtomic returns destOff+length
    When Util.arrayCopyNonAtomic(src, 0, dest, 3, 5) is called
    Then the return value is 8

  # Source: [JavaCard 3.0.5 API, arrayCopyNonAtomic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopyNonAtomic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopyNonAtomic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopyNonAtomic is not constrained by commit capacity
    Given a copy length exceeding the commit capacity
    When Util.arrayCopyNonAtomic is called
    Then the copy proceeds without TransactionException

  # Source: [JavaCard 3.0.5 API, arrayCopyNonAtomic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCopyNonAtomic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCopyNonAtomic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCopyNonAtomic(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCopyNonAtomic throws SystemException for integrity-sensitive dest
    Given dest is a persistent integrity-sensitive array
    When Util.arrayCopyNonAtomic is called with that dest
    Then a SystemException is thrown with reason ILLEGAL_VALUE

  # -------------------------------------------------------------------
  # Method: arrayFill(byte[], short, short, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, arrayFill](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFill](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFill](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFill fills a byte array range with a value
    Given a byte array of length 10
    When Util.arrayFill(bArray, 2, 5, 0xFF) is called
    Then the return value is 7
    And bArray[2..6] all contain 0xFF

  # Source: [JavaCard 3.0.5 API, arrayFill](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFill](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFill](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFill on persistent array is performed atomically
    Given bArray is a persistent byte array
    When Util.arrayFill(bArray, 0, 10, 0x00) is called
    Then the fill is performed atomically

  # Source: [JavaCard 3.0.5 API, arrayFill](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFill](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFill](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFill throws TransactionException if commit capacity exceeded
    Given a persistent byte array
    And the fill length exceeds remaining commit capacity
    When Util.arrayFill is called
    Then a TransactionException is thrown

  # Source: [JavaCard 3.0.5 API, arrayFill](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFill](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFill](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFill with null array throws NullPointerException
    When Util.arrayFill(null, 0, 5, 0x00) is called
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, arrayFill](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFill](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFill](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFill(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFill with negative offset throws ArrayIndexOutOfBoundsException
    When Util.arrayFill(bArray, -1, 5, 0x00) is called
    Then an ArrayIndexOutOfBoundsException is thrown

  # -------------------------------------------------------------------
  # Method: arrayFillNonAtomic(byte[], short, short, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, arrayFillNonAtomic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFillNonAtomic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFillNonAtomic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFillNonAtomic fills without transaction participation
    Given a persistent byte array
    And a transaction is in progress
    When Util.arrayFillNonAtomic(bArray, 0, 10, 0x42) is called
    Then the fill is performed outside the transaction
    And power loss may leave the array partially filled

  # Source: [JavaCard 3.0.5 API, arrayFillNonAtomic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFillNonAtomic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFillNonAtomic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFillNonAtomic returns bOff+bLen
    When Util.arrayFillNonAtomic(bArray, 2, 5, 0x00) is called
    Then the return value is 7

  # Source: [JavaCard 3.0.5 API, arrayFillNonAtomic](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.1 API, arrayFillNonAtomic](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  # Source: [JavaCard 3.2 API, arrayFillNonAtomic](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayFillNonAtomic(byte%5B%5D,short,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayFillNonAtomic throws SystemException for integrity-sensitive array
    Given bArray is a persistent integrity-sensitive array
    When Util.arrayFillNonAtomic is called with that array
    Then a SystemException is thrown with reason ILLEGAL_VALUE

  # -------------------------------------------------------------------
  # Method: arrayCompare(byte[], short, byte[], short, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, arrayCompare](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCompare](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCompare](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCompare returns 0 for identical arrays
    Given src containing {0x01, 0x02, 0x03}
    And dest containing {0x01, 0x02, 0x03}
    When Util.arrayCompare(src, 0, dest, 0, 3) is called
    Then the return value is 0

  # Source: [JavaCard 3.0.5 API, arrayCompare](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCompare](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCompare](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCompare returns -1 when src byte is less than dest byte
    Given src containing {0x01, 0x02, 0x03}
    And dest containing {0x01, 0x02, 0x04}
    When Util.arrayCompare(src, 0, dest, 0, 3) is called
    Then the return value is -1

  # Source: [JavaCard 3.0.5 API, arrayCompare](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCompare](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCompare](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCompare returns 1 when src byte is greater than dest byte
    Given src containing {0x01, 0x02, 0x05}
    And dest containing {0x01, 0x02, 0x04}
    When Util.arrayCompare(src, 0, dest, 0, 3) is called
    Then the return value is 1

  # Source: [JavaCard 3.0.5 API, arrayCompare](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCompare](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCompare](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCompare compares from left to right
    Given src containing {0xFF, 0x01}
    And dest containing {0x00, 0xFF}
    When Util.arrayCompare(src, 0, dest, 0, 2) is called
    Then the return value is 1 based on the first differing byte

  # Source: [JavaCard 3.0.5 API, arrayCompare](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCompare](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCompare](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCompare with null src throws NullPointerException
    When Util.arrayCompare(null, 0, dest, 0, 3) is called
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, arrayCompare](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, arrayCompare](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, arrayCompare](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#arrayCompare(byte%5B%5D,short,byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: arrayCompare with out-of-bounds offset throws ArrayIndexOutOfBoundsException
    Given src of length 3
    When Util.arrayCompare(src, 2, dest, 0, 3) is called
    Then an ArrayIndexOutOfBoundsException is thrown

  # -------------------------------------------------------------------
  # Method: makeShort(byte, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, makeShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#makeShort(byte,byte)
  # Source: [JavaCard 3.1 API, makeShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#makeShort(byte,byte)
  # Source: [JavaCard 3.2 API, makeShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#makeShort(byte,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: makeShort concatenates two bytes into a short
    When Util.makeShort(0x01, 0x02) is called
    Then the return value is 0x0102

  # Source: [JavaCard 3.0.5 API, makeShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#makeShort(byte,byte)
  # Source: [JavaCard 3.1 API, makeShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#makeShort(byte,byte)
  # Source: [JavaCard 3.2 API, makeShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#makeShort(byte,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: makeShort with high-order byte first
    When Util.makeShort(0xFF, 0x00) is called
    Then the return value is (short)0xFF00

  # -------------------------------------------------------------------
  # Method: getShort(byte[], short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getShort reads two consecutive bytes as a short
    Given a byte array containing {0x00, 0x01, 0x02, 0x03}
    When Util.getShort(bArray, 1) is called
    Then the return value is 0x0102

  # Source: [JavaCard 3.0.5 API, getShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getShort with null array throws NullPointerException
    When Util.getShort(null, 0) is called
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, getShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#getShort(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getShort with bOff+2 exceeding array length throws ArrayIndexOutOfBoundsException
    Given a byte array of length 3
    When Util.getShort(bArray, 2) is called
    Then an ArrayIndexOutOfBoundsException is thrown

  # -------------------------------------------------------------------
  # Method: setShort(byte[], short, short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, setShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, setShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, setShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setShort deposits a short value as two bytes
    Given a byte array of length 10
    When Util.setShort(bArray, 3, 0x1234) is called
    Then the return value is 5
    And bArray[3] is 0x12 (high byte)
    And bArray[4] is 0x34 (low byte)

  # Source: [JavaCard 3.0.5 API, setShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, setShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, setShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setShort on persistent array is performed atomically
    Given bArray is a persistent byte array
    When Util.setShort(bArray, 0, 0xABCD) is called
    Then the write is performed atomically

  # Source: [JavaCard 3.0.5 API, setShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, setShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, setShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setShort throws TransactionException if commit capacity exceeded
    Given a persistent byte array
    And the commit capacity is exceeded
    When Util.setShort is called
    Then a TransactionException is thrown

  # Source: [JavaCard 3.0.5 API, setShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, setShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, setShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setShort with null array throws NullPointerException
    When Util.setShort(null, 0, 0x1234) is called
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, setShort](../../../../java_card_kit-classic-3_0_5-ga-spec-doc-b33-03_jun_2015/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.1 API, setShort](../../../../java_card_spec-3_1_0-u5-b_70-09_mar_2021/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  # Source: [JavaCard 3.2 API, setShort](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacard/framework/Util.html#setShort(byte%5B%5D,short,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: setShort with bOff+2 exceeding array length throws ArrayIndexOutOfBoundsException
    Given a byte array of length 3
    When Util.setShort(bArray, 2, 0x1234) is called
    Then an ArrayIndexOutOfBoundsException is thrown
