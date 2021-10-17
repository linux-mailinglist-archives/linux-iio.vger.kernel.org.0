Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978F443087F
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbhJQLwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234082AbhJQLwY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:52:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1685C60F70;
        Sun, 17 Oct 2021 11:50:09 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:54:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v4 1/9] iio: adc: ab8500-gpadc: Make use of the helper
 function dev_err_probe()
Message-ID: <20211017125424.3b9a205a@jic23-huawei>
In-Reply-To: <20211008092858.495-1-caihuoqing@baidu.com>
References: <20211008092858.495-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Oct 2021 17:28:49 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Hi Cai,

Series applied to the iio-togreg branch of iio.git and pushed out as testing
for 0-day to poke at it and see if it can find any problems we missed.

Thanks,

Jonathan

> ---
> v1->v2: Remove the separate line of PTR_ERR().
> v2: Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> v2->v3: Handle platform_get_irq_byname() that returns -EPROBE_DEFER.
> 
>  drivers/iio/adc/ab8500-gpadc.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> index 7b5212ba5501..4c46a201d4ef 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -1103,17 +1103,15 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	gpadc->irq_sw = platform_get_irq_byname(pdev, "SW_CONV_END");
> -	if (gpadc->irq_sw < 0) {
> -		dev_err(dev, "failed to get platform sw_conv_end irq\n");
> -		return gpadc->irq_sw;
> -	}
> +	if (gpadc->irq_sw < 0)
> +		return dev_err_probe(dev, gpadc->irq_sw,
> +				     "failed to get platform sw_conv_end irq\n");
>  
>  	if (is_ab8500(gpadc->ab8500)) {
>  		gpadc->irq_hw = platform_get_irq_byname(pdev, "HW_CONV_END");
> -		if (gpadc->irq_hw < 0) {
> -			dev_err(dev, "failed to get platform hw_conv_end irq\n");
> -			return gpadc->irq_hw;
> -		}
> +		if (gpadc->irq_hw < 0)
> +			return dev_err_probe(dev, gpadc->irq_hw,
> +					     "failed to get platform hw_conv_end irq\n");
>  	} else {
>  		gpadc->irq_hw = 0;
>  	}
> @@ -1146,11 +1144,9 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>  
>  	/* The VTVout LDO used to power the AB8500 GPADC */
>  	gpadc->vddadc = devm_regulator_get(dev, "vddadc");
> -	if (IS_ERR(gpadc->vddadc)) {
> -		ret = PTR_ERR(gpadc->vddadc);
> -		dev_err(dev, "failed to get vddadc\n");
> -		return ret;
> -	}
> +	if (IS_ERR(gpadc->vddadc))
> +		return dev_err_probe(dev, PTR_ERR(gpadc->vddadc),
> +				     "failed to get vddadc\n");
>  
>  	ret = regulator_enable(gpadc->vddadc);
>  	if (ret) {

