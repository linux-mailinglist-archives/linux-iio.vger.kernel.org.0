Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27245AEF3
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 23:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhKWWZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 17:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhKWWZu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 17:25:50 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFB9C061574
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:22:41 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id w15so589958ill.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pr5vj7yKu2Q0dXCqF65/NdS3tPAZ98TnPeO7LM4s2wU=;
        b=loY5A3m2CRa3niAeseY93H3urzpBa1N2grBGJOGHHmQDTd9HlBweYZ5VvGPppQquuZ
         D0YYochF4geJ98Ph0YEvzpteArNwD70atl2BlMf+Xezc3jL7PI4uur3D5fjtM7WSxUPv
         T2s7m92GaF/28UsI5xnnztd8o/1Wf8JSdNPvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pr5vj7yKu2Q0dXCqF65/NdS3tPAZ98TnPeO7LM4s2wU=;
        b=TbklMubORsuqDrrH3bSGNJ16UJ1BM4Ql15xzo5Y7GrJNSKNRc+y2gLuUGMC1g7aEVj
         XhlIu4/Ym+USwni3KytkuN9rQm+h0FswQ4rYquNs/N2BvTfB8LB+HTaNi9+KdQsIHXNc
         iu7+Ux3fzmqjOSb6IWmNwQDUDSP0lQ/l4LfwGON/n2guPD+z8qlU5xFSZN2Ipc7vTrUM
         z5o8yEI7cpnWXfN3YEWq8p7xTHVs/jhg99SEbTfgO/rfur1AbrcWHvHQ2td/dAC/eRGk
         IXkKfXbl5oUBGYenVXj8Ml/xe87kzq+J6JdDs59rS5AF5FHBkcdIo1EibXTQUk0VAATe
         nAYg==
X-Gm-Message-State: AOAM533ON3LXjGXabX0nHM3UXqyBcuCmUQrvKUPj3Z2QYNt5HnEkaWJu
        ZmVJHONysEI8CDe6BQI+nzjTNvBpvYs7axkJuXiE8I/Ohds=
X-Google-Smtp-Source: ABdhPJz/gFRQicrcKjtVw4WJHqLiz3MHZdg63BUZfsIdViy+JxXihwauFnxjAUOSF82s7vojBR5GlbIwm7rz8o8Zgys=
X-Received: by 2002:a92:511:: with SMTP id q17mr1145506ile.322.1637706161186;
 Tue, 23 Nov 2021 14:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-50-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-50-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 23 Nov 2021 14:22:28 -0800
Message-ID: <CAJCx=gmdMFguGUeGheiObeB66Kdk4HEgsGbWXRDeFdQM=wrtYA@mail.gmail.com>
Subject: Re: [PATCH 49/49] iio:chemical:atlas: Switch from CONFIG_PM guards to
 pm_ptr() / __maybe_unused
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

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>


> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/chemical/atlas-sensor.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 04b44a327614..7bacd0bd6f19 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -737,8 +737,7 @@ static int atlas_remove(struct i2c_client *client)
>         return atlas_set_powermode(data, 0);
>  }
>
> -#ifdef CONFIG_PM
> -static int atlas_runtime_suspend(struct device *dev)
> +static __maybe_unused int atlas_runtime_suspend(struct device *dev)
>  {
>         struct atlas_data *data =
>                      iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> @@ -746,16 +745,15 @@ static int atlas_runtime_suspend(struct device *dev)
>         return atlas_set_powermode(data, 0);
>  }
>
> -static int atlas_runtime_resume(struct device *dev)
> +static __maybe_unused int atlas_runtime_resume(struct device *dev)
>  {
>         struct atlas_data *data =
>                      iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>
>         return atlas_set_powermode(data, 1);
>  }
> -#endif
>
> -static const struct dev_pm_ops atlas_pm_ops = {
> +static __maybe_unused const struct dev_pm_ops atlas_pm_ops = {
>         SET_RUNTIME_PM_OPS(atlas_runtime_suspend,
>                            atlas_runtime_resume, NULL)
>  };
> @@ -764,7 +762,7 @@ static struct i2c_driver atlas_driver = {
>         .driver = {
>                 .name   = ATLAS_DRV_NAME,
>                 .of_match_table = atlas_dt_ids,
> -               .pm     = &atlas_pm_ops,
> +               .pm     = pm_ptr(&atlas_pm_ops),
>         },
>         .probe          = atlas_probe,
>         .remove         = atlas_remove,
> --
> 2.34.0
>
