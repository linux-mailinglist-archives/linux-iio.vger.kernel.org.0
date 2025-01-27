Return-Path: <linux-iio+bounces-14629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCAA1D948
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A35E1887CFD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446FE149C53;
	Mon, 27 Jan 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OPi3Dg98"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C9D13D52E;
	Mon, 27 Jan 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990889; cv=none; b=m4vu2BVx3x9XNITmTX9qTJFhpWUHvxoOKIuOnVscoyxF9oWRh5PTKA7BQrxrVgnO258g/T/v3UGAqG0LYUL7Jp7kOxQ/injIrQ9mLj9cFIZzuHmq2LtIO2/TAWbLptFG7f2XRe8YMQwdhSU8EcRT48m4Pg2pkvMs+DdQQWT8tEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990889; c=relaxed/simple;
	bh=u9LaaQeUau3x7YznJ+M0nNQ8Lcx/fxXznUF77zYsQVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciGygIEJOtbj+w8Bz1Yv8hOoorvdjZ52o4iYhBM22YYs6AFkQ7Jv0IVJv+uqs9JV0qen7AZLQg21O0ya3I4+owmpUKgG1VlH5wFDe/TDwYgbGCRnKkZ5OaQLX6csElHah0CaAX3t9LJDOCBKDzKqrOshG2SohkPpz9bkw7potdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OPi3Dg98; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWCYH005707;
	Mon, 27 Jan 2025 10:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SVmrj
	qfpId3et969pjKuiGiFFNd1mufCaVcjhWLh+44=; b=OPi3Dg987wMgcdQWXhDHC
	jIoVW/BsBgT/BvEo2h9evrjPprj0QieueqLF59+YU5byeS2NAb+i00st4LZD3bEG
	vudKhdd72aPP8gNztRRKozAIE/r52XjID8Ef3+KGeigNFa7CIMQmAWlMrVly3LOg
	xWWNoi8aNSvLB6tUlrrhw/ninUGNHyy/abnozRbDM74pKdswuu7/DozKV9vFct6l
	TPJeK/nO582O2YiQ9Q7DaNqeChbk/Ev9rHPgl859FII67E6Tt35Q7ArtBsBJInqW
	Y98KsYASMOMsuXHzlVF3bQ+AAMJfm7ka3CazaDmUNJzzqpz6255xLbIDsOBU4UHg
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:14:32 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFEVLA011122
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:14:31 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:14:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 10:14:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:14:31 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFEKjo008467;
	Mon, 27 Jan 2025 10:14:22 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, PopPaul2021 <paul.pop@analog.com>
Subject: [PATCH v2 15/16] iio: adc: ad7768-1: add filter type and oversampling ratio attributes
Date: Mon, 27 Jan 2025 12:14:19 -0300
Message-ID: <3a5684280e86df1e2cc2c9be291fa2807aa6cb02.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Ze9XKNgkYDI4J5J-yQSpcAJjop9bR-Yg
X-Proofpoint-GUID: Ze9XKNgkYDI4J5J-yQSpcAJjop9bR-Yg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

Separate filter type and decimation rate from the sampling frequency
attribute. The new filter type attribute enables SINC3 and WIDEBAND
filters, which were previously unavailable.

Previously, combining decimation and MCLK divider in the sampling
frequency obscured performance trade-offs. Lower MCLK divider
settings increase power usage, while lower decimation rates reduce
precision by decreasing averaging. By creating an oversampling
attribute, which controls the decimation, users gain finer control
over performance.

The addition of those attributes allows a wider range of sampling
frequencies and more access to the device features.

