Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2435936AFAA
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 10:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhDZIVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhDZIVe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Apr 2021 04:21:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24DC061574;
        Mon, 26 Apr 2021 01:20:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so4720051pjj.3;
        Mon, 26 Apr 2021 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2ciH2+1ztRJQmELThIHS21rPqB7p1kTyEktcGsetJk=;
        b=gEV5OXUUXhVLwQ+z15lxcHjeEVR2mbikyr3f+FrWaUiAq9BqKvJ5KYMWRqoGbWgpmp
         HZ+ZF9bpBuRf9m0XReSKwbPaOLvcwqbjZzHbRvZGi/ivMDakPbuF0VkSaMuq3eFQvxet
         RI5oWYWs3g0/FvWrBIhd0IKfWEdAnX6X2XLB7siV9fIEXBQIvL003JdYPvy+yKgaaE7V
         XeKWHi8Tkj1OKLoOQVUA/oDoONnWUWOaHE1hAb2ZsQR+oZvdVZRvjKuHzYERBipAX1In
         S09uAtSULmDpYwtS6LCBp/LaLggSinYuTPWkPzblLfYl9X4c3ZDGOJcjx2qCPM26LFVb
         NDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2ciH2+1ztRJQmELThIHS21rPqB7p1kTyEktcGsetJk=;
        b=tBhNHPcsSnla5DZlnVDo6aEMid0xnmr6DKMpINHiiY1HZenVgPRsVSQm1SFuXrZgJw
         m3ckeUT6bC4EgKao8khVHwrg6H0EBVJZaUdiGjJe+vkv+5Mq68LmBmYyMPnwn7qOKfX4
         uiT83AELb1cCpDAa23akMw3lV3JXwwQICecum1Po/26FYB3jYBWfnpbtUoNkf2nwpgpt
         gvi4P7XDY1H9xcplZDsf/C38Ro/EJzxG9szaCx6br0nS5qlVyJZ3q2/pwYhiPutAR9DD
         Z4aKuVQcfHTh2HsPbJxpcPz4QO28lWCGjeNsEaNn/haSxX/oL0SYJx8hdS6PlIYEUDFd
         7GEA==
X-Gm-Message-State: AOAM532KO1DghDyu9JqEOmnE41dFd/xFqrp7pVLsaeclOjRdQzx8/wcm
        Mvn/rpZEU72i7CnkAiaPFCH4fLyCWynUJAq8C2QAkD/NIaA=
X-Google-Smtp-Source: ABdhPJyBca7lQrjkf8qfhybhW2/oEYj1J/RXtXuxlWCOXyKnY4CE4ASQKKios/Un9WQ68AZ+7TywIYIvvoEuWMp/fEY=
X-Received: by 2002:a17:90b:1c0f:: with SMTP id oc15mr20601128pjb.228.1619425252807;
 Mon, 26 Apr 2021 01:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210426081041.59807-1-tomas.melin@vaisala.com> <20210426081041.59807-3-tomas.melin@vaisala.com>
