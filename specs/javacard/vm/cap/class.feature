@jcvm
@cap
@class
Feature: CAP File Class Component
  The Class Component describes each class and interface defined in the
  CAP file. It provides information sufficient to execute operations
  associated with a particular class or interface without performing
  verification. The Class Component has tag value 6 (COMPONENT_Class).

  # Source: [JCVM 3.0.5, s6.9 Class Component](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=95)
  # Source: [JCVM 3.1, s6.9 Class Component](../../refs/3.1/JCVMSpec_3.1.pdf#page=100)
  # Source: [JCVM 3.2, s6.9 Class Component](../../refs/3.2/JCVMSpec_3.2.pdf#page=100)
  Background:
    Given a Java Card CAP file

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Class component structure
    # Source: [JCVM 3.0.5, s6.9](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=95)
    # Source: [JCVM 3.2, s6.9](../../refs/3.2/JCVMSpec_3.2.pdf#page=101)
    Then the class_component shall contain:
      | Field                 | Type              | Description                                       |
      | tag                   | u1                | COMPONENT_Class (6)                               |
      | size                  | u2                | Size of info excluding tag and size               |
      | signature_pool_length | u2                | Length of signature_pool in bytes (since CAP 2.2) |
      | signature_pool[]      | type_descriptor[] | Signatures for remote methods (since CAP 2.2)     |
      | interfaces[]          | interface_info[]  | Array of interface descriptors                    |
      | classes[]             | class_info[]      | Array of class descriptors                        |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Interfaces ordered by hierarchy -- superinterfaces before subinterfaces
    # Source: [JCVM 3.0.5, s6.9](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=96)
    # Source: [JCVM 3.2, s6.9](../../refs/3.2/JCVMSpec_3.2.pdf#page=101)
    Then interfaces shall be ordered such that a superinterface has a lower index than its subinterfaces
    And classes shall be ordered such that a superclass has a lower index than its subclasses

  # ===== INTERFACE AND CLASS FLAGS =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Interface and class flags
    # Source: [JCVM 3.0.5, s6.9.2.1 Table 6-11](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=99)
    # Source: [JCVM 3.2, s6.9.2.1 Table 6-11](../../refs/3.2/JCVMSpec_3.2.pdf#page=106)
    Then the flags field (4 bits) shall support:
      | Flag          | Value | Description                                 |
      | ACC_INTERFACE | 0x8   | 1 = interface_info; 0 = class_info          |
      | ACC_SHAREABLE | 0x4   | 1 = implements javacard.framework.Shareable |
      | ACC_REMOTE    | 0x2   | 1 = class/interface is remote (RMI)         |

  # ===== INTERFACE_INFO =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: interface_info structure
    # Source: [JCVM 3.0.5, s6.9.2 interface_info](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=99)
    # Source: [JCVM 3.2, s6.9.2](../../refs/3.2/JCVMSpec_3.2.pdf#page=104)
    Then interface_info shall contain:
      | Field             | Type                | Description                                                        |
      | bitfield          | u1                  | flags (4 bits, ACC_INTERFACE must be 1) + interface_count (4 bits) |
      | superinterfaces[] | class_ref[]         | Direct and indirect superinterfaces (0-14 entries)                 |
      | interface_name    | interface_name_info | Name info (required only if ACC_REMOTE = 1)                        |

  # ===== CLASS_INFO =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: class_info_compact structure
    # Source: [JCVM 3.0.5, s6.9.2](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=99)
    # Source: [JCVM 3.2, s6.9.2](../../refs/3.2/JCVMSpec_3.2.pdf#page=104)
    Then class_info_compact shall contain:
      | Field                          | Type                         | Description                                        |
      | bitfield                       | u1                           | flags (4 bits) + interface_count (4 bits, 0-15)    |
      | super_class_ref                | class_ref                    | Superclass (0xFFFF if no superclass)               |
      | declared_instance_size         | u1                           | Number of 16-bit cells for instance fields         |
      | first_reference_token          | u1                           | Token of first reference-type field (0xFF if none) |
      | reference_count                | u1                           | Number of reference-type instance fields           |
      | public_method_table_base       | u1                           | Base virtual method token for public table         |
      | public_method_table_count      | u1                           | Number of public virtual method entries            |
      | package_method_table_base      | u1                           | Base virtual method token for package table        |
      | package_method_table_count     | u1                           | Number of package virtual method entries           |
      | public_virtual_method_table[]  | u2[]                         | Offsets into Method Component (public methods)     |
      | package_virtual_method_table[] | u2[]                         | Offsets into Method Component (package methods)    |
      | interfaces[]                   | implemented_interface_info[] | Implemented interfaces                             |

  # ===== IMPLEMENTED_INTERFACE_INFO =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: implemented_interface_info maps interface methods to virtual method tokens
    # Source: [JCVM 3.0.5, s6.9.2.4 implemented_interface_info](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=105)
    # Source: [JCVM 3.2, s6.9.2.5](../../refs/3.2/JCVMSpec_3.2.pdf#page=112)
    Then implemented_interface_info shall contain:
      | Field     | Type      | Description                                           |
      | interface | class_ref | Reference to the implemented interface                |
      | count     | u1        | Number of entries in the index array                  |
      | index[]   | u1[]      | Maps interface method tokens to virtual method tokens |

  # ===== TYPE_DESCRIPTOR =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: type_descriptor uses nibble encoding for types
    # Source: [JCVM 3.0.5, s6.9.1 type_descriptor](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=96)
    # Source: [JCVM 3.2, s6.9.1](../../refs/3.2/JCVMSpec_3.2.pdf#page=102)
    Then type_descriptor shall encode types using nibbles (4-bit values):
      | Type              | Nibble Value |
      | Void              | 0x1          |
      | Boolean           | 0x2          |
      | Byte              | 0x3          |
      | Short             | 0x4          |
      | Int               | 0x5          |
      | Reference         | 0x6          |
      | arrayof boolean   | 0xA          |
      | arrayof byte      | 0xB          |
      | arrayof short     | 0xC          |
      | arrayof int       | 0xD          |
      | arrayof reference | 0xE          |
