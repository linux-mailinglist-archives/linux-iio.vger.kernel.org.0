Return-Path: <linux-iio+bounces-23787-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0644BB45D21
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA0D7C27AF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D45F1C75E2;
	Fri,  5 Sep 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="n9zR0SbW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9A15D3;
	Fri,  5 Sep 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087645; cv=none; b=Hl2hYiNhu7CrtAxbs9igmBmfJdMNc6drbbyXg9c/1d9xUwe197Oq5BzkqiqyamP5p+AwYkGFXrfoBTEwdgKEJlU4bUr/ETxBUUnLc72lLs1RLQXZqEezfvkmeedZWZ7jppWQ5NKtVApSQCteFHnbj1rdzCOkCMxvAzT8VbsuUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087645; c=relaxed/simple;
	bh=8qZozAs0LIHL90hHSMxPVKslq8HyOP7lUsHKqLK755k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0XbOkawrGwpTksnCHpZmr0RkA80nUNCSKZEPTgdD11fMF4pVub5he1ciAeOmtEFX36QWnbsEN6DzTY1dZ07Db3ZvMHMMqXC1RVngGWJnBFIGoLlbubK1xQCeh4X/yec8RvhQBMQladp3XTAP7LzRmHHXvfu8Gz+4/3CGlzmSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=n9zR0SbW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585E29BV031322;
	Fri, 5 Sep 2025 11:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qeWGD
	m9KV/6i3GIDO7INtTUs2TtnPVnlF+4jW9IqoG0=; b=n9zR0SbWmWVdwE0gC+Tji
	S+fyFcYDafkPXTNFdDwgVPantJSnC+ccM5Ly08YojGju8ztc0Mv8SBb19M7SDY1E
	BnKGB5MGlyee4MzEGmE7+2c+6taMBdJ1d9C553kIm2GqS7ZkhEM9VJC4i/9AUvyw
	cu7BGYpZNJDxZp7qpkGXKusuP4woODbd+VKFyPbhpRtgLiCJ0F/XzNragiKu6+1W
	w/QWmMEck1kpUCmrCa2dEjd8az2jmoTxfLnTa81OFcc0prPKdaCWUr3o7NSBBb4C
	7ofp7+udkimb03b/HEwn790teED0w/+RdixnjDjvQAbOH2Q5JvV8WJB+0nxKWuiG
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48ypq4upbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 11:53:47 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 585Frk5j053272
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Sep 2025 11:53:46 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 5 Sep 2025 11:53:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 5 Sep 2025 11:53:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Sep 2025 11:53:46 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 585FrWeq020495;
	Fri, 5 Sep 2025 11:53:34 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
        <jonath4nns@gmail.com>
