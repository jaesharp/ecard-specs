# Electronic Embedded Card Reference/Standards Library

Curated collection of smart card specifications (GlobalPlatform, Java Card, EMV, JCOP, ISO
14443/7816) with machine-readable conformance requirements transcribed into Gherkin feature files.

## Repository Layout

```
specs/                          Machine-readable specifications
  javacard/                     Java Card platform (3.0.5, 3.1, 3.2)
    application-programming-interface/
    virtual-machine/
    runtime-environment/

docs/                           Source documents (PDFs, Javadoc archives)
  javacard/                     Java Card specs, API Javadoc, bookmark indices
  globalplatform/               GP Card Spec v2.1.1--v2.3.1, Amendments A--E
  emv/                          EMV v4.3 Books 1--4, Contactless Books A--D
  ibm-jcop/                     JCOP product family briefs
  iso/                          ISO 14443 reference (NXP AN10834)
  research/                     Academic papers, ecosystem catalogs
  reference-implementations/    Oracle JCDK v25.1 (simulator, tools, plugin)

tools/                          Formatting and validation tooling (prettier)
```

## Specifications

### [Java Card Platform](specs/javacard/)

Conformance requirements for the Java Card Classic Edition, transcribed from Oracle's normative
specifications into versioned, cited Gherkin scenarios.

- [Application Programming Interface](specs/javacard/application-programming-interface/) -- all API
  classes across `javacard.framework`, `javacard.security`, `javacardx.*`, and the
  `java.lang`/`java.io`/`java.rmi` subset
- [Virtual Machine](specs/javacard/virtual-machine/) -- data types, all 109 bytecodes, CAP file
  format, token-based linking, language subset
- [Runtime Environment](specs/javacard/runtime-environment/) -- applet lifecycle, APDU dispatch,
  firewall, transactions, logical channels, transient objects

Each scenario is tagged with applicable versions (`@v3.0.5`, `@v3.1`, `@v3.2`) and includes direct
hyperlinks to the source document (PDF page anchors or Javadoc HTML method anchors).

## Source Documents

### GlobalPlatform

GP Card Specification versions 2.1.1 through 2.3.1, plus Amendments A (Confidential CCM), B (RAM
over HTTP), C (Contactless Services), D (SCP03), E (Security Upgrade), UICC Contactless Extension,
SE Access Control, and migration guidelines. See [docs/globalplatform/](docs/globalplatform/).

### Java Card

JCVM and JCRE specification PDFs for versions 2.1.1, 2.2.2, 3.0.5, 3.1, and 3.2 (Classic Edition).
API Javadoc archives for 3.0.5, 3.1, and 3.2. Applet Developer's Guide. See
[docs/javacard/](docs/javacard/).

### EMV

EMV v4.3 contact Books 1--4 (ICC interface, security, application spec, other interfaces) and
Contactless v2.6 Books A--D (architecture, entry point, Kernel 2, communication protocol). See
[docs/emv/](docs/emv/).

### IBM JCOP

Product documentation for the JCOP smart card OS family (JCOP10, JCOP20, JCOP21, JCOP31bio). See
[docs/ibm-jcop/](docs/ibm-jcop/).

### ISO / Reference Materials

NXP AN10834 (ISO 14443 Type A contactless selection). CardWerk web references for ISO 7816-3/4. See
[docs/iso/](docs/iso/).

### Research

CARDIS 2023 paper on Java Card feature adoption and the crocs-muni curated applet list. See
[docs/research/](docs/research/).

### Reference Implementations

Oracle Java Card Development Kit v25.1 archives (simulator, tools, Eclipse plugin). See
[docs/reference-implementations/](docs/reference-implementations/).

## Setup

```sh
# Fetch/update freely available spec PDFs
./download.sh

# Install formatting tools and git hooks
./tools/setup.sh

# Format all markdown and feature files
npm --prefix tools run format

# Check formatting compliance
npm --prefix tools test
```

## Not Freely Available

- GP UICC Configuration v2.0 (GPC_GUI_010) -- GP portal
- GP Amendment B v1.2, C v1.3 -- GP portal (have B v1.1.3, C v1.2)
- Visa OpenPlatform (VOP) Card Implementation Requirements -- proprietary
- ISO 7816-3/4 official -- CHF 168--258 from ISO (using CardWerk web refs)
- JCOP31bio biometric interface -- proprietary NXP extension
