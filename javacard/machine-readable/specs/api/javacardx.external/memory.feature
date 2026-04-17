@javacardx @javacardx.external @v3.0.5 @v3.1 @v3.2
Feature: External Memory Access -- Memory, MemoryAccess, ExternalException
  The javacardx.external package provides access to external memory subsystems
  such as MIFARE memory and extended store memory. The Memory class provides
  factory access, MemoryAccess provides read/write operations, and
  ExternalException signals errors.

  # Source: [JavaCard 3.2 API, external package](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external package)

  Background:
    Given a JavaCard runtime environment

  # ========== Memory Constants ==========

  Scenario: Memory defines memory type constants
    Then class Memory defines static byte constant "MEMORY_TYPE_MIFARE" for MIFARE memory subsystem
    And class Memory defines static byte constant "MEMORY_TYPE_EXTENDED_STORE" for extended store memory
    # Source: [JavaCard 3.2 API, Memory](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external/Memory.html)

  # ========== Memory Factory Method ==========

  Scenario: Memory.getMemoryAccessInstance returns a MemoryAccess for the subsystem
    When Memory.getMemoryAccessInstance(byte memoryType, short[] memorySize, short memorySizeOffset) is called
    Then a MemoryAccess instance for the specified memory subsystem is returned
    And memorySize array is updated with the size of the memory region
    # Source: [JavaCard 3.2 API, getMemoryAccessInstance](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external/Memory.html#getMemoryAccessInstance(byte,short%5B%5D,short))

  Scenario: Memory.getMemoryAccessInstance throws ExternalException for invalid subsystem
    When getMemoryAccessInstance is called with an unsupported memory type
    Then ExternalException is thrown with reason code NO_SUCH_SUBSYSTEM
    # Source: [JavaCard 3.2 API, getMemoryAccessInstance](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external/Memory.html#getMemoryAccessInstance(byte,short%5B%5D,short))

  # ========== MemoryAccess Interface ==========

  Scenario: MemoryAccess.readData reads from external memory
    Given a MemoryAccess instance for a specific memory subsystem
    When readData(byte[] dest, short destOffset, short[] auth, short authOffset, short authLength, short memoryAddress, short readLength) is called
    Then data from the external memory at memoryAddress is copied to dest
    # Source: [JavaCard 3.2 API, readData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external/MemoryAccess.html#readData(byte%5B%5D,short,short%5B%5D,short,short,short,short))

  Scenario: MemoryAccess.writeData writes to external memory
    Given a MemoryAccess instance for a specific memory subsystem
    When writeData(byte[] src, short srcOffset, short srcLength, short[] auth, short authOffset, short authLength, short memoryAddress) is called
    Then data from src is written to external memory at memoryAddress
    # Source: [JavaCard 3.2 API, writeData](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external/MemoryAccess.html#writeData(byte%5B%5D,short,short,short%5B%5D,short,short,short))

  # ========== ExternalException ==========

  Scenario Outline: ExternalException defines reason codes
    Then class ExternalException defines static short constant "<constant>"

    # Source: [JavaCard 3.2 API, <constant>](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external/ExternalException.html)
    Examples:
      | constant          | description                          |
      | NO_SUCH_SUBSYSTEM | Requested memory subsystem not found |
      | INVALID_PARAM     | Invalid parameter value              |
      | INTERNAL_ERROR    | Internal subsystem error             |

  Scenario: ExternalException.throwIt throws an ExternalException
    When ExternalException.throwIt(short reason) is called
    Then an ExternalException is thrown with the specified reason code
    # Source: [JavaCard 3.2 API, throwIt](../../../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/external/ExternalException.html#throwIt(short))
