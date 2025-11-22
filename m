Return-Path: <linux-iio+bounces-26393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489DFC7D836
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 22:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6743A9242
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637942C3261;
	Sat, 22 Nov 2025 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="mAeg95KB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324926F2BD;
	Sat, 22 Nov 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763848306; cv=none; b=X87FJWACWiEld3n+zZAM6L7JJ/m00jbG4GF2s9VO44EBsriRZ6tq+BcGtlTo34hpvrgl5cDd7dmJWUP6R/enVP/guc75ABd2oQlhfBCYRU6QToU0+Al7NcTFptbp9vyZwnrpe+QQTaBK2cQ70ftHKYRDkVmANdLjYNXqYPPzhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763848306; c=relaxed/simple;
	bh=GoKvhWNHoitmkUPZicUIxirWCAJ40B92OLKWtc13CVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trAmVOskawP8ncGkIQNNQ/a2TO2+fw/va7TFKsSwMCt0cOVACAvKHr4Ydj1twi8aiR6XqTMBhWYRnCsbRWDx7PTj14SWmZA96eRqixOfzdndje/Za3lojRrG77XXftzDG6OSfbZrKRrGpNwvmJHEjjW8rTtYTkU8m5c1F8KvGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=mAeg95KB; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 7FD4F16020A;
	Sat, 22 Nov 2025 23:42:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1763847776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjMlT91+pOcsYtocb/J9ghMNCQan9Jt2Iu8Ebm+XWTU=;
	b=mAeg95KBZbby4ADB4LNMuDQxriW4weDYgU0iZD4ePwYVch4vOpunYVlcoQFBLuPPTXbeNi
	36Q5mu6xndait6xvqz+z7zP6W5LkJ3pNmnsEAUzYC5LYiWexdL67TeCJHdCTTSy6f7g5/K
	qon77ZFrBsp2qUdGbOJt8V+23NEz2gB2JiSoCFFu1sjAwhqWxyeqIgLsTWVz5cJVDRayX0
	PiNv/aTJ3+xahAMgoHd1povVUMwFF+LmrztwMvVHWiuYNk9Zg6sbpnYJ4z854M9ahPzXvk
	3i91VjwJvHK96Zc8N2hNg1HkVOiAPJPjWJasc5pmW8+qnIG671VDH2H5a1tboA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 22 Nov 2025 23:42:44 +0200
Subject: [PATCH 1/2] dt-bindings: iio: pressure: add honeywell,abp2030pa
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251122-honeywell_abp2_driver-v1-1-7a8e265f9627@subdimension.ro>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
In-Reply-To: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5854;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=GoKvhWNHoitmkUPZicUIxirWCAJ40B92OLKWtc13CVo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2tpTGwyQmp1L1FxMjdJNHJoOW82ZmpFdHlVCk9mQWtTdEE5OTlCWnpmVDMx
 Z2xjdTRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcElpNWR
 BQW9KRUhRcko2ZGpPa2xqSzJjUC8xc2JHZnpnTVlhZyt0YlRUSWExcWsrZTVabEFnYjRFNE82MQ
 pSb2tlVWllOTFzd0lxd3RBZkYvcUdBa0hMbjlnK0lWWE1ZZWg5V3U5eXZWUlY0N3lwcWN6RkRDO
 WFBZEp2UVN0Ckd6LzBEWEllS3A5TFVQZklrN0g5Ymk1cWxkaEdXK1ZUQjFwc1hoYXk4LytURERS
 TG9JQ3lTR0syUUNaOExHQmkKejd3TnpzQmFwMERVMFRKWWVTTVcrZFFDeG52WDg1VXJhaHlTU0V
 HK2N3OUphS1pvSllqbUNYeFoxdlJyOGtmdApnMCtYQ0xmb2tFUmhIWkhOcUdUQjllODRBdlQvbH
 MxUGVTbnFoUHUxdExBQkNjTWRSSlczYWhCcG9hL1lvQ3h6CjMySUFIcG9oSk5JUEE4cC9Ma042T
 UU3dE93UnJFbk4wMmNHREcxZkRoWWR4T2NCdWpHS3ZuVWNCTmIrRjVaMW0KS0ZHSXFVT3BjeGww
 a0tHSHZWMjYwcFRWNytvNzRMMVBYSWNWRk15ZEY2dHJNcmVqR2VyeXhpaTNhaDFGVEFOOAp5RFd
 OejB5QTIvdUdMcmJIMlRCalpsMm5QWFZZQlVwRkFneERlV1RsSktIbzhkNmx5RDY4NGNKa0JURy
 9zYjRpCitmKzJndVkyYTN3b2NYNDFWeG0wNTYySVhMK3RuaUI3N3hrL1JxYVVQd3o5blRpME4wZ
 Fl1V1YxVU9EdlRUVE0KR1ZJYlpNTUdkQW1iVUVtSHU0ZS9Eb0NCdnUwRnJhUVluSmJXdkx6ZWVY
 WjM3Znp0OUw4S1pqSDVuQm92eGZLTApmQjBTQjlYbE00Z0NoandMV1FRYzZWRWtKa25RZDZrODl
 5THd4UnZ4ZU04eFd4OSt6KzNZbnVGRGFtZDBJdWhYCk1EWTZmeEd5K3RJZ2dnPT0KPWlyVE8KLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Adds binding for digital Honeywell ABP2 series pressure and temperature
sensors.
The i2c address is hardcoded and depends on the part number.
There is an optional GPIO interrupt that signals the end of conversion.

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


