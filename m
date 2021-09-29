Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3A841CA3A
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 18:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbhI2QiM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 12:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345687AbhI2QiM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Sep 2021 12:38:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC20613D0;
        Wed, 29 Sep 2021 16:36:25 +0000 (UTC)
Date:   Wed, 29 Sep 2021 17:40:19 +0100
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
Subject: Re: [PATCH v3 5/9] iio: adc: max1241: Make use of the helper
 function dev_err_probe()
Message-ID: <20210929174019.3f93dfde@jic23-huawei>
In-Reply-To: <20210928141956.2148-5-caihuoqing@baidu.com>
References: <20210928141956.2148-1-caihuoqing@baidu.com>
        <20210928141956.2148-5-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 22:19:51 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Hi Cai,

Please also add a message to the
devm_gpiod_get_optional() and similar handling so that we
maintain information on that as well.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1241.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
> index b60f8448f21a..130ca8dc6fa0 100644
> --- a/drivers/iio/adc/max1241.c
> +++ b/drivers/iio/adc/max1241.c
> @@ -148,10 +148,9 @@ static int max1241_probe(struct spi_device *spi)
>  	mutex_init(&adc->lock);
>  
>  	adc->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(adc->vdd)) {
> -		dev_err(dev, "failed to get vdd regulator\n");
> -		return PTR_ERR(adc->vdd);
> -	}
> +	if (IS_ERR(adc->vdd))
> +		return dev_err_probe(dev, PTR_ERR(adc->vdd),
> +				     "failed to get vdd regulator\n");
>  
>  	ret = regulator_enable(adc->vdd);
>  	if (ret)
> @@ -164,10 +163,9 @@ static int max1241_probe(struct spi_device *spi)
>  	}
>  
>  	adc->vref = devm_regulator_get(dev, "vref");
> -	if (IS_ERR(adc->vref)) {
> -		dev_err(dev, "failed to get vref regulator\n");
> -		return PTR_ERR(adc->vref);
> -	}
> +	if (IS_ERR(adc->vref))
> +		return dev_err_probe(dev, PTR_ERR(adc->vref),
> +				     "failed to get vref regulator\n");
>  
>  	ret = regulator_enable(adc->vref);
>  	if (ret)

