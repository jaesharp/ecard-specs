@javacardx @javacardx.security.util @v3.1 @v3.2
Feature: MonotonicCounter -- Persistent Monotonically Increasing Counter
  The MonotonicCounter class provides a persistent counter that can only be
  incremented, never decremented. It is used for replay protection, sequence
  numbering, and other security-critical counting operations.

  # Source: [JavaCard 3.2 API, MonotonicCounter](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html)

  Background:
    Given a JavaCard runtime environment

  # ========== Factory Method ==========

  Scenario: MonotonicCounter.getInstance creates a counter instance
    When MonotonicCounter.getInstance(short size, byte memoryType) is called
    Then a MonotonicCounter with the specified byte size is returned
    And the memory type determines persistent or transient storage
    # Source: [JavaCard 3.2 API, getInstance](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#getInstance(short,byte))

  # ========== Query Methods ==========

  Scenario: MonotonicCounter.getMemoryType returns the memory type
    Given a MonotonicCounter instance
    When getMemoryType() is called
    Then the memory type (persistent or transient) is returned
    # Source: [JavaCard 3.2 API, getMemoryType](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#getMemoryType)

  Scenario: MonotonicCounter.getSize returns the counter size in bytes
    Given a MonotonicCounter instance
    When getSize() is called
    Then the size in bytes of the counter value is returned
    # Source: [JavaCard 3.2 API, getSize](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#getSize)

  # ========== Value Operations ==========

  Scenario: MonotonicCounter.setValue sets the counter value
    Given a MonotonicCounter instance
    When setValue(byte[] bArray, short bOff, short bLen) is called
    Then the counter is set to the value from bArray
    And the new value must be greater than or equal to the current value
    # Source: [JavaCard 3.2 API, setValue](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#setValue(byte%5B%5D,short,short))

  Scenario: MonotonicCounter.get retrieves the current counter value
    Given a MonotonicCounter instance
    When get(byte[] dest, short destOff) is called
    Then the current counter value is copied to dest
    # Source: [JavaCard 3.2 API, get](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#get(byte%5B%5D,short))

  Scenario: MonotonicCounter.incrementBy increments the counter
    Given a MonotonicCounter instance
    When incrementBy(short amount) is called
    Then the counter value is increased by the specified amount
    And the counter can never be decremented
    # Source: [JavaCard 3.2 API, incrementBy](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#incrementBy(short))

  # ========== Comparison ==========

  Scenario: MonotonicCounter.compareTo compares with a byte array value
    Given a MonotonicCounter instance
    When compareTo(byte[] bArray, short bOff, short bLen) is called
    Then returns 0 if equal, positive if counter > value, negative if counter < value
    # Source: [JavaCard 3.2 API, compareTo](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#compareTo(byte%5B%5D,short,short))

  Scenario: MonotonicCounter.compareTo compares with another MonotonicCounter
    Given two MonotonicCounter instances
    When compareTo(MonotonicCounter other) is called
    Then returns 0 if equal, positive if this > other, negative if this < other
    # Source: [JavaCard 3.2 API, compareTo](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#compareTo(MonotonicCounter))

  Scenario: MonotonicCounter.equalsMax checks if the counter is at maximum
    Given a MonotonicCounter instance
    When equalsMax() is called
    Then returns true if the counter has reached its maximum representable value
    # Source: [JavaCard 3.2 API, equalsMax](../../java_card_spec-3_2_0-b_185-18_jan_2023/api_classic/javacardx/security/util/MonotonicCounter.html#equalsMax)
