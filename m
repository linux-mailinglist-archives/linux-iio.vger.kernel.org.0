Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A73A38E22D
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 10:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhEXIP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbhEXIP0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 04:15:26 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FBC061574
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 01:13:58 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id j12so8772921vsq.9
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noqRgOg3VMiBTnwIHaAc+KPSOD1eUrURGc+0stbD3NE=;
        b=rIdkhcPayBubukS9o5GpUDFsVmFLjjEcXUDiVnt0chBVE1h2604oJficcTonA5X2ow
         sfTCE03yXen/qFYpojUHEW3ODYY3Jv6LL5Uz0aX3AZJMj0mR4Ab8s/Cf6B+4Q7hkItof
         r1aXfZimqmGUHTI87Cc/lcbulbdbVAa1430GHESH9goWDo3jhP3hEVrBinMOLuzPAzYs
         MX4/AUE7uUTqFbLOSRMVJ9c6EkRXV77g0iTRv1JJHbiShmtfDt6s5LzDC1oa7To2q6Mi
         oBSswFGSyFAvfNiKmn2qCMd5BkHo9zf52U43QJ+2QJgfzoDX53C+yRQpU9EGQbpRoujq
         rOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noqRgOg3VMiBTnwIHaAc+KPSOD1eUrURGc+0stbD3NE=;
        b=lD20XbP55qW03rvqfFhQCKIhJVmTveZnj+d7xlovXLIXZKvP+slhwFw2AryToGGEPB
         VUyXBz08E1IsiSqGAE0zDMBt/ICRrxpZFmVOMnnW2KUfGHgDvadcf072ErzDEuCwTgtB
         YdIYHOIwfY1WZWc4A3xbIJoRh98g/hiVvgdhMsbh3Y5VNIUt8UG8cBN32kd3163VZB4o
         XOxGhexCAOd9CWYQa8RyXeGeq6ykE5apC5il4Prw+40v1jvvX/JgwYUWVg+3jEcuKmcU
         Yqc7Hfzu79/ZjORtW0a/1IqEflv+CJxkJ7Um2I3D5Rtm8ApJYO6RBgE7S5O+pbaeXtZY
         vNQA==
X-Gm-Message-State: AOAM530577qFrOejiH6W3o4Z6JfyGZI1/9mmdNy5g7yueqGmXJbFnUks
        A5kixMVZ3bSMGN22pcvQ0OY/xxREPcCWSDE2Q0Evjg==
X-Google-Smtp-Source: ABdhPJxcJg0vOsiOnb/Qol2Iuhh84OaT88Lv4jQhKWk6DT7gXyiILuyQsttL1FYMli4t3rOR5hiQoiUUmd1RIyxm1ZU=
X-Received: by 2002:a05:6102:30ad:: with SMTP id y13mr20218627vsd.19.1621844037745;
 Mon, 24 May 2021 01:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210523162315.1965869-1-jic23@kernel.org> <20210523162315.1965869-5-jic23@kernel.org>
In-Reply-To: <20210523162315.1965869-5-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 24 May 2021 11:13:46 +0300
Message-ID: <CAASAkoYLYaSZeV_FqtVhnhRPzkYPeR02CnaMusEn9rnwb6m4ug@mail.gmail.com>
Subject: Re: [PATCH 4/5] iio: accel: mma9551: Use devm managed functions to
 tidy up probe()
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
> The error handling in here left runtime pm enabled, and didn't do the
> same steps as occurred in remove.  Moving over to fully devm_ managed
> makes it harder to get this stuff wrong, so let's do that.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/mma9551.c | 71 ++++++++++++++++++++-----------------
>  1 file changed, 38 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index a0bb4ccdbec7..f539772f8295 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -389,6 +389,15 @@ static irqreturn_t mma9551_event_handler(int irq, void *private)
>         return IRQ_HANDLED;
>  }
>
> +static void mma9551_disable_cb(void *_data)
> +{
> +       struct mma9551_data *data = _data;
> +
> +       mutex_lock(&data->mutex);
> +       mma9551_set_device_state(data->client, false);
> +       mutex_unlock(&data->mutex);
> +}
> +
>  static int mma9551_init(struct mma9551_data *data)
>  {
>         int ret;
> @@ -397,7 +406,12 @@ static int mma9551_init(struct mma9551_data *data)
>         if (ret)
>                 return ret;
>
> -       return mma9551_set_device_state(data->client, true);
> +       ret = mma9551_set_device_state(data->client, true);
> +       if (ret)
> +               return ret;
> +
> +       return devm_add_action_or_reset(&data->client->dev, mma9551_disable_cb,
> +                                       data);
>  }
>
>  static int mma9551_gpio_probe(struct iio_dev *indio_dev)
> @@ -442,6 +456,16 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
>         return 0;
>  }
>
> +static void mma9551_rpm_susp(void *d)
> +{
> +       pm_runtime_set_suspended(d);
> +}
> +
> +static void mma9551_rpm_disable(void *d)
> +{
> +       pm_runtime_disable(d);
> +}
> +
>  static int mma9551_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -475,46 +499,28 @@ static int mma9551_probe(struct i2c_client *client,
>
>         ret = mma9551_gpio_probe(indio_dev);
>         if (ret < 0)
> -               goto out_poweroff;
> +               return ret;
>
>         ret = pm_runtime_set_active(&client->dev);
>         if (ret < 0)
> -               goto out_poweroff;
> +               return ret;
> +
> +       ret = devm_add_action_or_reset(&client->dev, mma9551_rpm_susp,
> +                                      &client->dev);
> +       if (ret)
> +               return ret;
>
>         pm_runtime_enable(&client->dev);
> +       ret = devm_add_action_or_reset(&client->dev, mma9551_rpm_disable,
> +                                      &client->dev);
> +       if (ret)
> +               return ret;
> +
>         pm_runtime_set_autosuspend_delay(&client->dev,
>                                          MMA9551_AUTO_SUSPEND_DELAY_MS);
>         pm_runtime_use_autosuspend(&client->dev);
>
> -       ret = iio_device_register(indio_dev);
> -       if (ret < 0) {
> -               dev_err(&client->dev, "unable to register iio device\n");
> -               goto out_poweroff;
> -       }
> -
> -       return 0;
> -
> -out_poweroff:
> -       mma9551_set_device_state(client, false);
> -
> -       return ret;
> -}
> -
> -static int mma9551_remove(struct i2c_client *client)
> -{
> -       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -       struct mma9551_data *data = iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -
> -       pm_runtime_disable(&client->dev);
> -       pm_runtime_set_suspended(&client->dev);
> -
> -       mutex_lock(&data->mutex);
> -       mma9551_set_device_state(data->client, false);
> -       mutex_unlock(&data->mutex);
> -
> -       return 0;
> +       return devm_iio_device_register(&client->dev, indio_dev);
>  }
>
>  static __maybe_unused int mma9551_runtime_suspend(struct device *dev)
> @@ -569,7 +575,6 @@ static struct i2c_driver mma9551_driver = {
>                    .pm = &mma9551_pm_ops,
>                    },
>         .probe = mma9551_probe,
> -       .remove = mma9551_remove,
>         .id_table = mma9551_id,
>  };
>
> --
> 2.31.1
>
