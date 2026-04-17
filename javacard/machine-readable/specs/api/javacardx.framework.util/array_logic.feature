@javacardx
@javacardx.framework.util
@v3.0.5
@v3.1
@v3.2
Feature: ArrayLogic -- Generic Array Operations Utility
  The ArrayLogic class provides static utility methods for generic array operations
  including copy with type repacking, generic fill, compare, and find operations.
  These methods work across different primitive array types.

  # Source: [JavaCard 3.2 API, ArrayLogic](../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/ArrayLogic.html)
  Background:
    Given a JavaCard runtime environment

  Scenario: ArrayLogic.arrayCopyRepack copies with atomic transaction semantics
    When ArrayLogic.arrayCopyRepack(Object src, short srcOff, Object dest, short destOff, short length) is called
    Then elements are copied from src to dest with type conversion as needed
    And the copy is performed atomically (participates in transaction if active)
    And UtilException with TYPE_MISMATCHED is thrown if types are incompatible

  # Source: [JavaCard 3.2 API, ArrayLogic.arrayCopyRepack](../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/ArrayLogic.html#arrayCopyRepack(Object,short,Object,short,short))
  Scenario: ArrayLogic.arrayCopyRepackNonAtomic copies without transaction semantics
    When ArrayLogic.arrayCopyRepackNonAtomic(Object src, short srcOff, Object dest, short destOff, short length) is called
    Then elements are copied with type conversion but not as part of a transaction
    And UtilException with TYPE_MISMATCHED is thrown if types are incompatible

  # Source: [JavaCard 3.2 API, ArrayLogic.arrayCopyRepackNonAtomic](../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/ArrayLogic.html#arrayCopyRepackNonAtomic(Object,short,Object,short,short))
  Scenario: ArrayLogic.arrayFillGeneric fills array with a value atomically
    When ArrayLogic.arrayFillGeneric(Object theArray, short off, short len, Object valArray, short valOff) is called
    Then elements from off to off+len in theArray are filled with the value from valArray
    And the fill participates in any active transaction

  # Source: [JavaCard 3.2 API, ArrayLogic.arrayFillGeneric](../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/ArrayLogic.html#arrayFillGeneric(Object,short,short,Object,short))
  Scenario: ArrayLogic.arrayFillGenericNonAtomic fills without transaction
    When ArrayLogic.arrayFillGenericNonAtomic(Object theArray, short off, short len, Object valArray, short valOff) is called
    Then elements are filled non-atomically

  # Source: [JavaCard 3.2 API, ArrayLogic.arrayFillGenericNonAtomic](../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/ArrayLogic.html#arrayFillGenericNonAtomic(Object,short,short,Object,short))
  Scenario: ArrayLogic.arrayCompareGeneric compares two arrays element by element
    When ArrayLogic.arrayCompareGeneric(Object src, short srcOff, Object dest, short destOff, short length) is called
    Then returns 0 if arrays are equal, negative if src < dest, positive if src > dest

  # Source: [JavaCard 3.2 API, ArrayLogic.arrayCompareGeneric](../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/ArrayLogic.html#arrayCompareGeneric(Object,short,Object,short,short))
  Scenario: ArrayLogic.arrayFindGeneric finds an element in an array
    When ArrayLogic.arrayFindGeneric(Object theArray, short off, Object valArray, short valOff) is called
    Then returns the index of the first matching element, or -1 if not found

# Source: [JavaCard 3.2 API, ArrayLogic.arrayFindGeneric](../../../refs/javadoc-3.2/api_classic/javacardx/framework/util/ArrayLogic.html#arrayFindGeneric(Object,short,Object,short))