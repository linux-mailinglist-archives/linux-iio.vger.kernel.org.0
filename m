Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E654FDB6
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2019 20:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFWSpZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jun 2019 14:45:25 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:60887 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFWSpZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jun 2019 14:45:25 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6FF74FF807;
        Sun, 23 Jun 2019 18:45:21 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 4/4] IIO: Ingenic JZ47xx: Add support for JZ4770 SoC ADC.
Date:   Sun, 23 Jun 2019 20:47:32 +0200
Message-Id: <20190623184732.5492-4-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623184732.5492-1-contact@artur-rojek.eu>
References: <20190623184732.5492-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the ADC hardware present on Ingenic JZ4770 SoC.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/ingenic-adc.c | 134 +++++++++++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index e234970b7150..68d1c3280d1a 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -25,9 +25,13 @@
 #define JZ_ADC_REG_ADSDAT		0x20
 #define JZ_ADC_REG_ADCLK		0x28
 
+#define JZ_ADC_REG_ENABLE_PD		BIT(7)
+#define JZ_ADC_REG_CFG_AUX_MD		(BIT(0) | BIT(1))
 #define JZ_ADC_REG_CFG_BAT_MD		BIT(4)
 #define JZ_ADC_REG_ADCLK_CLKDIV_LSB	0
-#define JZ_ADC_REG_ADCLK_CLKDIV10US_LSB	16
+#define JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB	16
+#define JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB	8
+#define JZ4770_ADC_REG_ADCLK_CLKDIVMS_LSB	16
 
 #define JZ_ADC_AUX_VREF				3300
 #define JZ_ADC_AUX_VREF_BITS			12
@@ -37,6 +41,8 @@
 #define JZ4725B_ADC_BATTERY_HIGH_VREF_BITS	10
 #define JZ4740_ADC_BATTERY_HIGH_VREF		(7500 * 0.986)
 #define JZ4740_ADC_BATTERY_HIGH_VREF_BITS	12
+#define JZ4770_ADC_BATTERY_VREF			6600
+#define JZ4770_ADC_BATTERY_VREF_BITS		12
 
 struct ingenic_adc;
 
@@ -47,6 +53,8 @@ struct ingenic_adc_soc_data {
 	size_t battery_raw_avail_size;
 	const int *battery_scale_avail;
 	size_t battery_scale_avail_size;
+	unsigned int battery_vref_mode: 1;
+	unsigned int has_aux2: 1;
 	int (*init_clk_div)(struct device *dev, struct ingenic_adc *adc);
 };
 
@@ -54,6 +62,7 @@ struct ingenic_adc {
 	void __iomem *base;
 	struct clk *clk;
 	struct mutex lock;
+	struct mutex aux_lock;
 	const struct ingenic_adc_soc_data *soc_data;
 	bool low_vref_mode;
 };
