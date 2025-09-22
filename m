Return-Path: <linux-iio+bounces-24349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A482CB90658
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD40420489
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA230B50C;
	Mon, 22 Sep 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mS0GJpfi"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6058309F12;
	Mon, 22 Sep 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540694; cv=none; b=eQncZ77ujad1Egy6sBN3fM1Onu1rBQr8Aes6XqCDtt5kp+/n/KL0SoFLTWQEeFpXoNogC5ergSJ38av5smxik5FQrsNjRM9rraHYcWublzz5zPeD5Td9ZaHLK94PSG/m9259qAiKSsKleXXmUYQmQcWo1uHk/CY9X4ltJ04AExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540694; c=relaxed/simple;
	bh=7/Nf8DE5ABhe8oj1LCtQtX5e9ThT8oP4gyQTH3FnxOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iPiX3kqXsZrI1zCqvroACHkaT5lpJ4hHK5XxZe+7NoPj2RinEFQNh4RDOuSc68QljKIXF/e1/YfeSFyES8gAhHFpoiLFrTVkA20Lm72lKSgPLU/mtFKNoD7pz1mr/YkCr54ADUaddZ7PvHbhKuzUK5wW6O76ctqi0LiRLV/gQS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mS0GJpfi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758540691; x=1790076691;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7/Nf8DE5ABhe8oj1LCtQtX5e9ThT8oP4gyQTH3FnxOM=;
  b=mS0GJpfi6OhoL1NaMJbdoW08JKpdKMennXzH9eWiB5pXePDl8EKtjjIT
   Stjp8H4WM5Q5d1Z+o3ENIHV6M6G66elY+hmTI09p3mAokNG2JEogdgG1h
   uyGVyRln+0K2Tj0FZWMBHFACFNGexAQ20UEC1Qfk6qyWvjlOSIqLYmcI0
   BmU4ID0OqVJi35JK5gNRLBqtC6ZLVdCotmLDmBNDOlk/EHD5+/Og5ZJCR
   YWxQph1p20gN+nLkard7rqIpGpzjF2Zu/NRYyaB6o0EdG6y3qxBNikxJ2
   dzX6E2mNbOhFWxglZBUfSPV8zN2pLNJgZzaxHYlTr4c9IToOf4rFAWp3+
   g==;
X-CSE-ConnectionGUID: ItnTgdDQT3CQ6aHeJ/KMMA==
X-CSE-MsgGUID: mJ2s7g+hScu5epyJ7ccCiw==
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="46230243"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2025 04:31:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 04:31:06 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 22 Sep 2025 04:31:04 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Mon, 22 Sep 2025 14:30:53 +0300
Subject: [PATCH 1/2] dt-bindings: iio: dac: adding support for Microchip
 MCP47FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250922-mcp47feb02-v1-1-06cb4acaa347@microchip.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
In-Reply-To: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758540660; l=12283;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=7/Nf8DE5ABhe8oj1LCtQtX5e9ThT8oP4gyQTH3FnxOM=;
 b=9JlmVjpEYBuFOAjfTWIb+7Y34oHN0uwHMEIrtBntQEoFmpyshoiIaW3TwhXwegUYcSKyVSOzv
 5HYUyakNkcDAP6IbRsAYUHd4xGIjPuW3qth4vn+fo0eKBN++wyisHAL
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
 .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 305 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 311 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d05ddafa37540bc1f6b6ce65a466b95913925c10
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -0,0 +1,305 @@
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
+    description: |
+      Provides power and it will be used as the reference voltage if vref-supply
+      is not provided.
+
+  vref-supply:
+    description: |
+      Vref pin is used as a voltage reference when this supply is specified.
+      Into the datasheet it could be found as a Vref0.
+      If it does not exists the internal reference will be used.
+      This will be used as a reference voltage for the following outputs:
+        - for single-channel device: Vout0;
+        - for dual-channel device: Vout0, Vout1;
+        - for quad-channel device: Vout0, Vout2;
+        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
+
+  vref1-supply:
+    description: |
+      Vref1 pin is used as a voltage reference when this supply is specified.
+      If it does not exists the internal reference will be used.
+      This will be used as a reference voltage for the following outputs:
+        - for quad-channel device: Vout1, Vout3;
+        - for octal-channel device: Vout1, Vout3, Vout5, Vout7;
+
+  lat-gpios:
+    description: |
+      LAT pin to be used as a hardware trigger to synchronously update the DAC
+      channels and the pin is active Low. It could be also found as lat0 in
+      datasheet.
+    maxItems: 1
+
+  lat1-gpios:
+    description: |
+     LAT1 pin to be used as a hardware trigger to synchronously update the odd
+     DAC channels on devices with 4 and 8 channels. The pin is active Low.
+    maxItems: 1
+
+  microchip,vref-buffered:
+    type: boolean
+    description: |
+      Enable buffering of the external Vref/Vref0 pin in cases where the
+      external reference voltage does not have sufficient current capability in
+      order not to drop it’s voltage when connected to the internal resistor
+      ladder circuit.
+
+  microchip,vref1-buffered:
+    type: boolean
+    description: |
+      Enable buffering of the external Vref1 pin in cases where the external
+      reference voltage does not have sufficient current capability in order not
+      to drop it’s voltage when connected to the internal resistor ladder
+      circuit.
+
+  microchip,output-gain-2x:
+    type: boolean
+    description: |
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
+        minimum: 1
+        maximum: 7
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
+        lat-gpios: true
+        lat1-gpios: false
+        vref-supply: true
+        vref1-supply: false
+        microchip,vref-buffered: true
+        microchip,vref1-buffered: false
+      patternProperties:
+       "^channel@[1]$":
+        properties:
+         reg:
+          items:
+            maximum: 1
+        "^channel@[2-7]$": false
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
+        lat-gpios: true
+        lat1-gpios: false
+        vref-supply: true
+        vref1-supply: false
+        microchip,vref-buffered: true
+        microchip,vref1-buffered: false
+      patternProperties:
+       "^channel@[1-2]$":
+        properties:
+         reg:
+          items:
+            maximum: 1
+        "^channel@[3-7]$": false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,mcp47fvb04
+              - microchip,mcp47fvb14
+              - microchip,mcp47fvb24
+              - microchip,mcp47fvb08
+              - microchip,mcp47fvb18
+              - microchip,mcp47fvb28
+              - microchip,mcp47feb04
+              - microchip,mcp47feb14
+              - microchip,mcp47feb24
+              - microchip,mcp47feb08
+              - microchip,mcp47feb18
+              - microchip,mcp47feb28
+    then:
+      properties:
+        lat-gpios: true
+        lat1-gpios: true
+        vref-supply: true
+        vref1-supply: true
+        microchip,vref-buffered: true
+        microchip,vref1-buffered: true
+      patternProperties:
+       "^channel@[1-4]$":
+        properties:
+         reg:
+          items:
+            maximum: 1
+       "^channel@[5-7]$": false
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
+            label = "DAC_OUTPUT_0";
+          };
+
+          channel@1 {
+            reg = <0x1>;
+            label = "DAC_OUTPUT_1";
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


