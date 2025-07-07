Return-Path: <linux-iio+bounces-21431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB0AFB571
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255A91885F47
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8506C2BD5A8;
	Mon,  7 Jul 2025 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="U+B0VIA6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854D19D880;
	Mon,  7 Jul 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896510; cv=none; b=r5ych+CWr3JrAH7MdbLjAAhsMi2PZvlOicoqig8Sqa/EVwg6XILHAxpT8BQoWGSwXHLKVBD9U0DtoO8BhxM5TPfsDfKa6fQDogbVMp16MFkCRViJQNdBpBa17HjH58jsPfY++FaN0bcZKhyF4evPlWqp7S7kuzj0swgAy60flXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896510; c=relaxed/simple;
	bh=iUbEjQ0itCS6XDKVyYlzv4Vq2CkvMDnUhJ1WmP3sacM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBiUq5fRjm9w+FU2DYSdzkRaqcj9J5GXphTdxullgcyBuJ6gMBnA+T4VBSoOOyTQ9OTyHDUMs+RiaZIsOHa780InWyb9OMMFVv0VC9Eg/exo1nH7CS9jxakoSAk2PiYYUoon5CAWaVW9kdmZUW8AFZKFdowfu5Q4m+Yl1EipOvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=U+B0VIA6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567DBY55026983;
	Mon, 7 Jul 2025 09:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MGGK7
	5xxeKv/Z7hMV1RimTUL04g2dee7BogVVyYMPcQ=; b=U+B0VIA6rtIylAMusJ+L6
	wucnWZehqvc63fGvR5ypjf6x/UNr+STYmdG+YeM5Sky5qXgPap9PKQQSnq3IG7eC
	RwRq+NurL7BdwJJnl68Y3YFO02gzm3OeRXL4Tti1hQMeTykCCGKzFCqdP3HtP6bw
	/j7Q935SNXO4LwDWYW8dMKCPX6uWQ/XvlpClLqH+QIZ5KmMMfU3Ep4mxrZLi/I66
	rEV6Mfx7sNiKlGofQISxsEA+STbytDJK8Gou4+h/T/hGYhy+AJc+g4ce8Qpf5t+5
	D0YvDljAHnbPhqHIH3o1fQTkI/kPTPqbnpaNMy2ZLfDFUgY+O2xUW1KU9QkI1xHc
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47rayqh73r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:54:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 567DsnUp011879
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:54:49 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 09:54:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:54:49 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567DsUE8016360;
	Mon, 7 Jul 2025 09:54:33 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 12/12] iio: adc: ad4170-4: Add support for weigh scale, thermocouple, and RTD sens
Date: Mon, 7 Jul 2025 10:54:29 -0300
Message-ID: <52686943040ecad34cc89833d4d5d37f1a51f412.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AP9nYgXq c=1 sm=1 tr=0 ts=686bd1aa cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=b54mGPezs8RaO1Bbk_YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MSBTYWx0ZWRfXzJIyS5Da7eaE
 BrMMK7pWYEFsgEOPOkwZrkdYbbuNQFSuPlD4ZMNMqd6AZ+WGAV28GYqbT4duHz5JFw59208W7c9
 eJiiSxjD7ONrBKbukWKDEWGXjA2nEgLNNRCQJ0DCz+Jg4qclkfyRA/EG7d3Q0aFkIcdQMUOE2Gb
 BvD1A84IGWjQHT6OP6aRW99hXek7+50ENGecUe+6e6QrM845ioJ7j4/1VBObsLgaicDImnMMvJ4
 pyAE+y0/SLwB3k/gB4XoYs98ndO3gQmCKHQNt8vqIQpIZASzslD2c20lmsHcw801wz9MQUvlRR+
 1sHFPUl9iZrpjn/SdRb0vp60fSj7iS+TouQPqb2OQJ58/CUSHpMRbefHRA6UWxURCQXehKGxakx
 4A47GPxSSF4yF0pALdoo8YfM6da7Wei3BiqRl78zl+tlsa031usnR0q7ZLfjiheFO7cbOWop
X-Proofpoint-ORIG-GUID: mSkP4bpycPFNNcnoHCnrQMe5aXDVacIj
X-Proofpoint-GUID: mSkP4bpycPFNNcnoHCnrQMe5aXDVacIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070081

The AD4170-4 design provides features to aid interfacing with weigh scales,
thermocouples, and RTD sensors, which are set up with additional circuitry
for proper sensor operation. A key characteristic of those sensors is that
the circuit they are in must be excited with a single, a pair, or two pairs
of signals. The external circuit can be excited either by a voltage supply
or by AD4170-4 excitation signals. The sensor can then be read through a
different pair of lines that are connected to the AD4170-4 ADC.

Extend the ad4170-4 driver to handle external circuit sensors.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v7 -> v8
- Reworded external sensor support patch description.
- Reduced number of line removals in code diff.
- Updated ad4170_parse_external_sensor() param: u8 s_type -> unsigned int s_type.

 drivers/iio/adc/ad4170-4.c | 500 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 499 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 2a20868a1db7..6cd84d6fb08b 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -69,6 +69,8 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_V_BIAS_REG				0x135
+#define AD4170_CURRENT_SRC_REG(x)			(0x139 + 2 * (x))
 #define AD4170_GPIO_MODE_REG				0x191
 #define AD4170_GPIO_OUTPUT_REG				0x193
 #define AD4170_GPIO_INPUT_REG				0x195
@@ -100,6 +102,10 @@
 #define AD4170_CHAN_MAP_AINP_MSK			GENMASK(12, 8)
 #define AD4170_CHAN_MAP_AINM_MSK			GENMASK(4, 0)
 
