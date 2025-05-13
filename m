Return-Path: <linux-iio+bounces-19495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EC7AB5501
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 14:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782C41610B3
	for <lists+linux-iio@lfdr.de>; Tue, 13 May 2025 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8128C5A5;
	Tue, 13 May 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cOg6Yh55"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0F284B55;
	Tue, 13 May 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139848; cv=none; b=pmk8L/MyrblRLGuT93yh5e3c8Jqp3Jmay4CQBrc7D0mFr0JkTeioE54Dos2IquGv+U+OqjIGIJLKkjS6uk6NcODq1YpdH2D4S1pwX+NtsRb2fBUY/ZLTu7VYmJnj2Ci3lWhTvM4saWSa4g/SE1gPOev/x6Egr/DbAcMxKUNVGJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139848; c=relaxed/simple;
	bh=h3j5TUoP88kPGzkPhmp1KGw5LK6zVZFjCeqVMLvsNe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3xPGauQebm1xZdFMwjOehheHHbGJgwzjvfOo+a26issW9gi4ptVNy0xbwf1ddqJFCaZwNYo9m1Jk5kRiKzWRP2o1Nw6mP7eCKCFDPCtaUeoEO4H4hp+dcSOTs/nMXQ60xfvPo1ukYqifGuPO3iS+FrlCrzwbUfaL2Mw9xOZoK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cOg6Yh55; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DBEM6S007958;
	Tue, 13 May 2025 08:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CTw9k
	3G0ypRExR5jihUjHgHY3a0P79RjPenWStdKsIA=; b=cOg6Yh55Ol3YpOL368oMR
	fqWKLebbuacCdM/JBWUMbD9Bqp4HBOoPH/SMzb73ktGnD5N/3V318syzhgDBtj4N
	J+g1tAx1gmTF8ksxhkbWmyyLXSlWIH1zrLobNixlv0VbdgRPXn5d7xuK/P20jbBT
	6jHhh2NGtNhlLF7kVqH0Eb6c7Y8C2JeLS4moexIfznhpp+Ok/d80oV3mcFArcVj1
	K6s4y/dKqHY97jmtatvM65bz9aoHltKBbJIe7hTpRfmhl6wHnE1R3VypCEvyrcZd
	LnDCm+6OSg29/e22Cj4m1p9FEVzluzAd8ZdcZt07MZBmC/QDn2ooBKr9NuyOO2VV
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46kx53af3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 08:37:05 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 54DCb4KH041260
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 May 2025 08:37:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 13 May
 2025 08:37:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 May 2025 08:37:04 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 54DCanu1007560;
	Tue, 13 May 2025 08:36:51 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 10/10] iio: adc: ad4170: Add support for weigh scale and RTD sensors
Date: Tue, 13 May 2025 09:36:47 -0300
Message-ID: <c6d82e15c2b638ab40e7c8ef68b3bef959ce2946.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=a4sw9VSF c=1 sm=1 tr=0 ts=68233cf1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=dt9VzEwgFbYA:10 a=gAnH3GRIAAAA:8 a=WESGjA72igVXnEfjgT4A:9
X-Proofpoint-ORIG-GUID: O0gRRUqMJEKPvVzBUKjt1q-fiAJkys1x
X-Proofpoint-GUID: O0gRRUqMJEKPvVzBUKjt1q-fiAJkys1x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyMCBTYWx0ZWRfX+3LhfMJme69H
 U/0tA4S8Rpz+qZkLqDzhEh0LaE9KJMQ3xAVS+q5c/8ZeIzgcH/RkfYSUcK8/Of7ZWGf2Nhw2/1X
 kGDAXL6noM1kaqa/G8qFe/KEdzzPUMPfY0G7pRJ9C8lEoN//pyxQQ/Ab89iCSO72q8hdWj5ciTF
 3c61MS9qUebK3QQp4dNKX0sR+cZrvX8rXIw7ZMX3rzuXqvUQqRrpHRjwa8HbbSrCs6Ng+rqWCw2
 9Qkz3rkSU/J9fJN78XizdlTf2V+CiuH+GiQN8qvQTU8CQhjBa0SDEV0ckl7UJSXqhx0PjxgPtMA
 cdXRwCOZ1acJ2sh5eoRfbGL0uBPk9wxQ7pKV9o+r2ct++Wc526uGEMrJsvzD23YtB4RYdWEvlYl
 /uQFssoqrH8gSeIYWFN32JhNSObGqb2I35jyr+j3ErAOMFuMLJ0o0Tf2SM8TDh8i4RxKeiNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130120

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
Change log v2 -> v3
- Added trailing comma to ad4170_iout_current_ua_tbl array.
- Simplified AD4170_CURRENT_SRC_REG constants with macros.
- Used temporary variable to keep logical line wrapping of vbias calculation.
- Dropped ad4170_find_table_index() after open coding both uses of that.
- Extracted pin validation to reduce indentation.
- Inverted ad4170_setup_bridge() logic to reduce indentation.
- Used GPIO register masks to convey reg write meanings in ad4170_setup_bridge().
- Reworked ad4170_setup_current_src() to make it readable.

 drivers/iio/adc/ad4170.c | 419 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 415 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 1150c2e7ca1a..f80fbc6b663a 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -63,6 +63,8 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_V_BIAS_REG				0x135
