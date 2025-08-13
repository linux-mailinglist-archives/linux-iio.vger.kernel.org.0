Return-Path: <linux-iio+bounces-22642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1FB23E87
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 04:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFC81A2437F
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62A3242917;
	Wed, 13 Aug 2025 02:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YlxNZZe7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB425B2FF;
	Wed, 13 Aug 2025 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053379; cv=none; b=fhVPR39kF8PcytvvAV5wcKiT/MC667Nl98rRsvllisPXAwi8t93XRX6O0hCpVWd+dWznlGdCERx+l+n1AS+LGVVwzmTe1rZt8ge8aF8uwpa2KsHKSWZayqQrHyz2VICzQ84Zj8wfVkjObtg9zsHfDjK8+dmrQhMEic0SaFB+CU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053379; c=relaxed/simple;
	bh=Xi01FkHhzekzHJcbS+n+iytZilWhoGl1f9CeApnYn88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e81qDd2z8WCVj/HN4HM/+CuQ0DJK40DKtMRaQVwFlJJNkSwu5XpZas60vgA6FduAzM+XJQc6aE1SUCkNtddnKMTQfOFb9FWN1pA8hEOZkvhEC3owMvBWOx0K6zkL1EDs5QX9FmOBNloX8J9E7ckotaJ+HkZLaMmhEad0/Tg3u0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YlxNZZe7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D1dmt8027710;
	Tue, 12 Aug 2025 22:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LdrJ8
	htXGxTAT7umbW/ALpXkd3w95kSYbFBDaF7Dgng=; b=YlxNZZe7HHH3rEgBQaOge
	pZGdSZUhW0xPNj/wBQz/ImEV4+nPeSyaxEiHkx4FG1jbIIrQkrV8BqWc89mNU8IM
	qHCw8GCNsQW4HC8LW/R3nEqSAiUtzJPdlSpvncu4UUcUmcqaDqjHn0s0vDwcUZNB
	Kw39a7x9X3zY9hZlo9L0jp02nhxjGJpfTe1SIa8kfex28LZVdc0ni3nZRB19gcEy
	l8tC9zE5N9XVVVJmPywMRwI3bv1JQCEd3OLC4FpgQNpHSFylo8XSzzT3qS+VZ9cc
	3No4KtMsqKGpnly9B3Cn583NlZCjH0tMN6iHCkVdFW2e5i0A9/5HxiGy6+hauWcE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48g9q9t9tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 22:49:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57D2nUwB056091
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Aug 2025 22:49:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 12 Aug
 2025 22:49:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 22:49:29 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57D2nIGL032765;
	Tue, 12 Aug 2025 22:49:21 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
Date: Tue, 12 Aug 2025 23:49:16 -0300
Message-ID: <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=EOsG00ZC c=1 sm=1 tr=0 ts=689bfd3b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=6j_mre9DMpI3tPA8GHEA:9
X-Proofpoint-GUID: 5HYq-f0q3C4i4pq0bv0pBYsDLZKRy3Wt
X-Proofpoint-ORIG-GUID: 5HYq-f0q3C4i4pq0bv0pBYsDLZKRy3Wt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX2kfkp4IoGpL9
 s1ZxmmJ7b4Im/jDZuFjmlZanYqEIoKiW5/2MwnyHmbwSEYRqmYQbNGma4ZYntn4ctrDTr1ZFvBh
 EUB3mfoCs1GUlnx3wEVBgZsXj/qqHwFImBTk3gX2rNRP1VKCt+pJN+lXRbVUTeEZEUuUBeZ6Y0x
 4b/+8bTniiSP+sc4caw812s6582oYGVWTO42CHy+d0adpeD//5gmtCY8A9Md39pkkjAj0MHEczX
 dH8HA+XTxjhf3/dAjUBMm87CwOIi2VgMe1+oKp5HK8/1l8bOoUSyboRLAxs68OkhtrmtTisEcQz
 s/kZc1NEh8m7oTm0SxVzgQ8XD5qiXvVJyl92aY3wdRci0snLvwyTVJ59XZR7tUx5T8cGeG7/U98
 Jb5BDW1+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Add support for ADAQ7767/68/69-1 series, which includes PGIA and