@@ -120,6 +129,8 @@ static int ingenic_adc_write_raw(struct iio_dev *iio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel) {
 		case INGENIC_ADC_BATTERY:
+			if (!adc->soc_data->battery_vref_mode)
+				return -EINVAL;
 			if (val > JZ_ADC_BATTERY_LOW_VREF) {
 				ingenic_adc_set_config(adc,
 						       JZ_ADC_REG_CFG_BAT_MD,
@@ -158,6 +169,14 @@ static const int jz4740_adc_battery_scale_avail[] = {
 	JZ_ADC_BATTERY_LOW_VREF, JZ_ADC_BATTERY_LOW_VREF_BITS,
 };
 
+static const int jz4770_adc_battery_raw_avail[] = {
+	0, 1, (1 << JZ4770_ADC_BATTERY_VREF_BITS) - 1,
+};
+
+static const int jz4770_adc_battery_scale_avail[] = {
+	JZ4770_ADC_BATTERY_VREF, JZ4770_ADC_BATTERY_VREF_BITS,
+};
+
 static int jz4725b_adc_init_clk_div(struct device *dev, struct ingenic_adc *adc)
 {
 	struct clk *parent_clk;
@@ -187,7 +206,45 @@ static int jz4725b_adc_init_clk_div(struct device *dev, struct ingenic_adc *adc)
 	/* We also need a divider that produces a 10us clock. */
 	div_10us = DIV_ROUND_UP(rate, 100000);
 
-	writel(((div_10us - 1) << JZ_ADC_REG_ADCLK_CLKDIV10US_LSB) |
+	writel(((div_10us - 1) << JZ4725B_ADC_REG_ADCLK_CLKDIV10US_LSB) |
+	       (div_main - 1) << JZ_ADC_REG_ADCLK_CLKDIV_LSB,
+	       adc->base + JZ_ADC_REG_ADCLK);
+
+	return 0;
+}
+
+static int jz4770_adc_init_clk_div(struct device *dev, struct ingenic_adc *adc)
+{
+	struct clk *parent_clk;
+	unsigned long parent_rate, rate;
+	unsigned int div_main, div_ms, div_10us;
+
+	parent_clk = clk_get_parent(adc->clk);
+	if (!parent_clk) {
+		dev_err(dev, "ADC clock has no parent\n");
+		return -ENODEV;
+	}
+	parent_rate = clk_get_rate(parent_clk);
+
+	/*
+	 * The JZ4770 ADC works at 20 kHz to 200 kHz.
+	 * We pick the highest rate possible.
+	 */
+	div_main = DIV_ROUND_UP(parent_rate, 200000);
+	div_main = clamp(div_main, 1u, 256u);
+	rate = parent_rate / div_main;
+	if (rate < 20000 || rate > 200000) {
+		dev_err(dev, "No valid divider for ADC main clock\n");
+		return -EINVAL;
+	}
+
+	/* We also need a divider that produces a 10us clock. */
+	div_10us = DIV_ROUND_UP(rate, 10000);
+	/* And another, which produces a 1ms clock. */
+	div_ms = DIV_ROUND_UP(rate, 1000);
+
+	writel(((div_ms - 1) << JZ4770_ADC_REG_ADCLK_CLKDIVMS_LSB) |
+	       ((div_10us - 1) << JZ4770_ADC_REG_ADCLK_CLKDIV10US_LSB) |
 	       (div_main - 1) << JZ_ADC_REG_ADCLK_CLKDIV_LSB,
 	       adc->base + JZ_ADC_REG_ADCLK);
 
@@ -201,6 +258,8 @@ static const struct ingenic_adc_soc_data jz4725b_adc_soc_data = {
 	.battery_raw_avail_size = ARRAY_SIZE(jz4725b_adc_battery_raw_avail),
 	.battery_scale_avail = jz4725b_adc_battery_scale_avail,
 	.battery_scale_avail_size = ARRAY_SIZE(jz4725b_adc_battery_scale_avail),
+	.battery_vref_mode = true,
+	.has_aux2 = false,
 	.init_clk_div = jz4725b_adc_init_clk_div,
 };
 
@@ -211,9 +270,23 @@ static const struct ingenic_adc_soc_data jz4740_adc_soc_data = {
 	.battery_raw_avail_size = ARRAY_SIZE(jz4740_adc_battery_raw_avail),
 	.battery_scale_avail = jz4740_adc_battery_scale_avail,
 	.battery_scale_avail_size = ARRAY_SIZE(jz4740_adc_battery_scale_avail),
+	.battery_vref_mode = true,
+	.has_aux2 = false,
 	.init_clk_div = NULL, /* no ADCLK register on JZ4740 */
 };
 
+static const struct ingenic_adc_soc_data jz4770_adc_soc_data = {
+	.battery_high_vref = JZ4770_ADC_BATTERY_VREF,
+	.battery_high_vref_bits = JZ4770_ADC_BATTERY_VREF_BITS,
+	.battery_raw_avail = jz4770_adc_battery_raw_avail,
+	.battery_raw_avail_size = ARRAY_SIZE(jz4770_adc_battery_raw_avail),
+	.battery_scale_avail = jz4770_adc_battery_scale_avail,
+	.battery_scale_avail_size = ARRAY_SIZE(jz4770_adc_battery_scale_avail),
+	.battery_vref_mode = false,
+	.has_aux2 = true,
+	.init_clk_div = jz4770_adc_init_clk_div,
+};
+
 static int ingenic_adc_read_avail(struct iio_dev *iio_dev,
 				  struct iio_chan_spec const *chan,
 				  const int **vals,
@@ -246,19 +319,37 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 				long m)
 {
 	struct ingenic_adc *adc = iio_priv(iio_dev);
-	int ret;
+	struct mutex *lock = NULL;
+	int bit, ret, engine = 0;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		clk_enable(adc->clk);
-		ret = ingenic_adc_capture(adc, chan->channel);
-		if (ret) {
-			clk_disable(adc->clk);
-			return ret;
+		switch (chan->channel) {
+		case INGENIC_ADC_AUX:
+		case INGENIC_ADC_AUX2:
+			if (adc->soc_data->has_aux2)
+				lock = &adc->aux_lock;
+			break;
+		case INGENIC_ADC_BATTERY:
+			engine = 1;
+			break;
 		}
 
+		if (lock) /* We cannot sample AUX/AUX2 in parallel. */
+			mutex_lock(lock);
+		if (adc->soc_data->has_aux2 && engine == 0) {
+			bit = BIT(chan->channel == INGENIC_ADC_AUX2);
+			ingenic_adc_set_config(adc, JZ_ADC_REG_CFG_AUX_MD, bit);
+		}
+
+		clk_enable(adc->clk);
+		ret = ingenic_adc_capture(adc, engine);
+		if (ret)
+			goto out;
+
 		switch (chan->channel) {
 		case INGENIC_ADC_AUX:
+		case INGENIC_ADC_AUX2:
 			*val = readw(adc->base + JZ_ADC_REG_ADSDAT);
 			break;
 		case INGENIC_ADC_BATTERY:
@@ -266,12 +357,12 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 			break;
 		}
 
-		clk_disable(adc->clk);
-
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		goto out;
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->channel) {
 		case INGENIC_ADC_AUX:
+		case INGENIC_ADC_AUX2:
 			*val = JZ_ADC_AUX_VREF;
 			*val2 = JZ_ADC_AUX_VREF_BITS;
 			break;
@@ -290,6 +381,13 @@ static int ingenic_adc_read_raw(struct iio_dev *iio_dev,
 	default:
 		return -EINVAL;
 	}
+
+out:
+	clk_disable(adc->clk);
+	if (lock)
+		mutex_unlock(lock);
+
+	return ret;
 }
 
 static void ingenic_adc_clk_cleanup(void *data)
@@ -322,6 +420,14 @@ static const struct iio_chan_spec ingenic_channels[] = {
 		.indexed = 1,
 		.channel = INGENIC_ADC_BATTERY,
 	},
+	{ /* Must always be last in the array. */
+		.extend_name = "aux2",
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = INGENIC_ADC_AUX2,
+	},
 };
 
 static int ingenic_adc_probe(struct platform_device *pdev)
@@ -343,6 +449,7 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 
 	adc = iio_priv(iio_dev);
 	mutex_init(&adc->lock);
+	mutex_init(&adc->aux_lock);
 	adc->soc_data = soc_data;
 
 	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -374,6 +481,7 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	/* Put hardware in a known passive state. */
 	writeb(0x00, adc->base + JZ_ADC_REG_ENABLE);
 	writeb(0xff, adc->base + JZ_ADC_REG_CTRL);
+	usleep_range(2000, 3000); /* Must wait at least 2ms. */
 	clk_disable(adc->clk);
 
 	ret = devm_add_action_or_reset(dev, ingenic_adc_clk_cleanup, adc->clk);
@@ -387,6 +495,9 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = ingenic_channels;
 	iio_dev->num_channels = ARRAY_SIZE(ingenic_channels);
+	/* Remove AUX2 from the list of supported channels. */
+	if (!adc->soc_data->has_aux2)
+		iio_dev->num_channels -= 1;
 	iio_dev->info = &ingenic_adc_info;
 
 	ret = devm_iio_device_register(dev, iio_dev);
@@ -400,6 +511,7 @@ static int ingenic_adc_probe(struct platform_device *pdev)
 static const struct of_device_id ingenic_adc_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-adc", .data = &jz4725b_adc_soc_data, },
 	{ .compatible = "ingenic,jz4740-adc", .data = &jz4740_adc_soc_data, },
+	{ .compatible = "ingenic,jz4770-adc", .data = &jz4770_adc_soc_data, },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ingenic_adc_of_match);
-- 
2.22.0