+#define AD4170_CURRENT_SRC_REG(x)			(0x139 + 2 * (x))
 #define AD4170_GPIO_MODE_REG				0x191
 #define AD4170_GPIO_OUTPUT_REG				0x193
 #define AD4170_GPIO_INPUT_REG				0x195
@@ -94,6 +96,10 @@
 #define AD4170_CHAN_MAP_AINP_MSK			GENMASK(12, 8)
 #define AD4170_CHAN_MAP_AINM_MSK			GENMASK(4, 0)
 
+/* AD4170_MISC_REG */
+#define AD4170_MISC_CHOP_IEXC_MSK			GENMASK(15, 14)
+#define AD4170_MISC_CHOP_ADC_MSK			GENMASK(9, 8)
+
 /* AD4170_AFE_REG */
 #define AD4170_AFE_REF_BUF_M_MSK			GENMASK(11, 10)
 #define AD4170_AFE_REF_BUF_P_MSK			GENMASK(9, 8)
@@ -104,6 +110,10 @@
 /* AD4170_FILTER_REG */
 #define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
 
+/* AD4170_CURRENT_SRC_REG */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_MSK		GENMASK(12, 8)
+#define AD4170_CURRENT_SRC_I_OUT_VAL_MSK		GENMASK(2, 0)
+
 /* AD4170_GPIO_MODE_REG */
 #define AD4170_GPIO_MODE_GPIO0_MSK			GENMASK(1, 0)
 #define AD4170_GPIO_MODE_GPIO1_MSK			GENMASK(3, 2)
@@ -133,6 +143,11 @@
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
@@ -150,6 +165,10 @@
 #define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
 #define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
 
+/* AD4170_CURRENT_SRC_REG constants */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN(x)		(x)
+#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(x)		((x) + 17)
+
 /* AD4170_GPIO_MODE_REG constants */
 #define AD4170_GPIO_MODE_GPIO_INPUT			1
 #define AD4170_GPIO_MODE_GPIO_OUTPUT			2
@@ -163,6 +182,7 @@
 #define AD4170_MAX_SETUPS				8
 #define AD4170_INVALID_SETUP				9
 #define AD4170_SPI_MAX_XFER_LEN				6
+#define AD4170_NUM_CURRENT_SRC				4
 #define AD4170_DEFAULT_SAMP_RATE			(125 * HZ_PER_KHZ)
 
 #define AD4170_INT_REF_2_5V				2500000
@@ -186,9 +206,17 @@
 
 /* Analog pin functions  */
 #define AD4170_PIN_UNASIGNED				0x00
+#define AD4170_PIN_ANALOG_IN				0x01
+#define AD4170_PIN_CURRENT_OUT				0x02
+#define AD4170_PIN_VBIAS				0x04
 
 /* GPIO pin functions  */
 #define AD4170_GPIO_UNASIGNED				0x00
+#define AD4170_GPIO_AC_EXCITATION			0x02
+#define AD4170_GPIO_OUTPUT				0x04
+
+/* Current source */
+#define AD4170_CURRENT_SRC_DISABLED			0xFF
 
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
@@ -227,6 +255,8 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_V_BIAS_REG] = 2,
+	[AD4170_CURRENT_SRC_REG(0) ... AD4170_CURRENT_SRC_REG(3)] = 2,
 	[AD4170_GPIO_MODE_REG] = 2,
 	[AD4170_GPIO_OUTPUT_REG] = 2,
 	[AD4170_GPIO_INPUT_REG] = 2,