Anti-aliasing filter (AAF) gains.

The PGA gain is configured in run-time through the scale attribute,
if supported by the device. The scale options are updated according
to the output data width.

The AAF gain is configured in the devicetree and it should correspond to
the AAF channel selected in hardware.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad7768-1.c | 286 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 279 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index d0b9764a8f92..4397d044f5de 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
@@ -98,16 +99,22 @@
 /* AD7768_REG_GPIO_CONTROL */
 #define AD7768_GPIO_UNIVERSAL_EN	BIT(7)
 #define AD7768_GPIO_CONTROL_MSK		GENMASK(3, 0)
+#define AD7768_GPIO_PGIA_EN		(AD7768_GPIO_UNIVERSAL_EN | GENMASK(2, 0))
 
 /* AD7768_REG_GPIO_WRITE */
 #define AD7768_GPIO_WRITE_MSK		GENMASK(3, 0)
+#define AD7768_GPIO_WRITE(x)		FIELD_PREP(AD7768_GPIO_WRITE_MSK, x)
 
 /* AD7768_REG_GPIO_READ */
 #define AD7768_GPIO_READ_MSK		GENMASK(3, 0)
+#define AD7768_GPIO_READ(x)		FIELD_PREP(AD7768_GPIO_READ_MSK, x)
 
 #define AD7768_VCM_OFF			0x07
 #define AD7768_CHAN_INFO_NONE		0
 
+#define ADAQ776X_GAIN_MAX_NANO		(128 * NANO)
+#define ADAQ776X_MAX_GAIN_MODES		8
+
 #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
 
 #define AD7768_MAX_CHANNELS 1
@@ -154,6 +161,52 @@ enum ad7768_scan_type {
 	AD7768_SCAN_TYPE_HIGH_SPEED,
 };
 
