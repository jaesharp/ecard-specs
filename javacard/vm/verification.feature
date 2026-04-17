@jcvm @verification
Feature: JCVM Language and Bytecode Subset
  The Java Card platform supports a subset of the Java programming language
  and virtual machine. This chapter defines what is supported, what is
  unsupported, what is optionally supported, and the limitations imposed
  by resource-constrained hardware.

  # Source: [JCVM 3.0.5, s2 A Subset of the Java Virtual Machine](../3.0.5/JCVMSpec_3.0.5.pdf#page=27)
  # Source: [JCVM 3.1, s2 A Subset of the Java Virtual Machine](../3.1/JCVMSpec_3.1.pdf#page=27)
  # Source: [JCVM 3.2, s2 A Subset of the Java Virtual Machine](../3.2/JCVMSpec_3.2.pdf#page=27)

  Background:
    Given a Java Card platform implementation

  # ===== UNSUPPORTED FEATURES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Dynamic class loading is not supported
    # Source: [JCVM 3.0.5, s2.2.1.1.1](../3.0.5/JCVMSpec_3.0.5.pdf#page=27)
    # Source: [JCVM 3.2, s2.2.1.1.1](../3.2/JCVMSpec_3.2.pdf#page=27)
    Then the platform shall not support dynamic class loading
    And classes are either masked into the device during manufacturing or downloaded through installation

  @v3.0.5 @v3.1 @v3.2
  Scenario: Security Manager class is not supported
    # Source: [JCVM 3.0.5, s2.2.1.1.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=28)
    # Source: [JCVM 3.2, s2.2.1.1.2](../3.2/JCVMSpec_3.2.pdf#page=28)
    Then language security policies shall be implemented by the virtual machine itself
    And there shall be no Security Manager class

  @v3.0.5 @v3.1 @v3.2
  Scenario: Finalization, threads, and cloning are not supported
    # Source: [JCVM 3.0.5, s2.2.1.1.3-5](../3.0.5/JCVMSpec_3.0.5.pdf#page=28)
    # Source: [JCVM 3.2, s2.2.1.1.3-5](../3.2/JCVMSpec_3.2.pdf#page=28)
    Then finalize() shall not be called automatically
    And multiple threads of control shall not be supported
    And object cloning shall not be supported (no Cloneable interface)

  @v3.0.5 @v3.1 @v3.2
  Scenario: Typesafe enums, enhanced for loop, varargs are not supported
    # Source: [JCVM 3.0.5, s2.2.1.1.7-9](../3.0.5/JCVMSpec_3.0.5.pdf#page=28)
    # Source: [JCVM 3.2, s2.2.1.1.7-9](../3.2/JCVMSpec_3.2.pdf#page=28)
    Then the enum keyword shall not be supported
    And the enhanced for loop shall not be supported
    And variable-length argument lists (varargs) shall not be supported

  # ===== UNSUPPORTED KEYWORDS =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Unsupported Java keywords
    # Source: [JCVM 3.0.5, s2.2.1.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=29)
    # Source: [JCVM 3.2, s2.2.1.2](../3.2/JCVMSpec_3.2.pdf#page=29)
    Then the following keywords shall not be supported: native, strictfp, synchronized, enum, transient, assert, volatile

  # ===== UNSUPPORTED TYPES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Unsupported Java types
    # Source: [JCVM 3.0.5, s2.2.1.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=29)
    # Source: [JCVM 3.2, s2.2.1.3](../3.2/JCVMSpec_3.2.pdf#page=29)
    Then the following types shall not be supported: char, double, float, long
    And arrays of more than one dimension shall not be supported

  # ===== SUPPORTED FEATURES =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Supported language features
    # Source: [JCVM 3.0.5, s2.2.2.1](../3.0.5/JCVMSpec_3.0.5.pdf#page=30)
    # Source: [JCVM 3.2, s2.2.2.1](../3.2/JCVMSpec_3.2.pdf#page=30)
    Then the platform shall support: packages, dynamic object creation, virtual methods, interfaces, exceptions
    And the platform shall support: generics (compile-time only), static import
    And the platform shall support: runtime invisible metadata (annotations)

  @v3.0.5 @v3.1 @v3.2
  Scenario: Supported types
    # Source: [JCVM 3.0.5, s2.2.2.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=32)
    # Source: [JCVM 3.2, s2.2.2.3](../3.2/JCVMSpec_3.2.pdf#page=32)
    Then the platform shall support types: boolean, byte, short, int (optional), Objects, single-dimensional arrays

  @v3.0.5 @v3.1 @v3.2
  Scenario: Supported classes from java.lang
    # Source: [JCVM 3.0.5, s2.2.2.4](../3.0.5/JCVMSpec_3.0.5.pdf#page=32)
    # Source: [JCVM 3.2, s2.2.2.4](../3.2/JCVMSpec_3.2.pdf#page=32)
    Then java.lang.Object shall be supported as the root of the class hierarchy
    And java.lang.Throwable shall be supported as the common ancestor for exceptions

  # ===== OPTIONALLY SUPPORTED =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Integer data type is optionally supported
    # Source: [JCVM 3.0.5, s2.2.3.1](../3.0.5/JCVMSpec_3.0.5.pdf#page=33)
    # Source: [JCVM 3.2, s2.2.3.1](../3.2/JCVMSpec_3.2.pdf#page=33)
    Then the int keyword and 32-bit integer data type need not be supported
    And a VM that does not support int shall reject programs that use it
    And arithmetic results must match those of a Java VM regardless of int support

  @v3.0.5 @v3.1 @v3.2
  Scenario: Object deletion mechanism is optionally supported
    # Source: [JCVM 3.0.5, s2.2.3.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=33)
    # Source: [JCVM 3.2, s2.2.3.2](../3.2/JCVMSpec_3.2.pdf#page=33)
    Then an optional object deletion mechanism may be provided
    And if provided, it must be fully supported as specified

  # ===== LIMITATIONS =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Limitations of packages
    # Source: [JCVM 3.0.5, s2.2.4.1](../3.0.5/JCVMSpec_3.0.5.pdf#page=33)
    # Source: [JCVM 3.2, s2.2.4.1](../3.2/JCVMSpec_3.2.pdf#page=33)
    Then a CAP file can contain at most 255 packages
    And a package can reference at most 128 external packages
    And a package name can contain a maximum of 255 characters

  @v3.0.5 @v3.1 @v3.2
  Scenario: Limitations of classes
    # Source: [JCVM 3.0.5, s2.2.4.2](../3.0.5/JCVMSpec_3.0.5.pdf#page=33)
    # Source: [JCVM 3.2, s2.2.4.2](../3.2/JCVMSpec_3.2.pdf#page=34)
    Then a package can contain at most 255 classes and interfaces
    And a class can implement at most 15 interfaces
    And an interface can inherit from at most 14 super interfaces
    And a class in an applet package can have at most 256 public/protected static non-final fields
    And a class in an applet package can have at most 256 public/protected static methods

  @v3.0.5 @v3.1 @v3.2
  Scenario: Limitations of objects
    # Source: [JCVM 3.0.5, s2.2.4.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=34)
    # Source: [JCVM 3.2, s2.2.4.3](../3.2/JCVMSpec_3.2.pdf#page=34)
    Then a class can implement at most 128 public/protected instance methods and 128 package-visible instance methods
    And class instances can have at most 255 fields (int counts as two)
    And arrays can hold at most 32767 components

  @v3.0.5 @v3.1 @v3.2
  Scenario: Limitations of methods
    # Source: [JCVM 3.0.5, s2.2.4.4](../3.0.5/JCVMSpec_3.0.5.pdf#page=34)
    # Source: [JCVM 3.2, s2.2.4.4](../3.2/JCVMSpec_3.2.pdf#page=34)
    Then the maximum number of variables in a method is 255 (including locals, params, and 'this')
    And a method can have at most 32767 Java Card bytecodes
    And the maximum depth of an operand stack is 255 16-bit cells

  # ===== BYTECODE SUBSET =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Unsupported Java bytecodes (all long, float, double, char, thread, and multi-array)
    # Source: [JCVM 3.0.5, s2.3.2.1 Unsupported Bytecodes](../3.0.5/JCVMSpec_3.0.5.pdf#page=38)
    # Source: [JCVM 3.2, s2.3.2.1](../3.2/JCVMSpec_3.2.pdf#page=38)
    Then the following Java bytecode categories shall not be supported:
      | Category        | Examples                                                  |
      | char operations | caload, castore                                           |
      | double ops      | d2f, d2i, d2l, dadd, daload, dastore, dcmpg, dcmpl, etc  |
      | float ops       | f2d, f2i, fadd, faload, fastore, fcmpg, fcmpl, etc        |
      | long ops        | l2d, l2f, l2i, ladd, laload, land, lastore, lcmp, etc     |
      | threading       | monitorenter, monitorexit                                 |
      | multi-array     | multianewarray                                            |
      | wide jumps      | goto_w (Java), jsr_w                                      |
      | type conversion | i2c, i2d, i2f, i2l                                        |

  @v3.0.5 @v3.1 @v3.2
  Scenario: Static restrictions on bytecodes
    # Source: [JCVM 3.0.5, s2.3.2.3](../3.0.5/JCVMSpec_3.0.5.pdf#page=42)
    # Source: [JCVM 3.2, s2.3.2.3](../3.2/JCVMSpec_3.2.pdf#page=42)
    Then ldc and ldc_w can only be used to load integer constants (CONSTANT_Integer entries)
    And lookupswitch npairs must be less than 65536
    And tableswitch can contain at most 65536 cases
    And the wide bytecode can only be used with an iinc instruction

  # ===== EXCEPTION SUPPORT =====

  @v3.0.5 @v3.1 @v3.2
  Scenario: Supported runtime exceptions
    # Source: [JCVM 3.0.5, s2.3.3.3 Table 2-4](../3.0.5/JCVMSpec_3.0.5.pdf#page=43)
    # Source: [JCVM 3.2, s2.3.3.3 Table 2-4](../3.2/JCVMSpec_3.2.pdf#page=44)
    Then the following runtime exceptions shall be supported:
      | Exception                      | Supported |
      | ArithmeticException            | Yes       |
      | ArrayStoreException            | Yes       |
      | ClassCastException             | Yes       |
      | IndexOutOfBoundsException      | Yes       |
      | ArrayIndexOutOfBoundsException | Yes       |
      | NegativeArraySizeException     | Yes       |
      | NullPointerException           | Yes       |
      | SecurityException              | Yes       |

  @v3.0.5 @v3.1 @v3.2
  Scenario: Supported errors
    # Source: [JCVM 3.0.5, s2.3.3.4 Table 2-5](../3.0.5/JCVMSpec_3.0.5.pdf#page=44)
    # Source: [JCVM 3.2, s2.3.3.4 Table 2-5](../3.2/JCVMSpec_3.2.pdf#page=44)
    Then the following errors shall be supported:
      | Error                          | Supported |
      | LinkageError                   | Yes       |
      | ClassCircularityError          | Yes       |
      | ClassFormatError               | Yes       |
      | ExceptionInInitializerError    | Yes       |
      | IncompatibleClassChangeError   | Yes       |
      | AbstractMethodError            | Yes       |
      | IllegalAccessError             | Yes       |
      | InstantiationError             | Yes       |
      | NoSuchFieldError               | Yes       |
      | NoSuchMethodError              | Yes       |
      | NoClassDefFoundError           | Yes       |
      | UnsatisfiedLinkError           | Yes       |
      | VerifyError                    | Yes       |
      | VirtualMachineError            | Yes       |
      | InternalError                  | Yes       |
      | OutOfMemoryError               | Yes       |
