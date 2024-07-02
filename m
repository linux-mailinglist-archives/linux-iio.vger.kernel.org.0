Return-Path: <linux-iio+bounces-7116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C991ED39
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 05:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5332B21CB0
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 03:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334718E0E;
	Tue,  2 Jul 2024 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SEKNiDKI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60464CE09;
	Tue,  2 Jul 2024 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889284; cv=none; b=SdV/s9Mhl+9ztSYnKBOD/aGXvo65o3nhhFLkoKAytGR0rpY/SckHA6axrqd1SdmVFPGP6hRUoLxrljRkQ3Okz9/Vdn4XKzIJluIjvtomP2yicdhxC6gp+c/VsCGo4s8url0b5G2Zd9hzPwF9zSoebYY8UuMK7zhHBWmSKrqnXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889284; c=relaxed/simple;
	bh=va6D2VfXKjcLi6vWosEB2/bmOMXeyFhQSzHpa76mfWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtVcxwDbMMEiUPXHSvrxellNkJXao2uV0lrXaDYMSQle5QDwPMeZs0o2BL64/xSOEXJFS8V5zgCtTHoAzOylOtudta8RywUp5vZSZpWzvHntMjFipAUimfMf14ekWIHeG7SjaRsac8d4Ct5Phzfr4u9ReWTlESUez9msrvKDlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SEKNiDKI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4622eGFF003330;
	Mon, 1 Jul 2024 23:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tQY8m
	dcH9V0njHgRbxCwQsoRK/+SNP1Nvv7RmpWbY9I=; b=SEKNiDKIrUUdpbeZZFAuQ
	3dFksTSBPTVpN4Y0b0+kR2YjJVXF7J0FQdjKS744bduUCeDUY9N8U0Zfr+rMzjng
	NHCJUjaYUt1TqBPQtsTf5wltaMzi2TGA6vv+mHRE8g6WBi9tfGk7xSSR+muochav
	fHXdRYRZHpUMgwRsVZCy6GHsyyGHTcD+zJ2JSjdlZG81w6q0vFX3trLoeqcAjfS4
	TwD56ywse+bdaWLOoCAPuUcinMK+xpMPW9hDtFAaDkm30RRchsV1GVlh2WE5WnnC
	I2wWJ1jCnXmKva3muiphCQDh4SYW1gPLjuyUQjaXlq1AJPlUBO6u+0RgQb3SDrwh
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 402c43ry6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:01:08 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 462317Bl041234
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 23:01:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 1 Jul 2024
 23:01:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 1 Jul 2024 23:01:06 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.28])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46230WbO032046;
	Mon, 1 Jul 2024 23:00:54 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Michael
 Hennerich <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v5 3/6] dt-bindings: iio: dac: Generalize DAC common properties
Date: Tue, 2 Jul 2024 11:00:22 +0800
Message-ID: <20240702030025.57078-4-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702030025.57078-1-kimseer.paller@analog.com>
References: <20240702030025.57078-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: uQLmH3Vpjm5Ht9--TNnJghPadPNkF7bv
X-Proofpoint-GUID: uQLmH3Vpjm5Ht9--TNnJghPadPNkF7bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_23,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 mlxlogscore=916 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020020

Introduce a generalized DAC binding that can be used by DACs that have
similar properties adding output-range-microamp and output-range-microvolt.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml b/Documentation/devicetree/bindings/iio/dac/dac.yaml
new file mode 100644
index 000000000000..579f52ea6eb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/dac.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/dac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IIO Common Properties for DAC Channels
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  A few properties are defined in a common way DAC channels.
+
+properties:
+  $nodename:
+    pattern: "^channel(@[0-9a-f]+)?$"
+    description:
+      A channel index should match reg.
+
+  reg:
+    maxItems: 1
+
+  label:
+    description: Unique name to identify which channel this is.
+
+  output-range-microamp:
+    maxItems: 2
+    minItems: 2
+    description:
+      Specify the channel output full scale range in microamperes.
+
+  output-range-microvolt:
+    maxItems: 2
+    minItems: 2
+    description:
+      Specify the channel output full scale range in microvolts.
+
+anyOf:
+  - oneOf:
+      - required:
+          - reg
+          - output-range-microamp
+      - required:
+          - reg
+          - output-range-microvolt
+  - required:
+      - reg
+
+additionalProperties: true
-- 
2.34.1


