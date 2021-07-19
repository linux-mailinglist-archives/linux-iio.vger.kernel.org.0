Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A303CCF85
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhGSIQl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:16:41 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]:45918 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhGSIQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:16:40 -0400
Received: by mail-qv1-f50.google.com with SMTP id ay16so7982437qvb.12;
        Mon, 19 Jul 2021 01:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=iOGSsnSGe3yhdmwUK/j9xPiSgtq+ETfA7BA2PnxTE5U=;
        b=XLYqEut4J6RHFP26H7RS9rdj4sBxvAppvYMjdVzhqcTxUYnQBKdM0LCGJ7Dd4d75kQ
         iXgjUwuGZgS+C+spVZdhEWgAuC4/58TxeuAqJbgfaNCp5KC2ct09ARKWx5i+4WVZ3Yzq
         7o0H8fVBcdaRTAcKuo5+0muf9PuZo7t3yu3R21nJlycYNWtaRRCUNL/AYYVxPYplwOvE
         26BWlpuxrRl1pydwe3QstFYT4k/WRDV5s9to+DLYD8k4tfnGwlZEraJQ1LCQ9eIocGEu
         D83AORqbLQKs0iPaGIwR7ScprmeVfLXPdGFSgObTDO/yC5lVkjvxmdbu1dgHPEHHJ61E
         92aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=iOGSsnSGe3yhdmwUK/j9xPiSgtq+ETfA7BA2PnxTE5U=;
        b=Lzb7ARPWG+0jnH8Lvt9PK1+Cw2ZTsdhBXlxRCQ5BqKnUphDNX28lerG/dR8ZCje2HR
         XneqamEqVMR7gyWAdGKRkIzniMQZ9eGe7m/Y2LJmf9qDEjIxGE877i0w3Kvx9t4xSJP/
         tFmYTgUQCOWMOICUwpOOTigUJjm1cFJBdgvdqQMJsLwBc6U7ZmVEQeVuaSdP4eYbiAHm
         DNmlcTuXNsbQ7uZY+jmmxT8r/UTUSxECeiVeFRi2SBMMQkuU9cUKjx7nO9GeDK3QlAHV
         H3bf6Y4NhBorleRlbx9aCLfJmW/C+1hscaZR6pieO+f9FZ1TDkyb9cK07yj8okRK8mXM
         nBug==
X-Gm-Message-State: AOAM533jlYa10OICxq9AA2BjdlFw8NKI4A/FZw4w4nlJF0Yi329dlrHk
        0YSvCNDk03uYqBXLGnJioH0npXd3ov9DMd6E9Jn+jE1GChtoeWKW
X-Google-Smtp-Source: ABdhPJxT4s8TQd3LxoSQ5jEe9RNaeG749FKDMbtP2ZLiRffZ1UbaKuOtKSrFR+x55MMPoKKKz/h10v7AjuByWHlh6f0=
X-Received: by 2002:aa7:8284:0:b029:312:1c62:cc0f with SMTP id
 s4-20020aa782840000b02903121c62cc0fmr25188934pfm.75.1626683438127; Mon, 19
 Jul 2021 01:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20210715141742.15072-3-andrea.merello@gmail.com> <20210717163236.1553fbfa@jic23-huawei>
In-Reply-To: <20210717163236.1553fbfa@jic23-huawei>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 19 Jul 2021 10:30:26 +0200
Message-ID: <CAN8YU5NctVMPfNZn7ya-Jw7yE=NQDBq1aweWn0fX0Rp1p1P=aw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno sab 17 lug 2021 alle ore 17:30 Jonathan Cameron
<jic23@kernel.org> ha scritto:
>
> On Thu, 15 Jul 2021 16:17:40 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:
>
> > This patch adds a core driver for the BNO055 IMU from Bosch. This IMU
> > can be connected via both serial and I2C busses; separate patches will
> > add support for them.
> >
> > The driver supports "AMG" (Accelerometer, Magnetometer, Gyroscope) mode,
> > that provides raw data from the said internal sensors, and a couple of
> > "fusion" modes (i.e. the IMU also do calculations in order to provide
> > euler angles,
>
> Yuck.
>
> > quaternions,
>
> That's better :)  I don't suppose we could insist that people don't do anything
> so silly as using euler angles by just not providing them? :)

They are just handy to cat in combination with the watch command when
you are playing with your new bno055-equipped board, and look at them
change :)

> > linear acceleration and gravity measurements).
> >
> > In fusion modes the AMG data is still available (with some calibration
> > refinements done by the IMU), but certain settings such as low pass
> > filters cut-off frequency and sensors ranges are fixed, while in AMG mode
> > they can be customized; this is why AMG mode can still be interesting.
> >
> > Signed-off-by: Andrea Merello <andrea.merello@iit.it>
>
> Obviously Andy and Alex did a pretty detailed reviews of this so I might be a little
> lazy until a later version... But I'll take a scan read through so I know whats
> coming and if I notice anything will comment on it.
>
> One bit thing in here is that any non standard ABI needs documentation.
> It's very had to discuss whether we can accept the additions based on code.
> Basic rule of thumb is that nonstandard ABI will only be used by your own
> code.  If you want this to be generally useful, then we need to figure out
> how to standardise things or map to existing ABI.

I wasn't sure my new ABIs were useful for others. If you think that's
the case, then we can see how to make it generic. I'll add docs in
next series respin.

