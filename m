Return-Path: <linux-iio+bounces-26129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5193CC46ADE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 13:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C983B348A1E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61530DD27;
	Mon, 10 Nov 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PSvHskAP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F99305977;
	Mon, 10 Nov 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778743; cv=none; b=GLjmBlYAw/KlIo8iZk6tpLTnrZuVz5QDy5+TEM1SfEgTmsxru/ToEnMy9KkVmw7YkJgBTGuzv2gYrrvMWy+udnL4YPMK0NIh+XGrBHnJ70zc6l+DEjSvkbQfCgNYmmmZqPQP12FipF3/7+TI61MfoUBOmZ7S6ppgS306NOfKjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778743; c=relaxed/simple;
	bh=BfIvwFijGjZQWOXHFDTgf77sH8jxCPwYBDWqtbOWbvY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzT90HJFlNNvLEaadECe3vE+eUo6dIN2WNoOlIrX3WFfZvCtRcW1lBLj4RjYxpZpixQcyiHNV0CEDzhR0QAIKk36hi4m7vZi1mrINWzji0rJ+LV65dZLUpvW74cCaTiyplq4u0asWjp+/jY+MHL0j3ElPc16CN+TKpE3nyi6lJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PSvHskAP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9h79r3717091;
	Mon, 10 Nov 2025 07:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=toEiJ
	27RrvSl1L2+xP52itEEqNm02g9iODOwC4LgiLE=; b=PSvHskAPIJsXsi3UkSqUT
	fycQZWHcLocJNfCTL1wnJBf1bMoHPnBjAKE5QP+ht+Q/mPwPtoC2lIEJZusZFX8O
	4nvLr6zzwfTRRYwPttfWqWZj5iMYsiEuUpImcRdc1oansckWeQ5UyIdGg7+p1M9o
	kjP4dzFBw7DbBEVOozeS/NGEmgjiRVtaNLU/K1VP9RSGYQ+jGj0OSBmkegHSRaVG
	Yd42trUyWa333LFV9pR9WKA1pHbZ1o6Mtp/7xJvqqvO5OpkYUIPx/QHTU8cTUER1
	7TxK8bkYOKloTaLAeDegc8SGN4qetCR+F3yOtxfpVs+vqFbL2P+9XGDqQQm57Kzr
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aa0k61ns8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 07:45:36 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AACjZ46063958
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Nov 2025 07:45:35 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 10 Nov 2025 07:45:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 10 Nov 2025 07:45:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 10 Nov 2025 07:45:35 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AACjJ4w000595;
	Mon, 10 Nov 2025 07:45:21 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <cosmin.tanislav@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 1/3] dt-bindings: iio: adc: Add AD4134
Date: Mon, 10 Nov 2025 09:45:18 -0300
Message-ID: <608ab00821af9f766c75d88f59940fed87cb6df7.1762777931.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1762777931.git.marcelo.schmitt@analog.com>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: PZ_WZsG6TM_k1blIvrkovHe6oaSVxTdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMSBTYWx0ZWRfX00aR9zqwXtCd
 87M5CwPWtl74Pe5H4DjESHktc9NKcR8Z3CHcZPIzOrbV/8FuDhuXauH+nOBqYZzSjkHEpzCxF9f
 tHCytgDFMfjda3vi80B+iPQhy+NwIp5WbyZUkuXb40NT4feFYPXtz5L91eyNpUkdpUFMs+L8Rxh
 Y2m2/mwVTxd/4j0XZ5zx0S7rku+VpfqIA2/MsoWU37v+kRsstA1G5JeFYOjLaPQtA+0KpzKvdi1
 IkNvoArSorw3bCeCLPlBHs34X313uIaGOOA71MWHTX7JEuOEdxU8RwTxRcPekkFBgxVJ8t4QB9u
 N0byJMvFc3ZRnCK936vv1Dh1xabZjCXkZ1Saw0ye6yp4Iat9nob+HdrnKTQQcwZeVFSeshjWldE
 8H5aHGOzB98B8Wx6oWvSnIzZIIHRPQ==
X-Authority-Analysis: v=2.4 cv=VKPQXtPX c=1 sm=1 tr=0 ts=6911de70 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=nQ53MiDv_q3zpeR_elAA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: PZ_WZsG6TM_k1blIvrkovHe6oaSVxTdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100111

Add device tree documentation for AD4134 24-Bit, 4-channel simultaneous
sampling, precision ADC.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad4134.yaml          | 209 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
new file mode 100644
index 000000000000..a758d2542ab0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -0,0 +1,209 @@
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
+      power-down mode when broght low. Pull this input to IOVDD for normal
+      operation.
+    maxItems: 1
+
+  odr-gpios:
+    description:
+      GPIO connected to ODR pin. Used to sample ADC data in minimum I/O mode.
+    maxItems: 1
+
+  adi,control-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Describes whether the device is wired to an SPI interface or not. The
+      PIN/SPI pin on the device must be set accordingly, i.e., PIN/SPI must be
+      set to logic high for SPI Control Mode, low for Pin Control Mode. When
+      absent, implies the SPI interface configuration.
+    enum: [ spi-control-mode, pin-control-mode ]
+    default: spi-control-mode
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
+            adi,control-mode = "spi-control-mode";
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
index 9f3413e05c83..56bea005755d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1437,6 +1437,13 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
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


