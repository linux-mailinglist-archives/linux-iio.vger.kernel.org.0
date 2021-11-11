Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E073D44D4D7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhKKKP7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 05:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKKKP7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 05:15:59 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDC4C061766;
        Thu, 11 Nov 2021 02:13:10 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id b3so10824761uam.1;
        Thu, 11 Nov 2021 02:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=OV0UM9gJNoYarjOdaNebNlg6ZUQZxi88zAgzP/6FP0w=;
        b=QrRvMTm/TwaPYXc45yS3JOUYUvVgZB71WdWV4dRm4JBHXWgxODzYLwW7+tmsU4qccH
         5T8Jrhg1T+HfdM1ZQ7j4uHRlbn32QHJsz7p8dnRhA8RR0iahxUVUOeJ0XuI5T/eWq7xt
         y2I2AKlwgIHG4XaEAiGZo8C7fEEZdQ0gZ9Qg7X/hG9h0eGO1t3gc7RIq7MEmhFl4W2xi
         ulsQ8DLglPKgwxM/D2OSeg5SZRzOJXqfNDWFL5Tm58r8V3EexsnbV/eYXNaKPro6YvMV
         Zpdbf/s7qj5I0hLSUyqykram8SZMmkApvAqQwiew7nu5zuEz9iYHiiI5GZGNH7wJU9Ja
         eyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=OV0UM9gJNoYarjOdaNebNlg6ZUQZxi88zAgzP/6FP0w=;
        b=Foan/J8ZI5zIT3vEjwsZG+59B5J5Rsv5Q7EIAEbH77/Txpg7Swkd4CDquG8ThTb9yU
         CLb2CkhvgLv8A9wC7ooklZiMStgfk7HMb5ky2zlfDe0jJH5FrVn6glykt2W1vfYNS4mw
         zzTlF5gkLODBX+4ZNVXTjhL8uhDclDhjG9M/WI6IhQYrCp3s3R+f+SRbn5m+NTs63pPh
         Hlmn5GNKS/fjKf3dnGTT/1Goy8XKL0n39Rd0sIDEsbZqGsGrO+5ppHAcjofpO5X5rqPV
         UaGJSpZbgnKW/O/YHb0xVJ4mYoDebgqApairQd5hjMHMSUUVVDPs3LPeJdz5nvmHxhra
         EenA==
X-Gm-Message-State: AOAM532ueouJ75dzzNfpVk/+rNS3Im5SCcftRkjfuXjHtEdpPf0QC65L
        jiTW2S/ThzWS4k4W18KVq6Kmo0KBCeYE32/0ewg=
X-Google-Smtp-Source: ABdhPJxaRHHUZ22k+Ko739D5cwF3n8FJ9wWblVSb/ZT5zX8uIXJ17kDPhR3ACJmIcRvwwzfU30Vzy5n1WHsxeMot7CY=
X-Received: by 2002:ab0:3e3:: with SMTP id 90mr8641510uau.102.1636625589295;
 Thu, 11 Nov 2021 02:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028101840.24632-11-andrea.merello@gmail.com>
 <20211028121001.73d8abbe@jic23-huawei>
In-Reply-To: <20211028121001.73d8abbe@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Thu, 11 Nov 2021 11:12:58 +0100
Message-ID: <CAN8YU5PjJ9e8_RuLpY0JgLek-+HwxOLJ61MAGBqqzbqd6KWuYA@mail.gmail.com>
Subject: Re: [v2 10/10] iio: imu: add BNO055 I2C driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Just an inline comment; OK for the rest.

