Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F6737BE24
	for <lists+linux-iio@lfdr.de>; Wed, 12 May 2021 15:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhELNX5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 May 2021 09:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhELNX5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 May 2021 09:23:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46067613CA;
        Wed, 12 May 2021 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620825769;
        bh=+600oXmUz5yCA9BXwu6IsBzPyPlFFVP/G878xtyUWzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YBmJiVB7mcklbBf4tNS1KXO/hWJaveBBllEfUrkkQfILmLEtKPQuXKCWhzic86vQR
         aKdZRrvSORUVM6jABJQnVSbMT2UiFhzg1LYxoW1jSGGNHTyl1AsLlvFj+/DwgkSVLr
         hMwfdfNgb7HHavtb19E6IGCWO0ZPggvuEf/V6GPbrBO0CFG4S4A3BvlGG8cy6DX+hP
         JuNN22Qe2G0FXamjkhLeTxe7p3zWIHVTZZ/X/X9amWCWnryzSyUF41LwoSXX6aKTzv
         T8ev7fG97X3EI9I619JD+9+4BHxHEbxi6JT6nlWp1oN8u2ApkuLEn5eMKNEEVElhSl
         sYpX9BtFlGE2w==
Date:   Wed, 12 May 2021 15:22:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: Re: [PATCH 01/28] iio: gyro: fxa210002c: Balance runtime pm + use
 pm_runtime_resume_and_get().
Message-ID: <20210512152243.48c2fc74@coco.lan>
In-Reply-To: <20210509113354.660190-2-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-2-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun,  9 May 2021 12:33:27 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> In both the probe() error path and remove() pm_runtime_put_noidle()
> is called which will decrement the runtime pm reference count.
> However, there is no matching function to have raised the reference count.
> Not this isn't a fix as the runtime pm core will stop the reference count
> going negative anyway.
> 
> An alternative would have been to raise the count in these paths, but
> it is not clear why that would be necessary.
> 
> Whilst we are here replace some boilerplate with pm_runtime_resume_and_get()
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/iio/gyro/fxas21002c_core.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> index 5af7b48ff01a..539585b0d300 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -366,14 +366,7 @@ static int fxas21002c_write(struct fxas21002c_data *data,
>  
>  static int  fxas21002c_pm_get(struct fxas21002c_data *data)
>  {
> -	struct device *dev = regmap_get_device(data->regmap);
> -	int ret;
> -
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> -		pm_runtime_put_noidle(dev);
> -
> -	return ret;
> +	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
>  }
>  
>  static int  fxas21002c_pm_put(struct fxas21002c_data *data)
> @@ -1002,7 +995,6 @@ int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  pm_disable:
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
> -	pm_runtime_put_noidle(dev);
>  
>  	return ret;
>  }
> @@ -1016,7 +1008,6 @@ void fxas21002c_core_remove(struct device *dev)
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
> -	pm_runtime_put_noidle(dev);
>  }
>  EXPORT_SYMBOL_GPL(fxas21002c_core_remove);
>  



Thanks,
Mauro