Co-developed-by: PopPaul2021 <paul.pop@analog.com>
Signed-off-by: PopPaul2021 <paul.pop@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* Decimation_rate attribute replaced for oversampling_ratio.
---
 drivers/iio/adc/ad7768-1.c | 389 +++++++++++++++++++++++++++++++------
 1 file changed, 325 insertions(+), 64 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 01ccbe0aa708..6d0b430a8d54 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -5,6 +5,7 @@
  * Copyright 2017 Analog Devices Inc.
  */
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -17,6 +18,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
+#include "linux/util_macros.h"
 #include <linux/spi/spi.h>
 
 #include <linux/iio/buffer.h>
@@ -77,6 +79,10 @@
 #define AD7768_DIG_FIL_DEC_MSK		GENMASK(2, 0)
 #define AD7768_DIG_FIL_DEC_RATE(x)	FIELD_PREP(AD7768_DIG_FIL_DEC_MSK, x)
 
+/* AD7768_SINC3_DEC_RATE */
+#define AD7768_SINC3_DEC_RATE_MSB_MSK	GENMASK(12, 8)
+#define AD7768_SINC3_DEC_RATE_LSB_MSK	GENMASK(7, 0)
+
 /* AD7768_REG_CONVERSION */
 #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
 #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
@@ -97,6 +103,18 @@
 #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
 #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
 
+/* Decimation Rate Limits */
+#define SINC5_DEC_RATE_MIN		8
+#define SINC5_DEC_RATE_MAX		1024
+#define SINC3_DEC_RATE_MIN		32
+#define SINC3_DEC_RATE_MAX		163840
+#define WIDEBAND_DEC_RATE_MIN		32
+#define WIDEBAND_DEC_RATE_MAX		1024
+
+enum {
+	DEC_RATE,
+};
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -118,22 +136,12 @@ enum ad7768_mclk_div {
 	AD7768_MCLK_DIV_2
 };
 
