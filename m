Return-Path: <linux-iio+bounces-7064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5791CEC1
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 21:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5BAD1C20E4B
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6172139D12;
	Sat, 29 Jun 2024 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hdyS4APb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06831386C9;
	Sat, 29 Jun 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719688035; cv=none; b=FxVN+uyochFiuvS2pudm9HuDrsSKiZfuT8bKapdOxkrLdGbvpqRLZJZeLPzusUiQ9K0XNvI88KtgqoEBGpl6s+bTyW71t4vLr71QyuiGuaBG4aI2TCoZDZCUN9Gd0ImQj459jX49flZpQ/4cNHrIwYmYprs9gw/LuEUYzFXRbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719688035; c=relaxed/simple;
	bh=k7veSMp0dTiMQVWIJk8caVweli4U9DOOP2/uzcIjFTI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMc0Yv2BpkkgbK1Ox6SoI3nOUQQAuepuIYC3+zuqsS3og9VwAv7TB6Su5CgAKDgWD2OWbF5olbQ9s9h7PMhtxXzKrUE0aYBhEhYvexbYZf2gigBV0mITAxhS+RKhFw/+lESiUYjKa+oGwHMe/MQegVTs67vVDVYIQyRYDPBSeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hdyS4APb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45THnq2e002087;
	Sat, 29 Jun 2024 15:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Gbspy
	yLqkdsFVJZsAiZ3fPbYeD3nCTC47Baey/ICh0o=; b=hdyS4APbOQWVrtBaS7U9h
	O2ymqZLOQ0mlMk+BFkACeYcL3120/+1s6sp+JBe8ezkNCzmf+uJkpTlr9b37ojj0
	3aEbJarLlRSLnrD2Gq830z0+g3kNQ1edMYENfzMSwWUl933In7aTTXCIE4QOkra2
	lp9aVWyAbE1Qk7qiPqfcZcnhldUxbaHJbuMEYsG6Xe5/c+rGILcM4f6JImx71Aik
	wUO1AmdZTRJhxJvLWMgIK1AsyeZdgRy0BiKfo4zpGRWO4F1yxtlma23hnbhHjxUV
	IIEaDrtywggSRkyT1ZG5bkqaF8J0UNDn3lxp5E6OmCJiyEifyIJJkjkSOxv9f8DX
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402c43haty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 15:06:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45TJ6uFA046863
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Jun 2024 15:06:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sat, 29 Jun
 2024 15:06:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sat, 29 Jun 2024 15:06:55 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45TJ6bMc001401;
	Sat, 29 Jun 2024 15:06:39 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <broonie@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nuno.sa@analog.com>, <dlechner@baylibre.com>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 5/7] dt-bindings: iio: adc: Add AD4000
Date: Sat, 29 Jun 2024 16:06:35 -0300
Message-ID: <49f2ab72696440dd124241bfd275005de4b9d20c.1719686465.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hetKKj4gDymZbmjrMD6ixOPmmQiII8Vu
X-Proofpoint-GUID: hetKKj4gDymZbmjrMD6ixOPmmQiII8Vu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290138

Add device tree documentation for AD4000 series of ADC devices.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad4000.yaml          | 197 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
new file mode 100644
index 000000000000..e413a9d8d2a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4000 and similar Analog to Digital Converters
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: adi,ad4000
+      - items:
+          - enum:
+              - adi,ad4004
+              - adi,ad4008
+          - const: adi,ad4000
+
+      - const: adi,ad4001
+      - items:
+          - enum:
+              - adi,ad4005
+          - const: adi,ad4001
+
+      - const: adi,ad4002
+      - items:
+          - enum:
+              - adi,ad4006
+              - adi,ad4010
+          - const: adi,ad4002
+
+      - const: adi,ad4003
+      - items:
+          - enum:
+              - adi,ad4007
+              - adi,ad4011
+          - const: adi,ad4003
+
+      - const: adi,ad4020
+      - items:
+          - enum:
+              - adi,ad4021
+              - adi,ad4022
+          - const: adi,ad4020
+
+      - const: adi,adaq4001
+
+      - const: adi,adaq4003
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
+
+  adi,sdi-pin:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ high, low, cs, sdi ]
+    default: sdi
+    description:
+      Describes how the ADC SDI pin is wired. A value of "sdi" indicates that
+      the ADC SDI is connected to host SDO. "high" indicates that the ADC SDI
+      pin is hard-wired to logic high (VIO). "low" indicates that it is
+      hard-wired low (GND). "cs" indicates that the ADC SDI pin is connected to
+      the host CS line.
+
+  '#daisy-chained-devices': true
+
+  vdd-supply:
+    description: A 1.8V supply that powers the chip (VDD).
+
+  vio-supply:
+    description:
+      A 1.8V to 5.5V supply for the digital inputs and outputs (VIO).
+
+  ref-supply:
+    description:
+      A 2.5 to 5V supply for the external reference voltage (REF).
+
+  cnv-gpios:
+    description:
+      When provided, this property indicates the GPIO that is connected to the
+      CNV pin.
+    maxItems: 1
+
+  adi,high-z-input:
+    type: boolean
+    description:
+      High-Z mode allows the amplifier and RC filter in front of the ADC to be
+      chosen based on the signal bandwidth of interest, rather than the settling
+      requirements of the switched capacitor SAR ADC inputs.
+
+  adi,gain-milli:
+    description: |
+      The hardware gain applied to the ADC input (in milli units).
+      The gain provided by the ADC input scaler is defined by the hardware
+      connections between chip pins OUT+, R1K-, R1K1-, R1K+, R1K1+, and OUT-.
+      If not present, default to 1000 (no actual gain applied).
+    $ref: /schemas/types.yaml#/definitions/uint16
+    enum: [454, 909, 1000, 1900]
+    default: 1000
+
+  interrupts:
+    description:
+      The SDO pin can also function as a busy indicator. This node should be
+      connected to an interrupt that is triggered when the SDO line goes low
+      while the SDI line is high and the CNV line is low ("3-wire" mode) or the
+      SDI line is low and the CNV line is high ("4-wire" mode); or when the SDO
+      line goes high while the SDI and CNV lines are high (chain mode),
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vio-supply
+  - ref-supply
+
+allOf:
+  # The configuration register can only be accessed if SDI is connected to MOSI
+  - if:
+      required:
+        - adi,sdi-pin
+    then:
+      properties:
+        adi,high-z-input: false
+  # chain mode has lower SCLK max rate
+  - if:
+      required:
+        - '#daisy-chained-devices'
+    then:
+      properties:
+        spi-max-frequency:
+          maximum: 50000000 # for VIO > 2.7 V, 40000000 for VIO > 1.7 V
+  # Gain property only applies to ADAQ devices
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - adi,adaq4001
+                - adi,adaq4003
+    then:
+      properties:
+        adi,gain-milli: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,ad4020";
+            reg = <0>;
+            spi-max-frequency = <71000000>;
+            vdd-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            adi,sdi-pin = "cs";
+            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,adaq4003";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            vdd-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            adi,high-z-input;
+            adi,gain-milli = /bits/ 16 <454>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9517093d889d..9aa6531f7cf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1199,6 +1199,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
 F:	drivers/iio/dac/ad3552r.c
 
+ANALOG DEVICES INC AD4000 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
+
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0


