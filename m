Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9715438B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 12:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgBFLxN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 06:53:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbgBFLxN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 06:53:13 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A9CD206CC;
        Thu,  6 Feb 2020 11:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580989992;
        bh=Y0zcuvej+wYwlwnvVjgoexVWAmLWuOF09qAEInsLiOM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WmTzrmJn31ZmMEk1IcPO097byx3AiAATBirmASws11DYkmRl/lTGGsH/CU38cWuz3
         VpYBmPj36QNgR8INKEacQ7ArfqjlsNIAajre/sf75QGTYi/GLBOg7xFNnac+OhVAeq
         L96bVIEiXpeNCRPARce9nqguiRV9dOK7x9PYBujY=
Date:   Thu, 6 Feb 2020 11:53:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 2/6] iio: imu: inv_mpu6050: add support of ICM20609 &
 ICM20689
Message-ID: <20200206115306.300fa06b@archlinux>
In-Reply-To: <20200206103105.23666-3-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
        <20200206103105.23666-3-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Feb 2020 11:31:01 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> They are similar to ICM20608 chip.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig        |  8 +++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 26 ++++++++++++++++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 12 ++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  5 +++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 10 +++++++++
>  5 files changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index 003134734646..e933db3a5a89 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -16,8 +16,8 @@ config INV_MPU6050_I2C
>  	select REGMAP_I2C
>  	help
>  	  This driver supports the Invensense MPU6050/9150,
> -	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
> -	  over I2C.
> +	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
> +	  motion tracking devices over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
>  
> @@ -28,7 +28,7 @@ config INV_MPU6050_SPI
>  	select REGMAP_SPI
>  	help
>  	  This driver supports the Invensense MPU6000,
> -	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
> -	  over SPI.
> +	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
> +	  motion tracking devices over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 5096fc49012d..5fd57a1bee90 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -176,6 +176,22 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.fifo_size = 512,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
> +	{
> +		.whoami = INV_ICM20609_WHOAMI_VALUE,
> +		.name = "ICM20609",
> +		.reg = &reg_set_6500,
> +		.config = &chip_config_6050,
> +		.fifo_size = 4 * 1024,
> +		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> +	},
> +	{
> +		.whoami = INV_ICM20689_WHOAMI_VALUE,
> +		.name = "ICM20689",
> +		.reg = &reg_set_6500,
> +		.config = &chip_config_6050,
> +		.fifo_size = 4 * 1024,
> +		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> +	},
>  	{
>  		.whoami = INV_ICM20602_WHOAMI_VALUE,
>  		.name = "ICM20602",
> @@ -286,20 +302,22 @@ static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
>  	if (result)
>  		return result;
>  
> +	/* set accel lpf */
>  	switch (st->chip_type) {
>  	case INV_MPU6050:
>  	case INV_MPU6000:
>  	case INV_MPU9150:
>  		/* old chips, nothing to do */
> -		result = 0;
> +		return 0;
> +	case INV_ICM20689:
> +		/* set FIFO size to maximum value */
> +		val |= INV_ICM20689_BITS_FIFO_SIZE_MAX;
>  		break;
>  	default:
> -		/* set accel lpf */
> -		result = regmap_write(st->map, st->reg->accel_lpf, val);
>  		break;
>  	}
>  
> -	return result;
> +	return regmap_write(st->map, st->reg->accel_lpf, val);
>  }
>  
>  /**
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 49e9aa777ba4..dd054e21216a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -61,6 +61,8 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
>  
>  	switch (st->chip_type) {
>  	case INV_ICM20608:
> +	case INV_ICM20609:
> +	case INV_ICM20689:
>  	case INV_ICM20602:
>  		/* no i2c auxiliary bus on the chip */
>  		return false;
> @@ -202,6 +204,8 @@ static const struct i2c_device_id inv_mpu_id[] = {
>  	{"mpu9250", INV_MPU9250},
>  	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
> +	{"icm20609", INV_ICM20609},
> +	{"icm20689", INV_ICM20689},
>  	{"icm20602", INV_ICM20602},
>  	{}
>  };
> @@ -237,6 +241,14 @@ static const struct of_device_id inv_of_match[] = {
>  		.compatible = "invensense,icm20608",
>  		.data = (void *)INV_ICM20608
>  	},
> +	{
> +		.compatible = "invensense,icm20609",
> +		.data = (void *)INV_ICM20609
> +	},
> +	{
> +		.compatible = "invensense,icm20689",
> +		.data = (void *)INV_ICM20689
> +	},
>  	{
>  		.compatible = "invensense,icm20602",
>  		.data = (void *)INV_ICM20602
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 6158fca7f70e..75b8903450eb 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -75,6 +75,8 @@ enum inv_devices {
>  	INV_MPU9250,
>  	INV_MPU9255,
>  	INV_ICM20608,
> +	INV_ICM20609,
> +	INV_ICM20689,
>  	INV_ICM20602,
>  	INV_NUM_PARTS
>  };
> @@ -276,6 +278,7 @@ struct inv_mpu6050_state {
>  
>  /* mpu6500 registers */
>  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
> +#define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
>  #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
>  
>  /* delay time in milliseconds */
> @@ -340,6 +343,8 @@ struct inv_mpu6050_state {
>  #define INV_MPU9255_WHOAMI_VALUE		0x73
>  #define INV_MPU6515_WHOAMI_VALUE		0x74
>  #define INV_ICM20608_WHOAMI_VALUE		0xAF
> +#define INV_ICM20609_WHOAMI_VALUE		0xA6
> +#define INV_ICM20689_WHOAMI_VALUE		0x98
>  #define INV_ICM20602_WHOAMI_VALUE		0x12
>  
>  /* scan element definition for generic MPU6xxx devices */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 834bfa8e8684..3803c40e7b24 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -81,6 +81,8 @@ static const struct spi_device_id inv_mpu_id[] = {
>  	{"mpu9250", INV_MPU9250},
>  	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
> +	{"icm20609", INV_ICM20609},
> +	{"icm20689", INV_ICM20689},
>  	{"icm20602", INV_ICM20602},
>  	{}
>  };
> @@ -112,6 +114,14 @@ static const struct of_device_id inv_of_match[] = {
>  		.compatible = "invensense,icm20608",
>  		.data = (void *)INV_ICM20608
>  	},
> +	{
> +		.compatible = "invensense,icm20609",
> +		.data = (void *)INV_ICM20609
> +	},
> +	{
> +		.compatible = "invensense,icm20689",
> +		.data = (void *)INV_ICM20689
> +	},
>  	{
>  		.compatible = "invensense,icm20602",
>  		.data = (void *)INV_ICM20602

