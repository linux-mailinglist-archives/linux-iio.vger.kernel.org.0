Return-Path: <linux-iio+bounces-26503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABEC8C20E
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 22:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D36C4E76CE
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14D8341ADF;
	Wed, 26 Nov 2025 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EoPUEni/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC6340A4A;
	Wed, 26 Nov 2025 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764194215; cv=none; b=EO3PLT2gPhS/i+LXzTwwVMKmv16WfeFcKPlFViGNKNMdBCSmb9jzh7Y07V4nL82xGbeF0htNnJc5ozKMkvkka2MXCnn1T8i46EN8THwWLRqkHMvE9ZfBCbLMK8jBXbFZzWiDI+5Me16EocPXlMu6xAcBnaLK0G+7b3dq9YpFluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764194215; c=relaxed/simple;
	bh=2t+KqlfvYxSZoakPGhfW5wxtwr+6IUJPbn8JN14JM4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dcqj/pL8TSdpBIe4sNsZXXN6T7JlGbeAKAeXjOWGhX+UnBjh5tkTMJphxttY4Pq1KSFprMocHFfLtLdxAiL+gfYyI52U8efzzTYSSE545DlcAPQC/syHuIJXe9SvIeAR+60CUV81z0iFDwxJHHWgD83EOSiKKoUqrprFr2rMwJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EoPUEni/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQHC4Fa3402606;
	Wed, 26 Nov 2025 16:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y/i1e
	p17e2L97yK3LhRAyMc8k3tL4ZTKda49GY3Irj4=; b=EoPUEni/R7y9SomwW9G/k
	4/yHum8F7mNyCpTFXcqq8yYY6Y6c7rYTtNklkm17c+5AscVo0IJUWR838qCz1lUp
	vRYD4YX20EhV9ww992FfbX+6KvaVjEg6llGsV3MUuHhQqRloMf8hk9j8Q0Y1Ppe1
	hpSZ+qC05OVti2orB8Y4K5crH+YzdzGAYwlGkQNtwnWJ7j1Glwbu6ALilqpM59tT
	wpYwhuDV6fp/0IN3KjwWsguu1J9UGxplQeqg/ippQdriJBYyKLnmPMW8VQEzfcKA
	GkUzJIa4uepqWK4T/zJdrAAs3j9WCR8BHArFy4CXQySvX/xjIgpAAbiwRvbBF/+B
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4anmrux903-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:56:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 5AQLulpU035527
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Nov 2025 16:56:47 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 26 Nov
 2025 16:56:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 26 Nov 2025 16:56:47 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AQLua2p003019;
	Wed, 26 Nov 2025 16:56:38 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt@analog.com>, <jonath4nns@gmail.com>
