@v3.0.5
@v3.1
@v3.2
Feature: Java SE Subset Exception Classes (java.lang)
  The java.lang package on the Java Card platform provides a stripped-down
  subset of the standard Java SE exception hierarchy. All exception classes
  in this subset have only a single no-arg constructor -- there are no
  constructors accepting a String message or a Throwable cause, and none
  of these classes define any methods of their own beyond what they inherit
  from Object (i.e., equals(Object) only).

  The hierarchy is:
  Object -> Throwable -> Exception -> RuntimeException -> (leaf exceptions)
  Object -> Throwable -> Exception -> RuntimeException -> IndexOutOfBoundsException ->
  ArrayIndexOutOfBoundsException

  JCRE-owned instances of all runtime exception classes are temporary
  Entry Point Objects accessible from any applet context. References to
  these temporary objects cannot be stored in class variables, instance
  variables, or array components (see JCRE Specification, section 6.2.1).

  # ===================================================================
  # Exception (checked, extends Throwable)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, Exception](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Exception.html)
  # Source: [JavaCard 3.1 API, Exception](../../../refs/javadoc-3.1/api_classic/java/lang/Exception.html)
  # Source: [JavaCard 3.2 API, Exception](../../../refs/javadoc-3.2/api_classic/java/lang/Exception.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Exception class hierarchy
    Given the class java.lang.Exception
    Then its superclass is java.lang.Throwable
    And its direct known subclasses include javacard.framework.CardException
    And its direct known subclasses include java.io.IOException
    And its direct known subclasses include java.lang.RuntimeException

  # Source: [JavaCard 3.0.5 API, Exception()](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Exception.html#Exception())
  # Source: [JavaCard 3.1 API, Exception()](../../../refs/javadoc-3.1/api_classic/java/lang/Exception.html#())
  # Source: [JavaCard 3.2 API, Exception()](../../../refs/javadoc-3.2/api_classic/java/lang/Exception.html#())
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Exception provides only a no-arg constructor
    Given the class java.lang.Exception
    Then it has a public no-arg constructor: Exception()
    And there is no constructor accepting a String message
    And its subclasses represent conditions a reasonable applet might want to catch

  # ===================================================================
  # RuntimeException (unchecked, extends Exception)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: RuntimeException extends Exception
    Given the class java.lang.RuntimeException
    Then its superclass is java.lang.Exception

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArithmeticException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include java.lang.ArithmeticException

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayStoreException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include java.lang.ArrayStoreException

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ClassCastException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include java.lang.ClassCastException

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IndexOutOfBoundsException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include java.lang.IndexOutOfBoundsException

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: NegativeArraySizeException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include java.lang.NegativeArraySizeException

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: NullPointerException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include java.lang.NullPointerException

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SecurityException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include java.lang.SecurityException

  # Source: [JavaCard 3.0.5 API, RuntimeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.1 API, RuntimeException](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html)
  # Source: [JavaCard 3.2 API, RuntimeException](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CardRuntimeException is a direct subclass of RuntimeException
    Given the class java.lang.RuntimeException
    Then its direct known subclasses include javacard.framework.CardRuntimeException

  # Source: [JavaCard 3.0.5 API, RuntimeException()](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/RuntimeException.html#RuntimeException())
  # Source: [JavaCard 3.1 API, RuntimeException()](../../../refs/javadoc-3.1/api_classic/java/lang/RuntimeException.html#())
  # Source: [JavaCard 3.2 API, RuntimeException()](../../../refs/javadoc-3.2/api_classic/java/lang/RuntimeException.html#())
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: RuntimeException provides only a no-arg constructor
    Given the class java.lang.RuntimeException
    Then it has a public no-arg constructor: RuntimeException()
    And there is no constructor accepting a String message
    And a method is not required to declare RuntimeException subclasses in its throws clause

  # ===================================================================
  # ArithmeticException (extends RuntimeException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, ArithmeticException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArithmeticException.html)
  # Source: [JavaCard 3.1 API, ArithmeticException](../../../refs/javadoc-3.1/api_classic/java/lang/ArithmeticException.html)
  # Source: [JavaCard 3.2 API, ArithmeticException](../../../refs/javadoc-3.2/api_classic/java/lang/ArithmeticException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArithmeticException class definition
    Given the class java.lang.ArithmeticException
    Then its superclass is java.lang.RuntimeException
    And it has a public no-arg constructor: ArithmeticException()
    And there is no constructor accepting a String message

  # Source: [JavaCard 3.0.5 API, ArithmeticException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArithmeticException.html)
  # Source: [JavaCard 3.1 API, ArithmeticException](../../../refs/javadoc-3.1/api_classic/java/lang/ArithmeticException.html)
  # Source: [JavaCard 3.2 API, ArithmeticException](../../../refs/javadoc-3.2/api_classic/java/lang/ArithmeticException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArithmeticException thrown on divide by zero
    Given a JCRE-owned instance of ArithmeticException
    When an exceptional arithmetic condition occurs such as integer divide by zero
    Then the JCVM throws the JCRE-owned ArithmeticException instance
    And the instance is a temporary JCRE Entry Point Object

  # ===================================================================
  # ArrayStoreException (extends RuntimeException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, ArrayStoreException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArrayStoreException.html)
  # Source: [JavaCard 3.1 API, ArrayStoreException](../../../refs/javadoc-3.1/api_classic/java/lang/ArrayStoreException.html)
  # Source: [JavaCard 3.2 API, ArrayStoreException](../../../refs/javadoc-3.2/api_classic/java/lang/ArrayStoreException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayStoreException class definition
    Given the class java.lang.ArrayStoreException
    Then its superclass is java.lang.RuntimeException
    And it has a public no-arg constructor: ArrayStoreException()
    And there is no constructor accepting a String message

  # Source: [JavaCard 3.0.5 API, ArrayStoreException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArrayStoreException.html)
  # Source: [JavaCard 3.1 API, ArrayStoreException](../../../refs/javadoc-3.1/api_classic/java/lang/ArrayStoreException.html)
  # Source: [JavaCard 3.2 API, ArrayStoreException](../../../refs/javadoc-3.2/api_classic/java/lang/ArrayStoreException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayStoreException thrown on type-incompatible array store
    Given a JCRE-owned instance of ArrayStoreException
    When an attempt is made to store the wrong type of object into an array
    # Example: Object x[] = new AID[3]; x[0] = new OwnerPIN((byte)3, (byte)8);
    Then the JCVM throws the JCRE-owned ArrayStoreException instance
    And the instance is a temporary JCRE Entry Point Object

  # ===================================================================
  # ClassCastException (extends RuntimeException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, ClassCastException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ClassCastException.html)
  # Source: [JavaCard 3.1 API, ClassCastException](../../../refs/javadoc-3.1/api_classic/java/lang/ClassCastException.html)
  # Source: [JavaCard 3.2 API, ClassCastException](../../../refs/javadoc-3.2/api_classic/java/lang/ClassCastException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ClassCastException class definition
    Given the class java.lang.ClassCastException
    Then its superclass is java.lang.RuntimeException
    And it has a public no-arg constructor: ClassCastException()
    And there is no constructor accepting a String message

  # Source: [JavaCard 3.0.5 API, ClassCastException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ClassCastException.html)
  # Source: [JavaCard 3.1 API, ClassCastException](../../../refs/javadoc-3.1/api_classic/java/lang/ClassCastException.html)
  # Source: [JavaCard 3.2 API, ClassCastException](../../../refs/javadoc-3.2/api_classic/java/lang/ClassCastException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ClassCastException thrown on invalid cast
    Given a JCRE-owned instance of ClassCastException
    When code attempts to cast an object to a subclass of which it is not an instance
    # Example: Object x = new OwnerPIN((byte)3, (byte)8); JCSystem.getAppletShareableInterfaceObject((AID) x, (byte)5);
    Then the JCVM throws the JCRE-owned ClassCastException instance
    And the instance is a temporary JCRE Entry Point Object

  # ===================================================================
  # IndexOutOfBoundsException (extends RuntimeException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, IndexOutOfBoundsException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/IndexOutOfBoundsException.html)
  # Source: [JavaCard 3.1 API, IndexOutOfBoundsException](../../../refs/javadoc-3.1/api_classic/java/lang/IndexOutOfBoundsException.html)
  # Source: [JavaCard 3.2 API, IndexOutOfBoundsException](../../../refs/javadoc-3.2/api_classic/java/lang/IndexOutOfBoundsException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IndexOutOfBoundsException class definition
    Given the class java.lang.IndexOutOfBoundsException
    Then its superclass is java.lang.RuntimeException
    And it has a public no-arg constructor: IndexOutOfBoundsException()
    And there is no constructor accepting a String message
    And its direct known subclass is java.lang.ArrayIndexOutOfBoundsException

  # Source: [JavaCard 3.0.5 API, IndexOutOfBoundsException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/IndexOutOfBoundsException.html)
  # Source: [JavaCard 3.1 API, IndexOutOfBoundsException](../../../refs/javadoc-3.1/api_classic/java/lang/IndexOutOfBoundsException.html)
  # Source: [JavaCard 3.2 API, IndexOutOfBoundsException](../../../refs/javadoc-3.2/api_classic/java/lang/IndexOutOfBoundsException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IndexOutOfBoundsException thrown on index out of range
    Given a JCRE-owned instance of IndexOutOfBoundsException
    When an index of some sort (such as to an array) is out of range
    Then the JCVM throws the JCRE-owned IndexOutOfBoundsException instance
    And the instance is a temporary JCRE Entry Point Object

  # ===================================================================
  # ArrayIndexOutOfBoundsException (extends IndexOutOfBoundsException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.1 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.1/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.2 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.2/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayIndexOutOfBoundsException extends IndexOutOfBoundsException
    Given the class java.lang.ArrayIndexOutOfBoundsException
    Then its superclass is java.lang.IndexOutOfBoundsException

  # Source: [JavaCard 3.0.5 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.1 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.1/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.2 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.2/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayIndexOutOfBoundsException provides a no-arg constructor
    Given the class java.lang.ArrayIndexOutOfBoundsException
    Then it has a public no-arg constructor: ArrayIndexOutOfBoundsException()

  # Source: [JavaCard 3.0.5 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.1 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.1/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.2 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.2/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayIndexOutOfBoundsException does not accept a String message
    Given the class java.lang.ArrayIndexOutOfBoundsException
    Then there is no constructor accepting a String message

  # Source: [JavaCard 3.0.5 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.1 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.1/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.2 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.2/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayIndexOutOfBoundsException does not accept an int index
    Given the class java.lang.ArrayIndexOutOfBoundsException
    Then there is no constructor accepting an int index

  # Source: [JavaCard 3.0.5 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.1 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.1/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  # Source: [JavaCard 3.2 API, ArrayIndexOutOfBoundsException](../../../refs/javadoc-3.2/api_classic/java/lang/ArrayIndexOutOfBoundsException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: ArrayIndexOutOfBoundsException thrown on illegal array index
    Given a JCRE-owned instance of ArrayIndexOutOfBoundsException
    When an array has been accessed with an illegal index
    And the index is either negative or greater than or equal to the size of the array
    Then the JCVM throws the JCRE-owned ArrayIndexOutOfBoundsException instance
    And the instance is a temporary JCRE Entry Point Object

  # ===================================================================
  # NegativeArraySizeException (extends RuntimeException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, NegativeArraySizeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/NegativeArraySizeException.html)
  # Source: [JavaCard 3.1 API, NegativeArraySizeException](../../../refs/javadoc-3.1/api_classic/java/lang/NegativeArraySizeException.html)
  # Source: [JavaCard 3.2 API, NegativeArraySizeException](../../../refs/javadoc-3.2/api_classic/java/lang/NegativeArraySizeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: NegativeArraySizeException class definition
    Given the class java.lang.NegativeArraySizeException
    Then its superclass is java.lang.RuntimeException
    And it has a public no-arg constructor: NegativeArraySizeException()
    And there is no constructor accepting a String message

  # Source: [JavaCard 3.0.5 API, NegativeArraySizeException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/NegativeArraySizeException.html)
  # Source: [JavaCard 3.1 API, NegativeArraySizeException](../../../refs/javadoc-3.1/api_classic/java/lang/NegativeArraySizeException.html)
  # Source: [JavaCard 3.2 API, NegativeArraySizeException](../../../refs/javadoc-3.2/api_classic/java/lang/NegativeArraySizeException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: NegativeArraySizeException thrown on negative array creation
    Given a JCRE-owned instance of NegativeArraySizeException
    When an applet tries to create an array with negative size
    Then the JCVM throws the JCRE-owned NegativeArraySizeException instance
    And the instance is a temporary JCRE Entry Point Object

  # ===================================================================
  # NullPointerException (extends RuntimeException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, NullPointerException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/NullPointerException.html)
  # Source: [JavaCard 3.1 API, NullPointerException](../../../refs/javadoc-3.1/api_classic/java/lang/NullPointerException.html)
  # Source: [JavaCard 3.2 API, NullPointerException](../../../refs/javadoc-3.2/api_classic/java/lang/NullPointerException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: NullPointerException class definition
    Given the class java.lang.NullPointerException
    Then its superclass is java.lang.RuntimeException
    And it has a public no-arg constructor: NullPointerException()
    And there is no constructor accepting a String message

  # Source: [JavaCard 3.0.5 API, NullPointerException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/NullPointerException.html)
  # Source: [JavaCard 3.1 API, NullPointerException](../../../refs/javadoc-3.1/api_classic/java/lang/NullPointerException.html)
  # Source: [JavaCard 3.2 API, NullPointerException](../../../refs/javadoc-3.2/api_classic/java/lang/NullPointerException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: NullPointerException thrown on null dereference
    Given a JCRE-owned instance of NullPointerException
    When an applet attempts to use null where an object is required
    # This includes: calling instance methods on null, accessing/modifying
    # fields of null, taking the length of null as an array, accessing/modifying
    # slots of null as an array, or throwing null as a Throwable value.
    Then the JCVM throws the JCRE-owned NullPointerException instance
    And the instance is a temporary JCRE Entry Point Object

  # ===================================================================
  # SecurityException (extends RuntimeException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, SecurityException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/SecurityException.html)
  # Source: [JavaCard 3.1 API, SecurityException](../../../refs/javadoc-3.1/api_classic/java/lang/SecurityException.html)
  # Source: [JavaCard 3.2 API, SecurityException](../../../refs/javadoc-3.2/api_classic/java/lang/SecurityException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SecurityException class definition
    Given the class java.lang.SecurityException
    Then its superclass is java.lang.RuntimeException
    And it has a public no-arg constructor: SecurityException()
    And there is no constructor accepting a String message

  # Source: [JavaCard 3.0.5 API, SecurityException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/SecurityException.html)
  # Source: [JavaCard 3.1 API, SecurityException](../../../refs/javadoc-3.1/api_classic/java/lang/SecurityException.html)
  # Source: [JavaCard 3.2 API, SecurityException](../../../refs/javadoc-3.2/api_classic/java/lang/SecurityException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SecurityException thrown on security violation
    Given a JCRE-owned instance of SecurityException
    When the JCVM detects a security violation
    # This includes: illegally accessing an object belonging to another applet,
    # or optionally attempting to invoke a private method in another class.
    Then the JCVM throws the JCRE-owned SecurityException instance
    And the instance is a temporary JCRE Entry Point Object

  # Source: [JavaCard 3.0.5 API, SecurityException](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/SecurityException.html)
  # Source: [JavaCard 3.1 API, SecurityException](../../../refs/javadoc-3.1/api_classic/java/lang/SecurityException.html)
  # Source: [JavaCard 3.2 API, SecurityException](../../../refs/javadoc-3.2/api_classic/java/lang/SecurityException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: SecurityException may cause card mute instead
    Given a security violation on the Java Card platform
    Then the JCRE implementation may mute the card instead of throwing SecurityException

  # For security reasons, silencing the card is an allowed alternative response.
  # ===================================================================
  # Common restrictions for all java.lang exception classes
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, java.lang package](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/package-summary.html)
  # Source: [JavaCard 3.1 API, java.lang package](../../../refs/javadoc-3.1/api_classic/java/lang/package-summary.html)
  # Source: [JavaCard 3.2 API, java.lang package](../../../refs/javadoc-3.2/api_classic/java/lang/package-summary.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: All java.lang exceptions use only no-arg constructors
    Given all exception classes in the java.lang package on Java Card
    Then each class has exactly one constructor taking no arguments
    And none have constructors accepting a String message parameter
    And none have constructors accepting a Throwable cause parameter
    And none define any new methods beyond what is inherited from Object

  # Source: [JavaCard 3.0.5 API, java.lang package](../../../refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/package-summary.html)
  # Source: [JavaCard 3.1 API, java.lang package](../../../refs/javadoc-3.1/api_classic/java/lang/package-summary.html)
  # Source: [JavaCard 3.2 API, java.lang package](../../../refs/javadoc-3.2/api_classic/java/lang/package-summary.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: JCRE-owned exception instances are temporary Entry Point Objects
    Given all JCRE-owned runtime exception instances in java.lang
    Then each instance is a temporary JCRE Entry Point Object
    And each instance can be accessed from any applet context
    And references to these instances cannot be stored in class variables
    And references to these instances cannot be stored in instance variables
    And references to these instances cannot be stored in array components
