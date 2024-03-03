Return-Path: <linux-iio+bounces-3288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1086F647
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7BE1C21991
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7436E5F8;
	Sun,  3 Mar 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+tfJAKz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5576E5F5
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484976; cv=none; b=mJUdQmNK5DkPBTb8N1tUu3PtOFvWNauaAwCLx5JiHZ9AVXo3Sb905UDqlGuvajQdXYaEZMD/QrL0A8FZdQ87wIMpt25Z/g9tYl15K4ZndNaS3H3B8PkZCXdrx0wR1YqH/AgFXsDfSz3nLr7cQzkdmkuFqDTuL9zcOsu/t/NzW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484976; c=relaxed/simple;
	bh=/QuK0LMBv65e+XPv7L3zO/BW48BqXA8OYU85bxz8bWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEfTXslFn8eAncW5Pd085F3YuD+Zwd0spKvLfd6CWj8iL+21WMInA+XFKnHFo1NJ5HiPdKNqzaXNKlPHgPtEafIdcLZj4pprnBbQbrsqBUiZtv+xla9PFKhEG6m5zYtSpAkPBu6rF99FRpkWiot5LulIcRJ1pq/ZjfnAOD/eIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+tfJAKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B745DC433C7;
	Sun,  3 Mar 2024 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709484975;
	bh=/QuK0LMBv65e+XPv7L3zO/BW48BqXA8OYU85bxz8bWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+tfJAKzmMLyciAyx08t9kv1/4jFY6m2PlswtAx2+dsXFLJ9fk0I9mxEr3wSiPi7M
	 JaCDhRFmqMVA1K6Z7EnlkyOFN9erPx2+bgIymB2TFOslozGZIxVDvAw2rgEj9Bx4Sz
	 RNpPH04yJyh+q83aaWPsYXDyjntwvY7T2Toxj/lfBtOA65ttEBK9Do10EGJQ5Z8vXy
	 v5IdEC1uqHM2Vq4DxtHwyXAM+uBuYvzZbmAZdTh+s4vOfp7R7pCPdwHU6n468zJHL0
	 L9x0FaabPGherMwImjpvbJJKEPnpSvjRjhWPWGkDiVnA1/Wj0U2XSTTTHxiqblT0bj
	 HH7WixRYZ7K2A==
Date: Sun, 3 Mar 2024 16:56:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 1/4] iio: imu: inv_mpu6050: add WoM (Wake-on-Motion)
 sensor
Message-ID: <20240303165602.59c29808@jic23-huawei>
In-Reply-To: <20240225160027.200092-2-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
	<20240225160027.200092-2-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 16:00:24 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> WoM is a threshold test on accel value comparing actual sample
> with previous one. It maps best to magnitude adaptive rising
> event.
> Add support of a new WOM sensor and functions for handling the
> corresponding mag_adaptive_rising event. The event value is in
> SI units. Ensure WOM is stopped and restarted at suspend-resume
> and handle usage with buffer data ready interrupt.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

A few questions inline. Things don't seem to align perfectly with the
few datasheets I opened.

Jonathan



> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 5950e2419ebb..519c1eee96ad 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -88,11 +88,12 @@ enum inv_devices {
>  	INV_NUM_PARTS
>  };
>  
> -/* chip sensors mask: accelerometer, gyroscope, temperature, magnetometer */
> +/* chip sensors mask: accelerometer, gyroscope, temperature, magnetometer, WoM */
>  #define INV_MPU6050_SENSOR_ACCL		BIT(0)
>  #define INV_MPU6050_SENSOR_GYRO		BIT(1)
>  #define INV_MPU6050_SENSOR_TEMP		BIT(2)
>  #define INV_MPU6050_SENSOR_MAGN		BIT(3)
> +#define INV_MPU6050_SENSOR_WOM		BIT(4)
>  
>  /**
>   *  struct inv_mpu6050_chip_config - Cached chip configuration data.
> @@ -104,6 +105,7 @@ enum inv_devices {
>   *  @gyro_en:		gyro engine enabled
>   *  @temp_en:		temperature sensor enabled
>   *  @magn_en:		magn engine (i2c master) enabled
> + *  @wom_en:		Wake-on-Motion enabled
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
>   *  @temp_fifo_enable:	enable temp data output
> @@ -119,12 +121,14 @@ struct inv_mpu6050_chip_config {
>  	unsigned int gyro_en:1;
>  	unsigned int temp_en:1;
>  	unsigned int magn_en:1;
> +	unsigned int wom_en:1;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
>  	unsigned int temp_fifo_enable:1;
>  	unsigned int magn_fifo_enable:1;
>  	u8 divider;
>  	u8 user_ctrl;
> +	u8 wom_threshold;
>  };
>  
>  /*
> @@ -256,12 +260,14 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_REG_INT_ENABLE          0x38
>  #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
>  #define INV_MPU6050_BIT_DMP_INT_EN          0x02
> +#define INV_MPU6500_BIT_WOM_INT_EN          (BIT(7) | BIT(6) | BIT(5))

GENMASK?  or build it up as I'm guessing those are the 3 axis?
However I opened the datasheet from the tdk website and only bit(6) is mentioned.

>  
>  #define INV_MPU6050_REG_RAW_ACCEL           0x3B
>  #define INV_MPU6050_REG_TEMPERATURE         0x41
>  #define INV_MPU6050_REG_RAW_GYRO            0x43
>  
>  #define INV_MPU6050_REG_INT_STATUS          0x3A
> +#define INV_MPU6500_BIT_WOM_INT             (BIT(7) | BIT(6) | BIT(5))

Likewise on this, the mpu6500 datasheet only mentions bit(6)

>  #define INV_MPU6050_BIT_FIFO_OVERFLOW_INT   0x10
>  #define INV_MPU6050_BIT_RAW_DATA_RDY_INT    0x01
>  
> @@ -301,6 +307,11 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BIT_PWR_ACCL_STBY       0x38
>  #define INV_MPU6050_BIT_PWR_GYRO_STBY       0x07
>  
> +/* ICM20609 registers */
> +#define INV_ICM20609_REG_ACCEL_WOM_X_THR    0x20
> +#define INV_ICM20609_REG_ACCEL_WOM_Y_THR    0x21
> +#define INV_ICM20609_REG_ACCEL_WOM_Z_THR    0x22
This one does mention all 3 bits for the enable and status registers.
Perhaps there is more inter chip variation than currently covered?
I don't like writing reserved bits unless we have a clear statement
(and a comment here) that it is correct thing to do.


> +
>  /* ICM20602 register */
>  #define INV_ICM20602_REG_I2C_IF             0x70
>  #define INV_ICM20602_BIT_I2C_IF_DIS         0x40
> @@ -320,6 +331,10 @@ struct inv_mpu6050_state {
>  /* mpu6500 registers */
>  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
>  #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
> +#define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
> +#define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
> +#define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
> +#define INV_MPU6500_BIT_ACCEL_INTEL_MODE    BIT(6)
>  #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
>  
>  /* delay time in milliseconds */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 66d4ba088e70..13da6f523ca2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -33,10 +33,8 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
>  
>  reset_fifo_fail:
>  	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
> -	result = regmap_write(st->map, st->reg->int_enable,
> -			      INV_MPU6050_BIT_DATA_RDY_EN);
> -
> -	return result;
> +	return regmap_update_bits(st->map, st->reg->int_enable,
> +			INV_MPU6050_BIT_DATA_RDY_EN, INV_MPU6050_BIT_DATA_RDY_EN);
>  }
>  
>  /*
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 676704f9151f..ec2398a87f45 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -134,11 +134,13 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
>  		ret = regmap_write(st->map, st->reg->user_ctrl, d);
>  		if (ret)
>  			return ret;
> -		/* enable interrupt */
> -		ret = regmap_write(st->map, st->reg->int_enable,
> -				   INV_MPU6050_BIT_DATA_RDY_EN);
> +		/* enable data interrupt */
> +		ret = regmap_update_bits(st->map, st->reg->int_enable,
> +				INV_MPU6050_BIT_DATA_RDY_EN, INV_MPU6050_BIT_DATA_RDY_EN);
>  	} else {
> -		ret = regmap_write(st->map, st->reg->int_enable, 0);
> +		/* disable data interrupt */
> +		ret = regmap_update_bits(st->map, st->reg->int_enable,
> +				INV_MPU6050_BIT_DATA_RDY_EN, 0);
>  		if (ret)
>  			return ret;
>  		ret = regmap_write(st->map, st->reg->fifo_en, 0);
> @@ -171,9 +173,9 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  			return result;
>  		/*
>  		 * In case autosuspend didn't trigger, turn off first not
> -		 * required sensors.
> +		 * required sensors excepted WoM
>  		 */
> -		result = inv_mpu6050_switch_engine(st, false, ~scan);
> +		result = inv_mpu6050_switch_engine(st, false, ~scan & ~INV_MPU6050_SENSOR_WOM);
>  		if (result)
>  			goto error_power_off;
>  		result = inv_mpu6050_switch_engine(st, true, scan);


