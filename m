Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315002916FE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgJRKqe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 06:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgJRKqK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 06:46:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9544020897;
        Sun, 18 Oct 2020 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603017969;
        bh=03DK99dTu+o3n4yTJvzRf0I4cwbJQqFwysU6ZyBEbzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rxgJhPFSybRUPyEeByb8jSnB+faUrpTr7aMHrRH8R4VYIIdkuZnYbmqcm6AY+ZuVh
         G4q5Jm65vYhGV9heUYAKz/8N2EFYCHwtvYtvgbfriHkE3uKOYUCta02DN/gw5KHLgb
         dO7trmkYancNvqvPhyAkWL0Jn7gbdg+ceWs0R11Y=
Date:   Sun, 18 Oct 2020 11:46:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <alexandru.ardelean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH 2/3] iio: adc: aspeed: Modify driver for ast2600
Message-ID: <20201018114603.0da21bcb@archlinux>
In-Reply-To: <20201013103245.16723-3-billy_tsai@aspeedtech.com>
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
        <20201013103245.16723-3-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Oct 2020 18:32:44 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

Hi Billy,

> This patch is used to handle the difference between ast2600
> and previous versions.
Good to mention what they are. Not all of them are obvious (such
as the reset change to being requested as shared).

> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch is a mixture of adding the new support, and adding various
'hooks' to enable the differences.  I'd rather see it as two patches.
First one adds the hooks but makes no functional change, second patch
adds the new device support.  That makes for easier reviewing for me!

> ---
>  drivers/iio/adc/aspeed_adc.c | 129 ++++++++++++++++++++++++++---------
>  1 file changed, 95 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index ae400c4d6d40..fc4bbccf9348 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Aspeed AST2400/2500 ADC
> + * Aspeed AST2400/2500/2600 ADC
>   *
>   * Copyright (C) 2017 Google, Inc.
>   */
> @@ -81,6 +81,7 @@ struct aspeed_adc_model_data {
>  	unsigned int max_sampling_rate;	// Hz
>  	unsigned int vref_voltage;	// mV

Add a comment to this to say that not all devices use a fixed
vref_voltage.

>  	bool wait_init_sequence;
> +	int num_channels;
>  };
>  
>  struct aspeed_adc_data {
> @@ -90,6 +91,7 @@ struct aspeed_adc_data {
>  	struct clk_hw		*clk_prescaler;
>  	struct clk_hw		*clk_scaler;
>  	struct reset_control	*rst;
> +	unsigned int vref_voltage;	// mV

If the naming can include the unit, then we both don't need the
comment and the units are apparent at the point of use.

vref_mV; for example.  A good cleanup would be to do similar
for the other cases in the driver.


>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -126,8 +128,6 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  			       int *val, int *val2, long mask)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> -	const struct aspeed_adc_model_data *model_data =
> -			of_device_get_match_data(data->dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -135,7 +135,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = model_data->vref_voltage;
> +		*val = data->vref_voltage;
>  		*val2 = ASPEED_RESOLUTION_BITS;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> @@ -208,8 +208,13 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	struct aspeed_adc_data *data;
>  	const struct aspeed_adc_model_data *model_data;
>  	const char *clk_parent_name;
> +	char prescaler_clk_name[32];
> +	char scaler_clk_name[32];
>  	int ret;
>  	u32 adc_engine_control_reg_val;
> +	u32 ref_voltage_cfg = 0;
> +
> +	model_data = of_device_get_match_data(&pdev->dev);
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -225,29 +230,75 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	/* Register ADC clock prescaler with source specified by device tree. */
>  	spin_lock_init(&data->clk_lock);
>  	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
> +	snprintf(prescaler_clk_name, sizeof(prescaler_clk_name),
> +			"prescaler-%s", pdev->name);
> +	snprintf(scaler_clk_name, sizeof(scaler_clk_name),
> +			"scaler-%s", pdev->name);
> +	if (!strcmp(model_data->model_name, "ast2400-adc") ||
> +	    !strcmp(model_data->model_name, "ast2500-adc")) {

It would be nice to avoid all of these string comparisons if possible.
Various options come to mind:
1) Put a flag for each possible thing in the mode_data structures
   so we just check that to make decisions in probe.
2) Compare against the model_data pointers (bit ugly)
3) Do comparisons just once to convert to an enum.
4) Put an enum value in each mode_data structure to identify it without
   a string comparison.

