Return-Path: <linux-iio+bounces-19329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C00AB0107
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1961C03AB3
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D982868A9;
	Thu,  8 May 2025 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zdLInItu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31449283C93;
	Thu,  8 May 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723962; cv=none; b=TidP6yEX9ZBw7FwIlI5HzC+crgdy5Q19tIzFK1933ekd/fDU6TsdifXxcisodSFZN/XEUfSXBrfh/5JOp0vzGqghQ8D3DWiLIYACqX+Zr/CZS7ymGG+T5sMxyRpCW2iooaAEL6q84hJb5yKwegDRmYkpf4Csi0RW/VH5B8OIgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723962; c=relaxed/simple;
	bh=HBuU66S3VTq8i7o8eklJa2hkCmWyLRvco9Ii+S60nsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuqZBBPsPZVxtJx/NrOMnt0Ul1sGU+QX4lZAN7UpjzS6eFqOB284m/B+LeQsp7mnMFOh9hiUQ6aecK7+AjGQnxnWBtuP91sy1P0BmV9CJvVMzoG0pTmm8LkvhpKCSkWbk6IWC7ubAF8X2mSGdetVA2DecoIXeOElhLZHz7n0eUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zdLInItu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548FSXAD000696;
	Thu, 8 May 2025 13:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SS+Fb
	mOiFC7N0sPyXObj+cKQUUs11jhkykrBVHjB0XE=; b=zdLInItusKlyEUQpFkbbo
	ZtYOY4uUfiirK9XwqrMvrHgX5Nzo/I3PcVoyPSbGEr7VNSwqlAQeGbueZJjW/HdG
	AulRNpuD0VLvVpAEPqp0wjEaPY0svu5Zd+UlxIoWeb60vnvl6DdH8NxL6lUW37RG
	dXsXoROmfQ+UKPGldVzctsPU7qxIdYJ67RhIzfiDTfJxsqPNFIL8rY/udrqLgJ0i
	ajFcgupdK3ZeUxzo12n7FDQ35O9743AFyG32Rey1EF2daE9tw649edgh5auG1v1D
	xDo+0akUeZ0U74TZTn1hCHr2MMm+yCyTVmTlcGft4ltIv0jbVYrZqsSWYPXff7ay
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 46gy9q8dff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 13:05:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 548H5f2b052952
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 May 2025 13:05:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:05:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 8 May 2025 13:05:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 8 May 2025 13:05:41 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 548H5QhQ015951;
	Thu, 8 May 2025 13:05:29 -0400
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
        "Pop
 Paul" <paul.pop@analog.com>
