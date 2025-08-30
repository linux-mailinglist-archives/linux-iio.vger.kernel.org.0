Return-Path: <linux-iio+bounces-23412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD11EB3C68D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB22561323
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9771DC994;
	Sat, 30 Aug 2025 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ir9lYXra"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3DD26281;
	Sat, 30 Aug 2025 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514597; cv=none; b=KVHJXA6+ajSTACKktZAf8NlD3FIrLetQ8vIIrYyn4FtBHVo/XfTuql9wFfLbDVeyU23YiG4lQG+Jxh0VCXbC8GOI0ACp6V2JP6DzfuOn2MxmIuIEHRxjASEaOsvphkRzSI34a65IalZvpvuvAYxmKXM+6wkHGXsP3dD7Lc3TOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514597; c=relaxed/simple;
	bh=69QVv/Grwcj2rwaVte9wexWRjakJa5z/n5SXDXZ5KI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivF/Vb3DzFpTf2ZiPckWnYzGlUd5655E5se8pT1PEofxAnXKb2VZvXWubFjwVkIcQ3W5yPy6sMWiXWLloeOWjHp6w4R/I6qZItHFA9N0gxLPsyZb21JWalfuMNVr3Po/Tw15QmiYgmfGOYdZzZRkl3CjW6GR1//FE92Y6eX/kyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ir9lYXra; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TJR4Sc013221;
	Fri, 29 Aug 2025 20:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8jlvE
	XFDgHfR551rHAd8ihA9px49kQ+hz7BoJVLS0c8=; b=Ir9lYXranQPD2Av2Z4+gU
	w/7souh3yQFQpKHqt79DMc6/MNL5Sn+xf9sybeW6TMZex/2OA20k+Xlyt5HtdCuq
	ph6tDUBZM1kdP/1fET5+CJQkrnh1wrwyr0jAlFo9vVPFWhjIwHWMe/4HsrnSoTor
	c59QxPzmaXRf9mY018+xAvG7jhpcARlmBbxusiroEaypNmWr4IYHql2yhz1h5GEj
	IcuAGgIT2KNOHngX2aZgKjkn/C5eNKtIkq86P5T/X+XW3X9zag6Ys+Unfl9SgVYF
	6jb8qXs2B6TGpu50GiFpbpKGW6qQpZQKVNC5KcHNiihEFwQMSFMLUG5ynwLa3/SX
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966utju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:43:09 -0400 (EDT)
Received: from m0375855.ppops.net (m0375855.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0h9sw030038;
	Fri, 29 Aug 2025 20:43:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 48u966utjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:43:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0h8tK018861
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:43:08 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:43:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:43:08 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0godH004976;
	Fri, 29 Aug 2025 20:42:53 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <sergiu.cuciurean@analog.com>,
        <tgamblin@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH 07/15] iio: adc: ad4030: Add SPI offload support
Date: Fri, 29 Aug 2025 21:42:50 -0300
Message-ID: <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: CpYj5v1e_X79bGSW4_TZo0G06Rgy-SZ0
X-Proofpoint-ORIG-GUID: O97mH2lkCqi72aoqyoV5TE2ncaU_kCuq
X-Authority-Analysis: v=2.4 cv=J6Wq7BnS c=1 sm=1 tr=0 ts=68b2491d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=IvjRRIT8uyO-NJnUH0kA:9
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDA3NCBTYWx0ZWRfX34QhA3PkuPbq
 Emr/oOViNoPnPSFHVjVQOYrVis/IKEfesHRFgIj4syIBMi10bUSwDFs4nvXfWGel/+02b4tvG6n
 nFiE71NPBzxVVb3lv9mi8j6jYjYOJa0UdCfL+UvuhXfMucILgDAH2mP/U13mbD6AnFEsioeiSEe
 Yn0xhsJZoaLyXNuDOzZTKFQ1DLhx6hScXJyG5uDbg4H/2DySd7/skNlcQVAcmU9FlYZWVBU0Xe9
 FSWgryEFEazyKGqkquHFr0FOoVnfGpCOLScO6/9Sx/3yPf1HexZHBJz3eIDbzv5Y9Zb8JixIr2u
 hLSWkjw98y2+sBJHVbzRsNKpG8I7UW2Dn1OatndZkMvIbxyOFK63sttk9ISSPDrUD4Wlgn8FREn
 yybj9l4Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508290074

