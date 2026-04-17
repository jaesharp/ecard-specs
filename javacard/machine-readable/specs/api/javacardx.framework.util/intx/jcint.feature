@javacardx
@javacardx.framework.util.intx
@v3.0.5
@v3.1
@v3.2
Feature: JCint -- 32-bit Integer Support Utility
  The JCint class provides utility methods for working with 32-bit (int) values
  on the Java Card platform, which natively supports only 16-bit (short) values.
  It provides methods to construct ints from shorts, read/write ints in byte arrays,
  create transient int arrays, and create int array views.

  # Source: [JavaCard 3.2 API, JCint](../../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/intx/JCint.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: JCint.makeInt constructs an int from two shorts
    When JCint.makeInt(short high, short low) is called
    Then a 32-bit int is returned with high as the upper 16 bits and low as the lower 16 bits

  # Source: [JavaCard 3.2 API, JCint.makeInt](../../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/intx/JCint.html#makeInt(short,short))
  Scenario: JCint.makeInt constructs an int from four bytes
    When JCint.makeInt(byte b1, byte b2, byte b3, byte b4) is called
    Then a 32-bit int is returned with b1 as the most significant byte and b4 as the least

  # Source: [JavaCard 3.2 API, JCint.makeInt](../../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/intx/JCint.html#makeInt(byte,byte,byte,byte))
  Scenario: JCint.getInt reads an int from a byte array
    When JCint.getInt(byte[] bArray, short bOff) is called
    Then a 32-bit int is read from 4 consecutive bytes starting at bOff in big-endian order

  # Source: [JavaCard 3.2 API, JCint.getInt](../../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/intx/JCint.html#getInt(byte%5B%5D,short))
  Scenario: JCint.setInt writes an int to a byte array
    When JCint.setInt(byte[] bArray, short bOff, int iValue) is called
    Then the 32-bit int is written as 4 bytes starting at bOff in big-endian order

  # Source: [JavaCard 3.2 API, JCint.setInt](../../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/intx/JCint.html#setInt(byte%5B%5D,short,int))
  Scenario: JCint.makeTransientIntArray creates a transient int array
    When JCint.makeTransientIntArray(short length, byte event) is called
    Then a transient int array of the specified length is created
    And the event parameter specifies clear-on-reset or clear-on-deselect behavior

  # Source: [JavaCard 3.2 API, JCint.makeTransientIntArray](../../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/intx/JCint.html#makeTransientIntArray(short,byte))
  Scenario: JCint.makeIntArrayView creates an int view over a byte array
    When JCint.makeIntArrayView(byte[] bArray, short bOff, short bLen) is called
    Then returns an int array that is a view over the specified byte array region
    And changes to the int array are reflected in the underlying byte array and vice versa

# Source: [JavaCard 3.2 API, JCint.makeIntArrayView](../../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/intx/JCint.html#makeIntArrayView(byte%5B%5D,short,short))