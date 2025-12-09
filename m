Return-Path: <linux-iio+bounces-26979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2530CB0C35
	for <lists+linux-iio@lfdr.de>; Tue, 09 Dec 2025 18:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C100C30D686B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Dec 2025 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6F32ABDB;
	Tue,  9 Dec 2025 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KzP5o8p8"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586332E15B;
	Tue,  9 Dec 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765302176; cv=none; b=RgPtcNNEftTAHvQzuIBZyq5ZEwBPeVsC8Av7vPZTzl+xD7A7LcXNDpiicoGPQnn/E0reZM99B+SeLSk/zNy6xOQ7gAFmEKMntMlY5PlbAZjrKmnDE4DchrVyWbgZK8/aYXVypSJ+nXQ+XJvvHCv1M7CFTOOS9NUAAd7wpkm0O5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765302176; c=relaxed/simple;
	bh=t/b15A41qprKSaWdxOKVWIGNKr5jAWI1VdWCUdw4uCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T4YO5htnpvbQtc8CY/lz5O0aVQQ9TFFG8oaUZg9i4LbuG67RN70oVEFK0mOLzuBCA5qoHGU6xMBq1j7qGvk0P+XYYztkdpDAJjcj6oGaF+dTVIACN6rqpC73vyjvIKPAlnQCCOMBcECozyN45zKKijB9vcp5Kka/COwLQ8x5kAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KzP5o8p8; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1765302174; x=1796838174;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t/b15A41qprKSaWdxOKVWIGNKr5jAWI1VdWCUdw4uCQ=;
  b=KzP5o8p8f386sIYV6c3KYa6bYWCXCEHm2OFliLQtqvxSbtRFiG3wzT9y
   Jmi9hnW4wjYdmJj4/pqPcI4XIIDPLZYdKt6WLsidMo+2slDez+PaJmguI
   5jdu45LJP8SweBx3ZemM+C2e5V8LBcPq8GPOaFn11JjjYQVxpYvcJpCW5
   V2f/Nq+KiTxY6HL8Ikui3VM1brocr/jqbI2LkFVMP0VPbyR6yRgfWxTwc
   8znMFbs+GdW71NfZ5gy32eU1piroNACslaAFPMbO3yl64YhTpTQC1Po6w
   XRtppAbThdlkF5VIh16nbS65G501b9sHIfNnP6S0d9yHiK13++bimK/3S
   w==;
X-CSE-ConnectionGUID: 8oOcSEMwQtaDFol/doV2Vw==
X-CSE-MsgGUID: laLMmcPxSGurLij7RFREPg==
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="217617376"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 10:42:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 9 Dec 2025 10:42:37 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 9 Dec 2025 10:42:34 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Tue, 9 Dec 2025 18:06:23 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: adding support for Microchip
 MCP47FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251209-mcp47feb02-v3-1-bb0ba9052f4f@microchip.com>
References: <20251209-mcp47feb02-v3-0-bb0ba9052f4f@microchip.com>
In-Reply-To: <20251209-mcp47feb02-v3-0-bb0ba9052f4f@microchip.com>
To: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765296389; l=12407;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=t/b15A41qprKSaWdxOKVWIGNKr5jAWI1VdWCUdw4uCQ=;
 b=eGN3UUSi49P6bxHqd+2+gqDC6vTqiz/iODtC0P2eGKSscr3nfECiIgxNcQ7TQcAc9WlU0iV0X
 QF3S3mA+Xk3ACzoB4WReJ/9l996XdZkI1F8WasHLh0VHMJ+3kuoQg04
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the device tree schema for iio driver for Microchip
MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and
MCP47F(E/V)B(0/1/2)8 series of buffered voltage output Digital-to-Analog
Converters with nonvolatile or volatile memory and an I2C Interface.

The families support up to 8 output channels.

The devices can be 8-bit, 10-bit and 12-bit.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 302 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 308 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d2466aa6bda2106a8b695347a0edf38462294d03
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
+  Datasheet for MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02, MCP47FVB12,
+  MCP47FVB22 can be found here:
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
+      This supply will be voltage reference for the following outputs:
+        - for single-channel device: Vout0;
+        - for dual-channel device: Vout0, Vout1;
+        - for quad-channel device: Vout0, Vout2;
+        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
+
+  vref1-supply:
+    description: |
+      Vref1 pin may be used as a voltage reference when this supply is specified.
+      The internal reference will be taken into account for voltage reference
+      beside VDD if this supply does not exist.
+
+      This supply will be voltage reference for the following outputs:
+        - for quad-channel device: Vout1, Vout3;
+        - for octal-channel device: Vout1, Vout3, Vout5, Vout7;
+
+  lat-gpios:
+    description:
+      LAT pin to be used as a hardware trigger to synchronously update the DAC
+      channels. The pin is active Low. It could be also found as LAT0 in
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


