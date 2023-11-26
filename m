Return-Path: <linux-iio+bounces-385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE97F921E
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 11:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16FBF2811D0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63318F78;
	Sun, 26 Nov 2023 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="RFpK01v5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1B0118;
	Sun, 26 Nov 2023 02:15:10 -0800 (PST)
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0017C28EE6F;
	Sun, 26 Nov 2023 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1700993708;
	bh=X1if6+dXyS4IOu9VJ6YZavnsWFjbh6L8Mr4n8bVqe0s=;
	h=From:To:Cc:Subject:Date;
	b=RFpK01v5J+7E48GWNUmJ0MOfGERXNkEfcB2+TG72WmLHDg/nRBPY11jExsQP/sdv8
	 JrUOZUnWZDeK/mzmq+e9lCeN2Jh6deUyBloVZUGBmGGY7ZdMIgB3s1F07DAG6jSUle
	 mMMJsWHt3ovYzUOlQ0TbHpuV1DIah5sk8KTJNhf8=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Date: Sun, 26 Nov 2023 12:14:38 +0200
Message-ID: <20231126101443.13880-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds binding for digital Honeywell TruStability HSC and SSC series
pressure and temperature sensors. 
Communication is one way. The sensor only requires 4 bytes worth of
clock signals on both i2c and spi in order to push the data out.
The i2c address is hardcoded and depends on the part number.
There is no additional GPIO control.

Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
Datasheet:
https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
V2: - fix yaml struct
    - cleanup based on Krzysztof's review
V3: - rename range_str -> honeywell,pressure-triplet to define the string
       containing the pressure range, measurement unit and type
    - honeywell,pmax-pascal becomes uint32 (Krzysztof)
    - pmin-pascal still needs type change to int32 
       for kpascal in the schema.
       be so kind and add 'pascal' as well since there are sensors with 
       a full scale span of mere 320 pascals with 14bits of precision.
---
 .../iio/pressure/honeywell,hsc030pa.yaml      | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
new file mode 100644
index 000000000000..47f7a8202847
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/honeywell,hsc030pa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Honeywell TruStability HSC and SSC pressure sensor series
+
+description: |
+  support for Honeywell TruStability HSC and SSC digital pressure sensor
+  series.
+
+  These sensors have either an I2C, an SPI or an analog interface. Only the
+  digital versions are supported by this driver.
+
+  There are 118 models with different pressure ranges available in each family.
+  The vendor calls them "HSC series" and "SSC series". All of them have an
+  identical programming model but differ in pressure range, unit and transfer
+  function.
+
+  To support different models one needs to specify the pressure range as well
+  as the transfer function. Pressure range can either be provided via
+  pressure-triplet (directly extracted from the part number) or in case it's
+  a custom chip via numerical range limits converted to pascals.
+
+  The transfer function defines the ranges of raw conversion values delivered
+  by the sensor. pmin-pascal and pmax-pascal corespond to the minimum and
+  maximum pressure that can be measured.
+
+  Please note that in case of an SPI-based sensor, the clock signal should not
+  exceed 800kHz and the MOSI signal is not required.
+
+  Specifications about the devices can be found at:
+  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
+  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
+
+maintainers:
+  - Petre Rodan <petre.rodan@subdimension.ro>
+
+properties:
+  compatible:
+    const: honeywell,hsc030pa
+
+  reg:
+    maxItems: 1
+
+  honeywell,transfer-function:
+    description: |
+      Transfer function which defines the range of valid values delivered by
+      the sensor.
+      0 - A, 10% to 90% of 2^14
+      1 - B, 5% to 95% of 2^14
+      2 - C, 5% to 85% of 2^14
+      3 - F, 4% to 94% of 2^14
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  honeywell,pressure-triplet:
+    description: |
+      Case-sensitive five character string that defines pressure range, unit
+      and type as part of the device nomenclature. In the unlikely case of a
+      custom chip, set to "NA" and provide pmin-pascal and pmax-pascal.
+    enum: [001BA, 1.6BA, 2.5BA, 004BA, 006BA, 010BA, 1.6MD, 2.5MD, 004MD,
+           006MD, 010MD, 016MD, 025MD, 040MD, 060MD, 100MD, 160MD, 250MD,
+           400MD, 600MD, 001BD, 1.6BD, 2.5BD, 004BD, 2.5MG, 004MG, 006MG,
+           010MG, 016MG, 025MG, 040MG, 060MG, 100MG, 160MG, 250MG, 400MG,
+           600MG, 001BG, 1.6BG, 2.5BG, 004BG, 006BG, 010BG, 100KA, 160KA,
+           250KA, 400KA, 600KA, 001GA, 160LD, 250LD, 400LD, 600LD, 001KD,
+           1.6KD, 2.5KD, 004KD, 006KD, 010KD, 016KD, 025KD, 040KD, 060KD,
+           100KD, 160KD, 250KD, 400KD, 250LG, 400LG, 600LG, 001KG, 1.6KG,
+           2.5KG, 004KG, 006KG, 010KG, 016KG, 025KG, 040KG, 060KG, 100KG,
+           160KG, 250KG, 400KG, 600KG, 001GG, 015PA, 030PA, 060PA, 100PA,
+           150PA, 0.5ND, 001ND, 002ND, 004ND, 005ND, 010ND, 020ND, 030ND,
+           001PD, 005PD, 015PD, 030PD, 060PD, 001NG, 002NG, 004NG, 005NG,
+           010NG, 020NG, 030NG, 001PG, 005PG, 015PG, 030PG, 060PG, 100PG,
+           150PG, NA]
+    $ref: /schemas/types.yaml#/definitions/string
+
+  honeywell,pmin-pascal:
+    description: |
+      Minimum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is set to "NA".
+    $ref: /schemas/types.yaml#/definitions/int32
+
+  honeywell,pmax-pascal:
+    description: |
+      Maximum pressure value the sensor can measure in pascal.
+      To be specified only if honeywell,pressure-triplet is set to "NA".
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  vdd-supply:
+    description:
+      Provide VDD power to the sensor (either 3.3V or 5V depending on the chip)
+
+  spi-max-frequency:
+    maximum: 800000
+
+required:
+  - compatible
+  - reg
+  - honeywell,transfer-function
+  - honeywell,pressure-triplet
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@28 {
+            compatible = "honeywell,hsc030pa";
+            reg = <0x28>;
+            honeywell,transfer-function = <0>;
+            honeywell,pressure-triplet = "030PA";
+        };
+    };
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@0 {
+            compatible = "honeywell,hsc030pa";
+            reg = <0>;
+            spi-max-frequency = <800000>;
+            honeywell,transfer-function = <0>;
+            honeywell,pressure-triplet = "NA";
+            honeywell,pmin-pascal = <0>;
+            honeywell,pmax-pascal = <200000>;
+        };
+    };
+...
-- 
2.41.0


