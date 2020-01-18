Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E55614174D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 12:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgARLoZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 06:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgARLoZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 06:44:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB5E24694;
        Sat, 18 Jan 2020 11:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579347864;
        bh=nN/J4PWKrhD76a8FgazpQA7pmakPEExEgkvEydfp45g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OYnlhhwe2HCRlvRpMl1MNxZTAv3MqE6jkUtIq6CZFNE7SDwTiZCUk0JiB2UaHN4zJ
         oZzwUYF7jEt4/P/I5EO3oXinl1by5mIbYk1wVZ3vaaXkz2zgli/+IZFnDjSCP+8Za7
         TwC/lYfy4/wZWx2t1jHwz2pNLs4tipsKeY0re4HQ=
Date:   Sat, 18 Jan 2020 11:44:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: add fifo temperature data
 support
Message-ID: <20200118114421.0fea6ef4@archlinux>
In-Reply-To: <20200116175645.1543-1-jmaneyrol@invensense.com>
References: <20200116175645.1543-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jan 2020 18:56:45 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add support of temperature data in fifo for all chips.
> Enable unification of scan elements for icm20602.
> Add macros for generating scan elements.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Dropped v1 and applied this.

If this happens, please reply to v1 to say there is an issue.
Saves me time,

Jonathan