+/* AD4170_MISC_REG */
+#define AD4170_MISC_CHOP_IEXC_MSK			GENMASK(15, 14)
+#define AD4170_MISC_CHOP_ADC_MSK			GENMASK(9, 8)
+
 /* AD4170_AFE_REG */
 #define AD4170_AFE_REF_BUF_M_MSK			GENMASK(11, 10)
 #define AD4170_AFE_REF_BUF_P_MSK			GENMASK(9, 8)
@@ -110,12 +116,19 @@
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
@@ -139,6 +152,11 @@
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
@@ -156,6 +174,10 @@
 #define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
 #define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
 
+/* AD4170_CURRENT_SRC_REG constants */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN(x)		(x)
+#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(x)		((x) + 17)
+
 /* AD4170_GPIO_MODE_REG constants */
 #define AD4170_GPIO_MODE_GPIO_INPUT			1
 #define AD4170_GPIO_MODE_GPIO_OUTPUT			2
@@ -171,6 +193,7 @@
 #define AD4170_INVALID_SETUP				9
 #define AD4170_SPI_INST_PHASE_LEN			2
 #define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_NUM_CURRENT_SRC				4
 #define AD4170_DEFAULT_SAMP_RATE			(125 * HZ_PER_KHZ)
 
 #define AD4170_INT_REF_2_5V				2500000
@@ -192,8 +215,19 @@
 
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
@@ -232,6 +266,8 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_V_BIAS_REG] = 2,
+	[AD4170_CURRENT_SRC_REG(0) ... AD4170_CURRENT_SRC_REG(3)] = 2,
 	[AD4170_GPIO_MODE_REG] = 2,
 	[AD4170_GPIO_OUTPUT_REG] = 2,
 	[AD4170_GPIO_INPUT_REG] = 2,
@@ -301,8 +337,39 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
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
 enum ad4170_sensor_enum {
 	AD4170_ADC_SENSOR = 0,
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
 };
 
 struct ad4170_chip_info {
@@ -387,6 +454,7 @@ struct ad4170_state {
 	unsigned int clock_ctrl;
 	unsigned int pins_fn[AD4170_NUM_ANALOG_PINS];
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
+	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
 	struct gpio_chip gpiochip;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -909,6 +977,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
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
 
@@ -963,6 +1044,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
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
@@ -977,7 +1071,7 @@ static int ad4170_validate_channel_input(struct ad4170_state *st, int pin, bool
 				     "Invalid analog input pin number. %d\n",
 				     pin);
 
-	return 0;
+	return ad4170_validate_analog_input(st, pin);
 }
 
 /*
@@ -1719,6 +1813,371 @@ static int ad4170_gpio_init(struct iio_dev *indio_dev)
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
+					struct iio_chan_spec *chan,
+					unsigned int s_type)
+{
+	unsigned int num_exc_pins, reg_val;
+	struct device *dev = &st->spi->dev;
+	u32 pins[2], exc_pins[4], exc_curs[4];
+	bool ac_excited;
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
+		if (st->pins_fn[chan->channel2] & AD4170_PIN_VBIAS) {
+			reg_val = BIT(chan->channel2);
+			ret = regmap_write(st->regmap, AD4170_V_BIAS_REG, reg_val);
+			if (ret)
+				dev_err_probe(dev, ret, "Failed to set vbias\n");
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
@@ -1848,12 +2307,26 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	ret = fwnode_property_match_property_string(child, "adi,sensor-type",
+						    ad4170_sensor_type,
+						    ARRAY_SIZE(ad4170_sensor_type));
+
+	/* Default to conventional ADC channel if sensor type not present */
+	s_type = ret < 0 ? AD4170_ADC_SENSOR : ret;
 	switch (s_type) {
 	case AD4170_ADC_SENSOR:
 		ret = ad4170_parse_adc_channel_type(dev, child, chan);
 		if (ret)
 			return ret;
 
+		break;
+	case AD4170_WEIGH_SCALE_SENSOR:
+	case AD4170_THERMOCOUPLE_SENSOR:
+	case AD4170_RTD_SENSOR:
+		ret = ad4170_parse_external_sensor(st, child, setup, chan, s_type);
+		if (ret)
+			return ret;
+
 		break;
 	default:
 		return -EINVAL;
@@ -2060,10 +2533,13 @@ static int ad4170_clock_select(struct iio_dev *indio_dev)
 
 static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 {
+	unsigned int vbias_pins[AD4170_MAX_ANALOG_PINS];
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
+	unsigned int num_vbias_pins;
 	int reg_data, ret;
 	u32 int_pin_sel;
+	unsigned int i;
 
 	ret = ad4170_clock_select(indio_dev);
 	if (ret)
@@ -2073,6 +2549,9 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++)
+		st->cur_src_pins[i] = AD4170_CURRENT_SRC_DISABLED;
+
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	int_pin_sel = AD4170_INT_PIN_SDO;
 	ret = device_property_match_property_string(dev, "interrupt-names",
@@ -2091,6 +2570,25 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	ret = device_property_count_u32(dev, "adi,vbias-pins");
+	if (ret > 0) {
+		if (ret > AD4170_MAX_ANALOG_PINS)
+			return dev_err_probe(dev, -EINVAL,
+					     "Too many vbias pins %u\n", ret);
+
+		num_vbias_pins = ret;
+
+		ret = device_property_read_u32_array(dev, "adi,vbias-pins",
+						     vbias_pins,
+						     num_vbias_pins);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to read vbias pins\n");
+
+		for (i = 0; i < num_vbias_pins; i++)
+			st->pins_fn[vbias_pins[i]] |= AD4170_PIN_VBIAS;
+	}
+
 	ret = ad4170_parse_channels(indio_dev);
 	if (ret)
 		return ret;
-- 
2.47.2


