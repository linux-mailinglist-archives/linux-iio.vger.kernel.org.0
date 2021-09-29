Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47941C9EE
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 18:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbhI2QSP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 12:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhI2QSO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Sep 2021 12:18:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DDEB6159A;
        Wed, 29 Sep 2021 16:16:27 +0000 (UTC)
Date:   Wed, 29 Sep 2021 17:20:21 +0100
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
Subject: Re: [PATCH v3 1/9] iio: adc: ab8500-gpadc: Make use of the helper
 function dev_err_probe()
Message-ID: <20210929172021.4b797990@jic23-huawei>
In-Reply-To: <20210928141956.2148-1-caihuoqing@baidu.com>
References: <20210928141956.2148-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 22:19:47 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

I believe we could in theory get an -EPROBE_DEFER from
platform_get_irq_by_name() so we should handle that one similarly.

I have no idea if can actually happen on this platform, but seems to me
that we should be thorough given how easy it is to do here.

Thanks,

Jonathan

> ---
> v1->v2: Remove the separate line of PTR_ERR().
> 
>  drivers/iio/adc/ab8500-gpadc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> index 7b5212ba5501..c58d0e2ae538 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -1146,11 +1146,9 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
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

