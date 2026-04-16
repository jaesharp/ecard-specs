# GlobalPlatform Card Specifications

This directory contains GlobalPlatform Card Specification documents, including
the core specification across multiple versions, amendments, and supplementary
guides.

## Card Specification Versions

- **GPC_CardSpecification_v2.1.1.pdf** -- GlobalPlatform Card Specification,
  Version 2.1.1, March 2003. Defines the core architecture for managing
  applications on smart cards, covering system and card architecture, security
  architecture, life cycle models, the Card Manager (OPEN, Issuer Security
  Domain, CVM Handler), security domains, delegated management, secure
  communication, APDU command reference, and the GlobalPlatform API.

- **GPC_CardSpecification_v2.2.pdf** -- GlobalPlatform Card Specification,
  Version 2.2, March 2006. Major revision introducing the Trusted Framework
  concept, Global Services Applications, restructured OPEN (GlobalPlatform
  Environment) as a standalone chapter, formal privilege definitions and
  assignment, and expanded security domain architecture. Adds sections on
  card and application management, content loading/installation, and secure
  communication protocols.

- **GPC_CardSpecification_v2.2.1.pdf** -- GlobalPlatform Card Specification,
  Version 2.2.1, January 2011. Document Reference: GPC_SPE_034. Public
  Release. Minor update to v2.2 incorporating clarifications, errata, and
  refinements. Retains the same overall structure as v2.2 with sections on
  system architecture, card architecture, security architecture, life cycle
  models, OPEN, security domains, global platform services, card and
  application management, secure communication, and APDU command reference.

- **GPC_CardSpecification_v2.3.1.pdf** -- GlobalPlatform Technology Card
  Specification, Version 2.3.1, March 2018. Document Reference: GPC_SPE_034.
  Public Release. The most recent major version in this collection. Organized
  into four parts: Part I (introduction, system/card/security architecture,
  cryptographic support), Part II (life cycle models, OPEN, security domains,
  global platform services, card/application management, secure
  communication), Part III (not shown in ToC excerpt), and Part IV (APDU
  command reference with general coding rules, life cycle state coding,
  privileges coding, class byte coding). Adds memory resource management,
  application status/card status interrogation, and expanded content
  management operations.

## Amendments

- **GPC_2.2_Amendment_A_v1.0.1.pdf** -- Confidential Card Content Management,
  Card Specification v2.2 - Amendment A, Version 1.0.1, January 2011.
  Document Reference: GPC_SPE_007. Defines mechanisms for confidential
  application loading on smart cards, including DGI formats for personalizing
  security domain mandatory data, public key certificates and DES signatures,
  symmetric and asymmetric key schemes, ciphered load files, and an API for
  confidential personalization. Originally published October 2007; v1.0.1
  incorporates errata. Contents of sections 4.8 and 4.9 were integrated into
  Card Specification v2.2.1.

- **GPC_2.3_A_ConfidentialCCM_v1.2.pdf** -- Confidential Card Content
  Management, Card Specification v2.3 - Amendment A, Version 1.2, July 2019.
  Document Reference: GPC_SPE_007. Public Release. Updated version of the
  Confidential Card Content Management amendment, now targeting v2.3. Covers
  confidential personalization of secure channel keys (pull model, push model,
  key agreement model), preparation of Controlling Authority and Application
  Provider security domains, establishment of secure channel keys, ciphered
  load file data block privilege, DGI for personalizing security domain keys,
  Controlling Authority services to applications, and APDU commands including
  INITIALIZE SECURITY.

- **GPC_2.2_B_RAM_over_HTTP_v1.1.3.pdf** -- Remote Application Management over
  HTTP, Card Specification v2.2 - Amendment B, Version 1.1.3, May 2015.
  Document Reference: GPC_SPE_011. Public Release. Defines a mechanism for
  Application Providers to perform Remote Application Management (loading,
  installation, personalization) over HTTP with PSK TLS security
  Over-The-Air, per ETSI TS 102 226. Covers administration protocol, session
  management, command format, retry policy, session triggering parameters,
  PSK TLS key loading, and an API for administration session triggering.

