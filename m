Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348BAACC84
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfIHL5Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 07:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbfIHL5Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 07:57:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F062081B;
        Sun,  8 Sep 2019 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567943842;
        bh=gq0cAHfCboGGxLDLErcGe70BXN0w2yQR1l9DRElLIJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bq28nCNgmwIyhSFU3bZ84EUA5htiAPN1XvmjZJpRBOymh8Z5wa47uVBniTnmYondL
         ksiYu8Wgksgcb+48uT1dqh7ZurDf+JblfmWnxFN7xvQwYX76mDEGlg9uG2o3H9A3B9
         MUfjqw5hKSBMkFYcdzH+Fhw2m1sYemcKVKDeqEkw=
Date:   Sun, 8 Sep 2019 12:57:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 6/8] iio: imu: inv_mpu6050: add magnetometer
 implementation for MPU925x
Message-ID: <20190908125717.2956301f@archlinux>
In-Reply-To: <20190829151801.13014-7-jmaneyrol@invensense.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
        <20190829151801.13014-7-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Aug 2019 15:18:43 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Add implementation for driving MPU9250 magnetometer connected on
> i2c auxiliary bus using the MPU i2c master. This is currently not
> wired inside the main mpu driver.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

A few comments inline. 

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Makefile          |   2 +-
>  .../iio/imu/inv_mpu6050/inv_mpu9250_magn.c    | 239 ++++++++++++++++++
>  .../iio/imu/inv_mpu6050/inv_mpu9250_magn.h    |  27 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |   4 +
>  4 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> index 187f003c81f2..fee41415ebdb 100644
> --- a/drivers/iio/imu/inv_mpu6050/Makefile
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -5,7 +5,7 @@
>  
>  obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
>  inv-mpu6050-y := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
> -inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) += inv_mpu_aux.o
> +inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) += inv_mpu_aux.o inv_mpu9250_magn.o
>  
>  obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
>  inv-mpu6050-i2c-y := inv_mpu_i2c.o inv_mpu_acpi.o
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c
> new file mode 100644
> index 000000000000..0c2230247557
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 TDK-InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <asm/unaligned.h>
> +
> +#include "inv_mpu_iio.h"
> +#include "inv_mpu_aux.h"
> +#include "inv_mpu9250_magn.h"
> +
> +/*
> + * MPU9250 magnetometer is an AKM AK8963 chip on I2C aux bus
> + */
> +#define INV_MPU9250_MAGN_I2C_ADDR		0x0C
> +
> +#define INV_MPU9250_MAGN_REG_WIA		0x00
> +#define INV_MPU9250_MAGN_BITS_WIA		0x48
> +
> +#define INV_MPU9250_MAGN_REG_ST1		0x02
> +#define INV_MPU9250_MAGN_BIT_DRDY		0x01
> +#define INV_MPU9250_MAGN_BIT_DOR		0x02
> +
> +#define INV_MPU9250_MAGN_REG_DATA		0x03
> +
> +#define INV_MPU9250_MAGN_REG_ST2		0x09
> +#define INV_MPU9250_MAGN_BIT_HOFL		0x08
> +#define INV_MPU9250_MAGN_BIT_BITM		0x10
> +
> +#define INV_MPU9250_MAGN_REG_CNTL1		0x0A
> +#define INV_MPU9250_MAGN_BITS_MODE_PWDN		0x00
> +#define INV_MPU9250_MAGN_BITS_MODE_SINGLE	0x01
> +#define INV_MPU9250_MAGN_BITS_MODE_FUSE		0x0F
> +#define INV_MPU9250_MAGN_BIT_OUTPUT_BIT		0x10
> +
> +#define INV_MPU9250_MAGN_REG_CNTL2		0x0B
> +#define INV_MPU9250_MAGN_BIT_SRST		0x01
> +
> +#define INV_MPU9250_MAGN_REG_ASAX		0x10
> +#define INV_MPU9250_MAGN_REG_ASAY		0x11
> +#define INV_MPU9250_MAGN_REG_ASAZ		0x12
> +
> +/* init magnetometer chip */
> +static int inv_magn_init(struct inv_mpu6050_state *st)
> +{
> +	uint8_t val;
> +	uint8_t asa[3];
> +	int ret;
> +
> +	/* check whoami */
> +	ret = inv_mpu_aux_read(st, INV_MPU9250_MAGN_I2C_ADDR,
> +			       INV_MPU9250_MAGN_REG_WIA, &val, sizeof(val));
> +	if (ret)
> +		return ret;
> +	if (val != INV_MPU9250_MAGN_BITS_WIA)
> +		return -ENODEV;
> +
> +	/* reset chip */
> +	ret = inv_mpu_aux_write(st, INV_MPU9250_MAGN_I2C_ADDR,
> +				INV_MPU9250_MAGN_REG_CNTL2,
> +				INV_MPU9250_MAGN_BIT_SRST);
> +	if (ret)
> +		return ret;
> +
> +	/* read fuse ROM data */
> +	ret = inv_mpu_aux_write(st, INV_MPU9250_MAGN_I2C_ADDR,
> +				INV_MPU9250_MAGN_REG_CNTL1,
> +				INV_MPU9250_MAGN_BITS_MODE_FUSE);
> +	if (ret)
> +		return ret;
> +	ret = inv_mpu_aux_read(st, INV_MPU9250_MAGN_I2C_ADDR,
> +			       INV_MPU9250_MAGN_REG_ASAX, asa, sizeof(asa));
> +	if (ret)
> +		return ret;
> +
> +	/* switch back to power-down */
> +	ret = inv_mpu_aux_write(st, INV_MPU9250_MAGN_I2C_ADDR,
> +				INV_MPU9250_MAGN_REG_CNTL1,
> +				INV_MPU9250_MAGN_BITS_MODE_PWDN);
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
> +	 * sensor sensitivity: 0.15 uT (16 bits)
> +	 * 1 uT = 0.01 G and value is in micron (1e6)
> +	 *
> +	 * Hadj = H * ((ASA + 128) / 256) * 0.15 * 0.01 * 1e6
> +	 * Hadj = H * ((ASA + 128) / 256) * 1500
> +	 */
> +	st->magn_raw_to_gauss[0] = (((int32_t)asa[0] + 128) * 1500) / 256;
> +	st->magn_raw_to_gauss[1] = (((int32_t)asa[1] + 128) * 1500) / 256;
> +	st->magn_raw_to_gauss[2] = (((int32_t)asa[2] + 128) * 1500) / 256;
> +
> +	return 0;
> +}
> +
> +/**
> + * Probe magnetometer chip and setup all i2c transfers.
> + * SLV0: read sensor data
> + * SLV1: launch sensor single measurement
> + *
> + * Sampling data requires 2 cycles to read after measurement.
> + * A measurement can take up to ~10ms.
> + */
> +int inv_mpu9250_magn_probe(struct inv_mpu6050_state *st)
> +{
> +	int ret;
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
> +			   INV_MPU6050_BIT_I2C_SLV_RNW |
> +			   INV_MPU9250_MAGN_I2C_ADDR);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0),
> +			   INV_MPU9250_MAGN_REG_DATA);
> +	if (ret)
> +		return ret;

