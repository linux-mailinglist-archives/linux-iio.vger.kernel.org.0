Return-Path: <linux-iio+bounces-24265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40694B86449
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66011565EAF
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073031A7FD;
	Thu, 18 Sep 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EzKydJLF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513D3164D3;
	Thu, 18 Sep 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217159; cv=none; b=dKImiz3BrTf+WOSdT7Jc+2BvtgP4ptLcKgKCC3aN5oeowROxyrop48bCWGqqEjzm1iQrlzWYxTRPhVXYqr6V0EpNZKi3LDM8HMaDohqNe8eMcqNZmXIBI5Wf0t2hRPRKfIW8lsx65m9FW21g8qk2FpFUu4nLmNlR6IdIPujj4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217159; c=relaxed/simple;
	bh=QHxI6lVIUt7y4IBOL8kBhM7M+Kpi3kc7BiewWUfm+Ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCpXJr4PZHQpdsVhGov7yfrkGRNzCQtSbEJK2FU0MtZbFm1ELVSNYMIqZJOv613mL6BiASn/qVyti6aj68ZjobVnsniMpPaWPROmJnFtH4uWWuRfUSY/GzRXnTCCtOOoyj61loX3mFPSoW9rVqmSDC8aqUalW3mXIZ459zj647I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EzKydJLF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGFENh022817;
	Thu, 18 Sep 2025 13:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A0Zot
	YTytb7wINIzIs3E1qS3q9t70nlHgdrnL/jVs/A=; b=EzKydJLF3/z4vNYwUU+IX
	3N1rgC4y/Do8eIXP1O2QgU6xkQ2RYbukFwOgWH+3OX5zfk1LgJ8wFl+EZghRgA0S
	hNBwrPDc3e7VP2xtblvqp4P12VXn8N26rHLSrMOxMvAhSGMPNrCuuOXMRtuE2Bls
	0jLCOCHXiRwj6gkHbRNeeK4+ntaGyF5mPohAYFdyqOZJpVOm+/s0WdL0eG62EcUN
	qF3X8o0HndQuhgW3ODwtvZpODLIOqw+tWF+Ug+P9sMm80QXV9Uz2/okCMoQBqCy8
	IuNCZBziRu/ZRiMpHR725fceKcKZlJTmvekYLAnpKyCEZfIQqJtNbAYBix23AKkB
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 497xre7v39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 13:39:11 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 58IHdAGW013850
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 13:39:10 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:39:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Sep 2025 13:39:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Sep 2025 13:39:10 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58IHcsfD022222;
	Thu, 18 Sep 2025 13:38:56 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>
Subject: [PATCH v2 5/8] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Thu, 18 Sep 2025 14:38:53 -0300
Message-ID: <0bd4a1ce0a26ec95cf5bdb10357879cb665cd0ee.1758214628.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758214628.git.marcelo.schmitt@analog.com>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GIOwPOybB9R3bVi-JhUTxmVLj9uxtha_
X-Authority-Analysis: v=2.4 cv=WZUMa1hX c=1 sm=1 tr=0 ts=68cc43c0 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=HwBGVG7bte8kWS4IyKsA:9 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE0MCBTYWx0ZWRfX8CCujpEUyGp8
 UEcAl1HobrYXkkPKJlYWP9fNrBHGVSY8oPOF7qQKcSQ4D2iS1BEI9eV9jidBUT6XwuS9f8y7oVl
 360uPvg58ZO3Wuu9NBuZRpyrSSgV6dCgp6Qj+Y44zHUdxw5UM4kf00kOySgFag11nPhob55/wai
 HCOFItEf8grVlvWQ5jXWggHtF+cZOT2/EeQnELDp3xHCnamiZ+C+ItmUnHz5z4emfJ5GdRpWDlq
 SL8h9t/wSV+Bl9DWavxC45rEWM64oB28wMxCoEMGjNNetmD4rkkKHHNrYVyEZi/vHJTrL/Rz2S9
 q2yJRNAo3YrmsUx1Qv1ros8Q4mwdibfkvzrwojEV8Jk70wU9lsUiXVTbA5mzeOASlagQL64G6KG
 4g0XEaQ/
X-Proofpoint-GUID: GIOwPOybB9R3bVi-JhUTxmVLj9uxtha_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1011 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170140

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/linux-iio/CAHp75Vfu-C3Hd0ZXTj4rxEgRe_O84cfo6jiRCPFxZJnYrvROWQ@mail.gmail.com/
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index d8bee6a4215a..aa0e27321869 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -233,9 +233,11 @@ struct ad4030_state {
 }
 
 static const int ad4030_average_modes[] = {
-	1, 2, 4, 8, 16, 32, 64, 128,
-	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
-	65536,
+	BIT(0),					/* No averaging/oversampling */
+	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
+	BIT(5), BIT(6), BIT(7), BIT(8),		/* 32 to 256 */
+	BIT(9), BIT(10), BIT(11), BIT(12),	/* 512 to 4096 */
+	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
 };
 
 static int ad4030_enter_config_mode(struct ad4030_state *st)
-- 
2.50.1


