Return-Path: <linux-iio+bounces-15641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D073BA382C4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 13:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490331892AA0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D121B907;
	Mon, 17 Feb 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vXpxVTpT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46421A455;
	Mon, 17 Feb 2025 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739794464; cv=none; b=Fwv60s86BYOz47yy+ArQohVKKAzrSYPJP39FvXaw4cAK/FuuJ1TcR4dfPvIrprzI+1AYSLb3RDgcFqC44cOjqYXk1GjC+uBVsg2PFD6hpU7ORCFaXB9tXh0gzxlL39Bgh3PrsV44zsNmrWLgRM3b7gV4HPY0TeD1BlOlvxJp4ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739794464; c=relaxed/simple;
	bh=8y6Os77UNdhpdM67q9W4orETtj2uBW3pwCUl3l10G+8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIr7G+vqka+/U5dvKfWosJd/MstocFBPf6GF7DQ9pm3I1Y4oJJ6e89DxF+/keaDaBVbRwkoPU7PHPfeIS4qAI+HFcXZg/7BRQBbshqdaBHfIsIQ1QfB9qRVBlML3mARV6Ynxwa2bI92byH8iFUREwGyMbFDq9hjfkFzXQmFG1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vXpxVTpT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HARWfn013382;
	Mon, 17 Feb 2025 07:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IMOJp
	knZ0meHeXaL6MLuO3SUChC1Uy4Cr3LuOyZlBuQ=; b=vXpxVTpTNy6CTLHhSSeho
	84dDRiDJtOOcIjBwZnoG9Cz4OHBpKaWok6lVInpmjW6gmeYb+F9Z0fiaOkcs1Cp+
	Qlnh11CuVhJgCnobHYKBbL0vXXcl48VSpURzsYdmNlikbBOfQZR2Ygnhc3G9Qgql
	K19VI1oWoWHDcGl5UCakSSv3wjNtLXR+6iL8Gx+ZVW5Hj9+zHOc0t6rjFkhEaD07
	zOJryW2d0cu0y97V+It+1v1KphkF/ifBwgGLGh3oPmyQXHj48XjEusiuqgajQzwO
	Yr0g78DpCMX0Z56JuqkfZzLTpprTsVu/71RmRPC6MFNrkqWWEN297MnaQbIUOhDM
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44trqcyw38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 07:14:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51HCE7WK017809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Feb 2025 07:14:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 17 Feb
 2025 07:14:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 17 Feb 2025 07:14:07 -0500
Received: from desktop-robi.ad.analog.com ([10.48.65.85])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51HCDZMS016764;
	Mon, 17 Feb 2025 07:14:02 -0500
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
Subject: [PATCH v8 4/6] dt-bindings: iio: Add adis16550 bindings
Date: Mon, 17 Feb 2025 12:12:17 +0200
Message-ID: <20250217101221.600898-5-robert.budai@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217101221.600898-1-robert.budai@analog.com>
References: <20250217101221.600898-1-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=a5XK9VSF c=1 sm=1 tr=0 ts=67b32810 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=R49muxxXEzkXWbzaYJUA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: QR7kC2z-1MLwiXtpRgJNt8ZBdATc2bPS
X-Proofpoint-ORIG-GUID: QR7kC2z-1MLwiXtpRgJNt8ZBdATc2bPS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502170107

Document the ADIS16550 device devicetree bindings.

Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Robert Budai <robert.budai@analog.com>
---

v8:
- added extra blank lines
- changes reset-gpios description according to suggested changes


 .../bindings/iio/imu/adi,adis16550.yaml       | 74 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
new file mode 100644
index 000000000..a4c273c7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
@@ -0,0 +1,74 @@
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
+      Active low RESET pin.
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
+
+additionalProperties: false
+
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