+enum {
+	AD7768_PGA_GAIN_0,
+	AD7768_PGA_GAIN_1,
+	AD7768_PGA_GAIN_2,
+	AD7768_PGA_GAIN_3,
+	AD7768_PGA_GAIN_4,
+	AD7768_PGA_GAIN_5,
+	AD7768_PGA_GAIN_6,
+	AD7768_PGA_GAIN_7,
+	AD7768_MAX_PGA_GAIN,
+};
+
+enum {
+	AD7768_AAF_IN1,
+	AD7768_AAF_IN2,
+	AD7768_AAF_IN3,
+};
+
+/* PGA and AAF gains in V/V */
+static const int adaq7768_gains[7] = {
+	[AD7768_PGA_GAIN_0] = 325,	/* 0.325 */
+	[AD7768_PGA_GAIN_1] = 650,	/* 0.650 */
+	[AD7768_PGA_GAIN_2] = 1300,	/* 1.300 */
+	[AD7768_PGA_GAIN_3] = 2600,	/* 2.600 */
+	[AD7768_PGA_GAIN_4] = 5200,	/* 5.200 */
+	[AD7768_PGA_GAIN_5] = 10400,	/* 10.400 */
+	[AD7768_PGA_GAIN_6] = 20800	/* 20.800 */
+};
+
+static const int adaq7769_gains[8] = {
+	[AD7768_PGA_GAIN_0] = 1000,	/* 1.000 */
+	[AD7768_PGA_GAIN_1] = 2000,	/* 2.000 */
+	[AD7768_PGA_GAIN_2] = 4000,	/* 4.000 */
+	[AD7768_PGA_GAIN_3] = 8000,	/* 8.000 */
+	[AD7768_PGA_GAIN_4] = 16000,	/* 16.000 */
+	[AD7768_PGA_GAIN_5] = 32000,	/* 32.000 */
+	[AD7768_PGA_GAIN_6] = 64000,	/* 64.000 */
+	[AD7768_PGA_GAIN_7] = 128000	/* 128.000 */
+};
+
+static const int ad7768_aaf_gains[3] = {
+	[AD7768_AAF_IN1] = 1000,	/* 1.000 */
+	[AD7768_AAF_IN2] = 364,		/* 0.364 */
+	[AD7768_AAF_IN3] = 143		/* 0.143 */
+};
+
 /* -3dB cutoff frequency multipliers (relative to ODR) for each filter type. */
 static const int ad7768_filter_3db_odr_multiplier[] = {
 	[AD7768_FILTER_SINC5] = 204,		/* 0.204 */
@@ -216,6 +269,12 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 
 struct ad7768_chip_info {
 	const char *name;
+	bool has_variable_aaf;
+	bool has_pga;
+	int num_pga_modes;
+	int default_pga_mode;
+	int pgia_mode2pin_offset;
+	const int *pga_gains;
 	const struct iio_chan_spec *channel_spec;
 	const unsigned long *available_masks;
 	int num_channels;
@@ -236,6 +295,9 @@ struct ad7768_state {
 	unsigned int samp_freq;
 	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
 	unsigned int samp_freq_avail_len;
+	int pga_gain_mode;
+	int aaf_gain;
+	int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
@@ -466,6 +528,43 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static void ad7768_fill_scale_tbl(struct iio_dev *dev)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	const struct iio_scan_type *scan_type;
+	int val, val2, tmp0, tmp1, i;
+	unsigned long denominator, numerator;
+	u64 tmp2;
+
+	scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);
+	if (scan_type->sign == 's')
+		val2 = scan_type->realbits - 1;
+	else
+		val2 = scan_type->realbits;
+
+	for (i = 0; i < st->chip->num_pga_modes; i++) {
+		/* Convert gain to a fraction format */
+		numerator = st->chip->pga_gains[i];
+		denominator = MILLI;
+		if (st->chip->has_variable_aaf) {
+			numerator *= ad7768_aaf_gains[st->aaf_gain];
+			denominator *= MILLI;
+		}
+
+		rational_best_approximation(numerator, denominator, __INT_MAX__, __INT_MAX__,
+					    &numerator, &denominator);
+
+		val = st->vref_uv / 1000;
+		/* Multiply by MILLI here to avoid losing precision */
+		val = mult_frac(val, denominator * MILLI, numerator);
+		/* Would multiply by NANO here but we already multiplied by MILLI */
+		tmp2 = shift_right((u64)val * MICRO, val2);
+		tmp0 = (int)div_s64_rem(tmp2, NANO, &tmp1);
+		st->scale_tbl[i][0] = tmp0; /* Integer part */
+		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
+	}
+}
+
 static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
 				     unsigned int dec_rate)
 {
@@ -567,12 +666,68 @@ static int ad7768_configure_dig_fil(struct iio_dev *dev,
 		st->oversampling_ratio = ad7768_dec_rate_values[dec_rate_idx];
 	}
 
+	/* Update scale table: scale values vary according to the precision */
+	ad7768_fill_scale_tbl(dev);
+
 	ad7768_fill_samp_freq_tbl(st);
 
 	/* A sync-in pulse is required after every configuration change */
 	return ad7768_send_sync_pulse(st);
 }
 