1 is probably the best of these options as more extensible to additional
models as it provides fine grained feature information in one location
rather than many.



> +		/* Divider config */
> +		data->clk_prescaler = clk_hw_register_divider(
> +				&pdev->dev, prescaler_clk_name, clk_parent_name,
> +				0,
> +				data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15,
> +				CLK_DIVIDER_ONE_BASED, &data->clk_lock);
> +		if (IS_ERR(data->clk_prescaler))
> +			return PTR_ERR(data->clk_prescaler);
>  
> -	data->clk_prescaler = clk_hw_register_divider(
> -				&pdev->dev, "prescaler", clk_parent_name, 0,
> -				data->base + ASPEED_REG_CLOCK_CONTROL,
> -				17, 15, 0, &data->clk_lock);
> -	if (IS_ERR(data->clk_prescaler))
> -		return PTR_ERR(data->clk_prescaler);
> -
> -	/*
> -	 * Register ADC clock scaler downstream from the prescaler. Allow rate
> -	 * setting to adjust the prescaler as well.
> -	 */
> -	data->clk_scaler = clk_hw_register_divider(
> -				&pdev->dev, "scaler", "prescaler",
> -				CLK_SET_RATE_PARENT,
> -				data->base + ASPEED_REG_CLOCK_CONTROL,
> -				0, 10, 0, &data->clk_lock);
> -	if (IS_ERR(data->clk_scaler)) {
> -		ret = PTR_ERR(data->clk_scaler);
> -		goto scaler_error;
> +		/*
> +		 * Register ADC clock scaler downstream from the prescaler. Allow rate
> +		 * setting to adjust the prescaler as well.
> +		 */
> +		data->clk_scaler = clk_hw_register_divider(
> +					&pdev->dev, scaler_clk_name, prescaler_clk_name,
> +					CLK_SET_RATE_PARENT,
> +					data->base + ASPEED_REG_CLOCK_CONTROL, 0, 10,
> +					CLK_DIVIDER_ONE_BASED, &data->clk_lock);
> +		if (IS_ERR(data->clk_scaler)) {
> +			ret = PTR_ERR(data->clk_scaler);
> +			goto scaler_error;
> +		}
> +		/* Get ref_voltage */

If you do the 'feature flag' suggestion I make above, clearly this is a
separate feature to the clock stuff and so needs it's own feature flag.

> +		data->vref_voltage = model_data->vref_voltage;
> +	} else if (!strcmp(model_data->model_name, "ast2600-adc")) {
> +		/* Divider config */
> +		data->clk_scaler = clk_hw_register_divider(
> +			&pdev->dev, scaler_clk_name, clk_parent_name,
> +			CLK_SET_RATE_UNGATE,
> +			data->base + ASPEED_REG_CLOCK_CONTROL, 0, 16,
> +			CLK_DIVIDER_ONE_BASED, &data->clk_lock);
> +		if (IS_ERR(data->clk_scaler))
> +			return PTR_ERR(data->clk_scaler);
> +		/*
> +		 * Get ref_voltage:
> +		 * If reference voltage is between 1550~1650mv, we can set
> +		 * fields either ASPEED_REF_VOLTAGE_EXT_HIGH or ASPEED_REF_VOLTAGE_EXT_LOW.
> +		 * In this place, we select ASPEED_REF_VOLTAGE_EXT_HIGH as higher priority.
> +		 */
> +		if (!of_property_read_u32(pdev->dev.of_node, "ref_voltage",
> +					  &data->vref_voltage)) {
> +			if (data->vref_voltage == 2500)
> +				ref_voltage_cfg = ASPEED_REF_VOLTAGE_2500mV;
> +			else if (data->vref_voltage == 1200)
> +				ref_voltage_cfg = ASPEED_REF_VOLTAGE_1200mV;
> +			else if ((data->vref_voltage >= 1550) &&
> +					(data->vref_voltage <= 2700))
> +				ref_voltage_cfg = ASPEED_REF_VOLTAGE_EXT_HIGH;
> +			else if ((data->vref_voltage >= 900) &&
> +					(data->vref_voltage <= 1650))
> +				ref_voltage_cfg = ASPEED_REF_VOLTAGE_EXT_LOW;
> +			else {
> +				dev_err(&pdev->dev, "ref_voltage property is out of range: %d\n",
> +					data->vref_voltage);
> +				return -EINVAL;
> +			}
> +		} else {
Don't eat the error value from of_property_read_u32.  It might potentially
provide information on 'why' we couldn't read it.

Also would reduce indentation (improve readability) to do
		ret = of_property_read_u32(pdev->dev.of_node, "ref_voltage", ...
		if (ret) {
			dev_err(..)
			return ret;
		}
		if (data->vref_voltage) ...

> +			dev_err(&pdev->dev, "Couldn't read ref_voltage property\n");
> +			return -EINVAL;
> +		}
>  	}
>  
> -	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);

