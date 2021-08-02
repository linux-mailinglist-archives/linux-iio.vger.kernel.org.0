Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7944F3DDE49
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhHBRQk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHBRQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 13:16:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3854C06175F;
        Mon,  2 Aug 2021 10:16:30 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso5946950ota.13;
        Mon, 02 Aug 2021 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXqGzBuimOEHoQJy1thzoAl5IGIx0JTJbkpTuUYV1Bc=;
        b=Hwym+8axpud0bZABTXdKp66NL1mEheA+LOzjXjhCGpaytvwRt6kg1OjFM9IzCrK6Ws
         gw6yClJbfybxEkcOUhcfbVouCzAvdSA4v49gcBqsrJAIGKLpNOiEdf07R5/Ftm8gQiQ7
         VCXhulUBr2JkaTJRXDyinwyzsErUgnjtUm2sl2sUwpcwWXOGrWMdq1ksCGtHCxbuNIzx
         RITRVDHqhCPQ6L4Mw4QYF3ZqmDx0uRMknr26TSFAhtrnwB0W1yznyYM8r7uPWifWO+El
         +C7aX4d7hr+Eje1Cw8r0E7Is+Utrfv6H0wgBCBCsCRx/vSTEywjRnafBQ3CJPOt85Y7C
         EmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXqGzBuimOEHoQJy1thzoAl5IGIx0JTJbkpTuUYV1Bc=;
        b=rQ2tViwkNkSuGlZlusYYkPZIiNbadLMWCx0AFkbgMWsgs4VE73kPtsg50NaOh5My/f
         jbwcnKIFRBhfqHkGqqLsGnaaFQ8UcpLu5uBhc4Vdxj24dR2iZFgmQLaUFg/quafQkGzO
         ATRGXkNOgi4WMVjAvP78IP0Q7eGkxAgONzN4lVIS9sgmS29UolWeNZNFGVsw56idLCF7
         oHKlefo7gOu/N3Lt9fZNtLDCfaNJT/BSqJxTv2Q2T5UpgzLDPDzpg3U5ic4aJjR+H3H7
         qvdyY6ZL1Oe25JNAWFfd5zZbwc8BdfGgZZs2OdHSSxdh2FH/3zU5NNGSqIBucFi4w60Y
         w1fQ==
X-Gm-Message-State: AOAM530tHe61SrDHIS3sQc95aKexItYJ9TUdf8HoMuY+PSaAqA47woP+
        GsMVUbMveSDiufCgVCTHN1D0A8vomocr5Ndnaig=
X-Google-Smtp-Source: ABdhPJyA0A7h8GKGTG0FmnFbDTN9ZWmqtr0Bn7yoE1wCCjjG24r6djwXeLMegP6rZAYeoNJgZf9z40Qs6HyhWLAXZ2g=
X-Received: by 2002:a9d:6754:: with SMTP id w20mr12574047otm.252.1627924589516;
 Mon, 02 Aug 2021 10:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627709571.git.lucas.p.stankus@gmail.com>
 <8f13da2603ebede1c8c2d89f4ec2d9900a331250.1627709571.git.lucas.p.stankus@gmail.com>
 <20210801191210.19044c90@jic23-huawei>
In-Reply-To: <20210801191210.19044c90@jic23-huawei>
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
Date:   Mon, 2 Aug 2021 14:15:53 -0300
Message-ID: <CACKVXZD9nnAYb1bHNp32dzoGE3xnBPd6NR=9PNXkPVBSaPpaKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: accel: Add driver support for ADXL313
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        robh+dt@kernel.org, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Berghe, Darius" <Darius.Berghe@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Aug 1, 2021 at 3:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 31 Jul 2021 17:36:48 -0300
> Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> > ADXL313 is a small, thin, low power, 3-axis accelerometer with high
> > resolution measurement up to +/-4g. It includes an integrated 32-level
> > FIFO and has activity and inactivity sensing capabilities.
> >
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
>
> Very nice.  A few really minor things inline.
>
> Jonathan
>

Thanks for the feedback!

I'll change the minor things for the v2.

