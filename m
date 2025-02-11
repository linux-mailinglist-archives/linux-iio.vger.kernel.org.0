Return-Path: <linux-iio+bounces-15369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53320A31645
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 20:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBAF3A20E2
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7342641F2;
	Tue, 11 Feb 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oDezxTCC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D102C2641DE;
	Tue, 11 Feb 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303944; cv=none; b=OIM49u1qfwWBoHTtb4cSNz8xnKzP7v8snvFhwvxg9IBuK7to/Vq1AtLSPzcFtVtSHCG0DvptZSac2NcVfNfEDRDnTK/pIWuyacA03S5aqJ4/UnGG8QIL0NdEVXl5mwDdzv/PItmLQytdv3zXQNd8dGLv9AREM6CBlMammfsXV3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303944; c=relaxed/simple;
	bh=pk0dE3jWIp2mV+M8rCD1+ry+6ym2ZfPpI5W3SlEELCI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr8he4ojcWlV6+vW3NvQzYyycGA99i26NbP814bbhqdmABjptG52Flv8+Mt8ffk/6rVrZrQ688MHl652WQFvkSMfh+FGvp0xfwM+hA76TFf3Xn6N247L+IMBxtCftJO3HNWwA9XSVwogfWUEw2ppWiQ+K6Qb0yAOLzOT5Fe59jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oDezxTCC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BJAUhV002747;
	Tue, 11 Feb 2025 14:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a3dok
	mUJp+evdf/DyLLSiGp0MpLEmvPYdgx6ztZG520=; b=oDezxTCCuz9rmQnFVt6FT
	W7vcKG4QIKY1WhbZrMxb06f8NFygu8GbdW/jm0LUlyPU1aLACQZPza2fv/3IqnIH
	/MxkmH4s5p4V0IJhQJktpzawIBgqiuPhpYZeRJEEfsEaw95lrxnzs/fRnt2ra40t
	+5RnOY3wNDKij/kgjVYAdLp5BZck13okjoBVPOlQAKBKWqoRjD63Qx0JK2lK52CT
	4zjqbU48qqu0fW7PFRlAJX1An2sGzDb6Thn9PeWwFlBZYaUTehJKbj8wsTkjPxNU
	F3IFI/t7zDCyCYqkL7zVs7DifgtmI4L5H+fHgAtWln7Xq6qU5mkmVB9vaU04xTBy
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44r857hd1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 14:58:49 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51BJwlik065157
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Feb 2025 14:58:47 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 14:58:47 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 11 Feb 2025 14:58:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 11 Feb 2025 14:58:47 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51BJwFRD031076;
	Tue, 11 Feb 2025 14:58:43 -0500
From: Robert Budai <robert.budai@analog.com>
To: Nuno Sa <nuno.sa@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Robert Budai <robert.budai@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 4/6] dt-bindings: iio: Add adis16550 bindings
Date: Tue, 11 Feb 2025 19:57:01 +0200
Message-ID: <20250211175706.276987-5-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211175706.276987-1-robert.budai@analog.com>
References: <20250211175706.276987-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bNXsBfHUy38j3oqlDydPe5C6SNCX6l8g
X-Proofpoint-ORIG-GUID: bNXsBfHUy38j3oqlDydPe5C6SNCX6l8g
X-Authority-Analysis: v=2.4 cv=U5VoDfru c=1 sm=1 tr=0 ts=67ababf9 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=neJRz3qJz1uz_Or4AKoA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502110129

Document the ADIS16550 device devicetree bindings.

Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v7:
- dropped clock-frequency binding as suggested

 .../bindings/iio/imu/adi,adis16550.yaml       | 73 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
new file mode 100644
index 000000000..b55cd0f7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
@@ -0,0 +1,73 @@
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
+  - Robert Budai <robert.budai@analog.com>
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16550
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
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
+    description: If not provided, then the internal clock is used.
+    maxItems: 1
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
index 25c86f473..d3e6258fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1485,6 +1485,16 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 F:	drivers/iio/imu/adis16475.c
 
+ANALOG DEVICES INC ADIS16550 DRIVER
+M:	Nuno Sa <nuno.sa@analog.com>
+M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+M:	Robert Budai <robert.budai@analog.com>
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


