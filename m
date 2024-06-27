Return-Path: <linux-iio+bounces-6979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A8E91A3C6
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 12:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99301C213B4
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2024 10:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA213D8A0;
	Thu, 27 Jun 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qygZK2Wh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75579F0;
	Thu, 27 Jun 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484243; cv=none; b=eUVSI9xAfG3bIpcp9nS9STQdqkgIUPs0fyQ/wAH66y4KGocpUWuq0VaVhEen+lqhi8G2UYzcFJtv8zqP9H2AJr8xQPZvMzuDx5mkDCzDZlWirDphE3jjW6y7PhYsgqchAXu7vEUqea0C+XBVZbVG7X6EmRv0e5Lfsxf6tlUHzYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484243; c=relaxed/simple;
	bh=/8NyOuFrsIHdO2r91wTRCS6o5U3GDI7g+a4G/f08Uik=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lDmmZEuJH8zgHoC/PZju26HIJ/qRN/aD/6VCSlay1fpHg1/sGrlGr8ZHjNE34qbzgI88e5SqzGQIRM+5OCuUTnfCXxGh21fjv4v1EUAfjvYIJfRoipQ4ue8HkaMH2Fk2hq8TzTPF6KvC8DlLXmiUQaJjVu9TVJIz7gDWAuui094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qygZK2Wh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7Gb7S026083;
	Thu, 27 Jun 2024 06:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=p/OShLG1DvzLaxgFY9eCBJu8cE0
	1k/tVxLTHfdPqOsk=; b=qygZK2WhuamKcY3IlX2VLF5WgAz0tcHZQ74NJfJVvEb
	FYZazO3bBbifKrIhFGJgQd9MEpuAo6ZoFDrGO3teUUXhdLJgAtU7LtMnuHHcP3R6
	D7/kKrgmUmuPmyYYlhJDnKXjNrnzFEAOKrnzuEArLvlr3vOGJ5Y3G8BGy8gQ/5yb
	d4Aac/xZNVbkV/DhQazcSNMZqeSeARhlFw2OXS5TEJsNWV776KZqcBW8DYHJjp7+
	KxDVkfQw1frY0gjFLIrQSbpXMNPDyS5w5BOr0H1vZiGaAO73y3zA27UkE8iSSDNo
	aG1J9k9DjMRF4CsVaqz3/ADhNsjwvein7j2nXZMaqnQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4013j48t9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 06:30:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45RAUGIh059536
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 06:30:16 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 27 Jun
 2024 06:30:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Jun 2024 06:30:15 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45RATvYQ018482;
	Thu, 27 Jun 2024 06:30:00 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Jun Yan <jerrysteve1101@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: accel: add ADXL380
Date: Thu, 27 Jun 2024 13:25:17 +0300
Message-ID: <20240627102617.24416-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: sF05aFnhZ5TVYScdDtWdQpNQVWYUpm4P
X-Proofpoint-GUID: sF05aFnhZ5TVYScdDtWdQpNQVWYUpm4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270079

Add dt-bindings for ADXL380/ADLX382 low noise density, low
power, 3-axis accelerometer with selectable measurement ranges.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - add power support
 - add support for both interrupts
 .../bindings/iio/accel/adi,adxl380.yaml       | 103 ++++++++++++++++++
 MAINTAINERS                                   |   7 ++
 2 files changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
new file mode 100644
index 000000000000..55e25a9b31ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
@@ -0,0 +1,103 @@
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
+  The ADXL380/ADXL382 offers industry leading noise, enabling precision
+  applications with minimal calibration. The low noise, and low power
+  ADXL380/ADXL382 enables accurate measurement in an environment with
+  high vibration, heart sounds and audio.
+
+  In addition to its low power consumption, the ADXL380/ADXL382 has
+  many features to enable true system level performance. These
+  include a built-in micropower temperature sensor, single / double /
+  triple tap detection and a state machine to prevent a false
+  triggering. In addition, the ADXL380/ADXL382 has provisions for
+  external control of the sampling time and/or an external clock.
+
+    https://www.analog.com/en/products/adxl380.html
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


