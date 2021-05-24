Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30F38E1A6
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhEXHai (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 03:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhEXHah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 03:30:37 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FFBC061574
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 00:29:08 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id m129so5726514vkh.9
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d45EDUAuLlc1KQoYIx7EjKMmc6rJ3zHVqmhU/cVWYeg=;
        b=SFr/1pyVSD+UWJDq23S5oDoTt12gENM4FLe4odbV7b4Jsj3EpNg4pBVN7ewvaja1cn
         ypRxcTXcpSzea8lFlew6b3LX4n4WXm3Zl3tkv2A+yFZwivmWy4bzchCp8nDLhMs0BZHt
         5vC6OxfIWdoGNawi/UCNG37LQ2Q0AsfnWaC/7Kz3KkF/huGAl9pjnglfo9O03NcNCfEV
         FctvjBsjj8Ii/OyK/116x934LkAAvw8ES8e48fir69K4UDCEQVjivAkt3HaHEF3BkTzo
         NSe7lQwoYidocjivc5WcdcShwUHxAFQOVB35nOXGXx+dCZVMJvW9QaxiKl8Ll+1zso0x
         m+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d45EDUAuLlc1KQoYIx7EjKMmc6rJ3zHVqmhU/cVWYeg=;
        b=h+R9caTxEpwcW/njfFu1gLLmVVsbpFn7tu8DsdYN97bM9wpIxBJz35qkuK0lSjS98V
         F4iKn0J5YCqFA7RfoVw679Oxqck1QFi5EhYezW1P2FN4J/JbCRPBGxOw/SIhDmel04Hk
         OOZEsZbUf3h6N7wxyQ9+U+OicTcPZd2gRhz32PdvuJoTQPQ0LYzZ8n8R2gW+FrTHOuSe
         rmi7INd0rx6VFs9BFjHlScHCQysmVceNHcEz7kp48nsvmapg4HDYuEpUbis8/8XVwWvb
         93/X2XFL4aoIIL4Fz1eWjl8egiP7VEmKZ0k6z34wShOoQWv7/mYCqSvlKEJrMu2T0Br2
         3qgA==
X-Gm-Message-State: AOAM53070hf5BSlcJMVxLw3Nkw+792mJtD2QokKn4G1iYKWrHY5FyE4y
        1w5ufeYz64Do1G+qyqkU6a7qLSHczXTiRum/ykqfeA==
X-Google-Smtp-Source: ABdhPJwePz2CnquT5QGg3gBJ0W2Xp6Bb6y8XBPvvDZmJQDssuPb9oW/W92cArlLJj9N+BzlsGre4eUipWFNuC/DMFEg=
X-Received: by 2002:a1f:a404:: with SMTP id n4mr764218vke.12.1621841347961;
 Mon, 24 May 2021 00:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210523162315.1965869-1-jic23@kernel.org> <20210523162315.1965869-2-jic23@kernel.org>
In-Reply-To: <20210523162315.1965869-2-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 24 May 2021 10:28:57 +0300
Message-ID: <CAASAkob6b-e5Vw1r0UYHfbQx0-PLSB19w=mvyzba=OWx0iTmOQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: accel: mma9551/mma9553: Drop explicit ACPI match support
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
> The IDs look highly suspicious as they are just the part numbers in
> capitals, so lets drop these if no one screams.
>

I think some headers (at least acpi.h) could be removed with this patch.
Other than that:

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/accel/mma9551.c | 21 ---------------------
>  drivers/iio/accel/mma9553.c | 21 ---------------------
>  2 files changed, 42 deletions(-)
>
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 4c359fb05480..2b74f67536a3 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -435,17 +435,6 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
>         return 0;
>  }
>
> -static const char *mma9551_match_acpi_device(struct device *dev)
> -{
> -       const struct acpi_device_id *id;
> -
> -       id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -       if (!id)
> -               return NULL;
> -
> -       return dev_name(dev);
> -}
> -
>  static int mma9551_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -464,8 +453,6 @@ static int mma9551_probe(struct i2c_client *client,
>
>         if (id)
>                 name = id->name;
> -       else if (ACPI_HANDLE(&client->dev))
> -               name = mma9551_match_acpi_device(&client->dev);
>
>         ret = mma9551_init(data);
>         if (ret < 0)
> @@ -591,13 +578,6 @@ static const struct dev_pm_ops mma9551_pm_ops = {
>                            mma9551_runtime_resume, NULL)
>  };
>
> -static const struct acpi_device_id mma9551_acpi_match[] = {
> -       {"MMA9551", 0},
> -       {},
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, mma9551_acpi_match);
> -
>  static const struct i2c_device_id mma9551_id[] = {
>         {"mma9551", 0},
>         {}
> @@ -608,7 +588,6 @@ MODULE_DEVICE_TABLE(i2c, mma9551_id);
>  static struct i2c_driver mma9551_driver = {
>         .driver = {
>                    .name = MMA9551_DRV_NAME,
> -                  .acpi_match_table = ACPI_PTR(mma9551_acpi_match),
>                    .pm = &mma9551_pm_ops,
>                    },
>         .probe = mma9551_probe,
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index ba3ecb3b57dc..32c9a79ebfec 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -1062,17 +1062,6 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
>         return IRQ_HANDLED;
>  }
>
> -static const char *mma9553_match_acpi_device(struct device *dev)
> -{
> -       const struct acpi_device_id *id;
> -
> -       id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -       if (!id)
> -               return NULL;
> -
> -       return dev_name(dev);
> -}
> -
>  static int mma9553_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -1091,8 +1080,6 @@ static int mma9553_probe(struct i2c_client *client,
>
>         if (id)
>                 name = id->name;
> -       else if (ACPI_HANDLE(&client->dev))
> -               name = mma9553_match_acpi_device(&client->dev);
>         else
>                 return -ENOSYS;
>
> @@ -1230,13 +1217,6 @@ static const struct dev_pm_ops mma9553_pm_ops = {
>                            mma9553_runtime_resume, NULL)
>  };
>
> -static const struct acpi_device_id mma9553_acpi_match[] = {
> -       {"MMA9553", 0},
> -       {},
> -};
> -
> -MODULE_DEVICE_TABLE(acpi, mma9553_acpi_match);
> -
>  static const struct i2c_device_id mma9553_id[] = {
>         {"mma9553", 0},
>         {},
> @@ -1247,7 +1227,6 @@ MODULE_DEVICE_TABLE(i2c, mma9553_id);
>  static struct i2c_driver mma9553_driver = {
>         .driver = {
>                    .name = MMA9553_DRV_NAME,
> -                  .acpi_match_table = ACPI_PTR(mma9553_acpi_match),
>                    .pm = &mma9553_pm_ops,
>                    },
>         .probe = mma9553_probe,
> --
> 2.31.1
>
