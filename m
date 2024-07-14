Return-Path: <linux-iio+bounces-7608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E2C930A1E
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3357B21636
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE9139D05;
	Sun, 14 Jul 2024 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="metk5KWq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB2513B2AC;
	Sun, 14 Jul 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963864; cv=none; b=J1qFZZWiwHb9cA8cimGhOLHuXTV10aahJNtVnUPwM1A0Yxb6KwEH+TpW37t3zFaBvjD6SGALYtQXvTnJTN/pChZpypHcW8apyjAuqbQbEmncNFt+eLh1+Kdqr30V+t8pa62VJy23KUL1vZGi/rfjADwRj2j6U7K6rRbuzU3yc38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963864; c=relaxed/simple;
	bh=rEL4WPYXeT1MFbOI+5rj1FO81TRkoPf1+8b6B+9DeVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qguDBhDoA0P51aty2GFya+Y4o6Bvpw60u5KcGFeG1PU9expnmY/HMxTGLkLLEtshSZU3ed49fy616OjCzL96B4bSFKGu6FTxz1AaXduYlTEk3ke1Z11KkIn5Tf8aZdjKl1oCnXCY1cUnEORwzuHSyqxA8HFqXWM+3nmOxv7pYxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=metk5KWq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46E4i408015427;
	Sun, 14 Jul 2024 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AefKg
	xXBfDoGbQOfHySlsRQbhpOYlxFQ+YAOdWRoxEc=; b=metk5KWqSFS6FeFmC84dR
	Z4Lhc3kRrEglO291mEZ/PwhhmJsxma0Ezq6ICN8Wj81Px40hCOwOa76qqKXSkudI
	6fiqiUEe6KliBEnRS28lSKSjLCXdK4hfJF2+VqyApPRxCfMVO0BVRprBNneSvT44
	qKLSLmKCBZhFB5Nwj8NkrrtT/luIWiJ4oyzK3vcjcf8Z8TXtmDMtARnwkAYzVokz
	blp1Oz2Q/a4D8hRfEeqO52XjdkzCKaf5Wi8oBwx7T3d16LaHMb1I2QaRohtUza5n
	Ih86xftjYOzAvrABCA2WN3lyrMhxzV631/L+PWyFk3KRy+fKJ1aEnJJYnw5BOa1o
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40c7wdgs3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 09:30:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46EDUkmY009618
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 14 Jul 2024 09:30:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 14 Jul
 2024 09:30:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 14 Jul 2024 09:30:45 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.97])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46EDU4QX028092;
	Sun, 14 Jul 2024 09:30:35 -0400
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
Subject: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Date: Sun, 14 Jul 2024 21:29:58 +0800
Message-ID: <20240714133000.5866-5-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240714133000.5866-1-kimseer.paller@analog.com>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ifZ7tNVQlsU5l6vQQzWgB2mE1l_bg-Ec
X-Proofpoint-ORIG-GUID: ifZ7tNVQlsU5l6vQQzWgB2mE1l_bg-Ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407140107

Add documentation for ltc2664.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/dac/adi,ltc2664.yaml         | 181 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 2 files changed, 189 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
new file mode 100644
index 000000000000..84488437b788
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
@@ -0,0 +1,181 @@
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
+        description:
+          This property is only allowed when SoftSpan is enabled. If not present,
+          [0, 5000000] is the default output range.
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
+          not:
+            properties:
+              adi,manual-span-operation-config:
+                const: 7
+        then:
+          patternProperties:
+            "^channel@[0-3]$":
+              properties:
+                output-range-microvolt: false
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
index 06ecfa64a39a..c25863321328 100644
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


