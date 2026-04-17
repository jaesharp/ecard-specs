# Java Card Runtime Environment

Machine-readable conformance requirements for the Java Card Runtime Environment Specification,
transcribed from the JCRE spec PDFs across versions 3.0.5, 3.1, and 3.2 (Classic Edition).

## Source Documents

PDF specifications are linked via `.refs/`:

- `.refs/3.0.5/JCRESpec_3.0.5.pdf` -- JCRE Specification 3.0.5 (May 2015)
- `.refs/3.1/JCRESpec_3.1.pdf` -- JCRE Specification 3.1 (February 2021)
- `.refs/3.2/JCRESpec_3.2.pdf` -- JCRE Specification 3.2 (January 2023)

The 3.1 and 3.2 PDFs include bookmarks merged from extracted table-of-contents indices (see
`.refs/3.*/JCRESpec_3.*.bookmarks.txt`).

## Structure

| File                        | Source Chapter | Coverage                                                                                                                                                                                             |
| --------------------------- | -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `vm_lifetime.feature`       | Ch. 2          | VM persistence across power cycles, card sessions, initialization, object persistence rules                                                                                                          |
| `applet_lifecycle.feature`  | Ch. 3          | install, select, process, deselect, uninstall methods -- behavior, parameters, exception handling, lifecycle transitions, power loss recovery                                                        |
| `apdu_dispatch.feature`     | Ch. 4          | SELECT FILE step-by-step processing, non-SELECT dispatching, default applet behavior, CLA byte encoding                                                                                              |
| `logical_channels.feature`  | Ch. 4          | Channel management, MANAGE CHANNEL OPEN/CLOSE processing, multiselectable applets, channel assignment rules, default applet selection                                                                |
| `transient_objects.feature` | Ch. 5          | CLEAR_ON_RESET, CLEAR_ON_DESELECT semantics, transient array creation, behavior across resets and deselections, array views (v3.1+)                                                                  |
| `firewall.feature`          | Ch. 6          | Contexts, context switching, object ownership, object access rules, entry point objects (temporary/permanent), global arrays, Shareable Interface Objects, all 11 class/object access behavior rules |
| `transactions.feature`      | Ch. 7          | beginTransaction, commitTransaction, abortTransaction, atomicity guarantees (single field, block), commit capacity, nested transaction prohibition, tear/reset failure, transient object exclusion   |
| `apdu_handling.feature`     | Ch. 9          | APDU class T=0 and T=1 specifics, constrained/regular transfers, extended length APDU semantics, security/crypto package behavior                                                                    |

## Version Tagging

Same convention as the API module. Each scenario is tagged with applicable versions and includes
citation links with PDF page anchors.
