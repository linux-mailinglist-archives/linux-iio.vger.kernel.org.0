Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF8B43085E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245520AbhJQLdb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 17 Oct 2021 07:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242003AbhJQLda (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:33:30 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41E3A61252;
        Sun, 17 Oct 2021 11:31:18 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:35:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QW5kcsOp?= Gustavo Nakagomi Lopez <andregnl@usp.br>,
        linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: lpc18xx_adc: Convert probe to device
 managed version
Message-ID: <20211017123533.33883e16@jic23-huawei>
In-Reply-To: <YWnMsGlc/I35gYvy@Andryuu.br>
References: <YWnMsGlc/I35gYvy@Andryuu.br>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Oct 2021 15:47:12 -0300
André Gustavo Nakagomi Lopez <andregnl@usp.br> wrote:

> The remove function and the goto sections are not necessary if devm
> functions are used.
> 
> Convert device register to devm version. Add hook functions to release
> device resources, and use them inside probe with devm_add_action,
> which will release resources on driver detach.
> 
> To maintain the order of which device resources were released/reseted,
> register the hook functions as soon as resources are obtained/initialized.
> Since devres actions are called on driver detach, the remove
> function and the error-handling goto sections are no longer necessary.
> 
> Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>

Hi André

Looks good to me, but I did notice an unrelated issue whilst looking at this driver.
Comment on that inline.  Follow up patch welcome!

Applied to the togreg branch of iio.git and pushed out as testing to let 0-day
see if it can find anything we missed.

Thanks,

Jonathan



> ---
> Change log V1 -> V2:
>        -Renamed lpc18xx_clk_disable_unprepare function
>        -Removed platform_set_drvdata(pdev, indio_dev)
>        -Renamed lpc18xx_writel to lpc18xx_clear_cr_reg
>        -devm_iio_device_register now returns directly in the end of probe function
>  drivers/iio/adc/lpc18xx_adc.c | 61 ++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index 3566990ae87d..7d50107427ac 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -115,6 +115,23 @@ static const struct iio_info lpc18xx_adc_info = {
>  	.read_raw = lpc18xx_adc_read_raw,
>  };
>  
> +static void lpc18xx_clear_cr_reg(void *data)
> +{
> +	struct lpc18xx_adc *adc = data;
> +
> +	writel(0, adc->base + LPC18XX_ADC_CR);
> +}
> +
> +static void lpc18xx_clk_disable(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static void lpc18xx_regulator_disable(void *vref)
> +{
> +	regulator_disable(vref);
> +}
> +
>  static int lpc18xx_adc_probe(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev;
> @@ -127,7 +144,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -	platform_set_drvdata(pdev, indio_dev);
>  	adc = iio_priv(indio_dev);
>  	adc->dev = &pdev->dev;
>  	mutex_init(&adc->lock);
> @@ -163,44 +179,30 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_regulator_disable, adc->vref);
> +	if (ret)
> +		return ret;
> +
>  	ret = clk_prepare_enable(adc->clk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to enable clock\n");
> -		goto dis_reg;
> +		return ret;

Unrelated but clk_get_rate() as called before the clk_prepare_enable() is not guaranteed
to work.   So a good follow up patch would reorder that to be after the clk is turned on.


>  	}
>  
> +	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable,
> +				       adc->clk);
> +	if (ret)
> +		return ret;
> +
>  	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
>  			LPC18XX_ADC_CR_PDN;
>  	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to register device\n");
> -		goto dis_clk;
> -	}
> -
> -	return 0;
> -
> -dis_clk:
> -	writel(0, adc->base + LPC18XX_ADC_CR);
> -	clk_disable_unprepare(adc->clk);
> -dis_reg:
> -	regulator_disable(adc->vref);
> -	return ret;
> -}
> -
> -static int lpc18xx_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -	struct lpc18xx_adc *adc = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	writel(0, adc->base + LPC18XX_ADC_CR);
> -	clk_disable_unprepare(adc->clk);
> -	regulator_disable(adc->vref);
> +	ret = devm_add_action_or_reset(&pdev->dev, lpc18xx_clear_cr_reg, adc);
> +	if (ret)
> +		return ret;
>  
> -	return 0;
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  
>  static const struct of_device_id lpc18xx_adc_match[] = {
> @@ -211,7 +213,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_adc_match);
>  
>  static struct platform_driver lpc18xx_adc_driver = {
>  	.probe	= lpc18xx_adc_probe,
> -	.remove	= lpc18xx_adc_remove,
>  	.driver	= {
>  		.name = "lpc18xx-adc",
>  		.of_match_table = lpc18xx_adc_match,

