Return-Path: <linux-iio+bounces-20382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998C9AD43F6
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4463A5E11
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 20:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59562266B56;
	Tue, 10 Jun 2025 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1Wx6HSo0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3F2263C91;
	Tue, 10 Jun 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587671; cv=none; b=e1KkG1ej6Ne8enEOwstEy1inzY5Ei/SR5HCWD7jfjsRCnJS4qydHeN1RacA0n8sTTaplc2gpJQRYfftFQdFang8B/02YFajywQks/7KqvLVrmgqwnXlgJoaS9tM7tgTh1ToiF9nXDvU/0vqkLIvVGpH51EHcHhSA+wRnOORjP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587671; c=relaxed/simple;
	bh=DqrXh8+RmHxzxkijpYaqHKgtDCZu0DxdQ7w/YQ+JLes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARw8zNzMxx4Rm18bs6FXElfIIqGQR69Tc2CRwbgSKYS1vEyWjjMOnSiSfawxaVXN47jQOeg0rw2YF+BSkewIg+YZVkRjhSQVvoAi94Z2uKi6KQLH4dr3mY6Ed5H1GesE3PmaaTl5UXSAXKiP/MXACEK9F3NzFSmQN8Kh92DH5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1Wx6HSo0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AIC0df012634;
	Tue, 10 Jun 2025 16:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qf5EZ
	ituaJRKmyffhhRYy33K6Of/goaVcp3vSCNIVYA=; b=1Wx6HSo06N39gfuQ1iNJU
	VNOFC0kTYi4ck4XPshNLT9e4QRaDVYCyI6U1NVmsB6IhXGTK9drDUHrP2V0wecCW
	HVO8ScUNWQcQ+Er5eaQTUOyvSQA9lMMxcK4/YdT+YMAzyJvVWzMFseVLc0HMVpCU
	u8kps4oA4dQ5Q+v0Naf0zTj1O0GNoV3eml5YxHrzJcDvYYsZvdUmnx98NVt4wtx4
	6s+JCMMH3lIOkBRRYOZ1nzg9onjSUCxkLzY8+ZMZir1SxLJuaYlDmOJX7CBRTh4I
	TO0EYiVJFd3zo0B0F5lSyq/IcE25p1bLlY2r6UkTlNpJm0v9gPJh1V6SogVvEq5p
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476hwsbkm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 16:34:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55AKYABH037726
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 16:34:10 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 16:34:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 16:34:10 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55AKXsT6019949;
	Tue, 10 Jun 2025 16:33:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 10/11] iio: adc: ad4170: Add support for weigh scale and RTD sensors
Date: Tue, 10 Jun 2025 17:33:54 -0300
Message-ID: <e3f018539cc187b6a60528efe6ab7c1ab7b126b0.1749582679.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1749582679.git.marcelo.schmitt@analog.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: wl6YO6dpg1jF4X9iI5u1SF6SG0lK9aiF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2NiBTYWx0ZWRfX2mTKUEkTAgfj
 0+EfSEpH+W2BJg3JWlcAPcpVpSXA6klYY1CwuNOuEdxPD5w8ctpbLu+U+yvoJG5XClF+mpJild+
 b/H3mID3Ccz70rmWxRfxfT8dDHEWjJmMG7VeIDuwTYVFSKjj9YQ4fZy/vgbtTd1JSrHpbjllbRc
 dxw/mS7+uM7WbrZcQTT2hR6Aj5cunBjIriDO5xSfRjSSOpVAONmqmcRDHzyeQJ079LT4sXgT9Bw
 NUjWkB16hbotLkOBGBP/HLhSbcMPxDsHAcvgnjjBAfLMJfPFK7BzA5JuHGL8vliE1QUunOkDbsC
 /Yxr16zQwcWt4zjSYEQ64G2nDFCcQkIb2nEque0XgUGTZnpJqw2Px7YkmAnPNqAISrxKUlcHZgC
 g6cOtv6w2wR/45QTNnxd1n3bw6phbLdEvWjeXbfJdQibdY0Yg5YjJ9Jmkt/4qjbXybKE4RO1
X-Authority-Analysis: v=2.4 cv=daWA3WXe c=1 sm=1 tr=0 ts=684896c4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=b54mGPezs8RaO1Bbk_YA:9
X-Proofpoint-GUID: wl6YO6dpg1jF4X9iI5u1SF6SG0lK9aiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100166

