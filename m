Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5AB3FAC9C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbhH2P3Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235561AbhH2P3Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:29:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60D460F42;
        Sun, 29 Aug 2021 15:28:26 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:31:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 10/15] iio: adc: aspeed: Support ast2600 adc.
Message-ID: <20210829163137.4c0ce7b0@jic23-huawei>
In-Reply-To: <20210824091243.9393-11-billy_tsai@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <20210824091243.9393-11-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:38 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Make driver to support ast2600 adc device.
> - Use shared reset controller
> - Complete the vref configure function
> - Add the model data for ast2600 adc
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Hi Billy,

A few minor things inline,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 106 +++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 1c87e12a0cab..ea3e9a52fcc9 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Aspeed AST2400/2500 ADC
> + * Aspeed AST2400/2500/2600 ADC
>   *
>   * Copyright (C) 2017 Google, Inc.
>   * Copyright (C) 2021 Aspeed Technology Inc.
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> @@ -73,6 +74,7 @@ struct aspeed_adc_model_data {
>  struct aspeed_adc_data {
>  	struct device		*dev;
>  	const struct aspeed_adc_model_data *model_data;
> +	struct regulator	*regulator;
>  	void __iomem		*base;
>  	spinlock_t		clk_lock;
>  	struct clk_hw		*clk_prescaler;
> @@ -208,14 +210,80 @@ static void aspeed_adc_clk_disable_unprepare(void *data)
>  	clk_disable_unprepare(clk);
>  }
>  
> +static void aspeed_adc_reg_disable(void *data)
> +{
> +	struct regulator *reg = data;
> +
> +	regulator_disable(reg);
> +}
> +
>  static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u32 adc_engine_control_reg_val =
> +		readl(data->base + ASPEED_REG_ENGINE_CONTROL);

Given you aren't going to use this if vref_fixed is set, move the read
until after that.

>  
>  	if (data->model_data->vref_fixed) {
>  		data->vref = data->model_data->vref_fixed;
>  		return 0;
>  	}
> +
> +	data->regulator = devm_regulator_get_optional(data->dev, "vref");
> +	if (!IS_ERR(data->regulator)) {
> +		ret = regulator_enable(data->regulator);
> +		if (ret)
> +			return ret;
> +		ret = devm_add_action_or_reset(
> +			data->dev, aspeed_adc_reg_disable, data->regulator);
> +		if (ret)
> +			return ret;
> +		data->vref = regulator_get_voltage(data->regulator);
> +		/* Conversion from uV to mV */
> +		data->vref /= 1000;
> +		if ((data->vref >= 1550) && (data->vref <= 2700))
> +			writel(adc_engine_control_reg_val |
> +				       FIELD_PREP(
> +					       ASPEED_ADC_REF_VOLTAGE,
> +					       ASPEED_ADC_REF_VOLTAGE_EXT_HIGH),
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else if ((data->vref >= 900) && (data->vref <= 1650))
> +			writel(adc_engine_control_reg_val |
> +				       FIELD_PREP(
> +					       ASPEED_ADC_REF_VOLTAGE,
> +					       ASPEED_ADC_REF_VOLTAGE_EXT_LOW),
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else {
> +			dev_err(data->dev, "Regulator voltage %d not support",
> +				data->vref);
> +			return -EOPNOTSUPP;
> +		}
> +	} else {
> +		if (PTR_ERR(data->regulator) != -ENODEV)
> +			return PTR_ERR(data->regulator);
> +		ret = of_property_read_u32(data->dev->of_node,
> +					   "aspeed,int_vref_mv", &data->vref);
> +		if (ret < 0) {
> +			dev_warn(data->dev,
> +				 "Using default vref: internal 2500 mv");

Perhaps document that as default in the dt-binding, then you can remove this warning and
handle this as:

		data->vref = 2500;
		of_property_read_u32(data->dev->of_node,
				     "aspeed,int-vref-mvolts", &data->vref);
etc

> +			data->vref = 2500;
> +		}
> +		if (data->vref == 2500)
> +			writel(adc_engine_control_reg_val |
> +				       FIELD_PREP(ASPEED_ADC_REF_VOLTAGE,
> +						  ASPEED_ADC	writel(adc_engine_control_reg_val,
		data->base + ASPEED_REG_ENGINE_CONTROL);_REF_VOLTAGE_2500mV),
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else if (data->vref == 1200)
> +			writel(adc_engine_control_reg_val |
> +				       FIELD_PREP(ASPEED_ADC_REF_VOLTAGE,
> +						  ASPEED_ADC_REF_VOLTAGE_1200mV),
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else {
> +			dev_err(data->dev, "Voltage %d not support", data->vref);
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -279,7 +347,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
>  	if (IS_ERR(data->rst)) {
>  		dev_err(&pdev->dev,
>  			"invalid or missing reset controller device tree entry");
> @@ -297,10 +365,14 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	if (data->model_data->wait_init_sequence) {
> +		adc_engine_control_reg_val =
> +			readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +		adc_engine_control_reg_val |=
> +			FIELD_PREP(ASPEED_ADC_OP_MODE,
> +				   ASPEED_ADC_OP_MODE_NORMAL) |
> +			ASPEED_ADC_ENGINE_ENABLE;
>  		/* Enable engine in normal mode. */
> -		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
> -				  ASPEED_ADC_OP_MODE_NORMAL) |
> -			       ASPEED_ADC_ENGINE_ENABLE,
> +		writel(adc_engine_control_reg_val,
>  		       data->base + ASPEED_REG_ENGINE_CONTROL);
>  
>  		/* Wait for initial sequence complete. */
> @@ -326,6 +398,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	adc_engine_control_reg_val =
> +		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +	adc_engine_control_reg_val |=
>  		ASPEED_ADC_CTRL_CHANNEL |
>  		FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_NORMAL) |
>  		ASPEED_ADC_ENGINE_ENABLE;
> @@ -376,9 +450,29 @@ static const struct aspeed_adc_model_data ast2500_model_data = {
>  	.num_channels = 16,
>  };
>  
> +static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
> +	.model_name = "ast2600-adc0",
> +	.min_sampling_rate = 10000,
> +	.max_sampling_rate = 500000,
> +	.wait_init_sequence = true,
> +	.scaler_bit_width = 16,
> +	.num_channels = 8,
> +};
> +
> +static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
> +	.model_name = "ast2600-adc1",
> +	.min_sampling_rate = 10000,
> +	.max_sampling_rate = 500000,
> +	.wait_init_sequence = true,
> +	.scaler_bit_width = 16,
> +	.num_channels = 8,
> +};
> +
>  static const struct of_device_id aspeed_adc_matches[] = {
>  	{ .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
>  	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
> +	{ .compatible = "aspeed,ast2600-adc0", .data = &ast2600_adc0_model_data },
> +	{ .compatible = "aspeed,ast2600-adc1", .data = &ast2600_adc1_model_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
> @@ -395,5 +489,5 @@ static struct platform_driver aspeed_adc_driver = {
>  module_platform_driver(aspeed_adc_driver);
>  
>  MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
> -MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
> +MODULE_DESCRIPTION("Aspeed AST2400/2500/2600 ADC Driver");
>  MODULE_LICENSE("GPL");

