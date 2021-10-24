Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378FD438BC8
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJXUXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 16:23:55 -0400
Received: from mleia.com ([178.79.152.223]:47074 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231563AbhJXUXz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 16:23:55 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Oct 2021 16:23:55 EDT
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id C00F42E3E5;
        Sun, 24 Oct 2021 20:12:40 +0000 (UTC)
Subject: Re: [PATCH] iio: adc: lpc18xx_adc: Reorder clk_get_rate function call
To:     =?UTF-8?Q?Andr=c3=a9_Gustavo_Nakagomi_Lopez?= <andregnl@usp.br>,
        jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <YXW3azIjPzGjvjTX@Andryuu.br>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <bd79117b-91cc-da4b-abdd-2a41db8b330a@mleia.com>
Date:   Sun, 24 Oct 2021 23:12:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YXW3azIjPzGjvjTX@Andryuu.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20211024_201240_805681_00140E3F 
X-CRM114-Status: GOOD (  14.96  )
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi André,

On 10/24/21 10:43 PM, André Gustavo Nakagomi Lopez wrote:
> clk_get_rate is not garanteed to work if called before clk_prepare_enable.

typo, s/garanteed/guaranteed/

> 
> Reorder clk_get_rate, so it's called after clk_prepare_enable and
> after devm_add_action_or_reset of lpc18xx_clk_disable.
> 
> Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
> ---
>   drivers/iio/adc/lpc18xx_adc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index ceefa4d793cf..ae9c9384f23e 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -157,9 +157,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
>   		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
>   				     "error getting clock\n");
>   
> -	rate = clk_get_rate(adc->clk);
> -	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
> -
>   	adc->vref = devm_regulator_get(&pdev->dev, "vref");
>   	if (IS_ERR(adc->vref))
>   		return dev_err_probe(&pdev->dev, PTR_ERR(adc->vref),
> @@ -192,6 +189,9 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	rate = clk_get_rate(adc->clk);
> +	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
> +
>   	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
>   			LPC18XX_ADC_CR_PDN;
>   	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
> 

Thank you for the change, per se this particular change is not needed on
LPC18xx/43xx platform, however I don't object to it.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
