Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65B29206B8
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 14:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfEPMP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 08:15:28 -0400
Received: from mail-eopbgr700063.outbound.protection.outlook.com ([40.107.70.63]:23648
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfEPMP2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 08:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTkDDJKaIEquOmn8yjs9y6hKy6/tdcibMyb5qC2pFqw=;
 b=cME2snXXNb3Sx0gX5/UF6Ehx9lG1disSwG6Y1zlKiavJBwGwEm6SDXSc9yZFqd9lvyFiP682/M83IIkL0rBtSxDCxYy32HJLng6OiAX+tHqH1P2mXjxwr06f0JzNxXkk/RTwPNLeq2PpkhxR97zz7A36Qk1D7wvH5L3g2smMaHY=
Received: from BN3PR03CA0056.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::16) by CY1PR03MB2266.namprd03.prod.outlook.com
 (2a01:111:e400:c637::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1900.16; Thu, 16 May
 2019 12:15:12 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BN3PR03CA0056.outlook.office365.com
 (2a01:111:e400:7a4d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 12:15:12 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Thu, 16 May 2019 12:15:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x4GCFBRF024451
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2019 05:15:11 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 16 May 2019
 08:15:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] dt-bindings: iio: accel: adxl345: switch to YAML bindings
Date:   Thu, 16 May 2019 15:15:09 +0300
Message-ID: <20190516121509.1441-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(189003)(199004)(186003)(8676002)(47776003)(486006)(51416003)(110136005)(1076003)(14444005)(6306002)(36756003)(336012)(7696005)(16586007)(305945005)(7636002)(106002)(54906003)(246002)(126002)(426003)(2906002)(316002)(70206006)(44832011)(53376002)(53416004)(48376002)(107886003)(2616005)(966005)(8936002)(4326008)(50466002)(5660300002)(86362001)(70586007)(26005)(77096007)(476003)(356004)(478600001)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2266;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9190f16-475d-4274-8ac6-08d6d9f8255f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:CY1PR03MB2266;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2266:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <CY1PR03MB2266D680DAA9CB400C066517F90A0@CY1PR03MB2266.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ObL2z75FUh80nrb1B+hcrrrS/UtkiNcsPziQe08Gfb0ZyZNBj5O7wRRA3b4LGzxjeDrVc5OrYQYxuMEtIWGRwiuU6KiYKlq4ZWRv2TJymfoh8nIGxKtWD51zs0eM2PRp3g030NrI+HCDhRHobTpgL78FZAOs7VQYqyotJrj9kIx/XC46N0Wk73PC5bLEo/VC199bT4pPaljMAFSgzariAf+xP0cVKgbl1LhhkEVHb6g09AO6HyGln6nbq06aZvPSe27fh2dS6fDY+A+YkoFGw+ikI45UZdXWUn7B3lMzz3L3XpSuMPzrWyZ800KP0+ONrv1LDNjiHc5rBMqpsdwPLga0eSSqgjxmgm5wI3wgy9gYiVe/Pz/MNDTNull4fEFmgK+nMDvyUNv4K4z1JwMwddv3aANaiRkti8KfezjXa8M=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 12:15:12.0638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9190f16-475d-4274-8ac6-08d6d9f8255f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2266
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADX345 supports both I2C & SPI bindings.
This change switches from old text bindings, to YAML bindings, and also
tries to make use of the recent multiple-examples support.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/accel/adi,adxl345.yaml       | 74 +++++++++++++++++++
 .../devicetree/bindings/iio/accel/adxl345.txt | 39 ----------
 2 files changed, 74 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
new file mode 100644
index 000000000000..47cdfb3b8182
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accelerometers/adi,adxl345.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers that supports
+  both I2C & SPI interfaces.
+    http://www.analog.com/en/products/mems/accelerometers/adxl345.html
+    http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl345
+      - adi,adxl375
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  interrupt-parent: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a I2C device node */
+        accelerometer@2a {
+            compatible = "adi,adxl345";
+            reg = <0x53>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "adi,adxl345";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/accel/adxl345.txt b/Documentation/devicetree/bindings/iio/accel/adxl345.txt
deleted file mode 100644
index f9525f6e3d43..000000000000
--- a/Documentation/devicetree/bindings/iio/accel/adxl345.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Analog Devices ADXL345/ADXL375 3-Axis Digital Accelerometers
-
-http://www.analog.com/en/products/mems/accelerometers/adxl345.html
-http://www.analog.com/en/products/sensors-mems/accelerometers/adxl375.html
-
-Required properties:
- - compatible : should be one of
-		"adi,adxl345"
-		"adi,adxl375"
- - reg : the I2C address or SPI chip select number of the sensor
-
-Required properties for SPI bus usage:
- - spi-max-frequency : set maximum clock frequency, must be 5000000
- - spi-cpol and spi-cpha : must be defined for adxl345 to enable SPI mode 3
-
-Optional properties:
- - interrupts: interrupt mapping for IRQ as documented in
-   Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-Example for a I2C device node:
-
-	accelerometer@2a {
-		compatible = "adi,adxl345";
-		reg = <0x53>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-Example for a SPI device node:
-
-	accelerometer@0 {
-		compatible = "adi,adxl345";
-		reg = <0>;
-		spi-max-frequency = <5000000>;
-		spi-cpol;
-		spi-cpha;
-		interrupt-parent = <&gpio1>;
-		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-	};
-- 
2.17.1

