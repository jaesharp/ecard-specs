# Java Card Platform Specifications

Java Card is a technology that enables small Java-based applications (applets) to run
on smart cards and other resource-constrained secure elements. The platform combines a
subset of the Java programming language with a runtime environment optimized for devices
that have as little as a few kilobytes of memory. Java Card technology provides a
secure, vendor-neutral, interoperable execution platform that can store and update
multiple applications on a single device, while retaining the highest certification
levels and compatibility with standards such as ISO 7816.

The Java Card platform is defined by three complementary specifications:

- **Virtual Machine Specification (JCVM)** -- Defines the Java Card virtual machine,
  including the supported language subset, bytecode instruction set, binary
  representation formats (CAP and Export files), and the split between off-card and
  on-card processing.
- **Runtime Environment Specification (JCRE)** -- Defines the runtime behaviour of the
  platform: the applet lifecycle (install, select, process, deselect), the applet
  firewall and object sharing model, transient objects, transactions and atomicity, the
  applet installer, and APDU dispatch.
- **Application Programming Interface (API)** -- Defines the class libraries available
  to applet developers, organized into packages such as `java.lang`,
  `javacard.framework`, `javacard.security`, and extension packages under `javacardx`.

The specifications were originally developed by Sun Microsystems and later maintained by
Oracle Corporation.


## Version 2.1.1 (May 2000)

Published by Sun Microsystems. This is an early foundational release of the Java Card
platform.

### Included documents

| Document | File |
|----------|------|
| Virtual Machine Specification, Revision 1.0 | `2.1.1/JCVMSpec.pdf` |
| Runtime Environment (JCRE) Specification, Revision 1.0 | `2.1.1/JCRESpec.pdf` |
| Application Programming Interface | `2.1.1/JavaCard211API.pdf` |
| Specifications Release Notes | `2.1.1/JC211SpecRelease.pdf` |

### Coverage

**JCVM Spec** -- Defines the Java Card virtual machine as a subset of the Java VM. The
VM supports only a restricted set of the Java language: no threads, no dynamic class
loading, no finalization, no cloning, no large primitive types (float, double, long).
The `int` type is optionally supported. The spec covers data types and values, runtime
data areas (contexts, frames), object representation, the instruction set, AID-based
naming, token-based linking, binary compatibility, the Export file format, and the CAP
(Converted Applet) file format with its component structure (Header, Directory, Applet,
Import, Constant Pool, Class, Method, Static Field, Reference Location, Export,
Descriptor).

**JCRE Spec** -- Defines the runtime environment's responsibilities: VM lifetime
(persistent across card power cycles), the applet lifecycle (install, select, process,
deselect methods), SELECT command processing, transient objects (cleared on reset or
deselect), the applet firewall (context-based isolation, object ownership, shareable
interfaces), transactions and atomicity (including tear/reset recovery), APDU handling
for T=0 and T=1 protocols, and the applet installer.

**API** -- Provides four packages: `java.lang` (core language classes adapted for the
card), `javacard.framework` (AID, APDU, Applet, JCSystem, OwnerPIN, ISO7816, Shareable,
Util), `javacard.security` (cryptographic keys -- DES, DSA, RSA -- KeyBuilder, KeyPair,
MessageDigest, RandomData, Signature), and `javacardx.crypto` (Cipher,
KeyEncryption -- export-controlled functionality).

**Release Notes** -- Documents the specific changes made between the 2.1 and 2.1.1
revisions across the JCRE, API, and VM specs, including corrections to the install
method, object ownership rules, JCRE privileges, transient object handling, installer
behaviour, API constants, and various instruction set clarifications.


## Version 2.2.2 (March 2006)

Published by Sun Microsystems. A significant update that adds logical channel support,
multiselectable applets, RMI, and a considerably expanded API.

### Included documents

| Document | File |
|----------|------|
| Virtual Machine Specification | `2.2.2/JavaCard222VMspec.pdf` |
| Runtime Environment Specification | `2.2.2/JavaCard222JCREspec.pdf` |
| Application Programming Interface | `2.2.2/JavaCard222API.pdf` |

### Changes from 2.1.1

**JCVM Spec** -- Adds support for multiselectable applets restrictions and Java Card
Platform Remote Method Invocation (RMI) restrictions. Expands the language subset
documentation with detailed sections on unsupported features, keywords, types, and
classes. Adds optional support for the integer data type and an object deletion
mechanism. Documents additional VM limitations for packages, classes, objects, methods,
and switch statements.

**JCRE Spec** -- Introduces logical channels and the MANAGE CHANNEL command (open/close),
allowing multiple concurrent applet sessions on a single card. Adds multiselectable
applets that can be selected on more than one logical channel simultaneously. Defines
applet selection via both SELECT FILE and MANAGE CHANNEL OPEN. Adds the `uninstall`
method to the applet lifecycle. Adds support for concurrent operations over multiple
interfaces. Expands the applet firewall with active context tracking in the VM and
optional static access checks.

**API** -- Greatly expanded compared to 2.1.1. Adds packages: `java.io` (IOException),
`java.rmi` (Remote, RemoteException), `javacard.framework.service` (BasicService,
CardRemoteObject, Dispatcher, RemoteService, RMIService, SecurityService, Service,
ServiceException), `javacardx.apdu` (ExtendedLength), `javacardx.biometry` (BioBuilder,
BioException, BioTemplate, OwnerBioTemplate, SharedBioTemplate), `javacardx.external`
(ExternalException, Memory, MemoryAccess), and `javacardx.framework`. Adds AES key
support, elliptic curve (EC) key interfaces, HMAC keys, Checksum, KeyAgreement,
InitializedMessageDigest, SignatureMessageRecovery, KoreanSEEDKey, and the AppletEvent
and MultiSelectable interfaces.


