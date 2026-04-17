@jcvm @bytecodes @conversion
Feature: JCVM Type Conversion Bytecodes
  The Java Card virtual machine provides four type conversion instructions:
  s2b (short to byte), s2i (short to int), i2b (int to byte), and i2s (int
  to short). The s2b instruction is the only narrowing conversion between
  the always-supported types. The s2i instruction is a widening conversion.
  The i2b and i2s instructions are narrowing conversions from the optional
  int type.

  # Source: [JCVM 3.0.5, s7.5 Instruction Set](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=140)
  # Source: [JCVM 3.1, s7.5 Instruction Set](../../refs/3.1/JCVMSpec_3.1.pdf#page=159)
  # Source: [JCVM 3.2, s7.5 Instruction Set](../../refs/3.2/JCVMSpec_3.2.pdf#page=159)

  Background:
    Given a Java Card virtual machine implementation

  @v3.0.5 @v3.1 @v3.2
  Scenario: s2b -- convert short to byte
    # Source: [JCVM 3.0.5, s7.5.81 s2b](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=205)
    # Source: [JCVM 3.1, s7.5.81 s2b](../../refs/3.1/JCVMSpec_3.1.pdf#page=225)
    # Source: [JCVM 3.2, s7.5.81 s2b](../../refs/3.2/JCVMSpec_3.2.pdf#page=225)
    Given the instruction "s2b" with opcode 91 (0x5b)
    And format: s2b
    Then the operand stack shall transition: ..., value -> ..., result
    And value must be of type short
    And the value shall be truncated to a byte, then sign-extended back to a short result
    And this is a narrowing conversion that may lose information about magnitude
    And the result may not have the same sign as value

  @v3.0.5 @v3.1 @v3.2
  Scenario: s2i -- convert short to int
    # Source: [JCVM 3.0.5, s7.5.82 s2i](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=206)
    # Source: [JCVM 3.1, s7.5.82 s2i](../../refs/3.1/JCVMSpec_3.1.pdf#page=226)
    # Source: [JCVM 3.2, s7.5.82 s2i](../../refs/3.2/JCVMSpec_3.2.pdf#page=226)
    Given the instruction "s2i" with opcode 92 (0x5c)
    And format: s2i
    Then the operand stack shall transition: ..., value -> ..., result.word1, result.word2
    And value must be of type short
    And the value shall be sign-extended to an int result
    And this is a widening conversion; the conversion is exact
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: i2b -- convert int to byte
    # Source: [JCVM 3.0.5, s7.5.26 i2b](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=163)
    # Source: [JCVM 3.1, s7.5.26 i2b](../../refs/3.1/JCVMSpec_3.1.pdf#page=181)
    # Source: [JCVM 3.2, s7.5.26 i2b](../../refs/3.2/JCVMSpec_3.2.pdf#page=181)
    Given the instruction "i2b" with opcode 93 (0x5d)
    And format: i2b
    Then the operand stack shall transition: ..., value.word1, value.word2 -> ..., result
    And value must be of type int
    And the low-order 16 bits are taken, then truncated to a byte, then sign-extended to a short result
    And this is a narrowing conversion that may lose information about magnitude and sign
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: i2s -- convert int to short
    # Source: [JCVM 3.0.5, s7.5.27 i2s](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=163)
    # Source: [JCVM 3.1, s7.5.27 i2s](../../refs/3.1/JCVMSpec_3.1.pdf#page=182)
    # Source: [JCVM 3.2, s7.5.27 i2s](../../refs/3.2/JCVMSpec_3.2.pdf#page=182)
    Given the instruction "i2s" with opcode 94 (0x5e)
    And format: i2s
    Then the operand stack shall transition: ..., value.word1, value.word2 -> ..., result
    And value must be of type int
    And the result is the low-order 16 bits of the int value, discarding the high-order 16 bits
    And this is a narrowing conversion that may lose information about magnitude and sign
    And this instruction is unavailable if the VM does not support the int data type
