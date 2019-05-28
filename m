Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C06C42C4DC
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2019 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfE1K41 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 May 2019 06:56:27 -0400
Received: from mail-eopbgr770085.outbound.protection.outlook.com ([40.107.77.85]:28807
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfE1K41 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 May 2019 06:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwV8OShxfwW0qegSCpjAggTC97WmyfImuuoeB/q3850=;
 b=Sb7eIfOikVaBDV+5E3nOVtc3obYFU09H4waGr0yPskE2ZV8PzI9SG/CzmJGKnLdd3KIwfF9xJpINA3Lo0L0JB+vjZQ2Wur+sodzYQP/XDjUcGh+NYvx7bm0P/AdMGoVmDx1dqbVr6595UGAu6u6TNYgEnAOTcTNOJW+F5UWyrG4=
Received: from CY1PR03CA0012.namprd03.prod.outlook.com (2603:10b6:600::22) by
 BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.23; Tue, 28 May 2019 10:56:24 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by CY1PR03CA0012.outlook.office365.com
 (2603:10b6:600::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Tue, 28 May 2019 10:56:24 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Tue, 28 May 2019 10:56:23 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4SAuMkp004510
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 28 May 2019 03:56:22 -0700
Received: from linux.ad.analog.com (10.50.1.179) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 28 May 2019
 06:56:22 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
Date:   Tue, 28 May 2019 13:56:08 +0300
Message-ID: <1559040968-13832-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(189003)(7696005)(8936002)(51416003)(426003)(44832011)(336012)(7416002)(6306002)(6666004)(356004)(77096007)(53376002)(107886003)(186003)(478600001)(50226002)(72206003)(4326008)(26005)(966005)(8676002)(48376002)(70586007)(47776003)(36756003)(110136005)(50466002)(16586007)(7636002)(54906003)(305945005)(246002)(486006)(2616005)(476003)(126002)(106002)(5660300002)(316002)(70206006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54f7bb44-9d3f-41b8-6794-08d6e35b201a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709054)(1401327)(2017052603328);SRVR:BL2PR03MB546;
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BL2PR03MB546177C5988CF82EF6583D59D1E0@BL2PR03MB546.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 00514A2FE6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6sB1sfdFqkpb1R8U/0u4qKuzJn2KiE+EN9LernPABm64vHCZzkV5pq7jwurSwbOAUUOngjm+VPqgbwXWNpdT+eMovx6HuMAxe+nm+dmxljP63EPWhAU3jPzlvYaFmURD17UTKRMMGKFNCj36p9A7OU+ohJm0PPu5lcCrZl2qFvGICgGbCcsQp3SIOsT5SonmoHpvsI0LVVdXJdDE1JG9LCXnRhVkTysQxGRfI7pq7eu9qyRQZOGncDWm79/7i5WVy4ni6zDXfQGsw6aOuwmGtK87KT1/bXX0RkHENthFkWuF7ZNJyeJ2ZJBkZ+yZsbIefogFDLOyw01NOzwUbowSkEDzZ64qbnds1EDytjCtpGRxHsq9bugwIoVABgIvCdFTmtB00WqwqGVu5xvUvnxuPeGfUKpnlqgeQKEs99a44qk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2019 10:56:23.2808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f7bb44-9d3f-41b8-6794-08d6e35b201a
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
	- Nothing changed.
Changes in v3:
	- Nothing changed.

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

