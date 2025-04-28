Return-Path: <linux-iio+bounces-18776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C8A9F0BA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 14:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A04A1A8288C
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 12:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DB8269D16;
	Mon, 28 Apr 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uCzhpyJo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2E1DED70;
	Mon, 28 Apr 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745843416; cv=none; b=OHo8R7kf6iPskArTh5TkOzsesLFZMGiATmFr2rmZqrNjqeyMOqcxDiHnC7CO/vKVat9UUECwM/+olnhXdmkNgvxLpOl4Zt1uRKEZoT3UqpnGA9HpgFOYoI1dxpWB7JHUB9pen2QMKgXBCI+1LYCmOj8tsRr92lDE2xDS3p/crKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745843416; c=relaxed/simple;
	bh=3BbKXe7Zc+RvdFk6D2uK/LuyvPLJdqo/N/svjQb8hpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0TPx9PVABLDOUBy9QeoqYwNCqsXf2nRYXZCyPdAytaHJrGKrBPmjtSnEjGzeQpYBorFkb9rIsluuL1PIWPjoksXf+0XqLv0Auw3aqydoMh6s/Mp3Gr874Wy0pdWIlGSku+qstQ/qnv/Z+cqBaAMYvGyceNZEfxO9n9NWZIyqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uCzhpyJo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAmjNv027378;
	Mon, 28 Apr 2025 08:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pz4FK
	ufwXFREbwem8o+20KQ8D3cSpfBzKcleqbS4UR4=; b=uCzhpyJo6reJIqM7mcjVN
	pLzXPV6dBXihwwhy9SWUJt98TpIXPY7/hass3adY05+BvdPYtVu0sPnsUWqZK68u
	Qxr4SySE4AK9FuVtEaTzsZLGKq1+Lg4DE4x4YuB8FOAKjT3fzaJg3w9RXn+9xSXu
	TTpid8OdonulcbCBw4nxxBO0pFyowITEXnb1++Ab/18WVZK/rYjIRUvsr02Wogfw
	wVQikWgPiDQu2xJb97bqLPR2o4dVqrxz055vNONMa45W9mpCWzwbkMs0j67+1Tba
	toSmUdowTicybD8gbffIREioTVCBXl3hbl26+/xCwcaYHzC3pcoVrWGewTbBvqkb
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 469dtgh6gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 08:29:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53SCTv4c038281
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Apr 2025 08:29:57 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:29:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 28 Apr 2025 08:29:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 28 Apr 2025 08:29:56 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53SCTfnq032557;
	Mon, 28 Apr 2025 08:29:43 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 7/7] iio: adc: ad4170: Add support for weigh scale and RTD sensors
Date: Mon, 28 Apr 2025 09:29:40 -0300
Message-ID: <3687a9e0a479aef9736ad557b341ed2e7d4f5756.1745841276.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1745841276.git.marcelo.schmitt@analog.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwMyBTYWx0ZWRfXx99SX91XRjsg Ov30wG8jSMBnlp6CuOjmcnnfGK/XEu7If6y5Y6F4zN+z6Qa0bpxsFmXRY3D0g8ow+VRN9+b0OWh 3WMn388FZGV9zy3jT53aZnLSjK9ZiGx+uHy3iOoLNaqXGDrX1SaVXxIoBprGdKGQralQ2PrQiwn
 I2RDyjrVU5jpDKUGllgjpyQl2FkzchkijoD0hFaJhBmnnPQVvU6TAcehP7D8VOloKA7h5qwPzZZ P7cv9c9GFL5QEMkD/sZg6OE3bYgXdnAoIRrPKvAmfnWbMtuTnWt08lfajWgFZbZnDeEwk9mBSvg 3tQylq1q4tKCArM4jGtHOqE+OyrNq9YDK2RPdt0CsE0ApV2pA1N0hA+oD2hFu6BKJ2vibnKyzNr
 dZgUcdkJZ3+Wt3VLRJ9+ZpA6gyxxLLsRGgDaPBg56DmyHf8oyjaHYIIc0ZbSiHqIJgAMFUeT
