Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389782084E
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEPNgR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 09:36:17 -0400
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:22448
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfEPNgR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 09:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zzkI77GoQIS17JxrUwd215hmCNtlmK8SLj2SenOQ98=;
 b=D10oYKwYs3ut1B2Gt6cSrbNWLn0LPoKZiP8jrHOlUqjfDA5EvJeB+0D2PdvNAJgtRRB+pJu10v0sIQ157trlPe3o3STN/dbq74WDdkQIFF+y7eLeMBmb+yaKz033NptnQWFOqvFyclHrZyYSR0pikQpem0SQoomvKwS/w8dmq+0=
Received: from DM5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:4:3b::18) by
 BLUPR03MB549.namprd03.prod.outlook.com (2a01:111:e400:880::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.25; Thu, 16 May 2019 13:36:14 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by DM5PR03CA0029.outlook.office365.com
 (2603:10b6:4:3b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16 via Frontend
 Transport; Thu, 16 May 2019 13:36:13 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1900.16
 via Frontend Transport; Thu, 16 May 2019 13:36:12 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x4GDaCcC005469
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 16 May 2019 06:36:12 -0700
Received: from saturn.analog.com (10.50.1.244) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Thu, 16 May 2019
 09:36:11 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH V2] dt-bindings: iio: accel: adxl345: switch to YAML bindings
Date:   Thu, 16 May 2019 16:36:09 +0300
Message-ID: <20190516133609.10975-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516121509.1441-1-alexandru.ardelean@analog.com>
References: <20190516121509.1441-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(2980300002)(199004)(189003)(54534003)(11346002)(47776003)(2616005)(476003)(446003)(53376002)(126002)(36756003)(86362001)(70586007)(53416004)(6306002)(77096007)(8676002)(26005)(186003)(246002)(50466002)(7636002)(107886003)(305945005)(486006)(76176011)(51416003)(48376002)(8936002)(5660300002)(44832011)(14444005)(356004)(7696005)(50226002)(110136005)(316002)(2906002)(478600001)(16586007)(4326008)(966005)(106002)(70206006)(1076003)(426003)(336012)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB549;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a58259f-74ea-442a-f632-08d6da0376c2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR03MB549;
X-MS-TrafficTypeDiagnostic: BLUPR03MB549:
X-MS-Exchange-PUrlCount: 4
X-Microsoft-Antispam-PRVS: <BLUPR03MB54902EEF49723DD46FCFE72F90A0@BLUPR03MB549.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0039C6E5C5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kz0vzgIK9hLxWDSxbEQrOXYaMkM7xbPuxLelOWVaEJ72b4jN0Mork0yIc54Hryf9/9zBpv+PLi5rvtMq/enyMN8JDykX7yBoSlDU4+gcfstRQ0CiswgFs/jmo4zx/omW5DtaLCnJwtNSUtD8D5nvMTG8Tf35H/L6vbFVVzK5y5S6kNOLnLYqL7AHXAAxjTEnVfHF1xTW+BFhjix4PzIfDBMsREe+kMCxa9Ap5mKBP6t/Rz0DhPIpCzspNjI4R7/9AYfUpFgrfhvwyPo3pdv6rIP0vzNPAEDVZXLHXav5QixWjYwgp5VLIO3OvtG7O/LZx78+mf524XXboGHM5ffb5mEjP0VRjkBQfM6h0V0SKuixd6EWnrc4V9FGaj0x/f3g28bNNDXs/ZSb4VHMJwfpBpok1jyugfdFnMtvocd4JyA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2019 13:36:12.9397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a58259f-74ea-442a-f632-08d6da0376c2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB549
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADX345 supports both I2C & SPI bindings.
This change switches from old text bindings, to YAML bindings, and also
tries to make use of the recent multiple-examples support.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
Changelog v1 -> v2:
* dropped interrupt-parent from DT, as suggested by Rob

 .../bindings/iio/accel/adi,adxl345.yaml       | 72 +++++++++++++++++++
 .../devicetree/bindings/iio/accel/adxl345.txt | 39 ----------
 2 files changed, 72 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/accel/adxl345.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
new file mode 100644
index 000000000000..7ba167e2e1ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
@@ -0,0 +1,72 @@
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

