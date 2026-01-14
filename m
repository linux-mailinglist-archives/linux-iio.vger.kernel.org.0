Return-Path: <linux-iio+bounces-27780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD7D1EEAF
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AA30305EF8D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083CE397ADB;
	Wed, 14 Jan 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="U5iqCfhO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134AD397AB0;
	Wed, 14 Jan 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394891; cv=none; b=Noev737cNrlqCBN9yQTNAoZUmHEfYSvkARhGNE2fasVbbnJTVErs05UbzYJKmiOVeMyngvKjntL5OUtJkX8y4tpfqBqEZweazkkBeW5F6IYgJez2z+Ou4afOPL/khFLJ7k3VrgtnjujKEcA+p8cFfzBH0hORD/zDKDIJzsKKxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394891; c=relaxed/simple;
	bh=2WkxNpDn1vZbwmh9nJ7gZ7poSADRrQ2NKNtchf0sVW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ss7/BY2u7qTXcAiMfgK0/W3o+5aVNHxnKQ2fXwiklY6h6bHyq0XrGmm2C4WUL8iNLS9FddWVU0D3FlU7YRmvtv1+ZNSDD+s6ERqo+Pz/AWEa9Pmas1WUcN7fU5UT3ZE0sPB3/e5Z6LifYK2d+jPFzeG+umLYLjQQWrUgDWpE6I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=U5iqCfhO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EC4i6V3765687;
	Wed, 14 Jan 2026 07:47:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bZmFk
	r8xxYxE/pWn/umV3IQU4FChqsl/TJL5v2dP19s=; b=U5iqCfhOXURNcteMp/7cs
	hiuVqCAy/mEYFaonYTN82hIHusT19bBL0UxgQBsuMJiSvxBa8ARx16NIQR7fFWeq
	3++zap8SwAMXtPQI9wR3vvEaO/sLcWh+pqTRjiPF94sxuqiEENoj2CuZoaLXs8sv
	ISqPmbZ+CAL4fFVS8QDkUJq/a88tplxYzaJ/YGWTBR2uveIT+lUv29NXtPPWZvyb
	9p5wN6s/TPt/Ilng8jQkjds86MQp1D/WPhlbiYiCujyPQZkeMt4ZZdw/eIe+8RT2
	mX7JkVBEwvl1Fp3Jp7iyenfHoE3d5HWMGVhlL5aBFKcUR2v893uwcmaWWo//dHEL
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bpau08gve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 07:47:53 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60EClqp9061511
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Jan 2026 07:47:52 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:47:52 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 14 Jan 2026 07:47:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Jan 2026 07:47:52 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60EClcnl001748;
	Wed, 14 Jan 2026 07:47:40 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <jonath4nns@gmail.com>
Subject: [PATCH v6 5/5] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
Date: Wed, 14 Jan 2026 06:27:29 -0300
Message-ID: <fd9acf8fca67679a33441ea18d1d06b2aa2c5fad.1768350772.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1768350772.git.Jonathan.Santos@analog.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEwNiBTYWx0ZWRfX7BFwnMfkgx9d
 x8SpT/5mdWudB0cSDSArNQFPdO3mjpvx3e6yKNRxXUEVtJm5oCWDQFsCWcHdttYi9dLcaih7Md0
 wsGnqh9xPJsX1yoByfP78I8K+SRXtSMgEWQ3wY2gY4Ra5dz3EC7xarZqYqsfMXS3m1pszLLRERs
 Ixl1BsUN6owhwMDvuskXVo5swDHj8YiiyGtnKdSd1IW5MkNSRofq0hldxyEIrNGhy9hOPvI3R/J
 IQYzzhPYptdO8a0qwRDOd56/+cuHZJ4YDVW+uhm8rhfXbrD6t0isx6LUN0u9Jb7SRNCpF5Y2pLG
 CcQfhAYqaDU5rFtWwaDYIfogfP39Ss7hQmE9syR5NxpIY4cfh7YXS0N/H0sobZ/1srm080dqCdr
 WIAJSQK8ZPlmr3yYsey0NGlHWL7v4ij17rRY+8DPhJwe7XFwra5+nRD58603QvOJcIZDW9A/WCC
 DQ6/gtGroNvZVWb0epA==
