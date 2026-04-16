#!/usr/bin/env bash
# telecom-standards/download.sh
# Downloads freely available GlobalPlatform, JavaCard, JCOP, and EMV specifications.
# Run from the telecom-standards/ directory.
# Re-running is safe: curl -z skips if local file is newer than remote.

set -euo pipefail
cd "$(dirname "$0")"

mkdir -p globalplatform globalplatform/se-access-control \
         javacard/2.1.1 javacard/2.2.2 javacard/3.0.5 javacard/3.1 \
         ibm-jcop iso emv research reference-implementations

# ---------------------------------------------------------------------------
# GlobalPlatform Card Specifications
# ---------------------------------------------------------------------------

# GP 2.1.1 (the spec JCOP10-31bio actually implement; OP 2.0.1 heritage)
curl -z globalplatform/GPC_CardSpecification_v2.1.1.pdf -sL -o globalplatform/GPC_CardSpecification_v2.1.1.pdf \
  "https://pinpasjc.win.tue.nl/docs/Card%20Spec%20v2.1.1%20v0303.pdf"

# GP 2.2 (intermediate version, TU/e Eindhoven mirror)
curl -z globalplatform/GPC_CardSpecification_v2.2.pdf -sL -o globalplatform/GPC_CardSpecification_v2.2.pdf \
  "https://pinpasjc.win.tue.nl/docs/GPCardSpec_v2.2.pdf"

# GP 2.2.1 (intermediate version, direct from GlobalPlatform)
curl -z globalplatform/GPC_CardSpecification_v2.2.1.pdf -sL -o globalplatform/GPC_CardSpecification_v2.2.1.pdf \
  "https://globalplatform.org/wp-content/uploads/2018/06/GPC_Specification-2.2.1.pdf"

# GP 2.3.1 (current CC-certified release, best normative clarity)
curl -z globalplatform/GPC_CardSpecification_v2.3.1.pdf -sL -o globalplatform/GPC_CardSpecification_v2.3.1.pdf \
  "https://globalplatform.org/wp-content/uploads/2018/05/GPC_CardSpecification_v2.3.1_PublicRelease_CC.pdf"

# SCP03 Amendment D v1.1.2 (AES-based secure channel, forward compat)
curl -z globalplatform/GPC_2.3_D_SCP03_v1.1.2.pdf -sL -o globalplatform/GPC_2.3_D_SCP03_v1.1.2.pdf \
  "https://globalplatform.org/wp-content/uploads/2014/07/GPC_2.3_D_SCP03_v1.1.2_PublicRelease.pdf"

# GP 2.1.1 Mapping Guidelines (OP 2.0.1 -> GP 2.1.1 migration notes)
curl -z globalplatform/GP_2.1.1_Mapping_Guidelines.pdf -sL -o globalplatform/GP_2.1.1_Mapping_Guidelines.pdf \
  "https://globalplatform.org/wp-content/uploads/2018/06/2.1.1_Mapping_guidelines_v1.0.1-Final.pdf"

# Amendment A v1.0.1 (Confidential Card Content Management, older public release)
curl -z globalplatform/GPC_2.2_Amendment_A_v1.0.1.pdf -sL -o globalplatform/GPC_2.2_Amendment_A_v1.0.1.pdf \
  "https://globalplatform.org/wp-content/uploads/2018/09/GPC-Spec_2.2_Amendment_A_1.0.1.pdf"

# Amendment A v1.2 (latest freely available public release)
curl -z globalplatform/GPC_2.3_A_ConfidentialCCM_v1.2.pdf -sL -o globalplatform/GPC_2.3_A_ConfidentialCCM_v1.2.pdf \
  "https://globalplatform.org/wp-content/uploads/2019/07/GPC_2.3_A_ConfidentialCardContentMgmt_v1.2_PublicRelease-replacement.pdf"

# Amendment B v1.1.3 (Remote Application Management over HTTP / SCP81)
curl -z globalplatform/GPC_2.2_B_RAM_over_HTTP_v1.1.3.pdf -sL -o globalplatform/GPC_2.2_B_RAM_over_HTTP_v1.1.3.pdf \
  "https://globalplatform.org/wp-content/uploads/2018/06/GPC_2.2_B_Remote_Application_Mgmt_over_HTTP_v1.1.3.pdf"

# Amendment C v1.2 (Contactless Services, ISO 14443 integration)
curl -z globalplatform/GPC_2.3_C_ContactlessServices_v1.2.pdf -sL -o globalplatform/GPC_2.3_C_ContactlessServices_v1.2.pdf \
  "https://globalplatform.org/wp-content/uploads/2018/06/GPC_2.3_C_ContactlessServices_v1.2.pdf"

