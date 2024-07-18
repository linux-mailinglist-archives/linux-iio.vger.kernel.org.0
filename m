Return-Path: <linux-iio+bounces-7671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C388D93478B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 07:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454411F24C48
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F517347E;
	Thu, 18 Jul 2024 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Zr3jq2ka"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA173466;
	Thu, 18 Jul 2024 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279985; cv=none; b=qHwRhGHmchauVZ6kIQMEL2tq/upIt72DCOip2AdoRzkSqyNRBftkqCyWkAsARQ30bn0O7lehDbVQumNioPuo+JE1vDpGpbRaxUp+I5OdFtKvNSiIJcHZ0zieeK/PUWRbSRuYloVSYfiRtINcU6LbE2f84u91V4ewU6KcnbBRHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279985; c=relaxed/simple;
	bh=5DgB2+OMBexhxXb85iGGqtE51nQxsJyKmmRHfzCo56s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtZEKd8aH5jhGEp+FOO0BPuiiQe4DydX3nrrU90lBM4Ri0JFlrgmoIUvWJClX0deRp1HQ7f2SYCCmMv3z7tkm5lavH9/7qUi0pz8PefRPlryepF0uPd3ZnJ5WLq/f5achtgHbru2qFA1BKqtlisvgh3NM8DBRwLc/BaaygKawSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Zr3jq2ka; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I1FPYI023204;
	Thu, 18 Jul 2024 01:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cRTBL
	711coDo1KDNs0MLzgY2pbIwZ8ZYaLQQm5cnz4o=; b=Zr3jq2kadUz0VbQwXmj+l
	RiXwcY1aOV2k97U0seW9Sx4eyCioI7uzUW8WiVnICzYEYf6ej+i0j4z+K8XCWXF1
	A5KEKcfQoQbssFA3hTGbBkF0CTqbF3cPDmmUDPtRxu0e0tbZ78z4cC980MR6TLuf
	M1SZ1kXhFmgk/biHke5XIUZNbHzIhNW5+wYiUMEdsIxOrO8zeA81KeOFC2pRGfs4
	D3xpS3O1770wznA93WK9PJ1kMW0eMPoyy56/1nUvigf4DYpw0ysUulAdlo/HlS/z
	V2MgzefkrD+ZtbxVIp0jkzb/nz/6LEcum4Orjor8LhLrUaIh8FT7CcZGvGWe8phK
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 40dwer69n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 01:19:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46I5JQ1L021569
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jul 2024 01:19:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 18 Jul 2024 01:19:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 18 Jul 2024 01:19:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 18 Jul 2024 01:19:25 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46I5IhgW009768;
	Thu, 18 Jul 2024 01:19:18 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Michael
 Hennerich" <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v8 5/6] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Date: Thu, 18 Jul 2024 13:18:33 +0800
Message-ID: <20240718051834.32270-6-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718051834.32270-1-kimseer.paller@analog.com>
References: <20240718051834.32270-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ilbJ27wez2ld8nmyX1xXT462XMkDfPrU
X-Proofpoint-ORIG-GUID: ilbJ27wez2ld8nmyX1xXT462XMkDfPrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_02,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180035

Add documentation for ltc2672.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/dac/adi,ltc2672.yaml         | 160 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
new file mode 100644
index 000000000000..c8c434c10643
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ltc2672.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2672 DAC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+  Analog Devices LTC2672 5 channel, 12-/16-Bit, 300mA DAC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2672
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  vcc-supply:
+    description: Analog Supply Voltage Input.
+
+  v-neg-supply:
+    description: Negative Supply Voltage Input.
+
+  vdd0-supply:
+    description: Positive Supply Voltage Input for DAC OUT0.
+
+  vdd1-supply:
+    description: Positive Supply Voltage Input for DAC OUT1.
+
+  vdd2-supply:
+    description: Positive Supply Voltage Input for DAC OUT2.
+
+  vdd3-supply:
+    description: Positive Supply Voltage Input for DAC OUT3.
+
+  vdd4-supply:
+    description: Positive Supply Voltage Input for DAC OUT4.
+
+  iovcc-supply:
+    description: Digital Input/Output Supply Voltage.
+
+  ref-supply:
+    description:
+      Reference Input/Output. The voltage at the REF pin sets the full-scale
+      range of all channels. If not provided the internal reference is used and
+      also provided on the VREF pin.
+
+  reset-gpios:
+    description:
+      Active Low Asynchronous Clear Input. A logic low at this level triggered
+      input clears the device to the default reset code and output range, which
+      is zero-scale with the outputs off. The control registers are cleared to
+      zero.
+    maxItems: 1
+
+  adi,rfsadj-ohms:
+    description:
+      If FSADJ is tied to VCC, an internal RFSADJ (20 kΩ) is selected, which
+      results in nominal output ranges. When an external resistor of 19 kΩ to
+      41 kΩ can be used instead by connecting the resistor between FSADJ and GND
+      it controls the scaling of the ranges, and the internal resistor is
+      automatically disconnected.
+    minimum: 19000
+    maximum: 41000
+    default: 20000
+
+  io-channels:
+    description:
+      ADC channel to monitor voltages and currents at the MUX pin.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-4]$":
+    $ref: dac.yaml
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        description: The channel number representing the DAC output channel.
+        maximum: 4
+
+      adi,toggle-mode:
+        description:
+          Set the channel as a toggle enabled channel. Toggle operation enables
+          fast switching of a DAC output between two different DAC codes without
+          any SPI transaction.
+        type: boolean
+
+      output-range-microamp:
+        items:
+          - const: 0
+          - enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
+                   200000000, 300000000]
+
+    required:
+      - reg
+      - output-range-microamp
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - vcc-supply
+  - iovcc-supply
+  - v-neg-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            compatible = "adi,ltc2672";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+
+            vcc-supply = <&vcc>;
+            iovcc-supply = <&vcc>;
+            ref-supply = <&vref>;
+            v-neg-supply = <&vneg>;
+
+            io-channels = <&adc 0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                adi,toggle-mode;
+                output-range-microamp = <0 3125000>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                output-range-microamp = <0 6250000>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c25863321328..d54b56aca1b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13087,6 +13087,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
+F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 
 LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
-- 
2.34.1


