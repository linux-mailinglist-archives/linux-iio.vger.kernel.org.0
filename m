Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED56F41C9FF
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbhI2QYT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 12:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344369AbhI2QYT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Sep 2021 12:24:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275C461246;
        Wed, 29 Sep 2021 16:22:32 +0000 (UTC)
Date:   Wed, 29 Sep 2021 17:26:27 +0100
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
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3 2/9] iio: adc: imx7d_adc: Make use of the helper
 function dev_err_probe()
Message-ID: <20210929172627.1dfd4f17@jic23-huawei>
In-Reply-To: <20210928141956.2148-2-caihuoqing@baidu.com>
References: <20210928141956.2148-1-caihuoqing@baidu.com>
        <20210928141956.2148-2-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 22:19:48 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Hi Cai,

It is currently not printing a message, but should we handle the same
for platform_get_irq?

One other minor comment inline.  Actual change here is fine.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 4969a5f941e3..f47360cbff3b 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -496,19 +496,13 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  		return irq;
>  
>  	info->clk = devm_clk_get(dev, "adc");
> -	if (IS_ERR(info->clk)) {
> -		ret = PTR_ERR(info->clk);
> -		dev_err(dev, "Failed getting clock, err = %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk), "Failed getting clock\n");

Where it doesn't hurt readabilty preferred to keep below 80 chars.

>  
>  	info->vref = devm_regulator_get(dev, "vref");
> -	if (IS_ERR(info->vref)) {
> -		ret = PTR_ERR(info->vref);
> -		dev_err(dev,
> -			"Failed getting reference voltage, err = %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(info->vref))
> +		return dev_err_probe(dev, PTR_ERR(info->vref),
> +				     "Failed getting reference voltage\n");
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  

