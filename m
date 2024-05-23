Return-Path: <linux-iio+bounces-5199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0ED8CCB17
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 05:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26AB91F23048
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 03:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E63513B797;
	Thu, 23 May 2024 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="orDdTK8u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682213B5AC;
	Thu, 23 May 2024 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434404; cv=none; b=p8K2kZaVOvqrffJb2YOXrTBvL5XuYu3Tc5j25h0Fxp6vMfqXb8impW82FnOon0CSORDeZX+NjDvDWtjNB7wrIvL29kjvenX+J2/b4fvJj0A8SnrxhE11QSd7hfu3CM1WYbaKckhSBvzCC08r4zuh1JQRxG6NX/9qKJYWTA7YZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434404; c=relaxed/simple;
	bh=v3RCZoU9hhmslSyclylqPr9ffAr4R5EywidC1iicto0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3OH1/wsVzbAwo2wIeoXn9cy/PP3A+hfnQ3EDjRccDc/kDE5zN1KmUTSem9NVSAHBNALwdB+Npyfk1HYm0Ahu5f/g+teuzETz52q2ruy3vcGUDVwKWMvIv5ik1rgbLSuMmhV6bCnPgo2bTB9dMVPtWRVnga+4KBKIFJCtrOfAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=orDdTK8u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44N1PlEN028617;
	Wed, 22 May 2024 23:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=DKIM;
	 bh=cEXx/KsITbFNVuUG/Dj0JcB2owy0tUaNkuXkZ7ltzM0=; b=orDdTK8u70o9
	yDBvL98xJNQAgkdciM062IDNFb+O0qzjrltZWUKjXdDie09jBb2QfLIy6JtA2teO
	aMVzNwkKv7iH8GXIaPrnYut6UP42jDvBYL7y+UeSfWDHgHhz+AkP8O2Q0Un8QSQ/
	LX9gg7cB/sd3lI4aD0SHzYEmQZ7ezQxkfQv5uWs+rdUGpOa2n6Gpv3Hzk4wsg4lu
	OYcNcseozyer48Mn/Dv01/bjpFwp81tSqX9c1zd+phRQm67I7X+esC9Kg7+f8nrj
	b1AxxHgy/ZD4YD28IqOH809hPX28YFrBsm7j8uxGEjgX7/s9YNyGUcgQjs+g0neg
	3lsTT824Cw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y87pwkw45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 23:19:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44N3JkGv004188
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 23:19:46 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 23:19:45 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 23:19:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 23:19:45 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.38])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44N3JG8u018850;
	Wed, 22 May 2024 23:19:36 -0400
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
	<noname.nuno@gmail.com>
Subject: [PATCH v2 3/5] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Date: Thu, 23 May 2024 11:19:07 +0800
Message-ID: <20240523031909.19427-4-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523031909.19427-1-kimseer.paller@analog.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1mH6ZWNxWQbuIE2EMpA2Ydm12_OrkBn1
X-Proofpoint-ORIG-GUID: 1mH6ZWNxWQbuIE2EMpA2Ydm12_OrkBn1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230022

Add documentation for ltc2664.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/dac/adi,ltc2664.yaml         | 167 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
new file mode 100644
index 000000000000..517a96808ee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
@@ -0,0 +1,167 @@
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
+  Analog Devices LTC2664 4 channel, 16 bit, +-10V DAC
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
+  clr-gpios:
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
+        0 - MPS2=GND, MPS1=GND, MSP0=GND
+        1 - MPS2=GND, MPS1=GND, MSP0=VCC
+        2 - MPS2=GND, MPS1=VCC, MSP0=GND
+        3 - MPS2=GND, MPS1=VCC, MSP0=VCC
+        4 - MPS2=VCC, MPS1=GND, MSP0=GND
+        5 - MPS2=VCC, MPS1=GND, MSP0=VCC
+        6 - MPS2=VCC, MPS1=VCC, MSP0=GND
+        7 - MPS2=VCC, MPS1=VCC, MSP0=VCC (enables SoftSpan feature)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3, 4, 5, 6, 7]
+    default: 7
+
+  io-channels:
+    description:
+      Analog multiplexer output. VOUT0-VOUT3, MUXIN0-MUXIN3, REFLO, REF, V+, V-,
+      and a temperature monitor output can be internally routed to the MUXOUT pin.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-3]$":
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
+      adi,output-range-microvolt:
+        description: Specify the channel output full scale range.
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
+      - adi,output-range-microvolt
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
+                    adi,output-range-microvolt = <(-10000000) 10000000>;
+            };
+
+            channel@1 {
+                    reg = <1>;
+                    adi,output-range-microvolt = <0 10000000>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index b3be54c09159..7becbdf7d1df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12857,6 +12857,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac
+F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
 
 LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
-- 
2.34.1


