Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC841CAA1
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 18:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245323AbhI2Qxo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 12:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245180AbhI2Qxn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Sep 2021 12:53:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C1361411;
        Wed, 29 Sep 2021 16:51:57 +0000 (UTC)
Date:   Wed, 29 Sep 2021 17:55:51 +0100
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
Subject: Re: [PATCH v3 8/9] iio: adc: rockchip_saradc: Make use of the
 helper function dev_err_probe()
Message-ID: <20210929175551.7517b018@jic23-huawei>
In-Reply-To: <20210928141956.2148-8-caihuoqing@baidu.com>
References: <20210928141956.2148-1-caihuoqing@baidu.com>
        <20210928141956.2148-8-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 22:19:54 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

In this driver, there is also a call to
devm_reset_control_get_exclusive() which I think can return
-EPROBE_DEFER

There isn't a message printed on that particular patch, but it would
be good to add something generic. Same for platform_get_irq()

There are some devm_clk_get() calls as well which likewise probably
want handling in a similar fashion as you have done in other patches.

Thanks,

Jonathan


> ---
> v1->v2: Remove the separate line of PTR_ERR().
> 
>  drivers/iio/adc/rockchip_saradc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index a56a0d7337ca..57419ccb3c70 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -392,11 +392,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	}
>  
>  	info->vref = devm_regulator_get(&pdev->dev, "vref");
> -	if (IS_ERR(info->vref)) {
> -		dev_err(&pdev->dev, "failed to get regulator, %ld\n",
> -			PTR_ERR(info->vref));
> -		return PTR_ERR(info->vref);
> -	}
> +	if (IS_ERR(info->vref))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->vref),
> +				     "failed to get regulator\n");
>  
>  	if (info->reset)
>  		rockchip_saradc_reset_controller(info->reset);

