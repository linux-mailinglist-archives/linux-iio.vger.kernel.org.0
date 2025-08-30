Return-Path: <linux-iio+bounces-23408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E7B3C66D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B6AA00B29
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E221D63EF;
	Sat, 30 Aug 2025 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZQXgjIbY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468B2E403;
	Sat, 30 Aug 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514499; cv=none; b=OwDHdtTjnIyWCRpEbMq41n8YqapAboVMhEGDknNKtKTl+GtiOocj8pY6cOiTtLSWH5DlBoCw6b3STcovOa2/hKVkDc9kHlAxwH23pEvSL+yJPiMzZX0YoR4zmLVthxVxN4H6rcrHtcao2mxmbDlJr76klvTQbmpESocBtHMqcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514499; c=relaxed/simple;
	bh=tpJDerBCWd8Z4zWwnGPLa1SK+fgozplZ1nj+q9QbQG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbpVuYpKYSoyJNAyulvo15DFqcxRiqZIMfzBCR4XbUcg80Y9ZBvxMkHTYdek+IVkywoPWdlJlY1HaOEHiNPW0XWhzE0gUKJb7+4IcjHqSvorNCi2qV1RFaMsdXETaYiZSihcg/RBoHa29dBHqpYbov9RV1YvmmyMA9TvjZVrB5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZQXgjIbY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0dHd7026882;
	Fri, 29 Aug 2025 20:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5R9ah
	ZzwPLUgs9wi/8QuKfPdV/QxpZjwEWWnlei07gw=; b=ZQXgjIbYo0wz6CoUqBLBX
	4uY5/DwbD+udLLAU3ApSHBCSS888/nGJEQHR2y7Fh3OvfVeQd1nqniZzohufbJpH
	tDl6Ep+iJQtxOEVHWtLH9acmjwuH0vygIrrJ0pkArHY1Dmxo91LiWaEF35g/j+Ro
	R2tH9Tuag4kwq92yyupZTRQWyPctTjFkxAV2D/ZmwiCUhuvJw9tIu0odF/NRHnii
	TLYLt7cB9uEpmgvYxaPTFREOmUt/dDowKOYxJYZx/wqV9YuY3hFt56V6EnSQTfNy
	cYsJxL1UL4CJR5OrEgAKESDYSbgM6Zx4fFXRQOPJ6DlnyG/R0v2hW2Yb2fqTA13g
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqataj62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:41:33 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0fW3M007856;
	Fri, 29 Aug 2025 20:41:32 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqataj5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:41:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0fVAp018742
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:41:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:41:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:41:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:41:31 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0fEVj004947;
	Fri, 29 Aug 2025 20:41:17 -0400
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
Subject: [PATCH 03/15] Documentation: iio: ad4030: Add double PWM SPI offload doc
Date: Fri, 29 Aug 2025 21:41:14 -0300
Message-ID: <4425996699ceca9fa909bdad86b41abe8b25aad4.1756511030.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfX+rwI6dJqRYjq
 xqxzkk5+zjTy6DVocRx4kROAIAkZs5wa8ft10GGxWuMlhTocq2EPBYoshqs6baRnBd1cDeqJ4vx
 wfKVJUvN442v2NlqK/CJjT0scW34FmqKraFotbFeOh3qPHQFL9h30Fhr4p1//i0g7/eEpDVJccT
 qYrM+VvhMTPeM50IXjoCMvl1lZZDIJc5x2TBCKITjofRBZPCLne+j4Z0DmI5Vk1B33zDedlyQe4
 jlp1XR+Lj5hVI2DDuVjT6UcC967sVj/Fyqvmw5ZnkM5Qf5m8VEAcdRKpiHjIk/n5hKbh6jfKqHV
 klzAJjW4QEwHBxNuKhjrd3OoUWwrWTc8CUdkXBAi897SzapdA6Z2MWgoTRYSecyEX1IXB+s2VaS
 lwliwz+v
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68b248bd cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=DwuEUq9QxqjxwLk3QocA:9
X-Proofpoint-ORIG-GUID: EQkiZGxoYLgf36lkLC9tAiKGWhr6WDRr
X-Proofpoint-GUID: O1Vs3CQcZPmeYOHQYrOcr2I2odlciXVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

Document double PWM setup SPI offload wiring schema.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4030.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
index b57424b650a8..dc3ac253ef66 100644
--- a/Documentation/iio/ad4030.rst
+++ b/Documentation/iio/ad4030.rst
@@ -92,6 +92,35 @@ Interleaved mode
 In this mode, both channels conversion results are bit interleaved one SDO line.
 As such the wiring is the same as `One lane mode`_.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |         CNV |<-----+--| GPIO        |
+    |             |      +--| PWM1        |
+    |             |         |             |
+    |             |      +--| PWM0        |
+    |             |      |  +-------------+
+    |             |      +->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+In this mode, both the ``cnv-gpios`` and a ``pwms`` properties are required.
+The ``pwms`` property specifies the PWM that is connected to the ADC CNV pin.
+The SPI offload will have a ``trigger-sources`` property to indicate the SPI
+offload (PWM) trigger source. The IIO device driver synchronizes the PWMs to do
+ADC transfer zone 2 data capture.
+
+.. seealso:: `SPI offload support`_
+
 SPI Clock mode
 --------------
 
-- 
2.39.2


