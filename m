Return-Path: <linux-iio+bounces-20129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D8ACAD53
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60D417C70C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD220DD75;
	Mon,  2 Jun 2025 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b5/6zmpy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95092C3278;
	Mon,  2 Jun 2025 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864269; cv=none; b=USNOj8M48XXDlu0CqbqbaSE8ov9wWZZR0m9TOrrC22jJsioFIjPJadSPgQrQrOKAz5anww4LYgRMlbE9HJ4J5MDzz9fkujfxARV1+JBy579dh8++tKUFJO88Daoy3FAMK2lyqqshJP9uZNFawwC0qheRW1M6jpYV9tEo7abaVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864269; c=relaxed/simple;
	bh=qLOYxSvxclZj0qj+rpp9cGWeOQZF+x5ExNsdsmgXyj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SdSS+5fZuEdVChGaRHEhMV++qsRr2StO6SEVjATA01FEe1F/yVC+tuQOw02fCfb7vAZLZ0AD35Lb3OAoCqP3MDcfXfp8hTpsrZ1v4SREaZYZwvGX2bAA/gIz/yA2ndv+BDo09BHi//tC4pqLPmlWIjsQAa4ZKZ2XM7PKmgDRVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b5/6zmpy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55283FXO020785;
	Mon, 2 Jun 2025 07:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tpdYa
	0LX4UegjYMyca2vMhsF4BBiJQRu1isucu7Qubc=; b=b5/6zmpyy904LTtbg2Chg
	s70NCOLgmxcrXzdQD0Bqqaay5lnqx4fGjgOKkziMdVGNYk2Lxzp695wUjxeOXeWy
	ZH9eDuiLxFntQINQBT5uhRXpUmUA+Es1XRnxlADN7xoiR2DFfkkFseJplh8pKI8l
	KhfvHSEJW8gcFSvZ9Sz8EFBvvYJEqs9yeROyJzKzljWtQFu32wXoVjWHNpoT7VT7
	cE4oPb1+MZlGl3lJZIU+FevQNGY4aYGuP/vOmVKQwsfUzRjRXNxHQgIVFtgSmPAU
	t1C8hLU1WI/cPAb9hwpgT7hUXQ6yW6DjE2ohagOuvsYVwmaZZ9sS7qkxrek+ynMI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46yxp57ayn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 07:37:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 552BbUlR043180
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 07:37:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:37:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:37:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 07:37:30 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552BbEIV024894;
	Mon, 2 Jun 2025 07:37:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 03/11] iio: adc: ad4170: Add support for calibration gain
Date: Mon, 2 Jun 2025 08:37:11 -0300
Message-ID: <a84963e1f17b009ccd752a8033a1f882c23f76f1.1748829860.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=HdIUTjE8 c=1 sm=1 tr=0 ts=683d8cfb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=s1qB4CsIdprNQQnv0OQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfX4vxa6jiV1+AD
 OKQ9Aj5Fff0wzAXBPTnOLWmp1oWr84HpFIWYWTn8PDfxoSivbQD31/hzZMe1/QS0oiBkifcHDWv
 1zalJRpgbEK1mz9zubDEdNwacJP4XytTHgdfnIELr2OaawyjS66QfPkWZcxbcDrGMV7Jx84UPVQ
 uwB1s4hxPlV9C3n+RkBPlMEfMhS2x3viuL8xLlgfo/qgUAWBfwGNtSg9xxrEzb3fdaZVST4ZT7L
 kd+NsDGMoTSesd5QPW5EUumdAa37i+yjC7mlBJVJqpNxIuvN4R3jrM+AEQod+zXayvUyQh4nCLL
 NtyXv8NBbvgjBxC4CT8qr2IuHNJll71P7k0fqJXc0uTabnPJ1ATCpem39DEGcScVUwpnUAClnbU
 wsHX1f4q30dTcxZo3pA63HP9OfgbeNwC2jwou4mnH+UYaUuvbkHTieARy5nI20AhWiXleHHO
X-Proofpoint-ORIG-GUID: LyYK0sOdi09NwmxJkDq_jfY5Z8Dfiuet
X-Proofpoint-GUID: LyYK0sOdi09NwmxJkDq_jfY5Z8Dfiuet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020100

Add support for ADC calibration gain configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4
- No longer restoring calib gain or calib offset on reg write fail.

 drivers/iio/adc/ad4170.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index c317529e0449..98e38fabc725 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -631,7 +631,8 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
-			      BIT(IIO_CHAN_INFO_OFFSET),
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
 		.realbits = 24,
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


