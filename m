Return-Path: <linux-iio+bounces-20225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F441ACE510
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EBF3A35D5
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2118B23184C;
	Wed,  4 Jun 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZdC6eDQl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8721421A;
	Wed,  4 Jun 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065883; cv=none; b=CAJZajIWLPa3SyvKqIM5Sy6jX8JbZdqkU6TFp+7fUbmOcLSnJNAGClfFjxYKXs0amc5yJNlB9ZlUKAjsY/o1+8j9urJIQ++3Z9QxkqskS78IcnPtSocmv2N/9zQyo4wbcyR5mALWkak0wUmXBa5nsMiE6Mgxpz+MVIcIAFOuPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065883; c=relaxed/simple;
	bh=mkl2A9yr4Qt2Z3WBs91RW1n2ZT6GHvgce2qEw6M7fps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxVk2bjClhRNB0ytNaPL8CAmgWkstaJPJjL+mVfAQ3pNA977lp6L0JJbr9IfeBsSrpeQ/5SXkYOCDKfVYw8KqCB5N2ufYpwyb7IrmEt2sizNTHpWLqKJibaF+aTQ8cxa7mx24jQzKOKBicRdOYmHxu8Pk8rIIqjsymD6JXNT9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZdC6eDQl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554FdHhp030454;
	Wed, 4 Jun 2025 15:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mW5SG
	1QmUgrQ45invhLOPsSgodnjFkZZNIqKGA2xSIw=; b=ZdC6eDQlrMO2o5k67Ytmm
	EcYlXZAZyH9qYV8vsXoIU8R4vUYy1Qc5M19mILS4Pxl9fgEGs04jhsFz6/GP+hdJ
	KFUTEWCYCfXKVezT+vu6QxkvFxSxJImmHPUPSu9u9nI8MMd6uPe3/GZy2QYJn28g
	P9tVSozN7eb/tTx6FH5yfLsq5pxurxbQNXfJ3FvlZlzYMaJQ232lDFVd7x0BMkQq
	WCTsWXDXoRv5QBVQKxoZHqcTo+79jWlWbrOXGC1PYqRQNaXti8a1I4bqecK8MPsK
	kn2FE0keBiY+jBJsWkt09A7FnMLL4y/yocsLwNBkS2HbviZK8wv4Rt/R3aYmj1eK
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 472p2vhw24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 15:37:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 554JbraA053872
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Jun 2025 15:37:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Jun
 2025 15:37:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Jun 2025 15:37:53 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 554JbasN014367;
	Wed, 4 Jun 2025 15:37:39 -0400
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
        Pop
 Paul <paul.pop@analog.com>
Subject: [PATCH v10 11/12] iio: adc: ad7768-1: add filter type and oversampling ratio attributes
Date: Wed, 4 Jun 2025 16:37:36 -0300
Message-ID: <c36d6494453050041a585c0e79d7bb674da11c99.1749063024.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1749063024.git.Jonathan.Santos@analog.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE1NSBTYWx0ZWRfXxjMMlaBc+U4a
 uPI5KCVlcEma2s9kdNgywpedFOD7gWOVuUS6ROh2soIPPCF3kkXCDvugFSuGX+VPixCkamVd9j0
 z8uDqjFgav9ecpn6EWFfw4FQ+Hgqp0LzcZIXFc/HCMLQNVc/8LCo4Kcq948mxWNC6R6xF+4ejpM
 UjIiMO4txECqEMdpshkR8f5pvQ/BIfAIfVpqT0ImX8xjhCLNbkfOO5ZrDp6v2S/AAwcN2+eHOcd
 YPVFZf8JsHbi2duwclsrqnbkbS8Irh/D2baOFufo/qALZNnOGYHjj9P1FuZxPOvBLFD5+8LZ5nv
 LcDU3nTebx0CEQXqmHmRYi/oqbzSgWtHboTuCFIBNBmwwu/A5Pko+4a6FIBYegnio5Cpql4o2n6
 K+CBSxyS3CiEIWqKoI4GQjRYKNMkT/FVb4HkK7zECrlQ2tSz2LshgCFOsnmLcEzzqPDL821w
