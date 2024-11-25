Return-Path: <linux-iio+bounces-12638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35C09D888D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3829B39BC1
	for <lists+linux-iio@lfdr.de>; Mon, 25 Nov 2024 13:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0BC1AF0CB;
	Mon, 25 Nov 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I0zcPdye"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF991ABEBF;
	Mon, 25 Nov 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541804; cv=none; b=SCZDvMePqiZEH1Fh2RMaouHXI+PQTnTcdhPcxFnzT0Ef3RXGyICmbyrwL5k/pOFf4Ctn0VfeHttQMZBT66TxTSNIbL2XsH2fVjsp7gBzS3TDVnTJaZ9pgNfz9v3Eyh/o60ddV33AVER6HGmujfhihglQT/rzqNzvoFq68C6VSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541804; c=relaxed/simple;
	bh=B6bSts6FalS/WVMupvec72o/d2wy1GWRk5tlur6sjMM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiLPbgb5sr2jVT5aVcS36zXrvlBdwL1r+Wj5s2wqIcavDnA4f4B2wIiYGlxdSKe3PDan+r1kETq3CkX7J+OT69ZwNyK6wbkFr+kxdVAx/2Yvf6Q5U51arh/Dny9+OQdYn3S+OU9am72TZBqmLUeoIy7ns/Fat+FT/D7yjMU/iNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I0zcPdye; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP9VtC5017858;
	Mon, 25 Nov 2024 08:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hrbsY
	o0tJ2wB9cGH61UOvdROZ5uIqy/CHxsR1REJekA=; b=I0zcPdyeUhGWCPaMLUHmg
	mho4nQOPQr5BXfZ4eL7lObHkCeejDq9m96gIOIvRZSvg+/ss5KSolzImcFdQ9m4t
	MUE8ogMhE489hPducJWXFZm7OGAQpidjAy8r6G3Tkb9UFAoPoYE9UK3E10pWQ4nv
	mRjt22oQFGvXAckdOnPYrwtLaLLEUgIsNMeW+tzX5TLaVFQN6ErLZwPde4UEHVxY
	DwtZZAcTB0xdcvntRwAVXGRZIJkXePskbXXhTz0eSyR1kokQHtixuE355hAUWsJd
	jgL31brTwenKKie/Yz3ve5ZQR4acHfBx+17NL8otbvD08xlU6ELXbqdPbjngC8XP
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 434pph0wgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 08:36:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4APDaRUD046424
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 08:36:27 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 08:36:27 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 08:36:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 25 Nov 2024 08:36:27 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.197])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4APDZR2F031415;
	Mon, 25 Nov 2024 08:36:21 -0500
From: Robert Budai <robert.budai@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robert Budai
	<robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH 5/7] dt-bindings: iio: Add adis16550 bindings
Date: Mon, 25 Nov 2024 15:35:12 +0200
Message-ID: <20241125133520.24328-6-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125133520.24328-1-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uwWIAAFvIZXMf-8omTLLjrh2kEbF9yfE
X-Proofpoint-ORIG-GUID: uwWIAAFvIZXMf-8omTLLjrh2kEbF9yfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411250116

Document the ADIS16550 device devicetree bindings.

Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v2:
- signed of by submitter

 .../bindings/iio/imu/adi,adis16550.yaml       | 97 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
new file mode 100644
index 000000000000..767b500afbaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16550 and similar IMUs
+
+maintainers:
+  - Nuno Sa <nuno.sa@analog.com>
+  - Ramona Gradinariu <ramona.gradinariu@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16550
+      - adi,adis16550w
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 15000000
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. If specified,
+      it will be asserted during driver probe. As the line is active low,
+      it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: If not provided, then the internal clock is used.
+
+  adi,sync-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Configures the device SYNC pin.
+      scaled_sync:  Device handles internally custom scaled
+                    sync mode. It is stored in a designated register.
+    enum:
+      - direct_sync
+      - scaled_sync
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-cpha
+  - spi-cpol
+  - spi-max-frequency
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        adi,sync-mode:
+          enum: [direct_sync, scaled_sync]
+
+    then:
+      dependencies:
+        adi,sync-mode: [ clocks ]
+
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "adi,adis16550";
+            reg = <0>;
+            spi-max-frequency = <15000000>;
+            spi-cpol;
+            spi-cpha;
+            vdd-supply = <&vdd>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a4628d566e98..b8ea8c9af74a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1412,6 +1412,15 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 F:	drivers/iio/imu/adis16475.c
 
+ANALOG DEVICES INC ADIS16550 DRIVER
+M:	Nuno Sa <nuno.sa@analog.com>
+M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
+
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.34.1


