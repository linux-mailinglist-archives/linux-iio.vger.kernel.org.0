Return-Path: <linux-iio+bounces-20765-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E72D0ADF3F0
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 19:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED9F189EE10
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF02F2C66;
	Wed, 18 Jun 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="egW8spP4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8311E8323;
	Wed, 18 Jun 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268238; cv=none; b=M7rhYylIaCHwbUdVgiicaNW8bbyjjvebrOAcWGEnIXI1B7TQZ/uJdtvevpdfM3pnNHzk8JEBN68j8R4VDCYlNdKi8uWk8GadPsHmHWuyoxiksa18zwVYB1oK738bXeuD2gqRIORkvFpyCsO2W7xCNYc2mtnmy7KWAiidB3uhu6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268238; c=relaxed/simple;
	bh=m6YubeSw5ekT8lpN0+uUwhJnEiSFE5vohhR5O5jeQQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFMJKKyftv20taEt56FGfXso3A5KQjx6FE8wvQ0XPzc13/lPDdbwWwBqR55YiCVnCF64LSxYzZqFagUyVRhnClQgPFrnIQH86gi1WxxaKw2EKUmiV9tYJhxBItj1uyn3sHklkw9IwA1PsNxWYYZoFCQzBAMXEZM+ODsVQuFQlHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=egW8spP4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IG2Gbp027608;
	Wed, 18 Jun 2025 13:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OWGVn
	FcPIk0gEmfPaY1OLr914IuzfYU3xB4ziCOu5DI=; b=egW8spP4mtUFARyHFNcqq
	fXex8wJON/cggCmwxIZiIlB2QPd55U2+K9T0TBtgb72OG27QoD1R5Z87liytPwPg
	X4/woanmkXWBTazocWYaAIOx2ZJXms0biW+rM5JojUioQCxOWbMuSwrISQQYFsqa
	s93cwAs2O4g/J0HF3uyfkCpoBWO6wgRhAL+KikGAMN50F6lTpEGWSAqawwGA3I9C
	QVK68xoXbVCRQY85ZideaT/f/10s7YLkKCIs02AejiGDFeelu4YQ8vSw2YxcwhVW
	mdmoGGQ1FstaT0pIWR3AksS+flj9C1xamPz/oTE47eQmH1lAz6qAVoGt55vfrxQU
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47bfxcwd45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 13:36:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55IHak6L015953
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Jun 2025 13:36:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 18 Jun
 2025 13:36:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 18 Jun 2025 13:36:46 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55IHaUYM007456;
	Wed, 18 Jun 2025 13:36:33 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 04/12] iio: adc: ad4170: Add support for calibration bias
Date: Wed, 18 Jun 2025 14:36:29 -0300
Message-ID: <1f759b391faea46fe3fd3fd25792db0312bf3969.1750258776.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-ORIG-GUID: lVQW6ye8m4GGWZRTLpNGQLovTM5Kkeu4
X-Proofpoint-GUID: lVQW6ye8m4GGWZRTLpNGQLovTM5Kkeu4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE1MCBTYWx0ZWRfX6x85RNOD3p5B
 DJq0nlEzdjM0FVx7NXDINqZPnLH9iTRLJ5qjst1FxjUpCR2nBgph8FsjcAu5l4ROVZAz5wAHDjM
 erc8rAaQqrFExk8os1+HzT462ikdrE5cqZyxePYjL9IU/rartX55d9KUwunmHp1rP0iW0EQI9FA
 qzWxumDeiJ+XpQ21N+3aYGbRCRGKzq0DErvt6ZFLkoEWzkRiS3g3hMd2jPjJY/XXr5BxeMo+3Fa
 +Fu0uW2O9ILS1xlKof8PCvS1/vU3ZBwAZKQCi7Sc9jVDgtgX4Zn9D9qMpBvP2+m7INgUJMwFa7o
 qQP7WMy82Salr0zA7AbQd6/bY3ZnxnEc8NARWBQ099kgi6dUniUFVQcFS3KD9kBpWOHTqoNQTim
 Om/47cjHHb3PdH5Uw31DOpQta2DPGDlWY8JFcZsubenmKS6mg9OQNB8jRa4l1fc0L/JSHB4D
X-Authority-Analysis: v=2.4 cv=Jb28rVKV c=1 sm=1 tr=0 ts=6852f93c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=1daVv4cnZmPfqeT0XEsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180150

Add support for ADC calibration bias/offset configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v6.

 drivers/iio/adc/ad4170.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 7b85771ff0d1..5c442af51f76 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -628,6 +628,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
@@ -946,6 +947,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = setup->offset;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		*val = setup->gain;
 		return IIO_VAL_INT;
@@ -1063,6 +1067,18 @@ static int ad4170_set_pga(struct ad4170_state *st,
 	return ad4170_write_channel_setup(st, chan->address, false);
 }
 
+static int ad4170_set_calib_offset(struct ad4170_state *st,
+				   struct iio_chan_spec const *chan, int val)
+{
+	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
+	struct ad4170_setup *setup = &chan_info->setup;
+
+	guard(mutex)(&st->lock);
+	setup->offset = val;
+
+	return ad4170_write_channel_setup(st, chan->address, false);
+}
+
 static int ad4170_set_calib_gain(struct ad4170_state *st,
 				 struct iio_chan_spec const *chan, int val)
 {
@@ -1084,6 +1100,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return ad4170_set_calib_gain(st, chan, val);
 	default:
@@ -1112,6 +1130,7 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
 	default:
-- 
2.47.2


