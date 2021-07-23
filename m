Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41BF3D3C75
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhGWOuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 10:50:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3468 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbhGWOt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 10:49:27 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GWY1S0ybTz6G983;
        Fri, 23 Jul 2021 23:21:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 17:29:58 +0200
Received: from localhost (10.210.170.238) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Fri, 23 Jul
 2021 16:29:57 +0100
Date:   Fri, 23 Jul 2021 16:29:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [v2 4/8] iio: adc: aspeed: Allow driver to support ast2600
Message-ID: <20210723162931.00004329@Huawei.com>
In-Reply-To: <20210723081621.29477-5-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
        <20210723081621.29477-5-billy_tsai@aspeedtech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.238]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 23 Jul 2021 16:16:17 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The adc controller have some differents at ast2600:
> 1. Combine control register of clock divider to continuous bitfields.
> 2. Reference voltage becomes optional which are internal 2500mv/1200mv
> and external range from 900mv to 2700mv
> 3. Divided into two engine, each one has 8 voltage sensing channels.
> 
> This patch handled these changes and compatible with old version.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Hi Billy,

Various comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 176 ++++++++++++++++++++++++++---------
>  1 file changed, 132 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 99466a5924c7..84f079195375 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Aspeed AST2400/2500 ADC
> + * Aspeed AST2400/2500/2600 ADC
>   *
>   * Copyright (C) 2017 Google, Inc.
> + * Copyright (C) 2021 Aspeed Technology Inc.
>   */
>  
>  #include <linux/clk.h>
> @@ -55,12 +56,17 @@
>  #define ASPEED_ADC_INIT_POLLING_TIME	500
>  #define ASPEED_ADC_INIT_TIMEOUT		500000
>  
> +enum aspeed_adc_version {
> +	aspeed_adc_ast2400,
> +	aspeed_adc_ast2500,
> +	aspeed_adc_ast2600,
> +};

Nitpick! Blank line here.

>  struct aspeed_adc_model_data {
> -	const char *model_name;
> +	enum aspeed_adc_version version;

Currently we have a slightly odd mixture of
a device type enum and a device specific structure
containing that enum which is then used
to make additional decisions in the driver.

I would have a
	struct aspeed_adc_data *model_data;
pointer in here and make sure that has all the
relevant stuff so that we never need to
do special handling by 'version'.

>  	unsigned int min_sampling_rate;	// Hz
>  	unsigned int max_sampling_rate;	// Hz
> -	unsigned int vref_voltage;	// mV
>  	bool wait_init_sequence;
> +	unsigned int num_channels;
>  };
>  
>  struct aspeed_adc_data {
> @@ -70,6 +76,7 @@ struct aspeed_adc_data {
>  	struct clk_hw		*clk_prescaler;
>  	struct clk_hw		*clk_scaler;
>  	struct reset_control	*rst;
> +	int			vref;

Ideally I would break this into 2 patches.
1) Refactoring like this and the enum above.
2) Introduce the new part number using the result of that
   refactoring.

>  };
>  
>  #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
> @@ -106,8 +113,6 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  			       int *val, int *val2, long mask)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> -	const struct aspeed_adc_model_data *model_data =
> -			of_device_get_match_data(data->dev);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -115,7 +120,7 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = model_data->vref_voltage;
> +		*val = data->vref;
>  		*val2 = ASPEED_RESOLUTION_BITS;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> @@ -182,6 +187,55 @@ static const struct iio_info aspeed_adc_iio_info = {
>  	.debugfs_reg_access = aspeed_adc_reg_access,
>  };
>  
> +static int aspeed_adc_vref_config(struct platform_device *pdev)

As mentioned below, this would be slightly simpler if you just passed
in the struct iio_dev rather than pdev.

