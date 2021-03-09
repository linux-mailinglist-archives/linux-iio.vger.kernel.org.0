Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF563333147
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 22:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhCIVu7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 16:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhCIVur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 16:50:47 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3035AC06174A
        for <linux-iio@vger.kernel.org>; Tue,  9 Mar 2021 13:50:47 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id f10so13581000ilq.5
        for <linux-iio@vger.kernel.org>; Tue, 09 Mar 2021 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2FCuOuvzMif7mLgvauVp71ltb9Cj1kvrxurwIVD7+U=;
        b=OHLs7iPGeMAxIk6bGveW20uIlRlyEyk8lL1PbWb5cBDZRlPSqwdiYTjySIUFtiFY5T
         9gqgsZa+AqYeW148EE0cW2qPgfnOS9dXSFgd8Ad+djiCQOHT1C+VIyIsMmY8UjPqy3Hu
         muYnVrS30nmgozQoC/qx3qm21HcWkVg/9lw6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2FCuOuvzMif7mLgvauVp71ltb9Cj1kvrxurwIVD7+U=;
        b=SfW6X9gAkKisYJUo2XH253sJWCBspRTLaXFax6TIEArU1pNd+oxOJ0Nnfm1l27Qgx9
         q1JeyVqArlrp/DgwTKXJLQBDakp5fePP5i12Ea8V6183U7YSFOejxfiOAYglTMxGx0PF
         0drjS8XGf4IY3pWdOcL9A145U26f8NM0X/iPv7nN/iMvy/+a4mHlvE45XLgUp+AzhEfC
         2n1VOTiPhKCB4tIRGGdYlIUfeVj3F8kLtQ6rj7yMsW0gtkNEntzL2vawZIwp3ZU25Jku
         NbrjrMJBe0BKL5lvDzwJjRyzgaHjoN2YXVk+N2gTkphEV/yAxSBt8c9ScW/dWNpX5C8M
         i9WQ==
X-Gm-Message-State: AOAM533mZ+QlVx9tyTbgIvnUS+1ASgHU5y3YX6kkv8xKllrnZaRabxyh
        GjqSPyIDaXGDt2GwoWU5J2VCf8rsy3htnCVQL1X8WA==
X-Google-Smtp-Source: ABdhPJw04zXW/a3AbA09/X90W77lFDvENf9BQAhe2eX7FRD0FFKg03PE3x2H4tDZQ9zg0A9nCTGgfY7ogYee42LDjqk=
X-Received: by 2002:a92:c567:: with SMTP id b7mr210945ilj.25.1615326646694;
 Tue, 09 Mar 2021 13:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20210309193620.2176163-1-gwendal@chromium.org> <20210309193620.2176163-6-gwendal@chromium.org>
In-Reply-To: <20210309193620.2176163-6-gwendal@chromium.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 9 Mar 2021 13:50:35 -0800
Message-ID: <CAJCx=gm5KYx6iZOBbPDc1qiivJyC=NV4nanBqP9=3tS-22LJKg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] iio: lmp91000: Remove code to set trigger parent
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ardeleanalex@gmail.com,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 9, 2021 at 11:37 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> iio_trigger_set_drvdata() sets the trigger device parent to first
> argument of viio_trigger_alloc(), no need to do it again in the driver
> code.
>
> Given data->dev is dev, and we call devm_iio_trigger_alloc with
> dev instead of data->dev, we do not have to set data->trig->dev.parent to
> dev anymore.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
> Changes in v4:
> Improve commit message.
>
> No changes in v3.
>
>  drivers/iio/potentiostat/lmp91000.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index f34ca769dc20d..8a9c576616ee5 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -322,7 +322,7 @@ static int lmp91000_probe(struct i2c_client *client,
>                 return PTR_ERR(data->regmap);
>         }
>
> -       data->trig = devm_iio_trigger_alloc(data->dev, "%s-mux%d",
> +       data->trig = devm_iio_trigger_alloc(dev, "%s-mux%d",
>                                             indio_dev->name, indio_dev->id);
>         if (!data->trig) {
>                 dev_err(dev, "cannot allocate iio trigger.\n");
> @@ -330,7 +330,6 @@ static int lmp91000_probe(struct i2c_client *client,
>         }
>
>         data->trig->ops = &lmp91000_trigger_ops;
> -       data->trig->dev.parent = dev;
>         init_completion(&data->completion);
>
>         ret = lmp91000_read_config(data);
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
