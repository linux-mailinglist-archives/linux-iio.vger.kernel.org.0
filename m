Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D546715FF9F
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 19:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgBOSJh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 13:09:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgBOSJg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Feb 2020 13:09:36 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A1532086A;
        Sat, 15 Feb 2020 18:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581790174;
        bh=2VvjzZSASqxyjOT7gYcDtEGfVzJPSIOBAYa1S4KMBbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=prUcrN04+UMF1mXT4xQNmHKFDd6K9UHOYX6y+ofqze7yhDUhCbJ3m+12pLrti4ye5
         /TrP2bXnm+yIoKek3R5xoy4qPwCQ16qiOO2TahhEZJl2/+pi2l5mvzKaVMJG+4DDM4
         zlIq3FIRrGWYrS+Crx4jkmfAeZdmLQ+qr7t0vfOA=
Date:   Sat, 15 Feb 2020 18:09:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/13] iio: imu: inv_mpu6050: rewrite power and engine
 management
Message-ID: <20200215180930.5ebecddc@archlinux>
In-Reply-To: <20200212174048.1034-9-jmaneyrol@invensense.com>
References: <20200212174048.1034-1-jmaneyrol@invensense.com>
        <20200212174048.1034-9-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 Feb 2020 18:40:43 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Rewrite clock management to use automatic clock switching