Subject: [PATCH v7 11/12] iio: adc: ad7768-1: add filter type and oversampling ratio attributes
Date: Thu, 8 May 2025 14:05:26 -0300
Message-ID: <2180d8774a2fdef3900f86fbc8f25886503df479.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: KgNR3SMqWZc7U9nZJbFnipxcFMD7ceu7
X-Authority-Analysis: v=2.4 cv=f/ZIBPyM c=1 sm=1 tr=0 ts=681ce466 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=dt9VzEwgFbYA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=EP7K-5VxzDsVkbtTEdQA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: KgNR3SMqWZc7U9nZJbFnipxcFMD7ceu7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0OSBTYWx0ZWRfXx50DYk3HO/Z/
 Tg0HBx5rXtM3HQEowVywfHsKomfbTh8nJgoRQ9A+jxsKz4BTp5jcqtUVYKKryMYJAarc7BgL8iv
 9lvKSfUO83tBU728xJrBB4oxmFJZkjt+y9J50Yy0mxCytrhm1hl621HYdfd87JgXSvWeKntzfp9
 TJKxf2+q2sBSJ6I3xZP5abF/81+FID9R9tKdffcqcL1aFdBgZxPKnDIOOqgoFNv0w5BVhcQ5kDp
 V27TA7vC1rGqiy6/94eTEv1p5RhonbyM905sXeJe3aObjjt6hf+AIH4/6XPpy1zIBeWc2qWiJeH
 vaiPCcG0MlmgYlIaWAGRPVh7tSxoE/2cw2mEqWCedus09k4As4JpJ9xzptbKLkSo5RTGbwIx32g
 aTkzAoxB+MwLlO7rjlMERp7g5PaIGKw2vyVLMPFToVgYgYjEldDWNA+Ylif/Qh6ri5NA3yxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080149

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
 drivers/iio/adc/ad7768-1.c | 391 +++++++++++++++++++++++++++++--------
 1 file changed, 306 insertions(+), 85 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 260eed41e504..28998cb02761 100644
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
@@ -153,18 +156,39 @@ static const int ad7768_mclk_div_rates[] = {
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
+/* Decimation Rate range for each filter type */
+static const int ad7768_dec_rate_range[][3] = {
+	[AD7768_FILTER_SINC5] = { 8, 8, 1024 },
+	[AD7768_FILTER_SINC3] = { 32, 32, 163840 },
+	[AD7768_FILTER_WIDEBAND] = { 32, 32, 1024 },
+	[AD7768_FILTER_SINC3_REJ60] = { 32, 32, 163840 },
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
@@ -183,22 +207,6 @@ static const struct iio_scan_type ad7768_scan_type[] = {
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
@@ -208,15 +216,18 @@ struct ad7768_state {
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
 	bool en_spi_sync;
-	const char *labels[ARRAY_SIZE(ad7768_channels)];
+	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -326,11 +337,36 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
 
 static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
 {
-	unsigned int i;
+	unsigned int i, freq_filtered, len = 0;
+
+	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
+	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
+		st->samp_freq_avail[len] = DIV_ROUND_CLOSEST(freq_filtered,
+							     ad7768_mclk_div_rates[i]);
+		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
+		if (st->samp_freq_avail[len] >= 50)
+			len++;
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
 
-	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++)
-		st->samp_freq_avail[i] = DIV_ROUND_CLOSEST(st->mclk_freq,
-							   ad7768_clk_config[i].clk_div);
+	return regmap_update_bits(st->regmap, AD7768_REG_POWER_CLOCK,
+				  AD7768_PWR_MCLK_DIV_MSK | AD7768_PWR_PWRMODE_MSK,
+				  mclk_div_value);
 }
 
 static int ad7768_set_mode(struct ad7768_state *st,
@@ -366,7 +402,7 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
 	 * register provides 24-bit data, the precision is reduced by
 	 * right-shifting the read value by 8 bits.
 	 */
-	if (st->dec_rate == 8)
+	if (st->oversampling_ratio == 8)
 		readval >>= 8;
 
 	/*
@@ -413,22 +449,110 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
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
+	 *  Value = (DEC_RATE / 32) -1
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
 		return ret;
 
-	/* A sync-in pulse is required every time the filter dec rate changes */
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
+		return ret;
+
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
 
@@ -551,45 +675,102 @@ static int ad7768_gpio_init(struct iio_dev *indio_dev)
 static int ad7768_set_freq(struct ad7768_state *st,
 			   unsigned int freq)
 {
-	unsigned int diff_new, diff_old, pwr_mode, i, idx;
+	unsigned int diff_new, diff_old, i, idx;
 	int res, ret;
 
+	freq = clamp(freq, 50, 1024000);
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
@@ -629,6 +810,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = st->samp_freq;
 
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling_ratio;
+
 		return IIO_VAL_INT;
 	}
 
@@ -643,9 +829,13 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
 	struct ad7768_state *st = iio_priv(indio_dev);
 
 	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = (int *)ad7768_dec_rate_range[st->filter_type];
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals = (int *)st->samp_freq_avail;
-		*length = ARRAY_SIZE(ad7768_clk_config);
+		*length = st->samp_freq_avail_len;
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
 	default:
@@ -653,20 +843,44 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
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
@@ -680,7 +894,7 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
 
-	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
+	return st->oversampling_ratio == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
 		AD7768_SCAN_TYPE_NORMAL;
 }
 
@@ -811,6 +1025,14 @@ static int ad7768_setup(struct iio_dev *indio_dev)
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
@@ -1145,7 +1367,6 @@ static int ad7768_probe(struct spi_device *spi)
 		return PTR_ERR(st->mclk);
 
 	st->mclk_freq = clk_get_rate(st->mclk);
-	ad7768_fill_samp_freq_tbl(st);
 
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
-- 
2.34.1


