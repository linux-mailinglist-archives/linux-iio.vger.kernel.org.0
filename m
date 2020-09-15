Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4A26ACF8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgIOTFf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgIOTEB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:04:01 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D7C06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 12:03:59 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s88so4064936ilb.6
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PRRTXSiaB+OaguTj8Jo3XI9THRE2KOGVAaHm+/U/wTc=;
        b=Uh4GfV2lo4DTG4xx9TmdtDFN+UOz3HSz7rtntCzC5BjvIolrztpFS8cmW66NQ4jufM
         Xqy75ITDTqcYjDzTrTFxrXP9P6kOTYj2LS4Dh+PLTk8s1GeLlsl1c8R2uW0Tosv0/pHP
         I8eHbW0+AqSgGGNoZ8aIPzVqDGy7JgRBWCgzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PRRTXSiaB+OaguTj8Jo3XI9THRE2KOGVAaHm+/U/wTc=;
        b=IBw4lk1+2/rVBJXFzJJkantkcvm8rwTRetqM5mZLmaupKtsvYHbsXfmFyxiPq1/690
         POAPsH/IMeZD8ZCIRbEoLM4BBgZEEuGG9fEpdJ+mYC05K9LkjPX0Y9hWpT0e/P1aneVQ
         itbMrRYiENCQDqE72no/UghP70HVzAPClrCQpLJVpdaxCcB/gD/C7z/WyJoq9+uQPoZF
         S7CVXESj+oiKHCgWbBEnkfM3IzKzJcdlUOPU6Ts2Je488BwzzeXRXClhMDjWEXmG9SfA
         LU0+8jD4IbZB72pqvSp2vlKYDX2XiKYFik47KaiX4h9fecLxJrHx3lvsIi1ZdsIIl4sC
         MNxA==
X-Gm-Message-State: AOAM5328Hr5VjVf6tJrTlPnV8es20ZfVZRJsjL8+SiUBUP6+TDswX5Iw
        YXYTjWky5O+mF6zitKw+4rjA+CMWzCrsp0Y3t4RL+Ui2Z5ktlQ==
X-Google-Smtp-Source: ABdhPJznl5YCfoiiC+mKvS8mWdk8k+9HYC749JMuqDj+zabW6qyZeYTRhaanxsWQxUPtAnbb0J+A05s2yegSmHutBLk=
X-Received: by 2002:a92:8b52:: with SMTP id i79mr18252132ild.177.1600196638075;
 Tue, 15 Sep 2020 12:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-30-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-30-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 12:03:47 -0700
Message-ID: <CAJCx=g=xfHmzQ6NVErq+5uds4E3wfnjdb_0B3YkF-t172Qjc=g@mail.gmail.com>
Subject: Re: [PATCH 29/38] iio:chemical:vz89x: Drop of_match_ptr protection
 and use generic fw accessors
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
> This change allow the driver to be used with ACPI PRP0001 and removes
> an antipattern that I want to avoid being copied into new IIO drivers.
>
> The handling of match_data uses a different approach as
> device_get_match_data() doesn't distinguish between no match, and
> a match but with NULL data.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/chemical/vz89x.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 3cd469578590..23b22a5f5c1c 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -10,8 +10,7 @@
>  #include <linux/mutex.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -355,7 +354,6 @@ static int vz89x_probe(struct i2c_client *client,
>         struct device *dev = &client->dev;
>         struct iio_dev *indio_dev;
>         struct vz89x_data *data;
> -       const struct of_device_id *of_id;
>         int chip_id;
>
>         indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -371,11 +369,10 @@ static int vz89x_probe(struct i2c_client *client,
>         else
>                 return -EOPNOTSUPP;
>
> -       of_id = of_match_device(vz89x_dt_ids, dev);
> -       if (!of_id)
> +       if (!dev_fwnode(dev))
>                 chip_id = id->driver_data;
>         else
> -               chip_id = (unsigned long)of_id->data;
> +               chip_id = (unsigned long)device_get_match_data(dev);
>
>         i2c_set_clientdata(client, indio_dev);
>         data->client = client;
> @@ -403,7 +400,7 @@ MODULE_DEVICE_TABLE(i2c, vz89x_id);
>  static struct i2c_driver vz89x_driver = {
>         .driver = {
>                 .name   = "vz89x",
> -               .of_match_table = of_match_ptr(vz89x_dt_ids),
> +               .of_match_table = vz89x_dt_ids,
>         },
>         .probe = vz89x_probe,
>         .id_table = vz89x_id,
> --
> 2.28.0
>
