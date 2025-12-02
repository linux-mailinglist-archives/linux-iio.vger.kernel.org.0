Return-Path: <linux-iio+bounces-26651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5CC9CF93
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 21:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F140B3A898D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 20:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED102F747F;
	Tue,  2 Dec 2025 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eheLFRic"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D822F745C;
	Tue,  2 Dec 2025 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708926; cv=none; b=AVfc/tcD/U+ypN59WivxmP/RB7qKDYCWE2RwreUsJ11J+q7Ea4EcDaPTDI3AnEmV5T5Bb4/97bnCY2w81xnAIYPY6OqH3H3QVbkR8VM5tDAxLfkjLFO+YK7AIykn5kTUR6SdY9n8RBdVDx3o295G8akMQvGIcUB+IT1W6cbYZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708926; c=relaxed/simple;
	bh=AztzcKexXIW7/2FGe9e92LU91IuZ50KkXelb8udWLSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YygLejtdIKj8mtCKZDu2x9WWdbw/TiGNePS816H/OkcjvbuavH3zjVHNLlDFB/Q1WipUgy1HoyXXZ33MXRzfTS882ArAB3Tl02l3pb88hWNE7KSukfQar/Nv7c81vklMLw7xvnQiQeELQqfJb81+c+xtKoa29fm9esa/9HzcEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eheLFRic; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2JrZ3x2129313;
	Tue, 2 Dec 2025 15:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BORoJ
	bYqonJf2ub2hWKYbF+i6XYDEaDUA54j59mvTmQ=; b=eheLFRicSbAddrsxzhstG
	stRSPzAzGdqyluqW8cug/Uj3UOJez88okuKavF/oiDv2luHzTo6Mw/RXMUqgc5x5
	Yu7MfoYJWy5VBI15q9elVdjgttVxMbXwKh76NP11YsiaqjNvEHUdwUcEZdoIh8UC
	cQjOHOFroTsBOZCPx4yUcwGwLv9g+jqy14ueiPDMOPGSKTWGaNVJm0+kTB48nhea
	DrmQvZ7f/JkA2+qVPffi0XPl1G9hglQp2m5JeFf2Dr4Wsl+vALP7f6Nz6K2GDO3C
	GBUsTEdc66OlFJRWwjYANTYFDcHwnRH9qZPuMRm39haR3DVxmYa6KIcVy/czzonY
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4at2vd1c9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 15:55:20 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5B2KtJ2h060178
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Dec 2025 15:55:19 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Dec 2025 15:55:18 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 2 Dec 2025 15:55:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 2 Dec 2025 15:55:18 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5B2Kt3Ll020220;
	Tue, 2 Dec 2025 15:55:05 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <marcelo.schmitt1@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: Add AD4134
Date: Tue, 2 Dec 2025 17:55:03 -0300
Message-ID: <06d7be2af0f6520c23f612fa0249ff6a26655cb7.1764708608.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1764708608.git.marcelo.schmitt@analog.com>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDE2NCBTYWx0ZWRfX+yXEcNMEr1NV
 vmlr7TN++cyivSeCtPN8dwunE2Bqx0NYB0n1lW5IJ2PlgbX+9/J6b79aJll8twni9A1VR/mC1lO
 Z2SobM6vzJRZEpu6S+Ssk05bm183/SKugAKegs/fBNqQTLPB1/YztbbGLxmjKfEvWBb6GppZZwq
 ojwXQe5j7JwX/OucjTC4broWVqbauy2Rp2LLzF+XK+TCoNv6gMkLYXhsbwo8qWNHCI3Q2SEBjOF
 163dKR2vpV55C10WV7ouraqaR2F5pqjOU3NAhUdrC2K2J30/qBSmfXMJ7V5F9T4qlwh/B77Y3f3
 O0xlYY+7to1QXuliYDcDYueB0IyhPAHmC1K/hZvSEIFHY1pDIBPh7Z4cwrZgxs+CXyR4ODx2Qsd
 0M+gktm5TjScHHEJa4Dv9zmJ5X2jMg==
X-Proofpoint-ORIG-GUID: CCn2RSyFv8xQ8IT2e6YFofemMFtfhfv1
X-Proofpoint-GUID: CCn2RSyFv8xQ8IT2e6YFofemMFtfhfv1
X-Authority-Analysis: v=2.4 cv=KeffcAYD c=1 sm=1 tr=0 ts=692f5238 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=-drBH0npV3mEBoBFRa4A:9
 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512020164

Add device tree documentation for AD4134 24-Bit, 4-channel simultaneous
sampling, precision ADC.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- fixed typo in powerdown-gpios description.
- picked up Conor's review tag. 

 .../bindings/iio/adc/adi,ad4134.yaml          | 198 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
new file mode 100644
index 000000000000..69a6ddf6ca92
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -0,0 +1,198 @@
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
+      - xtal1-xtal2
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
+allOf:
+  - if:
+      not:
+        required:
+          - ldoin-supply
+    then:
+      required:
+        - avdd1v8-supply
+        - dvdd1v8-supply
+        - clkvdd-supply
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
+            adi,asrc-mode = "low";
+            adi,dclkio = "in";
+            adi,dclkmode = "gated";
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
index 31d98efb1ad1..b9029c4055e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1449,6 +1449,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
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


