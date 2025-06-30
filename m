Return-Path: <linux-iio+bounces-21164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B0AEE00F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 16:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9697D189FCB2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF65128B7C3;
	Mon, 30 Jun 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D2rWQWKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371B24678A;
	Mon, 30 Jun 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292134; cv=none; b=HV2BD/i9+z1tHZX1n5LktoLgstrToa4dSD6r2DciqaQbgUGL19gxHjB04siMokEyDABQtbRyVMku+U9owG0wj3Rg3UfrOTgDpumbsE8yu3isoIqFVl4OSC4voCBCUklAbYnM6os8qpfzjZnl73w4bhifObyh0TFOAQyUYCUxgOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292134; c=relaxed/simple;
	bh=NCjZT0PMaxsYU/hhnqINetN7S8Z5zxeD6wdf7+3RGes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW7GCKSshZEKwaqj8TzIUuAOoT2+iKmslpvtXc15JQqbv49vkTkA7o9tD1S7imSgdM7+xnEl9EsbNy4OHJFonJNFTa4r6C7NBjC8D0KPUvM23N9kSk47ENQcTvoXi9FXAyrwRiDxa9+2YLIPEu77eNmbNnSDbMYdeMRva2+lpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D2rWQWKu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UAIjmF026457;
	Mon, 30 Jun 2025 10:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qKIcN
	8g8mQnq95yd+P8hnOs++6UGV23zy+0ANg1h7EY=; b=D2rWQWKufOC2sssMo6OOJ
	jZ/uqtO32XLNeBXkikDhaRnoles/Pttots2KzEMID4e8xw/hhQTjtviJLACYlSpw
	nDBsAmCKwiudQulBFfdrHG/IWpnwM5Ne3XLrAxCsseAzdS7k90qzkrFWtF3eMhKC
	JMzZjGvGS/xEdrV7E0qTN3b/+mBZzkGNcOGQhZX4aB6BF4k4LwbHSZOmdx7KHklj
	P5q92UZBNl+TuaE/cUqskLAxliyoYFYj7QoiWFvUUgDzHWaAWkzhfguheUguOBl8
	rPkzUE6Xncn84iKAfbQph7UIWyTYstTc3ivyG8M7lNB3PyUecIp2AhQq+DzcWkGw
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47krqa10w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 10:01:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55UE1oXK054707
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Jun 2025 10:01:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 30 Jun
 2025 10:01:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Jun 2025 10:01:50 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55UE1VgJ009161;
	Mon, 30 Jun 2025 10:01:34 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v7 11/12] iio: adc: ad4170-4: Add support for weigh scale and RTD sensors
Date: Mon, 30 Jun 2025 11:01:30 -0300
Message-ID: <0b966dd44a977e7af004065937399e6b6e9afac7.1751289747.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751289747.git.marcelo.schmitt@analog.com>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDExNSBTYWx0ZWRfX6ZaYdLJnvBLd
 3G/77VvqZh6E9lNgmkOZ+Qva9jugxMd156W/vhaztKSA/pCpVIpC6GK6Uz8WtzY7qT+YORwCFth
 gRanP6pUeQikN+YNoaCbItpoAtyiFTV+hwreUp/eBUwpUJMCoj3+5Kp4UbhxTvTi1dJ7flTCMdC
 R97lVkqDlIGB73VCJUN1In6wCc3szjIsn7WAYYMtNoMcqgqaGKn6ny729vmz49+SpjfkNe9vFqi
 +a9U0tF75ZETdCj/McUUpRVGnuZ2RWLc1AW5+KfFpPDXkMzQtjIRBwLfYq8pCxmxPuVkEtmrpMS
 2m9ojiVvGt+q4o7v4RlSoe3aYzvw+uM8SrYZdOGVgcJggXhdIOyeNb0lzKdIoEg0p8WuOm2vDmn
 l2Bz777QGG7bhiFAaBF7yeUu2VzWHaR/NqcsHxXC3Ty76i/m41YPtkP4Dt2r3Fqj+TaI8tqf
