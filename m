Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEBEB3014
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfIONNb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:13:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbfIONNb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:13:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38F2214D8;
        Sun, 15 Sep 2019 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568553209;
        bh=vFhkin3nTWjGZpyxOp8g4r2hyEJiKScHQGFljWC+KvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j0fJNbo/iArzf+a9v0Q9UeC/RC2A/SmyAVnYUobpswCuu1z0hou6BFl0Io039aLiV
         +8K0v5Q+tWRvwTsxYZjMdis8OnPG2KH8uTQAurXsX2PSx+w9swXIiUggSBW2YRFUzR
         Hb/N4B5iQrFqSj+MaAMk4hfR5zDVAV4zre1Ps2Qo=
Date:   Sun, 15 Sep 2019 14:13:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] iio: imu: inv_mpu6050: helpers for using i2c
 master on auxiliary bus
Message-ID: <20190915141325.0111f36d@archlinux>
In-Reply-To: <20190912105804.15650-5-jmaneyrol@invensense.com>
References: <20190912105804.15650-1-jmaneyrol@invensense.com>
        <20190912105804.15650-5-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Sep 2019 10:58:34 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Add helper functions to use the i2c auxiliary bus with the MPU i2c
> master block.
> 
> Support only register based chip, reading and 1 byte writing. These
> will be useful for initializing magnetometers inside MPU9x50 chips.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Docs should be by the implementation not in the header.

Otherwise, this looks fine I think. I'm not planning to plough through
datasheets for this set so mostly assuming you got it right ;)

Jonathan



