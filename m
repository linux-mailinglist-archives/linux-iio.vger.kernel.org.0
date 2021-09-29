Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9441C8D8
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 17:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbhI2P6Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 11:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244682AbhI2P6Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Sep 2021 11:58:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A57E860EE2;
        Wed, 29 Sep 2021 15:56:41 +0000 (UTC)
Date:   Wed, 29 Sep 2021 17:00:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] iio: light: cm3605: Make use of the helper
 function dev_err_probe()
Message-ID: <20210929170035.619212d4@jic23-huawei>
In-Reply-To: <20210928014156.1491-1-caihuoqing@baidu.com>
References: <20210928014156.1491-1-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Sep 2021 09:41:52 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Hi Cai,

This driver has some more cases where we should potentially do something
like this.

It handles the lack of availability of an IIO channel in line 199
by converting an -ENODEV to an -EPROBE_DEFER.

Also platform_get_irq() can return -EPROBE_DEFER and the driver
isn't currently handling that properly.

Both changes are of a more involved nature than the simple conversions you
have here though, so perhaps a follow up patch?

The parts you here look good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm3605.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
> index 4c83953672be..0b90564213e8 100644
> --- a/drivers/iio/light/cm3605.c
> +++ b/drivers/iio/light/cm3605.c
> @@ -211,10 +211,10 @@ static int cm3605_probe(struct platform_device *pdev)
>  	}
>  
>  	cm3605->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(cm3605->vdd)) {
> -		dev_err(dev, "failed to get VDD regulator\n");
> -		return PTR_ERR(cm3605->vdd);
> -	}
> +	if (IS_ERR(cm3605->vdd))
> +		return dev_err_probe(dev, PTR_ERR(cm3605->vdd),
> +				     "failed to get VDD regulator\n");
> +
>  	ret = regulator_enable(cm3605->vdd);
>  	if (ret) {
>  		dev_err(dev, "failed to enable VDD regulator\n");
> @@ -223,8 +223,7 @@ static int cm3605_probe(struct platform_device *pdev)
>  
>  	cm3605->aset = devm_gpiod_get(dev, "aset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(cm3605->aset)) {
> -		dev_err(dev, "no ASET GPIO\n");
> -		ret = PTR_ERR(cm3605->aset);
> +		ret = dev_err_probe(dev, PTR_ERR(cm3605->aset), "no ASET GPIO\n");
>  		goto out_disable_vdd;
>  	}
>  

