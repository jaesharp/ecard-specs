@javacardx
@javacardx.annotations
@v3.0.5
@v3.1
@v3.2
Feature: Annotations -- StringDef and StringPool
  The javacardx.annotations package provides annotations for Java Card applet
  development. StringDef annotates String constants for compile-time pooling.
  StringPool marks a class as containing pooled string definitions.

  These annotations are processed at build time and do not have runtime behavior.

  # Source: [JavaCard 3.2 API, annotations package](../.refs/javadoc-3.2/api_classic/javacardx/annotations/package-summary.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: StringDef annotation marks a String constant for pooling
    Then the @StringDef annotation is applied to String constant fields
    And it indicates the string value should be included in the string constant pool
    And the annotation has retention policy for compile/build time processing

  # Source: [JavaCard 3.2 API, StringDef](../.refs/javadoc-3.2/api_classic/javacardx/annotations/StringDef.html)
  Scenario: StringPool annotation marks a class containing pooled strings
    Then the @StringPool annotation is applied at the class level
    And it indicates the class contains @StringDef annotated fields for pooling
    And the annotation has retention policy for compile/build time processing


# Source: [JavaCard 3.2 API, StringPool](../.refs/javadoc-3.2/api_classic/javacardx/annotations/StringPool.html)