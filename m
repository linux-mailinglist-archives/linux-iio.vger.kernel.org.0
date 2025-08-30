Return-Path: <linux-iio+bounces-23406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 446FFB3C65E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3AB7B77A7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235731AF0A7;
	Sat, 30 Aug 2025 00:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pSUSZsl4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE60192598;
	Sat, 30 Aug 2025 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514450; cv=none; b=WAyg5pBvpIs0s0BGx4OGO1jYIkbb5Dhc44sePjzQ3pO2lAjiMlO64Ja89+jWpVaAG7DOjlS9w3hZYX96hlp2tPqQlGFot5jT8qb9hCeYJYvtAMm369XqInQVy1d2nXYlNBUsrkUcgZcvjLdZkZw84y+j3NvHuCmslROuwf3HaCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514450; c=relaxed/simple;
	bh=R5v2CbtId9QiLI674TrD2NNCSx0GiW7rkC88QcylqqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy9oTpy0jndi9/JlPTyz5qICCak0nB+drNNULesjBnyhNYROhD6P+dZAMhM68ovsdcfVau4DjSvYmchSTExsX9Mi4YD9yJRppIhSX4vIXUrTy/PQnHMiwAHakQi2lTNfj49pekaGFjCR/i/gA/0UxUG5SJQ8j3y9yQ734HrCDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pSUSZsl4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0Xtou026857;
	Fri, 29 Aug 2025 20:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Tkcpv
	EbPVqRwdmIq6F9eiZaSGFwF1Dt8mzAmP4bNjVA=; b=pSUSZsl44DYIXlsSMIkxX
	uGQftV71yCO5ER+Ck39hqXcnDA51PhIQbg37DVI1V/fTkPCDrLnC+1xoW4TDtugI
	BcWPewEOCcDtZhyorNUInw4TxZEB3E0NTOjMoozFLZw03wezuRrWlM0Vh+ybPEwn
	+/yNeyU2G62ZXbAYVR6up0DCtfTF14a5eDH3euf0JR0PKw6EGm9u/kQ3MXUNMMAK
	f8krfB20GnNkbqKaTpXQA/T7rKVOt15Ghb+7+5nzQDevXvcDt1jDmlpWVp56NpSk
	wsrByWeOoPK2W+nLsLdLvGWrBtzL8R5GSXZxGK0Y60QZ0aTneN0YhF8QKuM6xQnt
	w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqataj39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:40:44 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0eOuv006372;
	Fri, 29 Aug 2025 20:40:44 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqataj36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:40:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0ehYS018613
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:40:43 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:40:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 29 Aug 2025 20:40:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:40:43 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0eO20004924;
	Fri, 29 Aug 2025 20:40:27 -0400
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
Subject: [PATCH 01/15] iio: adc: ad4030: Fix _scale for when oversampling is enabled
Date: Fri, 29 Aug 2025 21:40:24 -0300
Message-ID: <f9d40e8deb3d17a41b4fd6ecc1b8ac92275f0078.1756511030.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfX88zzHCq5/nDO
 r/wjf39sT6kH9nlc+rvMqj1oA72jpN9EWxuS/Qi8CEqYKXAuwfHa77kq+pcr33YoWDyhTfhnuOP
 eTBEPJ+s7kOXsbk5ks1bRhKGfEjabW+LApJdKSH3eYYZAB4/eiIVOx9txcBkVHesAi/zljk35yl
 NK44taHcRbmsgwjzQlXBig4vbyYyM/BEURGhp2RgKWA8cJxboQ3E8j0icpbKO19JVNjXSVHdBfB
 Y6rfoqSRRypmUenU2OPJyhMpyCWQ83WQj87ukEikvPhYiCQfgvKMRc8lv60fD99ERzKekKVn0Pm
 ffZL8IbiQrcCn7XeF2bf+AJYsjkkuRFtRD88UB6IJeggykgRljSP98zJXy93oIVeYUDe2BFSV2m
 nByu28b4
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68b2488d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=FmaFMTTwz6kbnnVnduEA:9
X-Proofpoint-ORIG-GUID: SIx78YnzNXhWA9UmnaPYZg1sp0jXu7sU
X-Proofpoint-GUID: QjX7hVZAAzztxX10HSRsNVuwIKPK6Jly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

Previously, the AD4030 driver was using the number of scan realbits for the
voltage channel to derive the scale to millivolts. Though, when sample
averaging is enabled (oversampling_ratio > 1), the number of scan realbits
for the channel is set to 30 and doesn't match the amount of conversion
precision bits. Due to that, the calculated channel scale did not correctly
scale raw sample data to millivolt units in those cases. Use chip specific
precision bits to derive the correct channel _scale on every and all
channel configuration.

Fixes: dc78e71d7c15 ("iio: adc: ad4030: remove some duplicate code")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
This was probalby buggy since 
commit 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
but I decided to set the fixes tag with dc78e71d7c15 because this patch will
not apply cleanly over 949abd1ca5a4.

 drivers/iio/adc/ad4030.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 1bc2f9a22470..82784593f976 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -394,7 +394,14 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	else
 		*val = st->vref_uv / MILLI;
 
-	*val2 = scan_type->realbits;
+	/*
+	 * Even though the sample data comes in a 30-bit chunk when the ADC
+	 * is averaging samples, the conversion precision is still 16-bit or
+	 * 24-bit depending on the device. Thus, instead of scan_type->realbits,
+	 * use chip specific precision bits to derive the correct scale to mV.
+	 */
+	*val2 = scan_type->realbits == 30 ? st->chip->precision_bits
+					  : scan_type->realbits;
 
 	return IIO_VAL_FRACTIONAL_LOG2;
 }
-- 
2.39.2


