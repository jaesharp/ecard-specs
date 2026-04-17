@v3.0.5
@v3.1
@v3.2
Feature: Remote Interface and RemoteException (java.rmi)
  The java.rmi package on the Java Card platform provides two types that
  support the Java Card RMI (Remote Method Invocation) subsystem: the
  Remote marker interface and the RemoteException checked exception.

  These are stripped-down versions of their Java SE counterparts, adapted
  for the constrained Java Card environment. Remote is a pure marker
  interface with no methods. RemoteException has only a no-arg constructor
  (no message string or cause Throwable), and defines no methods beyond
  what it inherits from Object.

  # ===================================================================
  # Remote -- marker interface for RMI-accessible objects
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, Remote](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/Remote.html)
  # Source: [JavaCard 3.1 API, Remote](../.refs/javadoc-3.1/api_classic/java/rmi/Remote.html)
  # Source: [JavaCard 3.2 API, Remote](../.refs/javadoc-3.2/api_classic/java/rmi/Remote.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Remote is a marker interface
    Given the interface java.rmi.Remote
    Then it is declared as: public interface Remote
    And it defines no methods
    And it defines no fields
    And it defines no constructors

  # Source: [JavaCard 3.0.5 API, Remote](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/Remote.html)
  # Source: [JavaCard 3.1 API, Remote](../.refs/javadoc-3.1/api_classic/java/rmi/Remote.html)
  # Source: [JavaCard 3.2 API, Remote](../.refs/javadoc-3.2/api_classic/java/rmi/Remote.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Remote identifies interfaces whose methods may be invoked from a CAD client
    Given an object that implements java.rmi.Remote (directly or indirectly)
    Then only methods specified in a "remote interface" (one that extends java.rmi.Remote) are available remotely
    And the object is a remote object that can be invoked from a CAD client application

  # Source: [JavaCard 3.0.5 API, Remote](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/Remote.html)
  # Source: [JavaCard 3.1 API, Remote](../.refs/javadoc-3.1/api_classic/java/rmi/Remote.html)
  # Source: [JavaCard 3.2 API, Remote](../.refs/javadoc-3.2/api_classic/java/rmi/Remote.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Remote implementation classes may extend CardRemoteObject
    Given a class implementing a remote interface
    Then it can implement any number of remote interfaces
    And it can extend other remote implementation classes
    And the convenience class javacard.framework.service.CardRemoteObject is available to facilitate remote object creation
    And the known implementing class is javacard.framework.service.CardRemoteObject

  # ===================================================================
  # RemoteException (checked, extends java.io.IOException)
  # ===================================================================
  # Source: [JavaCard 3.0.5 API, RemoteException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.1 API, RemoteException](../.refs/javadoc-3.1/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.2 API, RemoteException](../.refs/javadoc-3.2/api_classic/java/rmi/RemoteException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: RemoteException class hierarchy
    Given the class java.rmi.RemoteException
    Then its superclass is java.io.IOException
    And the full hierarchy is: Object -> Throwable -> Exception -> IOException -> RemoteException

  # Source: [JavaCard 3.0.5 API, RemoteException()](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/RemoteException.html#RemoteException())
  # Source: [JavaCard 3.1 API, RemoteException()](../.refs/javadoc-3.1/api_classic/java/rmi/RemoteException.html#())
  # Source: [JavaCard 3.2 API, RemoteException()](../.refs/javadoc-3.2/api_classic/java/rmi/RemoteException.html#())
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: RemoteException provides only a no-arg constructor
    Given the class java.rmi.RemoteException
    Then it has a public no-arg constructor: RemoteException()
    And there is no constructor accepting a String message
    And there is no constructor accepting a String message and Throwable cause

  # Source: [JavaCard 3.0.5 API, RemoteException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.1 API, RemoteException](../.refs/javadoc-3.1/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.2 API, RemoteException](../.refs/javadoc-3.2/api_classic/java/rmi/RemoteException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: RemoteException indicates communication-related failure during remote method call
    Given a JCRE-owned instance of RemoteException
    Then it indicates that a communication-related exception occurred during a remote method call

  # Source: [JavaCard 3.0.5 API, RemoteException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.1 API, RemoteException](../.refs/javadoc-3.1/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.2 API, RemoteException](../.refs/javadoc-3.2/api_classic/java/rmi/RemoteException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Remote interface methods must declare RemoteException in throws clause
    Given a remote interface that extends java.rmi.Remote
    Then each method of that interface must list RemoteException or a superclass in its throws clause

  # Source: [JavaCard 3.0.5 API, RemoteException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.1 API, RemoteException](../.refs/javadoc-3.1/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.2 API, RemoteException](../.refs/javadoc-3.2/api_classic/java/rmi/RemoteException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: RemoteException defines no methods of its own
    Given the class java.rmi.RemoteException on the Java Card platform
    Then it inherits only equals(Object) from java.lang.Object
    And it defines no additional methods
    And it defines no fields

  # Source: [JavaCard 3.0.5 API, RemoteException](../.refs/javadoc-3.0.5/javacard_specifications-3_0_5-RR/classic/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.1 API, RemoteException](../.refs/javadoc-3.1/api_classic/java/rmi/RemoteException.html)
  # Source: [JavaCard 3.2 API, RemoteException](../.refs/javadoc-3.2/api_classic/java/rmi/RemoteException.html)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: JCRE-owned RemoteException instance is a temporary Entry Point Object
    Given a JCRE-owned instance of RemoteException
    Then the instance is a temporary JCRE Entry Point Object
    And the instance can be accessed from any applet context
    And references to the instance cannot be stored in class variables
    And references to the instance cannot be stored in instance variables
    And references to the instance cannot be stored in array components
