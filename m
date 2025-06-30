Return-Path: <linux-iio+bounces-21157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17A2AEDFF1
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7CC3A5635
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24728C2A0;
	Mon, 30 Jun 2025 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DbICCX6d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF528C035;
	Mon, 30 Jun 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291990; cv=none; b=TNUC3xS/lJnXY5dENtRhHvqqWGZ3iyz4/25XNJzfAYIxRlvhglY0hn8QazGVAukmixIXn5wa+FBGGioeNi/n2G8OOz8VK8mPE3RAfOcOrj35lmLJwpvOMCJ+M9VWrMQiad1HQVo6o8uI2O0E8ASFHQEL3Yd0Qjt8FdXxYMLMApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291990; c=relaxed/simple;
	bh=yLqmcRyor1QJiUjMq0X5lpxFTYSogqHK7nhSL2HsY6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h++0B4/8vtfJhIFysiqLUBIvM5dcjPD2uMloaqL8YgqKui8lW9rksfKGBXPQfWkffG33QBRmWh62gTUMdNg4PqbsOo2/0UP9nprl3J7QfiPtNcFJQeC2UMNSNpx9D2Itpv7UnHuv14mZ8IpzAn49ts0HLXTUP2/BCDhTwy9pRU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DbICCX6d; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UCnABp012489;
	Mon, 30 Jun 2025 09:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uU9Dd
	zNo9K6Na4NJFm4aQGVhBiSVcAJ1EI8h8lkwDSI=; b=DbICCX6d+Z875yvpWaYcA
	4y8GiWmw8Bz3lPJwLHNN+klR/m5rsDpLjv12eIQcMlZ4tf3F19xE4DISyqlzZf5f
	WoLjs+tesD8KAc4QVMrvz6QpGF5+WieV4VrtbPL+sR8eCQh3Rq0gJw5ae/dZ33OI
	JFggfL5FW3THdKdFVKPrQkEeUeJOIl6s5aZVIfEg+uwsBni/jEAlVmkB2eW0Of73
	iw4J7a7f86Pe3wV0GDqClj2NxTBERmojKCRZoD7e/eM1fIHdTt5VJTxtERDRF46p
	Dbsa800q3KIpqDId/9GHKlfJxAbcdfEorr5/yyAKn0yFOoR7ifQ1gMcojEnnKCjr
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47kqtj19hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 09:59:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55UDxUbE039365
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 09:59:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Jun
 2025 09:59:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 09:59:30 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UDxEKV008274;
	Mon, 30 Jun 2025 09:59:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 04/12] iio: adc: ad4170-4: Add support for calibration bias
Date: Mon, 30 Jun 2025 10:59:13 -0300
Message-ID: <0a2cf0ee8b869d0ed08d261851cf98df4445beab.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ArprzhsiTsthBwUGpZc9jcmOTsqUE58t
X-Proofpoint-ORIG-GUID: ArprzhsiTsthBwUGpZc9jcmOTsqUE58t
X-Authority-Analysis: v=2.4 cv=WasMa1hX c=1 sm=1 tr=0 ts=68629844 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=1daVv4cnZmPfqeT0XEsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfX9rMFEw44QaVX
 fgSm7lV8gxUFzeqyurUSv6bGrukqXnSwrXW4wgRyOZpKomB3H1+k+5LGsYlSJBv/+eVMMrkmmKj
 UVi9YyxGJjSWhqCHZLb8A8whF7PZgtSNzGJX52W3agaVCubSll411rY1TpLYn6e1kjE3D8hqSvK
 +BuVvKCyktivsCBTpFuA8xODKuNSAvAIETjKWwULSVEMkgeO+8vSfXTNIepKitupjv6jN/rAM6M
 rL/B5xyOUGMI6Uqg2GmWIOdG2TkpcELn3tGYEe83LxA4094Z+5/c5lQ0jtHwalfc4z3wptaQZse
 OO4dwTT9elruMtgB0r3PVgY/MAyLTBepIS01n3wedicGuzuxSlI0aVgha4DZr0NopCZtsHaBxfX
 iqusSso2+X9G+gn6gURRsI7h+Kt2/YS22tPcJ4+WUtnlLce9j0gkLQ+NBuXKVRnmu5FGG+wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

Add support for ADC calibration bias/offset configuration.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v5.

 drivers/iio/adc/ad4170-4.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index c45203c0b479..216dc844cc62 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -623,6 +623,7 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	.differential = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 			      BIT(IIO_CHAN_INFO_OFFSET),
 	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
@@ -941,6 +942,9 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = setup->offset;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_CALIBSCALE:
 		*val = setup->gain;
 		return IIO_VAL_INT;
@@ -1058,6 +1062,18 @@ static int ad4170_set_pga(struct ad4170_state *st,
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
@@ -1079,6 +1095,8 @@ static int __ad4170_write_raw(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return ad4170_set_pga(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad4170_set_calib_offset(st, chan, val);
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return ad4170_set_calib_gain(st, chan, val);
 	default:
@@ -1107,6 +1125,7 @@ static int ad4170_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
 		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_CALIBBIAS:
 	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
 	default:
-- 
2.47.2


