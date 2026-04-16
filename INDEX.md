# Telecom Standards Collection -- GlobalPlatform / JavaCard / JCOP

Standards referenced by the simrs GlobalPlatform card emulator implementation.
Run `./download.sh` to fetch or update all freely available documents.

## GlobalPlatform Card Specifications

| Document | Version | Ref | simrs Crate(s) | Notes |
|----------|---------|-----|----------------|-------|
| Card Specification | v2.1.1 | GPC_SPE_006 | simrs-gp-open, simrs-gp-scp | Primary spec for JCOP10-31bio |
| Card Specification | v2.3.1 | GPC_SPE_034 | simrs-gp-open, simrs-gp-scp | Current CC-certified, normative clarity |
| Amendment A: Confidential CCM | v1.0.1 | GPC_SPE_007 | simrs-gp-open | DAP verification, delegated management |
| Amendment B: RAM over HTTP | v1.1.3 | GPC_SPE_011 | (future) | SCP81, OTA card management |
| Amendment C: Contactless Services | v1.2 | GPC_SPE_025 | simrs-gp-card | ISO 14443 applet configuration |
| Amendment D: SCP03 | v1.1.2 | GPC_SPE_014 | simrs-gp-scp | AES-based secure channel |
| Amendment E: Security Upgrade | v1.1 | GPC_SPE_042 | simrs-gp-scp | ECC/RSA (re-integrated into GPCS) |
| UICC Contactless Extension | v1.0 | -- | simrs-gp-card | Bridges GP + UICC worlds |
| Mapping Guidelines 2.1.1 | v1.0.1 | -- | -- | OP 2.0.1 -> GP 2.1.1 migration |

## JavaCard Platform Specifications

| Document | Version | simrs Crate(s) | Notes |
|----------|---------|----------------|-------|
| JCVM Specification | 2.1.1 | simrs-jcvm | Bytecode set, verification, CAP format |
| JCRE Specification | 2.1.1 | simrs-jcre | Runtime, applet lifecycle, firewall |
| JavaCard API | 2.1.1 | simrs-jcre | Framework classes, crypto API |
| JC 2.1.1 Release Notes | 2.1.1 | -- | Overview and errata |
| JCVM Specification | 3.1 | simrs-jcvm | Latest normative clarity for ambiguous 2.1.1 areas |
| JCRE Specification | 3.1 | simrs-jcre | Latest runtime semantics |

Note: JC 3.0.5 specs require Oracle SSO login. JC 2.1.1 (what JCOP implements)
and JC 3.1 (latest freely available) cover all needed normative content.

## IBM JCOP Product Documentation

| Document | simrs Crate(s) | Notes |
|----------|----------------|-------|
| JCOP Family Overview | simrs-jcop-profile | All variants: JCOP10/20/21/21id/31bio |
| JCOP10 Technical Brief | simrs-jcop-profile | 8KB EEPROM, SCP01, RSA-1024 max |
| JCOP20 Technical Brief | simrs-jcop-profile | 16KB, SCP02, RSA-2048, VOP Config 2 |

## ISO / Reference Materials

| Document | Source | simrs Crate(s) | Notes |
|----------|--------|----------------|-------|
| ISO 14443 Type A (NXP AN10834) | NXP | simrs-gp-card | Contactless overview for JCOP21+ |
| ISO 7816-3 (CardWerk) | Web ref | simrs-t0 | T=0, T=1 protocol (already impl) |
| ISO 7816-4 (CardWerk) | Web ref | simrs-iso7816 | APDU structure (already impl) |

## Research

| Document | Notes |
|----------|-------|
| CARDIS 2023: JavaCard feature adoption | Certified product + OSS feature coverage |
| JavaCard Curated Applet List | Ecosystem catalog for certification testing |

## Not Freely Available (require account/purchase)

- JavaCard 3.0.5 specs -- Oracle SSO required
- GP UICC Configuration v2.0 (GPC_GUI_010) -- GP portal download flow
- GP Amendment latest versions (A v1.2, B v1.2, C v1.3) -- GP portal
- Visa OpenPlatform (VOP) Card Implementation Requirements -- proprietary
- ISO 7816-3/4 (official) -- CHF 168-258 from ISO
- JCOP31bio biometric interface -- proprietary NXP extension