> +{
> +	const struct aspeed_adc_model_data *model_data;
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +	int vref;
> +	u32 adc_engine_control_reg_val =
> +		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +
> +	model_data = of_device_get_match_data(&pdev->dev);
> +	switch (model_data->version) {
> +	case aspeed_adc_ast2400:
As mentioned above, instead of using a version enum, just put
everything required in the model data structure.
e.g. add a vref_fixed field and set it for these two devices.

	if (model_data->vref_fixed) {
		data->vref = model_data->vref_fixed;
		return 0;
	}

	data->reg = devm_regulator_get_optional(pdev->dev, "vref");
	if (!IS_ERR(data->reg)) {
		ret = regulator_enable(data->reg);
		if (ret)
			return ret;
		// need to provide a little function to turn the reg off.
		ret = devm_add_action_or_reset(aspeed_adc_regdisable, data->reg);
		if (ret)
			return ret;
		
		ret = regulator_get_voltage(data->reg);
		if (ret < 0)
			return ret;
		data->vref = ret;
		//Here do the register set depending on value.
	} else {
		if (PTR_ERR(data->reg != -ENODEV)
			return PTR_ERR(data->reg);

		ret = of_property_read_u32(pdev->dev.of_node, "vref_int_mv", data->vref);
		if (ret)
			return ret;

		data->vref = ret;
		//here to the register set to configure the internal regulator.		
	}

> +		vref = 2500;
> +		break;
> +	case aspeed_adc_ast2500:
> +		vref = 1800;
> +		break;
> +	case aspeed_adc_ast2600:
> +		if (of_property_read_u32(pdev->dev.of_node, "vref", &vref))
> +			vref = 2500;

As in the binding review, if it's an external reference it needs to be
specified as a regulator.

If that is not present then you can have something like
aspeed,int_vref_mv as an enum that can be either 2500 or 1200.
As this only applies to the ast2600 you should also have a condition
check in the binding yaml to enforce that (so neither external regulator
or aspeed,int_vref_mv is allowed for the wrong devices).  You can also
enforce only one of the regulator and internal vref is supplied in the
dts, but that is a little fiddly to do and so perhaps not worth it.

> +		if (vref == 2500)
> +			writel(adc_engine_control_reg_val |
> +				       ASPEED_ADC_REF_VOLTAGE_2500mV,
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else if (vref == 1200)
> +			writel(adc_engine_control_reg_val |
> +				       ASPEED_ADC_REF_VOLTAGE_1200mV,
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else if ((vref >= 1550) && (vref <= 2700))
> +			writel(adc_engine_control_reg_val |
> +				       ASPEED_ADC_REF_VOLTAGE_EXT_HIGH,
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else if ((vref >= 900) && (vref <= 1650))
> +			writel(adc_engine_control_reg_val |
> +				       ASPEED_ADC_REF_VOLTAGE_EXT_LOW,
> +			       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		else {
> +			dev_err(&pdev->dev, "Vref not support");
> +			return -EOPNOTSUPP;
> +		}
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "ADC version not recognized");
> +		return -EOPNOTSUPP;
> +	}
> +	data->vref = vref;
> +	return 0;
> +}
> +
>  static int aspeed_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -190,13 +244,16 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	const char *clk_parent_name;
>  	int ret;
>  	u32 adc_engine_control_reg_val;
> +	char scaler_clk_name[32];
>  
> +	model_data = of_device_get_match_data(&pdev->dev);
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
>  	data->dev = &pdev->dev;
> +	dev_set_drvdata(data->dev, indio_dev);

You use platform_get_drvdata() below, so use platform_set_drvdata for this

>  
>  	data->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(data->base))
> @@ -205,29 +262,39 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	/* Register ADC clock prescaler with source specified by device tree. */
>  	spin_lock_init(&data->clk_lock);
>  	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
> +	if (model_data->version <= aspeed_adc_ast2500) {

I'd like to see this based on a flag in the model_data not a version number match.

> +		data->clk_prescaler = clk_hw_register_divider(
> +					&pdev->dev, "prescaler", clk_parent_name, 0,
> +					data->base + ASPEED_REG_CLOCK_CONTROL,
> +					17, 15, 0, &data->clk_lock);
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
> +					&pdev->dev, "scaler", "prescaler",
> +					CLK_SET_RATE_PARENT,
> +					data->base + ASPEED_REG_CLOCK_CONTROL,
> +					0, 10, 0, &data->clk_lock);
> +		if (IS_ERR(data->clk_scaler)) {
> +			ret = PTR_ERR(data->clk_scaler);
> +			goto scaler_error;
> +		}
> +	} else {
> +		snprintf(scaler_clk_name, sizeof(scaler_clk_name), "scaler-%s",
> +			 pdev->name);
> +		data->clk_scaler = clk_hw_register_divider(
> +			&pdev->dev, scaler_clk_name, clk_parent_name, 0,
> +			data->base + ASPEED_REG_CLOCK_CONTROL, 0, 16, 0,
> +			&data->clk_lock);
> +		if (IS_ERR(data->clk_scaler))
> +			return PTR_ERR(data->clk_scaler);
>  	}
>  
> -	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
>  	if (IS_ERR(data->rst)) {
>  		dev_err(&pdev->dev,
>  			"invalid or missing reset controller device tree entry");
> @@ -236,11 +303,17 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	}
>  	reset_control_deassert(data->rst);
>  
> -	model_data = of_device_get_match_data(&pdev->dev);
> +	ret = aspeed_adc_vref_config(pdev);

As we have the struct iio_dev available here I would pass it into this function.

> +	if (ret)
> +		goto vref_config_error;
>  
>  	if (model_data->wait_init_sequence) {
> +		adc_engine_control_reg_val =
> +			readl(data->base + ASPEED_REG_ENGINE_CONTROL);
>  		/* Enable engine in normal mode. */
> -		writel(ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE,
> +		writel(adc_engine_control_reg_val |
> +			       ASPEED_ADC_OPERATION_MODE_NORMAL |
> +			       ASPEED_ADC_ENGINE_ENABLE,
>  		       data->base + ASPEED_REG_ENGINE_CONTROL);
>  
>  		/* Wait for initial sequence complete. */
> @@ -254,22 +327,23 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			goto poll_timeout_error;
>  	}
>  
> -	/* Start all channels in normal mode. */
>  	ret = clk_prepare_enable(data->clk_scaler->clk);
>  	if (ret)
>  		goto clk_enable_error;
> -
> -	adc_engine_control_reg_val = GENMASK(31, 16) |
> -		ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE;
> +	adc_engine_control_reg_val =
> +		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +	/* Start all channels in normal mode. */
> +	adc_engine_control_reg_val |= ASPEED_ADC_CTRL_CHANNEL |
> +				     ASPEED_ADC_OPERATION_MODE_NORMAL |
> +				     ASPEED_ADC_ENGINE_ENABLE;
>  	writel(adc_engine_control_reg_val,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  
> -	model_data = of_device_get_match_data(&pdev->dev);
> -	indio_dev->name = model_data->model_name;
> +	indio_dev->name = dev_name(&pdev->dev);

This name needs to be the part number and I don't think that is true after
this change.  There are lots other ways to identify multiple instances.

>  	indio_dev->info = &aspeed_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = aspeed_adc_iio_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(aspeed_adc_iio_channels);
> +	indio_dev->num_channels = model_data->num_channels;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> @@ -281,13 +355,15 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  	clk_disable_unprepare(data->clk_scaler->clk);
> +vref_config_error:
>  clk_enable_error:
>  poll_timeout_error:
>  	reset_control_assert(data->rst);
>  reset_error:
>  	clk_hw_unregister_divider(data->clk_scaler);
>  scaler_error:
> -	clk_hw_unregister_divider(data->clk_prescaler);
> +	if (model_data->version <= aspeed_adc_ast2500)
> +		clk_hw_unregister_divider(data->clk_prescaler);

Consider a conversion to devm_add_action_or_reset() based cleanup
for these and potentially all the undwinding currently in remove.
It tends to end up simpler, particularly when there are parts of
probe that only happen for some supported devices.

>  	return ret;
>  }
>  
> @@ -295,36 +371,48 @@ static int aspeed_adc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);

I'm curious.  Before this patch, this was never set, so did the driver
just crash on remove?

>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> +	const struct aspeed_adc_model_data *model_data;

I would suggest storing a pointer to this in the iio_priv() as you
reference it from multiple places.

>  
> +	model_data = of_device_get_match_data(&pdev->dev);
>  	iio_device_unregister(indio_dev);
>  	writel(ASPEED_ADC_OPERATION_MODE_POWER_DOWN,
>  		data->base + ASPEED_REG_ENGINE_CONTROL);
>  	clk_disable_unprepare(data->clk_scaler->clk);
>  	reset_control_assert(data->rst);
>  	clk_hw_unregister_divider(data->clk_scaler);
> -	clk_hw_unregister_divider(data->clk_prescaler);
> +	if (model_data->version <= aspeed_adc_ast2500)
> +		clk_hw_unregister_divider(data->clk_prescaler);
>  
>  	return 0;
>  }
>  
>  static const struct aspeed_adc_model_data ast2400_model_data = {
> -	.model_name = "ast2400-adc",
> -	.vref_voltage = 2500, // mV
> +	.version = aspeed_adc_ast2400,
>  	.min_sampling_rate = 10000,
>  	.max_sampling_rate = 500000,
> +	.num_channels = 16,
>  };
>  
>  static const struct aspeed_adc_model_data ast2500_model_data = {
> -	.model_name = "ast2500-adc",
> -	.vref_voltage = 1800, // mV
> -	.min_sampling_rate = 1,
> -	.max_sampling_rate = 1000000,
> +	.version = aspeed_adc_ast2500,
> +	.min_sampling_rate = 10000,
> +	.max_sampling_rate = 500000,
> +	.wait_init_sequence = true,
> +	.num_channels = 16,
> +};
> +
> +static const struct aspeed_adc_model_data ast2600_model_data = {
> +	.version = aspeed_adc_ast2600,
> +	.min_sampling_rate = 10000,
> +	.max_sampling_rate = 500000,
>  	.wait_init_sequence = true,
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
> @@ -341,5 +429,5 @@ static struct platform_driver aspeed_adc_driver = {
>  module_platform_driver(aspeed_adc_driver);
>  
>  MODULE_AUTHOR("Rick Altherr <raltherr@google.com>");
> -MODULE_DESCRIPTION("Aspeed AST2400/2500 ADC Driver");
> +MODULE_DESCRIPTION("Aspeed AST2400/2500/2600 ADC Driver");
>  MODULE_LICENSE("GPL");

