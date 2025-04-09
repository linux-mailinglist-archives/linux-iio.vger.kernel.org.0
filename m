Return-Path: <linux-iio+bounces-17872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BB0A824D7
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 14:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8C51BC0F3D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30914264FBA;
	Wed,  9 Apr 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UOhhc1wZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAC245031;
	Wed,  9 Apr 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201618; cv=none; b=mSJ6DJr5L5Lfpx6aQiCZrjx82hT2JF6V55Zp63rUEYNUFKlSI1LXF3dXRKynQtoSUM+1b1Dp95S7CYggqxHf7RilPkbg0ao099lp0tNPmsK/rJpmxClQXjBYHYnLfvpI9/K7plqwGBCjtmFWc4ezkCNkDRu4THpX7h4Gn7/X+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201618; c=relaxed/simple;
	bh=7ly4YrsdN0QW2qLgBuSqLWWxmoMTauIezIw79eucUw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5vg9RKzL3Gsp+uQH0lNg6HUh8Zsf9hjobvVLa3tfI7HrYaA73h+M9RnIzIb2EZ9fwccI4f9IXFJfckCPzBUQ5Ba/A5jtWxPzepwom6ayav8nIoSdZgO9kSeDuyXuLbuDSWY0Ta118vS4alewKfywN9wH0QbFVZ1uyCzDnHtgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UOhhc1wZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399eLs6002723;
	Wed, 9 Apr 2025 08:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h/v+6
	mD3bVqnrnTTP8KGuWn1+wyqY9qGLX+GKjFwdC8=; b=UOhhc1wZe1wQdcJMLg38/
	0CGrjtIiSWufiUUOE4cL306PIDOoGHqrB0UY6tETfkVtkVg5DD4U57mCLc04WhdR
	8uZJEsNW7e5V6SDqan9JE0ZXVJjqcoBDQX4j7msLcMOZGPqrjPm+PlTRCaz9y6SF
	2ofLkmko9Utttehdu2Nt7dR0Z1IwYzDJHYuT4ojZ1rxE83LP92b+3D5kep81/SVc
	0L59X3IrhUDOOY7sqz4ky6biILzwBxgh7yZQ35LgU4ICmjNP71UvmUHsNo9puDd3
	G8efZEsMYpIB4mE5hV3/xfM+iyV8LqJTuP222NnAtlGrX367Z92TmxZRkinu0rtC
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45u1e6dqxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:26:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 539CQd1u042024
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Apr 2025 08:26:39 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 9 Apr 2025 08:26:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 9 Apr 2025 08:26:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 9 Apr 2025 08:26:39 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 539CQNMr016975;
	Wed, 9 Apr 2025 08:26:25 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 7/7] iio: adc: ad4170: Add support for weigh scale and RTD sensors
Date: Wed, 9 Apr 2025 09:26:22 -0300
Message-ID: <56e76070b72d15950bf1fb01e68e94c42e79905b.1744200264.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1744200264.git.marcelo.schmitt@analog.com>
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SkYVrmzOGcXFMGzjW5cK3-1w-Uo0dd5A
X-Authority-Analysis: v=2.4 cv=cdjSrmDM c=1 sm=1 tr=0 ts=67f66780 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=EiBr_KzpBCXFKVrstIUA:9
X-Proofpoint-GUID: SkYVrmzOGcXFMGzjW5cK3-1w-Uo0dd5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_04,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090073

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
 drivers/iio/adc/ad4170.c | 341 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 338 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index d204f8ca840f..2cf578608316 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -77,6 +77,7 @@
 #define AD4170_OFFSET_REG(x)				(0xCA + 14 * (x))
 #define AD4170_GAIN_REG(x)				(0xCD + 14 * (x))
 #define AD4170_V_BIAS_REG				0x135
+#define AD4170_CURRENT_SRC_REG(x)			(0x139 + 2 * (x))
 #define AD4170_FIR_CTRL					0x141
 #define AD4170_COEFF_DATA_REG				0x14A
 #define AD4170_COEFF_ADDR_REG				0x14C
@@ -127,6 +128,10 @@
 /* AD4170_FILTER_REG */
 #define AD4170_FILTER_FILTER_TYPE_MSK			GENMASK(3, 0)
 
+/* AD4170_CURRENT_SRC_REG */
+#define AD4170_CURRENT_SRC_I_OUT_PIN_MSK		GENMASK(12, 8)
+#define AD4170_CURRENT_SRC_I_OUT_VAL_MSK		GENMASK(2, 0)
+
 /* AD4170 register constants */
 
 /* AD4170_CLOCK_CTRL_REG constants */
