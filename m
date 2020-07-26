Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1891222DD20
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgGZIDy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGZIDx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jul 2020 04:03:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7CC0619D2;
        Sun, 26 Jul 2020 01:03:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c6so885602pje.1;
        Sun, 26 Jul 2020 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZTyjc2HyC6y85XH85GHGfkxauyRSIpAX3gHz59Ag1Iw=;
        b=Xe+FGX9+fKokaPq19WKF7qDWVyR1AC6auAyuEwEq6p+rGjs7K3HgCWD9XrCD6+EvdX
         O+qMnpA9xvupacz76B/w2X8uAO3dfwXBlwZ8j9EwdfVvj02+haNnFGawUD5Vy4hjQoD6
         tZRUDUMr9mKCt+f6PylmwXMNCnFRK/UBA+6nSF1f3rypUP1wNch/3el1750U9BVuRtfp
         hnywhWCh6kA6fpqj28Em78pXgd3Mrj1yvo+4sZYREifSGojpXy+tR9iuDULtJ8QIWrS4
         QXHRlNdxDJzetuUofCrripPQETo4pCRym0NeKauLua/smgbUpNOm9J8PC5CdyxqnYZUi
         RpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZTyjc2HyC6y85XH85GHGfkxauyRSIpAX3gHz59Ag1Iw=;
        b=gfIfTP0aj/LxAezwx4V8F+K/sHn6ZAwCEpWFlwdltGa3dxZEnwY7qiNpp1pFeL5K8E
         LXfM+dlPwTeJdNhQrXGXshUmAR0UyWOMUMIeh9GNRgO8tzEgnlgbbbpIni7sgaHJJffc
         PqSnqirljON4rRokz6cefoFbtkUugFW01NBloSNoDSe4t4lOwgYM8+hXEKduPON3Xlsq
         UQfRaPBpKAMsFkzggDZ3mtQCtxSQQh4a5e8C/f4U7/vebP/x5KyQW+lIXxHXQSf1oQWf
         L+j9nLSQgdB8o3sKg3fK6yzHbUF53OnUjtM1yUSr60+TsRWoS33PVK7LqFZK9GMMe445
         G0gQ==
X-Gm-Message-State: AOAM531u26jsicQIG0papLfDDQ+5zuaoRMfIUF5cH2V2dhEbDEZaSsCL
        9tMkJ2Czj1dAE/M3UE3dmi+LZ6CGzvyxPvwOlwQ=
X-Google-Smtp-Source: ABdhPJwBkZlz+AFKAZS1BnWdC6ufmXDyAJeOomYuncVxG3RQPNnLtVHgPmIlLPc27ZwuCRqOGWUjAn5cQkfF+mZJS98=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr10823183pjp.228.1595750631935;
 Sun, 26 Jul 2020 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200724110159.24402-1-nish.malpani25@gmail.com>
In-Reply-To: <20200724110159.24402-1-nish.malpani25@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 11:03:35 +0300
Message-ID: <CAHp75VeiB_-r9X=tufYvO_fkD4GtjzvRqaY1sL_3FxCurXJMjg@mail.gmail.com>
Subject: Re: [v3 1/2] iio: gyro: Add driver support for ADXRS290
To:     Nishant Malpani <nish.malpani25@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        darius.berghe@analog.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 24, 2020 at 2:02 PM Nishant Malpani
<nish.malpani25@gmail.com> wrote:
>
> ADXRS290 is a high performance MEMS pitch and roll (dual-axis in-plane)
> angular rate sensor (gyroscope) designed for use in stabilization
> applications. It also features an internal temperature sensor and
> programmable high-pass and low-pass filters.
>
> Add support for ADXRS290 in direct-access mode for now.

