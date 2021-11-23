Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6335045AEEC
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 23:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKWWVL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 23 Nov 2021 17:21:11 -0500
Received: from aposti.net ([89.234.176.197]:35546 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhKWWVK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 17:21:10 -0500
Date:   Tue, 23 Nov 2021 22:17:52 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/49] iio:accel:da280: Switch from CONFIG_PM_SLEEP guards
 to pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <SXP13R.7A93XDVR9X8I@crapouillou.net>
In-Reply-To: <20211123211019.2271440-3-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Le mar., nov. 23 2021 at 21:09:32 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than 
> the
> use of #ifdef based config guards.
> 
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
> 
> The pm_ptr() macro only removes the reference if CONFIG_PM is not
> set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
> will not always remove the pm_ops structure.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No pm_ptr() for this one?

-Paul

> ---
>  drivers/iio/accel/da280.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> index 9633bdae5fd4..91ac478891ce 100644
> --- a/drivers/iio/accel/da280.c
> +++ b/drivers/iio/accel/da280.c
> @@ -153,17 +153,15 @@ static int da280_probe(struct i2c_client 
> *client,
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
> 
> -#ifdef CONFIG_PM_SLEEP
> -static int da280_suspend(struct device *dev)
> +static __maybe_unused int da280_suspend(struct device *dev)
>  {
>  	return da280_enable(to_i2c_client(dev), false);
>  }
> 
> -static int da280_resume(struct device *dev)
> +static __maybe_unused int da280_resume(struct device *dev)
>  {
>  	return da280_enable(to_i2c_client(dev), true);
>  }
> -#endif
> 
>  static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
> 
> --
> 2.34.0
> 