> > ---
> >  MAINTAINERS                      |   9 +
> >  drivers/iio/accel/Kconfig        |  29 +++
> >  drivers/iio/accel/Makefile       |   3 +
> >  drivers/iio/accel/adxl313.h      |  60 ++++++
> >  drivers/iio/accel/adxl313_core.c | 323 +++++++++++++++++++++++++++++++
> >  drivers/iio/accel/adxl313_i2c.c  |  65 +++++++
> >  drivers/iio/accel/adxl313_spi.c  |  74 +++++++
> >  7 files changed, 563 insertions(+)
> >  create mode 100644 drivers/iio/accel/adxl313.h
> >  create mode 100644 drivers/iio/accel/adxl313_core.c
> >  create mode 100644 drivers/iio/accel/adxl313_i2c.c
> >  create mode 100644 drivers/iio/accel/adxl313_spi.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a61f4f3b78a9..1fc88723e632 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -585,6 +585,15 @@ L:       platform-driver-x86@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/platform/x86/adv_swbutton.c
> >
> > +ADXL313 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
> > +M:   Lucas Stankus <lucas.p.stankus@gmail.com>
> > +S:   Supported
> > +F:   Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> > +F:   drivers/iio/accel/adxl313.h
> > +F:   drivers/iio/accel/adxl313_core.c
> > +F:   drivers/iio/accel/adxl313_i2c.c
> > +F:   drivers/iio/accel/adxl313_spi.c
> > +
> >  ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
> >  M:   Michael Hennerich <michael.hennerich@analog.com>
> >  S:   Supported
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 0e56ace61103..ae621532e716 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -30,6 +30,35 @@ config ADIS16209
> >         To compile this driver as a module, say M here: the module will be
> >         called adis16209.
> >
> > +config ADXL313
> > +     tristate
> > +
> > +config ADXL313_I2C
> > +     tristate "Analog Devices ADXL313 3-Axis Digital Accelerometer I2C Driver"
> > +     depends on I2C
> > +     select ADXL313
> > +     select REGMAP_I2C
> > +     help
> > +       Say Y here if you want to build i2c support for the Analog Devices
> > +       ADXL313 3-axis digital accelerometer.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called adxl313_i2c and you will also get adxl313_core
> > +       for the core module.
> > +
> > +config ADXL313_SPI
> > +     tristate "Analog Devices ADXL313 3-Axis Digital Accelerometer SPI Driver"
> > +     depends on SPI
> > +     select ADXL313
> > +     select REGMAP_SPI
> > +     help
> > +       Say Y here if you want to build spi support for the Analog Devices
> > +       ADXL313 3-axis digital accelerometer.
> > +
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called adxl313_spi and you will also get adxl313_core
> > +       for the core module.
> > +
> >  config ADXL345
> >       tristate
> >
> > diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> > index 89280e823bcd..fadc92816e24 100644
> > --- a/drivers/iio/accel/Makefile
> > +++ b/drivers/iio/accel/Makefile
> > @@ -6,6 +6,9 @@
> >  # When adding new entries keep the list in alphabetical order
> >  obj-$(CONFIG_ADIS16201) += adis16201.o
> >  obj-$(CONFIG_ADIS16209) += adis16209.o
> > +obj-$(CONFIG_ADXL313) += adxl313_core.o
> > +obj-$(CONFIG_ADXL313_I2C) += adxl313_i2c.o
> > +obj-$(CONFIG_ADXL313_SPI) += adxl313_spi.o
> >  obj-$(CONFIG_ADXL345) += adxl345_core.o
> >  obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
> >  obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> > diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> > new file mode 100644
> > index 000000000000..72f268e02a80
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl313.h
> > @@ -0,0 +1,60 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * ADXL313 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> > + */
> > +
> > +#ifndef _ADXL313_H_
> > +#define _ADXL313_H_
> > +
> > +/* ADXL313 register definitions */
>
> If these are only used in the c file, push them down there. Better to
> keep what is in the header to absolute minimum.
> however I suggest below moving some of this so that won't be true any more,
> so maybe you do want to keep them here!
>

Only some of them would be called from the _spi.c file, but I think
I'll keep them here to have them all at the same place.

