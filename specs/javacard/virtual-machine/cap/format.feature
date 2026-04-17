@jcvm
@cap
@format
Feature: CAP File Structure and Component Model
  A CAP (Converted Applet) file is the binary representation of a Java Card
  application or library. It consists of a set of components, each describing
  a different aspect of the contents. The file is contained in a JAR file.
  A CAP file may be in Compact format (single package, max 64KB bytecode)
  or Extended format (multiple packages, up to 128 blocks of 64KB each).

  # Source: [JCVM 3.0.5, s6.1 CAP File Overview](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=76)
  # Source: [JCVM 3.1, s6.1 CAP File Overview](../.refs/3.1/JCVMSpec_3.1.pdf#page=77)
  # Source: [JCVM 3.2, s6.1 CAP File Overview](../.refs/3.2/JCVMSpec_3.2.pdf#page=77)
  Background:
    Given a Java Card CAP file

  # ===== GENERAL FORMAT =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CAP file is a stream of 8-bit bytes with big-endian multibyte values
    # Source: [JCVM 3.0.5, s6.1](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=76)
    # Source: [JCVM 3.1, s6.1](../.refs/3.1/JCVMSpec_3.1.pdf#page=77)
    # Source: [JCVM 3.2, s6.1](../.refs/3.2/JCVMSpec_3.2.pdf#page=77)
    Then the CAP file shall consist of a stream of 8-bit bytes
    And 16-bit quantities shall be constructed by reading two consecutive bytes (big-endian)
    And 32-bit quantities shall be constructed by reading four consecutive bytes (big-endian)

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CAP file data types u1, u2, u4
    # Source: [JCVM 3.0.5, s6.1](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=76)
    # Source: [JCVM 3.1, s6.1](../.refs/3.1/JCVMSpec_3.1.pdf#page=77)
    # Source: [JCVM 3.2, s6.1](../.refs/3.2/JCVMSpec_3.2.pdf#page=77)
    Then u1 shall represent an unsigned one-byte quantity
    And u2 shall represent an unsigned two-byte quantity
    And u4 shall represent an unsigned four-byte quantity

  # ===== COMPONENT MODEL =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Compact format component structure -- tag (u1), size (u2), info[]
    # Source: [JCVM 3.0.5, s6.2 Component Model](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=76)
    # Source: [JCVM 3.1, s6.2 Component Model](../.refs/3.1/JCVMSpec_3.1.pdf#page=78)
    # Source: [JCVM 3.2, s6.2 Component Model](../.refs/3.2/JCVMSpec_3.2.pdf#page=78)
    Then each component in Compact format shall begin with a u1 tag
    And followed by a u2 size indicating the number of bytes in the info array
    And followed by the info[] byte array

  @v3.1
  @v3.2
  Scenario: Extended format component structure -- tag (u1), size (u4), info[]
    # Source: [JCVM 3.1, s6.2 Component Model](../.refs/3.1/JCVMSpec_3.1.pdf#page=78)
    # Source: [JCVM 3.2, s6.2 Component Model](../.refs/3.2/JCVMSpec_3.2.pdf#page=78)
    Then each component in Extended format shall begin with a u1 tag
    And followed by a u4 size indicating the number of bytes in the info array
    And followed by the info[] byte array

  # ===== COMPONENT TAGS =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Header has tag value 1
    # Source: [JCVM 3.0.5, s6.2 Table 6-1](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=77)
    # Source: [JCVM 3.2, s6.2 Table 6-1](../.refs/3.2/JCVMSpec_3.2.pdf#page=79)
    Then COMPONENT_Header shall have tag value 1 and file name "Header.cap"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Directory has tag value 2
    Then COMPONENT_Directory shall have tag value 2 and file name "Directory.cap"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Applet has tag value 3 (optional)
    Then COMPONENT_Applet shall have tag value 3 and file name "Applet.cap"
    And it shall be included only if applets are defined in the packages

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Import has tag value 4
    Then COMPONENT_Import shall have tag value 4 and file name "Import.cap"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_ConstantPool has tag value 5
    Then COMPONENT_ConstantPool shall have tag value 5 and file name "ConstantPool.cap"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Class has tag value 6
    Then COMPONENT_Class shall have tag value 6 and file name "Class.cap"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Method has tag value 7
    Then COMPONENT_Method shall have tag value 7 and file name "Method.cap[x]"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_StaticField has tag value 8
    Then COMPONENT_StaticField shall have tag value 8 and file name "StaticField.cap"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_ReferenceLocation has tag value 9
    Then COMPONENT_ReferenceLocation shall have tag value 9 and file name "RefLocation.cap[x]"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Export has tag value 10 (optional)
    Then COMPONENT_Export shall have tag value 10 and file name "Export.cap"
    And it shall be included only if classes are imported by other packages

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Descriptor has tag value 11
    Then COMPONENT_Descriptor shall have tag value 11 and file name "Descriptor.cap[x]"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: COMPONENT_Debug has tag value 12 (optional, since CAP format 2.2)
    Then COMPONENT_Debug shall have tag value 12 and file name "Debug.cap[x]"
    And it is not intended for download to the device

  @v3.1
  @v3.2
  Scenario: COMPONENT_Static_Resources has tag value 13 (optional, since CAP format 2.3)
    # Source: [JCVM 3.1, s6.2 Table 6-1](../.refs/3.1/JCVMSpec_3.1.pdf#page=79)
    # Source: [JCVM 3.2, s6.2 Table 6-1](../.refs/3.2/JCVMSpec_3.2.pdf#page=79)
    Then COMPONENT_Static_Resources shall have tag value 13 and file name "StaticResources.capx"

  # ===== JAR CONTAINMENT =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CAP file components are stored in a JAR file
    # Source: [JCVM 3.0.5, s6.2.1 Containment in a JAR File](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=77)
    # Source: [JCVM 3.1, s6.2.1](../.refs/3.1/JCVMSpec_3.1.pdf#page=79)
    # Source: [JCVM 3.2, s6.2.1](../.refs/3.2/JCVMSpec_3.2.pdf#page=79)
    Then all CAP file components shall be stored as files in a JAR file
    And the path to the component files shall consist of a directory called "javacard"
    And component file names are not case sensitive

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Compact format JAR directory structure follows package path
    # Source: [JCVM 3.0.5, s6.2.1](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=77)
    # Source: [JCVM 3.2, s6.2.1](../.refs/3.2/JCVMSpec_3.2.pdf#page=79)
    Then in Compact format the "javacard" directory shall be in a subdirectory representing the package
    And for example, javacard.framework components are in javacard/framework/javacard/

  @v3.1
  @v3.2
  Scenario: Extended format JAR directory structure follows application path
    # Source: [JCVM 3.1, s6.2.1](../.refs/3.1/JCVMSpec_3.1.pdf#page=79)
    # Source: [JCVM 3.2, s6.2.1](../.refs/3.2/JCVMSpec_3.2.pdf#page=79)
    Then in Extended format the "javacard" directory shall be in a subdirectory representing the application

  # ===== CUSTOM COMPONENTS =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Custom components use tag values 128-255 and are identified by AID
    # Source: [JCVM 3.0.5, s6.2.2 Defining New Components](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=78)
    # Source: [JCVM 3.1, s6.2.2](../.refs/3.1/JCVMSpec_3.1.pdf#page=80)
    # Source: [JCVM 3.2, s6.2.2](../.refs/3.2/JCVMSpec_3.2.pdf#page=80)
    Then custom components shall have tag values between 128 and 255 inclusive
    And they shall also be assigned an ISO 7816-5 AID
    And VMs must silently ignore components they do not recognize

  # ===== INSTALLATION ORDER =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Reference component install order
    # Source: [JCVM 3.0.5, s6.3 Installation](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=79)
    # Source: [JCVM 3.1, s6.3 Installation](../.refs/3.1/JCVMSpec_3.1.pdf#page=81)
    # Source: [JCVM 3.2, s6.3 Installation](../.refs/3.2/JCVMSpec_3.2.pdf#page=81)
    Then the reference installation order shall be:
      | Order | Component                       |
      | 1     | COMPONENT_Header                |
      | 2     | COMPONENT_Directory             |
      | 3     | COMPONENT_Import                |
      | 4     | COMPONENT_Applet                |
      | 5     | COMPONENT_Class                 |
      | 6     | COMPONENT_Method                |
      | 7     | COMPONENT_StaticField           |
      | 8     | COMPONENT_Export                |
      | 9     | COMPONENT_ConstantPool          |
      | 10    | COMPONENT_ReferenceLocation     |
      | 11    | COMPONENT_Static_Resources      |
      | 12    | COMPONENT_Descriptor (optional) |