X-Proofpoint-GUID: RHaxcp8Ss1ODQ5fNIjZGiOyYPjQZA12r
X-Proofpoint-ORIG-GUID: RHaxcp8Ss1ODQ5fNIjZGiOyYPjQZA12r
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=6840a093 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=EP7K-5VxzDsVkbtTEdQA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040155

Separate filter type and decimation rate from the sampling frequency
attribute. The new filter type attribute enables sinc3, sinc3+rej60
and wideband filters, which were previously unavailable.

Previously, combining decimation and MCLK divider in the sampling
frequency obscured performance trade-offs. Lower MCLK divider
settings increase power usage, while lower decimation rates reduce
precision by decreasing averaging. By creating an oversampling
attribute, which controls the decimation, users gain finer control
over performance.

The addition of those attributes allows a wider range of sampling
frequencies and more access to the device features. Sampling frequency
table is updated after every digital filter parameter change.

Changes in the sampling frequency are not allowed anymore while in
buffered mode.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Co-developed-by: Pop Paul <paul.pop@analog.com>
Signed-off-by: Pop Paul <paul.pop@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v10 Changes:
* None.

v9 Changes:
* Addressed some nits.
* Fixed oversampling_ratio_available attribute. Now we mix range 
  (for sinc3) with list (for sinc5 and wideband).

v8 Changes:
* Addressed formatting issue.
* used find_closest_descending() implementation to find the closest mclk
  divider.
* Reorganized ad7768_fill_samp_freq_tbl() function to improve the
  samp_freq_avail assignment. 

v7 Changes:
* Refactor code to avoid forward declarations.
* replaced clamp_t() for clamp();
* Mentioned that sampling frequency changes is not allowed in
  buffered mode.
* removed 60Hz rejection enable from the filter mask and create
  AD7768_DIG_FIL_EN_60HZ_REJ for it.
* addressed other nits.

v6 Changes:
* Made sinc3 decimation rate calculation clearer as requested.
* Renamed some filter functions to clarify the purpose.
* Other nits.

v5 Changes:
* Addressed some nits.
* Use the new new iio_device_claim/release_direct() functions.

v4 Changes:
* Sampling frequency table is dynamically updated after every
  filter configuration.

v3 Changes:
* removed unused variables.
* included sinc3+rej60 filter type.
* oversampling_ratio moved to info_mask_shared_by_type.
* reordered functions to avoid forward declaration.
* simplified regmap writes.
* Removed locking.
* replaced some helper functions for direct regmap_update_bits
  calls.
* Addressed other nits.

v2 Changes:
* Decimation_rate attribute replaced for oversampling_ratio.
---
 drivers/iio/adc/ad7768-1.c | 414 ++++++++++++++++++++++++++++---------
 1 file changed, 319 insertions(+), 95 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 4f7d0327a05e..8c56b7243211 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -21,6 +21,8 @@
 #include <linux/regulator/driver.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+#include <linux/util_macros.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -78,6 +80,7 @@
 #define AD7768_PWR_PWRMODE(x)		FIELD_PREP(AD7768_PWR_PWRMODE_MSK, x)
 
 /* AD7768_REG_DIGITAL_FILTER */
+#define AD7768_DIG_FIL_EN_60HZ_REJ	BIT(7)
 #define AD7768_DIG_FIL_FIL_MSK		GENMASK(6, 4)
 #define AD7768_DIG_FIL_FIL(x)		FIELD_PREP(AD7768_DIG_FIL_FIL_MSK, x)
 #define AD7768_DIG_FIL_DEC_MSK		GENMASK(2, 0)
@@ -105,6 +108,8 @@
 
 #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
 
