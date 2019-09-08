Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4963CACC8C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfIHMH7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 08:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfIHMH7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 08:07:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DD71218AC;
        Sun,  8 Sep 2019 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567944477;
        bh=z1c2UaTnzOf4cHSnHTpqqdVqEfVS3AV3x9ncGMVw1m8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F2D2urZWH/x+uwEhsfZCtga91q0qL5ALXf3LDAePLylbuxtYLCnV+IOmwR4xaTSX3
         GH6kXVJuTXfWg1M2wG8IhbEZTWH/IW7fRk/WopzveF0m2/oRgyAq+kGhJQjHw4n3Tm
         QXbdsclYjvY4Bo3TGVUkFmNU4HABaGMINqqvb9Cg=
Date:   Sun, 8 Sep 2019 13:07:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 8/8] iio: imu: inv_mpu6050: add fifo support for
 magnetometer data
Message-ID: <20190908130750.20023b6a@archlinux>
In-Reply-To: <20190829151801.13014-9-jmaneyrol@invensense.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
        <20190829151801.13014-9-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Aug 2019 15:18:46 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Put read magnetometer data by mpu inside the fifo.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Inline...

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    |  1 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 14 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 90 +++++++++++++++++--
>  4 files changed, 94 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index d08cec6a8a7a..d4a321fd03a9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -105,6 +105,7 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE),
>  	.gyro_fifo_enable = false,
>  	.accl_fifo_enable = false,
> +	.magn_fifo_enable = false,
>  	.accl_fs = INV_MPU6050_FS_02G,
>  	.user_ctrl = 0,
>  };
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index cfc11cb0a36c..48ed66e39cda 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -86,6 +86,7 @@ enum inv_devices {
>   *  @accl_fs:		accel full scale range.
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
> + *  @magn_fifo_enable:	enable magn data output
>   *  @divider:		chip sample rate divider (sample rate divider - 1)
>   */
>  struct inv_mpu6050_chip_config {
> @@ -94,6 +95,7 @@ struct inv_mpu6050_chip_config {
>  	unsigned int accl_fs:2;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
> +	unsigned int magn_fifo_enable:1;
>  	u8 divider;
>  	u8 user_ctrl;
>  };
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 5f9a5de0bab4..f0a5350c1848 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -14,6 +14,7 @@
>  #include <linux/poll.h>
>  #include <linux/math64.h>
>  #include <asm/unaligned.h>
> +

Clean this stuff up - should not be in this patch.


>  #include "inv_mpu_iio.h"
>  
>  /**
> @@ -124,7 +125,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  
>  	/* enable interrupt */
>  	if (st->chip_config.accl_fifo_enable ||
> -	    st->chip_config.gyro_fifo_enable) {
> +	    st->chip_config.gyro_fifo_enable ||
> +	    st->chip_config.magn_fifo_enable) {
>  		result = regmap_write(st->map, st->reg->int_enable,
>  				      INV_MPU6050_BIT_DATA_RDY_EN);
>  		if (result)
> @@ -141,6 +143,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  		d |= INV_MPU6050_BITS_GYRO_OUT;
>  	if (st->chip_config.accl_fifo_enable)
>  		d |= INV_MPU6050_BIT_ACCEL_OUT;
> +	if (st->chip_config.magn_fifo_enable)
> +		d |= INV_MPU6050_BIT_SLAVE_0;
>  	result = regmap_write(st->map, st->reg->fifo_en, d);
>  	if (result)
>  		goto reset_fifo_fail;
> @@ -190,17 +194,19 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	}
>  
>  	if (!(st->chip_config.accl_fifo_enable |
> -		st->chip_config.gyro_fifo_enable))
> +		st->chip_config.gyro_fifo_enable |
> +		st->chip_config.magn_fifo_enable))
>  		goto end_session;
> +
>  	bytes_per_datum = 0;
>  	if (st->chip_config.accl_fifo_enable)
>  		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> -
I don't want to see white space changes in a patch doing something else.
Better to just be consistent and carry on with the blank line for your new
case.

