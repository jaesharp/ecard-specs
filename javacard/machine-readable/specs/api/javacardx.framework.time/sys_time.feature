@javacardx
@javacardx.framework.time
@v3.1
@v3.2
Feature: Time Framework -- SysTime, TimeDuration, DateTimeException
  The javacardx.framework.time package provides system uptime access and
  time duration arithmetic for the Java Card platform.

  SysTime provides access to system uptime. TimeDuration represents
  a signed time duration with configurable units. DateTimeException signals errors.

  # Source: [JavaCard 3.2 API, time package](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/package-summary.html)
  Background:
    Given a JavaCard runtime environment

  # ========== SysTime ==========
  Scenario: SysTime.uptime returns system uptime as a TimeDuration
    When SysTime.uptime(TimeDuration dest) is called
    Then the system uptime since the last card reset is stored in dest
    And the returned TimeDuration represents the elapsed time

  # Source: [JavaCard 3.2 API, uptime](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/SysTime.html#uptime(TimeDuration))
  # ========== TimeDuration Constants ==========
  Scenario Outline: TimeDuration defines time unit constants
    Then class TimeDuration defines static byte constant "<constant>" for time unit "<unit>"

    # Source: [JavaCard 3.2 API, TimeDuration](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html)
    Examples:
      | constant | unit         |
      | MICROS   | microseconds |
      | MILLIS   | milliseconds |
      | SECONDS  | seconds      |
      | MINUTES  | minutes      |
      | HOURS    | hours        |
      | DAYS     | days         |

  # ========== TimeDuration Factory ==========
  Scenario: TimeDuration.getInstance creates a persistent TimeDuration
    When TimeDuration.getInstance(byte unit) is called
    Then a persistent TimeDuration instance with the specified time unit is returned
    And the initial value is zero

  # Source: [JavaCard 3.2 API, getInstance](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#getInstance(byte))
  Scenario: TimeDuration.getInstance creates a transient TimeDuration
    When TimeDuration.getInstance(byte unit, byte memoryType) is called
    Then a TimeDuration instance with the specified memory type (transient/persistent) is returned

  # Source: [JavaCard 3.2 API, getInstance](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#getInstance(byte,byte))
  Scenario: TimeDuration.getMemoryType returns the memory type
    Given a TimeDuration instance
    When getMemoryType() is called
    Then the memory type (MEMORY_TYPE_PERSISTENT or MEMORY_TYPE_TRANSIENT_*) is returned

  # Source: [JavaCard 3.2 API, getMemoryType](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#getMemoryType)
  # ========== TimeDuration Arithmetic ==========
  Scenario: TimeDuration.plus adds another TimeDuration
    Given two TimeDuration instances
    When plus(TimeDuration other) is called
    Then the other duration is added to this duration

  # Source: [JavaCard 3.2 API, plus](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#plus(TimeDuration))
  Scenario: TimeDuration.plus adds a scalar amount
    Given a TimeDuration instance
    When plus(short amount, byte unit) is called
    Then the specified amount in the given unit is added to this duration

  # Source: [JavaCard 3.2 API, plus](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#plus(short,byte))
  Scenario: TimeDuration.minus subtracts another TimeDuration
    Given two TimeDuration instances
    When minus(TimeDuration other) is called
    Then the other duration is subtracted from this duration

  # Source: [JavaCard 3.2 API, minus](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#minus(TimeDuration))
  Scenario: TimeDuration.minus subtracts a scalar amount
    Given a TimeDuration instance
    When minus(short amount, byte unit) is called
    Then the specified amount is subtracted from this duration

  # Source: [JavaCard 3.2 API, minus](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#minus(short,byte))
  Scenario: TimeDuration.neg negates the duration
    Given a TimeDuration instance
    When neg() is called
    Then the sign of the duration is reversed

  # Source: [JavaCard 3.2 API, neg](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#neg)
  Scenario: TimeDuration.abs returns absolute value
    Given a negative TimeDuration instance
    When abs() is called
    Then the duration becomes positive

  # Source: [JavaCard 3.2 API, abs](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#abs)
  # ========== TimeDuration Query and Comparison ==========
  Scenario: TimeDuration.isNegative checks sign
    Given a TimeDuration instance
    When isNegative() is called
    Then returns true if the duration is negative

  # Source: [JavaCard 3.2 API, isNegative](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#isNegative)
  Scenario: TimeDuration.compareTo compares with another TimeDuration
    Given two TimeDuration instances
    When compareTo(TimeDuration other) is called
    Then returns 0 if equal, positive if this > other, negative if this < other

  # Source: [JavaCard 3.2 API, compareTo](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#compareTo(TimeDuration))
  Scenario: TimeDuration.set sets the duration value
    Given a TimeDuration instance
    When set(short amount, byte unit) is called
    Then the duration is set to the specified amount and unit

  # Source: [JavaCard 3.2 API, set](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#set(short,byte))
  Scenario: TimeDuration.reset clears the duration to zero
    Given a TimeDuration instance
    When reset() is called
    Then the duration is set to zero

  # Source: [JavaCard 3.2 API, reset](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#reset)
  Scenario: TimeDuration.toBytes serializes the duration
    Given a TimeDuration instance
    When toBytes(byte[] dest, short offset) is called
    Then the duration is serialized to the byte array

  # Source: [JavaCard 3.2 API, toBytes](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#toBytes(byte%5B%5D,short))
  Scenario: TimeDuration.getByteLength returns serialized length
    Given a TimeDuration instance
    When getByteLength() is called
    Then the number of bytes needed to serialize the duration is returned

  # Source: [JavaCard 3.2 API, getByteLength](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/TimeDuration.html#getByteLength)
  # ========== DateTimeException ==========
  Scenario: DateTimeException defines reason codes
    Then class DateTimeException defines static short constant "INVALID_VALUE" for invalid time value
    And class DateTimeException defines static short constant "INVALID_UNIT" for invalid time unit

  # Source: [JavaCard 3.2 API, DateTimeException](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/DateTimeException.html)
  Scenario: DateTimeException.throwIt throws a DateTimeException
    When DateTimeException.throwIt(short reason) is called
    Then a DateTimeException is thrown with the specified reason code


# Source: [JavaCard 3.2 API, throwIt](../../../refs/javadoc-3.2/api_classic/javacardx/framework/time/DateTimeException.html#throwIt(short))