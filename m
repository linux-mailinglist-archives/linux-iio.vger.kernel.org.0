Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F21DD54A
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgEURzT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 13:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgEURzT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 13:55:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D97B6206D4;
        Thu, 21 May 2020 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083717;
        bh=ajzwr0MoajkuLw4Mwab9fMGkMH1+nR54DUFdVFxtviM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Aofw9DdAMcB4J8YKIrJWIjWcW2Xl+YIn1lPUnBXY0y+NN6cM6qHh0PTiUmS8+yeDr
         3zHBiG37b/2NIvNdXxaBjrfnJimdnK4RGdeCuU2M5K5purNkPFzdDiYYhpAFoVRWot
         5fa7W1uUC4BTuZGkO9svAHUVSARvopz1/w0FUbSQ=
Date:   Thu, 21 May 2020 18:55:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] iio: imu: inv_icm42600: add gyroscope IIO device
Message-ID: <20200521185512.51c57747@archlinux>
In-Reply-To: <MN2PR12MB4422B32CB3C4BFD0AF5FFF3CC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-5-jmaneyrol@invensense.com>
        <20200508150104.000010c2@Huawei.com>
        <MN2PR12MB4422B32CB3C4BFD0AF5FFF3CC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 May 2020 15:27:28 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
> 
> I agree with all comments.
> 
> For regmap_bulk_read, by looking at source code it doesn't seem to requires specific alignment, except if bus read callback is expecting that. But I can see numerous drivers calling regmap_bulk_read with a data buffer on the stack and not particularly aligned.

Absolutely.  e.g. i2c you don't need to be aligned for
but for SPI you do.  If there are drivers
using regmap for spi that don't there is probably
a bug there.

Jonathan