The AD4170 design has features to aid interfacing with weigh scale and RTD
sensors that are expected to be setup with external circuitry for proper
sensor operation. A key characteristic of those sensors is that the circuit
they are in must be excited with a pair of signals. The external circuit
can be excited either by voltage supply or by AD4170 excitation signals.
The sensor can then be read through a different pair of lines that are
connected to AD4170 ADC.

Configure AD4170 to handle external circuit sensors.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Tweaked commits/patches to reduce diff.
- Dropped unneeded local variable.

 drivers/iio/adc/ad4170.c | 494 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 490 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 253c9ca9b3e6..96274b20e9d2 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -67,6 +67,8 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_V_BIAS_REG				0x135
+#define AD4170_CURRENT_SRC_REG(x)			(0x139 + 2 * (x))
 #define AD4170_GPIO_MODE_REG				0x191
 #define AD4170_GPIO_OUTPUT_REG				0x193
 #define AD4170_GPIO_INPUT_REG				0x195
@@ -98,6 +100,10 @@
 #define AD4170_CHAN_MAP_AINP_MSK			GENMASK(12, 8)
 #define AD4170_CHAN_MAP_AINM_MSK			GENMASK(4, 0)
 
+/* AD4170_MISC_REG */
+#define AD4170_MISC_CHOP_IEXC_MSK			GENMASK(15, 14)
+#define AD4170_MISC_CHOP_ADC_MSK			GENMASK(9, 8)
+
 /* AD4170_AFE_REG */
 #define AD4170_AFE_REF_BUF_M_MSK			GENMASK(11, 10)
 #define AD4170_AFE_REF_BUF_P_MSK			GENMASK(9, 8)
@@ -108,12 +114,19 @@
 /* AD4170_FILTER_REG */
 #define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
 
+/* AD4170_CURRENT_SRC_REG */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_MSK		GENMASK(12, 8)
+#define AD4170_CURRENT_SRC_I_OUT_VAL_MSK		GENMASK(2, 0)
+
 /* AD4170_GPIO_MODE_REG */
 #define AD4170_GPIO_MODE_GPIO0_MSK			GENMASK(1, 0)
 #define AD4170_GPIO_MODE_GPIO1_MSK			GENMASK(3, 2)
 #define AD4170_GPIO_MODE_GPIO2_MSK			GENMASK(5, 4)
 #define AD4170_GPIO_MODE_GPIO3_MSK			GENMASK(7, 6)
 
+/* AD4170_GPIO_OUTPUT_REG */
+#define AD4170_GPIO_OUTPUT_GPIO_MSK(x)			BIT(x)
+
 /* AD4170 register constants */
 
 /* AD4170_CLOCK_CTRL_REG constants */
@@ -137,6 +150,11 @@
 #define AD4170_CHAN_MAP_REFIN2_N		28
 #define AD4170_CHAN_MAP_REFOUT			29
 
+/* AD4170_MISC_REG constants */
+#define AD4170_MISC_CHOP_IEXC_PAIR1			0x1
+#define AD4170_MISC_CHOP_IEXC_PAIR2			0x2
+#define AD4170_MISC_CHOP_IEXC_BOTH			0x3
+
 /* AD4170_PIN_MUXING_REG constants */
 #define AD4170_PIN_MUXING_DIG_AUX1_DISABLED		0x0
 #define AD4170_PIN_MUXING_DIG_AUX1_RDY			0x1
@@ -154,6 +172,10 @@
 #define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
 #define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
 
+/* AD4170_CURRENT_SRC_REG constants */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN(x)		(x)
+#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(x)		((x) + 17)
+
 /* AD4170_GPIO_MODE_REG constants */
 #define AD4170_GPIO_MODE_GPIO_INPUT			1
 #define AD4170_GPIO_MODE_GPIO_OUTPUT			2
@@ -167,6 +189,7 @@
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
 #define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_NUM_CURRENT_SRC				4
 #define AD4170_DEFAULT_SAMP_RATE			(125 * HZ_PER_KHZ)
 
 #define AD4170_INT_REF_2_5V				2500000
