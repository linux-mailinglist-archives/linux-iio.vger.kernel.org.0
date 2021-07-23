Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18B83D365F
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhGWHfi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 03:35:38 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29972 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhGWHfi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 03:35:38 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16N7x6St041951;
        Fri, 23 Jul 2021 15:59:06 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 16:15:40 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v2 4/8] iio: adc: aspeed: Allow driver to support ast2600
Date:   Fri, 23 Jul 2021 16:16:17 +0800
Message-ID: <20210723081621.29477-5-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16N7x6St041951
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The adc controller have some differents at ast2600:
1. Combine control register of clock divider to continuous bitfields.
2. Reference voltage becomes optional which are internal 2500mv/1200mv
and external range from 900mv to 2700mv
3. Divided into two engine, each one has 8 voltage sensing channels.

This patch handled these changes and compatible with old version.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 176 ++++++++++++++++++++++++++---------
 1 file changed, 132 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 99466a5924c7..84f079195375 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Aspeed AST2400/2500 ADC
+ * Aspeed AST2400/2500/2600 ADC
  *
  * Copyright (C) 2017 Google, Inc.
+ * Copyright (C) 2021 Aspeed Technology Inc.
  */
 
 #include <linux/clk.h>
@@ -55,12 +56,17 @@
 #define ASPEED_ADC_INIT_POLLING_TIME	500
 #define ASPEED_ADC_INIT_TIMEOUT		500000
 
+enum aspeed_adc_version {
+	aspeed_adc_ast2400,
+	aspeed_adc_ast2500,
+	aspeed_adc_ast2600,
+};
 struct aspeed_adc_model_data {
-	const char *model_name;
+	enum aspeed_adc_version version;
 	unsigned int min_sampling_rate;	// Hz
 	unsigned int max_sampling_rate;	// Hz
-	unsigned int vref_voltage;	// mV
 	bool wait_init_sequence;
+	unsigned int num_channels;
 };
 
 struct aspeed_adc_data {
@@ -70,6 +76,7 @@ struct aspeed_adc_data {
 	struct clk_hw		*clk_prescaler;
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
+	int			vref;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -106,8 +113,6 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			       int *val, int *val2, long mask)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
-	const struct aspeed_adc_model_data *model_data =
-			of_device_get_match_data(data->dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -115,7 +120,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = model_data->vref_voltage;
+		*val = data->vref;
 		*val2 = ASPEED_RESOLUTION_BITS;
 		return IIO_VAL_FRACTIONAL_LOG2;
 
@@ -182,6 +187,55 @@ static const struct iio_info aspeed_adc_iio_info = {
 	.debugfs_reg_access = aspeed_adc_reg_access,
 };
 
+static int aspeed_adc_vref_config(struct platform_device *pdev)
+{
+	const struct aspeed_adc_model_data *model_data;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	int vref;
+	u32 adc_engine_control_reg_val =
+		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+
+	model_data = of_device_get_match_data(&pdev->dev);
+	switch (model_data->version) {
+	case aspeed_adc_ast2400:
+		vref = 2500;
+		break;
+	case aspeed_adc_ast2500:
+		vref = 1800;
+		break;
+	case aspeed_adc_ast2600:
+		if (of_property_read_u32(pdev->dev.of_node, "vref", &vref))
+			vref = 2500;
+		if (vref == 2500)
+			writel(adc_engine_control_reg_val |
+				       ASPEED_ADC_REF_VOLTAGE_2500mV,
+			       data->base + ASPEED_REG_ENGINE_CONTROL);
+		else if (vref == 1200)
+			writel(adc_engine_control_reg_val |
+				       ASPEED_ADC_REF_VOLTAGE_1200mV,
+			       data->base + ASPEED_REG_ENGINE_CONTROL);
+		else if ((vref >= 1550) && (vref <= 2700))
+			writel(adc_engine_control_reg_val |
+				       ASPEED_ADC_REF_VOLTAGE_EXT_HIGH,
+			       data->base + ASPEED_REG_ENGINE_CONTROL);
+		else if ((vref >= 900) && (vref <= 1650))
+			writel(adc_engine_control_reg_val |
+				       ASPEED_ADC_REF_VOLTAGE_EXT_LOW,
+			       data->base + ASPEED_REG_ENGINE_CONTROL);
+		else {
+			dev_err(&pdev->dev, "Vref not support");
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		dev_err(&pdev->dev, "ADC version not recognized");
+		return -EOPNOTSUPP;
+	}
+	data->vref = vref;
+	return 0;
+}
+
 static int aspeed_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
@@ -190,13 +244,16 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	const char *clk_parent_name;
 	int ret;
 	u32 adc_engine_control_reg_val;
+	char scaler_clk_name[32];
 
+	model_data = of_device_get_match_data(&pdev->dev);
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	data->dev = &pdev->dev;
+	dev_set_drvdata(data->dev, indio_dev);
 
 	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
@@ -205,29 +262,39 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	/* Register ADC clock prescaler with source specified by device tree. */
 	spin_lock_init(&data->clk_lock);
 	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
+	if (model_data->version <= aspeed_adc_ast2500) {
+		data->clk_prescaler = clk_hw_register_divider(
+					&pdev->dev, "prescaler", clk_parent_name, 0,
+					data->base + ASPEED_REG_CLOCK_CONTROL,
+					17, 15, 0, &data->clk_lock);
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
+					&pdev->dev, "scaler", "prescaler",
+					CLK_SET_RATE_PARENT,
+					data->base + ASPEED_REG_CLOCK_CONTROL,
+					0, 10, 0, &data->clk_lock);
+		if (IS_ERR(data->clk_scaler)) {
+			ret = PTR_ERR(data->clk_scaler);
+			goto scaler_error;
+		}
+	} else {
+		snprintf(scaler_clk_name, sizeof(scaler_clk_name), "scaler-%s",
+			 pdev->name);
+		data->clk_scaler = clk_hw_register_divider(
+			&pdev->dev, scaler_clk_name, clk_parent_name, 0,
+			data->base + ASPEED_REG_CLOCK_CONTROL, 0, 16, 0,
+			&data->clk_lock);
+		if (IS_ERR(data->clk_scaler))
+			return PTR_ERR(data->clk_scaler);
 	}
 
-	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
 	if (IS_ERR(data->rst)) {
 		dev_err(&pdev->dev,
 			"invalid or missing reset controller device tree entry");
@@ -236,11 +303,17 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	}
 	reset_control_deassert(data->rst);
 
-	model_data = of_device_get_match_data(&pdev->dev);
+	ret = aspeed_adc_vref_config(pdev);
+	if (ret)
+		goto vref_config_error;
 
 	if (model_data->wait_init_sequence) {
+		adc_engine_control_reg_val =
+			readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 		/* Enable engine in normal mode. */
-		writel(ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE,
+		writel(adc_engine_control_reg_val |
+			       ASPEED_ADC_OPERATION_MODE_NORMAL |
+			       ASPEED_ADC_ENGINE_ENABLE,
 		       data->base + ASPEED_REG_ENGINE_CONTROL);
 
 		/* Wait for initial sequence complete. */
@@ -254,22 +327,23 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 			goto poll_timeout_error;
 	}
 
-	/* Start all channels in normal mode. */
 	ret = clk_prepare_enable(data->clk_scaler->clk);
 	if (ret)
 		goto clk_enable_error;
-
-	adc_engine_control_reg_val = GENMASK(31, 16) |
-		ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE;
+	adc_engine_control_reg_val =
+		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	/* Start all channels in normal mode. */
+	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL |
+				     ASPEED_ADC_OPERATION_MODE_NORMAL |
+				     ASPEED_ADC_ENGINE_ENABLE;
 	writel(adc_engine_control_reg_val,
 		data->base + ASPEED_REG_ENGINE_CONTROL);
 
-	model_data = of_device_get_match_data(&pdev->dev);
-	indio_dev->name = model_data->model_name;
+	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->info = &aspeed_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = aspeed_adc_iio_channels;
-	indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
+	indio_dev->num_channels = model_data->num_channels;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -281,13 +355,15 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
 		data->base + ASPEED_REG_ENGINE_CONTROL);
 	clk_disable_unprepare(data->clk_scaler->clk);
+vref_config_error:
 clk_enable_error:
 poll_timeout_error:
 	reset_control_assert(data->rst);
 reset_error:
 	clk_hw_unregister_divider(data->clk_scaler);
 scaler_error:
-	clk_hw_unregister_divider(data->clk_prescaler);
+	if (model_data->version <= aspeed_adc_ast2500)
+		clk_hw_unregister_divider(data->clk_prescaler);
 	return ret;
 }
 
@@ -295,36 +371,48 @@ static int aspeed_adc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	const struct aspeed_adc_model_data *model_data;
 
+	model_data = of_device_get_match_data(&pdev->dev);
 	iio_device_unregister(indio_dev);
 	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
 		data->base + ASPEED_REG_ENGINE_CONTROL);
 	clk_disable_unprepare(data->clk_scaler->clk);
 	reset_control_assert(data->rst);
 	clk_hw_unregister_divider(data->clk_scaler);
