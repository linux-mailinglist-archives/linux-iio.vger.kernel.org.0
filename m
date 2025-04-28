Return-Path: <linux-iio+bounces-18743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96648A9E565
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 02:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A163BA704
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0DF224FD;
	Mon, 28 Apr 2025 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uqP3nly2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626F713D8A4;
	Mon, 28 Apr 2025 00:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745799238; cv=none; b=dXecrYOGBLCwDsbgt2eR42QjcWLJkKCBGiFMAwYK4prBXj3ZLnuvn+WOKZJp99wVwDsm7EiUUCy5oG6pEUQGdnU57KxACe3TK7O3p3AZyb9H4BFouY//0BuQLWa4iiE2PJrPgphdu8R3G6W+Ab0wlBdiwWIYceAjkz33oDz0rsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745799238; c=relaxed/simple;
	bh=t9HpRH4M+U/FTNzlC3ZIGZLSa5SdGaQ8MNmae+ynA88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LeAhAdKrwbVrwWpJjzp6mGSkTOH1P/mm3WsaXENnnuq53dYSdctL+bQifA8f6p+U+SxHfx5NdwqtPvDDk+FP5zKhOt4UEoUzLzdGF3L6ot7V5ejKRcXHuhrMeulVBzku/mAsQb+t4YMk/Dh6AjfK33xjzUX3J6+bIZbw/maFH/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uqP3nly2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53RL8Das027375;
	Sun, 27 Apr 2025 20:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JZWDk
	BnuIj5WqU/AbEG+tTCclcVQ0pYubYL/63HKSEI=; b=uqP3nly2Y/hL+fvBHCwXK
	8mteqZUlQddE+cp5BnpZOGtjVlVZlxQNyL764JGdvhMx3ul22MA+uXVeQXo2NNAm
	m3P8Ual/SDmMgx4ZAm3Une6JdjRChBIa6a68ZrjZUD6grmPF+eLW+qszZJ32FBQ+
	ZzkK/1fQ2yZcyEBZLijDDflIq2tx6YYNA9Q8dSLMdG99R3BfcxTwQbxUENi76rla
	nJhFajukRsRskM4RaCPheB9JhBrYlEesTJrLGU3DSB0+pcZDcDhOUEj87iJ4YCmz
	KPR/KjVxiJ9vQlywjU1GoKld8/9nRvBpq3jg5Dpy/I6ifNmSJCt0HUinT57e3hBa
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgcmht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Apr 2025 20:13:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53S0DopC028981
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Apr 2025 20:13:50 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:13:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Sun, 27 Apr 2025 20:13:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Apr 2025 20:13:49 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53S0DThf014633;
	Sun, 27 Apr 2025 20:13:32 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jonath4nns@gmail.com>, <dlechner@baylibre.com>,
        "David
 Lechner" <dlechner@baylire.com>
Subject: [PATCH v6 07/11] iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
Date: Sun, 27 Apr 2025 21:13:29 -0300
Message-ID: <0a214d5dfacc3976db71af8a80f9dcf2887fe6cc.1745605382.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745605382.git.Jonathan.Santos@analog.com>
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDIwMiBTYWx0ZWRfX3CjuUs9PP1BI H14YKdaqOouaq10RFbzTv5LPfWLm7mHf73vfQJjway1mqtdO/kBwR4IbBOYqAcY/KPudqA5ca8l m/5ZCT3g4/1FpwZ3nBvBMR025L2VLrTqouq4P7CdXQDSuRDzKDMKLdQM1x+he7TrMS598cP0tz+
 UqEijiNlYVrQ2+Iju8kpQSjEG2AxXVtGsRGHVe5dK8uJK4NsuOR2vfpob8aQJsLJoW3GBLTJEDh VWngs2AOkcuc+guX2HSrmLpv4uk0tR7Kfbp+gvqguwWXimzjTQUFr86M0+Yw0oTugzcCFpRMU9h Br34j1VsXG1pP1VIdVFH7J7CDUnmZuZFLuTzkgt+q+aC+cllhwhQ8crL7YEUD+ecNAglfno/ZyN
 lCc1QmID0mBA/9P+Avz4jaCIe5xubWuUf1Nbqd87a+OANkwiJ7OIBIctd8YLNd7dZqMMG4T6
X-Proofpoint-ORIG-GUID: n8diwT2mKXJ6795OnBxYcNHJc4UG7ve7
X-Proofpoint-GUID: n8diwT2mKXJ6795OnBxYcNHJc4UG7ve7
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680ec83f cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=ajdmHsczAAAA:8 a=gAnH3GRIAAAA:8 a=TVenB2Com6UDTqQwcj8A:9 a=Cd2TjbhyRiE6FbCepFud:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504270202

