Return-Path: <linux-iio+bounces-26549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F386C92D96
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 18:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0B624E47CC
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDCE32ED3D;
	Fri, 28 Nov 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hHNGMKGs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9902C030E;
	Fri, 28 Nov 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764352465; cv=none; b=SrNkMZHTcLD7g/GCsV/ArRJLRlexGZxuPq0bwHPBwKlMdloe2kwhlNH6jgD2rYjNiCXBiY9RKKfW8RKMzCC2j93egXU12Pa5gQOtW696DEy9bTo/xAclARImDFsLsrtUfZCf8FcssFSxIYknLuihKyGlphsIrhueRFjhovVPUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764352465; c=relaxed/simple;
	bh=nfg8ijWsrq/26EBsYgopDb7xFVSrHGFVksbDyLWr5RA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eg6aBhLZO+80bvKSpeZCezGcY/HrwCrUVrmUC22CZVPhIM7gsSf+pmUvOlQTOus4BMhw1DNfmmw19TxjvwsrkGJMS1GvawAyJ5zI4NW5+DjWYVRB6Oocunko92rVEyZreuglnsgFwMaMvPcJz8+fLeSZGplAxTp6c2d1bSZab9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hHNGMKGs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS9lmAY769750;
	Fri, 28 Nov 2025 09:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=686Es
	vQsEWdff/qeC69omCafaW5g+o0PR8F7f8iW46U=; b=hHNGMKGs4YjphJIK0sy5N
	jPBQ3x7MVt+Bn6Qd89Bnwfic8u/+CaHxw36nxLNEM4JN7WFxPcnaOUT0HeqWkWPO
	cSQIeTm9yVt6iPZxBthchB3D1h5XGFLC74sTgNYFKEe+aho7L/wcFgCkHB2pvdnW
	Hfge28b3N4wqZ5+kGBY278M0UBLoOn7L/oGtd7MMOZhUHnrfHWVeikIKsM2tPDgt
	pES5TrZwbId3zQXcl7q0a+yRjX0QVoN3Hcr9DsiO1PE8rfHeadymbbXpAVM5GqND
	3M7Lr+2zfIcX9FBbwd9StQN1FWZRaAVi1hM0BhXKhNiYlsslzCB5VQoS+QAs/LHA
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4aq0u5u7q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 09:45:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5ASEj65s026708
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Nov 2025 09:45:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Nov
 2025 09:45:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Nov 2025 09:45:06 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.13.98])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5ASEilHp011408;
	Fri, 28 Nov 2025 09:44:59 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: amplifiers: add adl8113
Date: Fri, 28 Nov 2025 16:44:10 +0200
Message-ID: <20251128144428.24450-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128144428.24450-1-antoniu.miclaus@analog.com>
References: <20251128144428.24450-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oR0wAP6bQJ50yK8MEd5VFZd4FhSi-YBW
X-Proofpoint-ORIG-GUID: oR0wAP6bQJ50yK8MEd5VFZd4FhSi-YBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDEwOCBTYWx0ZWRfX3lx1spDKIUQn
 rGlHxTsLUGqsipAlX73SD4pQ/gJjg2rKIsnOPh9YTWTrfdZH4cp8H0MkTOy+GPSA7ABmvmvWpXf
 WHr7NabvES5SbntBjMBjzdt7T0frG1csBEFW1WxRDelrEm341+T3ryDjTbrlwXFC/pMyQovXqOf
 A8mk9P20BwJhfk/uLdnYs6NQZXMifX6txVbzZg3XlUZAbxYQpbL68MdZ0A+wTcg4tqFKsrr0B34
 1uIzXKhaHJSH14jgxWnr5KZijdiq7j8mg93Y2oizQBGJsZ2BRVAcXlBeCymLAjh8/4nCvXxkZaF
 VsNg0kLPB98s4ak8Ryry6gegyesHBbwHaRyrhaUIWtGrAwh8LUwDp0t1l9vkw5CpDq1fx+8w8vH
 j317sfAaDMhJAQBvwCfIKKODNw/iSA==
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=6929b574 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=1yNy12B5puk2P9Y3jxYA:9 a=4Crt4hL0rqkA:10 a=shvgCOL7IKUA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280108

Add devicetree bindings for adl8113.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v5:
- Replace separate va-gpios and vb-gpios properties with single ctrl-gpios array
- Remove second example, keep only one with external bypass configuration
- Add comments to external bypass gains in example

 .../bindings/iio/amplifiers/adi,adl8113.yaml  | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
new file mode 100644
index 000000000000..43ba51f8a235
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,adl8113.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADL8113 Low Noise Amplifier with integrated bypass switches
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  The ADL8113 is a 10MHz to 12GHz Low Noise Amplifier with integrated bypass
+  switches controlled by two GPIO pins (VA and VB). The device supports four
+  operation modes:
+    - Internal Amplifier: VA=0, VB=0 - Signal passes through the internal LNA
+    - Internal Bypass: VA=1, VB=1 - Signal bypasses through internal path
+    - External Bypass A: VA=0, VB=1 - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
+    - External Bypass B: VA=1, VB=0 - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
+
+    https://www.analog.com/en/products/adl8113.html
+
+properties:
+  compatible:
+    const: adi,adl8113
+
+  vdd1-supply: true
+
+  vdd2-supply: true
+
+  vss2-supply: true
+
+  ctrl-gpios:
+    description:
+      GPIOs connected to the VA and VB control pins (in that order).
+      Must be specified as GPIO_ACTIVE_HIGH.
+    minItems: 2
+    maxItems: 2
+
+  adi,external-bypass-a-gain-db:
+    description:
+      Gain in dB of external amplifier connected to bypass path A (OUT_A/IN_A).
+      When specified, this gain value becomes selectable via the hardwaregain
+      attribute and automatically routes through the external A path.
+
+  adi,external-bypass-b-gain-db:
+    description:
+      Gain in dB of external amplifier connected to bypass path B (OUT_B/IN_B).
+      When specified, this gain value becomes selectable via the hardwaregain
+      attribute and automatically routes through the external B path.
+
+required:
+  - compatible
+  - ctrl-gpios
+  - vdd1-supply
+  - vdd2-supply
+  - vss2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* Basic configuration with only internal paths */
+    amplifier {
+        compatible = "adi,adl8113";
+        ctrl-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>,
+                     <&gpio 23 GPIO_ACTIVE_HIGH>;
+        vdd1-supply = <&vdd1_5v>;
+        vdd2-supply = <&vdd2_3v3>;
+        vss2-supply = <&vss2_neg>;
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* Configuration with external bypass amplifiers */
+    amplifier {
+        compatible = "adi,adl8113";
+        ctrl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>,
+                     <&gpio 25 GPIO_ACTIVE_HIGH>;
+        vdd1-supply = <&vdd1_5v>;
+        vdd2-supply = <&vdd2_3v3>;
+        vss2-supply = <&vss2_neg>;
+        adi,external-bypass-a-gain-db = <20>;  /* 20dB external amp on path A */
+        adi,external-bypass-b-gain-db = <6>;   /* 6dB external amp on path B */
+    };
+...
-- 
2.43.0