@@ -188,8 +211,19 @@
 
 #define AD4170_ADC_CTRL_CONT_READ_EXIT			0xA5
 
+/* Analog pin functions  */
+#define AD4170_PIN_UNASSIGNED				0x00
+#define AD4170_PIN_ANALOG_IN				0x01
+#define AD4170_PIN_CURRENT_OUT				0x02
+#define AD4170_PIN_VBIAS				0x04
+
 /* GPIO pin functions  */
 #define AD4170_GPIO_UNASSIGNED				0x00
+#define AD4170_GPIO_AC_EXCITATION			0x02
+#define AD4170_GPIO_OUTPUT				0x04
+
+/* Current source */
+#define AD4170_CURRENT_SRC_DISABLED			0xFF
 
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
@@ -228,6 +262,8 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_V_BIAS_REG] = 2,
+	[AD4170_CURRENT_SRC_REG(0) ... AD4170_CURRENT_SRC_REG(3)] = 2,
 	[AD4170_GPIO_MODE_REG] = 2,
 	[AD4170_GPIO_OUTPUT_REG] = 2,
 	[AD4170_GPIO_INPUT_REG] = 2,
@@ -290,6 +326,41 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
 	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256,
 };
 
+static const unsigned int ad4170_iout_pin_tbl[] = {
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(0),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(1),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(2),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(3),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(4),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(5),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(6),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(7),
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN(8),
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(0),
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(1),
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(2),
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(3),
+};
+
+static const unsigned int ad4170_iout_current_ua_tbl[] = {
+	0, 10, 50, 100, 250, 500, 1000, 1500,
+};
+
+enum ad4170_sensor_enum {
+	AD4170_ADC_SENSOR = 0,
+	AD4170_WEIGH_SCALE_SENSOR = 1,
+	AD4170_RTD_SENSOR = 2,
+	AD4170_THERMOCOUPLE_SENSOR = 3,
+};
+
+/* maps adi,sensor-type property value to enum */
+static const char * const ad4170_sensor_type[] = {
+	[AD4170_ADC_SENSOR] = "adc",
+	[AD4170_WEIGH_SCALE_SENSOR] = "weighscale",
+	[AD4170_RTD_SENSOR] = "rtd",
+	[AD4170_THERMOCOUPLE_SENSOR] = "thermocouple",
+};
+
 struct ad4170_chip_info {
 	const char *name;
 };
@@ -374,6 +445,7 @@ struct ad4170_state {
 	struct gpio_chip gpiochip;
 	unsigned int clock_ctrl;
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
+	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -918,6 +990,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
 	int v_diff;
 
 	*ain_voltage = 0;
+	/*
+	 * The voltage bias (vbias) sets the common-mode voltage of the channel
+	 * to (AVDD + AVSS)/2. If provided, AVSS supply provides the magnitude
+	 * (absolute value) of the negative voltage supplied to the AVSS pin.
+	 * So, we do AVDD - AVSS to compute the DC voltage generated by the bias
+	 * voltage generator.
+	 */
+	if (st->pins_fn[ain_n] & AD4170_PIN_VBIAS) {
+		int v_diff = st->vrefs_uv[AD4170_AVDD_SUP] - st->vrefs_uv[AD4170_AVSS_SUP];
+		*ain_voltage = v_diff / 2;
+		return 0;
+	}
+
 	if (ain_n <= AD4170_CHAN_MAP_TEMP_SENSOR)
 		return 0;
 
@@ -972,6 +1057,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
 	}
 }
 
