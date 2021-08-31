Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19483FC33B
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 09:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbhHaHPW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 03:15:22 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:43150 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhHaHPV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 03:15:21 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17V6scJA028273;
        Tue, 31 Aug 2021 14:54:38 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 15:13:35 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v5 10/15] iio: adc: aspeed: Support ast2600 adc.
Date:   Tue, 31 Aug 2021 15:14:53 +0800
Message-ID: <20210831071458.2334-11-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17V6scJA028273
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make driver to support ast2600 adc device.
- Use shared reset controller
- Complete the vref configure function
- Add the model data for ast2600 adc

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 105 +++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index af00d9752c1e..40b7ba58c1dc 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Aspeed AST2400/2500 ADC
+ * Aspeed AST2400/2500/2600 ADC
  *
  * Copyright (C) 2017 Google, Inc.
  * Copyright (C) 2021 Aspeed Technology Inc.
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -81,6 +82,7 @@ struct aspeed_adc_model_data {
 struct aspeed_adc_data {
 	struct device		*dev;
 	const struct aspeed_adc_model_data *model_data;
+	struct regulator	*regulator;
 	void __iomem		*base;
 	spinlock_t		clk_lock;
 	struct clk_hw		*clk_prescaler;
@@ -224,14 +226,79 @@ static void aspeed_adc_power_down(void *data)
 	       priv_data->base + ASPEED_REG_ENGINE_CONTROL);
 }
 
+static void aspeed_adc_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	int ret;
+	u32 adc_engine_control_reg_val;
 
 	if (data->model_data->vref_fixed_mv) {
 		data->vref_mv = data->model_data->vref_fixed_mv;
 		return 0;
 	}
+	adc_engine_control_reg_val =
+		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	data->regulator = devm_regulator_get_optional(data->dev, "vref");
+	if (!IS_ERR(data->regulator)) {
+		ret = regulator_enable(data->regulator);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(
+			data->dev, aspeed_adc_reg_disable, data->regulator);
+		if (ret)
+			return ret;
+		data->vref_mv = regulator_get_voltage(data->regulator);
+		/* Conversion from uV to mV */
+		data->vref_mv /= 1000;
+		if ((data->vref_mv >= 1550) && (data->vref_mv <= 2700))
+			writel(adc_engine_control_reg_val |
+				FIELD_PREP(
+					ASPEED_ADC_REF_VOLTAGE,
+					ASPEED_ADC_REF_VOLTAGE_EXT_HIGH),
+			data->base + ASPEED_REG_ENGINE_CONTROL);
+		else if ((data->vref_mv >= 900) && (data->vref_mv <= 1650))
+			writel(adc_engine_control_reg_val |
+				FIELD_PREP(
+					ASPEED_ADC_REF_VOLTAGE,
+					ASPEED_ADC_REF_VOLTAGE_EXT_LOW),
+			data->base + ASPEED_REG_ENGINE_CONTROL);
+		else {
+			dev_err(data->dev, "Regulator voltage %d not support",
+				data->vref_mv);
+			return -EOPNOTSUPP;
+		}
+	} else {
+		if (PTR_ERR(data->regulator) != -ENODEV)
+			return PTR_ERR(data->regulator);
+		data->vref_mv = 2500000;
+		of_property_read_u32(data->dev->of_node,
+				     "aspeed,int-vref-microvolt",
+				     &data->vref_mv);
+		/* Conversion from uV to mV */
+		data->vref_mv /= 1000;
+		if (data->vref_mv == 2500)
+			writel(adc_engine_control_reg_val |
+				FIELD_PREP(ASPEED_ADC_REF_VOLTAGE,
+						ASPEED_ADC_REF_VOLTAGE_2500mV),
+			data->base + ASPEED_REG_ENGINE_CONTROL);
+		else if (data->vref_mv == 1200)
+			writel(adc_engine_control_reg_val |
+				FIELD_PREP(ASPEED_ADC_REF_VOLTAGE,
+						ASPEED_ADC_REF_VOLTAGE_1200mV),
+			data->base + ASPEED_REG_ENGINE_CONTROL);
+		else {
+			dev_err(data->dev, "Voltage %d not support", data->vref_mv);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	return 0;
 }
 
@@ -298,7 +365,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
 	if (IS_ERR(data->rst)) {
 		dev_err(&pdev->dev,
 			"invalid or missing reset controller device tree entry");
@@ -316,10 +383,14 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	if (data->model_data->wait_init_sequence) {
+		adc_engine_control_reg_val =
+			readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+		adc_engine_control_reg_val |=
+			FIELD_PREP(ASPEED_ADC_OP_MODE,
+				   ASPEED_ADC_OP_MODE_NORMAL) |
+			ASPEED_ADC_ENGINE_ENABLE;
 		/* Enable engine in normal mode. */
-		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
-				  ASPEED_ADC_OP_MODE_NORMAL) |
-			       ASPEED_ADC_ENGINE_ENABLE,
+		writel(adc_engine_control_reg_val,
 		       data->base + ASPEED_REG_ENGINE_CONTROL);
 
 		ret = devm_add_action_or_reset(data->dev, aspeed_adc_power_down,
@@ -349,6 +420,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		return ret;
 
 	adc_engine_control_reg_val =
+		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val |=
 		ASPEED_ADC_CTRL_CHANNEL |
 		FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_NORMAL) |
 		ASPEED_ADC_ENGINE_ENABLE;
@@ -391,9 +464,29 @@ static const struct aspeed_adc_model_data ast2500_model_data = {
 	.num_channels = 16,
 };
 
+static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
+	.model_name = "ast2600-adc0",
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
+	.wait_init_sequence = true,
+	.scaler_bit_width = 16,
+	.num_channels = 8,
+};
+
+static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
+	.model_name = "ast2600-adc1",
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
+	.wait_init_sequence = true,
+	.scaler_bit_width = 16,
+	.num_channels = 8,
+};
+
 static const struct of_device_id aspeed_adc_matches[] = {
 	{ .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
 	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
+	{ .compatible = "aspeed,ast2600-adc0", .data = &ast2600_adc0_model_data },
+	{ .compatible = "aspeed,ast2600-adc1", .data = &ast2600_adc1_model_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
@@ -409,5 +502,5 @@ static struct platform_driver aspeed_adc_driver = {
 module_platform_driver(aspeed_adc_driver);
 
 MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
-MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
+MODULE_DESCRIPTION("Aspeed AST2400/2500/2600 ADC Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

