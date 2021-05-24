Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85E438E1CC
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 09:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhEXHfj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhEXHfi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 03:35:38 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969C8C061574
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 00:34:10 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u188so13765639vsu.8
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHQySSVz1N01q/QG+Sg4zKGo0ul+dp/KxARlVUPPnpw=;
        b=kNm9z/MG6Kd2/pg2gpFXzynXhdkovrQhm5bo/Y0EXB29XUsXbyv/wmgEmc38A28llh
         v606/wXg+g94139XuC/QuUfBjywhit3mAAcU4iUMRlT9xpe9v0EO+qjFBg2X1drA7KJc
         5+NF2IAMkeoCQYqz1IPxUGvy0sjyGpG3+DY7E30a5XV+4pTLbJFjI/CTBSpA4Em20BMo
         5O0r9ZN0zi4yDW5DlN68ab1hTa6e+hu2fGx/9KrnCS8X0jFaLRw7quZlNZiy6I4Lm93+
         Vdw+nZyLrz73/yrdeEIC6CH5xHpeRhFwrnS5Bvzpe8ad4a5K8PPhkaErkhn2pPawAy24
         4Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHQySSVz1N01q/QG+Sg4zKGo0ul+dp/KxARlVUPPnpw=;
        b=QsXdl4TqwXsPMHXElx4r9ThTS6czpdaZP+9WT6H8r8SQxp4r+d49oXwW3HwdpbPghz
         upUnynRMwnf9Ywy9YMaWPugChl6yHJblE/suT6I/EQf4WN8ULA7DDRgt9Tc5u/9q+BYU
         hT/lknUvNK5ZRxy7T+IHoOpk/2XcdyRbwn7QVj8MwbOah/XaGFNqykS4rtKFtUyF1Tci
         yPmFvGI2XGidmRifkh/7yl89NbJky7PgNLyk6hLNnE7aVBTFJ+jtbmwa+ADTxVcZ0IXv
         Yh1xxccU5WtWkuSTQAlNyNUguJ/KZ753nYN3uslFLPH17Un1Szqpaym56y+/uZnh+qmg
         yJDA==
X-Gm-Message-State: AOAM530ePWywWgAuje9un+nVJefInnOCYPQ1ack5kpBNGq0vgNtCyJiI
        9S2e3rHLnnZ4KYZvQ0ZqxAwHbad8h2DBkr+F1MFPAEG3eaQgpAGuY3w=
X-Google-Smtp-Source: ABdhPJwgCaeKgq3aoHyjnwdoJi+Ju8M11LkpfT6ijuU49O4pxbwxCTVq5DoH3bvduCYrW0UmgpVCRVFrHNON2ms+GpU=
X-Received: by 2002:a67:7d85:: with SMTP id y127mr19297178vsc.43.1621841649707;
 Mon, 24 May 2021 00:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210523162315.1965869-1-jic23@kernel.org> <20210523162315.1965869-3-jic23@kernel.org>
In-Reply-To: <20210523162315.1965869-3-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 24 May 2021 10:33:58 +0300
Message-ID: <CAASAkoY+eRTAA8AO4hA1B2W+t+rs_zv7yoT2O3zJERVG6mb+Dg@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: accel: mma9551/mma9553: Simplify pm logic
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 23 May 2021 at 19:24, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> I can't see why we shouldn't sleep in the system resume path to allow
> the device firmware to fully wakeup.  Having done that, the runtime
> system functions are identical (down to an error print) so use
> pm_runtime_force_suspend() and pm_runtime_force_resume() to reduce
> repitition.
>
> General preference in IIO is now to mark these functions __maybe_unused
> instead of using ifdefs as it is easy to get them wrong.
> Here they appear correct, but provide a less than desirable example
> to copy into other drivers.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/mma9551.c | 37 ++++--------------------------------
>  drivers/iio/accel/mma9553.c | 38 ++++---------------------------------
>  2 files changed, 8 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 2b74f67536a3..1b4a8b27f14a 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -510,8 +510,7 @@ static int mma9551_remove(struct i2c_client *client)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int mma9551_runtime_suspend(struct device *dev)
> +static __maybe_unused int mma9551_runtime_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct mma9551_data *data = iio_priv(indio_dev);
> @@ -522,13 +521,13 @@ static int mma9551_runtime_suspend(struct device *dev)
>         mutex_unlock(&data->mutex);
>         if (ret < 0) {
>                 dev_err(&data->client->dev, "powering off device failed\n");
> -               return -EAGAIN;
> +               return ret;
>         }
>
>         return 0;
>  }
>
> -static int mma9551_runtime_resume(struct device *dev)
> +static __maybe_unused int mma9551_runtime_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct mma9551_data *data = iio_priv(indio_dev);
> @@ -542,38 +541,10 @@ static int mma9551_runtime_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int mma9551_suspend(struct device *dev)
> -{
> -       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -       struct mma9551_data *data = iio_priv(indio_dev);
> -       int ret;
> -
> -       mutex_lock(&data->mutex);
> -       ret = mma9551_set_device_state(data->client, false);
> -       mutex_unlock(&data->mutex);
> -
> -       return ret;
> -}
> -
> -static int mma9551_resume(struct device *dev)
> -{
> -       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -       struct mma9551_data *data = iio_priv(indio_dev);
> -       int ret;
>
> -       mutex_lock(&data->mutex);
> -       ret = mma9551_set_device_state(data->client, true);
> -       mutex_unlock(&data->mutex);
> -
> -       return ret;
> -}
> -#endif
>
>  static const struct dev_pm_ops mma9551_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(mma9551_suspend, mma9551_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(mma9551_runtime_suspend,
>                            mma9551_runtime_resume, NULL)
>  };
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 32c9a79ebfec..dc2a3316c1a3 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1149,8 +1149,7 @@ static int mma9553_remove(struct i2c_client *client)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int mma9553_runtime_suspend(struct device *dev)
> +static __maybe_unused int mma9553_runtime_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct mma9553_data *data = iio_priv(indio_dev);
> @@ -1161,13 +1160,13 @@ static int mma9553_runtime_suspend(struct device *dev)
>         mutex_unlock(&data->mutex);
>         if (ret < 0) {
>                 dev_err(&data->client->dev, "powering off device failed\n");
> -               return -EAGAIN;
> +               return ret;
>         }
>
>         return 0;
>  }
>
> -static int mma9553_runtime_resume(struct device *dev)
> +static __maybe_unused int mma9553_runtime_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>         struct mma9553_data *data = iio_priv(indio_dev);
> @@ -1181,38 +1180,9 @@ static int mma9553_runtime_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif
> -
> -#ifdef CONFIG_PM_SLEEP
> -static int mma9553_suspend(struct device *dev)
> -{
> -       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -       struct mma9553_data *data = iio_priv(indio_dev);
> -       int ret;
> -
> -       mutex_lock(&data->mutex);
> -       ret = mma9551_set_device_state(data->client, false);
> -       mutex_unlock(&data->mutex);
> -
> -       return ret;
> -}
> -
> -static int mma9553_resume(struct device *dev)
> -{
> -       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -       struct mma9553_data *data = iio_priv(indio_dev);
> -       int ret;
> -
> -       mutex_lock(&data->mutex);
> -       ret = mma9551_set_device_state(data->client, true);
> -       mutex_unlock(&data->mutex);
> -
> -       return ret;
> -}
> -#endif
>
>  static const struct dev_pm_ops mma9553_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(mma9553_suspend, mma9553_resume)
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(mma9553_runtime_suspend,
>                            mma9553_runtime_resume, NULL)
>  };
> --
> 2.31.1
>
