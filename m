Return-Path: <linux-iio+bounces-24471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A928BA51B7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D705742621
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E628C039;
	Fri, 26 Sep 2025 20:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gGZH/LWX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4876285C95;
	Fri, 26 Sep 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919292; cv=none; b=bO80YD++nS2ydOAOC8sgpjMLoxPu6n1Ph1uzVpzmeQPXJgtgtHwX/sElyvbzL/EnS2Tc+1XcCq98VVwIikuGozbKGTbM1I6YX6ZXdCCD+N4JTQyujseaefHUIYis2ywj3qbddnCy/gQvEQTy7dAOdXlTWHecpGT/utN58mnz6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919292; c=relaxed/simple;
	bh=mzHNgv2o4i8/Lrcczcapvp9RFqY9cJtR+vo6bqWGAU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taJITihhM8wytmxpeUvlxARekFM1xxVvwqU1XSCp1ydMZ2nai0/CFuc5l9PsC0Qhk0c0uISl23m0SUUW6GFzF4x8wLUQryDFj5Xw6SXPuutGyltraikpw196dIamLeY5kR/znffTwtZklvne880KTNi5oL2HgI1a2Ue+JOlXIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gGZH/LWX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QFlAZD019428;
	Fri, 26 Sep 2025 16:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VDUKR
	ZSJWAs/gkKzIwgdj0tML9hZqJO8d8boAN9e7us=; b=gGZH/LWXpklelHn3xsZlU
	MRRZMvY63BgS794IqiAQrdrU4bT8KN9b/n4ALL2vQo0XQVR7uZVKrDfrZqYCI7FT
	yJ9JBH7/Vm1wLDD/FdbDp90yLV0Iz9k8HbjXKof0yqH8Ca6ysVk4bIjhAaA9Z6MN
	gsFxO/V3CNbllrokVMx0eJ1wR31AGE+6Q+/SoTQfC4aheLSQmrC+ygs0HIndGDvb
	OEDztV7FVzTqYCrmGh4hoH4IUCS7EoLOQSlzf2PslquL/gl4Gn0yZvL1Bf1rKQBs
	BGvUB2h/uciI9bRftj3ocmv+XcMJ0WcVSaeX73kj/Ds1jHeuVLtbZdvYP8ojoAF8
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49db1ef96j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:41:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58QKfQ1a006550
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 16:41:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Sep 2025 16:41:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 26 Sep 2025 16:41:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 16:41:25 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QKe9NX010369;
	Fri, 26 Sep 2025 16:40:11 -0400
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
Subject: [PATCH v3 5/8] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Fri, 26 Sep 2025 17:40:08 -0300
Message-ID: <2de5bf50658d5a25d86231b3d1f1ec104a9f1a56.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: wPkWvlp4vPpcevHN0tdfDCFrJhcDAzDN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXzEVFp9e4DYAf
 ZymQZuNXfZWKfNKQYkOxML87WLyYW35Fd64Qdel/I+XOFexQE7YimqFLaUoFkGhNiCtfns4uMsz
 /a8GqBofemK5/qyBoKFUwoS303jsEfytMc9SVg5nabPgSg2EDg5m0v30UogsQL2DwMzwIuwQ+KD
 Tn6KnRvT+m63HXL2WC0PoPrW0Zbp1AL7j6Zt4ETlfoMaouFS2HppOuNfXvtia7JcgXlqI1/Zozb
 VZ5tu6CVnSZ5pAy/DB3Yz77K4uwsf6Il/EVwWULIktPIm1TMLrdNXAgDFVYvDRfeaq8D8RSA60i
 FpuOTeSIB5xlT65oL55MOkx4ANUWLtMNgN4H5sTaWQm1duZpOa+t4RJ/U8+BMXjU3WNQvFRL7I1
 cWtF7bn93i/hZc5n1pm0udWsn7P7rA==
X-Authority-Analysis: v=2.4 cv=YaGwJgRf c=1 sm=1 tr=0 ts=68d6fa77 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=HwBGVG7bte8kWS4IyKsA:9 a=br55WurUj89AL1qEz8Q6:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: wPkWvlp4vPpcevHN0tdfDCFrJhcDAzDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/linux-iio/CAHp75Vfu-C3Hd0ZXTj4rxEgRe_O84cfo6jiRCPFxZJnYrvROWQ@mail.gmail.com/
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 7f0dbb8a3b07..cdf5933e9725 100644
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
2.39.2


