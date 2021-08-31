Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1021A3FCC12
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhHaRK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 13:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhHaRK2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 13:10:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F0C061575;
        Tue, 31 Aug 2021 10:09:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g13so173304lfj.12;
        Tue, 31 Aug 2021 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1SyW4zNF0sMaCr/TWtyUXHYF7HtxO4wuQklBeji5um8=;
        b=SvYYxJ3SofmfEUS2A/u8hySAIjBEKwOQ2SvXXZJvtSyRrVa072YAlhxx7IeiH4sl5F
         tv5SNm6bOSxS9gFAO7TdfpTq8Dhqwej/OvGJfMEHFi+P5thCde63mnt4oBE388GrDgaM
         7J7O4MmIEpdf9CDdPXLONHGRWvWjcdc2OCvvl43YGEBKQyqf5mi2MwZBlgyw6KsU6j+F
         Re5fxpvBq7N13umljJqmpmzvHa/CUegfrRmn7XJX7JHgb0luudRjahbgBaHqg4ugAqr1
         ClJifDQBEGx/OMRxem9ixC2MFdmVSvvOoDUwFPZQX1DdE+bmvj71OjZUuJP9g491b6NM
         Qp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1SyW4zNF0sMaCr/TWtyUXHYF7HtxO4wuQklBeji5um8=;
        b=GK7gMSwJN7jLmQHG6EsipM5tQqAwqYaxRAF8nzdT8QikD7cFl2rlpWd8hFzMZYd2K5
         BzduXD4tolX8WxjQar2EbRKRrsV+XXLZUnyvNYqkn8aTK5EI8uOPtoYAtwivkRui5odC
         bVWLbcShD36o2/kxxXqH5wwXSTjg75UbfCkUhLBCToXDUQxFlOJsUG121UB9VWtztOuZ
         KolV73xRHQ8wmNsEHOW0SxM34PYsC8m/xBbc0y1NABWHYNnu7rgERKGaoYS4kSZxsq1I
         UI751+auRz57zHy4D7Zcm76voavcjHSRd7j4b8Y3dc/BrfRG3JbPVNTp8j1zY8CXDpLQ
         G0Jg==
X-Gm-Message-State: AOAM531OlxGUSRkSCaZ0xxIEj4ZB1zdqkvkji/HIM04tsM3R53H2iKSW
        e7ElcOv/X6NOfiLMIN/ibfxWpE0heIbT0gc53c8=
X-Google-Smtp-Source: ABdhPJzeDMYI9vxvnnVJ2zglOKvp0+27CVcRHTpnj+0aakIf/bCE/UF0iunWCMJkvntNSTxwqTYepzSju8iAEHhsJfI=
X-Received: by 2002:a05:6512:3905:: with SMTP id a5mr22451542lfu.354.1630429770570;
 Tue, 31 Aug 2021 10:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210819181133.15181-1-puranjay12@gmail.com> <20210830161357.782def25@jic23-huawei>
In-Reply-To: <20210830161357.782def25@jic23-huawei>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Tue, 31 Aug 2021 22:39:19 +0530
Message-ID: <CANk7y0jVofBv0U6Ut9cX2=imafpMvXdYS2CjvZXcOJkAukH_VA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: adxl355: Add triggered buffer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 30, 2021 at 8:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 19 Aug 2021 23:41:33 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> > Provide a way for continuous data capture by setting up buffer support. The
> > data ready signal exposed at the DRDY pin of the ADXL355 is exploited as
> > a hardware interrupt which triggers to fill the buffer.
> >
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> Hi Puranjay,
>
> A fresh read and I noticed a few additional things.
> All simple stuff.
>
> I do have a slight concern that we might be setting ourselves up for problems
> once the fifo is enabled.  Hopefully not, but if you have looked at that and
> verified it will drop in nicely then that's great. We might be fine.

Yes, I will work on FIFO and make sure I fix all issues if any arise.