+static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
+				int gain_fract, int precision)
+{
+	u64 gain_nano, tmp;
+	int gain_idx;
+
+	precision--;
+	gain_nano = gain_int * NANO + gain_fract;
+	if (gain_nano < 0 || gain_nano > ADAQ776X_GAIN_MAX_NANO)
+		return -EINVAL;
+
+	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
+	gain_nano = DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);
+	if (st->chip->has_variable_aaf)
+		/* remove the AAF gain from the overall gain */
+		gain_nano = DIV_ROUND_CLOSEST_ULL(gain_nano *  MILLI,
+						  ad7768_aaf_gains[st->aaf_gain]);
+	tmp = st->chip->num_pga_modes;
+	gain_idx = find_closest(gain_nano, st->chip->pga_gains, tmp);
+
+	return gain_idx;
+}
+
+static int ad7768_set_pga_gain(struct ad7768_state *st,
+			       int gain_mode)
+{
+	int pgia_pins_value = abs(gain_mode - st->chip->pgia_mode2pin_offset);
+	int check_val;
+	int ret;
+
+	/* Check GPIO control register */
+	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &check_val);
+	if (ret < 0)
+		return ret;
+
+	if ((check_val & AD7768_GPIO_PGIA_EN) != AD7768_GPIO_PGIA_EN) {
+		/* Enable PGIA GPIOs and set them as output */
+		ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_PGIA_EN);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Write the respective gain values to GPIOs 0, 1, 2 */
+	ret = regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
+			   AD7768_GPIO_WRITE(pgia_pins_value));
+	if (ret < 0)
+		return ret;
+
+	st->pga_gain_mode = gain_mode;
+
+	return 0;
+}
+
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
 	struct iio_dev *indio_dev = gpiochip_get_data(chip);
@@ -782,13 +937,17 @@ static const struct iio_chan_spec ad7768_channels[] = {
 	AD7768_CHAN(0, AD7768_CHAN_INFO_NONE),
 };
 
+static const struct iio_chan_spec adaq776x_channels[] = {
+	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
+};
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
-	int scale_uv, ret, temp;
+	int ret, temp;
 
 	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
@@ -809,12 +968,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		scale_uv = st->vref_uv;
-		if (scale_uv < 0)
-			return scale_uv;
-
-		*val = (scale_uv * 2) / 1000;
-		*val2 = scan_type->realbits;
+		if (st->chip->has_pga) {
+			*val = st->scale_tbl[st->pga_gain_mode][0];
+			*val2 = st->scale_tbl[st->pga_gain_mode][1];
+			return IIO_VAL_INT_PLUS_NANO;
+		}
+		*val = st->vref_uv / 1000;
+		if (st->chip->has_variable_aaf)
+			*val = (*val * MILLI) / ad7768_aaf_gains[st->aaf_gain];
+		/*
+		 * ADC output code is two's complement so only (realbits - 1)
+		 * bits express voltage magnitude.
+		 */
+		*val2 = scan_type->realbits - 1;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -869,18 +1035,42 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
 		*length = st->samp_freq_avail_len;
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)st->scale_tbl;
+		*length = st->chip->num_pga_modes * 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
+
 static int __ad7768_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	int gain_mode;
 	int ret;
 
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad7768_set_freq(st, val);
@@ -892,6 +1082,13 @@ static int __ad7768_write_raw(struct iio_dev *indio_dev,
 
 		/* Update sampling frequency */
 		return ad7768_set_freq(st, st->samp_freq);
+	case IIO_CHAN_INFO_SCALE:
+		if (!st->chip->has_pga)
+			return -EOPNOTSUPP;
+
+		gain_mode = ad7768_calc_pga_gain(st, val, val2,
+						 scan_type->realbits);
+		return ad7768_set_pga_gain(st, gain_mode);
 	default:
 		return -EINVAL;
 	}
