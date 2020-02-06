Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3CE1543D7
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 13:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgBFMPy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 07:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBFMPy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 07:15:54 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9C520730;
        Thu,  6 Feb 2020 12:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580991352;
        bh=iliu2efJXhqt9fy1kadTbbwC8E2UETMZLz8m164anB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OXcqcrQDTL/Qi8+jlIDbr2Bs5tcyDIc4dPhEJNUqznVXRxp1TO3bU7ambyTne+jPP
         4boQV3XDaNDZhPI0bS3TMR2gI8l+Q+zyrnheUo0N7Q5/JrFmBDIQAmjVjeWHJNDDkh
         aW2kjHvWBkE49pQKj9eVFZkn3ZkmE4RTIKwiXxfs=
Date:   Thu, 6 Feb 2020 12:15:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/6] iio: imu: inv_mpu6050: add support of ICM20690
Message-ID: <20200206121549.6e41892e@archlinux>
In-Reply-To: <20200206103105.23666-5-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
        <20200206103105.23666-5-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Feb 2020 11:31:03 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Same generation as ICM20602 but different registers.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.
Thanks.
> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig        |  8 ++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 36 +++++++++++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  5 +++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  3 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 +++
>  5 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index e65474a64675..7137ea6f25db 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -16,8 +16,8 @@ config INV_MPU6050_I2C
>  	select REGMAP_I2C
>  	help
>  	  This driver supports the Invensense MPU6050/9150,
> -	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
> -	  motion tracking devices over I2C.
> +	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690 and
> +	  IAM20680 motion tracking devices over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
>  
> @@ -28,7 +28,7 @@ config INV_MPU6050_SPI
>  	select REGMAP_SPI
>  	help
>  	  This driver supports the Invensense MPU6000,
> -	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
> -	  motion tracking devices over SPI.
> +	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602/ICM20690 and
> +	  IAM20680 motion tracking devices over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index e8e6beef3f04..9ecc667debbe 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -200,6 +200,14 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.fifo_size = 1008,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
> +	{
> +		.whoami = INV_ICM20690_WHOAMI_VALUE,
> +		.name = "ICM20690",
> +		.reg = &reg_set_icm20602,
> +		.config = &chip_config_6050,
> +		.fifo_size = 1024,
> +		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> +	},
>  	{
>  		.whoami = INV_IAM20680_WHOAMI_VALUE,
>  		.name = "IAM20680",
> @@ -295,6 +303,25 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  }
>  EXPORT_SYMBOL_GPL(inv_mpu6050_set_power_itg);
>  
> +static int inv_mpu6050_set_gyro_fsr(struct inv_mpu6050_state *st,
> +				    enum inv_mpu6050_fsr_e val)
> +{
> +	unsigned int gyro_shift;
> +	u8 data;
> +
> +	switch (st->chip_type) {
> +	case INV_ICM20690:
> +		gyro_shift = INV_ICM20690_GYRO_CONFIG_FSR_SHIFT;
> +		break;
> +	default:
> +		gyro_shift = INV_MPU6050_GYRO_CONFIG_FSR_SHIFT;
> +		break;
> +	}
> +
> +	data = val << gyro_shift;
> +	return regmap_write(st->map, st->reg->gyro_config, data);
> +}
> +
>  /**
>   *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
>   *
> @@ -318,6 +345,7 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
>  		/* old chips, nothing to do */
>  		return 0;
>  	case INV_ICM20689:
> +	case INV_ICM20690:
>  		/* set FIFO size to maximum value */
>  		val |= INV_ICM20689_BITS_FIFO_SIZE_MAX;
>  		break;
> @@ -346,8 +374,8 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> -	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
> -	result = regmap_write(st->map, st->reg->gyro_config, d);
> +
> +	result = inv_mpu6050_set_gyro_fsr(st, INV_MPU6050_FSR_2000DPS);
>  	if (result)
>  		goto error_power_off;
>  
> @@ -559,12 +587,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)
>  {
>  	int result, i;
> -	u8 d;
>  
>  	for (i = 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) {
>  		if (gyro_scale_6050[i] == val) {
> -			d = (i << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
> -			result = regmap_write(st->map, st->reg->gyro_config, d);
> +			result = inv_mpu6050_set_gyro_fsr(st, i);
>  			if (result)
>  				return result;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index cd0eeb5dc7f6..1363d3776523 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -208,6 +208,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
>  	{"icm20609", INV_ICM20609},
>  	{"icm20689", INV_ICM20689},
>  	{"icm20602", INV_ICM20602},
> +	{"icm20690", INV_ICM20690},
>  	{"iam20680", INV_IAM20680},
>  	{}
>  };
> @@ -255,6 +256,10 @@ static const struct of_device_id inv_of_match[] = {
>  		.compatible = "invensense,icm20602",
>  		.data = (void *)INV_ICM20602
>  	},
> +	{
> +		.compatible = "invensense,icm20690",
> +		.data = (void *)INV_ICM20690
> +	},
>  	{
>  		.compatible = "invensense,iam20680",
>  		.data = (void *)INV_IAM20680
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 404c289f8c84..7ae614052210 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -78,6 +78,7 @@ enum inv_devices {
>  	INV_ICM20609,
>  	INV_ICM20689,
>  	INV_ICM20602,
> +	INV_ICM20690,
>  	INV_IAM20680,
>  	INV_NUM_PARTS
>  };
> @@ -297,6 +298,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_MAX_ACCL_FS_PARAM        3
>  #define INV_MPU6050_THREE_AXIS               3
>  #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
> +#define INV_ICM20690_GYRO_CONFIG_FSR_SHIFT   2
>  #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
>  
>  #define INV_MPU6500_TEMP_OFFSET              7011
> @@ -347,6 +349,7 @@ struct inv_mpu6050_state {
>  #define INV_ICM20609_WHOAMI_VALUE		0xA6
>  #define INV_ICM20689_WHOAMI_VALUE		0x98
>  #define INV_ICM20602_WHOAMI_VALUE		0x12
> +#define INV_ICM20690_WHOAMI_VALUE		0x20
>  #define INV_IAM20680_WHOAMI_VALUE		0xA9
>  
>  /* scan element definition for generic MPU6xxx devices */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 393cec555be6..bc351dd58c53 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -84,6 +84,7 @@ static const struct spi_device_id inv_mpu_id[] = {
>  	{"icm20609", INV_ICM20609},
>  	{"icm20689", INV_ICM20689},
>  	{"icm20602", INV_ICM20602},
> +	{"icm20690", INV_ICM20690},
>  	{"iam20680", INV_IAM20680},
>  	{}
>  };
> @@ -127,6 +128,10 @@ static const struct of_device_id inv_of_match[] = {
>  		.compatible = "invensense,icm20602",
>  		.data = (void *)INV_ICM20602
>  	},
> +	{
> +		.compatible = "invensense,icm20690",
> +		.data = (void *)INV_ICM20690
> +	},
>  	{
>  		.compatible = "invensense,iam20680",
>  		.data = (void *)INV_IAM20680

