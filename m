Return-Path: <linux-iio+bounces-20764-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32586ADF3ED
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718F8189FF45
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504872F3628;
	Wed, 18 Jun 2025 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="C7JZFRxw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B802F198E;
	Wed, 18 Jun 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268204; cv=none; b=hJuuteFkAdniJKWFvakt56HZKTHjqH80Dk+r+WbdgYCbe4/34wT0TQ9df5UYacitee0ErR9xgmHYhwirfy8YW5jLMKfMnNPI5iQhHAfnkcEiNjsLtEZZLE/1PHQ93eO0nygc2Um+fNOTIrdyYxwJ8xsj5a982y/ZQIG/BnBVA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268204; c=relaxed/simple;
	bh=XHZknbguom8fkunil8PybHRQ+S6GekFYDx/PRHD+ISw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkfoW/YybFztqisL4Vqgn+oKp/c5+JLc4DIXRh9GNz0csiMXB0jhh4TTxKfB1OHuCXvKpiCJiHWQK6Wp5XO+bYW9IuPDZa8HmIeQa6qZMQ2yw1dD6sBO/aLm5cn6awmvZNPF1LwqdbmgI/JYv8MgUk7CBpcz2NdIwO6jLG+v/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=C7JZFRxw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IGv7Lg032726;
	Wed, 18 Jun 2025 13:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l1pBi
	DClr02yKY17/Yq7AB4mIpKfmz6p8rCSOFHt8tM=; b=C7JZFRxwwjvLXcCQGtbXK
	wohQtukJsGwHXx+WVjFJb8PlsA5BJtWgXpFRJOul0gfPsuy0oNtkzHNwQm7w9RtE
	hKNCxZSIbc9ePWaYeOeMdhEHA+Rbj1b7lJNAAA+oeLkLZCcZSoUkgAn5tOOogSW0
	817HeVlSqkKcwwcrD0CSgDg+wcTQIfoQhcZZ9LX/CSlXbis54DePYWnv/xmQXsIu
	HP8gmogah6H6FoT1MgD1B3wXOgynwQgRefXfak486SPc8MMDZZVD6jHqto+dpIrx
	iBIQOjr0HOzPEuDy4+WH9UDi91e5azXKX1lR2G7gd8mbYVAjx+xni99h2mFvOomk
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47bfshdd50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 13:36:25 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55IHaOg7015881
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Jun 2025 13:36:24 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 18 Jun
 2025 13:36:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 18 Jun 2025 13:36:24 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55IHa5WJ007447;
	Wed, 18 Jun 2025 13:36:08 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 03/12] iio: adc: ad4170: Add support for calibration gain
Date: Wed, 18 Jun 2025 14:36:04 -0300
Message-ID: <49119fe62e7791caa2a8ad6eb2a3c7ecc175f113.1750258776.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1750258776.git.marcelo.schmitt@analog.com>
References: <cover.1750258776.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 59MakZl-BaqHock-EaLVQZjeGZmZFaB3
X-Authority-Analysis: v=2.4 cv=SKhCVPvH c=1 sm=1 tr=0 ts=6852f919 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=s1qB4CsIdprNQQnv0OQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE0OSBTYWx0ZWRfX8LAht16QBu4e
 BQeAxOrKaYxzP96696HTrVpytzbGCEG53HJGpPKH6HWecy+WaHQZ1cy0PgkhtrnkA3i8JAzZERF
 o23KYzHpFv4Rol8t1VtKsfY6hcM8tVLRfjroBB59M/aTlBWSZBV5QPajVpTvWERjtBUbJOz+YBo
 DcBa6d4dxSutQGc3SPSeeiYDAdkfVTMAdlz7V2aX+KA0OYIiuDXmxG8JJIEMa1iCO2/kyTzUUEI
 eBKeBBRsm90HAoxq9PnSARObcqkRCD4y/jruoSe6O3aQX42fC4z2DFcBRwJ/n1iYbM9GciAd9UZ
 DJ/wB0O5yeZMueJtvDSKQkKgg5Yto+dlUbJ6JW0RLmjd2sTNZdXMJopaGlFedPlScxx7pK80jOU
 t8HwKTRK/veARIRuqo7BgSvtRQ8wjwZXp44ug62KqCFPDzB5R9UdsgVp0qi0xF+SAbvh50Gi
X-Proofpoint-GUID: 59MakZl-BaqHock-EaLVQZjeGZmZFaB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180149

Add support for ADC calibration gain configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v6.

 drivers/iio/adc/ad4170.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 58716ad6e7fc..7b85771ff0d1 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -628,6 +628,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
@@ -945,6 +946,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = setup->gain;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -1059,6 +1063,18 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return ad4170_write_channel_setup(st, chan->address, false);
 }
 
+static int ad4170_set_calib_gain(struct ad4170_state *st,
+				 struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+
+	guard(mutex)(&st->lock);
+	setup->gain = val;
+
+	return ad4170_write_channel_setup(st, chan->address, false);
+}
+
 static int __ad4170_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan, int val,
 			      int val2, long info)
@@ -1068,6 +1084,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4170_set_calib_gain(st, chan, val);
 	default:
 		return -EINVAL;
 	}
@@ -1094,6 +1112,8 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
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


