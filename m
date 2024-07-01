Return-Path: <linux-iio+bounces-7093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B5D91DA55
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D465B226CC
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A215F8289C;
	Mon,  1 Jul 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ewDwjb33"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BE82D69;
	Mon,  1 Jul 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823610; cv=none; b=HUlV1PLz9LzHqJPEEliz5NpAZ7oFjdMGAursqwga6U3cSIKWReLon0pdfsM6DbuPWurqE72uUmdywvR7tKBEKkb0tgisjSD7NYSZfK2Od3IqZKARpudV5ofDcse6/OSxS6jDYk2qE92U9Oug4jf6Io83Qfz2PM9HzPEBeFUL0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823610; c=relaxed/simple;
	bh=ccuBcuwhx7ikJOxIjJGxDBPbz8W9hAPA7qvWrMla4f4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=exvJ3XwxAh70Da3xDulU4XrY2SrKEpdU3a84gUlm7aw2OZ49BzES1MCJ6Xq92S7USdDvMsttAZcjBVSFcXIHLxPQyxIELp5xBS+4HgD8zeKDFP2tf1HG+R26Co7FPYLqewnJgHJs5b+5fZeu1YKiluxw1CfI+3MxkOc2a3hkSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ewDwjb33; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4615jS3l024945;
	Mon, 1 Jul 2024 04:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=uCdLKw4CDp7CCZCSGHD2siartWD
	U88/GGTxkeUKosAg=; b=ewDwjb33/0k1NkZKP5ci26eUrCvK710B5JsJyJQZ9Co
	oLIdpa/SrynK5IOjwB7NFhrmzqNPXdswdJSAWh10tSSbFzA486xV3Rzy2ZeuY3wY
	VyD76CCerdgaNXfA36eVZpShxabNWjMCry23xEATlnmTDAZvoBeBpnuHFqvN+yaq
	KVNTuIbfJTLadXlo4SFE9XCAmjcfNznurrb48aE43nguYGz5AjhpXJNC2PXJD0rz
	5jxBlT2ISkFa7PwQc2sxp+0AIkqNQxERy1eovxeXyRTzV140rvkPVZfAWRLzm+pY
	YyXJKnY0DuJ/GiS7bBLsLvlem9DrcRmWdYuX7Je2umw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402f6358uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 04:46:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4618kHLW037330
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 04:46:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 1 Jul 2024 04:46:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 1 Jul 2024 04:46:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 1 Jul 2024 04:46:16 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4618k0L9004394;
	Mon, 1 Jul 2024 04:46:02 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael
 Hennerich" <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        Jun Yan <jerrysteve1101@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        "Mario
 Limonciello" <mario.limonciello@amd.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: accel: add ADXL380
Date: Mon, 1 Jul 2024 11:30:42 +0300
Message-ID: <20240701083138.15891-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: fSl5XYzB1wS4PxDTreLn3hX1Ynf6RYpB
X-Proofpoint-ORIG-GUID: fSl5XYzB1wS4PxDTreLn3hX1Ynf6RYpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_07,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010067

Add dt-bindings for ADXL380/ADLX382 low noise density, low
power, 3-axis accelerometer with selectable measurement ranges.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - drop marketing from description.
 .../bindings/iio/accel/adi,adxl380.yaml       | 92 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
new file mode 100644
index 000000000000..f1ff5ff4f478
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adxl380.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADXL380/382 3-Axis Digital Accelerometer
+
+maintainers:
+  - Ramona Gradinariu <ramona.gradinariu@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The ADXL380/ADXL382 is a low noise density, low power, 3-axis
+  accelerometer with selectable measurement ranges. The ADXL380
+  supports the ±4 g, ±8 g, and ±16 g ranges, and the ADXL382 supports
+  ±15 g, ±30 g, and ±60 g ranges.
+
+  https://www.analog.com/en/products/adxl380.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adxl380
+      - adi,adxl382
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - enum: [INT0, INT1]
+      - const: INT1
+
+  vddio-supply: true
+
+  vsupply-supply: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - vddio-supply
+  - vsupply-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      accelerometer@54 {
+        compatible = "adi,adxl380";
+        reg = <0x54>;
+        vddio-supply = <&vddio>;
+        vsupply-supply = <&vsupply>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "INT0";
+      };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      accelerometer@0 {
+        compatible = "adi,adxl380";
+        reg = <0>;
+        spi-max-frequency = <8000000>;
+        vddio-supply = <&vddio>;
+        vsupply-supply = <&vsupply>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "INT0";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index be590c462d91..1425182c85e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -618,6 +618,13 @@ F:	drivers/iio/accel/adxl372.c
 F:	drivers/iio/accel/adxl372_i2c.c
 F:	drivers/iio/accel/adxl372_spi.c
 
+ADXL380 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
+
 AF8133J THREE-AXIS MAGNETOMETER DRIVER
 M:	Ondřej Jirman <megi@xff.cz>
 S:	Maintained
-- 
2.45.2