I'd like a comment in the patch description saying why you made this change.

>  	if (IS_ERR(data->rst)) {
>  		dev_err(&pdev->dev,
>  			"invalid or missing reset controller device tree entry");
> @@ -256,13 +307,14 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	}
>  	reset_control_deassert(data->rst);
>  
> -	model_data = of_device_get_match_data(&pdev->dev);
> +	adc_engine_control_reg_val = readl(data->base + ASPEED_REG_ENGINE_CONTROL);

Given this is during probe, I'd like to see an explanation comment on why we are
leaving the other bits of the register in whatever state we find them in.
i.e. why are we leaving some channels enabled?  We weren't previously
doing so...

> +	/* Enable engine in normal mode and set ref_voltage */
> +	adc_engine_control_reg_val |= (ASPEED_OPERATION_MODE_NORMAL |
> +				ASPEED_ENGINE_ENABLE | ref_voltage_cfg);
> +	writel(adc_engine_control_reg_val,
> +			data->base + ASPEED_REG_ENGINE_CONTROL);
>  
>  	if (model_data->wait_init_sequence) {
> -		/* Enable engine in normal mode. */
> -		writel(ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE,
> -		       data->base + ASPEED_REG_ENGINE_CONTROL);
> -
>  		/* Wait for initial sequence complete. */
>  		ret = readl_poll_timeout(data->base + ASPEED_REG_ENGINE_CONTROL,
>  					 adc_engine_control_reg_val,
> @@ -279,18 +331,16 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto clk_enable_error;
>  
> -	adc_engine_control_reg_val = GENMASK(31, 16) |
> -		ASPEED_OPERATION_MODE_NORMAL | ASPEED_ENGINE_ENABLE;
> +	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CH_EN_ALL;
>  	writel(adc_engine_control_reg_val,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  
> -	model_data = of_device_get_match_data(&pdev->dev);
>  	indio_dev->name = model_data->model_name;
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->info = &aspeed_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = aspeed_adc_iio_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
> +	indio_dev->num_channels = model_data->num_channels;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> @@ -333,6 +383,7 @@ static const struct aspeed_adc_model_data ast2400_model_data = {
>  	.vref_voltage = 2500, // mV
>  	.min_sampling_rate = 10000,
>  	.max_sampling_rate = 500000,
> +	.num_channels = 16,
>  };
>  
>  static const struct aspeed_adc_model_data ast2500_model_data = {
> @@ -341,11 +392,21 @@ static const struct aspeed_adc_model_data ast2500_model_data = {
>  	.min_sampling_rate = 1,
>  	.max_sampling_rate = 1000000,
>  	.wait_init_sequence = true,
> +	.num_channels = 16,
> +};
> +
> +static const struct aspeed_adc_model_data ast2600_model_data = {
> +	.model_name = "ast2600-adc",
> +	.min_sampling_rate = 1,
> +	.max_sampling_rate = 1000000,
> +	.wait_init_sequence = true,
> +	.num_channels = 8,
>  };
>  
>  static const struct of_device_id aspeed_adc_matches[] = {
>  	{ .compatible = "aspeed,ast2400-adc", .data = &ast2400_model_data },
>  	{ .compatible = "aspeed,ast2500-adc", .data = &ast2500_model_data },
> +	{ .compatible = "aspeed,ast2600-adc", .data = &ast2600_model_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_adc_matches);
> @@ -362,5 +423,5 @@ static struct platform_driver aspeed_adc_driver = {
>  module_platform_driver(aspeed_adc_driver);
>  
>  MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
> -MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
> +MODULE_DESCRIPTION("Aspeed AST2400/2500/2600 ADC Driver");
>  MODULE_LICENSE("GPL");

