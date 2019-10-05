Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE85CC98E
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfJELNY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 07:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfJELNY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 07:13:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C9F222C0;
        Sat,  5 Oct 2019 11:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570274002;
        bh=EnQLClIHCUunSjdcxHsEMf6RxecXB+wKAAax2Jl6ecM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s3FjTQeWbFdzS0Tq2UiIy+UaEq4aEqw2LCIwIIeMki4qc36s4IY0Y++u4Kix9xzDz
         Cq+lrNqUXLSVVntU2DQ6qDrcF0y+Z1gz0fPoMr6P89xiswt2jsjEYgSbMnUEOEMeqW
         8OSe7j+DeNms9FALM1eXLln7ljdJtzQCPs4+7234=
Date:   Sat, 5 Oct 2019 12:13:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] iio: imu: inv_mpu6050: add MPU925x magnetometer
 support
Message-ID: <20191005121318.440cf39c@archlinux>
In-Reply-To: <20190916094128.30122-7-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
        <20190916094128.30122-7-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 09:42:07 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Add support of driving MPU9250 magnetometer connected on i2c
> auxiliary bus using the MPU i2c master.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Same issue of the c file not including it's own header. Fixed up.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Makefile       |   2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 144 ++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   4 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 355 +++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h |  36 +++
>  5 files changed, 537 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> index 2cfbd926522f..c103441a906b 100644
> --- a/drivers/iio/imu/inv_mpu6050/Makefile
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -5,7 +5,7 @@
>  
>  obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
>  inv-mpu6050-y := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o \
> -		 inv_mpu_aux.o
> +		 inv_mpu_aux.o inv_mpu_magn.o
>  
>  obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
>  inv-mpu6050-i2c-y := inv_mpu_i2c.o inv_mpu_acpi.o
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7b2e4d81bbba..f1c65e0dd1a5 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include "inv_mpu_iio.h"
> +#include "inv_mpu_magn.h"
>  
>  /*
>   * this is the gyro scale translated from dynamic range plus/minus
> @@ -332,6 +333,11 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
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
> @@ -411,6 +417,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
>  					      IIO_MOD_X, val);
>  		break;
> +	case IIO_MAGN:
> +		ret = inv_mpu_magn_read(st, chan->channel2, val);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -469,6 +478,8 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  				*val2 = INV_MPU6050_TEMP_SCALE;
>  
>  			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_MAGN:
> +			return inv_mpu_magn_get_scale(st, chan, val, val2);
>  		default:
>  			return -EINVAL;
>  		}
> @@ -710,6 +721,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
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
> @@ -795,8 +811,14 @@ inv_get_mount_matrix(const struct iio_dev *indio_dev,
>  		     const struct iio_chan_spec *chan)
>  {
>  	struct inv_mpu6050_state *data = iio_priv(indio_dev);
> +	const struct iio_mount_matrix *matrix;
> +
> +	if (chan->type == IIO_MAGN)
> +		matrix = &data->magn_orient;
> +	else
> +		matrix = &data->orientation;
>  
> -	return &data->orientation;
> +	return matrix;
>  }
>  
>  static const struct iio_chan_spec_ext_info inv_ext_info[] = {
> @@ -864,6 +886,98 @@ static const unsigned long inv_mpu_scan_masks[] = {
>  	0,
>  };
>  
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

This doesn't need to be set as 0 is the 'obvious' default.

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
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
> +
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU6050_SCAN_ACCL_X),
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU6050_SCAN_ACCL_Y),
> +	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
> +
> +	/* Magnetometer resolution is 16 bits */
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 16, INV_MPU9X50_SCAN_MAGN_X),
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Y, 16, INV_MPU9X50_SCAN_MAGN_Y),
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCAN_MAGN_Z),
> +};
> +
> +static const unsigned long inv_mpu9x50_scan_masks[] = {
> +	/* 3-axis accel */
> +	BIT(INV_MPU6050_SCAN_ACCL_X)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Z),
> +	/* 3-axis gyro */
> +	BIT(INV_MPU6050_SCAN_GYRO_X)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Z),
> +	/* 3-axis magn */
> +	BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	/* 6-axis accel + gyro */
> +	BIT(INV_MPU6050_SCAN_ACCL_X)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Z)
> +		| BIT(INV_MPU6050_SCAN_GYRO_X)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Z),
> +	/* 6-axis accel + magn */
> +	BIT(INV_MPU6050_SCAN_ACCL_X)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Z)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	/* 6-axis gyro + magn */
> +	BIT(INV_MPU6050_SCAN_GYRO_X)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Z)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	/* 9-axis accel + gyro + magn */
> +	BIT(INV_MPU6050_SCAN_ACCL_X)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> +		| BIT(INV_MPU6050_SCAN_ACCL_Z)
> +		| BIT(INV_MPU6050_SCAN_GYRO_X)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> +		| BIT(INV_MPU6050_SCAN_GYRO_Z)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> +		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	0,
> +};
> +
>  static const struct iio_chan_spec inv_icm20602_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
>  	{
> @@ -1145,6 +1259,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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
> @@ -1168,14 +1287,33 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  	if (inv_mpu_bus_setup)
>  		inv_mpu_bus_setup(indio_dev);
>  
> -	if (chip_type == INV_ICM20602) {
> +	switch (chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		/*
> +		 * Use magnetometer inside the chip only if there is no i2c
> +		 * auxiliary device in use.
> +		 */
> +		if (!st->magn_disabled) {
> +			indio_dev->channels = inv_mpu9250_channels;
> +			indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
> +			indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
> +		} else {
> +			indio_dev->channels = inv_mpu_channels;
> +			indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +			indio_dev->available_scan_masks = inv_mpu_scan_masks;
> +		}
> +		break;
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
> index 04215bc6e8ab..953f85618199 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -130,6 +130,8 @@ struct inv_mpu6050_hw {
>   *  @data_timestamp:	timestamp for next data sample.
>   *  @vddio_supply	voltage regulator for the chip.
>   *  @magn_disabled:     magnetometer disabled for backward compatibility reason.
> + *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
> + *  @magn_orient:       magnetometer sensor chip orientation if available.
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -152,6 +154,8 @@ struct inv_mpu6050_state {
>  	s64 data_timestamp;
>  	struct regulator *vddio_supply;
>  	bool magn_disabled;
> +	s32 magn_raw_to_gauss[3];
> +	struct iio_mount_matrix magn_orient;
>  };
>  
>  /*register and associated bit definition*/
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> new file mode 100644
> index 000000000000..415d8acece54
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -0,0 +1,355 @@
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
> +
> +/*
> + * MPU9250 magnetometer is an AKM AK8963 chip on I2C aux bus
> + */
> +#define INV_MPU_MAGN_I2C_ADDR		0x0C
> +
> +#define INV_MPU_MAGN_REG_WIA		0x00
> +#define INV_MPU_MAGN_BITS_WIA		0x48
> +
> +#define INV_MPU_MAGN_REG_ST1		0x02
> +#define INV_MPU_MAGN_BIT_DRDY		0x01
> +#define INV_MPU_MAGN_BIT_DOR		0x02
> +
> +#define INV_MPU_MAGN_REG_DATA		0x03
> +
> +#define INV_MPU_MAGN_REG_ST2		0x09
> +#define INV_MPU_MAGN_BIT_HOFL		0x08
> +#define INV_MPU_MAGN_BIT_BITM		0x10
> +
> +#define INV_MPU_MAGN_REG_CNTL1		0x0A
> +#define INV_MPU_MAGN_BITS_MODE_PWDN	0x00
> +#define INV_MPU_MAGN_BITS_MODE_SINGLE	0x01
> +#define INV_MPU_MAGN_BITS_MODE_FUSE	0x0F
> +#define INV_MPU_MAGN_BIT_OUTPUT_BIT	0x10
> +
> +#define INV_MPU_MAGN_REG_CNTL2		0x0B
> +#define INV_MPU_MAGN_BIT_SRST		0x01
> +
> +#define INV_MPU_MAGN_REG_ASAX		0x10
> +#define INV_MPU_MAGN_REG_ASAY		0x11
> +#define INV_MPU_MAGN_REG_ASAZ		0x12
> +
> +/* Magnetometer maximum frequency */
> +#define INV_MPU_MAGN_FREQ_HZ_MAX	50
> +
> +static bool inv_magn_supported(const struct inv_mpu6050_state *st)
> +{
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/* init magnetometer chip */
> +static int inv_magn_init(struct inv_mpu6050_state *st)
> +{
> +	uint8_t val;
> +	uint8_t asa[3];
> +	int ret;
> +
> +	/* check whoami */
> +	ret = inv_mpu_aux_read(st, INV_MPU_MAGN_I2C_ADDR, INV_MPU_MAGN_REG_WIA,
> +			       &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +	if (val != INV_MPU_MAGN_BITS_WIA)
> +		return -ENODEV;
> +
> +	/* reset chip */
> +	ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
> +				INV_MPU_MAGN_REG_CNTL2,
> +				INV_MPU_MAGN_BIT_SRST);
> +	if (ret)
> +		return ret;
> +
> +	/* read fuse ROM data */
> +	ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
> +				INV_MPU_MAGN_REG_CNTL1,
> +				INV_MPU_MAGN_BITS_MODE_FUSE);
> +	if (ret)
> +		return ret;
> +
> +	ret = inv_mpu_aux_read(st, INV_MPU_MAGN_I2C_ADDR, INV_MPU_MAGN_REG_ASAX,
> +			       asa, sizeof(asa));
> +	if (ret)
> +		return ret;
> +
> +	/* switch back to power-down */
> +	ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
> +				INV_MPU_MAGN_REG_CNTL1,
> +				INV_MPU_MAGN_BITS_MODE_PWDN);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Sensitivity adjustement and scale to Gauss
> +	 *
> +	 * Hadj = H * (((ASA - 128) * 0.5 / 128) + 1)
> +	 * Factor simplification:
> +	 * Hadj = H * ((ASA + 128) / 256)
> +	 *
> +	 * Sensor sentivity
> +	 * 0.15 uT in 16 bits mode
> +	 * 1 uT = 0.01 G and value is in micron (1e6)
> +	 * sensitvity = 0.15 uT * 0.01 * 1e6
> +	 *
> +	 * raw_to_gauss = Hadj * 1500
> +	 */
> +	st->magn_raw_to_gauss[0] = (((int32_t)asa[0] + 128) * 1500) / 256;
> +	st->magn_raw_to_gauss[1] = (((int32_t)asa[1] + 128) * 1500) / 256;
> +	st->magn_raw_to_gauss[2] = (((int32_t)asa[2] + 128) * 1500) / 256;
> +
> +	return 0;
> +}
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
> +int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
> +{
> +	int ret;
> +
> +	/* quit if chip is not supported */
> +	if (!inv_magn_supported(st))
> +		return 0;
> +
> +	/* configure i2c master aux port */
> +	ret = inv_mpu_aux_init(st);
> +	if (ret)
> +		return ret;
> +
> +	/* check and init mag chip */
> +	ret = inv_magn_init(st);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * configure mpu i2c master accesses
> +	 * i2c SLV0: read sensor data, 7 bytes data(6)-ST2
> +	 * Byte swap data to store them in big-endian in impair address groups
> +	 */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(0),
> +			   INV_MPU6050_BIT_I2C_SLV_RNW | INV_MPU_MAGN_I2C_ADDR);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0),
> +			   INV_MPU_MAGN_REG_DATA);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0),
> +			   INV_MPU6050_BIT_SLV_EN |
> +			   INV_MPU6050_BIT_SLV_BYTE_SW |
> +			   INV_MPU6050_BIT_SLV_GRP |
> +			   INV_MPU9X50_BYTES_MAGN);
> +	if (ret)
> +		return ret;
> +
> +	/* i2c SLV1: launch single measurement */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(1),
> +			   INV_MPU_MAGN_I2C_ADDR);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(1),
> +			   INV_MPU_MAGN_REG_CNTL1);
> +	if (ret)
> +		return ret;
> +
> +	/* add 16 bits mode */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1),
> +			   INV_MPU_MAGN_BITS_MODE_SINGLE |
> +			   INV_MPU_MAGN_BIT_OUTPUT_BIT);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(1),
> +			    INV_MPU6050_BIT_SLV_EN | 1);
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
> +int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate)
> +{
> +	uint8_t d;
> +
> +	/* quit if chip is not supported */
> +	if (!inv_magn_supported(st))
> +		return 0;
> +
> +	/*
> +	 * update i2c master delay to limit mag sampling to max frequency
> +	 * compute fifo_rate divider d: rate = fifo_rate / (d + 1)
> +	 */
> +	if (fifo_rate > INV_MPU_MAGN_FREQ_HZ_MAX)
> +		d = fifo_rate / INV_MPU_MAGN_FREQ_HZ_MAX - 1;
> +	else
> +		d = 0;
> +
> +	return regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL, d);
> +}
> +
> +/**
> + * inv_mpu_magn_set_orient() - fill magnetometer mounting matrix
> + * @st: driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise
> + *
> + * Fill magnetometer mounting matrix using the provided chip matrix.
> + */
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
> +/**
> + * inv_mpu_magn_read() - read magnetometer data
> + * @st: driver internal state
> + * @axis: IIO modifier axis value
> + * @val: store corresponding axis value
> + *
> + * Returns 0 on success, a negative error code otherwise
> + */
> +int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val)
> +{
> +	unsigned int user_ctrl, status;
> +	__be16 data[3];
> +	uint8_t addr;
> +	uint8_t d;
> +	unsigned int period_ms;
> +	int ret;
> +
> +	/* quit if chip is not supported */
> +	if (!inv_magn_supported(st))
> +		return -ENODEV;
> +
> +	/* Mag data: X - Y - Z */
> +	switch (axis) {
> +	case IIO_MOD_X:
> +		addr = 0;
> +		break;
> +	case IIO_MOD_Y:
> +		addr = 1;
> +		break;
> +	case IIO_MOD_Z:
> +		addr = 2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* set sample rate to max mag freq */
> +	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU_MAGN_FREQ_HZ_MAX);
> +	ret = regmap_write(st->map, st->reg->sample_rate_div, d);
> +	if (ret)
> +		return ret;
> +
> +	/* start i2c master, wait for xfer, stop */
> +	user_ctrl = st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
> +	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* need to wait 2 periods + half-period margin */
> +	period_ms = 1000 / INV_MPU_MAGN_FREQ_HZ_MAX;
> +	msleep(period_ms * 2 + period_ms / 2);
> +	user_ctrl = st->chip_config.user_ctrl;
> +	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* restore sample rate */
> +	d = st->chip_config.divider;
> +	ret = regmap_write(st->map, st->reg->sample_rate_div, d);
> +	if (ret)
> +		return ret;
> +
> +	/* check i2c status and read raw data */
> +	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK ||
> +			status & INV_MPU6050_BIT_I2C_SLV1_NACK)
> +		return -EIO;
> +
> +	ret = regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
> +			       data, sizeof(data));
> +	if (ret)
> +		return ret;
> +
> +	*val = (int16_t)be16_to_cpu(data[addr]);
> +
> +	return IIO_VAL_INT;
> +}
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> new file mode 100644
> index 000000000000..b41bd0578478
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> @@ -0,0 +1,36 @@
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
> +int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate);
> +
> +int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st);
> +
> +int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val);
> +
> +#endif		/* INV_MPU_MAGN_H_ */

