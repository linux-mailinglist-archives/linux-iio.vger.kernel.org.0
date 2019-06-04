Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AD34B1B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfFDO6d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 10:58:33 -0400
Received: from mail-eopbgr720064.outbound.protection.outlook.com ([40.107.72.64]:49729
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727537AbfFDO6d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jun 2019 10:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkyBvH8VDYehPn/N5ezTXNCAie7hF3owBLh+v5GlZWI=;
 b=bVN/R/sLBHh3ZBz+VfgkoccGWVD34/WbQbQVJ02OIHek6DikgEATjZEtoP6BLGaM5rZcQ/FNFEYjYJDjdTbB/nD5mwyBPIw5RoEkga7C/75EiEY6AYRfg+Xp7b0U8wMyLWzSK+uvuYZK6T1OUHqp/TvC1hSC6WcTUT4d+bNfBG8=
Received: from BN3PR03CA0087.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::47) by BY2PR03MB556.namprd03.prod.outlook.com
 (2a01:111:e400:2c3a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Tue, 4 Jun
 2019 14:58:29 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BN3PR03CA0087.outlook.office365.com
 (2a01:111:e400:7a4d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.20 via Frontend
 Transport; Tue, 4 Jun 2019 14:58:28 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1943.19
 via Frontend Transport; Tue, 4 Jun 2019 14:58:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x54EwPCn008279
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 4 Jun 2019 07:58:25 -0700
Received: from linux.ad.analog.com (10.32.224.122) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 4 Jun 2019 10:58:25 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v6 2/2] dt-bindings: iio: frequency: Add docs for ADF4371 PLL
Date:   Tue, 4 Jun 2019 17:58:21 +0300
Message-ID: <1559660301-12298-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(199004)(189003)(70206006)(70586007)(77096007)(53376002)(107886003)(476003)(2906002)(26005)(126002)(50466002)(16586007)(5660300002)(246002)(186003)(6306002)(356004)(6666004)(305945005)(44832011)(966005)(486006)(7696005)(51416003)(478600001)(8676002)(7416002)(36756003)(316002)(336012)(72206003)(8936002)(47776003)(2616005)(48376002)(106002)(426003)(54906003)(110136005)(4326008)(7636002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB556;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22353854-a950-4ab7-8a65-08d6e8fd1a74
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BY2PR03MB556;
X-MS-TrafficTypeDiagnostic: BY2PR03MB556:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BY2PR03MB556C576D9EC7C23B90C63C59D150@BY2PR03MB556.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0058ABBBC7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: IRycg2aCR4BvjLB1pdz7bam6khCXbJZSwY/dE2CTukFoHFjf18EMUqUzg2w7vC25Tq3pmoBptnKQtyekgfX6bwyH1j01eBFY5nGIT93cnF0L0QW/Scb7YAKrDPo0oljPUz3dPzNxt1ffZNT1rvlxAp5GaKADcRpQxH3HZ4Jnzech6YOy3Pge31OvZ49SPjbXFi3+pJIdgc4V8lbNnohB0S3IPrmpmRaPaLT1a29AOAhhm5eR3zEumjXEuD8/VtGbPzheW6K3OrXHhiwrUu7T/ZHjGj1X7Nv4R96LwfqXM+Yuo7K6QqgWk0CP5815sl1BVySor48G1g24N7thzrPAuRpHdYj6rAJEozlZKKVv/ovylbwqdIKgSefAC11bhxAxVKcfZ8kF4TXkxtVCh3zVJBDqSndJY/cfE+4CkBYXmCI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2019 14:58:28.0143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22353854-a950-4ab7-8a65-08d6e8fd1a74
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB556
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
Changes in v4:
	- Nothing changed.
Changes in v5:
	- Nothing changed.
Changes in v6:
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

