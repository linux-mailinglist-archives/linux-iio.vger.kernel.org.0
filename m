Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61F029348
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2019 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbfEXIl0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 May 2019 04:41:26 -0400
Received: from mail-eopbgr690055.outbound.protection.outlook.com ([40.107.69.55]:56526
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389281AbfEXIl0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 May 2019 04:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml0VBRm1UNmaas8mhCPclTvcY52wlsaKS9mUMbMBU2Y=;
 b=9fpkJJG1S40c8Z5vhWCge4piGEtHf9rGEHwwnSkUGWhDkWqDDMwegXpnlenoSNlqqpoY3+8+kMZv4gyENktAf/vGWHBFsdbEIhd0k8pJC/J2Lzb6/yrslcwK0bhDic2k8xw0gExYmN2+BcWhBaQtUFfedvaOk+2ClEwMu5SEezU=
Received: from BN8PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:94::22)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Fri, 24 May
 2019 08:41:22 +0000
Received: from BL2NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN8PR03CA0009.outlook.office365.com
 (2603:10b6:408:94::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.15 via Frontend
 Transport; Fri, 24 May 2019 08:41:22 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT041.mail.protection.outlook.com (10.152.77.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Fri, 24 May 2019 08:41:21 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4O8fLta014608
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 24 May 2019 01:41:21 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 24 May 2019 04:41:21 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
Date:   Fri, 24 May 2019 11:41:15 +0300
Message-ID: <1558687275-3037-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39860400002)(346002)(2980300002)(189003)(199004)(6666004)(356004)(70586007)(5660300002)(6306002)(47776003)(36756003)(72206003)(966005)(70206006)(478600001)(2616005)(7636002)(476003)(50466002)(4326008)(48376002)(486006)(126002)(107886003)(50226002)(53376002)(2906002)(305945005)(110136005)(77096007)(26005)(186003)(106002)(51416003)(8676002)(426003)(16586007)(336012)(54906003)(246002)(316002)(44832011)(7416002)(7696005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2303ada-b1ba-4a27-a9ea-08d6e023994b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR03MB546;
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BL2PR03MB5467F20B89A5E12BEC0027F9D020@BL2PR03MB546.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0047BC5ADE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uVpuAfOV8WztObwr2GwX5bxi1qiXkb2h2X28NjFO28KU2W0mP7rvYvPlDmjHEbXEzV7Qyyn/RtatSlxuXJ8J2Qmgfgv4DydCrpGJ/c++5QRrAL6Vabp/ksJnXBcarK2Ov3LfiRXKORuLWMgcssc/sGlJf9GTXlby82XpiPqLZln4XhdlbqITN/Y3EqJlXacHiFpdgPoUpg8gs1oTajvya/GR/Sgttt0DShdqm+iLw8vwMegZjqPGgu5azbDWctLb3rSJ9ObuBgKvT+NhblSPtqsd994g0GHIFrcFMhjryuy1EKJEq9IIZiqZo6fiMbs3fGFLKX+2acJHiOsFCaEXVwepK04hdvf+yb9dJkFA14+X1IqogqU5dDbO/Gg+qNJc3MCa9pOBnpAPZPG2Obxzx1SpHD56MyTQ8/5EMUXf3EA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2019 08:41:21.8873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2303ada-b1ba-4a27-a9ea-08d6e023994b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
	- Nothing changed

 .../devicetree/bindings/iio/frequency/adf4371.yaml | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
new file mode 100644
index 0000000..d7adf074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adf4371.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADF4371 Wideband Synthesizer
+
+maintainers:
+  - Popa Stefan <stefan.popa@analog.com>
+
+description: |
+  Analog Devices ADF4371 SPI Wideband Synthesizer
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adf4371.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adf4371
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description:
+      Definition of the external clock (see clock/clock-bindings.txt)
+    maxItems: 1
+
+  clock-names:
+    description:
+      Must be "clkin"
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        frequency@0 {
+                compatible = "adi,adf4371";
+                reg = <0>;
+                spi-max-frequency = <1000000>;
+                clocks = <&adf4371_clkin>;
+                clock-names = "clkin";
+        };
+    };
+...
-- 
2.7.4