> ---
> Changelog:
> - v2: delete temp duplication macro, not compliant with checkpatch
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 200 +++++++-----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  22 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |   3 +
>  4 files changed, 90 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 268240644adf..1eb3c263b528 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -104,6 +104,7 @@ static const struct inv_mpu6050_chip_config chip_config_6050 = {
>  	.divider = INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_MPU6050_INIT_FIFO_RATE),
>  	.gyro_fifo_enable = false,
>  	.accl_fifo_enable = false,
> +	.temp_fifo_enable = false,
>  	.magn_fifo_enable = false,
>  	.accl_fs = INV_MPU6050_FS_02G,
>  	.user_ctrl = 0,
> @@ -856,19 +857,27 @@ static const struct iio_chan_spec_ext_info inv_ext_info[] = {
>  		.ext_info = inv_ext_info,                             \
>  	}
>  
> +#define INV_MPU6050_TEMP_CHAN(_index)				\
> +	{							\
> +		.type = IIO_TEMP,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
> +				| BIT(IIO_CHAN_INFO_OFFSET)	\
> +				| BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = _index,				\
> +		.scan_type = {					\
> +			.sign = 's',				\
> +			.realbits = 16,				\
> +			.storagebits = 16,			\
> +			.shift = 0,				\
> +			.endianness = IIO_BE,			\
> +		},						\
> +	}
> +
>  static const struct iio_chan_spec inv_mpu_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
> -	/*
> -	 * Note that temperature should only be via polled reading only,
> -	 * not the final scan elements output.
> -	 */
> -	{
> -		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> -				| BIT(IIO_CHAN_INFO_OFFSET)
> -				| BIT(IIO_CHAN_INFO_SCALE),
> -		.scan_index = -1,
> -	},
> +
> +	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
> +
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
> @@ -878,22 +887,29 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
>  	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
>  };
>  
> +#define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL	\
> +	(BIT(INV_MPU6050_SCAN_ACCL_X)		\
> +	| BIT(INV_MPU6050_SCAN_ACCL_Y)		\
> +	| BIT(INV_MPU6050_SCAN_ACCL_Z))
> +
> +#define INV_MPU6050_SCAN_MASK_3AXIS_GYRO	\
> +	(BIT(INV_MPU6050_SCAN_GYRO_X)		\
> +	| BIT(INV_MPU6050_SCAN_GYRO_Y)		\
> +	| BIT(INV_MPU6050_SCAN_GYRO_Z))
> +
> +#define INV_MPU6050_SCAN_MASK_TEMP		(BIT(INV_MPU6050_SCAN_TEMP))
> +
>  static const unsigned long inv_mpu_scan_masks[] = {
>  	/* 3-axis accel */
> -	BIT(INV_MPU6050_SCAN_ACCL_X)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 3-axis gyro */
> -	BIT(INV_MPU6050_SCAN_GYRO_X)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 6-axis accel + gyro */
> -	BIT(INV_MPU6050_SCAN_ACCL_X)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Z)
> -		| BIT(INV_MPU6050_SCAN_GYRO_X)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
> +		| INV_MPU6050_SCAN_MASK_TEMP,
>  	0,
>  };
>  
> @@ -917,17 +933,9 @@ static const unsigned long inv_mpu_scan_masks[] = {
>  
>  static const struct iio_chan_spec inv_mpu9150_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
> -	/*
> -	 * Note that temperature should only be via polled reading only,
> -	 * not the final scan elements output.
> -	 */
> -	{
> -		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> -				| BIT(IIO_CHAN_INFO_OFFSET)
> -				| BIT(IIO_CHAN_INFO_SCALE),
> -		.scan_index = -1,
> -	},
> +
> +	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
> +
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
> @@ -944,17 +952,9 @@ static const struct iio_chan_spec inv_mpu9150_channels[] = {
>  
>  static const struct iio_chan_spec inv_mpu9250_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
> -	/*
> -	 * Note that temperature should only be via polled reading only,
> -	 * not the final scan elements output.
> -	 */
> -	{
> -		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> -				| BIT(IIO_CHAN_INFO_OFFSET)
> -				| BIT(IIO_CHAN_INFO_SCALE),
> -		.scan_index = -1,
> -	},
> +
> +	INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),
> +
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
>  	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
> @@ -969,98 +969,50 @@ static const struct iio_chan_spec inv_mpu9250_channels[] = {
>  	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCAN_MAGN_Z),
>  };
>  
> +#define INV_MPU9X50_SCAN_MASK_3AXIS_MAGN	\
> +	(BIT(INV_MPU9X50_SCAN_MAGN_X)		\
> +	| BIT(INV_MPU9X50_SCAN_MAGN_Y)		\
> +	| BIT(INV_MPU9X50_SCAN_MAGN_Z))
> +
>  static const unsigned long inv_mpu9x50_scan_masks[] = {
>  	/* 3-axis accel */
> -	BIT(INV_MPU6050_SCAN_ACCL_X)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 3-axis gyro */
> -	BIT(INV_MPU6050_SCAN_GYRO_X)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 3-axis magn */
> -	BIT(INV_MPU9X50_SCAN_MAGN_X)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
> +	INV_MPU9X50_SCAN_MASK_3AXIS_MAGN | INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 6-axis accel + gyro */
> -	BIT(INV_MPU6050_SCAN_ACCL_X)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Z)
> -		| BIT(INV_MPU6050_SCAN_GYRO_X)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
> +		| INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 6-axis accel + magn */
> -	BIT(INV_MPU6050_SCAN_ACCL_X)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Z)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN
> +		| INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 6-axis gyro + magn */
> -	BIT(INV_MPU6050_SCAN_GYRO_X)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Z)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU9X50_SCAN_MASK_3AXIS_MAGN
> +		| INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 9-axis accel + gyro + magn */
> -	BIT(INV_MPU6050_SCAN_ACCL_X)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Y)
> -		| BIT(INV_MPU6050_SCAN_ACCL_Z)
> -		| BIT(INV_MPU6050_SCAN_GYRO_X)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Y)
> -		| BIT(INV_MPU6050_SCAN_GYRO_Z)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_X)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Y)
> -		| BIT(INV_MPU9X50_SCAN_MAGN_Z),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
> +		| INV_MPU9X50_SCAN_MASK_3AXIS_MAGN,
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
> +		| INV_MPU9X50_SCAN_MASK_3AXIS_MAGN
> +		| INV_MPU6050_SCAN_MASK_TEMP,
>  	0,
>  };
>  
> -static const struct iio_chan_spec inv_icm20602_channels[] = {
> -	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
> -	{
> -		.type = IIO_TEMP,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
> -				| BIT(IIO_CHAN_INFO_OFFSET)
> -				| BIT(IIO_CHAN_INFO_SCALE),
> -		.scan_index = INV_ICM20602_SCAN_TEMP,
> -		.scan_type = {
> -				.sign = 's',
> -				.realbits = 16,
> -				.storagebits = 16,
> -				.shift = 0,
> -				.endianness = IIO_BE,
> -			     },
> -	},
> -
> -	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_ICM20602_SCAN_GYRO_X),
> -	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_ICM20602_SCAN_GYRO_Y),
> -	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_ICM20602_SCAN_GYRO_Z),
> -
> -	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_ICM20602_SCAN_ACCL_Y),
> -	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_ICM20602_SCAN_ACCL_X),
> -	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_ACCL_Z),
> -};
> -
>  static const unsigned long inv_icm20602_scan_masks[] = {
>  	/* 3-axis accel + temp (mandatory) */
> -	BIT(INV_ICM20602_SCAN_ACCL_X)
> -		| BIT(INV_ICM20602_SCAN_ACCL_Y)
> -		| BIT(INV_ICM20602_SCAN_ACCL_Z)
> -		| BIT(INV_ICM20602_SCAN_TEMP),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 3-axis gyro + temp (mandatory) */
> -	BIT(INV_ICM20602_SCAN_GYRO_X)
> -		| BIT(INV_ICM20602_SCAN_GYRO_Y)
> -		| BIT(INV_ICM20602_SCAN_GYRO_Z)
> -		| BIT(INV_ICM20602_SCAN_TEMP),
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_TEMP,
>  	/* 6-axis accel + gyro + temp (mandatory) */
> -	BIT(INV_ICM20602_SCAN_ACCL_X)
> -		| BIT(INV_ICM20602_SCAN_ACCL_Y)
> -		| BIT(INV_ICM20602_SCAN_ACCL_Z)
> -		| BIT(INV_ICM20602_SCAN_GYRO_X)
> -		| BIT(INV_ICM20602_SCAN_GYRO_Y)
> -		| BIT(INV_ICM20602_SCAN_GYRO_Z)
> -		| BIT(INV_ICM20602_SCAN_TEMP),
> +	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK_3AXIS_GYRO
> +		| INV_MPU6050_SCAN_MASK_TEMP,
>  	0,
>  };
>  
> @@ -1363,8 +1315,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
>  		break;
>  	case INV_ICM20602:
> -		indio_dev->channels = inv_icm20602_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(inv_icm20602_channels);
> +		indio_dev->channels = inv_mpu_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
>  		indio_dev->available_scan_masks = inv_icm20602_scan_masks;
>  		break;
>  	default:
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index b096e010d4ee..6158fca7f70e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -86,6 +86,7 @@ enum inv_devices {
>   *  @accl_fs:		accel full scale range.
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
> + *  @temp_fifo_enable:	enable temp data output
>   *  @magn_fifo_enable:	enable magn data output
>   *  @divider:		chip sample rate divider (sample rate divider - 1)
>   */
> @@ -95,6 +96,7 @@ struct inv_mpu6050_chip_config {
>  	unsigned int accl_fs:2;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
> +	unsigned int temp_fifo_enable:1;
>  	unsigned int magn_fifo_enable:1;
>  	u8 divider;
>  	u8 user_ctrl;
> @@ -184,6 +186,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BIT_SLAVE_2             0x04
>  #define INV_MPU6050_BIT_ACCEL_OUT           0x08
>  #define INV_MPU6050_BITS_GYRO_OUT           0x70
> +#define INV_MPU6050_BIT_TEMP_OUT            0x80
>  
>  #define INV_MPU6050_REG_I2C_MST_CTRL        0x24
>  #define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D
> @@ -268,8 +271,8 @@ struct inv_mpu6050_state {
>  /* MPU9X50 9-axis magnetometer */
>  #define INV_MPU9X50_BYTES_MAGN               7
>  
> -/* ICM20602 FIFO samples include temperature readings */
> -#define INV_ICM20602_BYTES_PER_TEMP_SENSOR   2
> +/* FIFO temperature sample size */
> +#define INV_MPU6050_BYTES_PER_TEMP_SENSOR   2
>  
>  /* mpu6500 registers */
>  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
> @@ -298,7 +301,7 @@ struct inv_mpu6050_state {
>  #define INV_ICM20608_TEMP_OFFSET	     8170
>  #define INV_ICM20608_TEMP_SCALE		     3059976
>  
> -/* 6 + 6 + 7 (for MPU9x50) = 19 round up to 24 and plus 8 */
> +/* 6 + 6 + 2 + 7 (for MPU9x50) = 21 round up to 24 and plus 8 */
>  #define INV_MPU6050_OUTPUT_DATA_SIZE         32
>  
>  #define INV_MPU6050_REG_INT_PIN_CFG	0x37
> @@ -344,6 +347,7 @@ enum inv_mpu6050_scan {
>  	INV_MPU6050_SCAN_ACCL_X,
>  	INV_MPU6050_SCAN_ACCL_Y,
>  	INV_MPU6050_SCAN_ACCL_Z,
> +	INV_MPU6050_SCAN_TEMP,
>  	INV_MPU6050_SCAN_GYRO_X,
>  	INV_MPU6050_SCAN_GYRO_Y,
>  	INV_MPU6050_SCAN_GYRO_Z,
> @@ -355,18 +359,6 @@ enum inv_mpu6050_scan {
>  	INV_MPU9X50_SCAN_TIMESTAMP,
>  };
>  
> -/* scan element definition for ICM20602, which includes temperature */
> -enum inv_icm20602_scan {
> -	INV_ICM20602_SCAN_ACCL_X,
> -	INV_ICM20602_SCAN_ACCL_Y,
> -	INV_ICM20602_SCAN_ACCL_Z,
> -	INV_ICM20602_SCAN_TEMP,
> -	INV_ICM20602_SCAN_GYRO_X,
> -	INV_ICM20602_SCAN_GYRO_Y,
> -	INV_ICM20602_SCAN_GYRO_Z,
> -	INV_ICM20602_SCAN_TIMESTAMP,
> -};
> -
>  enum inv_mpu6050_filter_e {
>  	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
>  	INV_MPU6050_FILTER_188HZ,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 10d16ec5104b..3755577dc449 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -142,6 +142,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
>  		d |= INV_MPU6050_BITS_GYRO_OUT;
>  	if (st->chip_config.accl_fifo_enable)
>  		d |= INV_MPU6050_BIT_ACCEL_OUT;
> +	if (st->chip_config.temp_fifo_enable)
> +		d |= INV_MPU6050_BIT_TEMP_OUT;
>  	if (st->chip_config.magn_fifo_enable)
>  		d |= INV_MPU6050_BIT_SLAVE_0;
>  	result = regmap_write(st->map, st->reg->fifo_en, d);
> @@ -200,8 +202,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	if (st->chip_config.gyro_fifo_enable)
>  		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
>  
> -	if (st->chip_type == INV_ICM20602)
> -		bytes_per_datum += INV_ICM20602_BYTES_PER_TEMP_SENSOR;
> +	if (st->chip_config.temp_fifo_enable)
> +		bytes_per_datum += INV_MPU6050_BYTES_PER_TEMP_SENSOR;
>  
>  	if (st->chip_config.magn_fifo_enable)
>  		bytes_per_datum += INV_MPU9X50_BYTES_MAGN;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index a9c75bc62f18..5199fe790c30 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -24,6 +24,9 @@ static void inv_scan_query_mpu6050(struct iio_dev *indio_dev)
>  			 indio_dev->active_scan_mask) ||
>  		test_bit(INV_MPU6050_SCAN_ACCL_Z,
>  			 indio_dev->active_scan_mask);
> +
> +	st->chip_config.temp_fifo_enable =
> +		test_bit(INV_MPU6050_SCAN_TEMP, indio_dev->active_scan_mask);
>  }
>  
>  static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)

