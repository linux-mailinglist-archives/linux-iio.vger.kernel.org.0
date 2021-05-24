Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2043238E22F
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEXIS1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhEXIS1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 04:18:27 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97723C061574
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 01:16:58 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x9so9071443uao.3
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8QMajxDiOxfs9o4d9bwLOk0rMAh1fDmI4EQ9nhU62Q=;
        b=e1Evp9sZcWDfZhBwNJbqddH7kKc9NGq0ynltNevYJNriMvAuIheB3DoLVprBFFO4xu
         p/payRKt+bgBce3JEsTjTneQvVgJnlt4N+JN+B2/s2UbniireYf3qTNCGy7+AE/Nn31i
         0hiFVbJlxYECl79fRMjuD0792NDKeflf521aR74UmTAOiZSMQZMhTdU+a1K3S9gZoIFL
         49bEmcLRpiwerqyPUfUsyh+3Yb4KBoaX2X4hUHpAgTlq7UaF5faGR+QwW8siQRlGi4uf
         zZZ9g/F7m2anNOk90/dE9mg8BwNYLAMS4nDjvlm2DTjSR8yGWGzODsb4wPUPfEVVW5j2
         qNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8QMajxDiOxfs9o4d9bwLOk0rMAh1fDmI4EQ9nhU62Q=;
        b=nqJ1eefcT7iQzyWmEcT2Q/IshtirjdDH2KV4pGwEYtrGZVOCxrIBG17OJBX9RMJEN2
         3UuFBiy3OKrCsC6E0X2kwo7JPW9hqKRZYUEqll7dbGWtSqRIEBSdSmUj2PD3pjqsJXHT
         pSkqi/wU5lk/mn8w9MiKXeR0alIdZwUVccJ/j4WeiXVa9f6jB1t+xqdKXBYn5GwvPjBv
         MzxZnRB/7DjKsM0zeWn1L7vMKcMWVilNj6QC8WVGggO51Y/qzRnqME2N1OQCElzNr5+M
         qmvZ0pkYyEAysUs01W3LS4toHI6gV3/OFCHDhB8CgRfu/5oUN1o96MumKyNbedu4ua7f
         9Dkg==
X-Gm-Message-State: AOAM533duSv5bBmzHgVl0k+z4KN7RnhNRLfYZOGjMIXZ62/xv3uJbcI+
        SQ4Dnfftr44FOrEJ4RLy2dTHdH5keX+fXmh2NcH5BA==
X-Google-Smtp-Source: ABdhPJxyL8RWryX38tv2jwJLPxgUuIZyrw3xJ//GWyD79xCSAIQjG1dBL+j9XKn+ekz1uRMFQsOw1tCsA0aizM4Ligk=
X-Received: by 2002:ab0:40e:: with SMTP id 14mr20722192uav.42.1621844217811;
 Mon, 24 May 2021 01:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210523162315.1965869-1-jic23@kernel.org> <20210523162315.1965869-4-jic23@kernel.org>
In-Reply-To: <20210523162315.1965869-4-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 24 May 2021 11:16:47 +0300
Message-ID: <CAASAkoY+gz0B9ig4napKdXmtTr74DXs_ONXnBmh9sghk1a6gxg@mail.gmail.com>
Subject: Re: [PATCH 3/5] iio: accel: mma9551: Add support to get irqs directly
 from fwnode
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
> The driver previous supported using GPIO requests to retrieve
> multiple interrupt lines.  As existing firmware may be using
> this method, we need to continue to support it.  However, that doesn't
> stop us also supporting just getting irqs directly.
>
> The handling of irqflags has to take into account the fact that using
> a GPIO method to identify the interrupt does not convey direction of
> the trigger that fwnode_irq_get() will. So we need to set the
> IRQF_TRIGGER_RISING in that path but not otherwise, where it will
> cause an issue if we reprobe the driver after removal.
>

I'm not too experienced here [with this GPIO/IRQ API] to be able to
review this confidently.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/mma9551.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> index 1b4a8b27f14a..a0bb4ccdbec7 100644
> --- a/drivers/iio/accel/mma9551.c
> +++ b/drivers/iio/accel/mma9551.c
> @@ -406,30 +406,37 @@ static int mma9551_gpio_probe(struct iio_dev *indio_dev)
>         int i, ret;
>         struct mma9551_data *data = iio_priv(indio_dev);
>         struct device *dev = &data->client->dev;
> +       unsigned long irqflags = IRQF_ONESHOT;
>
>         for (i = 0; i < MMA9551_GPIO_COUNT; i++) {
> -               gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
> -               if (IS_ERR(gpio)) {
> -                       dev_err(dev, "acpi gpio get index failed\n");
> -                       return PTR_ERR(gpio);
> -               }
> -
> -               ret = gpiod_to_irq(gpio);
> -               if (ret < 0)
> +               /* GPIO provided for backwards compatibility reasons */
> +               ret = fwnode_irq_get(dev_fwnode(dev), i);
> +               if (ret == -EPROBE_DEFER)
>                         return ret;
>
> +               /* fwnode_irq_get() returns 0 for not present on OF, and -EINVAL for ACPI */
> +               if (ret == 0 || ret == -EINVAL) {
> +                       gpio = devm_gpiod_get_index(dev, NULL, i, GPIOD_IN);
> +                       if (IS_ERR(gpio)) {
> +                               dev_err(dev, "gpio get index failed\n");
> +                               return PTR_ERR(gpio);
> +                       }
> +
> +                       ret = gpiod_to_irq(gpio);
> +                       if (ret < 0)
> +                               return ret;
> +                       /* GPIO interrupt does npt have a specified direction */
> +                       irqflags |= IRQF_TRIGGER_RISING;
> +               }
>                 data->irqs[i] = ret;
>                 ret = devm_request_threaded_irq(dev, data->irqs[i],
> -                               NULL, mma9551_event_handler,
> -                               IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> -                               MMA9551_IRQ_NAME, indio_dev);
> +                                               NULL, mma9551_event_handler,
> +                                               irqflags,
> +                                               MMA9551_IRQ_NAME, indio_dev);
>                 if (ret < 0) {
>                         dev_err(dev, "request irq %d failed\n", data->irqs[i]);
>                         return ret;
>                 }
> -
> -               dev_dbg(dev, "gpio resource, no:%d irq:%d\n",
> -                       desc_to_gpio(gpio), data->irqs[i]);
>         }
>
>         return 0;
> --
> 2.31.1
>