> present since MPU6500.
> Sensors engine management can now turn on or off a batch of
> sensors which simplifies usage a lot.
> Temperature sensor is now turned on/off depending on usage.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
At the fairly superficial level at which I'm reading this it all
looks fine.  I suspect I'll not go into this in enough detail to
understand it properly.  Will apply once the rest are ready to
go.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 264 +++++++++++++-----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  24 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    |  12 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    |   2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  91 +++---
>  5 files changed, 262 insertions(+), 131 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 63cdde20df7e..a51efc4c941b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -99,9 +99,31 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
>  };
>  
>  static const struct inv_mpu6050_chip_config chip_config_6050 = {
> +	.clk = INV_CLK_INTERNAL,
>  	.fsr = INV_MPU6050_FSR_2000DPS,
>  	.lpf = INV_MPU6050_FILTER_20HZ,
>  	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(50),
> +	.gyro_en = true,
> +	.accl_en = true,
> +	.temp_en = true,
> +	.magn_en = false,
> +	.gyro_fifo_enable = false,
> +	.accl_fifo_enable = false,
> +	.temp_fifo_enable = false,
> +	.magn_fifo_enable = false,
> +	.accl_fs = INV_MPU6050_FS_02G,
> +	.user_ctrl = 0,
> +};
> +
> +static const struct inv_mpu6050_chip_config chip_config_6500 = {
> +	.clk = INV_CLK_PLL,
> +	.fsr = INV_MPU6050_FSR_2000DPS,
> +	.lpf = INV_MPU6050_FILTER_20HZ,
> +	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(50),
> +	.gyro_en = true,
> +	.accl_en = true,
> +	.temp_en = true,
> +	.magn_en = false,
>  	.gyro_fifo_enable = false,
>  	.accl_fifo_enable = false,
>  	.temp_fifo_enable = false,
> @@ -124,7 +146,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_MPU6500_WHOAMI_VALUE,
>  		.name = "MPU6500",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 512,
>  		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
> @@ -132,7 +154,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_MPU6515_WHOAMI_VALUE,
>  		.name = "MPU6515",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 512,
>  		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
> @@ -156,7 +178,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_MPU9250_WHOAMI_VALUE,
>  		.name = "MPU9250",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 512,
>  		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
> @@ -164,7 +186,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_MPU9255_WHOAMI_VALUE,
>  		.name = "MPU9255",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 512,
>  		.temp = {INV_MPU6500_TEMP_OFFSET, INV_MPU6500_TEMP_SCALE},
>  	},
> @@ -172,7 +194,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_ICM20608_WHOAMI_VALUE,
>  		.name = "ICM20608",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 512,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
> @@ -180,7 +202,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_ICM20609_WHOAMI_VALUE,
>  		.name = "ICM20609",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 4 * 1024,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
> @@ -188,7 +210,7 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_ICM20689_WHOAMI_VALUE,
>  		.name = "ICM20689",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 4 * 1024,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
> @@ -196,15 +218,15 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_ICM20602_WHOAMI_VALUE,
>  		.name = "ICM20602",
>  		.reg = &reg_set_icm20602,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 1008,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
>  	{
>  		.whoami = INV_ICM20690_WHOAMI_VALUE,
>  		.name = "ICM20690",
> -		.reg = &reg_set_icm20602,
> -		.config = &chip_config_6050,
> +		.reg = &reg_set_6500,
> +		.config = &chip_config_6500,
>  		.fifo_size = 1024,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
> @@ -212,61 +234,162 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.whoami = INV_IAM20680_WHOAMI_VALUE,
>  		.name = "IAM20680",
>  		.reg = &reg_set_6500,
> -		.config = &chip_config_6050,
> +		.config = &chip_config_6500,
>  		.fifo_size = 512,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
>  };
>  
> -int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
> +static int inv_mpu6050_pwr_mgmt_1_write(struct inv_mpu6050_state *st, bool sleep,
> +					int clock, int temp_dis)
>  {
> -	unsigned int d, mgmt_1;
> -	int result;
> -	/*
> -	 * switch clock needs to be careful. Only when gyro is on, can
> -	 * clock source be switched to gyro. Otherwise, it must be set to
> -	 * internal clock
> -	 */
> -	if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
> -		result = regmap_read(st->map, st->reg->pwr_mgmt_1, &mgmt_1);
> -		if (result)
> -			return result;
> +	u8 val;
> +
> +	if (clock < 0)
> +		clock = st->chip_config.clk;
> +	if (temp_dis < 0)
> +		temp_dis = !st->chip_config.temp_en;
> +
> +	val = clock & INV_MPU6050_BIT_CLK_MASK;
> +	if (temp_dis)
> +		val |= INV_MPU6050_BIT_TEMP_DIS;
> +	if (sleep)
> +		val |= INV_MPU6050_BIT_SLEEP;
> +
> +	dev_dbg(regmap_get_device(st->map), "pwr_mgmt_1: 0x%x\n", val);
> +	return regmap_write(st->map, st->reg->pwr_mgmt_1, val);
> +}
> +
> +static int inv_mpu6050_clock_switch(struct inv_mpu6050_state *st,
> +				    unsigned int clock)
> +{
> +	int ret;
> +
> +	switch (st->chip_type) {
> +	case INV_MPU6050:
> +	case INV_MPU6000:
> +	case INV_MPU9150:
> +		/* old chips: switch clock manually */
> +		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, clock, -1);
> +		if (ret)
> +			return ret;
> +		st->chip_config.clk = clock;
> +		break;
> +	default:
> +		/* automatic clock switching, nothing to do */
> +		break;
> +	}
> +
> +	return 0;
> +}
>  
> -		mgmt_1 &= ~INV_MPU6050_BIT_CLK_MASK;
> +int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
> +			      unsigned int mask)
> +{
> +	unsigned int sleep;
> +	u8 pwr_mgmt2, user_ctrl;
> +	int ret;
> +
> +	/* delete useless requests */
> +	if (mask & INV_MPU6050_SENSOR_ACCL && en == st->chip_config.accl_en)
> +		mask &= ~INV_MPU6050_SENSOR_ACCL;
> +	if (mask & INV_MPU6050_SENSOR_GYRO && en == st->chip_config.gyro_en)
> +		mask &= ~INV_MPU6050_SENSOR_GYRO;
> +	if (mask & INV_MPU6050_SENSOR_TEMP && en == st->chip_config.temp_en)
> +		mask &= ~INV_MPU6050_SENSOR_TEMP;
> +	if (mask & INV_MPU6050_SENSOR_MAGN && en == st->chip_config.magn_en)
> +		mask &= ~INV_MPU6050_SENSOR_MAGN;
> +	if (mask == 0)
> +		return 0;
> +
> +	/* turn on/off temperature sensor */
> +	if (mask & INV_MPU6050_SENSOR_TEMP) {
> +		ret = inv_mpu6050_pwr_mgmt_1_write(st, false, -1, !en);
> +		if (ret)
> +			return ret;
> +		st->chip_config.temp_en = en;
>  	}
>  
> -	if ((mask == INV_MPU6050_BIT_PWR_GYRO_STBY) && (!en)) {
> -		/*
> -		 * turning off gyro requires switch to internal clock first.
> -		 * Then turn off gyro engine
> -		 */
> -		mgmt_1 |= INV_CLK_INTERNAL;
> -		result = regmap_write(st->map, st->reg->pwr_mgmt_1, mgmt_1);
> -		if (result)
> -			return result;
> +	/* update user_crtl for driving magnetometer */
> +	if (mask & INV_MPU6050_SENSOR_MAGN) {
> +		user_ctrl = st->chip_config.user_ctrl;
> +		if (en)
> +			user_ctrl |= INV_MPU6050_BIT_I2C_MST_EN;
> +		else
> +			user_ctrl &= ~INV_MPU6050_BIT_I2C_MST_EN;
> +		ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +		if (ret)
> +			return ret;
> +		st->chip_config.user_ctrl = user_ctrl;
> +		st->chip_config.magn_en = en;
>  	}
>  
> -	result = regmap_read(st->map, st->reg->pwr_mgmt_2, &d);
> -	if (result)
> -		return result;
> -	if (en)
> -		d &= ~mask;
> -	else
> -		d |= mask;
> -	result = regmap_write(st->map, st->reg->pwr_mgmt_2, d);
> -	if (result)
> -		return result;
> +	/* manage accel & gyro engines */
> +	if (mask & (INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO)) {
> +		/* compute power management 2 current value */
> +		pwr_mgmt2 = 0;
> +		if (!st->chip_config.accl_en)
> +			pwr_mgmt2 |= INV_MPU6050_BIT_PWR_ACCL_STBY;
> +		if (!st->chip_config.gyro_en)
> +			pwr_mgmt2 |= INV_MPU6050_BIT_PWR_GYRO_STBY;
> +
> +		/* update to new requested value */
> +		if (mask & INV_MPU6050_SENSOR_ACCL) {
> +			if (en)
> +				pwr_mgmt2 &= ~INV_MPU6050_BIT_PWR_ACCL_STBY;
> +			else
> +				pwr_mgmt2 |= INV_MPU6050_BIT_PWR_ACCL_STBY;
> +		}
> +		if (mask & INV_MPU6050_SENSOR_GYRO) {
> +			if (en)
> +				pwr_mgmt2 &= ~INV_MPU6050_BIT_PWR_GYRO_STBY;
> +			else
> +				pwr_mgmt2 |= INV_MPU6050_BIT_PWR_GYRO_STBY;
> +		}
>  
> -	if (en) {
> -		/* Wait for output to stabilize */
> -		msleep(INV_MPU6050_TEMP_UP_TIME);
> -		if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
> -			/* switch internal clock to PLL */
> -			mgmt_1 |= INV_CLK_PLL;
> -			result = regmap_write(st->map,
> -					      st->reg->pwr_mgmt_1, mgmt_1);
> -			if (result)
> -				return result;
> +		/* switch clock to internal when turning gyro off */
> +		if (mask & INV_MPU6050_SENSOR_GYRO && !en) {
> +			ret = inv_mpu6050_clock_switch(st, INV_CLK_INTERNAL);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* update sensors engine */
> +		dev_dbg(regmap_get_device(st->map), "pwr_mgmt_2: 0x%x\n",
> +			pwr_mgmt2);
> +		ret = regmap_write(st->map, st->reg->pwr_mgmt_2, pwr_mgmt2);
> +		if (ret)
> +			return ret;
> +		if (mask & INV_MPU6050_SENSOR_ACCL)
> +			st->chip_config.accl_en = en;
> +		if (mask & INV_MPU6050_SENSOR_GYRO)
> +			st->chip_config.gyro_en = en;
> +
> +		/* compute required time to have sensors stabilized */
> +		sleep = 0;
> +		if (en) {
> +			if (mask & INV_MPU6050_SENSOR_ACCL) {
> +				if (sleep < INV_MPU6050_ACCEL_UP_TIME)
> +					sleep = INV_MPU6050_ACCEL_UP_TIME;
> +			}
> +			if (mask & INV_MPU6050_SENSOR_GYRO) {
> +				if (sleep < INV_MPU6050_GYRO_UP_TIME)
> +					sleep = INV_MPU6050_GYRO_UP_TIME;
> +			}
> +		} else {
> +			if (mask & INV_MPU6050_SENSOR_GYRO) {
> +				if (sleep < INV_MPU6050_GYRO_DOWN_TIME)
> +					sleep = INV_MPU6050_GYRO_DOWN_TIME;
> +			}
> +		}
> +		if (sleep)
> +			msleep(sleep);
> +
> +		/* switch clock to PLL when turning gyro on */
> +		if (mask & INV_MPU6050_SENSOR_GYRO && en) {
> +			ret = inv_mpu6050_clock_switch(st, INV_CLK_PLL);
> +			if (ret)
> +				return ret;
>  		}
>  	}
>  
> @@ -279,7 +402,7 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  
>  	if (power_on) {
>  		if (!st->powerup_count) {
> -			result = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
> +			result = inv_mpu6050_pwr_mgmt_1_write(st, false, -1, -1);
>  			if (result)
>  				return result;
>  			usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> @@ -288,8 +411,7 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  		st->powerup_count++;
>  	} else {
>  		if (st->powerup_count == 1) {
> -			result = regmap_write(st->map, st->reg->pwr_mgmt_1,
> -					      INV_MPU6050_BIT_SLEEP);
> +			result = inv_mpu6050_pwr_mgmt_1_write(st, true, -1, -1);
>  			if (result)
>  				return result;
>  		}
> @@ -451,33 +573,41 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  	switch (chan->type) {
>  	case IIO_ANGL_VEL:
>  		result = inv_mpu6050_switch_engine(st, true,
> -				INV_MPU6050_BIT_PWR_GYRO_STBY);
> +				INV_MPU6050_SENSOR_GYRO);
>  		if (result)
>  			goto error_power_off;
>  		ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
>  					      chan->channel2, val);
>  		result = inv_mpu6050_switch_engine(st, false,
> -				INV_MPU6050_BIT_PWR_GYRO_STBY);
> +				INV_MPU6050_SENSOR_GYRO);
>  		if (result)
>  			goto error_power_off;
>  		break;
>  	case IIO_ACCEL:
>  		result = inv_mpu6050_switch_engine(st, true,
> -				INV_MPU6050_BIT_PWR_ACCL_STBY);
> +				INV_MPU6050_SENSOR_ACCL);
>  		if (result)
>  			goto error_power_off;
>  		ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
>  					      chan->channel2, val);
>  		result = inv_mpu6050_switch_engine(st, false,
> -				INV_MPU6050_BIT_PWR_ACCL_STBY);
> +				INV_MPU6050_SENSOR_ACCL);
>  		if (result)
>  			goto error_power_off;
>  		break;
>  	case IIO_TEMP:
> +		result = inv_mpu6050_switch_engine(st, true,
> +				INV_MPU6050_SENSOR_TEMP);
> +		if (result)
> +			goto error_power_off;
>  		/* wait for stablization */
> -		msleep(INV_MPU6050_SENSOR_UP_TIME);
> +		msleep(INV_MPU6050_TEMP_UP_TIME);
>  		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
>  					      IIO_MOD_X, val);
> +		result = inv_mpu6050_switch_engine(st, false,
> +				INV_MPU6050_SENSOR_TEMP);
> +		if (result)
> +			goto error_power_off;
>  		break;
>  	case IIO_MAGN:
>  		ret = inv_mpu_magn_read(st, chan->channel2, val);
> @@ -1108,7 +1238,7 @@ static const struct iio_info mpu_info = {
>  static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  {
>  	int result;
> -	unsigned int regval;
> +	unsigned int regval, mask;
>  	int i;
>  
>  	st->hw  = &hw_info[st->chip_type];
> @@ -1174,13 +1304,9 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> -
> -	result = inv_mpu6050_switch_engine(st, false,
> -					   INV_MPU6050_BIT_PWR_ACCL_STBY);
> -	if (result)
> -		goto error_power_off;
> -	result = inv_mpu6050_switch_engine(st, false,
> -					   INV_MPU6050_BIT_PWR_GYRO_STBY);
> +	mask = INV_MPU6050_SENSOR_ACCL | INV_MPU6050_SENSOR_GYRO |
> +			INV_MPU6050_SENSOR_TEMP | INV_MPU6050_SENSOR_MAGN;
> +	result = inv_mpu6050_switch_engine(st, false, mask);
>  	if (result)
>  		goto error_power_off;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 17f1f6a15f95..a578789c9210 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -83,11 +83,22 @@ enum inv_devices {
>  	INV_NUM_PARTS
>  };
>  
> +/* chip sensors mask: accelerometer, gyroscope, temperature, magnetometer */
> +#define INV_MPU6050_SENSOR_ACCL		BIT(0)
> +#define INV_MPU6050_SENSOR_GYRO		BIT(1)
> +#define INV_MPU6050_SENSOR_TEMP		BIT(2)
> +#define INV_MPU6050_SENSOR_MAGN		BIT(3)
> +
>  /**
>   *  struct inv_mpu6050_chip_config - Cached chip configuration data.
> + *  @clk:		selected chip clock
>   *  @fsr:		Full scale range.
>   *  @lpf:		Digital low pass filter frequency.
>   *  @accl_fs:		accel full scale range.
> + *  @accl_en:		accel engine enabled
> + *  @gyro_en:		gyro engine enabled
> + *  @temp_en:		temperature sensor enabled
> + *  @magn_en:		magn engine (i2c master) enabled
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
>   *  @temp_fifo_enable:	enable temp data output
> @@ -95,9 +106,14 @@ enum inv_devices {
>   *  @divider:		chip sample rate divider (sample rate divider - 1)
>   */
>  struct inv_mpu6050_chip_config {
> +	unsigned int clk:3;
>  	unsigned int fsr:2;
>  	unsigned int lpf:3;
>  	unsigned int accl_fs:2;
> +	unsigned int accl_en:1;
> +	unsigned int gyro_en:1;
> +	unsigned int temp_en:1;
> +	unsigned int magn_en:1;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
>  	unsigned int temp_fifo_enable:1;
> @@ -262,6 +278,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
>  #define INV_MPU6050_BIT_H_RESET             0x80
>  #define INV_MPU6050_BIT_SLEEP               0x40
> +#define INV_MPU6050_BIT_TEMP_DIS            0x08
>  #define INV_MPU6050_BIT_CLK_MASK            0x7
>  
>  #define INV_MPU6050_REG_PWR_MGMT_2          0x6C
> @@ -292,7 +309,9 @@ struct inv_mpu6050_state {
>  /* delay time in milliseconds */
>  #define INV_MPU6050_POWER_UP_TIME            100
>  #define INV_MPU6050_TEMP_UP_TIME             100
> -#define INV_MPU6050_SENSOR_UP_TIME           30
> +#define INV_MPU6050_ACCEL_UP_TIME            20
> +#define INV_MPU6050_GYRO_UP_TIME             35
> +#define INV_MPU6050_GYRO_DOWN_TIME           150
>  
>  /* delay time in microseconds */
>  #define INV_MPU6050_REG_UP_TIME_MIN          5000
> @@ -417,7 +436,8 @@ enum inv_mpu6050_clock_sel_e {
>  irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
>  int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
>  int inv_reset_fifo(struct iio_dev *indio_dev);
> -int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
> +int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
> +			      unsigned int mask);
>  int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index 607104a2631e..3f402fa56d95 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -316,9 +316,9 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>   *
>   * Returns 0 on success, a negative error code otherwise
>   */
> -int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val)
> +int inv_mpu_magn_read(struct inv_mpu6050_state *st, int axis, int *val)
>  {
> -	unsigned int user_ctrl, status;
> +	unsigned int status;
>  	__be16 data;
>  	uint8_t addr;
>  	unsigned int freq_hz, period_ms;
> @@ -350,16 +350,14 @@ int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val)
>  		freq_hz = INV_MPU_MAGN_FREQ_HZ_MAX;
>  	period_ms = 1000 / freq_hz;
>  
> -	/* start i2c master, wait for xfer, stop */
> -	user_ctrl = st->chip_config.user_ctrl | INV_MPU6050_BIT_I2C_MST_EN;
> -	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +	ret = inv_mpu6050_switch_engine(st, true, INV_MPU6050_SENSOR_MAGN);
>  	if (ret)
>  		return ret;
>  
>  	/* need to wait 2 periods + half-period margin */
>  	msleep(period_ms * 2 + period_ms / 2);
> -	user_ctrl = st->chip_config.user_ctrl;
> -	ret = regmap_write(st->map, st->reg->user_ctrl, user_ctrl);
> +
> +	ret = inv_mpu6050_switch_engine(st, false, INV_MPU6050_SENSOR_MAGN);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> index b41bd0578478..f7ad50ca6c1b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
> @@ -31,6 +31,6 @@ int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate);
>  
>  int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st);
>  
> -int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int *val);
> +int inv_mpu_magn_read(struct inv_mpu6050_state *st, int axis, int *val);
>  
>  #endif		/* INV_MPU_MAGN_H_ */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 5199fe790c30..cfd7243159f6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -5,9 +5,10 @@
>  
>  #include "inv_mpu_iio.h"
>  
> -static void inv_scan_query_mpu6050(struct iio_dev *indio_dev)
> +static unsigned int inv_scan_query_mpu6050(struct iio_dev *indio_dev)
>  {
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
> +	unsigned int mask;
>  
>  	st->chip_config.gyro_fifo_enable =
>  		test_bit(INV_MPU6050_SCAN_GYRO_X,
> @@ -27,17 +28,28 @@ static void inv_scan_query_mpu6050(struct iio_dev *indio_dev)
>  
>  	st->chip_config.temp_fifo_enable =
>  		test_bit(INV_MPU6050_SCAN_TEMP, indio_dev->active_scan_mask);
> +
> +	mask = 0;
> +	if (st->chip_config.gyro_fifo_enable)
> +		mask |= INV_MPU6050_SENSOR_GYRO;
> +	if (st->chip_config.accl_fifo_enable)
> +		mask |= INV_MPU6050_SENSOR_ACCL;
> +	if (st->chip_config.temp_fifo_enable)
> +		mask |= INV_MPU6050_SENSOR_TEMP;
> +
> +	return mask;
>  }
>  
> -static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)
> +static unsigned int inv_scan_query_mpu9x50(struct iio_dev *indio_dev)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	unsigned int mask;
>  
> -	inv_scan_query_mpu6050(indio_dev);
> +	mask = inv_scan_query_mpu6050(indio_dev);
>  
>  	/* no magnetometer if i2c auxiliary bus is used */
>  	if (st->magn_disabled)
> -		return;
> +		return mask;
>  
>  	st->chip_config.magn_fifo_enable =
>  		test_bit(INV_MPU9X50_SCAN_MAGN_X,
> @@ -46,9 +58,13 @@ static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)
>  			 indio_dev->active_scan_mask) ||
>  		test_bit(INV_MPU9X50_SCAN_MAGN_Z,
>  			 indio_dev->active_scan_mask);
> +	if (st->chip_config.magn_fifo_enable)
> +		mask |= INV_MPU6050_SENSOR_MAGN;
> +
> +	return mask;
>  }
>  
> -static void inv_scan_query(struct iio_dev *indio_dev)
> +static unsigned int inv_scan_query(struct iio_dev *indio_dev)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
> @@ -92,62 +108,40 @@ static unsigned int inv_compute_skip_samples(const struct inv_mpu6050_state *st)
>  static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> -	uint8_t d;
> +	unsigned int scan;
>  	int result;
>  
> +	scan = inv_scan_query(indio_dev);
> +
>  	if (enable) {
>  		result = inv_mpu6050_set_power_itg(st, true);
>  		if (result)
>  			return result;
> -		inv_scan_query(indio_dev);
> -		if (st->chip_config.gyro_fifo_enable) {
> -			result = inv_mpu6050_switch_engine(st, true,
> -					INV_MPU6050_BIT_PWR_GYRO_STBY);
> -			if (result)
> -				goto error_power_off;
> -		}
> -		if (st->chip_config.accl_fifo_enable) {
> -			result = inv_mpu6050_switch_engine(st, true,
> -					INV_MPU6050_BIT_PWR_ACCL_STBY);
> -			if (result)
> -				goto error_gyro_off;
> -		}
> -		if (st->chip_config.magn_fifo_enable) {
> -			d = st->chip_config.user_ctrl |
> -					INV_MPU6050_BIT_I2C_MST_EN;
> -			result = regmap_write(st->map, st->reg->user_ctrl, d);
> -			if (result)
> -				goto error_accl_off;
> -			st->chip_config.user_ctrl = d;
> -		}
> +		result = inv_mpu6050_switch_engine(st, true, scan);
> +		if (result)
> +			goto error_power_off;
>  		st->skip_samples = inv_compute_skip_samples(st);
>  		result = inv_reset_fifo(indio_dev);
>  		if (result)
> -			goto error_magn_off;
> +			goto error_sensors_off;
>  	} else {
>  		result = regmap_write(st->map, st->reg->fifo_en, 0);
>  		if (result)
> -			goto error_magn_off;
> +			goto error_fifo_off;
>  
>  		result = regmap_write(st->map, st->reg->int_enable, 0);
>  		if (result)
> -			goto error_magn_off;
> -
> -		d = st->chip_config.user_ctrl & ~INV_MPU6050_BIT_I2C_MST_EN;
> -		result = regmap_write(st->map, st->reg->user_ctrl, d);
> -		if (result)
> -			goto error_magn_off;
> -		st->chip_config.user_ctrl = d;
> +			goto error_fifo_off;
>  
> -		result = inv_mpu6050_switch_engine(st, false,
> -					INV_MPU6050_BIT_PWR_ACCL_STBY);
> +		/* restore user_ctrl for disabling FIFO reading */
> +		result = regmap_write(st->map, st->reg->user_ctrl,
> +				      st->chip_config.user_ctrl);
>  		if (result)
> -			goto error_accl_off;
> +			goto error_sensors_off;
>  
> -		result = inv_mpu6050_switch_engine(st, false,
> -					INV_MPU6050_BIT_PWR_GYRO_STBY);
> +		result = inv_mpu6050_switch_engine(st, false, scan);
>  		if (result)
> -			goto error_gyro_off;
> +			goto error_power_off;
>  
>  		result = inv_mpu6050_set_power_itg(st, false);
>  		if (result)
> @@ -156,18 +150,11 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  
>  	return 0;
>  
> -error_magn_off:
> +error_fifo_off:
>  	/* always restore user_ctrl to disable fifo properly */
> -	st->chip_config.user_ctrl &= ~INV_MPU6050_BIT_I2C_MST_EN;
>  	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
> -error_accl_off:
> -	if (st->chip_config.accl_fifo_enable)
> -		inv_mpu6050_switch_engine(st, false,
> -					  INV_MPU6050_BIT_PWR_ACCL_STBY);
> -error_gyro_off:
> -	if (st->chip_config.gyro_fifo_enable)
> -		inv_mpu6050_switch_engine(st, false,
> -					  INV_MPU6050_BIT_PWR_GYRO_STBY);
> +error_sensors_off:
> +	inv_mpu6050_switch_engine(st, false, scan);
>  error_power_off:
>  	inv_mpu6050_set_power_itg(st, false);
>  	return result;

