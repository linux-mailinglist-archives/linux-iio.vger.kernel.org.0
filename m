Return-Path: <linux-iio+bounces-20381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC2CAD43F4
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027F93A6198
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B9266B72;
	Tue, 10 Jun 2025 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xQgpz5IA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9C23BCEC;
	Tue, 10 Jun 2025 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587652; cv=none; b=gjFQZ4+0Lr38gX+QHVSXNy5/8QkMvEWhvRBRUuDMoqiTjG6oHNDedfPLzeDsP5CklZAo37BPaymBIDX31GIMK46TSYdyshAseUMAIPj+RKxViXPjHo8a5W6cxTo83BJ+l0b7YbT5mdEJKzVZApriiDbjtr3PZruyNj4Ibr/Ebyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587652; c=relaxed/simple;
	bh=5heTSQo+jawexGXcxJqZn08sdi464tWNxa1FRUQICPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcVZATbqMATriP1qlpyzDASesE11xX5MpNe0IdAKY2n47bzVRz1hHnhDffNyIiUXg4g9wfsRkJacqOX2csB322YXD7xEkAZfEuGPD3La6xYTPEyInO7lzqzMQzVBdTLbLIG2bInv2gSouR+a13TsoWrCewEHCKnYx9DYomgKID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xQgpz5IA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIBmlV022384;
	Tue, 10 Jun 2025 16:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MK/xd
	yLxaMoVoW+lvzhWcupKMLSuP+uOC08iiMOM8C8=; b=xQgpz5IAS228bkwaSNgwM
	EPMwNUFQLGvYWwtMZdQXmQvyzXPjkHBCoRgNZMJEgBYbGvF+QsqKWnz94OkyyTe1
	Dbs/TM8nwL1v2W4mNKlZ3OW9IOtzGEnod1nScTqXoF/EufEHUqTO5MqxSx/c+kUO
	HN8tFPcnfwTRHEs6MdGFfTtFFQDZpVVpORsjgWIRg557NwGbQNw9i1DSjUit1UDj
	ocOeMSiEGMLEcizcwB3Do61tf82ppB1Di7ECce61iYRgtL9oAc3GNfMK8qB4C1z8
	DgWjyv6Z6PVA3kBUgD/7ymNvGyzaYufnf+eaHViFfO9Rwh0RRxCL1meTw4oll3hY
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476n67tdhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:33:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55AKXr69037714
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:33:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:33:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 16:33:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:33:53 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKXZQQ019941;
	Tue, 10 Jun 2025 16:33:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 09/11] iio: adc: ad4170: Add support for internal temperature sensor
Date: Tue, 10 Jun 2025 17:33:34 -0300
Message-ID: <278fc570bf4ca3e795713537cc2b238e2a9a0cdf.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YXKD86dO5sD3_VvDnnih18KU45ir4UD2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX4u6KdZL1wWyc
 LkrOOhP5j5G5/AIXOxa6G1H+Tq1ynTIAsp9BTxaE9Ux98Jjdk9lwRyzEvhyEFivmKyStvxrk/Lm
 lrxUnvIQ0huFtaUNLQpo41kBzs5rP/tsO20vT/SFdoFjavJ145gkrz4rL655a6ZEwYfaSfIqHZG
 y6w7nBeu4PJ+79RzvvhwB6KBycgZRaQmiEIUdaCB7aXaqeUHljXuQyGFXG2j3lXcxZ+KENXNNhM
 Jju/ymn9EXss/rWGo9c+m6MgkPuAAGtJJNaMzP7WXjthxhgT8lhn+dMIfjft+y0susL2vq8XuM6
 ArahdICuggC5lw+NJquDmd7MAe36YoDbubGB+y28hu5ayMW5kw7mCNOMF+dT6wLRxT7MzGQDjU3
 rRcA+T9kt8F0VeQeh4/+EOQT/WHQXxAfmIdQDWT9tj3SQm4vp4ETnDLqKCwT+Rsgy9R/XcfT