blank lines in all these locations ideally.  See below.

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
> +			   INV_MPU9250_MAGN_I2C_ADDR);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(1),
> +			   INV_MPU9250_MAGN_REG_CNTL1);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1),
> +			   INV_MPU9250_MAGN_BITS_MODE_SINGLE |
> +			   INV_MPU9250_MAGN_BIT_OUTPUT_BIT);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(1),
> +			   INV_MPU6050_BIT_SLV_EN | 1);
> +	if (ret)
> +		return ret;
> +
return regmap_write....

Check for others of these in the rest of the patches.

> +	return 0;
> +}
> +
> +/**
> + * Read magnetometer data from MPU fifo.
> + * Sampling data requires running the i2c master for 2 cycles.
> + * Use magnetometer maximal supported frequency.
> + */
> +int inv_mpu9250_magn_read(const struct inv_mpu6050_state *st, int axis,
> +			  int *val)
> +{
> +	unsigned int user_ctrl, status;
> +	__be16 data[3];
> +	uint8_t addr;
> +	uint8_t d;
> +	unsigned int period_ms;
> +	int ret;
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
> +	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU9250_MAGN_FREQ_HZ_MAX);
> +	ret = regmap_write(st->map, st->reg->sample_rate_div, d);
> +	if (ret)
> +		return ret;
> +
> +	/* start i2c master, wait for xfer, stop */
> +	user_ctrl = st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
> +	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +	if (ret)
> +		return ret;
blank line.

> +	/* need to wait 2 periods + half-period margin */
> +	period_ms = 1000 / INV_MPU9250_MAGN_FREQ_HZ_MAX;
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

Blank line.

> +	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK ||
> +			status & INV_MPU6050_BIT_I2C_SLV1_NACK)
> +		return -EIO;

Blank lines after error checks like this make the code a little
easier to read.

> +	ret = regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
> +			       data, sizeof(data));
> +	if (ret)
> +		return ret;
> +
> +	*val = (int16_t)be16_to_cpu(data[addr]);
> +
> +	return IIO_VAL_INT;
> +}
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h b/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h
> new file mode 100644
> index 000000000000..9899dd6c560c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 TDK-InvenSense, Inc.
> + */
> +
> +#ifndef INV_MPU9250_MAGN_H_
> +#define INV_MPU9250_MAGN_H_
> +
> +#include <linux/kernel.h>
> +
> +#include "inv_mpu_iio.h"
> +
> +/* Magnetometer maximum frequency */
> +#define INV_MPU9250_MAGN_FREQ_HZ_MAX		50
> +
> +/**
> + * inv_mpu9250_magn_probe() - MPU9250 implementation
> + */
> +int inv_mpu9250_magn_probe(struct inv_mpu6050_state *st);
> +
> +/**
> + * inv_mpu9250_magn_read() - MPU9250 implementation

Documentation by implementation not in the header.  Also full documentation
of all parameters needed if you are going to use kernel-doc style

> + */
> +int inv_mpu9250_magn_read(const struct inv_mpu6050_state *st, int axis,
> +			  int *val);
> +
> +#endif
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 82669ecb4735..5b462672bbcb 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
>   *  @it_timestamp:	timestamp from previous interrupt.
>   *  @data_timestamp:	timestamp for next data sample.
>   *  @vddio_supply	voltage regulator for the chip.
> + *  @magn_raw_to_gauss:	coefficient to convert mag raw value to Gauss.
>   */
>  struct inv_mpu6050_state {
>  	struct mutex lock;
> @@ -150,6 +151,9 @@ struct inv_mpu6050_state {
>  	s64 it_timestamp;
>  	s64 data_timestamp;
>  	struct regulator *vddio_supply;
> +#ifdef CONFIG_INV_MPU6050_MAGN
> +	s32 magn_raw_to_gauss[3];
> +#endif
>  };
>  
>  /*register and associated bit definition*/

