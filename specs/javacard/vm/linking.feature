@jcvm
@linking
Feature: JCVM Binary Representation, AID Naming, Token-based Linking, and Binary Compatibility
  Java Card technology uses a different strategy for binary representation
  than Java. Executable binaries are CAP files; public API information is
  in export files. Naming uses ISO 7816-5 AIDs instead of Unicode strings.
  Linking uses opaque numeric tokens instead of symbolic references.

  # Source: [JCVM 3.0.5, s4 Binary Representation](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=51)
  # Source: [JCVM 3.1, s4 Binary Representation](../refs/3.1/JCVMSpec_3.1.pdf#page=51)
  # Source: [JCVM 3.2, s4 Binary Representation](../refs/3.2/JCVMSpec_3.2.pdf#page=51)
  Background:
    Given a Java Card platform implementation

  # ===== FILE FORMATS =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Two binary file formats -- CAP file and export file
    # Source: [JCVM 3.0.5, s4.1 Java Card Platform File Formats](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=51)
    # Source: [JCVM 3.2, s4.1](../refs/3.2/JCVMSpec_3.2.pdf#page=51)
    Then the platform shall define two binary file formats: CAP files and export files
    And CAP files contain executable code that can be installed on a device
    And export files contain public linking information for API packages
    And export files are used during conversion, not on the device itself

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CAP file is the Java Card equivalent of a class file
    # Source: [JCVM 3.0.5, s4.1.2 CAP File Format](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=52)
    # Source: [JCVM 3.2, s4.1.2](../refs/3.2/JCVMSpec_3.2.pdf#page=52)
    Then a CAP file shall contain a binary representation of one or more Java packages
    And it is produced by a Java Card converter
    And its relationship to the JCVM is analogous to the .class file to the JVM

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: JAR file is the container for CAP files
    # Source: [JCVM 3.0.5, s4.1.3 JAR File Container](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=52)
    # Source: [JCVM 3.2, s4.1.3](../refs/3.2/JCVMSpec_3.2.pdf#page=52)
    Then the JAR file format shall be the container format for CAP files
    And CAP file components shall be stored as individual files within the JAR

  # ===== AID-BASED NAMING =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: AID format -- RID (5 bytes) plus PIX (0-11 bytes)
    # Source: [JCVM 3.0.5, s4.2.1 The AID Format](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=53)
    # Source: [JCVM 3.2, s4.2.1](../refs/3.2/JCVMSpec_3.2.pdf#page=53)
    Then an AID shall consist of a 5-byte RID (resource identifier) and a 0 to 11 byte PIX (proprietary identifier extension)
    And the total AID length shall be between 5 and 16 bytes inclusive
    And ISO controls the assignment of RIDs to companies
    And companies manage assignment of PIXs for AIDs using their own RIDs

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CAP file AID namespace -- no two CAP files may share an AID
    # Source: [JCVM 3.0.5, s4.2.2.1 CAP File AID namespace](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=53)
    # Source: [JCVM 3.2, s4.2.2.1](../refs/3.2/JCVMSpec_3.2.pdf#page=53)
    Then all CAP files must be assigned an AID such that no two CAP files have the same AID
    And the AID is formed from the company's RID and a PIX for that CAP file

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Applet AID namespace -- unique per applet, shared RID with CAP file
    # Source: [JCVM 3.0.5, s4.2.2.2 Applet AID namespace](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=53)
    # Source: [JCVM 3.2, s4.2.2.2](../refs/3.2/JCVMSpec_3.2.pdf#page=53)
    Then each applet must have a unique AID
    And the RID of each applet AID must match the RID of the CAP file AID
    And no two applets in the same CAP file may share the same AID

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Package AID namespace -- unique per package
    # Source: [JCVM 3.0.5, s4.2.2.3 Package AID namespace](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=54)
    # Source: [JCVM 3.2, s4.2.2.3](../refs/3.2/JCVMSpec_3.2.pdf#page=54)
    Then any package represented in an export file must be assigned a unique AID
    And the AID corresponds to the package's string name

  # ===== TOKEN-BASED LINKING =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Six kinds of externally visible items require tokens
    # Source: [JCVM 3.0.5, s4.3.1 Externally Visible Items](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=54)
    # Source: [JCVM 3.2, s4.3.1](../refs/3.2/JCVMSpec_3.2.pdf#page=54)
    Then six kinds of items in a package require external identification:
      | Item Kind        | Token Range | Type              | Scope           |
      | Package          | 0-127       | Private           | Package         |
      | Class/Interface  | 0-254       | Public            | Package         |
      | Static Field     | 0-255       | Public            | Class           |
      | Static Method    | 0-255       | Public            | Class           |
      | Instance Field   | 0-255       | Public or Private | Class           |
      | Virtual Method   | 0-127       | Public or Private | Class Hierarchy |
      | Interface Method | 0-127       | Public            | Class           |

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Private tokens for internal linking
    # Source: [JCVM 3.0.5, s4.3.2 Private Tokens](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=54)
    # Source: [JCVM 3.2, s4.3.2](../refs/3.2/JCVMSpec_3.2.pdf#page=55)
    Then three kinds of items can be assigned private tokens: instance fields, virtual methods, and packages

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Export file maps names to tokens during conversion
    # Source: [JCVM 3.0.5, s4.3.3 The Export File and Conversion](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=54)
    # Source: [JCVM 3.2, s4.3.3](../refs/3.2/JCVMSpec_3.2.pdf#page=55)
    Then the export file shall be used to map imported item names to tokens during package conversion
    And the converter uses these tokens to represent unresolved references in the CAP file

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: External references use package token + item token; internal references use offsets
    # Source: [JCVM 3.0.5, s4.3.4 References](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=55)
    # Source: [JCVM 3.2, s4.3.4](../refs/3.2/JCVMSpec_3.2.pdf#page=55)
    Then external references (to other CAP files) shall be made through the constant pool using tokens
    And an external class reference consists of a package token and a class token
    And an internal class reference is a 15-bit offset into the Class Component
    And an internal static member reference is a 16-bit offset into the Static Field or Method Component

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Instance field token assignment -- public reference fields before private, int skips a token
    # Source: [JCVM 3.0.5, s4.3.7.5 Instance Fields](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=57)
    # Source: [JCVM 3.2, s4.3.7.5](../refs/3.2/JCVMSpec_3.2.pdf#page=57)
    Then instance field tokens shall be in the range 0-255
    And public reference field tokens shall be numbered greater than public primitive field tokens
    And private reference field tokens shall be numbered less than private primitive field tokens
    And an int field token shall cause the following field's token to be incremented by two

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Virtual method token high bit indicates public (0) or private (1)
    # Source: [JCVM 3.0.5, s4.3.7.6 Virtual Methods](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=57)
    # Source: [JCVM 3.2, s4.3.7.6](../refs/3.2/JCVMSpec_3.2.pdf#page=58)
    Then virtual method tokens shall be in the range 0-127
    And the high bit of the byte containing the token indicates public (0) or private (1)
    And overriding methods must use the same token number as the method in the superclass

  # ===== BINARY COMPATIBILITY =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Binary compatibility between package versions
    # Source: [JCVM 3.0.5, s4.4 Binary Compatibility](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=58)
    # Source: [JCVM 3.2, s4.4](../refs/3.2/JCVMSpec_3.2.pdf#page=59)
    Then a new CAP file is binary compatible if another CAP file converted with the old export file can link with the new one
    And changing a token value assigned to an API element causes binary incompatibility
    And changing the value of an externally visible final static field (compile-time constant) causes binary incompatibility

  # ===== PACKAGE VERSIONS =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Package versioning -- major.minor version numbers
    # Source: [JCVM 3.0.5, s4.5 Package Versions](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=60)
    # Source: [JCVM 3.2, s4.5](../refs/3.2/JCVMSpec_3.2.pdf#page=60)
    Then each package implementation shall be assigned a major and minor version number
    And the initial version should be major 1, minor 0
    And a binary-incompatible change requires incrementing the major version and resetting minor to 0
    And a binary-compatible change requires keeping the same major version and incrementing the minor

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Version compatibility during linking
    # Source: [JCVM 3.0.5, s4.5.2 Linking](../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=60)
    # Source: [JCVM 3.2, s4.5.2](../refs/3.2/JCVMSpec_3.2.pdf#page=60)
    Then during installation, references to an imported package can be resolved only when version numbers are compatible
    And versions are compatible when major versions are equal and the export file's minor version is less than or equal to the resident image's minor version