-enum ad7768_dec_rate {
-	AD7768_DEC_RATE_32 = 0,
-	AD7768_DEC_RATE_64 = 1,
-	AD7768_DEC_RATE_128 = 2,
-	AD7768_DEC_RATE_256 = 3,
-	AD7768_DEC_RATE_512 = 4,
-	AD7768_DEC_RATE_1024 = 5,
-	AD7768_DEC_RATE_8 = 9,
-	AD7768_DEC_RATE_16 = 10
-};
-
-struct ad7768_clk_configuration {
-	enum ad7768_mclk_div mclk_div;
-	enum ad7768_dec_rate dec_rate;
-	unsigned int clk_div;
-	enum ad7768_pwrmode pwrmode;
+enum ad7768_flt_type {
+	SINC5,
+	SINC5_DEC_X8,
+	SINC5_DEC_X16,
+	SINC3,
+	WIDEBAND
 };
 
 enum ad7768_scan_type {
@@ -145,18 +153,12 @@ static const int ad7768_mclk_div_rates[4] = {
 	16, 8, 4, 2,
 };
 
-static const struct ad7768_clk_configuration ad7768_clk_config[] = {
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_32, 64, AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_64, 128, AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_128, 256, AD7768_FAST_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_128, 512, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_256, 1024, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_512, 2048, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_1024, 4096, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_8, AD7768_DEC_RATE_1024, 8192, AD7768_MED_MODE },
-	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
+static const int ad7768_dec_rate_values[6] = {
+	32, 64, 128, 256, 512, 1024,
+};
+
+static const char * const ad7768_filter_enum[] = {
+	"sinc5", "sinc3", "wideband"
 };
 
 static const struct iio_scan_type ad7768_scan_type[] = {
@@ -176,12 +178,32 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 	},
 };
 
+static int ad7768_get_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan);
+static int ad7768_set_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan, unsigned int filter);
+
+static const struct iio_enum ad7768_flt_type_iio_enum = {
+	.items = ad7768_filter_enum,
+	.num_items = ARRAY_SIZE(ad7768_filter_enum),
+	.set = ad7768_set_fil_type_attr,
+	.get = ad7768_get_fil_type_attr,
+};
+
+static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
+	{ },
+};
+
 static const struct iio_chan_spec ad7768_channels[] = {
 	{
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.ext_info = ad7768_ext_info,
 		.indexed = 1,
 		.channel = 0,
 		.scan_index = 0,
@@ -201,7 +223,9 @@ struct ad7768_state {
 	struct gpio_chip gpiochip;
 	unsigned int gpio_avail_map;
 	unsigned int mclk_freq;
-	unsigned int dec_rate;
+	unsigned int mclk_div;
+	unsigned int oversampling_ratio;
+	enum ad7768_flt_type filter_type;
 	unsigned int samp_freq;
 	struct completion completion;
 	struct iio_trigger *trig;
@@ -223,6 +247,9 @@ struct ad7768_state {
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 
+static int ad7768_set_freq(struct ad7768_state *st,
+			   unsigned int freq);
+
 static int ad7768_spi_reg_read(void *context, unsigned int addr,
 			       unsigned int *val)
 {
@@ -281,6 +308,31 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
 	return 0;
 }
 
+static int ad7768_set_mclk_div(struct ad7768_state *st, unsigned int mclk_div)
+{
+	unsigned int mclk_div_value;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	ret = ad7768_spi_reg_read(st, AD7768_REG_POWER_CLOCK, &mclk_div_value, 1);
+	if (ret)
+		return ret;
+
+	mclk_div_value &= ~(AD7768_PWR_MCLK_DIV_MSK | AD7768_PWR_PWRMODE_MSK);
+	/* Set mclk_div value */
+	mclk_div_value |= AD7768_PWR_MCLK_DIV(mclk_div);
+	/*
+	 * Set power mode based on mclk_div value.
+	 * ECO_MODE is only recommended for MCLK_DIV 16
+	 */
+	if (mclk_div > AD7768_MCLK_DIV_16)
+		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_FAST_MODE);
+	else
+		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_ECO_MODE);
+
+	return regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, mclk_div_value);
+}
+
 static int ad7768_set_mode(struct ad7768_state *st,
 			   enum ad7768_conv_mode mode)
 {
@@ -349,23 +401,183 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int ad7768_set_dig_fil(struct ad7768_state *st,
-			      enum ad7768_dec_rate dec_rate)
+static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
+				     unsigned int dec_rate)
+{
+	unsigned int dec_rate_msb, dec_rate_lsb, max_dec_rate;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	/*
+	 * Maximum dec_rate is limited by the MCLK_DIV value
+	 * and by the ODR. The edge case is for MCLK_DIV = 2
+	 * ODR = 50 SPS.
+	 * max_dec_rate <= MCLK / (2 * 50)
+	 */
+	max_dec_rate = st->mclk_freq / 100;
+	dec_rate = clamp_t(unsigned int, dec_rate, 32, max_dec_rate);
+	/*
+	 * Calculate the equivalent value to sinc3 decimation ratio
+	 * to be written on the SINC3_DECIMATION_RATE register:
+	 *  Value = (DEC_RATE / 32) -1
+	 */
+	dec_rate = DIV_ROUND_UP(dec_rate, 32) - 1;
+	dec_rate_msb = FIELD_GET(AD7768_SINC3_DEC_RATE_MSB_MSK, dec_rate);
+	dec_rate_lsb = FIELD_GET(AD7768_SINC3_DEC_RATE_LSB_MSK, dec_rate);
+
+	ret = regmap_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_MSB, dec_rate_msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_LSB, dec_rate_lsb);
+	if (ret)
+		return ret;
+
+	st->oversampling_ratio = (dec_rate + 1) * 32;
+
+	return 0;
+}
+
+static int ad7768_set_dec_rate(struct ad7768_state *st, unsigned int dec_rate)
 {
+	unsigned int mode, dec_rate_reg;
+	int ret;
+
+	dec_rate_reg = find_closest(dec_rate, ad7768_dec_rate_values,
+				    ARRAY_SIZE(ad7768_dec_rate_values));
+
+	guard(mutex)(&st->lock);
+	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
+	if (ret)
+		return ret;
+
+	mode &= ~AD7768_DIG_FIL_DEC_MSK;
+	mode |= AD7768_DIG_FIL_DEC_RATE(dec_rate_reg);
+	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
+	if (ret)
+		return ret;
+
+	st->oversampling_ratio = ad7768_dec_rate_values[dec_rate_reg];
+
+	return 0;
+}
+
+static int ad7768_set_filter_type(struct iio_dev *dev,
+				  enum ad7768_flt_type filter_type)
+{
+	struct ad7768_state *st = iio_priv(dev);
 	unsigned int mode;
 	int ret;
 
-	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
-		mode = AD7768_DIG_FIL_FIL(dec_rate);
-	else
-		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
+	guard(mutex)(&st->lock);
+	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
+	if (ret)
+		return ret;
+
+	mode &= ~AD7768_DIG_FIL_FIL_MSK;
+	mode |= AD7768_DIG_FIL_FIL(filter_type);
 
 	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
 	if (ret < 0)
 		return ret;
 
-	/* A sync-in pulse is required every time the filter dec rate changes */
-	return ad7768_send_sync_pulse(st);
+	st->filter_type = filter_type;
+
+	return 0;
+}
+
+static int ad7768_configure_dig_fil(struct iio_dev *dev,
+				    enum ad7768_flt_type filter_type,
+				    unsigned int dec_rate)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+
+	if (filter_type == SINC3) {
+		ret = ad7768_set_filter_type(dev, SINC3);
+		if (ret)
+			return ret;
+
+		/* recalculate the decimation for this filter mode */
+		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);
+	} else if (filter_type == WIDEBAND) {
+		ret = ad7768_set_filter_type(dev, filter_type);
+		if (ret)
+			return ret;
+
+		/* recalculate the decimation rate */
+		ret = ad7768_set_dec_rate(st, dec_rate);
+	} else {
+		/* For SINC5 filter */
+		/* Decimation 8 and 16 are set in the digital filter field */
+		if (dec_rate <= 8) {
+			ret = ad7768_set_filter_type(dev, SINC5_DEC_X8);
+			if (ret)
+				return ret;
+
+			st->oversampling_ratio = 8;
+		} else if (dec_rate <= 16) {
+			ret = ad7768_set_filter_type(dev, SINC5_DEC_X16);
+			if (ret)
+				return ret;
+
+			st->oversampling_ratio = 16;
+		} else {
+			ret = ad7768_set_filter_type(dev, SINC5);
+			if (ret)
+				return ret;
+
+			ret = ad7768_set_dec_rate(st, dec_rate);
+		}
+	}
+
+	return ret;
+}
+
+static int ad7768_set_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int filter)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+
+	/*
+	 * Filters of types 0, 1, and 2 correspond to SINC5.
+	 * For SINC3 and wideband filter types, an offset of 2 is added
+	 * to align with the expected register values.
+	 */
+	if (filter != SINC5)
+		filter += 2;
+
+	ret = ad7768_configure_dig_fil(dev, filter, st->oversampling_ratio);
+	if (ret)
+		return ret;
+
+	/* Update sampling frequency */
+	return ad7768_set_freq(st, st->samp_freq);
+}
+
+static int ad7768_get_fil_type_attr(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+	unsigned int mode;
+
+	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
+	if (ret)
+		return ret;
+
+	mode = FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode);
+	/* Filter types from 0 to 2 are represented as SINC5 */
+	if (mode < SINC3)
+		return SINC5;
+
+	/*
+	 * Remove the offset for the sinc3 and wideband filters
+	 * to get the corresponding attribute enum value
+	 */
+	return mode - 2;
 }
 
 static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
