@v3.0.5
@v3.1
@v3.2
Feature: Object and Throwable (java.lang)
  The java.lang package provides a stripped-down Java SE subset for the
  Java Card platform. Object is the root of the class hierarchy, and
  Throwable is the root of the exception hierarchy.

  The JavaCard platform subset of these classes is significantly reduced
  compared to standard Java SE. Object provides only the no-arg
  constructor and equals(Object) -- there is no hashCode(), toString(),
  clone(), getClass(), finalize(), wait(), notify(), or notifyAll().
  Throwable provides only the no-arg constructor -- there is no
  getMessage(), getCause(), printStackTrace(), or initCause().

  # ===================================================================
  # Object -- root class of the Java Card class hierarchy
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object is the root of the class hierarchy
    Given the Java Card platform class hierarchy
    Then every class has java.lang.Object as a superclass
    And all objects, including arrays, implement the methods of Object

  # Source: [JavaCard 3.0.5 API, Object()](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html#Object())
  # Source: [JavaCard 3.1 API, Object()](../.refs/javadoc-3.1/api_classic/java/lang/Object.html#())
  # Source: [JavaCard 3.2 API, Object()](../.refs/javadoc-3.2/api_classic/java/lang/Object.html#())
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object provides a public no-arg constructor
    Given the class java.lang.Object
    Then it has a public no-arg constructor: Object()

  # Source: [JavaCard 3.0.5 API, equals](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html#equals(java.lang.Object))
  # Source: [JavaCard 3.1 API, equals](../.refs/javadoc-3.1/api_classic/java/lang/Object.html#equals(java.lang.Object))
  # Source: [JavaCard 3.2 API, equals](../.refs/javadoc-3.2/api_classic/java/lang/Object.html#equals(java.lang.Object))
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object.equals implements reference equality by default
    Given two reference values x and y
    When x.equals(y) is called on the Object base implementation
    Then it returns true if and only if x and y refer to the same object (x == y)

  # Source: [JavaCard 3.0.5 API, equals](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html#equals(java.lang.Object))
  # Source: [JavaCard 3.1 API, equals](../.refs/javadoc-3.1/api_classic/java/lang/Object.html#equals(java.lang.Object))
  # Source: [JavaCard 3.2 API, equals](../.refs/javadoc-3.2/api_classic/java/lang/Object.html#equals(java.lang.Object))
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object.equals is an equivalence relation
    Given the method public boolean equals(Object obj)
    Then it is reflexive: x.equals(x) returns true for any non-null x
    And it is symmetric: x.equals(y) returns true iff y.equals(x) returns true
    And it is transitive: if x.equals(y) and y.equals(z) then x.equals(z)
    And it is consistent: repeated calls return the same result
    And x.equals(null) returns false for any non-null x

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object provides only equals as an instance method
    Given the class java.lang.Object on the Java Card platform
    Then the only instance method is: public boolean equals(Object obj)

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide hashCode
    Given the class java.lang.Object on the Java Card platform
    Then there is no hashCode() method

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide toString
    Given the class java.lang.Object on the Java Card platform
    Then there is no toString() method

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide clone
    Given the class java.lang.Object on the Java Card platform
    Then there is no clone() method

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide getClass
    Given the class java.lang.Object on the Java Card platform
    Then there is no getClass() method

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide finalize
    Given the class java.lang.Object on the Java Card platform
    Then there is no finalize() method

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide wait
    Given the class java.lang.Object on the Java Card platform
    Then there is no wait() method

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide notify
    Given the class java.lang.Object on the Java Card platform
    Then there is no notify() method

  # Source: [JavaCard 3.0.5 API, Object](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.1 API, Object](../.refs/javadoc-3.1/api_classic/java/lang/Object.html)
  # Source: [JavaCard 3.2 API, Object](../.refs/javadoc-3.2/api_classic/java/lang/Object.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object does not provide notifyAll
    Given the class java.lang.Object on the Java Card platform
    Then there is no notifyAll() method

  # ===================================================================
  # Throwable -- root of the exception hierarchy
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable extends Object
    Given the class java.lang.Throwable
    Then its superclass is java.lang.Object
    And its direct known subclass is java.lang.Exception

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable is the superclass of all errors and exceptions
    Given the Java Card platform
    Then only instances of Throwable or its subclasses can be thrown by the JCVM
    And only Throwable or its subclasses can be the argument type in a catch clause

  # Source: [JavaCard 3.0.5 API, Throwable()](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html#Throwable())
  # Source: [JavaCard 3.1 API, Throwable()](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html#())
  # Source: [JavaCard 3.2 API, Throwable()](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html#())
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable provides only a no-arg constructor
    Given the class java.lang.Throwable
    Then it has a public no-arg constructor: Throwable()
    And there is no constructor accepting a String message
    And there is no constructor accepting a Throwable cause

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable inherits only equals from Object
    Given the class java.lang.Throwable on the Java Card platform
    Then it inherits only equals(Object) from Object

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide getMessage
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no getMessage() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide getCause
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no getCause() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide initCause
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no initCause() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide printStackTrace
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no printStackTrace() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide getStackTrace
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no getStackTrace() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide fillInStackTrace
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no fillInStackTrace() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide toString
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no toString() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide getLocalizedMessage
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no getLocalizedMessage() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide addSuppressed
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no addSuppressed() method

  # Source: [JavaCard 3.0.5 API, Throwable](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.1 API, Throwable](../.refs/javadoc-3.1/api_classic/java/lang/Throwable.html)
  # Source: [JavaCard 3.2 API, Throwable](../.refs/javadoc-3.2/api_classic/java/lang/Throwable.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Throwable does not provide getSuppressed
    Given the class java.lang.Throwable on the Java Card platform
    Then there is no getSuppressed() method