# Amendment E v1.1 (Security Upgrade - ECC/RSA; content re-integrated into GPCS + Amd A)
curl -z globalplatform/GPC_2.3_E_SecurityUpgrade_v1.1.pdf -sL -o globalplatform/GPC_2.3_E_SecurityUpgrade_v1.1.pdf \
  "https://globalplatform.org/wp-content/uploads/2016/11/GPC_2.3_E_SecurityUpgrade_v1.1_PublicRelease.pdf"

# UICC Configuration Contactless Extension v1.0
curl -z globalplatform/GPC_UICC_ContactlessExtn_v1.0.pdf -sL -o globalplatform/GPC_UICC_ContactlessExtn_v1.0.pdf \
  "https://globalplatform.org/wp-content/uploads/2013/06/2012-02-15-for-Member-Release-GPC_UICC_ContactlessExtn_1.0.pdf"

# SE Access Control v1.1 (Android HCE integration)
curl -z globalplatform/se-access-control/GPD_SE_Access_Control_v1.1.pdf -sL -o globalplatform/se-access-control/GPD_SE_Access_Control_v1.1.pdf \
  "https://globalplatform.org/wp-content/uploads/2014/10/GPD_SE_Access_Control_v1.1.pdf"

# ---------------------------------------------------------------------------
# JavaCard Platform Specifications
# ---------------------------------------------------------------------------

# JavaCard 2.1.1 (JCVM + JCRE + API) -- what all JCOP10-31bio implement
# Distributed as a ZIP archive from Oracle OTN (free click-through license)
if [ ! -f javacard/2.1.1/JCVMSpec.pdf ]; then
  echo "Downloading JavaCard 2.1.1 spec bundle..."
  curl -sL -o /tmp/jc211-doc.zip \
    -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    "https://download.oracle.com/otn-pub/jcp/7233-javacard-2.1.1-spec-oth-JSpec/java_card_kit-2_1_1-doc.zip"
  unzip -o -j /tmp/jc211-doc.zip "*/JCVMSpec.pdf" -d javacard/2.1.1/
  unzip -o -j /tmp/jc211-doc.zip "*/JCRESpec.pdf" -d javacard/2.1.1/
  unzip -o -j /tmp/jc211-doc.zip "*/JavaCard211API.pdf" -d javacard/2.1.1/
  unzip -o -j /tmp/jc211-doc.zip "*/JC211SpecRelease.pdf" -d javacard/2.1.1/
  rm -f /tmp/jc211-doc.zip
fi

# JavaCard 2.2.2 (many open-source applets target this version)
# Distributed as ZIP from Oracle JCP archive (free click-through license)
if [ ! -f javacard/2.2.2/JavaCard222VMspec.pdf ]; then
  echo "Downloading JavaCard 2.2.2 spec bundle..."
  curl -sL -o /tmp/jc222-spec.zip \
    -H "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/jcp/java_card_kit-2.2.2-fr-oth-JSpec/java_card_kit-2_2_2-fr-spec.zip"
  unzip -o -j /tmp/jc222-spec.zip "*/JavaCard222VMspec.pdf" -d javacard/2.2.2/
  unzip -o -j /tmp/jc222-spec.zip "*/JavaCard222JCREspec.pdf" -d javacard/2.2.2/
  unzip -o -j /tmp/jc222-spec.zip "*/JavaCard222API.pdf" -d javacard/2.2.2/
  rm -f /tmp/jc222-spec.zip
fi

# JavaCard 3.0.5 (current classic edition, from GitHub mirror usasmartcard/Javacard-API)
# NOTE: Filenames on GitHub have spaces; these are consolidated spec PDFs, not separate JCVM/JCRE
if [ ! -f javacard/3.0.5/JCVMSpec_3.0.5.pdf ]; then
  echo "Downloading JavaCard 3.0.5 specs from GitHub mirror..."
  TMP_REPO=$(mktemp -d)
  git clone --depth 1 https://github.com/usasmartcard/Javacard-API.git "$TMP_REPO" 2>/dev/null
  # Note: double space in "Specification  3.0.5" is intentional (repo filename)
  cp "$TMP_REPO/Java Card Specification  3.0.5.pdf" javacard/3.0.5/JCVMSpec_3.0.5.pdf
  cp "$TMP_REPO/Javacard Runtime 3.0.5.pdf" javacard/3.0.5/JCRESpec_3.0.5.pdf
  # Also grab 3.2 and developer guide while we have the repo
  cp "$TMP_REPO/Java Card Specification 3.2.pdf" javacard/JCVMSpec_3.2.pdf 2>/dev/null || true
  cp "$TMP_REPO/Javacard Runtime 3.2.pdf" javacard/JCRESpec_3.2.pdf 2>/dev/null || true
  cp "$TMP_REPO/Java Card Applet Developers Guide.pdf" javacard/ 2>/dev/null || true
  rm -rf "$TMP_REPO"