+static int ad4170_validate_analog_input(struct ad4170_state *st, int pin)
+{
+	if (pin <= AD4170_MAX_ANALOG_PINS) {
+		if (st->pins_fn[pin] & AD4170_PIN_CURRENT_OUT)
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "Pin %d already used with fn %u.\n",
+					     pin, st->pins_fn[pin]);
+
+		st->pins_fn[pin] |= AD4170_PIN_ANALOG_IN;
+	}
+	return 0;
+}
+
 static int ad4170_validate_channel_input(struct ad4170_state *st, int pin, bool com)
 {
 	/* Check common-mode input pin is mapped to a special input. */
@@ -986,7 +1084,7 @@ static int ad4170_validate_channel_input(struct ad4170_state *st, int pin, bool
 				     "Invalid analog input pin number. %d\n",
 				     pin);
 
-	return 0;
+	return ad4170_validate_analog_input(st, pin);
 }
 
 /*
@@ -1723,6 +1821,371 @@ static int ad4170_gpio_init(struct iio_dev *indio_dev)
 	return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio_dev);
 }
 
+static int ad4170_validate_excitation_pin(struct ad4170_state *st, u32 pin)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int i;
+
+	/* Check the pin number is valid */
+	for (i = 0; i < ARRAY_SIZE(ad4170_iout_pin_tbl); i++)
+		if (ad4170_iout_pin_tbl[i] == pin)
+			break;
+
+	if (i == ARRAY_SIZE(ad4170_iout_pin_tbl))
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid excitation pin: %u\n",
+				     pin);
+
+	/* Check the pin is available */
+	if (pin <= AD4170_MAX_ANALOG_PINS) {
+		if (st->pins_fn[pin] != AD4170_PIN_UNASSIGNED)
+			return dev_err_probe(dev, -EINVAL,
+					     "Pin %u already used with fn %u\n",
+					     pin, st->pins_fn[pin]);
+
+		st->pins_fn[pin] |= AD4170_PIN_CURRENT_OUT;
+	} else {
+		unsigned int gpio = pin - AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(0);
+
+		if (st->gpio_fn[gpio] != AD4170_GPIO_UNASSIGNED)
+			return dev_err_probe(dev, -EINVAL,
+					     "GPIO %u already used with fn %u\n",
+					     gpio, st->gpio_fn[gpio]);
+
+		st->gpio_fn[gpio] |= AD4170_GPIO_AC_EXCITATION;
+	}
+
+	return 0;
+}
+
+static int ad4170_validate_excitation_pins(struct ad4170_state *st,
+					   u32 *exc_pins, int num_exc_pins)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < num_exc_pins; i++) {
+		ret = ad4170_validate_excitation_pin(st, exc_pins[i]);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static const char *const ad4170_i_out_pin_dt_props[] = {
+	"adi,excitation-pin-0",
+	"adi,excitation-pin-1",
+	"adi,excitation-pin-2",
+	"adi,excitation-pin-3",
+};
+
+static const char *const ad4170_i_out_val_dt_props[] = {
+	"adi,excitation-current-0-microamp",
+	"adi,excitation-current-1-microamp",
+	"adi,excitation-current-2-microamp",
+	"adi,excitation-current-3-microamp",
+};
+
+/*
+ * Parses firmware data describing output current source setup. There are 4
+ * excitation currents (IOUT0 to IOUT3) that can be configured independently.
+ * Excitation currents are added if they are output on the same pin.
+ */
+static int ad4170_parse_exc_current(struct ad4170_state *st,
+				    struct fwnode_handle *child,
+				    unsigned int *exc_pins,
+				    unsigned int *exc_curs,
+				    unsigned int *num_exc_pins)
+{
+	struct device *dev = &st->spi->dev;
+	unsigned int num_pins, i, j;
+	u32 pin, val;
+	int ret;
+
+	num_pins = 0;
+	for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++) {
+		/* Parse excitation current output pin properties. */
+		pin = AD4170_CURRENT_SRC_I_OUT_PIN_AIN(0);
+		ret = fwnode_property_read_u32(child, ad4170_i_out_pin_dt_props[i],
+					       &pin);
+		if (ret)
+			continue;
+
+		exc_pins[num_pins] = pin;
+
+		/* Parse excitation current value properties. */
+		val = ad4170_iout_current_ua_tbl[0];
+		fwnode_property_read_u32(child,
+					 ad4170_i_out_val_dt_props[i], &val);
+
+		for (j = 0; j < ARRAY_SIZE(ad4170_iout_current_ua_tbl); j++)
+			if (ad4170_iout_current_ua_tbl[j] == val)
+				break;
+
+		if (j == ARRAY_SIZE(ad4170_iout_current_ua_tbl))
+			return dev_err_probe(dev, -EINVAL, "Invalid %s: %uuA\n",
+					     ad4170_i_out_val_dt_props[i], val);
+
+		exc_curs[num_pins] = j;
+		num_pins++;
+	}
+	*num_exc_pins = num_pins;
+
+	return 0;
+}
+
+static int ad4170_setup_current_src(struct ad4170_state *st,
+				    struct fwnode_handle *child,
+				    struct ad4170_setup *setup, u32 *exc_pins,
+				    unsigned int *exc_curs, int num_exc_pins,
+				    bool ac_excited)
+{
+	unsigned int exc_cur_pair, i, j;
+	int ret;
+
+	for (i = 0; i < num_exc_pins; i++) {
+		unsigned int exc_cur = exc_curs[i];
+		unsigned int pin = exc_pins[i];
+		unsigned int current_src = 0;
+
+		for (j = 0; j < AD4170_NUM_CURRENT_SRC; j++)
+			if (st->cur_src_pins[j] == AD4170_CURRENT_SRC_DISABLED)
+				break;
+
+		if (j == AD4170_NUM_CURRENT_SRC)
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "Too many excitation current sources\n");
+
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK, pin);
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK, exc_cur);
+		st->cur_src_pins[j] = pin;
+		ret = regmap_write(st->regmap, AD4170_CURRENT_SRC_REG(j),
+				   current_src);
+		if (ret)
+			return ret;
+	}
+
+	if (!ac_excited)
+		return 0;
+
+	if (num_exc_pins < 2)
+		return dev_err_probe(&st->spi->dev, -EINVAL,
+			"Current chopping requested but only one pin provided: %u\n",
+			exc_pins[0]);
+
+	/*
+	 * Two use cases to handle here:
+	 * - 2 pairs of excitation currents;
+	 * - 1 pair of excitation currents.
+	 */
+	if (num_exc_pins == 4) {
+		for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++)
+			if (st->cur_src_pins[i] != exc_pins[i])
+				return dev_err_probe(&st->spi->dev, -EINVAL,
+						     "Unable to use 4 exc pins\n");
+	} else {
+		/*
+		 * Excitation current chopping is configured in pairs. Current
+		 * sources IOUT0 and IOUT1 form pair 1, IOUT2 and IOUT3 make up
+		 * pair 2. So, if current chopping was requested, check if the
+		 * first end of the first pair of excitation currents is
+		 * available. Try the next pair if IOUT0 has already been
+		 * configured for another channel.
+		 */
+		i = st->cur_src_pins[0] == exc_pins[0] ? 0 : 2;
+
+		if (st->cur_src_pins[i] != exc_pins[0] ||
+		    st->cur_src_pins[i + 1] != exc_pins[1])
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "Failed to setup current chopping\n");
+
+		st->cur_src_pins[i] = exc_pins[0];
+		st->cur_src_pins[i + 1] = exc_pins[1];
+
+		if (i == 0)
+			exc_cur_pair = AD4170_MISC_CHOP_IEXC_PAIR1;
+		else
+			exc_cur_pair = AD4170_MISC_CHOP_IEXC_PAIR2;
+	}
+
+	/*
+	 * Configure excitation current chopping.
+	 * Chop both pairs if using four excitation pins.
+	 */
+	setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
+				  num_exc_pins == 2 ?
+				  exc_cur_pair :
+				  AD4170_MISC_CHOP_IEXC_BOTH);
+
+	return 0;
+}
+
+static int ad4170_setup_bridge(struct ad4170_state *st,
+			       struct fwnode_handle *child,
+			       struct ad4170_setup *setup, u32 *exc_pins,
+			       unsigned int *exc_curs, int num_exc_pins,
+			       bool ac_excited)
+{
+	unsigned long gpio_mask;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * If a specific current is provided through
+	 * adi,excitation-current-n-microamp, set excitation pins provided
+	 * through adi,excitation-pin-n to excite the bridge circuit.
+	 */
+	for (i = 0; i < num_exc_pins; i++)
+		if (exc_curs[i] > 0)
+			return ad4170_setup_current_src(st, child, setup, exc_pins,
+							exc_curs, num_exc_pins,
+							ac_excited);
+
+	/*
+	 * Else, use predefined ACX1, ACX1 negated, ACX2, ACX2 negated signals
+	 * to AC excite the bridge. Those signals are output on GPIO2, GPIO0,
+	 * GPIO3, and GPIO1, respectively. If only two pins are specified for AC
+	 * excitation, use ACX1 and ACX2 (GPIO2 and GPIO3).
+	 *
+	 * Also, to avoid any short-circuit condition when more than one channel
+	 * is enabled, set GPIO2 and GPIO0 high, and set GPIO1 and GPIO3 low to
+	 * DC excite the bridge whenever a channel without AC excitation is
+	 * selected. That is needed because GPIO pins are controlled by the next
+	 * highest priority GPIO function when a channel doesn't enable AC
+	 * excitation. See datasheet Figure 113 Weigh Scale (AC Excitation) for
+	 * the reference circuit diagram.
+	 */
+	if (num_exc_pins == 2) {
+		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x3);
+
+		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK | AD4170_GPIO_MODE_GPIO2_MSK;
+		ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
+					 FIELD_PREP(AD4170_GPIO_MODE_GPIO3_MSK,
+						    AD4170_GPIO_MODE_GPIO_OUTPUT) |
+					 FIELD_PREP(AD4170_GPIO_MODE_GPIO2_MSK,
+						    AD4170_GPIO_MODE_GPIO_OUTPUT));
+		if (ret)
+			return ret;
+
+		/*
+		 * Set GPIO2 high and GPIO3 low to DC excite the bridge when
+		 * a different channel is selected.
+		 */
+		gpio_mask = AD4170_GPIO_OUTPUT_GPIO_MSK(3) |
+			    AD4170_GPIO_OUTPUT_GPIO_MSK(2);
+		ret = regmap_update_bits(st->regmap, AD4170_GPIO_OUTPUT_REG, gpio_mask,
+					 FIELD_PREP(AD4170_GPIO_OUTPUT_GPIO_MSK(3), 0) |
+					 FIELD_PREP(AD4170_GPIO_OUTPUT_GPIO_MSK(2), 1));
+		if (ret)
+			return ret;
+
+		st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
+		st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
+	} else {
+		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x2);
+
+		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK | AD4170_GPIO_MODE_GPIO2_MSK |
+			    AD4170_GPIO_MODE_GPIO1_MSK | AD4170_GPIO_MODE_GPIO0_MSK;
+		ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
+					 FIELD_PREP(AD4170_GPIO_MODE_GPIO3_MSK,
+						    AD4170_GPIO_MODE_GPIO_OUTPUT) |
+					 FIELD_PREP(AD4170_GPIO_MODE_GPIO2_MSK,
+						    AD4170_GPIO_MODE_GPIO_OUTPUT) |
+					 FIELD_PREP(AD4170_GPIO_MODE_GPIO1_MSK,
+						    AD4170_GPIO_MODE_GPIO_OUTPUT) |
+					 FIELD_PREP(AD4170_GPIO_MODE_GPIO0_MSK,
+						    AD4170_GPIO_MODE_GPIO_OUTPUT));
+		if (ret)
+			return ret;
+
+		/*
+		 * Set GPIO2 and GPIO0 high, and set GPIO1 and GPIO3 low to DC
+		 * excite the bridge when a different channel is selected.
+		 */
+		gpio_mask = AD4170_GPIO_OUTPUT_GPIO_MSK(3) |
+			    AD4170_GPIO_OUTPUT_GPIO_MSK(2) |
+			    AD4170_GPIO_OUTPUT_GPIO_MSK(1) |
+			    AD4170_GPIO_OUTPUT_GPIO_MSK(0);
+		ret = regmap_update_bits(st->regmap, AD4170_GPIO_OUTPUT_REG, gpio_mask,
+					 FIELD_PREP(AD4170_GPIO_OUTPUT_GPIO_MSK(3), 0) |
+					 FIELD_PREP(AD4170_GPIO_OUTPUT_GPIO_MSK(2), 1) |
+					 FIELD_PREP(AD4170_GPIO_OUTPUT_GPIO_MSK(1), 0) |
+					 FIELD_PREP(AD4170_GPIO_OUTPUT_GPIO_MSK(0), 1));
+		if (ret)
+			return ret;
+
+		st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
+		st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
+		st->gpio_fn[1] |= AD4170_GPIO_OUTPUT;
+		st->gpio_fn[0] |= AD4170_GPIO_OUTPUT;
+	}
+
+	return 0;
+}
+
+static int ad4170_setup_rtd(struct ad4170_state *st,
+			    struct fwnode_handle *child,
+			    struct ad4170_setup *setup, u32 *exc_pins,
+			    unsigned int *exc_curs, int num_exc_pins, bool ac_excited)
+{
+	return ad4170_setup_current_src(st, child, setup, exc_pins,
+					exc_curs, num_exc_pins, ac_excited);
+}
+
+static int ad4170_parse_external_sensor(struct ad4170_state *st,
+					struct fwnode_handle *child,
+					struct ad4170_setup *setup,
+					struct iio_chan_spec *chan, u8 s_type)
+{
+	unsigned int num_exc_pins, reg_val;
+	struct device *dev = &st->spi->dev;
+	u32 pins[2], exc_pins[4], exc_curs[4];
+	bool ac_excited, vbias;
+	int ret;
+
+	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
+					     ARRAY_SIZE(pins));
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read sensor diff-channels\n");
+
+	chan->differential = true;
+	chan->channel = pins[0];
+	chan->channel2 = pins[1];
+
+	ret = ad4170_parse_exc_current(st, child, exc_pins, exc_curs, &num_exc_pins);
+	if (ret)
+		return ret;
+
+	/* The external sensor may not need excitation from the ADC chip. */
+	if (num_exc_pins == 0)
+		return 0;
+
+	ret = ad4170_validate_excitation_pins(st, exc_pins, num_exc_pins);
+	if (ret)
+		return ret;
+
+	ac_excited = fwnode_property_read_bool(child, "adi,excitation-ac");
+
+	if (s_type == AD4170_THERMOCOUPLE_SENSOR) {
+		vbias = fwnode_property_read_bool(child, "adi,vbias");
+		if (vbias) {
+			st->pins_fn[chan->channel2] |= AD4170_PIN_VBIAS;
+			reg_val = BIT(chan->channel2);
+			return regmap_write(st->regmap, AD4170_V_BIAS_REG,
+					    reg_val);
+		}
+	}
+	if (s_type == AD4170_WEIGH_SCALE_SENSOR)
+		ret = ad4170_setup_bridge(st, child, setup, exc_pins, exc_curs,
+					  num_exc_pins, ac_excited);
+	else
+		ret = ad4170_setup_rtd(st, child, setup, exc_pins, exc_curs,
+				       num_exc_pins, ac_excited);
+
+	return ret;
+}
+
 static int ad4170_parse_reference(struct ad4170_state *st,
 				  struct fwnode_handle *child,
 				  struct ad4170_setup *setup)