Thanks for an update!
My nits below, after addressing them
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ADXRS290.pdf
> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> ---
>
> Changes in v3:
>   - drop "Link" tag & extra line in commit message
>   - rename cut-off frequencies tables to
>     'adxrs290_{lpf, hpf}_3db_freq_hz_table' to be more descriptive
>   - fix unsigned type errors
>   - add comments on how to scale raw angular velocity and temperature
>     values to appropriate units mentioned in the ABI
>   - re-order declarations in reversed spruce tree order
>   - remove 'indio_dev->dev.parent =3D &spi->dev' as the iio core handles =
it
>     during iio_device_alloc()
>   - use plain msleep() instead of the interruptible variant
>   - remove extra terminal comma
>
> Changes in v2:
>   - append copyright tag with author's info
>   - remove asm/unaligned.h header
>   - remove unnecessary comments about the registers' description
>   - rephrase comment on the usage of mutex_lock
>   - discard the usage of local tx, rx buffers; use DMA-safe buffers
>     provided by the SPI core instead
>   - utilize spi_w8r16 provided by the SPI core instead of writing a
>     wrapper over spi_sync_transfer which semantically does the same
>   - equip spi_write_then_read instead of plain spi_write since the
>     latter requires a DMA-safe buffer
>   - implement exact matching of filter 3db frequencies instead of
>     finding the "closest" match; rounding complexity is left to the
>     userspace
>   - include 'info_mask_shared_by_type_available' when initialising
>     iio_chan_spec instead of explicitly exposing attributes
>     signifying available filter 3db frequencies; with this we can
>     utilize read_avail core callback
> ---
>  MAINTAINERS                 |   6 +
>  drivers/iio/gyro/Kconfig    |  10 +
>  drivers/iio/gyro/Makefile   |   1 +
>  drivers/iio/gyro/adxrs290.c | 446 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 463 insertions(+)
>  create mode 100644 drivers/iio/gyro/adxrs290.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9077411c9890..71ae9b184179 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1098,6 +1098,12 @@ L:       linux-media@vger.kernel.org
>  S:     Maintained
>  F:     drivers/media/i2c/adv7842*
>
> +ANALOG DEVICES INC ADXRS290 DRIVER
> +M:     Nishant Malpani <nish.malpani25@gmail.com>
> +L:     linux-iio@vger.kernel.org
> +S:     Supported
> +F:     drivers/iio/gyro/adxrs290.c
> +
>  ANALOG DEVICES INC ASOC CODEC DRIVERS
>  M:     Lars-Peter Clausen <lars@metafoo.de>
>  M:     Nuno S=C3=A1 <nuno.sa@analog.com>
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 6daeddf37f60..024a34139875 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -41,6 +41,16 @@ config ADIS16260
>           This driver can also be built as a module.  If so, the module
>           will be called adis16260.
>
> +config ADXRS290
> +       tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI dr=
iver"
> +       depends on SPI
> +       help
> +         Say yes here to build support for Analog Devices ADXRS290 progr=
ammable
> +         digital output gyroscope.
> +
> +         This driver can also be built as a module. If so, the module wi=
ll be
> +         called adxrs290.
> +
>  config ADXRS450
>         tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI =
driver"
>         depends on SPI
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 45cbd5dc644e..0319b397dc3f 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ADIS16080) +=3D adis16080.o
>  obj-$(CONFIG_ADIS16130) +=3D adis16130.o
>  obj-$(CONFIG_ADIS16136) +=3D adis16136.o
>  obj-$(CONFIG_ADIS16260) +=3D adis16260.o
> +obj-$(CONFIG_ADXRS290) +=3D adxrs290.o
>  obj-$(CONFIG_ADXRS450) +=3D adxrs450.o
>  obj-$(CONFIG_BMG160) +=3D bmg160_core.o
>  obj-$(CONFIG_BMG160_I2C) +=3D bmg160_i2c.o
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> new file mode 100644
> index 000000000000..cff1af9211bc
> --- /dev/null
> +++ b/drivers/iio/gyro/adxrs290.c
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ADXRS290 SPI Gyroscope Driver
> + *
> + * Copyright (C) 2020 Nishant Malpani <nish.malpani25@gmail.com>
> + * Copyright (C) 2020 Analog Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>

> +#include <linux/device.h>
> +#include <linux/delay.h>

Keep it ordered?

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define ADXRS290_ADI_ID                0xAD
> +#define ADXRS290_MEMS_ID       0x1D
> +#define ADXRS290_DEV_ID                0x92
> +
> +#define ADXRS290_REG_ADI_ID    0x00
> +#define ADXRS290_REG_MEMS_ID   0x01
> +#define ADXRS290_REG_DEV_ID    0x02
> +#define ADXRS290_REG_REV_ID    0x03
> +#define ADXRS290_REG_SN0       0x04 /* Serial Number Registers, 4 bytes =
*/
> +#define ADXRS290_REG_DATAX0    0x08 /* Roll Rate o/p Data Regs, 2 bytes =
*/
> +#define ADXRS290_REG_DATAY0    0x0A /* Pitch Rate o/p Data Regs, 2 bytes=
 */
