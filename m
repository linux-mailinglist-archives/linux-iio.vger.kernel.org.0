Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3244C347A4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 15:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFDNIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 09:08:30 -0400
Received: from mail-eopbgr680049.outbound.protection.outlook.com ([40.107.68.49]:24226
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727276AbfFDNIa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jun 2019 09:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHzerxANfLKVuklCjD4HWWszYeByUUdVmCcA6XtN+UQ=;
 b=qkDSVDcYTE9uNaPhYf4JJMQcYdmbkek7N6ivxKhscgJlTPwqP5jBDxD6yGcc6GSAOcCzpOEKP51+M06Y4LPBWn8ghxhlPUocfl9xKvEwgbGCOw16n0qjnqBqbdeMBog5f6N62HURYVBFNR+cFOoYKlrCrFQKemdLFdi0yJKs9p0=
Received: from DM5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:4:3b::18) by
 CO2PR03MB2262.namprd03.prod.outlook.com (2603:10b6:102:e::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Tue, 4 Jun 2019 13:08:26 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by DM5PR03CA0029.outlook.office365.com
 (2603:10b6:4:3b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.18 via Frontend
 Transport; Tue, 4 Jun 2019 13:08:26 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1943.19
 via Frontend Transport; Tue, 4 Jun 2019 13:08:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x54D8Mma011418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 4 Jun 2019 06:08:22 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 4 Jun 2019 09:08:22 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v5 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
Date:   Tue, 4 Jun 2019 16:08:17 +0300
Message-ID: <1559653697-2760-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(426003)(336012)(44832011)(186003)(106002)(2906002)(77096007)(36756003)(7696005)(7416002)(8936002)(70206006)(70586007)(50226002)(47776003)(26005)(48376002)(51416003)(107886003)(50466002)(53376002)(4326008)(5660300002)(8676002)(356004)(478600001)(7636002)(110136005)(72206003)(6666004)(966005)(16586007)(54906003)(126002)(305945005)(486006)(2616005)(316002)(476003)(6306002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2262;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53a43ac7-aac3-4b75-9066-08d6e8edbadb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CO2PR03MB2262;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2262:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CO2PR03MB2262A151AFDDAB4D702CF6D99D150@CO2PR03MB2262.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0058ABBBC7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JqeCVyRk9wIKcgKibpO4SNMVdKdXHmrdCetDRWL14/gqOZQj3C37ROTzwnh/Z8WooVVbh2/LPXC152Moa5FPCjsIuM3x5rFQgKXYwpcT/cRH7/zXhOdmJMoe0DemTiy4cxLHJ64mYScXaZrVcJ+cliuR728BYksHs89I1Kzw2NW+0sg9z6ZnTEMQHFZAFY0p3J0EjVIV5A5PCIHO4+SqDR1eSQ7ZlAfIAS2Oed163BTByvtpdaJF1Vd1If5LVFSkIoBgdMdttWhvtEJwnUhbVwqTOMhurNUvF7m6GvM4Q7UmBmX/76XRXqqes/WalvvB/jztxdXjncE8bstv0AqP3mvK9KmILGaTQx7MjghMDGBrQSG+E31goH9R0hn7wfyXNxsGCOb9BPexrHu4W37w8/3YDmFfXEw+Ipd4q6m/YkE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2019 13:08:24.7729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a43ac7-aac3-4b75-9066-08d6e8edbadb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2262
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document support for Analog Devices ADF4371 SPI Wideband Synthesizer.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Nothing changed.
Changes in v3:
	- Nothing changed.
Changes in v4:
	- Nothing changed.
Changes in v5:
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