@@ -490,43 +702,37 @@ static int ad7768_gpio_init(struct iio_dev *indio_dev)
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
-	unsigned int diff_new, diff_old, pwr_mode, i, idx;
+	unsigned int diff_new, diff_old, i, idx;
 	int res, ret;
 
+	freq = clamp_t(unsigned int, freq, 50, 1024000);
 	diff_old = U32_MAX;
 	idx = 0;
 
-	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq);
+	if (freq == 0)
+		return -EINVAL;
+
+	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->oversampling_ratio);
 
 	/* Find the closest match for the desired sampling frequency */
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
-		diff_new = abs(res - ad7768_clk_config[i].clk_div);
+	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
+		diff_new = abs(res - ad7768_mclk_div_rates[i]);
 		if (diff_new < diff_old) {
 			diff_old = diff_new;
 			idx = i;
 		}
 	}
 
-	/*
-	 * Set both the mclk_div and pwrmode with a single write to the
-	 * POWER_CLOCK register
-	 */
-	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
-		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
-	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
-	if (ret < 0)
-		return ret;
-
-	ret =  ad7768_set_dig_fil(st, ad7768_clk_config[idx].dec_rate);
-	if (ret < 0)
+	/* Set both the mclk_div and pwrmode */
+	ret = ad7768_set_mclk_div(st, idx);
+	if (ret)
 		return ret;
 
