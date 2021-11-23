Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1B45AEFB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 23:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKWW1d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 17:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhKWW1d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 17:27:33 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD4C061574
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:24:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id x10so602388ioj.9
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5+Y3IbHYe0fSvLkpI7wcU4xHgZCyoI7gQEr2uSHGR0=;
        b=riKdbKXVuNBmkOVWFQTf2ZMywoOxzcyFpQYl78Z52CWL85gSeDKNohN+xQmaOJ9Olz
         sWjk4BeUaAtxHIt0Ai3FrXnlcG7M/au14rJQDlq2LILE1scKxifpKfPCgS+uPOoxwzik
         QcEZniGbRVhkEum9u7nBZy2vwG8Ys5df8BOt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5+Y3IbHYe0fSvLkpI7wcU4xHgZCyoI7gQEr2uSHGR0=;
        b=VpKz/ULDdddIJlHxDV3MIBUeiX9O/9a0vYz953lpZNnC+LsXmakANEzIUgXnowQjNl
         xIdD8Ea1PtABzscH2uxGZ5E1npgWy4f2d+ZVe8R9cc2RxDyJO3sKZ9pCGy1cn8e/P6I8
         6+uVya+TxBiDJpPT4wECBPlHbNpOWUwqIWZ4jU4feIjYrmCb/5aZ0w2QKNe3gdpRHgLx
         fOPq13YxZjuh721HU5dwMVBsMRPXvW80sGuuRdDRWje19TxjkQ7g5vMb4uNS4Y6JWwNl
         qWoOwrCtGnF+IQr3EZ32eeb2T7r14Gfxpi7Ou+WpHvodosM1jFVmLQo+O/d/XZeVeqR0
         bZig==
X-Gm-Message-State: AOAM530Sxy+EppwnkkylPIxQyCAyVmKz9+dTQVJDe8gS0lxeaqwb1kYU
        uab+9gFHFyo35e3dIl457FYByUCSA8tDS4kkBSiMtA==
X-Google-Smtp-Source: ABdhPJz5RA9bYFCFtgeanwhmlBJ8L8VovGGiFHz1JKG/K9R3+iJMI6I5171dcwrZkfk8gyC1gVuiTc3LzJzlinO3Gn0=
X-Received: by 2002:a5d:9d92:: with SMTP id ay18mr9812950iob.130.1637706264649;
 Tue, 23 Nov 2021 14:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-37-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-37-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 23 Nov 2021 14:24:11 -0800
Message-ID: <CAJCx=gntgfpHD1Y4PjdGkZb0N4ne+s61p2Gu9SkVU31vNhvYRA@mail.gmail.com>
Subject: Re: [PATCH 36/49] iio:magn:ak8975: Switch from CONFIG_PM guards to
 pm_ptr() / __maybe_unused
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
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


> Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/iio/magnetometer/ak8975.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 6e82dc54a417..ced3e674eb5f 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -1033,8 +1033,7 @@ static int ak8975_remove(struct i2c_client *client)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int ak8975_runtime_suspend(struct device *dev)
> +static __maybe_unused int ak8975_runtime_suspend(struct device *dev)
>  {
>         struct i2c_client *client = to_i2c_client(dev);
>         struct iio_dev *indio_dev = i2c_get_clientdata(client);
> @@ -1053,7 +1052,7 @@ static int ak8975_runtime_suspend(struct device *dev)
>         return 0;
>  }
>
> -static int ak8975_runtime_resume(struct device *dev)
> +static __maybe_unused int ak8975_runtime_resume(struct device *dev)
>  {
>         struct i2c_client *client = to_i2c_client(dev);
>         struct iio_dev *indio_dev = i2c_get_clientdata(client);
> @@ -1074,9 +1073,8 @@ static int ak8975_runtime_resume(struct device *dev)
>
>         return 0;
>  }
> -#endif /* CONFIG_PM */
>
> -static const struct dev_pm_ops ak8975_dev_pm_ops = {
> +static __maybe_unused const struct dev_pm_ops ak8975_dev_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>                                 pm_runtime_force_resume)
>         SET_RUNTIME_PM_OPS(ak8975_runtime_suspend,
> @@ -1113,7 +1111,7 @@ MODULE_DEVICE_TABLE(of, ak8975_of_match);
>  static struct i2c_driver ak8975_driver = {
>         .driver = {
>                 .name   = "ak8975",
> -               .pm = &ak8975_dev_pm_ops,
> +               .pm = pm_ptr(&ak8975_dev_pm_ops),
>                 .of_match_table = ak8975_of_match,
>                 .acpi_match_table = ak_acpi_match,
>         },
> --
> 2.34.0
>
