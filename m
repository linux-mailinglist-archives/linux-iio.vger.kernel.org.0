Return-Path: <linux-iio+bounces-21163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6296CAEDFFB
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2778164E7B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406D28C2AA;
	Mon, 30 Jun 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UPJe3lMc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155228B516;
	Mon, 30 Jun 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292113; cv=none; b=EW4MgqmokkEdOHlQ7f+oJRkKxpwDqLAD8PiZlLwEwr0Z49m6IyELCMpo87THVTLkCexXuzG889xOFFtzhVvKdhHFEHgUt0/JqZqQQAB68H+84aXAp8VH7Q4Q1oPHv/UZEoYtX2KKu1EF5S00Yqt7sCXZbV+8/n1ZQu+W/+jahLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292113; c=relaxed/simple;
	bh=zi+zDlytj5OA3CnyU1Q0eqQB+IRDeodFsr6dRFYjSGQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=biueEobW8F2s09lW+tlEjzErc+IvNILHA2obuDqB3BqzwytkByhrR1AGSWUQ3V5Lj6CAdiPLZTVvKrlqjFf24FLt4BF1U9SjUXf6yZduDhjet+EgYeGlgygzKTT5p7TcSEjQ+WRqAajptsin4OrJ2TuVYkIZ9gSgG0/3PJM6K+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UPJe3lMc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UD3Z6K012596;
	Mon, 30 Jun 2025 10:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Nw9GO
	EeaBY5B9feYxKk+bNFSvHX0v1Rs3LheSGnBQ4M=; b=UPJe3lMcsQ+HG5bmLGwsa
	qqtI/XZeE1FdCNV50azDAlgWCN1EzmK0Y9h7YlI/rpU/OIpsra9ze+B+jBlJA4lJ
	Xx1XS0svYnKvlfqampAAh8asFqTjK6RUlzK9QtG7KWZhm7Vn+snXv4ld1r0/rMHu
	lQemSKcCtOBwEoQeMZyK/FM8KbDYi64qb+WClxLHOq8WyDs/ioLLxKfx0npuE0Zi
	W/B6OjbM6EIbBGQHSkYu4CyWNZOeG9Jyq1N5hy/F1DbEitxOQrpKHHozPSEESoVZ
	ujE7YT/kdJEhAQ07HS3YC3v45hMLhkjitFPoOjIOYKlAs7OzqquF7AberTdh5Gle
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 47kqtj19ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:01:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55UE1V6Q040052
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 10:01:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:01:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Jun 2025 10:01:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 10:01:30 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UE1DQF009156;
	Mon, 30 Jun 2025 10:01:15 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 10/12] iio: adc: ad4170-4: Add support for internal temperature sensor
Date: Mon, 30 Jun 2025 11:01:11 -0300
Message-ID: <51abd3617dff088981f487b5bdd9e78b26f74929.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: oI6yOwfhzv_EvT4q2Eq0uRS9PhvQuaU-
X-Proofpoint-ORIG-GUID: oI6yOwfhzv_EvT4q2Eq0uRS9PhvQuaU-
X-Authority-Analysis: v=2.4 cv=WasMa1hX c=1 sm=1 tr=0 ts=686298bc cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=o3DtMFfdRpqB0q9FUmIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfX343xRRJNTEs/
 0Oih23o3UBGWS0uRtYzpvtADJUzCQwdsWWYkYqQVoA1f5AKCprkXCabVMFA07w9cTLuZDNOuMAn
 wVrn0VFhGqJIb8xqnZmYC/5/W9cAHiQn4daNGfnUGekZCDrEJRfReuzKu8sDap3bQQyjKyclb5F
 sFbs5JaaVRyfypr5QVN13l3/02oEGwHXneEc668XkOsddwZffZYRUTT3W8K4SsPhYyH3bnYOaoZ
 tFOBK1vyMhiA0ZrFWcyBAq4RjhknXVELgtdfGzps8TPuHQF1JEeCii7U2YcZIytAeEtypF788NK
 E5gixRUw7jxICAZ1dN36kNkX907EnoQKE18pPdG6/3S6YRk5t7DiMrz7UEJPGlvNWWSawAM8QxE
 nxiuJdNnrZ0cJIjeGvfSwdXDsCDEWklqgtitnnldKwhEg14L7aU5BMwOySoJaP42itGjSbaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

The AD4170-4 has an internal temperature sensor that can be read using the
ADC. Whenever possible, configure an IIO channel to provide the chip's
temperature.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v3.

 drivers/iio/adc/ad4170-4.c | 72 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 9b5a0f858f48..53875b74a9a7 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -870,6 +870,27 @@ static const struct iio_chan_spec ad4170_channel_template = {
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
@@ -1172,9 +1193,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
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
@@ -1842,6 +1881,9 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 	if (num_channels > AD4170_MAX_CHANNELS)
 		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
 
+	/* Add one for temperature */
+	num_channels = min(num_channels + 1, AD4170_MAX_CHANNELS);
+
 	chan_num = 0;
 	device_for_each_child_node_scoped(dev, child) {
 		ret = ad4170_parse_channel_node(indio_dev, child, chan_num++);
@@ -1849,6 +1891,30 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
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


