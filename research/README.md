# JavaCard Research

## Documents

### 2023-cardis-javacard.pdf

"The adoption rate of JavaCard features by certified products and open-source projects"
by Lukas Zaoral (Red Hat), Antonin Dufka, and Petr Svenda (Masaryk University). Published
in Proceedings of the 22nd Smart Card Research and Advanced Application Conference (CARDIS
2023), Lecture Notes in Computer Science, vol 14530, pp. 169-189, Springer.

This paper analyzes the JavaCard ecosystem by mapping activity from two sources: (1)
security certification documents from Common Criteria and FIPS140 schemes, and (2) activity
and resource requirements of JavaCard applets released as open-source projects.

The analysis covers all certificates issued between 1997 and 2023 and more than 200 public
JavaCard applets. Key findings include:

- New features from the JavaCard specification are adopted slowly. It typically takes six or
  more years before a majority of certified products add support for newly specified features.
- Open-source applets adopt new features even later, likely due to the unavailability of
  recent performant smartcards in smaller quantities.
- Almost 70% of constants defined in the JavaCard API specification are completely unused in
  open-source applets.
- Applet portability improves with recent cards, and transient memory requirements are
  typically small.
- Around twenty products have been consistently certified every year since 2009. The
  open-source ecosystem became more active around 2013 but appeared to decline in recent
  years.
- JavaCard API version 2.2.2 was in use for the longest period, remaining common in
  certification documents from 2008 through 2017 and still appearing in 2022.

The paper includes analysis of certification documents for JavaCard algorithm adoption
(matching ALG_ prefixed strings), tracking when algorithms introduced in API versions 3.0.1,
3.0.4, 3.0.5, and 3.1.0 first appeared in certified products.

Supplementary materials and tools are available at https://crocs.fi.muni.cz/papers/cardis2023

### javacard-curated-list.md

A curated catalog of all known open-source JavaCard applets and applications, compiled by
exhaustive search of GitHub, SourceForge, and GitLab repositories containing the
'javacard.framework' keyword. Maintained as a community resource with contributions accepted
via pull request; entries are organized lexicographically within each section.

The list is organized into the following categories:

- Applets (standalone applications): electronic passports and citizen ID, authentication and
  access control, payments and loyalty, key and password managers, digital signing/OpenPGP/mail
  security, e-Health, NDEF tags, cryptocurrency wallets, emulation of proprietary cards, mobile
  telephony and SIM toolkits
- Library code for use within other projects
- Developer tools: applet build/upload/management, card capabilities testing, formal
  verification and code transformation
- JavaCard simulators and emulators
- Learning projects

Repositories listed here are backed up under the 'javacard-FOSS-applets' GitHub organization
to preserve them if originals are moved or deleted. The Software Heritage archive provides an
additional preservation option.

This list was analyzed and published in the CARDIS 2023 paper above and in an earlier 2017
analysis: "Analysis of JavaCard open-source ecosystem" (Medium/Enigma Shards).
