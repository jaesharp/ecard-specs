@jcvm
@bytecodes
@array
Feature: JCVM Array Operation Bytecodes
  The Java Card virtual machine provides instructions for creating arrays,
  querying array length, and loading/storing elements from/to arrays of
  byte/boolean, short, int, and reference types.

  # Source: [JCVM 3.0.5, s7.5 Instruction Set](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=140)
  # Source: [JCVM 3.1, s7.5 Instruction Set](../.refs/3.1/JCVMSpec_3.1.pdf#page=159)
  # Source: [JCVM 3.2, s7.5 Instruction Set](../.refs/3.2/JCVMSpec_3.2.pdf#page=159)
  Background:
    Given a Java Card virtual machine implementation

  # ===== ARRAY CREATION =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: newarray -- create new array of primitive type
    # Source: [JCVM 3.0.5, s7.5.71 newarray](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=196)
    # Source: [JCVM 3.1, s7.5.71 newarray](../.refs/3.1/JCVMSpec_3.1.pdf#page=216)
    # Source: [JCVM 3.2, s7.5.71 newarray](../.refs/3.2/JCVMSpec_3.2.pdf#page=216)
    Given the instruction "newarray" with opcode 144 (0x90)
    And format: newarray, atype
    Then the operand stack shall transition: ..., count -> ..., arrayref
    And count must be of type short representing the number of elements
    And atype indicates the primitive component type: 10=T_BOOLEAN, 11=T_BYTE, 12=T_SHORT, 13=T_INT
    And all elements shall be initialized to the default value for the type
    And if count is less than zero, a NegativeArraySizeException shall be thrown
    And if the VM does not support int, atype may not be 13 (T_INT)

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: anewarray -- create new array of reference type
    # Source: [JCVM 3.0.5, s7.5.6 anewarray](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=146)
    # Source: [JCVM 3.1, s7.5.6 anewarray](../.refs/3.1/JCVMSpec_3.1.pdf#page=165)
    # Source: [JCVM 3.2, s7.5.6 anewarray](../.refs/3.2/JCVMSpec_3.2.pdf#page=165)
    Given the instruction "anewarray" with opcode 145 (0x91)
    And format: anewarray, indexbyte1, indexbyte2
    Then the operand stack shall transition: ..., count -> ..., arrayref
    And count must be of type short
    And the constant pool entry at (indexbyte1 << 8) | indexbyte2 must be CONSTANT_Classref
    And all components shall be initialized to null
    And if count is less than zero, a NegativeArraySizeException shall be thrown

  # ===== ARRAY LENGTH =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: arraylength -- get length of array
    # Source: [JCVM 3.0.5, s7.5.8 arraylength](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=147)
    # Source: [JCVM 3.1, s7.5.8 arraylength](../.refs/3.1/JCVMSpec_3.1.pdf#page=166)
    # Source: [JCVM 3.2, s7.5.8 arraylength](../.refs/3.2/JCVMSpec_3.2.pdf#page=166)
    Given the instruction "arraylength" with opcode 146 (0x92)
    And format: arraylength
    Then the operand stack shall transition: ..., arrayref -> ..., length
    And arrayref must be of type reference and must refer to an array
    And the length shall be pushed as a short
    And if arrayref is null, a NullPointerException shall be thrown

  # ===== BYTE/BOOLEAN ARRAY LOAD/STORE =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: baload -- load byte or boolean from array
    # Source: [JCVM 3.0.5, s7.5.12 baload](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=150)
    # Source: [JCVM 3.1, s7.5.12 baload](../.refs/3.1/JCVMSpec_3.1.pdf#page=169)
    # Source: [JCVM 3.2, s7.5.12 baload](../.refs/3.2/JCVMSpec_3.2.pdf#page=169)
    Given the instruction "baload" with opcode 37 (0x25)
    And format: baload
    Then the operand stack shall transition: ..., arrayref, index -> ..., value
    And arrayref must refer to an array of byte or boolean components
    And index must be of type short
    And the byte value shall be sign-extended to a short before pushing
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: bastore -- store into byte or boolean array
    # Source: [JCVM 3.0.5, s7.5.13 bastore](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=151)
    # Source: [JCVM 3.1, s7.5.13 bastore](../.refs/3.1/JCVMSpec_3.1.pdf#page=169)
    # Source: [JCVM 3.2, s7.5.13 bastore](../.refs/3.2/JCVMSpec_3.2.pdf#page=169)
    Given the instruction "bastore" with opcode 56 (0x38)
    And format: bastore
    Then the operand stack shall transition: ..., arrayref, index, value -> ...
    And the short value shall be truncated to a byte before storing
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown

  # ===== SHORT ARRAY LOAD/STORE =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: saload -- load short from array
    # Source: [JCVM 3.0.5, s7.5.84 saload](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=207)
    # Source: [JCVM 3.1, s7.5.84 saload](../.refs/3.1/JCVMSpec_3.1.pdf#page=227)
    # Source: [JCVM 3.2, s7.5.84 saload](../.refs/3.2/JCVMSpec_3.2.pdf#page=227)
    Given the instruction "saload" with opcode 38 (0x26)
    And format: saload
    Then the operand stack shall transition: ..., arrayref, index -> ..., value
    And arrayref must refer to an array of short components
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: sastore -- store into short array
    # Source: [JCVM 3.0.5, s7.5.86 sastore](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=208)
    # Source: [JCVM 3.1, s7.5.86 sastore](../.refs/3.1/JCVMSpec_3.1.pdf#page=228)
    # Source: [JCVM 3.2, s7.5.86 sastore](../.refs/3.2/JCVMSpec_3.2.pdf#page=228)
    Given the instruction "sastore" with opcode 57 (0x39)
    And format: sastore
    Then the operand stack shall transition: ..., arrayref, index, value -> ...
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown

  # ===== REFERENCE ARRAY LOAD/STORE =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: aaload -- load reference from array
    # Source: [JCVM 3.0.5, s7.5.1 aaload](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=142)
    # Source: [JCVM 3.1, s7.5.1 aaload](../.refs/3.1/JCVMSpec_3.1.pdf#page=160)
    # Source: [JCVM 3.2, s7.5.1 aaload](../.refs/3.2/JCVMSpec_3.2.pdf#page=160)
    Given the instruction "aaload" with opcode 36 (0x24)
    And format: aaload
    Then the operand stack shall transition: ..., arrayref, index -> ..., value
    And arrayref must refer to an array whose components are of type reference
    And index must be of type short
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: aastore -- store into reference array
    # Source: [JCVM 3.0.5, s7.5.2 aastore](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=143)
    # Source: [JCVM 3.1, s7.5.2 aastore](../.refs/3.1/JCVMSpec_3.1.pdf#page=161)
    # Source: [JCVM 3.2, s7.5.2 aastore](../.refs/3.2/JCVMSpec_3.2.pdf#page=161)
    Given the instruction "aastore" with opcode 55 (0x37)
    And format: aastore
    Then the operand stack shall transition: ..., arrayref, index, value -> ...
    And the type of value must be assignment compatible with the component type of the array
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown
    And if value is not assignment compatible, an ArrayStoreException shall be thrown

  # ===== INT ARRAY LOAD/STORE =====
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: iaload -- load int from array
    # Source: [JCVM 3.0.5, s7.5.29 iaload](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=164)
    # Source: [JCVM 3.1, s7.5.29 iaload](../.refs/3.1/JCVMSpec_3.1.pdf#page=183)
    # Source: [JCVM 3.2, s7.5.29 iaload](../.refs/3.2/JCVMSpec_3.2.pdf#page=183)
    Given the instruction "iaload" with opcode 39 (0x27)
    And format: iaload
    Then the operand stack shall transition: ..., arrayref, index -> ..., value.word1, value.word2
    And arrayref must refer to an array of int components
    And index must be of type short
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown
    And this instruction is unavailable if the VM does not support the int data type

  @v3.0.5
  @v3.1
  @v3.2
  Scenario: iastore -- store into int array
    # Source: [JCVM 3.0.5, s7.5.31 iastore](../.refs/3.0.5/JCVMSpec_3.0.5.pdf#page=166)
    # Source: [JCVM 3.1, s7.5.31 iastore](../.refs/3.1/JCVMSpec_3.1.pdf#page=184)
    # Source: [JCVM 3.2, s7.5.31 iastore](../.refs/3.2/JCVMSpec_3.2.pdf#page=184)
    Given the instruction "iastore" with opcode 58 (0x3a)
    And format: iastore
    Then the operand stack shall transition: ..., arrayref, index, value.word1, value.word2 -> ...
    And if arrayref is null, a NullPointerException shall be thrown
    And if index is out of bounds, an ArrayIndexOutOfBoundsException shall be thrown
    And this instruction is unavailable if the VM does not support the int data type
