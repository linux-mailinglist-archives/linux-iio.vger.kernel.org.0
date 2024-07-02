Return-Path: <linux-iio+bounces-7117-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E397491ED3B
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 05:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1413E1C2122F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02495821A;
	Tue,  2 Jul 2024 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z9MgWZpX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CEC2030B;
	Tue,  2 Jul 2024 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889289; cv=none; b=O93FRRX7oWQuhplQIKcA59XBQhWfZinoXzMC/T7+Ha2gxT+x70bM2/uII5anSHhI2lBB8oxn0nVL7sN9zkH7zOAI1Bd4GIft7fUlr7e4HgXwf2N2xWyi3PtdFJ1lMURfCFZOT8nav8k/6ZiJ6WEnDIC8ev067RuTctgl1k5YmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889289; c=relaxed/simple;
	bh=lplyi8mT03vC3ksYVx4N7Q0AkiyexrUep7aLa2L4RWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MeCKe1zeQTfFFTZZ7kQ/PF8g3f0hX7mOlEZ1BtJMrHNLlxwRPJ8+/tr8jSpqrzL3jYw4EO+tN/X3NptRF+MVraQd+KGO1HMS5cYrHuq3X3IDSICyv64plpIxSh6Bz3Q3vVDUfME+L9X6sKTIMBxf5gQx93nO90ZxF9fJs6iGMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z9MgWZpX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46228Hmk002097;
	Mon, 1 Jul 2024 23:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P4rPz
	bng6IdDtG1rgZ7rXgDJKUT2vhcKXsp7XF166Ys=; b=z9MgWZpXbHBWKmbbTfd95
	/JvQFpppf27LTCeGvbA/fZTj+D1lw0Y+9dtpWdwvvLcoSQpfTgJ0XpHSddmZtdOT
	74qdlg//AmbbjIdOlJbl9sfjJOKUi0dYJFekoZmKA9Ah0HrlEPohudR3BwSsGc98
	qYV+t1QMdeuTXZUlmXnJ1busRhYTBFIXVt/GiF7sUYU78vmbSra4ZSukw27/FSzp
	fY1jPki48F3xiAWmIwD9wMgIhLlEUba3vs05uwLuG1RSE9NyU3R7XNLn0Vxrb822
	u5Q3H8Zzu3sH2630zgy/1dhzFSeX9NujaQd/nTN2k/HbnzoEKggrtq8o9b7THmQW
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402c43ry7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:01:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46231BGW041271
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 23:01:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 1 Jul 2024
 23:01:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 1 Jul 2024 23:01:10 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.28])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46230WbP032046;
	Mon, 1 Jul 2024 23:00:59 -0400
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
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Michael
 Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v5 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Date: Tue, 2 Jul 2024 11:00:23 +0800
Message-ID: <20240702030025.57078-5-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702030025.57078-1-kimseer.paller@analog.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: liRKFl4UNSp7H-VvTDnZ1zR1VRdaf0jA
X-Proofpoint-GUID: liRKFl4UNSp7H-VvTDnZ1zR1VRdaf0jA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_23,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020020

Add documentation for ltc2664.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/dac/adi,ltc2664.yaml         | 176 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 2 files changed, 184 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
new file mode 100644
index 000000000000..51c2e8502b9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ltc2664.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2664 DAC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+  Analog Devices LTC2664 4 channel, 12-/16-Bit, +-10V DAC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/2664fa.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2664
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
+  v-pos-supply:
+    description: Positive Supply Voltage Input.
+
+  v-neg-supply:
+    description: Negative Supply Voltage Input.
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
+      Active-low Asynchronous Clear Input. A logic low at this level-triggered
+      input clears the part to the reset code and range determined by the
+      hardwired option chosen using the MSPAN pins. The control registers are
+      cleared to zero.
+    maxItems: 1
+
+  adi,manual-span-operation-config:
+    description:
+      This property must mimic the MSPAN pin configurations. By tying the MSPAN
+      pins (MSP2, MSP1 and MSP0) to GND and/or VCC, any output range can be
+      hardware-configured with different mid-scale or zero-scale reset options.
+      The hardware configuration is latched during power on reset for proper
+      operation.
+        0 - MPS2=GND, MPS1=GND, MSP0=GND (+-10V, reset to 0V)
+        1 - MPS2=GND, MPS1=GND, MSP0=VCC (+-5V, reset to 0V)
+        2 - MPS2=GND, MPS1=VCC, MSP0=GND (+-2.5V, reset to 0V)
+        3 - MPS2=GND, MPS1=VCC, MSP0=VCC (0V to 10, reset to 0V)
+        4 - MPS2=VCC, MPS1=GND, MSP0=GND (0V to 10V, reset to 5V)
+        5 - MPS2=VCC, MPS1=GND, MSP0=VCC (0V to 5V, reset to 0V)
+        6 - MPS2=VCC, MPS1=VCC, MSP0=GND (0V to 5V, reset to 2.5V)
+        7 - MPS2=VCC, MPS1=VCC, MSP0=VCC (0V to 5V, reset to 0V, enables SoftSpan)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    default: 7
+
+  io-channels:
+    description:
+      ADC channel to monitor voltages and temperature at the MUXOUT pin.
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: dac.yaml
+    type: object
+    additionalProperties: false
+
+    properties:
+      reg:
+        description: The channel number representing the DAC output channel.
+        maximum: 3
+
+      adi,toggle-mode:
+        description:
+          Set the channel as a toggle enabled channel. Toggle operation enables
+          fast switching of a DAC output between two different DAC codes without
+          any SPI transaction.
+        type: boolean
+
+      output-range-microvolt:
+        oneOf:
+          - items:
+              - const: 0
+              - enum: [5000000, 10000000]
+          - items:
+              - const: -5000000
+              - const: 5000000
+          - items:
+              - const: -10000000
+              - const: 10000000
+          - items:
+              - const: -2500000
+              - const: 2500000
+
+    required:
+      - reg
+
+    allOf:
+      - if:
+          properties:
+            adi,manual-span-operation-config:
+              const: 7
+        then:
+          patternProperties:
+            "^channel@[0-3]$":
+              required: [output-range-microvolt]
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - vcc-supply
+  - iovcc-supply
+  - v-pos-supply
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
+            compatible = "adi,ltc2664";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+
+            vcc-supply = <&vcc>;
+            iovcc-supply = <&vcc>;
+            ref-supply = <&vref>;
+            v-pos-supply = <&vpos>;
+            v-neg-supply = <&vneg>;
+
+            io-channels = <&adc 0>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                    reg = <0>;
+                    adi,toggle-mode;
+                    output-range-microvolt = <(-10000000) 10000000>;
+            };
+
+            channel@1 {
+                    reg = <1>;
+                    output-range-microvolt= <0 10000000>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0cbeb03847f5..2629e818ffdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13080,6 +13080,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2664 IIO DAC DRIVER
+M:	Michael Hennerich <michael.hennerich@analog.com>
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
+
 LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