X-Proofpoint-ORIG-GUID: hDFRSFgkuj43S2OyJFDHFpO80R39CEby
X-Proofpoint-GUID: hDFRSFgkuj43S2OyJFDHFpO80R39CEby
X-Authority-Analysis: v=2.4 cv=crybk04i c=1 sm=1 tr=0 ts=680f74c6 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=803P3kdnwzmVfup4ueMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504280103

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
changes since v1:
- Improved to support more than one external sensor connected.

 drivers/iio/adc/ad4170.c | 375 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 372 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 335b4194c7eb..9e4a9b524dd4 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -62,6 +62,8 @@
 #define AD4170_FILTER_FS_REG(x)				(0xC7 + 14 * (x))
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
+#define AD4170_V_BIAS_REG				0x135
+#define AD4170_CURRENT_SRC_REG(x)			(0x139 + 2 * (x))
 #define AD4170_GPIO_MODE_REG				0x191
 #define AD4170_GPIO_OUTPUT_REG				0x193
 #define AD4170_GPIO_INPUT_REG				0x195
@@ -110,6 +112,10 @@
 /* AD4170_FILTER_REG */
 #define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
 
+/* AD4170_CURRENT_SRC_REG */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_MSK		GENMASK(12, 8)
+#define AD4170_CURRENT_SRC_I_OUT_VAL_MSK		GENMASK(2, 0)
+
 /* AD4170 register constants */
 
 /* AD4170_CLOCK_CTRL_REG constants */
@@ -171,6 +177,21 @@
 #define AD4170_FILTER_FILTER_TYPE_SINC5			0x4
 #define AD4170_FILTER_FILTER_TYPE_SINC3			0x6
 
+/* AD4170_CURRENT_SRC_REG constants */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN0		0
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN1		1
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN2		2
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN3		3
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN4		4
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN5		5
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN6		6
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN7		7
+#define AD4170_CURRENT_SRC_I_OUT_PIN_AIN8		8
+#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0		17
+#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO1		18
+#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO2		19
+#define AD4170_CURRENT_SRC_I_OUT_PIN_GPIO3		20
+
 /* Device properties and auxiliary constants */
 
 #define AD4170_NUM_ANALOG_PINS				9
@@ -204,6 +225,15 @@
 #define AD4170_PIN_UNASIGNED				0x00
 #define AD4170_PIN_ANALOG_IN				0x01
 #define AD4170_PIN_CURRENT_OUT				0x02
+#define AD4170_PIN_VBIAS				0x04
+
+/* GPIO pin functions  */
+#define AD4170_GPIO_UNASIGNED				0x00
+#define AD4170_GPIO_AC_EXCITATION			0x02
+#define AD4170_GPIO_OUTPUT				0x04
+
+/* Current source */
+#define AD4170_CURRENT_SRC_DISABLED			0xFF
 
 static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
@@ -244,6 +274,8 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_OFFSET_REG(5) ... AD4170_GAIN_REG(5)] = 3,
 	[AD4170_OFFSET_REG(6) ... AD4170_GAIN_REG(6)] = 3,
 	[AD4170_OFFSET_REG(7) ... AD4170_GAIN_REG(7)] = 3,
+	[AD4170_V_BIAS_REG] = 2,
+	[AD4170_CURRENT_SRC_REG(0) ... AD4170_CURRENT_SRC_REG(3)] = 2,
 	[AD4170_GPIO_MODE_REG] = 2,
 	[AD4170_GPIO_OUTPUT_REG] = 2,
 	[AD4170_GPIO_INPUT_REG] = 2,
@@ -305,6 +337,33 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
 	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256,
 };
 
