Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2CE97C54
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfHUORt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 10:17:49 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:7872 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728943AbfHUORt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Aug 2019 10:17:49 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LEFmEp017466;
        Wed, 21 Aug 2019 10:17:05 -0400
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2059.outbound.protection.outlook.com [104.47.44.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uh0ysrsnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Aug 2019 10:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dso5x2h96jElou+DyxYm0ra9DW6/MXV/oYkDYs6MPlvhu3vErg1zVrL6B8rzP4+vw9UXaWz5gdKG8GZoyqYXlYT4KOyQF+NmIzFruWYdUJuruoW7HoYAFHwEnW4rRoERKp4Ghl8e1HG5dnR2jeKU0sG8APgrnkd4/vPHY42Wu86WZhnwljBAj1E4Hlh66MJb9oWIc6TMB1YKyv+S01GbB58NWbI7WgmNxP9kfBmUT+AkNcb5vVnCq+cpbVCqIEqDDpVBvOUTJKhmmakrAwVgq2+QCMn61TcWVxVcHwGCU3pEs0jx9BXZCZJ/YGJ0hXSbaZ3Ej0rzeLzLn6OCHyb3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFlWvH9I3MOLL/kFpve2H7nq9VD8alvCrpap+sXRZ9k=;
 b=kMIWN8Qm2hYrOnCwx/U/rijYn3+QKf9YzV3i58Zi9ol/Ank4A7L26tOqyJwklLcReoxU19OWvJVJAjtmxWv+UBnwMVySjg48FmGY1vaTetT2UbVs/PLLxe5yh5O3z/M1JRWotN6fhkJyd4kG7uQe1raKtdFSdI/eV1RLJbSblRMllEkgNSni80TxfNwVDfq5gU4htzmsy1pnbAZSAon66R+e5gX4SP7p6QGqlWS3S/bUeD5RD/gsUrKsW/6YsByDcQAkiSQhH+FTdEt5mcsPkVPZw4O4RTN295oTR3M7vjYrHCx6XaAo6CMilVPNceAXG0OBY2xWQeGFXpSPaa7ztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFlWvH9I3MOLL/kFpve2H7nq9VD8alvCrpap+sXRZ9k=;
 b=hcf8hYR6jcW64ztJAH6lWCo4PZEbmQf5ZsunvxZgVu4vtpropwvwbSryzJvXj02PuKT3Z/Edha+Ed4skAeO8d6EQN0SVgtWZgaxhF4cICzTwAQPvVnc5A122REb6rbDT7vEpQxblZYmCfyOg/t3hIqRWanRxgpTj6NhdZGwadYs=
Received: from BN6PR03CA0117.namprd03.prod.outlook.com (2603:10b6:404:10::31)
 by BN7PR03MB3873.namprd03.prod.outlook.com (2603:10b6:408:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Wed, 21 Aug
 2019 14:17:03 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR03CA0117.outlook.office365.com
 (2603:10b6:404:10::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Wed, 21 Aug 2019 14:17:03 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2178.16
 via Frontend Transport; Wed, 21 Aug 2019 14:17:02 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x7LEGwNY005658
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 21 Aug 2019 07:16:58 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 21 Aug 2019 10:17:01 -0400
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
Subject: [PATCH v3 3/4] dt-bindings: iio: adc: Migrate AD7606 documentation to yaml
Date:   Wed, 21 Aug 2019 17:16:55 +0300
Message-ID: <20190821141656.4815-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821141656.4815-1-beniamin.bia@analog.com>
References: <20190821141656.4815-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(199004)(189003)(70206006)(7636002)(70586007)(106002)(54906003)(305945005)(336012)(316002)(7416002)(47776003)(5820100001)(36756003)(426003)(44832011)(6916009)(76176011)(476003)(86362001)(11346002)(486006)(2616005)(446003)(126002)(6666004)(356004)(5660300002)(23676004)(14444005)(53376002)(107886003)(2870700001)(7696005)(2351001)(246002)(6306002)(26005)(2906002)(478600001)(966005)(186003)(8676002)(50466002)(8936002)(1076003)(4326008)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3873;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bfd56f3-e618-422f-f190-08d726423d50
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN7PR03MB3873;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3873:
X-MS-Exchange-PUrlCount: 5
X-Microsoft-Antispam-PRVS: <BN7PR03MB3873789F11687C609F8CF179F0AA0@BN7PR03MB3873.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0136C1DDA4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bC9yNTT7A9IUz5J7cXBvnF8Hh6uvIP0Io7UZTywlLXyAzLILUnrMrqunDuwgzUCkDQqWJcDHL4/O8BTdcvgWacPu2dvrEpSxWkUBQ+cJZhIQ7K6ceqFcXB9AYEQ8oF3H1dkThcutfHGZFnWfU0eRA1zxm4EQa8UOnedRtEE6Ao7OP2IQQQWElhDfH/M3EhvWtydWS5+nowPqGxAjmiKACtqIPp7oqYMlJyzkaKecWoBHzgzftKrx0N8ydFMs/gkpzMMSyea1xpzWqfKRFitjM0LuAd5Smwcx+W4vhX/bvLOXuLK3w3On2r7NL55PBRfQb2/xx5ewhI7jWwgXvCqS8duqXoO6IVRZ1MII30zE+WzG/Ru5yRh2BetlP3pr7rJpPfFI4kv8qDWn1SL6WmDYvHn4LNy9nVELWMzGjjxu6FM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2019 14:17:02.5559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfd56f3-e618-422f-f190-08d726423d50
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210156
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The documentation for ad7606 was migrated to yaml.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
Changes in v3:
-nothing changed

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

