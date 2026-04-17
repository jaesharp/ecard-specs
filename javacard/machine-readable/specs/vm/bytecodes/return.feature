@jcvm @bytecodes @return
Feature: JCVM Return and Miscellaneous Bytecodes
  The Java Card virtual machine provides return instructions for each
  return type (void, short, int, reference), an athrow instruction for
  throwing exceptions, and a nop instruction that does nothing.

  # Source: [JCVM 3.0.5, s7.5 Instruction Set](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=140)
  # Source: [JCVM 3.1, s7.5 Instruction Set](../../../3.1/JCVMSpec_3.1.pdf#page=159)
  # Source: [JCVM 3.2, s7.5 Instruction Set](../../../3.2/JCVMSpec_3.2.pdf#page=159)

  Background:
    Given a Java Card virtual machine implementation

  @v3.0.5 @v3.1 @v3.2
  Scenario: return -- return void from method
    # Source: [JCVM 3.0.5, s7.5.80 return](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=205)
    # Source: [JCVM 3.1, s7.5.80 return](../../../3.1/JCVMSpec_3.1.pdf#page=225)
    # Source: [JCVM 3.2, s7.5.80 return](../../../3.2/JCVMSpec_3.2.pdf#page=225)
    Given the instruction "return" with opcode 122 (0x7a)
    And format: return
    Then the operand stack shall transition: ... -> [empty]
    And any values on the operand stack of the current method are discarded
    And the VM reinstates the frame of the invoker and returns control to the invoker

  @v3.0.5 @v3.1 @v3.2
  Scenario: sreturn -- return short from method
    # Source: [JCVM 3.0.5, s7.5.99 sreturn](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=216)
    # Source: [JCVM 3.1, s7.5.99 sreturn](../../../3.1/JCVMSpec_3.1.pdf#page=236)
    # Source: [JCVM 3.2, s7.5.99 sreturn](../../../3.2/JCVMSpec_3.2.pdf#page=236)
    Given the instruction "sreturn" with opcode 120 (0x78)
    And format: sreturn
    Then the operand stack shall transition: ..., value -> [empty]
    And value must be of type short
    And it is popped from the current frame and pushed onto the operand stack of the invoker's frame

  @v3.0.5 @v3.1 @v3.2
  Scenario: ireturn -- return int from method
    # Source: [JCVM 3.0.5, s7.5.60 ireturn](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=189)
    # Source: [JCVM 3.1, s7.5.60 ireturn](../../../3.1/JCVMSpec_3.1.pdf#page=209)
    # Source: [JCVM 3.2, s7.5.60 ireturn](../../../3.2/JCVMSpec_3.2.pdf#page=209)
    Given the instruction "ireturn" with opcode 121 (0x79)
    And format: ireturn
    Then the operand stack shall transition: ..., value.word1, value.word2 -> [empty]
    And value must be of type int
    And it is popped from the current frame and pushed onto the operand stack of the invoker's frame
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: areturn -- return reference from method
    # Source: [JCVM 3.0.5, s7.5.7 areturn](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=147)
    # Source: [JCVM 3.1, s7.5.7 areturn](../../../3.1/JCVMSpec_3.1.pdf#page=165)
    # Source: [JCVM 3.2, s7.5.7 areturn](../../../3.2/JCVMSpec_3.2.pdf#page=165)
    Given the instruction "areturn" with opcode 119 (0x77)
    And format: areturn
    Then the operand stack shall transition: ..., objectref -> [empty]
    And objectref must be of type reference
    And it is popped from the current frame and pushed onto the operand stack of the invoker's frame

  @v3.0.5 @v3.1 @v3.2
  Scenario: athrow -- throw exception or error
    # Source: [JCVM 3.0.5, s7.5.11 athrow](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=149)
    # Source: [JCVM 3.1, s7.5.11 athrow](../../../3.1/JCVMSpec_3.1.pdf#page=168)
    # Source: [JCVM 3.2, s7.5.11 athrow](../../../3.2/JCVMSpec_3.2.pdf#page=168)
    Given the instruction "athrow" with opcode 147 (0x93)
    And format: athrow
    Then the operand stack shall transition: ..., objectref -> objectref
    And objectref must be of type reference and must refer to an instance of Throwable or its subclass
    And the VM searches the current frame for a matching catch clause
    And if a matching catch clause is found, the pc is reset to the handler location
    And if no matching clause is found, the frame is popped and objectref is rethrown in the invoker
    And if objectref is null, a NullPointerException shall be thrown instead

  @v3.0.5 @v3.1 @v3.2
  Scenario: nop -- do nothing
    # Source: [JCVM 3.0.5, s7.5.72 nop](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=197)
    # Source: [JCVM 3.1, s7.5.72 nop](../../../3.1/JCVMSpec_3.1.pdf#page=217)
    # Source: [JCVM 3.2, s7.5.72 nop](../../../3.2/JCVMSpec_3.2.pdf#page=217)
    Given the instruction "nop" with opcode 0 (0x0)
    And format: nop
    Then the stack shall not change
    And no operation shall be performed