>
> Jonathan
>
>
> > ---
> > Changes since v1:
> > - Fix an indentation issue.
> > - Add comments on layout of data in buffer.
> > - Zero the buffer before using it in trigger handler.
> > - Use if(ret) in place of if(ret < 0)
> > ---
> > drivers/iio/accel/Kconfig        |   4 +
> >  drivers/iio/accel/adxl355_core.c | 162 ++++++++++++++++++++++++++++++-
> >  2 files changed, 164 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index d0c45c809..9c16c1841 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -69,6 +69,8 @@ config ADXL355_I2C
> >       depends on I2C
> >       select ADXL355
> >       select REGMAP_I2C
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> >       help
> >         Say Y here if you want to build i2c support for the Analog Devices
> >         ADXL355 3-axis digital accelerometer.
> > @@ -82,6 +84,8 @@ config ADXL355_SPI
> >       depends on SPI
> >       select ADXL355
> >       select REGMAP_SPI
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> >       help
> >         Say Y here if you want to build spi support for the Analog Devices
> >         ADXL355 3-axis digital accelerometer.
> > diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> > index c91d2254c..d499403dc 100644
> > --- a/drivers/iio/accel/adxl355_core.c
> > +++ b/drivers/iio/accel/adxl355_core.c
> > @@ -9,11 +9,16 @@
> >
> >  #include <linux/bits.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >  #include <linux/limits.h>
> >  #include <linux/math64.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/regmap.h>
> >  #include <asm/unaligned.h>
> >
> > @@ -46,6 +51,7 @@
> >  #define ADXL355_RANGE_REG            0x2C
> >  #define ADXL355_POWER_CTL_REG                0x2D
> >  #define  ADXL355_POWER_CTL_MODE_MSK  GENMASK(1, 0)
> > +#define  ADXL355_POWER_CTL_DRDY_MSK  BIT(2)
> >  #define ADXL355_SELF_TEST_REG                0x2E
> >  #define ADXL355_RESET_REG            0x2F
> >
> > @@ -165,7 +171,15 @@ struct adxl355_data {
> >       enum adxl355_hpf_3db hpf_3db;
> >       int calibbias[3];
> >       int adxl355_hpf_3db_table[7][2];
> > -     u8 transf_buf[3] ____cacheline_aligned;
> > +     struct iio_trigger *dready_trig;
> > +     int irq;
> > +     union {
> > +             u8 transf_buf[3];
> > +             struct {
> > +                     u8 buf[14];
> > +                     s64 ts;
> > +             } buffer;
> > +     } ____cacheline_aligned;
> >  };
> >
> >  static int adxl355_set_op_mode(struct adxl355_data *data,
> > @@ -186,6 +200,23 @@ static int adxl355_set_op_mode(struct adxl355_data *data,
> >       return ret;
> >  }
> >
> > +static int adxl355_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > +                                           bool state)
> > +{
> > +     struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +     struct adxl355_data *data = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     mutex_lock(&data->lock);
>
> Why take the lock?  What are you protecting here?

Power Control Register is the same register that is used to put the
device in measurement mode, so it has to be protected.

>
> > +     ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
> > +                              ADXL355_POWER_CTL_DRDY_MSK,
> > +                              FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK,
> > +                                         !state));
> > +     mutex_unlock(&data->lock);
> > +
> > +     return ret;
> > +}
> > +
> >  static void adxl355_fill_3db_frequency_table(struct adxl355_data *data)
> >  {
> >       u32 multiplier;
> > @@ -246,6 +277,12 @@ static int adxl355_setup(struct adxl355_data *data)
> >       if (ret)
> >               return ret;
> >
> > +     ret = regmap_update_bits(data->regmap, ADXL355_POWER_CTL_REG,
> > +                              ADXL355_POWER_CTL_DRDY_MSK,
> > +                              FIELD_PREP(ADXL355_POWER_CTL_DRDY_MSK, 1));
> > +     if (ret)
> > +             return ret;
> > +
> >       adxl355_fill_3db_frequency_table(data);
> >
> >       return adxl355_set_op_mode(data, ADXL355_MEASUREMENT);
> > @@ -499,12 +536,74 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
> >       }
> >  }
> >
> > +static const unsigned long adxl355_avail_scan_masks[] = {
> > +     GENMASK(3, 0),
> > +     0
> > +};
> > +
> >  static const struct iio_info adxl355_info = {
> >       .read_raw       = adxl355_read_raw,
> >       .write_raw      = adxl355_write_raw,
> >       .read_avail     = &adxl355_read_avail,
> >  };
> >
> > +static const struct iio_trigger_ops adxl355_trigger_ops = {
> > +     .set_trigger_state = &adxl355_data_rdy_trigger_set_state,
> > +     .validate_device = &iio_trigger_validate_own_device,
>
> This is fine for now, but I'd like you to think about whether you can ultimately
> drop this validation and allow other devices to be triggered from this signal.
> It can be very helpful when doing sensor fusion to grab data at (approximately)
> the same time from a set of different sensors.

I will remove this line in the next patch, I will read about this more.

>
> IIRC this device has a fifo though which can complicate that option.
>
> > +};
> > +
> > +static irqreturn_t adxl355_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf = p;
> > +     struct iio_dev *indio_dev = pf->indio_dev;
> > +     struct adxl355_data *data = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     mutex_lock(&data->lock);
> > +
> > +     /*
> > +      * data->buffer is used both for triggered buffer support
> > +      * and read/write_raw(), hence, it has to be zeroed here before usage.
> > +      */
> > +     data->buffer.buf[0] = 0;
> > +
> > +     /*
> > +      * The accelaration data is 24 bits and big endian. It has to be saved
>
> Spell check.  acceleration

Will change in next version.

>
> > +      * in 32 bits, hence, it is saved in the 2nd byte of the 4 byte buffer.
> > +      * The buf array is 14 bytes as it includes 3x4=12 bytes for
> > +      * accelaration data of x, y, and z axis. It also includes 2 bytes for
> > +      * temperature data.
> > +      */
> > +     ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
> > +                            &data->buffer.buf[1], 3);
> > +     if (ret)
> > +             goto out_unlock_notify;
> > +
> > +     ret = regmap_bulk_read(data->regmap, ADXL355_YDATA3_REG,
> > +                            &data->buffer.buf[5], 3);
> > +     if (ret)
> > +             goto out_unlock_notify;
> > +
> > +     ret = regmap_bulk_read(data->regmap, ADXL355_ZDATA3_REG,
> > +                            &data->buffer.buf[9], 3);
> > +     if (ret)
> > +             goto out_unlock_notify;
> > +
> > +     ret = regmap_bulk_read(data->regmap, ADXL355_TEMP2_REG,
> > +                            &data->buffer.buf[12], 2);
> > +     if (ret)
> > +             goto out_unlock_notify;
> > +
> > +     iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> > +                                        pf->timestamp);
> > +
> > +out_unlock_notify:
> > +     mutex_unlock(&data->lock);
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  #define ADXL355_ACCEL_CHANNEL(index, reg, axis) {                    \
> >       .type = IIO_ACCEL,                                              \
> >       .address = reg,                                                 \
> > @@ -518,6 +617,7 @@ static const struct iio_info adxl355_info = {
> >       .info_mask_shared_by_type_available =                           \
> >               BIT(IIO_CHAN_INFO_SAMP_FREQ) |                          \
> >               BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),      \
> > +     .scan_index = index,                                            \
> >       .scan_type = {                                                  \
> >               .sign = 's',                                            \
> >               .realbits = 20,                                         \
> > @@ -537,6 +637,7 @@ static const struct iio_chan_spec adxl355_channels[] = {
> >               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >                                     BIT(IIO_CHAN_INFO_SCALE) |
> >                                     BIT(IIO_CHAN_INFO_OFFSET),
> > +             .scan_index = 3,
> >               .scan_type = {
> >                       .sign = 's',
> >                       .realbits = 12,
> > @@ -544,8 +645,46 @@ static const struct iio_chan_spec adxl355_channels[] = {
> >                       .endianness = IIO_BE,
> >               },
> >       },
> > +     IIO_CHAN_SOFT_TIMESTAMP(4),
> >  };
> >
> > +static int adxl355_probe_trigger(struct iio_dev *indio_dev)
> > +{
> > +     struct adxl355_data *data = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     if (!data->irq) {
> > +             dev_info(data->dev, "no irq, using polling\n");
>
> I would move this check externally so that we never probe if it's
> not wired up.  It's also easy to tell (no trigger available) so
> the dev_info is probably unnecessary noise in the log.

I will remove this in next version.

>
>
> > +             return 0;
> > +     }
> > +
> > +     data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> > +                                                indio_dev->name,
> > +                                                indio_dev->id);
> > +     if (!data->dready_trig)
> > +             return -ENOMEM;
> > +
> > +     data->dready_trig->ops = &adxl355_trigger_ops;
> > +     iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> > +
> > +     ret = devm_request_irq(data->dev, data->irq,
> > +                            &iio_trigger_generic_data_rdy_poll,
> > +                            IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
> > +     if (ret)
> > +             return dev_err_probe(data->dev, ret, "request irq %d failed\n",
> > +                                  data->irq);
> > +
> > +     ret = devm_iio_trigger_register(data->dev, data->dready_trig);
> > +     if (ret) {
> > +             dev_err(data->dev, "iio trigger register failed\n");
> > +             return ret;
> > +     }
> > +
> > +     indio_dev->trig = iio_trigger_get(data->dready_trig);
> > +
> > +     return 0;
> > +}
> > +
> >  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> >                      const char *name)
> >  {
> > @@ -563,18 +702,37 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> >       data->op_mode = ADXL355_STANDBY;
> >       mutex_init(&data->lock);
> >
> > +     /*
> > +      * TODO: Would be good to move it to the generic version.
> > +      */
> > +     ret = of_irq_get_byname(dev->of_node, "DRDY");
> > +     if (ret > 0)
> > +             data->irq = ret;
>
> If you do this get down near the probe_trigger() call then you should be able to
> avoid keeping a copy of irq in data.  Just pass it into that function as
> a parameter.

ok, I will change it in next version.

>
> > +
> >       indio_dev->name = name;
> >       indio_dev->info = &adxl355_info;
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> >       indio_dev->channels = adxl355_channels;
> >       indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
> > +     indio_dev->available_scan_masks = adxl355_avail_scan_masks;
> >
> >       ret = adxl355_setup(data);
> > -     if (ret < 0) {
> > +     if (ret) {
>
> This looks to be an unrelated cleanup.  Please move to a precursor patch as
> it adds noise in this one which is fiddly enough without it ;)

ok, I will make a separate patch for this and send a series.

>
> >               dev_err(dev, "ADXL355 setup failed\n");
> >               return ret;
> >       }
> >
> > +     ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +                                           &iio_pollfunc_store_time,
> > +                                           &adxl355_trigger_handler, NULL);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "iio triggered buffer setup failed\n");
> > +
> > +     ret = adxl355_probe_trigger(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       return devm_iio_device_register(dev, indio_dev);
> >  }
> >  EXPORT_SYMBOL_GPL(adxl355_core_probe);
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
