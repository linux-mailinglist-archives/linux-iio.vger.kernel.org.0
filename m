Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F226ACAF
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgIOS4v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgIOS4k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 14:56:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488EFC06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:56:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b6so5310574iof.6
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6Dqm2D7aLy7U+UhsC2DIhJbKfy3QptxlvDV324h6Qw=;
        b=Ku2t7PZpN9msY/kTF4VT13YmiZX2gXtbsghh3/regA9OzPyPWbYZMY+xZm6xDiIES7
         pnKdviffYeLfrHLOhR3zZaP9s8C9EzbSqYpj4wssJ7MxKk34k6S/lbke11s7QZ4Wehzn
         IG7vLqSWECGXDIuxPxoX9NpsiiRdxg+KILvlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6Dqm2D7aLy7U+UhsC2DIhJbKfy3QptxlvDV324h6Qw=;
        b=bFSgkKK/jmUOig/tNaYbtupwFaZIhWXW2lAAFGT66p7LsgZNx/7THi7L3hbgRTpb5e
         SlPIxsBixecf3t9ft21TdwdVsTgFcFR0QZCmwsGFXC4E06HHu5rFSFrU7SphehSJN542
         5cUDkp+6pgoWqjyT+41RngMJ6v0pi9yUImoenjF4ZTSV9Lwj/WyMYULV++SswK/wvbci
         5R/W953rvHw5MyuRI4l5hVEaHdXZWAGVDTjAnk0UAblcRrFdiG7P9kwWiU9+nzwGRKFX
         MJaKsY2b9Wc+if7Qa9+RqEP3aUZW9J1rOCgsTZboLg4yMloTwcNq0xy9gYlZgWqoPJsV
         i72w==
X-Gm-Message-State: AOAM533OJJcr5ErxuA0aGhaoJbwSN03HrVwcJTZQthABXbhUus0ax997
        dYUZHKJhizfCuCoa/bD2reNr5lXpjKbt/jBvkaX2GA==
X-Google-Smtp-Source: ABdhPJwalQ+t33zBfz+PRppUi9MH0GNxR/tsi5FAxWgY6SZoqaEmxVaQxnxgQBZAeV30N6eQKAwzvAfTd19ZVhsH7C8=
X-Received: by 2002:a5e:8a08:: with SMTP id d8mr15959506iok.95.1600196199631;
 Tue, 15 Sep 2020 11:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-32-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-32-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:56:28 -0700
Message-ID: <CAJCx=gnsSJRoiEoD8truDp9weBeyEyFSi1E3SF=nTOr9j6MKrA@mail.gmail.com>
Subject: Re: [PATCH 31/38] iio:proximity:as3935: Use local struct device
 pointer to simplify code.
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
> This makes the existing code easier to read and will make the following
> patch a little simpler.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/proximity/as3935.c | 38 ++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index c339e7339ec8..4df8d53d65fb 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -352,19 +352,20 @@ static void as3935_stop_work(void *data)
>
>  static int as3935_probe(struct spi_device *spi)
>  {
> +       struct device *dev = &spi->dev;
>         struct iio_dev *indio_dev;
>         struct iio_trigger *trig;
>         struct as3935_state *st;
> -       struct device_node *np = spi->dev.of_node;
> +       struct device_node *np = dev->of_node;
>         int ret;
>
>         /* Be sure lightning event interrupt is specified */
>         if (!spi->irq) {
> -               dev_err(&spi->dev, "unable to get event interrupt\n");
> +               dev_err(dev, "unable to get event interrupt\n");
>                 return -EINVAL;
>         }
>
> -       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>         if (!indio_dev)
>                 return -ENOMEM;
>
> @@ -378,14 +379,12 @@ static int as3935_probe(struct spi_device *spi)
>                         "ams,tuning-capacitor-pf", &st->tune_cap);
>         if (ret) {
>                 st->tune_cap = 0;
> -               dev_warn(&spi->dev,
> -                       "no tuning-capacitor-pf set, defaulting to %d",
> +               dev_warn(dev, "no tuning-capacitor-pf set, defaulting to %d",
>                         st->tune_cap);
>         }
>
>         if (st->tune_cap > MAX_PF_CAP) {
> -               dev_err(&spi->dev,
> -                       "wrong tuning-capacitor-pf setting of %d\n",
> +               dev_err(dev, "wrong tuning-capacitor-pf setting of %d\n",
>                         st->tune_cap);
>                 return -EINVAL;
>         }
> @@ -393,8 +392,7 @@ static int as3935_probe(struct spi_device *spi)
>         ret = of_property_read_u32(np,
>                         "ams,nflwdth", &st->nflwdth_reg);
>         if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
> -               dev_err(&spi->dev,
> -                       "invalid nflwdth setting of %d\n",
> +               dev_err(dev, "invalid nflwdth setting of %d\n",
>                         st->nflwdth_reg);
>                 return -EINVAL;
>         }
> @@ -405,7 +403,7 @@ static int as3935_probe(struct spi_device *spi)
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &as3935_info;
>
> -       trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +       trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
>                                       indio_dev->name, indio_dev->id);
>
>         if (!trig)
> @@ -417,42 +415,42 @@ static int as3935_probe(struct spi_device *spi)
>         iio_trigger_set_drvdata(trig, indio_dev);
>         trig->ops = &iio_interrupt_trigger_ops;
>
> -       ret = devm_iio_trigger_register(&spi->dev, trig);
> +       ret = devm_iio_trigger_register(dev, trig);
>         if (ret) {
> -               dev_err(&spi->dev, "failed to register trigger\n");
> +               dev_err(dev, "failed to register trigger\n");
>                 return ret;
>         }
>
> -       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>                                               iio_pollfunc_store_time,
>                                               as3935_trigger_handler, NULL);
>
>         if (ret) {
> -               dev_err(&spi->dev, "cannot setup iio trigger\n");
> +               dev_err(dev, "cannot setup iio trigger\n");
>                 return ret;
>         }
>
>         calibrate_as3935(st);
>
>         INIT_DELAYED_WORK(&st->work, as3935_event_work);
> -       ret = devm_add_action(&spi->dev, as3935_stop_work, indio_dev);
> +       ret = devm_add_action(dev, as3935_stop_work, indio_dev);
>         if (ret)
>                 return ret;
>
> -       ret = devm_request_irq(&spi->dev, spi->irq,
> +       ret = devm_request_irq(dev, spi->irq,
>                                 &as3935_interrupt_handler,
>                                 IRQF_TRIGGER_RISING,
> -                               dev_name(&spi->dev),
> +                               dev_name(dev),
>                                 indio_dev);
>
>         if (ret) {
> -               dev_err(&spi->dev, "unable to request irq\n");
> +               dev_err(dev, "unable to request irq\n");
>                 return ret;
>         }
>
> -       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       ret = devm_iio_device_register(dev, indio_dev);
>         if (ret < 0) {
> -               dev_err(&spi->dev, "unable to register device\n");
> +               dev_err(dev, "unable to register device\n");
>                 return ret;
>         }
>         return 0;
> --
> 2.28.0
>
