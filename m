Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC58084D4F
	for <lists+linux-iio@lfdr.de>; Wed,  7 Aug 2019 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfHGNc4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Aug 2019 09:32:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:3352 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388311AbfHGNcq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Aug 2019 09:32:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77DS0Jn029504;
        Wed, 7 Aug 2019 09:32:04 -0400
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0a-00128a01.pphosted.com with ESMTP id 2u7bcx3bdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Aug 2019 09:32:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuE07EvLQ/JTcmX8Aj7yvTDiSa04bgH6tnUgERHc39bmdgyfcLI0B8oTrjL7vQp6DxOq2HunpJAQuMcY3QsLfkRHg6qEnYO8yFkT7mVqY4938mYyGA3pyMZebtFX6c2aZdWk/hcgMdnJllN09+21tnjbYKPZC35Xf11I5Y9PyOKopPj7PRkDkALLrGOfAX+QRI5Op9n48018uCk81zviDm//z8Fkv1uxl43OEK3UKZdsTCQ1Cs0eWkrjkFOPrzNjPeo4sdgtB3e8eI+v5RlXzwz3XT/NyA+JxMx4+NvSIiDOrB2GuXvCGf9yUdcgT5oMLGdck5LElwdPmltUPsd+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnirtYnRBJDyHJHtscoGDPkexqJFoY5juiYbm9lL+Xc=;
 b=Pfjy5DW3innclkamBbZLBok9x70ALEIKp4G/Zur3+a+3iKsFHVDAneKiQNFR/0IzUUrF+cU8d/MmLNu44Q6EmKVQCRZj7Olu5LCsH9cEuA9hdjniTzzSCmOoWi1jOFV3CFKUsOuCgYZK9K5EHhvHeCrNV6HVFm8Z+XyjS0JFKe7k60z/q0skHEgY2+VuhWERx4dHHS6bX0BdTJkfwPAyPDbl/euOcYV3giNW6qKM50sWadq8GTSX6YJ4qwQECJToTR3evGOtRRqbcBwjKs6q+8sT3Ok5HK7rvFdleM5n/Xm2YNWOFCcYuY23IpQNTPacDtHejyVYu0wdo/DwFVjtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnirtYnRBJDyHJHtscoGDPkexqJFoY5juiYbm9lL+Xc=;
 b=yjA/WyYWTJKV7JtSf91z5KhwIqfIg29wNqWs1QuirsWogDVETr2GPASXhD3Ibnd5RC4Z+ojiXdWTgH/R+PPBLVDL5A3ifhIOyIu3dEga2ASF/e8FQ6ylFrJDv/qB0ubV3Z89Vu75RjX2EaFMelsLwr9jJWJnSX6OAMY5yczGRJY=
