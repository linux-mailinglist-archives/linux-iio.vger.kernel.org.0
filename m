Return-Path: <linux-iio+bounces-9458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2B97661D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 11:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015221F258B6
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5049619F42D;
	Thu, 12 Sep 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vcn8sFCg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6519F418;
	Thu, 12 Sep 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134933; cv=none; b=TxVl1IaL/KqDhT6750NRKf2Ht2L0Y8hT6265ss+VIl8jmBV9AFqjoRbfKGKL2Qf9FqjAES+JOw2IT2Vo+lQzQRv7Z48aSLateAybhW2X1Hp9f2QvUOGtqoxMRsfLQj+cs1oNUVfOm0Pm/XfAXNfEtXY7v9YFtvrdJ1+XrhsquzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134933; c=relaxed/simple;
	bh=y8pKZm7pmbn5A9tErwVdixOANHlrU8fhEsYx4jUKIRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKRYPCiDAbICBSUbyOGMWdnLx6878KDHRi5kvI8NtaxcGj/iA+9bSDRNhZsl54Q1w6qc03px4Gj5GdeuMQuUxFTqyIZzqAud5KUcjke9oeCya7AW4D6Nwc78eXetlRrR3J6SG/HryAwjjn02BtgvSHTdfqmkzAVdQRg/chsvTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vcn8sFCg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C4q77o032017;
	Thu, 12 Sep 2024 05:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZDLD8
	NovO9bNmVkbgptH/BtydIeIXHY42gjIDBi47Jg=; b=vcn8sFCgGQ6b6S2sOros2
	GVmQM1+qZji4CY1y6eCcVK4TtVNTpJujHy2YF1Z4MbBC4Dyph/VlkGSqDf2/MHUJ
	qPEtlBcmG8/R1ZstdFeauChs1lBGtjL+9LUreaNDVfo7g/3B9+HP9GGKkqagpRGp
	m8IWZL1co9dv4GEp1GGxwoFw0O3hEfD9L8798QABOhENaA+1RwTeO0nRw7MdTfDN
	rHn8y7EcXXoMDXR2RUSNbrARJWf07R5urAunt946+vG26KglfKemUsxEZLUFST3t
	q35QneNra9OXN4EwXKYVKMYRnMCb/vbiMK3siUyI4T8+c/Cy0FCqcFMGiC9ZRIMI
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41gyh1kbr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 05:55:04 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 48C9t2RA042990
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Sep 2024 05:55:02 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Sep 2024 05:55:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 12 Sep 2024 05:55:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Sep 2024 05:55:02 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.121])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48C9sheR026249;
	Thu, 12 Sep 2024 05:54:54 -0400
From: Mariel Tinaco <Mariel.Tinaco@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Marcelo
 Schmitt" <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: dac: add docs for ad8460
Date: Thu, 12 Sep 2024 17:54:34 +0800
Message-ID: <20240912095435.18639-2-Mariel.Tinaco@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: AgdlHbMOSsh-c6zoO6z6z-TkVbPrMmqW
X-Proofpoint-GUID: AgdlHbMOSsh-c6zoO6z6z-TkVbPrMmqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120069

This adds the bindings documentation for the 14-bit
High Voltage, High Current, Waveform Generator
Digital-to-Analog converter.

Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
---
 .../bindings/iio/dac/adi,ad8460.yaml          | 164 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
new file mode 100644
index 000000000000..b65928024e12
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2024 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad8460.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD8460 DAC
+
+maintainers:
+  - Mariel Tinaco <mariel.tinaco@analog.com>
+
+description: |
+  Analog Devices AD8460 110 V High Voltage, 1 A High Current,
+  Arbitrary Waveform Generator with Integrated 14-Bit High Speed DAC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad8460.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad8460
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: tx
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  hvcc-supply:
+    description: Positive high voltage power supply line
+
+  hvee-supply:
+    description: Negative high voltage power supply line
+
+  vcc-5v-supply:
+    description: Low voltage power supply
+
+  vref-5v-supply:
+    description: Reference voltage for analog low voltage
+
+  dvdd-3p3v-supply:
+    description: Digital supply bypass
+
+  avdd-3p3v-supply:
+    description: Analog supply bypass
+
+  refio-1p2v-supply:
+    description: Drive voltage in the range of 1.2V maximum to as low as
+      low as 0.12V through the REF_IO pin to adjust full scale output span
+
+  adi,external-resistor-ohms:
+    description: Specify value of external resistor connected to FS_ADJ pin
+      to establish internal HVDAC's reference current I_REF
+    minimum: 2000
+    maximum: 20000
+    default: 2000
+
+  adi,range-microvolt:
+    description: Voltage output range specified as <minimum, maximum>
+    items:
+      - minimum: -55000000
+        maximum: 0
+        default: 0
+      - minimum: 0
+        maximum: 55000000
+        default: 0
+
+  adi,range-microamp:
+    description: Current output range specified as <minimum, maximum>
+    items:
+      - minimum: -1000000
+        maximum: 0
+        default: 0
+      - minimum: 0
+        maximum: 1000000
+        default: 0
+
+  adi,max-millicelsius:
+    description: Overtemperature threshold
+    minimum: 0
+    maximum: 150000
+    default: 0
+
+  shutdown-reset-gpios:
+    description: Corresponds to SDN_RESET pin. To exit shutdown
+      or sleep mode, pulse SDN_RESET HIGH, then leave LOW.
+    maxItems: 1
+
+  reset-gpios:
+    description: Manual Power On Reset (POR). Pull this GPIO pin
+      LOW and then HIGH to reset all digital registers to default
+    maxItems: 1
+
+  shutdown-gpios:
+    description: Corresponds to SDN_IO pin. Shutdown may be
+      initiated by the user, by pulsing SDN_IO high. To exit shutdown,
+      pulse SDN_IO low, then float.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - hvcc-supply
+  - hvee-supply
+  - vcc-5v-supply
+  - vref-5v-supply
+  - dvdd-3p3v-supply
+  - avdd-3p3v-supply
+  - refio-1p2v-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad8460";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+
+            dmas = <&tx_dma 0>;
+            dma-names = "tx";
+
+            shutdown-reset-gpios = <&gpio 86 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 91 GPIO_ACTIVE_LOW>;
+            shutdown-gpios = <&gpio 88 GPIO_ACTIVE_HIGH>;
+
+            clocks = <&sync_ext_clk>;
+
+            hvcc-supply = <&hvcc>;
+            hvee-supply = <&hvee>;
+            vcc-5v-supply = <&vcc_5>;
+            vref-5v-supply = <&vref_5>;
+            dvdd-3p3v-supply = <&dvdd_3_3>;
+            avdd-3p3v-supply = <&avdd_3_3>;
+            refio-1p2v-supply = <&refio_1_2>;
+
+            adi,external-resistor-ohms = <2000>;
+            adi,range-microvolt = <(-40000000) 40000000>;
+            adi,range-microamp = <0 50000>;
+            adi,max-millicelsius = <50000>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a22f22369ad5..9f0acaea0749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1320,6 +1320,13 @@ F:	Documentation/ABI/testing/debugfs-iio-ad9467
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
 F:	drivers/iio/adc/ad9467.c
 
+ANALOG DEVICES INC AD8460 DRIVER
+M:	Mariel Tinaco <Mariel.Tinaco@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
+
 ANALOG DEVICES INC AD9739a DRIVER
 M:	Nuno Sa <nuno.sa@analog.com>
 M:	Dragos Bogdan <dragos.bogdan@analog.com>
-- 
2.34.1


