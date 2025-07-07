Return-Path: <linux-iio+bounces-21428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE40AFB552
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 15:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF863A8361
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112C329E114;
	Mon,  7 Jul 2025 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KDAexAiw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73F19D880;
	Mon,  7 Jul 2025 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896444; cv=none; b=cdccTYnnWcY849NwCnOkrYNqPadHjziy3/T56+CfFyi13yf9R894QzOcnPYKOzKP0LM0DYoYAAg2L+StOA0odnQs9aua3pmUnvkTlH6wGdzGlo6cQNlEd+c1XCsfQp4PJpRqBu+noq7hmDceAPIpavdu0GJXHMcE7lj56Y8HVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896444; c=relaxed/simple;
	bh=J1A8iWQjcMuOeqQijgpnAxD2NaWkOf+Q+qJ3xPARNn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcKcv61o6/pp3rIEFNrcSILCXWUHH9VEwArbpGwOHtaHKEit6gZjLjgeqUVkvHF3/yCnHxEn53MkU0HLHtfMZI83hD8JTXjgchNMM0ytotn9wtJt3oI4fYBrjZGypiJ6n0QQtd0Ovx0jkBNtY57BMNTXKXJJpqdoqjXsi/CqFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KDAexAiw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567CpX6b026979;
	Mon, 7 Jul 2025 09:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fxw+R
	spXaESBkmbcL392bFN6ba395HSCOvbOCOqR8KM=; b=KDAexAiweoXQtKTFz7Mmx
	QsWVKyGwOMgDYcXUfFIHx8gV8x6S8fZ9TXVOY1DihY59i2DD2Mz3xm2sSpJvPVfy
	rxUX0myr42EACM6rhLSu7ytDkdmeNL7/QHYpSwDknjNBMqaBbcFRRZSt9CvDZhuY
	223Pl9ZD7coq1yxueAQelSkHsuDHaLUxdpbJEIeD+MDq33a5ZND2mmmOIr8+fdXH
	MnDdiJglC+trJfhaw85u1GPUvuJacOLNUelvC8lYF1Vc14MNLD01V4TGc0t/Rd2A
	88fHVpFe9+cyQi6kg03KvKyCIwzAk8ie8z6OPe1ykMDu1u0dBw50aGXMv5hr5caw
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 47rayqh6yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:53:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 567DrjVO011765
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Jul 2025 09:53:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 7 Jul
 2025 09:53:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 7 Jul 2025 09:53:44 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 567DrS5Y016186;
	Mon, 7 Jul 2025 09:53:31 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <andriy.shevchenko@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 09/12] iio: adc: ad4170-4: Add clock provider support
Date: Mon, 7 Jul 2025 10:53:27 -0300
Message-ID: <68697c7613b1a69d752e541caef28d08b3e59bc1.1751895245.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1751895245.git.marcelo.schmitt@analog.com>
References: <cover.1751895245.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AP9nYgXq c=1 sm=1 tr=0 ts=686bd16a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=gAnH3GRIAAAA:8 a=YCMAGL58eHQI0dBkuO4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4MSBTYWx0ZWRfX187QqA2vBoH6
 Fb+LCmZzGMRQ4LIkYuR4EAIsoDnBou8DbgQipJX4JSWZ3ahpVhwRlQG2tH+X4DoILcwDQOyF5MU
 4DKfr6Yv2w1N4Kvf5xixJGzOFlLnpa/Cj3iBOJqCJgZ3vq7GJz5mgrUUNXLTw7Nv/NgtCV33ZL/
 uGS/0uW5xtY4mUb9Kn1DAFLoW5v48QUmtJcUuktY4mnAMFNBVogVQuHO+5KdBPnxF5qSB3/pWpx
 T7aACfZdVBaH7pt3dpXgsdQ/kLvheu3Bll23n72JbL/KvsWcQXjTfYLkFrn/CC6sk/v90ALLEMd
 9ZgQ/HB2Ga2I934LHlM0jT0skaVwHkS4KrjAmyLH74xmpH+g6SoDCawGHFdAOBnLYSQ/MEvKFlh
 Vnde+A2zldgHjTZYXgRi6PyYpeQIjgrakfeLjJYwbQSymaU1VWVLR3JcgcDOTE51JtjtqV6F
