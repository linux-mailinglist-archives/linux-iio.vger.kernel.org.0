Return-Path: <linux-iio+bounces-7607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A91C930A1A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 15:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85063B2149A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 13:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E4139CEE;
	Sun, 14 Jul 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kPiLixwj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDE131736;
	Sun, 14 Jul 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720963859; cv=none; b=sCoMaFSEW+9yxs4JNtEEGbGOe/TWzJSaK9uilWmg5l8sYppdgMzmU+SRR3CTpNbJ4mOXb+eQvYoy56nhUBYbMf3XHm9YcKyW5AyPIkKraDLLEW9GLjcc6sHGW4TfysJGJ57PU+3HhmBwDlwKloyXBE5pp5Wtxh+v0DBZMmD23bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720963859; c=relaxed/simple;
	bh=g2K4Otuh6+temID4J60XxaKPICYAXCVeY6YCKt1hrRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUbajzlNonK69tJThORk77+WS/zXcEAwk4lqDJW9wVttn4xi+kVYPg1XakMZM35TcYNpoUBr8qBaTwtKb/z+ddvDh7wXGys8CvhnXhKWn1SF3h84ZPCAaIq89UMiZVq2sJ/1ZrBMlgiV1DXReaBVZBc1aGoggRovgC1nxNRxS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kPiLixwj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46E4hlvl015266;
	Sun, 14 Jul 2024 09:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=f+YN4
	oRMXazlO+9YCYfmAFDHBxy+UFZ0AYoT5j/htl4=; b=kPiLixwjgA/DSdXoIg9i0
	StbzfQKwRcS+V6V97fQT8zanVo2/JYpm9gX3MUGiSlOF/JeZfp9nvWO8tNcfACdp
	LXvKtKnI31wVqrSaSbdGOADHsOU3s5C1Pc3ILfDTlBBWAJICT7ckHMo4li9ayU1S
	cRTHS/OOMKuj3ME+gtshFygQOsTUIz2cymxQ3lTq2NYUjZRq5hWi531D6CciaNWB
	5NzZdMVCWWIdQSUEzyoJK8feQmFbia/61FxKNcc3gluC9slTrUmuuPEARcxIe0I2
	F7092y/LVAWKuNl+vasj51+VNHFvyZHBvWvJg99+PLkG7c6kIkrb8ctLqH46722g
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40c7wdgs3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 09:30:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46EDUe13050889
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 14 Jul 2024 09:30:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 14 Jul 2024 09:30:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 14 Jul 2024 09:30:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 14 Jul 2024 09:30:39 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.97])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46EDU4QW028092;
	Sun, 14 Jul 2024 09:30:27 -0400
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
        "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Michael
 Hennerich" <michael.hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<noname.nuno@gmail.com>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: [PATCH v7 3/6] dt-bindings: iio: dac: Generalize DAC common properties
Date: Sun, 14 Jul 2024 21:29:57 +0800
Message-ID: <20240714133000.5866-4-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240714133000.5866-1-kimseer.paller@analog.com>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: cozfuCHVF24bFE2tuu8hqlqjcXcZBgwX
X-Proofpoint-ORIG-GUID: cozfuCHVF24bFE2tuu8hqlqjcXcZBgwX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=890 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407140107

Introduce a generalized DAC binding that can be used by DACs that have
similar properties adding output-range-microamp and output-range-microvolt.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml b/Documentation/devicetree/bindings/iio/dac/dac.yaml
new file mode 100644
index 000000000000..daa40724e1cf
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
+  A few properties are defined in a common way for DAC channels.
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


