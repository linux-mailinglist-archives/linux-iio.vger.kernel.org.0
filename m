Return-Path: <linux-iio+bounces-8039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4B94059C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 05:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452051F23344
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 03:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE93148302;
	Tue, 30 Jul 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bUSRifTs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F5146A73;
	Tue, 30 Jul 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308758; cv=none; b=RaZtMztiG4bgsGPAilAup9Xx54BRLfJVzO2l0dn4PNMVKuR6mMLmjO54IsaIbd1urNSUzbFTrQV+o4EEEqL3iPmhPGnrl46877Cg/5pgNnPXrM4S6FnJOGxMaRYu/bLLEPRb9g0QSKvnaGNWLsrNO8hyVlSi5wcjARebbsFFf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308758; c=relaxed/simple;
	bh=3/aU1CXLZb74j+ye90gOTmKSR0CTbF50ZKRtBVlWYqY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzTCPmqUYsA6Xo+ufB33OFvG9A/iek0Bwbd5CZZvPuFwvkYBbffIMKopQAZRzU8LxWXYmqIpQxP6NMxo0gBv90Z5EWGGlo/LQpFsQXxwOhDBWQFflmwxU9oC3njhs6JJj2mMcZcEglfqR6M327K4R+8qO7A6+3gZ351zu5fyOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bUSRifTs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TKuGjD023770;
	Mon, 29 Jul 2024 23:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bjUCk
	/7QrsVpMTg7pCqQ/aXkziIPeCowM1ToViJarAo=; b=bUSRifTs/IdCuBcwE14jb
	/TMLXNQHZqGkn7DkW4i4At43WP6EzxiCjvHJHBixBmgzOHxKL9mjurSMRVPBjvws
	kt+vlgIZ9H5FKyMPyc9C85WmgXVN3AyglfWh4bYbL77ESHXiNzF/8VCmreclQS44
	A78HINcsL/v0WhHSvcLlvMq/ZdTMyUzS/3fGA5bOVn1/GT2i0sIRpmbwpYB2mprZ
	S1EkTqArbsA3TmeAEs3xCaY9757uBylYsvUBDcSvBrVkat7erAjgnlgKaN/3xS8X
	SPbOPrD+mZVSryLoGPiNDAjv+QWCQBU1X5OZO0CBO0B/k5YSdqk5jMc2/2Su1kCd
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40neb9xu72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 23:05:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46U35d8b029573
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 23:05:39 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 29 Jul 2024 23:05:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 29 Jul 2024 23:05:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 29 Jul 2024 23:05:38 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.75])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46U35GSY017771;
	Mon, 29 Jul 2024 23:05:27 -0400
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
Subject: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
Date: Tue, 30 Jul 2024 11:05:08 +0800
Message-ID: <20240730030509.57834-2-Mariel.Tinaco@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
References: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 63lDaOWeiL9pnVVERGgB96th9erkr81k
X-Proofpoint-GUID: 63lDaOWeiL9pnVVERGgB96th9erkr81k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_03,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407300022

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
index 000000000..6a7031d0d
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
+    description: Reference voltage for analog low voltage and protection threshold DACs.
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
+  clocks:
+    description: The clock for the DAC. This is the sync clock
+
+  adi,rset-ohms:
+    description: Specify value of external resistor connected to FS_ADJ pin
+      to establish internal HVDAC's reference current I_REF
+    default: 2000
+    minimum: 2000
+    maximum: 20000
+
+  adi,range-microvolt:
+    description: |
+      Voltage output range specified as <minimum, maximum>
+    oneOf:
+      - items:
+          - const: -40000000
+          - const: 40000000
+
+  adi,range-microamp:
+    description: |
+      Current output range specified as <minimum, maximum>
+    oneOf:
+      - items:
+          - const: 0
+          - const: 50000
+      - items:
+          - const: -50000
+          - const: 50000
+
+  adi,temp-max-millicelsius:
+    description: Overtemperature threshold
+    default: 50000
+    minimum: 20000
+    maximum: 150000
+
+  sdn-reset-gpios:
+    description: GPIO spec for the SHUTDOWN RESET pin. As the line is active high,
+      it should be marked GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO spec for the RESET pin. As the line is active low, it
+      should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  sdn-io-gpios:
+    description: GPIO spec for the SHUTDOWN INPUT/OUTPUT pin. As the line is
+      active high, it should be marked GPIO_ACTIVE_HIGH.
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
+            adi,rset-ohms = <2000>;
+            adi,range-microvolt = <(-40000000) 40000000>;
+            adi,range-microamp = <0 50000>;
+            adi,temp-max-millicelsius = <50000>;
+
+            dmas = <&tx_dma 0>;
+            dma-names = "tx";
+
+            sdn-reset-gpios = <&gpio 86 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 91 GPIO_ACTIVE_LOW>;
+            sdn-io-gpios = <&gpio 88 GPIO_ACTIVE_HIGH>;
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
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 758c202ec..dae93df2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1234,6 +1234,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
 F:	drivers/iio/adc/ad7780.c
 
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


