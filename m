Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF526ACA9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgIOS4Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgIOSzc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 14:55:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE86C06178A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:55:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d190so5318165iof.3
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWE6rhk69rnm75yfE47DhWUUL0uP6CBfMR4/BLNsfyU=;
        b=rKcORz6RPsxsXJ9ha7oh3bDqmxDY8XJVzCSQ4sHrquj2OWNWSI22pwMw8Vh+f3Pzbt
         Ro8wAAjXu0nV1pUV7TYctoSYl7hUUNzUYOoYXgMFBcjhUT5qh1bS6U2X/EHDWsI91Wum
         lCF7o+tJFptJVaTULK0wogbo3vwkvl9OIC598=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWE6rhk69rnm75yfE47DhWUUL0uP6CBfMR4/BLNsfyU=;
        b=ZnKy2/MAR1tpI3EmnuhhOLNytCmR8rP5+vjTy9EHZDotGlt5Onfg5otgmPzkRGqNAp
         NPUlIo0uJYxgyfevfTUd47tNOv/KJOyi0Ag11IRnRw04rorOur5/Tq9VxQhsnZn8GWBz
         AEluOr5JHzX5/fSImYO05N+qIrbQ2Out+tsf12k56HkYidRYfJv0qT3E5eMdRIQ/iAmQ
         WjD68mttopdP0GW5n2rxKogt8Qy/AEE3vysxPxZzMpJ1Ta0rGmyOQhwgjbjGbfV73Xc3
         PEOgLMHCewhe3ztO44BXFvVQZbuYNY34IG0254nL3VKz82k2ynf5e5BY1BKAoPW0pNyI
         L/jw==
X-Gm-Message-State: AOAM532pKx7vUoh1N2NMtwtl1ruNMdO0OjAq1FrRbyr67+pCS90Wjs+U
        TwSnLYLaLXBLYBPLIOuPL1ym/kF53PhFqHR7DgUc4Q==
X-Google-Smtp-Source: ABdhPJwSrTixZ9MrBaSKQ+9LBeNK+jvDHQQt5PjbOHb6lBoAzr77KaTzjNd2SB70LxcmlRp7mrgzFJBI53qyx13E5mI=
X-Received: by 2002:a02:c914:: with SMTP id t20mr19079724jao.117.1600196130639;
 Tue, 15 Sep 2020 11:55:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-33-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-33-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:55:19 -0700
Message-ID: <CAJCx=gkCpE7hxf3Dja-59a2fYarMMvH4+t4N9k=s8Q4_PopkLw@mail.gmail.com>
Subject: Re: [PATCH 32/38] iio:proximity:as3935: Drop of_match_ptr and use
 generic fw accessors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 10:35 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This change allows the driver to be used with ACPI PRP0001 and removes
> an antipattern that I want to avoid being copied into new IIO drivers.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/proximity/as3935.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index 4df8d53d65fb..b79ada839e01 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -356,7 +357,6 @@ static int as3935_probe(struct spi_device *spi)
>         struct iio_dev *indio_dev;
>         struct iio_trigger *trig;
>         struct as3935_state *st;
> -       struct device_node *np = dev->of_node;
>         int ret;
>
>         /* Be sure lightning event interrupt is specified */
> @@ -375,7 +375,7 @@ static int as3935_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>         mutex_init(&st->lock);
>
> -       ret = of_property_read_u32(np,
> +       ret = device_property_read_u32(dev,
>                         "ams,tuning-capacitor-pf", &st->tune_cap);
>         if (ret) {
>                 st->tune_cap = 0;
> @@ -389,7 +389,7 @@ static int as3935_probe(struct spi_device *spi)
>                 return -EINVAL;
>         }
>
> -       ret = of_property_read_u32(np,
> +       ret = device_property_read_u32(dev,
>                         "ams,nflwdth", &st->nflwdth_reg);
>         if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
>                 dev_err(dev, "invalid nflwdth setting of %d\n",
> @@ -471,7 +471,7 @@ MODULE_DEVICE_TABLE(spi, as3935_id);
>  static struct spi_driver as3935_driver = {
>         .driver = {
>                 .name   = "as3935",
> -               .of_match_table = of_match_ptr(as3935_of_match),
> +               .of_match_table = as3935_of_match,
>                 .pm     = AS3935_PM_OPS,
>         },
>         .probe          = as3935_probe,
> --
> 2.28.0
>
