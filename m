Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE5362FE5
	for <lists+linux-iio@lfdr.de>; Sat, 17 Apr 2021 15:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhDQMj4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Apr 2021 08:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQMj4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Apr 2021 08:39:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E7C061574;
        Sat, 17 Apr 2021 05:39:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m11so20123289pfc.11;
        Sat, 17 Apr 2021 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5m6WYXywGC9cMTV3SNlpEDdkZLjEaEUcWZAutELYj4=;
        b=jIXbNKTXn1LyNTxZ0uZVgbnnFE7Eg4nYCxPfEEOZZNMyIjowJYs5woGM2txkdCz3Vb
         ik6fH82oBHHOg/7cy0rxZMEM+n4nuR9OM7+hbTap6GFEIRoKt2Du9kgvZ9SrYd0cWt/M
         Ijh7O8r7/P/67vvG3XUh5OjlAo83DmncXQicxQpLLQpNIJIfBTDHMwCsIuwUfV56Gdn/
         vWz4Sprvljk2wV2a40O1q6CvbL8KEBnOqoaFUuG/WfQjQBdYTMxDrk2sgowkxPprLOVk
         fRxt+ZdzPHDuiK30sgfqDU2ntmjXsW4aRywtCIacSvmo49Wzz3wmUE2RY5+KFIkpMY9S
         3pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5m6WYXywGC9cMTV3SNlpEDdkZLjEaEUcWZAutELYj4=;
        b=j/iSqcjNKGerHqaRI1kiYuQ36qJxnIlJzJ3eGPFNqwCenBgZqPTxvOje8ExhUpFoXE
         YYeDUQu2uXYKrJNTZCAJ9AXPgJ2TTkL94Ace6FqPnHf3tJ+B6DvIJqiZAQ/MoQVCzass
         qdA9xO2bAyr/z4VaokFMFIjr4Ar1IL1K2BIHcck9yshNmsIPFzL0oJriSJyv2tBhejK9
         NVTQXOjBelJl+OlFzlnO6Y+EtiibPbhLDi4ZajbPC0D8Y3n0hVymWLMBKpFoBndheers
         cgJ4gkIYw4zEdwMe6DMt+xYxG6EsLXy8m75z0wF+OYL4sMYZhLapJqYSMttto7Y0jQ8O
         vFqg==
X-Gm-Message-State: AOAM53011+EY5o5XlTg+keacL6ObDDPsXXxG/H5kML/zM+xfnrxKqra9
        TpYwDo4OLtSf+qxShYOtq4UadSLmKcw62USxaEycmL65suA=
X-Google-Smtp-Source: ABdhPJyeY9oULnb0q+ZGcw4IO2w4e8xof+88zdhpnuJjg9b8qRWpt5nGq/9FeJx1Xc0VyD+nnMv1erx4Xd6f+634Q8s=
X-Received: by 2002:a63:c48:: with SMTP id 8mr3329069pgm.74.1618663169164;
 Sat, 17 Apr 2021 05:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210416134546.38475-1-tomas.melin@vaisala.com> <20210416134546.38475-3-tomas.melin@vaisala.com>
In-Reply-To: <20210416134546.38475-3-tomas.melin@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Apr 2021 15:39:12 +0300
Message-ID: <CAHp75VcibWup79np=xeQpO2z+OGCFXPhL6vWL6aWRZ+G8+djwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 16, 2021 at 5:21 PM Tomas Melin <tomas.melin@vaisala.com> wrote:
>
> Add initial support for Murata SCA3300 3-axis industrial
> accelerometer with digital SPI interface. This device also
> provides a temperature measurement.
>
> Device product page including datasheet can be found at:
> https://www.murata.com/en-global/products/sensor/accel/sca3300

Can you create a tag out of it, i.e.

Datasheet: <URL>

?

> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>

...

>  obj-$(CONFIG_SCA3000)          += sca3000.o
> +obj-$(CONFIG_SCA3300)          += sca3300.o

How much difference between them?

...

> +/*
> + * Copyright (c) 2021 Vaisala Oyj. All rights reserved.
> + */

One line

> +#include <asm/unaligned.h>

