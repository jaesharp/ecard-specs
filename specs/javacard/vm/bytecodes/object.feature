@jcvm
@bytecodes
@object
Feature: JCVM Object Operation Bytecodes
  The Java Card virtual machine provides instructions for creating objects,
  type checking, field access, and method invocation. Field access instructions
  come in typed variants (_a, _b, _s, _i) and short/wide index forms.

  # Source: [JCVM 3.0.5, s7.5 Instruction Set](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=140)
  # Source: [JCVM 3.1, s7.5 Instruction Set](../../refs/3.1/JCVMSpec_3.1.pdf#page=159)
  # Source: [JCVM 3.2, s7.5 Instruction Set](../../refs/3.2/JCVMSpec_3.2.pdf#page=159)
  Background:
    Given a Java Card virtual machine implementation

  # ===== OBJECT CREATION =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: new -- create new object
    # Source: [JCVM 3.0.5, s7.5.70 new](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=196)
    # Source: [JCVM 3.1, s7.5.70 new](../../refs/3.1/JCVMSpec_3.1.pdf#page=216)
    # Source: [JCVM 3.2, s7.5.70 new](../../refs/3.2/JCVMSpec_3.2.pdf#page=216)
    Given the instruction "new" with opcode 143 (0x8f)
    And format: new, indexbyte1, indexbyte2
    Then the operand stack shall transition: ... -> ..., objectref
    And the constant pool entry at (indexbyte1 << 8) | indexbyte2 must be CONSTANT_Classref
    And the reference must resolve to a class type (not an interface type)
    And memory shall be allocated from the heap with instance variables initialized to defaults

  # ===== TYPE CHECKING =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: checkcast -- check whether object is of given type
    # Source: [JCVM 3.0.5, s7.5.16 checkcast](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=153)
    # Source: [JCVM 3.1, s7.5.16 checkcast](../../refs/3.1/JCVMSpec_3.1.pdf#page=171)
    # Source: [JCVM 3.2, s7.5.16 checkcast](../../refs/3.2/JCVMSpec_3.2.pdf#page=171)
    Given the instruction "checkcast" with opcode 148 (0x94)
    And format: checkcast, atype, indexbyte1, indexbyte2
    Then the operand stack shall transition: ..., objectref -> ..., objectref
    And atype indicates array type check (10=T_BOOLEAN, 11=T_BYTE, 12=T_SHORT, 13=T_INT, 14=T_REFERENCE) or 0 for class/interface
    And if objectref cannot be cast to the resolved type, a ClassCastException shall be thrown
    And if objectref is null, the stack is unchanged (no exception)

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: instanceof -- determine if object is of given type
    # Source: [JCVM 3.0.5, s7.5.53 instanceof](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=181)
    # Source: [JCVM 3.1, s7.5.53 instanceof](../../refs/3.1/JCVMSpec_3.1.pdf#page=200)
    # Source: [JCVM 3.2, s7.5.53 instanceof](../../refs/3.2/JCVMSpec_3.2.pdf#page=200)
    Given the instruction "instanceof" with opcode 149 (0x95)
    And format: instanceof, atype, indexbyte1, indexbyte2
    Then the operand stack shall transition: ..., objectref -> ..., result
    And if objectref is not null and is an instance of the resolved type, result is short 1; otherwise short 0

  # ===== INSTANCE FIELD ACCESS =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getfield_a, getfield_b, getfield_s, getfield_i -- fetch field from object
    # Source: [JCVM 3.0.5, s7.5.20 getfield_<t>](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=157)
    # Source: [JCVM 3.1, s7.5.20 getfield_<t>](../../refs/3.1/JCVMSpec_3.1.pdf#page=175)
    # Source: [JCVM 3.2, s7.5.20 getfield_<t>](../../refs/3.2/JCVMSpec_3.2.pdf#page=175)
    Given the instruction family "getfield_<t>"
    And format: getfield_<t>, index
    And forms: getfield_a = 131 (0x83), getfield_b = 132 (0x84), getfield_s = 133 (0x85), getfield_i = 134 (0x86)
    Then the operand stack shall transition: ..., objectref -> ..., value (or value.word1, value.word2 for _i)
    And the unsigned index is used as an index into the constant pool (CONSTANT_InstanceFieldref)
    And _a field must be reference; _b field must be byte or boolean; _s field must be short; _i field must be int
    And if objectref is null, a NullPointerException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getfield_a_this through getfield_i_this -- fetch field from current object
    # Source: [JCVM 3.0.5, s7.5.21 getfield_<t>_this](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=158)
    # Source: [JCVM 3.1, s7.5.21 getfield_<t>_this](../../refs/3.1/JCVMSpec_3.1.pdf#page=176)
    # Source: [JCVM 3.2, s7.5.21 getfield_<t>_this](../../refs/3.2/JCVMSpec_3.2.pdf#page=176)
    Given the instruction family "getfield_<t>_this"
    And format: getfield_<t>_this, index
    And forms: getfield_a_this = 173 (0xad), getfield_b_this = 174 (0xae), getfield_s_this = 175 (0xaf), getfield_i_this = 176 (0xb0)
    Then the operand stack shall transition: ... -> ..., value (or value.word1, value.word2 for _i)
    And the currently executing method must be an instance method with local variable 0 as "this"

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getfield_a_w through getfield_i_w -- fetch field from object (wide index)
    # Source: [JCVM 3.0.5, s7.5.22 getfield_<t>_w](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=159)
    # Source: [JCVM 3.1, s7.5.22 getfield_<t>_w](../../refs/3.1/JCVMSpec_3.1.pdf#page=178)
    # Source: [JCVM 3.2, s7.5.22 getfield_<t>_w](../../refs/3.2/JCVMSpec_3.2.pdf#page=178)
    Given the instruction family "getfield_<t>_w"
    And format: getfield_<t>_w, indexbyte1, indexbyte2
    And forms: getfield_a_w = 169 (0xa9), getfield_b_w = 170 (0xaa), getfield_s_w = 171 (0xab), getfield_i_w = 172 (0xac)
    Then the operand stack shall transition: ..., objectref -> ..., value
    And index is (indexbyte1 << 8) | indexbyte2

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: putfield_a, putfield_b, putfield_s, putfield_i -- set field in object
    # Source: [JCVM 3.0.5, s7.5.75 putfield_<t>](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=199)
    # Source: [JCVM 3.1, s7.5.75 putfield_<t>](../../refs/3.1/JCVMSpec_3.1.pdf#page=219)
    # Source: [JCVM 3.2, s7.5.75 putfield_<t>](../../refs/3.2/JCVMSpec_3.2.pdf#page=219)
    Given the instruction family "putfield_<t>"
    And format: putfield_<t>, index
    And forms: putfield_a = 135 (0x87), putfield_b = 136 (0x88), putfield_s = 137 (0x89), putfield_i = 138 (0x8a)
    Then the operand stack shall transition: ..., objectref, value -> ... (or objectref, value.word1, value.word2 for _i)
    And if objectref is null, a NullPointerException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: putfield_a_this through putfield_i_this -- set field in current object
    # Source: [JCVM 3.0.5, s7.5.76 putfield_<t>_this](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=200)
    # Source: [JCVM 3.1, s7.5.76 putfield_<t>_this](../../refs/3.1/JCVMSpec_3.1.pdf#page=220)
    # Source: [JCVM 3.2, s7.5.76 putfield_<t>_this](../../refs/3.2/JCVMSpec_3.2.pdf#page=220)
    Given the instruction family "putfield_<t>_this"
    And format: putfield_<t>_this, index
    And forms: putfield_a_this = 181 (0xb5), putfield_b_this = 182 (0xb6), putfield_s_this = 183 (0xb7), putfield_i_this = 184 (0xb8)
    Then the operand stack shall transition: ..., value -> ... (or value.word1, value.word2 for _i)

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: putfield_a_w through putfield_i_w -- set field in object (wide index)
    # Source: [JCVM 3.0.5, s7.5.77 putfield_<t>_w](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=202)
    # Source: [JCVM 3.1, s7.5.77 putfield_<t>_w](../../refs/3.1/JCVMSpec_3.1.pdf#page=222)
    # Source: [JCVM 3.2, s7.5.77 putfield_<t>_w](../../refs/3.2/JCVMSpec_3.2.pdf#page=222)
    Given the instruction family "putfield_<t>_w"
    And format: putfield_<t>_w, indexbyte1, indexbyte2
    And forms: putfield_a_w = 177 (0xb1), putfield_b_w = 178 (0xb2), putfield_s_w = 179 (0xb3), putfield_i_w = 180 (0xb4)
    Then the operand stack shall transition: ..., objectref, value -> ...

  # ===== STATIC FIELD ACCESS =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getstatic_a, getstatic_b, getstatic_s, getstatic_i -- get static field from class
    # Source: [JCVM 3.0.5, s7.5.23 getstatic_<t>](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=161)
    # Source: [JCVM 3.1, s7.5.23 getstatic_<t>](../../refs/3.1/JCVMSpec_3.1.pdf#page=179)
    # Source: [JCVM 3.2, s7.5.23 getstatic_<t>](../../refs/3.2/JCVMSpec_3.2.pdf#page=179)
    Given the instruction family "getstatic_<t>"
    And format: getstatic_<t>, indexbyte1, indexbyte2
    And forms: getstatic_a = 123 (0x7b), getstatic_b = 124 (0x7c), getstatic_s = 125 (0x7d), getstatic_i = 126 (0x7e)
    Then the operand stack shall transition: ... -> ..., value (or value.word1, value.word2 for _i)
    And the constant pool entry must be CONSTANT_StaticFieldref

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: putstatic_a, putstatic_b, putstatic_s, putstatic_i -- set static field in class
    # Source: [JCVM 3.0.5, s7.5.78 putstatic_<t>](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=203)
    # Source: [JCVM 3.1, s7.5.78 putstatic_<t>](../../refs/3.1/JCVMSpec_3.1.pdf#page=223)
    # Source: [JCVM 3.2, s7.5.78 putstatic_<t>](../../refs/3.2/JCVMSpec_3.2.pdf#page=223)
    Given the instruction family "putstatic_<t>"
    And format: putstatic_<t>, indexbyte1, indexbyte2
    And forms: putstatic_a = 127 (0x7f), putstatic_b = 128 (0x80), putstatic_s = 129 (0x81), putstatic_i = 130 (0x82)
    Then the operand stack shall transition: ..., value -> ... (or value.word1, value.word2 for _i)

  # ===== METHOD INVOCATION =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: invokevirtual -- invoke instance method, dispatch based on class
    # Source: [JCVM 3.0.5, s7.5.57 invokevirtual](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=187)
    # Source: [JCVM 3.1, s7.5.57 invokevirtual](../../refs/3.1/JCVMSpec_3.1.pdf#page=206)
    # Source: [JCVM 3.2, s7.5.57 invokevirtual](../../refs/3.2/JCVMSpec_3.2.pdf#page=206)
    Given the instruction "invokevirtual" with opcode 139 (0x8b)
    And format: invokevirtual, indexbyte1, indexbyte2
    Then the operand stack shall transition: ..., objectref, [arg1, [arg2 ...]] -> ...
    And the constant pool entry must be CONSTANT_VirtualMethodref
    And the method must not be <init>, <clinit>, or a class/interface initialization method
    And if objectref is null, a NullPointerException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: invokeinterface -- invoke interface method
    # Source: [JCVM 3.0.5, s7.5.54 invokeinterface](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=183)
    # Source: [JCVM 3.1, s7.5.54 invokeinterface](../../refs/3.1/JCVMSpec_3.1.pdf#page=202)
    # Source: [JCVM 3.2, s7.5.54 invokeinterface](../../refs/3.2/JCVMSpec_3.2.pdf#page=202)
    Given the instruction "invokeinterface" with opcode 142 (0x8e)
    And format: invokeinterface, nargs, indexbyte1, indexbyte2, method
    Then the operand stack shall transition: ..., objectref, [arg1, [arg2 ...]] -> ...
    And nargs is an unsigned byte that must not be zero
    And the method operand is the interface method token for the method to be invoked
    And if objectref is null, a NullPointerException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: invokespecial -- invoke instance method (special handling)
    # Source: [JCVM 3.0.5, s7.5.55 invokespecial](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=185)
    # Source: [JCVM 3.1, s7.5.55 invokespecial](../../refs/3.1/JCVMSpec_3.1.pdf#page=204)
    # Source: [JCVM 3.2, s7.5.55 invokespecial](../../refs/3.2/JCVMSpec_3.2.pdf#page=204)
    Given the instruction "invokespecial" with opcode 140 (0x8c)
    And format: invokespecial, indexbyte1, indexbyte2
    Then the operand stack shall transition: ..., objectref, [arg1, [arg2 ...]] -> ...
    And this instruction is used for superclass, private, and instance initialization method invocations
    And the constant pool entry is CONSTANT_StaticMethodref (for private/<init>) or CONSTANT_SuperMethodref (for super calls)
    And if objectref is null, a NullPointerException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: invokestatic -- invoke a class (static) method
    # Source: [JCVM 3.0.5, s7.5.56 invokestatic](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=186)
    # Source: [JCVM 3.1, s7.5.56 invokestatic](../../refs/3.1/JCVMSpec_3.1.pdf#page=205)
    # Source: [JCVM 3.2, s7.5.56 invokestatic](../../refs/3.2/JCVMSpec_3.2.pdf#page=205)
    Given the instruction "invokestatic" with opcode 141 (0x8d)
    And format: invokestatic, indexbyte1, indexbyte2
    Then the operand stack shall transition: ..., [arg1, [arg2 ...]] -> ...
    And the constant pool entry must be CONSTANT_StaticMethodref
    And the method must not be <init>, <clinit>, or an instance initialization method
    And the method must be static and therefore cannot be abstract