@@ -1808,6 +2271,7 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	struct ad4170_setup *setup;
 	struct iio_chan_spec *chan;
 	unsigned int ref_select;
+	unsigned int s_type;
 	unsigned int ch_reg;
 	bool bipolar;
 	int ret;
@@ -1836,10 +2300,28 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = ad4170_parse_adc_channel_type(dev, child, chan);
-	if (ret < 0)
-		return ret;
+	ret = fwnode_property_match_property_string(child, "adi,sensor-type",
+						    ad4170_sensor_type,
+						    ARRAY_SIZE(ad4170_sensor_type));
 
+	/* Default to conventional ADC channel if sensor type not present */
+	s_type = ret < 0 ? AD4170_ADC_SENSOR : ret;
+	switch (s_type) {
+	case AD4170_ADC_SENSOR:
+		ret = ad4170_parse_adc_channel_type(dev, child, chan);
+		if (ret)
+			return ret;
+
+		break;
+	case AD4170_WEIGH_SCALE_SENSOR:
+	case AD4170_THERMOCOUPLE_SENSOR:
+	case AD4170_RTD_SENSOR:
+		ret = ad4170_parse_external_sensor(st, child, setup, chan, s_type);
+		if (ret)
+			return ret;
+
+		break;
+	}
 	bipolar = fwnode_property_read_bool(child, "bipolar");
 	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
 	if (bipolar)
@@ -2035,6 +2517,7 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
 	int reg_data, ret;
+	unsigned int i;
 
 	ret = ad4170_clock_select(indio_dev);
 	if (ret)
@@ -2044,6 +2527,9 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++)
+		st->cur_src_pins[i] = AD4170_CURRENT_SRC_DISABLED;
+
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	st->int_pin_sel = AD4170_INT_PIN_SDO;
 	ret = device_property_match_property_string(dev, "interrupt-names",
-- 
2.47.2


