Return-Path: <linux-iio+bounces-26527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718BFC90B7E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 04:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DD3A710C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785912BE65F;
	Fri, 28 Nov 2025 03:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="PoOd7hmO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB227E7F0;
	Fri, 28 Nov 2025 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764299640; cv=none; b=Jbo4q8Eo0/s2ln9FV5lEKPn3ETzqEJJZeliahcAmmiXXe2dWVnpv5CHIgE048QHd7xqG/0vIc0N66NkaU2MCfXiTH+PbLl3xhWGg+sa+wKNhJA7Fc6qFmkyfrNnF+qkSvpZHvJSTvgd5wkGOHDjsqBSfDKos0WFSZ3d2duS7zzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764299640; c=relaxed/simple;
	bh=8T/9Cs0/ak+fTfxza5H/0jFjKpC7hE17bPkqIsZm+cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJmR7qzh2MUrZWglHsXLfuHzGsGNoOkFBEPTiCejhxffTc53IZAiqekq1MhYuECibA7xiptl5t+LTAyEbQyX5tafrczHkKf7OGDyqUFUR3QCNxA0itKZDO75jAGoJwtN2DvdivP0Hjom3x/vM82fcnGYrRk1RpO9e5MoiN5IK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=PoOd7hmO; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 27AB416020A;
	Fri, 28 Nov 2025 05:13:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1764299635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUMvhw3Yrl3BOOsNMul6PT9KsxD7XnHx4PeGl4+PTw4=;
	b=PoOd7hmOhmfrSPw5qx6i7uYidFfSovS6IyXvu69hx7IADbWjpPx4OpVReI+obIX4+OHqQF
	oCu+TFPRurWsnZoGMU9huDuwwoz4GcvZlf086ZNUuwmG/OjziJRCUaXkocZbGhnZS/TfxK
	8VSuUNJWTgbYPwv3fWkiV6rno0/u9qVbya1lUddUgQevuMrvbN3FVwNSO7GS9ahpVMQYNS
	zfYQ5f7awOSswGqNsuMPUk0wpvznvQd6VJ1OCVSc2UtdEkfzrpCOcr0OwRiDfIO/PTjCkv
	JGLgf7XYOUoT9amP99LkKOvNYjddZWl200spwOt2lwZfuy7DFx6xiyrWB6W5yA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Fri, 28 Nov 2025 05:13:26 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,abp2030pa
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-honeywell_abp2_driver-v2-1-7053748aecf7@subdimension.ro>
References: <20251128-honeywell_abp2_driver-v2-0-7053748aecf7@subdimension.ro>
In-Reply-To: <20251128-honeywell_abp2_driver-v2-0-7053748aecf7@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5901;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=8T/9Cs0/ak+fTfxza5H/0jFjKpC7hE17bPkqIsZm+cg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2twRTI1TXh6YlAwTEhMWjBVM0VkNnRPQWdoCloyYjV5eC9iS3ZtM0x1NWdH
 aUgvQVlrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcEtSTnV
 BQW9KRUhRcko2ZGpPa2xqQjdvUUFLSzVvZU5LMVZlOGtIWU5VV0xLbEFjOFQyK0ZiUzJSdXBpYQ
 pwL0FnQ3Vsek1MenZDUXJRUytDTDF2S2hDNVdvdjRPYjF5elN0amd1ZW54Mk9uWjdJWlNWSjFQe
 kxSanJQYTdmCjl0OWtCTk1YWDl0bmsyK3JqcC9lZlNHZXhCN214YVRvUHFGWFVBRlFNMkpKSE5z
 TGtMZFhaaWw1ZjNmVjVMZloKUVNaRmJydmllSk9tRytaZGFKOXdKeGpEY3hzZjN0Z0dSSzc0NTV
 zRVB0aFBPMks5amNmK0srM1lGTzJQd0xocAp5T3M3NWwxYjRLSGE1NWRGVHM4OElUWW41NWpUOT
 Qyak9kSmd1eWE3UlozQ09ucG9STURMYWh6aHdvcElMeXBPCnBkZDlnQUNKRGNLQWNRaVN1VHVEN
 UtzOTlXQXpNaTgwcHd0Nk10dzZOanpSQVMwZDFtUXZnTXlLTHIrYUlHLzkKM2JGSWFnc1YwcTk2
 bUw2RFV0WXgrQStINXFVNjJReU83SGhhVmdVV1FuWXFVWVowZTFmQk1HSm51b2V0Q2lXZwpFbEt
 tR1IyaUx5Rlp3SExUb1hOdVNHUEdBa2taL0tkMUVibTRVWUxyM1B5dmFzL2JhL1V1QkhCWEU4YU
 pjTndtClZUc0RvWUpPdjV6aDZVdFVTNGM4M3ovRGYrbjVST1hELytBb1JLSFgxZStiMTVKUGpWV
 SswZlVHeEkwZlZmcW4KTDhBQkZLcjRDRkNzaWdGbnZqclN3eEg0SksxMmE1d0VMeDFxUmJjeXF4
 T3BTdUxUcnNqb0pxTWY2b0phK0NKawp1cDBNQm1YOUJpSkVFNEhwZ0trbVdVaDlqRkhxRmhDb3N
 RTU9UUE1TM3VCMFdRV3E4TzFhM1F5RjVDOER5NVIvCnNybUxpeEI5ekdJZHdRPT0KPXhTUisKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Adds binding for digital Honeywell ABP2 series pressure and temperature
