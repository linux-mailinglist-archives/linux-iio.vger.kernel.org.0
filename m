Return-Path: <linux-iio+bounces-23175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8AB32D7F
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 06:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8529C48514A
	for <lists+linux-iio@lfdr.de>; Sun, 24 Aug 2025 04:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF541F4CB3;
	Sun, 24 Aug 2025 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gAgPqwdi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F261E1DEC;
	Sun, 24 Aug 2025 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756008649; cv=none; b=JIstbqywqP6AGPLtk3AZ4ckAS5uXwVQhdBhC2K/9qg2DABhfkmtsFJl1ID+cyOm0bf8Rls9wGzUGXVXiZFHwhAiDskrgyK9r/g81enLbhnVn4Y9L4xIvSpOSIrZ35aISFjp54pAuLmvlo8M9KH1ZFPnTA11obSq+9Tj0F3ugXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756008649; c=relaxed/simple;
	bh=6+oEB7svFLaBXTbvBGzVK2fTfcu7Srw9/TBF1l9sLFk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snPffUVaD6Swpvfc6ipcaMfbJ1Wce/yIZNDwseTxLP0y4c8HTmILIXQiIQo12Wzk1+I1nQ1x85mgtmFfnc6bsRyGYrFYbLW6A7ush8YbUcFUHJuBwrmm27sMCkV+bIVNs62SiMTWxMZ6RzAiRTDwAsMvK0MtlYTRPcZg0AY/XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gAgPqwdi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57O33PpH007915;
	Sun, 24 Aug 2025 00:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=r6WsX62p2nESGTyNrzAay1721fT
	slyZQeTMLp9dIxWc=; b=gAgPqwdiaNp2hmt2fWVGCZZMnJaVqi6k9IRgY5+pDTZ
	6XbTTySkhY5bj9dbF3IFT/Sj/iQZaOZmyYgMmoJqcqRFD6/AjjHArmLJmeEG2I93
	QFEZywlb/k0DxEzqsEctc0+AsWj9rjgYOBFEWLV9ibTSq3LSen/vbYWGShpK46bG
	KRpx95EzFKoIDWurFMax5ltwNfUZYBNofdkOAgWQC+6e/mi/fgch0fvTO7goaMNy
	MeJSHLSi+iHDSQ6k3JUIsza/qRgjSl8yup6zi69h69+r1ZalwGO7LsOLIG0irf19
	9p1UdMGiFMb5IWrwQMn5eoVvvb1vjaHcEsn89PVa5ZA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48q7g3uhpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Aug 2025 00:10:32 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57O4AVYO043656
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 24 Aug 2025 00:10:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 24 Aug
 2025 00:10:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 24 Aug 2025 00:10:30 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57O4AF4i006365;
	Sun, 24 Aug 2025 00:10:18 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
Date: Sun, 24 Aug 2025 01:10:13 -0300
Message-ID: <20250824041013.9872-1-Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: zunoW6vkZiDNwEe2TbOoOFb-cvu88_k8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA1MSBTYWx0ZWRfXxgX4+74B7s4O
 qXcWdQ44u6NuyLHb1nTueXBcX63WajxK9sMGgQrzPXYrLllyn8czzdYxZKGh5xJhcNMptMsRGli
 7cRAPDxXGKN1947voPlSAZUFR3SuL6UMk8SRETg6GGePwQj1jvsTUAjLeFW0yCQcYprjC24cXqo
 tcQWBEZYW1ArWS2NWrJ6K1Zb5PieyAgp7skZHGdECut816UV+tZ0M/SvFTpmsV5vFjKWQf1yVGq
 hyw/eYKCk2q/m9ULK02HEkkzECqFS36rcQrqCikh2sxTi5yM3fK/JW4QKjLSOovLe6JqpKSvv3o
 tejFofpppsSWUbEdGqIXBOYDB90nVj1fHAoD1NnCaZcv6zwPdYpfSfx9QxpvledPPx/FJZ4Hoee
 TANaHf70
X-Proofpoint-GUID: zunoW6vkZiDNwEe2TbOoOFb-cvu88_k8
X-Authority-Analysis: v=2.4 cv=PNQP+eqC c=1 sm=1 tr=0 ts=68aa90b8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=aQdO_Aj_qnLP7_xn5aYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-23_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230051