Il giorno gio 28 ott 2021 alle ore 13:05 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Thu, 28 Oct 2021 12:18:40 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > This path adds an I2C driver for communicating to a BNO055 IMU via I2C bus
> > and it enables the BNO055 core driver to work in this scenario.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> Hi Andrea,
>
> A few minor things inline.
>
> Jonathan
>
> > ---
> >  drivers/iio/imu/bno055/Kconfig      |  6 ++++
> >  drivers/iio/imu/bno055/Makefile     |  1 +
> >  drivers/iio/imu/bno055/bno055_i2c.c | 54 +++++++++++++++++++++++++++++
> >  3 files changed, 61 insertions(+)
> >  create mode 100644 drivers/iio/imu/bno055/bno055_i2c.c
> >
> > diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> > index 941e43f0368d..87200787d548 100644
> > --- a/drivers/iio/imu/bno055/Kconfig
> > +++ b/drivers/iio/imu/bno055/Kconfig
> > @@ -7,3 +7,9 @@ config BOSH_BNO055_SERIAL
> >       tristate "Bosh BNO055 attached via serial bus"
> >       depends on SERIAL_DEV_BUS
> >       select BOSH_BNO055_IIO
> > +
> > +config BOSH_BNO055_I2C
> > +     tristate "Bosh BNO055 attached via I2C bus"
> > +     depends on I2C
> > +     select REGMAP_I2C
> > +     select BOSH_BNO055_IIO
> > diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> > index 7285ade2f4b9..eaf24018cb28 100644
> > --- a/drivers/iio/imu/bno055/Makefile
> > +++ b/drivers/iio/imu/bno055/Makefile
> > @@ -2,3 +2,4 @@
> >
> >  obj-$(CONFIG_BOSH_BNO055_IIO) += bno055.o
> >  obj-$(CONFIG_BOSH_BNO055_SERIAL) += bno055_sl.o
> > +obj-$(CONFIG_BOSH_BNO055_I2C) += bno055_i2c.o
> > diff --git a/drivers/iio/imu/bno055/bno055_i2c.c b/drivers/iio/imu/bno055/bno055_i2c.c
> > new file mode 100644
> > index 000000000000..eea0daa6a61d
> > --- /dev/null
> > +++ b/drivers/iio/imu/bno055/bno055_i2c.c
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * I2C interface for Bosh BNO055 IMU.
> > + * This file implements I2C communication up to the register read/write
> > + * level.
>
> Not really. It just uses regmap, so I'd drop this comment.
>
> > + *
> > + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> > + * Electronic Design Laboratory
> > + * Written by Andrea Merello <andrea.merello@iit.it>
> > + */
> > +
> > +#include <linux/i2c.h>
>
> Why?  I'm not seeing an i2c specific calls in here.

Because of the definition of struct i2c_client, that is being accessed
in lines like this
dev_err(&client->dev, "Unable to init register map");

> > +#include <linux/regmap.h>
> > +#include <linux/module.h>
>
> mod_devicetable.h for struct i2c_device_id
>
> > +
> > +#include "bno055.h"
> > +
> > +#define BNO055_I2C_XFER_BURST_BREAK_THRESHOLD 3 /* FIXME */
> > +
> > +static int bno055_i2c_probe(struct i2c_client *client,
> > +                         const struct i2c_device_id *id)
> > +{
> > +     struct regmap *regmap =
> > +             devm_regmap_init_i2c(client, &bno055_regmap_config);
> > +
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&client->dev, "Unable to init register map");
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     return bno055_probe(&client->dev, regmap,
> > +                         BNO055_I2C_XFER_BURST_BREAK_THRESHOLD);
> > +
> > +     return 0;
>
> ?
>
> > +}
> > +
> > +static const struct i2c_device_id bno055_i2c_id[] = {
> > +     {"bno055", 0},
> > +     { },
>
> It's at terminator, so don't put a comma as we'll never add entries after this.
>
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bno055_i2c_id);
> > +
> > +static struct i2c_driver bno055_driver = {
> > +     .driver = {
> > +             .name = "bno055-i2c",
> > +     },
> > +     .probe = bno055_i2c_probe,
> > +     .id_table = bno055_i2c_id
> > +};
> > +module_i2c_driver(bno055_driver);
> > +
> > +MODULE_AUTHOR("Andrea Merello");
> > +MODULE_DESCRIPTION("Bosch BNO055 I2C interface");
> > +MODULE_LICENSE("GPL v2");
>
