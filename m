Return-Path: <linux-iio+bounces-26046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD068C43250
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 18:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD24E6765
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378D26FA77;
	Sat,  8 Nov 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LOgSF4LW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9882C26C3BD;
	Sat,  8 Nov 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623861; cv=none; b=bFarPAnmcHxAqPBmFlgNT+kuesm39v/zlRznXsdiqyLmPTjkvZqAY6JJuRzn75siWUKpq48nSb6BBiZj25hXhzpEvuAj6limA28Mu0eIwwAY7LzHdFHxdJTUvhApkoPZQNyBSz2b1dpHNvIDf4VhtcZAT6sJbmlppN+ETD5mvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623861; c=relaxed/simple;
	bh=BaKYdFCZMChl06mOKBAejY27cNJajV2OHXDiVdKNwB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tN8aJqhtaQUY3UYrw38PGxj7cEAD6kfPs4oBF2fI2ottdt5VObyCrW5nruxEba4vI2y6d5yw3AMj8GM7ZB4vQ5qt4zAorodAhHQrVUMtZCZsSFYM3bL/9wScG/h5sRG5bcj4FL4fGz7o0V6XUplnw/swDVl3q90STjd7Ra2yNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LOgSF4LW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A8HRoOS4004375;
	Sat, 8 Nov 2025 12:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Gqanc
	uMQc9xOkKjdIzT1pt8m4FyleACpFj1tvDw1dM4=; b=LOgSF4LWBcr7yZbIKVTUX
	5I9YqOAw5SqzzAR4XBc5gEYvpMoqS27lXdkf8zBKC7w4TkAQx8WODWibFhcGRUy2
	ggER5ayWdemMeJ0e1QC+8yQOlDOukhXx0/ozFJIstLLPVSpqGaTEGFkiKMDngLRh
	82hqgbxc2292pOfFm7FwxItO8HjhmcBFY/hJ327wgCTlDijqrFx9vKD14vm703SS
	jcG1oLAVTwvQ+OW1/3U0dggs5ATOoKAiwKGnfcHQDLhZn+9rnLSHeqB7+HPROxX2
	tThJcxOAzupLtNHFnoSScoTIPljDaG1crsWTIFdkthXWGc2VP3WD/OxvnopUohmB
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aa3n69cd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 12:44:17 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5A8HiGXk010295
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 8 Nov 2025 12:44:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 8 Nov
 2025 12:44:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 8 Nov 2025 12:44:16 -0500
Received: from Ubuntu.ad.analog.com ([10.32.15.145])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5A8Hi4Xi028553;
	Sat, 8 Nov 2025 12:44:10 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: amplifiers: add adl8113
Date: Sat, 8 Nov 2025 17:43:52 +0000
Message-ID: <20251108174357.3748-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251108174357.3748-1-antoniu.miclaus@analog.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JoD8bc4C c=1 sm=1 tr=0 ts=690f8171 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=fejBgCUCbQS8leEGmL4A:9 a=4Crt4hL0rqkA:10 a=shvgCOL7IKUA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: R8l_b-ZeDKaCT490cvQn0jF3W4_L7hYw
X-Proofpoint-ORIG-GUID: R8l_b-ZeDKaCT490cvQn0jF3W4_L7hYw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDE0MyBTYWx0ZWRfXxmMMdd4gYpOr
 4Z10nl9RoycyYCJsxrsAYrdMRVE8/mOWMQbhCqOaG9ZkoLtAGcpIl19w1tv3dCnc493yVcNhV3U
 DEq7YBFEtaBUFpDajliwQ3OtVsxtP6mDlbscsAKVgBI1Kpt+Fs0YzSzi8Q6csf80Fu5+wTr2Lx9
 fW7KokK9/vqV6yqyUSeWMJEATzFL9iIza2kcTNf+QYCmLnXWEETWYd41dlba1CjhLD+j5LGRZJF
 REauZ1NXvOAMnHim9IyuEva9EB87cQNmADHIkPnxxvNl+RoUBa9UAkZQd8HxHqcCxIPORkb4psZ
 HkqGh5F8yWSWn6QSRppEJI2iIi2DEL8tcSYCpoXgd87QboKkOe7cd7visRZ3cv8OM1Gtnc6u/q6
 qFu9DyCRUB2rBwSPW33T43SZo8ByIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511080143

Add devicetree bindings for adl8113.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v2:
- Enhance External Bypass A mode description: clarify signal routing from RFIN to OUT_A and from IN_A to RFOUT
- Enhance External Bypass B mode description: clarify signal routing from RFIN to OUT_B and from IN_B to RFOUT
- Remove adi,initial-mode property and its description, enum values, and example usage
- Simplify device tree example by removing adi,initial-mode = <0> parameter
 .../bindings/iio/amplifiers/adi,adl8113.yaml  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
new file mode 100644
index 000000000000..cf8dd6e8b887
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
@@ -0,0 +1,65 @@
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
+  va-gpios:
+    description:
+      GPIO connected to the VA control pin. Must be specified as GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+  vb-gpios:
+    description:
+      GPIO connected to the VB control pin. Must be specified as GPIO_ACTIVE_HIGH.
+    maxItems: 1
+
+
+required:
+  - compatible
+  - va-gpios
+  - vb-gpios
+  - vdd1-supply
+  - vdd2-supply
+  - vss2-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    amplifier {
+        compatible = "adi,adl8113";
+        va-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+        vb-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
+        vdd1-supply = <&vdd1_5v>;
+        vdd2-supply = <&vdd2_3v3>;
+        vss2-supply = <&vss2_neg>;
+    };
+...
-- 
2.43.0