Usually asm/* goes after linux/*

> +#include <linux/bitops.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Can you move this below...

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>

...here.

So, you will have something like this at the end:

linux/*

asm/*

linux/iio*

...

> +#define SCA3300_REG_STATUS 0x6
> +#define SCA3300_REG_MODE 0xd
> +#define SCA3300_REG_WHOAMI 0x10

> +#define SCA3300_VALUE_SW_RESET 0x20
> +#define SCA3300_CRC8_POLYNOMIAL 0x1d
> +#define SCA3300_DEVICE_ID 0x51
> +#define SCA3300_RS_ERROR 0x3

> +#define SCA3300_SELBANK 0x1f

Is it mask or value or offset?

> +#define SCA3300_STATUS_MASK 0x1ff

GENMASK()

TAB indentation to all?

This all like an unordered pile of something. I can't guess the value
for which register and so on. Can you put an order here?

...

> +#define SCA3300_ACCEL_CHANNEL(index, reg, axis) {                      \


> +                       }

Something wrong with indentation here.

...

> +static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185},
> +                                           {0, 185}};

Put it all on one line.

...

> +static const unsigned long sca3300_scan_masks[] = {
> +       BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> +       BIT(SCA3300_TEMP),

> +       0};

Something wrong with indentation, i.e. }; should be on the following line.

...

> +static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
> +{
> +       struct spi_delay delay = {.value = 10, .unit = SPI_DELAY_UNIT_USECS};
> +       int32_t ret;
> +       int rs;
> +       u8 crc;
> +       struct spi_transfer xfers[2] = {
> +               {
> +                       .tx_buf = sca_data->txbuf,
> +                       .rx_buf = NULL,
> +                       .len = ARRAY_SIZE(sca_data->txbuf),
> +                       .delay = delay,
> +                       .cs_change = 1,
> +               },
> +               {
> +                       .tx_buf = NULL,
> +                       .rx_buf = sca_data->rxbuf,
> +                       .len = ARRAY_SIZE(sca_data->rxbuf),
> +                       .delay = delay,
> +                       .cs_change = 0,
> +               }
> +       };
> +
> +       /* inverted crc value as described in device data sheet */
> +       crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3, CRC8_INIT_VALUE);
> +       sca_data->txbuf[3] = crc;
> +
> +       ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
> +       if (ret < 0) {
> +               dev_err(&sca_data->spi->dev,
> +                       "transfer error, error: %d\n", ret);

> +               return -EIO;

Why shadowing error code?

> +       }
> +
> +       crc = ~crc8(sca3300_crc_table, &sca_data->rxbuf[0], 3, CRC8_INIT_VALUE);
> +       if (sca_data->rxbuf[3] != crc) {
> +               dev_err(&sca_data->spi->dev, "CRC checksum mismatch");
> +               return -EIO;
> +       }
> +
> +       /* get return status */

> +       rs = sca_data->rxbuf[0] & 0x03;

What's 0x3? Shouldn't it be defined with a descriptive name?

> +       if (rs == SCA3300_RS_ERROR)
> +               ret = -EINVAL;
> +
> +       *val = sign_extend32(get_unaligned_be16(&sca_data->rxbuf[1]), 15);
> +
> +       return ret;
> +}

...

> +static int sca3300_error_handler(struct sca3300_data *sca_data)
> +{
> +       int ret;
> +       int val;
> +
> +       mutex_lock(&sca_data->lock);
> +       sca_data->txbuf[0] = 0x0 | (SCA3300_REG_STATUS << 2);
> +       ret = sca3300_transfer(sca_data, &val);
> +       mutex_unlock(&sca_data->lock);
> +       /* return status is cleared after reading status register */

> +       if (ret != -EINVAL) {

Why this? Comment above is confusing, see also the comments below.

> +               dev_err(&sca_data->spi->dev,
> +                       "error reading device status: %d\n", ret);
> +               return ret;
> +       }

> +       dev_err(&sca_data->spi->dev, "device status: 0x%x\n",
> +               (u16)(val & SCA3300_STATUS_MASK));

Why casting here?!

> +       return 0;
> +}

...

> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
> +{
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);

> +       sca_data->txbuf[0] = 0x0 | (reg << 2);

What is the meaning of the 0x0? Comment, please.

> +       ret = sca3300_transfer(sca_data, val);
> +       mutex_unlock(&sca_data->lock);

> +       if (ret == -EINVAL)

This needs a good comment.

> +               ret  = sca3300_error_handler(sca_data);
> +
> +       return ret;

if (ret != -EINVAL)
  return ret;

return _error_handler(...);

