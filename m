Return-Path: <linux-iio+bounces-21782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D25B0B1C2
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 22:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD9F189E5E4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 20:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708BE21C173;
	Sat, 19 Jul 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="y7aU6BVm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC9191484;
	Sat, 19 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957455; cv=none; b=B986bCrQNkICETPa7Es7Jnri0/66KD+A9lwzJ3JtaAkiUym1bzPmX+eIGZVyXzhC4VkrNbDNNj2PQvCD4eDJsLsoWExFMyo1dn1y0gRzbGc+ahkszeikCvq+BmuR6IKKoRavkf4k/UkKuKa1JKcPGrMvi9gGICGl7FCKWV7+doU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957455; c=relaxed/simple;
	bh=d1y7Y/qXdjcx7CdL+FADat6eddsAFGpX2OE/zDSRinM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OiV6RrynlFs+fvyATxJc99dX1MSs/oiq5/o85c2ZzRvQp+yXGRD2wk6rl0aY20/2Ie+SGAqs0g3fpXKb+rLwPc4WP+TKiHpFHEGtxyMSaqHsxMVYuRQL7nmQZ3FXVwobhqCIVboRyXiJ6z9K/VZdLSi0/QfGsKmYS9Zunp0epTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=y7aU6BVm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56JJPANx008103;
	Sat, 19 Jul 2025 16:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5VhNeZaGVO+KPeewbNqaIdq0o85
	MTUTPES/xWee+v8U=; b=y7aU6BVmKTGDHLCODdfO1M8kFaUBKO6ATkNyJEyKucx
	rtdlqtOyXmLzedVBEjpHXOcZj3ZZnIBoeLHUOT87yiH5Ntmm6nUN8GC/F0i3aplb
	uvEn3b1+Xu+9Z7802NeeWJgajM1ymhl9DI4LxLqqsKIuilKPLIq9prPZIv+e6XbL
	qnbo2gr4/X3+1Juy6NRxMZvf4L1jPlNkvZExsYrN4yTN09dar8OyGpB18LGR4ak/
	FVUYU0P5XoMj0PP8y9V9BDjQ4LcZG2nw2ZYWh3Cvw8HdHQ7qI+bbGm/shiiugEKD
	8TTSempyumsinELkIl+DhttdNxemyqa1jg954RTcCRw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 480b6p98p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Jul 2025 16:37:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 56JKb2GE054515
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 19 Jul 2025 16:37:02 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 19 Jul 2025 16:37:02 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 19 Jul 2025 16:37:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sat, 19 Jul 2025 16:37:02 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 56JKalu6019557;
	Sat, 19 Jul 2025 16:36:50 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <dan.carpenter@linaro.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <andy@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH] iio: adc: ad4170-4: Correctly update filter_fs after filter type change
Date: Sat, 19 Jul 2025 17:36:42 -0300
Message-ID: <7b2fec30e9c6a80630a5fc08fb061d17417eb350.1752956751.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8LB8axdSLzkqH8-K2XkpZKq-z1Mf46h-
X-Proofpoint-GUID: 8LB8axdSLzkqH8-K2XkpZKq-z1Mf46h-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDIwNSBTYWx0ZWRfX6dRS8Xa+wJeO
 b1gBfdTgeIg/i7O3mYTYa7oYbSPzH3mLWqShkSQo1U2BqTfpN1e1+WIBLfH0jaqUY6ohrvYpIBt
 P1Mr/dDcAYGPFAmM1ZoZZ+g3/h3/uNKcXSVCOSXWf/VxR0HPaTlheUNuceKBFrPsoN4U92GJPPh
 Aaz/mD1l+KBGPE3/tgVxVEf4aDlRHqdTD9lI8XTZeAf9ea/4I42At/xjdPi3ysK2c7sonZK501t
 ka6Q+byexasflmyjsSxlv+B//dVvsohvKNjgcmLRhZVyio2TELe5dEgV8b9jRsvv+ZRR9WDvnpG
 OKtdQEbeSv0rAceAz8x1vpBjStw8ez5uFMHPxWJevvk2ojFVnCkQLM+ldcMoRQ06KQHdiyHUc3N
 j+PhBfBErJ3nxfFZqFW7lNytcbt4r2QQQg/KpTZHKvP2OUv1wEdUQGnghuQDnqSADGhZxACj
X-Authority-Analysis: v=2.4 cv=KKdaDEFo c=1 sm=1 tr=0 ts=687c01f0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8
 a=dFwZVDRm2i14ZgZprooA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190205

Previously, the driver was directly using the filter type value to update
the filter frequency (filter_fs) configuration. That caused the driver to
switch to the lowest filter_fs configuration (highest sampling frequency)
on every update to the filter type. Correct the filter_fs colateral update
by clampling it to the range of supported values instead of mistakenly
using the filter type to update the filter_fs.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/linux-iio/c6e54942-5b42-484b-be53-9d4606fd25c4@sabinyo.mountain/
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Fixes: 8ab7434734cd ("iio: adc: ad4170-4: Add digital filter and sample frequency config support")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Didn't find a bug report in https://bugzilla.kernel.org/ to link with a
Closes: tag so added a Link: tag instead.

 drivers/iio/adc/ad4170-4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 6cd84d6fb08b..de35cef85a6e 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -880,10 +880,12 @@ static int ad4170_set_filter_type(struct iio_dev *indio_dev,
 			return -EBUSY;
 
 		if (val == AD4170_SINC5_AVG || val == AD4170_SINC3)
-			setup->filter_fs = clamp(val, AD4170_SINC3_MIN_FS,
+			setup->filter_fs = clamp(setup->filter_fs,
+						 AD4170_SINC3_MIN_FS,
 						 AD4170_SINC3_MAX_FS);
 		else
-			setup->filter_fs = clamp(val, AD4170_SINC5_MIN_FS,
+			setup->filter_fs = clamp(setup->filter_fs,
+						 AD4170_SINC5_MIN_FS,
 						 AD4170_SINC5_MAX_FS);
 
 		setup->filter &= ~AD4170_FILTER_FILTER_TYPE_MSK;

base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
-- 
2.47.2


