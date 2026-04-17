@jcvm @cap @method
Feature: CAP File Method Component
  The Method Component describes each method declared in the CAP file,
  excluding <clinit> methods and interface method declarations. Abstract
  methods defined by classes (not interfaces) are included. Exception
  handlers associated with each method are also described. The Method
  Component has tag value 7 (COMPONENT_Method).

  # Source: [JCVM 3.0.5, s6.10 Method Component](../3.0.5/JCVMSpec_3.0.5.pdf#page=108)
  # Source: [JCVM 3.1, s6.10 Method Component](../3.1/JCVMSpec_3.1.pdf#page=116)
  # Source: [JCVM 3.2, s6.10 Method Component](../3.2/JCVMSpec_3.2.pdf#page=116)

  Background:
    Given a Java Card CAP file

  @v3.0.5 @v3.1 @v3.2
  Scenario: Method component compact structure
    # Source: [JCVM 3.0.5, s6.10](../3.0.5/JCVMSpec_3.0.5.pdf#page=108)
    # Source: [JCVM 3.2, s6.10](../3.2/JCVMSpec_3.2.pdf#page=116)
    Then method_component_compact shall contain:
      | Field               | Type                  | Description                          |
      | tag                 | u1                    | COMPONENT_Method (7)                 |
      | size                | u2                    | Size of info excluding tag and size   |
      | handler_count       | u1                    | Number of exception handlers (0-255)  |
      | exception_handlers[]| exception_handler_info[] | Array of exception handler entries |
      | methods[]           | method_info[]         | Table of method info structures        |

  @v3.1 @v3.2
  Scenario: Method component extended structure (since CAP format 2.3)
    # Source: [JCVM 3.1, s6.10](../3.1/JCVMSpec_3.1.pdf#page=116)
    # Source: [JCVM 3.2, s6.10](../3.2/JCVMSpec_3.2.pdf#page=116)
    Then method_component_extended shall contain:
      | Field                          | Type                   | Description                     |
      | tag                            | u1                     | COMPONENT_Method (7)            |
      | size                           | u4                     | Size (extended format)          |
      | method_component_block_count   | u1                     | Number of blocks (0-127)        |
      | method_component_block_offsets[]| u4[]                  | Offsets to each block           |
      | blocks[]                       | method_component_block[] | Array of method blocks        |

  @v3.1 @v3.2
  Scenario: method_component_block structure (since CAP format 2.3)
    # Source: [JCVM 3.1, s6.10.1](../3.1/JCVMSpec_3.1.pdf#page=117)
    # Source: [JCVM 3.2, s6.10.1](../3.2/JCVMSpec_3.2.pdf#page=117)
    Then each method_component_block shall contain:
      | Field               | Type                  | Description                         |
      | handler_count       | u1                    | Number of exception handlers        |
      | exception_handlers[]| exception_handler_info[] | Exception handler table          |
      | methods[]           | method_info[]         | Method bytecodes and headers         |
    And each block has a maximum size of 65535 bytes
    And a method and all its exception handlers must be in the same block

  # ===== EXCEPTION HANDLER INFO =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: exception_handler_info structure -- 8 bytes per handler
    # Source: [JCVM 3.0.5, s6.10.2 exception_handler_info](../3.0.5/JCVMSpec_3.0.5.pdf#page=110)
    # Source: [JCVM 3.1, s6.10.3](../3.1/JCVMSpec_3.1.pdf#page=119)
    # Source: [JCVM 3.2, s6.10.3](../3.2/JCVMSpec_3.2.pdf#page=119)
    Then exception_handler_info shall contain:
      | Field          | Type           | Description                                |
      | start_offset   | u2             | Start of the try block (inclusive)          |
      | bitfield       | u2             | stop_bit (1 bit) + active_length (15 bits)  |
      | handler_offset | u2             | Start of the catch/finally handler          |
      | catch_type_index | u2           | Index into constant_pool (0 = finally block)|
    And start_offset and active_length define the try block range
    And end_offset = start_offset + active_length (exclusive)
    And if catch_type_index is 0, this handler represents a finally block
    And if catch_type_index is non-zero, it must reference a CONSTANT_Classref

  @v3.0.5 @v3.1 @v3.2
  Scenario: stop_bit optimization for exception handler search
    # Source: [JCVM 3.0.5, s6.10.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=111)
    # Source: [JCVM 3.2, s6.10.3](../3.2/JCVMSpec_3.2.pdf#page=120)
    Then stop_bit shall be 1 if the active range does not intersect with any succeeding handler's range
    And stop_bit shall be 0 if the active range is nested within another handler's range
    And the stop_bit allows early termination of the exception handler search

  @v3.0.5 @v3.1 @v3.2
  Scenario: Exception handlers sorted by handler_offset in ascending order
    # Source: [JCVM 3.0.5, s6.10](../3.0.5/JCVMSpec_3.0.5.pdf#page=109)
    # Source: [JCVM 3.2, s6.10](../3.2/JCVMSpec_3.2.pdf#page=118)
    Then exception_handlers entries shall be sorted in ascending order by handler_offset
    And nested handlers shall occur before outer handlers in the array

  # ===== METHOD INFO =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: method_info structure -- header followed by bytecodes
    # Source: [JCVM 3.0.5, s6.10.3 method_info](../3.0.5/JCVMSpec_3.0.5.pdf#page=112)
    # Source: [JCVM 3.1, s6.10.4](../3.1/JCVMSpec_3.1.pdf#page=121)
    # Source: [JCVM 3.2, s6.10.4](../3.2/JCVMSpec_3.2.pdf#page=121)
    Then method_info shall contain:
      | Field        | Type                | Description                         |
      | method_header | method_header_info or extended_method_header_info | Method header |
      | bytecodes[]  | u1[]               | Java Card bytecodes for this method  |

  @v3.0.5 @v3.1 @v3.2
  Scenario: method_header_info (compact, 2 bytes)
    # Source: [JCVM 3.0.5, s6.10.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=112)
    # Source: [JCVM 3.2, s6.10.4](../3.2/JCVMSpec_3.2.pdf#page=121)
    Then method_header_info shall contain:
      | Field      | Type | Description                                        |
      | flags      | 4 bits | ACC_EXTENDED (0x8) must be 0; ACC_ABSTRACT (0x4)  |
      | max_stack  | 4 bits | Max operand stack words needed (0-15)             |
      | nargs      | 4 bits | Number of parameter words including 'this' (0-15) |
      | max_locals | 4 bits | Number of local variable words (0-15)             |

  @v3.0.5 @v3.1 @v3.2
  Scenario: extended_method_header_info (extended, 4 bytes)
    # Source: [JCVM 3.0.5, s6.10.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=112)
    # Source: [JCVM 3.2, s6.10.4](../3.2/JCVMSpec_3.2.pdf#page=121)
    Then extended_method_header_info shall contain:
      | Field      | Type  | Description                                       |
      | flags      | 4 bits | ACC_EXTENDED (0x8) must be 1; ACC_ABSTRACT (0x4) |
      | padding    | 4 bits | Must be zero                                     |
      | max_stack  | u1    | Max operand stack words needed (0-255)            |
      | nargs      | u1    | Number of parameter words including 'this'        |
      | max_locals | u1    | Number of local variable words (0-255)            |

  @v3.0.5 @v3.1 @v3.2
  Scenario: Method flags ACC_EXTENDED and ACC_ABSTRACT
    # Source: [JCVM 3.0.5, s6.10.3 Table 6-12](../3.0.5/JCVMSpec_3.0.5.pdf#page=113)
    # Source: [JCVM 3.2, s6.10.4 Table 6-12](../3.2/JCVMSpec_3.2.pdf#page=122)
    Then ACC_EXTENDED (0x8) shall be 1 if the header is extended_method_header_info
    And ACC_ABSTRACT (0x4) shall be 1 if the method is abstract (bytecodes must be empty)
    And if ACC_ABSTRACT is 0, the method is not abstract and bytecodes must be present

  @v3.0.5 @v3.1 @v3.2
  Scenario: max_locals does not include method parameters
    # Source: [JCVM 3.0.5, s6.10.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=113)
    # Source: [JCVM 3.2, s6.10.4](../3.2/JCVMSpec_3.2.pdf#page=122)
    Then max_locals shall represent only the local variables declared by the method
    And parameters passed to the method are not included in max_locals
    And int-type local variables are represented in two words; all others in one word
