# ISO 14443 Reference Material

## Documents

### iso14443-reference-NXP-AN10834.pdf

NXP Application Note AN10834, "MIFARE ISO/IEC 14443 PICC Selection," Rev. 4.2,
10 August 2021. Company Public.

This application note describes the elementary communication sequence for selecting a
contactless smart card (PICC) according to ISO/IEC 14443 and how to use this communication
to guarantee proper functionality in different applications. It covers MIFARE, MIFARE 2GO,
virtual cards, and general contactless card selection.

The document is divided into two main parts. The first part covers the communication layer:
how to select a single PICC regardless of card type or application, as defined by ISO/IEC
14443-3. The card activation procedure guarantees that a single card is properly selected
independent of the number of cards in the reader field, the number of cards moved into the
field during the transaction, and that the selected card remains selected throughout the
transaction. The second part covers application-level selection: how to select the correct
application (or card) once a single card has been activated, or how to properly ignore
foreign applications.

Key topics include:

- Card polling: the procedure starts with REQA/REQB request commands to detect Type A and
  Type B cards. The REQA or REQB must be sent after the carrier is switched on, with a
  minimum 5 ms wait. NFC devices must additionally check for an existing external field
  before activating their own RF field.

- Anti-collision: the mandatory procedure for both Type A and Type B cards to resolve
  multiple cards in the reader field and select exactly one.

- Transaction integrity: in systems where cards move in and out of the field continuously,
  transaction completion cannot be guaranteed at the communication layer alone. Applications
  must provide recovery procedures (tear protection or back-up management) for interrupted
  transactions.

The term "MIFARE card" in this document refers to contactless cards using ICs from the
MIFARE Classic, MIFARE Ultralight, MIFARE Plus, or MIFARE DESFire product families.

Revision history: Rev 2.0 (2009, superseding AN130810 Rev 1.0 from 2006), Rev 3.0 (2009),
Rev 4.0 (2017), Rev 4.1 (2020, added latest product generations), Rev 4.2 (2021, moved
product distinction flowchart to AN10833, added MIFARE 2GO references).
