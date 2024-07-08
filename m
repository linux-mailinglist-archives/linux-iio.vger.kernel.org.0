Return-Path: <linux-iio+bounces-7428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4EB92A065
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A81C214DA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651377F0B;
	Mon,  8 Jul 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a2mJkDs0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F9D77F2F;
	Mon,  8 Jul 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435354; cv=none; b=hcnLhIrYodS9cJaGSgJmq5aUACsn9acjOH/NxBD1jwqqI4T2PpCvpUa2rMwKq7xIE31iV6d7NHXdkvqYNFhX6Q5Tu46Mb2IT8rrjBCdKVYn9LD6853qpElTuO00JsQybBfpn5DHS7WbQ9I4WoQ+MVNpGNZ10olWDLAJw1PPX2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435354; c=relaxed/simple;
	bh=i/kHEvju2I6c+qBQX8v1bX565zHgz0y+711zN3vWcZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=An8VX17goDoof/jE8wj9SjqEbc2wqbcr5CusJZbTjLHSBp6djiW5VJK+tuKtSSACQJpsZUKqE/xzUjRgwKe3cV3wHmT8pDLG435HWm1udYmLp9rM1mAXCVdIIZmEd2ta5peBgynppXhbPU4pbqnc0i6S1Aa20d28vhxM1VkjfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a2mJkDs0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46889YRM015055;
	Mon, 8 Jul 2024 06:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=9C39xYUzc+KtN/fSDo0lILdCzlb
	q4vaUdJ1kkUuwPHY=; b=a2mJkDs0Eu/R7M6ipECMy6fKK5imKFSsl3zdlFq5Jzk
	3ewQacT9Jg3Bz/Wrs5Um/nF3SHicyR+AWK+/Dvf0Va0aK6ebul8Tsu8etRqGovBW
	ErK/2gyvWshHg8ADlavStVGzeSITgNLlJ+R8jUbZEqXsDmSpoZo51iyU7f+9/qME
	MdECeRodJVSMlF3hkju2fY+64nI/DuqJl9XWk2iDo11oRqQK8mOkIJm8Q0sCPPFw
	Ox2Bzl0sslGwf8WckF//zfeKYWR5txRfDNelGK9hqn1vhc+w5Tfctfyb11Is7f6e
	lHKeRGkP1gNpHnhveEKfqNnvIdUClRjHf5MecVaw0FQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 406ys2nt3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 06:42:01 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 468AfxHu001202
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jul 2024 06:42:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 Jul 2024 06:41:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 8 Jul 2024 06:41:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 8 Jul 2024 06:41:58 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 468AfZLI008375;
	Mon, 8 Jul 2024 06:41:38 -0400
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
        Sean Nyekjaer <sean@geanix.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Mario Limonciello
	<mario.limonciello@amd.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/3] dt-bindings: iio: accel: add ADXL380
Date: Mon, 8 Jul 2024 13:40:11 +0300
Message-ID: <20240708104114.29894-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: OppW38yYS8VqOleUvm1gJpbDIiTy6nug
X-Proofpoint-GUID: OppW38yYS8VqOleUvm1gJpbDIiTy6nug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_05,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080083

Add dt-bindings for ADXL380/ADLX382 low noise density, low
power, 3-axis accelerometer with selectable measurement ranges.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
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
index 06ecfa64a39a..fe24becaeca5 100644
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