@@ -289,6 +319,33 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
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
+enum ad4170_sensor_type {
+	AD4170_WEIGH_SCALE_SENSOR = 0,
+	AD4170_RTD_SENSOR = 1,
+	AD4170_THERMOCOUPLE_SENSOR = 2,
+	AD4170_ADC_SENSOR = 3,
+};
+
 struct ad4170_chip_info {
 	const char *name;
 };
@@ -374,6 +431,7 @@ struct ad4170_state {
 	struct clk *ext_clk;
 	unsigned int clock_ctrl;
 	int gpio_fn[AD4170_NUM_GPIO_PINS];
+	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -931,6 +989,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
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
 
@@ -985,6 +1056,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
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
@@ -999,7 +1083,7 @@ static int ad4170_validate_channel_input(struct ad4170_state *st, int pin, bool
 				     "Invalid analog input pin number. %d\n",
 				     pin);
 
-	return 0;
+	return ad4170_validate_analog_input(st, pin);
 }
 
 /*
@@ -1765,6 +1849,304 @@ static int ad4170_gpio_init(struct iio_dev *indio_dev)
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
+		if (st->pins_fn[pin] != AD4170_PIN_UNASIGNED)
+			return dev_err_probe(dev, -EINVAL,
+					     "Pin %u already used with fn %u\n",
+					     pin, st->pins_fn[pin]);
+
+		st->pins_fn[pin] |= AD4170_PIN_CURRENT_OUT;
+	} else {
+		unsigned int gpio = pin - AD4170_CURRENT_SRC_I_OUT_PIN_GPIO(0);
+
+		if (st->gpio_fn[gpio] != AD4170_GPIO_UNASIGNED)
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
+		unsigned int pin = exc_pins[i];
+
+		ret = ad4170_validate_excitation_pin(st, pin);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int ad4170_setup_current_src(struct ad4170_state *st,
+				    struct fwnode_handle *child,
+				    struct ad4170_setup *setup, u32 *exc_pins,
+				    int num_exc_pins, int exc_cur, bool ac_excited)
+{
+	unsigned int exc_cur_pair, i;
+	unsigned int current_src = 0;
+	int ret;
+
+	for (i = 0; i < num_exc_pins; i++) {
+		unsigned int pin = exc_pins[i];
+
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK, pin);
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK, exc_cur);
+
+		ret = regmap_write(st->regmap, AD4170_CURRENT_SRC_REG(i),
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
+		for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++) {
+			unsigned int pin = exc_pins[i];
+
+			if (st->cur_src_pins[i] != AD4170_CURRENT_SRC_DISABLED)
+				return dev_err_probe(&st->spi->dev, -EINVAL,
+						     "Unable to use 4 exc pins\n");
+
+			st->cur_src_pins[i] = pin;
+		}
+	} else {
+		/*
+		 * Excitation current chopping is configured in pairs. Current
+		 * sources IOUT0 and IOUT1 form pair 1, IOUT2 and IOUT3 make up
+		 * pair 2. So, if current chopping was requested, check if the
+		 * first end of the first pair of excitation currents is
+		 * available. Try the next pair if IOUT0 has already been
+		 * configured for another channel.
+		 */
+		i = st->cur_src_pins[0] == AD4170_CURRENT_SRC_DISABLED ? 0 : 2;
+
+		if (st->cur_src_pins[i] != AD4170_CURRENT_SRC_DISABLED ||
+		    st->cur_src_pins[i + 1] != AD4170_CURRENT_SRC_DISABLED)
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
+			       int num_exc_pins, int exc_cur, bool ac_excited)
+{
+	unsigned long gpio_mask;
+	int ret;
+
+	/*
+	 * If a specific current is provided through
+	 * adi,excitation-current-microamp, set excitation pins provided through
+	 * adi,excitation-pins to excite the bridge circuit.
+	 */
+	if (exc_cur > 0)
+		return ad4170_setup_current_src(st, child, setup, exc_pins,
+						num_exc_pins, exc_cur,
+						ac_excited);
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
+	 * an example circuit diagram.
+	 */
+	if (num_exc_pins == 2) {
+		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x3);
+
+		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK | AD4170_GPIO_MODE_GPIO2_MSK;
+		ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
+					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 3) |
+					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 2));
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(st->regmap,
+				      AD4170_GPIO_OUTPUT_REG,
+				      BIT(3) | BIT(2));
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
+					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 3) |
+					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 2) |
+					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 1) |
+					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 0));
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(st->regmap,
+				      AD4170_GPIO_OUTPUT_REG,
+				      BIT(3) | BIT(2) | BIT(1) | BIT(0));
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
+			    int num_exc_pins, int exc_cur, bool ac_excited)
+{
+	return ad4170_setup_current_src(st, child, setup, exc_pins,
+					num_exc_pins, exc_cur, ac_excited);
+}
+
+static int ad4170_parse_external_sensor(struct ad4170_state *st,
+					struct fwnode_handle *child,
+					struct ad4170_setup *setup,
+					struct iio_chan_spec *chan, u8 s_type)
+{
+	unsigned int num_exc_pins, exc_cur, reg_val;
+	struct device *dev = &st->spi->dev;
+	u32 pins[2], exc_pins[4];
+	bool ac_excited, vbias;
+	unsigned int i;
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
+	ac_excited = fwnode_property_read_bool(child, "adi,excitation-ac");
+
+	num_exc_pins = fwnode_property_count_u32(child, "adi,excitation-pins");
+	if (num_exc_pins != 1 && num_exc_pins != 2 && num_exc_pins != 4)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid number of excitation pins\n");
+
+	ret = fwnode_property_read_u32_array(child, "adi,excitation-pins",
+					     exc_pins, num_exc_pins);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read adi,excitation-pins\n");
+
+	ret = ad4170_validate_excitation_pins(st, exc_pins, num_exc_pins);
+	if (ret)
+		return ret;
+
+	exc_cur = 0;
+	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
+				       &exc_cur);
+	if (ret && s_type == AD4170_RTD_SENSOR)
+		return dev_err_probe(dev, ret,
+				     "Failed to read adi,excitation-current-microamp\n");
+
+	for (i = 0; i < ARRAY_SIZE(ad4170_iout_current_ua_tbl); i++)
+		if (ad4170_iout_current_ua_tbl[i] == exc_cur)
+			break;
+
+	if (i == ARRAY_SIZE(ad4170_iout_current_ua_tbl))
+		return dev_err_probe(dev, ret,
+				     "Invalid excitation current: %uuA\n",
+				     exc_cur);
+
+	/* Get the excitation current configuration value */
+	exc_cur = ret;
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
+	if (s_type == AD4170_WEIGH_SCALE_SENSOR) {
+		ret = ad4170_setup_bridge(st, child, setup, exc_pins,
+					  num_exc_pins, exc_cur, ac_excited);
+	} else {
+		ret = ad4170_setup_rtd(st, child, setup, exc_pins, num_exc_pins,
+				       exc_cur, ac_excited);
+	}
+	return ret;
+}
+
 static int ad4170_parse_reference(struct ad4170_state *st,
 				  struct fwnode_handle *child,
 				  struct ad4170_setup *setup)