> 
> And we definitely can read calibration offset registers while running, the lock is indeed not needed.
> 
> Thanks,
> JB
> ________________________________
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, May 8, 2020 16:01
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Cc: jic23@kernel.org <jic23@kernel.org>; robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel.org>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemloft.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 04/12] iio: imu: inv_icm42600: add gyroscope IIO device
> 
>  CAUTION: This email originated from outside of the organization. Please make sure the sender is who they say they are and do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Thu, 7 May 2020 16:42:14 +0200
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
> 
> > Add IIO device for gyroscope sensor with data polling interface.
> > Attributes: raw, scale, sampling_frequency, calibbias.
> >
> > Gyroscope in low noise mode.
> >
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> Few trivial things and questions inline.
> 
> J
> 
> > ---
> >  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   4 +
> >  .../iio/imu/inv_icm42600/inv_icm42600_core.c  |   5 +
> >  .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 549 ++++++++++++++++++
> >  3 files changed, 558 insertions(+)
> >  create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> >
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > index 8da4c8249aed..ca41a9d6404a 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > @@ -120,6 +120,7 @@ struct inv_icm42600_suspended {
> >   *  @orientation:    sensor chip orientation relative to main hardware.
> >   *  @conf:           chip sensors configurations.
> >   *  @suspended:              suspended sensors configuration.
> > + *  @indio_gyro:     gyroscope IIO device.
> >   */
> >  struct inv_icm42600_state {
> >        struct mutex lock;
> > @@ -131,6 +132,7 @@ struct inv_icm42600_state {
> >        struct iio_mount_matrix orientation;
> >        struct inv_icm42600_conf conf;
> >        struct inv_icm42600_suspended suspended;
> > +     struct iio_dev *indio_gyro;
> >  };
> >
> >  /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
> > @@ -369,4 +371,6 @@ int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
> >  int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> >                            inv_icm42600_bus_setup bus_setup);
> >
> > +int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
> > +
> >  #endif
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > index 35bdf4f9d31e..151257652ce6 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > @@ -503,6 +503,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> >        if (ret)
> >                return ret;
> >
> > +     /* create and init gyroscope iio device */  
> 
> 'Kind' of obvious from function name?   Maybe drop the comment?
> 
> > +     ret = inv_icm42600_gyro_init(st);
> > +     if (ret)
> > +             return ret;
> > +
> >        /* setup runtime power management */
> >        ret = pm_runtime_set_active(dev);
> >        if (ret)
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > new file mode 100644
> > index 000000000000..74aa2b5fa611
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > @@ -0,0 +1,549 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2020 Invensense, Inc.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/mutex.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/iio.h>
> > +
> > +#include "inv_icm42600.h"
> > +
> > +#define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)         \
> > +     {                                                               \
> > +             .type = IIO_ANGL_VEL,                                   \
> > +             .modified = 1,                                          \
> > +             .channel2 = _modifier,                                  \
> > +             .info_mask_separate =                                   \
> > +                     BIT(IIO_CHAN_INFO_RAW) |                        \
> > +                     BIT(IIO_CHAN_INFO_CALIBBIAS),                   \
> > +             .info_mask_shared_by_type =                             \
> > +                     BIT(IIO_CHAN_INFO_SCALE),                       \
> > +             .info_mask_shared_by_type_available =                   \
> > +                     BIT(IIO_CHAN_INFO_SCALE),                       \
> > +             .info_mask_shared_by_all =                              \
> > +                     BIT(IIO_CHAN_INFO_SAMP_FREQ),                   \
> > +             .info_mask_shared_by_all_available =                    \
> > +                     BIT(IIO_CHAN_INFO_SAMP_FREQ),                   \
> > +             .scan_index = _index,                                   \
> > +             .scan_type = {                                          \
> > +                     .sign = 's',                                    \
> > +                     .realbits = 16,                                 \
> > +                     .storagebits = 16,                              \
> > +                     .shift = 0,                                     \  
> 
> Shift has the 'obviously' default of 0, so normally we don't bother explicitly
> setting it to 0 like this.
> 
> > +                     .endianness = IIO_BE,                           \
> > +             },                                                      \
> > +             .ext_info = _ext_info,                                  \
> > +     }
> > +
> > +enum inv_icm42600_gyro_scan {
> > +     INV_ICM42600_GYRO_SCAN_X,
> > +     INV_ICM42600_GYRO_SCAN_Y,
> > +     INV_ICM42600_GYRO_SCAN_Z,
> > +};
> > +
> > +static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos[] = {
> > +     IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42600_get_mount_matrix),
> > +     {},
> > +};
> > +
> > +static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
> > +     INV_ICM42600_GYRO_CHAN(IIO_MOD_X, INV_ICM42600_GYRO_SCAN_X,
> > +                            inv_icm42600_gyro_ext_infos),
> > +     INV_ICM42600_GYRO_CHAN(IIO_MOD_Y, INV_ICM42600_GYRO_SCAN_Y,
> > +                            inv_icm42600_gyro_ext_infos),
> > +     INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_SCAN_Z,
> > +                            inv_icm42600_gyro_ext_infos),
> > +};
> > +
> > +static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
> > +                                      struct iio_chan_spec const *chan,
> > +                                      int16_t *val)
> > +{
> > +     struct device *dev = regmap_get_device(st->map);
> > +     struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> > +     unsigned int reg;
> > +     __be16 data;
> > +     int ret;
> > +
> > +     if (chan->type != IIO_ANGL_VEL)
> > +             return -EINVAL;
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_X:
> > +             reg = INV_ICM42600_REG_GYRO_DATA_X;
> > +             break;
> > +     case IIO_MOD_Y:
> > +             reg = INV_ICM42600_REG_GYRO_DATA_Y;
> > +             break;
> > +     case IIO_MOD_Z:
> > +             reg = INV_ICM42600_REG_GYRO_DATA_Z;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     pm_runtime_get_sync(dev);
> > +     mutex_lock(&st->lock);
> > +
> > +     /* enable gyro sensor */
> > +     conf.mode = INV_ICM42600_SENSOR_MODE_LOW_NOISE;
> > +     ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     /* read gyro register data */
> > +     ret = regmap_bulk_read(st->map, reg, &data, sizeof(data));  
> 
> IIRC bulk reads need to be to dma safe buffers.  So typically on the stack and
> in appropriately aligned location in any containing structure.
> 
> > +     if (ret)
> > +             goto exit;
> > +
> > +     *val = (int16_t)be16_to_cpu(data);
> > +     if (*val == INV_ICM42600_DATA_INVALID)
> > +             ret = -EINVAL;
> > +exit:
> > +     mutex_unlock(&st->lock);
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_put_autosuspend(dev);
> > +     return ret;
> > +}
> > +
> > +/* IIO format int + nano */
> > +static const int inv_icm42600_gyro_scale[] = {
> > +     /* +/- 2000dps => 0.001065264 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_2000DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_2000DPS + 1] = 1065264,
> > +     /* +/- 1000dps => 0.000532632 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_1000DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_1000DPS + 1] = 532632,
> > +     /* +/- 500dps => 0.000266316 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_500DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_500DPS + 1] = 266316,
> > +     /* +/- 250dps => 0.000133158 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_250DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_250DPS + 1] = 133158,
> > +     /* +/- 125dps => 0.000066579 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_125DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_125DPS + 1] = 66579,
> > +     /* +/- 62.5dps => 0.000033290 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_62_5DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_62_5DPS + 1] = 33290,
> > +     /* +/- 31.25dps => 0.000016645 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_31_25DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_31_25DPS + 1] = 16645,
> > +     /* +/- 15.625dps => 0.000008322 rad/s */
> > +     [2 * INV_ICM42600_GYRO_FS_15_625DPS] = 0,
> > +     [2 * INV_ICM42600_GYRO_FS_15_625DPS + 1] = 8322,
> > +};
> > +
> > +static int inv_icm42600_gyro_read_scale(struct inv_icm42600_state *st,
> > +                                     int *val, int *val2)
> > +{
> > +     unsigned int idx;
> > +
> > +     mutex_lock(&st->lock);
> > +     idx = st->conf.gyro.fs;  
> 
> Seems like we shouldn't need the lock to retrieve a single value.
> Is there some odd intermediate state somewhere I'm missing?
> 
> > +     mutex_unlock(&st->lock);
> > +
> > +     *val = inv_icm42600_gyro_scale[2 * idx];
> > +     *val2 = inv_icm42600_gyro_scale[2 * idx + 1];
> > +     return IIO_VAL_INT_PLUS_NANO;
> > +}
> > +
> > +static int inv_icm42600_gyro_write_scale(struct inv_icm42600_state *st,
> > +                                      int val, int val2)
> > +{
> > +     struct device *dev = regmap_get_device(st->map);
> > +     unsigned int idx;
> > +     struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> > +     int ret;
> > +
> > +     for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_gyro_scale); idx += 2) {
> > +             if (val == inv_icm42600_gyro_scale[idx] &&
> > +                             val2 == inv_icm42600_gyro_scale[idx + 1])  
> 
> Alignment of code seems odd.
> 
> > +                     break;
> > +     }
> > +     if (idx >= ARRAY_SIZE(inv_icm42600_gyro_scale))
> > +             return -EINVAL;
> > +
> > +     /* update gyro fs */
> > +     pm_runtime_get_sync(dev);
> > +
> > +     mutex_lock(&st->lock);
> > +     conf.fs = idx / 2;
> > +     ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
> > +     mutex_unlock(&st->lock);
> > +
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_put_autosuspend(dev);
> > +
> > +     return ret;
> > +}
> > +
> > +/* IIO format int + micro */
> > +static const int inv_icm42600_gyro_odr[] = {
> > +     /* 12.5Hz */
> > +     12, 500000,
> > +     /* 25Hz */
> > +     25, 0,
> > +     /* 50Hz */
> > +     50, 0,
> > +     /* 100Hz */
> > +     100, 0,
> > +     /* 200Hz */
> > +     200, 0,
> > +     /* 1kHz */
> > +     1000, 0,
> > +     /* 2kHz */
> > +     2000, 0,
> > +     /* 4kHz */
> > +     4000, 0,
> > +};
> > +
> > +static const int inv_icm42600_gyro_odr_conv[] = {
> > +     INV_ICM42600_ODR_12_5HZ,
> > +     INV_ICM42600_ODR_25HZ,
> > +     INV_ICM42600_ODR_50HZ,
> > +     INV_ICM42600_ODR_100HZ,
> > +     INV_ICM42600_ODR_200HZ,
> > +     INV_ICM42600_ODR_1KHZ_LN,
> > +     INV_ICM42600_ODR_2KHZ_LN,
> > +     INV_ICM42600_ODR_4KHZ_LN,
> > +};
> > +
> > +static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state *st,
> > +                                   int *val, int *val2)
> > +{
> > +     unsigned int odr;
> > +     unsigned int i;
> > +
> > +     mutex_lock(&st->lock);
> > +     odr = st->conf.gyro.odr;
> > +     mutex_unlock(&st->lock);
> > +
> > +     for (i = 0; i < ARRAY_SIZE(inv_icm42600_gyro_odr_conv); ++i) {
> > +             if (inv_icm42600_gyro_odr_conv[i] == odr)
> > +                     break;
> > +     }
> > +     if (i >= ARRAY_SIZE(inv_icm42600_gyro_odr_conv))
> > +             return -EINVAL;
> > +
> > +     *val = inv_icm42600_gyro_odr[2 * i];
> > +     *val2 = inv_icm42600_gyro_odr[2 * i + 1];
> > +
> > +     return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state *st,
> > +                                    int val, int val2)
> > +{
> > +     struct device *dev = regmap_get_device(st->map);
> > +     unsigned int idx;
> > +     struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
> > +     int ret;
> > +
> > +     for (idx = 0; idx < ARRAY_SIZE(inv_icm42600_gyro_odr); idx += 2) {
> > +             if (val == inv_icm42600_gyro_odr[idx] &&
> > +                             val2 == inv_icm42600_gyro_odr[idx + 1])
> > +                     break;
> > +     }
> > +     if (idx >= ARRAY_SIZE(inv_icm42600_gyro_odr))
> > +             return -EINVAL;
> > +
> > +     /* update gyro odr */
> > +     pm_runtime_get_sync(dev);
> > +
> > +     mutex_lock(&st->lock);
> > +     conf.odr = inv_icm42600_gyro_odr_conv[idx / 2];
> > +     ret = inv_icm42600_set_gyro_conf(st, &conf, NULL);
> > +     mutex_unlock(&st->lock);
> > +
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_put_autosuspend(dev);
> > +
> > +     return ret;
> > +}
> > +
> > +static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
> > +                                      struct iio_chan_spec const *chan,
> > +                                      int16_t *val)
> > +{
> > +     struct device *dev = regmap_get_device(st->map);
> > +     unsigned int reg;
> > +     uint8_t data[2];
> > +     int ret;
> > +
> > +     if (chan->type != IIO_ANGL_VEL)
> > +             return -EINVAL;
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_X:
> > +             reg = INV_ICM42600_REG_OFFSET_USER0;
> > +             break;
> > +     case IIO_MOD_Y:
> > +             reg = INV_ICM42600_REG_OFFSET_USER1;
> > +             break;
> > +     case IIO_MOD_Z:
> > +             reg = INV_ICM42600_REG_OFFSET_USER3;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     pm_runtime_get_sync(dev);
> > +
> > +     /* read gyro offset data */
> > +     mutex_lock(&st->lock);
> > +     ret = regmap_bulk_read(st->map, reg, &data, sizeof(data));
> > +     mutex_unlock(&st->lock);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_X:
> > +             *val = (int16_t)(((data[1] & 0x0F) << 8) | data[0]);  
> 
> This doesn't look right for negative values.  You would be better
> off with a sign extend of the 12 bit value.
> 
> > +             break;
> > +     case IIO_MOD_Y:
> > +             *val = (int16_t)(((data[0] & 0xF0) << 4) | data[1]);
> > +             break;
> > +     case IIO_MOD_Z:
> > +             *val = (int16_t)(((data[1] & 0x0F) << 8) | data[0]);
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
> > +             break;
> > +     }
> > +
> > +exit:
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_put_autosuspend(dev);
> > +     return ret;
> > +}
> > +
> > +static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
> > +                                       struct iio_chan_spec const *chan,
> > +                                       int val)
> > +{
> > +     struct device *dev = regmap_get_device(st->map);
> > +     unsigned int reg, regval;
> > +     uint8_t data[2];
> > +     int ret;
> > +
> > +     if (chan->type != IIO_ANGL_VEL)
> > +             return -EINVAL;
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_X:
> > +             reg = INV_ICM42600_REG_OFFSET_USER0;
> > +             break;
> > +     case IIO_MOD_Y:
> > +             reg = INV_ICM42600_REG_OFFSET_USER1;
> > +             break;
> > +     case IIO_MOD_Z:
> > +             reg = INV_ICM42600_REG_OFFSET_USER3;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     /* value is limited to 12 bits signed */
> > +     if (val < -2048 || val > 2047)
> > +             return -EINVAL;  
> 
> Perhaps worth an available callback to give the range?
> 
> > +
> > +     pm_runtime_get_sync(dev);
> > +     mutex_lock(&st->lock);
> > +
> > +     switch (chan->channel2) {
> > +     case IIO_MOD_X:
> > +             /* OFFSET_USER1 register is shared */
> > +             ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER1,
> > +                               &regval);
> > +             if (ret)
> > +                     goto out_unlock;
> > +             data[0] = val & 0xFF;
> > +             data[1] = (regval & 0xF0) | ((val & 0xF00) >> 8);
> > +             break;
> > +     case IIO_MOD_Y:
> > +             /* OFFSET_USER1 register is shared */
> > +             ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER1,
> > +                               &regval);
> > +             if (ret)
> > +                     goto out_unlock;
> > +             data[0] = ((val & 0xF00) >> 4) | (regval & 0x0F);
> > +             data[1] = val & 0xFF;
> > +             break;
> > +     case IIO_MOD_Z:
> > +             /* OFFSET_USER4 register is shared */
> > +             ret = regmap_read(st->map, INV_ICM42600_REG_OFFSET_USER4,
> > +                               &regval);
> > +             if (ret)
> > +                     goto out_unlock;
> > +             data[0] = val & 0xFF;
> > +             data[1] = (regval & 0xF0) | ((val & 0xF00) >> 8);
> > +             break;
> > +     default:
> > +             ret = -EINVAL;
> > +             goto out_unlock;
> > +     }
> > +
> > +     ret = regmap_bulk_write(st->map, reg, data, sizeof(data));
> > +
> > +out_unlock:
> > +     mutex_unlock(&st->lock);
> > +     pm_runtime_mark_last_busy(dev);
> > +     pm_runtime_put_autosuspend(dev);
> > +     return ret;
> > +}
> > +
> > +static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
> > +                                   struct iio_chan_spec const *chan,
> > +                                   int *val, int *val2, long mask)
> > +{
> > +     struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> > +     int16_t data;
> > +     int ret;
> > +
> > +     if (chan->type != IIO_ANGL_VEL)
> > +             return -EINVAL;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret = iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +             ret = inv_icm42600_gyro_read_sensor(st, chan, &data);
> > +             iio_device_release_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +             *val = data;
> > +             return IIO_VAL_INT;
> > +     case IIO_CHAN_INFO_SCALE:
> > +             return inv_icm42600_gyro_read_scale(st, val, val2);
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return inv_icm42600_gyro_read_odr(st, val, val2);
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             ret = iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;  
> 
> I'm curious.  Why can't we read back a calibration offset whilst doing
> buffered capture?
> 
> > +             ret = inv_icm42600_gyro_read_offset(st, chan, &data);
> > +             iio_device_release_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +             *val = data;
> > +             return IIO_VAL_INT;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int inv_icm42600_gyro_read_avail(struct iio_dev *indio_dev,
> > +                                     struct iio_chan_spec const *chan,
> > +                                     const int **vals,
> > +                                     int *type, int *length, long mask)
> > +{
> > +     if (chan->type != IIO_ANGL_VEL)
> > +             return -EINVAL;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *vals = inv_icm42600_gyro_scale;
> > +             *type = IIO_VAL_INT_PLUS_NANO;
> > +             *length = ARRAY_SIZE(inv_icm42600_gyro_scale);
> > +             return IIO_AVAIL_LIST;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             *vals = inv_icm42600_gyro_odr;
> > +             *type = IIO_VAL_INT_PLUS_MICRO;
> > +             *length = ARRAY_SIZE(inv_icm42600_gyro_odr);
> > +             return IIO_AVAIL_LIST;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
> > +                                    struct iio_chan_spec const *chan,
> > +                                    int val, int val2, long mask)
> > +{
> > +     struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
> > +     int ret;
> > +
> > +     if (chan->type != IIO_ANGL_VEL)
> > +             return -EINVAL;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SCALE:
> > +             ret = iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +             ret = inv_icm42600_gyro_write_scale(st, val, val2);
> > +             iio_device_release_direct_mode(indio_dev);
> > +             return ret;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return inv_icm42600_gyro_write_odr(st, val, val2);
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             ret = iio_device_claim_direct_mode(indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +             ret = inv_icm42600_gyro_write_offset(st, chan, val);
> > +             iio_device_release_direct_mode(indio_dev);
> > +             return ret;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +                                            struct iio_chan_spec const *chan,
> > +                                            long mask)
> > +{
> > +     if (chan->type != IIO_ANGL_VEL)
> > +             return -EINVAL;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_SCALE:
> > +             return IIO_VAL_INT_PLUS_NANO;
> > +     case IIO_CHAN_INFO_SAMP_FREQ:
> > +             return IIO_VAL_INT_PLUS_MICRO;
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             return IIO_VAL_INT;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static const struct iio_info inv_icm42600_gyro_info = {
> > +     .read_raw = inv_icm42600_gyro_read_raw,
> > +     .read_avail = inv_icm42600_gyro_read_avail,
> > +     .write_raw = inv_icm42600_gyro_write_raw,
> > +     .write_raw_get_fmt = inv_icm42600_gyro_write_raw_get_fmt,
> > +     .debugfs_reg_access = inv_icm42600_debugfs_reg,
> > +};
> > +
> > +int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
> > +{
> > +     struct device *dev = regmap_get_device(st->map);
> > +     const char *name;
> > +     struct iio_dev *indio_dev;
> > +
> > +     name = devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", st->name);
> > +     if (!name)
> > +             return -ENOMEM;
> > +
> > +     indio_dev = devm_iio_device_alloc(dev, 0);
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     iio_device_set_drvdata(indio_dev, st);
> > +     indio_dev->dev.parent = dev;
> > +     indio_dev->name = name;
> > +     indio_dev->info = &inv_icm42600_gyro_info;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->channels = inv_icm42600_gyro_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(inv_icm42600_gyro_channels);
> > +
> > +     st->indio_gyro = indio_dev;
> > +     return devm_iio_device_register(dev, st->indio_gyro);
> > +}  
> 
> 

