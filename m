Return-Path: <linux-iio+bounces-20595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93FAAD8CAF
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D925164759
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212C870810;
	Fri, 13 Jun 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UUV/8l2l"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2461DA29;
	Fri, 13 Jun 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819765; cv=none; b=Gx8sfgCaW+2mgppT4xF2l/xPl32FXcesBdA4kEcHS1xKnbPHhPnmgBpm1xVEWV0qutr4lyrD4vI8HXTH7NwT2v6j9UpzB1jFRhqLNyqqFspa1UzXSSlUy2b2Ka4tKQYx6q47t2SElXEyeKt7l5Ak778iHufjIK1SKJbTol0ZkjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819765; c=relaxed/simple;
	bh=iDUHzb5KiG2udZG4Gth0ZpjkeGyywdN49zxcOfgKPrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jb9EoqazBSDy3RAa71l2GN6vWgn9iYxrdFXDw/TtDJKequuCTgKL1TftLTxDBcv/igqhpNYbAjxRNUsAgh2pF3bUZXaeeZ5uK+hVC/k1tKmC1WcDrb3FTyxjYrzMTzFkfKaeuowNXyVAd6D7vismWRMfNeNcmr2SPGQvfmTidnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UUV/8l2l; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749819765; x=1781355765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDUHzb5KiG2udZG4Gth0ZpjkeGyywdN49zxcOfgKPrQ=;
  b=UUV/8l2lWPf3ewvke1n2qago0c/AElDgD+vRIoyjUkIK7xoPdR2+xIwJ
   kSaeLvxjzGEpSL5pFZklz35lMStMSKNw/1rd7ydMMAAc01N0+s9rhYh5D
   eDcPFqSzroaatsgFn95P7Wr1XetqqBIu8VeR+9KohpEWpqYR14BnodAem
   dbM1ssM4xH6VCjCsdDe/3PEl7IoH17KgVGuvXkdR3bDDqx0zYci6rWZdr
   tzO3epTpChdA+w0HucWoZQNPTNZCGzx5x/KMSdXqd1ZcdbNfQRCEwcx+n
   8i5/RfQ+uCDzNg00A4TxxwJKLIQkAxaWGAkAIqFy0GDenk+OfxzxpwXmR
   g==;
X-CSE-ConnectionGUID: Aonm0V6kTF+56eNzH0aNCQ==
X-CSE-MsgGUID: 9NF5q4BDT/iTtvAlCk2Uiw==
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="274154965"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2025 06:02:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Jun 2025 06:02:27 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 13 Jun 2025 06:02:24 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: temperature: add support for MCP998X
Date: Fri, 13 Jun 2025 16:02:06 +0300
Message-ID: <20250613130207.8560-2-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250613130207.8560-1-victor.duicu@microchip.com>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This is the devicetree schema for Microchip MCP998X/33 and
MCP998XD/33D Automotive Temperature Monitor Family.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 .../iio/temperature/microchip,mcp9982.yaml    | 211 ++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
new file mode 100644
index 000000000000..ec939d463612
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
@@ -0,0 +1,211 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive
+       Temperature Monitor Family
+
+maintainers:
+  - Victor Duicu <victor.duicu@microchip.com>
+
+description: |
+  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire multichannel
+  automotive temperature monitor.
+  The datasheet can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp9933
+      - microchip,mcp9933d
+      - microchip,mcp9982
+      - microchip,mcp9982d
+      - microchip,mcp9983
+      - microchip,mcp9983d
+      - microchip,mcp9984
+      - microchip,mcp9984d
+      - microchip,mcp9985
+      - microchip,mcp9985d
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      -alert-therm is used to handle a HIGH or LOW limit.
+      -therm-addr is used to handle a THERM limit on chips
+      without "D" in the name.
+      -sys-shutdown is used to handle a THERM limit on chips
+      with "D" in the name.
+    items:
+      - const: alert-therm
+      - const: therm-addr
+      - const: sys-shutdown
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,enable-anti-parallel:
+    description:
+      Enable anti-parallel diode mode operation.
+      MCP9984/84D/85/85D and MCP9933/33D support reading two external diodes
+      in anti-parallel connection on the same set of pins.
+    type: boolean
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
+    default: 16
+
+  microchip,beta2:
+    description:
+      Set beta compensation value for external channel 2.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 16
+
+  microchip,resistance-comp-ch1-2-enable:
+    description:
+      Enable resistance error correction(REC) for external channels 1 and 2.
+      The chip internal hardware counterbalances the parasitic resistance in
+      series with the external diodes. The compensation can be activated or
+      disabled in hardware for both channels 1 and 2 at the same time.
+    type: boolean
+
+  microchip,resistance-comp-ch3-4-enable:
+    description:
+      Enable resistance error correction(REC) for external channels 3 and 4.
+      The chip internal hardware counterbalances the parasitic resistance in
+      series with the external diodes. The compensation can be activated or
+      disabled in hardware for both channels 3 and 4 at the same time.
+    type: boolean
+
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
+              - microchip,mcp9982d
+              - microchip,mcp9983d
+              - microchip,mcp9984d
+              - microchip,mcp9985d
+              - microchip,mcp9933d
+    then:
+      properties:
+        interrupts-names:
+          items:
+            - const: alert-therm
+            - const: sys-shutdown
+    else:
+      properties:
+        interrupts-names:
+          items:
+            - const: alert-therm
+            - const: therm-addr
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
+            compatible = "microchip,mcp9985";
+            reg = <0x4c>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            microchip,enable-anti-parallel;
+            microchip,resistance-comp-ch1-2-enable;
+            microchip,resistance-comp-ch3-4-enable;
+            microchip,beta1 = <16>;
+            microchip,beta2 = <16>;
+            vdd-supply = <&vdd>;
+
+            channel@1 {
+                reg = <1>;
+                label = "CPU Temperature";
+            };
+
+            channel@2 {
+                reg = <2>;
+                label = "GPU Temperature";
+            };
+        };
+    };
+
+...
-- 
2.48.1


