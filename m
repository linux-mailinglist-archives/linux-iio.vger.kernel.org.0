Return-Path: <linux-iio+bounces-14690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D2DA218E8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8663B1658C0
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB31ACEDE;
	Wed, 29 Jan 2025 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xycNzTNS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8B1AB52D;
	Wed, 29 Jan 2025 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138897; cv=none; b=APCr5nfbB+NQxLdOZX+CD91m6Iul7he/gooT3XbiPsz/cnCe/ormL6HnFqfaWjVhsIPC24oKgiXqjWjECMGBBZibzhrIposxD/uPKSy+d3KRfHI1WfLyuhb//RNpE/WbCoycn4RZWBVf0MTFZ0LN9p0eCFqFzsqdRipZlZUNpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138897; c=relaxed/simple;
	bh=//+8dWqDwRHYvO419D2usv4wKg8pCRda8S2fGTCz408=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqJsib1uWbeOHHc5kzWhj8CMGtN4eNxLrQt+S98/My2wNn81fDuhh87JuF9qmS1lMkoM8c5XrbTEzrt458uIt4eTnwYAhPWIEi3ocW43qIl1aksOPmdLPz+sWhMuWQIAw09GKwo48NiXNJJSi+0zREa+bacspfjLYrVspYcgLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xycNzTNS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T6iu2E001626;
	Wed, 29 Jan 2025 03:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TT2DG
	XBa/HTdJz7vtGFxe6AAPDT4QYfKxuYbhU53qr0=; b=xycNzTNSyin3l3HbX9QpR
	HkYFOyL16gnO06E2MR4zVoqN1cfnyRqS5RIqOxxgzbfywp5EXv0isur2TmTYXi0X
	gvp98dzhJ/3zkuMDkYUlGMQehOTgklaIhGvj9QY9uFygzsklg6FhZTTDbqq5wUvO
	EF7SgABiVyrdZTxiAUXAIJ7J88tabFjM8UhAURVi0/fAdSehGn8YQIWtZoQuUOBT
	a3Xhm7q4KXomsKg/gsggzKOGeRrjYYSkThmG9FpZ5XEgOvLzhft/LPrFL2RyVAtg
	757zm7f1UgVDOUZZGHiabVgTWBhw+Bmm1wtrvib/Jistnv0EFn7I2xV+BE0jzWVL
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44f1jaucvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 03:21:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50T8LK0Q028243
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jan 2025 03:21:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 29 Jan
 2025 03:21:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 29 Jan 2025 03:21:20 -0500
Received: from robi-Precision-5540.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50T8KtHK025874;
	Wed, 29 Jan 2025 03:21:12 -0500
From: Robert Budai <robert.budai@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <lanzano.alex@gmail.com>,
        <robert.budai@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v5 4/6] dt-bindings: iio: Add adis16550 bindings
Date: Wed, 29 Jan 2025 10:20:44 +0200
Message-ID: <20250129082053.19077-5-robert.budai@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129082053.19077-1-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mtq6RaVWlZEO3Q7bkdvL3cUyH-amsvk-
X-Proofpoint-ORIG-GUID: mtq6RaVWlZEO3Q7bkdvL3cUyH-amsvk-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290067

Document the ADIS16550 device devicetree bindings.

Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v5:
- removed sync-mode binding
- added binding for external clock frequency
- removed adis16550w

 .../bindings/iio/imu/adi,adis16550.yaml       | 80 +++++++++++++++++++
 MAINTAINERS                                   |  9 +++
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
new file mode 100644
index 000000000000..4e9406168782
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Analog Devices ADIS16550 and similar IMUs
+maintainers:
+  - Nuno Sa <nuno.sa@analog.com>
+  - Ramona Gradinariu <ramona.gradinariu@analog.com>
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+properties:
+  compatible:
+    enum:
+      - adi,adis16550
+      - adi,adis16550w
+  reg:
+    maxItems: 1
+  spi-cpha: true
+  spi-cpol: true
+  spi-max-frequency:
+    maximum: 15000000
+  vdd-supply: true
+  interrupts:
+    maxItems: 1
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. If specified,
+      it will be asserted during driver probe. As the line is active low,
+      it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+  clocks:
+    description: If not provided, then the internal clock is used.
+    maxItems: 1
+  clock-frequency:
+    description: Clock frequency in Hz when an external clock is used.
+    oneOf:
+      - type: integer
+        minimum: 1
+        maximum: 128
+      - type: integer
+        minimum: 3000
+        maximum: 4500
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
+        clocks:
+          maxItems: 1
+    then:
+      required:
+        - clock-frequency
+
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+additionalProperties: false
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index aeb5f3cc58a1..5c59a183cd3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1479,6 +1479,15 @@ W:	https://ez.analog.com/linux-software-drivers
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
2.43.0