Received: from DM6PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:40::32) by
 MN2PR03MB5136.namprd03.prod.outlook.com (2603:10b6:208:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14; Wed, 7 Aug
 2019 13:32:01 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by DM6PR03CA0019.outlook.office365.com
 (2603:10b6:5:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Wed, 7 Aug 2019 13:32:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Wed, 7 Aug 2019 13:32:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x77DVuHv028985
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 7 Aug 2019 06:31:56 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 7 Aug 2019 09:31:59 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v2 3/4] dt-bindings: iio: adc: Migrate AD7606 documentation to yaml
Date:   Wed, 7 Aug 2019 16:31:36 +0300
Message-ID: <20190807133137.11185-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807133137.11185-1-beniamin.bia@analog.com>
References: <20190807133137.11185-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(199004)(189003)(107886003)(7416002)(966005)(54906003)(316002)(50466002)(478600001)(2351001)(6916009)(106002)(2870700001)(2906002)(53376002)(36756003)(50226002)(4326008)(14444005)(8676002)(6306002)(305945005)(7636002)(86362001)(246002)(5660300002)(8936002)(5820100001)(70586007)(70206006)(26005)(47776003)(7696005)(446003)(44832011)(76176011)(126002)(426003)(23676004)(476003)(2616005)(11346002)(336012)(186003)(356004)(1076003)(486006)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5136;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba7d4878-80f7-4eb6-a395-08d71b3ba0b3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:MN2PR03MB5136;
X-MS-TrafficTypeDiagnostic: MN2PR03MB5136:
X-MS-Exchange-PUrlCount: 5
X-Microsoft-Antispam-PRVS: <MN2PR03MB5136B940D8CA8889B15911A6F0D40@MN2PR03MB5136.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 01221E3973
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: KwIfZ3JT3XMpm/aoztC2lXj0IoNseRblVbzG7xHjReIcWtXp59r0IS5AgClEGCDMlNRyfyct4jr5tfGluE0pnXS6Jvvkhd2hIMqAOjQ0fJbuYweqXAZqa4x4uPz4Z9FOYjUWIeQ1mLcmR8SF1VnMISQdqu3WCsfRilZ2J5UdB8sALeZr0uLbsAsjiEGYY8MuvcBk23Jl/XQWJE9KBC5ffLZJwiBVq0KFn6gSZA9PYKkF6MjrscMFAh+vTExnCqDRiUXJPqJxFWFJgc94xwbm3o6dN6wucWcDj9TSJ+o3TJ6OPoiB8jgQc2rAWdtFby/4vm+14gkMPDBsofsGRegTW5e4alzrc3hwUEUMzu2yvynaHUvL7LXxdqLwb3mHyYEdc5VmMSX3NzS6hc4O4Ty6Piry6QPTPx/+35NIOmu8D1A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2019 13:32:00.2566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7d4878-80f7-4eb6-a395-08d71b3ba0b3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070147
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation for ad7606 was migrated to yaml.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v2:
-old txt file was deleted

 .../bindings/iio/adc/adi,ad7606.txt           |  66 ---------
 .../bindings/iio/adc/adi,ad7606.yaml          | 134 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 135 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
deleted file mode 100644
index d8652460198e..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Analog Devices AD7606 Simultaneous Sampling ADC
-
-Required properties for the AD7606:
-
-- compatible: Must be one of
-	* "adi,ad7605-4"
-	* "adi,ad7606-8"
-	* "adi,ad7606-6"
-	* "adi,ad7606-4"
-	* "adi,ad7616"
-- reg: SPI chip select number for the device
-- spi-max-frequency: Max SPI frequency to use
-	see: Documentation/devicetree/bindings/spi/spi-bus.txt
-- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
-- avcc-supply: phandle to the Avcc power supply
-- interrupts: IRQ line for the ADC
-	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-- adi,conversion-start-gpios: must be the device tree identifier of the CONVST pin.
-		  This logic input is used to initiate conversions on the analog
-		  input channels. As the line is active high, it should be marked
-		  GPIO_ACTIVE_HIGH.
-
-Optional properties:
-
-- reset-gpios: must be the device tree identifier of the RESET pin. If specified,
-	       it will be asserted during driver probe. As the line is active high,
-	       it should be marked GPIO_ACTIVE_HIGH.
-- standby-gpios: must be the device tree identifier of the STBY pin. This pin is used
-		to place the AD7606 into one of two power-down modes, Standby mode or
-		Shutdown mode. As the line is active low, it should be marked
-		GPIO_ACTIVE_LOW.
-- adi,first-data-gpios: must be the device tree identifier of the FRSTDATA pin.
-		    The FRSTDATA output indicates when the first channel, V1, is
-		    being read back on either the parallel, byte or serial interface.
-		    As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
-- adi,range-gpios: must be the device tree identifier of the RANGE pin. The polarity on
-	      this pin determines the input range of the analog input channels. If
-	      this pin is tied to a logic high, the analog input range is ±10V for
-	      all channels. If this pin is tied to a logic low, the analog input range
-	      is ±5V for all channels. As the line is active high, it should be marked
-	      GPIO_ACTIVE_HIGH.
-- adi,oversampling-ratio-gpios: must be the device tree identifier of the over-sampling
-				mode pins. As the line is active high, it should be marked
-				GPIO_ACTIVE_HIGH.
-
-Example:
-
-	adc@0 {
-		compatible = "adi,ad7606-8";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		spi-cpol;
-
-		avcc-supply = <&adc_vref>;
-
-		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-parent = <&gpio>;
-
-		adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
-		adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
-		adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH
-						&gpio 23 GPIO_ACTIVE_HIGH
-						&gpio 26 GPIO_ACTIVE_HIGH>;
-		standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
new file mode 100644
index 000000000000..509dbe9c84d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7606 Simultaneous Sampling ADC
+
+maintainers:
+  - Beniamin Bia <beniamin.bia@analog.com>
+  - Stefan Popa <stefan.popa@analog.com>
+
+description: |
+  Analog Devices AD7606 Simultaneous Sampling ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606_7606-6_7606-4.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7605-4
+      - adi,ad7606-8
+      - adi,ad7606-6
+      - adi,ad7606-4
+      - adi,ad7616
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  adi,conversion-start-gpios:
+    description:
+      Must be the device tree identifier of the CONVST pin.
+      This logic input is used to initiate conversions on the analog
+      input channels. As the line is active high, it should be marked
+      GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. If specified,
+      it will be asserted during driver probe. As the line is active high,
+      it should be marked GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  standby-gpios:
+    description:
+       Must be the device tree identifier of the STBY pin. This pin is used
+       to place the AD7606 into one of two power-down modes, Standby mode or
+       Shutdown mode. As the line is active low, it should be marked
+       GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  adi,first-data-gpios:
+    description:
+      Must be the device tree identifier of the FRSTDATA pin.
+      The FRSTDATA output indicates when the first channel, V1, is
+      being read back on either the parallel, byte or serial interface.
+      As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,range-gpios:
+    description:
+      Must be the device tree identifier of the RANGE pin. The polarity on
+      this pin determines the input range of the analog input channels. If
+      this pin is tied to a logic high, the analog input range is ±10V for
+      all channels. If this pin is tied to a logic low, the analog input range
+      is ±5V for all channels. As the line is active high, it should be marked
+      GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,oversampling-ratio-gpios:
+    description:
+      Must be the device tree identifier of the over-sampling
+      mode pins. As the line is active high, it should be marked
+      GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  adi,sw-mode:
+    description:
+      Software mode of operation, so far available only for ad7616.
+      It is enabled when all three oversampling mode pins are connected to
+      high level. The device is configured by the corresponding registers. If the
+      adi,oversampling-ratio-gpios property is defined, then the driver will set the
+      oversampling gpios to high. Otherwise, it is assumed that the pins are hardwired
+      to VDD.
+    maxItems: 1
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - avcc-supply
+  - interrupts
+  - adi,conversion-start-gpios
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+                compatible = "adi,ad7606-8";
+                reg = <0>;
+                spi-max-frequency = <1000000>;
+                spi-cpol;
+
+                avcc-supply = <&adc_vref>;
+
+                interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+
+                adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+                reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+                adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+                adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH
+                                                &gpio 23 GPIO_ACTIVE_HIGH
+                                                &gpio 26 GPIO_ACTIVE_HIGH>;
+                standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+                adi,sw-mode;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 052d7a8591fb..d2e465772071 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,7 +900,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7606.c
-F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
 
 ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.17.1