+#define AD7768_MAX_CHANNELS 1
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -126,22 +131,20 @@ enum ad7768_mclk_div {
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
+enum ad7768_filter_type {
+	AD7768_FILTER_SINC5,
+	AD7768_FILTER_SINC3,
+	AD7768_FILTER_WIDEBAND,
+	AD7768_FILTER_SINC3_REJ60,
 };
 
-struct ad7768_clk_configuration {
-	enum ad7768_mclk_div mclk_div;
-	enum ad7768_dec_rate dec_rate;
-	unsigned int clk_div;
-	enum ad7768_pwrmode pwrmode;
+enum ad7768_filter_regval {
+	AD7768_FILTER_REGVAL_SINC5 = 0,
+	AD7768_FILTER_REGVAL_SINC5_X8 = 1,
+	AD7768_FILTER_REGVAL_SINC5_X16 = 2,
+	AD7768_FILTER_REGVAL_SINC3 = 3,
+	AD7768_FILTER_REGVAL_WIDEBAND = 4,
+	AD7768_FILTER_REGVAL_SINC3_REJ60 = 11,
 };
 
 enum ad7768_scan_type {
@@ -153,18 +156,36 @@ static const int ad7768_mclk_div_rates[] = {
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
+static const int ad7768_dec_rate_values[8] = {
+	8, 16, 32, 64, 128, 256, 512, 1024,
+};
+
+/* Decimation rate range for sinc3 filter */
+static const int ad7768_sinc3_dec_rate_range[3] = {
+	32, 32, 163840
+};
+
+/*
+ * The AD7768-1 supports three primary filter types:
+ * Sinc5, Sinc3, and Wideband.
+ * However, the filter register values can also encode additional parameters
+ * such as decimation rates and 60Hz rejection. This utility array separates
+ * the filter type from these parameters.
+ */
+static const int ad7768_filter_regval_to_type[] = {
+	[AD7768_FILTER_REGVAL_SINC5] = AD7768_FILTER_SINC5,
+	[AD7768_FILTER_REGVAL_SINC5_X8] = AD7768_FILTER_SINC5,
+	[AD7768_FILTER_REGVAL_SINC5_X16] = AD7768_FILTER_SINC5,
+	[AD7768_FILTER_REGVAL_SINC3] = AD7768_FILTER_SINC3,
+	[AD7768_FILTER_REGVAL_WIDEBAND] = AD7768_FILTER_WIDEBAND,
+	[AD7768_FILTER_REGVAL_SINC3_REJ60] = AD7768_FILTER_SINC3_REJ60,
+};
+
+static const char * const ad7768_filter_enum[] = {
+	[AD7768_FILTER_SINC5] = "sinc5",
+	[AD7768_FILTER_SINC3] = "sinc3",
+	[AD7768_FILTER_WIDEBAND] = "wideband",
+	[AD7768_FILTER_SINC3_REJ60] = "sinc3+rej60"
 };
 
 static const struct iio_scan_type ad7768_scan_type[] = {
@@ -183,22 +204,6 @@ static const struct iio_scan_type ad7768_scan_type[] = {
 	},
 };
 
-static const struct iio_chan_spec ad7768_channels[] = {
-	{
-		.type = IIO_VOLTAGE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
-		.indexed = 1,
-		.channel = 0,
-		.scan_index = 0,
-		.has_ext_scan_type = 1,
-		.ext_scan_type = ad7768_scan_type,
-		.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),
-	},
-};
-
 struct ad7768_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -208,14 +213,17 @@ struct ad7768_state {
 	unsigned int vcm_output_sel;
 	struct clk *mclk;
 	unsigned int mclk_freq;
-	unsigned int dec_rate;
+	unsigned int mclk_div;
+	unsigned int oversampling_ratio;
+	enum ad7768_filter_type filter_type;
 	unsigned int samp_freq;
-	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_clk_config)];
+	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
+	unsigned int samp_freq_avail_len;
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
-	const char *labels[ARRAY_SIZE(ad7768_channels)];
+	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
 	bool en_spi_sync;
 	/*
@@ -326,11 +334,38 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
 
 static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
 {
-	unsigned int i;
+	unsigned int i, samp_freq_avail, freq_filtered;
+	unsigned int len = 0;
+
+	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
+	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
+		samp_freq_avail = DIV_ROUND_CLOSEST(freq_filtered, ad7768_mclk_div_rates[i]);
+		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
+		if (samp_freq_avail < 50)
+			continue;
 
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
-		st->samp_freq_avail[i] =
-			DIV_ROUND_CLOSEST(st->mclk_freq, ad7768_clk_config[i].clk_div);
+		st->samp_freq_avail[len++] = samp_freq_avail;
+	}
+
+	st->samp_freq_avail_len = len;
+}
+
+static int ad7768_set_mclk_div(struct ad7768_state *st, unsigned int mclk_div)
+{
+	unsigned int mclk_div_value;
+
+	mclk_div_value = AD7768_PWR_MCLK_DIV(mclk_div);
+	/*
+	 * Set power mode based on mclk_div value.
+	 * ECO_MODE is only recommended for MCLK_DIV 16
+	 */
+	mclk_div_value |= mclk_div > AD7768_MCLK_DIV_16 ?
+			  AD7768_PWR_PWRMODE(AD7768_FAST_MODE) :
+			  AD7768_PWR_PWRMODE(AD7768_ECO_MODE);
+
+	return regmap_update_bits(st->regmap, AD7768_REG_POWER_CLOCK,
+				  AD7768_PWR_MCLK_DIV_MSK | AD7768_PWR_PWRMODE_MSK,
+				  mclk_div_value);
 }
 
 static int ad7768_set_mode(struct ad7768_state *st,
@@ -366,7 +401,7 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	 * register provides 24-bit data, the precision is reduced by
 	 * right-shifting the read value by 8 bits.
 	 */
-	if (st->dec_rate == 8)
+	if (st->oversampling_ratio == 8)
 		readval >>= 8;
 
 	/*
@@ -413,22 +448,110 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int ad7768_set_dig_fil(struct ad7768_state *st,
-			      enum ad7768_dec_rate dec_rate)
+static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
+				     unsigned int dec_rate)
 {
-	unsigned int mode;
+	unsigned int max_dec_rate;
+	u8 dec_rate_reg[2];
+	u16 regval;
 	int ret;
 
-	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
-		mode = AD7768_DIG_FIL_FIL(dec_rate);
-	else
-		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
+	/*
+	 * Maximum dec_rate is limited by the MCLK_DIV value and by the ODR.
+	 * The edge case is for MCLK_DIV = 2, ODR = 50 SPS.
+	 * max_dec_rate <= MCLK / (2 * 50)
+	 */
+	max_dec_rate = st->mclk_freq / 100;
+	dec_rate = clamp(dec_rate, 32, max_dec_rate);
+	/*
+	 * Calculate the equivalent value to sinc3 decimation ratio
+	 * to be written on the SINC3_DEC_RATE register:
+	 *  Value = (DEC_RATE / 32) - 1
+	 */
+	dec_rate = DIV_ROUND_UP(dec_rate, 32) - 1;
 
-	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
-	if (ret < 0)
+	/*
+	 * The SINC3_DEC_RATE value is a 13-bit value split across two
+	 * registers: MSB [12:8] and LSB [7:0]. Prepare the 13-bit value using
+	 * FIELD_PREP and store it with the right endianness in dec_rate_reg.
+	 */
+	regval = FIELD_PREP(GENMASK(12, 0), dec_rate);
+	put_unaligned_be16(regval, dec_rate_reg);
+	ret = regmap_bulk_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_MSB,
+				dec_rate_reg, 2);
+	if (ret)
+		return ret;
+
+	st->oversampling_ratio = (dec_rate + 1) * 32;
+
+	return 0;
+}
+
+static int ad7768_configure_dig_fil(struct iio_dev *dev,
+				    enum ad7768_filter_type filter_type,
+				    unsigned int dec_rate)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	unsigned int dec_rate_idx, dig_filter_regval;
+	int ret;
+
+	switch (filter_type) {
+	case AD7768_FILTER_SINC3:
+		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC3);
+		break;
+	case AD7768_FILTER_SINC3_REJ60:
+		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC3) |
+				    AD7768_DIG_FIL_EN_60HZ_REJ;
+		break;
+	case AD7768_FILTER_WIDEBAND:
+		/* Skip decimations 8 and 16, not supported by the wideband filter */
+		dec_rate_idx = find_closest(dec_rate, &ad7768_dec_rate_values[2],
+					    ARRAY_SIZE(ad7768_dec_rate_values) - 2);
+		dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_WIDEBAND) |
+				    AD7768_DIG_FIL_DEC_RATE(dec_rate_idx);
+		/* Correct the index offset */
+		dec_rate_idx += 2;
+		break;
+	case AD7768_FILTER_SINC5:
+		dec_rate_idx = find_closest(dec_rate, ad7768_dec_rate_values,
+					    ARRAY_SIZE(ad7768_dec_rate_values));
+
+		/*
+		 * Decimations 8 (idx 0) and 16 (idx 1) are set in the
+		 * FILTER[6:4] field. The other decimations are set in the
+		 * DEC_RATE[2:0] field, and the idx needs to be offsetted by two.
+		 */
+		if (dec_rate_idx == 0)
+			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5_X8);
+		else if (dec_rate_idx == 1)
+			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5_X16);
+		else
+			dig_filter_regval = AD7768_DIG_FIL_FIL(AD7768_FILTER_REGVAL_SINC5) |
+					    AD7768_DIG_FIL_DEC_RATE(dec_rate_idx - 2);
+		break;
+	}
+
+	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, dig_filter_regval);
+	if (ret)
 		return ret;
 
