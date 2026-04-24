# Java Card Platform -- Machine-Readable Specifications

Conformance requirements for the Java Card platform, transcribed from Oracle's normative
specifications into Gherkin feature files. Each scenario traces back to the source document via
direct hyperlinks with page anchors (PDFs) or method-level anchors (Javadoc HTML).

## Specification Versions

Requirements are drawn from three versions of the Java Card Classic Edition:

| Version | Date          | Publisher | Notes                                                                |
| ------- | ------------- | --------- | -------------------------------------------------------------------- |
| 3.0.5   | May 2015      | Oracle    | Current classic edition GA release                                   |
| 3.1     | February 2021 | Oracle    | Added XEC keys, SM4, NIO buffers, event framework, KDF, certificates |
| 3.2     | January 2023  | Oracle    | Added SM2 key agreement, TLS KDF expand label, array views           |

Each Feature and Scenario is tagged with the versions where it is normative (`@v3.0.5`, `@v3.1`,
`@v3.2`). Scenarios present in all three carry all three tags. Scenarios added in a later version
carry only the applicable tags.

## Modules

The Java Card platform specification is organized into three complementary documents, each with its
own module here:

### [Application Programming Interface](application-programming-interface/)

The class libraries available to applet developers. Feature files are organized under `pkgs/`
following the standard Java package hierarchy (`javacard/framework/`, `javacard/security/`,
`javacardx/crypto/`, etc.). Sources are the Javadoc HTML archives linked via `.refs/`.

Covers all core packages (`javacard.framework`, `javacard.security`, `java.lang`) and all extension
packages (`javacardx.crypto`, `javacardx.biometry`, `javacardx.framework.*`, `javacardx.security.*`,
etc.).

### [Virtual Machine](virtual-machine/)

The Java Card VM definition. Covers data types, all 109 bytecode instructions (with opcode values,
formats, stack effects, and behavior), the CAP file format (component model, header, constant pool,
class, method structures), token-based linking, AID naming, and the language subset restrictions.
Sources are the JCVM spec PDFs linked via `.refs/`.

### [Runtime Environment](runtime-environment/)

The runtime behavior of the platform. Covers VM lifetime and persistence, the applet lifecycle
(install, select, process, deselect, uninstall), APDU dispatch and command processing, logical
channels and multiselectable applets, transient objects, the applet firewall (contexts, object
ownership, access rules, entry points, Shareable Interface Objects), transactions and atomicity, and
T=0/T=1 protocol specifics. Sources are the JCRE spec PDFs linked via `.refs/`.

## References

Each module contains a `.refs/` directory with symlinks to the source documents under
`docs/javacard/`. If the source documents are relocated, only the symlinks need updating -- feature
file links remain stable.
