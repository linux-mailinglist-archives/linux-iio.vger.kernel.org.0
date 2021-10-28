Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73C643E263
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 15:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJ1Nio convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 28 Oct 2021 09:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhJ1Nio (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 09:38:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5584161056;
        Thu, 28 Oct 2021 13:36:15 +0000 (UTC)
Date:   Thu, 28 Oct 2021 14:40:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?QW5kcsOp?= Gustavo Nakagomi Lopez <andregnl@usp.br>
Cc:     lars@metafoo.de, vz@mleia.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: lpc18xx_adc: Reorder clk_get_rate function
 call
Message-ID: <20211028144041.20407149@jic23-huawei>
In-Reply-To: <YXag5l4xBkGQH3tq@Andryuu.br>
References: <YXag5l4xBkGQH3tq@Andryuu.br>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 Oct 2021 09:19:50 -0300
André Gustavo Nakagomi Lopez <andregnl@usp.br> wrote:

> clk_get_rate is not guaranteed to work if called before clk_prepare_enable.
> 
> Reorder clk_get_rate, so it's called after clk_prepare_enable and
> after devm_add_action_or_reset of lpc18xx_clk_disable.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>

Thanks. I tweaked the message a little and added a note that this was not
a fix for this particular platform.  Good to avoid chance of cut and paste
into another driver!

Jonathan

> ---
> Change log V1 -> V2:
> 		  -Fixed typo
> 		  -Added appropriate Suggested-by and Acked-by tags
>  drivers/iio/adc/lpc18xx_adc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index ceefa4d793cf..ae9c9384f23e 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -157,9 +157,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
>  				     "error getting clock\n");
>  
> -	rate = clk_get_rate(adc->clk);
> -	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
> -
>  	adc->vref = devm_regulator_get(&pdev->dev, "vref");
>  	if (IS_ERR(adc->vref))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(adc->vref),
> @@ -192,6 +189,9 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	rate = clk_get_rate(adc->clk);
> +	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
> +
>  	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
>  			LPC18XX_ADC_CR_PDN;
>  	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);

