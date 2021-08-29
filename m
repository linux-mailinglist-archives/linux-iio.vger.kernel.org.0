Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245A43FAC86
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbhH2PXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhH2PXd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:23:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E53660F45;
        Sun, 29 Aug 2021 15:22:35 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:25:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 09/15] iio: adc: aspeed: Use
 devm_add_action_or_reset.
Message-ID: <20210829162548.40aa9f91@jic23-huawei>
In-Reply-To: <202108250004.17P04FdD094082@twspam01.aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <202108250004.17P04FdD094082@twspam01.aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:37 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch use devm_add_action_or_reset to handle the error in probe
> phase.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/iio/adc/aspeed_adc.c | 92 +++++++++++++++++++++---------------
>  1 file changed, 55 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 52db38be9699..1c87e12a0cab 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -187,6 +187,27 @@ static const struct iio_info aspeed_adc_iio_info = {
>  	.debugfs_reg_access = aspeed_adc_reg_access,
>  };
>  
> +static void aspeed_adc_unregister_divider(void *data)
> +{
> +	struct clk_hw *clk = data;
> +
> +	clk_hw_unregister_divider(clk);
> +}
> +
> +static void aspeed_adc_reset_assert(void *data)
> +{
> +	struct reset_control *rst = data;
> +
> +	reset_control_assert(rst);
> +}
> +
> +static void aspeed_adc_clk_disable_unprepare(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_disable_unprepare(clk);
> +}
> +
>  static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
>  {
>  	struct aspeed_adc_data *data = iio_priv(indio_dev);
> @@ -232,6 +253,12 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  			&data->clk_lock);
>  		if (IS_ERR(data->clk_prescaler))
>  			return PTR_ERR(data->clk_prescaler);
> +
> +		ret = devm_add_action_or_reset(data->dev,
> +					       aspeed_adc_unregister_divider,
> +					       data->clk_prescaler);
> +		if (ret)
> +			return ret;
>  		snprintf(clk_parent_name, 32, clk_name);
>  		scaler_flags = CLK_SET_RATE_PARENT;
>  	}
> @@ -244,23 +271,30 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
>  		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
>  		data->model_data->scaler_bit_width, 0, &data->clk_lock);
> -	if (IS_ERR(data->clk_scaler)) {
> -		ret = PTR_ERR(data->clk_scaler);
> -		goto scaler_error;
> -	}
> +	if (IS_ERR(data->clk_scaler))
> +		return PTR_ERR(data->clk_scaler);
> +
> +	ret = devm_add_action_or_reset(data->dev, aspeed_adc_unregister_divider,
> +				       data->clk_scaler);
> +	if (ret)
> +		return ret;
>  
>  	data->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
>  	if (IS_ERR(data->rst)) {
>  		dev_err(&pdev->dev,
>  			"invalid or missing reset controller device tree entry");
> -		ret = PTR_ERR(data->rst);
> -		goto reset_error;
> +		return PTR_ERR(data->rst);
>  	}
>  	reset_control_deassert(data->rst);
>  
> +	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
> +				       data->rst);
> +	if (ret)
> +		return ret;
> +
>  	ret = aspeed_adc_vref_config(indio_dev);
>  	if (ret)
> -		goto vref_config_error;
> +		return ret;
>  
>  	if (data->model_data->wait_init_sequence) {
>  		/* Enable engine in normal mode. */
> @@ -277,13 +311,19 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  					 ASPEED_ADC_INIT_POLLING_TIME,
>  					 ASPEED_ADC_INIT_TIMEOUT);
>  		if (ret)
> -			goto poll_timeout_error;
> +			return ret;
>  	}
>  
>  	/* Start all channels in normal mode. */
>  	ret = clk_prepare_enable(data->clk_scaler->clk);
>  	if (ret)
> -		goto clk_enable_error;
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(data->dev,
> +				       aspeed_adc_clk_disable_unprepare,
> +				       data->clk_scaler->clk);
> +	if (ret)
> +		return ret;
>  
>  	adc_engine_control_reg_val =
>  		ASPEED_ADC_CTRL_CHANNEL |
> @@ -299,41 +339,19 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	indio_dev->num_channels = data->model_data->num_channels;
>  
>  	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto iio_register_error;
> -
> +	if (ret) {
> +		writel(FIELD_PREP(ASPEED_ADC_OP_MODE,
> +				  ASPEED_ADC_OP_MODE_PWR_DOWN),
> +		       data->base + ASPEED_REG_ENGINE_CONTROL);
> +		return ret;
> +	}
>  	return 0;
> -
> -iio_register_error:
> -	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
> -	       data->base + ASPEED_REG_ENGINE_CONTROL);
> -	clk_disable_unprepare(data->clk_scaler->clk);
> -clk_enable_error:
> -poll_timeout_error:
> -vref_config_error:
> -	reset_control_assert(data->rst);
> -reset_error:
> -	clk_hw_unregister_divider(data->clk_scaler);
> -scaler_error:
> -	if (data->model_data->need_prescaler)
> -		clk_hw_unregister_divider(data->clk_prescaler);
> -	return ret;
>  }
>  
>  static int aspeed_adc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct aspeed_adc_data *data = iio_priv(indio_dev);
> -
>  	iio_device_unregister(indio_dev);

Given there is no longer anything here, you should be safe to call
devm_iio_device_unregister() and get rid of this function entirely.


> -	writel(FIELD_PREP(ASPEED_ADC_OP_MODE, ASPEED_ADC_OP_MODE_PWR_DOWN),
> -	       data->base + ASPEED_REG_ENGINE_CONTROL);

Unless I'm missing something this is not handled via any of the
devm_add_action_or_reset() callbacks. You handle it in the error paths manually
but if you move this to managed as well you can drop that handling and still
have it automatically called on remove.


> -	clk_disable_unprepare(data->clk_scaler->clk);
> -	reset_control_assert(data->rst);
> -	clk_hw_unregister_divider(data->clk_scaler);
> -	if (data->model_data->need_prescaler)
> -		clk_hw_unregister_divider(data->clk_prescaler);
> -
>  	return 0;
>  }
>  

