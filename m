Return-Path: <linux-iio+bounces-20257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C456ACFF77
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD9D17978E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593CD286427;
	Fri,  6 Jun 2025 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Lf2shYci"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F491C861D;
	Fri,  6 Jun 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749202789; cv=none; b=PV4GaTKWGMgstwESmCGr0/vIC+uiSZ+6kfCrh2yhkz/784ii8fj7C5K3+wH7N/86H3hNAjomIOKL26qvR/21roA6OMrQqBYOCC2pPRaihbYhgGJKv+UvDvoUboWnbXvD6s/CV/Tg4wgY/FYVe0MFmXPYOv8+9fIp2eTH3w+3Auk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749202789; c=relaxed/simple;
	bh=2OFIkwcFfGxbIptsJzGXFt9IKn/aP/aohtIajXB2Jno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wt9BoWgY4PvBFBxkhS3kesmbB99+pDpcTKkqbc4JsvESWbJFi99yZhIjTuO55Hw8gHA26kSPuQO7pugKPFp8i89fQexUwvQdYTXjFlgbInPYINQoz1UMWYxGENLIS9bR9c9byEs6HLhmDKHcDq2kdXk3kltq3tbc5Pc3rXNNAVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Lf2shYci; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749202787; x=1780738787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2OFIkwcFfGxbIptsJzGXFt9IKn/aP/aohtIajXB2Jno=;
  b=Lf2shYciSVxArhhKE7mtyIaFOO6vDkFpU1f+HejPiVz1KasX/xaU6OiR
   p3XZ8Yxu/drKzfyq/wkkl7k8tsc2sYALWNuP+zFGiZc4JyLL30qfB6kOe
   DAs/G/3UPPYypS7uxvwO4PPAcv5lYNR71rJezqcijFwPPzm6uSXzaXMu4
   TEapBqFvB/Er2CaJUV1AWtYjMExW5ImHyz8nmgmeT+G71DjWOSnM/abR7
   HnQBWhQIDaKBrwqWrxsJHk0wyITQXYrv7bB++5kyfDX40Ut7508NmO5DX
   zZWoqzcsoZlD/Wx0lV/CIR27sqx/n/+CXeYayeTmOBw7GTwxHnyjDopBM
   Q==;
X-CSE-ConnectionGUID: RNxw4F1gS4uefnTd7vXzbA==
X-CSE-MsgGUID: y5Nj09tiRyOGdHR44TJ84A==
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; 
   d="scan'208";a="43064047"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2025 02:39:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 6 Jun 2025 02:39:43 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 6 Jun 2025 02:39:40 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<broonie@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<marius.cristea@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: adding support for PAC194X
Date: Fri, 6 Jun 2025 12:39:28 +0300
Message-ID: <20250606093929.100118-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606093929.100118-1-marius.cristea@microchip.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for Microchip PAC194X
and PAC195X series of Power Monitors with Accumulator. The PAC194X
family supports 9V Full-Scale Range and the PAC195X supports 32V
Full-Scale Range.

There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices
are for high-side current sensing and the PAC194X/5X-2 devices are
for low-side current sensing or floating VBUS applications.