> > Cc: Andrea Merello <andrea.merello@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Vlad Dogaru <vlad.dogaru@intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  drivers/iio/imu/Kconfig         |    1 +
> >  drivers/iio/imu/Makefile        |    1 +
> >  drivers/iio/imu/bno055/Kconfig  |    7 +
> >  drivers/iio/imu/bno055/Makefile |    6 +
> >  drivers/iio/imu/bno055/bno055.c | 1361 +++++++++++++++++++++++++++++++
> >  drivers/iio/imu/bno055/bno055.h |   12 +
> >  6 files changed, 1388 insertions(+)
> >  create mode 100644 drivers/iio/imu/bno055/Kconfig
> >  create mode 100644 drivers/iio/imu/bno055/Makefile
> >  create mode 100644 drivers/iio/imu/bno055/bno055.c
> >  create mode 100644 drivers/iio/imu/bno055/bno055.h
> >
> > diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> > index 001ca2c3ff95..f1d7d4b5e222 100644
> > --- a/drivers/iio/imu/Kconfig
> > +++ b/drivers/iio/imu/Kconfig
> > @@ -52,6 +52,7 @@ config ADIS16480
> >         ADIS16485, ADIS16488 inertial sensors.
> >
> >  source "drivers/iio/imu/bmi160/Kconfig"
> > +source "drivers/iio/imu/bno055/Kconfig"
> I'm not sure I'd bother with a directory for this one.
> >
> >  config FXOS8700
> >       tristate
> > diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
> > index c82748096c77..6eb612034722 100644
> > --- a/drivers/iio/imu/Makefile
> > +++ b/drivers/iio/imu/Makefile
> > @@ -15,6 +15,7 @@ adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
> >  obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
> >
> >  obj-y += bmi160/
> > +obj-y += bno055/
> >
> >  obj-$(CONFIG_FXOS8700) += fxos8700_core.o
> >  obj-$(CONFIG_FXOS8700_I2C) += fxos8700_i2c.o
> > diff --git a/drivers/iio/imu/bno055/Kconfig b/drivers/iio/imu/bno055/Kconfig
> > new file mode 100644
> > index 000000000000..2bfed8df4554
> > --- /dev/null
> > +++ b/drivers/iio/imu/bno055/Kconfig
> > @@ -0,0 +1,7 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# driver for Bosh bmo055
> > +#
> > +
> > +config BOSH_BNO055_IIO
> > +     tristate
> > diff --git a/drivers/iio/imu/bno055/Makefile b/drivers/iio/imu/bno055/Makefile
> > new file mode 100644
> > index 000000000000..15c5ddf8d648
> > --- /dev/null
> > +++ b/drivers/iio/imu/bno055/Makefile
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Makefile for bosh bno055
> > +#
> > +
> > +obj-$(CONFIG_BOSH_BNO055_IIO) += bno055.o
> > diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
> > new file mode 100644
> > index 000000000000..888a88bb13d5
> > --- /dev/null
> > +++ b/drivers/iio/imu/bno055/bno055.c
> > @@ -0,0 +1,1361 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * IIO driver for Bosh BNO055 IMU
> > + *
> > + * Copyright (C) 2021 Istituto Italiano di Tecnologia
> > + * Electronic Design Laboratory
> > + * Written by Andrea Merello <andrea.merello@iit.it>
> > + *
> > + * Portions of this driver are taken from the BNO055 driver patch
> > + * from Vlad Dogaru which is Copyright (c) 2016, Intel Corporation.
> > + *
> > + * This driver is also based on BMI160 driver, which is:
> > + *   Copyright (c) 2016, Intel Corporation.
> > + *   Copyright (c) 2019, Martin Kelly.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/firmware.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/irq.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/util_macros.h>
> > +
> > +#include "bno055.h"
> > +
> > +#define BNO055_FW_NAME "bno055-caldata"
> > +#define BNO055_FW_EXT ".dat"
> > +
> > +/* common registers */
> > +#define BNO055_PAGESEL_REG           0x7
> > +
> > +/* page 0 registers */
> > +#define BNO055_CHIP_ID_REG           0x0
> > +#define BNO055_CHIP_ID_MAGIC 0xA0
> > +#define BNO055_SW_REV_LSB_REG                0x4
> > +#define BNO055_SW_REV_MSB_REG                0x5
> > +#define BNO055_ACC_DATA_X_LSB_REG    0x8
> > +#define BNO055_ACC_DATA_Y_LSB_REG    0xA
> > +#define BNO055_ACC_DATA_Z_LSB_REG    0xC
> > +#define BNO055_MAG_DATA_X_LSB_REG    0xE
> > +#define BNO055_MAG_DATA_Y_LSB_REG    0x10
> > +#define BNO055_MAG_DATA_Z_LSB_REG    0x12
> > +#define BNO055_GYR_DATA_X_LSB_REG    0x14
> > +#define BNO055_GYR_DATA_Y_LSB_REG    0x16
> > +#define BNO055_GYR_DATA_Z_LSB_REG    0x18
> > +#define BNO055_EUL_DATA_X_LSB_REG    0x1A
> > +#define BNO055_EUL_DATA_Y_LSB_REG    0x1C
> > +#define BNO055_EUL_DATA_Z_LSB_REG    0x1E
> > +#define BNO055_QUAT_DATA_W_LSB_REG   0x20
> > +#define BNO055_LIA_DATA_X_LSB_REG    0x28
> > +#define BNO055_LIA_DATA_Y_LSB_REG    0x2A
> > +#define BNO055_LIA_DATA_Z_LSB_REG    0x2C
> > +#define BNO055_GRAVITY_DATA_X_LSB_REG        0x2E
> > +#define BNO055_GRAVITY_DATA_Y_LSB_REG        0x30
> > +#define BNO055_GRAVITY_DATA_Z_LSB_REG        0x32
> > +#define BNO055_TEMP_REG                      0x34
> > +#define BNO055_CALIB_STAT_REG                0x35
> > +#define BNO055_CALIB_STAT_MASK 3
> > +#define BNO055_CALIB_STAT_MAGN_SHIFT 0
> > +#define BNO055_CALIB_STAT_ACCEL_SHIFT 2
> > +#define BNO055_CALIB_STAT_GYRO_SHIFT 4
> > +#define BNO055_CALIB_STAT_SYS_SHIFT 6
> > +#define BNO055_SYS_TRIGGER_REG               0x3F
> > +#define BNO055_SYS_TRIGGER_RST_INT BIT(6)
> > +#define BNO055_SYS_TRIGGER_CLK_SEL BIT(7)
> > +#define BNO055_OPR_MODE_REG          0x3D
> > +#define BNO055_OPR_MODE_CONFIG 0x0
> > +#define BNO055_OPR_MODE_AMG 0x7
> > +#define BNO055_OPR_MODE_FUSION_FMC_OFF 0xB
> > +#define BNO055_OPR_MODE_FUSION 0xC
> > +#define BNO055_UNIT_SEL_REG          0x3B
> > +#define BNO055_UNIT_SEL_ANDROID BIT(7)
> > +#define BNO055_CALDATA_START         0x55
> > +#define BNO055_CALDATA_END           0x6A
> > +#define BNO055_CALDATA_LEN (BNO055_CALDATA_END - BNO055_CALDATA_START + 1)
> > +
> > +/*
> > + * The difference in address between the register that contains the
> > + * value and the register that contains the offset.  This applies for
> > + * accel, gyro and magn channels.
> > + */
> > +#define BNO055_REG_OFFSET_ADDR               0x4D
> > +
> > +/* page 1 registers */
> > +#define PG1(x) ((x) | 0x80)
> > +#define BNO055_ACC_CONFIG_REG                PG1(0x8)
> > +#define BNO055_ACC_CONFIG_LPF_MASK 0x1C
> > +#define BNO055_ACC_CONFIG_LPF_SHIFT 0x2
> > +#define BNO055_ACC_CONFIG_RANGE_MASK 0x3
> > +#define BNO055_ACC_CONFIG_RANGE_SHIFT 0x0
> > +#define BNO055_MAG_CONFIG_REG                PG1(0x9)
> > +#define BNO055_MAG_CONFIG_HIGHACCURACY 0x18
> > +#define BNO055_MAG_CONFIG_ODR_MASK 0x7
> > +#define BNO055_MAG_CONFIG_ODR_SHIFT 0
> > +#define BNO055_GYR_CONFIG_REG                PG1(0xA)
> > +#define BNO055_GYR_CONFIG_RANGE_MASK 0x7
> > +#define BNO055_GYR_CONFIG_RANGE_SHIFT 0
> > +#define BNO055_GYR_CONFIG_LPF_MASK 0x38
> > +#define BNO055_GYR_CONFIG_LPF_SHIFT 3
> > +#define BNO055_INT_MSK                       PG1(0xF)
> > +#define BNO055_INT_EN                        PG1(0x10)
> > +#define BNO055_INT_ACC_BSX_DRDY BIT(0)
> > +#define BNO055_INT_MAG_DRDY BIT(1)
> > +#define BNO055_INT_GYR_DRDY BIT(4)
> > +#define BNO055_UID_REG                       PG1(0x50)
> > +#define BNO055_UID_LEN (0xF)
> > +
> > +static const int bno055_mag_odr_vals[] = {2, 6, 8, 10, 15, 20, 25, 30};
> > +static const int bno055_acc_lpf_vals[] = {781, 1563, 3125, 6250,
> > +                                         12500, 25000, 50000, 100000};
> > +static const int bno055_acc_ranges[] = {2, 4, 8, 16};
> > +static const int bno055_gyr_lpf_vals[] = {523, 230, 116, 47, 23, 12, 64, 32};
> > +static const int bno055_gyr_ranges[] = {2000, 1000, 500, 250, 125};
> > +
> > +struct bno055_priv {
> > +     struct regmap *regmap;
> > +     struct device *dev;
> > +     struct clk *clk;
> > +     int operation_mode;
> > +     int xfer_burst_break_thr;
> > +     struct mutex lock;
> > +     u8 uid[BNO055_UID_LEN];
> > +};
> > +
> > +static int find_closest_unsorted(int val, const int arr[], int len)
> > +{
> > +     int i;
> > +     int best_idx, best_delta, delta;
> > +     int first = 1;
> > +
> > +     for (i = 0; i < len; i++) {
> > +             delta = abs(arr[i] - val);
> > +             if (first || delta < best_delta) {
> > +                     best_delta = delta;
> > +                     best_idx = i;
> > +             }
> > +             first = 0;
> > +     }
> > +
> > +     return best_idx;
> > +}
> > +
> > +static bool bno055_regmap_volatile(struct device *dev, unsigned int reg)
> > +{
> > +     if ((reg >= 0x8 && reg <= 0x3A) ||
> > +         /* when in fusion mode, config is updated by chip */
> > +         reg == BNO055_MAG_CONFIG_REG ||
> > +         reg == BNO055_ACC_CONFIG_REG ||
> > +         reg == BNO055_GYR_CONFIG_REG ||
> > +         (reg >= BNO055_CALDATA_START && reg <= BNO055_CALDATA_END))
> > +             return true;
> > +     return false;
> > +}
> > +
> > +static bool bno055_regmap_readable(struct device *dev, unsigned int reg)
> > +{
> > +     if ((reg <= 0x7F && reg >= 0x6B) ||
> > +         reg == 0x3C ||
> > +         (reg <= PG1(0x7F) && reg >= PG1(0x60)) ||
> > +         (reg <= PG1(0x4F) && reg >= PG1(0x20)) ||
> > +         reg == PG1(0xE) ||
> > +         (reg <= PG1(0x6) && reg >= PG1(0x0)))
> > +             return false;
> > +     return true;
> > +}
> > +
> > +static bool bno055_regmap_writeable(struct device *dev, unsigned int reg)
> > +{
> > +     if ((!bno055_regmap_readable(dev, reg)) ||
> > +         (reg <= 0x3A && reg >= 0x8) ||
> > +         reg <= 0x6 ||
> > +         (reg <= PG1(0x5F) && reg >= PG1(0x50)))
> > +             return false;
> > +     return true;
> > +}
> > +
> > +static const struct regmap_range_cfg bno055_regmap_ranges[] = {
> > +     {
> > +             .range_min = 0,
> > +             .range_max = 0x7f * 2,
> > +             .selector_reg = BNO055_PAGESEL_REG,
> > +             .selector_mask = 0xff,
> > +             .selector_shift = 0,
> > +             .window_start = 0,
> > +             .window_len = 0x80
> > +     },
> > +};
> > +
> > +const struct regmap_config bno055_regmap_config = {
> > +     .name      = "bno055",
>
> Don't mix and match aligning rvalue and not.  Personally I prefer
> not trying to do pretty aligning as it normally needs to later noise
> when the whole lot lead realigning because we've set something else!
>
> > +     .reg_bits  = 8,
> > +     .val_bits  = 8,
> > +     .ranges = bno055_regmap_ranges,
> > +     .num_ranges = 1,
> > +     .volatile_reg = bno055_regmap_volatile,
> > +     .max_register = 0x80 * 2,
> > +     .writeable_reg = bno055_regmap_writeable,
> > +     .readable_reg = bno055_regmap_readable,
> > +     .cache_type = REGCACHE_RBTREE,
> > +};
> > +EXPORT_SYMBOL_GPL(bno055_regmap_config);
> > +
> > +static int bno055_reg_read(struct bno055_priv *priv,
> > +                        unsigned int reg, unsigned int *val)
> > +{
> > +     int res = regmap_read(priv->regmap, reg, val);
> > +
> > +     if (res && res != -ERESTARTSYS) {
> > +             dev_err(priv->dev, "Regmap read error. adr: 0x%x, res: %d",
> > +                     reg,  res);
> > +     }
> > +
> > +     return res;
> > +}
> > +
> > +static int bno055_reg_write(struct bno055_priv *priv,
> > +                         unsigned int reg, unsigned int val)
> > +{
> > +     int res = regmap_write(priv->regmap, reg, val);
> > +
> > +     if (res && res != -ERESTARTSYS) {
>
> I think Andy asked about these, so I won't repeat...
> Nice to get rid of those and just be able to make the regmap calls inline though...

Ok for inline. I've just answered in another mail to Andy's comments
for the rest.

>
> > +             dev_err(priv->dev, "Regmap write error. adr: 0x%x, res: %d",
> > +                     reg,  res);
> > +     }
> > +
> > +     return res;
> > +}
> > +
> > +static int bno055_reg_update_bits(struct bno055_priv *priv, unsigned int reg,
> > +                               unsigned int mask, unsigned int val)
> > +{
> > +     int res = regmap_update_bits(priv->regmap, reg, mask, val);
> > +
> > +     if (res && res != -ERESTARTSYS) {
> > +             dev_err(priv->dev, "Regmap update_bits  error. adr: 0x%x, res: %d",
> > +                     reg,  res);
> > +     }
> > +
> > +     return res;
> > +}
> > +
> > +/* must be called in configuration mode */
> > +int bno055_calibration_load(struct bno055_priv *priv, const struct firmware *fw)
> > +{
> > +     int i;
> > +     unsigned int tmp;
> > +     u8 cal[BNO055_CALDATA_LEN];
> > +     int read, tot_read = 0;
> > +     int ret = 0;
> > +     char *buf = kmalloc(fw->size + 1, GFP_KERNEL);
> > +
> > +     if (!buf)
> > +             return -ENOMEM;
> > +
> > +     memcpy(buf, fw->data, fw->size);
> > +     buf[fw->size] = '\0';
> > +     for (i = 0; i < BNO055_CALDATA_LEN; i++) {
> > +             ret = sscanf(buf + tot_read, "%x%n",
> > +                          &tmp, &read);
> > +             if (ret != 1 || tmp > 0xff) {
> > +                     ret = -EINVAL;
> > +                     goto exit;
> > +             }
> > +             cal[i] = tmp;
> > +             tot_read += read;
> > +     }
> > +     dev_dbg(priv->dev, "loading cal data: %*ph", BNO055_CALDATA_LEN, cal);
> > +     ret = regmap_bulk_write(priv->regmap, BNO055_CALDATA_START,
> > +                             cal, BNO055_CALDATA_LEN);
> > +exit:
> > +     kfree(buf);
> > +     return ret;
> > +}
> > +
> > +static int bno055_init(struct bno055_priv *priv, const struct firmware *caldata)
> > +{
> > +     int res;
> > +
> > +     res = bno055_reg_write(priv, BNO055_SYS_TRIGGER_REG,
> > +                            (priv->clk ? BNO055_SYS_TRIGGER_CLK_SEL : 0) |
> > +                            BNO055_SYS_TRIGGER_RST_INT);
> > +     if (res)
> > +             return res;
> > +
> > +     msleep(100);
> > +     res = bno055_reg_write(priv, BNO055_OPR_MODE_REG,
> > +                            BNO055_OPR_MODE_CONFIG);
> > +     if (res)
> > +             return res;
> > +
> > +     /* use standard SI units */
>
> Nice :)
>
> > +     res = bno055_reg_write(priv, BNO055_UNIT_SEL_REG,
> > +                            BNO055_UNIT_SEL_ANDROID);
> > +     if (res)
> > +             return res;
> > +
> > +     if (caldata) {
> > +             res = bno055_calibration_load(priv, caldata);
> > +             if (res)
> > +                     dev_warn(priv->dev, "failed to load calibration data with error %d",
> > +                              res);
> > +     }
> > +
> > +     /*
> > +      * Start in fusion mode (all data available), but with magnetometer auto
> > +      * calibration switched off, in order not to overwrite magnetometer
> > +      * calibration data in case one want to keep it untouched.
>
> Why might you? good to have a default that is what people most commonly want...
> If there is a usecase for this then it may be better to have a 'disable autocalibration
> and manually reload a fixed calibration' path.

I'm not sure whether disabling autocalibration for magnetometer is
just a matter of saving some power, or whether this has the purpose of
carefully doing the calibration far from magnetic disturbances,
avoiding screwing the calibration every time you briefly pass by a
piece of iron. I think I found some clues for this second
interpretation poking on the internet, but I don't know whether they
were right.

Do you know anything about this?

If we assume that disabling autocalibration is of almost no use, I may
just drop support for this, otherwise if we think that sticking with
initial calibration data is a possilble use case, then I would find it
a bit twisted to: let the driver load initial calibration, let the IMU
possibly tweak it, then disable autocalibration, then ask to realod
the calibration data.. Isn't that more straightforward to let the
driver load the initial calibration, and then enable autocalibration..

If you want a separate attribute for disabling/enabling calibration,
then it is OK; just it would only work in fusion mode, and if support
for other IMU modes will be addeed (e.g. compass) it still would be
unused except for one.

> > +      */
> > +     priv->operation_mode = BNO055_OPR_MODE_FUSION_FMC_OFF;
> > +     return bno055_reg_write(priv, BNO055_OPR_MODE_REG,
> > +                             priv->operation_mode);
> > +}
> > +
> > +static void bno055_uninit(void *arg)
> > +{
> > +     struct bno055_priv *priv = arg;
> > +
> > +     bno055_reg_write(priv, BNO055_INT_EN, 0);
> I'm not seeing where the action this is unwinding occurs.
>
> It's uncommon to have a devm cleanup function that does two things like this
> which makes me suspicious about potential races.

Yes, Alex told me; I'll fix that..

> > +
> > +     clk_disable_unprepare(priv->clk);
> > +}
> > +
> > +#define BNO055_CHANNEL(_type, _axis, _index, _address, _sep, _sh) {  \
> > +     .address = _address,                                            \
> > +     .type = _type,                                                  \
> > +     .modified = 1,                                                  \
> > +     .channel2 = IIO_MOD_##_axis,                                    \
> > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | (_sep),          \
> > +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | (_sh),   \
> > +     .scan_index = _index,                                           \
> > +     .scan_type = {                                                  \
> > +             .sign = 's',                                            \
> > +             .realbits = 16,                                         \
> > +             .storagebits = 16,                                      \
> > +             .endianness = IIO_LE,                                   \
> > +             .repeat = IIO_MOD_##_axis == IIO_MOD_QUATERNION ? 4 : 0 \
> > +     },                                                              \
> > +}
> > +
> > +/* scan indexes follow DATA register order */
> > +enum bmi160_scan_axis {
> > +     BNO055_SCAN_ACCEL_X,
> > +     BNO055_SCAN_ACCEL_Y,
> > +     BNO055_SCAN_ACCEL_Z,
> > +     BNO055_SCAN_MAGN_X,
> > +     BNO055_SCAN_MAGN_Y,
> > +     BNO055_SCAN_MAGN_Z,
> > +     BNO055_SCAN_GYRO_X,
> > +     BNO055_SCAN_GYRO_Y,
> > +     BNO055_SCAN_GYRO_Z,
> > +     BNO055_SCAN_HEADING,
> > +     BNO055_SCAN_ROLL,
> > +     BNO055_SCAN_PITCH,
> > +     BNO055_SCAN_QUATERNION,
> > +     BNO055_SCAN_LIA_X,
> > +     BNO055_SCAN_LIA_Y,
> > +     BNO055_SCAN_LIA_Z,
> > +     BNO055_SCAN_GRAVITY_X,
> > +     BNO055_SCAN_GRAVITY_Y,
> > +     BNO055_SCAN_GRAVITY_Z,
> > +     BNO055_SCAN_TIMESTAMP,
> > +};
> > +
> > +static const struct iio_chan_spec bno055_channels[] = {
> > +     /* accelerometer */
> > +     BNO055_CHANNEL(IIO_ACCEL, X, BNO055_SCAN_ACCEL_X,
> > +                    BNO055_ACC_DATA_X_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> > +     BNO055_CHANNEL(IIO_ACCEL, Y, BNO055_SCAN_ACCEL_Y,
> > +                    BNO055_ACC_DATA_Y_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> > +     BNO055_CHANNEL(IIO_ACCEL, Z, BNO055_SCAN_ACCEL_Z,
> > +                    BNO055_ACC_DATA_Z_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> > +     /* gyroscope */
> > +     BNO055_CHANNEL(IIO_ANGL_VEL, X, BNO055_SCAN_GYRO_X,
> > +                    BNO055_GYR_DATA_X_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> > +     BNO055_CHANNEL(IIO_ANGL_VEL, Y, BNO055_SCAN_GYRO_Y,
> > +                    BNO055_GYR_DATA_Y_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> > +     BNO055_CHANNEL(IIO_ANGL_VEL, Z, BNO055_SCAN_GYRO_Z,
> > +                    BNO055_GYR_DATA_Z_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)),
> > +     /* magnetometer */
> > +     BNO055_CHANNEL(IIO_MAGN, X, BNO055_SCAN_MAGN_X,
> > +                    BNO055_MAG_DATA_X_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_SAMP_FREQ)),
> > +     BNO055_CHANNEL(IIO_MAGN, Y, BNO055_SCAN_MAGN_Y,
> > +                    BNO055_MAG_DATA_Y_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_SAMP_FREQ)),
> > +     BNO055_CHANNEL(IIO_MAGN, Z, BNO055_SCAN_MAGN_Z,
> > +                    BNO055_MAG_DATA_Z_LSB_REG, BIT(IIO_CHAN_INFO_OFFSET),
> > +                    BIT(IIO_CHAN_INFO_SAMP_FREQ)),
> > +     /* euler angle */
> > +     BNO055_CHANNEL(IIO_ROT, X, BNO055_SCAN_HEADING,
> > +                    BNO055_EUL_DATA_X_LSB_REG, 0, 0),
>
> Euler angles don't map to axis.  If it were doing angle/axis then that
> would be a natural mapping, but it's not.

So do we need new modifiers like IIO_MOD_HEADING, IIO_MOD_YAW,
IIO_MODE_ROLL? But aren't euler angles really rotations around each
axis (so IMHO mapping them to axis would make sense).. FWIW the
datasheet also reg names are in form of e.g BNO055_EUL_DATA_X_LSB_REG.

> > +     BNO055_CHANNEL(IIO_ROT, Y, BNO055_SCAN_ROLL,
> > +                    BNO055_EUL_DATA_Y_LSB_REG, 0, 0),
> > +     BNO055_CHANNEL(IIO_ROT, Z, BNO055_SCAN_PITCH,
> > +                    BNO055_EUL_DATA_Z_LSB_REG, 0, 0),
> > +     /* quaternion */
> > +     BNO055_CHANNEL(IIO_ROT, QUATERNION, BNO055_SCAN_QUATERNION,
> > +                    BNO055_QUAT_DATA_W_LSB_REG, 0, 0),
> > +
> > +     /* linear acceleration */
> > +     BNO055_CHANNEL(IIO_ACCEL, ACCEL_LINEAR_X, BNO055_SCAN_LIA_X,
> > +                    BNO055_LIA_DATA_X_LSB_REG, 0, 0),
> > +     BNO055_CHANNEL(IIO_ACCEL, ACCEL_LINEAR_Y, BNO055_SCAN_LIA_Y,
> > +                    BNO055_LIA_DATA_Y_LSB_REG, 0, 0),
> > +     BNO055_CHANNEL(IIO_ACCEL, ACCEL_LINEAR_Z, BNO055_SCAN_LIA_Z,
> > +                    BNO055_LIA_DATA_Z_LSB_REG, 0, 0),
> > +
> > +     /* gravity vector */
> > +     BNO055_CHANNEL(IIO_GRAVITY, X, BNO055_SCAN_GRAVITY_X,
> > +                    BNO055_GRAVITY_DATA_X_LSB_REG, 0, 0),
> > +     BNO055_CHANNEL(IIO_GRAVITY, Y, BNO055_SCAN_GRAVITY_Y,
> > +                    BNO055_GRAVITY_DATA_Y_LSB_REG, 0, 0),
> > +     BNO055_CHANNEL(IIO_GRAVITY, Z, BNO055_SCAN_GRAVITY_Z,
> > +                    BNO055_GRAVITY_DATA_Z_LSB_REG, 0, 0),
> > +
> > +     {
> > +             .type = IIO_TEMP,
> > +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +             .scan_index = -1
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(BNO055_SCAN_TIMESTAMP),
> > +};
> > +
> > +static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
> > +                           int reg, int mask, int shift,
>
> Ideally shouldn't need mask and shift as can normally extract the shift
> from the mask.

OK

> This seems far more complex than I'd expect to see.  It may well
> be both more readable and less error prone to just spend the extra
> lines of code to lay this out as more standard functions for each
> case.

That would be a cut&paste of almost identical two same functions,
except for register name and shift, repeated for 5 times. The only
complication I see here, is the last param "k", which serve only for
one case indeed. What about letting stay the generic helper for the 4
"plain" cases, and introducing separated dedicated functions for the
only case that is a bit different (accelerometer lpf), getting rid of
the last parameter "k"?

>
> > +                           const int tbl[], int k)
> > +{
> > +     int hwval, idx;
> > +     int ret = bno055_reg_read(priv, reg, &hwval);
> > +
> > +     if (ret)
> > +             return ret;
> > +     if (val2)
> > +             *val2 = 0;
> > +     idx = (hwval & mask) >> shift;
> > +     *val = tbl[idx] / k;
> > +
> > +     if (k == 1)
> > +             return IIO_VAL_INT;
>
> if returning IIO_VAL_INT, no need to set *val2 as nothing will read it.
> As such, you should be able to skip the default setting above.

Ah OK!

> > +
> > +     *val2 = (tbl[idx] % k) * 10000;
> > +     return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int bno055_set_regmask(struct bno055_priv *priv, int val, int val2,
> > +                           int reg, int mask, int shift,
> > +                           const int table[], int table_len, int k)
> > +
> > +{
> > +     int ret;
> > +     int hwval = find_closest_unsorted(val * k + val2 / 10000,
> > +                                       table, table_len);
> > +     /*
> > +      * The closest value the HW supports is only one in fusion mode,
> > +      * and it is autoselected, so don't do anything, just return OK,
> > +      * as the closest possible value has been (virtually) selected
> > +      */
> > +     if (priv->operation_mode != BNO055_OPR_MODE_AMG)
> > +             return 0;
> > +
> > +     dev_dbg(priv->dev, "WR config - reg, mask, val: 0x%x, 0x%x, 0x%x",
> > +             reg, mask, hwval);
> > +
> > +     ret = bno055_reg_write(priv, BNO055_OPR_MODE_REG,
> > +                            BNO055_OPR_MODE_CONFIG);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = bno055_reg_update_bits(priv, reg, mask, hwval << shift);
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     return bno055_reg_write(priv, BNO055_OPR_MODE_REG,
> > +                             BNO055_OPR_MODE_AMG);
> > +     return 0;
> > +}
> > +
> > +#define bno055_get_mag_odr(p, v, v2) \
> > +     bno055_get_regmask(p, v, v2, \
> > +                        BNO055_MAG_CONFIG_REG, BNO055_MAG_CONFIG_ODR_MASK, \
> > +                        BNO055_MAG_CONFIG_ODR_SHIFT, bno055_mag_odr_vals, 1)
> > +
> > +#define bno055_set_mag_odr(p, v, v2) \
> > +     bno055_set_regmask(p, v, v2, \
> > +                        BNO055_MAG_CONFIG_REG, BNO055_MAG_CONFIG_ODR_MASK, \
> > +                        BNO055_MAG_CONFIG_ODR_SHIFT, \
> > +                        bno055_mag_odr_vals, \
> > +                        ARRAY_SIZE(bno055_mag_odr_vals), 1)
> > +
> > +#define bno055_get_acc_lpf(p, v, v2) \
> > +     bno055_get_regmask(p, v, v2, \
> > +                        BNO055_ACC_CONFIG_REG, BNO055_ACC_CONFIG_LPF_MASK, \
> > +                        BNO055_ACC_CONFIG_LPF_SHIFT, \
> > +                        bno055_acc_lpf_vals, 100)
> > +
> > +#define bno055_set_acc_lpf(p, v, v2) \
> > +     bno055_set_regmask(p, v, v2, \
> > +                        BNO055_ACC_CONFIG_REG, BNO055_ACC_CONFIG_LPF_MASK, \
> > +                        BNO055_ACC_CONFIG_LPF_SHIFT, \
> > +                        bno055_acc_lpf_vals, \
> > +                        ARRAY_SIZE(bno055_acc_lpf_vals), 100)
> > +
> > +#define bno055_get_acc_range(p, v, v2) \
> > +     bno055_get_regmask(priv, v, v2, \
> > +                        BNO055_ACC_CONFIG_REG, \
> > +                        BNO055_ACC_CONFIG_RANGE_MASK, \
> > +                        BNO055_ACC_CONFIG_RANGE_SHIFT, bno055_acc_ranges, 1)
> > +
> > +#define bno055_set_acc_range(p, v, v2) \
> > +     bno055_set_regmask(p, v, v2, \
> > +                        BNO055_ACC_CONFIG_REG, \
> > +                        BNO055_ACC_CONFIG_RANGE_MASK,  \
> > +                        BNO055_ACC_CONFIG_RANGE_SHIFT, \
> > +                        bno055_acc_ranges, ARRAY_SIZE(bno055_acc_ranges), 1)
> > +
> > +#define bno055_get_gyr_lpf(p, v, v2) \
> > +     bno055_get_regmask(p, v, v2, \
> > +                        BNO055_GYR_CONFIG_REG, BNO055_GYR_CONFIG_LPF_MASK, \
> > +                        BNO055_GYR_CONFIG_LPF_SHIFT, bno055_gyr_lpf_vals, 1)
> > +
> > +#define bno055_set_gyr_lpf(p, v, v2) \
> > +     bno055_set_regmask(p, v, v2, \
> > +                        BNO055_GYR_CONFIG_REG, BNO055_GYR_CONFIG_LPF_MASK, \
> > +                        BNO055_GYR_CONFIG_LPF_SHIFT, \
> > +                        bno055_gyr_lpf_vals, \
> > +                        ARRAY_SIZE(bno055_gyr_lpf_vals), 1)
> > +
> > +#define bno055_get_gyr_range(p, v, v2) \
> > +     bno055_get_regmask(p, v, v2, \
> > +                        BNO055_GYR_CONFIG_REG, \
> > +                        BNO055_GYR_CONFIG_RANGE_MASK,  \
> > +                        BNO055_GYR_CONFIG_RANGE_SHIFT, \
> > +                        bno055_gyr_ranges, 1)
> > +
> > +#define bno055_set_gyr_range(p, v, v2) \
> > +     bno055_set_regmask(p, v, v2, \
> > +                        BNO055_GYR_CONFIG_REG, \
> > +                        BNO055_GYR_CONFIG_RANGE_MASK, \
> > +                        BNO055_GYR_CONFIG_RANGE_SHIFT, \
> > +                        bno055_gyr_ranges, ARRAY_SIZE(bno055_gyr_ranges), 1)
> > +
> > +static int bno055_read_simple_chan(struct iio_dev *indio_dev,
> > +                                struct iio_chan_spec const *chan,
> > +                                int *val, int *val2, long mask)
> > +{
> > +     struct bno055_priv *priv = iio_priv(indio_dev);
> > +     __le16 raw_val;
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = regmap_bulk_read(priv->regmap, chan->address,
> > +                                    &raw_val, 2);
> > +             if (ret < 0)
> > +                     return ret;
> > +             *val = (s16)le16_to_cpu(raw_val);
> > +             *val2 = 0;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_OFFSET:
> > +             if (priv->operation_mode != BNO055_OPR_MODE_AMG) {
> > +                     *val = 0;
> > +             } else {
> > +                     ret = regmap_bulk_read(priv->regmap,
> > +                                            chan->address +
> > +                                            BNO055_REG_OFFSET_ADDR,
> > +                                            &raw_val, 2);
> > +                     if (ret < 0)
> > +                             return ret;
> > +                     *val = -(s16)le16_to_cpu(raw_val);
>
> A comment for the negative is probably a good thing to have.

Of course

> > +             }
> > +             *val2 = 0;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val = 1;
> > +             switch (chan->type) {
> > +             case IIO_GRAVITY:
> > +                     /* Table 3-35: 1 m/s^2 = 100 LSB */
> > +             case IIO_ACCEL:
> > +                     /* Table 3-17: 1 m/s^2 = 100 LSB */
> > +                     *val2 = 100;
> > +                     break;
> > +             case IIO_MAGN:
> > +                     /*
> > +                      * Table 3-19: 1 uT = 16 LSB.  But we need
> > +                      * Gauss: 1G = 0.1 uT.
> > +                      */
> > +                     *val2 = 160;
> > +                     break;
> > +             case IIO_ANGL_VEL:
> > +                     /* Table 3-22: 1 Rps = 900 LSB */
> > +                     *val2 = 900;
> > +                     break;
> > +             case IIO_ROT:
> > +                     /* Table 3-28: 1 degree = 16 LSB */
> > +                     *val2 = 16;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             return IIO_VAL_FRACTIONAL;
> > +     default:
> > +             return -EINVAL;
> > +
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             if (chan->type == IIO_MAGN)
> > +                     return bno055_get_mag_odr(priv, val, val2);
> > +             else
> > +                     return -EINVAL;
> > +
> > +     case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +             switch (chan->type) {
> > +             case IIO_ANGL_VEL:
> > +                     return bno055_get_gyr_lpf(priv, val, val2);
> > +             case IIO_ACCEL:
> > +                     return bno055_get_acc_lpf(priv, val, val2);
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     }
> > +}
> > +
> > +static int bno055_read_temp_chan(struct iio_dev *indio_dev, int *val)
> > +{
> > +     struct bno055_priv *priv = iio_priv(indio_dev);
> > +     unsigned int raw_val;
> > +     int ret;
> > +
> > +     ret = regmap_read(priv->regmap, BNO055_TEMP_REG, &raw_val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     /*
> > +      * Tables 3-36 and 3-37: one byte of priv, signed, 1 LSB = 1C.
> > +      * ABI wants milliC.
> > +      */
> > +     *val = raw_val * 1000;
> > +
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +static int bno055_read_quaternion(struct iio_dev *indio_dev,
> > +                               struct iio_chan_spec const *chan,
> > +                               int size, int *vals, int *val_len,
> > +                               long mask)
> > +{
> > +     struct bno055_priv *priv = iio_priv(indio_dev);
> > +     __le16 raw_vals[4];
> > +     int i, ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             if (size < 4)
> > +                     return -EINVAL;
> > +             ret = regmap_bulk_read(priv->regmap,
> > +                                    BNO055_QUAT_DATA_W_LSB_REG,
> > +                                    raw_vals, sizeof(raw_vals));
> > +             if (ret < 0)
> > +                     return ret;
> > +             for (i = 0; i < 4; i++)
> > +                     vals[i] = (s16)le16_to_cpu(raw_vals[i]);
> > +             *val_len = 4;
> > +             return IIO_VAL_INT_MULTIPLE;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             /* Table 3-31: 1 quaternion = 2^14 LSB */
> > +             if (size < 2)
> > +                     return -EINVAL;
> > +             vals[0] = 1;
> > +             vals[1] = 1 << 14;
> > +             return IIO_VAL_FRACTIONAL;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int _bno055_read_raw_multi(struct iio_dev *indio_dev,
> > +                               struct iio_chan_spec const *chan,
> > +                               int size, int *vals, int *val_len,
> > +                               long mask)
> > +{
> > +     switch (chan->type) {
> > +     case IIO_MAGN:
> > +     case IIO_ACCEL:
> > +     case IIO_ANGL_VEL:
> > +     case IIO_GRAVITY:
> > +             if (size < 2)
> > +                     return -EINVAL;
> > +             *val_len = 2;
> > +             return bno055_read_simple_chan(indio_dev, chan,
> > +                                            &vals[0], &vals[1],
> > +                                            mask);
> > +
> > +     case IIO_TEMP:
> > +             *val_len = 1;
> > +             return bno055_read_temp_chan(indio_dev, &vals[0]);
> > +
> > +     case IIO_ROT:
>
> Hmm. Rot is currently defined in the ABI docs only for compass rotations.
> If you would fix that it would be much appreciated.
>
> We also have usecases for quaternion which is well defined and for tilt
> angle, but not as far as I can see a euler angle use case.
>
> We need to close that gap which needs 3 more modifiers to specify which
> angle is which.  Or we could tell people to learn how to deal with
> rotations in a safe and reliable way with out gimbal lock ;)

Ah, you are answering here to what I asked you above :)
I think that it would be much easier for me to update the DOC, rather
than teaching people how to use quaternions ;)

> > +             /*
> > +              * Rotation is exposed as either a quaternion or three
> > +              * Euler angles.
> > +              */
> > +             if (chan->channel2 == IIO_MOD_QUATERNION)
> > +                     return bno055_read_quaternion(indio_dev, chan,
> > +                                                   size, vals,
> > +                                                   val_len, mask);
> > +             if (size < 2)
> > +                     return -EINVAL;
> > +             *val_len = 2;
> > +             return bno055_read_simple_chan(indio_dev, chan,
> > +                                            &vals[0], &vals[1],
> > +                                            mask);
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int bno055_read_raw_multi(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan,
> > +                              int size, int *vals, int *val_len,
> > +                              long mask)
> > +{
> > +     int ret;
> > +     struct bno055_priv *priv = iio_priv(indio_dev);
> > +
> > +     mutex_lock(&priv->lock);
> > +     ret = _bno055_read_raw_multi(indio_dev, chan, size,
> > +                                  vals, val_len, mask);
> > +     mutex_unlock(&priv->lock);
> > +     return ret;
> > +}
> > +
> > +static int _bno055_write_raw(struct iio_dev *iio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int val, int val2, long mask)
> > +{
> > +     struct bno055_priv *priv = iio_priv(iio_dev);
> > +
> > +     switch (chan->type) {
> > +     case IIO_MAGN:
> > +             switch (mask) {
> > +             case IIO_CHAN_INFO_SAMP_FREQ:
> > +                     return bno055_set_mag_odr(priv, val, val2);
> > +
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +             break;
> > +     case IIO_ACCEL:
> > +             switch (mask) {
> > +             case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +                     return bno055_set_acc_lpf(priv, val, val2);
> > +
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     case IIO_ANGL_VEL:
> > +             switch (mask) {
> > +             case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +                     return bno055_set_gyr_lpf(priv, val, val2);
> > +             }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int bno055_write_raw(struct iio_dev *iio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int val, int val2, long mask)
> > +{
> > +     int ret;
> > +     struct bno055_priv *priv = iio_priv(iio_dev);
> > +
> > +     mutex_lock(&priv->lock);
> > +     ret = _bno055_write_raw(iio_dev, chan, val, val2, mask);
> > +     mutex_unlock(&priv->lock);
> > +
> > +     return ret;
> > +}
> > +
> > +static ssize_t in_magn_sampling_frequency_available_show(struct device *dev,
> > +                                                      struct device_attribute *attr,
> > +                                                      char *buf)
> > +{
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +                      (priv->operation_mode != BNO055_OPR_MODE_AMG) ? "20" :
> > +                      "2 6 8 10 15 20 25 30");
> > +}
> > +
> > +static ssize_t in_accel_range_available_show(struct device *dev,
> > +                                          struct device_attribute *attr,
> > +                                          char *buf)
> > +{
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +                      (priv->operation_mode != BNO055_OPR_MODE_AMG) ? "4" :
> > +                      "2 4 8 16");
> > +}
> > +
> > +static ssize_t
> > +in_accel_filter_low_pass_3db_frequency_available_show(struct device *dev,
> > +                                                   struct device_attribute *attr,
> > +                                                   char *buf)
> > +{
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +                      (priv->operation_mode != BNO055_OPR_MODE_AMG) ? "62.5" :
> > +                      "7.81 15.63 31.25 62.5 125 250 500 1000");
> > +}
> > +
> > +static ssize_t in_anglvel_range_available_show(struct device *dev,
> > +                                            struct device_attribute *attr,
> > +                                            char *buf)
> > +{
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +                      (priv->operation_mode != BNO055_OPR_MODE_AMG) ? "2000" :
> > +                      "125 250 500 1000 2000");
> > +}
> > +
> > +static ssize_t
> > +in_anglvel_filter_low_pass_3db_frequency_available_show(struct device *dev,
> > +                                                     struct device_attribute *attr,
> > +                                                     char *buf)
> > +{
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +                      (priv->operation_mode != BNO055_OPR_MODE_AMG) ? "32" :
> > +                       "12 23 47 32 64 116 230 523");
> > +}
> > +
> > +static ssize_t bno055_operation_mode_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *buf)
> > +{
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n",
> > +                      (priv->operation_mode == BNO055_OPR_MODE_AMG) ? "amg" :
> > +                      (priv->operation_mode == BNO055_OPR_MODE_FUSION) ?
> > +                      "fusion" : "fusion_fmc_off");
> > +}
> > +
> > +static ssize_t bno055_operation_mode_store(struct device *dev,
> > +                                        struct device_attribute *attr,
> > +                                        const char *buf, size_t len)
> > +{
> > +     int res;
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     if (sysfs_streq(buf, "amg"))
> > +             priv->operation_mode = BNO055_OPR_MODE_AMG;
> > +     else if (sysfs_streq(buf, "fusion"))
> > +             priv->operation_mode = BNO055_OPR_MODE_FUSION;
> > +     else if (sysfs_streq(buf, "fusion_fmc_off"))
> > +             priv->operation_mode = BNO055_OPR_MODE_FUSION_FMC_OFF;
> > +     else
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&priv->lock);
> > +     res = bno055_reg_write(priv, BNO055_OPR_MODE_REG,
> > +                            BNO055_OPR_MODE_CONFIG);
> > +     if (res) {
> > +             mutex_unlock(&priv->lock);
> > +             return res;
> > +     }
> > +
> > +     res = bno055_reg_write(priv, BNO055_OPR_MODE_REG, priv->operation_mode);
> > +     mutex_unlock(&priv->lock);
> > +
> > +     return res ? res : len;
> > +}
> > +
> > +static ssize_t bno055_in_accel_range_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *buf)
> > +{
> > +     int val;
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     int res = bno055_get_acc_range(priv, &val, NULL);
> > +
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%d\n", val);
> > +}
> > +
> > +static ssize_t bno055_in_accel_range_store(struct device *dev,
> > +                                        struct device_attribute *attr,
> > +                                        const char *buf, size_t len)
> > +{
> > +     int ret;
> > +     unsigned long val;
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     ret = kstrtoul(buf, 10, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_lock(&priv->lock);
> > +     ret = bno055_set_acc_range(priv, val, 0);
> > +     mutex_unlock(&priv->lock);
> > +
> > +     return ret ? ret : len;
> > +}
> > +
> > +static ssize_t bno055_in_gyr_range_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     int val;
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +     int res = bno055_get_gyr_range(priv, &val, NULL);
> > +
> > +     if (res < 0)
> > +             return res;
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%d\n", val);
> > +}
> > +
> > +static ssize_t bno055_in_gyr_range_store(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      const char *buf, size_t len)
> > +{
> > +     int ret;
> > +     unsigned long val;
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     ret = kstrtoul(buf, 10, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_lock(&priv->lock);
> > +     ret = bno055_set_gyr_range(priv, val, 0);
> > +     mutex_unlock(&priv->lock);
> > +
> > +     return ret ? ret : len;
> > +}
> > +
> > +static ssize_t bno055_get_calib_status(struct device *dev, char *buf, int which)
> > +{
> > +     int val;
> > +     int ret;
> > +     const char *calib_str;
> > +     static const char * const calib_status[] = {"bad", "barely enough",
> > +                                                "fair", "good"};
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     if (priv->operation_mode == BNO055_OPR_MODE_AMG ||
> > +         (priv->operation_mode == BNO055_OPR_MODE_FUSION_FMC_OFF &&
> > +          which == BNO055_CALIB_STAT_MAGN_SHIFT)) {
> > +             calib_str = "idle";
> > +     } else {
> > +             mutex_lock(&priv->lock);
> > +             ret = bno055_reg_read(priv, BNO055_CALIB_STAT_REG, &val);
> > +             mutex_unlock(&priv->lock);
> > +
> > +             if (ret)
> > +                     return -EIO;
> > +
> > +             val = (val >> which) & BNO055_CALIB_STAT_MASK;
> > +             calib_str = calib_status[val];
> > +     }
> > +
> > +     return scnprintf(buf, PAGE_SIZE, "%s\n", calib_str);
> > +}
> > +
> > +static ssize_t in_calibration_data_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     int ret;
> > +     int size;
> > +     int i;
> > +     u8 data[BNO055_CALDATA_LEN];
> > +     struct bno055_priv *priv = iio_priv(dev_to_iio_dev(dev));
> > +
> > +     mutex_lock(&priv->lock);
> > +     ret = bno055_reg_write(priv, BNO055_OPR_MODE_REG,
> > +                            BNO055_OPR_MODE_CONFIG);
> > +     if (ret)
> > +             goto unlock;
> > +
> > +     ret = regmap_bulk_read(priv->regmap, BNO055_CALDATA_START, data,
> > +                            BNO055_CALDATA_LEN);
> > +     if (ret)
> > +             goto unlock;
> > +
> > +     ret = bno055_reg_write(priv, BNO055_OPR_MODE_REG, priv->operation_mode);
> > +     mutex_unlock(&priv->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     for (size = 0, i = 0; i < BNO055_CALDATA_LEN; i++) {
> > +             ret = scnprintf(buf + size,
> > +                             PAGE_SIZE - size, "%02x%c", data[i],
> > +                             (i + 1 < BNO055_CALDATA_LEN) ? ' ' : '\n');
> > +             if (ret < 0)
> > +                     return ret;
> > +             size += ret;
> > +     }
> > +
> > +     return size;
> > +unlock:
> > +     mutex_unlock(&priv->lock);
> > +     return ret;
> > +}
> > +
> > +static ssize_t in_autocalibration_status_sys_show(struct device *dev,
> > +                                               struct device_attribute *a,
> > +                                               char *buf)
> > +{
> > +     return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_SYS_SHIFT);
> > +}
> > +
> > +static ssize_t in_autocalibration_status_accel_show(struct device *dev,
> > +                                                 struct device_attribute *a,
> > +                                                 char *buf)
> > +{
> > +     return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_ACCEL_SHIFT);
> > +}
> > +
> > +static ssize_t in_autocalibration_status_gyro_show(struct device *dev,
> > +                                                struct device_attribute *a,
> > +                                                char *buf)
> > +{
> > +     return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_GYRO_SHIFT);
> > +}
> > +
> > +static ssize_t in_autocalibration_status_magn_show(struct device *dev,
> > +                                                struct device_attribute *a,
> > +                                                char *buf)
> > +{
> > +     return bno055_get_calib_status(dev, buf, BNO055_CALIB_STAT_MAGN_SHIFT);
> > +}
> > +
> > +static IIO_DEVICE_ATTR_RO(in_magn_sampling_frequency_available,
> > +                       0);
> > +
> > +static IIO_DEVICE_ATTR(operation_mode, 0644,
> > +                    bno055_operation_mode_show,
> > +                    bno055_operation_mode_store, 0);
> > +
> > +static IIO_CONST_ATTR(operation_mode_available,
> > +                   "amg fusion fusion_fmc_off");
>
> Hmm. This is going to be very hard for userspace apps to know what to do with.
> 99% of the time you are going to end up with the default as a result.
> If there is any way to map these to actual features enabled, then that will make
> them more likely to be used as will map to standard ABI.

