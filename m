Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6AA37C282
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 17:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhELPLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 11:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhELPII (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 11:08:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B6AF611AD;
        Wed, 12 May 2021 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620831704;
        bh=tl1Us0IjRXhQGvdTa2eYDls5gfP5C2BFoj6/gJWmsic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fG/zv8OFlpR1FwPAbCRcICrQOWzjYXcR+Pz79e/YbQRK1IYk2XcVckGZ58aGvh0EX
         t+8oR0dJOKMtqbYJ+RrOguAJM05DilWcuJgnzD3wshICk09B1FCWgJy/jZ8b1W3iRI
         SqZrU9RuisT2xI9A9eE5f2yFldZSvDQjrpwTy7WGNRmfrwWCqc6Wsj66h+NMsWppjd
         Vp85O7U9BD2MAZWLH3+bBLqxcoYths6XJHp1NxO1qSnIWtSjVINW+RdY2lHHUK4tab
         z0i+zXh7ugCzgbM9EEQaq+r7Nj7viMAobbRqvrVMZpp1JLOYnR9cZr2UeuEAcYQDof
         XO00op2U3lCzA==
Date:   Wed, 12 May 2021 17:01:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 28/28] iio: adc: rcar-gyroadc: Use
 pm_runtime_resume_and_get() and check in probe()
Message-ID: <20210512170140.0e79aa86@coco.lan>
In-Reply-To: <20210509113354.660190-29-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-29-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:54 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> 1 instance found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> The other instance changed did not check for failure of the
> pm_runtime_get_sync() so that is added.
> 
> Note the remaining pm_runtime_get_sync() call is left alone because it
> is not obvious what to do on failure to power up in remove()
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Marek Vasut <marek.vasut@gmail.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/adc/rcar-gyroadc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index 9f38cf3c7dc2..a48895046408 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -162,18 +162,13 @@ static const struct iio_chan_spec rcar_gyroadc_iio_channels_3[] = {
>  static int rcar_gyroadc_set_power(struct rcar_gyroadc *priv, bool on)
>  {
>  	struct device *dev = priv->dev;
> -	int ret;
>  
>  	if (on) {
> -		ret = pm_runtime_get_sync(dev);
> -		if (ret < 0)
> -			pm_runtime_put_noidle(dev);
> +		return pm_runtime_resume_and_get(dev);
>  	} else {
>  		pm_runtime_mark_last_busy(dev);
> -		ret = pm_runtime_put_autosuspend(dev);
> +		return pm_runtime_put_autosuspend(dev);
>  	}
> -
> -	return ret;
>  }
>  
>  static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
> @@ -535,7 +530,10 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_enable(dev);
>  
> -	pm_runtime_get_sync(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		goto err_power_up;
> +
>  	rcar_gyroadc_hw_init(priv);
>  	rcar_gyroadc_hw_start(priv);
>  
> @@ -552,6 +550,7 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
>  err_iio_device_register:
>  	rcar_gyroadc_hw_stop(priv);
>  	pm_runtime_put_sync(dev);
> +err_power_up:
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
>  	clk_disable_unprepare(priv->clk);



Thanks,
Mauro
