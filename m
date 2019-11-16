Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C4FF44E
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 18:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfKPRUS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 12:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbfKPRUS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 12:20:18 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA882168B;
        Sat, 16 Nov 2019 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573924816;
        bh=psHD/eafM9N0vB2S5gtVIeD2u3B78vlHuBJG0ZdLxtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bArX8jj6dAnElJ0B9IiBkuPxEyMY0zt8iEbUy9nr6Tbb9PnTbGq50xfpE3YuvzARQ
         zWlarplobTDJEu1eMdH8citIBViQEOvDBE1J2zjHMA6LtEVl5eBN4Pr1WSFzawIcVS
         JUkx1bG5LpReQvdHkt8EYc76NI6lF810HuSj/J54=
Date:   Sat, 16 Nov 2019 17:20:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add support of MPU9150
 magnetometer
Message-ID: <20191116172013.7d272d0b@archlinux>
In-Reply-To: <20191115140622.6429-3-jmaneyrol@invensense.com>
References: <20191115140622.6429-1-jmaneyrol@invensense.com>
        <20191115140622.6429-3-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Nov 2019 15:06:22 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add support for driving MPU9150 magnetometer (AK8975) from mpu.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
All the prerequisits are now (I think) in my togreg branch so
applied to that and pushed out as testing for the autobuilders
to do more build tests than I can be bothered with :)

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 57 ++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  2 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 80 +++++++++++++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  1 +
>  4 files changed, 104 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 45e77b308238..23c0557891a0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -914,6 +914,33 @@ static const unsigned long inv_mpu_scan_masks[] = {
>  		.ext_info = inv_ext_info,				\
>  	}
>  
> +static const struct iio_chan_spec inv_mpu9150_channels[] = {
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
> +	/* Magnetometer resolution is 13 bits */
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 13, INV_MPU9X50_SCAN_MAGN_X),
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Y, 13, INV_MPU9X50_SCAN_MAGN_Y),
> +	INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 13, INV_MPU9X50_SCAN_MAGN_Z),
> +};
> +
>  static const struct iio_chan_spec inv_mpu9250_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),
>  	/*
> @@ -1323,21 +1350,16 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		inv_mpu_bus_setup(indio_dev);
>  
>  	switch (chip_type) {
> +	case INV_MPU9150:
> +		indio_dev->channels = inv_mpu9150_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9150_channels);
> +		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
> +		break;
>  	case INV_MPU9250:
>  	case INV_MPU9255:
> -		/*
> -		 * Use magnetometer inside the chip only if there is no i2c
> -		 * auxiliary device in use.
> -		 */
> -		if (!st->magn_disabled) {
> -			indio_dev->channels = inv_mpu9250_channels;
> -			indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
> -			indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
> -		} else {
> -			indio_dev->channels = inv_mpu_channels;
> -			indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> -			indio_dev->available_scan_masks = inv_mpu_scan_masks;
> -		}
> +		indio_dev->channels = inv_mpu9250_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(inv_mpu9250_channels);
> +		indio_dev->available_scan_masks = inv_mpu9x50_scan_masks;
>  		break;
>  	case INV_ICM20602:
>  		indio_dev->channels = inv_icm20602_channels;
> @@ -1350,6 +1372,15 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		indio_dev->available_scan_masks = inv_mpu_scan_masks;
>  		break;
>  	}
> +	/*
> +	 * Use magnetometer inside the chip only if there is no i2c
> +	 * auxiliary device in use. Otherwise Going back to 6-axis only.
> +	 */
> +	if (st->magn_disabled) {
> +		indio_dev->channels = inv_mpu_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
> +		indio_dev->available_scan_masks = inv_mpu_scan_masks;
> +	}
>  
>  	indio_dev->info = &mpu_info;
>  	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 389cc8505e0e..f47a28b4be23 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -77,6 +77,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
>  	case INV_ICM20602:
>  		/* no i2c auxiliary bus on the chip */
>  		return false;
> +	case INV_MPU9150:
>  	case INV_MPU9250:
>  	case INV_MPU9255:
>  		if (st->magn_disabled)
> @@ -102,6 +103,7 @@ static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
>  	struct device_node *mux_node;
>  
>  	switch (st->chip_type) {
> +	case INV_MPU9150:
>  	case INV_MPU9250:
>  	case INV_MPU9255:
>  		mux_node = of_get_child_by_name(dev->of_node, "i2c-gate");
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> index 02735af152c8..4f192352521e 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> @@ -12,7 +12,9 @@
>  #include "inv_mpu_magn.h"
>  
>  /*
> - * MPU9250 magnetometer is an AKM AK8963 chip on I2C aux bus
> + * MPU9xxx magnetometer are AKM chips on I2C aux bus
> + * MPU9150 is AK8975
> + * MPU9250 is AK8963
>   */
>  #define INV_MPU_MAGN_I2C_ADDR		0x0C
>  
> @@ -33,10 +35,10 @@
>  #define INV_MPU_MAGN_BITS_MODE_PWDN	0x00
>  #define INV_MPU_MAGN_BITS_MODE_SINGLE	0x01
>  #define INV_MPU_MAGN_BITS_MODE_FUSE	0x0F
> -#define INV_MPU_MAGN_BIT_OUTPUT_BIT	0x10
> +#define INV_MPU9250_MAGN_BIT_OUTPUT_BIT	0x10
>  
> -#define INV_MPU_MAGN_REG_CNTL2		0x0B
> -#define INV_MPU_MAGN_BIT_SRST		0x01
> +#define INV_MPU9250_MAGN_REG_CNTL2	0x0B
> +#define INV_MPU9250_MAGN_BIT_SRST	0x01
>  
>  #define INV_MPU_MAGN_REG_ASAX		0x10
>  #define INV_MPU_MAGN_REG_ASAY		0x11
> @@ -48,6 +50,7 @@
>  static bool inv_magn_supported(const struct inv_mpu6050_state *st)
>  {
>  	switch (st->chip_type) {
> +	case INV_MPU9150:
>  	case INV_MPU9250:
>  	case INV_MPU9255:
>  		return true;
> @@ -61,6 +64,7 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
>  {
>  	uint8_t val;
>  	uint8_t asa[3];
> +	int32_t sensitivity;
>  	int ret;
>  
>  	/* check whoami */
> @@ -71,12 +75,19 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
>  	if (val != INV_MPU_MAGN_BITS_WIA)
>  		return -ENODEV;
>  
> -	/* reset chip */
> -	ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
> -				INV_MPU_MAGN_REG_CNTL2,
> -				INV_MPU_MAGN_BIT_SRST);
> -	if (ret)
> -		return ret;
> +	/* software reset for MPU925x only */
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
> +					INV_MPU9250_MAGN_REG_CNTL2,
> +					INV_MPU9250_MAGN_BIT_SRST);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		break;
> +	}
>  
>  	/* read fuse ROM data */
>  	ret = inv_mpu_aux_write(st, INV_MPU_MAGN_I2C_ADDR,
> @@ -97,6 +108,25 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Sensor sentivity
> +	 * 1 uT = 0.01 G and value is in micron (1e6)
> +	 * sensitvity = x uT * 0.01 * 1e6
> +	 */
> +	switch (st->chip_type) {
> +	case INV_MPU9150:
> +		/* sensor sensitivity is 0.3 uT */
> +		sensitivity = 3000;
> +		break;
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		/* sensor sensitivity in 16 bits mode: 0.15 uT */
> +		sensitivity = 1500;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * Sensitivity adjustement and scale to Gauss
>  	 *
> @@ -104,16 +134,11 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
>  	 * Factor simplification:
>  	 * Hadj = H * ((ASA + 128) / 256)
>  	 *
> -	 * Sensor sentivity
> -	 * 0.15 uT in 16 bits mode
> -	 * 1 uT = 0.01 G and value is in micron (1e6)
> -	 * sensitvity = 0.15 uT * 0.01 * 1e6
> -	 *
> -	 * raw_to_gauss = Hadj * 1500
> +	 * raw_to_gauss = Hadj * sensitivity
>  	 */
> -	st->magn_raw_to_gauss[0] = (((int32_t)asa[0] + 128) * 1500) / 256;
> -	st->magn_raw_to_gauss[1] = (((int32_t)asa[1] + 128) * 1500) / 256;
> -	st->magn_raw_to_gauss[2] = (((int32_t)asa[2] + 128) * 1500) / 256;
> +	st->magn_raw_to_gauss[0] = (((int32_t)asa[0] + 128) * sensitivity) / 256;
> +	st->magn_raw_to_gauss[1] = (((int32_t)asa[1] + 128) * sensitivity) / 256;
> +	st->magn_raw_to_gauss[2] = (((int32_t)asa[2] + 128) * sensitivity) / 256;
>  
>  	return 0;
>  }
> @@ -129,6 +154,7 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
>   */
>  int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
>  {
> +	uint8_t val;
>  	int ret;
>  
>  	/* quit if chip is not supported */
> @@ -179,10 +205,17 @@ int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
>  	if (ret)
>  		return ret;
>  
> -	/* add 16 bits mode */
> -	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1),
> -			   INV_MPU_MAGN_BITS_MODE_SINGLE |
> -			   INV_MPU_MAGN_BIT_OUTPUT_BIT);
> +	/* add 16 bits mode for MPU925x */
> +	val = INV_MPU_MAGN_BITS_MODE_SINGLE;
> +	switch (st->chip_type) {
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		val |= INV_MPU9250_MAGN_BIT_OUTPUT_BIT;
> +		break;
> +	default:
> +		break;
> +	}
> +	ret = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_DO(1), val);
>  	if (ret)
>  		return ret;
>  
> @@ -237,6 +270,7 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
>  
>  	/* fill magnetometer orientation */
>  	switch (st->chip_type) {
> +	case INV_MPU9150:
>  	case INV_MPU9250:
>  	case INV_MPU9255:
>  		/* x <- y */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index d7d951927a44..a9c75bc62f18 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -50,6 +50,7 @@ static void inv_scan_query(struct iio_dev *indio_dev)
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
>  	switch (st->chip_type) {
> +	case INV_MPU9150:
>  	case INV_MPU9250:
>  	case INV_MPU9255:
>  		return inv_scan_query_mpu9x50(indio_dev);

