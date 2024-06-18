Return-Path: <linux-iio+bounces-6468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6390C9CF
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6D11C23692
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E7155CAE;
	Tue, 18 Jun 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ov6KREqx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EB14A62B;
	Tue, 18 Jun 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707964; cv=none; b=giGi08b5jY4sastvmKsSqRv7gV2Uh/E6yudAGdzqTrb3COVBmr/ALL+y/xOcWwwyFEvc+BrRwVgQ9Mc1xfw9kDFI1SKTpYiQKCVx5RfkjfOlk3GmQAza4PnCjFDzvF6OMBKRSIMbOqSkPKR1kZnyt5syJb1PTF7S/4Y3ysTPlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707964; c=relaxed/simple;
	bh=PStlxCg0Yn+hSsz17AdTX+Yu5sTSazftZUeKH5skRYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H9qpCxxEQXsZ+uVIhRQoPWJCaRVQy408Wicx1MpbsqyMWRH2YAJ7w4Eakjk8TfbVhx9lp8lrQZ/PMMT7QioRFoIcEb7Nc+v+Zi3+BlXFzRNglGNAC97bp7n3c32aBj+tHydAxuRxJ+q/Is/uuuMgg0xSjeLCoiRhafKfqg6nZ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ov6KREqx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAYRDD007465;
	Tue, 18 Jun 2024 06:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=LF8rafwwJ18wMjJApttWCsXEq0k
	eigzP29TsId0Pwjw=; b=Ov6KREqxcqD0looOqhgEc1gjy86Qvi7+2t0HHNd2PQh
	2nldKQwCWoMKsQEC4oAedg93/zN7XvbteqsjN6vFiRxzVk2QSy3+9hR6HGA0WH/B
	423x/gfRj6/bXTI26NrVDUCF8T2M7T4pxVCQOvvryiSX9Qfz0ExT1yf2mnSYW5uU
	KS6fgef78z2VpK8dWUmiGh0+ci64MMr5qYKgYly7jSk80CjEDG9ZMLq3URHV67Ov
	PI8AzzJK4eDDbFfM4M4u5fz8WOiOm97GSISt9mTbkwcjLv7ccEBvY6uorkl6Pyg4
	gMB/fao3ITUI+ubOFotYJWtmirU6/Cx+FdHsDYsDBMg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys7v32c86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 06:52:24 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 45IAqNKn010770
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 06:52:23 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 06:52:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 18 Jun 2024 06:52:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 06:52:20 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IAq1xm010996;
	Tue, 18 Jun 2024 06:52:03 -0400
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
        "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello
	<mario.limonciello@amd.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 1/3] dt-bindings: iio: accel: add ADXL380
Date: Tue, 18 Jun 2024 13:50:54 +0300
Message-ID: <20240618105150.38141-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: g_er1EJ2Z9Jif94dzS7heBcdHXGwrbiZ
X-Proofpoint-GUID: g_er1EJ2Z9Jif94dzS7heBcdHXGwrbiZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180080

From: Ramona Gradinariu <ramona.gradinariu@analog.com>

Add dt-bindings for ADXL380/ADLX382 low noise density, low
power, 3-axis accelerometer with selectable measurement ranges.

Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/accel/adi,adxl380.yaml       | 83 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
new file mode 100644
index 000000000000..992e2ab841e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
@@ -0,0 +1,83 @@
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
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
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
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b68c8b25bb93..2adee5198891 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -608,6 +608,13 @@ F:	drivers/iio/accel/adxl372.c
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