fi

# JavaCard 3.1 VM Spec (latest, best normative clarity for ambiguous 2.1.1 behavior)
curl -z javacard/3.1/JCVMSpec_3.1.pdf -sL -o javacard/3.1/JCVMSpec_3.1.pdf \
  "https://docs.oracle.com/en/java/javacard/3.1/jc-vm-spec/F12650_05.pdf"

# JavaCard 3.1 JCRE Spec
curl -z javacard/3.1/JCRESpec_3.1.pdf -sL -o javacard/3.1/JCRESpec_3.1.pdf \
  "https://docs.oracle.com/en/java/javacard/3.1/jc-re-spec/F12651_05.pdf"

# ---------------------------------------------------------------------------
# IBM JCOP Product Documentation
# ---------------------------------------------------------------------------

curl -z ibm-jcop/JCOP_Family.pdf -sL -o ibm-jcop/JCOP_Family.pdf \
  "https://public.dhe.ibm.com/software/pervasive/info/JCOP_Family.pdf"

curl -z ibm-jcop/JCOP10Brief.pdf -sL -o ibm-jcop/JCOP10Brief.pdf \
  "https://public.dhe.ibm.com/software/pervasive/info/JCOP10Brief.pdf"

curl -z ibm-jcop/JCOP20Brief.pdf -sL -o ibm-jcop/JCOP20Brief.pdf \
  "https://public.dhe.ibm.com/software/pervasive/info/JCOP20Brief.pdf"

# ---------------------------------------------------------------------------
# EMV Specifications (v4.3 mirrors -- official latest requires $850/yr EMVCo sub)
# ---------------------------------------------------------------------------

# EMV v4.3 Book 3: Application Specification (GitHub mirror, mvallim)
curl -z emv/EMV_v4.3_Book_3_Application_Specification.pdf -sL -o emv/EMV_v4.3_Book_3_Application_Specification.pdf \
  "https://mvallim.github.io/emv-qrcode/docs/EMV_v4.3_Book_3_Application_Specification_20120607062110791.pdf"

# EMV v4.3 Book 4: Other Interfaces (GitHub mirror, mvallim)
curl -z emv/EMV_v4.3_Book_4_Other_Interfaces.pdf -sL -o emv/EMV_v4.3_Book_4_Other_Interfaces.pdf \
  "https://mvallim.github.io/emv-qrcode/docs/EMV_v4.3_Book_4_Other_Interfaces_20120607062305603.pdf"

# NOTE: EMV Books 1 (ICC to Terminal Interface) and 2 (Security and Key Management)
# are on Scribd/PDFCoffee but not cleanly downloadable via curl.
# See SPEC_TO_PLAN_MAP.md for mirror search status.

# ---------------------------------------------------------------------------
# ISO Reference Materials (free application notes / summaries)
# ---------------------------------------------------------------------------

# NXP AN10834: ISO 14443 Type A contactless overview
curl -z iso/iso14443-reference-NXP-AN10834.pdf -sL -o iso/iso14443-reference-NXP-AN10834.pdf \
  "https://www.nxp.com/docs/en/application-note/AN10834.pdf"

# ---------------------------------------------------------------------------
# Research Papers
# ---------------------------------------------------------------------------

# CARDIS 2023: JavaCard feature adoption analysis (MUNI Brno)
curl -z research/2023-cardis-javacard.pdf -sL -o research/2023-cardis-javacard.pdf \
  "https://crocs.fi.muni.cz/_media/publications/pdf/2023-cardis-javacard.pdf"

# Curated JavaCard applet list (crocs-muni)
curl -z research/javacard-curated-list.md -sL -o research/javacard-curated-list.md \
  "https://raw.githubusercontent.com/crocs-muni/javacard-curated-list/refs/heads/master/README.md"

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------

echo ""
echo "=== telecom-standards collection ==="
find . -type f \( -name "*.pdf" -o -name "*.md" \) -not -path "./.git/*" | sort | while read -r f; do
  printf "  %8s  %s\n" "$(stat -c%s "$f" | numfmt --to=iec)" "$f"
done
echo ""
echo "Total PDFs: $(find . -name '*.pdf' -not -path './.git/*' | wc -l)"
echo "Done."