Subject: [PATCH v4 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
Date: Wed, 26 Nov 2025 18:56:35 -0300
Message-ID: <c3b79acfd171b3625b0e6ed8af4c95cc8409af18.1764101647.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1764101647.git.Jonathan.Santos@analog.com>
References: <cover.1764101647.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDE3OCBTYWx0ZWRfX7sd72xRmjiWU
 k1/iUfsu0Wv0ZiNAGwlQ+idQcvZS7wJTi+6Co/7DbwwkTgBVT981SX2C2hfw3OiwJNvhAlResb1
 lHRogk6E0YOizSFaoDlWV1+Udio32I314Sx0O88pfKUuIUGdjleX0yct4JhH7bV+Y3kYu8JyagX
 rOtOrUtXdUxhDL6S59jZCE68HZ4vwhZwT561XeG+dRmQuwrDuuHnlqefgCbfHZr26mFrqHpWGab
 H4Iv22SUvZgNIdMjuhhc3S89ZLjlJswIQ8yZ8dzfK22vje1JeJIk5Vu0vDHs8XbiAlcBR4530IE
 myTl5oUemvzx/IbZjDT5yeHztQl199X3/qqaO0u6GsRoRAQDiPTHHjghM8IPQ3/qGfCLTSvYFvF
 bXxQCeiWYXlYX2LokoHRiKrrFpkeEQ==
X-Proofpoint-GUID: 9XfTZIktGiHSH2TTUgTdxheJfKK2V8tY
X-Authority-Analysis: v=2.4 cv=Qehrf8bv c=1 sm=1 tr=0 ts=692777a0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=j908aWQ6n9cnJO2kZlgA:9
X-Proofpoint-ORIG-GUID: 9XfTZIktGiHSH2TTUgTdxheJfKK2V8tY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260178

Add support for ADAQ7767/68/69-1 series, which includes PGIA and
Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
provide a VCM regulator interface.

The PGA gain is configured in run-time through the scale attribute,
if supported by the device. PGA is controlled by GPIOs provided in
the device tree.

The AAF gain is defined by hardware connections and should be specified
in the device tree.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v4 Changes:
* replaced shift_right() with '>>' operator in the ad7768_fill_scale_tbl()
  function.
* Refactored ad7768_parse_aaf_gain () as requested.
* renamed ad7768_register_regulators() to ad7768_register_vcm_regulator()
  to better reflect its purpose (not sure if this is ok to do).
* Replaced u64_fract with u32_fract -> after reviewing the numbers again, I
  realized that u32_fract is sufficient for these calculations.
* addressed minor suggestions.
* Adopted a new approach to manage the PGA GPIOs, using pga-gpios property.
  This avoids possible conflicts when the internal gpio controller is used
  externally (and also allows hardwiring, as soon as the gpio interface 
  supports it). However, using GPIOs from the device's own controller causes
  a deadlock when claiming direct mode in the ad7768_gpio_get() function.
  This happens because the direct mode remains locked by the ad7768_write_raw()
  function. I have kept this approach for now to discuss a way around this
  problem. It would be good to have the flexibility provided by pga-gpios 
  property.

v3 Changes:
* Fixed trailing comma issues.
* Addressed other minor issues related to dead code, variable declaration,
  etc.
* removed unnecessary comments and relocating some local variables.
* replaced mutex_init() with devm_mutex_init().
* adopted different variables for the input and output of 
  rational_best_approximation(). Also used a u64_fract for the inputs, but 
  kept the unsigned long for the outputs, because could not create a unsigned
  long fraction number type.
* ad7768_set_pga_gain(): removed the pgia enable check, relying on the
  regmap cache.
* Moved aaf gain parsing to its own function, and now returning after
  warning to avoid setting a variable when it shouldn't (avoid confusion).
* AAF gain is now in basis point units, so related multipliers and dividers
  are adjusted accordingly.

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
 drivers/iio/adc/ad7768-1.c | 322 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 319 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58da8255525e..396f6d45fd6d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -387,6 +387,7 @@ config AD7768_1
 	depends on SPI
 	select REGULATOR
 	select REGMAP_SPI
+	select RATIONAL
 	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 89b0ca8f584c..40fb26ca3804 100644
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
@@ -14,8 +15,12 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/limits.h>
+#include <linux/math.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
@@ -107,10 +112,15 @@
 
 #define AD7768_VCM_OFF			0x07
 
+#define ADAQ776X_GAIN_MAX_NANO		(128 * NANO)
+#define ADAQ776X_MAX_GAIN_MODES		8
+
 #define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
 
 #define AD7768_MAX_CHANNELS 1
 
+#define ADAQ7768_PGA_PINS 3
+
 enum ad7768_conv_mode {
 	AD7768_CONTINUOUS,
 	AD7768_ONE_SHOT,
@@ -153,6 +163,51 @@ enum ad7768_scan_type {
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
+};
+
+enum {
+	AD7768_AAF_IN1,
+	AD7768_AAF_IN2,
+	AD7768_AAF_IN3,
+};
+
+/* PGA and AAF gains in V/V */
+static const int adaq7768_gains[] = {
+	[AD7768_PGA_GAIN_0] = 325,	/* 0.325 */
+	[AD7768_PGA_GAIN_1] = 650,	/* 0.650 */
+	[AD7768_PGA_GAIN_2] = 1300,	/* 1.300 */
+	[AD7768_PGA_GAIN_3] = 2600,	/* 2.600 */
+	[AD7768_PGA_GAIN_4] = 5200,	/* 5.200 */
+	[AD7768_PGA_GAIN_5] = 10400,	/* 10.400 */
+	[AD7768_PGA_GAIN_6] = 20800,	/* 20.800 */
+};
+
+static const int adaq7769_gains[] = {
+	[AD7768_PGA_GAIN_0] = 1000,	/* 1.000 */
+	[AD7768_PGA_GAIN_1] = 2000,	/* 2.000 */
+	[AD7768_PGA_GAIN_2] = 4000,	/* 4.000 */
+	[AD7768_PGA_GAIN_3] = 8000,	/* 8.000 */
+	[AD7768_PGA_GAIN_4] = 16000,	/* 16.000 */
+	[AD7768_PGA_GAIN_5] = 32000,	/* 32.000 */
+	[AD7768_PGA_GAIN_6] = 64000,	/* 64.000 */
+	[AD7768_PGA_GAIN_7] = 128000,	/* 128.000 */
+};
+
+static const int ad7768_aaf_gains_bp[] = {
+	[AD7768_AAF_IN1] = 10000,	/* 1.000 */
+	[AD7768_AAF_IN2] = 3640,	/* 0.364 */
+	[AD7768_AAF_IN3] = 1430,	/* 0.143 */
+};
+
 /* -3dB cutoff frequency multipliers (relative to ODR) for each filter type. */
 static const int ad7768_filter_3db_odr_multiplier[] = {
 	[AD7768_FILTER_SINC5] = 204,		/* 0.204 */
@@ -217,6 +272,13 @@ struct ad7768_chip_info {
 	const char *name;
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
@@ -234,14 +296,19 @@ struct ad7768_state {
 	unsigned int samp_freq;
 	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
 	unsigned int samp_freq_avail_len;
+	unsigned int pga_gain_mode;
+	unsigned int aaf_gain;
+	int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];
 	struct completion completion;
 	struct iio_trigger *trig;
+	struct gpio_descs *pga_gpios;
 	struct gpio_desc *gpio_sync_in;
 	struct gpio_desc *gpio_reset;
 	const char *labels[AD7768_MAX_CHANNELS];
 	struct gpio_chip gpiochip;
 	const struct ad7768_chip_info *chip;
 	bool en_spi_sync;
+	struct mutex pga_lock; /* protect device internal state (PGA) */
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -464,6 +531,42 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static void ad7768_fill_scale_tbl(struct iio_dev *dev)
+{
+	struct ad7768_state *st = iio_priv(dev);
+	const struct iio_scan_type *scan_type;
+	int val, val2, tmp0, tmp1, i;
+	struct u32_fract fract;
+	unsigned long n, d;
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
+		fract.numerator = st->chip->pga_gains[i];
+		fract.denominator = MILLI;
+		if (st->chip->has_variable_aaf) {
+			fract.numerator *= ad7768_aaf_gains_bp[st->aaf_gain];
+			fract.denominator *= BASIS_POINTS;
+		}
+
+		rational_best_approximation(fract.numerator, fract.denominator,
+					    INT_MAX, INT_MAX, &n, &d);
+
+		val = mult_frac(st->vref_uv, d, n);
+		/* Would multiply by NANO here, but value is already in milli */
+		tmp2 = ((u64)val * MICRO) >> val2;
+		tmp0 = div_u64_rem(tmp2, NANO, &tmp1);
+		st->scale_tbl[i][0] = tmp0; /* Integer part */
+		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
+	}
+}
+
 static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
 				     unsigned int dec_rate)
 {
@@ -565,12 +668,72 @@ static int ad7768_configure_dig_fil(struct iio_dev *dev,
 		st->oversampling_ratio = ad7768_dec_rate_values[dec_rate_idx];
 	}
 
+	/* Update scale table: scale values vary according to the precision */
+	ad7768_fill_scale_tbl(dev);
+
 	ad7768_fill_samp_freq_tbl(st);
 
 	/* A sync-in pulse is required after every configuration change */
 	return ad7768_send_sync_pulse(st);
 }
 
+/*
+ * FIXME: Using GPIOs from the device's own controller causes the device
+ * to get stuck when claiming direct mode in the ad7768_gpio_get() function.
+ * This happens because the direct mode remains locked by the
+ * ad7768_write_raw() function.
+ */
+static int ad7768_setup_pga(struct device *dev, struct ad7768_state *st)
+{
+	st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
+	if (IS_ERR(st->pga_gpios))
+		return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
+				     "Failed to get PGA gpios.\n");
+
+	if (st->pga_gpios->ndescs != ADAQ7768_PGA_PINS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Expected %d GPIOs for PGA control.\n",
+				     ADAQ7768_PGA_PINS);
+	return 0;
+}
+
+static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
+				int gain_fract, int precision)
+{
+	u64 gain_nano;
+	u32 tmp;
+
+	gain_nano = gain_int * NANO + gain_fract;
+	gain_nano = clamp(gain_nano, 0, ADAQ776X_GAIN_MAX_NANO);
+	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
+	gain_nano = DIV_ROUND_CLOSEST(st->vref_uv, tmp);
+	if (st->chip->has_variable_aaf)
+		gain_nano = DIV_ROUND_CLOSEST_ULL(gain_nano * BASIS_POINTS,
+						  ad7768_aaf_gains_bp[st->aaf_gain]);
+
+	return find_closest(gain_nano, st->chip->pga_gains,
+			    (int)st->chip->num_pga_modes);
+}
+
+static int ad7768_set_pga_gain(struct ad7768_state *st,
+			       int gain_mode)
+{
+	int pgia_pins_value = abs(gain_mode - st->chip->pgia_mode2pin_offset);
+	DECLARE_BITMAP(bitmap, ADAQ7768_PGA_PINS) = { };
+	int ret;
+
+	guard(mutex)(&st->pga_lock);
+
+	bitmap_write(bitmap, pgia_pins_value, 0, ADAQ7768_PGA_PINS);
+	ret = gpiod_multi_set_value_cansleep(st->pga_gpios, bitmap);
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
@@ -779,6 +942,10 @@ static const struct iio_chan_spec ad7768_channels[] = {
 	AD7768_CHAN(0, 0),
 };
 
+static const struct iio_chan_spec adaq776x_channels[] = {
+	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
+};
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -806,7 +973,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = (st->vref_uv * 2) / 1000;
+		if (st->chip->has_pga) {
+			guard(mutex)(&st->pga_lock);
+
+			*val = st->scale_tbl[st->pga_gain_mode][0];
+			*val2 = st->scale_tbl[st->pga_gain_mode][1];
+			return IIO_VAL_INT_PLUS_NANO;
+		}
+
+		temp = (st->vref_uv * 2) / 1000;
+		if (st->chip->has_variable_aaf)
+			temp = (temp * BASIS_POINTS) / ad7768_aaf_gains_bp[st->aaf_gain];
+
+		*val = temp;
 		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -862,18 +1041,39 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
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
+}
+
 static int __ad7768_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int val, int val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	int ret;
 
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad7768_set_freq(st, val);
@@ -885,6 +1085,21 @@ static int __ad7768_write_raw(struct iio_dev *indio_dev,
 
 		/* Update sampling frequency */
 		return ad7768_set_freq(st, st->samp_freq);
+	case IIO_CHAN_INFO_SCALE: {
+		int gain_mode;
+
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
+	}
 	default:
 		return -EINVAL;
 	}
