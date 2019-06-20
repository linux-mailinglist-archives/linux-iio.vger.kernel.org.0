Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9941F4CB30
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfFTJmo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 05:42:44 -0400
Received: from mail-eopbgr820051.outbound.protection.outlook.com ([40.107.82.51]:11176
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfFTJmo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 20 Jun 2019 05:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXQQnqNNCdqJAWCuSxei/N8WB8wUBeQGuDm8VkLygFM=;
 b=mbwn4/k417OBX/5P7dqUJFz0x63+w7omLff3sg/P7nqJP5AUk28JhE/o3b+/IRsmX/hTW5SsiOXm+LTrrhKeyclQHB6FTxjCOnWnMExC1QxJXeBoC62WfyDSPceCWZ5Q+OHHwP55xXPiq+E4I2mMW9KjZjQBw6BvYwV5xtvU514=
Received: from BN6PR03CA0113.namprd03.prod.outlook.com (2603:10b6:404:10::27)
 by CO2PR03MB2263.namprd03.prod.outlook.com (2603:10b6:102:a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.12; Thu, 20 Jun
 2019 09:42:40 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BN6PR03CA0113.outlook.office365.com
 (2603:10b6:404:10::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13 via Frontend
 Transport; Thu, 20 Jun 2019 09:42:40 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Thu, 20 Jun 2019 09:42:38 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5K9gclY013393
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 20 Jun 2019 02:42:38 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Jun 2019 05:42:37 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [RESEND PATCH 4/4] dt-bindings: iio: adc: Convert ad7124 documentation to YAML
Date:   Thu, 20 Jun 2019 12:42:03 +0300
Message-ID: <20190620094203.13654-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620094203.13654-1-mircea.caprioru@analog.com>
References: <20190620094203.13654-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(199004)(189003)(7636002)(356004)(107886003)(8676002)(76176011)(48376002)(305945005)(186003)(26005)(316002)(2351001)(6666004)(7696005)(16586007)(246002)(54906003)(8936002)(50466002)(2906002)(70206006)(11346002)(4326008)(478600001)(5660300002)(1076003)(6306002)(51416003)(50226002)(6916009)(2616005)(70586007)(446003)(53376002)(486006)(86362001)(426003)(106002)(72206003)(36756003)(44832011)(476003)(966005)(77096007)(336012)(126002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2263;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13cea9dc-4138-4014-a4ea-08d6f563a268
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:CO2PR03MB2263;
X-MS-TrafficTypeDiagnostic: CO2PR03MB2263:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <CO2PR03MB2263CB3C928ADBF1BD08EB7B81E40@CO2PR03MB2263.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0074BBE012
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: BkubUVsok9dg3KwqRG2juUOwVKUAjTpsloHwdtTcDYPKX7E6kp0b5+9P7CXy9NFOudhsTgjqKLGJh7cebzGoYoJs096GogMyyhCH0KNzgf6RlhZZXx0JzfERWioGH/DS7PWZXa9+HnbYxDXk/noKQWxVV8z4T+/PL1nxOUiu5rCn2D6xKRKhf9OCCqVTIxKFaRliKJSr6AFsFu8LHPXpdUxy93ut8+USZpiHzSvGygWiaRk3WkOJTCQmrPdk45kQmVuoa1YT0X4sTdzuur/BUt5WCoSAGFqvKGtkRRSTDSs22/nfgAnUw2VyKEDPvUVQ03W3HFK2NgjD8/sodcClMBsuCgiSQCTzIcwei+4+XG25lt4/9Nu6qYsh673wlWlgtt8AZ0elLq1JuZUObhjMWdkivWDLcwre5eJDa+GHz2c=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2019 09:42:38.9784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cea9dc-4138-4014-a4ea-08d6f563a268
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2263
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

