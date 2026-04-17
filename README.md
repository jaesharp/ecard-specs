# Electronic Embedded Card Reference/Standards Library

GlobalPlatform, JavaCard, EMV, and JCOP specification collection. Run `./download.sh` to fetch or
update all freely available documents.

## GlobalPlatform Card Specifications

| Document                          | Version | Ref         | Notes                                   |
| --------------------------------- | ------- | ----------- | --------------------------------------- |
| Card Specification                | v2.1.1  | GPC_SPE_006 | Primary spec for JCOP10-31bio           |
| Card Specification                | v2.2    | --          | Intermediate, SCP02 enhancements        |
| Card Specification                | v2.2.1  | --          | Intermediate, clarifications            |
| Card Specification                | v2.3.1  | GPC_SPE_034 | Current CC-certified, normative clarity |
| Amendment A: Confidential CCM     | v1.0.1  | GPC_SPE_007 | DAP verification, delegated management  |
| Amendment A: Confidential CCM     | v1.2    | GPC_SPE_007 | Latest freely available public release  |
| Amendment B: RAM over HTTP        | v1.1.3  | GPC_SPE_011 | SCP81, OTA card management              |
| Amendment C: Contactless Services | v1.2    | GPC_SPE_025 | ISO 14443 applet configuration          |
| Amendment D: SCP03                | v1.1.2  | GPC_SPE_014 | AES-based secure channel                |
| Amendment E: Security Upgrade     | v1.1    | GPC_SPE_042 | ECC/RSA (re-integrated into GPCS)       |
| UICC Contactless Extension        | v1.0    | --          | Bridges GP + UICC worlds                |
| SE Access Control                 | v1.1    | GPD_SPE_013 | Android HCE integration                 |
| Mapping Guidelines 2.1.1          | v1.0.1  | --          | OP 2.0.1 -> GP 2.1.1 migration          |

## JavaCard Platform Specifications

| Document                   | Version | Notes                                              |
| -------------------------- | ------- | -------------------------------------------------- |
| JCVM Specification         | 2.1.1   | Bytecode set, verification, CAP format             |
| JCRE Specification         | 2.1.1   | Runtime, applet lifecycle, firewall                |
| JavaCard API               | 2.1.1   | Framework classes, crypto API                      |
| JC 2.1.1 Release Notes     | 2.1.1   | Overview and errata                                |
| JCVM Specification         | 2.2.2   | Many OSS applets target this version               |
| JCRE Specification         | 2.2.2   | Runtime for 2.2.2 applet targets                   |
| JavaCard API               | 2.2.2   | API for 2.2.2 applet targets                       |
| JCVM Specification         | 3.0.5   | Current classic edition (from GitHub mirror)       |
| JCRE Specification         | 3.0.5   | Runtime for classic edition                        |
| Spec + API Javadoc archive | 3.0.5   | Oracle spec bundle with API documentation          |
| JCVM Specification         | 3.1     | Latest normative clarity for ambiguous 2.1.1 areas |
| JCRE Specification         | 3.1     | Latest runtime semantics                           |
| Spec + API Javadoc archive | 3.1.0   | Oracle spec bundle with API documentation          |
| JCVM Specification         | 3.2     | From GitHub mirror (usasmartcard/Javacard-API)     |
| JCRE Specification         | 3.2     | From GitHub mirror                                 |
| JC Platform Options        | 3.2     | Configuration options reference                    |
| Spec + API Javadoc archive | 3.2.0   | Oracle spec bundle with API documentation          |
| Applet Developers Guide    | --      | From GitHub mirror                                 |

## IBM JCOP Product Documentation

| Document               | Notes                                 |
| ---------------------- | ------------------------------------- |
| JCOP Family Overview   | All variants: JCOP10/20/21/21id/31bio |
| JCOP10 Technical Brief | 8KB EEPROM, SCP01, RSA-1024 max       |
| JCOP20 Technical Brief | 16KB, SCP02, RSA-2048, VOP Config 2   |

## ISO / Reference Materials

| Document                       | Source  | Notes                            |
| ------------------------------ | ------- | -------------------------------- |
| ISO 14443 Type A (NXP AN10834) | NXP     | Contactless overview for JCOP21+ |
| ISO 7816-3 (CardWerk)          | Web ref | T=0, T=1 protocol                |
| ISO 7816-4 (CardWerk)          | Web ref | APDU structure                   |

## EMV Specifications

| Document                            | Version | Notes                                 |
| ----------------------------------- | ------- | ------------------------------------- |
| Book 1: ICC to Terminal Interface   | v4.3    | Physical interface, ATR, protocol     |
| Book 2: Security and Key Management | v4.3    | RSA, SHA-1, certificate chain         |
| Book 3: Application Specification   | v4.3    | SELECT, GPO, READ RECORD, auth flow   |
| Book 4: Other Interfaces            | v4.3    | Cardholder/attendant interface        |
| Contactless Book A                  | v2.6    | Architecture and general requirements |
| Contactless Book B                  | v2.6    | Entry point specification             |
| Contactless Book C-2                | v2.6    | Kernel 2 (MasterCard) specification   |
| Contactless Book D                  | v2.6    | Contactless communication protocol    |

## Research

| Document                               | Notes                                       |
| -------------------------------------- | ------------------------------------------- |
| CARDIS 2023: JavaCard feature adoption | Certified product + OSS feature coverage    |
| JavaCard Curated Applet List           | Ecosystem catalog for certification testing |

## Reference Implementations

| Archive                           | Notes                                         |
| --------------------------------- | --------------------------------------------- |
| Oracle JCDK Simulator (Linux x86) | v25.1, jcsl binary + samples + client libs    |
| Oracle JCDK Simulator (Windows)   | v25.1, same contents as Linux variant         |
| Oracle JCDK Tools                 | v25.1, converter + verifier for CAP files     |
| Oracle JCDK Eclipse Plugin        | v25.1, IDE integration for applet development |

See `reference-implementations/README.md` for extraction and usage instructions.

## Not Freely Available (require account/purchase)

- GP UICC Configuration v2.0 (GPC_GUI_010) -- GP portal download flow
- GP Amendment B v1.2, C v1.3 -- GP portal (have B v1.1.3, C v1.2)
- Visa OpenPlatform (VOP) Card Implementation Requirements -- proprietary
- ISO 7816-3/4 (official) -- CHF 168-258 from ISO (using CardWerk web refs)
- JCOP31bio biometric interface -- proprietary NXP extension
