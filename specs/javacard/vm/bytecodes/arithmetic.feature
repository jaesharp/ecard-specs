@jcvm
@bytecodes
@arithmetic
Feature: JCVM Arithmetic Bytecodes
  The Java Card virtual machine provides arithmetic instructions for short
  and (optionally) int types. There are no byte-specific arithmetic
  instructions; byte values are operated on using short instructions after
  sign-extension. All int-type instructions are unavailable if the VM does
  not support the int data type.

  # Source: [JCVM 3.0.5, s7.5 Instruction Set](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=140)
  # Source: [JCVM 3.1, s7.5 Instruction Set](../../refs/3.1/JCVMSpec_3.1.pdf#page=159)
  # Source: [JCVM 3.2, s7.5 Instruction Set](../../refs/3.2/JCVMSpec_3.2.pdf#page=159)
  Background:
    Given a Java Card virtual machine implementation

  # ===== SHORT ARITHMETIC =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sadd -- add short
    # Source: [JCVM 3.0.5, s7.5.83 sadd](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=206)
    # Source: [JCVM 3.1, s7.5.83 sadd](../../refs/3.1/JCVMSpec_3.1.pdf#page=226)
    # Source: [JCVM 3.2, s7.5.83 sadd](../../refs/3.2/JCVMSpec_3.2.pdf#page=226)
    Given the instruction "sadd" with opcode 65 (0x41)
    And format: sadd
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And both value1 and value2 must be of type short
    And the result shall be value1 + value2
    And on overflow the result shall be the low-order bits of the true mathematical result

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ssub -- subtract short
    # Source: [JCVM 3.0.5, s7.5.105 ssub](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=219)
    # Source: [JCVM 3.1, s7.5.105 ssub](../../refs/3.1/JCVMSpec_3.1.pdf#page=239)
    # Source: [JCVM 3.2, s7.5.105 ssub](../../refs/3.2/JCVMSpec_3.2.pdf#page=239)
    Given the instruction "ssub" with opcode 67 (0x43)
    And format: ssub
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And both value1 and value2 must be of type short
    And the result shall be value1 - value2
    And no runtime exception shall be thrown on overflow or underflow

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: smul -- multiply short
    # Source: [JCVM 3.0.5, s7.5.95 smul](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=214)
    # Source: [JCVM 3.1, s7.5.95 smul](../../refs/3.1/JCVMSpec_3.1.pdf#page=234)
    # Source: [JCVM 3.2, s7.5.95 smul](../../refs/3.2/JCVMSpec_3.2.pdf#page=234)
    Given the instruction "smul" with opcode 69 (0x45)
    And format: smul
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And both value1 and value2 must be of type short
    And the result shall be value1 * value2
    And on overflow the result shall be the low-order bits of the mathematical product

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sdiv -- divide short
    # Source: [JCVM 3.0.5, s7.5.88 sdiv](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=209)
    # Source: [JCVM 3.1, s7.5.88 sdiv](../../refs/3.1/JCVMSpec_3.1.pdf#page=229)
    # Source: [JCVM 3.2, s7.5.88 sdiv](../../refs/3.2/JCVMSpec_3.2.pdf#page=229)
    Given the instruction "sdiv" with opcode 71 (0x47)
    And format: sdiv
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And both value1 and value2 must be of type short
    And the result shall be value1 / value2 rounded towards zero
    And if value2 is 0 then an ArithmeticException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: srem -- remainder short
    # Source: [JCVM 3.0.5, s7.5.98 srem](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=215)
    # Source: [JCVM 3.1, s7.5.98 srem](../../refs/3.1/JCVMSpec_3.1.pdf#page=235)
    # Source: [JCVM 3.2, s7.5.98 srem](../../refs/3.2/JCVMSpec_3.2.pdf#page=235)
    Given the instruction "srem" with opcode 73 (0x49)
    And format: srem
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And both value1 and value2 must be of type short
    And the result shall be value1 - (value1 / value2) * value2
    And if value2 is 0 then an ArithmeticException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sneg -- negate short
    # Source: [JCVM 3.0.5, s7.5.96 sneg](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=214)
    # Source: [JCVM 3.1, s7.5.96 sneg](../../refs/3.1/JCVMSpec_3.1.pdf#page=234)
    # Source: [JCVM 3.2, s7.5.96 sneg](../../refs/3.2/JCVMSpec_3.2.pdf#page=234)
    Given the instruction "sneg" with opcode 72 (0x4b)
    And format: sneg
    Then the operand stack shall transition: ..., value -> ..., result
    And value must be of type short
    And the result shall be the arithmetic negation of value (-value)
    And for all short values x, -x equals (~x) + 1

  # ===== SHORT BITWISE =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sand -- boolean AND short
    # Source: [JCVM 3.0.5, s7.5.85 sand](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=207)
    # Source: [JCVM 3.1, s7.5.85 sand](../../refs/3.1/JCVMSpec_3.1.pdf#page=228)
    # Source: [JCVM 3.2, s7.5.85 sand](../../refs/3.2/JCVMSpec_3.2.pdf#page=228)
    Given the instruction "sand" with opcode 83 (0x53)
    And format: sand
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And the result shall be the bitwise AND of value1 and value2

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sor -- boolean OR short
    # Source: [JCVM 3.0.5, s7.5.97 sor](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=215)
    # Source: [JCVM 3.1, s7.5.97 sor](../../refs/3.1/JCVMSpec_3.1.pdf#page=235)
    # Source: [JCVM 3.2, s7.5.97 sor](../../refs/3.2/JCVMSpec_3.2.pdf#page=235)
    Given the instruction "sor" with opcode 85 (0x55)
    And format: sor
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And the result shall be the bitwise inclusive OR of value1 and value2

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sxor -- boolean XOR short
    # Source: [JCVM 3.0.5, s7.5.109 sxor](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=222)
    # Source: [JCVM 3.1, s7.5.109 sxor](../../refs/3.1/JCVMSpec_3.1.pdf#page=242)
    # Source: [JCVM 3.2, s7.5.109 sxor](../../refs/3.2/JCVMSpec_3.2.pdf#page=242)
    Given the instruction "sxor" with opcode 87 (0x57)
    And format: sxor
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And the result shall be the bitwise exclusive OR of value1 and value2

  # ===== SHORT SHIFT =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sshl -- shift left short
    # Source: [JCVM 3.0.5, s7.5.100 sshl](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=216)
    # Source: [JCVM 3.1, s7.5.100 sshl](../../refs/3.1/JCVMSpec_3.1.pdf#page=236)
    # Source: [JCVM 3.2, s7.5.100 sshl](../../refs/3.2/JCVMSpec_3.2.pdf#page=236)
    Given the instruction "sshl" with opcode 77 (0x4d)
    And format: sshl
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And both value1 and value2 must be of type short
    And the result shall be value1 shifted left by s bit positions where s is the low five bits of value2
    And the shift distance shall always be in the range 0 to 31 inclusive (value2 AND 0x1f)

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sshr -- arithmetic shift right short
    # Source: [JCVM 3.0.5, s7.5.101 sshr](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=217)
    # Source: [JCVM 3.1, s7.5.101 sshr](../../refs/3.1/JCVMSpec_3.1.pdf#page=237)
    # Source: [JCVM 3.2, s7.5.101 sshr](../../refs/3.2/JCVMSpec_3.2.pdf#page=237)
    Given the instruction "sshr" with opcode 79 (0x4f)
    And format: sshr
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And the result shall be value1 arithmetically shifted right by s positions with sign extension
    And s shall be the low five bits of value2 (value2 AND 0x1f)

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sushr -- logical shift right short
    # Source: [JCVM 3.0.5, s7.5.107 sushr](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=221)
    # Source: [JCVM 3.1, s7.5.107 sushr](../../refs/3.1/JCVMSpec_3.1.pdf#page=241)
    # Source: [JCVM 3.2, s7.5.107 sushr](../../refs/3.2/JCVMSpec_3.2.pdf#page=241)
    Given the instruction "sushr" with opcode 81 (0x51)
    And format: sushr
    Then the operand stack shall transition: ..., value1, value2 -> ..., result
    And value1 shall be sign-extended to 32 bits before shifting right by s positions with zero extension
    And s shall be the low five bits of value2 (value2 AND 0x1f)
    And the result shall be truncated to a 16-bit short

  # ===== INT ARITHMETIC =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: iadd -- add int
    # Source: [JCVM 3.0.5, s7.5.28 iadd](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=164)
    # Source: [JCVM 3.1, s7.5.28 iadd](../../refs/3.1/JCVMSpec_3.1.pdf#page=182)
    # Source: [JCVM 3.2, s7.5.28 iadd](../../refs/3.2/JCVMSpec_3.2.pdf#page=182)
    Given the instruction "iadd" with opcode 66 (0x42)
    And format: iadd
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And both value1 and value2 must be of type int
    And the result shall be value1 + value2
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: isub -- subtract int
    # Source: [JCVM 3.0.5, s7.5.65 isub](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=192)
    # Source: [JCVM 3.1, s7.5.65 isub](../../refs/3.1/JCVMSpec_3.1.pdf#page=212)
    # Source: [JCVM 3.2, s7.5.65 isub](../../refs/3.2/JCVMSpec_3.2.pdf#page=212)
    Given the instruction "isub" with opcode 68 (0x44)
    And format: isub
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be value1 - value2
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: imul -- multiply int
    # Source: [JCVM 3.0.5, s7.5.51 imul](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=180)
    # Source: [JCVM 3.1, s7.5.51 imul](../../refs/3.1/JCVMSpec_3.1.pdf#page=198)
    # Source: [JCVM 3.2, s7.5.51 imul](../../refs/3.2/JCVMSpec_3.2.pdf#page=198)
    Given the instruction "imul" with opcode 70 (0x46)
    And format: imul
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be value1 * value2
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: idiv -- divide int
    # Source: [JCVM 3.0.5, s7.5.34 idiv](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=168)
    # Source: [JCVM 3.1, s7.5.34 idiv](../../refs/3.1/JCVMSpec_3.1.pdf#page=186)
    # Source: [JCVM 3.2, s7.5.34 idiv](../../refs/3.2/JCVMSpec_3.2.pdf#page=186)
    Given the instruction "idiv" with opcode 72 (0x48)
    And format: idiv
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be value1 / value2 rounded towards zero
    And if value2 is 0 then an ArithmeticException shall be thrown
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: irem -- remainder int
    # Source: [JCVM 3.0.5, s7.5.59 irem](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=188)
    # Source: [JCVM 3.1, s7.5.59 irem](../../refs/3.1/JCVMSpec_3.1.pdf#page=208)
    # Source: [JCVM 3.2, s7.5.59 irem](../../refs/3.2/JCVMSpec_3.2.pdf#page=208)
    Given the instruction "irem" with opcode 74 (0x4a)
    And format: irem
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be value1 - (value1 / value2) * value2
    And if value2 is 0 then an ArithmeticException shall be thrown
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ineg -- negate int
    # Source: [JCVM 3.0.5, s7.5.52 ineg](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=181)
    # Source: [JCVM 3.1, s7.5.52 ineg](../../refs/3.1/JCVMSpec_3.1.pdf#page=199)
    # Source: [JCVM 3.2, s7.5.52 ineg](../../refs/3.2/JCVMSpec_3.2.pdf#page=199)
    Given the instruction "ineg" with opcode 76 (0x4c)
    And format: ineg
    Then the operand stack shall transition: ..., value.word1, value.word2 -> ..., result.word1, result.word2
    And value must be of type int
    And the result shall be the arithmetic negation of value (-value)
    And for all int values x, -x equals (~x) + 1
    And this instruction is unavailable if the VM does not support the int data type

  # ===== INT BITWISE =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: iand -- boolean AND int
    # Source: [JCVM 3.0.5, s7.5.30 iand](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=165)
    # Source: [JCVM 3.1, s7.5.30 iand](../../refs/3.1/JCVMSpec_3.1.pdf#page=184)
    # Source: [JCVM 3.2, s7.5.30 iand](../../refs/3.2/JCVMSpec_3.2.pdf#page=184)
    Given the instruction "iand" with opcode 84 (0x54)
    And format: iand
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be the bitwise AND of value1 and value2
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ior -- boolean OR int
    # Source: [JCVM 3.0.5, s7.5.58 ior](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=188)
    # Source: [JCVM 3.1, s7.5.58 ior](../../refs/3.1/JCVMSpec_3.1.pdf#page=208)
    # Source: [JCVM 3.2, s7.5.58 ior](../../refs/3.2/JCVMSpec_3.2.pdf#page=208)
    Given the instruction "ior" with opcode 86 (0x56)
    And format: ior
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be the bitwise inclusive OR of value1 and value2
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ixor -- boolean XOR int
    # Source: [JCVM 3.0.5, s7.5.68 ixor](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=194)
    # Source: [JCVM 3.1, s7.5.68 ixor](../../refs/3.1/JCVMSpec_3.1.pdf#page=214)
    # Source: [JCVM 3.2, s7.5.68 ixor](../../refs/3.2/JCVMSpec_3.2.pdf#page=214)
    Given the instruction "ixor" with opcode 88 (0x58)
    And format: ixor
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be the bitwise exclusive OR of value1 and value2
    And this instruction is unavailable if the VM does not support the int data type

  # ===== INT SHIFT =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ishl -- shift left int
    # Source: [JCVM 3.0.5, s7.5.61 ishl](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=190)
    # Source: [JCVM 3.1, s7.5.61 ishl](../../refs/3.1/JCVMSpec_3.1.pdf#page=210)
    # Source: [JCVM 3.2, s7.5.61 ishl](../../refs/3.2/JCVMSpec_3.2.pdf#page=210)
    Given the instruction "ishl" with opcode 78 (0x4e)
    And format: ishl
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be value1 shifted left by s positions where s is the low five bits of value2
    And the shift distance shall always be in the range 0 to 31 inclusive (value2 AND 0x1f)
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ishr -- arithmetic shift right int
    # Source: [JCVM 3.0.5, s7.5.62 ishr](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=190)
    # Source: [JCVM 3.1, s7.5.62 ishr](../../refs/3.1/JCVMSpec_3.1.pdf#page=210)
    # Source: [JCVM 3.2, s7.5.62 ishr](../../refs/3.2/JCVMSpec_3.2.pdf#page=210)
    Given the instruction "ishr" with opcode 80 (0x50)
    And format: ishr
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be value1 arithmetically shifted right by s positions with sign extension
    And s shall be the low five bits of value2 (value2 AND 0x1f)
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: iushr -- logical shift right int
    # Source: [JCVM 3.0.5, s7.5.67 iushr](../../refs/3.0.5/JCVMSpec_3.0.5.pdf#page=194)
    # Source: [JCVM 3.1, s7.5.67 iushr](../../refs/3.1/JCVMSpec_3.1.pdf#page=214)
    # Source: [JCVM 3.2, s7.5.67 iushr](../../refs/3.2/JCVMSpec_3.2.pdf#page=214)
    Given the instruction "iushr" with opcode 82 (0x52)
    And format: iushr
    Then the operand stack shall transition: ..., value1.word1, value1.word2, value2.word1, value2.word2 -> ..., result.word1, result.word2
    And the result shall be value1 logically shifted right by s positions with zero extension
    And s shall be the low five bits of value2 (value2 AND 0x1f)
    And this instruction is unavailable if the VM does not support the int data type
