# Java Card Virtual Machine

Machine-readable conformance requirements for the Java Card Virtual Machine Specification,
transcribed from the JCVM spec PDFs across versions 3.0.5, 3.1, and 3.2 (Classic Edition).

## Source Documents

PDF specifications are linked via `.refs/`:

- `.refs/3.0.5/JCVMSpec_3.0.5.pdf` -- JCVM Specification 3.0.5 (May 2015)
- `.refs/3.1/JCVMSpec_3.1.pdf` -- JCVM Specification 3.1 (February 2021)
- `.refs/3.2/JCVMSpec_3.2.pdf` -- JCVM Specification 3.2 (January 2023)

The 3.1 and 3.2 PDFs include bookmarks merged from extracted table-of-contents indices (see
`.refs/3.*/JCVMSpec_3.*.bookmarks.txt`).

## Structure

### `types.feature`

Data types and values (Chapter 3): boolean, byte, short, int, reference, returnAddress.
Computational vs storage types, words, runtime data areas, frames, and the instruction set type
mapping.

### `bytecodes/`

All 109 bytecodes from the Java Card instruction set (Chapter 7), organized by category:

| File                   | Coverage                                                                                         |
| ---------------------- | ------------------------------------------------------------------------------------------------ |
| `arithmetic.feature`   | sadd, ssub, smul, sdiv, srem, sneg, iadd, isub, imul, idiv, irem, ineg, bit ops, shifts          |
| `stack.feature`        | Constants (sconst, iconst, aconst_null), push (bspush, sipush, etc.), load/store, dup, pop, swap |
| `control_flow.feature` | Branches (if_scmp, if_acmp, ifnull, etc.), goto, switch, jsr/ret                                 |
| `object.feature`       | new, checkcast, instanceof, field access, method invocation                                      |
| `array.feature`        | newarray, anewarray, arraylength, element load/store                                             |
| `conversion.feature`   | s2b, s2i, i2b, i2s                                                                               |
| `return.feature`       | return, sreturn, ireturn, areturn, athrow, nop                                                   |

Each scenario specifies the opcode value (decimal and hex), format, operand stack effect, and
behavior. Scenarios include direct PDF page anchors.

### `cap/`

The CAP (Converted Applet) file format (Chapter 6):

| File                    | Coverage                                                             |
| ----------------------- | -------------------------------------------------------------------- |
| `format.feature`        | Component model, component tags, JAR containment, installation order |
| `header.feature`        | Magic number (0xDECAFFED), version, flags, package info              |
| `constant_pool.feature` | All 6 constant pool entry types and their structures                 |
| `class.feature`         | interface_info, class_info, type descriptors, method tables          |
| `method.feature`        | method_info, exception_handler_info, bytecode encoding               |

### `linking.feature`

Binary representation (Chapter 4): AID-based naming, token-based linking (all 7 token types), binary
compatibility, and package versioning.

### `verification.feature`

Language subset (Chapter 2): supported and unsupported features, keywords, types, classes,
bytecodes, and VM limitations.

## Version Tagging

Same convention as the API module. Each scenario is tagged with applicable versions and includes
citation links with PDF page anchors.