Add support for ADAQ7767/68/69-1 series, which includes PGIA and
Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
provide a VCM regulator interface.

The PGA gain is configured in run-time through the scale attribute,
if supported by the device. PGA is enabled and controlled by the GPIO
controller (GPIOs 0, 1 and 2) provided by the device with the SPI
interface.

The AAF gain is defined by hardware connections and should be specified
in device tree.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v2 Changes:
* Added more details to the commit message.
* Some devices does not provide VCM regulator, so a new field in
  the chip info struct was added to indicate this.
* Added 'select RATIONAL' to Kconfig. Kernel test robot pointed out
  compilation error due to undefined reference to 
  rational_best_approximation().
* Added lock to protect PGA value access.
* precision in the PGA calculation is now dependent of the channel sign
  (signed or unsigned).
* went back to the original scale computation: (st->vref_uv * 2) / 2^n
  instead of st->vref_uv / 2^(n-1).
* rewrote AAF gain check and replaced error returns with warnings. I the
  AAF gain is not provided, a default value is used.
* Addressed other minor suggestions.
---
 drivers/iio/adc/Kconfig    |   1 +
 drivers/iio/adc/ad7768-1.c | 288 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 286 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6de2abad0197..7c5fe3954514 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -374,6 +374,7 @@ config AD7768_1
 	depends on SPI
 	select REGULATOR
 	select REGMAP_SPI
+	select RATIONAL
 	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 51562367a9d4..61d93dbfc4c6 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -6,6 +6,7 @@
  */
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -14,8 +15,11 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/limits.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
@@ -98,15 +102,21 @@
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
 
+#define ADAQ776X_GAIN_MAX_NANO		(128 * NANO)
+#define ADAQ776X_MAX_GAIN_MODES		8
+
 #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
 
 #define AD7768_MAX_CHANNELS 1
@@ -153,6 +163,52 @@ enum ad7768_scan_type {
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
@@ -218,6 +274,13 @@ struct ad7768_chip_info {
 	const unsigned long *available_masks;
 	const struct iio_chan_spec *channel_spec;
 	int num_channels;
+	const int *pga_gains;
+	int num_pga_modes;
+	int default_pga_mode;
+	int pgia_mode2pin_offset;
+	bool has_pga;
+	bool has_variable_aaf;
+	bool has_vcm_regulator;
 };
 
 struct ad7768_state {
@@ -235,6 +298,9 @@ struct ad7768_state {
 	unsigned int samp_freq;
 	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
 	unsigned int samp_freq_avail_len;
+	int pga_gain_mode;
+	int aaf_gain;
+	int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
@@ -243,6 +309,7 @@ struct ad7768_state {
 	struct gpio_chip gpiochip;
 	const struct ad7768_chip_info *chip;
 	bool en_spi_sync;
+	struct mutex pga_lock; /* protect PGA value access */
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -465,6 +532,41 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
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
+		rational_best_approximation(numerator, denominator, INT_MAX, INT_MAX,
+					    &numerator, &denominator);
+
+		val = mult_frac(st->vref_uv, denominator, numerator);
+		/* Would multiply by NANO here, but value is already in milli */
+		tmp2 = shift_right((u64)val * MICRO, val2);
+		tmp0 = (int)div_u64_rem(tmp2, NANO, &tmp1);
+		st->scale_tbl[i][0] = tmp0; /* Integer part */
+		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
+	}
+}
+
 static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
 				     unsigned int dec_rate)
 {
@@ -566,12 +668,67 @@ static int ad7768_configure_dig_fil(struct iio_dev *dev,
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
+	u64 gain_nano;
+	int gain_idx;
+	u32 tmp;
+
+	gain_nano = gain_int * NANO + gain_fract;
+	gain_nano = clamp(gain_nano, 0, ADAQ776X_GAIN_MAX_NANO);
+	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
+	gain_nano = DIV_ROUND_CLOSEST(st->vref_uv, tmp);
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
+	guard(mutex)(&st->pga_lock);
+	/* Check GPIO control register */
+	ret = regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &check_val);
+	if (ret < 0)
+		return ret;
+
+	if ((check_val & AD7768_GPIO_PGIA_EN) != AD7768_GPIO_PGIA_EN) {
+		/* Enable PGIA GPIOs and set them as output */
+		ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_PGIA_EN);
+		if (ret)
+			return ret;
+	}
+
+	/* Write the respective gain values to GPIOs 0, 1, 2 */
+	ret = regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
+			   AD7768_GPIO_WRITE(pgia_pins_value));
+	if (ret)
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
@@ -781,6 +938,10 @@ static const struct iio_chan_spec ad7768_channels[] = {
 	AD7768_CHAN(0, 0),
 };
 