-	clk_hw_unregister_divider(data->clk_prescaler);
+	if (model_data->version <= aspeed_adc_ast2500)
+		clk_hw_unregister_divider(data->clk_prescaler);
 
 	return 0;
 }
 
 static const struct aspeed_adc_model_data ast2400_model_data = {
-	.model_name = "ast2400-adc",
-	.vref_voltage = 2500, // mV
+	.version = aspeed_adc_ast2400,
 	.min_sampling_rate = 10000,
 	.max_sampling_rate = 500000,
+	.num_channels = 16,
 };
 
 static const struct aspeed_adc_model_data ast2500_model_data = {
-	.model_name = "ast2500-adc",
-	.vref_voltage = 1800, // mV
-	.min_sampling_rate = 1,
-	.max_sampling_rate = 1000000,
+	.version = aspeed_adc_ast2500,
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
+	.wait_init_sequence = true,
+	.num_channels = 16,
+};
+
+static const struct aspeed_adc_model_data ast2600_model_data = {
+	.version = aspeed_adc_ast2600,
+	.min_sampling_rate = 10000,
+	.max_sampling_rate = 500000,
 	.wait_init_sequence = true,
+	.num_channels = 8,
 };
 
 static const struct of_device_id aspeed_adc_matches[] = {
 	{ .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
 	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
+	{ .compatible = "aspeed,ast2600-adc", .data = &ast2600_model_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
@@ -341,5 +429,5 @@ static struct platform_driver aspeed_adc_driver = {
 module_platform_driver(aspeed_adc_driver);
 
 MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
-MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
+MODULE_DESCRIPTION("Aspeed AST2400/2500/2600 ADC Driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

