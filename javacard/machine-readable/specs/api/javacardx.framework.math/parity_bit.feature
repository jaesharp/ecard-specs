@javacardx
@javacardx.framework.math
@v3.0.5
@v3.1
@v3.2
Feature: ParityBit -- Parity Bit Setting Utility
  The ParityBit class provides a method for setting parity bits in byte arrays,
  typically used for DES key parity adjustment.

  # Source: [JavaCard 3.2 API, ParityBit](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/ParityBit.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: ParityBit.set adjusts parity bits
    When ParityBit.set(byte[] bArray, short bOff, short bLen, boolean isEven) is called
    Then the least significant bit of each byte in the range is set to achieve the requested parity
    And if isEven is true, even parity is set (even number of 1-bits per byte)
    And if isEven is false, odd parity is set (odd number of 1-bits per byte)

# Source: [JavaCard 3.2 API, set](../../../refs/javadoc-3.2/api_classic/javacardx/framework/math/ParityBit.html#set(byte%5B%5D,short,short,boolean))