+static const struct iio_chan_spec adaq776x_channels[] = {
+	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
+};
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -808,7 +969,18 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
+		if (st->chip->has_pga) {
+			guard(mutex)(&st->pga_lock);
+
+			*val = st->scale_tbl[st->pga_gain_mode][0];
+			*val2 = st->scale_tbl[st->pga_gain_mode][1];
+			return IIO_VAL_INT_PLUS_NANO;
+		}
+
 		*val = (st->vref_uv * 2) / 1000;
+		if (st->chip->has_variable_aaf)
+			*val = (*val * MILLI) / ad7768_aaf_gains[st->aaf_gain];
+
 		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -864,18 +1036,42 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
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
@@ -887,6 +1083,18 @@ static int __ad7768_write_raw(struct iio_dev *indio_dev,
 
 		/* Update sampling frequency */
 		return ad7768_set_freq(st, st->samp_freq);
+	case IIO_CHAN_INFO_SCALE:
+		if (!st->chip->has_pga)
+			return -EOPNOTSUPP;
+
+		if (scan_type->sign == 's')
+			gain_mode = ad7768_calc_pga_gain(st, val, val2,
+							 scan_type->realbits - 1);
+		else
+			gain_mode = ad7768_calc_pga_gain(st, val, val2,
+							 scan_type->realbits);
+
+		return ad7768_set_pga_gain(st, gain_mode);
 	default:
 		return -EINVAL;
 	}
@@ -928,6 +1136,7 @@ static const struct iio_info ad7768_info = {
 	.read_raw = &ad7768_read_raw,
 	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
+	.write_raw_get_fmt = &ad7768_write_raw_get_fmt,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
@@ -1344,12 +1553,47 @@ static const struct ad7768_chip_info ad7768_chip_info = {
 	.channel_spec = ad7768_channels,
 	.num_channels = ARRAY_SIZE(ad7768_channels),
 	.available_masks = ad7768_channel_masks,
+	.has_vcm_regulator = true
+};
+
+static const struct ad7768_chip_info adaq7767_chip_info = {
+	.name = "adaq7767-1",
+	.channel_spec = ad7768_channels,
+	.num_channels = ARRAY_SIZE(ad7768_channels),
+	.available_masks = ad7768_channel_masks,
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
 };
 
 static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
 	struct iio_dev *indio_dev;
+	u32 val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -1409,9 +1653,37 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Register VCM output regulator */
-	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
-	if (ret)
-		return ret;
+	if (st->chip->has_vcm_regulator) {
+		ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	st->aaf_gain = AD7768_AAF_IN1;
+	ret = device_property_read_u32(&spi->dev, "adi,gain-milli", &val);
+	if (ret && st->chip->has_variable_aaf)
+		dev_warn(&spi->dev, "AAF gain not specified, using default\n");
+
+	if (!ret && !st->chip->has_variable_aaf)
+		dev_warn(&spi->dev, "AAF gain not supported for %s\n", st->chip->name);
+
+	if (!ret) {
+		/* If provided, validate and set the gain */
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
+					     "Invalid firmware provided AAF gain\n");
+		}
+	}
 
 	ret = ad7768_setup(indio_dev);
 	if (ret < 0) {
@@ -1420,6 +1692,10 @@ static int ad7768_probe(struct spi_device *spi)
 	}
 
 	init_completion(&st->completion);
+	mutex_init(&st->pga_lock);
+
+	if (st->chip->has_pga)
+		ad7768_set_pga_gain(st, st->chip->default_pga_mode);
 
 	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
@@ -1441,12 +1717,18 @@ static int ad7768_probe(struct spi_device *spi)
 
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