@@ -933,6 +1130,7 @@ static const struct iio_info ad7768_info = {
 	.read_raw = &ad7768_read_raw,
 	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
+	.write_raw_get_fmt = &ad7768_write_raw_get_fmt,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
@@ -1351,10 +1549,46 @@ static const struct ad7768_chip_info ad7768_chip_info = {
 	.available_masks = ad7768_channel_masks,
 };
 
+static const struct ad7768_chip_info adaq7767_chip_info = {
+	.name = "adaq7767-1",
+	.channel_spec = ad7768_channels,
+	.num_channels = ARRAY_SIZE(ad7768_channels),
+	.available_masks = ad7768_channel_masks,
+	.has_pga = false,
+	.has_variable_aaf = true
+};
+
+static const struct ad7768_chip_info adaq7768_chip_info = {
+	.name = "adaq7768-1",
+	.channel_spec = adaq776x_channels,
+	.num_channels = ARRAY_SIZE(adaq776x_channels),
+	.available_masks = ad7768_channel_masks,
+	.pga_gains = adaq7768_gains,
+	.default_pga_mode = AD7768_PGA_GAIN_2,
+	.num_pga_modes = ARRAY_SIZE(adaq7768_gains),
+	.pgia_mode2pin_offset = 6,
+	.has_pga = true,
+	.has_variable_aaf = false
+};
+
+static const struct ad7768_chip_info adaq7769_chip_info = {
+	.name = "adaq7769-1",
+	.channel_spec = adaq776x_channels,
+	.num_channels = ARRAY_SIZE(adaq776x_channels),
+	.available_masks = ad7768_channel_masks,
+	.pga_gains = adaq7769_gains,
+	.default_pga_mode = AD7768_PGA_GAIN_0,
+	.num_pga_modes = ARRAY_SIZE(adaq7769_gains),
+	.pgia_mode2pin_offset = 0,
+	.has_pga = true,
+	.has_variable_aaf = true
+};
+
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
 	struct iio_dev *indio_dev;
+	u32 val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -1418,6 +1652,35 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	st->aaf_gain = AD7768_AAF_IN1;
+	ret = device_property_read_u32(&spi->dev, "adi,aaf-gain", &val);
+	if (ret) {
+		/* AAF gain required, but not specified */
+		if (st->chip->has_variable_aaf)
+			return dev_err_probe(&spi->dev, -EINVAL, "AAF gain not specified\n");
+
+	} else if (!st->chip->has_variable_aaf) {
+		/* AAF gain provided, but not supported */
+		return dev_err_probe(&spi->dev, -EINVAL, "AAF gain not supported for %s\n",
+				     st->chip->name);
+	} else {
+		/* Device supports variable AAF gain, validate and set the gain */
+		switch (val) {
+		case 1000:
+			st->aaf_gain = AD7768_AAF_IN1;
+			break;
+		case 364:
+			st->aaf_gain = AD7768_AAF_IN2;
+			break;
+		case 143:
+			st->aaf_gain = AD7768_AAF_IN3;
+			break;
+		default:
+			return dev_err_probe(&spi->dev, -EINVAL,
+					     "Invalid firmware provided gain\n");
+		}
+	}
+
 	ret = ad7768_setup(indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
@@ -1426,6 +1689,9 @@ static int ad7768_probe(struct spi_device *spi)
 
 	init_completion(&st->completion);
 
+	if (st->chip->has_pga)
+		ad7768_set_pga_gain(st, st->chip->default_pga_mode);
+
 	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
 		return ret;
@@ -1446,12 +1712,18 @@ static int ad7768_probe(struct spi_device *spi)
 
 static const struct spi_device_id ad7768_id_table[] = {
 	{ "ad7768-1", (kernel_ulong_t)&ad7768_chip_info },
+	{ "adaq7767-1", (kernel_ulong_t)&adaq7767_chip_info },
+	{ "adaq7768-1", (kernel_ulong_t)&adaq7768_chip_info },
+	{ "adaq7769-1", (kernel_ulong_t)&adaq7769_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7768_id_table);
 
 static const struct of_device_id ad7768_of_match[] = {
 	{ .compatible = "adi,ad7768-1", .data = &ad7768_chip_info },
+	{ .compatible = "adi,adaq7767-1", .data = &adaq7767_chip_info },
+	{ .compatible = "adi,adaq7768-1", .data = &adaq7768_chip_info },
+	{ .compatible = "adi,adaq7769-1", .data = &adaq7769_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7768_of_match);
-- 
2.34.1


