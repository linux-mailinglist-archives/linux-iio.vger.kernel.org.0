Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7024CA99
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfFTJUD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:20:03 -0400
Received: from mail-eopbgr810080.outbound.protection.outlook.com ([40.107.81.80]:45248
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTJUD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXQQnqNNCdqJAWCuSxei/N8WB8wUBeQGuDm8VkLygFM=;
 b=r3ANeOT9dz9xPTtGpqW+SplSkWrS1UAVAB0mDZtQxSc50tBg3FD1a8ZWwFqxpymxJ5TGiCmNmaI7RzV2aH9sTLIv1qxBYC1b5+ngdiO9QwK/A7xvoulApZULdt0YGwP6Ze6HWviSZ+w9f2rdTN/JxJfYdnAN+piyGmfEpVQSyH0=
Received: from BN6PR03CA0096.namprd03.prod.outlook.com (10.164.122.162) by
 BN3PR03MB2257.namprd03.prod.outlook.com (10.167.5.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 09:19:59 +0000
Received: from SN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BN6PR03CA0096.outlook.office365.com
 (2603:10b6:405:6f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14 via Frontend
 Transport; Thu, 20 Jun 2019 09:19:59 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT021.mail.protection.outlook.com (10.152.72.144) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:19:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5K9JtwP023189
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:19:55 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:19:55 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 4/4] dt-bindings: iio: adc: Convert ad7124 documentation to YAML
Date:   Thu, 20 Jun 2019 12:19:08 +0300
Message-ID: <20190620091908.12041-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620091908.12041-1-mircea.caprioru@analog.com>
References: <20190620091908.12041-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(199004)(189003)(305945005)(7636002)(426003)(77096007)(50226002)(486006)(48376002)(186003)(2616005)(336012)(7696005)(476003)(966005)(72206003)(26005)(76176011)(53376002)(51416003)(126002)(107886003)(50466002)(446003)(106002)(4326008)(47776003)(246002)(478600001)(6916009)(16586007)(316002)(356004)(6666004)(2906002)(54906003)(5660300002)(11346002)(36756003)(2351001)(8676002)(6306002)(8936002)(70206006)(70586007)(44832011)(1076003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2257;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf28c94-b650-47bc-058b-08d6f56077a4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN3PR03MB2257;
X-MS-TrafficTypeDiagnostic: BN3PR03MB2257:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BN3PR03MB22579E96E6BB288351F215F781E40@BN3PR03MB2257.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: FYCJZTQ5AqGTxNGAl1sicESyF7f3FE4rnl0q3wo2q9R/E1+cBs4/Jif/0aplVHjKtYOJM8arcgrJD7foWrNmci2tv+1uIGPH4DPV0PzwEKJ4c63yuA1Xb9kbjJIx7ncXCfyrDhv5xHAwyYU+NvB7PBd0KQjCyrqhcLnhyrxIxZH5R4C3xCIQ8pWQiB02/Yze4foqeCLS/exL11dQxNi22IoOEU/vFTcRxu21g6nfkUicqNeGaDDQz2WvS60b1x2vRb53DDCaNiUbFsYDAPDJETkqDAazh/HZkxwMr0Q520AviABQ7UmOEKc5GlbHEX485mbWJQCwFCl1MTLvSCZv4IlfEmnVSuDNt3KaeGqwx6zyQqMsBuD+uqRhJETjPl40Ou3HNf9taAnus4/IooQKzrBtzBsq1c1qMWJl/7UBPeY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:19:57.2929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf28c94-b650-47bc-058b-08d6f56077a4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2257
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert AD7124 bindings documentation to YAML format.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
 .../bindings/iio/adc/adi,ad7124.yaml          | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
new file mode 100644
index 000000000000..2dba3759b8e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad7124.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7124 ADC device driver
+
+maintainers:
+  - Stefan Popa <stefan.popa@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
+  found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD7124-8.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7124-4
+      - adi,ad7124-8
+
+  reg:
+    description: SPI chip select number for the device
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: phandle to the master clock (mclk)
+
+  clock-names:
+    items:
+      - const: mclk
+
+  interrupts:
+    description: IRQ line for the ADC
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  refin1-supply:
+    description: refin1 supply can be used as reference for conversion.
+    maxItems: 1
+
+  refin2-supply:
+    description: refin2 supply can be used as reference for conversion.
+    maxItems: 1
+
+  avdd-supply:
+    description: avdd supply can be used as reference for conversion.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+patternProperties:
+  "^channel@[01]$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+      See Documentation/devicetree/bindings/iio/adc/adc.txt.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 8 channels on ad7124-4
+          and 16 channels on ad7124-8, numbered from 0 to 15.
+        maxItems: 1
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on
+          the specific channel.
+          If this field is left empty, internal reference is selected.
+        maxItems: 1
+
+      diff-channels:
+        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+        maxItems: 1
+
+      bipolar:
+        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+        maxItems: 1
+
+      adi,buffered-positive:
+        description: Enable buffered mode for positive input.
+        maxItems: 1
+
+      adi,buffered-negative:
+        description: Enable buffered mode for negative input.
+        maxItems: 1
+
+    required:
+      - reg
+      - diff-channels
+
+examples:
+  - |
+    adc@0 {
+      compatible = "adi,ad7124-4";
+      reg = <0>;
+      spi-max-frequency = <5000000>;
+      interrupts = <25 2>;
+      interrupt-parent = <&gpio>;
+      refin1-supply = <&adc_vref>;
+      clocks = <&ad7124_mclk>;
+      clock-names = "mclk";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      channel@0 {
+        reg = <0>;
+        diff-channels = <0 1>;
+        adi,reference-select = <0>;
+        adi,buffered-positive;
+      };
+
+      channel@1 {
+        reg = <1>;
+        bipolar;
+        diff-channels = <2 3>;
+        adi,reference-select = <0>;
+        adi,buffered-positive;
+        adi,buffered-negative;
+      };
+
+      channel@2 {
+        reg = <2>;
+        diff-channels = <4 5>;
+      };
+
+      channel@3 {
+        reg = <3>;
+        diff-channels = <6 7>;
+      };
+    };
-- 
2.17.1

