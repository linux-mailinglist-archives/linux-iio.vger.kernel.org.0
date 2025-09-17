Return-Path: <linux-iio+bounces-24207-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881E0B7D5A6
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098E3467D75
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FAC337EBE;
	Wed, 17 Sep 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IooIxzPW"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C50337E9B;
	Wed, 17 Sep 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111792; cv=none; b=C1QTnmQysR+4VPEf1uaYxw+EeCurs9eNWdcJHbXTFt5ncutZx5/z2r08RRpuVuNBHp5lOhrt1XkMgQKsld5P/uA8Yd226RFrb8C0rn6wMBc/E16ICx7DSnrk5vB+JE0mSoXMKM+1AjWeQWMAu0JgTHmFx31T5ReXls9dkcUqjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111792; c=relaxed/simple;
	bh=BpD1bOFTOIJsiHSQusp9sWgVg2Vr0RHKSMK0p4m8mUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q/bV95yfslEjRNyLEDP227gzwUEPSUBOX54s2/bV+qxJhV2zmH9oBcG5dhGpv4l24Y5qHqTG8PdbbuIJKYZfy9D9t+GUwmOdch0YpSl2CASxxnE+wxLPNFg7nenTK0jFh03lkfyWA1evb0EMiG2WuL7JItnW3r1xUsGlQ8afx9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IooIxzPW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758111791; x=1789647791;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BpD1bOFTOIJsiHSQusp9sWgVg2Vr0RHKSMK0p4m8mUU=;
  b=IooIxzPWbHD8EDB6D9ZUOrzkWY8VdvEOqTFcLiObeUkeTybn/lzeWUlr
   YCSRutk1k2L7Bt3lPqflJ2e968pZ+MY6u0o1AWcMGjWSMmhGSBP8qv94j
   +ru4ODHv3c0/1uD6KDGoxJ678CvDHKa+CnNmbjtvcX/K7O1HWK6aFTIm4
   ymN2ifQmvLX6hCsbXCeZGEeBXMtck/rCC3Ie2YvuLdStMILIRi7Dxd3J4
   RWQMdwhh/NvQtGtSSswi5PO6r2MQZNs2IMvZEqjk+vFjRNbVzbnRZlHnJ
   d8lxhP6deGUSCfnAdzFCXshJ2eMuS0fWv0QJEUTzuX6ZpKi0TeWAX+AOL
   A==;
X-CSE-ConnectionGUID: 1Y/9r9DUQQ6M27zKdQ/Wqw==
X-CSE-MsgGUID: VBNycquIQTaPjlOAfFPAxQ==
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="47159034"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 05:23:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 05:22:42 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 17 Sep 2025 05:22:39 -0700
From: Marius Cristea <marius.cristea@microchip.com>
Date: Wed, 17 Sep 2025 15:21:57 +0300
Subject: [PATCH 1/2] dt-bindings: iio: temperature: add support for EMC1812
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250917-iio-emc1812-v1-1-0b1f74cea7ab@microchip.com>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
In-Reply-To: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Marius Cristea <marius.cristea@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7373;
 i=marius.cristea@microchip.com; h=from:subject:message-id;
 bh=BpD1bOFTOIJsiHSQusp9sWgVg2Vr0RHKSMK0p4m8mUU=;
 b=owGbwMvMwCW2tbSTZa7u0x2Mp9WSGDJOreB5WhVS9Xn26w1/YtumPbEqUK3yzy+W+3bAOytMp
 fTUqdU5HaUsDGJcDLJiiiwr3vqpVa39cFlJLFMHZg4rE8gQBi5OAZiIrCAjw8Q83sLKxzoGC761
 CuxrDetcphj9eWnwvE9VV1+Is/79WM7wP7FQ7fzCRZt4e/Z17v0+bc/6qPLAb/91P23cFq4kK82
 xlg0A
X-Developer-Key: i=marius.cristea@microchip.com; a=openpgp;
 fpr=E32F8D4396E72E463E8CCD91446DE0ABD9140C3E

