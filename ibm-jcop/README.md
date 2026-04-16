# IBM JCOP (Java Card OpenPlatform)

JCOP is IBM's smart card operating system implementing the JavaCard and GlobalPlatform
specifications. Developed by IBM Zurich Research Laboratory (BlueZ Secure Systems), it is
a fully standards-compliant platform designed for use across the financial/EMV, telecom/SIM,
and ID/health smart card markets.

JCOP is compliant with JavaCard 2.1.1, GlobalPlatform 2.0.1', EMV and ISO 7816, ISO 14443,
and 3GPP 03.19/11.14. It is designed for low-cost 8-bit controllers with as little as 48k of
ROM and uses a custom mask process to reduce EEPROM requirements and card production cost.
IBM claims industry-leading performance due to JCOP's architecture, which places the Java VM
at its core rather than layering it on top of a traditional ISO file system card OS.

JCOP supports contact and contactless interfaces, RSA key generation on-card (up to 2048 bits),
DES and RSA cryptography, SHA/MD5 hashing, and automatic memory management with garbage
collection. IBM developed a Custom Mask Process allowing card issuers to blend standard
applets into ROM, significantly reducing EEPROM usage for high-volume deployments.

The product family passed Visa approval at the highest level (Level 3) and all JavaCard
compliance tests. FIPS 140-2 Level 3 certification was in progress as of 2002.

## Documents

### JCOP_Family.pdf

Product overview of the full JCOP family from BlueZ Secure Systems. Includes a version map
comparing all variants (JCOP10, JCOP20, JCOP30, JCOP21id, JCOP21sim, JCOP31bio) across
features such as EEPROM size, cryptographic capabilities, ISO 7816 T=0/T=1 support,
ISO 14443 T=CL contactless support, MIFARE compatibility, Bio-API, GlobalPIN, and VOP
configuration profiles. Also includes an inverse product configuration matrix mapping
Philips smart card controller references (P8WE6017, P8WE6033, P8WE5009, P8WE5017,
P8WE5033, P8RF5016) to available JCOP features, and a memory map showing free EEPROM
and ROM per variant and chip.

### JCOP10Brief.pdf

Technical brief (Revision 2.1) for the JCOP10, the first and most basic member of the
JCOP family. JCOP10 is the DES-only variant with no RSA coprocessor support. It implements
the Visa OpenPlatform Card Implementation Guide (VOP) Configuration 1. JCOP10v1 conformed
to VOP 2.1.1 Compact (August 2000); JCOP10v2 is compliant with VOP Configuration 1,
Version 2.0 (February 2002).

Communication is via ISO 7816 T=0 and T=1 protocols (direct and inverse convention) at speeds
up to 115200 bit/sec at the default 3.57 MHz clock. Memory available to applications includes
15kB/31kB EEPROM persistent heap (depending on custom ROM applets), a 512-byte transaction
buffer, 651 bytes of transient Java heap in RAM, a 261-byte APDU buffer, a 200-byte Java
stack, and 16kB/64kB free ROM. Supported cryptographic algorithms are DES (CBC and ECB
modes with NOPAD, ISO9797 M1/M2 padding), DES MAC8 signatures, and ALG_SECURE_RANDOM.
Garbage collection and Global PIN are fully implemented.

### JCOP20Brief.pdf

Technical brief (Revision 2.3) for the JCOP20, the first public-key member of the JCOP
family. JCOP20 adds RSA capabilities to the JCOP10 feature set, including on-card RSA
key generation. It conforms to VOP Card Implementation Guide 2.1.2 Compact (August 2000);
JCOP20v2 is compliant with VOP Configuration 2 with PK, Version 2.0 (February 2002).

Communication protocols and speeds match JCOP10, with an additional 57600 bit/sec option.
Memory available includes 7kB/15kB/31kB EEPROM persistent heap, 615 bytes of transient
Java heap, and 24kB/56kB free ROM. In addition to DES algorithms, JCOP20 supports
ALG_RSA_PKCS1, ALG_RSA_NOPAD ciphers; ALG_RSA_SHA_ISO9796, ALG_RSA_SHA_PKCS1, and
ALG_RSA_MD5_PKCS1 signatures; ALG_SHA and ALG_MD5 message digests; and RSA key types
up to 2048 bits (v2 only), with on-card key generation for RSA keys in CRT format.