- **GPC_2.3_C_ContactlessServices_v1.2.pdf** -- Contactless Services, Card
  Specification v2.3 - Amendment C, Version 1.2, December 2015. Document
  Reference: GPC_SPE_025. Public Release. Comprehensive amendment covering
  contactless functionality: user interaction management (display control,
  application families, application groups, CREL/CRS applications,
  notification rules), contactless protocol management (protocol parameters
  for Type A/B/F in card emulation mode, conflict detection), communication
  interface access configuration, application selection over contactless
  interfaces, contactless privileges, application availability states,
  cumulative granted memory, cumulative delete, security domain APDU
  commands, and a token identifier blacklist for delegated management.

- **GPC_2.3_D_SCP03_v1.1.2.pdf** -- Secure Channel Protocol '03', Card
  Specification v2.3 - Amendment D, Version 1.1.2, March 2019. Document
  Reference: GPC_SPE_014. Public Release. Defines Secure Channel Protocol 03
  (SCP03) based on AES cryptography. Covers AES encryption/decryption,
  MACing, AES padding, data derivation scheme, mutual authentication, message
  integrity, message data confidentiality, security levels, protocol rules,
  cryptographic key management (AES session keys, challenges, authentication
  cryptograms, C-MAC/R-MAC generation and verification, C-DECRYPTION/
  R-ENCRYPTION), and secure channel commands (INITIALIZE UPDATE, EXTERNAL
  AUTHENTICATE, BEGIN/END R-MAC SESSION). Also addresses AES-based DAPs,
  tokens, and receipts for card content management.

- **GPC_2.3_E_SecurityUpgrade_v1.1.pdf** -- Security Upgrade for Card Content
  Management, Card Specification v2.3 - Amendment E, Version 1.1, October
  2016. Document Reference: GPC_SPE_042. Public Release. Adds support for
  Elliptic Curve Cryptography (ECC) and upgraded RSA cryptographic schemes.
  Covers ECC algorithms (domain parameters, key types, ECDSA, ECKA, key
  derivation), RSA algorithms (Variant 2), ECC-based DAPs/tokens/receipts,
  encrypted load files with optional ICV, confidential setup of secure
  channel keys using ECKA and ECKA-EG, and indication of card/CASD
  capabilities. Note: the technical contents have been re-integrated into
  the main Card Specification and Amendment A.

## Other Documents

- **GPC_UICC_ContactlessExtn_v1.0.pdf** -- UICC Configuration - Contactless
  Extension, Version 1.0, February 2012. Document Reference: GPC_GUI_035.
  Member Release. Defines configuration requirements for implementing
  GlobalPlatform Card Specification Amendment C (Contactless Services) on
  UICCs. Covers user interaction management, contactless protocol management
  (default OPEN protocol data for Type A and B), communication interface
  access configuration, application selection, contactless privilege,
  application availability on the contactless interface, and security domain
  APDU commands (INSTALL, DELETE, GET STATUS).

- **GP_2.1.1_Mapping_Guidelines.pdf** -- Mapping Guidelines of Existing GP
  v2.1.1 Implementation on v2.2.1, Version 1.0.1, January 2011. Document
  Reference: GPC_GUI_003. Member Release. Provides guidance for migrating
  existing GlobalPlatform v2.1.1 card implementations to v2.2.1. Covers
  security principles (privileges, Issuer Security Domain, supplementary
  security domains, applications), data recommendations (OPEN, ISD data
  store, secure channel keys, key information templates), key usage, secure
  channel operations, and detailed APDU command recommendations (DELETE,
  EXTERNAL AUTHENTICATE, GET DATA, GET STATUS, INITIALIZE UPDATE, INSTALL,
  LOAD, MANAGE CHANNEL, PUT KEY, SELECT, SET STATUS, STORE DATA), plus
  application programming interface mappings (GPSystem, SecureChannel,
  GPRegistryEntry, SecureChannelX, CVM).
