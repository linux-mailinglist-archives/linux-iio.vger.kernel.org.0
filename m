Return-Path: <linux-iio+bounces-18739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB80A9E549
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0885189A579
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F11F5F6;
	Mon, 28 Apr 2025 00:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oN62osVQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470F487BE;
	Mon, 28 Apr 2025 00:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799179; cv=none; b=uRk7CvhgbuZ4iqE8xqpbyqOBzcn0Thkub4/iWL7VP2S7GeImKf5oCPxBFn8kAEf/nr8Z7j65pUHo+Z0eu9AaYVVmzZ2tsu0cNH7WoVrEjiSFq6S4aY8y8GmbVf54AYcfzSzOX84Es28n78FdwxB1GMmdcaNjThACJlD68ovSK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799179; c=relaxed/simple;
	bh=eIS3GZPwbLQeINkMZ0VV3NlxARLpXwsPrDUvC1qauaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kx/y1LLrFFodJfPwBN1eHriAPfiHtK9aZit51COiuBgIGDppNj6BEynDPNYUI7ckk8sfwusUIZMA+P32PJVzgp9YrMFC1t28c8yTgLLE6pzmtcKX1c0U4TtBTwDPtIkTwhC1VH/0H8+McuBITQ9MTIkRXuh2ZqN60tkLtaGGPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oN62osVQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RKDrpJ027673;
	Sun, 27 Apr 2025 20:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5vFsq
	bQZ43ewqNP7/ZVFRx5w3U9mYMjfcygfBoGfWRY=; b=oN62osVQKhZ9awuGEZ+pK
	I0fWL7oQaVDW6wx86tH4AArrXOOe/FhO30pQ1I32MMuLXrKBJR9ZNllWdjWlkiaE
	lW93OJUh1CYZMRcmHPZIQ+yQJYqN+6hLNeTXhy8zsN0wEuWg5bCNqg0E/JNLrX3z
	WsyrKk3fsQOPqxCc00UI0X4tlxrIxlBCeIsG3SZ2+ZCkBbx9457KhewtTGs/3Xnt
	UWKDtPdjV+3+16gmYtyOu9rTOV2vdNkW0NYKM4yhiqfaVOM5kF/cmRMvQlyeMC3F
	+UGa5FNcDBLdkBdwX49F3A8pfORuXoGKxpBFImmFIKW4xOQb9lFRYlbzF6vBiYWv
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgcmc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:12:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0Co1b028856
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:12:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 27 Apr
 2025 20:12:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:12:50 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0CWZt014585;
	Sun, 27 Apr 2025 20:12:35 -0400
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
Subject: [PATCH v6 03/11] dt-bindings: iio: adc: ad7768-1: Document GPIO controller
Date: Sun, 27 Apr 2025 21:12:30 -0300
Message-ID: <a3960f6d59d2659ae32450cca2f493b01f2b9add.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfX1Azlr99NHSs7 +MIKWCrm3IRRKyR1tPn1gSEGzs9ynteX4NZcXHeu+ZnKT61jHab9f/BVmzLmNc7xpfY4UULvLVj y/MzwZoFd/df+K+lK70M8WEbNRfyx8IM21yVgkGxN4fZ93Etw7ZVLY12b1O5MrEYsHy9SMpRmUv
 4gKwDjGbYYcxOkbQc205fW3Ulf34XpM5MrfPSFsSeGbWVMObQgPG+bBK1+CB2hVILYbniLnWGbm Ww0b3ENwYqwIJ8jv6+clNyNFA66IllIzKMsFjhpT/MZ3yp1L5QNC+67bQOcbzgoVAbjAGloVgqV O7L8DAjXQNU0u1u9GUQ0dQJMAqN55mCRr2ujwSbmRAyKYIZDWnnxrYMJGrZ/hLzYGeSpFickTnC
 6soB1VjtSSBV7z9bSkqqNfxiUEn4nAhhCuOQ5G0Wxi0pFmjzuBIwV7sszMfVMu8ydXdv0tRL
X-Proofpoint-ORIG-GUID: 8rv4ingJgcYSuasGUsQvWQpbUD-AQfmy
X-Proofpoint-GUID: 8rv4ingJgcYSuasGUsQvWQpbUD-AQfmy
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680ec803 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=FDCdkw0c5cjSjuxHnEwA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202

The AD7768-1 ADC exports four bidirectional GPIOs accessible
via register map.

Document GPIO properties necessary to enable GPIO controller for this
device.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v6 Changes:
* none.

v5 Changes:
* none.

v4 Changes:
* none.

v3 Changes:
* none.

v2 Changes:
* New patch in v2.
---
 .../devicetree/bindings/iio/adc/adi,ad7768-1.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
index 1f476aa15305..25d4995c63a5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -87,6 +87,14 @@ properties:
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
@@ -134,6 +142,8 @@ examples:
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


