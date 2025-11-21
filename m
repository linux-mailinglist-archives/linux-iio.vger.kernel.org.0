Return-Path: <linux-iio+bounces-26359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 681F2C783E1
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E023E3513E9
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99334214C;
	Fri, 21 Nov 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F7AQZzMR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE02D8DC4;
	Fri, 21 Nov 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718743; cv=none; b=LBM6ok4NqeMh4YA3IoIUsuoWToTmmZ7Hxml5o/oDWEwZ4DRi+Tyes8zq4rh8XBD9hwS3Ck2JNiWzI1rPfAWPCB6WmcZuNcWjhF35PXD3fpUji+Uo4D94d7Q4dHf0iqQT3YecqGlJ/WURc8lzRvvbh+7kTcL21lrHZYI9EEQFOc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718743; c=relaxed/simple;
	bh=Fdvc1Ur8f75zXn4L70ub5lRleyw/QJ99zDkUCuWR40E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKQ9uH1WqnIMwN8Ow0sXcvJhZ8AYvJwRx/S22XzAnfU5jTPqdxObMl1TGh/3gxQP3V3IAtxFCdNofku7Hzi09FAqAlW3VSNboP4Ce89XpPh6UA1rfaUgnt9YgRycY53ZUHjoq5UnnP0KG4WyumDj171klEoW+za2/YzXl3bu2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F7AQZzMR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AL6cLEs1922873;
	Fri, 21 Nov 2025 04:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q8X+k
	YYcMPpykuohcouE/RHUC6HZ8AJJYjyStMYOS7g=; b=F7AQZzMRZBjbstB7d9sGC
	rRs4Fo39E/jAUVYcFYcl6atriLgXNFspK6noX9zB2ca38PcrBRXsvo7wIztvEXN9
	kQaXYnU1UoJFHCjFshiYUZjLoBjxwvHamTErxlRVKU7lvoC0xGBijNpqWn5A3wBK
	c2jVx5b7moaGvjT5kOT08g9X0TO1EtVOPsliKXpP4xW8teDgeDf2T7tcdGrOtwEX
	nTQQJijAnklDALvRAoVtXMwhuci1GUYVuMUG0rXzj7Tn1d3MBqxZGVgFvN4iSSIc
	SH4c44ruKeMTVUsDAhH0v21c4eTPq9+N2uARoEzhW6Cg1ct8BJVx5mJVTOTy8agR
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4aj40c5ccp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 04:52:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AL9qIEo014848
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Nov 2025 04:52:18 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 04:52:18 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Nov 2025 04:52:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Nov 2025 04:52:18 -0500
Received: from Ubuntu.ad.analog.com (AMICLAUS-L01.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AL9q9RD026882;
	Fri, 21 Nov 2025 04:52:14 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: amplifiers: add adl8113
Date: Fri, 21 Nov 2025 09:52:02 +0000
Message-ID: <20251121095204.18574-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121095204.18574-1-antoniu.miclaus@analog.com>
References: <20251121095204.18574-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NCBTYWx0ZWRfX6R7P0bRM0bla
 r02hSXbBwpnrt4PNZHf4mvpr1I5O22P4TqtUzg8DFFY7EV4tejVYDWMDJMyRmviISDFe4+cuexu
 j7iU16yEuhOnTVqSFcghKybIbMpjOWAKSj8CjszzI0OmG6WO9L8Sp3xFFvpPKKfYm8dhyYfcJaL
 sz9jD058Rth/Iq24JxhENVCgC+Wb1Hg9ZcJeu05taB3ESGaWPHexk04XgMEVvkKp0rcrdW9RSaz
 iLMjRNDvJEyPckUQz07XzQ5VMVWhwWM9DXKYIn+nmUxW3E+ZQdRk7phxuV3pYF7YIVdzpL9wKCY
 u8bPJ0B9EWGRPahFPWwcMYRswBGEeo2e0xYkXbV8PYFq/h+XLwFbEQVredJGNnMmTPfmUuKlcEu
 PhFT7f+QtHpCmU+jx99cQOClq2Uo5A==
X-Authority-Analysis: v=2.4 cv=DvhbOW/+ c=1 sm=1 tr=0 ts=69203653 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=1yNy12B5puk2P9Y3jxYA:9 a=4Crt4hL0rqkA:10 a=shvgCOL7IKUA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: kFp1Zww_BKz6tOULahRS2b2uI2SsQsjR
X-Proofpoint-ORIG-GUID: kFp1Zww_BKz6tOULahRS2b2uI2SsQsjR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511210074

Add devicetree bindings for adl8113.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v4:
- Add adi,external-bypass-a-gain-db and adi,external-bypass-b-gain-db properties
- Add example with external amplifier configuration
---
 .../bindings/iio/amplifiers/adi,adl8113.yaml  | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
new file mode 100644
index 000000000000..3da5de01e31b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
@@ -0,0 +1,93 @@
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
+
+    /* Basic configuration with only internal paths */
+    amplifier {
+        compatible = "adi,adl8113";
+        va-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+        vb-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
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
+        va-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+        vb-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+        vdd1-supply = <&vdd1_5v>;
+        vdd2-supply = <&vdd2_3v3>;
+        vss2-supply = <&vss2_neg>;
+        adi,external-bypass-a-gain-db = <20>;
+        adi,external-bypass-b-gain-db = <6>;
+    };
+...
-- 
2.43.0


