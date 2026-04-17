@jcre
@vm-lifetime
Feature: Java Card Virtual Machine Lifetime
  The Java Card VM execution lifetime is the lifetime of the secure element.
  Unlike a standard JVM which runs as an OS process and is destroyed on termination,
  the Java Card VM persists across power cycles. When power is removed the VM only
  stops temporarily; on next reset it recovers its previous object heap from
  persistent storage.

  # Source: [JCRE 3.0.5, s2 Lifetime of the Java Card Virtual Machine](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=17)
  # Source: [JCRE 3.1, s2 Lifetime of the Java Card Virtual Machine](../refs/3.1/JCRESpec_3.1.pdf#page=19)
  # Source: [JCRE 3.2, s2 Lifetime of the Java Card Virtual Machine](../refs/3.2/JCRESpec_3.2.pdf#page=19)
  Background:
    Given a Java Card secure element with a compliant JCRE implementation

  # Source: [JCRE 3.0.5, s2 Lifetime of the Java Card Virtual Machine](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=17)
  # Source: [JCRE 3.1, s2 Lifetime of the Java Card Virtual Machine](../refs/3.1/JCRESpec_3.1.pdf#page=19)
  # Source: [JCRE 3.2, s2 Lifetime of the Java Card Virtual Machine](../refs/3.2/JCRESpec_3.2.pdf#page=19)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: VM persistence across power cycles
    Given the Java Card VM is running on the secure element
    And persistent objects have been created on the object heap
    When power is removed from the secure element
    And power is reapplied and the secure element is reset
    Then the VM shall start again
    And the VM shall recover its previous object heap from persistent storage
    And all persistent objects shall be available with their previous state

  # Source: [JCRE 3.0.5, s2 Lifetime of the Java Card Virtual Machine](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=17)
  # Source: [JCRE 3.1, s2 Lifetime of the Java Card Virtual Machine](../refs/3.1/JCRESpec_3.1.pdf#page=19)
  # Source: [JCRE 3.2, s2 Lifetime of the Java Card Virtual Machine](../refs/3.2/JCRESpec_3.2.pdf#page=19)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Persistent storage of information across power loss
    Given the secure element uses persistent memory technology such as EEPROM
    When information is stored on the secure element
    And power is removed
    Then the information stored on the secure element shall be preserved
    And the VM shall appear to run forever from the perspective of applications

  # Source: [JCRE 3.0.5, s2.1 Card Initialization](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=17)
  # Source: [JCRE 3.1, s2.1 Initialization](../refs/3.1/JCRESpec_3.1.pdf#page=19)
  # Source: [JCRE 3.2, s2.1 Initialization](../refs/3.2/JCRESpec_3.2.pdf#page=19)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Secure element initialization
    Given the secure element initialization time is after masking and prior to personalization and issuance
    When the secure element is initialized
    Then the Java Card RE shall be initialized
    And the framework objects created by the Java Card RE shall exist for the lifetime of the virtual machine
    And the lifetimes of objects created by applets shall span power sessions as persistent objects

  # Source: [JCRE 3.0.5, s2.1 Card Initialization](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=17)
  # Source: [JCRE 3.1, s2.1 Initialization](../refs/3.1/JCRESpec_3.1.pdf#page=19)
  # Source: [JCRE 3.2, s2.1 Initialization](../refs/3.2/JCRESpec_3.2.pdf#page=19)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Power sessions definition
    Given the secure element is powered up
    When the secure element is exchanging streams of commands
    Then it is in a power session
    And when power is removed the power session ends
    And a new power session begins when power is reapplied

  # Source: [JCRE 3.0.5, s2.1 Card Initialization](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=17)
  # Source: [JCRE 3.1, s2.1 Initialization](../refs/3.1/JCRESpec_3.1.pdf#page=19)
  # Source: [JCRE 3.2, s2.1 Initialization](../refs/3.2/JCRESpec_3.2.pdf#page=19)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object persistence via Applet.register
    Given an applet calls the Applet.register method
    Then the Java Card RE shall store a reference to the instance of the applet object
    And the Java Card RE implementer shall ensure that instances of class applet are persistent

  # Source: [JCRE 3.0.5, s2.1 Card Initialization](../refs/3.0.5/JCRESpec_3.0.5.pdf#page=17)
  # Source: [JCRE 3.1, s2.1 Initialization](../refs/3.1/JCRESpec_3.1.pdf#page=19)
  # Source: [JCRE 3.2, s2.1 Initialization](../refs/3.2/JCRESpec_3.2.pdf#page=19)
  @v3.0.5
  @v3.1
  @v3.2
  Scenario: Object persistence via reference storage in persistent fields
    Given a reference to an object is stored in a persistent field or a class static field
    Then the referenced object shall be made persistent
    And this requirement preserves the integrity of the Java Card RE internal data structures