X-Proofpoint-ORIG-GUID: YXKD86dO5sD3_VvDnnih18KU45ir4UD2
X-Authority-Analysis: v=2.4 cv=a/gw9VSF c=1 sm=1 tr=0 ts=684896b2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=o3DtMFfdRpqB0q9FUmIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100166

The AD4170 has an internal temperature sensor that can be read using the
ADC. Whenever possible, configure an IIO channel to provide the chip's
temperature.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v3.

 drivers/iio/adc/ad4170.c | 72 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index b3189c5f8078..253c9ca9b3e6 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -883,6 +883,27 @@ static const struct iio_chan_spec ad4170_channel_template = {
 	},
 };
 
+static const struct iio_chan_spec ad4170_temp_channel_template = {
+	.type = IIO_TEMP,
+	.indexed = 0,
+	.channel = 17,
+	.channel2 = 17,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET) |
+			      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			      BIT(IIO_CHAN_INFO_CALIBBIAS) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+};
+
 /*
  * Receives the number of a multiplexed AD4170 input (ain_n), and stores the
  * voltage (in µV) of the specified input into ain_voltage. If the input number
@@ -1182,9 +1203,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
-		*val = chan_info->scale_tbl[pga][0];
-		*val2 = chan_info->scale_tbl[pga][1];
-		return IIO_VAL_INT_PLUS_NANO;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = chan_info->scale_tbl[pga][0];
+			*val2 = chan_info->scale_tbl[pga][1];
+			return IIO_VAL_INT_PLUS_NANO;
+
+		case IIO_TEMP:
+			/*
+			 * The scale_tbl converts output codes to mV units so
+			 * multiply by MILLI to make the factor convert to µV.
+			 * Then, apply the temperature sensor change sensitivity
+			 * of 477 μV/K. Finally, multiply the result by MILLI
+			 * again to comply with milli degrees Celsius IIO ABI.
+			 */
+			*val = 0;
+			*val2 = DIV_ROUND_CLOSEST(chan_info->scale_tbl[pga][1] * MILLI, 477) *
+						  MILLI;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_OFFSET:
 		pga = FIELD_GET(AD4170_AFE_PGA_GAIN_MSK, setup->afe);
 		*val = chan_info->offset_tbl[pga];
@@ -1834,12 +1873,39 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 	if (num_channels > AD4170_MAX_CHANNELS)
 		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
 
+	/* Add one for temperature */
+	num_channels = min(num_channels + 1, AD4170_MAX_CHANNELS);
+
 	device_for_each_child_node_scoped(dev, child) {
 		ret = ad4170_parse_channel_node(indio_dev, child, chan_num++);
 		if (ret)
 			return ret;
 	}
 
+	/*
+	 * Add internal temperature sensor channel if the maximum number of
+	 * channels has not been reached.
+	 */
+	if (num_channels < AD4170_MAX_CHANNELS) {
+		struct ad4170_setup *setup = &st->chan_infos[chan_num].setup;
+
+		st->chans[chan_num] = ad4170_temp_channel_template;
+		st->chans[chan_num].address = chan_num;
+		st->chans[chan_num].scan_index = chan_num;
+
+		st->chan_infos[chan_num].setup_num = AD4170_INVALID_SETUP;
+		st->chan_infos[chan_num].initialized = true;
+
+		setup->afe |= FIELD_PREP(AD4170_AFE_REF_SELECT_MSK,
+					 AD4170_REF_AVDD);
+
+		ret = ad4170_get_input_range(st, &st->chans[chan_num], chan_num,
+					     AD4170_REF_AVDD);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Invalid input config\n");
+
+		st->chan_infos[chan_num].input_range_uv = ret;
+	}
 	indio_dev->num_channels = num_channels;
 	indio_dev->channels = st->chans;
 
-- 
2.47.2