X-Authority-Analysis: v=2.4 cv=YcWwJgRf c=1 sm=1 tr=0 ts=6967907a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=OY_cmHL8cwcxf5wYxqQA:9
X-Proofpoint-ORIG-GUID: VXbU4SweE-iJquaFw_50DeJbJgkg53Tk
X-Proofpoint-GUID: VXbU4SweE-iJquaFw_50DeJbJgkg53Tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140106

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
v6 Changes:
* Refactored ad7768_parse_aaf_gain() to improve cleanliness and readability.

v5 Changes:
* Write scale attribute without direct mode claim to avoid deadlock
  when using GPIOs from the device's own controller.

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
 drivers/iio/adc/ad7768-1.c | 311 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 308 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b4295aa415bf..60038ae8dfc4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -411,6 +411,7 @@ config AD7768_1
 	depends on SPI
 	select REGULATOR
 	select REGMAP_SPI
+	select RATIONAL
 	select IIO_BUFFER
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index bd4b2e090c5b..980c079ab41a 100644
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
+			fract.denominator *= PERMYRIAD;
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
@@ -565,12 +668,66 @@ static int ad7768_configure_dig_fil(struct iio_dev *dev,
 		st->oversampling_ratio = ad7768_dec_rate_values[dec_rate_idx];
 	}
 
+	/* Update scale table: scale values vary according to the precision */
+	ad7768_fill_scale_tbl(dev);
+
 	ad7768_fill_samp_freq_tbl(st);
 
 	/* A sync-in pulse is required after every configuration change */
 	return ad7768_send_sync_pulse(st);
 }
 
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
+		gain_nano = DIV_ROUND_CLOSEST_ULL(gain_nano * PERMYRIAD,
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
@@ -792,6 +949,10 @@ static const struct iio_chan_spec ad7768_channels[] = {
 	AD7768_CHAN(0, 0),
 };
 
+static const struct iio_chan_spec adaq776x_channels[] = {
+	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
+};
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -819,7 +980,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
+			temp = (temp * PERMYRIAD) / ad7768_aaf_gains_bp[st->aaf_gain];
+
+		*val = temp;
 		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -875,18 +1048,39 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
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
 static int ad7768_write_raw(struct iio_dev *indio_dev,
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
 		if (!iio_device_claim_direct(indio_dev))
@@ -902,6 +1096,21 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 		ret = ad7768_update_dec_rate(indio_dev, val);
 		iio_device_release_direct(indio_dev);
 		return ret;
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
@@ -928,6 +1137,7 @@ static const struct iio_info ad7768_info = {
 	.read_raw = &ad7768_read_raw,
 	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
+	.write_raw_get_fmt = &ad7768_write_raw_get_fmt,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
@@ -1311,8 +1521,9 @@ static const struct regulator_desc vcm_desc = {
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
@@ -1334,10 +1545,77 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
 	return 0;
 }
 
+static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
+{
+	u32 val;
+	int ret;
+
+	ret = device_property_read_u32(dev, "adi,aaf-gain-bp", &val);
+	if (ret == -EINVAL) {
+		/* If controllable, use default */
+		if (st->chip->has_variable_aaf)
+			st->aaf_gain = AD7768_AAF_IN1;
+		return 0;
+	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get AAF gain value\n");
+
+	if (!st->chip->has_variable_aaf)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "AAF gain provided, but not supported for %s\n", st->chip->name);
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
@@ -1398,7 +1676,13 @@ static int ad7768_probe(struct spi_device *spi)
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
 
@@ -1409,6 +1693,19 @@ static int ad7768_probe(struct spi_device *spi)
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
@@ -1430,12 +1727,18 @@ static int ad7768_probe(struct spi_device *spi)
 
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