-	/* A sync-in pulse is required every time the filter dec rate changes */
+	st->filter_type = filter_type;
+	/*
+	 * The decimation for SINC3 filters are configured in different
+	 * registers.
+	 */
+	if (filter_type == AD7768_FILTER_SINC3 ||
+	    filter_type == AD7768_FILTER_SINC3_REJ60) {
+		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);
+		if (ret)
+			return ret;
+	} else {
+		st->oversampling_ratio = ad7768_dec_rate_values[dec_rate_idx];
+	}
+
+	ad7768_fill_samp_freq_tbl(st);
+
+	/* A sync-in pulse is required after every configuration change */
 	return ad7768_send_sync_pulse(st);
 }
 
@@ -551,45 +674,92 @@ static int ad7768_gpio_init(struct iio_dev *indio_dev)
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
-	unsigned int diff_new, diff_old, pwr_mode, i, idx;
-	int res, ret;
-
-	diff_old = U32_MAX;
-	idx = 0;
+	unsigned int idx, mclk_div;
+	int ret;
 
-	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq);
+	freq = clamp(freq, 50, 1024000);
+	if (freq == 0)
+		return -EINVAL;
 
+	mclk_div = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->oversampling_ratio);
 	/* Find the closest match for the desired sampling frequency */
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
-		diff_new = abs(res - ad7768_clk_config[i].clk_div);
-		if (diff_new < diff_old) {
-			diff_old = diff_new;
-			idx = i;
-		}
-	}
-
-	/*
-	 * Set both the mclk_div and pwrmode with a single write to the
-	 * POWER_CLOCK register
-	 */
-	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
-		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
-	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
-	if (ret < 0)
+	idx = find_closest_descending(mclk_div, ad7768_mclk_div_rates,
+				      ARRAY_SIZE(ad7768_mclk_div_rates));
+	/* Set both the mclk_div and pwrmode */
+	ret = ad7768_set_mclk_div(st, idx);
+	if (ret)
 		return ret;
 
