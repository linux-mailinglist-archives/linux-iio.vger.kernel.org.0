Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458F126ACD3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgIOTAf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgIOTAO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:00:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191D0C06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 12:00:08 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z25so5288705iol.10
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnNwu28AnEov8YAs3Y1NlvsH/fnXWGod8A99me5AeF4=;
        b=frI6mi9waBS1TSa9so2b0OMdswChxYHdVhprG4c0VzmNyWTv/QC0nfbWL9OpMt2mER
         Ya+sLeBdwVRD9czBqJ/7eVmj/HHV1Z/evtVDGAIOapUHkzprGizApHok8NJmgmJvkd+y
         0+hZzHXinwwCfHeu4AQjEeI+1ovmOcZf6BimY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnNwu28AnEov8YAs3Y1NlvsH/fnXWGod8A99me5AeF4=;
        b=Yk2ItYOClV0/ZEtjTNOaNeLSS8dYUDjqPwbubNQN6DiQ4palyqpFTjxm79U5LoYn/j
         cw7XScMMtmr83s8GIiEjXEdpqkQT+RzfSYFhsEGbk+FR9YpIIUpA5VBxaLJZDpHiQVy4
         RTlvmCgFDbuXfCeh9jnAW151g9imCL4rwnP+8Ee5KGzjffyxp3iWcjz2dusntJCYzMT9
         /F+uYlvfBHK2EH02YmJ2tgOvR+ZGAJfkPF4+vm2P8ujzH00iEye0ntkB5Ngsp/MDZn03
         AFl2ThV+3p5rbDcRRHNh/RBgxNEZ0txBDw0cCGSJKyNjhJPPraawMi+Rm/tDXZrxP74w
         cjGg==
X-Gm-Message-State: AOAM530D7wzHxEJUnNOreAuN4IRxTNoLlKz7c6YRENaYAfy/dqpruIVZ
        bVvgh4DeP2RSTSlEJzjPnQvFWLnEONldXGIXVNUqjg==
X-Google-Smtp-Source: ABdhPJyh0FD2dyYrofHaQ+vZ+pC4+2WGKPVrLEGkAtv9NZpKrSfmXbKcBPPohbSu2XnSdVhn1t1qkAOMAmC1nK9M1W4=
X-Received: by 2002:a02:c914:: with SMTP id t20mr19095177jao.117.1600196407446;
 Tue, 15 Sep 2020 12:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-26-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-26-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:59:56 -0700
Message-ID: <CAJCx=g=M9ERR7O=Rz==3MeunRPNZ4LBwsXWuSZHExg7H0idEBw@mail.gmail.com>
Subject: Re: [PATCH 25/38] iio:chemical:atlas-sensor: Drop of_match_ptr and
 use generic fw accessors
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
> of_match_ptr() prevents use of this driver with ACPI via PRP0001 and is
> an example of an anti pattern I'm trying to remove from IIO.
> Hence drop from this driver and use generic fw accessors to check
> if there is a fw_node and get the id.
>
> It might be neater to use pointers rather than indexes for
> the device_data but that is another issue and should be handled
> separately.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/chemical/atlas-sensor.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> index 43069636fcd5..cdab9d04dedd 100644
> --- a/drivers/iio/chemical/atlas-sensor.c
> +++ b/drivers/iio/chemical/atlas-sensor.c
> @@ -15,7 +15,7 @@
>  #include <linux/irq.h>
>  #include <linux/irq_work.h>
>  #include <linux/i2c.h>
> -#include <linux/of_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -620,7 +620,6 @@ static int atlas_probe(struct i2c_client *client,
>  {
>         struct atlas_data *data;
>         struct atlas_device *chip;
> -       const struct of_device_id *of_id;
>         struct iio_trigger *trig;
>         struct iio_dev *indio_dev;
>         int ret;
> @@ -629,11 +628,10 @@ static int atlas_probe(struct i2c_client *client,
>         if (!indio_dev)
>                 return -ENOMEM;
>
> -       of_id = of_match_device(atlas_dt_ids, &client->dev);
> -       if (!of_id)
> +       if (!dev_fwnode(&client->dev))
>                 chip = &atlas_devices[id->driver_data];
>         else
> -               chip = &atlas_devices[(unsigned long)of_id->data];
> +               chip = &atlas_devices[(unsigned long)device_get_match_data(&client->dev)];
>
>         indio_dev->info = &atlas_info;
>         indio_dev->name = ATLAS_DRV_NAME;
> @@ -775,7 +773,7 @@ static const struct dev_pm_ops atlas_pm_ops = {
>  static struct i2c_driver atlas_driver = {
>         .driver = {
>                 .name   = ATLAS_DRV_NAME,
> -               .of_match_table = of_match_ptr(atlas_dt_ids),
> +               .of_match_table = atlas_dt_ids,
>                 .pm     = &atlas_pm_ops,
>         },
>         .probe          = atlas_probe,
> --
> 2.28.0
>
