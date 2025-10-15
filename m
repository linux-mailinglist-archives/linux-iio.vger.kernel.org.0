Return-Path: <linux-iio+bounces-25106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5DBDF9F1
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643863A0657
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E1337691;
	Wed, 15 Oct 2025 16:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lwRSlyV5"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF8C3375BF;
	Wed, 15 Oct 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545218; cv=none; b=W/WdJ4vhCw9+INRS/Fl8muPA0cun28pO+78O3W/gKMQfZ8/ZneQBtNKWVC3jaEBnzswjJRKOFz3uUV6pr26YTj2gAAkMxagGVAE+tiMySU56PeO4dqyGphKKPQVdg7G3738SsvUfa5UQQsxchpOICBXVNiIIA7bnAwM4d/qwWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545218; c=relaxed/simple;
	bh=1P+zgOFkoSxMpqQl2tMHCe78PRwDqWlmYIUg8mwTr6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YQgW5rf3pLIlLksgoWDuMnFSgiKTIKf6jhb5zldxox/5KAzDF9mto88oK7P2YAocScL9Da1OqTcTYtqV6rmMu/XN/lewoLRJNTmDuD6WGJW0W5+hUOG98KfSuh+O0FujbDMjqNice9WOb7UmAifKvs24aclWYmr2skC+6Je5YHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lwRSlyV5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760545217; x=1792081217;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1P+zgOFkoSxMpqQl2tMHCe78PRwDqWlmYIUg8mwTr6M=;
  b=lwRSlyV5W0C0B4ou6/LGbUUEY9H/GSdRFYOVom0I7Q7Td+1QL4fkejKM
   0GgFohlck//7YwXzkafEl/QsXq1erm5anMwGKawhP4lFFrrFP/iQ3ttrW
   eAeabKTewuR3fBhRnTYtD3NggWAu92/IrytWq/JTIRDu+oLP3rNyls1nr
   EwjTVdUTi000KQYah9DCx595YSJiExjZuXGfordWFUM7BIXzxeimVyUt6
   TMnXu1jt416COOdFBRPU0Z9k0L1m6NfyRBwMyqKAwsa37BExJxh2IsGqm
   1N7+O4dahRfDjS9o6WegUe8US6uZQhUI0aBalnxRloT9PWjJcf970XE4Y
   A==;
X-CSE-ConnectionGUID: Bhsms0hATlWQ7AFZ9S6Yvw==
X-CSE-MsgGUID: rdSg983kRNufGkorsuOeOA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="47821240"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2025 09:20:10 -0700
Received: from chn-vm-ex1.mchp-main.com (10.10.87.30) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 15 Oct 2025 09:19:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Wed, 15 Oct 2025 09:19:49 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 15 Oct 2025 09:19:46 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 15 Oct 2025 13:12:15 +0300
Subject: [PATCH 1/2] dt-bindings: iio: adc: adding support for PAC1711
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251015-pac1711-v1-1-976949e36367@microchip.com>
References: <20251015-pac1711-v1-0-976949e36367@microchip.com>
In-Reply-To: <20251015-pac1711-v1-0-976949e36367@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760523137; l=7915;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=1P+zgOFkoSxMpqQl2tMHCe78PRwDqWlmYIUg8mwTr6M=;
 b=Dcfq/bUTzNPD7XA9CW8wueayCBlJUpbpWQxtJcgnKqKeahn8uY8hz+8CQ81jbDHStXWSZHS9l
 zLZAGWQoK4NCfxvDjoWnqsWRdWIWWZgtq4d03mzNu7uutI0b/5re6qj
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the device tree schema for Microchip PAC1711 single-channel power
monitor with accumulator. The device uses 12-bit resolution for voltage and
current measurements and 24 bits power calculations. The device supports
one 56-bit accumulator register.

