Return-Path: <linux-iio+bounces-9112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49596AE9A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 04:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314F3286FEF
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 02:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5BE40855;
	Wed,  4 Sep 2024 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NumCH4Ec"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1518054;
	Wed,  4 Sep 2024 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417084; cv=none; b=PgD6iOeb/2eTBf/2X8g8SBO5Jj6hiLP0m/M70ShRhST6fujQsCnUtjHVtvumJBscloU6/PqGdrUZNVPz2kXcPreQ+Op3Xzi0ajGLHKBek8K3CAvz9rBHlcXx8JnGyS7QJTqw+vSwQ17az43RzQI1sVzo8evmCdZiQwMe3HAHViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417084; c=relaxed/simple;
	bh=Bh0yPJsinDS+db94VWsBJKFpquTItz0x8BReYqEpp8U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw4G5La4/ST5PVnr6TeCPEaVV1KV1vDzKjIVD5Alk8JL3a7cxLuTxfE9jkG9wH8Nqtwl4fxjdd0PW4bTpAdPmMAcoWJI7OrD4kufAh0MfRy5yS76z4+M4MmNondnFinOo/RUbmTUEoksYVh8T7qX3XAxxnY/2TmznLfP7RHdwmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NumCH4Ec; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483K6WCs009957;
	Tue, 3 Sep 2024 22:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AX8Of
	O3xH6KZtx+9PaYGY7rh/7W0Om2fJ7mJdtayCOc=; b=NumCH4Ec5CEqhXZ2JXN5D
	WOghUaOUt9DJrD2Hv/icJWk9wrUuDcwTeAhKlZWsJSy9YsyO8J+j/d2cI9URgT26
	IcZqyu6sZ7gwv74a2bFExeqEmQJulNRjXhOrpRBjxj9ew9wwxGa0lPY+7S9jXd8E
	dFd5717Jbq0AUktNabljDkBeP8PiaTSwnKQ0ud690iiPz7GCRf4tQ5JBlDj+tqC5
	KjXZVPCCFy9OyBLpcRZC8sOzn+G16laCQQsAefHVoERxHmNoPLrmatfNmoJqPXBQ
	u1ieZdxwoAtrDZFAX01K00Xm+/hx79tQ96DH4t2XPHgPdACwl7RxOVnCLwzzBvPg
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41bw13x243-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 22:31:07 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4842V630053864
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 22:31:06 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 3 Sep 2024 22:31:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 3 Sep 2024 22:31:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 3 Sep 2024 22:31:05 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.121])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4842Ujtr000342;
	Tue, 3 Sep 2024 22:30:56 -0400
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
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
Date: Wed, 4 Sep 2024 10:30:39 +0800
Message-ID: <20240904023040.23352-2-Mariel.Tinaco@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Y-uFE8s6qSOkcA-9x4OTEAwuinT7ng5c
X-Proofpoint-GUID: Y-uFE8s6qSOkcA-9x4OTEAwuinT7ng5c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040016

This adds the bindings documentation for the 14-bit
High Voltage, High Current, Waveform Generator
Digital-to-Analog converter.

Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
---
 .../bindings/iio/dac/adi,ad8460.yaml          | 154 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
new file mode 100644
index 000000000000..da53bae4efed
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
@@ -0,0 +1,154 @@
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
+    default: 2000
+    minimum: 2000
+    maximum: 20000
+
+  adi,range-microvolt:
+    description: Voltage output range specified as <minimum, maximum>
+    oneOf:
+      - items:
+          - enum: [0, -10000000, -20000000, -30000000, -40000000, -55000000]
+          - enum: [10000000, 20000000, 30000000, 40000000, 55000000]
+
+  adi,range-microamp:
+    description: Current output range specified as <minimum, maximum>
+    oneOf:
+      - items:
+          - enum: [-50000, -100000, -300000, -500000, -1000000]
+          - enum: [50000, 100000, 300000, 500000, 1000000]
+      - items:
+          - const: 0
+          - enum: [50000, 100000, 300000, 500000, 1000000]
+
+  adi,max-millicelsius:
+    description: Overtemperature threshold
+    default: 50000
+    minimum: 20000
+    maximum: 150000
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
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: false
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
index 417c6751c0dc..e0509c9f5545 100644
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