## Version 3.0.5, Classic Edition (May 2015)

Published by Oracle. The Java Card 3 platform introduced a split into "Classic Edition"
(for traditional smart cards, continuing the 2.x lineage) and "Connected Edition" (for
cards with more resources, supporting servlets and TCP/IP). The documents in this
collection cover the Classic Edition only.

### Included documents

| Document | File |
|----------|------|
| Virtual Machine Specification, Classic Edition | `3.0.5/JCVMSpec_3.0.5.pdf` |
| Runtime Environment Specification, Classic Edition | `3.0.5/JCRESpec_3.0.5.pdf` |

### Changes from 2.2.2

**JCVM Spec** -- Continues the Classic Edition VM specification under Oracle stewardship.
The unsupported feature list is carried forward (no dynamic class loading, no Security
Manager, no finalization, no threads, no cloning, no access control in Java packages, no
typesafe enums, no enhanced for loop). The overall structure remains consistent with
2.2.2: Java Card language subset, VM structure, binary representation, Export file
format, CAP file format, and instruction set.

**JCRE Spec** -- Continues the Classic Edition runtime specification. Covers the same
major topics as 2.2.2: VM lifetime and initialization, applet lifecycle (install,
select, process, deselect, uninstall), logical channels and applet selection (including
PICC activation behaviour), multiselectable applets, transient objects, the applet
firewall, transactions and atomicity. Concurrent operations over multiple interfaces
remain specified.


## Version 3.1, Classic Edition (February 2021)

Published by Oracle. Provided under the Oracle Technology Network Developer License.

### Included documents

| Document | File |
|----------|------|
| Virtual Machine Specification, Classic Edition | `3.1/JCVMSpec_3.1.pdf` |
| Runtime Environment Specification, Classic Edition | `3.1/JCRESpec_3.1.pdf` |

### Changes from 3.0.5

**JCVM Spec** -- The specification structure and unsupported feature list remain
essentially identical to 3.0.5. The same Java language features remain unsupported
(dynamic class loading, Security Manager, finalization, threads, cloning, access control
in Java packages, typesafe enums, enhanced for loop). The document continues the
established organization: introduction, Java VM subset, VM structure, binary
representation, Export file format, CAP file format, and instruction set.

**JCRE Spec** -- Follows the same structural organization as 3.0.5. Covers VM lifetime
and initialization, applet lifecycle, logical channels and applet selection (including
default applets, PICC activation behaviour, multiselectable applets), transient objects,
the applet firewall and object sharing, and transactions and atomicity. Concurrent
operations over multiple interfaces continue to be specified.


## Version 3.2, Classic Edition (January 2023)

Published by Oracle. The most recent specification version in this collection.

### Included documents

| Document | File |
|----------|------|
| Virtual Machine Specification, Classic Edition | `3.2/JCVMSpec_3.2.pdf` |
| Runtime Environment Specification, Classic Edition | `3.2/JCRESpec_3.2.pdf` |
| Options List | `3.2/JCOptions_3.2.pdf` |

### Changes from 3.1

**JCVM Spec** -- Continues with the same structure and unsupported feature set as 3.1.
The specification organization remains: introduction, Java VM subset, VM structure,
binary representation, Export file format, CAP file format, and instruction set.

**JCRE Spec** -- Follows the same structural organization as 3.1 covering VM lifetime,
applet lifecycle, logical channels and applet selection, multiselectable applets,
transient objects, firewall, and transactions.

**Options List** -- A new companion document for version 3.2 that enumerates all optional
features available when implementing a Java Card platform. It is organized into three
categories:

- *Core packages (mandatory)* -- Language features, application framework, security and
  cryptography.
- *Extension packages (optional)* -- Extended APDU, APDU utilities, biometry (including
  1-to-N), cryptography extensions, external memory access, event framework, big
  numbers, NIO buffers, string utilities, system time, BER-TLV encoding/decoding, array
  utilities, int utilities, service framework and RMI, security assertions, certificate
  handling, and derivation functions.
- *Platform optional features* -- Optional operations and platform behaviours.

This document is intended for both platform implementors and application developers who
need to understand which capabilities are mandatory and which are optional.


## Java Card Applet Developer's Guide

| Document | File |
|----------|------|
| Java Card Applet Developer's Guide, Revision 1.12 | `Java Card Applet Developers Guide.pdf` |

Published by Sun Microsystems in August 1998, this is a practical guide for developers
writing Java Card applets. It predates the 2.1.1 specifications and covers the
fundamentals of the platform from an application development perspective.

The guide covers:

- **Smart card architecture** -- Communication interface, CPU, on-card memory (ROM, RAM,
  EEPROM), and the role of Application Protocol Data Units (APDUs).
- **Java Card technology overview** -- The virtual machine, language restrictions
  (primitive types, arrays, inheritance), security, portability, exceptions, and core
  classes (Throwable, Object).
- **Creating applets** -- A basic example walkthrough, applet installation, the Applet
  class, registering and selecting applets, working with APDUs (communication sequence,
  receiving data, responses, return values), atomicity, and the commit buffer.
- **Optimization techniques** -- Reusing objects, allocating memory efficiently, and
  optimizing array element access for resource-constrained environments.
- **File system operations** -- Elementary and dedicated files, record files, the
  FileSystem class, file operations, file security, finding files and records.
- **Cryptography** -- Cryptographic concepts, symmetric keys, verification of
  symmetrically-encoded messages, asymmetric keys, and authentication and verification.
