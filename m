Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725F028CBC0
	for <lists+linux-iio@lfdr.de>; Tue, 13 Oct 2020 12:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbgJMKdM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 06:33:12 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40383 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbgJMKdK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Oct 2020 06:33:10 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 09DAUg2e010593;
        Tue, 13 Oct 2020 18:30:42 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Oct
 2020 18:32:57 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <billy_tsai@aspeedtech.com>, <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 2/3] iio: adc: aspeed: Modify driver for ast2600
Date:   Tue, 13 Oct 2020 18:32:44 +0800
Message-ID: <20201013103245.16723-3-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 09DAUg2e010593
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch is used to handle the difference between ast2600
and previous versions.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 129 ++++++++++++++++++++++++++---------
 1 file changed, 95 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index ae400c4d6d40..fc4bbccf9348 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Aspeed AST2400/2500 ADC
+ * Aspeed AST2400/2500/2600 ADC
  *
  * Copyright (C) 2017 Google, Inc.
  */
@@ -81,6 +81,7 @@ struct aspeed_adc_model_data {
 	unsigned int max_sampling_rate;	// Hz
 	unsigned int vref_voltage;	// mV
 	bool wait_init_sequence;
+	int num_channels;
 };
 
 struct aspeed_adc_data {
@@ -90,6 +91,7 @@ struct aspeed_adc_data {
 	struct clk_hw		*clk_prescaler;
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
+	unsigned int vref_voltage;	// mV
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -126,8 +128,6 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			       int *val, int *val2, long mask)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
-	const struct aspeed_adc_model_data *model_data =
-			of_device_get_match_data(data->dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -135,7 +135,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = model_data->vref_voltage;
+		*val = data->vref_voltage;
 		*val2 = ASPEED_RESOLUTION_BITS;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -208,8 +208,13 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	struct aspeed_adc_data *data;
 	const struct aspeed_adc_model_data *model_data;
 	const char *clk_parent_name;
+	char prescaler_clk_name[32];
+	char scaler_clk_name[32];
 	int ret;
 	u32 adc_engine_control_reg_val;
+	u32 ref_voltage_cfg = 0;
+
+	model_data = of_device_get_match_data(&pdev->dev);
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
 	if (!indio_dev)
@@ -225,29 +230,75 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	/* Register ADC clock prescaler with source specified by device tree. */
 	spin_lock_init(&data->clk_lock);
 	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
+	snprintf(prescaler_clk_name, sizeof(prescaler_clk_name),
+			"prescaler-%s", pdev->name);
+	snprintf(scaler_clk_name, sizeof(scaler_clk_name),
+			"scaler-%s", pdev->name);
+	if (!strcmp(model_data->model_name, "ast2400-adc") ||
+	    !strcmp(model_data->model_name, "ast2500-adc")) {
+		/* Divider config */
+		data->clk_prescaler = clk_hw_register_divider(
+				&pdev->dev, prescaler_clk_name, clk_parent_name,
+				0,
+				data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15,
+				CLK_DIVIDER_ONE_BASED, &data->clk_lock);
+		if (IS_ERR(data->clk_prescaler))
+			return PTR_ERR(data->clk_prescaler);
 
-	data->clk_prescaler = clk_hw_register_divider(
-				&pdev->dev, "prescaler", clk_parent_name, 0,
-				data->base + ASPEED_REG_CLOCK_CONTROL,
-				17, 15, 0, &data->clk_lock);
-	if (IS_ERR(data->clk_prescaler))
-		return PTR_ERR(data->clk_prescaler);
-
-	/*
-	 * Register ADC clock scaler downstream from the prescaler. Allow rate
-	 * setting to adjust the prescaler as well.
-	 */
-	data->clk_scaler = clk_hw_register_divider(
-				&pdev->dev, "scaler", "prescaler",
-				CLK_SET_RATE_PARENT,
-				data->base + ASPEED_REG_CLOCK_CONTROL,
-				0, 10, 0, &data->clk_lock);
-	if (IS_ERR(data->clk_scaler)) {
-		ret = PTR_ERR(data->clk_scaler);
-		goto scaler_error;
+		/*
+		 * Register ADC clock scaler downstream from the prescaler. Allow rate
+		 * setting to adjust the prescaler as well.
+		 */
+		data->clk_scaler = clk_hw_register_divider(
+					&pdev->dev, scaler_clk_name, prescaler_clk_name,
+					CLK_SET_RATE_PARENT,
+					data->base + ASPEED_REG_CLOCK_CONTROL, 0, 10,
+					CLK_DIVIDER_ONE_BASED, &data->clk_lock);
+		if (IS_ERR(data->clk_scaler)) {
+			ret = PTR_ERR(data->clk_scaler);
+			goto scaler_error;
+		}
+		/* Get ref_voltage */
+		data->vref_voltage = model_data->vref_voltage;
+	} else if (!strcmp(model_data->model_name, "ast2600-adc")) {
+		/* Divider config */
+		data->clk_scaler = clk_hw_register_divider(
+			&pdev->dev, scaler_clk_name, clk_parent_name,
+			CLK_SET_RATE_UNGATE,
+			data->base + ASPEED_REG_CLOCK_CONTROL, 0, 16,
+			CLK_DIVIDER_ONE_BASED, &data->clk_lock);
+		if (IS_ERR(data->clk_scaler))
+			return PTR_ERR(data->clk_scaler);
+		/*
+		 * Get ref_voltage:
+		 * If reference voltage is between 1550~1650mv, we can set
+		 * fields either ASPEED_REF_VOLTAGE_EXT_HIGH or ASPEED_REF_VOLTAGE_EXT_LOW.
+		 * In this place, we select ASPEED_REF_VOLTAGE_EXT_HIGH as higher priority.
+		 */
+		if (!of_property_read_u32(pdev->dev.of_node, "ref_voltage",
+					  &data->vref_voltage)) {
+			if (data->vref_voltage == 2500)
+				ref_voltage_cfg = ASPEED_REF_VOLTAGE_2500mV;
+			else if (data->vref_voltage == 1200)
+				ref_voltage_cfg = ASPEED_REF_VOLTAGE_1200mV;
+			else if ((data->vref_voltage >= 1550) &&
+					(data->vref_voltage <= 2700))
+				ref_voltage_cfg = ASPEED_REF_VOLTAGE_EXT_HIGH;
+			else if ((data->vref_voltage >= 900) &&
+					(data->vref_voltage <= 1650))
+				ref_voltage_cfg = ASPEED_REF_VOLTAGE_EXT_LOW;
+			else {
+				dev_err(&pdev->dev, "ref_voltage property is out of range: %d\n",
+					data->vref_voltage);
+				return -EINVAL;
+			}
+		} else {
+			dev_err(&pdev->dev, "Couldn't read ref_voltage property\n");
+			return -EINVAL;
+		}
 	}
 
-	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
 	if (IS_ERR(data->rst)) {
 		dev_err(&pdev->dev,
 			"invalid or missing reset controller device tree entry");
@@ -256,13 +307,14 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	}
 	reset_control_deassert(data->rst);
 
-	model_data = of_device_get_match_data(&pdev->dev);
+	adc_engine_control_reg_val = readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	/* Enable engine in normal mode and set ref_voltage */
+	adc_engine_control_reg_val |= (ASPEED_OPERATION_MODE_NORMAL |
+				ASPEED_ENGINE_ENABLE | ref_voltage_cfg);
+	writel(adc_engine_control_reg_val,
+			data->base + ASPEED_REG_ENGINE_CONTROL);
 
 	if (model_data->wait_init_sequence) {
-		/* Enable engine in normal mode. */
-		writel(ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE,
-		       data->base + ASPEED_REG_ENGINE_CONTROL);
-
 		/* Wait for initial sequence complete. */
 		ret = readl_poll_timeout(data->base + ASPEED_REG_ENGINE_CONTROL,
 					 adc_engine_control_reg_val,
@@ -279,18 +331,16 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_enable_error;
 
-	adc_engine_control_reg_val = GENMASK(31, 16) |
-		ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
+	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CH_EN_ALL;
 	writel(adc_engine_control_reg_val,
 		data->base + ASPEED_REG_ENGINE_CONTROL);
 
-	model_data = of_device_get_match_data(&pdev->dev);
 	indio_dev->name = model_data->model_name;
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->info = &aspeed_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = aspeed_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
+	indio_dev->num_channels = model_data->num_channels;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -333,6 +383,7 @@ static const struct aspeed_adc_model_data ast2400_model_data = {
 	.vref_voltage = 2500, // mV
 	.min_sampling_rate = 10000,
 	.max_sampling_rate = 500000,
+	.num_channels = 16,
 };
 
 static const struct aspeed_adc_model_data ast2500_model_data = {
@@ -341,11 +392,21 @@ static const struct aspeed_adc_model_data ast2500_model_data = {
 	.min_sampling_rate = 1,
 	.max_sampling_rate = 1000000,
 	.wait_init_sequence = true,
+	.num_channels = 16,
+};
+
+static const struct aspeed_adc_model_data ast2600_model_data = {
+	.model_name = "ast2600-adc",
+	.min_sampling_rate = 1,
+	.max_sampling_rate = 1000000,
+	.wait_init_sequence = true,
+	.num_channels = 8,
 };
 
 static const struct of_device_id aspeed_adc_matches[] = {
 	{ .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
 	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
+	{ .compatible = "aspeed,ast2600-adc", .data = &ast2600_model_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
@@ -362,5 +423,5 @@ static struct platform_driver aspeed_adc_driver = {
 module_platform_driver(aspeed_adc_driver);
 
 MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
-MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
+MODULE_DESCRIPTION("Aspeed AST2400/2500/2600 ADC Driver");
 MODULE_LICENSE("GPL");
-- 
2.17.1

