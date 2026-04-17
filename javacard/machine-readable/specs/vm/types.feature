@jcvm @types
Feature: JCVM Data Types and Values
  The Java Card virtual machine supports primitive types and reference types.
  The primitive data types are the numeric types, the boolean type, and the
  returnAddress type. The numeric types consist of byte (8-bit signed two's
  complement), short (16-bit signed two's complement), and optionally int
  (32-bit signed two's complement). The VM uses an abstract storage unit
  called a "word" which is large enough to hold a value of type byte, short,
  reference, or returnAddress. Two words hold a value of type int.

  # Source: [JCVM 3.0.5, s3.1 Data Types and Values](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
  # Source: [JCVM 3.1, s3.1 Data Types and Values](../../../3.1/JCVMSpec_3.1.pdf#page=46)
  # Source: [JCVM 3.2, s3.1 Data Types and Values](../../../3.2/JCVMSpec_3.2.pdf#page=46)

  Background:
    Given a Java Card virtual machine implementation

  # ---------- Primitive numeric types ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: byte type -- 8-bit signed two's complement integer
    # Source: [JCVM 3.0.5, s3.1](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
    # Source: [JCVM 3.1, s3.1](../../../3.1/JCVMSpec_3.1.pdf#page=46)
    # Source: [JCVM 3.2, s3.1](../../../3.2/JCVMSpec_3.2.pdf#page=46)
    Then the VM shall support the "byte" primitive type
    And "byte" values shall be 8-bit signed two's complement integers
    And "byte" values shall range from -128 to 127
    And "byte" shall be a storage type with computational type "short"

  @v3.0.5 @v3.1 @v3.2
  Scenario: short type -- 16-bit signed two's complement integer
    # Source: [JCVM 3.0.5, s3.1](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
    # Source: [JCVM 3.1, s3.1](../../../3.1/JCVMSpec_3.1.pdf#page=46)
    # Source: [JCVM 3.2, s3.1](../../../3.2/JCVMSpec_3.2.pdf#page=46)
    Then the VM shall support the "short" primitive type
    And "short" values shall be 16-bit signed two's complement integers
    And "short" values shall range from -32768 to 32767
    And "short" shall be both a storage type and a computational type

  @v3.0.5 @v3.1 @v3.2
  Scenario: int type -- 32-bit signed two's complement integer (optional)
    # Source: [JCVM 3.0.5, s3.1](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
    # Source: [JCVM 3.1, s3.1](../../../3.1/JCVMSpec_3.1.pdf#page=46)
    # Source: [JCVM 3.2, s3.1](../../../3.2/JCVMSpec_3.2.pdf#page=46)
    Then the VM may optionally support the "int" primitive type
    And "int" values shall be 32-bit signed two's complement integers
    And "int" shall be both a storage type and a computational type
    And a VM that does not support "int" shall reject programs that use it

  # ---------- boolean type ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: boolean type -- encoded as integer values 0 and 1
    # Source: [JCVM 3.0.5, s3.1](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
    # Source: [JCVM 3.1, s3.1](../../../3.1/JCVMSpec_3.1.pdf#page=46)
    # Source: [JCVM 3.2, s3.1](../../../3.2/JCVMSpec_3.2.pdf#page=46)
    Then the VM shall support the "boolean" type
    And the value 1 shall represent true
    And the value 0 shall represent false

  # ---------- returnAddress type ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: returnAddress type -- used by jsr/ret instructions
    # Source: [JCVM 3.0.5, s3.1](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
    # Source: [JCVM 3.1, s3.1](../../../3.1/JCVMSpec_3.1.pdf#page=46)
    # Source: [JCVM 3.2, s3.1](../../../3.2/JCVMSpec_3.2.pdf#page=46)
    Then the VM shall support the "returnAddress" primitive type
    And "returnAddress" shall be used by the jsr and ret instructions

  # ---------- reference type ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: reference type -- pointers to dynamically created objects
    # Source: [JCVM 3.0.5, s3.1](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
    # Source: [JCVM 3.1, s3.1](../../../3.1/JCVMSpec_3.1.pdf#page=46)
    # Source: [JCVM 3.2, s3.1](../../../3.2/JCVMSpec_3.2.pdf#page=46)
    Then the VM shall support "reference" types
    And reference support shall be identical to the Java virtual machine

  # ---------- Words ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: word -- abstract storage unit for one-word values
    # Source: [JCVM 3.0.5, s3.2 Words](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=46)
    # Source: [JCVM 3.1, s3.2 Words](../../../3.1/JCVMSpec_3.1.pdf#page=46)
    # Source: [JCVM 3.2, s3.2 Words](../../../3.2/JCVMSpec_3.2.pdf#page=46)
    Then the VM shall define an abstract storage unit called a "word"
    And a word shall be large enough to hold a value of type byte, short, reference, or returnAddress
    And two words shall be large enough to hold a value of type int
    And the actual size in bits of a word shall be platform-specific

  # ---------- Storage types and computational types ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: storage type byte maps to computational type short
    # Source: [JCVM 3.0.5, s3.10.1 Table 3-2](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=50)
    # Source: [JCVM 3.1, s3.10.1 Table 3-2](../../../3.1/JCVMSpec_3.1.pdf#page=50)
    # Source: [JCVM 3.2, s3.10.1 Table 3-2](../../../3.2/JCVMSpec_3.2.pdf#page=50)
    Given the storage type "byte" with size 8 bits
    Then its computational type shall be "short"

  @v3.0.5 @v3.1 @v3.2
  Scenario: storage type short maps to computational type short
    # Source: [JCVM 3.0.5, s3.10.1 Table 3-2](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=50)
    # Source: [JCVM 3.1, s3.10.1 Table 3-2](../../../3.1/JCVMSpec_3.1.pdf#page=50)
    # Source: [JCVM 3.2, s3.10.1 Table 3-2](../../../3.2/JCVMSpec_3.2.pdf#page=50)
    Given the storage type "short" with size 16 bits
    Then its computational type shall be "short"

  @v3.0.5 @v3.1 @v3.2
  Scenario: storage type int maps to computational type int
    # Source: [JCVM 3.0.5, s3.10.1 Table 3-2](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=50)
    # Source: [JCVM 3.1, s3.10.1 Table 3-2](../../../3.1/JCVMSpec_3.1.pdf#page=50)
    # Source: [JCVM 3.2, s3.10.1 Table 3-2](../../../3.2/JCVMSpec_3.2.pdf#page=50)
    Given the storage type "int" with size 32 bits
    Then its computational type shall be "int"

  # ---------- Runtime data areas ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: single thread of execution
    # Source: [JCVM 3.0.5, s3.3 Runtime Data Areas](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=47)
    # Source: [JCVM 3.1, s3.3 Runtime Data Areas](../../../3.1/JCVMSpec_3.1.pdf#page=47)
    # Source: [JCVM 3.2, s3.3 Runtime Data Areas](../../../3.2/JCVMSpec_3.2.pdf#page=47)
    Then the VM shall support only a single thread of execution
    And per-thread runtime data areas in the JVM shall have only one global copy

  @v3.0.5 @v3.1 @v3.2
  Scenario: heap is not required to be garbage collected
    # Source: [JCVM 3.0.5, s3.3](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=47)
    # Source: [JCVM 3.1, s3.3](../../../3.1/JCVMSpec_3.1.pdf#page=47)
    # Source: [JCVM 3.2, s3.3](../../../3.2/JCVMSpec_3.2.pdf#page=47)
    Then the VM heap is not required to be garbage collected
    And objects allocated from the heap will not necessarily be reclaimed

  # ---------- Frames ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: stack frames contain local variables, operand stack, and constant pool reference
    # Source: [JCVM 3.0.5, s3.5 Frames](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=47)
    # Source: [JCVM 3.1, s3.5 Frames](../../../3.1/JCVMSpec_3.1.pdf#page=47)
    # Source: [JCVM 3.2, s3.5 Frames](../../../3.2/JCVMSpec_3.2.pdf#page=47)
    Then each frame shall have a set of local variables
    And each frame shall have an operand stack
    And each frame shall contain a reference to the constant pool of the current class's package
    And each frame shall include a reference to the context in which the current method is executing

  # ---------- Instruction set summary ----------

  @v3.0.5 @v3.1 @v3.2
  Scenario: instructions are one-byte opcode plus zero or more operands
    # Source: [JCVM 3.0.5, s3.10](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=48)
    # Source: [JCVM 3.1, s3.10](../../../3.1/JCVMSpec_3.1.pdf#page=48)
    # Source: [JCVM 3.2, s3.10](../../../3.2/JCVMSpec_3.2.pdf#page=48)
    Then individual instructions shall consist of a one-byte opcode and zero or more operands
    And multi-byte operand data shall be encoded in big-endian order

  @v3.0.5 @v3.1 @v3.2
  Scenario: no direct byte-type arithmetic instructions
    # Source: [JCVM 3.0.5, s3.10.1 Table 3-1](../../../3.0.5/JCVMSpec_3.0.5.pdf#page=49)
    # Source: [JCVM 3.1, s3.10.1 Table 3-1](../../../3.1/JCVMSpec_3.1.pdf#page=49)
    # Source: [JCVM 3.2, s3.10.1 Table 3-1](../../../3.2/JCVMSpec_3.2.pdf#page=49)
    Then there shall be no load instruction for type byte
    And there shall be no store instruction for type byte
    And there shall be no add, sub, mul, div, rem, or neg instruction for type byte
    And byte values shall be operated upon using short-type instructions after sign-extension