sensors.
The i2c address is hardcoded and depends on the part number.
There is an optional interrupt that signals the end of conversion.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 .../bindings/iio/pressure/honeywell,abp2030pa.yaml | 133 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 139 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml
new file mode 100644
index 000000000000..8da39ee43dbc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/honeywell,abp2030pa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell abp2030pa pressure sensor
+
+maintainers:
+  - Petre Rodan <petre.rodan@subdimension.ro>
+
+description: |
+  Honeywell pressure sensor of model abp2030pa.
+
+  This sensor has an I2C and SPI interface.
+
+  There are many models with different pressure ranges available. The vendor
+  calls them "ABP2 series". All of them have an identical programming model and
+  differ in the pressure range and measurement unit.
+
+  To support different models one needs to specify its pressure triplet.
+
+  For custom silicon chips not covered by the Honeywell ABP2 series datasheet,
+  the pressure values can be specified manually via honeywell,pmin-pascal and
+  honeywell,pmax-pascal.
+
+  Specifications about the devices can be found at:
+  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
+
+properties:
+  compatible:
+    const: honeywell,abp2030pa
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Optional interrupt for indicating end of conversion.
+      SPI variants of ABP2 chips do not provide this feature.
+    maxItems: 1
+
+  honeywell,pressure-triplet:
+    description: |
+      Case-sensitive five character string that defines pressure range, unit
+      and type as part of the device nomenclature. In the unlikely case of a
+      custom chip, unset and provide pmin-pascal and pmax-pascal instead.
+    enum: [001BA, 1.6BA, 2.5BA, 004BA, 006BA, 008BA, 010BA, 012BA, 001BD,
+           1.6BD, 2.5BD, 004BD, 001BG, 1.6BG, 2.5BG, 004BG, 006BG, 008BG,
+           010BG, 012BG, 001GG, 1.2GG, 100KA, 160KA, 250KA, 001KD, 1.6KD,
+           2.5KD, 004KD, 006KD, 010KD, 016KD, 025KD, 040KD, 060KD, 100KD,
+           160KD, 250KD, 400KD, 001KG, 1.6KG, 2.5KG, 004KG, 006KG, 010KG,
+           016KG, 025KG, 040KG, 060KG, 100KG, 160KG, 250KG, 400KG, 600KG,
+           800KG, 250LD, 600LD, 600LG, 2.5MD, 006MD, 010MD, 016MD, 025MD,
+           040MD, 060MD, 100MD, 160MD, 250MD, 400MD, 600MD, 006MG, 010MG,
+           016MG, 025MG, 040MG, 060MG, 100MG, 160MG, 250MG, 400MG, 600MG,
+           001ND, 002ND, 004ND, 005ND, 010ND, 020ND, 030ND, 002NG, 004NG,
+           005NG, 010NG, 020NG, 030NG, 015PA, 030PA, 060PA, 100PA, 150PA,
+           175PA, 001PD, 005PD, 015PD, 030PD, 060PD, 001PG, 005PG, 015PG,
+           030PG, 060PG, 100PG, 150PG, 175PG]
+    $ref: /schemas/types.yaml#/definitions/string
+
+  honeywell,pmin-pascal:
+    description:
+      Minimum pressure value the sensor can measure in pascal.
+
+  honeywell,pmax-pascal:
+    description:
+      Maximum pressure value the sensor can measure in pascal.
+
+  spi-max-frequency:
+    maximum: 800000
+
+  vdd-supply:
+    description: provide VDD power to the sensor.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+oneOf:
+  - required:
+      - honeywell,pressure-triplet
+  - required:
+      - honeywell,pmin-pascal
+      - honeywell,pmax-pascal
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+  - if:
+      required:
+        - honeywell,pressure-triplet
+    then:
+      properties:
+        honeywell,pmin-pascal: false
+        honeywell,pmax-pascal: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@18 {
+            compatible = "honeywell,abp2030pa";
+            reg = <0x18>;
+            interrupt-parent = <&gpio3>;
+            interrupts = <21 IRQ_TYPE_EDGE_RISING>;
+
+            honeywell,pressure-triplet = "001BA";
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@0 {
+            compatible = "honeywell,abp2030pa";
+            reg = <0>;
+            spi-max-frequency = <800000>;
+
+            honeywell,pressure-triplet = "001PD";
+            vdd-supply = <&vcc_3v3>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 31d98efb1ad1..15b92300acbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11404,6 +11404,12 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HONEYWELL ABP2030PA PRESSURE SENSOR SERIES IIO DRIVER
+M:	Petre Rodan <petre.rodan@subdimension.ro>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml
+
 HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org

-- 
2.51.0


