Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20214E838
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2019 14:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFUMo6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jun 2019 08:44:58 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:37224 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbfFUMo6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jun 2019 08:44:58 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LCBwBZ030686;
        Fri, 21 Jun 2019 08:15:11 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2058.outbound.protection.outlook.com [104.47.41.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t8sds0xqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 08:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PZ/+KMWrI3e6YRrGlWoCjV46aj52YzqGefF7Hasz4M=;
 b=cvw+1NH3xS7fcQEErZbIDy1E3TNgiECgJuvUaNfy49wKMahHahfIQsuHk0QpH3czEPTtAIuh8V0G5a0AspnD5zYd+yCoAT3vpgy2yaCwgyk4S4Yc6wymZdLsAkgbcRfHyHYtRg2IiAxxWH8DabLMQUS3eQME+g8XIu2hNF4pzwc=
Received: from BN6PR03CA0114.namprd03.prod.outlook.com (2603:10b6:404:10::28)
 by BN6PR03MB3121.namprd03.prod.outlook.com (2603:10b6:405:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.11; Fri, 21 Jun
 2019 12:14:37 +0000
Received: from CY1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN6PR03CA0114.outlook.office365.com
 (2603:10b6:404:10::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13 via Frontend
 Transport; Fri, 21 Jun 2019 12:14:37 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT037.mail.protection.outlook.com (10.152.75.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Fri, 21 Jun 2019 12:14:36 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5LCEZYA023668
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 21 Jun 2019 05:14:35 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 21 Jun 2019 08:14:35 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 4/4] dt-bindings: iio: adc: Convert ad7124 documentation to YAML
Date:   Fri, 21 Jun 2019 15:13:44 +0300
Message-ID: <20190621121344.24917-4-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621121344.24917-1-mircea.caprioru@analog.com>
References: <20190621121344.24917-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(346002)(376002)(2980300002)(54534003)(189003)(199004)(6306002)(186003)(305945005)(76176011)(36756003)(7696005)(1076003)(7636002)(246002)(5660300002)(26005)(6916009)(77096007)(356004)(70206006)(6666004)(478600001)(50226002)(72206003)(2351001)(966005)(106002)(70586007)(8936002)(426003)(107886003)(316002)(53376002)(486006)(446003)(2870700001)(54906003)(4326008)(126002)(476003)(2616005)(11346002)(44832011)(86362001)(47776003)(336012)(50466002)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3121;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2eb672-4a27-45b8-bb87-08d6f6420742
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BN6PR03MB3121;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3121:
X-MS-Exchange-PUrlCount: 3
X-Microsoft-Antispam-PRVS: <BN6PR03MB31212A83B981B1B3D66C9EB681E70@BN6PR03MB3121.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0075CB064E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kLFQDqmcP47BUZnlcAdSQ3/rjqZXMn7GlqdK5g4SEoSWfJ7QJDEFITW59m6rt/F0YvfP4NCeTiyptjC7UPRz4EQEL00KQRsyARR4EZidH0J4LrsRcLQL/Nbog67RF9T6aQl/rGsDIx97AfqM83iQeHW7eD2vqg+eAkujf3qlR2KW3nwSCJ6wpfJPWFoSglVtG6kbQmkdApm3pRAW+sDpz/LH+msYVVBMJgf7hkyG57KVVQ5WvHFf7nkLxCFwD+dhvCzKeknlAL2ILK7maZFpPya2DH+NQ0e8/VZdfXZJeLAvAeXL07TAiyGAcUbTJh1wvMNosDhlMcMm8eTgephHu9iLlvbHdfdpi6XOJsOAIZ7Osdpn8oPPhLd1j8QQIbHBgZEFZq1vs4kY9Ks1sFQS/WY7j3OnVr3uqapFJWLnkdY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2019 12:14:36.4595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2eb672-4a27-45b8-bb87-08d6f6420742
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3121
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210104
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

 .../bindings/iio/adc/adi,ad7124.yaml          | 155 ++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
new file mode 100644
index 000000000000..cf494a08b837
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -0,0 +1,155 @@
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
+      adi,buffered-positive:
+        description: Enable buffered mode for positive input.
+        type: boolean
+
+      adi,buffered-negative:
+        description: Enable buffered mode for negative input.
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