> +#define ADXRS290_REG_TEMP0     0x0C
> +#define ADXRS290_REG_POWER_CTL 0x10
> +#define ADXRS290_REG_FILTER    0x11
> +#define ADXRS290_REG_DATA_RDY  0x12
> +
> +#define ADXRS290_READ          BIT(7)
> +#define ADXRS290_TSM           BIT(0)
> +#define ADXRS290_MEASUREMENT   BIT(1)
> +#define ADXRS290_SYNC          GENMASK(1, 0)
> +#define ADXRS290_LPF_MASK      GENMASK(2, 0)
> +#define ADXRS290_LPF(x)                FIELD_PREP(ADXRS290_LPF_MASK, x)
> +#define ADXRS290_HPF_MASK      GENMASK(7, 4)
> +#define ADXRS290_HPF(x)                FIELD_PREP(ADXRS290_HPF_MASK, x)
> +
> +#define ADXRS290_READ_REG(reg) (ADXRS290_READ | (reg))
> +
> +#define ADXRS290_MAX_TRANSITION_TIME_MS 100
> +
> +enum adxrs290_mode {
> +       STANDBY,
> +       MEASUREMENT,
> +};

Perhaps a prefix
ADXRS290_STANDBY,
etc.

> +struct adxrs290_state {
> +       struct spi_device       *spi;
> +       /* Serialize reads and their subsequent processing */
> +       struct mutex            lock;
> +       enum adxrs290_mode      mode;
> +       unsigned int            lpf_3db_freq_idx;
> +       unsigned int            hpf_3db_freq_idx;
> +};
> +
> +/*
> + * Available cut-off frequencies of the low pass filter in Hz.
> + * The integer part and fractional part are represented separately.
> + */
> +static const int adxrs290_lpf_3db_freq_hz_table[][2] =3D {
> +       [0] =3D {480, 0},
> +       [1] =3D {320, 0},
> +       [2] =3D {160, 0},
> +       [3] =3D {80, 0},
> +       [4] =3D {56, 600000},
> +       [5] =3D {40, 0},
> +       [6] =3D {28, 300000},
> +       [7] =3D {20, 0},
> +};
> +
> +/*
> + * Available cut-off frequencies of the high pass filter in Hz.
> + * The integer part and fractional part are represented separately.
> + */
> +static const int adxrs290_hpf_3db_freq_hz_table[][2] =3D {
> +       [0] =3D {0, 0},
> +       [1] =3D {0, 11000},
> +       [2] =3D {0, 22000},
> +       [3] =3D {0, 44000},
> +       [4] =3D {0, 87000},
> +       [5] =3D {0, 175000},
> +       [6] =3D {0, 350000},
> +       [7] =3D {0, 700000},
> +       [8] =3D {1, 400000},
> +       [9] =3D {2, 800000},
> +       [10] =3D {11, 300000},
> +};
> +
> +static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cm=
d,
> +                                 unsigned int *val)
> +{
> +       struct adxrs290_state *st =3D iio_priv(indio_dev);
> +       int ret =3D 0;
> +       int temp;
> +
> +       mutex_lock(&st->lock);
> +       temp =3D spi_w8r16(st->spi, cmd);
> +       if (temp < 0) {
> +               ret =3D temp;
> +               goto err_unlock;
> +       }
> +
> +       *val =3D temp;
> +
> +err_unlock:
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}
> +
> +static int adxrs290_get_temp_data(struct iio_dev *indio_dev, unsigned in=
t *val)
> +{
> +       const u8 cmd =3D ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
> +       struct adxrs290_state *st =3D iio_priv(indio_dev);
> +       int ret =3D 0;
> +       int temp;
> +
> +       mutex_lock(&st->lock);
> +       temp =3D spi_w8r16(st->spi, cmd);
> +       if (temp < 0) {
> +               ret =3D temp;
> +               goto err_unlock;
> +       }
> +
> +       /* extract lower 12 bits temperature reading */
> +       *val =3D temp & 0x0FFF;
> +
> +err_unlock:
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}
> +
> +static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u8 =
*val2)
> +{
> +       const u8 cmd =3D ADXRS290_READ_REG(ADXRS290_REG_FILTER);
> +       struct adxrs290_state *st =3D iio_priv(indio_dev);
> +       int ret =3D 0;
> +       short temp;
> +
> +       mutex_lock(&st->lock);
> +       temp =3D spi_w8r8(st->spi, cmd);
> +       if (temp < 0) {
> +               ret =3D temp;
> +               goto err_unlock;
> +       }
> +
> +       *val =3D FIELD_GET(ADXRS290_LPF_MASK, temp);
> +       *val2 =3D FIELD_GET(ADXRS290_HPF_MASK, temp);
> +
> +err_unlock:
> +       mutex_unlock(&st->lock);
> +       return ret;
> +}
> +
> +static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
> +                                 const u8 val)
> +{
> +       u8 buf[2];
> +
> +       buf[0] =3D reg;
> +       buf[1] =3D val;
> +
> +       return spi_write_then_read(spi, buf, ARRAY_SIZE(buf), NULL, 0);
> +}
> +
> +static int adxrs290_find_match(const int (*freq_tbl)[2], const int n,
> +                              const int val, const int val2)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < n; i++) {
> +               if (freq_tbl[i][0] =3D=3D val && freq_tbl[i][1] =3D=3D va=
l2)
> +                       return i;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
> +                                   const unsigned int lpf_idx,
> +                                   const unsigned int hpf_idx)
> +{
> +       struct adxrs290_state *st =3D iio_priv(indio_dev);
> +       u8 val;
> +
> +       val =3D ADXRS290_HPF(hpf_idx) | ADXRS290_LPF(lpf_idx);
> +
> +       return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
> +}
> +
> +static int adxrs290_initial_setup(struct iio_dev *indio_dev)
> +{
> +       struct adxrs290_state *st =3D iio_priv(indio_dev);
> +
> +       st->mode =3D MEASUREMENT;
> +
> +       return adxrs290_spi_write_reg(st->spi,
> +                                     ADXRS290_REG_POWER_CTL,
> +                                     ADXRS290_MEASUREMENT | ADXRS290_TSM=
);
> +}
> +
> +static int adxrs290_read_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int *val,
> +                            int *val2,
> +                            long mask)
> +{
> +       struct adxrs290_state *st =3D iio_priv(indio_dev);
> +       unsigned int t;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               switch (chan->type) {
> +               case IIO_ANGL_VEL:
> +                       ret =3D adxrs290_get_rate_data(indio_dev,
> +                                                    ADXRS290_READ_REG(ch=
an->address),
> +                                                    &t);

> +                       if (ret < 0)

Please, revisit all ' < 0' checks and drop ones that are not necessary
(above seems fine, but here and below are subject to revisit).

> +                               return ret;
> +                       *val =3D t;
> +                       return IIO_VAL_INT;
> +               case IIO_TEMP:
> +                       ret =3D adxrs290_get_temp_data(indio_dev, &t);
> +                       if (ret < 0)
> +                               return ret;
> +                       *val =3D t;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_ANGL_VEL:
> +                       /* 1 LSB =3D 0.005 degrees/sec */
> +                       *val =3D 0;
> +                       *val2 =3D 87266;
> +                       return IIO_VAL_INT_PLUS_NANO;
> +               case IIO_TEMP:
> +                       /* 1 LSB =3D 0.1 degrees Celsius */
> +                       *val =3D 100;
> +                       return IIO_VAL_INT;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               switch (chan->type) {
> +               case IIO_ANGL_VEL:
> +                       t =3D st->lpf_3db_freq_idx;
> +                       *val =3D adxrs290_lpf_3db_freq_hz_table[t][0];
> +                       *val2 =3D adxrs290_lpf_3db_freq_hz_table[t][1];
> +                       return IIO_VAL_INT_PLUS_MICRO;
> +               default:
> +                       return -EINVAL;
> +               }
> +       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +               switch (chan->type) {
> +               case IIO_ANGL_VEL:
> +                       t =3D st->hpf_3db_freq_idx;
> +                       *val =3D adxrs290_hpf_3db_freq_hz_table[t][0];
> +                       *val2 =3D adxrs290_hpf_3db_freq_hz_table[t][1];
> +                       return IIO_VAL_INT_PLUS_MICRO;
> +               default:
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int adxrs290_write_raw(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan,
> +                             int val,
> +                             int val2,
> +                             long mask)
> +{
> +       struct adxrs290_state *st =3D iio_priv(indio_dev);
> +       int lpf_idx, hpf_idx;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               lpf_idx =3D adxrs290_find_match(adxrs290_lpf_3db_freq_hz_=
table,
> +                                             ARRAY_SIZE(adxrs290_lpf_3db=
_freq_hz_table),
> +                                             val, val2);
> +               if (lpf_idx < 0)
> +                       return -EINVAL;
> +               /* caching the updated state of the low-pass filter */
> +               st->lpf_3db_freq_idx =3D lpf_idx;
> +               /* retrieving the current state of the high-pass filter *=
/
> +               hpf_idx =3D st->hpf_3db_freq_idx;
> +               return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_i=
dx);
> +       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +               hpf_idx =3D adxrs290_find_match(adxrs290_hpf_3db_freq_hz_=
table,
> +                                             ARRAY_SIZE(adxrs290_hpf_3db=
_freq_hz_table),
> +                                             val, val2);
> +               if (hpf_idx < 0)
> +                       return -EINVAL;
> +               /* caching the updated state of the high-pass filter */
> +               st->hpf_3db_freq_idx =3D hpf_idx;
> +               /* retrieving the current state of the low-pass filter */
> +               lpf_idx =3D st->lpf_3db_freq_idx;
> +               return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_i=
dx);
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int adxrs290_read_avail(struct iio_dev *indio_dev,
> +                              struct iio_chan_spec const *chan,
> +                              const int **vals, int *type, int *length,
> +                              long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               *vals =3D (const int *)adxrs290_lpf_3db_freq_hz_table;
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               /* Values are stored in a 2D matrix */
> +               *length =3D ARRAY_SIZE(adxrs290_lpf_3db_freq_hz_table) * =
2;
> +
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +               *vals =3D (const int *)adxrs290_hpf_3db_freq_hz_table;
> +               *type =3D IIO_VAL_INT_PLUS_MICRO;
> +               /* Values are stored in a 2D matrix */
> +               *length =3D ARRAY_SIZE(adxrs290_hpf_3db_freq_hz_table) * =
2;
> +
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +#define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {                         \
> +       .type =3D IIO_ANGL_VEL,                                          =
 \
> +       .address =3D reg,                                                =
 \
> +       .modified =3D 1,                                                 =
 \
> +       .channel2 =3D IIO_MOD_##axis,                                    =
 \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),                  =
 \
> +       .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |         =
 \
> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |              \
> +       BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),              \
> +       .info_mask_shared_by_type_available =3D                          =
 \
> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |              \
> +       BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),              \
> +}
> +
> +static const struct iio_chan_spec adxrs290_channels[] =3D {
> +       ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAX0, X),
> +       ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAY0, Y),
> +       {
> +               .type =3D IIO_TEMP,
> +               .address =3D ADXRS290_REG_TEMP0,
> +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +               BIT(IIO_CHAN_INFO_SCALE),
> +       },
> +};
> +
> +static const struct iio_info adxrs290_info =3D {
> +       .read_raw =3D &adxrs290_read_raw,
> +       .write_raw =3D &adxrs290_write_raw,
> +       .read_avail =3D &adxrs290_read_avail,
> +};
> +
> +static int adxrs290_probe(struct spi_device *spi)
> +{
> +       struct iio_dev *indio_dev;
> +       struct adxrs290_state *st;
> +       u8 val, val2;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st =3D iio_priv(indio_dev);
> +       st->spi =3D spi;
> +       spi_set_drvdata(spi, indio_dev);
> +
> +       indio_dev->name =3D "adxrs290";
> +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> +       indio_dev->channels =3D adxrs290_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(adxrs290_channels);
> +       indio_dev->info =3D &adxrs290_info;
> +
> +       val =3D spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
> +       if (val !=3D ADXRS290_ADI_ID) {
> +               dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
> +               return -ENODEV;
> +       }
> +
> +       val =3D spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
> +       if (val !=3D ADXRS290_MEMS_ID) {
> +               dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", val);
> +               return -ENODEV;
> +       }
> +
> +       val =3D spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
> +       if (val !=3D ADXRS290_DEV_ID) {
> +               dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", val);
> +               return -ENODEV;
> +       }
> +
> +       /* default mode the gyroscope starts in */
> +       st->mode =3D STANDBY;
> +
> +       /* switch to measurement mode and switch on the temperature senso=
r */
> +       ret =3D adxrs290_initial_setup(indio_dev);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* max transition time to measurement mode */
> +       msleep(ADXRS290_MAX_TRANSITION_TIME_MS);
> +
> +       ret =3D adxrs290_get_3db_freq(indio_dev, &val, &val2);
> +       if (ret < 0)
> +               return ret;
> +
> +       st->lpf_3db_freq_idx =3D val;
> +       st->hpf_3db_freq_idx =3D val2;
> +
> +       return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id adxrs290_of_match[] =3D {
> +       { .compatible =3D "adi,adxrs290" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, adxrs290_of_match);
> +
> +static struct spi_driver adxrs290_driver =3D {
> +       .driver =3D {
> +               .name =3D "adxrs290",
> +               .of_match_table =3D adxrs290_of_match,
> +       },
> +       .probe =3D adxrs290_probe,
> +};
> +module_spi_driver(adxrs290_driver);
> +
> +MODULE_AUTHOR("Nishant Malpani <nish.malpani25@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXRS290 Gyroscope SPI driver");
> +MODULE_LICENSE("GPL");
> --
> 2.20.1
>


--=20
With Best Regards,
Andy Shevchenko