AD4030 and similar ADCs can capture data at sample rates up to 2 mega
samples per second (MSPS). Not all SPI controllers are able to achieve
such high throughputs and even when the controller is fast enough to run
transfers at the required speed, it may be costly to the CPU to handle
transfer data at such high sample rates.  Add SPI offload support for
AD4030 and similar ADCs so to enable ADC data capture at maximum sample
rates.

Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Axel Haslam <ahaslam@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>
Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Most of the code in this patch is based on work from Sergiu Cuciurean, Nuno Sa,
Axel Haslam, and Trevor Gamblin, hence the many co-developed-by tags. I also
draw inspiration from other drivers supporting SPI offload, many of them written
by David Lechner.

 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4030.c | 400 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 378 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6de2abad0197..7cfbc07e7f77 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -49,6 +49,8 @@ config AD4030
 	depends on GPIOLIB
 	select REGMAP
 	select IIO_BUFFER
+	select IIO_BUFFER_DMA
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 82784593f976..68f76432dbfd 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -15,11 +15,15 @@
 
 #include <linux/bitfield.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
@@ -111,6 +115,8 @@
 #define AD4632_TCYC_NS			2000
 #define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
 #define AD4030_TRESET_COM_DELAY_MS	750
+/* Datasheet says 9.8ns, so use the closest integer value */
+#define AD4030_TQUIET_CNV_DELAY_NS	10
 
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
@@ -120,7 +126,7 @@ enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_32_PATTERN,
 };
 
-enum {
+enum ad4030_lane_mode {
 	AD4030_LANE_MD_1_PER_CH,
 	AD4030_LANE_MD_2_PER_CH,
 	AD4030_LANE_MD_4_PER_CH,
@@ -130,17 +136,21 @@ enum {
 enum {
 	AD4030_SCAN_TYPE_NORMAL,
 	AD4030_SCAN_TYPE_AVG,
+	AD4030_OFFLOAD_SCAN_TYPE_NORMAL,
+	AD4030_OFFLOAD_SCAN_TYPE_AVG,
 };
 
 struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
 	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
+	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
 	u8 grade;
 	u8 precision_bits;
 	/* Number of hardware channels */
 	int num_voltage_inputs;
 	unsigned int tcyc_ns;
+	unsigned int max_sample_rate_hz;
 };
 
 struct ad4030_state {
@@ -148,11 +158,20 @@ struct ad4030_state {
 	struct regmap *regmap;
 	const struct ad4030_chip_info *chip;
 	struct gpio_desc *cnv_gpio;
+	struct pwm_device *conv_trigger;
+	struct pwm_waveform conv_wf;
 	int vref_uv;
 	int vio_uv;
 	int offset_avail[3];
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
+	enum ad4030_lane_mode lane_mode;
+	/* offload sampling spi message */
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_offload_trigger_config offload_trigger_config;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -209,12 +228,13 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
+#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
 	.info_mask_shared_by_all =					\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_shared_by_all_available =				\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |		\
+		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\
 		BIT(IIO_CHAN_INFO_CALIBSCALE) |				\
 		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
 		BIT(IIO_CHAN_INFO_RAW),					\
@@ -232,12 +252,23 @@ struct ad4030_state {
 	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+#define AD4030_CHAN_DIFF(_idx, _scan_type)				\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
+
+#define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
+
 static const int ad4030_average_modes[] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
 	65536,
 };
 
+static const struct spi_offload_config ad4030_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 static int ad4030_enter_config_mode(struct ad4030_state *st)
 {
 	st->tx_data[0] = AD4030_REG_ACCESS;
@@ -385,7 +416,7 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	struct ad4030_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
 
-	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
@@ -458,6 +489,96 @@ static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
 	}
 }
 
+static void ad4030_get_sampling_freq(const struct ad4030_state *st, int *freq)
+{
+	*freq = DIV_ROUND_CLOSEST_ULL(NANO, st->conv_wf.period_length_ns);
+}
+
+static int __ad4030_set_sampling_freq(struct ad4030_state *st, unsigned int freq)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+	struct pwm_waveform conv_wf = { };
+	u64 offload_period_ns;
+	u64 offload_offset_ns;
+	u32 mode;
+	int ret;
+	u64 target = AD4030_TCNVH_NS;
+
+	conv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
+	/*
+	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
+	 * rounded PWM's value is less than 10, increase the target value by 10
+	 * and attempt to round the waveform again, until the value is at least
+	 * 10 ns. Use a separate variable to represent the target in case the
+	 * rounding is severe enough to keep putting the first few results under
+	 * the minimum 10ns condition checked by the while loop.
+	 */
+	do {
+		conv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->conv_trigger, &conv_wf);
+		if (ret)
+			return ret;
+		target += 10;
+	} while (conv_wf.duty_length_ns < 10);
+
+	offload_period_ns = conv_wf.period_length_ns;
+
+	ret = regmap_read(st->regmap, AD4030_REG_MODES, &mode);
+	if (ret)
+		return ret;
+	if (FIELD_GET(AD4030_REG_MODES_MASK_OUT_DATA_MODE, mode) == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {
+		u32 avg;
+
+		ret = regmap_read(st->regmap, AD4030_REG_AVG, &avg);
+		if (ret)
+			return ret;
+
+		offload_period_ns <<= FIELD_GET(AD4030_REG_AVG_MASK_AVG_VAL, avg);
+	}
+
+	config->periodic.frequency_hz =  DIV_ROUND_UP_ULL(NSEC_PER_SEC,
+							  offload_period_ns);
+
+	/*
+	 * The hardware does the capture on zone 2 (when spi trigger PWM
+	 * is used). This means that the spi trigger signal should happen at
+	 * tsync + tquiet_con_delay being tsync the conversion signal period
+	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
+	 *
+	 * The PWM waveform API only supports nanosecond resolution right now,
+	 * so round this setting to the closest available value.
+	 */
+	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
+	do {
+		config->periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, config);
+		if (ret)
+			return ret;
+		offload_offset_ns += 10;
+
+	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
+
+	st->conv_wf = conv_wf;
+
+	return 0;
+}
+
+static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (PTR_ERR_OR_ZERO(st->offload))
+		return -EINVAL;
+
+	if (!freq || freq > st->chip->max_sample_rate_hz)
+		return -EINVAL;
+
+	ret = __ad4030_set_sampling_freq(st, freq);
+	iio_device_release_direct(indio_dev);
+
+	return ret;
+}
 static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan,
 				      int gain_int,
@@ -618,7 +739,7 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
 	unsigned int i;
 	int ret;
 
-	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
@@ -774,6 +895,13 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
 		*val = BIT(st->avg_log2);
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (PTR_ERR_OR_ZERO(st->offload))
+			return -EINVAL;
+
+		ad4030_get_sampling_freq(st, val);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -814,6 +942,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		return ad4030_set_avg_frame_len(indio_dev, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4030_set_sampling_freq(indio_dev, val);
+
 	default:
 		return -EINVAL;
 	}
@@ -868,7 +999,11 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
 
-	return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
+	if (PTR_ERR_OR_ZERO(st->offload))
+		return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
+	else
+		return st->avg_log2 ? AD4030_OFFLOAD_SCAN_TYPE_AVG :
+				      AD4030_OFFLOAD_SCAN_TYPE_NORMAL;
 }
 
 static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
