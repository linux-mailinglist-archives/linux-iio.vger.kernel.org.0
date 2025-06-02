Return-Path: <linux-iio+bounces-20130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E93ACAD56
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0348188CCC8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5DA2080C8;
	Mon,  2 Jun 2025 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1AHGJK8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F691DF270;
	Mon,  2 Jun 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864322; cv=none; b=D83Jn/PnYT18uSmPCZUTPVQigMA4U4trbTi5vi9l96vybW5+LRoY7GBZzs0rw25WjhDI2qur8EjZMNjSD9B+5WiPyImrrhSC4S//pzqSRjBlJGse0pmiTNqY79/VXLPK4vr/F9NkGFh66WdyyyCUJApWTcdLgbcixfnrOtoeAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864322; c=relaxed/simple;
	bh=+uu95Z2xOQ5l4c8ceIVVUi7YXywp0Rz43kBIEafrvnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5VZgBfaintdFLfX9aeGQXitLJsgKL4DRPTIgj3gDIcryyyJR8biO2LRwOKGqd8O7pvDEtvP8jSL+9tsq4UwwTzoi3ZlahdD99oKhc7+2GWZsUqCHCNdBXQTBIls6f1WW5rvJJ9eG6aeZke4AN8VtHDBZaBlabrk26739iGN6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1AHGJK8c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5527tLpK010717;
	Mon, 2 Jun 2025 07:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gQRq9
	v9jREdtB0uReoZyFH4Ksbud4jEDbLHJpnLTx3I=; b=1AHGJK8clpvXgkmK9Kwhu
	Kf3qJtmN/Y+zepr1Rx1SOULX7p1n/cSVgfoC/5tQRxbPzdXJ+n6Qd07JyJCIz8PP
	1Ef4tFUUZl0+ztzH0MvcvXYpXrSaLv/VhFOGznRukeNGNxW9oWE4/0uiDI1VCBGi
	5zXhQC79TxhJEVTuSk3rfDl1c5UrztPNr6uytitAcqTgvl9Kc5cdjYUWYAhHn7wk
	uPAxW8yCq6OvQWfSidCAO+Nfqy+OtbP0j7rnZjehupw7z8Xre58xpBaHfyVyO1pf
	B42HA4/gDtbhDt3TaLskSiodTyWluylwU8XZS+OadfR1fJFOI4pmgVkTrNmnVdJe
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47133mj2fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 07:38:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 552BcJ2b043254
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 07:38:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:38:18 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:38:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 07:38:18 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552BbpXB024910;
	Mon, 2 Jun 2025 07:37:53 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 04/11] iio: adc: ad4170: Add support for calibration bias
Date: Mon, 2 Jun 2025 08:37:48 -0300
Message-ID: <f5b08977ede47ab454bac1e32c0ed496c2f5474f.1748829860.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-GUID: ge2f6TRS1SoWUMQsDEw0dDg8Z_IgutmP
X-Proofpoint-ORIG-GUID: ge2f6TRS1SoWUMQsDEw0dDg8Z_IgutmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfXxknIbl2C7sQy
 dr+F31wiyU3qJhCHVmaNI3iqbAuGgK1qUttnF27VtFzxZq9rePzA7Ts0TGDhzT8IOvfi9vgIobK
 GS+N9JsFVogNnm/r7V1qJAn2e27lLCUYm8wLu1nHF3I6abNLFUq63IzCB12kJITEPGllyY+3rUJ
 x6jeQNrXv5PfsI/TdM15B+rHbplzKKscxHDTNMRZZa+9lFFfAKJmOrUWpe7QyTOgMVA9hrKskcl
 k0S4pM0xptt/H8Yfm/EPbaeI1MMtZZJcpdrosJg1JxpBYjWmJe13kpH6rUhhWtdlplT46MdrsMT
 i1tY4qNj+BPqW0WW9fSNjk0KDSlDorapE79Ht7wvJzvg7OvXSbjQP1ggg+Zm8q6+gBkAKPWfj0V
 WDYgiOk4naTrScGpc06U1oN5WLFXKdB/byL7kQQUEc2DahITUeTyVkR/soiXTUaYQKmBSJLk
X-Authority-Analysis: v=2.4 cv=DY4XqutW c=1 sm=1 tr=0 ts=683d8d2c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=1daVv4cnZmPfqeT0XEsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2506020100

Add support for ADC calibration bias/offset configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4
- No longer restoring calib gain or calib offset on reg write fail.

 drivers/iio/adc/ad4170.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 98e38fabc725..b109ebf3347d 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -632,6 +632,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			      BIT(IIO_CHAN_INFO_CALIBSCALE),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 	.scan_type = {
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