+static const unsigned int ad4170_iout_pin_tbl[] = {
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN0,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN1,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN2,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN3,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN4,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN5,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN6,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN7,
+	AD4170_CURRENT_SRC_I_OUT_PIN_AIN8,
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0,
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO1,
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO2,
+	AD4170_CURRENT_SRC_I_OUT_PIN_GPIO3,
+};
+
+static const unsigned int ad4170_iout_current_ua_tbl[] = {
+	0, 10, 50, 100, 250, 500, 1000, 1500
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
@@ -378,6 +437,8 @@ struct ad4170_state {
 	struct clk *ext_clk;
 	struct clk_hw int_clk_hw;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
+	int gpio_fn[AD4170_NUM_GPIO_PINS];
+	unsigned int cur_src_pins[AD4170_NUM_CURRENT_SRC];
 	struct gpio_chip gpiochip;
 	u32 int_pin_sel;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
@@ -925,6 +986,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
 	struct device *dev = &st->spi->dev;
 
 	*ain_voltage = 0;
+	/*
+	 * The voltage bias (vbias) sets the common-mode voltage of the channel
+	 * to (AVDD + AVSS)/2. If provided, AVSS supply provides the magnitude
+	 * (absolute value) of the negative voltage supplied to the AVSS pin.
+	 * So, we do AVDD - AVSS to compute the DC voltage generated by the bias
+	 * voltage generator.
+	 */
+	if (st->pins_fn[ain_n] & AD4170_PIN_VBIAS) {
+		*ain_voltage = (st->vrefs_uv[AD4170_AVDD_SUP]
+				- st->vrefs_uv[AD4170_AVSS_SUP]) / 2;
+		return 0;
+	}
+
 	if (ain_n <= AD4170_CHAN_MAP_TEMP_SENSOR)
 		return 0;
 
@@ -1742,6 +1816,266 @@ static int ad4170_gpio_init(struct iio_dev *indio_dev)
 	return devm_gpiochip_add_data(&st->spi->dev, &st->gpiochip, indio_dev);
 }
 
+static int _ad4170_find_table_index(const unsigned int *tbl, size_t len,
+				    unsigned int val)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i++)
+		if (tbl[i] == val)
+			return i;
+
+	return -EINVAL;
+}
+
+#define ad4170_find_table_index(table, val) \
+	_ad4170_find_table_index(table, ARRAY_SIZE(table), val)
+
+static int ad4170_validate_excitation_pins(struct ad4170_state *st,
+					   u32 *exc_pins, int num_exc_pins)
+{
+	struct device *dev = &st->spi->dev;
+	int ret, i;
+
+	for (i = 0; i < num_exc_pins; i++) {
+		unsigned int pin = exc_pins[i];
+
+		ret = ad4170_find_table_index(ad4170_iout_pin_tbl, pin);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Invalid excitation pin: %u\n",
+					     pin);
+
+		if (pin <= AD4170_MAX_ANALOG_PINS) {
+			if (st->pins_fn[pin] != AD4170_PIN_UNASIGNED)
+				return dev_err_probe(dev, -EINVAL,
+						     "Pin %u already used with fn %u\n",
+						     pin, st->pins_fn[pin]);
+
+			st->pins_fn[pin] |= AD4170_PIN_CURRENT_OUT;
+		} else {
+			unsigned int gpio = pin - AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0;
+
+			if (st->gpio_fn[gpio] != AD4170_GPIO_UNASIGNED)
+				return dev_err_probe(dev, -EINVAL,
+						     "GPIO %u already used with fn %u\n",
+						     gpio, st->gpio_fn[gpio]);
+
+			st->gpio_fn[gpio] |= AD4170_GPIO_AC_EXCITATION;
+		}
+	}
+	return 0;
+}
+
+static int ad4170_setup_current_src(struct ad4170_state *st,
+				    struct fwnode_handle *child,
+				    struct ad4170_setup *setup, u32 *exc_pins,
+				    int num_exc_pins, int exc_cur, bool ac_excited)
+{
+	unsigned int current_src, i, j;
+	int ret;
+
+	for (i = 0; i < num_exc_pins; i++) {
+		unsigned int pin = exc_pins[i];
+
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK, pin);
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK, exc_cur);
+
+		for (j = 0; j < AD4170_NUM_CURRENT_SRC; j++) {
+			/*
+			 * Excitation current chopping is configured in pairs.
+			 * If current chopping configured and the first end of
+			 * the current source pair has already been assigned,
+			 * skip to the next pair of output currents.
+			 */
+			if (ac_excited && j % 2 != 0)
+				continue;
+
+			if (st->cur_src_pins[j] == AD4170_CURRENT_SRC_DISABLED) {
+				st->cur_src_pins[j] = pin;
+				break;
+			}
+		}
+		if (j == AD4170_NUM_CURRENT_SRC)
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "Failed to setup IOUT at pin %u\n",
+					     pin);
+
+		ret = regmap_write(st->regmap, AD4170_CURRENT_SRC_REG(j),
+				   current_src);
+		if (ret)
+			return ret;
+	}
+
+	if (ac_excited && num_exc_pins > 1) {
+		unsigned int exc_cur_pair;
+
+		if (st->cur_src_pins[0] == exc_pins[0])
+			exc_cur_pair = 1;
+		else
+			exc_cur_pair = 2;
+
+		/*
+		 * Configure excitation currents chopping.
+		 * Chop two pairs if using four excitation currents.
+		 */
+		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
+					  num_exc_pins == 2 ? exc_cur_pair : 3);
+	}
+
+	return 0;
+}
+
+static int ad4170_setup_bridge(struct ad4170_state *st,
+			       struct fwnode_handle *child,
+			       struct ad4170_setup *setup, u32 *exc_pins,
+			       int num_exc_pins, int exc_cur, bool ac_excited)
+{
+	int ret;
+
+	/*
+	 * If a specific current is provided through
+	 * adi,excitation-current-microamp, set excitation pins provided through
+	 * adi,excitation-pins to AC excite the bridge circuit. Else, use
+	 * predefined ACX1, ACX1 negated, ACX2, ACX2 negated signals to AC
+	 * excite the bridge. Those signals are output on GPIO2, GPIO0, GPIO3,
+	 * and GPIO1, respectively. If only two pins are specified for AC
+	 * excitation, use ACX1 and ACX2.
+	 *
+	 * Also, to avoid any short-circuit condition when more than one channel
+	 * is enabled, set GPIO2 and GPIO0 high, and set GPIO1 and GPIO3 low to
+	 * DC excite the bridge whenever a channel without AC excitation is
+	 * selected. That is needed because GPIO pins are controlled by the next
+	 * highest priority GPIO function when a channel doesn't enable AC
+	 * excitation. See datasheet Figure 113 Weigh Scale (AC Excitation) for
+	 * an example circuit diagram.
+	 */
+	if (exc_cur == 0 && ac_excited) {
+		if (num_exc_pins == 2) {
+			setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x3);
+			ret = regmap_set_bits(st->regmap,
+					      AD4170_GPIO_MODE_REG,
+					      BIT(7) | BIT(5));
+			if (ret)
+				return ret;
+
+			ret = regmap_set_bits(st->regmap,
+					      AD4170_GPIO_OUTPUT_REG,
+					      BIT(3) | BIT(2));
+			if (ret)
+				return ret;
+
+			st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
+			st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
+		} else {
+			setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x2);
+			ret = regmap_set_bits(st->regmap,
+					      AD4170_GPIO_MODE_REG,
+					      BIT(7) | BIT(5) | BIT(3) | BIT(1));
+			if (ret)
+				return ret;
+
+			ret = regmap_set_bits(st->regmap,
+					      AD4170_GPIO_OUTPUT_REG,
+					      BIT(3) | BIT(2) | BIT(1) | BIT(0));
+			if (ret)
+				return ret;
+
+			st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
+			st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
+			st->gpio_fn[1] |= AD4170_GPIO_OUTPUT;
+			st->gpio_fn[0] |= AD4170_GPIO_OUTPUT;
+		}
+
+		return 0;
+	}
+
+	return ad4170_setup_current_src(st, child, setup, exc_pins,
+					num_exc_pins, exc_cur, ac_excited);
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
+	ret = ad4170_find_table_index(ad4170_iout_current_ua_tbl, exc_cur);
+	if (ret < 0)
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
@@ -1823,6 +2157,7 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
 	struct ad4170_chan_info *chan_info;