-	ret =  ad7768_set_dig_fil(st, ad7768_clk_config[idx].dec_rate);
-	if (ret < 0)
+	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
+					  ad7768_mclk_div_rates[idx] * st->oversampling_ratio);
+
+	/* A sync-in pulse is required after every configuration change */
+	return ad7768_send_sync_pulse(st);
+}
+
+static int ad7768_set_filter_type_attr(struct iio_dev *dev,
+				       const struct iio_chan_spec *chan,
+				       unsigned int filter)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+
+	ret = ad7768_configure_dig_fil(dev, filter, st->oversampling_ratio);
+	if (ret)
 		return ret;
 
-	st->dec_rate = ad7768_clk_config[idx].clk_div /
-		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
-	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
-					  ad7768_clk_config[idx].clk_div);
+	/* Update sampling frequency */
+	return ad7768_set_freq(st, st->samp_freq);
+}
 
-	return 0;
+static int ad7768_get_filter_type_attr(struct iio_dev *dev,
+				       const struct iio_chan_spec *chan)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	int ret;
+	unsigned int mode, mask;
+
+	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
+	if (ret)
+		return ret;
+
+	mask = AD7768_DIG_FIL_EN_60HZ_REJ | AD7768_DIG_FIL_FIL_MSK;
+	/* From the register value, get the corresponding filter type */
+	return ad7768_filter_regval_to_type[FIELD_GET(mask, mode)];
 }
 
