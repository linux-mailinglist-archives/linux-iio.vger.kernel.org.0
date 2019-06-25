Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F55262F
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2019 10:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfFYIMe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jun 2019 04:12:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37610 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726783AbfFYIMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jun 2019 04:12:33 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P87VCc032083;
        Tue, 25 Jun 2019 04:12:09 -0400
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2tbc6g8jye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 04:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzwPRTRNt3YDZuFL7LFtShifw0LfohjzFR0MrsyKhrA=;
 b=gc6dsABMQiPCIdGFpwygQF/ZoTCZ/D6Q/ER+hntE6iWbR9GLaKYtEsKi9jYcShsINP95s/eERxyA+VwAXNnfcsV32+hyKQzOPmLddknfLwTdaU8NM2HL0Yw1G1LZRl+zl1dRqxLXrRVJchmaBFC1lBWzHnpY+Fx56Kz6FdITtiA=
Received: from BN6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:405:6f::13)
 by BLUPR03MB550.namprd03.prod.outlook.com (2a01:111:e400:880::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Tue, 25 Jun
 2019 08:12:06 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN6PR03CA0075.outlook.office365.com
 (2603:10b6:405:6f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16 via Frontend
 Transport; Tue, 25 Jun 2019 08:12:06 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Tue, 25 Jun 2019 08:12:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5P8C44j022714
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 25 Jun 2019 01:12:04 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 25 Jun 2019 04:12:04 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V4 4/5] dt-bindings: iio: adc: Convert ad7124 documentation to YAML
Date:   Tue, 25 Jun 2019 11:11:27 +0300
Message-ID: <20190625081128.22190-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625081128.22190-1-mircea.caprioru@analog.com>
References: <20190625081128.22190-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(199004)(189003)(54534003)(4326008)(54906003)(47776003)(316002)(50226002)(2906002)(11346002)(426003)(446003)(486006)(72206003)(44832011)(2616005)(476003)(36756003)(126002)(478600001)(246002)(2870700001)(50466002)(26005)(53376002)(6306002)(8936002)(186003)(14444005)(356004)(6916009)(6666004)(107886003)(966005)(77096007)(86362001)(1076003)(305945005)(2351001)(8676002)(70206006)(70586007)(7696005)(5660300002)(106002)(76176011)(336012)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB550;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03887a5a-c394-4fd2-7c9b-08d6f944cfde
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BLUPR03MB550;
X-MS-TrafficTypeDiagnostic: BLUPR03MB550:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BLUPR03MB5507CA4E5C39E2C9CF1B2F381E30@BLUPR03MB550.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0079056367
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: sJgS3MW6Kz0h2OhDDrFEVriDS/wqmyOsUX8uU9ICZoIWTvah1RpTqoxGhnXg6gZNNGvcQ/BfPi9m038jFq7bYKvy8Dvys1qCpmSmoOu9FbhYVwCFmbZUFq7sqvTOI8IhseewaWGDGMlEtSxs84L/fYl22d1eV7/dl6nXf0FUfCc57ilHWZ7sBFxDH1ZCMaoLXOIxCwEqHsaNXDWMcQwNHNR8i2Dhp/Y6bJDdfGH0M2w3KvlGAObf71NwIYPcJ+MvWARqYJy0PdUHCmGeKo544bZCVyCWR2zRDZrfv50XGaDmQFnIFv8NGl4JqQagQt3G8ylQE/ZhhQzWzikzYkdW4rtjmufCNccVpp9vbl67TtN5Gr5QnJwWJYSf7dYJfkCMN1cW/jV2focHOpNkOEA6Bck4TVv7/RpVSLxWDCc4L8o=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2019 08:12:05.6798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03887a5a-c394-4fd2-7c9b-08d6f944cfde
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB550
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250067
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert AD7124 bindings documentation to YAML format.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---

Changelog v2:
- modified SPDX license to GPL-2.0 OR BSD-2-Clause
- added regex for a range from 0 to 15
- added minimum and maximum constraints for reg property
- set type and range of values for adi,reference-select property
- used items for diff-channels property
- set bipolar, adi,buffered-positive and negative to type: boolean

Changelog v3:
- moved adi,buffered-positive and negative properties to own commit

Changelog v4:
- removed old txt dt-binding

 .../bindings/iio/adc/adi,ad7124.txt           |  75 ---------
 .../bindings/iio/adc/adi,ad7124.yaml          | 144 ++++++++++++++++++
 2 files changed, 144 insertions(+), 75 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
deleted file mode 100644
index 416273dce569..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
+++ /dev/null
@@ -1,75 +0,0 @@
-Analog Devices AD7124 ADC device driver
-
-Required properties for the AD7124:
-	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
-	- reg: SPI chip select number for the device
-	- spi-max-frequency: Max SPI frequency to use
-		see: Documentation/devicetree/bindings/spi/spi-bus.txt
-	- clocks: phandle to the master clock (mclk)
-		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
-	- clock-names: Must be "mclk".
-	- interrupts: IRQ line for the ADC
-		see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-	  Required properties:
-		* #address-cells: Must be 1.
-		* #size-cells: Must be 0.
-
-	  Subnode(s) represent the external channels which are connected to the ADC.
-	  Each subnode represents one channel and has the following properties:
-		Required properties:
-			* reg: The channel number. It can have up to 4 channels on ad7124-4
-			  and 8 channels on ad7124-8, numbered from 0 to 15.
-			* diff-channels: see: Documentation/devicetree/bindings/iio/adc/adc.txt
-
-		Optional properties:
-			* bipolar: see: Documentation/devicetree/bindings/iio/adc/adc.txt
-			* adi,reference-select: Select the reference source to use when
-			  converting on the the specific channel. Valid values are:
-			  0: REFIN1(+)/REFIN1(−).
-			  1: REFIN2(+)/REFIN2(−).
-			  3: AVDD
-			  If this field is left empty, internal reference is selected.
-
-Optional properties:
-	- refin1-supply: refin1 supply can be used as reference for conversion.
-	- refin2-supply: refin2 supply can be used as reference for conversion.
-	- avdd-supply: avdd supply can be used as reference for conversion.
-
-Example:
-	adc@0 {
-		compatible = "adi,ad7124-4";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		interrupts = <25 2>;
-		interrupt-parent = <&gpio>;
-		refin1-supply = <&adc_vref>;
-		clocks = <&ad7124_mclk>;
-		clock-names = "mclk";
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		channel@0 {
-			reg = <0>;
-			diff-channels = <0 1>;
-			adi,reference-select = <0>;
-		};
-
-		channel@1 {
-			reg = <1>;
-			bipolar;
-			diff-channels = <2 3>;
-			adi,reference-select = <0>;
-		};
-
-		channel@2 {
-			reg = <2>;
-			diff-channels = <4 5>;
-		};
-
-		channel@3 {
-			reg = <3>;
-			diff-channels = <6 7>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
new file mode 100644
index 000000000000..1b3d84d08609
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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
+  "^channel@([0-9]|1[0-5])$":
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
+        items:
+         minimum: 0
+         maximum: 15
+
+      adi,reference-select:
+        description: |
+          Select the reference source to use when converting on
+          the specific channel. Valid values are:
+          0: REFIN1(+)/REFIN1(−).
+          1: REFIN2(+)/REFIN2(−).
+          3: AVDD
+          If this field is left empty, internal reference is selected.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+          - enum: [0, 1, 3]
+
+      diff-channels:
+        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+        items:
+          minimum: 0
+          maximum: 15
+
+      bipolar:
+        description: see Documentation/devicetree/bindings/iio/adc/adc.txt
+        type: boolean
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
+      };
+
+      channel@1 {
+        reg = <1>;
+        bipolar;
+        diff-channels = <2 3>;
+        adi,reference-select = <0>;
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