The PAC194X/5X-1 is named shortly PAC194X/5X.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1944.yaml   | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
new file mode 100644
index 000000000000..4a2cf6b64055
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
@@ -0,0 +1,204 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1944.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1944 and PAC1954 Power Monitors with Accumulator
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with
+  Accumulator. The datasheet for PAC1941-1, PAC1941-1, PAC1942-1, PAC1942-2,
+  PAC1943-1 and PAC1944-1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
+  The datasheet for PAC1951-1, PAC1951-1, PAC1952-1, PAC1952-2, PAC1953-1 and
+  PAC1954-1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1941
+      - microchip,pac19412
+      - microchip,pac1942
+      - microchip,pac19422
+      - microchip,pac1943
+      - microchip,pac1944
+      - microchip,pac1951
+      - microchip,pac19512
+      - microchip,pac1952
+      - microchip,pac19522
+      - microchip,pac1953
+      - microchip,pac1954
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      alert1 indicates a HIGH or LOW limit was exceeded.
+      alert2 indicates a THERM limit was exceeded.
+    items:
+      - const: alert1
+      - const: alert2
+
+patternProperties:
+  "^channel@[1-4]+$":
+    type: object
+    $ref: adc.yaml
+    description:
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      shunt-resistor-micro-ohms:
+        description:
+          Value in micro Ohms of the shunt resistor connected between
+          the SENSE+ and SENSE- inputs, across which the current is measured.
+          Value is needed to compute the scaling of the measured current.
+
+      microchip,vbus-half-range:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: |
+          In order to increase measurement resolution and keeping the same
+          number the of bits the device has a configurable VBUS full range scale
+          (FSR). The range should be set by hardware design and it should not be
+          changed during runtime. The bipolar capability for VBUS enables
+          accurate offset measurement and correction.
+          The VBUS could be configured into the following full scale range:
+            - VBUS has unipolar 0V to 32V FSR (default) for PAC195X or 0V to 9V
+              (default) for PAC194X.
+            - VBUS has bipolar -32V to 32V FSR for PAC195X or -9V to 9V for
+              PAC194X. The actual range is limited to about -200 mV due to the
+              impact of the ESD structures.
+            - VBUS has bipolar -16V to 16V FSR for PAC195X or -4.5V to 4.5V for
+              PAC194X. The actual range is limited to about -200 mV due to the
+              impact of the ESD structures.
+
+      microchip,vbus-bipolar:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          If provided, the channel is to be used in bipolar mode. The
+          actual range is limited to about -200 mV due to the impact of the ESD
+          structures.
+
+      microchip,vsense-half-range:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: |
+          In order to decrease the power dissipation on the shunt resistor and
+          in the same time to increase measurement resolution by keeping the
+          same number the of bits the device has a configurable VSENSE full
+          range scale (FSR). The range should be set by hardware design and it
+          should not be changed during runtime.
+          The VSENSE could be configured into the following full scale range:
+            - VSENSE has unipolar 0V to 100 mV FSR (default)
+            - VSENSE has bipolar -100 mV to 100 mV FSR
+            - VSENSE has bipolar -50 mV to 50 mV FSR
+
+      microchip,vsense-bipolar:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          If provided, the channel is to be used in bipolar mode.
+
+      microchip,accumulation-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The Hardware Accumulator may be used to accumulate VPOWER, VSENSE or
+          VBUS values for any channel. By setting the accumulator for a channel
+          to accumulate the VPOWER values gives a measure of accumulated power
+          into a time period, which is equivalent to energy. Setting the
+          accumulator for a channel to accumulate VSENSE values gives a measure
+          of accumulated current, which is equivalent to charge. This allows the
+          accumulator to be used as a coulomb counter. For either VSENSE or
+          VBUS, many samples may be accumulated on chip and the result collected
+          by the host and divided by the accumulator counter count value to
+          yield an average value with a very long integration time to reduce
+          noise. This feature is also very useful for system calibration,
+          allowing many averages to be accumulated for fast averaging/noise
+          reduction.
+          This functionality needs to be setup once and must not be changed
+          during the runtime, just in case the user wants to measure the charge
+          or the energy consumed from board power up till the user has control
+          or during a reboot of the system.
+          The Hardware Accumulator could be configured to accumulate
+          VPOWER, VSENSE or VBUS
+            <0>  -  Accumulator accumulates VPOWER (default)
+            <1>  -  Accumulator accumulates VSENSE
+            <2>  -  Accumulator accumulates VBUS
+        maximum: 2
+        default: 0
+
+    required:
+      - reg
+      - shunt-resistor-micro-ohms
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-monitor@10 {
+            compatible = "microchip,pac1954";
+            reg = <0x10>;
+            vdd-supply = <&vdd>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@1 {
+                reg = <0x1>;
+                shunt-resistor-micro-ohms = <24900>;
+                label = "CPU";
+                microchip,vsense-half-range;
+                microchip,vsense-bipolar;
+            };
+
+            channel@3 {
+                reg = <0x3>;
+                shunt-resistor-micro-ohms = <75000>;
+                label = "MEM";
+                microchip,vbus-half-range;
+                microchip,vbus-bipolar;
+                microchip,vsense-half-range;
+            };
+
+            channel@4 {
+                reg = <0x4>;
+                shunt-resistor-micro-ohms = <100000>;
+                label = "NET";
+                microchip,vbus-bipolar;
+            };
+        };
+    };
+
+...
-- 
2.48.1