@@ -903,6 +1038,67 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
+static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));
+	if (ret)
+		return ret;
+
+	st->offload_msg.offload = st->offload;
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret < 0)
+		goto out_reset_mode;
+
+	ret = pwm_set_waveform_might_sleep(st->conv_trigger, &st->conv_wf, false);
+	if (ret)
+		goto out_unoptimize;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_pwm_disable;
+	return 0;
+out_pwm_disable:
+	pwm_disable(st->conv_trigger);
+out_unoptimize:
+	spi_unoptimize_message(&st->offload_msg);
+out_reset_mode:
+	/* reenter register configuration mode */
+	ret = ad4030_enter_config_mode(st);
+	if (ret)
+		dev_warn(&st->spi->dev,
+			 "couldn't reenter register configuration mode\n");
+	return ret;
+}
+
+static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	pwm_disable(st->conv_trigger);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	spi_unoptimize_message(&st->offload_msg);
+
+	/* reenter register configuration mode */
+	ret = ad4030_enter_config_mode(st);
+	if (ret)
+		dev_warn(&st->spi->dev,
+			 "couldn't reenter register configuration mode\n");
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
+	.postenable = &ad4030_offload_buffer_postenable,
+	.predisable = &ad4030_offload_buffer_predisable,
+};
+
 static int ad4030_regulators_get(struct ad4030_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -972,6 +1168,44 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_pwm_get(struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->conv_trigger = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->conv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
+				     "Failed to get cnv pwm\n");
+
+	/*
+	 * Preemptively disable the PWM, since we only want to enable it with
+	 * the buffer
+	 */
+	pwm_disable(st->conv_trigger);
+
+	return 0;
+}
+
+static void ad4030_prepare_offload_msg(struct ad4030_state *st)
+{
+	u8 data_width = st->chip->precision_bits;
+	u8 offload_bpw;
+
+	if (st->lane_mode == AD4030_LANE_MD_INTERLEAVED)
+		/*
+		 * This means all channels on 1 lane.
+		 */
+		offload_bpw = data_width * st->chip->num_voltage_inputs;
+	else
+		offload_bpw  = data_width;
+
+	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;
+	st->offload_xfer.bits_per_word = offload_bpw;
+	st->offload_xfer.len = roundup_pow_of_two(BITS_TO_BYTES(offload_bpw));
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+}
+
 static int ad4030_config(struct ad4030_state *st)
 {
 	int ret;
@@ -982,11 +1216,11 @@ static int ad4030_config(struct ad4030_state *st)
 	st->offset_avail[2] = BIT(st->chip->precision_bits - 1) - 1;
 
 	if (st->chip->num_voltage_inputs > 1)
-		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
-				       AD4030_LANE_MD_INTERLEAVED);
+		st->lane_mode = AD4030_LANE_MD_INTERLEAVED;
 	else
