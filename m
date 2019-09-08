Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119AEACC87
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfIHMFs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfIHMFs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:05:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55081218AC;
        Sun,  8 Sep 2019 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944347;
        bh=6Wz7k4jeAcWyN3r9O4aNWI1PyiYmYosVUp+dmhxrFho=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EmZxTFfM2QhbW0gf7Vo1pUpEt7015vv/9mxzGWBTuTbtRjPxwsHHqLl69o8eW9aVA
         KldnLRlfh8PcTqOY2+gL3Ku2AYLY4nBeFCd0IhAzATc/h32g9vZXBRh60hiJmpOczl
         kbd7/sWv7LBijOI0Snf0HFOsz47soK+Kz7ZsbKs4=
Date:   Sun, 8 Sep 2019 13:05:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 7/8] iio: imu: inv_mpu6050: add magnetometer support
 inside mpu driver
Message-ID: <20190908130542.523c363b@archlinux>
In-Reply-To: <20190829151801.13014-8-jmaneyrol@invensense.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
        <20190829151801.13014-8-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Aug 2019 15:18:45 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Add inv_mpu_magn layer to manage several chip specific
> implementations and be noop when Kconfig option is not set.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

A few minor bits inline.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Makefile       |   3 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 140 ++++++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   2 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 120 ++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h | 107 ++++++++++++++++
>  5 files changed, 368 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> index fee41415ebdb..6f5baac29f81 100644
> --- a/drivers/iio/imu/inv_mpu6050/Makefile
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -5,7 +5,8 @@
>  
>  obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
>  inv-mpu6050-y := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
> -inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) += inv_mpu_aux.o inv_mpu9250_magn.o
> +inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) += inv_mpu_aux.o inv_mpu_magn.o \
> +	inv_mpu9250_magn.o
>  
>  obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
>  inv-mpu6050-i2c-y := inv_mpu_i2c.o inv_mpu_acpi.o
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index b17f060b52fc..d08cec6a8a7a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -16,7 +16,9 @@
>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +
>  #include "inv_mpu_iio.h"
> +#include "inv_mpu_magn.h"
>  
>  /*
>   * this is the gyro scale translated from dynamic range plus/minus
> @@ -332,6 +334,11 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	 */
>  	st->chip_period = NSEC_PER_MSEC;
>  
> +	/* magn chip init, noop if not present in the chip */
> +	result = inv_mpu_magn_probe(st);
> +	if (result)
> +		goto error_power_off;
> +
>  	return inv_mpu6050_set_power_itg(st, false);
>  
>  error_power_off:
> @@ -411,6 +418,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
>  					      IIO_MOD_X, val);
>  		break;
> +	case IIO_MAGN:
> +		ret = inv_mpu_magn_read(st, chan->channel2, val);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -469,6 +479,8 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  				*val2 = INV_MPU6050_TEMP_SCALE;
>  
>  			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_MAGN:
> +			return inv_mpu_magn_get_scale(st, chan, val, val2);
>  		default:
>  			return -EINVAL;
>  		}
> @@ -710,6 +722,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  	if (result)
>  		goto fifo_rate_fail_power_off;
>  
> +	/* update rate for magn, noop if not present in chip */
> +	result = inv_mpu_magn_set_rate(st, fifo_rate);
> +	if (result)
> +		goto fifo_rate_fail_power_off;
> +
>  fifo_rate_fail_power_off:
>  	result |= inv_mpu6050_set_power_itg(st, false);
>  fifo_rate_fail_unlock:
> @@ -795,8 +812,13 @@ inv_get_mount_matrix(const struct iio_dev *indio_dev,
>  		     const struct iio_chan_spec *chan)
>  {
>  	struct inv_mpu6050_state *data = iio_priv(indio_dev);
> +	const struct iio_mount_matrix *matrix = &data->orientation;
>  
> -	return &data->orientation;
> +#ifdef CONFIG_INV_MPU6050_MAGN
> +	if (chan->type == IIO_MAGN)
> +		matrix = &data->magn_orient;
> +#endif
> +	return matrix;
>  }
>  
>  static const struct iio_chan_spec_ext_info inv_ext_info[] = {
> @@ -864,6 +886,102 @@ static const unsigned long inv_mpu_scan_masks[] = {
>  	0,
>  };
>  
> +#ifdef CONFIG_INV_MPU6050_MAGN
> +
> +#define INV_MPU9X50_MAGN_CHAN(_chan2, _bits, _index)			\
> +	{								\
> +		.type = IIO_MAGN,					\
> +		.modified = 1,						\
> +		.channel2 = _chan2,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				      BIT(IIO_CHAN_INFO_RAW),		\
> +		.scan_index = _index,					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = _bits,				\
> +			.storagebits = 16,				\
> +			.shift = 0,					\
> +			.endianness = IIO_BE,				\
> +		},							\
> +		.ext_info = inv_ext_info,				\
> +	}
> +
> +static const struct iio_chan_spec inv_mpu9250_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
> +	/*
> +	 * Note that temperature should only be via polled reading only,
> +	 * not the final scan elements output.
> +	 */
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> +				| BIT(IIO_CHAN_INFO_OFFSET)
> +				| BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = -1,
> +	},
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU9X50_SCAN_GYRO_X),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU9X50_SCAN_GYRO_Y),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU9X50_SCAN_GYRO_Z),
> +
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU9X50_SCAN_ACCL_X),
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU9X50_SCAN_ACCL_Y),
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU9X50_SCAN_ACCL_Z),
> +
> +	/* Magnetometer resolution is 16 bits */
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 16, INV_MPU9X50_SCAN_MAGN_X),
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Y, 16, INV_MPU9X50_SCAN_MAGN_Y),
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCAN_MAGN_Z),
> +};
> +
> +static const unsigned long inv_mpu9x50_scan_masks[] = {
> +	/* 3-axis accel */
> +	BIT(INV_MPU9X50_SCAN_ACCL_X)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Z),
> +	/* 3-axis gyro */
> +	BIT(INV_MPU9X50_SCAN_GYRO_X)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Z),
> +	/* 3-axis magn */
> +	BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	/* 6-axis accel + gyro */
> +	BIT(INV_MPU9X50_SCAN_ACCL_X)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Z)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_X)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Z),
> +	/* 6-axis accel + magn */
> +	BIT(INV_MPU9X50_SCAN_ACCL_X)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Z)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	/* 6-axis gyro + magn */
> +	BIT(INV_MPU9X50_SCAN_GYRO_X)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Z)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	/* 9-axis accel + gyro + magn */
> +	BIT(INV_MPU9X50_SCAN_ACCL_X)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Y)
> +		| BIT(INV_MPU9X50_SCAN_ACCL_Z)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_X)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Y)
> +		| BIT(INV_MPU9X50_SCAN_GYRO_Z)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	0,
> +};
> +
> +#endif
> +
>  static const struct iio_chan_spec inv_icm20602_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
>  	{
> @@ -1145,6 +1263,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		return result;
>  	}
>  
> +	/* fill magnetometer orientation */
> +	result = inv_mpu_magn_set_orient(st);
> +	if (result)
> +		return result;
> +
>  	/* power is turned on inside check chip type*/
>  	result = inv_check_and_setup_chip(st);
>  	if (result)
> @@ -1167,14 +1290,25 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	else
>  		indio_dev->name = dev_name(dev);
>  
> -	if (chip_type == INV_ICM20602) {
> +	switch (chip_type) {
> +#ifdef CONFIG_INV_MPU6050_MAGN
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		indio_dev->channels = inv_mpu9250_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
> +		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
> +		break;
> +#endif
> +	case INV_ICM20602:
>  		indio_dev->channels = inv_icm20602_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(inv_icm20602_channels);
>  		indio_dev->available_scan_masks = inv_icm20602_scan_masks;
> -	} else {
> +		break;
> +	default:
>  		indio_dev->channels = inv_mpu_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
>  		indio_dev->available_scan_masks = inv_mpu_scan_masks;
> +		break;
>  	}
>  
>  	indio_dev->info = &mpu_info;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 5b462672bbcb..cfc11cb0a36c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -130,6 +130,7 @@ struct inv_mpu6050_hw {
>   *  @data_timestamp:	timestamp for next data sample.
>   *  @vddio_supply	voltage regulator for the chip.
>   *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
> + *  @magn_orient:	magnetometer sensor chip orientation if available.
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -153,6 +154,7 @@ struct inv_mpu6050_state {
>  	struct regulator *vddio_supply;
>  #ifdef CONFIG_INV_MPU6050_MAGN
>  	s32 magn_raw_to_gauss[3];
> +	struct iio_mount_matrix magn_orient;
>  #endif
>  };
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> new file mode 100644
> index 000000000000..2bb40dae0429
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 TDK-InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/string.h>
> +
> +#include "inv_mpu_iio.h"
> +#include "inv_mpu_aux.h"
> +#include "inv_mpu9250_magn.h"
> +
> +int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
> +{
> +	int ret;
> +
> +	/* probe and init mag chip */
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		/* configure i2c master aux port */
> +		ret = inv_mpu_aux_init(st);
> +		if (ret)
> +			return ret;
> +		return inv_mpu9250_magn_probe(st);
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate)
> +{
> +	int max_freq;
> +	uint8_t d;
> +
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		max_freq = INV_MPU9250_MAGN_FREQ_HZ_MAX;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	/*
> +	 * update i2c master delay to limit mag sampling to max frequency
> +	 * compute fifo_rate divider d: rate = fifo_rate / (d + 1)
> +	 */
> +	if (fifo_rate > max_freq)
> +		d = fifo_rate / max_freq - 1;
> +	else
> +		d = 0;
> +
> +	return regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL, d);
> +}
> +
> +int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
> +{
> +	const char *orient;
> +	char *str;
> +	int i;
> +
> +	/* fill magnetometer orientation */
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		/* x <- y */
> +		st->magn_orient.rotation[0] = st->orientation.rotation[3];
> +		st->magn_orient.rotation[1] = st->orientation.rotation[4];
> +		st->magn_orient.rotation[2] = st->orientation.rotation[5];
> +		/* y <- x */
> +		st->magn_orient.rotation[3] = st->orientation.rotation[0];
> +		st->magn_orient.rotation[4] = st->orientation.rotation[1];
> +		st->magn_orient.rotation[5] = st->orientation.rotation[2];
> +		/* z <- -z */
> +		for (i = 0; i < 3; ++i) {
> +			orient = st->orientation.rotation[6 + i];
> +			/* use length + 2 for adding minus sign if needed */
> +			str = devm_kzalloc(regmap_get_device(st->map),
> +					   strlen(orient) + 2, GFP_KERNEL);
> +			if (str == NULL)
> +				return -ENOMEM;
> +			if (strcmp(orient, "0") == 0) {
> +				strcpy(str, orient);
> +			} else if (orient[0] == '-') {
> +				strcpy(str, &orient[1]);
> +			} else {
> +				str[0] = '-';
> +				strcpy(&str[1], orient);
> +			}
> +			st->magn_orient.rotation[6 + i] = str;
> +		}
> +		break;
> +	default:
> +		st->magn_orient = st->orientation;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val)
> +{
> +	int ret;
> +
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:

This is a bit paranoid given we can't get anywhere near here if it isn't one of
these devices.  I suppose you might have other magn containing devices to be
supported in the near future?

> +		ret = inv_mpu9250_magn_read(st, axis, val);
> +		break;
> +	default:
> +		ret = -ENODEV;
> +		break;
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> new file mode 100644
> index 000000000000..efa2ec1b3b2f
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 TDK-InvenSense, Inc.
> + */
> +
> +#ifndef INV_MPU_MAGN_H_
> +#define INV_MPU_MAGN_H_
> +
> +#include <linux/kernel.h>
> +
> +#include "inv_mpu_iio.h"
> +
> +#ifdef CONFIG_INV_MPU6050_MAGN
> +
> +/**
> + * inv_mpu_magn_probe() - probe and setup magnetometer chip
> + * @st: driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise
> + *
> + * It is probing the chip and setting up all needed i2c transfers.
> + * Noop if there is no magnetometer in the chip.
> + */

Comments generally next to implementations rather than definitions...
We got this wrong a fair bit in early IIO but let us move forward
correctly!

> +int inv_mpu_magn_probe(struct inv_mpu6050_state *st);
> +
> +/**
> + * inv_mpu_magn_get_scale() - get magnetometer scale value
> + * @st: driver internal state
> + *
> + * Returns IIO data format.
> + */
> +static inline int inv_mpu_magn_get_scale(const struct inv_mpu6050_state *st,
> +					 const struct iio_chan_spec *chan,
> +					 int *val, int *val2)
> +{
> +	*val = 0;
> +	*val2 = st->magn_raw_to_gauss[chan->address];
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +/**
> + * inv_mpu_magn_set_rate() - set magnetometer sampling rate
> + * @st: driver internal state
> + * @fifo_rate: mpu set fifo rate
> + *
> + * Returns 0 on success, a negative error code otherwise
> + *
> + * Limit sampling frequency to the maximum value supported by the
> + * magnetometer chip. Resulting in duplicated data for higher frequencies.
> + * Noop if there is no magnetometer in the chip.
> + */
> +int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate);
> +
> +/**
> + * inv_mpu_magn_set_orient() - fill magnetometer mounting matrix
> + * @st: driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise
> + *
> + * Fill magnetometer mounting matrix using the provided chip matrix.
> + */
> +int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st);
> +
> +/**
> + * inv_mpu_magn_read() - read magnetometer data
> + * @st: driver internal state
> + * @axis: IIO modifier axis value
> + * @val: store corresponding axis value
> + *
> + * Returns 0 on success, a negative error code otherwise
> + */
> +int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val);
> +
> +#else		/* CONFIG_INV_MPU6050_MAGN */
> +
> +static inline int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
> +{
> +	return 0;
> +}
> +
> +static inline int inv_mpu_magn_get_scale(const struct inv_mpu6050_state *st,
> +					 const struct iio_chan_spec *chan,
> +					 int *val, int *val2)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st,
> +					int fifo_rate)
> +{
> +	return 0;
> +}
> +
> +static inline int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
> +{
> +	return 0;
> +}
> +
> +static inline int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis,
> +				    int *val)
> +{
> +	return 0;
> +}
> +
> +#endif		/* CONFIG_INV_MPU6050_MAGN */
> +
> +#endif		/* INV_MPU_MAGN_H_ */

