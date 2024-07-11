Return-Path: <linux-iio+bounces-7497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0210292E766
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 13:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DC5EB27234
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF815B971;
	Thu, 11 Jul 2024 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tDFuZZ8w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611C15B0E0;
	Thu, 11 Jul 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698198; cv=none; b=gF4febUSeWBeqhCtEVLBFjTP9nTAIezxkLrjaKM7+OnXziyx6EjmurYv/KDHBXjkwL14+gabY9UFjHHA8ONiG5GuJNxecOkEU+7Be/wHqUvbbmPug72Q4wt5NZmx5hCVK/lkpIhDdFwjmIfHDWBLW1CLKlYuSuZk+yGI8YVe7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698198; c=relaxed/simple;
	bh=5DFFHkTpcd1s9/LiOT4YDr580PQYROuYJHm/EUSjklw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/CP94MwTJD0QTjAFsbbJGqn3jqr7fku+XVyKuQ8sk5xjheGbTpg62MlSHIJ027a/qbcVVS/3usqfhrozn7T68HxpLuJ18lw4icZb6STWuZe3LBJvgHxIQiTWUGZ4Jaf34vxSAirR2O2yqD4HI769i0YycO8BMHCE6e7X+yMxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tDFuZZ8w; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7LUEs031331;
	Thu, 11 Jul 2024 07:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4Myur
	UCm/o5+64DnGIGZPiQo0lc0pi4TzqMPFMAXxXg=; b=tDFuZZ8wAWsgR2TdwYoog
	JyBLKg1G9ptjJG/SmUCre9EU5aRFhpHtbL7hI8KgdIj3eXBQfsG8QXneFsRG8JvV
	OgFist2BXUUFFpMvg5yCAO8w/VKTpQcQexvnHcwYBqjWSHLTG77rMwkRSTXkIPpT
	fxM9ge2vANEiLij1a3nKIy5or9WhwCXu8OoeT3dFSLp+SvRTrQiZTE6xjJOCVE27
	mD6LMwLy4z66f9wGe83vpBpnBCA5bQOr0V3s5uI+84nQLqPuUXLMdMP0+GEaiMl8
	oLRW/KaGABoLNh0usTFG+LaVzlNsjvLmBcPyH72YLl0njdSENZKGqLVb3dwfsV88
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40aaxc8rb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 07:43:01 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46BBh03j008053
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 07:43:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 11 Jul
 2024 07:42:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 11 Jul 2024 07:42:59 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.23])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46BBgTQc013318;
	Thu, 11 Jul 2024 07:42:49 -0400
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
Subject: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common properties
Date: Thu, 11 Jul 2024 19:42:18 +0800
Message-ID: <20240711114221.62386-4-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711114221.62386-1-kimseer.paller@analog.com>
References: <20240711114221.62386-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: OypszEQxK9xbvDK7fTbQfYzFdCddMVkv
X-Proofpoint-GUID: OypszEQxK9xbvDK7fTbQfYzFdCddMVkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=916
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110083

Introduce a generalized DAC binding that can be used by DACs that have
similar properties adding output-range-microamp and output-range-microvolt.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml b/Documentation/devicetree/bindings/iio/dac/dac.yaml
new file mode 100644
index 000000000000..a9787bbcd22b
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
+oneOf:
+  - required:
+      - reg
+      - output-range-microamp
+  - required:
+      - reg
+      - output-range-microvolt
+
+required:
+  - reg
+
+additionalProperties: true
-- 
2.34.1