When the device is configured to decimation x8, only possible in the
sinc5 filter, output data is reduced to 16-bits in order to support
1 MHz of sampling frequency due to clock limitation.

Use multiple scan types feature to enable the driver to switch
scan type in runtime, making possible to support both 24-bit and
16-bit resolution.

Reviewed-by: David Lechner <dlechner@baylire.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v6 Changes:
* None.

v5 Changes:
* None.

v4 Changes:
* None.

v3 Changes:
* Decreased storagebits to 16 for AD7768_SCAN_TYPE_HIGH_SPEED
  scan type.

v2 Changes:
* Included the ".shift" value back to scan_type.
* Changed the number of bytes from regmap_read instead of shifting the 
  ADC sample value when the word size is lower (16-bits).
---
 drivers/iio/adc/ad7768-1.c | 74 ++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 1a546a0dc654..087478afb5bf 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -139,6 +139,15 @@ struct ad7768_clk_configuration {
 	enum ad7768_pwrmode pwrmode;
 };
 
+enum ad7768_scan_type {
+	AD7768_SCAN_TYPE_NORMAL,
+	AD7768_SCAN_TYPE_HIGH_SPEED,
+};
+
+static const int ad7768_mclk_div_rates[4] = {
+	16, 8, 4, 2,
+};
+
 static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
 	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
@@ -153,6 +162,22 @@ static const struct ad7768_clk_configuration ad7768_clk_config[] = {
 	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
 };
 
+static const struct iio_scan_type ad7768_scan_type[] = {
+	[AD7768_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+	[AD7768_SCAN_TYPE_HIGH_SPEED] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_BE,
+	},
+};
+
 static const struct iio_chan_spec ad7768_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
@@ -162,13 +187,9 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
-		.scan_type = {
-			.sign = 's',
-			.realbits = 24,
-			.storagebits = 32,
-			.shift = 8,
-			.endianness = IIO_BE,
-		},
+		.has_ext_scan_type = 1,
+		.ext_scan_type = ad7768_scan_type,
+		.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),
 	},
 };
 
@@ -182,6 +203,7 @@ struct ad7768_state {
 	struct clk *mclk;
 	struct gpio_chip gpiochip;
 	unsigned int mclk_freq;
+	unsigned int dec_rate;
 	unsigned int samp_freq;
 	struct completion completion;
 	struct iio_trigger *trig;
@@ -300,6 +322,15 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * When the decimation rate is set to x8, the ADC data precision is
+	 * reduced from 24 bits to 16 bits. Since the AD7768_REG_ADC_DATA
+	 * register provides 24-bit data, the precision is reduced by
+	 * right-shifting the read value by 8 bits.
+	 */
+	if (st->dec_rate == 8)
+		readval >>= 8;
+
 	/*
 	 * Any SPI configuration of the AD7768-1 can only be
 	 * performed in continuous conversion mode.
@@ -516,6 +547,8 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	if (ret < 0)
 		return ret;
 
+	st->dec_rate = ad7768_clk_config[idx].clk_div /
+		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
 	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
 					  ad7768_clk_config[idx].clk_div);
 
@@ -549,8 +582,13 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int scale_uv, ret;
 
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
@@ -561,7 +599,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
-		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
+		*val = sign_extend32(ret, scan_type->realbits - 1);
 
 		return IIO_VAL_INT;
 
@@ -571,7 +609,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			return scale_uv;
 
 		*val = (scale_uv * 2) / 1000;
-		*val2 = chan->scan_type.realbits;
+		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -615,11 +653,21 @@ static const struct attribute_group ad7768_group = {
 	.attrs = ad7768_attributes,
 };
 
+static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(indio_dev);
+
+	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
+		AD7768_SCAN_TYPE_NORMAL;
+}
+
 static const struct iio_info ad7768_info = {
 	.attrs = &ad7768_group,
 	.read_raw = &ad7768_read_raw,
 	.write_raw = &ad7768_write_raw,
 	.read_label = ad7768_read_label,
+	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
 };
 
@@ -674,9 +722,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int ret;
 
-	ret = spi_read(st->spi, &st->data.scan.chan, 3);
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	ret = spi_read(st->spi, &st->data.scan.chan,
+		       BITS_TO_BYTES(scan_type->realbits));
 	if (ret < 0)
 		goto out;
 
-- 
2.34.1


