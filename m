Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1025C120
	for <lists+linux-iio@lfdr.de>; Thu,  3 Sep 2020 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgICMh4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Sep 2020 08:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgICMhN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Sep 2020 08:37:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01ADC061246;
        Thu,  3 Sep 2020 05:37:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t20so1707988qtr.8;
        Thu, 03 Sep 2020 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMVMEkr/RipXmaA+3zIhhNn5aP6PdeOloXggf/OmI70=;
        b=Kt6aI/dTiZzwxK2/aGXfMGCSmM433yAX+JCeLqUo+Pfbct5XaJrgQ8Bd/TDsYPD+2x
         oRgdyQb8NqIIGRvYT3U38MYVmzNTpsUtYNQI6mNhJ9KwFvXX1mHA+lR0oH+QBSiMZeSJ
         7oBrpk0qm2Np/4NtqfF3myLANewMnutwaKIM7CTjdOULSNmVTWqvkIYKK7P4kxcKf6NU
         XagE6AmiP72uX5ZpH+OxvpzVO043Gt4+6Hzu393XqXbrwNAabLGEgJkeJD7CFP73mG70
         LqKg4YILsDUd4v0maRcQA84Bc54sDk/bEn5rVcwURkCOB2tjRWhaPCXTHoSd7S67lnjj
         K+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMVMEkr/RipXmaA+3zIhhNn5aP6PdeOloXggf/OmI70=;
        b=L2KE+qSVolxQ7OeZ2miCL2me1mUtyYSeQYJeboFoZIHt5RvYrV0x6/ISI45IMigeem
         iaWzpk6jjMpIICw2t8La9C56mnpuSV9lniV36qxpQrt9oD3AHPXgi0jr5sfXhmKS+aEx
         oEpwW4O4vfrNQW/xn4uocW727pflc1KRMiSQMBixjmyzq8YiEftamwMR7/C0Cfa518gM
         YMbG/0OWS/lrHE6Ir01VwDgl0BZ8tg7mHBnqRohMsJW4z2hcvkmYPGfSJUZbP7c/nGge
         tJ0foFZ53cXtknQ3CDDECsnp16S4jEv+/BQM5btRJ6zRfsB14nXvhwCFgLVroU9i96f3
         +mrw==
X-Gm-Message-State: AOAM532Xr7UxPziEDYymZ1MYXGpDw3wyQ7Y3pD/SBmwEkckF/ORZWF/V
        6cmP6L9yiiU3WHftSTgMIGJ32lB2YzDuRHZpO9A=
X-Google-Smtp-Source: ABdhPJwZKu8yEZ2mkqUZLKYEz2AziBJLea75QqpVsad2ySB3Xfzrov49iXgp88JpAJ8Bb3dxkTRfknK2GpegnH6/010=
X-Received: by 2002:aed:2212:: with SMTP id n18mr3266189qtc.346.1599136631983;
 Thu, 03 Sep 2020 05:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
 <20200825124711.11455-2-nish.malpani25@gmail.com> <20200829174623.422f7e7d@archlinux>
In-Reply-To: <20200829174623.422f7e7d@archlinux>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Date:   Thu, 3 Sep 2020 18:07:00 +0530
Message-ID: <CAEtfd9aB2jphW=x80iZ_vHJmLUGrn-SSCom0NHWbgLH3YnGOpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: gyro: adxrs290: Add triggered buffer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        Darius <darius.berghe@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Nishant Malpani <nish.malpani25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Thanks for the review, Jonathan. Comments inline...

