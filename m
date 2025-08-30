Return-Path: <linux-iio+bounces-23413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49653B3C692
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058E8A0327D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761AF1DF97D;
	Sat, 30 Aug 2025 00:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XRgi4aaL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00B16DC28;
	Sat, 30 Aug 2025 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514615; cv=none; b=PkFUN5zo/9h8iLj1H9QlNDFDLY6PfkXFLnJZYjIS4BSS5DMd1ARwdi3FcO6JP61gKUSBJ04137J32hNjsiCrQHo0pM/nk2CTLExZ8+OtVncBaDYj6H7P5uucMNc1RyS5BkkgCV6zYdOp4m8joCZAE+9EL9k9ywRqSBhFun0F1Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514615; c=relaxed/simple;
	bh=GcIDpuah604GX47Dg40jGDUL+iIjWtlKiwlafzBiYt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QY5ojgO2W0fZnWBTG3kl6EMjUOfPERNldZJyGPFCa6Uox+PKIwgDs7T/Lwwq8KSxNkG86nUL70V78GPRGlpXxUqe/eRatmujQ04Vc9blxzMMTnlSTZyS1Op0bJcm6q+/N10bxX0SzL+2GWozYxBYnxIXXJJKFJUtvY/gHkDQGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XRgi4aaL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJR8Vr021598;
	Fri, 29 Aug 2025 20:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YQIli
	+DgU4Sx6hpjVbLjL0Ls5BqzmxpUkb4nB4yGUDc=; b=XRgi4aaLskBfPPSAGBWdn
	oQe2sPQAEdUfnMBu4nZapPV3TZMYN0G2vC/MUpZQITlIGesnBeaA8+LQQhrMhU6T
	4aMRro53fZP5CWZCzsUHgf5COdYLPFyNJYLvoMZo703b0mBKxHzHknk8Um6QUDqM
	qNNIsscftE5alIDO+6bSsx0PhPYX3k98YFLx/lUaV2ZKfSGnxigiQtJaCO/M/T8d
	63ZEv6uQG+T+vXSWnFEkOU1Q0GyDiPFujaA9c/MWHNPN6Zbx8ntmJpkX+N35B68d
	yvoIvCDprPxL7QK2mFCHMYfC2fmHnLqvBb17Ix9dJfTG+I0/hvm5tlkiCVxlp3i5
	g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagcgw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:43:29 -0400 (EDT)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0dHn7031062;
	Fri, 29 Aug 2025 20:43:28 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagcgw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:43:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0hRHT018891
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:43:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:43:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:43:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:43:27 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0hAlY004981;
	Fri, 29 Aug 2025 20:43:13 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 08/15] dt-bindings: iio: adc: adi,ad4030: Add 4-lane per channel bus width option
Date: Fri, 29 Aug 2025 21:43:10 -0300
Message-ID: <8011cd2b2f2fe6fd162bc4b4b75ec64255516a87.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfXxqhY9BBUQb0M
 Qo61sUskWsxUYpPy86xKNOj3fmjc31msUCyr42/o2ZSRp2vVD9AgFnpUZQbkfpzJBpp5Js8VpZ/
 xD89Kz9A4EIXjWkjq9VOqXI5W/1Zcrh0bInW78Njxt4k1yoOOK0CcHZoMnZzF3Wdva05c+qqLq6
 FDUZsdQTXd/NEatkDtBMEfG1ZaLr/dg/cgwQDGq0GG78dCNNy3J6qKM68/M/gwEflccyhPsjZ6u
 /r1WwgKzm5DaHFuOkEEa0mGLQeg7tQSnkww6c7dfNC8wCZvN6P6SI9uXz7XK2YzoP9ElXB5SL1i
 t+MUutP5+A1PbFteuW8lMI4pYZq7IuD8El3oKsgBFQA77QNNrDDFrbVV1uIgULzWE0eO+Ci2+VN
 FNPr9/bM
X-Proofpoint-ORIG-GUID: VPSe03N6ByXMQDltH_3iNVdd7zzpcyvD
X-Proofpoint-GUID: _Vs8m2Vt4ag-jTHQUsmDJqdOkdEACasO
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68b24931 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=lK7_pbyzKmk9y7L_IogA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

AD4630 has two input channels and each of them can have it's data output in
4 dedicated lines, resulting in a total of 8 data lines used by the device.
Document the option that specifies the case where AD4630 and similar ADCs
provide data through 8 SPI lines.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 564b6f67a96e..bee85087a7b2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -39,7 +39,7 @@ properties:
     maximum: 102040816
 
   spi-rx-bus-width:
-    enum: [1, 2, 4]
+    enum: [1, 2, 4, 8]
 
   vdd-5v-supply: true
   vdd-1v8-supply: true
-- 
2.39.2