>
> > +#define ADXL313_REG_DEVID0           0x00
> > +#define ADXL313_REG_DEVID1           0x01
> > +#define ADXL313_REG_PARTID           0x02
> > +#define ADXL313_REG_XID                      0x04
> > +#define ADXL313_REG_SOFT_RESET               0x18
> > +#define ADXL313_REG_OFS_AXIS(index)  (0x1E + (index))
> > +#define ADXL313_REG_THRESH_ACT               0x24
> > +#define ADXL313_REG_ACT_INACT_CTL    0x27
> > +#define ADXL313_REG_BW_RATE          0x2C
> > +#define ADXL313_REG_POWER_CTL                0x2D
> > +#define ADXL313_REG_INT_MAP          0x2F
> > +#define ADXL313_REG_DATA_FORMAT              0x31
> > +#define ADXL313_REG_DATAX            0x32
> > +#define ADXL313_REG_DATAY            0x34
> > +#define ADXL313_REG_DATAZ            0x36
> > +#define ADXL313_REG_FIFO_CTL         0x38
> > +#define ADXL313_REG_FIFO_STATUS              0x39
> > +
> > +#define ADXL313_DEVID0                       0xAD
> > +#define ADXL313_DEVID1                       0x1D
> > +#define ADXL313_PARTID                       0xCB
> > +#define ADXL313_SOFT_RESET           0x52
> > +
> > +#define ADXL313_RATE_MSK             GENMASK(3, 0)
> > +#define ADXL313_RATE_BASE            6
> > +
> > +#define ADXL313_POWER_CTL_MSK                GENMASK(3, 2)
> > +#define ADXL313_MEASUREMENT_MODE     BIT(3)
> > +
> > +#define ADXL313_RANGE_MSK            GENMASK(1, 0)
> > +#define ADXL313_RANGE_4G             3
> > +
> > +#define ADXL313_FULL_RES             BIT(3)
> > +#define ADXL313_SPI_3WIRE            BIT(6)
> > +#define ADXL313_I2C_DISABLE          BIT(6)
> > +
> > +/*
> > + * Scale for any g range is given in datasheet as
> > + * 1024 LSB/g = 0.0009765625 * 9.80665 = 0.009576806640625 m/s^2
> > + */
> > +#define ADXL313_NSCALE 9576806
> > +
> > +extern const struct regmap_access_table adxl313_readable_regs_table;
> > +
> > +extern const struct regmap_access_table adxl313_writable_regs_table;
> > +
> > +int adxl313_core_probe(struct device *dev, struct regmap *regmap,
> > +                    const char *name);
> > +#endif /* _ADXL313_H_ */
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> > new file mode 100644
> > index 000000000000..76382ab4f0f4
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -0,0 +1,323 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ADXL313 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> > + *
> > + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "adxl313.h"
> > +
> > +const struct regmap_range adxl313_readable_reg_range[] = {
> > +     regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_XID),
> > +     regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> > +     regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > +     regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> > +     regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_FIFO_STATUS)
> > +};
> > +
> > +const struct regmap_access_table adxl313_readable_regs_table = {
> > +     .yes_ranges = adxl313_readable_reg_range,
> > +     .n_yes_ranges = ARRAY_SIZE(adxl313_readable_reg_range)
> > +};
> > +EXPORT_SYMBOL_GPL(adxl313_readable_regs_table);
> > +
> > +const struct regmap_range adxl313_writable_reg_range[] = {
> > +     regmap_reg_range(ADXL313_REG_SOFT_RESET, ADXL313_REG_SOFT_RESET),
> > +     regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
> > +     regmap_reg_range(ADXL313_REG_THRESH_ACT, ADXL313_REG_ACT_INACT_CTL),
> > +     regmap_reg_range(ADXL313_REG_BW_RATE, ADXL313_REG_INT_MAP),
> > +     regmap_reg_range(ADXL313_REG_DATA_FORMAT, ADXL313_REG_DATA_FORMAT),
> > +     regmap_reg_range(ADXL313_REG_FIFO_CTL, ADXL313_REG_FIFO_CTL)
> > +};
> > +
> > +const struct regmap_access_table adxl313_writable_regs_table = {
> > +     .yes_ranges = adxl313_writable_reg_range,
> > +     .n_yes_ranges = ARRAY_SIZE(adxl313_writable_reg_range)
> > +};
> > +EXPORT_SYMBOL_GPL(adxl313_writable_regs_table);
> > +
> > +struct adxl313_data {
> > +     struct regmap   *regmap;
> > +     struct mutex    lock; /* lock to protect transf_buf */
> > +     __le16          transf_buf ____cacheline_aligned;
> > +};
> > +
> > +static const int adxl313_odr_freqs[][2] = {
> > +     [0] = { 6, 250000 },
> > +     [1] = { 12, 500000 },
> > +     [2] = { 25, 0 },
> > +     [3] = { 50, 0 },
> > +     [4] = { 100, 0 },
> > +     [5] = { 200, 0 },
> > +     [6] = { 400, 0 },
> > +     [7] = { 800, 0 },
> > +     [8] = { 1600, 0 },
> > +     [9] = { 3200, 0 },
> > +};
> > +
> > +#define ADXL313_ACCEL_CHANNEL(index, addr, axis) {                   \
> > +     .type = IIO_ACCEL,                                              \
> > +     .address = addr,                                                \
> > +     .modified = 1,                                                  \
> > +     .channel2 = IIO_MOD_##axis,                                     \
> > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                  \
> > +                           BIT(IIO_CHAN_INFO_CALIBBIAS),             \
> > +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |          \
> > +                                 BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
> > +     .info_mask_shared_by_type_available =                           \
> > +             BIT(IIO_CHAN_INFO_SAMP_FREQ),                           \
> > +     .scan_index = index,                                            \
> > +     .scan_type = {                                                  \
> > +             .sign = 's',                                            \
> > +             .realbits = 13,                                         \
> > +             .storagebits = 16,                                      \
> > +             .endianness = IIO_LE,                                   \
> > +     },                                                              \
> > +}
> > +
> > +static const struct iio_chan_spec adxl313_channels[] = {
> > +     ADXL313_ACCEL_CHANNEL(0, ADXL313_REG_DATAX, X),
> > +     ADXL313_ACCEL_CHANNEL(1, ADXL313_REG_DATAY, Y),
> > +     ADXL313_ACCEL_CHANNEL(2, ADXL313_REG_DATAZ, Z),
> > +};
> > +
> > +static int adxl313_set_odr(struct adxl313_data *data,
> > +                        unsigned int freq1, unsigned int freq2)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(adxl313_odr_freqs); i++) {
> > +             if (adxl313_odr_freqs[i][0] == freq1 &&
> > +                 adxl313_odr_freqs[i][1] == freq2)
> > +                     break;
> > +     }
> > +
> > +     if (i == ARRAY_SIZE(adxl313_odr_freqs))
> > +             return -EINVAL;
> > +
> > +     return regmap_update_bits(data->regmap, ADXL313_REG_BW_RATE,
> > +                               ADXL313_RATE_MSK,
> > +                               FIELD_PREP(ADXL313_RATE_MSK,
> > +                                          ADXL313_RATE_BASE + i));
> > +}
> > +
> > +static int adxl313_read_axis(struct adxl313_data *data,
> > +                          struct iio_chan_spec const *chan)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&data->lock);
> > +
> > +     ret = regmap_bulk_read(data->regmap,
> > +                            chan->address,
> > +                            &data->transf_buf, 2);
> > +     if (ret)
> > +             goto unlock_ret;
> > +
> > +     ret = le16_to_cpu(data->transf_buf);
> > +
> > +unlock_ret:
> > +     mutex_unlock(&data->lock);
> > +     return ret;
> > +}
> > +
> > +static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
> > +                                struct iio_chan_spec const *chan,
> > +                                const int **vals, int *type, int *length,
> > +                                long mask)
> > +{
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             *vals = (const int *)adxl313_odr_freqs;
> > +             *length = ARRAY_SIZE(adxl313_odr_freqs) * 2;
> > +             *type = IIO_VAL_INT_PLUS_MICRO;
> > +             return IIO_AVAIL_LIST;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int adxl313_read_raw(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int *val, int *val2, long mask)
> > +{
> > +     struct adxl313_data *data = iio_priv(indio_dev);
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = adxl313_read_axis(data, chan);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             *val = sign_extend32(ret, chan->scan_type.realbits - 1);
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val = 0;
> > +             *val2 = ADXL313_NSCALE;
> > +             return IIO_VAL_INT_PLUS_NANO;
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             ret = regmap_read(data->regmap,
> > +                               ADXL313_REG_OFS_AXIS(chan->scan_index),
> > +                               &regval);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /*
> > +              * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> > +              * factor at full resolution
> > +              */
> > +             *val = sign_extend32(regval, 7) * 4;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             ret = regmap_read(data->regmap, ADXL313_REG_BW_RATE, &regval);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret = FIELD_GET(ADXL313_RATE_MSK, regval) - ADXL313_RATE_BASE;
> > +             *val = adxl313_odr_freqs[ret][0];
> > +             *val2 = adxl313_odr_freqs[ret][1];
> > +             return IIO_VAL_INT_PLUS_MICRO;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int adxl313_write_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int val, int val2, long mask)
> > +{
> > +     struct adxl313_data *data = iio_priv(indio_dev);
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             /*
> > +              * 8-bit resolution at +/- 0.5g, that is 4x accel data scale
> > +              * factor at full resolution
> > +              */
> > +             if (val > 127 * 4 || val < -128 * 4)
> > +                     return -EINVAL;
> > +
> > +             return regmap_write(data->regmap,
> > +                                 ADXL313_REG_OFS_AXIS(chan->scan_index),
> > +                                 val / 4);
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return adxl313_set_odr(data, val, val2);
> > +     }
> > +
> > +     return -EINVAL;
>
> Put this as a default in the case otherwise you might get warnings saying you
> don't handle all the possible values.
>
> > +}
> > +
> > +static const struct iio_info adxl313_info = {
> > +     .read_raw       = adxl313_read_raw,
> > +     .write_raw      = adxl313_write_raw,
> > +     .read_avail     = adxl313_read_freq_avail
> > +};
> > +
> > +static int adxl313_setup(struct device *dev, struct adxl313_data *data)
> > +{
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     /* Ensures the device is in a consistent state after start up */
> > +     ret = regmap_write(data->regmap, ADXL313_REG_SOFT_RESET,
> > +                        ADXL313_SOFT_RESET);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (device_property_read_bool(dev, "spi-3wire")) {
>
> Rather odd to see spi specific stuff in here.  Perhaps provide a callback to
> common probe if it needs to be done at this point in bringing the device up.
> However, I think you can just do this before calling the common_probe()
>

I'm doing this here because of the device reset, so whatever I write
to the register before it would be overwritten in setup. The datasheet
doesn't say that resetting the device is strictly necessary, but I
figured it would be better to do so to force consistency.

If I drop the reset, I'd be able to do it before the core probe call
and, from what I'm seeing here, the startup seems to be consistent
without it. Do you think it's best to drop the device reset?

> > +             ret = regmap_write(data->regmap, ADXL313_REG_DATA_FORMAT,
> > +                                ADXL313_SPI_3WIRE);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     ret = regmap_read(data->regmap, ADXL313_REG_DEVID0, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (regval != ADXL313_DEVID0) {
> > +             dev_err(dev, "Invalid manufacturer ID: 0x%02x\n", regval);
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret = regmap_read(data->regmap, ADXL313_REG_DEVID1, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (regval != ADXL313_DEVID1) {
> > +             dev_err(dev, "Invalid mems ID: 0x%02x\n", regval);
> > +             return -ENODEV;
> > +     }
> > +
> > +     ret = regmap_read(data->regmap, ADXL313_REG_PARTID, &regval);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (regval != ADXL313_PARTID) {
> > +             dev_err(dev, "Invalid device ID: 0x%02x\n", regval);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Sets the range to +/- 4g */
> > +     ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> > +                              ADXL313_RANGE_MSK,
> > +                              FIELD_PREP(ADXL313_RANGE_MSK,
> > +                                         ADXL313_RANGE_4G));
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enables full resolution */
> > +     ret = regmap_update_bits(data->regmap, ADXL313_REG_DATA_FORMAT,
> > +                              ADXL313_FULL_RES, ADXL313_FULL_RES);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enables measurement mode */
> > +     return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
> > +                               ADXL313_POWER_CTL_MSK,
> > +                               ADXL313_MEASUREMENT_MODE);
> > +}
> > +
> > +int adxl313_core_probe(struct device *dev, struct regmap *regmap,
> > +                    const char *name)
> > +{
> > +     struct adxl313_data *data;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     data = iio_priv(indio_dev);
> > +     data->regmap = regmap;
> > +     mutex_init(&data->lock);
> > +
> > +     indio_dev->name = name;
> > +     indio_dev->info = &adxl313_info;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->channels = adxl313_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(adxl313_channels);
> > +
> > +     ret = adxl313_setup(dev, data);
> > +     if (ret) {
> > +             dev_err(dev, "ADXL313 setup failed\n");
> > +             return ret;
> > +     }
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(adxl313_core_probe);
> > +
> > +MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> > +MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer core driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
> > new file mode 100644
> > index 000000000000..65050a2fbd38
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl313_i2c.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ADXL313 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> > + *
> > + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> > + */
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "adxl313.h"
> > +
> > +static const struct regmap_config adxl313_i2c_regmap_config = {
> > +     .reg_bits       = 8,
> > +     .val_bits       = 8,
> > +     .rd_table       = &adxl313_readable_regs_table,
> > +     .wr_table       = &adxl313_writable_regs_table,
> > +     .max_register   = 0x39
> > +};
> > +
> > +static int adxl313_i2c_probe(struct i2c_client *client)
> > +{
> > +     struct regmap *regmap;
> > +
> > +     regmap = devm_regmap_init_i2c(client, &adxl313_i2c_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
> > +                     PTR_ERR(regmap));
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     return adxl313_core_probe(&client->dev, regmap, client->name);
> > +}
> > +
> > +static const struct i2c_device_id adxl313_i2c_id[] = {
> > +     { "adxl313", 0 },
>
> No real need to set the data value if it's just going to be 0.
>         { "adl313 },
> is fine.
>
> > +     { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, adxl313_i2c_id);
> > +
> > +static const struct of_device_id adxl313_of_match[] = {
> > +     { .compatible = "adi,adxl313" },
> > +     { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, adxl313_of_match);
> > +
> > +static struct i2c_driver adxl313_i2c_driver = {
> > +     .driver = {
> > +             .name   = "adxl313_i2c",
> > +             .of_match_table = adxl313_of_match,
> > +     },
> > +     .probe_new      = adxl313_i2c_probe,
> > +     .id_table       = adxl313_i2c_id,
> > +};
> > +
> > +module_i2c_driver(adxl313_i2c_driver);
> > +
> > +MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> > +MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer I2C driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
> > new file mode 100644
> > index 000000000000..7c58c9ff8985
> > --- /dev/null
> > +++ b/drivers/iio/accel/adxl313_spi.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * ADXL313 3-Axis Digital Accelerometer
> > + *
> > + * Copyright (c) 2021 Lucas Stankus <lucas.p.stankus@gmail.com>
> > + *
> > + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXL313.pdf
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include "adxl313.h"
> > +
> > +static const struct regmap_config adxl313_spi_regmap_config = {
> > +     .reg_bits       = 8,
> > +     .val_bits       = 8,
> > +     .rd_table       = &adxl313_readable_regs_table,
> > +     .wr_table       = &adxl313_writable_regs_table,
> > +     .max_register   = 0x39,
> > +      /* Setting bits 7 and 6 enables multiple-byte read */
> > +     .read_flag_mask = BIT(7) | BIT(6)
> > +};
> > +
> > +static int adxl313_spi_probe(struct spi_device *spi)
> > +{
> > +     const struct spi_device_id *id = spi_get_device_id(spi);
> > +     struct regmap *regmap;
> > +     int ret;
> > +
> > +     regmap = devm_regmap_init_spi(spi, &adxl313_spi_regmap_config);
> > +     if (IS_ERR(regmap)) {
> > +             dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> > +                     PTR_ERR(regmap));
> > +             return PTR_ERR(regmap);
> > +     }
> > +
> > +     ret = adxl313_core_probe(&spi->dev, regmap, id->name);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return regmap_update_bits(regmap, ADXL313_REG_POWER_CTL,
> > +                               ADXL313_I2C_DISABLE, ADXL313_I2C_DISABLE);
>
> Why is this only done after the rest of probe?  Needs a comment perhaps.
> Normally I'd expect the core probe and hence exposure of the device
> to userspace etc to be the last thing done.
>

I'm doing this here for the same reason as for the spi-3wire setup. So
if I drop the reset in the probe, the bits could be updated before it.


> > +}
> > +
> > +static const struct spi_device_id adxl313_spi_id[] = {
> > +     { "adxl313", 0 },
> > +     { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(spi, adxl313_spi_id);
> > +
> > +static const struct of_device_id adxl313_of_match[] = {
> > +     { .compatible = "adi,adxl313" },
> > +     { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, adxl313_of_match);
> > +
> > +static struct spi_driver adxl313_spi_driver = {
> > +     .driver = {
> > +             .name   = "adxl313_spi",
> > +             .of_match_table = adxl313_of_match,
> > +     },
> > +     .probe          = adxl313_spi_probe,
> > +     .id_table       = adxl313_spi_id,
> > +};
> > +
> > +module_spi_driver(adxl313_spi_driver);
> > +
> > +MODULE_AUTHOR("Lucas Stankus <lucas.p.stankus@gmail.com>");
> > +MODULE_DESCRIPTION("ADXL313 3-Axis Digital Accelerometer SPI driver");
> > +MODULE_LICENSE("GPL v2");
>
