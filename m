Return-Path: <linux-iio+bounces-7118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D883391ED3E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 05:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072281C21461
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 03:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEEC74297;
	Tue,  2 Jul 2024 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pSUx3S98"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8F29CF0;
	Tue,  2 Jul 2024 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889296; cv=none; b=nb08QIrxD5tyC/tg2lWmJHkCAAauyn4q9whUcIBxQeLw2x+cNq108lBoGlQhOaGHJBfpzCMiaHgvVzoTnEc3Ei+yuecS++UGxTB55yoIJLrrUW7TRtxX6aC+Ut5NoJ25CeG2TMFbnGeWvi8sRXWlI/OukZK84BQ7lsUToaLbFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889296; c=relaxed/simple;
	bh=TBsBuaGMkb56ehMGUudAsXo4M6l6fZvJiCJi3eVC79k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcJhvkwCN6Ip34dngZPGmbWDkftBInLt6g/Vopc+S9uSWSEUsPwJT4/svj19TXBXfYg1LOdmkEJ6s+pud62pK+2rjmn7DgUbrEInoF6YRWYzxbnBMhd311ntLbW1tYEMydVhBIZ/bGGySgYFKfhE7NTPh08qNdmo+KIrHKRCiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pSUx3S98; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461NoXJH002311;
	Mon, 1 Jul 2024 23:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jksTz
	6XDfABA0SSJnt+neunC6sbO5Is3A5qCATXIJm0=; b=pSUx3S98FMYEmnfHx7XLV
	s8oD25SLUNArJMI9YJ+zhPw36iY1QgaQ8AUfL58b+2hVZaHH6wDCbWkvbKU4KUej
	h84ubhNDmOKRFicCUO458eEwNkihrT02e/ZTaH2dy/dTu4uJUVGRlpmqFyJEYq5o
	DiWKZFKXFGbDzu7cM51bKX1aU0jFHIAANX1lESXl6TpZhXC3wYdBaJR2J0aimmCW
	IDGHCzKiWP6rlzxGAw77vBdoBoG62Er7ntnMHY82jBD3FosXipFdJ6BaEm1yr0dX
	p0c71YNmXwmUcWANhtUzCzuWFsLFYXyEuRCOfe4kRVooGtAAy9Nsh6xJEEzNkKZ2
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4046g1gkj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:01:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 46231Jq0041358
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 23:01:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 1 Jul 2024 23:01:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 1 Jul 2024 23:01:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 1 Jul 2024 23:01:16 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.28])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46230WbQ032046;
	Mon, 1 Jul 2024 23:01:04 -0400
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
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v5 5/6] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Date: Tue, 2 Jul 2024 11:00:24 +0800
Message-ID: <20240702030025.57078-6-kimseer.paller@analog.com>
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
X-Proofpoint-ORIG-GUID: chWelC81BlCochIMPCUlfEm5kIDH1ZM_
X-Proofpoint-GUID: chWelC81BlCochIMPCUlfEm5kIDH1ZM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_23,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020020

Add documentation for ltc2672.

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
index 000000000000..4c78e46c58d8
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
+                    reg = <0>;
+                    adi,toggle-mode;
+                    output-range-microamp = <0 3125000>;
+            };
+
+            channel@1 {
+                    reg = <1>;
+                    output-range-microamp = <0 6250000>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2629e818ffdc..68685b2a3e77 100644
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