-	st->dec_rate = ad7768_clk_config[idx].clk_div /
-		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
 	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
-					  ad7768_clk_config[idx].clk_div);
+					  ad7768_mclk_div_rates[idx] * st->oversampling_ratio);
 
-	return 0;
+	/* A sync-in pulse is required every time the filter dec rate changes */
+	return ad7768_send_sync_pulse(st);
 }
 
 static int ad7768_set_vcm_output(struct ad7768_state *st, unsigned int mode)
@@ -540,13 +746,16 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7768_state *st = iio_priv(indio_dev);
-	unsigned int freq;
+	unsigned int freq, freq_filtered;
 	int i, len = 0;
 
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
-		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
-					 ad7768_clk_config[i].clk_div);
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
+	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
+	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
+		freq = DIV_ROUND_CLOSEST(freq_filtered,
+					 ad7768_mclk_div_rates[i]);
+		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
+		if (freq >= 50)
+			len += sysfs_emit_at(buf, len, "%d ", freq);
 	}
 
 	buf[len - 1] = '\n';
@@ -556,6 +765,37 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
 
+static ssize_t oversampling_ratio_available_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7768_state *st = iio_priv(indio_dev);
+	int len = 0;
+
+	/* Return oversampling ratio available in range format */
+	buf[len++] = '[';
+	if (st->filter_type == SINC3) {
+		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MAX);
+	} else if (st->filter_type == WIDEBAND) {
+		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MAX);
+	} else {
+		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
+		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MAX);	}
+
+	buf[len - 1] = ']';
+	buf[len++] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RO(oversampling_ratio_available, 0);
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -597,6 +837,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = st->samp_freq;
 
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling_ratio;
+
 		return IIO_VAL_INT;
 	}
 
@@ -608,10 +853,19 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad7768_set_freq(st, val);
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, val);
+		if (ret)
+			return ret;
+
+		/* Update sampling frequency */
+		return ad7768_set_freq(st, st->samp_freq);
 	default:
 		return -EINVAL;
 	}
@@ -627,6 +881,7 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
 
 static struct attribute *ad7768_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL
 };
 
@@ -639,7 +894,7 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 
-	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
+	return st->oversampling_ratio == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
 		AD7768_SCAN_TYPE_NORMAL;
 }
 
@@ -745,6 +1000,12 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	/*
+	 * Set Default Digital Filter configuration:
+	 * SINC5 filter with x32 Decimation rate
+	 */
+	ret = ad7768_configure_dig_fil(indio_dev, SINC5, 32);
+
 	/* Set the default sampling frequency to 32000 kSPS */
 	return ad7768_set_freq(st, 32000);
 }
-- 
2.34.1