In-Reply-To: <20210426081041.59807-3-tomas.melin@vaisala.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 26 Apr 2021 11:20:36 +0300
Message-ID: <CAHp75Vd-RnvCmGRs=M7bMwxEd8WbfobPwvPxte81+HOzYvzB7Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: accel: Add driver for Murata SCA3300 accelerometer
To:     Tomas Melin <tomas.melin@vaisala.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 26, 2021 at 11:11 AM Tomas Melin <tomas.melin@vaisala.com> wrote:
>
> Add initial support for Murata SCA3300 3-axis industrial
> accelerometer with digital SPI interface. This device also
> provides a temperature measurement.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Datasheet: https://www.murata.com/en-global/products/sensor/accel/sca3300
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/accel/Kconfig   |  13 +
>  drivers/iio/accel/Makefile  |   1 +
>  drivers/iio/accel/sca3300.c | 472 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 486 insertions(+)
>  create mode 100644 drivers/iio/accel/sca3300.c
>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index cceda3cecbcf..0dbf7b648e8a 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -450,6 +450,19 @@ config SCA3000
>           To compile this driver as a module, say M here: the module will be
>           called sca3000.
>
> +config SCA3300
> +       tristate "Murata SCA3300 3-Axis Accelerometer Driver"
> +       depends on SPI
> +       select CRC8
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +         Say yes here to build support for Murata SCA3300 3-Axis
> +         accelerometer.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called sca3300.
> +
>  config STK8312
>         tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
>         depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 32cd1342a31a..4b56527a2b97 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_MXC4005)         += mxc4005.o
>  obj-$(CONFIG_MXC6255)          += mxc6255.o
>
>  obj-$(CONFIG_SCA3000)          += sca3000.o
> +obj-$(CONFIG_SCA3300)          += sca3300.o
>
>  obj-$(CONFIG_STK8312)          += stk8312.o
>  obj-$(CONFIG_STK8BA50)         += stk8ba50.o
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> new file mode 100644
> index 000000000000..f7ef8ecfd34a
> --- /dev/null
> +++ b/drivers/iio/accel/sca3300.c
> @@ -0,0 +1,472 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Murata SCA3300 3-axis industrial accelerometer
> + *
> + * Copyright (c) 2021 Vaisala Oyj. All rights reserved.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define SCA3300_ALIAS "sca3300"
> +
> +#define SCA3300_CRC8_POLYNOMIAL 0x1d
> +
> +/* Device mode register */
> +#define SCA3300_REG_MODE       0xd
> +#define SCA3300_MODE_SW_RESET  0x20
> +
> +/* Last register in map */
> +#define SCA3300_REG_SELBANK    0x1f
> +
> +/* Device status and mask */
> +#define SCA3300_REG_STATUS     0x6
> +#define SCA3300_STATUS_MASK    GENMASK(8, 0)
> +
> +/* Device ID */
> +#define SCA3300_REG_WHOAMI     0x10
> +#define SCA3300_WHOAMI_ID      0x51
> +
> +/* Device return status and mask */
> +#define SCA3300_VALUE_RS_ERROR 0x3
> +#define SCA3300_MASK_RS_STATUS GENMASK(1, 0)
> +
> +enum sca3300_scan_indexes {
> +       SCA3300_ACC_X = 0,
> +       SCA3300_ACC_Y,
> +       SCA3300_ACC_Z,
> +       SCA3300_TEMP,
> +       SCA3300_TIMESTAMP,
> +};
> +
> +#define SCA3300_ACCEL_CHANNEL(index, reg, axis) {                      \
> +       .type = IIO_ACCEL,                                              \
> +       .address = reg,                                                 \
> +       .modified = 1,                                                  \
> +       .channel2 = IIO_MOD_##axis,                                     \
> +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                   \
> +       .info_mask_shared_by_type =                                     \
> +       BIT(IIO_CHAN_INFO_SCALE) |                                      \
> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),               \
> +       .info_mask_shared_by_type_available =                           \
> +       BIT(IIO_CHAN_INFO_SCALE) |                                      \
> +       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),               \
> +       .scan_index = index,                                            \
> +       .scan_type = {                                                  \
> +               .sign = 's',                                            \
> +               .realbits = 16,                                         \
> +               .storagebits = 16,                                      \
> +               .endianness = IIO_CPU,                                  \
> +       },                                                              \
> +}
> +
> +static const struct iio_chan_spec sca3300_channels[] = {
> +       SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
> +       SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> +       SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> +       {
> +               .type = IIO_TEMP,
> +               .address = 0x5,
> +               .scan_index = SCA3300_TEMP,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +               .scan_type = {
> +                       .sign = 's',
> +                       .realbits = 16,
> +                       .storagebits = 16,
> +                       .endianness = IIO_CPU,
> +               },
> +       },
> +       IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static const int sca3300_lp_freq[] = {70, 70, 70, 10};
> +static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
> +
> +static const unsigned long sca3300_scan_masks[] = {
> +       BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> +       BIT(SCA3300_TEMP),
> +       0
> +};
> +
> +/**
> + * struct sca3300_data - device data
> + * @spi: SPI device structure
> + * @lock: Data buffer lock
> + * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
> + * @txbuf: Transmit buffer
> + * @rxbuf: Receive buffer
> + */
> +struct sca3300_data {
> +       struct spi_device *spi;
> +       struct mutex lock;
> +       struct {
> +               s16 channels[4];
> +               s64 ts __aligned(sizeof(s64));
> +       } scan;
> +       u8 txbuf[4] ____cacheline_aligned;
> +       u8 rxbuf[4];
> +};
> +
> +DECLARE_CRC8_TABLE(sca3300_crc_table);
> +
> +static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
> +{
> +       /* Consecutive requests min. 10 us delay (Datasheet section 5.1.2) */
> +       struct spi_delay delay = { .value = 10, .unit = SPI_DELAY_UNIT_USECS };
> +       int32_t ret;
> +       int rs;
> +       u8 crc;
> +       struct spi_transfer xfers[2] = {
> +               {
> +                       .tx_buf = sca_data->txbuf,
> +                       .len = ARRAY_SIZE(sca_data->txbuf),
> +                       .delay = delay,
> +                       .cs_change = 1,
> +               },
> +               {
> +                       .rx_buf = sca_data->rxbuf,
> +                       .len = ARRAY_SIZE(sca_data->rxbuf),
> +                       .delay = delay,
> +               }
> +       };
> +
> +       /* inverted crc value as described in device data sheet */
> +       crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3, CRC8_INIT_VALUE);
> +       sca_data->txbuf[3] = crc;
> +
> +       ret = spi_sync_transfer(sca_data->spi, xfers, ARRAY_SIZE(xfers));
> +       if (ret) {
> +               dev_err(&sca_data->spi->dev,
> +                       "transfer error, error: %d\n", ret);
> +               return -EIO;
> +       }
> +
> +       crc = ~crc8(sca3300_crc_table, &sca_data->rxbuf[0], 3, CRC8_INIT_VALUE);
> +       if (sca_data->rxbuf[3] != crc) {
> +               dev_err(&sca_data->spi->dev, "CRC checksum mismatch");
> +               return -EIO;
> +       }
> +
> +       /* get return status */
> +       rs = sca_data->rxbuf[0] & SCA3300_MASK_RS_STATUS;
> +       if (rs == SCA3300_VALUE_RS_ERROR)
> +               ret = -EINVAL;
> +
> +       *val = sign_extend32(get_unaligned_be16(&sca_data->rxbuf[1]), 15);
> +
> +       return ret;
> +}
> +
> +static int sca3300_error_handler(struct sca3300_data *sca_data)
> +{
> +       int ret;
> +       int val;
> +
> +       mutex_lock(&sca_data->lock);
> +       sca_data->txbuf[0] = SCA3300_REG_STATUS << 2;
> +       ret = sca3300_transfer(sca_data, &val);
> +       mutex_unlock(&sca_data->lock);
> +       /*
> +        * Return status error is cleared after reading status register once,
> +        * expect EINVAL here.
> +        */
> +       if (ret != -EINVAL) {
> +               dev_err(&sca_data->spi->dev,
> +                       "error reading device status: %d\n", ret);
> +               return ret;
> +       }
> +
> +       dev_err(&sca_data->spi->dev, "device status: 0x%lx\n",
> +               val & SCA3300_STATUS_MASK);
> +
> +       return 0;
> +}
> +
> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
> +{
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);
> +       sca_data->txbuf[0] = reg << 2;
> +       ret = sca3300_transfer(sca_data, val);
> +       mutex_unlock(&sca_data->lock);
> +       if (ret != -EINVAL)
> +               return ret;
> +
> +       return sca3300_error_handler(sca_data);
> +}
> +
> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
> +{
> +       int reg_val = 0;
> +       int ret;
> +
> +       mutex_lock(&sca_data->lock);
> +       /* BIT(7) for write operation */
> +       sca_data->txbuf[0] = BIT(7) | (reg << 2);
> +       put_unaligned_be16(val, &sca_data->txbuf[1]);
> +       ret = sca3300_transfer(sca_data, &reg_val);
> +       mutex_unlock(&sca_data->lock);
> +       if (ret != -EINVAL)
> +               return ret;
> +
> +       return sca3300_error_handler(sca_data);
> +}
> +
> +static int sca3300_write_raw(struct iio_dev *indio_dev,
> +                            struct iio_chan_spec const *chan,
> +                            int val, int val2, long mask)
> +{
> +       struct sca3300_data *data = iio_priv(indio_dev);
> +       int reg_val;
> +       int ret;
> +       int i;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               if (val)
> +                       return -EINVAL;
> +
> +               for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
> +                       if (val2 == sca3300_accel_scale[i][1])
> +                               return sca3300_write_reg(data, SCA3300_REG_MODE, i);
> +               }
> +               return -EINVAL;
> +
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +               if (ret)
> +                       return ret;
> +               /* freq. change is possible only for mode 3 and 4 */
> +               if (reg_val == 2 && val == sca3300_lp_freq[3])
> +                       return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
> +               if (reg_val == 3 && val == sca3300_lp_freq[2])
> +                       return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
> +               return -EINVAL;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static int sca3300_read_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan,
> +                           int *val, int *val2, long mask)
> +{
> +       struct sca3300_data *data = iio_priv(indio_dev);
> +       int ret;
> +       int reg_val;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret = sca3300_read_reg(data, chan->address, val);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +               if (ret)
> +                       return ret;
> +               *val = 0;
> +               *val2 = sca3300_accel_scale[reg_val][1];
> +               return IIO_VAL_INT_PLUS_MICRO;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +               if (ret)
> +                       return ret;
> +               *val = sca3300_lp_freq[reg_val];
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
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
> +               if (ret) {
> +                       dev_err_ratelimited(&data->spi->dev,
> +                               "failed to read register, error: %d\n", ret);
> +                       /* handled, but bailing out due to errors */
> +                       goto out;
> +               }
> +               data->scan.channels[i++] = val;
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
> +/*
> + * sca3300_init - Device init sequence. See datasheet rev 2 section
> + * 4.2 Start-Up Sequence for details.
> + */
> +static int sca3300_init(struct sca3300_data *sca_data,
> +                       struct iio_dev *indio_dev)
> +{
> +       int value = 0;
> +       int ret;
> +
> +       ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
> +                               SCA3300_MODE_SW_RESET);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Wait 1ms after SW-reset command.
> +        * Wait 15ms for settling of signal paths.
> +        */
> +       usleep_range(16e3, 50e3);
> +
> +       ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
> +       if (ret)
> +               return ret;
> +
> +       if (value != SCA3300_WHOAMI_ID) {
> +               dev_err(&sca_data->spi->dev,
> +                       "device id not expected value, %d != %u\n",
> +                       value, SCA3300_WHOAMI_ID);
> +               return -ENODEV;
> +       }
> +       return 0;
> +}
> +
> +static int sca3300_debugfs_reg_access(struct iio_dev *indio_dev,
> +                                     unsigned int reg, unsigned int writeval,
> +                                     unsigned int *readval)
> +{
> +       struct sca3300_data *data = iio_priv(indio_dev);
> +       int value;
> +       int ret;
> +
> +       if (reg > SCA3300_REG_SELBANK)
> +               return -EINVAL;
> +
> +       if (!readval)
> +               return sca3300_write_reg(data, reg, writeval);
> +
> +       ret = sca3300_read_reg(data, reg, &value);
> +       if (ret)
> +               return ret;
> +
> +       *readval = value;
> +
> +       return 0;
> +}
> +
> +static int sca3300_read_avail(struct iio_dev *indio_dev,
> +                             struct iio_chan_spec const *chan,
> +                             const int **vals, int *type, int *length,
> +                             long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals = (const int *)sca3300_accel_scale;
> +               *length = ARRAY_SIZE(sca3300_accel_scale) * 2 - 2;
> +               *type = IIO_VAL_INT_PLUS_MICRO;
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               *vals = &sca3300_lp_freq[2];
> +               *length = 2;
> +               *type = IIO_VAL_INT;
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static const struct iio_info sca3300_info = {
> +       .read_raw = sca3300_read_raw,
> +       .write_raw = sca3300_write_raw,
> +       .debugfs_reg_access = &sca3300_debugfs_reg_access,
> +       .read_avail = sca3300_read_avail,
> +};
> +
> +static int sca3300_probe(struct spi_device *spi)
> +{
> +       struct sca3300_data *sca_data;
> +       struct iio_dev *indio_dev;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sca_data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       sca_data = iio_priv(indio_dev);
> +       mutex_init(&sca_data->lock);
> +       sca_data->spi = spi;
> +
> +       crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
> +
> +       indio_dev->info = &sca3300_info;
> +       indio_dev->name = SCA3300_ALIAS;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = sca3300_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
> +       indio_dev->available_scan_masks = sca3300_scan_masks;
> +
> +       ret = sca3300_init(sca_data, indio_dev);
> +       if (ret) {
> +               dev_err(&spi->dev, "failed to init device, error: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +                                             iio_pollfunc_store_time,
> +                                             sca3300_trigger_handler, NULL);
> +       if (ret) {
> +               dev_err(&spi->dev,
> +                       "iio triggered buffer setup failed, error: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret) {
> +               dev_err(&spi->dev, "iio device register failed, error: %d\n",
> +                       ret);
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id sca3300_dt_ids[] = {
> +       { .compatible = "murata,sca3300"},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
> +
> +static struct spi_driver sca3300_driver = {
> +       .driver = {
> +               .name           = SCA3300_ALIAS,
> +               .of_match_table = sca3300_dt_ids,
> +       },
> +       .probe  = sca3300_probe,
> +};
> +module_spi_driver(sca3300_driver);
> +
> +MODULE_AUTHOR("Tomas Melin <tomas.melin@vaisala.com>");
> +MODULE_DESCRIPTION("Murata SCA3300 SPI Accelerometer");
> +MODULE_LICENSE("GPL v2");
> --
> 2.21.3
>


-- 
With Best Regards,
Andy Shevchenko
