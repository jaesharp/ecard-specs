@jcvm @bytecodes @stack
Feature: JCVM Stack Manipulation Bytecodes
  The Java Card virtual machine provides instructions for pushing constants,
  loading and storing values between local variables and the operand stack,
  and manipulating the operand stack directly (dup, pop, swap).

  # Source: [JCVM 3.0.5, s7.5 Instruction Set](../3.0.5/JCVMSpec_3.0.5.pdf#page=140)
  # Source: [JCVM 3.1, s7.5 Instruction Set](../3.1/JCVMSpec_3.1.pdf#page=159)
  # Source: [JCVM 3.2, s7.5 Instruction Set](../3.2/JCVMSpec_3.2.pdf#page=159)

  Background:
    Given a Java Card virtual machine implementation

  # ===== SHORT CONSTANTS =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: sconst_m1 through sconst_5 -- push short constant
    # Source: [JCVM 3.0.5, s7.5.87 sconst_<s>](../3.0.5/JCVMSpec_3.0.5.pdf#page=209)
    # Source: [JCVM 3.1, s7.5.87 sconst_<s>](../3.1/JCVMSpec_3.1.pdf#page=229)
    # Source: [JCVM 3.2, s7.5.87 sconst_<s>](../3.2/JCVMSpec_3.2.pdf#page=229)
    Given the instruction family "sconst_<s>"
    And forms: sconst_m1 = 2 (0x2), sconst_0 = 3 (0x3), sconst_1 = 4 (0x4), sconst_2 = 5 (0x5), sconst_3 = 6 (0x6), sconst_4 = 7 (0x7), sconst_5 = 8 (0x8)
    Then the operand stack shall transition: ... -> ..., <s>
    And the short constant <s> (-1, 0, 1, 2, 3, 4, or 5) shall be pushed onto the operand stack

  # ===== INT CONSTANTS =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: iconst_m1 through iconst_5 -- push int constant
    # Source: [JCVM 3.0.5, s7.5.33 iconst_<i>](../3.0.5/JCVMSpec_3.0.5.pdf#page=167)
    # Source: [JCVM 3.1, s7.5.33 iconst_<i>](../3.1/JCVMSpec_3.1.pdf#page=186)
    # Source: [JCVM 3.2, s7.5.33 iconst_<i>](../3.2/JCVMSpec_3.2.pdf#page=186)
    Given the instruction family "iconst_<i>"
    And forms: iconst_m1 = 10 (0x9), iconst_0 = 11 (0xa), iconst_1 = 12 (0xb), iconst_2 = 13 (0xc), iconst_3 = 14 (0xd), iconst_4 = 15 (0xe), iconst_5 = 16 (0xf)
    Then the operand stack shall transition: ... -> ..., <i>.word1, <i>.word2
    And the int constant <i> (-1, 0, 1, 2, 3, 4, or 5) shall be pushed as two words
    And this instruction is unavailable if the VM does not support the int data type

  # ===== NULL CONSTANT =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: aconst_null -- push null reference
    # Source: [JCVM 3.0.5, s7.5.3 aconst_null](../3.0.5/JCVMSpec_3.0.5.pdf#page=145)
    # Source: [JCVM 3.1, s7.5.3 aconst_null](../3.1/JCVMSpec_3.1.pdf#page=163)
    # Source: [JCVM 3.2, s7.5.3 aconst_null](../3.2/JCVMSpec_3.2.pdf#page=163)
    Given the instruction "aconst_null" with opcode 1 (0x1)
    And format: aconst_null
    Then the operand stack shall transition: ... -> ..., null
    And the null object reference shall be pushed onto the operand stack

  # ===== PUSH BYTE/SHORT/INT =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: bspush -- push byte as short
    # Source: [JCVM 3.0.5, s7.5.15 bspush](../3.0.5/JCVMSpec_3.0.5.pdf#page=152)
    # Source: [JCVM 3.1, s7.5.15 bspush](../3.1/JCVMSpec_3.1.pdf#page=171)
    # Source: [JCVM 3.2, s7.5.15 bspush](../3.2/JCVMSpec_3.2.pdf#page=171)
    Given the instruction "bspush" with opcode 16 (0x10)
    And format: bspush, byte
    Then the operand stack shall transition: ... -> ..., value
    And the immediate byte shall be sign-extended to a short and pushed

  @v3.0.5 @v3.1 @v3.2
  Scenario: bipush -- push byte as int
    # Source: [JCVM 3.0.5, s7.5.14 bipush](../3.0.5/JCVMSpec_3.0.5.pdf#page=152)
    # Source: [JCVM 3.1, s7.5.14 bipush](../3.1/JCVMSpec_3.1.pdf#page=170)
    # Source: [JCVM 3.2, s7.5.14 bipush](../3.2/JCVMSpec_3.2.pdf#page=170)
    Given the instruction "bipush" with opcode 18 (0x12)
    And format: bipush, byte
    Then the operand stack shall transition: ... -> ..., value.word1, value.word2
    And the immediate byte shall be sign-extended to an int and pushed
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: sspush -- push short
    # Source: [JCVM 3.0.5, s7.5.102 sspush](../3.0.5/JCVMSpec_3.0.5.pdf#page=218)
    # Source: [JCVM 3.1, s7.5.102 sspush](../3.1/JCVMSpec_3.1.pdf#page=238)
    # Source: [JCVM 3.2, s7.5.102 sspush](../3.2/JCVMSpec_3.2.pdf#page=238)
    Given the instruction "sspush" with opcode 17 (0x11)
    And format: sspush, byte1, byte2
    Then the operand stack shall transition: ... -> ..., value
    And the two bytes shall be assembled into a signed short (byte1 << 8) | byte2

  @v3.0.5 @v3.1 @v3.2
  Scenario: sipush -- push short as int
    # Source: [JCVM 3.0.5, s7.5.91 sipush](../3.0.5/JCVMSpec_3.0.5.pdf#page=211)
    # Source: [JCVM 3.1, s7.5.91 sipush](../3.1/JCVMSpec_3.1.pdf#page=231)
    # Source: [JCVM 3.2, s7.5.91 sipush](../3.2/JCVMSpec_3.2.pdf#page=231)
    Given the instruction "sipush" with opcode 19 (0x13)
    And format: sipush, byte1, byte2
    Then the operand stack shall transition: ... -> ..., value.word1, value.word2
    And the two bytes shall be assembled into a signed short then sign-extended to an int
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: iipush -- push int
    # Source: [JCVM 3.0.5, s7.5.47 iipush](../3.0.5/JCVMSpec_3.0.5.pdf#page=177)
    # Source: [JCVM 3.1, s7.5.47 iipush](../3.1/JCVMSpec_3.1.pdf#page=195)
    # Source: [JCVM 3.2, s7.5.47 iipush](../3.2/JCVMSpec_3.2.pdf#page=195)
    Given the instruction "iipush" with opcode 20 (0x14)
    And format: iipush, byte1, byte2, byte3, byte4
    Then the operand stack shall transition: ... -> ..., value.word1, value.word2
    And the four bytes shall be assembled into a signed int (byte1 << 24) | (byte2 << 16) | (byte3 << 8) | byte4
    And this instruction is unavailable if the VM does not support the int data type

  # ===== SHORT LOAD/STORE =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: sload -- load short from local variable
    # Source: [JCVM 3.0.5, s7.5.92 sload](../3.0.5/JCVMSpec_3.0.5.pdf#page=212)
    # Source: [JCVM 3.1, s7.5.92 sload](../3.1/JCVMSpec_3.1.pdf#page=232)
    # Source: [JCVM 3.2, s7.5.92 sload](../3.2/JCVMSpec_3.2.pdf#page=232)
    Given the instruction "sload" with opcode 22 (0x16)
    And format: sload, index
    Then the operand stack shall transition: ... -> ..., value
    And the local variable at index shall contain a short which is pushed onto the stack

  @v3.0.5 @v3.1 @v3.2
  Scenario: sload_0 through sload_3 -- load short from local variable (short form)
    # Source: [JCVM 3.0.5, s7.5.93 sload_<n>](../3.0.5/JCVMSpec_3.0.5.pdf#page=212)
    # Source: [JCVM 3.1, s7.5.93 sload_<n>](../3.1/JCVMSpec_3.1.pdf#page=232)
    # Source: [JCVM 3.2, s7.5.93 sload_<n>](../3.2/JCVMSpec_3.2.pdf#page=232)
    Given the instruction family "sload_<n>"
    And forms: sload_0 = 28 (0x1c), sload_1 = 29 (0x1d), sload_2 = 30 (0x1e), sload_3 = 31 (0x1f)
    Then the operand stack shall transition: ... -> ..., value
    And each is the same as sload with an index of <n>, except the operand is implicit

  @v3.0.5 @v3.1 @v3.2
  Scenario: sstore -- store short into local variable
    # Source: [JCVM 3.0.5, s7.5.103 sstore](../3.0.5/JCVMSpec_3.0.5.pdf#page=218)
    # Source: [JCVM 3.1, s7.5.103 sstore](../3.1/JCVMSpec_3.1.pdf#page=238)
    # Source: [JCVM 3.2, s7.5.103 sstore](../3.2/JCVMSpec_3.2.pdf#page=238)
    Given the instruction "sstore" with opcode 41 (0x29)
    And format: sstore, index
    Then the operand stack shall transition: ..., value -> ...
    And the value on top of the operand stack must be of type short
    And it shall be stored into the local variable at index

  @v3.0.5 @v3.1 @v3.2
  Scenario: sstore_0 through sstore_3 -- store short into local variable (short form)
    # Source: [JCVM 3.0.5, s7.5.104 sstore_<n>](../3.0.5/JCVMSpec_3.0.5.pdf#page=219)
    # Source: [JCVM 3.1, s7.5.104 sstore_<n>](../3.1/JCVMSpec_3.1.pdf#page=239)
    # Source: [JCVM 3.2, s7.5.104 sstore_<n>](../3.2/JCVMSpec_3.2.pdf#page=239)
    Given the instruction family "sstore_<n>"
    And forms: sstore_0 = 47 (0x2f), sstore_1 = 48 (0x30), sstore_2 = 49 (0x31), sstore_3 = 50 (0x32)
    Then the operand stack shall transition: ..., value -> ...

  # ===== INT LOAD/STORE =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: iload -- load int from local variable
    # Source: [JCVM 3.0.5, s7.5.48 iload](../3.0.5/JCVMSpec_3.0.5.pdf#page=178)
    # Source: [JCVM 3.1, s7.5.48 iload](../3.1/JCVMSpec_3.1.pdf#page=196)
    # Source: [JCVM 3.2, s7.5.48 iload](../3.2/JCVMSpec_3.2.pdf#page=196)
    Given the instruction "iload" with opcode 23 (0x17)
    And format: iload, index
    Then the operand stack shall transition: ... -> ..., value.word1, value.word2
    And both index and index + 1 must be valid indices into the local variables
    And the local variables at index and index + 1 together must contain an int
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: iload_0 through iload_3 -- load int from local variable (short form)
    # Source: [JCVM 3.0.5, s7.5.49 iload_<n>](../3.0.5/JCVMSpec_3.0.5.pdf#page=178)
    # Source: [JCVM 3.1, s7.5.49 iload_<n>](../3.1/JCVMSpec_3.1.pdf#page=197)
    # Source: [JCVM 3.2, s7.5.49 iload_<n>](../3.2/JCVMSpec_3.2.pdf#page=197)
    Given the instruction family "iload_<n>"
    And forms: iload_0 = 32 (0x20), iload_1 = 33 (0x21), iload_2 = 34 (0x22), iload_3 = 35 (0x23)
    Then the operand stack shall transition: ... -> ..., value.word1, value.word2
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: istore -- store int into local variable
    # Source: [JCVM 3.0.5, s7.5.63 istore](../3.0.5/JCVMSpec_3.0.5.pdf#page=191)
    # Source: [JCVM 3.1, s7.5.63 istore](../3.1/JCVMSpec_3.1.pdf#page=211)
    # Source: [JCVM 3.2, s7.5.63 istore](../3.2/JCVMSpec_3.2.pdf#page=211)
    Given the instruction "istore" with opcode 42 (0x2a)
    And format: istore, index
    Then the operand stack shall transition: ..., value.word1, value.word2 -> ...
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: istore_0 through istore_3 -- store int into local variable (short form)
    # Source: [JCVM 3.0.5, s7.5.64 istore_<n>](../3.0.5/JCVMSpec_3.0.5.pdf#page=191)
    # Source: [JCVM 3.1, s7.5.64 istore_<n>](../3.1/JCVMSpec_3.1.pdf#page=211)
    # Source: [JCVM 3.2, s7.5.64 istore_<n>](../3.2/JCVMSpec_3.2.pdf#page=211)
    Given the instruction family "istore_<n>"
    And forms: istore_0 = 51 (0x33), istore_1 = 52 (0x34), istore_2 = 53 (0x35), istore_3 = 54 (0x36)
    Then the operand stack shall transition: ..., value.word1, value.word2 -> ...
    And this instruction is unavailable if the VM does not support the int data type

  # ===== REFERENCE LOAD/STORE =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: aload -- load reference from local variable
    # Source: [JCVM 3.0.5, s7.5.4 aload](../3.0.5/JCVMSpec_3.0.5.pdf#page=145)
    # Source: [JCVM 3.1, s7.5.4 aload](../3.1/JCVMSpec_3.1.pdf#page=163)
    # Source: [JCVM 3.2, s7.5.4 aload](../3.2/JCVMSpec_3.2.pdf#page=163)
    Given the instruction "aload" with opcode 21 (0x15)
    And format: aload, index
    Then the operand stack shall transition: ... -> ..., objectref
    And the local variable at index must contain a reference
    And aload cannot be used to load a value of type returnAddress

  @v3.0.5 @v3.1 @v3.2
  Scenario: aload_0 through aload_3 -- load reference from local variable (short form)
    # Source: [JCVM 3.0.5, s7.5.5 aload_<n>](../3.0.5/JCVMSpec_3.0.5.pdf#page=146)
    # Source: [JCVM 3.1, s7.5.5 aload_<n>](../3.1/JCVMSpec_3.1.pdf#page=164)
    # Source: [JCVM 3.2, s7.5.5 aload_<n>](../3.2/JCVMSpec_3.2.pdf#page=164)
    Given the instruction family "aload_<n>"
    And forms: aload_0 = 24 (0x18), aload_1 = 25 (0x19), aload_2 = 26 (0x1a), aload_3 = 27 (0x1b)
    Then the operand stack shall transition: ... -> ..., objectref

  @v3.0.5 @v3.1 @v3.2
  Scenario: astore -- store reference into local variable
    # Source: [JCVM 3.0.5, s7.5.9 astore](../3.0.5/JCVMSpec_3.0.5.pdf#page=148)
    # Source: [JCVM 3.1, s7.5.9 astore](../3.1/JCVMSpec_3.1.pdf#page=166)
    # Source: [JCVM 3.2, s7.5.9 astore](../3.2/JCVMSpec_3.2.pdf#page=166)
    Given the instruction "astore" with opcode 40 (0x28)
    And format: astore, index
    Then the operand stack shall transition: ..., objectref -> ...
    And objectref must be of type returnAddress or type reference

  @v3.0.5 @v3.1 @v3.2
  Scenario: astore_0 through astore_3 -- store reference into local variable (short form)
    # Source: [JCVM 3.0.5, s7.5.10 astore_<n>](../3.0.5/JCVMSpec_3.0.5.pdf#page=149)
    # Source: [JCVM 3.1, s7.5.10 astore_<n>](../3.1/JCVMSpec_3.1.pdf#page=167)
    # Source: [JCVM 3.2, s7.5.10 astore_<n>](../3.2/JCVMSpec_3.2.pdf#page=167)
    Given the instruction family "astore_<n>"
    And forms: astore_0 = 43 (0x2b), astore_1 = 44 (0x2c), astore_2 = 45 (0x2d), astore_3 = 46 (0x2e)
    Then the operand stack shall transition: ..., objectref -> ...

  # ===== STACK MANIPULATION =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: dup -- duplicate top operand stack word
    # Source: [JCVM 3.0.5, s7.5.17 dup](../3.0.5/JCVMSpec_3.0.5.pdf#page=155)
    # Source: [JCVM 3.1, s7.5.17 dup](../3.1/JCVMSpec_3.1.pdf#page=173)
    # Source: [JCVM 3.2, s7.5.17 dup](../3.2/JCVMSpec_3.2.pdf#page=173)
    Given the instruction "dup" with opcode 61 (0x3d)
    And format: dup
    Then the operand stack shall transition: ..., word -> ..., word, word
    And dup must not be used unless word contains a 16-bit data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: dup_x -- duplicate top operand stack words and insert below
    # Source: [JCVM 3.0.5, s7.5.18 dup_x](../3.0.5/JCVMSpec_3.0.5.pdf#page=155)
    # Source: [JCVM 3.1, s7.5.18 dup_x](../3.1/JCVMSpec_3.1.pdf#page=174)
    # Source: [JCVM 3.2, s7.5.18 dup_x](../3.2/JCVMSpec_3.2.pdf#page=174)
    Given the instruction "dup_x" with opcode 63 (0x3f)
    And format: dup_x, mn
    Then the operand stack shall transition: ..., wordN, ..., wordM, ..., word1 -> ..., wordM, ..., word1, wordN, ..., wordM, ..., word1
    And the high nibble of mn (mn & 0xf0) >> 4 gives m (1-4), the number of words to duplicate
    And the low nibble of mn (mn & 0x0f) gives n (0 to m+4), the insertion depth

  @v3.0.5 @v3.1 @v3.2
  Scenario: dup2 -- duplicate top two operand stack words
    # Source: [JCVM 3.0.5, s7.5.19 dup2](../3.0.5/JCVMSpec_3.0.5.pdf#page=156)
    # Source: [JCVM 3.1, s7.5.19 dup2](../3.1/JCVMSpec_3.1.pdf#page=175)
    # Source: [JCVM 3.2, s7.5.19 dup2](../3.2/JCVMSpec_3.2.pdf#page=175)
    Given the instruction "dup2" with opcode 62 (0x3e)
    And format: dup2
    Then the operand stack shall transition: ..., word2, word1 -> ..., word2, word1, word2, word1
    And each of word1 and word2 must be a 16-bit data type or both together the two words of a 32-bit datum

  @v3.0.5 @v3.1 @v3.2
  Scenario: pop -- pop top operand stack word
    # Source: [JCVM 3.0.5, s7.5.73 pop](../3.0.5/JCVMSpec_3.0.5.pdf#page=198)
    # Source: [JCVM 3.1, s7.5.73 pop](../3.1/JCVMSpec_3.1.pdf#page=218)
    # Source: [JCVM 3.2, s7.5.73 pop](../3.2/JCVMSpec_3.2.pdf#page=218)
    Given the instruction "pop" with opcode 59 (0x3b)
    And format: pop
    Then the operand stack shall transition: ..., word -> ...
    And pop must not be used unless the word contains a 16-bit data type

  @v3.0.5 @v3.1 @v3.2
  Scenario: pop2 -- pop top two operand stack words
    # Source: [JCVM 3.0.5, s7.5.74 pop2](../3.0.5/JCVMSpec_3.0.5.pdf#page=198)
    # Source: [JCVM 3.1, s7.5.74 pop2](../3.1/JCVMSpec_3.1.pdf#page=218)
    # Source: [JCVM 3.2, s7.5.74 pop2](../3.2/JCVMSpec_3.2.pdf#page=218)
    Given the instruction "pop2" with opcode 60 (0x3c)
    And format: pop2
    Then the operand stack shall transition: ..., word2, word1 -> ...

  @v3.0.5 @v3.1 @v3.2
  Scenario: swap_x -- swap top two operand stack words
    # Source: [JCVM 3.0.5, s7.5.108 swap_x](../3.0.5/JCVMSpec_3.0.5.pdf#page=221)
    # Source: [JCVM 3.1, s7.5.108 swap_x](../3.1/JCVMSpec_3.1.pdf#page=241)
    # Source: [JCVM 3.2, s7.5.108 swap_x](../3.2/JCVMSpec_3.2.pdf#page=241)
    Given the instruction "swap_x" with opcode 64 (0x40)
    And format: swap_x, mn
    Then the high nibble gives m and the low nibble gives n, both with permissible values 1 and 2
    And the top m words on the operand stack shall be swapped with the n words immediately below
    And if the VM does not support int, the only permissible value for both m and n is 1