+	u8 s_type = AD4170_ADC_SENSOR;
 	struct ad4170_setup *setup;
 	struct iio_chan_spec *chan;
 	unsigned int ch_reg;
@@ -1854,10 +2189,34 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
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
+		if (ret < 0)
+			return ret;
+
+		break;
+	case AD4170_WEIGH_SCALE_SENSOR:
+		fallthrough;
+	case AD4170_THERMOCOUPLE_SENSOR:
+		fallthrough;
+	case AD4170_RTD_SENSOR:
+		ret = ad4170_parse_external_sensor(st, child, setup, chan,
+						   s_type);
+		if (ret < 0)
+			return ret;
 
+		break;
+	default:
+		return -EINVAL;
+	}
 	bipolar = fwnode_property_read_bool(child, "bipolar");
 	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
 	if (bipolar)
@@ -2059,6 +2418,12 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
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
@@ -2083,6 +2448,10 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 
 	/* Only create a GPIO chip if flagged for it */
 	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
+		for (i = 0; i < AD4170_NUM_GPIO_PINS; i++)
+			if (st->gpio_fn[i] != AD4170_GPIO_UNASIGNED)
+				return 0;
+
 		ret = ad4170_gpio_init(indio_dev);
 		if (ret)
 			return ret;
-- 
2.47.2


