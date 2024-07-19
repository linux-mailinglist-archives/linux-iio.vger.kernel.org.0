Return-Path: <linux-iio+bounces-7714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BF2937BB3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA205B21C2F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12D146A9B;
	Fri, 19 Jul 2024 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ezNqP2f8"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E147146A72;
	Fri, 19 Jul 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410786; cv=none; b=qYe1SHug2ALGV05QcCEGbauhWsyt/Jc7pqxt5ccd4em60ZqtX03EYWcJDizTlenFGz8VZAsXjU2gpEu+ok6Z2kc+d4J65fltfcUqH4mDnJPELIL5QRAcFyiO9/SYFN1MwzcWK0qyRtlK2i7TMPKX6ZjM7/5C7KCIADKnxJFoC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410786; c=relaxed/simple;
	bh=y2fksHYs0CvAjQ+Zubx0thjSre3RrOXacrgGUzj3+3g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWShm5QVenE/R0DZZL5zCroIrziwyAm0Sk74Gay8QeCqzYBxseZZ7PR7kXrvAEg7KxUj0ZHbN+XfEhKqtGYSYWMxF/ByOAdSOHr8/SaDrU0xLMgS48Z6r/rUCCqJbPKtnOb8eK+/GW3nkdjctIPOVeAHpMEGIaxx78x9fygLI/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ezNqP2f8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721410784; x=1752946784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y2fksHYs0CvAjQ+Zubx0thjSre3RrOXacrgGUzj3+3g=;
  b=ezNqP2f8r80yR6abTAfoaTgLWCNCZttEWkdBOJbRSHRs7Jre7lpbxter
   QpuUVRQzPv2H3dcYHFNsBD/YJ331K5rP8DADetLFW/4aehN/AOdH1Lhuf
   rgn9Ys++7lnuzCXMcltWWszCSMb0hMmoyHla03wkeZUPshXjbLUn20uoa
   UNM4wMpannMZHfDomOe3y2Ap2dgLOKZkgjYmuQKGOCiY3gHA33Hc32JI4
   1zQFpa21w7a6loTf7VO6HprEKKJuSbxZnKmST0iFRJWEd9KCE2BNLjYVG
   R78Us9ZLCInJrxRSIFVtZBYMEtDK2CUl/CPPiFCBD0SGv9scEY95XRaRM
   A==;
X-CSE-ConnectionGUID: QnXZCxylTLSfBXU/hmrkSg==
X-CSE-MsgGUID: u9VXNyZZTXeN3k1+ZkGCGg==
X-IronPort-AV: E=Sophos;i="6.09,221,1716274800"; 
   d="scan'208";a="29461287"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2024 10:39:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jul 2024 10:39:07 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Jul 2024 10:39:05 -0700
From: <marius.cristea@microchip.com>
To: <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: adding support for PAC194X
Date: Fri, 19 Jul 2024 20:38:54 +0300
Message-ID: <20240719173855.53261-2-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719173855.53261-1-marius.cristea@microchip.com>
References: <20240719173855.53261-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Marius Cristea <marius.cristea@microchip.com>

This is the device tree schema for iio driver for
Microchip PAC194X and PAC195X series of Power Monitors with Accumulator.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1944.yaml   | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
new file mode 100644
index 000000000000..e997a4d536e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1944.yaml
@@ -0,0 +1,168 @@
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
+  This device is part of the Microchip family of Power Monitors with Accumulator.
+  The datasheet for PAC1941_1, PAC1941_1, PAC1942_1, PAC1942_2, PAC1943_1 and PAC1944_1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC194X-Family-Data-Sheet-DS20006543.pdf
+  The datasheet for PAC1951_1, PAC1951_1, PAC1952_1, PAC1952_2, PAC1953_1 and PAC1954_1 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/PAC195X-Family-Data-Sheet-DS20006539.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1941_1
+      - microchip,pac1941_2
+      - microchip,pac1942_1
+      - microchip,pac1942_2
+      - microchip,pac1943_1
+      - microchip,pac1944_1
+      - microchip,pac1951_1
+      - microchip,pac1951_2
+      - microchip,pac1952_1
+      - microchip,pac1952_2
+      - microchip,pac1953_1
+      - microchip,pac1954_1
+
+  reg:
+    maxItems: 1
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
+  slow-io-gpios:
+    description:
+      A GPIO used to trigger a change is sampling rate (lowering the chip power
+      consumption). If configured in SLOW mode, if this pin is forced high,
+      sampling rate is forced to eight samples/second. When it is forced low,
+      the sampling rate is 1024 samples/second unless a different sample rate
+      has been programmed.
+
+  microchip,gpio:
+    type: boolean
+    description:
+      In default mode, this pin is a GPIO input pin. It can be
+      configured to be an output pin, as well as the ALERT2
+      function. This pin is an open-drain configuration and
+      needs a pull-up resistor to VDD.
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
+      microchip,vbus-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The VBUS could be configured into the following full scale range (FSR)
+            <0>  -  VBUS has unipolar +32V to 0V FSR (default)
+            <1>  -  VBUS has bipolar +32V to -32V FSR
+            <2>  -  VBUS has bipolar +16V to -16V FSR
+        maximum: 2
+
+      microchip,vsense-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The VSENSE could be configured into the following full scale range (FSR)
+            <0>  -  VSENSE has unipolar +100 mV to 0V FSR (default)
+            <1>  -  VSENSE has bipolar +100 mV to -100 mV FSR
+            <2>  -  VSENSE has bipolar +50 mV to -50 mV FSR
+        maximum: 2
+
+      microchip,accumulation-mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          The Hardware Accumulator could be configured to accumulate
+          VPOWER, VSENSE or VBUS
+            <0>  -  Accumulator accumulates VPOWER (default)
+            <1>  -  Accumulator accumulates VSENSE
+            <2>  -  Accumulator accumulates VBUS
+        maximum: 2
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
+            compatible = "microchip,pac1954_1";
+            reg = <0x10>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            status = "okay";
+
+            channel@1 {
+                reg = <0x1>;
+                shunt-resistor-micro-ohms = <24900>;
+                label = "CPU";
+                microchip,vbus-mode = <0>;
+                microchip,vsense-mode = <0>;
+                microchip,accumulation-mode = <0>;
+            };
+
+            channel@3 {
+                reg = <0x3>;
+                shunt-resistor-micro-ohms = <75000>;
+                label = "MEM";
+                microchip,vbus-mode = <0>;
+                microchip,vsense-mode = <0>;
+                microchip,accumulation-mode = <0>;
+            };
+
+            channel@4 {
+                reg = <0x4>;
+                shunt-resistor-micro-ohms = <100000>;
+                label = "NET";
+                microchip,vbus-mode = <0>;
+                microchip,vsense-mode = <0>;
+                microchip,accumulation-mode = <0>;
+            };
+        };
+    };
+
+...
-- 
2.43.0


