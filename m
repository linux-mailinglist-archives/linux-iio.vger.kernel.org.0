Return-Path: <linux-iio+bounces-27956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E040D3A6C3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 12:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E52C33008F0F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B931065B;
	Mon, 19 Jan 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bYCkcq7N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E030FF3A;
	Mon, 19 Jan 2026 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821940; cv=none; b=BKjX/jJuXEAeJ4OylIqKKyd4fSX34rPWgNM7gWDOGmwKGuCWgF9gw73VP253NAVk++Ui0oZ0w0BqRt1QT5+H8SMkGSEcw2XH9h3r89FyXL3c0n/jsbPKMLJZ9NfTj6CcjZjAEoNTo1p9ZzaMrIQ5cDYikmB0KCo3W2KYfqi9EW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821940; c=relaxed/simple;
	bh=1CwT5vzAfpN7Fw7yzF9dpywP+ZKx1ta/8L74orbGr+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TVrqXSwehWHM5wS9LOI59CZQMVnbupGg1/o62kfdci4bhqlBBAACZTWKfed+PDDcSS3IceIgEXF9J/hOSoWrE/NDsbujVXQ7vHnXEntt+4GwBxMHdLUBOaa1RJaH7kq0Y5C0aSMXoTLvva5Wr44xa0Cn6M+IsDdzHcqMRvGbJDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bYCkcq7N; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J7x6uA2897195;
	Mon, 19 Jan 2026 06:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pS1VD
	V8VPI+kSQM64fBij25pElStbfin/YWMMDp+7rU=; b=bYCkcq7NbknYKueaF6rDf
	tYpYK/k6V5gkNCW37BDP/T/QHCEpBrKye+95GgA7hQfs8ycKpLlMs1nxHgLnVwEY
	zN+bIJrYItoFylN14LoczUWxUXrKf9rKzqi12LhL34jqD6TrbjrwP8NSwNQkUg/d
	aY9Ub4Rju8Np1VwDadtxG8MOIS1NpjoXRh0y2oEelR+KNmQOu+vf+THetReuhQ4z
	VYHfnYpxNwAHcTc8lH6294qzNGyg+NMO406oAXJI0d4JohInjbjHy8IpO0XCqk/M
	fCIeed0mDdwQplMvm6wxLd+v5WvzTz/NWlCupaAXG2Tlx7TT0p54tKLR2J28r9c0
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4brsmgv7mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 06:25:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60JBPFI0041193
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Jan 2026 06:25:15 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 19 Jan 2026 06:25:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 19 Jan 2026 06:25:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 19 Jan 2026 06:25:14 -0500
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.126])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60JBOwHr023363;
	Mon, 19 Jan 2026 06:25:08 -0500
From: Janani Sunil <janani.sunil@analog.com>
Date: Mon, 19 Jan 2026 12:24:23 +0100
Subject: [PATCH v4 1/2] dt-bindings: iio: dac: Add max22007
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260119-max22007-patch-v4-1-e22404a885a6@analog.com>
References: <20260119-max22007-patch-v4-0-e22404a885a6@analog.com>
In-Reply-To: <20260119-max22007-patch-v4-0-e22404a885a6@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jan.sun97@gmail.com>, <gastmaier@gmail.com>,
        Janani Sunil
	<janani.sunil@analog.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768821898; l=4501;
 i=janani.sunil@analog.com; h=from:subject:message-id;
 bh=1CwT5vzAfpN7Fw7yzF9dpywP+ZKx1ta/8L74orbGr+c=;
 b=FtUULZRnl7RxPYdcx3w9iUFLH7Ohr/1OAzjZLafIafoIKI+5nojdF0+NztWpF3/q3H4cRpqC3
 iWu9M02K7VLCf0xXcS+QNDCFKcvi6yk2aSRFiK7PjBMAS53ePo6UkoT
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xdJUUY_-Yg9GMmO2lCa7ufH7fIXPBmiS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA5NCBTYWx0ZWRfX92E2LdOE6WLC
 Kv1j0iUBXJErMf0gPy1RW0GNuhNYgpKU7cDhFMmhVY1/8OsOP+I0mH3WsmFDpWG+biXyvS8wUwA
 7cghWoNiS35upjGd2vAPCL8cGCA/h2ZgmwCqW6cRBT+9rklwhkoPbqM9L09cAmyM7bnOw2iIiAU
 jIl4rIvRI4CSc92bV/YFdiDtGhX1F3MKn1f9YbSYmlSaopPMHbRuIT4V+8zmocsd/JKKOQNjIMv
 5VU5InPg76HiMwn1t/AL7FV5IrdzB2Qabiji2Ifomrv8QMbsYwsIPzPQAh/bI8fC71YD2sgn4nM
 xZclk0oFZqfRFiRBUf9a26JiiEU8pjdoq6jeHIqsyyEfztznvY7uAMiLTHvxsHwLr/JuI+qnw2w
 cqu2cqrDVq+S/SDeSwOmuCpnuFP745EW6XHaZiEdGybtlH57iy8yN9UfrYl0k/JEzDX0m1KpOVf
 lSJIf94TZ+R8iHuilcg==
X-Authority-Analysis: v=2.4 cv=fr7RpV4f c=1 sm=1 tr=0 ts=696e149c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=5yLO_ytG1KKSPBdCm3cA:9 a=QEXdDO2ut3YA:10 a=9pxso9FRmSwA:10
 a=kMJE-xFm7jYA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: xdJUUY_-Yg9GMmO2lCa7ufH7fIXPBmiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_02,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190094

Devicetree bindings for MAX22007 4-channel 12-bit DAC that drives a
voltage or current output on each channel

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 120 +++++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 2 files changed, 127 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
new file mode 100644
index 000000000000..93d95f6b4c08
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,max22007.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX22007 DAC
+
+maintainers:
+  - Janani Sunil <janani.sunil@analog.com>
+
+description:
+  The MAX22007 is a quad-channel, 12-bit digital-to-analog converter (DAC)
+  with integrated precision output amplifiers and current output capability.
+  Each channel can be independently configured for voltage or current output.
+  Datasheet available at https://www.analog.com/en/products/max22007.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: adi,max22007
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 500000
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vdd-supply:
+    description: Low-Voltage Power Supply from +2.7V to +5.5V.
+
+  hvdd-supply:
+    description:
+      Positive High-Voltage Power Supply from +8V to (HVSS +24V) for
+      the Output Channels.
+
+  hvss-supply:
+    description:
+      Optional Negative High-Voltage Power Supply from -2V to 0V for the Output
+      Channels. For most applications HVSS can be connected to GND (0V), but for
+      applications requiring output down to true 0V or 0mA, connect to a -2V supply.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Active low GPIO.
+
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: /schemas/iio/dac/dac.yaml#
+    type: object
+    description:
+      Represents the external channels which are connected to the DAC.
+
+    properties:
+      reg:
+        description: Channel number
+        items:
+          minimum: 0
+          maximum: 3
+
+      adi,ch-func:
+        description:
+          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
+          output or CH_FUNC_CURRENT_OUTPUT for current output.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+
+    required:
+      - reg
+      - adi,ch-func
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - hvdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,max22007";
+            reg = <0>;
+            spi-max-frequency = <500000>;
+            reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&vdd_reg>;
+            hvdd-supply = <&hvdd_reg>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5b11839cba9d..48559d2625b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1594,6 +1594,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
 F:	drivers/iio/dac/ad9739a.c
 
+ANALOG DEVICES INC MAX22007 DRIVER
+M:	Janani Sunil <janani.sunil@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
+
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0