X-Proofpoint-GUID: RK-BMkDlRXOT7Q4ajlNLHMHr85RyjBGY
X-Proofpoint-ORIG-GUID: RK-BMkDlRXOT7Q4ajlNLHMHr85RyjBGY
X-Authority-Analysis: v=2.4 cv=U8+SDfru c=1 sm=1 tr=0 ts=686298d0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=VrUqSK_fKgCXKd0iswgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_03,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300115

The AD4170-4 design has features to aid interfacing with weigh scale and
RTD sensors that are expected to be setup with external circuitry for
proper sensor operation. A key characteristic of those sensors is that the
circuit they are in must be excited with a pair of signals. The external
circuit can be excited either by voltage supply or by AD4170-4 excitation
signals. The sensor can then be read through a different pair of lines
that are connected to AD4170-4 ADC.

Configure AD4170-4 to handle external circuit sensors.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v6 -> v7
- adi,vbias was previously set per channel in ad4170 dt-binding but it is set
  per device in adi,ad4130.yaml. Fixed ad4170 parsing of adi,vbias. The
  dt-binding had been updated to the established use of adi,vbias in v4.

 drivers/iio/adc/ad4170-4.c | 514 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 510 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 53875b74a9a7..05730e36deea 100644
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
@@ -170,6 +192,7 @@
 #define AD4170_INVALID_SETUP				9
 #define AD4170_SPI_INST_PHASE_LEN			2
 #define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_NUM_CURRENT_SRC				4
 #define AD4170_DEFAULT_SAMP_RATE			(125 * HZ_PER_KHZ)
 
 #define AD4170_INT_REF_2_5V				2500000
@@ -191,8 +214,19 @@
 
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
@@ -231,6 +265,8 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_V_BIAS_REG] = 2,
+	[AD4170_CURRENT_SRC_REG(0) ... AD4170_CURRENT_SRC_REG(3)] = 2,
 	[AD4170_GPIO_MODE_REG] = 2,
 	[AD4170_GPIO_OUTPUT_REG] = 2,
 	[AD4170_GPIO_INPUT_REG] = 2,
@@ -300,6 +336,41 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
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
@@ -384,6 +455,7 @@ struct ad4170_state {
 	struct gpio_chip gpiochip;
 	unsigned int clock_ctrl;
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
+	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -905,6 +977,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
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
 
@@ -959,6 +1044,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
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
@@ -973,7 +1071,7 @@ static int ad4170_validate_channel_input(struct ad4170_state *st, int pin, bool
 				     "Invalid analog input pin number. %d\n",
 				     pin);
 
-	return 0;
+	return ad4170_validate_analog_input(st, pin);
 }
 
 /*
@@ -1716,6 +1814,370 @@ static int ad4170_gpio_init(struct iio_dev *indio_dev)
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
@@ -1817,6 +2279,7 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	struct ad4170_setup *setup;
 	struct iio_chan_spec *chan;
 	unsigned int ref_select;
+	unsigned int s_type;
 	unsigned int ch_reg;
 	bool bipolar;
 	int ret;
@@ -1844,10 +2307,28 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = ad4170_parse_adc_channel_type(dev, child, chan);
-	if (ret)
-		return ret;
+	ret = fwnode_property_match_property_string(child, "adi,sensor-type",
+						    ad4170_sensor_type,
+						    ARRAY_SIZE(ad4170_sensor_type));
+
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
 
+		break;
+	}
 	bipolar = fwnode_property_read_bool(child, "bipolar");
 	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
 	if (bipolar)
@@ -2041,9 +2522,12 @@ static int ad4170_clock_select(struct iio_dev *indio_dev)
 
 static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 {
+	unsigned int vbias_pins[AD4170_MAX_ANALOG_PINS];
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
+	unsigned int num_vbias_pins;
 	int reg_data, ret;
+	unsigned int i;
 
 	ret = ad4170_clock_select(indio_dev);
 	if (ret)
@@ -2053,6 +2537,9 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++)
+		st->cur_src_pins[i] = AD4170_CURRENT_SRC_DISABLED;
+
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	st->int_pin_sel = AD4170_INT_PIN_SDO;
 	ret = device_property_match_property_string(dev, "interrupt-names",
@@ -2071,6 +2558,25 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
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


