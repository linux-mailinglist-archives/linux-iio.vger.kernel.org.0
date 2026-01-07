Return-Path: <linux-iio+bounces-27521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E428CFE772
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 16:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFA85309D7EB
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BCA350286;
	Wed,  7 Jan 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="G+f0dySO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DE34F479;
	Wed,  7 Jan 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797286; cv=none; b=pqH0xaHbLnZhLoZW4oDfHDdeAYvFAQBFGXklA2+gMC76d1OucSGhs/DWFw4QcoN/0fKqHKnWyzlhxHNZB0zfduiiTHornBOueo7DBOydeLYd9a5F9Leb0WnA2gK4PbSAtk2setrlmh4OmRcbwL1Y8hDbQkx54qNkYKnAR12JS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797286; c=relaxed/simple;
	bh=rWgrBMWSNWNVIuvhl7Pqsi0DqMCwA94eFeip9Nnf9P4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWQQOoqFrFlaL3XoJ2Zdyh8PdNsKjLG94C6lSVRueTs1A/iuLolqlrprFzNblST96hL04to2bbPRoDDP/fKXQvuIXU7LMpxV8P+Tk8hJfvUxmkdpbP/89qx0UaQP2HtWwEBQcrYXVAxjcrpZzLYrB1O2PtsAUraP734/DQ9ntQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=G+f0dySO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607DBggU783610;
	Wed, 7 Jan 2026 09:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SXX7B
	W83vW9ej3j2wcVWq37HfeTb+y+NqVskJMJzkjE=; b=G+f0dySOxbhvCF9wRG6db
	hSB3pplF+tjSCGWUT4t0QaEBICrxpXV21Xc4aMOPTs/0zMmNl4XIbEJEDAMhBXYz
	Ghu31reAHufH5Co1O5sx2ipk0UTHtLZEcalXW9d/NRGYRzni/Kl4VwgcHyAmsVB0
	36YU1i5OaQdrfPr7Vm92t00cSJooqG8HI4pVdMP23iSXgoG9N8VaILRfHIDWToH6
	NyVByxPmYoIX9283dAk4QWWI3CjqjbWMTqHV4hqM4rfNpvwifhhRzcp0OmsZfo2/
	vn17OiUE32zybOSJSYIY4mk2r8+xg0ecp8U848ScwNhWRfeC9yOyMvb1vmP3qQHi
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4bhah0cs73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 09:47:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 607ElqZJ065374
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Jan 2026 09:47:52 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 7 Jan
 2026 09:47:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 7 Jan 2026 09:47:52 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 607ElbNU004193;
	Wed, 7 Jan 2026 09:47:39 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <tomas.melin@vaisala.com>,
        <marcelo.schmitt1@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: Add AD4134
Date: Wed, 7 Jan 2026 11:47:37 -0300
Message-ID: <9953eb2d6b8024ae00f24ad196fcd45716130eb5.1767795849.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1767795849.git.marcelo.schmitt@analog.com>
References: <cover.1767795849.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=dOCrWeZb c=1 sm=1 tr=0 ts=695e721a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=HS44FQqwKhdDaIuF1EUA:9
 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: 8025cefS8MbFTNVJuBesPoAYeNTrn4mk
X-Proofpoint-GUID: 8025cefS8MbFTNVJuBesPoAYeNTrn4mk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDExNCBTYWx0ZWRfX2iNC/dBS4zpk
 +P+xc9JbUM6s6TGaM4tqpBZvZsUqIK1eYrZyxYY3SE0beqe0nQdB0zfDDxKdsEsZdofzubywqbw
 9CuLr3JW28W6pvEQz81zQWiXce3mJqUZhvPhlwLtC9xN0ckUbS7uO3CnQsPg3eNgEEaPV9l3Eea
 Y6tnZm4vd+9Q8VL/CNExghUnXe/ggv1HNqVbHKCds91m8YONHio/9TH2p6MXVD9XLUcFti+etde
 7gX3z5AibinCVceEY/gVfNUGvYIxG4sc2eat60OpDBgIvFyYOY+2cL1vxnligOcJmty71jBqrQ/
 4ainlt7MJj2nO3eXM3OB8jN7+rE8O6gQ8ALH+UTRMZJ45LL3ow6uTHXUAfkGrLV9lcXtg8Vq7d7
 cpOu+QyD7ry2Ybi+s2mlbhcHPhkbfrGHJqhs0NpAyUyWBK9I3s8+kp/HspEgDijcJUqYT1Wt7dF
 +uxTx+wrEn1K9bmj+2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070114

Add device tree documentation for AD4134 24-Bit, 4-channel simultaneous
sampling, precision ADC.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Renamed clock option "xtal1-xtal2" to "xtal" (making it similar to other bindings).
- Use oneOf for ldoin-supply choice.
- Dropped properties set to their defaults from the example.