>  	if (st->chip_config.gyro_fifo_enable)
>  		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> -
>  	if (st->chip_type == INV_ICM20602)
>  		bytes_per_datum += INV_ICM20602_BYTES_PER_TEMP_SENSOR;
> +	if (st->chip_config.magn_fifo_enable)
> +		bytes_per_datum += INV_MPU9X50_BYTES_MAGN;
>  
>  	/*
>  	 * read fifo_count register to know how many bytes are inside the FIFO
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index dd55e70b6f77..fa4928e589b9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -5,7 +5,7 @@
>  
>  #include "inv_mpu_iio.h"
>  
> -static void inv_scan_query(struct iio_dev *indio_dev)
> +static void inv_scan_query_mpu6050(struct iio_dev *indio_dev)
>  {
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
>  
> @@ -26,6 +26,52 @@ static void inv_scan_query(struct iio_dev *indio_dev)
>  			 indio_dev->active_scan_mask);
>  }
>  
> +#ifdef CONFIG_INV_MPU6050_MAGN
> +static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +
> +	st->chip_config.gyro_fifo_enable =
> +		test_bit(INV_MPU9X50_SCAN_GYRO_X,
> +			 indio_dev->active_scan_mask) ||
> +		test_bit(INV_MPU9X50_SCAN_GYRO_Y,
> +			 indio_dev->active_scan_mask) ||
> +		test_bit(INV_MPU9X50_SCAN_GYRO_Z,
> +			 indio_dev->active_scan_mask);
> +
> +	st->chip_config.accl_fifo_enable =
> +		test_bit(INV_MPU9X50_SCAN_ACCL_X,
> +			 indio_dev->active_scan_mask) ||
> +		test_bit(INV_MPU9X50_SCAN_ACCL_Y,
> +			 indio_dev->active_scan_mask) ||
> +		test_bit(INV_MPU9X50_SCAN_ACCL_Z,
> +			 indio_dev->active_scan_mask);
> +
> +	st->chip_config.magn_fifo_enable =
> +		test_bit(INV_MPU9X50_SCAN_MAGN_X,
> +			 indio_dev->active_scan_mask) ||
> +		test_bit(INV_MPU9X50_SCAN_MAGN_Y,
> +			 indio_dev->active_scan_mask) ||
> +		test_bit(INV_MPU9X50_SCAN_MAGN_Z,
> +			 indio_dev->active_scan_mask);
> +}
> +#endif
> +
> +static void inv_scan_query(struct iio_dev *indio_dev)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +
> +	switch (st->chip_type) {
> +#ifdef CONFIG_INV_MPU6050_MAGN
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		return inv_scan_query_mpu9x50(indio_dev);
> +#endif
> +	default:
> +		return inv_scan_query_mpu6050(indio_dev);
> +	}
> +}
> +
>  /**
>   *  inv_mpu6050_set_enable() - enable chip functions.
>   *  @indio_dev:	Device driver instance.
> @@ -34,6 +80,11 @@ static void inv_scan_query(struct iio_dev *indio_dev)
>  static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	uint8_t d;
> +	unsigned int gyro_skip = 0;
> +	unsigned int accl_skip = 0;
> +	unsigned int magn_skip = 0;
> +	unsigned int skip_samples;
>  	int result;
>  
>  	if (enable) {
> @@ -41,14 +92,13 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  		if (result)
>  			return result;
>  		inv_scan_query(indio_dev);
> -		st->skip_samples = 0;
>  		if (st->chip_config.gyro_fifo_enable) {
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_BIT_PWR_GYRO_STBY);
>  			if (result)
>  				goto error_power_off;
>  			/* gyro first sample is out of specs, skip it */
> -			st->skip_samples = 1;
> +			gyro_skip = 1;
>  		}
>  		if (st->chip_config.accl_fifo_enable) {
>  			result = inv_mpu6050_switch_engine(st, true,
> @@ -56,22 +106,40 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  			if (result)
>  				goto error_gyro_off;
>  		}
> +		if (st->chip_config.magn_fifo_enable) {
> +			d = st->chip_config.user_ctrl |
> +					INV_MPU6050_BIT_I2C_MST_EN;
> +			result = regmap_write(st->map, st->reg->user_ctrl, d);
> +			if (result)
> +				goto error_accl_off;
> +			st->chip_config.user_ctrl = d;
> +			/* mag first sample is always not ready, skip it */
> +			magn_skip = 1;
> +		}
> +		/* compute first samples to skip */
> +		skip_samples = gyro_skip;
> +		if (accl_skip > skip_samples)
> +			skip_samples = accl_skip;
> +		if (magn_skip > skip_samples)
> +			skip_samples = magn_skip;
> +		st->skip_samples = skip_samples;
>  		result = inv_reset_fifo(indio_dev);
>  		if (result)
> -			goto error_accl_off;
> +			goto error_magn_off;
>  	} else {
>  		result = regmap_write(st->map, st->reg->fifo_en, 0);
>  		if (result)
> -			goto error_accl_off;
> +			goto error_magn_off;
>  
>  		result = regmap_write(st->map, st->reg->int_enable, 0);
>  		if (result)
> -			goto error_accl_off;
> +			goto error_magn_off;
>  
> -		result = regmap_write(st->map, st->reg->user_ctrl,
> -				      st->chip_config.user_ctrl);
> +		d = st->chip_config.user_ctrl & ~INV_MPU6050_BIT_I2C_MST_EN;
> +		result = regmap_write(st->map, st->reg->user_ctrl, d);
>  		if (result)
> -			goto error_accl_off;
> +			goto error_magn_off;
> +		st->chip_config.user_ctrl = d;
>  
>  		result = inv_mpu6050_switch_engine(st, false,
>  					INV_MPU6050_BIT_PWR_ACCL_STBY);
> @@ -90,6 +158,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  
>  	return 0;
>  
> +error_magn_off:
> +	/* always restore user_ctrl to disable fifo properly */
> +	st->chip_config.user_ctrl &= ~INV_MPU6050_BIT_I2C_MST_EN;
> +	regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
>  error_accl_off:
>  	if (st->chip_config.accl_fifo_enable)
>  		inv_mpu6050_switch_engine(st, false,

