Return-Path: <linux-iio+bounces-27470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3DCEFAC1
	for <lists+linux-iio@lfdr.de>; Sat, 03 Jan 2026 05:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77921301AD2F
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jan 2026 04:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851B2550AF;
	Sat,  3 Jan 2026 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="roM6X3u4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5F207A32;
	Sat,  3 Jan 2026 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767415448; cv=none; b=ICr0q/BCdmMc+IN7aWoeuT+IY4nUVX/njb2Ag+19GlK1bgf6RGIR718Z3kBFVUqY+HbEu5z/f7uqBeK4nqqAOo3hb/Xr5GAH0p//LAJBaJ/KB6chSau2x2HdiLktkTdLUsqpQyC7l5CzRSN4ugQyZ67GSoKMfwLdJh/Jgt564g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767415448; c=relaxed/simple;
	bh=m1OtNMscmh345BXI/zxxN+81cxehbLguw/llaEts5kY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aCPpmOc/3jPnOT9IaMJAqOIpjKGh/VgcNglW16s0a/2jf/uNL5IPe+sVA00woLm1vtuW1Oz3Xbfa1vlnDci1twU2fXMzzFzr+r1uq6ZbJKaML7psHhrX7O3r8+4WpB+CdNqE/MuUMiZj/4MBo20tK6Pg3HPdfMihUD266jpykG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=roM6X3u4; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:710:a300:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 9666E16020A;
	Sat, 03 Jan 2026 06:35:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1767414955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZN65+jNLvSkRxJAGKRPmgTcRRddNL3zW+6k5CQ60ov8=;
	b=roM6X3u4fRW5U22EsLlk1Ya6xfcwVkWFZKeA7Ru3XNJbRgWvPeIYmsUGPmOimSkk+etEdT
	73bnzIRVtiw6j3QsUF9yy+9YVBRdNm7Azb8NHufSR6TfxjOm41XsVDusI+j/iH/t1DXTkv
	XyD9czGv9cP51pn7DC5oza1QyOLpPpzpt/kFGLeODE91A8TxPT/oCM/2YEgAFdP0CJ7xtB
	80EnJg6JSUFeM6AHSxrkA459CjI28h1kZUZoj/pTYWrgLczHd0uGbTkK6IsTqZgiBZr3Gx
	ilAOxUondK+wrW/sSAeHJ3+aP4BuJfyEhstq2XV9aHljZazsAuD19xE1P/jUzg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 03 Jan 2026 06:35:16 +0200
Subject: [PATCH v5 1/2] dt-bindings: iio: pressure: add honeywell,abp2030pa
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260103-honeywell_abp2_driver-v5-1-0435afcf306d@subdimension.ro>
References: <20260103-honeywell_abp2_driver-v5-0-0435afcf306d@subdimension.ro>
In-Reply-To: <20260103-honeywell_abp2_driver-v5-0-0435afcf306d@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5941;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=m1OtNMscmh345BXI/zxxN+81cxehbLguw/llaEts5kY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2xZbktTL2U5eGxJM2hZUi92Y1lOaGdOMHFECi9WWWsraHFLc3hwQTFqdllG
 eWVpUDRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcFdKeWt
 BQW9KRUhRcko2ZGpPa2xqS29JUUFLUDhUakF0cmc4RFJac0hxb0d3NGxGcEErWFh4TmxVeEZTdg
 pJWnprLzR4a2hMOHhVejFEWmRTMW9BMWVSUmZQdjBWaEx3bHpFN3RaU3J0bjFuRXNSbnZwUmtBT
 UpjZk1FQTJpCnlLM0U3aTdDQmNncWJjaURTWDU3bWJibk1qNkxIN0hkS3M0THF2Z3ZyWGo3blRD
 NzE0T2dRUmdIMlgwMkN3azUKN09NRWlSOEFDZTBpcFpGM1V2Y1pQa1VsRE9FeVU0RnVLaU9xTWY
 3MmlDMG5neEdnalFkTnFOV25uc1k1bXMycQpUVmlXRy81eHNVMWpqbFZIL0dBcUFkdXU2bDc2Sk
 FKN0tDa1JjcjNXZ3h0cnBKMjdnMHhGUU0zN3lnZ3lUWkUrCjhVZ1IvVXZEcjBrME5vZ2YvT0lkY
 kZZSFVCSll4dGR1N2VGaythcm5iRmY0RnhIaFRlQ0NrTUtyWkUydENhVW8KWHorT2VGTFloU0Ir
 dHhWK084d0ViQ0FUNGkrMVFpS2xodVl1S3BpdGVFQ0FIaXIvcXNIYTJ2Q2RXbkh5K3QreQpWOE1
 wVTR2em5MNGpqQ3NOKzF3ZjQzSWNlS0RkcURQamdhbFVmeUl2MXVFV29Zd3M5Y2FBUmJRMncvaX
 J2TGRCCjFwd3d5QkdCclJITC9Kd0NMbkhhYnJYRnFNQmpHSTkweHVLemxpbDhKZ3RVN3dlVU1rU
 2ZBTG0xWnRFcFQwSVQKMTZlUDdMTiswelZBWDNicUJ2cHl0WGRNbVpZVmtwbFpzUGY1QTQ0ZTBr
 dUVWeHJOWWg3QlErdFhtZitHN2pvUAowVGNRZzJNdkVXZ1owWHRISkRSdWgxM25YTFpPRWxkYUE
 2bUZBMWRMRStoRDB5UUtaUlROVGx0NTByOFVzdTRmCloxYnh6M3YrZlJFWWlBPT0KPUlkeU8KLS
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
    v1->v3 unchanged
    v3->v4 'vdd-supply: true' change requested by Jonathan
---
 .../bindings/iio/pressure/honeywell,abp2030pa.yaml | 132 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 138 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml
new file mode 100644
index 000000000000..e82897ffac3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml
@@ -0,0 +1,132 @@
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
+  vdd-supply: true
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
2.51.2


