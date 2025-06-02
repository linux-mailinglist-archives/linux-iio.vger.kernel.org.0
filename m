Return-Path: <linux-iio+bounces-20133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80DFACAD60
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 13:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C93BDF4A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8E20E33D;
	Mon,  2 Jun 2025 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tQ7jzORs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B32C3278;
	Mon,  2 Jun 2025 11:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864388; cv=none; b=D0xdGYscXpw1TpCF5+wIQWOHEG2VkD0ROk8A4fI16AVUijcPrjd4tY+YGBfkdx+12soHgq66Ni+INfWwu+HnRWPVL1fjP+9NPI0mKR29JFlRvLRsK2TkYdawgjUYIHsZ/shyqD32OWDoXu+zyrwsYJ8vBNac8NiT5LIHSe63xVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864388; c=relaxed/simple;
	bh=H6XvMpB6xslzAfWLTfLpAMgd3l/c2CLHj7aMBco/h4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRa8ureWseaVkq8rncB5Ec8I3vaq3C6qu6h2zoEqqITKDc2U3Xyplc00KfkUQCnXSYeLNWgzV1DBSo8DvhGA/SY26YFHu8yFXWzhs/DG7JNhgyTVBwS7s30x5Ig53SKRDbEcoWUZ51gLAk194FQ2Bi7xcVXb1u7wbUN1H18gLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tQ7jzORs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552BG5NO018487;
	Mon, 2 Jun 2025 07:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=swmWB
	TqNFdso2yQt5qP2qddh/UlVZ4a5+V87qTqxBFQ=; b=tQ7jzORsyAA/QpGo4OL2f
	MyQnikqF0+WBWdZzTP2m7lNwzsDc0ZVNq2KEndoLmR/gDQxBrOUPYEllAf/e6O9n
	cud7qqADOdtbphShikHPGapktWYD2lmqy4krsbqsqrayQGIWGohXloSoxRHtdeEz
	Vs0bPbBQgGWQ1pp3JpgsOn7FrMaa2wX2uvv0Be5bh99jP9L0NV0SRXH4v4xJEp5T
	mTYikeSVIZPUga4YUmey+vO1QUoJXMVXBg62Gg+c8Fp52yRwUfzUMKsHK5HyWPA9
	B7HUk49gTS9I7EpQuyNzKx+GbjEhBl1ply8UdstCdcFwf8kkxLHa6zvvrozwwEDN
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 46yxdaqdfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 07:39:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 552BdSNl043351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Jun 2025 07:39:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:39:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 2 Jun 2025 07:39:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Jun 2025 07:39:27 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 552BdAn7024946;
	Mon, 2 Jun 2025 07:39:12 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 07/11] iio: adc: ad4170: Add clock provider support
Date: Mon, 2 Jun 2025 08:39:07 -0300
Message-ID: <b892011ebdf6d21968cfae04f8749f4b5e7cb2a5.1748829860.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfX5yI0WXGeJ6nk
 ERkIeEDxQt83XNbuCltR7HbawHoTmWj85JtHLYFkKmUyLGPVBoMCkKwIWA+1suFQrfUS6+qNwZa
 urL9uSk18yQ+9zHUKKZwMrsnhRmwrT5oItw+Zdb+R4VDo2jDc3vVQQHv45p4PMj/OUqzCGt+3rO
 R3UlZoOp/ssJAsypWEuwLGI3HKTmgO9gtQjvWbjt40C+RYdINV84FrJRDFVU0hrcu7mgmE3DFNr
 G/C/6th3ztrG7d62u0qGOl92Sgu9Os/74IjnlJuN7CtgOimPb6ucYQErSK3Qe4PXZxYl2XDXdgL
 3i2kFF4/jx7P5pvo1mC6tVzCejjiiwZoI6VtqIfAEEfP1HzGyuUyzKuru9559xkOM6orTH1bAMk
 NYeCm+tK5UmR4izOLMM/sOuXr9b1FQeuyyDrdnTjITS4lwloreOG7kaP4qUYs+Mxty3lZ5Kv
X-Proofpoint-ORIG-GUID: pwuNpBHu16UoPkdaG6QJYzgKIHUShhfE
X-Proofpoint-GUID: pwuNpBHu16UoPkdaG6QJYzgKIHUShhfE
X-Authority-Analysis: v=2.4 cv=S5XZwJsP c=1 sm=1 tr=0 ts=683d8d71 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=PYpcqj4_LR_AJ3e6G-wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2506020100

The AD4170 chip can use an externally supplied clock at the XTAL2 pin, or
an external crystal connected to the XTAL1 and XTAL2 pins. Alternatively,
the AD4170 can provide its 16 MHz internal clock at the XTAL2 pin. In
addition, the chip has a programmable clock divider that allows dividing
the external or internal clock frequency, however, control for that is not
provided in this patch. Extend the AD4170 driver so it effectively uses the
provided external clock, if any, or supplies its own clock as a clock
provider.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4
- Explicitly stated that clock divider (CLKDIV) control support is not provided.
- Skipped clock provider register if "#clock-cells" is not present.

