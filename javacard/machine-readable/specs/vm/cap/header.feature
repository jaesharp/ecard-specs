@jcvm @cap @header
Feature: CAP File Header Component
  The Header Component contains general information about the CAP file
  including the magic number, CAP format version, flags, and package
  information. It always has tag value 1 (COMPONENT_Header). The Header
  Component is always in Compact format even in Extended format CAP files.

  # Source: [JCVM 3.0.5, s6.4 Header Component](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=79)
  # Source: [JCVM 3.1, s6.4 Header Component](../../../3.1/JCVMSpec_3.1.pdf#page=81)
  # Source: [JCVM 3.2, s6.4 Header Component](../../../3.2/JCVMSpec_3.2.pdf#page=81)

  Background:
    Given a Java Card CAP file

  @v3.0.5 @v3.1 @v3.2
  Scenario: Header component tag is COMPONENT_Header (1)
    # Source: [JCVM 3.2, s6.4](../../../3.2/JCVMSpec_3.2.pdf#page=82)
    Then the tag item shall have the value 1 (COMPONENT_Header)

  @v3.0.5 @v3.1 @v3.2
  Scenario: Magic number is 0xDECAFFED
    # Source: [JCVM 3.0.5, s6.4](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=80)
    # Source: [JCVM 3.2, s6.4](../../../3.2/JCVMSpec_3.2.pdf#page=82)
    Then the magic item (u4) shall have the value 0xDECAFFED

  @v3.0.5 @v3.1 @v3.2
  Scenario: CAP format version -- major version 2, minor version 1-3
    # Source: [JCVM 3.0.5, s6.4](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=80)
    # Source: [JCVM 3.2, s6.4](../../../3.2/JCVMSpec_3.2.pdf#page=82)
    Then the CAP_Format_major_version (u1) shall be 2
    And the CAP_Format_minor_version (u1) shall be between 1 and 3 inclusive
    And the CAP file format version is expressed as major.minor (e.g. 2.3)

  @v3.0.5 @v3.1 @v3.2
  Scenario: ACC_INT flag indicates use of int data type
    # Source: [JCVM 3.0.5, s6.4 Table 6-3](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=81)
    # Source: [JCVM 3.2, s6.4 Table 6-3](../../../3.2/JCVMSpec_3.2.pdf#page=83)
    Then the flags item (u1) shall contain a mask of modifiers
    And ACC_INT (0x01) shall be 1 if the int type is used by any package in the CAP file

  @v3.0.5 @v3.1 @v3.2
  Scenario: ACC_EXPORT flag indicates presence of Export Component
    Then ACC_EXPORT (0x02) shall be 1 if an Export Component is included

  @v3.0.5 @v3.1 @v3.2
  Scenario: ACC_APPLET flag indicates presence of Applet Component
    Then ACC_APPLET (0x04) shall be 1 if an Applet Component is included

  @v3.1 @v3.2
  Scenario: ACC_EXTENDED flag indicates Extended format CAP file
    # Source: [JCVM 3.1, s6.4 Table 6-3](../../../3.1/JCVMSpec_3.1.pdf#page=83)
    # Source: [JCVM 3.2, s6.4 Table 6-3](../../../3.2/JCVMSpec_3.2.pdf#page=83)
    Then ACC_EXTENDED (0x08) shall be 1 if the CAP file is in Extended format

  @v3.0.5 @v3.1 @v3.2
  Scenario: package_info structure contains AID and version
    # Source: [JCVM 3.0.5, s6.4](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=82)
    # Source: [JCVM 3.2, s6.4](../../../3.2/JCVMSpec_3.2.pdf#page=84)
    Then the package_info structure shall contain:
      | Field         | Type | Description                                     |
      | minor_version | u1   | Minor version number of this package             |
      | major_version | u1   | Major version number of this package             |
      | AID_length    | u1   | Number of bytes in the AID item (5-16 inclusive)  |
      | AID[]         | u1[] | AID of this package (ISO 7816-5)                 |

  @v3.0.5 @v3.1 @v3.2
  Scenario: package_name_info structure (since CAP format 2.2)
    # Source: [JCVM 3.0.5, s6.4](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=82)
    # Source: [JCVM 3.2, s6.4](../../../3.2/JCVMSpec_3.2.pdf#page=84)
    Then the package_name_info structure shall contain:
      | Field       | Type | Description                                      |
      | name_length | u1   | Number of bytes in the name (0 if no remote interfaces) |
      | name[]      | u1[] | Fully qualified package name in UTF-8 internal form     |

  @v3.0.5 @v3.1 @v3.2
  Scenario: Compact format header contains single package_info
    # Source: [JCVM 3.0.5, s6.4](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=79)
    # Source: [JCVM 3.2, s6.4](../../../3.2/JCVMSpec_3.2.pdf#page=81)
    Then header_component_compact shall contain a single package_info for the one package

  @v3.1 @v3.2
  Scenario: Extended format header contains CAP AID, package count, and package array
    # Source: [JCVM 3.1, s6.4](../../../3.1/JCVMSpec_3.1.pdf#page=82)
    # Source: [JCVM 3.2, s6.4](../../../3.2/JCVMSpec_3.2.pdf#page=82)
    Then header_component_extended shall contain:
      | Field              | Type            | Description                        |
      | CAP_minor_version  | u1              | Minor version of this CAP file     |
      | CAP_major_version  | u1              | Major version of this CAP file     |
      | CAP_AID_length     | u1              | Length of the CAP AID (5-16)       |
      | CAP_AID[]          | u1[]            | AID of the CAP file                |
      | package_count      | u1              | Number of packages (must be > 0)   |
      | packages[]         | package_info[]  | Array of package_info structures    |
      | package_names[]    | package_name_info[] | Names of all packages          |
