Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF32E7272
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 17:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgL2Q5b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 11:57:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgL2Q5b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 11:57:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B673207C9;
        Tue, 29 Dec 2020 16:56:50 +0000 (UTC)
Date:   Tue, 29 Dec 2020 16:56:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: ab8500-gpadc: Support non-hw-conversion
Message-ID: <20201229165647.3d162fa1@archlinux>
In-Reply-To: <20201218222013.383704-1-linus.walleij@linaro.org>
References: <20201218222013.383704-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Dec 2020 23:20:13 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> The hardware conversion mode only exists in the AB8500
> version of the chip, as it is lacking in the AB8505 it
> will not be in the device tree and we should just not
> even try to obtain it.
> 
> The driver already contains code to avoid using a
> non-existing hardware conversion IRQ at conversion time.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for all
the normal reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ab8500-gpadc.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> index 1bb987a4acba..6f9a3e2d5533 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -1108,10 +1108,14 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>  		return gpadc->irq_sw;
>  	}
>  
> -	gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
> -	if (gpadc->irq_hw < 0) {
> -		dev_err(dev, "failed to get platform hw_conv_end irq\n");
> -		return gpadc->irq_hw;
> +	if (is_ab8500(gpadc->ab8500)) {
> +		gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
> +		if (gpadc->irq_hw < 0) {
> +			dev_err(dev, "failed to get platform hw_conv_end irq\n");
> +			return gpadc->irq_hw;
> +		}
> +	} else {
> +		gpadc->irq_hw = 0;
>  	}
>  
>  	/* Initialize completion used to notify completion of conversion */
> @@ -1128,14 +1132,16 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = devm_request_threaded_irq(dev, gpadc->irq_hw, NULL,
> -		ab8500_bm_gpadcconvend_handler,	IRQF_NO_SUSPEND | IRQF_ONESHOT,
> -		"ab8500-gpadc-hw", gpadc);
> -	if (ret < 0) {
> -		dev_err(dev,
> -			"Failed to request hw conversion irq: %d\n",
> -			gpadc->irq_hw);
> -		return ret;
> +	if (gpadc->irq_hw) {
> +		ret = devm_request_threaded_irq(dev, gpadc->irq_hw, NULL,
> +			ab8500_bm_gpadcconvend_handler,	IRQF_NO_SUSPEND | IRQF_ONESHOT,
> +			"ab8500-gpadc-hw", gpadc);
> +		if (ret < 0) {
> +			dev_err(dev,
> +				"Failed to request hw conversion irq: %d\n",
> +				gpadc->irq_hw);
> +			return ret;
> +		}
>  	}
>  
>  	/* The VTVout LDO used to power the AB8500 GPADC */

