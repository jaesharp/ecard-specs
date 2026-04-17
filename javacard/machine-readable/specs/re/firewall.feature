@jcre
@firewall
Feature: Applet Firewall and Object Sharing
  Any implementation of the Java Card RE shall support isolation of contexts and
  applets. Isolation means that one applet cannot access the fields or objects of
  an applet in another context unless the other applet explicitly provides an
  interface for access. The firewall is runtime-enforced protection separate from
  Java language protections.

  # Source: [JCRE 3.0.5, s6 Applet Isolation and Object Sharing](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=43)
  # Source: [JCRE 3.1, s6 Applet Isolation and Object Sharing](../../refs/3.1/JCRESpec_3.1.pdf#page=51)
  # Source: [JCRE 3.2, s6 Applet Isolation and Object Sharing](../../refs/3.2/JCRESpec_3.2.pdf#page=53)
  Background:
    Given a Java Card secure element with a compliant JCRE implementation
    And the Java Card RE is initialized

  # ---------------------------------------------------------------------------
  # 6.1.2 Contexts and Context Switching
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.1.2 Contexts and Context Switching](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=43)
  # Source: [JCRE 3.1, s6.1.2 Contexts and Context Switching](../../refs/3.1/JCRESpec_3.1.pdf#page=51)
  # Source: [JCRE 3.2, s6.1.2 Contexts and Context Switching](../../refs/3.2/JCRESpec_3.2.pdf#page=53)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Context allocation per CAP file
    Given a Java Card CAP File containing applets is loaded
    Then the Java Card RE shall allocate and manage a context for each Java Card CAP File containing applets
    And all applet instances within a single CAP File share the same context
    And there is no firewall between individual applet instances within the same CAP File
    And an applet instance can freely access objects belonging to another applet instance in the same CAP File
    And a library CAP File is not assigned a separate context; library objects belong to the context of the creating applet instance

  # Source: [JCRE 3.0.5, s6.1.2 Contexts and Context Switching](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=43)
  # Source: [JCRE 3.1, s6.1.2 Contexts and Context Switching](../../refs/3.1/JCRESpec_3.1.pdf#page=51)
  # Source: [JCRE 3.2, s6.1.2 Contexts and Context Switching](../../refs/3.2/JCRESpec_3.2.pdf#page=53)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Java Card RE context
    Given the Java Card RE maintains its own Java Card RE context
    Then the Java Card RE context has special system privileges
    And access from the Java Card RE context to any applet instance's context is allowed
    But access from an applet instance's context to the Java Card RE context is prohibited by the firewall

  # ---------------------------------------------------------------------------
  # 6.1.2.1 Active Contexts in the VM
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.1.2.1 Active Contexts in the VM](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=44)
  # Source: [JCRE 3.1, s6.1.2.1 Active Contexts in the VM](../../refs/3.1/JCRESpec_3.1.pdf#page=52)
  # Source: [JCRE 3.2, s6.1.2.1 Active Contexts in the VM](../../refs/3.2/JCRESpec_3.2.pdf#page=54)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Currently active context and access checking
    Given at any point in time there is only one active context within the VM (the currently active context)
    Then the currently active context can be either the Java Card RE context or an applet's context
    And all bytecodes that access objects are checked at runtime against the currently active context
    And a java.lang.SecurityException is thrown when an access is disallowed

  # ---------------------------------------------------------------------------
  # 6.1.2.2 Context Switching in the VM
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.1.2.2 Context Switching in the VM](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=45)
  # Source: [JCRE 3.1, s6.1.2.2 Context Switching in the VM](../../refs/3.1/JCRESpec_3.1.pdf#page=53)
  # Source: [JCRE 3.2, s6.1.2.2 Context Switching in the VM](../../refs/3.2/JCRESpec_3.2.pdf#page=55)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Context switch mechanism - push/pop on VM stack
    Given a context switch occurs during execution of an invoke-type bytecode
    Then the previous context and object owner information is pushed on an internal VM stack
    And a new context becomes the currently active context
    And the invoked method executes in this new context
    And upon exit from that method, the VM performs a restoring context switch
    And the original context is popped from the stack and restored as the currently active context
    And context switches can be nested with depth limited by VM stack space

  # Source: [JCRE 3.0.5, s6.1.2.2 Context Switching in the VM](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=45)
  # Source: [JCRE 3.1, s6.1.2.2 Context Switching in the VM](../../refs/3.1/JCRESpec_3.1.pdf#page=53)
  # Source: [JCRE 3.2, s6.1.2.2 Context Switching in the VM](../../refs/3.2/JCRESpec_3.2.pdf#page=55)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Most method invocations do not cause context switch
    Given a method is invoked on an object that belongs to an applet instance in the same context
    Then no context switch occurs
    And context switches only occur during invocation of and return from certain cross-context methods
    And during exception exits from those methods

  # ---------------------------------------------------------------------------
  # 6.1.3 Object Ownership
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.1.3 Object Ownership](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=45)
  # Source: [JCRE 3.1, s6.1.3 Object Ownership](../../refs/3.1/JCRESpec_3.1.pdf#page=53)
  # Source: [JCRE 3.2, s6.1.3 Object Ownership](../../refs/3.2/JCRESpec_3.2.pdf#page=55)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object ownership rules
    Given an object is created in the Java Card platform
    Then the object is associated with the currently active context
    And the object is owned by the applet instance within the currently active context when instantiated
    And an object can be owned by an applet instance or by the Java Card RE
    And every applet instance belongs to a context; all applet instances from the same CAP File belong to the same context
    And every object is owned by an applet instance (identified by its AID) or the Java Card RE

  # ---------------------------------------------------------------------------
  # 6.1.4 Object Access
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.1.4 Object Access](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=46)
  # Source: [JCRE 3.1, s6.1.4 Object Access](../../refs/3.1/JCRESpec_3.1.pdf#page=54)
  # Source: [JCRE 3.2, s6.1.4 Object Access](../../refs/3.2/JCRESpec_3.2.pdf#page=56)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object access restricted to owning context
    Given an object exists in the Java Card platform object space
    Then in general the object can only be accessed by its owning context (when the owning context is the currently active context)
    And the firewall prevents an object from being accessed by another applet in a different context
    And an object is accessed when one of the following bytecodes is executed using the object's reference:
      | bytecode        |
      | getfield        |
      | putfield        |
      | invokevirtual   |
      | invokeinterface |
      | athrow          |
      | <T>aload        |
      | <T>astore       |
      | arraylength     |
      | checkcast       |
      | instanceof      |
    And a SecurityException is thrown if the owner context does not match the currently active context

  # ---------------------------------------------------------------------------
  # 6.1.5 Transient Objects and Contexts
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.1.5 Transient Objects and Contexts](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=47)
  # Source: [JCRE 3.1, s6.1.5 Transient Objects and Contexts](../../refs/3.1/JCRESpec_3.1.pdf#page=55)
  # Source: [JCRE 3.2, s6.1.5 Transient Objects and Contexts](../../refs/3.2/JCRESpec_3.2.pdf#page=57)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_RESET transient objects - owning context only
    Given a transient object of CLEAR_ON_RESET type exists
    Then it behaves like persistent objects in that it can be accessed only when the currently active context is the object's owning context

  # Source: [JCRE 3.0.5, s6.1.5 Transient Objects and Contexts](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=47)
  # Source: [JCRE 3.1, s6.1.5 Transient Objects and Contexts](../../refs/3.1/JCRESpec_3.1.pdf#page=55)
  # Source: [JCRE 3.2, s6.1.5 Transient Objects and Contexts](../../refs/3.2/JCRESpec_3.2.pdf#page=57)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_DESELECT transient objects - currently selected applet context only
    Given a transient object of CLEAR_ON_DESELECT type exists
    Then it can only be created or accessed when the currently active context is the context of the currently selected applet
    And if any makeTransient factory method of JCSystem is called to create a CLEAR_ON_DESELECT object when the active context is not the currently selected applet's context, a SystemException with reason ILLEGAL_TRANSIENT is thrown
    And if an attempt is made to access a CLEAR_ON_DESELECT object when the active context is not the currently selected applet's context, a SecurityException shall be thrown

  # Source: [JCRE 3.0.5, s6.1.5 Transient Objects and Contexts](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=47)
  # Source: [JCRE 3.1, s6.1.5 Transient Objects and Contexts](../../refs/3.1/JCRESpec_3.1.pdf#page=55)
  # Source: [JCRE 3.2, s6.1.5 Transient Objects and Contexts](../../refs/3.2/JCRESpec_3.2.pdf#page=57)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: CLEAR_ON_DESELECT transient objects shared within same CAP file
    Given applets are part of the same CAP file and share the same context
    Then every applet instance from a CAP file shares all its object instances with all other instances from the same CAP file
    And this includes transient objects of both CLEAR_ON_RESET and CLEAR_ON_DESELECT type
    And the CLEAR_ON_DESELECT transient objects shall be accessible when any of the applet instances in the same context is the currently selected applet

  # ---------------------------------------------------------------------------
  # 6.1.6 Static Fields and Methods
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.1.6 Static Fields and Methods](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=47)
  # Source: [JCRE 3.1, s6.1.6 Static Fields and Methods](../../refs/3.1/JCRESpec_3.1.pdf#page=56)
  # Source: [JCRE 3.2, s6.1.6 Static Fields and Methods](../../refs/3.2/JCRESpec_3.2.pdf#page=58)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Static fields and methods - no context check or switch
    Given a class static field is accessed or a static method is invoked
    Then there is no runtime context check performed on static field access
    And there is no context switch when a static method is invoked
    And similarly, invokespecial causes no context switch
    And public static fields and public static methods are accessible from any context
    And static methods execute in the same context as their caller

  # ---------------------------------------------------------------------------
  # 6.2.1 Java Card RE Entry Point Objects
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=48)
  # Source: [JCRE 3.1, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=56)
  # Source: [JCRE 3.2, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=58)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Temporary Java Card RE Entry Point Objects
    Given certain Java Card RE owned objects are designated as temporary entry point objects
    Then their methods can be invoked from any context, causing a context switch to the Java Card RE context
    But references to these objects cannot be stored in class variables, instance variables, or array components
    And the Java Card RE detects and restricts attempts to store references to these objects
    And the APDU object and all Java Card RE owned exception objects are examples of temporary entry point objects

  # Source: [JCRE 3.0.5, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=48)
  # Source: [JCRE 3.1, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=56)
  # Source: [JCRE 3.2, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=58)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Permanent Java Card RE Entry Point Objects
    Given certain Java Card RE owned objects are designated as permanent entry point objects
    Then their methods can be invoked from any context, causing a context switch to the Java Card RE context
    And additionally, references to these objects can be stored and freely re-used
    And Java Card RE owned AID instances are examples of permanent entry point objects

  # Source: [JCRE 3.0.5, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=48)
  # Source: [JCRE 3.1, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=56)
  # Source: [JCRE 3.2, s6.2.1 Java Card RE Entry Point Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=58)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Entry point objects - only methods accessible through firewall
    Given any Java Card RE Entry Point Object (temporary or permanent) exists
    Then only the methods of these objects are accessible through the firewall
    And the fields of these objects are still protected by the firewall
    And the fields can only be accessed by the Java Card RE context

  # ---------------------------------------------------------------------------
  # 6.2.2 Global Arrays
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.2.2 Global Arrays](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=49)
  # Source: [JCRE 3.1, s6.2.2.1 Sharing using Global Arrays](../../refs/3.1/JCRESpec_3.1.pdf#page=58)
  # Source: [JCRE 3.2, s6.2.2.1 Sharing using Global Arrays](../../refs/3.2/JCRESpec_3.2.pdf#page=60)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Global array access rules
    Given all global arrays are temporary global array objects owned by the Java Card RE context
    Then they can be accessed from any context
    But since they are temporary, references to them cannot be stored in class variables, instance variables, or array components
    And the Java Card RE detects and restricts attempts to store references; an attempt results in a SecurityException
    And only arrays can be designated as global
    And applets may create global arrays via JCSystem.makeGlobalArray()
    And the APDU buffer and the byte array parameter (bArray) to the applet's install method are global arrays

  # Source: [JCRE 3.0.5, s6.2.2 Global Arrays](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=49)
  # Source: [JCRE 3.1, s6.2.2.1 Sharing using Global Arrays](../../refs/3.1/JCRESpec_3.1.pdf#page=58)
  # Source: [JCRE 3.2, s6.2.2.1 Sharing using Global Arrays](../../refs/3.2/JCRESpec_3.2.pdf#page=60)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: APDU buffer content clearing on applet change
    Given the APDU buffer is a global array
    When another applet becomes the currently selected applet
    Then the previous content of the APDU buffer must be made unavailable
    And this prevents an applet's potentially sensitive data from being leaked to another applet via the global APDU buffer

  # ---------------------------------------------------------------------------
  # 6.2.3 Java Card RE Privileges
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.2.3 Java Card RE Privileges](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=50)
  # Source: [JCRE 3.1, s6.2.3 Java Card RE Privileges](../../refs/3.1/JCRESpec_3.1.pdf#page=58)
  # Source: [JCRE 3.2, s6.2.3 Java Card RE Privileges](../../refs/3.2/JCRESpec_3.2.pdf#page=60)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Java Card RE system context privileges
    Given the Java Card RE context is the "system" context
    Then the Java Card RE can invoke a method of any object on the card
    And the Java Card RE can access both methods and fields of any object
    And during such an invocation, a context switch occurs from the Java Card RE context to the context of the applet that owns the object
    But although the Java Card RE could invoke any method through the firewall, it shall only invoke select, process, deselect, and getShareableInterfaceObject
    And the Java Card RE context is the currently active context when the VM begins running after a card reset
    And the Java Card RE context is the "root" context and is always either the currently active context or the bottom context saved on the stack

  # ---------------------------------------------------------------------------
  # 6.2.4 Shareable Interfaces (SIO pattern)
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.2.4 Shareable Interfaces](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=50)
  # Source: [JCRE 3.1, s6.2.4 Shareable Interfaces](../../refs/3.1/JCRESpec_3.1.pdf#page=59)
  # Source: [JCRE 3.2, s6.2.4 Shareable Interfaces](../../refs/3.2/JCRESpec_3.2.pdf#page=61)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Shareable Interface Object definition and access
    Given an object instance of a class implementing a shareable interface exists (a Shareable Interface Object, SIO)
    Then to the owning context, the SIO is a normal object whose fields and methods can be accessed
    And to any other context, the SIO is an instance of the shareable interface
    And only the methods defined in the shareable interface are accessible to other contexts
    And all other fields and methods of the SIO are protected by the firewall

  # Source: [JCRE 3.0.5, s6.2.4.1 Server Applet A Builds a Shareable Interface Object](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=51)
  # Source: [JCRE 3.1, s6.2.4.1 Server Applet A Builds a Shareable Interface Object](../../refs/3.1/JCRESpec_3.1.pdf#page=59)
  # Source: [JCRE 3.2, s6.2.4.1 Server Applet A Builds a Shareable Interface Object](../../refs/3.2/JCRESpec_3.2.pdf#page=61)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Server applet builds a Shareable Interface Object
    Given server applet A wants to share services with other applets
    Then step 1: applet A defines a shareable interface SI that extends javacard.framework.Shareable
    And the methods defined in SI represent the services that applet A makes accessible
    And step 2: applet A defines a class C that implements SI; class C may define other methods and fields protected by the firewall
    And step 3: applet A creates an object instance O of class C; O belongs to applet A and the firewall allows A to access all fields and methods of O

  # Source: [JCRE 3.0.5, s6.2.4.2 Client Applet B Obtains the Shareable Interface Object](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=51)
  # Source: [JCRE 3.1, s6.2.4.2 Client Applet B Obtains the Shareable Interface Object](../../refs/3.1/JCRESpec_3.1.pdf#page=60)
  # Source: [JCRE 3.2, s6.2.4.2 Client Applet B Obtains the Shareable Interface Object](../../refs/3.2/JCRESpec_3.2.pdf#page=62)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Client applet obtains the Shareable Interface Object
    Given client applet B wants to access server applet A's shared object O
    Then step 1: applet B creates an object reference SIO of type SI
    And step 2: applet B invokes JCSystem.getAppletShareableInterfaceObject to request a shared interface from applet A
    And step 3: applet A receives the request and the AID of the requester (B) via Applet.getShareableInterfaceObject
    And step 4: if applet A agrees to share with B, it returns a reference to O (as type Shareable -- no fields or methods visible)
    And step 5: applet B receives the reference, casts it to interface type SI, and stores it; only SI methods are visible, firewall prevents access to other fields and methods of O

  # Source: [JCRE 3.0.5, s6.2.4.3 Client Applet B Requests Services from Applet A](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=52)
  # Source: [JCRE 3.1, s6.2.4.3 Client Applet B Requests Services from Applet A](../../refs/3.1/JCRESpec_3.1.pdf#page=60)
  # Source: [JCRE 3.2, s6.2.4.3 Client Applet B Requests Services from Applet A](../../refs/3.2/JCRESpec_3.2.pdf#page=62)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Client applet requests services via SIO
    Given client applet B has obtained a reference to server applet A's SIO
    When applet B invokes one of the shareable interface methods of SIO
    Then step 1: the Java Card VM performs a context switch; B's context is saved on stack and A's context (owner of O) becomes active
    And step 2: the SI method can determine client B's AID via JCSystem.getPreviousContextAID
    And step 3: the firewall allows the SI method to access all fields and methods of O and other objects in A's context
    And step 4: the SI method can access parameters passed by B and can provide a return value to B
    And step 5: on return, a restoring context switch occurs and B's context is popped from the stack and becomes active again
    And step 6: the firewall again prevents B from accessing non-shared objects in A's context

  # ---------------------------------------------------------------------------
  # 6.2.5 Determining the Previous Context
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.2.5 Determining the Previous Context](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=52)
  # Source: [JCRE 3.1, s6.2.5 Determining the Previous Context](../../refs/3.1/JCRESpec_3.1.pdf#page=61)
  # Source: [JCRE 3.2, s6.2.5 Determining the Previous Context](../../refs/3.2/JCRESpec_3.2.pdf#page=63)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: getPreviousContextAID returns caller's AID
    Given an applet calls JCSystem.getPreviousContextAID
    Then the Java Card RE shall return the instance AID of the applet instance active at the time of the last context switch
    And if the context of the applet was entered directly from the Java Card RE context, the method returns null
    And an applet that may be accessed either from within itself or via a shareable interface should check for null before performing caller AID authentication

  # ---------------------------------------------------------------------------
  # 6.2.7 Obtaining Shareable Interface Objects
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.2.7.1 Applet.getShareableInterfaceObject(AID, byte) Method](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=53)
  # Source: [JCRE 3.1, s6.2.7.1 Applet.getShareableInterfaceObject(AID, byte) Method](../../refs/3.1/JCRESpec_3.1.pdf#page=62)
  # Source: [JCRE 3.2, s6.2.7.1 Applet.getShareableInterfaceObject(AID, byte) Method](../../refs/3.2/JCRESpec_3.2.pdf#page=64)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Applet.getShareableInterfaceObject method
    Given a server applet instance implements getShareableInterfaceObject(AID, byte)
    Then the default behavior shall return null (indicating no inter-applet communication)
    And a server applet that intends to be invoked by another applet needs to override this method
    And the method should examine the clientAID and parameter; if not recognized, return null
    And the server can support multiple types of shared interfaces using clientAID and parameter to determine which SIO to return

  # Source: [JCRE 3.0.5, s6.2.7.2 JCSystem.getAppletShareableInterfaceObject Method](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=54)
  # Source: [JCRE 3.1, s6.2.7.2 JCSystem.getAppletShareableInterfaceObject Method](../../refs/3.1/JCRESpec_3.1.pdf#page=62)
  # Source: [JCRE 3.2, s6.2.7.2 JCSystem.getAppletShareableInterfaceObject Method](../../refs/3.2/JCRESpec_3.2.pdf#page=64)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: JCSystem.getAppletShareableInterfaceObject method
    Given a client applet invokes JCSystem.getAppletShareableInterfaceObject(serverAID, parameter)
    Then step 1: the Java Card RE searches the internal applet table for one with serverAID; if not found, null is returned
    And step 2: if the server applet is not multiselectable and is currently active on another logical channel, a SecurityException is thrown
    And step 3: the Java Card RE invokes the server applet's getShareableInterfaceObject method, passing the clientAID and parameter
    And step 4: a context switch occurs to the server applet; its implementation of getShareableInterfaceObject returns a SIO (or null)
    And step 5: getAppletShareableInterfaceObject returns the same SIO (or null) to its caller
    And the implementation shall make it impossible for the client to tell which of several null conditions caused a null return

  # ---------------------------------------------------------------------------
  # 6.2.8 Class and Object Access Behavior (11 rules)
  # ---------------------------------------------------------------------------
  # Source: [JCRE 3.0.5, s6.2.8.1 Accessing Static Class Fields](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=55)
  # Source: [JCRE 3.1, s6.2.8.1 Accessing Static Class Fields](../../refs/3.1/JCRESpec_3.1.pdf#page=63)
  # Source: [JCRE 3.2, s6.2.8.1 Accessing Static Class Fields](../../refs/3.2/JCRESpec_3.2.pdf#page=65)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 1 - Accessing Static Class Fields (getstatic, putstatic)
    Given a getstatic or putstatic bytecode is executed
    Then if the Java Card RE is the currently active context, access is allowed
    And if the bytecode is putstatic and the field is a reference type and the reference is to a temporary object, access is denied (SecurityException)
    And otherwise, access is allowed

  # Source: [JCRE 3.0.5, s6.2.8.2 Accessing Array Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=55)
  # Source: [JCRE 3.1, s6.2.8.2 Accessing Array Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=64)
  # Source: [JCRE 3.2, s6.2.8.2 Accessing Array Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=66)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 2 - Accessing Array Objects (<T>aload, <T>astore, arraylength, checkcast, instanceof)
    Given a <T>aload, <T>astore, arraylength, checkcast, or instanceof bytecode is executed on an array object
    Then if the Java Card RE is the currently active context, access is allowed
    And if the bytecode is aastore and the component is a reference type and the reference is to a temporary object, access is denied
    And if the bytecode is <T>astore and refers to an array view without the write access attribute set, access is denied
    And if the bytecode is <T>aload and refers to an array view without the read access attribute set, access is denied
    And if the array is a CLEAR_ON_DESELECT transient array owned by an applet not in the currently selected applet's context, access is denied
    And if the array is owned by an applet in the currently active context, access is allowed
    And if the array is designated global, access is allowed
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.3 Accessing Class Instance Object Fields](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=55)
  # Source: [JCRE 3.1, s6.2.8.3 Accessing Class Instance Object Fields](../../refs/3.1/JCRESpec_3.1.pdf#page=64)
  # Source: [JCRE 3.2, s6.2.8.3 Accessing Class Instance Object Fields](../../refs/3.2/JCRESpec_3.2.pdf#page=66)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 3 - Accessing Class Instance Object Fields (getfield, putfield)
    Given a getfield or putfield bytecode is executed on a class instance object
    Then if the Java Card RE is the currently active context, access is allowed
    And if the bytecode is putfield and the field is a reference type and the reference is to a temporary object, access is denied
    And if the object is owned by an applet in the currently active context, access is allowed
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.4 Accessing Class Instance Object Methods](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=55)
  # Source: [JCRE 3.1, s6.2.8.4 Accessing Class Instance Object Methods](../../refs/3.1/JCRESpec_3.1.pdf#page=64)
  # Source: [JCRE 3.2, s6.2.8.4 Accessing Class Instance Object Methods](../../refs/3.2/JCRESpec_3.2.pdf#page=66)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 4 - Accessing Class Instance Object Methods (invokevirtual)
    Given an invokevirtual bytecode is executed on a class instance object
    Then if the object is owned by an applet in the currently active context, access is allowed
    And if the object is designated a Java Card RE Entry Point Object, access is allowed and context is switched to the object owner's context (Java Card RE)
    And if Java Card RE is the currently active context, access is allowed and context is switched to the object owner's context
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.5 Accessing Standard Interface Methods](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=56)
  # Source: [JCRE 3.1, s6.2.8.5 Accessing Standard Interface Methods](../../refs/3.1/JCRESpec_3.1.pdf#page=65)
  # Source: [JCRE 3.2, s6.2.8.5 Accessing Standard Interface Methods](../../refs/3.2/JCRESpec_3.2.pdf#page=67)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 5 - Accessing Standard Interface Methods (invokeinterface)
    Given an invokeinterface bytecode is executed for a standard (non-shareable) interface method
    Then if the object is owned by an applet in the currently active context, access is allowed
    And if the object is designated a Java Card RE Entry Point Object, access is allowed and context switches to owner (Java Card RE)
    And if Java Card RE is the currently active context, access is allowed and context switches to the object owner's context
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.6 Accessing Shareable Interface Methods](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=56)
  # Source: [JCRE 3.1, s6.2.8.6 Accessing Shareable Interface Methods](../../refs/3.1/JCRESpec_3.1.pdf#page=65)
  # Source: [JCRE 3.2, s6.2.8.6 Accessing Shareable Interface Methods](../../refs/3.2/JCRESpec_3.2.pdf#page=67)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 6 - Accessing Shareable Interface Methods (invokeinterface)
    Given an invokeinterface bytecode is executed for a shareable interface method
    Then if the object is owned by an applet in the currently active context, access is allowed
    And if the object is owned by a non-multiselectable applet not in the currently selected applet's context and active on another channel, access is denied
    And if the object's class implements a Shareable interface and the interface being invoked extends Shareable, access is allowed and context switches to the object owner's context
    And if Java Card RE is the currently active context, access is allowed and context switches to the object owner's context
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.7 Throwing Exception Objects](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=56)
  # Source: [JCRE 3.1, s6.2.8.7 Throwing Exception Objects](../../refs/3.1/JCRESpec_3.1.pdf#page=65)
  # Source: [JCRE 3.2, s6.2.8.7 Throwing Exception Objects](../../refs/3.2/JCRESpec_3.2.pdf#page=67)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 7 - Throwing Exception Objects (athrow)
    Given an athrow bytecode is executed
    Then if the exception object is owned by an applet in the currently active context, access is allowed
    And if the exception object is designated a Java Card RE Entry Point Object, access is allowed
    And if the Java Card RE is the currently active context, access is allowed
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.8 Accessing Classes](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=57)
  # Source: [JCRE 3.1, s6.2.8.8 Accessing Classes](../../refs/3.1/JCRESpec_3.1.pdf#page=65)
  # Source: [JCRE 3.2, s6.2.8.8 Accessing Classes](../../refs/3.2/JCRESpec_3.2.pdf#page=67)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 8 - Accessing Classes (checkcast, instanceof on class type)
    Given a checkcast or instanceof bytecode is executed with a class type operand
    Then if the object is owned by an applet in the currently active context, access is allowed
    And if the object is designated a Java Card RE Entry Point Object, access is allowed
    And if the Java Card RE is the currently active context, access is allowed
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.9 Accessing Standard Interfaces](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=57)
  # Source: [JCRE 3.1, s6.2.8.9 Accessing Standard Interfaces](../../refs/3.1/JCRESpec_3.1.pdf#page=66)
  # Source: [JCRE 3.2, s6.2.8.9 Accessing Standard Interfaces](../../refs/3.2/JCRESpec_3.2.pdf#page=68)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 9 - Accessing Standard Interfaces (checkcast, instanceof on standard interface)
    Given a checkcast or instanceof bytecode is executed with a standard interface type operand
    Then if the object is owned by an applet in the currently active context, access is allowed
    And if the object is designated a Java Card RE Entry Point Object, access is allowed
    And if the Java Card RE is the currently active context, access is allowed
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.10 Accessing Shareable Interfaces](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=57)
  # Source: [JCRE 3.1, s6.2.8.10 Accessing Shareable Interfaces](../../refs/3.1/JCRESpec_3.1.pdf#page=66)
  # Source: [JCRE 3.2, s6.2.8.10 Accessing Shareable Interfaces](../../refs/3.2/JCRESpec_3.2.pdf#page=68)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 10 - Accessing Shareable Interfaces (checkcast, instanceof on shareable interface)
    Given a checkcast or instanceof bytecode is executed with a shareable interface type operand
    Then if the object is owned by an applet in the currently active context, access is allowed
    And if the object's class implements a Shareable interface, and the object is being cast to (checkcast) or verified as instance of (instanceof) an interface that extends Shareable, access is allowed
    And if the Java Card RE is the currently active context, access is allowed
    And otherwise, access is denied

  # Source: [JCRE 3.0.5, s6.2.8.11 Accessing Array Object Methods](../../refs/3.0.5/JCRESpec_3.0.5.pdf#page=57)
  # Source: [JCRE 3.1, s6.2.8.11 Accessing Array Object Methods](../../refs/3.1/JCRESpec_3.1.pdf#page=66)
  # Source: [JCRE 3.2, s6.2.8.11 Accessing Array Object Methods](../../refs/3.2/JCRESpec_3.2.pdf#page=68)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Rule 11 - Accessing Array Object Methods (invokevirtual on array)
    Given an invokevirtual bytecode is executed on an array object
    Then if the array is a CLEAR_ON_DESELECT transient array owned by an applet not in the currently selected applet's context, access is denied
    And if the array is owned by an applet in the currently active context, access is allowed
    And if the array is designated a global array, access is allowed and context switches to the array owner's context (Java Card RE context)
    And if Java Card RE is the currently active context, access is allowed and context switches to the array owner's context
    And otherwise, access is denied
    And the method access behavior of global arrays is identical to that of Java Card RE Entry Point Objects
