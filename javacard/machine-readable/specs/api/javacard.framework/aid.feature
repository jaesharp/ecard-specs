@v3.0.5 @v3.1 @v3.2
Feature: AID - Application Identifier
  The AID class encapsulates a 5-16 byte Application Identifier
  per ISO 7816-5. The Java Card runtime environment creates instances
  of AID to identify and manage every applet on the card.
  AID instances are permanent Java Card runtime environment
  Entry Point Objects accessible from any applet context.

  # -------------------------------------------------------------------
  # Constructor: AID(byte[], short, byte)
  # -------------------------------------------------------------------

  @v3.0.5 @v3.1 @v3.2
  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  Scenario: AID construction with valid minimum length
    Given a byte array containing a 5-byte AID value
    When an AID is constructed with offset 0 and length 5
    Then the AID is successfully created
    And the AID length is 5

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with valid maximum length
    Given a byte array containing a 16-byte AID value
    When an AID is constructed with offset 0 and length 16
    Then the AID is successfully created
    And the AID length is 16

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with typical 7-byte AID
    Given a byte array containing a 7-byte AID value
    When an AID is constructed with offset 0 and length 7
    Then the AID is successfully created
    And the AID length is 7

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with nonzero offset
    Given a byte array of length 20 with AID bytes starting at offset 5
    When an AID is constructed with offset 5 and length 7
    Then the AID is successfully created
    And the AID length is 7

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with length below minimum throws SystemException
    Given a byte array of length 4
    When an AID is constructed with that array, offset 0 and length 4
    Then a SystemException is thrown with reason ILLEGAL_VALUE

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with length above maximum throws SystemException
    Given a byte array of length 17
    When an AID is constructed with that array, offset 0 and length 17
    Then a SystemException is thrown with reason ILLEGAL_VALUE

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with null array throws NullPointerException
    Given a null byte array reference
    When an AID is constructed with that null array
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with negative offset throws ArrayIndexOutOfBoundsException
    Given a byte array of length 10
    When an AID is constructed with offset -1 and length 5
    Then an ArrayIndexOutOfBoundsException is thrown

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with offset+length exceeding array throws ArrayIndexOutOfBoundsException
    Given a byte array of length 6
    When an AID is constructed with offset 3 and length 5
    Then an ArrayIndexOutOfBoundsException is thrown

  # Source: [JavaCard 3.0.5 API, AID](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, AID](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, AID](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: AID construction with inaccessible array throws SecurityException
    Given a byte array not accessible in the caller's context
    When an AID is constructed with that array
    Then a SecurityException is thrown

  # -------------------------------------------------------------------
  # Method: getBytes(byte[], short)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getBytes copies all AID bytes and returns length
    Given an AID constructed from a 7-byte value
    And a destination byte array of length 16
    When getBytes is called with dest and offset 0
    Then the method returns 7
    And the first 7 bytes of dest contain the AID bytes

  # Source: [JavaCard 3.0.5 API, getBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getBytes with nonzero destination offset
    Given an AID constructed from a 7-byte value
    And a destination byte array of length 16
    When getBytes is called with dest and offset 5
    Then the method returns 7
    And bytes 5 through 11 of dest contain the AID bytes

  # Source: [JavaCard 3.0.5 API, getBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getBytes with null dest throws NullPointerException
    Given an AID constructed from a 7-byte value
    When getBytes is called with a null dest array
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, getBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getBytes with insufficient dest space throws ArrayIndexOutOfBoundsException
    Given an AID constructed from a 7-byte value
    And a destination byte array of length 5
    When getBytes is called with dest and offset 0
    Then an ArrayIndexOutOfBoundsException is thrown

  # Source: [JavaCard 3.0.5 API, getBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.1 API, getBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  # Source: [JavaCard 3.2 API, getBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getBytes(byte%5B%5D,short)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getBytes with inaccessible dest throws SecurityException
    Given an AID constructed from a 7-byte value
    And a destination byte array not accessible in the caller's context
    When getBytes is called with that dest array
    Then a SecurityException is thrown

  # -------------------------------------------------------------------
  # Method: equals(Object)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(Object) returns true for AID with same bytes
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And another AID constructed from the same bytes
    When equals(Object) is called with the other AID
    Then the result is true

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(Object) returns false for AID with different bytes
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And another AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x03}
    When equals(Object) is called with the other AID
    Then the result is false

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(Object) returns false for null argument
    Given an AID constructed from a 7-byte value
    When equals(Object) is called with null
    Then the result is false

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(Object) returns false for non-AID object
    Given an AID constructed from a 7-byte value
    When equals(Object) is called with a non-AID Object
    Then the result is false

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(Object) does not throw NullPointerException for null
    Given an AID constructed from a 7-byte value
    When equals(Object) is called with null
    Then no NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(Object)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(Object)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(Object) with inaccessible object throws SecurityException
    Given an AID constructed from a 7-byte value
    And an AID object not accessible in the caller's context
    When equals(Object) is called with that inaccessible AID
    Then a SecurityException is thrown

  # -------------------------------------------------------------------
  # Method: equals(byte[], short, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(byte[], short, byte) returns true for matching bytes
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And a byte array containing the same 7 bytes
    When equals(byte[], short, byte) is called with bArray, offset 0, length 7
    Then the result is true

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(byte[], short, byte) returns false for different bytes
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And a byte array containing different 7 bytes
    When equals(byte[], short, byte) is called with bArray, offset 0, length 7
    Then the result is false

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(byte[], short, byte) returns false for null bArray
    Given an AID constructed from a 7-byte value
    When equals(byte[], short, byte) is called with null bArray
    Then the result is false

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(byte[], short, byte) returns false for different length
    Given an AID constructed from a 7-byte value
    And a byte array containing a 5-byte prefix of the AID
    When equals(byte[], short, byte) is called with bArray, offset 0, length 5
    Then the result is false

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(byte[], short, byte) with negative offset throws ArrayIndexOutOfBoundsException
    Given an AID constructed from a 7-byte value
    And a byte array of length 10
    When equals(byte[], short, byte) is called with offset -1 and length 7
    Then an ArrayIndexOutOfBoundsException is thrown

  # Source: [JavaCard 3.0.5 API, equals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, equals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, equals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#equals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: equals(byte[], short, byte) with inaccessible array throws SecurityException
    Given an AID constructed from a 7-byte value
    And a byte array not accessible in the caller's context
    When equals(byte[], short, byte) is called with that array
    Then a SecurityException is thrown

  # -------------------------------------------------------------------
  # Method: partialEquals(byte[], short, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, partialEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, partialEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, partialEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: partialEquals returns true when prefix matches
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And a byte array containing {0xA0, 0x00, 0x00, 0x00, 0x62}
    When partialEquals is called with bArray, offset 0, length 5
    Then the result is true

  # Source: [JavaCard 3.0.5 API, partialEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, partialEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, partialEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: partialEquals returns false when prefix does not match
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And a byte array containing {0xA0, 0x00, 0x00, 0x00, 0x63}
    When partialEquals is called with bArray, offset 0, length 5
    Then the result is false

  # Source: [JavaCard 3.0.5 API, partialEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, partialEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, partialEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: partialEquals returns false when length exceeds AID length
    Given an AID constructed from a 5-byte value
    And a byte array of length 7
    When partialEquals is called with bArray, offset 0, length 7
    Then the result is false

  # Source: [JavaCard 3.0.5 API, partialEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, partialEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, partialEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: partialEquals returns false for null bArray
    Given an AID constructed from a 7-byte value
    When partialEquals is called with null bArray
    Then the result is false

  # Source: [JavaCard 3.0.5 API, partialEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, partialEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, partialEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#partialEquals(byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: partialEquals with negative offset throws ArrayIndexOutOfBoundsException
    Given an AID constructed from a 7-byte value
    And a byte array of length 10
    When partialEquals is called with offset -1 and length 5
    Then an ArrayIndexOutOfBoundsException is thrown

  # -------------------------------------------------------------------
  # Method: RIDEquals(AID)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, RIDEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.1 API, RIDEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.2 API, RIDEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(AID)
  @v3.0.5 @v3.1 @v3.2
  Scenario: RIDEquals returns true when first 5 bytes match
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And another AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x03, 0x04}
    When RIDEquals is called with the other AID
    Then the result is true

  # Source: [JavaCard 3.0.5 API, RIDEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.1 API, RIDEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.2 API, RIDEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(AID)
  @v3.0.5 @v3.1 @v3.2
  Scenario: RIDEquals returns false when first 5 bytes differ
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And another AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x63, 0x01, 0x02}
    When RIDEquals is called with the other AID
    Then the result is false

  # Source: [JavaCard 3.0.5 API, RIDEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.1 API, RIDEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.2 API, RIDEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(AID)
  @v3.0.5 @v3.1 @v3.2
  Scenario: RIDEquals returns false for null argument
    Given an AID constructed from a 7-byte value
    When RIDEquals is called with null
    Then the result is false

  # Source: [JavaCard 3.0.5 API, RIDEquals](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.1 API, RIDEquals](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#AID(AID)
  # Source: [JavaCard 3.2 API, RIDEquals](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#AID(AID)
  @v3.0.5 @v3.1 @v3.2
  Scenario: RIDEquals with inaccessible AID throws SecurityException
    Given an AID constructed from a 7-byte value
    And an AID object not accessible in the caller's context
    When RIDEquals is called with that inaccessible AID
    Then a SecurityException is thrown

  # -------------------------------------------------------------------
  # Method: getPartialBytes(short, byte[], short, byte)
  # -------------------------------------------------------------------

  # Source: [JavaCard 3.0.5 API, getPartialBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getPartialBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getPartialBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getPartialBytes copies specified portion of AID
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And a destination byte array of length 16
    When getPartialBytes is called with aidOffset 5, dest, oOffset 0, oLength 2
    Then the method returns 2
    And dest contains {0x01, 0x02} at offset 0

  # Source: [JavaCard 3.0.5 API, getPartialBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getPartialBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getPartialBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getPartialBytes with oLength 0 copies all remaining bytes
    Given an AID constructed from bytes {0xA0, 0x00, 0x00, 0x00, 0x62, 0x01, 0x02}
    And a destination byte array of length 16
    When getPartialBytes is called with aidOffset 5, dest, oOffset 0, oLength 0
    Then the method returns 2
    And dest contains {0x01, 0x02} at offset 0

  # Source: [JavaCard 3.0.5 API, getPartialBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getPartialBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getPartialBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getPartialBytes with null dest throws NullPointerException
    Given an AID constructed from a 7-byte value
    When getPartialBytes is called with a null dest array
    Then a NullPointerException is thrown

  # Source: [JavaCard 3.0.5 API, getPartialBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getPartialBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getPartialBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getPartialBytes with negative aidOffset throws ArrayIndexOutOfBoundsException
    Given an AID constructed from a 7-byte value
    And a destination byte array of length 16
    When getPartialBytes is called with aidOffset -1
    Then an ArrayIndexOutOfBoundsException is thrown

  # Source: [JavaCard 3.0.5 API, getPartialBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getPartialBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getPartialBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getPartialBytes with aidOffset exceeding AID length throws ArrayIndexOutOfBoundsException
    Given an AID constructed from a 7-byte value
    And a destination byte array of length 16
    When getPartialBytes is called with aidOffset 8
    Then an ArrayIndexOutOfBoundsException is thrown

  # Source: [JavaCard 3.0.5 API, getPartialBytes](../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.1 API, getPartialBytes](../../refs/javadoc-3.1/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  # Source: [JavaCard 3.2 API, getPartialBytes](../../refs/javadoc-3.2/api_classic/javacard/framework/AID.html#getPartialBytes(short,byte%5B%5D,short,byte)
  @v3.0.5 @v3.1 @v3.2
  Scenario: getPartialBytes with inaccessible dest throws SecurityException
    Given an AID constructed from a 7-byte value
    And a destination byte array not accessible in the caller's context
    When getPartialBytes is called with that dest array
    Then a SecurityException is thrown
