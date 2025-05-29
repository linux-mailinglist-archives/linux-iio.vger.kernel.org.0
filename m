Return-Path: <linux-iio+bounces-20022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C88AC8484
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 00:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74F1170369
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 22:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986521D591;
	Thu, 29 May 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dqoOI31u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AC820F087;
	Thu, 29 May 2025 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748558983; cv=none; b=NNH8UEHtpL8bzTOJ29ey4Jx+gwK+T26PHmRMlPOSdQ+pQ7mvkVSs5p2rIvYEYu9XmthiHntjKMzRfCBe3rCn7kmbLH9oETQCXHkIKGU3J27dQJzMWrNz+xXrxTq0EDSvHa0+gyMpAkOdP4iwmg5vno9SgChszkdAPRaC+z0sr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748558983; c=relaxed/simple;
	bh=jQ7LKNzwnr9ZyPUq0GlYDOZ+Zq1oOc5sPt1Nc9tQ9YQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgpiR8nDkCVGcuouGtFmj0voP1DZXSsIrBnueHz2Iaza294hMmbzskNhJ9S05OwcECn0zAoB4P6iwY+ju+KMifLN9H+0Ox5ZH7cIvhT6ar+mKUH2Nl7X3afCofeZ6aSvv9LGtQaqz0ZxrYxUk0gcfbQYE8K/jUIiYxD6aF3ILqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dqoOI31u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TLi0XR022879;
	Thu, 29 May 2025 18:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JLIFn
	HtoRGi+/TZDf+wLgTBcHhCirYKNztTgwuyZbrU=; b=dqoOI31uGtgDLbDwQBS6W
	ytz0CBfCytjfLOWNc0CoSZrOU+PjRzpAywoYVkJopx2GB7/uvjUaG5LF0DN2HvaJ
	FRQxbpqTt879jt/hJJLBvF/ya4iTenZTO4g/cPX1BCasQo76NjFSSsv59T1tDeyU
	XVJls62TWDZ9tf30w/8RP/lROSaau9iSjWOERPpeBLy2fHo4PcnVPdzomAY5yYQy
	VnG7lTfVJlShvqcMo6I0uzEN5LKW2fVsBr5sB6il+MMuUyc9fS4U5HvG3z2s7ESd
	YbcRZj4y0xc0XZgXGO/11zioE/OsR/HMASG7uonrrkyEUdzC0MlaA6uI5bq4PjHa
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46wu5837e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 18:49:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54TMnTu6010297
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 May 2025 18:49:29 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 29 May 2025 18:49:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 29 May 2025 18:49:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 May 2025 18:49:29 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54TMn9ph017144;
	Thu, 29 May 2025 18:49:12 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        <andriy.shevchenko@linux.intel.com>, <rafael@kernel.org>,
        <djrscally@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v9 04/12] dt-bindings: iio: adc: ad7768-1: Document GPIO controller
Date: Thu, 29 May 2025 19:49:09 -0300
Message-ID: <444c7f788303f03e390e330af91f24471a683907.1748447035.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1748447035.git.Jonathan.Santos@analog.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDIyMiBTYWx0ZWRfX2xvL3yE79f7b
 Sf/FMPrDq0Jk8Qe3Nt0DzOyxHU00U32KVDuN+7lPloecfRJk61VP+nCKjfUp1aSdzuo067TiRWO
 1qknUbEboi0w0NyMR72KY34r3To+L/LBCkI/KRuaHwACYyMTNsI1sLSuHBSPZdGgvbHS9mkKG35
 xc+uLcBMwDYxsVE9cH/M3MDO/xKiWtx9xjRD0YGgqN0Dl8XgNnfJ74Uwf9wMe5g5JhVZuWkJBJa
 7BFgY1PjTgPjmrR2EYSgq4jKrFVOzkMQY6dA/E1odedooJat0tnF4hp1HHOb1f+Yca0gh4wUPkD
 4IX5OJ/mJxVkf5jp1fSJLjSJmWYnQWV9o4UWtlYl5o1hdPxKUk36OiDBF2kmqGdIruX3gLmMsUf
 9sJKoz5s0SB1Ttauk7rurWHiwM801EHIN51/KPpFdScFbXGx21VBMK3NKoYtSGLqU3UCZTRN
X-Authority-Analysis: v=2.4 cv=FZ03xI+6 c=1 sm=1 tr=0 ts=6838e47a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=FDCdkw0c5cjSjuxHnEwA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kVyppYFo42kfrWqbBDZALRgo6rKlWMTn
X-Proofpoint-ORIG-GUID: kVyppYFo42kfrWqbBDZALRgo6rKlWMTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_10,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505290222

The AD7768-1 ADC exports four bidirectional GPIOs accessible
via register map.

Document GPIO properties necessary to enable GPIO controller for this
device.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v9 Changes:
* none.

v8 Changes:
* none.

v7 Changes:
* none.

v6 Changes:
* none.

v5 Changes:
* none.

v4 Changes:
* none.

v3 Changes:
* none.

v2 Changes:
* New
---
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 9a6df931edc3..18f93586fcdf 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -85,6 +85,14 @@ properties:
       dt-bindings/iio/adc/adi,ad7768-1.h.
     const: 1
 
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+    description: |
+      The first cell is for the GPIO number: 0 to 3.
+      The second cell takes standard GPIO flags.
+
 required:
   - compatible
   - reg
@@ -142,6 +150,8 @@ examples:
             spi-max-frequency = <2000000>;
             spi-cpol;
             spi-cpha;
+            gpio-controller;
+            #gpio-cells = <2>;
             vref-supply = <&adc_vref>;
             interrupts = <25 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
-- 
2.34.1