Suggestions/comments not followed/applied:

> Shouldn't there be a dependency that if clocks is given, then clock-names is
> required.
It could be, but we have a default for clock-names so I think it's not needed.

> Do we need to claim direct mode here to avoid poking registers during a
> buffered read?
In this case, I don't think so. All of clock configuration is done during probe.
The IIO device will not be visible to user space at that moment. There should be
no need to protect register access during probe (unless another thread tries to
concurrently probe the device?).

> Why not just do the regmap_write() in ad4170_clock_select() to keep it all
> together?
ad4170_clock_select() has two return paths (one for internal and one for
external clock). We would have to duplicate the regmap_write() to have
that inside ad4170_clock_select().

> Seems like we would want to start in the AD4170_CLOCK_CTRL_CLOCKSEL_INT state.
I don't think so. We'll match clock-names either with 0 or 1 and that indicates
if the external clock is an input clock or a crystal. If it's ext-clk, we write
0x2 (2 + 0) to CLOCKSEL field. If it's xtal we write 0x3 (2 + 1).

 drivers/iio/adc/Kconfig  |   1 +
 drivers/iio/adc/ad4170.c | 147 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b12dcc04c894..32e5177ceebe 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -91,6 +91,7 @@ config AD4170
 	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	depends on COMMON_CLK
 	help
 	  Say yes here to build support for Analog Devices AD4170 SPI analog
 	  to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
index 86ef70acbf21..2173e79ce96c 100644
--- a/drivers/iio/adc/ad4170.c
+++ b/drivers/iio/adc/ad4170.c
@@ -10,6 +10,8 @@
 #include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -50,6 +52,7 @@
 #define AD4170_CONFIG_A_REG				0x00
 #define AD4170_DATA_24B_REG				0x1E
 #define AD4170_PIN_MUXING_REG				0x69
+#define AD4170_CLOCK_CTRL_REG				0x6B
 #define AD4170_ADC_CTRL_REG				0x71
 #define AD4170_CHAN_EN_REG				0x79
 #define AD4170_CHAN_SETUP_REG(x)			(0x81 + 4 * (x))
@@ -70,6 +73,9 @@
 /* AD4170_PIN_MUXING_REG */
 #define AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK		GENMASK(5, 4)
 
+/* AD4170_CLOCK_CTRL_REG */
+#define AD4170_CLOCK_CTRL_CLOCKSEL_MSK			GENMASK(1, 0)
+
 /* AD4170_ADC_CTRL_REG */
 #define AD4170_ADC_CTRL_MULTI_DATA_REG_SEL_MSK		BIT(7)
 #define AD4170_ADC_CTRL_CONT_READ_MSK			GENMASK(5, 4)
@@ -97,6 +103,12 @@
 
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
@@ -143,6 +155,8 @@
 
 /* Internal and external clock properties */
 #define AD4170_INT_CLOCK_16MHZ				(16 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * HZ_PER_MHZ)
+#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * HZ_PER_MHZ)
 
 #define AD4170_NUM_PGA_OPTIONS				10
 
@@ -160,6 +174,7 @@ static const unsigned int ad4170_reg_size[] = {
 	[AD4170_CONFIG_A_REG] = 1,
 	[AD4170_DATA_24B_REG] = 3,
 	[AD4170_PIN_MUXING_REG] = 2,
+	[AD4170_CLOCK_CTRL_REG] = 2,
 	[AD4170_ADC_CTRL_REG] = 2,
 	[AD4170_CHAN_EN_REG] = 2,
 	/*
@@ -225,6 +240,10 @@ enum ad4170_regulator {
 	AD4170_MAX_SUP
 };
 
+static const char *const ad4170_clk_sel[] = {
+	"ext-clk", "xtal",
+};
+
 enum ad4170_int_pin_sel {
 	AD4170_INT_PIN_SDO,
 	AD4170_INT_PIN_DIG_AUX1,
@@ -327,6 +346,8 @@ struct ad4170_state {
 	struct completion completion;
 	int pins_fn[AD4170_NUM_ANALOG_PINS];
 	u32 int_pin_sel;
+	struct clk_hw int_clk_hw;
+	unsigned int clock_ctrl;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -1610,13 +1631,137 @@ static int ad4170_parse_channels(struct iio_dev *indio_dev)
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
+		if (!device_property_read_bool(&st->spi->dev, "#clock-cells"))
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
 	struct device *dev = &st->spi->dev;
 	int reg_data, ret;
 
-	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
+	ret = ad4170_clock_select(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup device clock\n");
+
+	ret = regmap_write(st->regmap, AD4170_CLOCK_CTRL_REG, st->clock_ctrl);
+	if (ret)
+		return ret;
 
 	/* On power on, device defaults to using SDO pin for data ready signal */
 	st->int_pin_sel = AD4170_INT_PIN_SDO;
-- 
2.47.2