I believe the changes were not disruptive so I kept Conor's review tag.

 .../bindings/iio/adc/adi,ad4134.yaml          | 191 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
new file mode 100644
index 000000000000..ea6d7e026419
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -0,0 +1,191 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad4134.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD4134 ADC
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  The AD4134 is a quad channel, low noise, simultaneous sampling, precision
+  analog-to-digital converter (ADC).
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4134.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad4134
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  avdd5-supply:
+    description: A 5V supply that powers the chip's analog circuitry.
+
+  dvdd5-supply:
+    description: A 5V supply that powers the chip's digital circuitry.
+
+  iovdd-supply:
+    description:
+      A 1.8V supply that sets the logic levels for the digital interface pins.
+
+  refin-supply:
+    description:
+      A 4.096V or 5V supply that serves as reference for ADC conversions.
+
+  avdd1v8-supply:
+    description: A 1.8V supply used by the analog circuitry.
+
+  dvdd1v8-supply:
+    description: A 1.8V supply used by the digital circuitry.
+
+  clkvdd-supply:
+    description: A 1.8V supply for the chip's clock management circuit.
+
+  ldoin-supply:
+    description:
+      A 2.6V to 5.5V supply that generates 1.8V for AVDD1V8, DVDD1V8, and CLKVDD
+      pins.
+
+  clocks:
+    maxItems: 1
+    description:
+      Required external clock source. Can specify either a crystal or CMOS clock
+      source. If an external crystal is set, connect the CLKSEL pin to IOVDD.
+      Otherwise, connect the CLKSEL pin to IOGND and the external CMOS clock
+      signal to the XTAL2/CLKIN pin.
+
+  clock-names:
+    enum:
+      - xtal
+      - clkin
+    default: clkin
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      list of regulators provided by this controller.
+
+    properties:
+      vcm-output:
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+  reset-gpios:
+    maxItems: 1
+
+  powerdown-gpios:
+    description:
+      Active low GPIO connected to the /PDN pin. Forces the device into full
+      power-down mode when brought low. Pull this input to IOVDD for normal
+      operation.
+    maxItems: 1
+
+  odr-gpios:
+    description:
+      GPIO connected to ODR pin. Used to sample ADC data in minimum I/O mode.
+    maxItems: 1
+
+  adi,asrc-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Asynchronous Sample Rate Converter (ASRC) operation mode control input.
+      Describes whether the MODE pin is set to a high level (for master mode
+      operation) or to a low level (for slave mode operation).
+    enum: [ high, low ]
+    default: low
+
+  adi,dclkio:
+    description:
+      DCLK pin I/O direction control for when the device operates in Pin Control
+      Slave Mode or in SPI Control Mode. Describes if DEC0/DCLKIO pin is at a
+      high level (which configures DCLK as an output) or to set to a low level
+      (configuring DCLK for input).
+    enum: [ out, in ]
+    default: in
+
+  adi,dclkmode:
+    description:
+      DCLK mode control for when the device operates in Pin Control Slave Mode
+      or in SPI Control Mode. Describes whether the DEC1/DCLKMODE pin is set to
+      a high level (configuring the DCLK to operate in free running mode) or
+      to a low level (to configure DCLK to operate in gated mode).
+    enum: [ free-running, gated ]
+    default: gated
+
+required:
+  - compatible
+  - reg
+  - avdd5-supply
+  - dvdd5-supply
+  - iovdd-supply
+  - refin-supply
+  - clocks
+  - clock-names
+
+oneOf:
+  - required:
+      - ldoin-supply
+  - required:
+      - avdd1v8-supply
+      - dvdd1v8-supply
+      - clkvdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4134";
+            reg = <0>;
+
+            spi-max-frequency = <1000000>;
+
+            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
+            odr-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
+            powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
+
+            clocks = <&sys_clk>;
+            clock-names = "clkin";
+
+            avdd5-supply = <&avdd5>;
+            dvdd5-supply = <&dvdd5>;
+            iovdd-supply = <&iovdd>;
+            refin-supply = <&refin>;
+            avdd1v8-supply = <&avdd1v8>;
+            dvdd1v8-supply = <&dvdd1v8>;
+            clkvdd-supply = <&clkvdd>;
+
+            regulators {
+                vcm_reg: vcm-output {
+                    regulator-name = "ad4134-vcm";
+                };
+            };
+
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e8825b8ccef..3f9f6dd96ae4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1458,6 +1458,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 F:	drivers/iio/adc/ad4130.c
 
+ANALOG DEVICES INC AD4134 DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+
 ANALOG DEVICES INC AD4170-4 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.51.0