@@ -1849,6 +2231,7 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
 	struct ad4170_chan_info *chan_info;
+	u8 s_type = AD4170_ADC_SENSOR;
 	struct ad4170_setup *setup;
 	struct iio_chan_spec *chan;
 	unsigned int ch_reg;
@@ -1880,10 +2263,32 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = ad4170_parse_adc_channel_type(dev, child, chan);
-	if (ret < 0)
-		return ret;
+	ret = fwnode_property_read_u8(child, "adi,sensor-type", &s_type);
+	if (!ret) {
+		if (s_type > AD4170_THERMOCOUPLE_SENSOR)
+			return dev_err_probe(dev, ret,
+					     "Invalid adi,sensor-type: %u\n",
+					     s_type);
+	}
+	switch (s_type) {
+	case AD4170_ADC_SENSOR:
+		ret = ad4170_parse_adc_channel_type(dev, child, chan);
+		if (ret)
+			return ret;
 
+		break;
+	case AD4170_WEIGH_SCALE_SENSOR:
+	case AD4170_THERMOCOUPLE_SENSOR:
+	case AD4170_RTD_SENSOR:
+		ret = ad4170_parse_external_sensor(st, child, setup, chan,
+						   s_type);
+		if (ret)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
 	bipolar = fwnode_property_read_bool(child, "bipolar");
 	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
 	if (bipolar)
@@ -2087,6 +2492,12 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
 		st->pins_fn[i] = AD4170_PIN_UNASIGNED;
 
+	for (i = 0; i < AD4170_NUM_GPIO_PINS; i++)
+		st->gpio_fn[i] = AD4170_GPIO_UNASIGNED;
+
+	for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++)
+		st->cur_src_pins[i] = AD4170_CURRENT_SRC_DISABLED;
+
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	st->int_pin_sel = AD4170_INT_PIN_SDO;
 	ret = device_property_match_property_string(dev, "interrupt-names",
-- 
2.47.2


