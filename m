Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7C738E22E
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 10:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEXIRg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhEXIRf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 04:17:35 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1262C061574
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 01:16:06 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 184so5244481vkz.13
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIjPuhRyF3kAfLBZs/zrW8pmW3eFpSUB+0McvzX/go8=;
        b=Y/XLCvT9xumexkGqm58bkDXqYBUmGkudHO+YrmGAVMgM85NDFWSlaY2YnXmUfXkavQ
         X/AsDb9Pv/3pc44RhDSrDMmMgsGYqUpsvulFDDF+q8O9sB1x+6hnKKLQ28SVz5OrnFnZ
         J198h+bCfJW1Y3bgegefiikfVWSe4LzxFd1QmgySsNllI26loTdUIm2phzY/b8rSoUPh
         lWshDL8stZCuaICKacd5eFlXNvqoJZzrxuTyM1VG9vaE7ySaV29RA/JmKKwqQmUGSGlX
         /pzKUy6cYkgdldvJRcwUUX3bqws0XfF5HRGkufc5qBFtuaA2VtINyAjhTae5/nlA0oXH
         UTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIjPuhRyF3kAfLBZs/zrW8pmW3eFpSUB+0McvzX/go8=;
        b=HrPMHrshKUzUK4zEnFngA3u6ZbkkJeDGlKe4Dt3i5pbnrEV7MH53HKeFZiLsmvdoZa
         GXM9QeyYNgGVDTCLkwAvgwxMoRScXiXDn81pFaqrX9Mg8jLo+q7197hvHLLmjjRsDGNj
         don36reZeL1vPWqJSlagxosaoX/I2XcEvdrM6PR4AMbwYx3NCcLfE1fAyyA2SlwnaNjO
         h0/JwNnGiAp7gl2USlAdzxDtE0SZ/e/uP+su8hpOsEG2ZnAbknMTE12aETHCoZSx6B71
         6yWQow5Z31yZO6qCxipfc1iFXu0RI15nLbMd8aMBUBRqeHNtzGzuA8lIxYijo9v0Ru0m
         NjVQ==
X-Gm-Message-State: AOAM532BGn7qlxSWjuKShqQw0U57wtf6oaZUnK7D5s4yVO2uv1xIwD1V
        eFmyJq8Ef9BYeHL+ZZL17gxofwZWLo4fpnP4cQbT7Q==
X-Google-Smtp-Source: ABdhPJwA3WV847/Z0qw5Yn9150D47jgDMu2jJbU8vi5K5X6OdydPovPBjiNtirrMEjqTa/PdGY/Ox8N9Spao9U2x2z8=
X-Received: by 2002:a1f:a404:: with SMTP id n4mr893316vke.12.1621844165773;
 Mon, 24 May 2021 01:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210523162315.1965869-1-jic23@kernel.org> <20210523162315.1965869-6-jic23@kernel.org>
In-Reply-To: <20210523162315.1965869-6-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 24 May 2021 11:15:55 +0300
Message-ID: <CAASAkoa6PNgpdStULwHBY_pqSScrCyRUm_6Sp4jEXRKMHw3OtQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: accel: mma9553: Use devm managed functions to
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
>  drivers/iio/accel/mma9553.c | 70 ++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index dc2a3316c1a3..14a9d5fedc06 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -375,6 +375,15 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
>         return 0;
>  }
>
> +static void mma9553_disable_cb(void *_data)
> +{
> +       struct mma9553_data *data = _data;
> +
> +       mutex_lock(&data->mutex);
> +       mma9551_set_device_state(data->client, false);
> +       mutex_unlock(&data->mutex);
> +}
> +
>  static int mma9553_init(struct mma9553_data *data)
>  {
>         int ret;
> @@ -430,7 +439,11 @@ static int mma9553_init(struct mma9553_data *data)
>                 return ret;
>         }
>
> -       return mma9551_set_device_state(data->client, true);
> +       ret = mma9551_set_device_state(data->client, true);
> +       if (ret)
> +               return ret;
> +
> +       return devm_add_action_or_reset(&data->client->dev, mma9553_disable_cb, data);
>  }
>
>  static int mma9553_read_status_word(struct mma9553_data *data, u16 reg,
> @@ -1062,6 +1075,16 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
>         return IRQ_HANDLED;
>  }
>
> +static void mma9553_rpm_set_susp(void *d)
> +{
> +       pm_runtime_set_suspended(d);
> +}
> +
> +static void mma9553_rpm_disable(void *d)
> +{
> +       pm_runtime_disable(d);
> +}
> +
>  static int mma9553_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -1105,48 +1128,30 @@ static int mma9553_probe(struct i2c_client *client,
>                 if (ret < 0) {
>                         dev_err(&client->dev, "request irq %d failed\n",
>                                 client->irq);
> -                       goto out_poweroff;
> +                       return ret;
>                 }
>         }
>
>         ret = pm_runtime_set_active(&client->dev);
>         if (ret < 0)
> -               goto out_poweroff;
> +               return ret;
> +
> +       ret = devm_add_action_or_reset(&client->dev, mma9553_rpm_set_susp,
> +                                      &client->dev);
> +       if (ret)
> +               return ret;
>
>         pm_runtime_enable(&client->dev);
> +       ret = devm_add_action_or_reset(&client->dev, mma9553_rpm_disable,
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
> -       dev_dbg(&indio_dev->dev, "Registered device %s\n", name);
> -       return 0;
> -
> -out_poweroff:
> -       mma9551_set_device_state(client, false);
> -       return ret;
> -}
> -
> -static int mma9553_remove(struct i2c_client *client)
> -{
> -       struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -       struct mma9553_data *data = iio_priv(indio_dev);
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
>  static __maybe_unused int mma9553_runtime_suspend(struct device *dev)
> @@ -1200,7 +1205,6 @@ static struct i2c_driver mma9553_driver = {
>                    .pm = &mma9553_pm_ops,
>                    },
>         .probe = mma9553_probe,
> -       .remove = mma9553_remove,
>         .id_table = mma9553_id,
>  };
>
> --
> 2.31.1
>
