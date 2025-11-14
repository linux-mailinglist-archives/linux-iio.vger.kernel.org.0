Return-Path: <linux-iio+bounces-26214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8058BC5CF95
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 12:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B13587D0
	for <lists+linux-iio@lfdr.de>; Fri, 14 Nov 2025 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF21315D5F;
	Fri, 14 Nov 2025 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oofDH1OX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81C0315D26;
	Fri, 14 Nov 2025 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121546; cv=none; b=BP7deuNFN3YuFdEmYySzWSW1qucZBhH7xJ8fdCjwcJxmorjkouK8ViJPbev5vMofU0AV6saSHksD5r23Hdeaz4vhn3EFJ4TQO0OlKAW6RslNhNdU4EBpoeFtsViipZ3ZYQukyiblnVe31ecT1OCA8bD+mzkD6koWugL0j70gDdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121546; c=relaxed/simple;
	bh=/cA/XdSGxsW0TXEoARCprt05ZAOkKn5eOCNRG4dittI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JI2bZoraO/L16ZUEFI6t6ehPe3GwGwrmfmYQ2Z/2aryZ6F9mJSzu12qoymUHZPlh/N3IYc56aiVgax/6AiYWOgDfzaPOuJMsthnHR+j9Uu4Hpv+8dd38Uu3/qkbuaZ7UEG3MOsy6W3+0/MvzOEyAl44eaOB7Qu9Fkf8u3UyIdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oofDH1OX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE9nMQq3285328;
	Fri, 14 Nov 2025 06:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3LjSl
	i5vUyvXqqEjgijtpPtqffwKzmiVZ1q8xmOZd2s=; b=oofDH1OXqAgshtn6kJnK/
	aVV/XW5+m3aYwvxNuatpvHpzaiVaZeww1+eOmBc78wROHsW3ttVpZFcpjXPTNdDH
	ZEUIjpaQdf+U1WYIeMlLnvuf80XCE10zLD0XNjWAmOb7QFbbSm+XG2ttrx84Ve5/
	M1vPXskE43z8ntBBKBeRG3nNJK203krcH6Uk2T6v8lJlLHac14ibab0HVVNtUINa
	kmqTJ78eTXpb6rfQfhP3ExbEJGJdjRuiAtTwOvq2ODFhVe4kvqCZM5fIi3IfH2AN
	XQ5Xdeve8jCsDyHnmAci3SNEefU5sGC2PuUvL2vK86SjAOABaAsF5Ph0GcVl+d0Z
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4adr7uud3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:59:01 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AEBx0Xw044605
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Nov 2025 06:59:00 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 14 Nov
 2025 06:59:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 14 Nov 2025 06:59:00 -0500
Received: from Ubuntu.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AEBwodh018389;
	Fri, 14 Nov 2025 06:58:56 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/3] dt-bindings: iio: amplifiers: add adl8113
Date: Fri, 14 Nov 2025 11:57:23 +0000
Message-ID: <20251114115725.5660-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114115725.5660-1-antoniu.miclaus@analog.com>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: a0RgU8YZoVdS87GqFqa0Stqi0eV0cShN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA5NSBTYWx0ZWRfX9m4r6rM4VIqI
 //kzDoi4OjX20z9VaxVyd/TbKdCh8Hwvbn7YA4J78pCEFCz8UqFLeBZAu9R7MU92uDxn5v+j9Cu
 NHt9aGnzdKNOr3EYS7pm9M/1hYD/6RhZjlW16WVeC8PytJLP6F/veepFgme+IOrEq+Zi2yrtOAr
 aOjw6PI3VQIYjbHrdbyXQag/J6kDmaOZA7NUR+OJtaTLVaVgk+WdAGQdjQPPCvj49Nsl3KV9wm7
 QimZqOBhRqrC7w6b8j21CDvwXQLPbXCyIuyFkRQMGylX2p1HAj6TMnJLpaiFlbVnI1wfwqZyVdu
 2CjJRbBGfbXpdWYkCgVuXMLjQb622QvjhzDgjVv8Gz+EbkVgKBXUwdZeV6oPV5QzU0zssQnQzw/
 tytUGr2IJFtbFFhPj0TZS4+/9nknSw==
X-Proofpoint-ORIG-GUID: a0RgU8YZoVdS87GqFqa0Stqi0eV0cShN
X-Authority-Analysis: v=2.4 cv=NLTYOk6g c=1 sm=1 tr=0 ts=69171985 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=fejBgCUCbQS8leEGmL4A:9 a=4Crt4hL0rqkA:10 a=shvgCOL7IKUA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511140095

Add devicetree bindings for adl8113.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---

Changes in v3:
- Remove extra blank line from YAML file for cleaner formatting
---
 .../bindings/iio/amplifiers/adi,adl8113.yaml  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
new file mode 100644
index 000000000000..0ad83a01ee37
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
@@ -0,0 +1,64 @@
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