On Sat, Aug 29, 2020 at 10:16 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 25 Aug 2020 18:17:09 +0530
> Nishant Malpani <nish.malpani25@gmail.com> wrote:
>
> > Provide a way for continuous data capture by setting up buffer support. The
> > data ready signal exposed at the SYNC pin of the ADXRS290 is exploited as
> > a hardware interrupt which triggers to fill the buffer.
> >
> > Triggered buffer setup was tested with both hardware trigger (DATA_RDY) and
> > software triggers (sysfs-trig & hrtimer).
> >
> > Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
>
> I've tried not to overlap with Andy's comments but might have hit on a few.
> Anyhow, comments inline.
>
> Jonathan
>
>
> > ---
> >  drivers/iio/gyro/Kconfig    |   2 +
> >  drivers/iio/gyro/adxrs290.c | 272 ++++++++++++++++++++++++++++++++++--
> >  2 files changed, 260 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> > index 024a34139875..5824f2edf975 100644
> > --- a/drivers/iio/gyro/Kconfig
> > +++ b/drivers/iio/gyro/Kconfig
> > @@ -44,6 +44,8 @@ config ADIS16260
> >  config ADXRS290
> >       tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
> >       depends on SPI
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> >       help
> >         Say yes here to build support for Analog Devices ADXRS290 programmable
> >         digital output gyroscope.
> > diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> > index ff989536d2fb..25046590761e 100644
> > --- a/drivers/iio/gyro/adxrs290.c
> > +++ b/drivers/iio/gyro/adxrs290.c
> > @@ -13,8 +13,12 @@
> >  #include <linux/module.h>
> >  #include <linux/spi/spi.h>
> >
> > +#include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >
> >  #define ADXRS290_ADI_ID              0xAD
> >  #define ADXRS290_MEMS_ID     0x1D
> > @@ -35,7 +39,9 @@
> >  #define ADXRS290_READ                BIT(7)
> >  #define ADXRS290_TSM         BIT(0)
> >  #define ADXRS290_MEASUREMENT BIT(1)
> > -#define ADXRS290_SYNC                GENMASK(1, 0)
> > +#define ADXRS290_DATA_RDY_OUT        BIT(0)
> > +#define ADXRS290_SYNC_MASK   GENMASK(1, 0)
> > +#define ADXRS290_SYNC(x)     FIELD_PREP(ADXRS290_SYNC_MASK, x)
> >  #define ADXRS290_LPF_MASK    GENMASK(2, 0)
> >  #define ADXRS290_LPF(x)              FIELD_PREP(ADXRS290_LPF_MASK, x)
> >  #define ADXRS290_HPF_MASK    GENMASK(7, 4)
> > @@ -50,6 +56,13 @@ enum adxrs290_mode {
> >       ADXRS290_MODE_MEASUREMENT,
> >  };
> >
> > +enum adxrs290_scan_index {
> > +     ADXRS290_IDX_X,
> > +     ADXRS290_IDX_Y,
> > +     ADXRS290_IDX_TEMP,
> > +     ADXRS290_IDX_TS,
> > +};
> > +
> >  struct adxrs290_state {
> >       struct spi_device       *spi;
> >       /* Serialize reads and their subsequent processing */
> > @@ -57,6 +70,12 @@ struct adxrs290_state {
> >       enum adxrs290_mode      mode;
> >       unsigned int            lpf_3db_freq_idx;
> >       unsigned int            hpf_3db_freq_idx;
> > +     struct iio_trigger      *dready_trig;
> > +     /* Ensure correct alignment of timestamp when present */
> > +     struct {
> > +             s16 channels[3];
> > +             s64 ts __aligned(8);
> > +     }                       buffer;
>         } buffer;
>
> I can see why you did the alignment like you have, but it looks really odd
> in this case.
>

I thought so too. Will fix it in v2.

> >  };
> >
>
> ...
>
> >
> > +static void adxrs290_chip_off_action(void *data)
> > +{
> > +     struct iio_dev *indio_dev = data;
> > +
> > +     adxrs290_set_mode(indio_dev, ADXRS290_MODE_STANDBY);
> > +}
> > +
> >  static int adxrs290_read_raw(struct iio_dev *indio_dev,
> >                            struct iio_chan_spec const *chan,
> >                            int *val,
> > @@ -215,24 +287,34 @@ static int adxrs290_read_raw(struct iio_dev *indio_dev,
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> > +             ret = iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +
> >               switch (chan->type) {
> >               case IIO_ANGL_VEL:
> >                       ret = adxrs290_get_rate_data(indio_dev,
> >                                                    ADXRS290_READ_REG(chan->address),
> >                                                    val);
> >                       if (ret < 0)
> > -                             return ret;
> > +                             goto err_release;
> >
> > -                     return IIO_VAL_INT;
> > +                     ret = IIO_VAL_INT;
> > +                     break;
> >               case IIO_TEMP:
> >                       ret = adxrs290_get_temp_data(indio_dev, val);
> >                       if (ret < 0)
> > -                             return ret;
> > +                             goto err_release;
> >
> > -                     return IIO_VAL_INT;
> > +                     ret = IIO_VAL_INT;
> > +                     break;
> >               default:
> > -                     return -EINVAL;
> > +                     ret = -EINVAL;
> > +                     break;
> >               }
> > +err_release:
> > +             iio_device_release_direct_mode(indio_dev);
> > +             return ret;
> >       case IIO_CHAN_INFO_SCALE:
> >               switch (chan->type) {
> >               case IIO_ANGL_VEL:
> > @@ -279,34 +361,53 @@ static int adxrs290_write_raw(struct iio_dev *indio_dev,
> >                             long mask)
> >  {
> >       struct adxrs290_state *st = iio_priv(indio_dev);
> > -     int lpf_idx, hpf_idx;
> > +     int ret, lpf_idx, hpf_idx;
> > +
> > +     ret = iio_device_claim_direct_mode(indio_dev);
>
> Is there anything in the datasheet that says we can't change the filters
> whilst doing captures?  Might get crazy data but if the datasheet doesn't
> want against a particular action, then we tend not to try and prevent it.
>

The datasheet, to my knowledge, explicitly doesn't mention any
restriction on changing the filter settings during a capture.

Quoting the datasheet, "The group delay of the wideband filter option
is less than 0.5ms" (pg. 11) - during an ongoing capture if one
re-configures the filter, how do we address this?

> > +     if (ret)
> > +             return ret;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> >               lpf_idx = adxrs290_find_match(adxrs290_lpf_3db_freq_hz_table,
> >                                             ARRAY_SIZE(adxrs290_lpf_3db_freq_hz_table),
> >                                             val, val2);
> > -             if (lpf_idx < 0)
> > -                     return -EINVAL;
> > +             if (lpf_idx < 0) {
> > +                     ret = -EINVAL;
> > +                     goto err_release;
> > +             }
> > +
> >               /* caching the updated state of the low-pass filter */
> >               st->lpf_3db_freq_idx = lpf_idx;
> >               /* retrieving the current state of the high-pass filter */
> >               hpf_idx = st->hpf_3db_freq_idx;
> > -             return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +             ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +             break;
> > +
> >       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> >               hpf_idx = adxrs290_find_match(adxrs290_hpf_3db_freq_hz_table,
> >                                             ARRAY_SIZE(adxrs290_hpf_3db_freq_hz_table),
> >                                             val, val2);
> > -             if (hpf_idx < 0)
> > -                     return -EINVAL;
> > +             if (hpf_idx < 0) {
> > +                     ret = -EINVAL;
> > +                     goto err_release;
> > +             }
> > +
> >               /* caching the updated state of the high-pass filter */
> >               st->hpf_3db_freq_idx = hpf_idx;
> >               /* retrieving the current state of the low-pass filter */
> >               lpf_idx = st->lpf_3db_freq_idx;
> > -             return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +             ret = adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
> > +             break;
> > +
> > +     default:
> > +             ret = -EINVAL;
> > +             break;
> >       }
> >
> > -     return -EINVAL;
> > +err_release:
> I think Andy may have mentioned this, but a break would work just as well
> to get you here
>

Agreed. Will refactor accordingly in v2.

> > +     iio_device_release_direct_mode(indio_dev);
> > +     return ret;
> >  }
> >
> >  static int adxrs290_read_avail(struct iio_dev *indio_dev,
> > @@ -334,6 +435,68 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
> >       }
> >  }
> >
> > +static int adxrs290_data_rdy_trigger_set_state(struct iio_trigger *trig, bool state)
> > +{
> > +     struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +     struct adxrs290_state *st = iio_priv(indio_dev);
> > +     int ret;
> > +     u8 val;
> > +
> > +     val = (state ? ADXRS290_SYNC(ADXRS290_DATA_RDY_OUT) : 0);
>
> Why the outer set of brackets?
>

I now realize those are unnecessary and probably violate the kernel
coding-style. Will remove those in v2.

> > +
> > +     ret = adxrs290_spi_write_reg(st->spi, ADXRS290_REG_DATA_RDY, val);
> > +     if (ret < 0)
> > +             dev_err(&st->spi->dev, "failed to start data ready interrupt\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static int adxrs290_reset_trig(struct iio_trigger *trig)
> > +{
> > +     struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +     int val;
> > +
> > +     /*
> > +      * Data ready interrupt is reset after a read of the data registers.
> > +      * Here, we only read the 16b DATAY registers as that marks the end of
> > +      * a read of the data registers and initiates a reset for the interrupt line.
> > +      */
> > +     return adxrs290_get_rate_data(indio_dev, ADXRS290_READ_REG(ADXRS290_REG_DATAY0), &val);
>
> We have a bug around this at the moment btw.
>
> A try_reenable callback shouldn't return an error.  The return value is
> meant to indicate that we need to go round again or not
> (though that's broken currently anwyay). Hence safer to just not
> return errors.
>
> return 0;
>

Right, I forgot about the recent conversations on the mailing list
about this; thanks for pointing out again. Will fix this in v2.

> > +}
> > +
> > +static const struct iio_trigger_ops adxrs290_trigger_ops = {
> > +     .set_trigger_state = &adxrs290_data_rdy_trigger_set_state,
> > +     .validate_device = &iio_trigger_validate_own_device,
> > +     .try_reenable = &adxrs290_reset_trig,
> > +};
> > +
> > +static irqreturn_t adxrs290_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf = p;
> > +     struct iio_dev *indio_dev = pf->indio_dev;
> > +     struct adxrs290_state *st = iio_priv(indio_dev);
> > +     struct spi_device *spi = st->spi;
>
> As you only use spi once, I'd just use st->spi inline.
>

Okay.

> > +     u8 tx = ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
> > +     int ret;
> > +
> > +     mutex_lock(&st->lock);
> > +
> > +     /* exercise a bulk data capture starting from reg DATAX0... */
> > +     ret = spi_write_then_read(spi, &tx, sizeof(tx), st->buffer.channels,
> > +                               sizeof(st->buffer.channels));
> > +     if (ret < 0)
> > +             goto done;
> > +
> > +     iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> > +                                        pf->timestamp);
> > +
> > +done:
> > +     mutex_unlock(&st->lock);
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  #define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {                               \
> >       .type = IIO_ANGL_VEL,                                           \
> >       .address = reg,                                                 \
> > @@ -346,6 +509,13 @@ static int adxrs290_read_avail(struct iio_dev *indio_dev,
> >       .info_mask_shared_by_type_available =                           \
> >       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |              \
> >       BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),              \
> > +     .scan_index = ADXRS290_IDX_##axis,                              \
> > +     .scan_type = {                                                  \
> > +             .sign = 's',                                            \
> > +             .realbits = 16,                                         \
> > +             .storagebits = 16,                                      \
> > +             .endianness = IIO_LE,                                   \
> > +     },                                                              \
> >  }
> >
> >  static const struct iio_chan_spec adxrs290_channels[] = {
> > @@ -356,7 +526,21 @@ static const struct iio_chan_spec adxrs290_channels[] = {
> >               .address = ADXRS290_REG_TEMP0,
> >               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >               BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index = ADXRS290_IDX_TEMP,
> > +             .scan_type = {
> > +                     .sign = 's',
> > +                     .realbits = 12,
> > +                     .storagebits = 16,
> > +                     .shift = 0,
>
> No need to specify shift if it is 0 as that's the obvious default.
>

Got it.

> > +                     .endianness = IIO_LE,
> > +             },
> >       },
> > +     IIO_CHAN_SOFT_TIMESTAMP(ADXRS290_IDX_TS),
> > +};
> > +
> > +static const unsigned long adxrs290_avail_scan_masks[] = {
> > +     BIT(ADXRS290_IDX_X) | BIT(ADXRS290_IDX_Y) | BIT(ADXRS290_IDX_TEMP),
> > +     0
> >  };
> >
> >  static const struct iio_info adxrs290_info = {
> > @@ -365,6 +549,47 @@ static const struct iio_info adxrs290_info = {
> >       .read_avail = &adxrs290_read_avail,
> >  };
> >
> > +static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
> > +{
> > +     struct adxrs290_state *st = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     if (!st->spi->irq) {
> > +             dev_info(&st->spi->dev, "no irq, using polling\n");
> > +             return 0;
> > +     }
> > +
> > +     st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
> > +                                              "%s-dev%d",
> > +                                              indio_dev->name,
> > +                                              indio_dev->id);
>
> As below, this could be sensibly done on fewer lines without any real loss
> of readability (staying under advised 80 chars)
>

Sure, will re-align in v2.

> > +     if (!st->dready_trig)
> > +             return -ENOMEM;
> > +
> > +     st->dready_trig->dev.parent = &st->spi->dev;
> > +     st->dready_trig->ops = &adxrs290_trigger_ops;
> > +     iio_trigger_set_drvdata(st->dready_trig, indio_dev);
> > +
> > +     ret = devm_request_irq(&st->spi->dev, st->spi->irq,
> > +                            &iio_trigger_generic_data_rdy_poll,
> > +                            IRQF_ONESHOT,
> > +                            "adxrs290_irq", st->dready_trig);
> > +     if (ret < 0) {
> > +             dev_err(&st->spi->dev, "request irq %d failed\n", st->spi->irq);
> > +             return ret;
> > +     }
> > +
> > +     ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
> > +     if (ret) {
> > +             dev_err(&st->spi->dev, "iio trigger register failed\n");
> > +             return ret;
> > +     }
> > +
> > +     indio_dev->trig = iio_trigger_get(st->dready_trig);
> > +
> > +     return 0;
> > +}
> > +
> >  static int adxrs290_probe(struct spi_device *spi)
> >  {
> >       struct iio_dev *indio_dev;
> > @@ -384,6 +609,7 @@ static int adxrs290_probe(struct spi_device *spi)
> >       indio_dev->channels = adxrs290_channels;
> >       indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
> >       indio_dev->info = &adxrs290_info;
> > +     indio_dev->available_scan_masks = adxrs290_avail_scan_masks;
> >
> >       mutex_init(&st->lock);
> >
> > @@ -416,6 +642,12 @@ static int adxrs290_probe(struct spi_device *spi)
> >       /* max transition time to measurement mode */
> >       msleep(ADXRS290_MAX_TRANSITION_TIME_MS);
> >
> > +     ret = devm_add_action_or_reset(&spi->dev,
> > +                                    adxrs290_chip_off_action,
> > +                                    indio_dev);
>
> What is this unwinding?  We should only be using devm to undo things
> that have been 'done' in probe and the association should be clear.
>

This unwinding is for placing the device **back** to its default
'STANDBY' mode. The device, during the probe, was put to 'MEASUREMENT'
mode during 'adxrs290_initial_setup()' a few lines back.

How else do you suggest I highlight the association?

> You have been a bit in consistent with wrapping.  Personally I would
> go for as many parameters as fit on each line under 80 chars as possible.
> The only exception being when there is some clear 'pairing' of parameters
> or similar.
>

Yes, I realize that, sorry. Will fix wherever necessary in v2.

With regards,
Nishant Malpani

> > +     if (ret < 0)
> > +             return ret;
> > +
> >       ret = adxrs290_get_3db_freq(indio_dev, &val, &val2);
> >       if (ret < 0)
> >               return ret;
> > @@ -423,6 +655,18 @@ static int adxrs290_probe(struct spi_device *spi)
> >       st->lpf_3db_freq_idx = val;
> >       st->hpf_3db_freq_idx = val2;
> >
> > +     ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > +                                           &iio_pollfunc_store_time,
> > +                                           &adxrs290_trigger_handler, NULL);
> > +     if (ret < 0) {
> > +             dev_err(&spi->dev, "iio triggered buffer setup failed\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = adxrs290_probe_trigger(indio_dev);
> > +     if (ret < 0)
> > +             return ret;
> > +
> >       return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> >
>