+static const struct iio_enum ad7768_filter_type_iio_enum = {
+	.items = ad7768_filter_enum,
+	.num_items = ARRAY_SIZE(ad7768_filter_enum),
+	.set = ad7768_set_filter_type_attr,
+	.get = ad7768_get_filter_type_attr,
+};
+
+static const struct iio_chan_spec_ext_info ad7768_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7768_filter_type_iio_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ad7768_filter_type_iio_enum),
+	{ }
+};
+
+static const struct iio_chan_spec ad7768_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+					    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = ad7768_ext_info,
+		.indexed = 1,
+		.channel = 0,
+		.scan_index = 0,
+		.has_ext_scan_type = 1,
+		.ext_scan_type = ad7768_scan_type,
+		.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type),
+	},
+};
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -629,6 +799,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = st->samp_freq;
 
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling_ratio;
+
 		return IIO_VAL_INT;
 	}
 
@@ -641,11 +816,29 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
 			     long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int shift;
 
 	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		/*
+		 * Sinc3 filter allows a wider range of OSR values, so show
+		 * the available values in range format.
+		 */
+		if (st->filter_type == AD7768_FILTER_SINC3 ||
+		    st->filter_type == AD7768_FILTER_SINC3_REJ60) {
+			*vals = (int *)ad7768_sinc3_dec_rate_range;
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_RANGE;
+		}
+
+		shift = st->filter_type == AD7768_FILTER_SINC5 ? 0 : 2;
+		*vals = (int *)&ad7768_dec_rate_values[shift];
+		*length = ARRAY_SIZE(ad7768_dec_rate_values) - shift;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals = (int *)st->samp_freq_avail;
-		*length = ARRAY_SIZE(ad7768_clk_config);
+		*length = st->samp_freq_avail_len;
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	default:
@@ -653,20 +846,44 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad7768_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long info)
+static int __ad7768_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long info)
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
 }
 
+static int ad7768_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = __ad7768_write_raw(indio_dev, chan, val, val2, info);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
+
 static int ad7768_read_label(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, char *label)
 {
@@ -680,7 +897,7 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 
-	return st->dec_rate == 8 ?
+	return st->oversampling_ratio == 8 ?
 	       AD7768_SCAN_TYPE_HIGH_SPEED : AD7768_SCAN_TYPE_NORMAL;
 }
 
@@ -804,6 +1021,14 @@ static int ad7768_setup(struct iio_dev *indio_dev)
 			return ret;
 	}
 
+	/*
+	 * Set Default Digital Filter configuration:
+	 * SINC5 filter with x32 Decimation rate
+	 */
+	ret = ad7768_configure_dig_fil(indio_dev, AD7768_FILTER_SINC5, 32);
+	if (ret)
+		return ret;
+
 	/* Set the default sampling frequency to 32000 kSPS */
 	return ad7768_set_freq(st, 32000);
 }
@@ -1138,7 +1363,6 @@ static int ad7768_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->mclk_freq = clk_get_rate(st->mclk);
-	ad7768_fill_samp_freq_tbl(st);
 
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-- 
2.34.1


