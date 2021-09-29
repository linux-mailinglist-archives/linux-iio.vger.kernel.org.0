Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF1841C998
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 18:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345695AbhI2QHB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 12:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346039AbhI2QFv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Sep 2021 12:05:51 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C3A61407;
        Wed, 29 Sep 2021 16:04:08 +0000 (UTC)
Date:   Wed, 29 Sep 2021 17:08:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: light: gp2ap002: Make use of the helper
 function dev_err_probe()
Message-ID: <20210929170802.1ab77b3a@jic23-huawei>
In-Reply-To: <20210928014156.1491-3-caihuoqing@baidu.com>
References: <20210928014156.1491-1-caihuoqing@baidu.com>
        <20210928014156.1491-3-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:41:54 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

There is an explicit return of -EPROBE_DEFER in here that we should
probably also handle.

https://elixir.bootlin.com/linux/latest/source/drivers/iio/light/gp2ap002.c#L508


I guess simplest option is
return dev_err_probe(dev, -EPROBE_DEFER, "no ADC, deferring\n");

> ---
>  drivers/iio/light/gp2ap002.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index f960be7d4001..724a3928ead1 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -521,15 +521,14 @@ static int gp2ap002_probe(struct i2c_client *client,
>  	}
>  
>  	gp2ap002->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(gp2ap002->vdd)) {
> -		dev_err(dev, "failed to get VDD regulator\n");
> -		return PTR_ERR(gp2ap002->vdd);
> -	}
> +	if (IS_ERR(gp2ap002->vdd))
> +		return dev_err_probe(dev, PTR_ERR(gp2ap002->vdd),
> +				     "failed to get VDD regulator\n");
> +
>  	gp2ap002->vio = devm_regulator_get(dev, "vio");
> -	if (IS_ERR(gp2ap002->vio)) {
> -		dev_err(dev, "failed to get VIO regulator\n");
> -		return PTR_ERR(gp2ap002->vio);
> -	}
> +	if (IS_ERR(gp2ap002->vio))
> +		return dev_err_probe(dev, PTR_ERR(gp2ap002->vio),
> +				     "failed to get VIO regulator\n");
>  
>  	/* Operating voltage 2.4V .. 3.6V according to datasheet */
>  	ret = regulator_set_voltage(gp2ap002->vdd, 2400000, 3600000);