@@ -926,6 +1141,7 @@ static const struct iio_info ad7768_info = {
 	.read_raw = &ad7768_read_raw,
 	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
+	.write_raw_get_fmt = &ad7768_write_raw_get_fmt,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
@@ -1309,8 +1525,9 @@ static const struct regulator_desc vcm_desc = {
 	.owner = THIS_MODULE,
 };
 
-static int ad7768_register_regulators(struct device *dev, struct ad7768_state *st,
-				      struct iio_dev *indio_dev)
+static int ad7768_register_vcm_regulator(struct device *dev,
+					 struct ad7768_state *st,
+					 struct iio_dev *indio_dev)
 {
 	struct regulator_config config = {
 		.dev = dev,
@@ -1332,10 +1549,82 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
 	return 0;
 }
 
+static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
+{
+	bool aaf_gain_provided;
+	u32 val;
+	int ret;
+
+	ret = device_property_read_u32(dev, "adi,aaf-gain-bp", &val);
+	if (ret == -EINVAL)
+		aaf_gain_provided = false;
+	else if (ret)
+		return dev_err_probe(dev, ret, "Failed to get AAF gain value\n");
+	else
+		aaf_gain_provided = true;
+
+	if (!aaf_gain_provided) {
+		if (st->chip->has_variable_aaf)
+			st->aaf_gain = AD7768_AAF_IN1;
+		return 0;
+	}
+
+	if (aaf_gain_provided && !st->chip->has_variable_aaf)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "AAF gain not supported for %s\n", st->chip->name);
+
+	switch (val) {
+	case 10000:
+		st->aaf_gain = AD7768_AAF_IN1;
+		break;
+	case 3640:
+		st->aaf_gain = AD7768_AAF_IN2;
+		break;
+	case 1430:
+		st->aaf_gain = AD7768_AAF_IN3;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Invalid firmware provided AAF gain\n");
+	}
+
+	return 0;
+}
+
 static const struct ad7768_chip_info ad7768_chip_info = {
 	.name = "ad7768-1",
 	.channel_spec = ad7768_channels,
 	.num_channels = ARRAY_SIZE(ad7768_channels),
+	.has_vcm_regulator = true,
+};
+
+static const struct ad7768_chip_info adaq7767_chip_info = {
+	.name = "adaq7767-1",
+	.channel_spec = ad7768_channels,
+	.num_channels = ARRAY_SIZE(ad7768_channels),
+	.has_variable_aaf = true,
+};
+
+static const struct ad7768_chip_info adaq7768_chip_info = {
+	.name = "adaq7768-1",
+	.channel_spec = adaq776x_channels,
+	.num_channels = ARRAY_SIZE(adaq776x_channels),
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
+	.pga_gains = adaq7769_gains,
+	.default_pga_mode = AD7768_PGA_GAIN_0,
+	.num_pga_modes = ARRAY_SIZE(adaq7769_gains),
+	.pgia_mode2pin_offset = 0,
+	.has_pga = true,
+	.has_variable_aaf = true,
 };
 
 static int ad7768_probe(struct spi_device *spi)
@@ -1396,7 +1685,13 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Register VCM output regulator */
-	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
+	if (st->chip->has_vcm_regulator) {
+		ret = ad7768_register_vcm_regulator(&spi->dev, st, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad7768_parse_aaf_gain(&spi->dev, st);
 	if (ret)
 		return ret;
 
@@ -1407,6 +1702,19 @@ static int ad7768_probe(struct spi_device *spi)
 	}
 
 	init_completion(&st->completion);
+	ret = devm_mutex_init(&spi->dev, &st->pga_lock);
+	if (ret)
+		return ret;
+
+	if (st->chip->has_pga) {
+		ret = ad7768_setup_pga(&spi->dev, st);
+		if (ret)
+			return ret;
+
+		ret = ad7768_set_pga_gain(st, st->chip->default_pga_mode);
+		if (ret)
+			return ret;
+	}
 
 	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
@@ -1428,12 +1736,18 @@ static int ad7768_probe(struct spi_device *spi)
 
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