-		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
-				       AD4030_LANE_MD_1_PER_CH);
+		st->lane_mode = AD4030_LANE_MD_1_PER_CH;
+
+	reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE, st->lane_mode);
 
 	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
 	if (ret)
@@ -999,6 +1233,31 @@ static int ad4030_config(struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
+				    struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+
+	indio_dev->setup_ops = &ad4030_offload_buffer_setup_ops;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
 static int ad4030_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1050,24 +1309,55 @@ static int ad4030_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
 				     "Failed to get cnv gpio\n");
 
-	/*
-	 * One hardware channel is split in two software channels when using
-	 * common byte mode. Add one more channel for the timestamp.
-	 */
-	indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
 	indio_dev->name = st->chip->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad4030_iio_info;
-	indio_dev->channels = st->chip->channels;
-	indio_dev->available_scan_masks = st->chip->available_masks;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4030_trigger_handler,
-					      &ad4030_buffer_setup_ops);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to setup triggered buffer\n");
+	st->offload = devm_spi_offload_get(dev, spi, &ad4030_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+
+	/* Fall back to low speed usage when no SPI offload available. */
+	if (ret == -ENODEV) {
+		/*
+		 * One hardware channel is split in two software channels when
+		 * using common byte mode. Add one more channel for the timestamp.
+		 */
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
+		indio_dev->channels = st->chip->channels;
+		indio_dev->available_scan_masks = st->chip->available_masks;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad4030_trigger_handler,
+						      &ad4030_buffer_setup_ops);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup triggered buffer\n");
+
+	} else {
+		/*
+		 * One hardware channel is split in two software channels when
+		 * using common byte mode. Offloaded SPI transfers can't support
+		 * software timestamp so no additional timestamp channel is added.
+		 */
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
+		indio_dev->channels = st->chip->offload_channels;
+		indio_dev->available_scan_masks = st->chip->available_masks;
+		ret = ad4030_spi_offload_setup(indio_dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup SPI offload\n");
+
+		ret = ad4030_pwm_get(st);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get PWM: %d\n", ret);
+
+		ret = __ad4030_set_sampling_freq(st, st->chip->max_sample_rate_hz);
+		ad4030_prepare_offload_msg(st);
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
@@ -1103,6 +1393,20 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
 		.shift = 2,
 		.endianness = IIO_BE,
 	},
+	[AD4030_OFFLOAD_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 24,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_OFFLOAD_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
 };
 
 static const struct iio_scan_type ad4030_16_scan_types[] = {
@@ -1119,7 +1423,21 @@ static const struct iio_scan_type ad4030_16_scan_types[] = {
 		.realbits = 30,
 		.shift = 2,
 		.endianness = IIO_BE,
-	}
+	},
+	[AD4030_OFFLOAD_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 16,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_OFFLOAD_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
 };
 
 static const struct ad4030_chip_info ad4030_24_chip_info = {
@@ -1130,10 +1448,15 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 		AD4030_CHAN_CMO(1, 0),
 		IIO_CHAN_SOFT_TIMESTAMP(2),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 1,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4030_chip_info ad4630_16_chip_info = {
@@ -1146,10 +1469,17 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4030_chip_info ad4630_24_chip_info = {
@@ -1162,10 +1492,17 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4030_chip_info ad4632_16_chip_info = {
@@ -1178,10 +1515,17 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * KILO,
 };
 
 static const struct ad4030_chip_info ad4632_24_chip_info = {
@@ -1194,10 +1538,17 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * KILO,
 };
 
 static const struct spi_device_id ad4030_id_table[] = {
@@ -1233,3 +1584,4 @@ module_spi_driver(ad4030_driver);
 MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.39.2


