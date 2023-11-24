Return-Path: <linux-iio+bounces-313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0E7F7215
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 11:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53A8B21226
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351BF1642E;
	Fri, 24 Nov 2023 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4E92;
	Fri, 24 Nov 2023 02:52:03 -0800 (PST)
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AO78UKq003310;
	Fri, 24 Nov 2023 05:51:41 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ujq65gms0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 05:51:40 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 3AOApdXG005748
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Nov 2023 05:51:39 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 24 Nov
 2023 05:51:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 24 Nov 2023 05:51:38 -0500
Received: from kimedia-VirtualBox.ad.analog.com (KPALLER2-L02.ad.analog.com [10.116.242.88])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3AOApMWa024857;
	Fri, 24 Nov 2023 05:51:25 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: 
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kim
 Seer Paller <kimseer.paller@analog.com>,
        Crt Mori <cmo@melexis.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: frequency: add admfm2000
Date: Fri, 24 Nov 2023 18:51:15 +0800
Message-ID: <20231124105116.5764-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: G_QwXmnDwUBMFMsCb5Vk42iWCPGt9pgg
X-Proofpoint-GUID: G_QwXmnDwUBMFMsCb5Vk42iWCPGt9pgg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311060001
 definitions=main-2311240085

Dual microwave down converter module with input RF and LO frequency
ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
for each down conversion path.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V4 -> V5: Added Reviewed-by tag.
V3 -> V4: Updated the description of the properties with multiple entries and
          defined the order.
V2 -> V3: Adjusted indentation to resolve wrong indentation warning. 
          Changed node name to converter. Updated the descriptions to clarify
          the properties.
V1 -> V2: Removed '|' after description. Specified the pins connected to
          the GPIOs. Added additionalProperties: false. Changed node name to gpio.
          Aligned < syntax with the previous syntax in the examples.

 .../bindings/iio/frequency/adi,admfm2000.yaml | 154 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
new file mode 100644
index 000000000..037438737
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMFM2000 Dual Microwave Down Converter
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description:
+  Dual microwave down converter module with input RF and LO frequency ranges
+  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
+  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
+  conversion path.
+
+properties:
+  compatible:
+    enum:
+      - adi,admfm2000
+
+  switch1-gpios:
+    items:
+      - description: B15 GPIO, when high (and B16 low) channel 1 is in
+          Direct IF mode.
+      - description: B16 GPIO, when high (and B15 low) channel 1 is in
+          Mixer mode.
+
+  switch2-gpios:
+    items:
+      - description: K14 GPIO, when high (and L14 low) channel 2 is in
+          Mixer mode.
+      - description: L14 GPIO, when high (and K14 low) channel 2 is in
+          Direct IF mode.
+
+  attenuation1-gpios:
+    description: |
+      Choice of attenuation:
+      D15 D14 C16 C15 C14
+      1   1   1   1   1   0 dB
+      1   1   1   1   0   -1 dB
+      1   1   1   0   1   -2 dB
+      1   1   0   1   1   -4 dB
+      1   0   1   1   1   -8 dB
+      0   1   1   1   1   -16 dB
+      0   0   0   0   0   -31 dB
+
+    items:
+      - description: C14 GPIO
+      - description: C15 GPIO
+      - description: C16 GPIO
+      - description: D14 GPIO
+      - description: D15 GPIO
+
+  attenuation2-gpios:
+    description: |
+      Choice of attenuation:
+      M16 M15 M14 L16 L15
+      1   1   1   1   1   0 dB
+      1   1   1   1   0   -1 dB
+      1   1   1   0   1   -2 dB
+      1   1   0   1   1   -4 dB
+      1   0   1   1   1   -8 dB
+      0   1   1   1   1   -16 dB
+      0   0   0   0   0   -31 dB
+
+    items:
+      - description: L15 GPIO
+      - description: L16 GPIO
+      - description: M14 GPIO
+      - description: M15 GPIO
+      - description: M16 GPIO
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-1]$":
+    type: object
+    description: Represents a channel of the device.
+
+    additionalProperties: false
+
+    properties:
+      reg:
+        description:
+          The channel number.
+        minimum: 0
+        maximum: 1
+
+      adi,mode:
+        description:
+          RF path selected for the channel.
+            0 - Direct IF mode
+            1 - Mixer mode
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1]
+
+    required:
+      - reg
+      - adi,mode
+
+required:
+  - compatible
+  - switch1-gpios
+  - switch2-gpios
+  - attenuation1-gpios
+  - attenuation2-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    converter {
+      compatible = "adi,admfm2000";
+
+      switch1-gpios = <&gpio 1 GPIO_ACTIVE_LOW>,
+                      <&gpio 2 GPIO_ACTIVE_HIGH>;
+
+      switch2-gpios = <&gpio 3 GPIO_ACTIVE_LOW>,
+                      <&gpio 4 GPIO_ACTIVE_HIGH>;
+
+      attenuation1-gpios = <&gpio 17 GPIO_ACTIVE_LOW>,
+                           <&gpio 22 GPIO_ACTIVE_LOW>,
+                           <&gpio 23 GPIO_ACTIVE_LOW>,
+                           <&gpio 24 GPIO_ACTIVE_LOW>,
+                           <&gpio 25 GPIO_ACTIVE_LOW>;
+
+      attenuation2-gpios = <&gpio 0 GPIO_ACTIVE_LOW>,
+                           <&gpio 5 GPIO_ACTIVE_LOW>,
+                           <&gpio 6 GPIO_ACTIVE_LOW>,
+                           <&gpio 16 GPIO_ACTIVE_LOW>,
+                           <&gpio 26 GPIO_ACTIVE_LOW>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      channel@0 {
+        reg = <0>;
+        adi,mode = <1>;
+      };
+
+      channel@1 {
+        reg = <1>;
+        adi,mode = <1>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e79e24b6..f1692ec68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1247,6 +1247,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 F:	drivers/hwmon/adm1177.c
 
+ANALOG DEVICES INC ADMFM2000 DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
+
 ANALOG DEVICES INC ADMV1013 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

base-commit: c2d5304e6c648ebcf653bace7e51e0e6742e46c8
-- 
2.34.1


