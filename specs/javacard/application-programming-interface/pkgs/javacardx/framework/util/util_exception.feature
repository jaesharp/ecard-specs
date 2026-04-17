@javacardx
@javacardx.framework.util
@v3.0.5
@v3.1
@v3.2
Feature: UtilException -- Utility Package Exception
  The UtilException class represents exceptions thrown by the javacardx.framework.util
  package utilities, such as ArrayLogic.

  # Source: [JavaCard 3.2 API, UtilException](../../../../.refs/javadoc-3.2/api_classic/javacardx/framework/util/UtilException.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: UtilException defines reason code ILLEGAL_VALUE
    Then class UtilException defines static short constant "ILLEGAL_VALUE" for invalid input parameters

  # Source: [JavaCard 3.2 API, ILLEGAL_VALUE](../../../../.refs/javadoc-3.2/api_classic/javacardx/framework/util/UtilException.html#ILLEGAL_VALUE)
  Scenario: UtilException defines reason code TYPE_MISMATCHED
    Then class UtilException defines static short constant "TYPE_MISMATCHED" for incompatible array types

  # Source: [JavaCard 3.2 API, TYPE_MISMATCHED](../../../../.refs/javadoc-3.2/api_classic/javacardx/framework/util/UtilException.html#TYPE_MISMATCHED)
  Scenario: UtilException.throwIt throws a UtilException
    When UtilException.throwIt(short reason) is called
    Then a UtilException is thrown with the specified reason code
    And the JCRE may reuse a single UtilException instance


# Source: [JavaCard 3.2 API, UtilException.throwIt](../../../../.refs/javadoc-3.2/api_classic/javacardx/framework/util/UtilException.html#throwIt(short))