X-Proofpoint-ORIG-GUID: FdOewF1DhH4tG67S8On6a-4kNrQA-pf6
X-Proofpoint-GUID: FdOewF1DhH4tG67S8On6a-4kNrQA-pf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070081

The AD4170-4 chip can use an externally supplied clock at the XTAL2 pin, or
an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
the AD4170-4 can provide its 16 MHz internal clock at the XTAL2 pin. In
addition, the chip has a programmable clock divider that allows dividing
the external or internal clock frequency, however, control for that is not
provided in this patch. Extend the AD4170-4 driver so it effectively uses
the provided external clock, if any, or supplies its own clock as a clock
provider.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes since v6.

 drivers/iio/adc/Kconfig    |   1 +
 drivers/iio/adc/ad4170-4.c | 147 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 538929b3df6e..36e506e8d8f1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -91,6 +91,7 @@ config AD4170_4
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	depends on COMMON_CLK
 	help
 	  Say yes here to build support for Analog Devices AD4170-4 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index 30ae667a252c..32e52d24656a 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -13,6 +13,8 @@
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -55,6 +57,7 @@
 #define AD4170_CONFIG_A_REG				0x00
 #define AD4170_DATA_24B_REG				0x1E
 #define AD4170_PIN_MUXING_REG				0x69
+#define AD4170_CLOCK_CTRL_REG				0x6B
 #define AD4170_ADC_CTRL_REG				0x71
 #define AD4170_CHAN_EN_REG				0x79
 #define AD4170_CHAN_SETUP_REG(x)			(0x81 + 4 * (x))
@@ -75,6 +78,9 @@
 /* AD4170_PIN_MUXING_REG */
 #define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
 
+/* AD4170_CLOCK_CTRL_REG */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_MSK			GENMASK(1, 0)
+
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
 #define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
@@ -102,6 +108,12 @@
 
 /* AD4170 register constants */
 
+/* AD4170_CLOCK_CTRL_REG constants */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_INT			0x0
+#define AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT		0x1
+#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT			0x2
+#define AD4170_CLOCK_CTRL_CLOCKSEL_EXT_XTAL		0x3
+
 /* AD4170_CHAN_MAP_REG constants */
 #define AD4170_CHAN_MAP_AIN(x)			(x)
 #define AD4170_CHAN_MAP_TEMP_SENSOR		17
@@ -150,6 +162,8 @@
 
 /* Internal and external clock properties */
 #define AD4170_INT_CLOCK_16MHZ				(16 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * HZ_PER_MHZ)
 
 #define AD4170_NUM_PGA_OPTIONS				10
 
@@ -167,6 +181,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
 	[AD4170_PIN_MUXING_REG] = 2,
