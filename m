Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABC03FAC77
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhH2PSM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhH2PSH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:18:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB906606A5;
        Sun, 29 Aug 2021 15:17:09 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:20:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 08/15] iio: adc: aspeed: Use model_data to set clk
 scaler.
Message-ID: <20210829162022.7ee18854@jic23-huawei>
In-Reply-To: <202108250006.17P06IgG097015@twspam01.aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <202108250006.17P06IgG097015@twspam01.aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:36 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> This patch use need_prescaler and scaler_bit_width to set the adc clock
> scaler.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Hi Billy,

One minor comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 39 +++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 2d6215a91f99..52db38be9699 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -202,9 +202,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
>  	struct aspeed_adc_data *data;
> -	const char *clk_parent_name;
>  	int ret;
>  	u32 adc_engine_control_reg_val;
> +	unsigned long scaler_flags = 0;
> +	char clk_name[32], clk_parent_name[32];
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -221,24 +222,28 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  
>  	/* Register ADC clock prescaler with source specified by device tree. */
>  	spin_lock_init(&data->clk_lock);
> -	clk_parent_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
> -
> -	data->clk_prescaler = clk_hw_register_divider(
> -				&pdev->dev, "prescaler", clk_parent_name, 0,
> -				data->base + ASPEED_REG_CLOCK_CONTROL,
> -				17, 15, 0, &data->clk_lock);
> -	if (IS_ERR(data->clk_prescaler))
> -		return PTR_ERR(data->clk_prescaler);
> -
> +	snprintf(clk_parent_name, 32, of_clk_get_parent_name(pdev->dev.of_node, 0));

ARRAY_SIZE(clk_parent_name) instead of 32.
Same for other places this pattern occurs.


> +	if (data->model_data->need_prescaler) {
> +		snprintf(clk_name, 32, "%s-prescaler",
> +			 data->model_data->model_name);
> +		data->clk_prescaler = clk_hw_register_divider(
> +			&pdev->dev, clk_name, clk_parent_name, 0,
> +			data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15, 0,
> +			&data->clk_lock);
> +		if (IS_ERR(data->clk_prescaler))
> +			return PTR_ERR(data->clk_prescaler);
> +		snprintf(clk_parent_name, 32, clk_name);
> +		scaler_flags = CLK_SET_RATE_PARENT;
> +	}
>  	/*
>  	 * Register ADC clock scaler downstream from the prescaler. Allow rate
>  	 * setting to adjust the prescaler as well.
>  	 */
> +	snprintf(clk_name, 32, "%s-scaler", data->model_data->model_name);
>  	data->clk_scaler = clk_hw_register_divider(
> -				&pdev->dev, "scaler", "prescaler",
> -				CLK_SET_RATE_PARENT,
> -				data->base + ASPEED_REG_CLOCK_CONTROL,
> -				0, 10, 0, &data->clk_lock);
> +		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
> +		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
> +		data->model_data->scaler_bit_width, 0, &data->clk_lock);
>  	if (IS_ERR(data->clk_scaler)) {
>  		ret = PTR_ERR(data->clk_scaler);
>  		goto scaler_error;
> @@ -310,7 +315,8 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  reset_error:
>  	clk_hw_unregister_divider(data->clk_scaler);
>  scaler_error:
> -	clk_hw_unregister_divider(data->clk_prescaler);
> +	if (data->model_data->need_prescaler)
> +		clk_hw_unregister_divider(data->clk_prescaler);
>  	return ret;
>  }
>  
> @@ -325,7 +331,8 @@ static int aspeed_adc_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(data->clk_scaler->clk);
>  	reset_control_assert(data->rst);
>  	clk_hw_unregister_divider(data->clk_scaler);
> -	clk_hw_unregister_divider(data->clk_prescaler);
> +	if (data->model_data->need_prescaler)
> +		clk_hw_unregister_divider(data->clk_prescaler);
>  
>  	return 0;
>  }

