Return-Path: <linux-iio+bounces-25865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6AC30248
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 10:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7177C4FAE7B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A54B3115B5;
	Tue,  4 Nov 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BxAw/dqw"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AF30F93E;
	Tue,  4 Nov 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246603; cv=none; b=JnNuGMdyZV+4rNSrUVXv8XS0kvc/DB7yvWFQqOXsB+8KHkUhzRAA/mF55gkvuk8fY/XceI11QcXieFE9sJtvn7fLU94lqc1d9llW67/w6c1UCdMUeTAdthVxvl4FKGZ3K9njb8vybCcfVwmJovmWT005M6Ep1amC+dGcFbHtjWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246603; c=relaxed/simple;
	bh=UfUblDT/93g2mrYdkqQD4JwsXxMegz7CDaQWhqMKJEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=r76ukh0hzcoWEr6asByYUzIfytF538pFL+CDE6d5Uup1naNMyACwzu96wWvqRxGvQ/dLMWibidT/mM9FgfHO4RiUVJdFUcYgIYFGtVU5uoFYcHw5S34MXf7YdT4xd9ZcLHkYUc5GIXyez+H8qDZNvUMWz14P+6/Lc1kKgoWauVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BxAw/dqw; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762246601; x=1793782601;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UfUblDT/93g2mrYdkqQD4JwsXxMegz7CDaQWhqMKJEs=;
  b=BxAw/dqwFos7Dwxewpx4nyXtIgHX6vrhP2f1eMZ+v7EWmhPvyEJOcI+D
   sZjawyuliXy9aB8HaBeK60GchF8PLWb/FfNeloZ/ScpQt8Wa5YNEqPGI2
   F2UfC3A7s4Km8RwbkHZd5yMKDh+vP89zgMHC7T8vLJ6QLNsyC+pPDWJ7u
   t4pl+GrCs9ICQDYsTXJ3O/k4LySp+LjjXH/3tBRCeSdpcwxLRSw8QiBy7
   4HfPcqKdpTvTb0xi1I+pyG5/mHMuhPsjFA6YX7ngLiZ9dxkJpeoqNTtj5
   G2+L9zbyx3TKzoKjJROUzR1SwB6oU6rLtfPTie+7vQkc3O+Tmvr51oFvL
   Q==;
X-CSE-ConnectionGUID: G3l3R0J8Rsa+FyrXXNMZIQ==
X-CSE-MsgGUID: 2mqj3kxbRvmUzRLaNEseyg==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="48018758"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:56:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 01:55:51 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 01:55:48 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Mon, 3 Nov 2025 17:50:29 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: dac: adding support for Microchip
 MCP47FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251103-mcp47feb02-v2-1-8c37741bd97a@microchip.com>
References: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
In-Reply-To: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
To: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762185039; l=12341;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=UfUblDT/93g2mrYdkqQD4JwsXxMegz7CDaQWhqMKJEs=;
 b=A+2qZmaKqgJPHqsY01Lfn7FDBMqi+L+KXmD33w45GVp1hf82KwmISVKItLmUxIJ9jDJAeLWBK
 YcXBCz4ogHPD7cogoJa8ookyolv8gF4n0PnorKOAQ5fCbjYwy1hceZW
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the device tree schema for iio driver for Microchip
MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and
MCP47F(E/V)B(0/1/2)8 series of buffered voltage output Digital-to-Analog
Converters with nonvolatile or volatile memory and an I2C Interface.

The families support up to 8 output channels.