This is the devicetree schema for Microchip EMC1812/13/14/15/33
Multichannel Low-Voltage Remote Diode Sensor Family.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../iio/temperature/microchip,emc1812.yaml         | 223 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 229 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,emc1812.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,emc1812.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..898d6d246746e229cb004f447872ee6bd5a65074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,emc1812.yaml
@@ -0,0 +1,223 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/microchip,emc1812.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip EMC1812/13/14/15/33 multichannel temperature sensor
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  The Microchip EMC1812/13/14/15/33 is a high-accuracy 2-wire multichannel
+  low-voltage remote diode temperature monitor.
+
+  The datasheet can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/EMC1812-3-4-5-33-Data-Sheet-DS20005751.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,emc1812
+      - microchip,emc1813
+      - microchip,emc1814
+      - microchip,emc1815
+      - microchip,emc1833
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      -alert-therm2 asserts when a diode temperature exceeds the ALERT
+      threshold.
+      -therm-addr asserts low when the hardware-set THERM limit threshold is
+      exceeded by one of the temperature sensors.
+    items:
+      - const: alert-therm2
+      - const: therm-addr
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,beta1:
+    description:
+      Set beta compensation value for external channel 1.
+      <0> 0.050
+      <1> 0.066
+      <2> 0.087
+      <3> 0.114
+      <4> 0.150
+      <5> 0.197
+      <6> 0.260
+      <7> 0.342
+      <8> 0.449
+      <9> 0.591
+      <10> 0.778
+      <11> 1.024
+      <12> 1.348
+      <13> 1.773
+      <14> 2.333
+      <15> Diode_Mode
+      <16> Auto
+      - Diode_Mode is used when measuring a discrete thermal diode
+      or a CPU diode that functions like a discrete thermal diode.
+      - Auto enables beta auto-detection. The chip monitors
+      external diode/transistor and determines the optimum
+      setting.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16
+    default: 16
+
+  microchip,beta2:
+    description:
+      Set beta compensation value for external channel 2.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16
+    default: 16
+
+  microchip,parasitic-res-on-channel1-2:
+    description:
+      Indicates that the chip and the diodes/transistors are sufficiently far
+      apart that a parasitic resistance is added to the wires, which can affect
+      the measurements. Due to the anti-parallel diode connections, channels
+      1 and 2 are affected together.
+    type: boolean
+
+  microchip,parasitic-res-on-channel3-4:
+    description:
+      Indicates that the chip and the diodes/transistors are sufficiently far
+      apart that a parasitic resistance is added to the wires, which can affect
+      the measurements. Due to the anti-parallel diode connections, channels
+      3 and 4 are affected together.
+    type: boolean
+
+  vdd-supply: true
+
+patternProperties:
+  "^channel@[1-4]$":
+    description:
+      Represents the external temperature channels to which
+      a remote diode is connected.
+    type: object
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      microchip,ideality-factor:
+        description:
+          Each channel has an ideality factor.
+          Beta compensation and resistance error correction automatically
+          correct for most ideality errors. So ideality factor does not need
+          to be adjusted in general.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 8
+        maximum: 55
+        default: 18
+
+      label:
+        description: Unique name to identify which channel this is.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,emc1812
+              - microchip,emc1813
+              - microchip,emc1833
+    then:
+      properties:
+        microchip,beta2: false
+        microchip,parasitic-res-on-channel3-4: false
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,emc1812"
+    then:
+      patternProperties:
+        "^channel@1$":
+          properties:
+            reg:
+              items:
+                maximum: 1
+        "^channel@[2-4]$": false
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,emc18[13]3"
+    then:
+      patternProperties:
+        "^channel@[12]$":
+          properties:
+            reg:
+              items:
+                maximum: 1
+        "^channel@[34]$": false
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,emc1814"
+    then:
+      patternProperties:
+        "^channel@[1-3]$":
+          properties:
+            reg:
+              items:
+                maximum: 1
+        "^channel@4$": false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@4c {
+            compatible = "microchip,emc1813";
+            reg = <0x4c>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            microchip,parasitic-res-on-channel1-2;
+
+            microchip,beta1 = <16>;
+            vdd-supply = <&vdd>;
+
+            channel@1 {
+                reg = <1>;
+                label = "External CH1 Temperature";
+            };
+
+            channel@2 {
+                reg = <2>;
+                label = "External CH2 Temperature";
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..09efda36a17e398b3ad807ac47485e530154bae4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22862,6 +22862,12 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/net/ethernet/smsc/smc91x.*
 
+MICROCHIP EMC1812 TEMPERATURE DRIVER
+M:	Marius Cristea <marius.cristea@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/temperature/microchip,emc1812.yaml
+
 SMSC EMC2103 HARDWARE MONITOR DRIVER
 M:	Steve Glendinning <steve.glendinning@shawell.net>
 L:	linux-hwmon@vger.kernel.org

-- 
2.48.1


