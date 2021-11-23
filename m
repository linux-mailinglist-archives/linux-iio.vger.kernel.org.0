Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88E845AEF4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 23:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhKWW0J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 17:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhKWW0I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 17:26:08 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D16C061574
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:23:00 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e8so558930ilu.9
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1Mp6dv6v/0ePA61SR7pnEfDvJAXFkLrGTxSBn1PQD4=;
        b=DAz4AvkHVzAL1+70ZTNj0m+9/janA5zEWO5ijvqALdVKFgBao0ue6d5OvHKa40/aR+
         D6v5igqyMZNFvaaMK24eSLb5u4P5FdJvuCXHJRA0QRy/sJHVIiMEANEYMyY/YV++iZKu
         1QaBjFU5J8kXjKBiGhdR7T1zGAmZME/stP/Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1Mp6dv6v/0ePA61SR7pnEfDvJAXFkLrGTxSBn1PQD4=;
        b=0DvAQ+UTAnZLvcgY9IKenxPV2syfPGRFTo4536kZVxkvESYrUo+ytzQkJXDxxPWH/G
         rPanbGG49781Er8B9Db0cu7AcDRQWs4Xrz3hm7elY3wT0GM4O+r2OQ0YXjYoIVY/I22D
         TCrq6cf3wY+Sv8WqUUxb8uOmgUPrkYZWs2rV0r0sCHErjDMj6rLR+GZniEp2voavxE5V
         T0ZLJnYNN2M3/A2X3toCCom7o09kfzB2YfzlTkCN8+vqW7oOPHk1oM9kvsPHLOOeqTEf
         LAOUSzot/iwonRqKANJVjXIDeDz+Nf6cudVOIYUhPStACwCa2rWuvFZmx0EVniy1pH9l
         XjQw==
X-Gm-Message-State: AOAM531HgcLzI2RW4R8UkRCMvjvca5pUHzl0C+wKsclTkSoStUh0SEnp
        vJjPd0xj/Buaa5vZK+jdp7TB3tczV6SHUQNBGnNc8A==
X-Google-Smtp-Source: ABdhPJzEf19CGZq8ZRdHXQX7bczrdaw1JQBz8U9KKdicrFmemsuPFDhyMofTicJxzgvNvOx3YFsGSts/HTbiec7jp/k=
X-Received: by 2002:a05:6e02:1582:: with SMTP id m2mr8909596ilu.212.1637706179734;
 Tue, 23 Nov 2021 14:22:59 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-44-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-44-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 23 Nov 2021 14:22:46 -0800
Message-ID: <CAJCx=gkO4a4dF7ZAEnJhLAzveDO2kKofe+uuAHb8X8ULxgC9RQ@mail.gmail.com>
Subject: Re: [PATCH 43/49] iio:proximity:pulsedlight: Switch from CONFIG_PM
 guards to pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 23, 2021 at 1:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM support is simpler and less error prone than the
> use of #ifdef based config guards.
>
> Removing instances of this approach from IIO also stops them being
> copied into new drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 27026c060ab9..6adc2a0c27cb 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -338,8 +338,7 @@ static const struct of_device_id lidar_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, lidar_dt_ids);
>
> -#ifdef CONFIG_PM
> -static int lidar_pm_runtime_suspend(struct device *dev)
> +static __maybe_unused int lidar_pm_runtime_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct lidar_data *data = iio_priv(indio_dev);
> @@ -347,7 +346,7 @@ static int lidar_pm_runtime_suspend(struct device *dev)
>         return lidar_write_power(data, 0x0f);
>  }
>
> -static int lidar_pm_runtime_resume(struct device *dev)
> +static __maybe_unused int lidar_pm_runtime_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct lidar_data *data = iio_priv(indio_dev);
> @@ -358,9 +357,8 @@ static int lidar_pm_runtime_resume(struct device *dev)
>
>         return ret;
>  }
> -#endif
>
> -static const struct dev_pm_ops lidar_pm_ops = {
> +static __maybe_unused const struct dev_pm_ops lidar_pm_ops = {
>         SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
>                            lidar_pm_runtime_resume, NULL)
>  };
> @@ -369,7 +367,7 @@ static struct i2c_driver lidar_driver = {
>         .driver = {
>                 .name   = LIDAR_DRV_NAME,
>                 .of_match_table = lidar_dt_ids,
> -               .pm     = &lidar_pm_ops,
> +               .pm     = pm_ptr(&lidar_pm_ops),
>         },
>         .probe          = lidar_probe,
>         .remove         = lidar_remove,
> --
> 2.34.0
>
