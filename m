Return-Path: <linux-iio+bounces-19322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E7AB00E9
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5885F1C04040
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977D2853FC;
	Thu,  8 May 2025 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1N9mH6hk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F8F2853E0;
	Thu,  8 May 2025 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723854; cv=none; b=GhSRHtkN7C8M3bZOjel0my73sj5ZMnfAou97hoCE9LAaVdbz2bNUNhV964vSAbEjsvDqZaVpHKOButkn95R88gzelZObzUBVKyTesWfcQIW7Xym+Cr0N/jgwDi01nkMstR99N95FldWXGezU65XmezGuosfk/mZeXWNKKHeTya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723854; c=relaxed/simple;
	bh=xKQoZ3FPpX0PdrITeGIukchMaZdVP8KH0O/FZPGgEKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvoxXcQDyYnYGIj/W2A/t2VEps/M/foaMLdGuMyqd03dYQ8jHwxlfmKG6ucz9rcp6knOBrr2j91bDPVIUeFEQNPy2VFB5aRfR97ZWMj0UXfR4Zv2LxXpxCaG71vfM1pcZAz6npML9T8Eurc74aXJmV9agJfMutMLaVq2tW1lEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1N9mH6hk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548FSacW000730;
	Thu, 8 May 2025 13:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SJMoR
	KwboMh3dxngT7wJepVe84DuCSbqfN8MDEU+Tnc=; b=1N9mH6hke4IHelFDCDfyK
	6n814cY+7DQmjl7YEfPX+tXbyHOSyAi4ksB6eyp+ZGmQ6PJoiOWEbDit74eCE5vw
	SLT2b+FKfbdN0On/qMclyDlo5bZVs150nBqb8TBM/jrOUfWqzX4G15WjSU800Od0
	GTn9v87LA1CVKoLcFf+Cg+H1WkZaJLI9QzLGzwqQrbWAI/kLpiggq0YOBynMAial
	+DbfYxSMSHe3miGidx8wuqNiTrT4N21VV/m69OfDXIdGku6n2Tdvw40fhYEBefpo
	R5Yl1dITaeWoB0WgRXDsnRE4XcPg3S55PcVNLX7kc4ADsuBjPQVrffOdvXRhfdF7
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46gy9q8d5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:04:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 548H43XS022722
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:04:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 8 May 2025
 13:04:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:04:03 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H3lBj015877;
	Thu, 8 May 2025 13:03:49 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v7 04/12] dt-bindings: iio: adc: ad7768-1: Document GPIO controller
Date: Thu, 8 May 2025 14:03:46 -0300
Message-ID: <1bd3ae9a4f0bc1296d97aae7db7b068ba7c462c9.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZoVT6cwPOsMk6vPvxBBA5Ww9Ixase4Zh
X-Authority-Analysis: v=2.4 cv=f/ZIBPyM c=1 sm=1 tr=0 ts=681ce404 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=FDCdkw0c5cjSjuxHnEwA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ZoVT6cwPOsMk6vPvxBBA5Ww9Ixase4Zh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXw6fECl81X7xR
 cXkoff0gdLL42g+hNvEiYHb937Tpv6yzqgt7IL9CpLTaLEZTbPGSJ/Tj0wAnhwXyZZLpZQE2viJ
 Nx0/yRh8tewzslCOCNhWsEATx+p7ir9s4KSkgkVLB49ouKefCGb3MEgusP048o71kSP7jm4RyKy
 mjLmnt3Mxks3fErDNrieeAiDG96EaDNvdtIYTE67+qJoeTjhOsoC8yaKmSRvxgc0iVcaQLx1vEi
 nF5ZEzZBlr8JLvpUK03O8bN4FW2AcuRPFNeQ+JOV6GBGyahdE747nC7AI06Q6lW70yRS0VTPG1Y
 /eGhE164OxF2Ofuqb2nCBggYC4hU3/aXTUuoX0xigF0kEDQbg5oXmTsgpvfA4MxpFggbOLf1mA2
 uNlRo+MNr0oUcT5el5qFrLGaA7Cjka9tWW6MRA6yheGW6WOpQJ++umaJjc3Fyfys6zsRCGw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080149

The AD7768-1 ADC exports four bidirectional GPIOs accessible
via register map.

Document GPIO properties necessary to enable GPIO controller for this
device.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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