> +}
> +
> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
> +{
> +       int reg_val = 0;
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);
> +       sca_data->txbuf[0] = BIT(7) | (reg << 2);
> +       put_unaligned_be16(val, &sca_data->txbuf[1]);
> +       ret = sca3300_transfer(sca_data, &reg_val);
> +       mutex_unlock(&sca_data->lock);
> +       if (ret == -EINVAL)
> +               ret  = sca3300_error_handler(sca_data);
> +
> +       return ret;
> +}

As per above.

...

> +               for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
> +                       if (val2 == sca3300_accel_scale[i][1]) {

> +                               idx = i;

Redundant variable. Refactor w/o using it. It's easy.

> +                               break;
> +                       }
> +               }
> +               if (idx == -1)
> +                       return -EINVAL;

...

> +               /* freq. change is possible only for mode 3 and 4 */
> +               if (reg_val == 2 && val == sca3300_lp_freq[3])
> +                       return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
> +               else if (reg_val == 3 && val == sca3300_lp_freq[2])
> +                       return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
> +               else
> +                       return -EINVAL;

Two times redundant 'else'

...

> +static irqreturn_t sca3300_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct sca3300_data *data = iio_priv(indio_dev);
> +       int bit, ret, val, i = 0;
> +
> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {
> +               ret = sca3300_read_reg(data, sca3300_channels[bit].address,
> +                                      &val);
> +               if (ret < 0) {
> +                       dev_err(&data->spi->dev,
> +                               "failed to read register, error: %d\n", ret);
> +                       goto out;
> +               }
> +               ((s16 *)data->scan.channels)[i++] = val;
> +       }
> +
> +       iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +                                          iio_get_time_ns(indio_dev));
> +out:
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +

...

> +       ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
> +                               SCA3300_VALUE_SW_RESET);
> +       if (ret != 0)

if (ret)

Everywhere in the code.

> +               return ret;

+ blank line

> +       /* wait at least 1ms after SW-reset command */
> +       usleep_range(1e3, 10e3);

This doesn't make any difference. You may simply drop it and unify the comments.

> +       /* wait 15ms for settling of signal paths */
> +       usleep_range(15e3, 50e3);

...

> +       if (value != SCA3300_DEVICE_ID) {
> +               dev_err(&sca_data->spi->dev,
> +                       "device id not expected value, %d != %u\n",
> +                       value, SCA3300_DEVICE_ID);

> +               return -EIO;

-ENODEV ?

> +       }

...

> +static int sca3300_debugfs_reg_access(struct iio_dev *indio_dev,
> +                                     unsigned int reg, unsigned int writeval,
> +                                     unsigned int *readval)
> +{
> +       struct sca3300_data *data = iio_priv(indio_dev);
> +       int value;
> +       int ret;
> +
> +       if (reg > SCA3300_SELBANK)
> +               return -EINVAL;
> +
> +       if (!readval)
> +               return sca3300_write_reg(data, reg, writeval);

> +       ret = sca3300_read_reg(data, reg, &value);
> +       if (ret < 0)
> +               return ret;

> +       *readval = (unsigned int)value;

While casting?

> +       return 0;
> +}

If you switch to use regmap, the read part will be a bonus automatically.

...

> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sca_data));
> +       if (!indio_dev) {

> +               dev_err(&spi->dev,
> +                       "failed to allocate memory for iio device\n");

Noice. You will get the same from user space.

> +               return -ENOMEM;
> +       }

...

> +       indio_dev->dev.parent = &spi->dev;

This is done by IIO core.

...

> +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret < 0) {
> +               dev_err(&spi->dev, "iio device register failed, error: %d\n",
> +                       ret);

> +               return ret;
> +       }
> +
> +       return 0;

return ret;

> +}

...

> +static const struct of_device_id sca3300_dt_ids[] = {
> +       { .compatible = "murata,sca3300"},
> +       {},

Drop comma. No need for a terminator line.

> +};

...

> +static struct spi_driver sca3300_driver = {
> +       .driver = {
> +               .name           = SCA3300_ALIAS,

> +               .owner          = THIS_MODULE,

Redundant.

> +               .of_match_table = of_match_ptr(sca3300_dt_ids),

Drop of_match_ptr(). In 99% its use is wrong.

> +       },
> +
> +       .probe  = sca3300_probe,
> +};

-- 
With Best Regards,
Andy Shevchenko
