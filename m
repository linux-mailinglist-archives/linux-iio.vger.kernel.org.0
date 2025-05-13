Return-Path: <linux-iio+bounces-19494-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4940DAB54FF
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD7E4A08F8
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854729209E;
	Tue, 13 May 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NOxSMVu7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70892918FE;
	Tue, 13 May 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139827; cv=none; b=Jzq3BpMXe4CWc5oBG+EfOPuL/KpQcMisLPcwvXejwHl23W+sWFufBG+3IteRlSbJpPSk9IZcRqIqeYgBbW9D/kixkCpEZVr7Vnq2eWgenJf6QbWe6C1rUfvoncK9GhUVyxR9PvbRfBq8ldZ3kH2b+wf4I2h+XvTtbgGGXTqW3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139827; c=relaxed/simple;
	bh=ABlBNAm7NhbMLcnjwxx9tP1Xus/dT1aDalOnCVDTQZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2wKjK1U+dmTolNijeW4tIFMlceWNi5UapmneqRcXwK8ix3fSgNjYZVNLtbwmDg0syr6GWo6Ag/WrfqGRSOW5m75XwwJINH1Oo7R1R4JgV9vtQVwmwR2Ew1+dSIsGDFX0wob9x5uBjLljOf5fePigQMj+p/0W4TRMiDr2O08dC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NOxSMVu7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DATTLL007631;
	Tue, 13 May 2025 08:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GKIOD
	mBn2FfG59ksRytTYs71nRhAvHKLhXJLZhB35nA=; b=NOxSMVu70jBd/NWf+GRAN
	/GySqZbasLpPEWPjm9knqm3IBzHQSj+NdMpRAyDrhZ2Dc29qZ7p37SL+tDTUGERi
	6EfwBNEzZNH/ePQsT3ZgHq5ixxKsGasXJIMmr3soiAVodDIEYCNCM0IbzFsRDm7Y
	Bv/lrKly11CAH/2XZuCvTNIUHLM8KR3Xjrkrp2Xe/hsLV9+l7PC3elc6n4UDByfO
	HxW1WrAlNoJQnOQj3G6/ViNNJ434Elw0dH6e/0piygClr8J2+aINQmJYx4SVC6j2
	lM5mIqP7C70DEgW7Qc2fVLlQClbJ2eKATHQNqqdSKy0urN7BOWlJ28gxI8dLuWbX
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46kx53af2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:36:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCamvv041248
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:36:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 May
 2025 08:36:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:36:47 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCaTJK007554;
	Tue, 13 May 2025 08:36:32 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 09/10] iio: adc: ad4170: Add support for internal temperature sensor
Date: Tue, 13 May 2025 09:36:28 -0300
Message-ID: <3eceb02208b86be4bb66fe77f40b84ef928c0d80.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=a4sw9VSF c=1 sm=1 tr=0 ts=68233ce1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=o3DtMFfdRpqB0q9FUmIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qhlJoeS5x-UaAa98ypbdDR61O5DB3T0M
X-Proofpoint-GUID: qhlJoeS5x-UaAa98ypbdDR61O5DB3T0M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyMCBTYWx0ZWRfXxAidp9cg+n+G
 2Doq1AOEXkUXA97VXS/kpj0/SdJUJ/84kL5o68h3c3ee3xdS0Weyt/fLczc45lQbqdyfFayDcjc
 UrKumG8K9mQGKBLzl+mYpbj5xH+omt2Zzj3V602L+AVFJDbal9W0cKwG9cWNmchuYGWcGRyqgHw
 E5dCv221Z7YNjEeDxwyN4kTlwAu4Uf5RCcdxCx4G2pUPrrJ77q+lATGLpZun5U2hZR/WlNdyNnF
 YuJT2H53SwDLWr90nHjEtlzrNh9/IeRPrPr8OSMPEMazJFsabd5HlaIULdfKvZdVk820mGEoTw9
 hKx+O4yys8AXbQXdlBhB1aSNf/fzksN2/cK1JONhAqaBlQc4vtnvFc1pj+1NPt6Pw2v8bPy+85w
 Gg7UIyNZTxC82s0tq986iuZuTKg100tOQ73ciz/duHBAPiKhN8uv8VQUDq5ErBEsNxLddsxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130120

The AD4170 has an internal temperature sensor that can be read using the
ADC. Whenever possible, configure an IIO channel to provide the chip's
temperature.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3
- Wrapped line according to logical approach.

 drivers/iio/adc/ad4170.c | 72 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 31f126a0f76f..1150c2e7ca1a 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -896,6 +896,27 @@ static const struct iio_chan_spec ad4170_channel_template = {
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
@@ -1192,9 +1213,27 @@ static int ad4170_read_raw(struct iio_dev *indio_dev,
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
@@ -1878,12 +1917,39 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
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
 	return 0;
-- 
2.47.2


