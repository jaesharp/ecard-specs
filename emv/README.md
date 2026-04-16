# EMV Specifications

EMV (Europay, Mastercard, Visa) Integrated Circuit Card Specifications for
Payment Systems, published by EMVCo. These define the interoperable standards
for chip-based payment cards and terminals worldwide.

## Contact Interface (v4.3, November 2011)

The contact specifications are divided into four books covering the full
transaction lifecycle between an ICC (Integrated Circuit Card) and a terminal
over the ISO 7816 contact interface.

### Book 1 -- Application Independent ICC to Terminal Interface Requirements

Defines the physical, electrical, and transport-layer interface between
the card and terminal independent of any payment application. Covers ATR
(Answer to Reset) parsing, protocol negotiation (T=0, T=1), and the
application-independent portion of the ICC-to-terminal communication.

### Book 2 -- Security and Key Management

Specifies the cryptographic infrastructure for EMV transactions: RSA public
key operations, SHA-1 hashing, certificate chains for Static Data
Authentication (SDA), Dynamic Data Authentication (DDA), and Combined DDA
with Application Cryptogram generation (CDA). Defines the CA (Certificate
Authority) public key distribution model and key management lifecycle.

### Book 3 -- Application Specification

The core payment application specification. Covers the full transaction flow:
application selection (SELECT by AID, PSE), initiation (GET PROCESSING
OPTIONS), card data reading (READ RECORD), cardholder verification (PIN,
signature), terminal risk management, terminal and card action analysis,
online/offline authorization, and script processing. Defines the APDU
command set, TLV data elements, and application state machine.

### Book 4 -- Cardholder, Attendant, and Acquirer Interface Requirements

Specifies requirements for the human-facing and network-facing interfaces:
cardholder interaction (display, PIN entry), attendant functions, acquirer
interface for online authorization, referral handling, and exception file
processing.

## Contactless Interface (v2.6, 2016)

The contactless specifications extend EMV to proximity (ISO 14443) interfaces,
organized into architecture, entry point, kernel, and protocol volumes.

### Book A -- Architecture and General Requirements (v2.6, March 2016)

Defines the overall POS system architecture for contactless transactions.
Covers terminology (Card, Entry Point, Kernel, Outcome), the POS system
descriptive model, logical architecture, operating modes, and system
configuration including country/currency code handling.

### Book B -- Entry Point Specification (v2.6, July 2016)

Specifies the Entry Point component that manages contactless card detection,
collision resolution, application selection, and kernel activation. Handles
the technology-independent preprocessing before a payment kernel takes over.

### Book C-2 -- Kernel 2 Specification (v2.6, February 2016)

The MasterCard contactless payment kernel. Defines the transaction flow
for MasterCard PayPass including card reading, cardholder verification,
risk management, and cryptogram generation over the contactless interface.
Note: each payment scheme has its own kernel (C-1 for JCB, C-2 for
MasterCard, C-3 for Visa, C-4 for American Express, etc.).

### Book D -- EMV Contactless Communication Protocol (v2.6, March 2016)

Specifies the communication protocol layer between the POS reader and
contactless cards. Covers ISO 14443 Type A and Type B activation, ATQA/ATS
handling, collision detection, APDU mapping over ISO 14443-4, and timing
requirements. Incorporates specification bulletins for amended timing (SB-168),
detectable disturbance (SB-169), EMD handling (SB-172), and PICC power-on
setup (SB-173).
