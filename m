Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7614945AEFA
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 23:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbhKWW1R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 17:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbhKWW1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 17:27:15 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73FAC061574
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:24:06 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z18so633576iof.5
        for <linux-iio@vger.kernel.org>; Tue, 23 Nov 2021 14:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Io1RaS8jQ51OxuGpyqsC0je17Y2G7y0gc0/YGQnhfQE=;
        b=Abp5+rfL+U/DXrbMNHvccuu4JOAi2Ac1N2FSgtOo09RuSj3ELfonbu3V86zSVLeY8v
         hggA4+mY7chQROEk+goQAHm2PbmEtVpi7hoeQwA+7MzSd6CEyGHhJhZswNhbK9wHwLou
         mrfAbGnlgAgpeAzCm5H2GKrRZ0Ndil8/pjxpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Io1RaS8jQ51OxuGpyqsC0je17Y2G7y0gc0/YGQnhfQE=;
        b=G4h1ZGY1SVxjzbHjriuylEt/VjilcMB9DveKUwLjMYIdWnw9yFX7rQRUbunC8YqfOq
         /UnsHUQ36kisraZ93s47zx6/6Dpe6iytWahgP9OWJ53oH9u2m9v46KvfAgHHOEg0NIrV
         SuuBmLtmhsY+JShPpY3UPmmh4Z0gRnVUQ2CdyY5Dm0osr18dXuxkjsQlNyLKaeYZYGsE
         dYJ8myeCTBhBKTUqOi9lABDHK48u5i+KCV6Avd/FqR8l725d/5uLPxQIxZ7zZOeZhx6d
         YItuqUzB1FMNWwmqfrFCvCizoORchWfrsMh3965UN0vduRJXH2uf6q6cuI/OLu0UMWyG
         B5gg==
X-Gm-Message-State: AOAM532tPMxVyWSBS/ZQUrX25DlLR2Vvb4Ftbl4GrJBX6vbrb6Qqj7k6
        jIbHUR2kvfFQNinF9qsT6D+y0v0PgoY1Wl5fkfY70juj00Io7w==
X-Google-Smtp-Source: ABdhPJwBlrlEqBl55rgRZ3livOBtO/forTjneWbYOxdjtdP+dGucv9BgldGueLAH5njDwSRYE11TcoWyl2Uk9MhpYZg=
X-Received: by 2002:a05:6602:1487:: with SMTP id a7mr9125331iow.57.1637706246135;
 Tue, 23 Nov 2021 14:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20211123211019.2271440-1-jic23@kernel.org> <20211123211019.2271440-43-jic23@kernel.org>
In-Reply-To: <20211123211019.2271440-43-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 23 Nov 2021 14:23:53 -0800
Message-ID: <CAJCx=gnsm=3yiw+0A=OZGHj=CZWw0dk2_9Uvn-4HfVUrLMavCw@mail.gmail.com>
Subject: Re: [PATCH 42/49] iio:proximity:as3935: Switch from CONFIG_PM_SLEEP
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
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
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
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/proximity/as3935.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index d62766b6b39e..605c6095d704 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -295,8 +295,7 @@ static void calibrate_as3935(struct as3935_state *st)
>         as3935_write(st, AS3935_NFLWDTH, st->nflwdth_reg);
>  }
>
> -#ifdef CONFIG_PM_SLEEP
> -static int as3935_suspend(struct device *dev)
> +static __maybe_unused int as3935_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>         struct as3935_state *st = iio_priv(indio_dev);
> @@ -316,7 +315,7 @@ static int as3935_suspend(struct device *dev)
>         return ret;
>  }
>
> -static int as3935_resume(struct device *dev)
> +static __maybe_unused int as3935_resume(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
>         struct as3935_state *st = iio_priv(indio_dev);
> @@ -338,11 +337,6 @@ static int as3935_resume(struct device *dev)
>  }
>
>  static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
> -#define AS3935_PM_OPS (&as3935_pm_ops)
> -
> -#else
> -#define AS3935_PM_OPS NULL
> -#endif
>
>  static void as3935_stop_work(void *data)
>  {
> @@ -472,7 +466,7 @@ static struct spi_driver as3935_driver = {
>         .driver = {
>                 .name   = "as3935",
>                 .of_match_table = as3935_of_match,
> -               .pm     = AS3935_PM_OPS,
> +               .pm     = pm_ptr(&as3935_pm_ops),
>         },
>         .probe          = as3935_probe,
>         .id_table       = as3935_id,
> --
> 2.34.0
>
