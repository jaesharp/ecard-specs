# GlobalPlatform Secure Element Access Control

This directory contains the GlobalPlatform Secure Element Access Control
specification.

- **GPD_SE_Access_Control_v1.1.pdf** -- GlobalPlatform Device Technology,
  Secure Element Access Control, Version 1.1, September 2014. Document
  Reference: GPD_SPE_013. Public Release. Defines the access control
  architecture and mechanisms for controlling which device applications may
  access applets on a Secure Element. Covers access control architecture
  (rules in Issuer Security Domain only, rules in both ISD and Application
  Provider Security Domains, Access Rule File support, rule enforcement),
  access control rules (DeviceAppID identification via AppID/UUID or
  certificate, NFC-specific enforcement, rule conflict resolution and
  combination), the device interface (GET DATA command for rule retrieval,
  access control evaluation steps, certificate chain management, version
  management), the remote interface based on RAM (STORE DATA command for
  rule provisioning), general data objects (access rule reference data
  objects, access rule data objects, configuration management data objects),
  and Access Rule File structure (PKCS#15-based file paths, ACMF/ACRF/ACCF
  files, ASN.1 definitions, file system validity). Includes annexes with
  data object nesting summaries, data object tags, access control data
  examples, rules conflict management examples, APDU process flows (device
  and remote/OTA), and UICC migration scenarios.
