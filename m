Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE6A23116F
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgG1SQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732261AbgG1SQV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:16:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B59C061794;
        Tue, 28 Jul 2020 11:16:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so280623pjb.2;
        Tue, 28 Jul 2020 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jISM+zt2nd29Ii1resuCb6bg2XEO61i6A+AqlD1hti0=;
        b=KmiQynWKNiiaInfPptkC/nVzxfXieCAeD0W3vIrg8JGnbk31sRWMGhAwOgommGIlpA
         mMmUQItHM4g7TesT3WIOvC47xxZbxvpPnT9B86HoH3Q6F1AteU4NhzDmW21jyQ/Rkkj+
         EqltDfVfCk7w2d+uZozuuZidA0gaKF/z146430sZuQBunCwGOR/QuYYY8BTidipz1Wlk
         wz6DP685WYRhWW0he1wA//mkktpEkwR+Ssq6DcwrRcwlrpx952wHdBQdgJmVX5gp8hsy
         pT2sHnAUymvit2t2HXa0fpg1dVOeoOkvXX33y35REJ6S6QN4lddozIt5dGthjXk2ojLo
         GKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jISM+zt2nd29Ii1resuCb6bg2XEO61i6A+AqlD1hti0=;
        b=e2dC8hmnleRi5yZd1MIggpm4FsM5Fi9w8ACG7kQ8+aFXX8RvKXds9jumHOAJ1xHbRe
         /zHkByZ0lfJHHAlxAVhgxd10T+y0QRx/dJOJnqn59berI+NX5XGpg80qhA8Drcjv78um
         JexWvjOJmTC2cD7nBaJBake0YJ9EYIMTsn46J0qINobGXABZiZEps9THUanEdFwTcD6K
         OwNeWpsuG55E9bqeiF0jPtaXpsN4fXr3VrU9l/Pu4L5wDWLzfZH3g0znxix8SQ3PJNvQ
         B2Md45y7BX8wHsZN2IFzyiUK3/GX2jNn7j0lFpmDMSbX+nF92zZ/u/Gy+PXGmVg5gaTV
         AIOw==
X-Gm-Message-State: AOAM530vXNlartY92FUjee1kKwmRr8RhpWDFh7G7rgbvfoYwNzlLpCB9
        7Tek9T3UR5aiL7LWg+OSXNu5xhYbsjo4Ko+VuuvO2NzbIXnjYA==
X-Google-Smtp-Source: ABdhPJzQ8hg05xRxXSgYdD4EaFMItMNc0I43CoPplgkCk2kbSZN1B2sbUle5Hkl/AAQq//VxGm3VDC3H5Uz4sBUOKyM=
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr5608154pjn.181.1595960181192;
 Tue, 28 Jul 2020 11:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.11.I126c3f697e0b7ee951ea24ac60ce79d368790de9@changeid>
In-Reply-To: <20200728091057.11.I126c3f697e0b7ee951ea24ac60ce79d368790de9@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:16:04 +0300
Message-ID: <CAHp75Vdm0EaR24FV3Tdd-8we9ooaZr81KaPexLKgFatYj1yTrg@mail.gmail.com>
Subject: Re: [PATCH 11/15] iio: sx9310: Use variable to hold &client->dev
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
>
> Improves readability by storing &client->dev in a local variable.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/iio/proximity/sx9310.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 051c6515e62c18..ba383710ef0dcf 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -884,11 +884,12 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>  static int sx9310_probe(struct i2c_client *client)
>  {
>         int ret;
> +       struct device *dev = &client->dev;
>         struct iio_dev *indio_dev;
>         struct sx9310_data *data;
>
> -       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> -       if (indio_dev == NULL)
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +       if (!indio_dev)
>                 return -ENOMEM;
>
>         data = iio_priv(indio_dev);
> @@ -902,17 +903,16 @@ static int sx9310_probe(struct i2c_client *client)
>
>         ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
>         if (ret) {
> -               dev_err(&client->dev, "error in reading WHOAMI register: %d",
> -                       ret);
> +               dev_err(dev, "error in reading WHOAMI register: %d", ret);
>                 return ret;
>         }
>
> -       ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
> +       ret = sx9310_set_indio_dev_name(dev, indio_dev, data->whoami);
>         if (ret)
>                 return ret;
>
> -       ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
> -       indio_dev->dev.parent = &client->dev;
> +       ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> +       indio_dev->dev.parent = dev;
>         indio_dev->channels = sx9310_channels;
>         indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
>         indio_dev->info = &sx9310_info;
> @@ -924,7 +924,7 @@ static int sx9310_probe(struct i2c_client *client)
>                 return ret;
>
>         if (client->irq) {
> -               ret = devm_request_threaded_irq(&client->dev, client->irq,
> +               ret = devm_request_threaded_irq(dev, client->irq,
>                                                 sx9310_irq_handler,
>                                                 sx9310_irq_thread_handler,
>                                                 IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> @@ -932,29 +932,29 @@ static int sx9310_probe(struct i2c_client *client)
>                 if (ret)
>                         return ret;
>
> -               data->trig =
> -                       devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> -                                              indio_dev->name, indio_dev->id);
> +               data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +                                                   indio_dev->name,
> +                                                   indio_dev->id);
>                 if (!data->trig)
>                         return -ENOMEM;
>
> -               data->trig->dev.parent = &client->dev;
> +               data->trig->dev.parent = dev;
>                 data->trig->ops = &sx9310_trigger_ops;
>                 iio_trigger_set_drvdata(data->trig, indio_dev);
>
> -               ret = devm_iio_trigger_register(&client->dev, data->trig);
> +               ret = devm_iio_trigger_register(dev, data->trig);
>                 if (ret)
>                         return ret;
>         }
>
> -       ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>                                               iio_pollfunc_store_time,
>                                               sx9310_trigger_handler,
>                                               &sx9310_buffer_setup_ops);
>         if (ret)
>                 return ret;
>
> -       return devm_iio_device_register(&client->dev, indio_dev);
> +       return devm_iio_device_register(dev, indio_dev);
>  }
>
>  static int __maybe_unused sx9310_suspend(struct device *dev)
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
