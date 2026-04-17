@v3.0.5
@v3.1
@v3.2
Feature: IOException (java.io)
  The java.io package on the Java Card platform contains a single class:
  IOException. This is a stripped-down version of the standard Java SE
  java.io.IOException, providing only a no-arg constructor and no methods
  beyond what is inherited from Object (equals only).

  IOException serves as the checked exception base class for I/O-related
  errors. On the Java Card platform, its primary role is as the superclass
  of java.rmi.RemoteException, which is used by the JavaCard RMI subsystem.

  # ===================================================================
  # IOException (checked, extends java.lang.Exception)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, IOException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.1 API, IOException](../.refs/javadoc-3.1/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.2 API, IOException](../.refs/javadoc-3.2/api_classic/java/io/IOException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IOException class hierarchy
    Given the class java.io.IOException
    Then its superclass is java.lang.Exception
    And its direct known subclass is java.rmi.RemoteException
    And the full hierarchy is: Object -> Throwable -> Exception -> IOException

  # Source: [JavaCard 3.0.5 API, IOException()](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/io/IOException.html#IOException())
  # Source: [JavaCard 3.1 API, IOException()](../.refs/javadoc-3.1/api_classic/java/io/IOException.html#())
  # Source: [JavaCard 3.2 API, IOException()](../.refs/javadoc-3.2/api_classic/java/io/IOException.html#())
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IOException provides only a no-arg constructor
    Given the class java.io.IOException
    Then it has a public no-arg constructor: IOException()
    And there is no constructor accepting a String message
    And there is no constructor accepting a Throwable cause

  # Source: [JavaCard 3.0.5 API, IOException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.1 API, IOException](../.refs/javadoc-3.1/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.2 API, IOException](../.refs/javadoc-3.2/api_classic/java/io/IOException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IOException signals I/O failures
    Given a JCRE-owned instance of IOException
    Then it signals that an I/O exception of some sort has occurred
    And it is the general class of exceptions produced by failed or interrupted I/O operations

  # Source: [JavaCard 3.0.5 API, IOException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.1 API, IOException](../.refs/javadoc-3.1/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.2 API, IOException](../.refs/javadoc-3.2/api_classic/java/io/IOException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IOException defines no methods of its own
    Given the class java.io.IOException on the Java Card platform
    Then it inherits only equals(Object) from java.lang.Object
    And it defines no additional methods
    And it defines no fields

  # Source: [JavaCard 3.0.5 API, IOException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.1 API, IOException](../.refs/javadoc-3.1/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.2 API, IOException](../.refs/javadoc-3.2/api_classic/java/io/IOException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: IOException is a checked exception
    Given the class java.io.IOException
    Then it extends java.lang.Exception (not RuntimeException)
    And methods that may throw IOException must declare it in their throws clause
    And it is the checked exception base used by the Java Card RMI subsystem

  # Source: [JavaCard 3.0.5 API, IOException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.1 API, IOException](../.refs/javadoc-3.1/api_classic/java/io/IOException.html)
  # Source: [JavaCard 3.2 API, IOException](../.refs/javadoc-3.2/api_classic/java/io/IOException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: JCRE-owned IOException instance is a temporary Entry Point Object
    Given a JCRE-owned instance of IOException
    Then the instance is a temporary JCRE Entry Point Object
    And the instance can be accessed from any applet context
    And references to the instance cannot be stored in class variables
    And references to the instance cannot be stored in instance variables
    And references to the instance cannot be stored in array components
