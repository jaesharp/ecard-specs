@jcvm @cap @constant_pool
Feature: CAP File Constant Pool Component
  The Constant Pool Component contains an entry for each class, method,
  and field referenced by elements in the Method Component. Each entry
  is a fixed 4-byte cp_info structure with a 1-byte tag and 3 bytes of
  info. There are six constant types in the Java Card constant pool.

  # Source: [JCVM 3.0.5, s6.8 Constant Pool Component](../3.0.5/JCVMSpec_3.0.5.pdf#page=88)
  # Source: [JCVM 3.1, s6.8 Constant Pool Component](../3.1/JCVMSpec_3.1.pdf#page=93)
  # Source: [JCVM 3.2, s6.8 Constant Pool Component](../3.2/JCVMSpec_3.2.pdf#page=93)

  Background:
    Given a Java Card CAP file

  @v3.0.5 @v3.1 @v3.2
  Scenario: Constant pool component structure
    # Source: [JCVM 3.0.5, s6.8](../3.0.5/JCVMSpec_3.0.5.pdf#page=88)
    # Source: [JCVM 3.2, s6.8](../3.2/JCVMSpec_3.2.pdf#page=93)
    Then the constant_pool_component shall contain:
      | Field            | Type     | Description                                |
      | tag              | u1       | COMPONENT_ConstantPool (5)                 |
      | size             | u2       | Number of bytes excluding tag and size      |
      | count            | u2       | Number of entries (0-65535)                 |
      | constant_pool[]  | cp_info  | Array of 4-byte constant pool entries       |

  @v3.0.5 @v3.1 @v3.2
  Scenario: cp_info is always 4 bytes -- 1 byte tag plus 3 bytes info
    # Source: [JCVM 3.0.5, s6.8](../3.0.5/JCVMSpec_3.0.5.pdf#page=89)
    # Source: [JCVM 3.2, s6.8](../3.2/JCVMSpec_3.2.pdf#page=94)
    Then each cp_info entry shall be exactly 4 bytes
    And the first byte shall be a tag indicating the kind of constant
    And the remaining 3 bytes contain type-specific information

  # ===== CONSTANT TYPES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: CONSTANT_Classref (tag = 1) -- reference to a class or interface
    # Source: [JCVM 3.0.5, s6.8.1 CONSTANT_Classref](../3.0.5/JCVMSpec_3.0.5.pdf#page=90)
    # Source: [JCVM 3.1, s6.8.1](../3.1/JCVMSpec_3.1.pdf#page=95)
    # Source: [JCVM 3.2, s6.8.1](../3.2/JCVMSpec_3.2.pdf#page=95)
    Then CONSTANT_Classref shall have tag value 1
    And class_ref is a union: internal_class_ref (u2, high bit 0) or external_class_ref (package_token + class_token, high bit 1)
    And an internal_class_ref is a 16-bit offset into the Class Component info
    And an external_class_ref consists of a package_token (u1) and a class_token (u1)
    And a padding byte (u1) of value 0 completes the 4-byte structure

  @v3.0.5 @v3.1 @v3.2
  Scenario: CONSTANT_InstanceFieldref (tag = 2) -- reference to an instance field
    # Source: [JCVM 3.0.5, s6.8.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=91)
    # Source: [JCVM 3.1, s6.8.2](../3.1/JCVMSpec_3.1.pdf#page=96)
    # Source: [JCVM 3.2, s6.8.2](../3.2/JCVMSpec_3.2.pdf#page=96)
    Then CONSTANT_InstanceFieldref shall have tag value 2
    And it contains a class_ref (u2) identifying the declaring class and a token (u1) for the field
    And the class referenced must be the class that contains the declaration of the field

  @v3.0.5 @v3.1 @v3.2
  Scenario: CONSTANT_VirtualMethodref (tag = 3) -- reference to a virtual method
    # Source: [JCVM 3.0.5, s6.8.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=91)
    # Source: [JCVM 3.1, s6.8.2](../3.1/JCVMSpec_3.1.pdf#page=96)
    # Source: [JCVM 3.2, s6.8.2](../3.2/JCVMSpec_3.2.pdf#page=96)
    Then CONSTANT_VirtualMethodref shall have tag value 3
    And it contains a class_ref (u2) and a token (u1) for the virtual method
    And the token's high bit indicates public/protected (0) or package-visible (1)

  @v3.0.5 @v3.1 @v3.2
  Scenario: CONSTANT_SuperMethodref (tag = 4) -- reference for super method invocation
    # Source: [JCVM 3.0.5, s6.8.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=91)
    # Source: [JCVM 3.1, s6.8.2](../3.1/JCVMSpec_3.1.pdf#page=96)
    # Source: [JCVM 3.2, s6.8.2](../3.2/JCVMSpec_3.2.pdf#page=96)
    Then CONSTANT_SuperMethodref shall have tag value 4
    And it contains a class_ref (u2) and a token (u1)
    And the class referenced must be the class containing the Java super invocation
    And the token is defined in the scope of the superclass hierarchy

  @v3.0.5 @v3.1 @v3.2
  Scenario: CONSTANT_StaticFieldref (tag = 5) -- reference to a static field
    # Source: [JCVM 3.0.5, s6.8.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=93)
    # Source: [JCVM 3.1, s6.8.3](../3.1/JCVMSpec_3.1.pdf#page=98)
    # Source: [JCVM 3.2, s6.8.3](../3.2/JCVMSpec_3.2.pdf#page=98)
    Then CONSTANT_StaticFieldref shall have tag value 5
    And for internal references: padding (u1, value 0) + offset (u2) into the Static Field Image
    And for external references: package_token (u1) + class_token (u1) + token (u1)

  @v3.0.5 @v3.1 @v3.2
  Scenario: CONSTANT_StaticMethodref (tag = 6) -- reference to a static method
    # Source: [JCVM 3.0.5, s6.8.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=93)
    # Source: [JCVM 3.1, s6.8.3](../3.1/JCVMSpec_3.1.pdf#page=98)
    # Source: [JCVM 3.2, s6.8.3](../3.2/JCVMSpec_3.2.pdf#page=98)
    Then CONSTANT_StaticMethodref shall have tag value 6
    And for internal references (Compact): padding (u1, value 0) + offset (u2) into Method Component
    And for internal references (Extended, since CAP 2.3): method_info_block_index (u1) + offset (u2)
    And for external references: package_token (u1) + class_token (u1) + token (u1)