@@ -188,6 +193,21 @@
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
@@ -222,6 +242,12 @@
 #define AD4170_PIN_UNASIGNED				0x00
 #define AD4170_PIN_ANALOG_IN				0x01
 #define AD4170_PIN_CURRENT_OUT				0x02
+#define AD4170_PIN_VBIAS				0x04
+
+/* GPIO pin functions  */
+#define AD4170_GPIO_UNASIGNED				0x00
+#define AD4170_GPIO_AC_EXCITATION			0x02
+#define AD4170_GPIO_OUTPUT				0x04
 
 enum ad4170_ref_buf {
 	AD4170_REF_BUF_PRE,	/* Pre-charge referrence buffer */
@@ -278,6 +304,33 @@ static const unsigned int ad4170_sinc5_filt_fs_tbl[] = {
 	1, 2, 4, 8, 12, 16, 20, 40, 48, 80, 100, 256
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
+	AD4170_ADC_SENSOR = 0,
+	AD4170_WEIGH_SCALE_SENSOR = 1,
+	AD4170_THERMOCOUPLE_SENSOR = 2,
+	AD4170_RTD_SENSOR = 3,
+};
+
 static const char * const ad4170_chip_names[] = {
 	"ad4170",
 	"ad4190",
@@ -343,6 +396,7 @@ struct ad4170_state {
 	struct clk *ext_clk;
 	struct clk_hw int_clk_hw;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
+	int gpio_fn[AD4170_NUM_GPIO_PINS];
 	struct gpio_chip gpiochip;
 	u32 int_pin_sel;
 	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
@@ -956,6 +1010,19 @@ static int ad4170_get_ain_voltage_uv(struct ad4170_state *st, int ain_n,
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
 
@@ -1746,6 +1813,242 @@ static int ad4170_gpio_init(struct iio_dev *indio_dev)
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
+			st->pins_fn[pin] = AD4170_PIN_CURRENT_OUT;
+		} else {
+			unsigned int gpio = pin - AD4170_CURRENT_SRC_I_OUT_PIN_GPIO0;
+
+			if (st->gpio_fn[gpio] != AD4170_GPIO_UNASIGNED)
+				return dev_err_probe(dev, -EINVAL,
+						     "GPIO %u already used with fn %u\n",
+						     gpio, st->gpio_fn[gpio]);
+
+			st->gpio_fn[gpio] = AD4170_GPIO_AC_EXCITATION;
+		}
+	}
+	return 0;
+}
+
+static int ad4170_setup_rtd(struct ad4170_state *st,
+			    struct fwnode_handle *child,
+			    struct ad4170_setup *setup, u32 *exc_pins,
+			    int num_exc_pins, int exc_cur, bool ac_excited)
+{
+	int current_src, ret, i;
+
+	for (i = 0; i < num_exc_pins; i++) {
+		unsigned int pin = exc_pins[i];
+
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK, pin);
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK, exc_cur);
+
+		ret = regmap_write(st->regmap16, AD4170_CURRENT_SRC_REG(i),
+				   current_src);
+		if (ret)
+			return ret;
+	}
+
+	if (ac_excited)
+		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
+					  num_exc_pins == 2 ? 0x2 : 0x3);
+
+	return 0;
+}
+
+static int ad4170_setup_bridge(struct ad4170_state *st,
+			       struct fwnode_handle *child,
+			       struct ad4170_setup *setup, u32 *exc_pins,
+			       int num_exc_pins, int exc_cur, bool ac_excited)
+{
+	int current_src, ret, i;
+
+	if (!ac_excited)
+		return 0;
+
+	/*
+	 * If a specific current is provided through
+	 * adi,excitation-current-microamp, set excitation pins provided through
+	 * adi,excitation-pins to AC excite the bridge circuit. Else, use
+	 * predefined ACX1, ACX1 negated, ACX2, ACX2 negated signals to AC
+	 * excite the bridge. Those signals are output on GPIO2, GPIO0, GPIO3,
+	 * and GPIO1, respectively. If only two pins are specified for AC
+	 * excitation, use ACX1 and ACX2. See AD4170 datasheet for instructions
+	 * on how to setup the bridge circuit.
+	 *
+	 * Also, to avoid any short-circuit condition when more than one channel
+	 * is enabled, set GPIO2 and GPIO0 high, and set GPIO1 and GPIO3 low to
+	 * DC excite the bridge whenever a channel without AC excitation is
+	 * selected. That is needed because GPIO pins are controlled by the next
+	 * highest priority GPIO function when a channel doesn't enable AC
+	 * excitation. See datasheet Figure 113 Weigh Scale (AC Excitation) for
+	 * an example circuit diagram.
+	 */
+	if (exc_cur == 0) {
+		if (num_exc_pins == 2) {
+			setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x3);
+			ret = regmap_set_bits(st->regmap16,
+					      AD4170_GPIO_MODE_REG,
+					      BIT(7) | BIT(5));
+			if (ret)
+				return ret;
+
+			ret = regmap_set_bits(st->regmap16,
+					      AD4170_GPIO_OUTPUT_REG,
+					      BIT(3) | BIT(2));
+			if (ret)
+				return ret;
+
+			st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
+			st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
+		} else {
+			setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x2);
+			ret = regmap_set_bits(st->regmap16,
+					      AD4170_GPIO_MODE_REG,
+					      BIT(7) | BIT(5) | BIT(3) | BIT(1));
+			if (ret)
+				return ret;
+
+			ret = regmap_set_bits(st->regmap16,
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
+	for (i = 0; i < num_exc_pins; i++) {
+		unsigned int pin = exc_pins[i];
+
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_PIN_MSK, pin);
+		current_src |= FIELD_PREP(AD4170_CURRENT_SRC_I_OUT_VAL_MSK, exc_cur);
+
+		ret = regmap_write(st->regmap16, AD4170_CURRENT_SRC_REG(i),
+				   current_src);
+		if (ret)
+			return ret;
+	}
+
+	setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_IEXC_MSK,
+				  num_exc_pins == 2 ? 0x2 : 0x3);
+
+	return 0;
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
+	ac_excited = fwnode_property_read_bool(child, "adi,ac-excited");
+
+	num_exc_pins = fwnode_property_count_u32(child, "adi,excitation-pins");
+	if (num_exc_pins != 2 && num_exc_pins != 4)
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
+			return regmap_write(st->regmap16, AD4170_V_BIAS_REG,
+					    reg_val);
+		}
+	}
+	if (s_type == AD4170_WEIGH_SCALE_SENSOR ||
+	    s_type == AD4170_THERMOCOUPLE_SENSOR) {
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
@@ -1827,6 +2130,7 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	struct ad4170_state *st = iio_priv(indio_dev);
 	struct device *dev = &st->spi->dev;
 	struct ad4170_chan_info *chan_info;
+	u8 s_type = AD4170_ADC_SENSOR;
 	struct ad4170_setup *setup;
 	struct iio_chan_spec *chan;
 	unsigned int ch_reg;
@@ -1857,10 +2161,34 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	ret = ad4170_parse_adc_channel_type(dev, child, chan);
-	if (ret < 0)
-		return ret;
+	ret = fwnode_property_read_u8(child, "adi,sensor-type", &s_type);
+	if (!ret) {
+		if (s_type > AD4170_RTD_SENSOR)
+			return dev_err_probe(dev, ret,
+					     "Invalid adi,sensor-type: %u\n",
+					     s_type);
+	}
+	switch (s_type) {
+	case AD4170_ADC_SENSOR:
+		ret = ad4170_parse_adc_channel_type(dev, child, chan);
+		if (ret < 0)
+			return ret;
 
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
+
+		break;
+	default:
+		return -EINVAL;
+	}
 	bipolar = fwnode_property_read_bool(child, "bipolar");
 	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
 	if (bipolar)
@@ -2057,6 +2385,9 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
 		st->pins_fn[i] = AD4170_PIN_UNASIGNED;
 
+	for (i = 0; i < AD4170_NUM_GPIO_PINS; i++)
+		st->gpio_fn[i] = AD4170_GPIO_UNASIGNED;
+
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	st->int_pin_sel = AD4170_INT_PIN_SDO;
 	ret = device_property_match_property_string(dev, "interrupt-names",
@@ -2081,6 +2412,10 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 
 	/* Only create a GPIO chip if flagged for it */
 	if (device_property_read_bool(&st->spi->dev, "gpio-controller")) {
+		for (i = 0; i < AD4170_NUM_GPIO_PINS; i++)
+			if (st->gpio_fn[i] != AD4170_GPIO_UNASIGNED)
+				return 0;
+
 		ret = ad4170_gpio_init(indio_dev);
 		if (ret < 0)
 			return ret;
-- 
2.47.2


