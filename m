Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF01428269
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhJJQD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 12:03:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232849AbhJJQD0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Oct 2021 12:03:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6337460F5B;
        Sun, 10 Oct 2021 16:01:21 +0000 (UTC)
Date:   Sun, 10 Oct 2021 17:05:27 +0100
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
Subject: Re: [PATCH v4 6/9] iio: adc: meson_saradc: Make use of the helper
 function dev_err_probe()
Message-ID: <20211010170527.13547811@jic23-huawei>
In-Reply-To: <20211008092858.495-6-caihuoqing@baidu.com>
References: <20211008092858.495-1-caihuoqing@baidu.com>
        <20211008092858.495-6-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Oct 2021 17:28:54 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Make sure you don't miss any tags on previous versions.  This had:

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #Meson8b Odroid-C1


> v1->v2: Remove the separate line of PTR_ERR().
> 
>  drivers/iio/adc/meson_saradc.c | 39 +++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 705d5e11a54b..62cc6fb0ef85 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1230,35 +1230,31 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	priv->clkin = devm_clk_get(&pdev->dev, "clkin");
> -	if (IS_ERR(priv->clkin)) {
> -		dev_err(&pdev->dev, "failed to get clkin\n");
> -		return PTR_ERR(priv->clkin);
> -	}
> +	if (IS_ERR(priv->clkin))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clkin),
> +				     "failed to get clkin\n");
>  
>  	priv->core_clk = devm_clk_get(&pdev->dev, "core");
> -	if (IS_ERR(priv->core_clk)) {
> -		dev_err(&pdev->dev, "failed to get core clk\n");
> -		return PTR_ERR(priv->core_clk);
> -	}
> +	if (IS_ERR(priv->core_clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->core_clk),
> +				     "failed to get core clk\n");
>  
>  	priv->adc_clk = devm_clk_get(&pdev->dev, "adc_clk");
>  	if (IS_ERR(priv->adc_clk)) {
> -		if (PTR_ERR(priv->adc_clk) == -ENOENT) {
> +		if (PTR_ERR(priv->adc_clk) == -ENOENT)
>  			priv->adc_clk = NULL;
> -		} else {
> -			dev_err(&pdev->dev, "failed to get adc clk\n");
> -			return PTR_ERR(priv->adc_clk);
> -		}
> +		else
> +			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_clk),
> +					     "failed to get adc clk\n");
>  	}
>  
>  	priv->adc_sel_clk = devm_clk_get(&pdev->dev, "adc_sel");
>  	if (IS_ERR(priv->adc_sel_clk)) {
> -		if (PTR_ERR(priv->adc_sel_clk) == -ENOENT) {
> +		if (PTR_ERR(priv->adc_sel_clk) == -ENOENT)
>  			priv->adc_sel_clk = NULL;
> -		} else {
> -			dev_err(&pdev->dev, "failed to get adc_sel clk\n");
> -			return PTR_ERR(priv->adc_sel_clk);
> -		}
> +		else
> +			return dev_err_probe(&pdev->dev, PTR_ERR(priv->adc_sel_clk),
> +					     "failed to get adc_sel clk\n");
>  	}
>  
>  	/* on pre-GXBB SoCs the SAR ADC itself provides the ADC clock: */
> @@ -1269,10 +1265,9 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	priv->vref = devm_regulator_get(&pdev->dev, "vref");
> -	if (IS_ERR(priv->vref)) {
> -		dev_err(&pdev->dev, "failed to get vref regulator\n");
> -		return PTR_ERR(priv->vref);
> -	}
> +	if (IS_ERR(priv->vref))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->vref),
> +				     "failed to get vref regulator\n");
>  
>  	priv->calibscale = MILLION;
>  

