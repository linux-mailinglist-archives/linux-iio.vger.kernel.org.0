Return-Path: <linux-iio+bounces-19488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53852AB54E0
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F73863801
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4791528F506;
	Tue, 13 May 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CpuwGsgE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF628E611;
	Tue, 13 May 2025 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139700; cv=none; b=dtAPWupeDILyvoTon00pIe2BGc5UsNKa+3deB0WJLLnOJ8miZrWqliQurWdGR4+cbE+LEcQvTYRoXKchp4/Vqa3qjQF1oJNS+ulkWWhyIfz1u3sMhUEbYAryxHaduJXcR0vDGxzCnhYoS8IDJErzzB6fJ+UF8jiGO6iSYu1XYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139700; c=relaxed/simple;
	bh=hBqY7u/JnFjJI/w3/g/c4OXToszQ46fwTlYxmxVH6dk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrPNMxar265lRjBRmO6GHz54t+HGrcxhpfLbOHDvoEYGk8+rW1VybE5wy2z1cnsY6RhTcxOEAvrs73SR9nfuEe9aoYld8y6ULGaossaXh4SZh9JICW2UQ+dS//JVy/NmxVfXHgiW+xZKvUMuiF8+RTvEgKOHWOD5cKBlZeoGfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CpuwGsgE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBD59m008282;
	Tue, 13 May 2025 08:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MecMS
	khtk5Z+MMSqon8pWjK1qRD4kS9uLF0Vm6JB3hs=; b=CpuwGsgEoyFjL/y05oHlP
	7zNEK6XOgfrxgCE+zQEeEvwKnboFvg8miKY9UqjDAzypy6yoTQ1SeeCI9s5PQgb5
	t8Fbr3qKM5S++MQxnBGu4vsN6zgIeg2OD3M38ssxYfzdcn3oIdkeEpvxt0K3w2T1
	+taOiTa8jZkh02fzU6RQY4aZv2ifaeMdo5MMmnHPdYJQgX8K2Lvs8mu2DfasyDGG
	nJOLB3Aq79ZMcsCHCEo4EQmGh6MWKaE/Airoa5mKi6TKarzcRezeQsdf/7svNC1u
	JIfoGvdVtsjBrYDDmLeOZGGcga86oaFS0qPukuHXEqEINi3oN2xQzGUt9UdSkKHM
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46kx53aesr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:34:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCYeIB041010
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:34:40 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:34:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 May 2025 08:34:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:34:40 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCYM1r007472;
	Tue, 13 May 2025 08:34:25 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 03/10] iio: adc: ad4170: Add support for calibration gain
Date: Tue, 13 May 2025 09:34:20 -0300
Message-ID: <3d255162174ab160c3fd06af3c27360947c2a566.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=a4sw9VSF c=1 sm=1 tr=0 ts=68233c61 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=s1qB4CsIdprNQQnv0OQA:9
X-Proofpoint-ORIG-GUID: OecLo8QBvF6yxvGH-r1AeWdjWQvteiT_
X-Proofpoint-GUID: OecLo8QBvF6yxvGH-r1AeWdjWQvteiT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDExOSBTYWx0ZWRfX0fvxGeZTsq6H
 LmMDIsy7vkehmNs86dLtpPZl05swD8vXzA+FigZaSBhdMNB1xzNAJpWWSauryVaGhN3rsVsb/HW
 k3HT/2t57uf8cJFdHdriwN3vre15R2tr2s927T5HMHPqMr+UiTL8qs48R77DPXHgjB+ubcwJ7fF
 qFG3juiBgPu7BbPm/vMezpplZmwB5BARH2IltA6/vhqjFu0jGE+ymZQSO1JfXA7eF/X98HiTBGx
 LroblUkWmfT3jnKHDB+nBLmC5fHrPHyyyvf5sGiDTDRUIGOZtsUcc09MWSYm73fuG2dCikgB6AY
 CKUZeOiZf2tuvpfeT+6i4YuV/ExDWpWCPS235xR3nMyN39ND4VTxhfBdXY3jttCZkmyGve/pz/o
 j6+WRzQkEet/5s19cBzTwezG9/VpgBY8RzMIWuq78KL/9d/tdiwh4OQlWqa0BqHsw9HqUYuV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130119

Add support for ADC calibration gain configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- New patch spun out of the base driver patch.

 drivers/iio/adc/ad4170.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index bf19b31095ee..1df214f7fdec 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -642,7 +642,8 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
-			      BIT(IIO_CHAN_INFO_OFFSET),
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
 		.realbits = 24,
@@ -953,6 +954,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = setup->gain;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -1079,6 +1083,25 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return 0;
 }
 
+static int ad4170_set_calib_gain(struct ad4170_state *st,
+				 struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+	u32 old_gain;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	old_gain = setup->gain;
+	setup->gain = val;
+
+	ret = ad4170_write_channel_setup(st, chan->address, false);
+	if (ret)
+		setup->gain = old_gain;
+
+	return ret;
+}
+
 static int __ad4170_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan, int val,
 			      int val2, long info)
@@ -1088,6 +1111,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4170_set_calib_gain(st, chan, val);
 	default:
 		return -EINVAL;
 	}
@@ -1114,6 +1139,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.2