PAC1711 measures up to 42V Full-Scale Range.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/adc/microchip,pac1711.yaml        | 195 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 201 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..67edd778981c2f0ed21dda02f14e383a153169b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
@@ -0,0 +1,195 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/microchip,pac1711.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PAC1711 Power Monitors with Accumulator
+
+maintainers:
+  - Ariana Lazar <ariana.lazar@microchip.com>
+
+description: |
+  This device is part of the Microchip family of Power Monitors with Accumulator.
+  The datasheet for PAC1711 can be found here:
+  https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,pac1711
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  gpio-controller:
+    description: Marks the device node as a GPIO controller.
+
+  "#gpio-cells":
+    const: 2
+    description:
+      The first cell is the GPIO number and the second cell specifies
+      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
+
+  powerdown-gpios:
+    description:
+      Active low puts the device in power-down state. When the PWRDN pin is
+      pulled high, measurement and accumulation will resume using the default
+      register settings.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      Could be triggered by overvoltage, undervoltage, overcurrent, overpower,
+      undercurrent, step limit, accumulator overflow and accumulator count
+      overflow.
+    items:
+      - const: alert0
+      - const: alert1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value in micro Ohms of the shunt resistor connected between
+      the VSENSEP and VSENSEN inputs, across which the current is measured.
+      Value is needed to compute the scaling of the measured current.
+
+  label:
+    description: Unique name to identify which device this is.
+
+  microchip,gpio:
+    type: boolean
+    description:
+      In default mode, A0 pin is a GPIO 0 input pin, respectively A1 pin is
+      GPIO 1. The pins can be used for the SLOW function, the device will sample
+      at 8 samples/second if pulled high. A0 also function as the Alert0 and A1
+      as Alert1, but can no longer be used to control conversion rate or SLOW.
+
+  microchip,vbus-input-range-microvolt:
+    description: |
+      Specifies the voltage range in microvolts chosen for the voltage full
+      scale range (FSR). The range should be set as <minimum, maximum> by
+      hardware design and should not be changed during runtime.
+
+      The VBUS could be configured into the following full scale range:
+        -  VBUS has unipolar 0V to 42V FSR (default)
+        -  VBUS has bipolar -42V to 42V FSR
+        -  VBUS has bipolar -21V to 21V FSR
+    items:
+      - enum: [-42000000, -21000000, 0]
+      - enum: [21000000, 42000000]
+
+  microchip,vsense-input-range-microvolt:
+    description: |
+      Specifies the voltage range in microvolts chosen for the current full
+      scale range (FSR). The current is calculated by dividing the vsense
+      voltage by the value of the shunt resistor. The range should be set as
+      <minimum, maximum> by hardware design and it should not be changed during
+      runtime.
+
+      The VSENSE could be configured into the following full scale range:
+        -  VSENSE has unipolar 0 mV to 100V FSR (default)
+        -  VSENSE has bipolar -100 mV to 100 mV FSR
+        -  VSENSE has bipolar -50 mV to 50 mV FSR
+    items:
+      - enum: [-100000, -50000, 0]
+      - enum: [50000, 100000]
+
+  microchip,accumulation-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The Hardware Accumulator may be used to accumulate VPOWER, VSENSE or
+      VBUS values for any channel. By setting the accumulator for a channel
+      to accumulate the VPOWER values gives a measure of accumulated power
+      into a time period, which is equivalent to energy. Setting the
+      accumulator for a channel to accumulate VSENSE values gives a measure
+      of accumulated current, which is equivalent to charge.
+
+      The Hardware Accumulator could be configured as:
+       <0>  -  Accumulator accumulates VPOWER (default)
+       <1>  -  Accumulator accumulates VSENSE
+       <2>  -  Accumulator accumulates VBUS
+    maximum: 2
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - shunt-resistor-micro-ohms
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,pac1711
+    then:
+      properties:
+        microchip,vbus-input-range-microvolt:
+          oneOf:
+            - items:
+                - const: 0
+                - const: 42000000
+            - items:
+                - const: -42000000
+                - const: 42000000
+            - items:
+                - const: -21000000
+                - const: 21000000
+          default:
+            items:
+              - const: 0
+              - const: 42000000
+
+        microchip,vsense-input-range-microvolt:
+          oneOf:
+            - items:
+                - const: 0
+                - const: 100000
+            - items:
+                - const: -100000
+                - const: 100000
+            - items:
+                - const: -50000
+                - const: 50000
+          default:
+            items:
+              - const: 0
+              - const: 100000
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pac1711@10 {
+            compatible = "microchip,pac1711";
+            reg = <0x10>;
+
+            shunt-resistor-micro-ohms = <10000>;
+            label = "VDD3V3";
+            vdd-supply = <&vdd>;
+            microchip,vbus-input-range-microvolt = <(-21000000) 21000000>;
+            microchip,vsense-input-range-microvolt = <(-50000) 50000>;
+            microchip,accumulation-mode = <0>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..7686e2516c90442aa3e23d19cfb08e280a44ba76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16337,6 +16337,12 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 F:	drivers/nvmem/microchip-otpc.c
 F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
+MICROCHIP PAC1711 DAC DRIVER
+M:	Ariana Lazar <ariana.lazar@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
+
 MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
 M:	Matteo Martelli <matteomartelli3@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0


