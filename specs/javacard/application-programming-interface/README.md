# Java Card Application Programming Interface

Machine-readable conformance requirements for the Java Card API, transcribed from the Oracle Java
Card API Specification Javadoc across versions 3.0.5, 3.1, and 3.2 (Classic Edition).

## Source Documents

Javadoc HTML archives are linked via `.refs/`:

- `.refs/javadoc-3.0.5/` -- Java Card Kit Classic 3.0.5 (June 2015)
- `.refs/javadoc-3.1/` -- Java Card Specification 3.1.0 (March 2021)
- `.refs/javadoc-3.2/` -- Java Card Specification 3.2.0 (January 2023)

## Package Layout

Feature files are organized under `pkgs/` following the standard Java package hierarchy.

### Core Packages (mandatory)

| Package               | Description                                                                                                                          |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `javacard/framework/` | AID, APDU, Applet lifecycle, ISO 7816 constants, JCSystem, OwnerPIN, Util, Shareable, exceptions                                     |
| `javacard/security/`  | Key types (AES, DES, RSA, EC, DH, HMAC, XEC, SM4), KeyBuilder, KeyPair, MessageDigest, Signature, KeyAgreement, RandomData, Checksum |
| `java/lang/`          | Object, Throwable, and all runtime exception classes                                                                                 |
| `java/io/`            | IOException (for RMI support)                                                                                                        |
| `java/rmi/`           | Remote interface and RemoteException                                                                                                 |

### Extension Packages (optional)

| Package                          | Description                                                                |
| -------------------------------- | -------------------------------------------------------------------------- |
| `javacardx/crypto/`              | Cipher, AEADCipher, KeyEncryption                                          |
| `javacardx/apdu/`                | ExtendedLength marker, APDUUtil                                            |
| `javacardx/biometry/`            | BioBuilder, BioTemplate, BioException                                      |
| `javacardx/biometry1toN/`        | Bio1toNBuilder, BioMatcher, 1-to-N matching                                |
| `javacardx/external/`            | Memory, MemoryAccess, ExternalException                                    |
| `javacardx/framework/math/`      | BigNumber, BCDUtil, ParityBit                                              |
| `javacardx/framework/tlv/`       | BER-TLV encoding/decoding (BERTag, BERTLV, Primitive/Constructed variants) |
| `javacardx/framework/util/`      | ArrayLogic, JCint, UtilException                                           |
| `javacardx/framework/string/`    | StringUtil with multiple encoding constants                                |
| `javacardx/framework/event/`     | EventListener, EventRegistry, EventSource (v3.1+)                          |
| `javacardx/framework/nio/`       | Buffer, ByteBuffer, ByteOrder (v3.1+)                                      |
| `javacardx/framework/time/`      | SysTime, TimeDuration (v3.1+)                                              |
| `javacardx/security/`            | SensitiveResult                                                            |
| `javacardx/security/cert/`       | Certificate, X509Certificate parsing (v3.1+)                               |
| `javacardx/security/derivation/` | DerivationFunction and KDF algorithm specs (v3.1+)                         |
| `javacardx/security/util/`       | MonotonicCounter (v3.1+)                                                   |
| `javacardx/annotations/`         | StringDef, StringPool                                                      |

## Version Tagging

Each Feature and Scenario is tagged with the specification versions where it is present:

- `@v3.0.5 @v3.1 @v3.2` -- present in all three versions
- `@v3.1 @v3.2` -- added in 3.1
- `@v3.2` -- added in 3.2 only

Every scenario includes direct hyperlinks to the Javadoc source for each applicable version.
