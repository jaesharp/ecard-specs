@javacardx
@javacardx.framework.nio
@v3.1
@v3.2
Feature: NIO Buffer Framework -- Buffer, ByteBuffer, ByteOrder, and Exceptions
  The javacardx.framework.nio package provides a buffer abstraction similar to
  java.nio for Java Card. Buffer is the abstract base class. ByteBuffer provides
  byte-oriented buffer operations with support for shorts, ints, and byte order.

  BufferOverflowException, BufferUnderflowException, and ReadOnlyBufferException
  signal buffer access errors.

  # Source: [JavaCard 3.2 API, nio package](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/package-summary.html)
  Background:
    Given a JavaCard runtime environment

  # ========== ByteOrder ==========
  Scenario: ByteOrder defines byte order constants
    Then class ByteOrder defines static field "BIG_ENDIAN" for big-endian byte order
    And class ByteOrder defines static field "LITTLE_ENDIAN" for little-endian byte order

  # Source: [JavaCard 3.2 API, ByteOrder](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteOrder.html)
  # ========== Buffer Abstract Base ==========
  Scenario: Buffer provides position, limit, and capacity management
    Given a Buffer instance
    Then capacity() returns the total buffer capacity
    And position() returns the current position
    And position(short newPosition) sets the position
    And limit() returns the current limit
    And limit(short newLimit) sets the limit

  # Source: [JavaCard 3.2 API, Buffer](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/Buffer.html)
  Scenario: Buffer.clear resets position to 0 and limit to capacity
    Given a Buffer instance
    When clear() is called
    Then position is set to 0 and limit is set to capacity

  # Source: [JavaCard 3.2 API, clear](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/Buffer.html#clear)
  Scenario: Buffer.flip sets limit to current position and resets position to 0
    Given a Buffer with position > 0
    When flip() is called
    Then limit is set to the current position and position is set to 0

  # Source: [JavaCard 3.2 API, flip](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/Buffer.html#flip)
  Scenario: Buffer.rewind sets position to 0 without changing limit
    Given a Buffer instance
    When rewind() is called
    Then position is set to 0 and limit is unchanged

  # Source: [JavaCard 3.2 API, rewind](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/Buffer.html#rewind)
  Scenario: Buffer.remaining returns limit minus position
    Given a Buffer instance
    When remaining() is called
    Then the number of elements between position and limit is returned

  # Source: [JavaCard 3.2 API, remaining](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/Buffer.html#remaining)
  Scenario: Buffer.hasRemaining checks if elements remain
    Given a Buffer instance
    When hasRemaining() is called
    Then returns true if position < limit

  # Source: [JavaCard 3.2 API, hasRemaining](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/Buffer.html#hasRemaining)
  Scenario: Buffer.slice creates a shared sub-buffer
    Given a Buffer instance
    When slice() is called
    Then a new Buffer sharing the same data from position to limit is returned

  # Source: [JavaCard 3.2 API, slice](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/Buffer.html#slice)
  # ========== ByteBuffer Factory Methods ==========
  Scenario: ByteBuffer.allocateDirect creates a direct byte buffer
    When ByteBuffer.allocateDirect(short capacity) is called
    Then a new direct ByteBuffer with the specified capacity is returned
    And position is 0 and limit equals capacity

  # Source: [JavaCard 3.2 API, allocateDirect](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#allocateDirect(short))
  Scenario: ByteBuffer.wrap creates a buffer wrapping a byte array
    When ByteBuffer.wrap(byte[] array) is called
    Then a ByteBuffer backed by the specified array is returned
    And capacity and limit equal array.length, position is 0

  # Source: [JavaCard 3.2 API, wrap](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#wrap(byte%5B%5D))
  Scenario: ByteBuffer.wrap creates a buffer wrapping a byte array region
    When ByteBuffer.wrap(byte[] array, short offset, short length) is called
    Then a ByteBuffer backed by the array with the specified offset and length is returned

  # Source: [JavaCard 3.2 API, wrap](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#wrap(byte%5B%5D,short,short))
  # ========== ByteBuffer Byte Order ==========
  Scenario: ByteBuffer.order retrieves the current byte order
    Given a ByteBuffer instance
    When order() is called
    Then the current ByteOrder is returned (default is BIG_ENDIAN)

  # Source: [JavaCard 3.2 API, order](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#order)
  Scenario: ByteBuffer.order sets the byte order
    Given a ByteBuffer instance
    When order(ByteOrder bo) is called
    Then the byte order for multi-byte reads/writes is set to bo

  # Source: [JavaCard 3.2 API, order](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#order(ByteOrder))
  # ========== ByteBuffer Get/Put Operations ==========
  Scenario: ByteBuffer relative get reads one byte and advances position
    Given a ByteBuffer with remaining capacity
    When get() is called
    Then the byte at the current position is returned and position advances by 1
    And BufferUnderflowException is thrown if position >= limit

  # Source: [JavaCard 3.2 API, get](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#get)
  Scenario: ByteBuffer absolute get reads at a specific index
    Given a ByteBuffer instance
    When get(short index) is called
    Then the byte at the specified index is returned without changing position

  # Source: [JavaCard 3.2 API, get](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#get(short))
  Scenario: ByteBuffer relative put writes one byte and advances position
    Given a writable ByteBuffer with remaining capacity
    When put(byte b) is called
    Then b is written at the current position and position advances by 1
    And BufferOverflowException is thrown if position >= limit
    And ReadOnlyBufferException is thrown if the buffer is read-only

  # Source: [JavaCard 3.2 API, put](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#put(byte))
  Scenario: ByteBuffer bulk get reads bytes into an array
    Given a ByteBuffer with sufficient remaining data
    When get(byte[] dst, short offset, short length) is called
    Then length bytes are read into dst starting at offset

  # Source: [JavaCard 3.2 API, get](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#get(byte%5B%5D,short,short))
  Scenario: ByteBuffer bulk put writes bytes from an array
    Given a writable ByteBuffer with sufficient capacity
    When put(byte[] src, short offset, short length) is called
    Then length bytes from src are written starting at the current position

  # Source: [JavaCard 3.2 API, put](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#put(byte%5B%5D,short,short))
  Scenario: ByteBuffer put from another ByteBuffer
    Given a writable ByteBuffer and a source ByteBuffer
    When put(ByteBuffer src) is called
    Then all remaining bytes from src are written to this buffer

  # Source: [JavaCard 3.2 API, put](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#put(ByteBuffer))
  # ========== ByteBuffer Typed Access ==========
  Scenario: ByteBuffer.getShort reads a short value
    Given a ByteBuffer with at least 2 remaining bytes
    When getShort() is called
    Then a short is read in the current byte order and position advances by 2

  # Source: [JavaCard 3.2 API, getShort](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#getShort)
  Scenario: ByteBuffer.putShort writes a short value
    Given a writable ByteBuffer with at least 2 remaining bytes
    When putShort(short value) is called
    Then the short is written in the current byte order and position advances by 2

  # Source: [JavaCard 3.2 API, putShort](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#putShort(short))
  Scenario: ByteBuffer.getInt reads an int value
    Given a ByteBuffer with at least 4 remaining bytes
    When getInt() is called
    Then an int is read in the current byte order and position advances by 4

  # Source: [JavaCard 3.2 API, getInt](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#getInt)
  Scenario: ByteBuffer.putInt writes an int value
    Given a writable ByteBuffer with at least 4 remaining bytes
    When putInt(int value) is called
    Then the int is written in the current byte order and position advances by 4

  # Source: [JavaCard 3.2 API, putInt](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#putInt(int))
  # ========== ByteBuffer Views and Comparison ==========
  Scenario: ByteBuffer.asReadOnlyBuffer creates a read-only view
    Given a ByteBuffer instance
    When asReadOnlyBuffer() is called
    Then a new read-only ByteBuffer sharing the same data is returned
    And any put operation on the read-only buffer throws ReadOnlyBufferException

  # Source: [JavaCard 3.2 API, asReadOnlyBuffer](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#asReadOnlyBuffer)
  Scenario: ByteBuffer.compact compacts the buffer
    Given a ByteBuffer with some bytes consumed
    When compact() is called
    Then remaining bytes are moved to the beginning and position is set after them

  # Source: [JavaCard 3.2 API, compact](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#compact)
  Scenario: ByteBuffer.compareTo compares two byte buffers
    Given two ByteBuffer instances
    When compareTo(ByteBuffer that) is called
    Then a lexicographic comparison of remaining elements is performed

  # Source: [JavaCard 3.2 API, compareTo](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ByteBuffer.html#compareTo(ByteBuffer))
  # ========== Buffer Exceptions ==========
  Scenario: BufferOverflowException is thrown on write past limit
    When a put operation exceeds the buffer limit
    Then BufferOverflowException is thrown

  # Source: [JavaCard 3.2 API, BufferOverflowException](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/BufferOverflowException.html)
  Scenario: BufferUnderflowException is thrown on read past limit
    When a get operation exceeds the buffer limit
    Then BufferUnderflowException is thrown

  # Source: [JavaCard 3.2 API, BufferUnderflowException](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/BufferUnderflowException.html)
  Scenario: ReadOnlyBufferException is thrown on write to read-only buffer
    When a put operation is attempted on a read-only buffer
    Then ReadOnlyBufferException is thrown


# Source: [JavaCard 3.2 API, ReadOnlyBufferException](../.refs/javadoc-3.2/api_classic/javacardx/framework/nio/ReadOnlyBufferException.html)