> ---
>  drivers/iio/imu/inv_mpu6050/Makefile      |   3 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c | 184 ++++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h |  46 ++++++
>  3 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> index 33bec09fee9b..2cfbd926522f 100644
> --- a/drivers/iio/imu/inv_mpu6050/Makefile
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -4,7 +4,8 @@
>  #
>  
>  obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
> -inv-mpu6050-y := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
> +inv-mpu6050-y := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o \
> +		 inv_mpu_aux.o
>  
>  obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
>  inv-mpu6050-i2c-y := inv_mpu_i2c.o inv_mpu_acpi.o
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
> new file mode 100644
> index 000000000000..b4907c1a8bb6
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 TDK-InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/delay.h>
> +
> +#include "inv_mpu_iio.h"
> +
> +/*
> + * i2c master auxiliary bus transfer function.
> + * Requires the i2c operations to be correctly setup before.
> + */
> +static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
> +{
> +	/* use 50hz frequency for xfer */
> +	const unsigned int freq = 50;
> +	const unsigned int period_ms = 1000 / freq;
> +	uint8_t d;
> +	unsigned int user_ctrl;
> +	int ret;
> +
> +	/* set sample rate */
> +	d = INV_MPU6050_FIFO_RATE_TO_DIVIDER(freq);
> +	ret = regmap_write(st->map, st->reg->sample_rate_div, d);
> +	if (ret)
> +		return ret;
> +
> +	/* start i2c master */
> +	user_ctrl = st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
> +	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +	if (ret)
> +		goto error_restore_rate;
> +
> +	/* wait for xfer: 1 period + half-period margin */
> +	msleep(period_ms + period_ms / 2);
> +
> +	/* stop i2c master */
> +	user_ctrl = st->chip_config.user_ctrl;
> +	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +	if (ret)
> +		goto error_stop_i2c;
> +
> +	/* restore sample rate */
> +	d = st->chip_config.divider;
> +	ret = regmap_write(st->map, st->reg->sample_rate_div, d);
> +	if (ret)
> +		goto error_restore_rate;
> +
> +	return 0;
> +
> +error_stop_i2c:
> +	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
> +error_restore_rate:
> +	regmap_write(st->map, st->reg->sample_rate_div, st->chip_config.divider);
> +	return ret;
> +}
> +
> +int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* configure i2c master */
> +	val = INV_MPU6050_BITS_I2C_MST_CLK_400KHZ |
> +			INV_MPU6050_BIT_WAIT_FOR_ES;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_MST_CTRL, val);
> +	if (ret)
> +		return ret;
> +
> +	/* configure i2c master delay */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL, 0);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_MPU6050_BIT_I2C_SLV0_DLY_EN |
> +			INV_MPU6050_BIT_I2C_SLV1_DLY_EN |
> +			INV_MPU6050_BIT_I2C_SLV2_DLY_EN |
> +			INV_MPU6050_BIT_I2C_SLV3_DLY_EN |
> +			INV_MPU6050_BIT_DELAY_ES_SHADOW;
> +	return regmap_write(st->map, INV_MPU6050_REG_I2C_MST_DELAY_CTRL, val);
> +}
> +
> +/*
> + * i2c slave reading using SLV0
> + */
> +int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
> +		     uint8_t reg, uint8_t *val, size_t size)
> +{
> +	unsigned int status;
> +	int ret;
> +
> +	if (size > 0x0F)
> +		return -EINVAL;
> +
> +	/* setup i2c SLV0 control: i2c addr, register, enable + size */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(0),
> +			   INV_MPU6050_BIT_I2C_SLV_RNW | addr);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0), reg);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0),
> +			   INV_MPU6050_BIT_SLV_EN | size);
> +	if (ret)
> +		return ret;
> +
> +	/* do i2c xfer */
> +	ret = inv_mpu_i2c_master_xfer(st);
> +	if (ret)
> +		goto error_disable_i2c;
> +
> +	/* disable i2c slave */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
> +	if (ret)
> +		goto error_disable_i2c;
> +
> +	/* check i2c status */
> +	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
> +	if (ret)
> +		return ret;
> +	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
> +		return -EIO;
> +
> +	/* read data in registers */
> +	return regmap_bulk_read(st->map, INV_MPU6050_REG_EXT_SENS_DATA,
> +				val, size);
> +
> +error_disable_i2c:
> +	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
> +	return ret;
> +}
> +
> +/*
> + * i2c slave writing 1 byte using SLV0
> + */
> +int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
> +		      uint8_t reg, uint8_t val)
> +{
> +	unsigned int status;
> +	int ret;
> +
> +	/* setup i2c SLV0 control: i2c addr, register, value, enable + size */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(0), addr);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(0), reg);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(0), val);
> +	if (ret)
> +		return ret;
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0),
> +			   INV_MPU6050_BIT_SLV_EN | 1);
> +	if (ret)
> +		return ret;
> +
> +	/* do i2c xfer */
> +	ret = inv_mpu_i2c_master_xfer(st);
> +	if (ret)
> +		goto error_disable_i2c;
> +
> +	/* disable i2c slave */
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
> +	if (ret)
> +		goto error_disable_i2c;
> +
> +	/* check i2c status */
> +	ret = regmap_read(st->map, INV_MPU6050_REG_I2C_MST_STATUS, &status);
> +	if (ret)
> +		return ret;
> +	if (status & INV_MPU6050_BIT_I2C_SLV0_NACK)
> +		return -EIO;
> +
> +	return 0;
> +
> +error_disable_i2c:
> +	regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(0), 0);
> +	return ret;
> +}
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
> new file mode 100644
> index 000000000000..bae4eab58e6c
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019 TDK-InvenSense, Inc.
> + */
> +
> +#ifndef INV_MPU_AUX_H_
> +#define INV_MPU_AUX_H_
> +
> +#include <linux/kernel.h>
> +
> +#include "inv_mpu_iio.h"
> +
> +/**
> + * inv_mpu_aux_init() - init i2c auxiliary bus
> + * @st: driver internal state
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +int inv_mpu_aux_init(const struct inv_mpu6050_state *st);
> +
> +/**
> + * inv_mpu_aux_read() - read register function for i2c auxiliary bus
> + * @st: driver internal state.
> + * @addr: chip i2c Address
> + * @reg: chip register address
> + * @val: buffer for storing read bytes
> + * @size: number of bytes to read
> + *
> + *  Returns 0 on success, a negative error code otherwise.

Documentation at implementation, not in the header.
Tends to rot when hidden away from the code.

> + */
> +int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
> +		     uint8_t reg, uint8_t *val, size_t size);
> +
> +/**
> + * inv_mpu_aux_write() - write register function for i2c auxiliary bus
> + * @st: driver internal state.
> + * @addr: chip i2c Address
> + * @reg: chip register address
> + * @val: 1 byte value to write
> + *
> + *  Returns 0 on success, a negative error code otherwise.
> + */
> +int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
> +		      uint8_t reg, uint8_t val);
> +
> +#endif		/* INV_MPU_AUX_H_ */

