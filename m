Return-Path: <linux-iio+bounces-13544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E859F339D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 15:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E37163DA6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD9B61FDF;
	Mon, 16 Dec 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j84hH9xy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B03BBF2;
	Mon, 16 Dec 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360585; cv=none; b=qUCQhaohzjy766U81bRHZrDEVityx8u6DEDdpQIgy85Rb083F765V3t/zM9cfu6pqxTAPo7ApwrvS3gEFeWI7LRp7RWYNDGXkmBwGBVJfqXLmEbAlfkLTQhD/mClYeEWqHzFRSaTD5r8x8hh74i+/QRgfNvKzF42YfocgFyQNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360585; c=relaxed/simple;
	bh=V+rfOs21s0y/XFtvfKSHF4IPz8rMuh+QgxG1UAIjh5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHH8+DcVVv5BDhy0uDrKrb7URKPv/GnEZUd7bQW59MZ3hhQ7axi8m2mtH7t2za6WxERcWd3Gt5cP4XutUcpRYRBXPmvdPmotRJ7/1K0kCd5uOI6y/Tdp+U0lljL5qSyQSpdNw7zBeuc9Fj1nWARsqpTxGa4lol9ehktgGx5Zlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j84hH9xy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGDarrf020252;
	Mon, 16 Dec 2024 09:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=N3JB6
	M9ThdaM8yXOdsYnUyCqlonCcA3IOSIzdjAtzUM=; b=j84hH9xyEqUGTsLiFDmvb
	enFHD3DgSSwsvyzLAw9OigR0vk7GE3oHFMmYamm52t7fq/qnbeS0pHvzXj682jS9
	mOuNpJlgflvaH3fHClF1wmt0EKugy3PyQqx0gzeIkmrMwg/I1RAHNB1sGQu8RDc/
	FZQZXOBvDyiso+wnNyZzuqFCIRiodNo8FXNGIzNjICi17iVbSVw8W13jjs2KmWGj
	SE/wNCSdpzS5jMizFyA8oibrjHziK8GdN/7M7iocs0atcm98U38dAmVpYN/+/eif
	tok2Oggt794ZUexCfrPLwNufM6HmFk0MqJyOfh+/Q7olGYOOKIYztdRhPXr/BIQD
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43jn8cg9jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:49:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BGEnQiU035995
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 09:49:26 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:49:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 16 Dec 2024 09:49:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 16 Dec 2024 09:49:26 -0500
Received: from dell-precision-robert.ad.analog.com ([10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BGEmKdm018405;
	Mon, 16 Dec 2024 09:49:19 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shen
 Jianping <Jianping.Shen@de.bosch.com>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        "Robert Budai" <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <robi_budai@yahoo.com>
Subject: [PATCH v3 5/7] dt-bindings: iio: Add adis16550 bindings
Date: Mon, 16 Dec 2024 16:48:11 +0200
Message-ID: <20241216144818.25344-6-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216144818.25344-1-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1E6ExpUBTjtfKnKA-0-DhgKXlaCb3JOV
X-Proofpoint-ORIG-GUID: 1E6ExpUBTjtfKnKA-0-DhgKXlaCb3JOV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160124

Document the ADIS16550 device devicetree bindings.

Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v3:
- changed sync type to integer
- conditioned clock only on scaled-sync
- added: unevaluatedProperties false

 .../bindings/iio/imu/adi,adis16550.yaml       | 93 +++++++++++++++++++
 MAINTAINERS                                   |  9 ++
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
new file mode 100644
index 000000000000..e0b07b912484
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
@@ -0,0 +1,93 @@
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
+      RESET active low pin.
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: If not provided, then the internal clock is used.
+
+    adi,sync-mode:
+        description:
+          Configures the device SYNC pin. The following modes are supported
+          0 - direct_sync
+          1 - scaled_sync
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 1
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
+        adi,sync-mode: 1
+
+    then:
+      dependencies:
+        adi,sync-mode: [ clocks ]
+
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
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
index 1e930c7a58b1..5522bf5e2ef1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1453,6 +1453,15 @@ W:	https://ez.analog.com/linux-software-drivers
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


