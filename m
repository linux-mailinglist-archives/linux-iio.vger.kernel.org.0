Return-Path: <linux-iio+bounces-5200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709AB8CCB1A
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 05:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA79F1F23830
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 03:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0566713BC01;
	Thu, 23 May 2024 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FNIVHXeM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B2213BAE7;
	Thu, 23 May 2024 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716434408; cv=none; b=muLdgDoFE8dKDHMf+zZ7f95sS1B9edCA5lo776YptwT3tnYjFQ2RTBpR/trMaA3u4gm+htMPP/VnZFsoebtZxeqDUbT6igZNvjXzdnh7nCrmrGeOEV5UDeC77ELETNmvIGw0jo6EY4i3RIAkLUTqfA8DE9vFvqiklPht5GaH1xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716434408; c=relaxed/simple;
	bh=7P62PKI0UvhgGT3xP/Im/mMHLeU8ykT2gvtM82GELTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ag7hn2kBqPxTzqZI71u+GBGopVY9S5hFtU9UdGSfDvvRpsoIzNU7yA1hWBcAXDPs5ww/6WK+LzRyEjqpKaZkiUUnjyJjC5g/812kDKybUw+13jSfFAGvko93Av9X+rA7WbYaTsqm4Ww87idVfpu6kQlNnbr+w3BdMlOZiAO8wiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FNIVHXeM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MN84MG028603;
	Wed, 22 May 2024 23:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=DKIM;
	 bh=bu7IDaxmkrY5Kg0snzmrnLwQy/rgplHv7e0IT4FWmH0=; b=FNIVHXeMwsJi
	SCZXjW02DP128aqYGhhnPu3OCU6r18lu2/X8P1Ykpe08HbasB/uAdtSnuI4vrCBd
	Rsg9gilm+AIzWUPt+Moaa4RLhMEwd9KXy8RTK4hOYoaIXYG6szHe472c3W7e1CTL
	2AEsaKWLFO5e5ZpaYqWtf9q8Ut7aj50NhELJtzh1Vdo6NtVX90XofKjcYwcmPJT8
	hUHbJ4g6CWPUg4pW4bpXzPeuMgXy1t/EaNFyPLOsfUBF+fl2/bcMW6iUdDlLdeci
	bGXa6AVk2d0nV99dOQu7xbaW801UUoo4bP3vaPEPE6WUacdg8j3/LcUyrNbH7CfT
	e1ixD2fMrw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y87pwkw4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 23:19:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44N3JpvS018247
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 23:19:51 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 23:19:50 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 23:19:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 23:19:50 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.38])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44N3JG8v018850;
	Wed, 22 May 2024 23:19:40 -0400
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
Subject: [PATCH v2 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Date: Thu, 23 May 2024 11:19:08 +0800
Message-ID: <20240523031909.19427-5-kimseer.paller@analog.com>
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
X-Proofpoint-GUID: FE9hbePh14Aa4AImooA9ESgOapjPoIs1
X-Proofpoint-ORIG-GUID: FE9hbePh14Aa4AImooA9ESgOapjPoIs1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_01,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230022

Add documentation for ltc2672.

Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/dac/adi,ltc2672.yaml         | 159 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
new file mode 100644
index 000000000000..996aae315640
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
@@ -0,0 +1,159 @@
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
+  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
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
+  clr-gpios:
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
+      Analog multiplexer output. Pin voltages and currents can be monitored by
+      measuring the voltage at MUX.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-4]$":
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
+      adi,output-range-microamp:
+        description: Specify the channel output full scale range.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
+               200000000, 300000000]
+
+    required:
+      - reg
+      - adi,output-range-microamp
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
+                    reg = <0>;
+                    adi,toggle-mode;
+                    adi,output-range-microamp = <3125000>;
+            };
+
+            channel@1 {
+                    reg = <1>;
+                    adi,output-range-microamp = <6250000>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7becbdf7d1df..3320b7af4c0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12858,6 +12858,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac
 F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
+F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
 
 LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
-- 
2.34.1


