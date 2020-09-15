Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EC426ACEA
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgIOTDd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgIOTDI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:03:08 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE55C06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 12:03:08 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u6so5311444iow.9
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRURjbyqDUK+oiKcbXkA3WH3kjC1sYTDDRSDDdnTIVg=;
        b=qhFeBlNbXzhulA4JNZBnfClmx5n/jOyrArjMr8jdlr19sfR73WHr28SvqYALx5LyQ7
         aAfdFr0+6bCEhP1LHSiDR3DYEG9WHtWEm59PXCJtwhWpPmL32VISxi8NUjMke/Id7XHM
         MFlHDAzhZKf5hog2WFZ6wLqIpT2qVMrXPBy4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRURjbyqDUK+oiKcbXkA3WH3kjC1sYTDDRSDDdnTIVg=;
        b=LVdO6J2LTvnoFMT/n3k2xUwGFR1o6Xl3Z8lu0cFRhtNozptpTqPE1lw4phf3yphj/j
         DPboc7Smmv8LZB+wmQXrBphElE+rmAaG8gdCLmKKt3VqhhFGtJj9KhFIxlwNbXwopvAa
         RnKeqUEgpIIvvH1ZwNuHghgfJO/WyRcAKchk9fmMVrHxmXlY6iyp0nYTzwdthfU8Gg3N
         jZuvRtHVt+tgqXnzPeWq/RvkbLULFCWxLWetPTI9UAIW2s/okBmhhayRQ9wg4IJxQUHB
         kPglm1W0R4TTUX4Y1vagnEttxcmM9Bf+IFv0d6PtU+hgs+Dbwp3AWl4485zXx45RGw4F
         HcYg==
X-Gm-Message-State: AOAM533wll6neh7omIptsD8Up8/+MBQMOq0Sjz2joRWH4IAu4KyNklKX
        O380o4yxYzym8nturJCgwpPuXI10FKr6utegjZivoCFKWhsi/g==
X-Google-Smtp-Source: ABdhPJzW9F1qFw9eDftKU0W69I6AlpbvkTWPh10MuiHddDkCpEDPFYSRlqnz0mNHCgH57m1V8nada0jBjr2ueS/zUlU=
X-Received: by 2002:a5e:9b0e:: with SMTP id j14mr16514431iok.112.1600196587597;
 Tue, 15 Sep 2020 12:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-29-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-29-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 12:02:56 -0700
Message-ID: <CAJCx=gnEVWM6ft45rOWU6BSP60dVq_3tzpZC41X8uGr3muWGsA@mail.gmail.com>
Subject: Re: [PATCH 28/38] iio:chemical:vz89x: Introduce local struct device pointer.
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
> Avoids lots of repition of &client->dev and will make the next
> patch tidier.

Typo of repetition.

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/chemical/vz89x.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 5586eb8e12cd..3cd469578590 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -352,12 +352,13 @@ MODULE_DEVICE_TABLE(of, vz89x_dt_ids);
>  static int vz89x_probe(struct i2c_client *client,
>                        const struct i2c_device_id *id)
>  {
> +       struct device *dev = &client->dev;
>         struct iio_dev *indio_dev;
>         struct vz89x_data *data;
>         const struct of_device_id *of_id;
>         int chip_id;
>
> -       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>         if (!indio_dev)
>                 return -ENOMEM;
>         data = iio_priv(indio_dev);
> @@ -370,7 +371,7 @@ static int vz89x_probe(struct i2c_client *client,
>         else
>                 return -EOPNOTSUPP;
>
> -       of_id = of_match_device(vz89x_dt_ids, &client->dev);
> +       of_id = of_match_device(vz89x_dt_ids, dev);
>         if (!of_id)
>                 chip_id = id->driver_data;
>         else
> @@ -383,13 +384,13 @@ static int vz89x_probe(struct i2c_client *client,
>         mutex_init(&data->lock);
>
>         indio_dev->info = &vz89x_info;
> -       indio_dev->name = dev_name(&client->dev);
> +       indio_dev->name = dev_name(dev);
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
>         indio_dev->channels = data->chip->channels;
>         indio_dev->num_channels = data->chip->num_channels;
>
> -       return devm_iio_device_register(&client->dev, indio_dev);
> +       return devm_iio_device_register(dev, indio_dev);
>  }
>
>  static const struct i2c_device_id vz89x_id[] = {
> --
> 2.28.0
>
