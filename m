Return-Path: <linux-iio+bounces-7669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F3A934785
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 07:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EA6283869
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 05:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C966A8D2;
	Thu, 18 Jul 2024 05:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fYtT31rf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617B64A8F;
	Thu, 18 Jul 2024 05:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279974; cv=none; b=PiWeCGVGw6nJO7ilbJpCpWGI6+beFVdw3W1oF+3hYDqLdtsmSzFy/NschPDbYpTfS0xojxNy9CDdlEXiFlWkXKUn9u2GSrlJ5zzqKJlqTsphiGOYOULJ+6dA2U72cbQYNWpBNGcoBxXBQ4upqI4XQaDps4v/6BzTbNVzQixjtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279974; c=relaxed/simple;
	bh=g2K4Otuh6+temID4J60XxaKPICYAXCVeY6YCKt1hrRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT5yAXznbzKgt2Wxvvnvs7/u1ipL8OdQmtowBwYo2InS93tjjl1Jn3TW0VbMNk2BklEIyc/U1C+gFVM3s0o5ZUWmujThEhLFyIDZ2hkWAixf6DhVyjVQwnDXwhimTp2wOyHk6yfzKvqugCmIZsPgWph42mXUv22GDN3WzOWDtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fYtT31rf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I25OQ2013536;
	Thu, 18 Jul 2024 01:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=f+YN4
	oRMXazlO+9YCYfmAFDHBxy+UFZ0AYoT5j/htl4=; b=fYtT31rfWynkPZZeTZNtG
	ogN5us/yZd9p5SkYYQ0KAYwvnMUMZDogr8zv812OeQ0syRt9r47z0yAhp2lMaEct
	eXcp2fcsND+6s4uqB79Is3OlyLLDR5dPU9v1xn2Bj6NGNtBX46Jue7TaFgfOQACD
	irGxVI1GLcKWIRmtrT4ze9hR1rXWab7oykLGM5qBOz7PC4Ief5Q2udtqSeJJ2tRR
	fU4Q/WySh2h9W1rHEqr59xhRf46Md4FF/S6gyw7YeqB2+u+SIPkCFPnb+emJ6cZj
	c5qT1qhWTTi+bIG6PtjpQIFXoe+mPwLCKoYmvUZA/QgQ8RJDxwOI9j7oU67rgusG
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 40efamass6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 01:19:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 46I5JGEX007549
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jul 2024 01:19:16 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 18 Jul 2024 01:19:15 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 18 Jul 2024 01:19:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 18 Jul 2024 01:19:15 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.220.49])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 46I5IhgU009768;
	Thu, 18 Jul 2024 01:19:06 -0400
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
Subject: [PATCH v8 3/6] dt-bindings: iio: dac: Generalize DAC common properties
Date: Thu, 18 Jul 2024 13:18:31 +0800
Message-ID: <20240718051834.32270-4-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718051834.32270-1-kimseer.paller@analog.com>
References: <20240718051834.32270-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ShdGSui8VyPXTw8FANr2tJSLPkRxRa5h
X-Proofpoint-ORIG-GUID: ShdGSui8VyPXTw8FANr2tJSLPkRxRa5h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_02,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=891
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180035

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