+	[AD4170_CLOCK_CTRL_REG] = 2,
 	[AD4170_ADC_CTRL_REG] = 2,
 	[AD4170_CHAN_EN_REG] = 2,
 	/*
@@ -239,6 +254,10 @@ enum ad4170_regulator {
 	AD4170_MAX_SUP,
 };
 
+static const char *const ad4170_clk_sel[] = {
+	"ext-clk", "xtal",
+};
+
 enum ad4170_int_pin_sel {
 	AD4170_INT_PIN_SDO,
 	AD4170_INT_PIN_DIG_AUX1,
@@ -343,6 +362,8 @@ struct ad4170_state {
 	struct spi_message msg;
 	struct spi_transfer xfer;
 	struct iio_trigger *trig;
+	struct clk_hw int_clk_hw;
+	unsigned int clock_ctrl;
 	unsigned int pins_fn[AD4170_NUM_ANALOG_PINS];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -1646,6 +1667,124 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static struct ad4170_state *clk_hw_to_ad4170(struct clk_hw *hw)
+{
+	return container_of(hw, struct ad4170_state, int_clk_hw);
+}
+
+static unsigned long ad4170_sel_clk(struct ad4170_state *st,
+				    unsigned int clk_sel)
+{
+	st->clock_ctrl &= ~AD4170_CLOCK_CTRL_CLOCKSEL_MSK;
+	st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, clk_sel);
+	return regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
+}
+
+static unsigned long ad4170_clk_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	return AD4170_INT_CLOCK_16MHZ;
+}
+
+static int ad4170_clk_output_is_enabled(struct clk_hw *hw)
+{
+	struct ad4170_state *st = clk_hw_to_ad4170(hw);
+	u32 clk_sel;
+
+	clk_sel = FIELD_GET(AD4170_CLOCK_CTRL_CLOCKSEL_MSK, st->clock_ctrl);
+	return clk_sel == AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT;
+}
+
+static int ad4170_clk_output_prepare(struct clk_hw *hw)
+{
+	struct ad4170_state *st = clk_hw_to_ad4170(hw);
+
+	return ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);
+}
+
+static void ad4170_clk_output_unprepare(struct clk_hw *hw)
+{
+	struct ad4170_state *st = clk_hw_to_ad4170(hw);
+
+	ad4170_sel_clk(st, AD4170_CLOCK_CTRL_CLOCKSEL_INT);
+}
+
+static const struct clk_ops ad4170_int_clk_ops = {
+	.recalc_rate = ad4170_clk_recalc_rate,
+	.is_enabled = ad4170_clk_output_is_enabled,
+	.prepare = ad4170_clk_output_prepare,
+	.unprepare = ad4170_clk_output_unprepare,
+};
+
+static int ad4170_register_clk_provider(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct clk_init_data init = {};
+	int ret;
+
+	if (device_property_read_string(dev, "clock-output-names", &init.name)) {
+		init.name = devm_kasprintf(dev, GFP_KERNEL, "%pfw",
+					   dev_fwnode(dev));
+		if (!init.name)
+			return -ENOMEM;
+	}
+
+	init.ops = &ad4170_int_clk_ops;
+
+	st->int_clk_hw.init = &init;
+	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &st->int_clk_hw);
+}
+
+static int ad4170_clock_select(struct iio_dev *indio_dev)
+{
+	struct ad4170_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	struct clk *ext_clk;
+	int ret;
+
+	ext_clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(ext_clk))
+		return dev_err_probe(dev, PTR_ERR(ext_clk),
+				     "Failed to get external clock\n");
+
+	if (!ext_clk) {
+		/* Use internal clock reference */
+		st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+		st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
+					     AD4170_CLOCK_CTRL_CLOCKSEL_INT_OUT);
+
+		if (!device_property_present(&st->spi->dev, "#clock-cells"))
+			return 0;
+
+		return ad4170_register_clk_provider(indio_dev);
+	}
+
+	/* Read optional clock-names prop to specify the external clock type */
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad4170_clk_sel,
+						    ARRAY_SIZE(ad4170_clk_sel));
+
+	ret = ret < 0 ? 0 : ret; /* Default to external clock if no clock-names */
+	st->clock_ctrl |= FIELD_PREP(AD4170_CLOCK_CTRL_CLOCKSEL_MSK,
+				     AD4170_CLOCK_CTRL_CLOCKSEL_EXT + ret);
+
+	st->mclk_hz = clk_get_rate(ext_clk);
+	if (st->mclk_hz < AD4170_EXT_CLOCK_MHZ_MIN ||
+	    st->mclk_hz > AD4170_EXT_CLOCK_MHZ_MAX) {
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid external clock frequency %u\n",
+				     st->mclk_hz);
+	}
+
+	return 0;
+}
+
 static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 {
 	struct ad4170_state *st = iio_priv(indio_dev);
@@ -1653,7 +1792,13 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
 	int reg_data, ret;
 	u32 int_pin_sel;
 
-	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+	ret = ad4170_clock_select(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup device clock\n");
+
+	ret = regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
+	if (ret)
+		return ret;
 
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	int_pin_sel = AD4170_INT_PIN_SDO;
-- 
2.47.2