Subject: [PATCH v3 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
Date: Fri, 5 Sep 2025 06:49:42 -0300
Message-ID: <6228c10d731b6946a68e1c3c95643065cc81329a.1757001160.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757001160.git.Jonathan.Santos@analog.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9TYNOfoOeYilUu9F5Tp1UlWd8UDxZ9ZW
X-Proofpoint-GUID: 9TYNOfoOeYilUu9F5Tp1UlWd8UDxZ9ZW
X-Authority-Analysis: v=2.4 cv=LrKSymdc c=1 sm=1 tr=0 ts=68bb078b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=f6szJElCMp8n6j1n3gYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDAxNiBTYWx0ZWRfX/ECm+kfyMFY2
 IJFkgQGDOGWaim5g46cBbsCPA/8KdZdFKSqQkAFTMnxtk3pRWfTsBB7PTDaJeR6wfvxF5z+X5c3
 d/Byd7WSbppg10BvzO6Wzo8gX0ZOY+5RjKtPBh3s2xV3KSRywBwDDVaBX06yAofKcPxuflIE6Az
 W0klR9WZuWKdRywz4E0cSdcphlv6BVa+ZWAHg3foBZmn52U2jJRiVOK4Tch7DhLh1neQwiHBa3+
 r5oOrAvUiy/3F7bmUVtUd4rQH+bwvaKpv7Xig4pwWsVEivHdE+PZsYLFXWERoF6op+0YP4D1YKa
 HqIpmkfyOg9brztiE+U6BaVmZI4XEkGg18IGoFWaT79So+RBawfk/f6s4k98cbZXGaW4FOlUZcN
 mcZ1P3JN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509050016

Add support for ADAQ7767/68/69-1 series, which includes PGIA and
Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
provide a VCM regulator interface.

The PGA gain is configured in run-time through the scale attribute,
if supported by the device. PGA is enabled and controlled by the GPIO
controller (GPIOs 0, 1 and 2) provided by the device with the SPI
interface.

The AAF gain is defined by hardware connections and should be specified
in the device tree.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
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
 drivers/iio/adc/ad7768-1.c | 292 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 291 insertions(+), 2 deletions(-)

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
index 000d294c616c..c2951de4799d 100644
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
@@ -98,15 +103,21 @@
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
@@ -153,6 +164,51 @@ enum ad7768_scan_type {
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
@@ -217,6 +273,13 @@ struct ad7768_chip_info {
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
@@ -234,6 +297,9 @@ struct ad7768_state {
 	unsigned int samp_freq;
 	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
 	unsigned int samp_freq_avail_len;
+	unsigned int pga_gain_mode;
+	unsigned int aaf_gain;
+	int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];
 	struct completion completion;
 	struct iio_trigger *trig;
 	struct gpio_desc *gpio_sync_in;
@@ -242,6 +308,7 @@ struct ad7768_state {
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
+	struct u64_fract fract;
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
+			fract.denominator *= 10000;
+		}
+
+		rational_best_approximation(fract.numerator, fract.denominator,
+					    INT_MAX, INT_MAX, &n, &d);
+
+		val = mult_frac(st->vref_uv, d, n);
+		/* Would multiply by NANO here, but value is already in milli */
+		tmp2 = shift_right((u64)val * MICRO, val2);
+		tmp0 = div_u64_rem(tmp2, NANO, &tmp1);
+		st->scale_tbl[i][0] = tmp0; /* Integer part */
+		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
+	}
+}
+
 static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
 				     unsigned int dec_rate)
 {
@@ -565,12 +668,56 @@ static int ad7768_configure_dig_fil(struct iio_dev *dev,
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
+	u32 tmp;
+
+	gain_nano = gain_int * NANO + gain_fract;
+	gain_nano = clamp(gain_nano, 0, ADAQ776X_GAIN_MAX_NANO);
+	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
+	gain_nano = DIV_ROUND_CLOSEST(st->vref_uv, tmp);
+	if (st->chip->has_variable_aaf)
+		gain_nano = DIV_ROUND_CLOSEST_ULL(gain_nano *  10000,
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
+	int ret;
+
+	guard(mutex)(&st->pga_lock);
+
+	ret = regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL, AD7768_GPIO_PGIA_EN);
+	if (ret)
+		return ret;
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
@@ -778,6 +925,10 @@ static const struct iio_chan_spec ad7768_channels[] = {
 	AD7768_CHAN(0, 0),
 };
 
+static const struct iio_chan_spec adaq776x_channels[] = {
+	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
+};
+
 static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long info)
@@ -805,7 +956,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
+			temp = (temp * 10000) / ad7768_aaf_gains_bp[st->aaf_gain];
+
+		*val = temp;
 		*val2 = scan_type->realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -861,18 +1024,39 @@ static int ad7768_read_avail(struct iio_dev *indio_dev,
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
@@ -884,6 +1068,21 @@ static int __ad7768_write_raw(struct iio_dev *indio_dev,
 
 		/* Update sampling frequency */
 		return ad7768_set_freq(st, st->samp_freq);
+	case IIO_CHAN_INFO_SCALE:  {
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
@@ -925,6 +1124,7 @@ static const struct iio_info ad7768_info = {
 	.read_raw = &ad7768_read_raw,
 	.read_avail = &ad7768_read_avail,
 	.write_raw = &ad7768_write_raw,
+	.write_raw_get_fmt = &ad7768_write_raw_get_fmt,
 	.read_label = ad7768_read_label,
 	.get_current_scan_type = &ad7768_get_current_scan_type,
 	.debugfs_reg_access = &ad7768_reg_access,
@@ -1331,10 +1531,80 @@ static int ad7768_register_regulators(struct device *dev, struct ad7768_state *s
 	return 0;
 }
 
+static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
+{
+	bool aaf_gain_provided;
+	u32 val;
+	int ret;
+
+	st->aaf_gain = AD7768_AAF_IN1;
+	ret = device_property_read_u32(dev, "adi,aaf-gain-bp", &val);
+	aaf_gain_provided = (ret == 0);
+	if (!aaf_gain_provided && st->chip->has_variable_aaf) {
+		dev_warn(dev, "AAF gain not specified, using default\n");
+		return 0;
+	}
+
+	if (aaf_gain_provided && !st->chip->has_variable_aaf) {
+		dev_warn(dev, "AAF gain not supported for %s\n", st->chip->name);
+		return 0;
+	}
+
+	if (aaf_gain_provided) {
+		switch (val) {
+		case 10000:
+			st->aaf_gain = AD7768_AAF_IN1;
+			break;
+		case 3640:
+			st->aaf_gain = AD7768_AAF_IN2;
+			break;
+		case 1430:
+			st->aaf_gain = AD7768_AAF_IN3;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid firmware provided AAF gain\n");
+		}
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
@@ -1399,7 +1669,13 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Register VCM output regulator */
-	ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
+	if (st->chip->has_vcm_regulator) {
+		ret = ad7768_register_regulators(&spi->dev, st, indio_dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad7768_parse_aaf_gain(&spi->dev, st);
 	if (ret)
 		return ret;
 
@@ -1410,6 +1686,12 @@ static int ad7768_probe(struct spi_device *spi)
 	}
 
 	init_completion(&st->completion);
+	ret = devm_mutex_init(&spi->dev, &st->pga_lock);
+	if (ret)
+		return ret;
+
+	if (st->chip->has_pga)
+		ad7768_set_pga_gain(st, st->chip->default_pga_mode);
 
 	ret = ad7768_set_channel_label(indio_dev, st->chip->num_channels);
 	if (ret)
@@ -1431,12 +1713,18 @@ static int ad7768_probe(struct spi_device *spi)
 
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


