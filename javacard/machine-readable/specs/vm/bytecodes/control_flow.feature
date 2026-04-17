@jcvm @bytecodes @control_flow
Feature: JCVM Control Flow Bytecodes
  The Java Card virtual machine provides branch, jump, and switch
  instructions for controlling program flow. Branches come in 8-bit
  (short offset) and 16-bit (wide offset) forms.

  # Source: [JCVM 3.0.5, s7.5 Instruction Set](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=140)
  # Source: [JCVM 3.1, s7.5 Instruction Set](../../../3.1/JCVMSpec_3.1.pdf#page=159)
  # Source: [JCVM 3.2, s7.5 Instruction Set](../../../3.2/JCVMSpec_3.2.pdf#page=159)

  Background:
    Given a Java Card virtual machine implementation

  # ===== UNCONDITIONAL BRANCHES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: goto -- branch always (8-bit offset)
    # Source: [JCVM 3.0.5, s7.5.24 goto](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=162)
    # Source: [JCVM 3.1, s7.5.24 goto](../../../3.1/JCVMSpec_3.1.pdf#page=180)
    # Source: [JCVM 3.2, s7.5.24 goto](../../../3.2/JCVMSpec_3.2.pdf#page=180)
    Given the instruction "goto" with opcode 112 (0x70)
    And format: goto, branch
    Then the stack shall not change
    And branch is used as a signed 8-bit offset from the address of the goto opcode
    And the target address must be an opcode within the method containing this instruction

  @v3.0.5 @v3.1 @v3.2
  Scenario: goto_w -- branch always (16-bit offset)
    # Source: [JCVM 3.0.5, s7.5.25 goto_w](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=162)
    # Source: [JCVM 3.1, s7.5.25 goto_w](../../../3.1/JCVMSpec_3.1.pdf#page=181)
    # Source: [JCVM 3.2, s7.5.25 goto_w](../../../3.2/JCVMSpec_3.2.pdf#page=181)
    Given the instruction "goto_w" with opcode 168 (0xa8)
    And format: goto_w, branchbyte1, branchbyte2
    Then the stack shall not change
    And branchbyte1 and branchbyte2 form a signed 16-bit branchoffset (branchbyte1 << 8) | branchbyte2

  # ===== SHORT COMPARISON BRANCHES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: if_scmpeq through if_scmple -- branch if short comparison succeeds (8-bit)
    # Source: [JCVM 3.0.5, s7.5.37 if_scmp<cond>](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=170)
    # Source: [JCVM 3.1, s7.5.37 if_scmp<cond>](../../../3.1/JCVMSpec_3.1.pdf#page=189)
    # Source: [JCVM 3.2, s7.5.37 if_scmp<cond>](../../../3.2/JCVMSpec_3.2.pdf#page=189)
    Given the instruction family "if_scmp<cond>"
    And format: if_scmp<cond>, branch
    And forms: if_scmpeq = 106 (0x6a), if_scmpne = 107 (0x6b), if_scmplt = 108 (0x6c), if_scmpge = 109 (0x6d), if_scmpgt = 110 (0x6e), if_scmple = 111 (0x6f)
    Then the operand stack shall transition: ..., value1, value2 -> ...
    And both values must be of type short, and the signed comparison is performed
    And if the comparison succeeds, branch is used as a signed 8-bit offset

  @v3.0.5 @v3.1 @v3.2
  Scenario: if_scmpeq_w through if_scmple_w -- branch if short comparison succeeds (16-bit)
    # Source: [JCVM 3.0.5, s7.5.38 if_scmp<cond>_w](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=171)
    # Source: [JCVM 3.1, s7.5.38 if_scmp<cond>_w](../../../3.1/JCVMSpec_3.1.pdf#page=189)
    # Source: [JCVM 3.2, s7.5.38 if_scmp<cond>_w](../../../3.2/JCVMSpec_3.2.pdf#page=189)
    Given the instruction family "if_scmp<cond>_w"
    And format: if_scmp<cond>_w, branchbyte1, branchbyte2
    And forms: if_scmpeq_w = 162 (0xa2), if_scmpne_w = 163 (0xa3), if_scmplt_w = 164 (0xa4), if_scmpge_w = 165 (0xa5), if_scmpgt_w = 166 (0xa6), if_scmple_w = 167 (0xa7)
    Then the operand stack shall transition: ..., value1, value2 -> ...
    And the branchoffset is (branchbyte1 << 8) | branchbyte2

  # ===== REFERENCE COMPARISON BRANCHES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: if_acmpeq, if_acmpne -- branch if reference comparison succeeds (8-bit)
    # Source: [JCVM 3.0.5, s7.5.35 if_acmp<cond>](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=169)
    # Source: [JCVM 3.1, s7.5.35 if_acmp<cond>](../../../3.1/JCVMSpec_3.1.pdf#page=187)
    # Source: [JCVM 3.2, s7.5.35 if_acmp<cond>](../../../3.2/JCVMSpec_3.2.pdf#page=187)
    Given the instruction family "if_acmp<cond>"
    And format: if_acmp<cond>, branch
    And forms: if_acmpeq = 104 (0x68), if_acmpne = 105 (0x69)
    Then the operand stack shall transition: ..., value1, value2 -> ...
    And both values must be of type reference
    And eq succeeds iff value1 = value2; ne succeeds iff value1 != value2

  @v3.0.5 @v3.1 @v3.2
  Scenario: if_acmpeq_w, if_acmpne_w -- branch if reference comparison succeeds (16-bit)
    # Source: [JCVM 3.0.5, s7.5.36 if_acmp<cond>_w](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=169)
    # Source: [JCVM 3.1, s7.5.36 if_acmp<cond>_w](../../../3.1/JCVMSpec_3.1.pdf#page=188)
    # Source: [JCVM 3.2, s7.5.36 if_acmp<cond>_w](../../../3.2/JCVMSpec_3.2.pdf#page=188)
    Given the instruction family "if_acmp<cond>_w"
    And format: if_acmp<cond>_w, branchbyte1, branchbyte2
    And forms: if_acmpeq_w = 160 (0xa0), if_acmpne_w = 161 (0xa1)
    Then the operand stack shall transition: ..., value1, value2 -> ...

  # ===== UNARY SHORT COMPARISON BRANCHES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: ifeq through ifle -- branch if short comparison with zero succeeds (8-bit)
    # Source: [JCVM 3.0.5, s7.5.39 if<cond>](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=172)
    # Source: [JCVM 3.1, s7.5.39 if<cond>](../../../3.1/JCVMSpec_3.1.pdf#page=190)
    # Source: [JCVM 3.2, s7.5.39 if<cond>](../../../3.2/JCVMSpec_3.2.pdf#page=190)
    Given the instruction family "if<cond>"
    And format: if<cond>, branch
    And forms: ifeq = 96 (0x60), ifne = 97 (0x61), iflt = 98 (0x62), ifge = 99 (0x63), ifgt = 100 (0x64), ifle = 101 (0x65)
    Then the operand stack shall transition: ..., value -> ...
    And value must be of type short, and is compared against zero

  @v3.0.5 @v3.1 @v3.2
  Scenario: ifeq_w through ifle_w -- branch if short comparison with zero succeeds (16-bit)
    # Source: [JCVM 3.0.5, s7.5.40 if<cond>_w](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=173)
    # Source: [JCVM 3.1, s7.5.40 if<cond>_w](../../../3.1/JCVMSpec_3.1.pdf#page=191)
    # Source: [JCVM 3.2, s7.5.40 if<cond>_w](../../../3.2/JCVMSpec_3.2.pdf#page=191)
    Given the instruction family "if<cond>_w"
    And format: if<cond>_w, branchbyte1, branchbyte2
    And forms: ifeq_w = 152 (0x98), ifne_w = 153 (0x99), iflt_w = 154 (0x9a), ifge_w = 155 (0x9b), ifgt_w = 156 (0x9c), ifle_w = 157 (0x9d)
    Then the operand stack shall transition: ..., value -> ...

  # ===== NULL REFERENCE BRANCHES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: ifnull -- branch if reference is null (8-bit offset)
    # Source: [JCVM 3.0.5, s7.5.43 ifnull](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=175)
    # Source: [JCVM 3.1, s7.5.43 ifnull](../../../3.1/JCVMSpec_3.1.pdf#page=193)
    # Source: [JCVM 3.2, s7.5.43 ifnull](../../../3.2/JCVMSpec_3.2.pdf#page=193)
    Given the instruction "ifnull" with opcode 102 (0x66)
    And format: ifnull, branch
    Then the operand stack shall transition: ..., value -> ...
    And value must be of type reference; if value is null, branch is taken

  @v3.0.5 @v3.1 @v3.2
  Scenario: ifnull_w -- branch if reference is null (16-bit offset)
    # Source: [JCVM 3.0.5, s7.5.44 ifnull_w](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=175)
    # Source: [JCVM 3.1, s7.5.44 ifnull_w](../../../3.1/JCVMSpec_3.1.pdf#page=194)
    # Source: [JCVM 3.2, s7.5.44 ifnull_w](../../../3.2/JCVMSpec_3.2.pdf#page=194)
    Given the instruction "ifnull_w" with opcode 158 (0x9e)
    And format: ifnull_w, branchbyte1, branchbyte2
    Then the operand stack shall transition: ..., value -> ...

  @v3.0.5 @v3.1 @v3.2
  Scenario: ifnonnull -- branch if reference not null (8-bit offset)
    # Source: [JCVM 3.0.5, s7.5.41 ifnonnull](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=174)
    # Source: [JCVM 3.1, s7.5.41 ifnonnull](../../../3.1/JCVMSpec_3.1.pdf#page=192)
    # Source: [JCVM 3.2, s7.5.41 ifnonnull](../../../3.2/JCVMSpec_3.2.pdf#page=192)
    Given the instruction "ifnonnull" with opcode 103 (0x67)
    And format: ifnonnull, branch
    Then the operand stack shall transition: ..., value -> ...
    And value must be of type reference; if value is not null, branch is taken

  @v3.0.5 @v3.1 @v3.2
  Scenario: ifnonnull_w -- branch if reference not null (16-bit offset)
    # Source: [JCVM 3.0.5, s7.5.42 ifnonnull_w](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=174)
    # Source: [JCVM 3.1, s7.5.42 ifnonnull_w](../../../3.1/JCVMSpec_3.1.pdf#page=193)
    # Source: [JCVM 3.2, s7.5.42 ifnonnull_w](../../../3.2/JCVMSpec_3.2.pdf#page=193)
    Given the instruction "ifnonnull_w" with opcode 159 (0x9f)
    And format: ifnonnull_w, branchbyte1, branchbyte2
    Then the operand stack shall transition: ..., value -> ...

  # ===== SWITCH INSTRUCTIONS =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: slookupswitch -- access jump table by short key match
    # Source: [JCVM 3.0.5, s7.5.94 slookupswitch](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=213)
    # Source: [JCVM 3.1, s7.5.94 slookupswitch](../../../3.1/JCVMSpec_3.1.pdf#page=233)
    # Source: [JCVM 3.2, s7.5.94 slookupswitch](../../../3.2/JCVMSpec_3.2.pdf#page=233)
    Given the instruction "slookupswitch" with opcode 117 (0x75)
    And format: slookupswitch, defaultbyte1, defaultbyte2, npairs1, npairs2, match-offset pairs...
    Then the operand stack shall transition: ..., key -> ...
    And key must be of type short
    And match-offset pairs must be sorted in increasing numerical order by match value
    And each pair consists of a signed 16-bit match and a signed 16-bit offset

  @v3.0.5 @v3.1 @v3.2
  Scenario: stableswitch -- access jump table by short index
    # Source: [JCVM 3.0.5, s7.5.106 stableswitch](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=220)
    # Source: [JCVM 3.1, s7.5.106 stableswitch](../../../3.1/JCVMSpec_3.1.pdf#page=240)
    # Source: [JCVM 3.2, s7.5.106 stableswitch](../../../3.2/JCVMSpec_3.2.pdf#page=240)
    Given the instruction "stableswitch" with opcode 115 (0x73)
    And format: stableswitch, defaultbyte1, defaultbyte2, lowbyte1, lowbyte2, highbyte1, highbyte2, jump offsets...
    Then the operand stack shall transition: ..., index -> ...
    And index must be of type short
    And low must be less than or equal to high
    And the jump table contains (high - low + 1) signed 16-bit offsets

  @v3.0.5 @v3.1 @v3.2
  Scenario: ilookupswitch -- access jump table by int key match
    # Source: [JCVM 3.0.5, s7.5.50 ilookupswitch](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=179)
    # Source: [JCVM 3.1, s7.5.50 ilookupswitch](../../../3.1/JCVMSpec_3.1.pdf#page=197)
    # Source: [JCVM 3.2, s7.5.50 ilookupswitch](../../../3.2/JCVMSpec_3.2.pdf#page=197)
    Given the instruction "ilookupswitch" with opcode 118 (0x76)
    And format: ilookupswitch, defaultbyte1, defaultbyte2, npairs1, npairs2, match-offset pairs...
    Then the operand stack shall transition: ..., key.word1, key.word2 -> ...
    And key must be of type int
    And each pair has a 32-bit int match (4 bytes) and a signed 16-bit offset (2 bytes)
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: itableswitch -- access jump table by int index
    # Source: [JCVM 3.0.5, s7.5.66 itableswitch](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=193)
    # Source: [JCVM 3.1, s7.5.66 itableswitch](../../../3.1/JCVMSpec_3.1.pdf#page=213)
    # Source: [JCVM 3.2, s7.5.66 itableswitch](../../../3.2/JCVMSpec_3.2.pdf#page=213)
    Given the instruction "itableswitch" with opcode 116 (0x74)
    And format: itableswitch, defaultbyte1, defaultbyte2, lowbyte1-4, highbyte1-4, jump offsets...
    Then the operand stack shall transition: ..., index -> ...
    And index must be of type int
    And low and high are signed 32-bit values; the jump table has (high - low + 1) signed 16-bit offsets
    And this instruction is unavailable if the VM does not support the int data type

  # ===== SUBROUTINE =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: jsr -- jump subroutine
    # Source: [JCVM 3.0.5, s7.5.69 jsr](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=195)
    # Source: [JCVM 3.1, s7.5.69 jsr](../../../3.1/JCVMSpec_3.1.pdf#page=215)
    # Source: [JCVM 3.2, s7.5.69 jsr](../../../3.2/JCVMSpec_3.2.pdf#page=215)
    Given the instruction "jsr" with opcode 113 (0x71)
    And format: jsr, branchbyte1, branchbyte2
    Then the operand stack shall transition: ... -> ..., address
    And the address of the instruction immediately following jsr is pushed as type returnAddress
    And branchoffset is (branchbyte1 << 8) | branchbyte2

  @v3.0.5 @v3.1 @v3.2
  Scenario: ret -- return from subroutine
    # Source: [JCVM 3.0.5, s7.5.79 ret](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=204)
    # Source: [JCVM 3.1, s7.5.79 ret](../../../3.1/JCVMSpec_3.1.pdf#page=224)
    # Source: [JCVM 3.2, s7.5.79 ret](../../../3.2/JCVMSpec_3.2.pdf#page=224)
    Given the instruction "ret" with opcode 114 (0x72)
    And format: ret, index
    Then the stack shall not change
    And the local variable at index must contain a value of type returnAddress
    And execution continues at the address contained in the local variable