As long as we have only those modes, then maybe yes:
We can have two attributes "fusion_enable" and "mag_autocal_enable"
(or something like that).
But it would probably become more difficoult to support other IMU
modes HW provides.

Also I wonder if that wouldn't get things more difficoult to
understand: changing modes have side effects (for example enabling
fusion mode locks settings for accelerometer and gyroscope); even if
we document them, I guess that someone might want to read the IMU
datasheet (and the information scattered on the internet) to better
understand what fits her/his usecase. If we stick with the idea of
"modes" it would be much easier to make the link wrt documentation.

> > +
> > +static IIO_DEVICE_ATTR(in_accel_range, 0644,
> > +                    bno055_in_accel_range_show,
> > +                    bno055_in_accel_range_store, 0);
> > +
> > +static IIO_DEVICE_ATTR_RO(in_accel_range_available, 0);
> > +static IIO_DEVICE_ATTR_RO(in_accel_filter_low_pass_3db_frequency_available, 0);
> > +
> > +static IIO_DEVICE_ATTR(in_anglvel_range, 0644,
> > +                    bno055_in_gyr_range_show,
> > +                    bno055_in_gyr_range_store, 0);
> > +
> > +static IIO_DEVICE_ATTR_RO(in_anglvel_range_available, 0);
> > +static IIO_DEVICE_ATTR_RO(in_anglvel_filter_low_pass_3db_frequency_available, 0);
> > +
> > +static IIO_DEVICE_ATTR_RO(in_autocalibration_status_sys, 0);
> > +static IIO_DEVICE_ATTR_RO(in_autocalibration_status_accel, 0);
> > +static IIO_DEVICE_ATTR_RO(in_autocalibration_status_gyro, 0);
> > +static IIO_DEVICE_ATTR_RO(in_autocalibration_status_magn, 0);
> > +static IIO_DEVICE_ATTR_RO(in_calibration_data, 0);
> > +
> > +static struct attribute *bno055_attrs[] = {
> > +     &iio_dev_attr_in_magn_sampling_frequency_available.dev_attr.attr,
> > +     &iio_dev_attr_in_accel_range_available.dev_attr.attr,
> > +     &iio_dev_attr_in_accel_range.dev_attr.attr,
>
> There is a bunch of ABI here that either belongs in as _avail callbacks etc
> or is non standard an hence needs documentation under
> Documentation/ABI/testing/sysfs-bus-iio*

Will check..

>
> > +     &iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> > +     &iio_dev_attr_in_anglvel_range_available.dev_attr.attr,
>
> Hmm. Range typically maps to something else (normally scale, but these smart
> sensors can do weird things)

Here the scaling doesn't change, just the range. I *think* that by
changing range you also get better or worse precision.

> > +     &iio_dev_attr_in_anglvel_range.dev_attr.attr,
> > +     &iio_dev_attr_in_anglvel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> > +     &iio_const_attr_operation_mode_available.dev_attr.attr,
> > +     &iio_dev_attr_operation_mode.dev_attr.attr,
> > +     &iio_dev_attr_in_autocalibration_status_sys.dev_attr.attr,
> > +     &iio_dev_attr_in_autocalibration_status_accel.dev_attr.attr,
> > +     &iio_dev_attr_in_autocalibration_status_gyro.dev_attr.attr,
> > +     &iio_dev_attr_in_autocalibration_status_magn.dev_attr.attr,
> > +     &iio_dev_attr_in_calibration_data.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group bno055_attrs_group = {
> > +     .attrs = bno055_attrs,
> > +};
> > +
> > +static const struct iio_info bno055_info = {
> > +     .read_raw_multi = bno055_read_raw_multi,
> > +     .write_raw = bno055_write_raw,
> > +     .attrs = &bno055_attrs_group,
> > +};
> > +
> > +/*
> > + * Reads len samples from the HW, stores them in buf starting from buf_idx,
> > + * and applies mask to cull (skip) unneeded samples.
> > + * Updates buf_idx incrementing with the number of stored samples.
> > + * Samples from HW are xferred into buf, then in-place copy on buf is
> > + * performed in order to cull samples that need to be skipped.
> > + * This avoids copies of the first samples until we hit the 1st sample to skip,
> > + * and also avoids having an extra bounce buffer.
> > + * buf must be able to contain len elements inspite of how many samples we are
> > + * going to cull.
> > + */
> > +static int bno055_scan_xfer(struct bno055_priv *priv,
> > +                         int start_ch, int len, unsigned long mask,
> > +                         __le16 *buf, int *buf_idx)
> > +{
> > +     int buf_base = *buf_idx;
> > +     const int base = BNO055_ACC_DATA_X_LSB_REG;
> > +     int ret;
> > +     int i, j, n;
> > +     __le16 *dst, *src;
> > +     bool quat_in_read = false;
> > +     int offs_fixup = 0;
> > +     int xfer_len = len;
> > +
> > +     /* All chans are made up 1 16bit sample, except for quaternion
> > +      * that is made up 4 16-bit values.
> > +      * For us the quaternion CH is just like 4 regular CHs.
> > +      * If out read starts past the quaternion make sure to adjust the
> > +      * starting offset; if the quaternion is contained in our scan then
> > +      * make sure to adjust the read len.
> > +      */
> > +     if (start_ch > BNO055_SCAN_QUATERNION) {
> > +             start_ch += 3;
> > +     } else if ((start_ch <= BNO055_SCAN_QUATERNION) &&
> > +              ((start_ch + len) > BNO055_SCAN_QUATERNION)) {
> > +             quat_in_read = true;
> > +             xfer_len += 3;
> > +     }
> > +
> > +     ret = regmap_bulk_read(priv->regmap,
> > +                            base + start_ch * sizeof(__le16),
> > +                            buf + buf_base,
> > +                            xfer_len * sizeof(__le16));
> > +     if (ret)
> > +             return ret;
> > +
> > +     for_each_set_bit(i, &mask, len) {
> > +             if (quat_in_read && ((start_ch + i) > BNO055_SCAN_QUATERNION))
> > +                     offs_fixup = 3;
> > +
> > +             dst = buf + *buf_idx;
> > +             src = buf + buf_base + offs_fixup + i;
> > +
> > +             n = ((start_ch + i) == BNO055_SCAN_QUATERNION) ? 4 : 1;
> > +
> > +             if (dst != src) {
> > +                     for (j = 0; j < n; j++)
> > +                             dst[j] = src[j];
> > +             }
> > +
> > +             *buf_idx += n;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t bno055_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf = p;
> > +     struct iio_dev *iio_dev = pf->indio_dev;
> > +     struct bno055_priv *priv = iio_priv(iio_dev);
> > +     struct {
> > +             __le16 chans[(BNO055_GRAVITY_DATA_Z_LSB_REG -
> > +                           BNO055_ACC_DATA_X_LSB_REG) / 2];
>
> Does this have potential holes?  I'm guessing it probable does. As such
> you want to memset the whole thing to 0 in order to ensure you can't leak
> kernel data.  One of the advantages of putting this in the priv()
> structure rather than on the stack is that you can rely on that being zeroed
> once and after that all you can leak is stale readings which are very unlikely
> to be a security issue!  Note that you would have a problem even without holes
> if only some channels are enabled.

I'm not sure if there are holes, but I see your point. I will go for a
zeroed buffer in priv.

> > +             s64 timestamp __aligned(8);
> > +     } buf;
> > +     bool thr_hit;
> > +     int quat;
> > +     int ret;
> > +     int start, end, xfer_start, next = 0;
> > +     int buf_idx = 0;
> > +     bool finish = false;
> > +     unsigned long mask;
> > +
> > +     /* we have less than 32 chs, all masks fit in an ulong */
> > +     start = find_first_bit(iio_dev->active_scan_mask, iio_dev->masklength);
> > +     xfer_start = start;
> > +     if (start == iio_dev->masklength)
> > +             goto done;
> > +
> > +     mutex_lock(&priv->lock);
> > +     while (!finish) {
> > +             end = find_next_zero_bit(iio_dev->active_scan_mask,
> > +                                      iio_dev->masklength, start);
> > +             if (end == iio_dev->masklength) {
> > +                     finish = true;
> > +             } else {
> > +                     next = find_next_bit(iio_dev->active_scan_mask,
> > +                                          iio_dev->masklength, end);
> > +                     if (next == iio_dev->masklength) {
> > +                             finish = true;
> > +                     } else {
> > +                             quat = ((next > BNO055_SCAN_QUATERNION) &&
> > +                                     (end <= BNO055_SCAN_QUATERNION)) ? 3 : 0;
> > +                             thr_hit = (next - end + quat) >
> > +                                     priv->xfer_burst_break_thr;
> > +                     }
> > +             }
> > +
> > +             if (thr_hit || finish) {
> > +                     mask = *iio_dev->active_scan_mask >> xfer_start;
> > +                     ret = bno055_scan_xfer(priv, xfer_start,
> > +                                            end - xfer_start,
> > +                                            mask, buf.chans, &buf_idx);
> > +                     if (ret)
> > +                             goto done;
> > +                     xfer_start = next;
> > +             }
> > +             start = next;
> > +     }
> > +     iio_push_to_buffers_with_timestamp(iio_dev, &buf, pf->timestamp);
> > +done:
> > +     mutex_unlock(&priv->lock);
> > +     iio_trigger_notify_done(iio_dev->trig);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +int bno055_probe(struct device *dev, struct regmap *regmap, int irq,
> > +              int xfer_burst_break_thr)
> > +{
> > +     int ver, rev;
> > +     int res;
> > +     unsigned int val;
> > +     struct gpio_desc *rst;
> > +     struct iio_dev *iio_dev;
> > +     struct bno055_priv *priv;
> > +     /* base name + separator + UID + ext + zero */
> > +     char fw_name_buf[sizeof(BNO055_FW_NAME BNO055_FW_EXT) +
> > +                      BNO055_UID_LEN * 2 + 1 + 1];
> > +     const struct firmware *caldata;
> > +
> > +     iio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> > +     if (!iio_dev)
> > +             return -ENOMEM;
> > +
> > +     iio_dev->name = "bno055";
> > +     priv = iio_priv(iio_dev);
> > +     memset(priv, 0, sizeof(*priv));
>
> No need. It is kzalloc'd by the IIO core.

OK

> > +     mutex_init(&priv->lock);
> > +     priv->regmap = regmap;
> > +     priv->dev = dev;
> > +     priv->xfer_burst_break_thr = xfer_burst_break_thr;
> > +     rst = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > +     if (IS_ERR(rst) && (PTR_ERR(rst) != -EPROBE_DEFER)) {
> > +             dev_err(dev, "Failed to get reset GPIO");
> > +             return PTR_ERR(rst);
> > +     }
> > +
> > +     priv->clk = devm_clk_get_optional(dev, "clk");
> > +     if (IS_ERR(priv->clk) && (PTR_ERR(priv->clk) != -EPROBE_DEFER)) {
>
> Why carry on if we get DEFER?  If that happens we want to return it
> and back off for now.  dev_err_probe() will handle only printing no defer errors.

Sure. This is obviously a bug :)  I'll go with dev_err_probe().

> > +             dev_err(dev, "Failed to get CLK");
> > +             return PTR_ERR(priv->clk);
> > +     }
> > +
> > +     clk_prepare_enable(priv->clk);
> > +
> > +     if (rst) {
> > +             usleep_range(5000, 10000);
> > +             gpiod_set_value_cansleep(rst, 0);
> > +             usleep_range(650000, 750000);
> > +     }
> > +
> > +     res = devm_add_action_or_reset(dev, bno055_uninit, priv);
> > +     if (res)
> > +             return res;
> > +
> > +     res = bno055_reg_read(priv, BNO055_CHIP_ID_REG, &val);
> > +     if (res)
> > +             return res;
> > +
> > +     if (val != BNO055_CHIP_ID_MAGIC) {
> > +             dev_err(dev, "Unrecognized chip ID 0x%x", val);
> > +             return -ENODEV;
> > +     }
> > +     dev_dbg(dev, "Found BMO055 chip");
>
> I'd clean this sort of debug out from a final submission. It's kind
> of handy during driver writing, but very unlikely to be much use
> to anyone after the driver 'works'.

Altought I really cannot understand why maintainers tends to ask for
killing log prints, even if they are silenced out by not enabling
debug prints, (indeed people are supposed to enable debug prints when
thinks breaks, and they want as much clues as possible), but OK, I'll
kill it.

> > +
> > +     res = regmap_bulk_read(priv->regmap, BNO055_UID_REG,
> > +                            priv->uid, BNO055_UID_LEN);
> > +     if (res)
> > +             return res;
> > +
> > +     dev_info(dev, "unique ID: %*ph", BNO055_UID_LEN, priv->uid);
>
> As below, looks like debugfs material rather than kernel log.

No, this is needed: the calibration data has to be stored in a file in
/lib/firmware; the driver looks, in sequence, for two file names; the
first one has the unique id embedded in the name. So you need to know
it..

If you have more than one IMU connected to your CPU, then you really
need several calibration files, one for each IMU, and the unique ID
distinguish them (on the other hand, if you have only one, you can
fallback to the second file name, which does not contain the ID).. I
think I have explained this stuff in the series cover letter.

Maybe we can expose this in an attribute instead of printing in the kernel log?

> > +
> > +     /*
> > +      * This has nothing to do with the IMU firmware, this is for sensor
> > +      * calibration data.
>
> Interesting.  So we have some similar cases where we use sysfs to load
> this sort of calibration data.  That's on the basis we are getting
> it from there in the first place and it may want tweaking at runtime.
> Does this need to be in place before we initialize the device?

Unsure if we can reload it after initialization; possbly yes. But I
don't see any reason to start with an uncalibrated IMU; I really would
love to get correct data as soon as I read them :)

.. But IMHO: AFAIK firmware interface is here explicitly also to
assist loading calibration data; why to reinvent the wheel ?

BTW, if we really think someone want to tweak calibration data, then
we can make the calibration data attribute R/W anyway (this doesn't
need the initial load to be dropped). In this case,  wouldn't it be
better to stick with HEX format, rather than to switch to binary, as
being discussed in other mails?

> > +      */
> > +     sprintf(fw_name_buf, BNO055_FW_NAME "-%*phN" BNO055_FW_EXT,
> > +             BNO055_UID_LEN, priv->uid);
> > +     res = request_firmware(&caldata, fw_name_buf, dev);
> > +     if (res)
> > +             res = request_firmware(&caldata,
> > +                                    BNO055_FW_NAME BNO055_FW_EXT, dev);
> > +
> > +     if (res) {
> > +             dev_notice(dev, "Failed to load calibration data firmware file; this has nothing to do with IMU main firmware.");
> > +             dev_notice(dev, "You can calibrate your IMU (look for 'in_autocalibration_status*' files in sysfs) and then copy 'in_calibration_data' to your firmware file");
> > +             caldata = NULL;
> > +     }
> > +
> > +     res = bno055_init(priv, caldata);
> > +     if (res)
> > +             return res;
> > +
> > +     if (caldata)
> > +             release_firmware(caldata);
> > +
> > +     res = regmap_read(priv->regmap,
> > +                       BNO055_SW_REV_LSB_REG, &rev);
> > +     if (res)
> > +             return res;
> > +
> > +     res = regmap_read(priv->regmap,
> > +                       BNO055_SW_REV_MSB_REG, &ver);
>
> Some of these don't need wrapping.

OK

>
>
> > +     if (res)
> > +             return res;
> > +
> > +     dev_info(dev, "Firmware version %x.%x", ver, rev);
>
> May be better exposed in debugfs so it is available when needed but doesn't make the
> kernel log noisier than necessary.

OK

> > +
> > +     iio_dev->channels = bno055_channels;
> > +     iio_dev->num_channels = ARRAY_SIZE(bno055_channels);
> > +     iio_dev->info = &bno055_info;
> > +     iio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +     res = devm_iio_triggered_buffer_setup(dev, iio_dev,
> > +                                           iio_pollfunc_store_time,
> > +                                           bno055_trigger_handler, NULL);
> > +     if (res)
> > +             return res;
> > +
> > +     return devm_iio_device_register(dev, iio_dev);
> > +}
> > +EXPORT_SYMBOL_GPL(bno055_probe);
> > +
> > +MODULE_AUTHOR("Andrea Merello <andrea.merello@iit.it>");
> > +MODULE_DESCRIPTION("Bosch BNO055 driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/iio/imu/bno055/bno055.h b/drivers/iio/imu/bno055/bno055.h
> > new file mode 100644
> > index 000000000000..163ab8068e7c
> > --- /dev/null
> > +++ b/drivers/iio/imu/bno055/bno055.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +#ifndef __BNO055_H__
> > +#define __BNO055_H__
> > +
> > +#include <linux/device.h>
>
> Just use
> struct device;
> and don't include device.h.

OK

> > +#include <linux/regmap.h>
> > +
> > +int bno055_probe(struct device *dev, struct regmap *regmap, int irq,
> > +              int xfer_burst_break_thr);
> > +extern const struct regmap_config bno055_regmap_config;
> > +
> > +#endif
>