The devices can be 8-bit, 10-bit and 12-bit.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 302 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 308 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2d7954423fa35a49ee2be0c225e59582e0fa9f7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -0,0 +1,302 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/microchip,mcp47feb02.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP47F(E/V)B(0/1/2)(1/2/4/8) DAC with I2C Interface Families
+
+maintainers:
+  - Ariana Lazar <ariana.lazar@microchip.com>
+
+description: |
+  Datasheet for MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
+  MCP47FEB22 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
+  Datasheet for MCP47FVBXX can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
+  Datasheet for MCP47FEB04, MCP47FEB14, MCP47FEB24, MCP47FEB08, MCP47FEB18,
+  MCP47FEB28, MCP47FVB04, MCP47FVB14, MCP47FVB24, MCP47FVB08, MCP47FVB18,
+  MCP47FVB28 can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
+
+  +------------+--------------+-------------+-------------+------------+
+  | Device     |  Resolution  |   Channels  | Vref number | Memory     |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FEB01 |     8-bit    |      1      |      1      |   EEPROM   |
+  | MCP47FEB11 |    10-bit    |      1      |      1      |   EEPROM   |
+  | MCP47FEB21 |    12-bit    |      1      |      1      |   EEPROM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FEB02 |     8-bit    |      2      |      1      |   EEPROM   |
+  | MCP47FEB12 |    10-bit    |      2      |      1      |   EEPROM   |
+  | MCP47FEB22 |    12-bit    |      2      |      1      |   EEPROM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FVB01 |     8-bit    |      1      |      1      |      RAM   |
+  | MCP47FVB11 |    10-bit    |      1      |      1      |      RAM   |
+  | MCP47FVB21 |    12-bit    |      1      |      1      |      RAM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FVB02 |     8-bit    |      2      |      1      |      RAM   |
+  | MCP47FVB12 |    10-bit    |      2      |      1      |      RAM   |
+  | MCP47FVB22 |    12-bit    |      2      |      1      |      RAM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FVB04 |     8-bit    |      4      |      2      |      RAM   |
+  | MCP47FVB14 |    10-bit    |      4      |      2      |      RAM   |
+  | MCP47FVB24 |    12-bit    |      4      |      2      |      RAM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FVB08 |     8-bit    |      8      |      2      |      RAM   |
+  | MCP47FVB18 |    10-bit    |      8      |      2      |      RAM   |
+  | MCP47FVB28 |    12-bit    |      8      |      2      |      RAM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FEB04 |     8-bit    |      4      |      2      |   EEPROM   |
+  | MCP47FEB14 |    10-bit    |      4      |      2      |   EEPROM   |
+  | MCP47FEB24 |    12-bit    |      4      |      2      |   EEPROM   |
+  |------------|--------------|-------------|-------------|------------|
+  | MCP47FEB08 |     8-bit    |      8      |      2      |   EEPROM   |
+  | MCP47FEB18 |    10-bit    |      8      |      2      |   EEPROM   |
+  | MCP47FEB28 |    12-bit    |      8      |      2      |   EEPROM   |
+  +------------+--------------+-------------+-------------+------------+
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp47feb01
+      - microchip,mcp47feb11
+      - microchip,mcp47feb21
+      - microchip,mcp47feb02
+      - microchip,mcp47feb12
+      - microchip,mcp47feb22
+      - microchip,mcp47fvb01
+      - microchip,mcp47fvb11
+      - microchip,mcp47fvb21
+      - microchip,mcp47fvb02
+      - microchip,mcp47fvb12
+      - microchip,mcp47fvb22
+      - microchip,mcp47fvb04
+      - microchip,mcp47fvb14
+      - microchip,mcp47fvb24
+      - microchip,mcp47fvb08
+      - microchip,mcp47fvb18
+      - microchip,mcp47fvb28
+      - microchip,mcp47feb04
+      - microchip,mcp47feb14
+      - microchip,mcp47feb24
+      - microchip,mcp47feb08
+      - microchip,mcp47feb18
+      - microchip,mcp47feb28
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
+  vdd-supply:
+    description:
+      Provides power to the chip and it could be used as reference voltage. The
+      voltage is used to calculate scale. For parts without EEPROM at powerup
+      this will be the selected as voltage reference.
+
+  vref-supply:
+    description: |
+      Vref pin (it could be found as Vref0 into the datasheet) may be used as a
+      voltage reference when this supply is specified. The internal reference
+      will be taken into account for voltage reference besides VDD if this supply
+      does not exist.
+
+      This supply will be voltage reference or the following outputs:
+        - for single-channel device: Vout0;
+        - for dual-channel device: Vout0, Vout1;
+        - for quad-channel device: Vout0, Vout2;
+        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
+
+  vref1-supply:
+    description: |
+      Vref pin (it could be found as Vref0 into the datasheet) may be used as a
+      voltage reference when this supply is specified. The internal reference
+      will be taken into account for voltage reference beside VDD if this supply
+      does not exist.
+
+      This supply will be voltage reference for the following outputs:
+        - for quad-channel device: Vout1, Vout3;
+        - for octal-channel device: Vout1, Vout3, Vout5, Vout7;
+
+  lat-gpios:
+    description:
+      LAT pin to be used as a hardware trigger to synchronously update the DAC
+      channels. The pin is active Low. It could be also found as lat0 in
+      datasheet.
+    maxItems: 1
+
+  lat1-gpios:
+    description:
+      LAT1 pin to be used as a hardware trigger to synchronously update the odd
+      DAC channels on devices with 4 and 8 channels. The pin is active Low.
+    maxItems: 1
+
+  microchip,vref-buffered:
+    type: boolean
+    description:
+      Enable buffering of the external Vref/Vref0 pin in cases where the
+      external reference voltage does not have sufficient current capability in
+      order not to drop it’s voltage when connected to the internal resistor
+      ladder circuit.
+
+  microchip,vref1-buffered:
+    type: boolean
+    description:
+      Enable buffering of the external Vref1 pin in cases where the external
+      reference voltage does not have sufficient current capability in order not
+      to drop it’s voltage when connected to the internal resistor ladder
+      circuit.
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: dac.yaml
+    type: object
+    description: Voltage output channel.
+
+    properties:
+      reg:
+        description: The channel number.
+        minItems: 1
+        maxItems: 8
+
+      label:
+        description: Unique name to identify which channel this is.
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
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
+              - microchip,mcp47feb01
+              - microchip,mcp47feb11
+              - microchip,mcp47feb21
+              - microchip,mcp47fvb01
+              - microchip,mcp47fvb11
+              - microchip,mcp47fvb21
+    then:
+      properties:
+        lat1-gpios: false
+        vref1-supply: false
+        microchip,vref1-buffered: false
+        channel@0:
+          properties:
+            reg:
+              const: 0
+      patternProperties:
+        "^channel@[1-7]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp47feb02
+              - microchip,mcp47feb12
+              - microchip,mcp47feb22
+              - microchip,mcp47fvb02
+              - microchip,mcp47fvb12
+              - microchip,mcp47fvb22
+    then:
+      properties:
+        lat1-gpios: false
+        vref1-supply: false
+        microchip,vref1-buffered: false
+      patternProperties:
+        "^channel@[0-1]$":
+          properties:
+            reg:
+              enum: [0, 1]
+        "^channel@[2-7]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp47fvb04
+              - microchip,mcp47fvb14
+              - microchip,mcp47fvb24
+              - microchip,mcp47feb04
+              - microchip,mcp47feb14
+              - microchip,mcp47feb24
+    then:
+      patternProperties:
+        "^channel@[0-3]$":
+          properties:
+            reg:
+              enum: [0, 1, 2, 3]
+        "^channel@[4-7]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp47fvb08
+              - microchip,mcp47fvb18
+              - microchip,mcp47fvb28
+              - microchip,mcp47feb08
+              - microchip,mcp47feb18
+              - microchip,mcp47feb28
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              enum: [0, 1, 2, 3, 4, 5, 6, 7]
+  - if:
+      not:
+        required:
+          - vref-supply
+    then:
+      properties:
+        microchip,vref-buffered: false
+  - if:
+      not:
+        required:
+          - vref1-supply
+    then:
+      properties:
+        microchip,vref1-buffered: false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+          compatible = "microchip,mcp47feb02";
+          reg = <0>;
+          vdd-supply = <&vdac_vdd>;
+          vref-supply = <&vref_reg>;
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+          channel@0 {
+            reg = <0>;
+            label = "Adjustable_voltage_ch0";
+          };
+
+          channel@1 {
+            reg = <0x1>;
+            label = "Adjustable_voltage_ch1";
+          };
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..6f51890cfc3081bc49c08fddc8af526c1ecc8d72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14938,6 +14938,12 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 F:	drivers/iio/potentiometer/mcp4018.c
 F:	drivers/iio/potentiometer/mcp4531.c
 
+MCP47FEB02 MICROCHIP DAC DRIVER
+M:	Ariana Lazar <ariana.lazar@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+
 MCP4821 DAC DRIVER
 M:	Anshul Dalal <anshulusr@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0


