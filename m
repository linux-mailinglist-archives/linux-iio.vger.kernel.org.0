Return-Path: <linux-iio+bounces-20218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35120ACE4EA
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B6E7AA586
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E137212FBD;
	Wed,  4 Jun 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="StLWdHOx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9320E030;
	Wed,  4 Jun 2025 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065789; cv=none; b=od6v4uu2h+3JoycOk5fhExHH7XpeE9Iuw0vIrqVtL8Ob9jsMyOVRX2l3/dyWcZC0ZosoIcBhnbbyn4PUDzgcRTa2AHxmFbA9Pv9lOXocZG2TUmIjbYPv1h8qHUoh+BHIuek337yjiIr19BvnBXGZW7NnFyeieJYZnobZlJRfepI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065789; c=relaxed/simple;
	bh=cRyW+OsprtAaIzD5oM05Biph6WAKTVGpqzgRA9+AKNA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fobaDeDay172zKqyfWl4v9nJLlFNS9XlGHuOKXF8VrWcMLw7AF3QEqiEz4pZYmuXM/O0ABM2bWoZdHO5HDfaCqgW7sYWgHzNLfThDRwEXw8Uyp/p5J1+HRf7WOoVB7csdwTZhdCN0/v/gYSa9dY0igylr2ts08wMGDRYbi7kuuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=StLWdHOx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554F5lhC028815;
	Wed, 4 Jun 2025 15:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EmpjY
	JrV1NcHxydyyQVCHpcTEWcrfy5MkalEWrP6TKY=; b=StLWdHOxvLn9nyVUYtzyA
	0MkU7U6nxCbs52I5sYVVhswnPV6c6NRa92NQ1u5RQzL6rvcdotF5jm2hP5NaZrfw
	sdR5aoHMjkCzk1TXgwMv5FpysvXEObUlzsfR3yUsoJVpxLO/CO8cru4cl7CYUtGj
	saMQZkKPDH0Ukb3jUQi7+jPWWjfb1KU3A8T7p2bfbbWnvsSVI5WbdxAEFNSr6udi
	dCLSQKVw3H/RKCQExGWtOlag/nIcjnQwZNT2Nuu5UdMjlAHHqMxHOMGsOiRwuXe9
	e3gdJVBIjXsJytckn2cKbdeL+jpZWDXVKcmH1KPWmhn0Cw6o3ud+EXumOGm1/2oo
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 471g9j42dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:36:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554JaKGs053756
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:36:20 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:36:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 4 Jun 2025 15:36:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:36:20 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554Ja4cV014316;
	Wed, 4 Jun 2025 15:36:06 -0400
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
Subject: [PATCH v10 04/12] dt-bindings: iio: adc: ad7768-1: Document GPIO controller
Date: Wed, 4 Jun 2025 16:36:03 -0300
Message-ID: <cabbcbef9b1c8b4fcee5df82bbcb499eef9c5dcb.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mLyJtu22d6oZ6eZEnxnnjsMi9H307vR8
X-Authority-Analysis: v=2.4 cv=DfIXqutW c=1 sm=1 tr=0 ts=6840a035 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=FDCdkw0c5cjSjuxHnEwA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: mLyJtu22d6oZ6eZEnxnnjsMi9H307vR8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfX6fPfq21/C2+W
 nqpuXpICFpsXkq8kJ4ARZGJIrJUfgpouTOZJrl1doW+yn9DTho90oU0ObkGeoR7+rfTQnEi/HvQ
 eVWWNKUtIlksm854O1RrGkFiRI4oO3b9UjfzeJgIGIvsLz6yRBDdLqyR4tk2ZhgZm1/jzNuG1wB
 9HVJf7z2RsT+O4UqK8pMPar2MPX610o+n9TlJ/PWKKiW/bkN2uwZx62gsQYWM2PQDm09IAnEp5R
 6E/isr/cJAUNzCyR3UieBoplLMyHIoeC0nx58JpKZjZ7eraDvq0IpRKV7SSfIgpolYbW4oaGcd2
 +WDejmRCOAbPU5eaIEe9oTUQ3zRd9Djo9v9xuMB9xhDrhNSW+xgYyUwfNmTWwiEYuE43CjEC+YQ
 xuyC5p0LxytAUjcgeIdlCW+zAxOTB5eys3HnrMoBqnA0gid7le2tqCINWuIfP6jD7MZ6ar3L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040155

The AD7768-1 ADC exports four bidirectional GPIOs accessible
via register map.

Document GPIO properties necessary to enable GPIO controller for this
device.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v10 Changes:
* none.

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


