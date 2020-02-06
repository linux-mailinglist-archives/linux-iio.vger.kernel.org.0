Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68E1543C7
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 13:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgBFMJt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 07:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbgBFMJt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 07:09:49 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BEA920730;
        Thu,  6 Feb 2020 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580990988;
        bh=eld5jTjUC8IIDTJAkcieS9kmCcJ2v9+F8gUVRLXcSz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x+jjy1V0hoEsQraduNwF6CZgy2e8atItUsCzhzD8fOdM3KIi6SY6yjAkvr5gwZtDM
         oWC+m5F4qnGfKvXhZNS5aE5ThFU3ifLb4chxvX72iPF0OZ7ZDqzIiHJoQqoMuZHR1J
         lgjeTAjiozHLuWHL+amZqUysxpyHhKBUs//6YqIg=
Date:   Thu, 6 Feb 2020 12:09:44 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/6] iio: imu: inv_mpu6050: add support of IAM20680
Message-ID: <20200206120944.4eab297f@archlinux>
In-Reply-To: <20200206103105.23666-4-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
        <20200206103105.23666-4-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Feb 2020 11:31:02 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Automotive certified IMU, similar to ICM20608.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig        | 4 ++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 8 ++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 6 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  | 5 +++++
>  5 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index e933db3a5a89..e65474a64675 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -16,7 +16,7 @@ config INV_MPU6050_I2C
>  	select REGMAP_I2C
>  	help
>  	  This driver supports the Invensense MPU6050/9150,
> -	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
> +	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
>  	  motion tracking devices over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
> @@ -28,7 +28,7 @@ config INV_MPU6050_SPI
>  	select REGMAP_SPI
>  	help
>  	  This driver supports the Invensense MPU6000,
> -	  MPU6500/6515/9250/9255, ICM20608/20609/20689 and ICM20602
> +	  MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM20602 and IAM20680
>  	  motion tracking devices over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 5fd57a1bee90..e8e6beef3f04 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -200,6 +200,14 @@ static const struct inv_mpu6050_hw hw_info[] = {
>  		.fifo_size = 1008,
>  		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  	},
> +	{
> +		.whoami = INV_IAM20680_WHOAMI_VALUE,
> +		.name = "IAM20680",
> +		.reg = &reg_set_6500,
> +		.config = &chip_config_6050,
> +		.fifo_size = 512,
> +		.temp = {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> +	},
>  };
>  
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index dd054e21216a..cd0eeb5dc7f6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -64,6 +64,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
>  	case INV_ICM20609:
>  	case INV_ICM20689:
>  	case INV_ICM20602:
> +	case INV_IAM20680:
>  		/* no i2c auxiliary bus on the chip */
>  		return false;
>  	case INV_MPU9150:
> @@ -207,6 +208,7 @@ static const struct i2c_device_id inv_mpu_id[] = {
>  	{"icm20609", INV_ICM20609},
>  	{"icm20689", INV_ICM20689},
>  	{"icm20602", INV_ICM20602},
> +	{"iam20680", INV_IAM20680},
>  	{}
>  };
>  
> @@ -253,6 +255,10 @@ static const struct of_device_id inv_of_match[] = {
>  		.compatible = "invensense,icm20602",
>  		.data = (void *)INV_ICM20602
>  	},
> +	{
> +		.compatible = "invensense,iam20680",
> +		.data = (void *)INV_IAM20680
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, inv_of_match);
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 75b8903450eb..404c289f8c84 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -78,6 +78,7 @@ enum inv_devices {
>  	INV_ICM20609,
>  	INV_ICM20689,
>  	INV_ICM20602,
> +	INV_IAM20680,
>  	INV_NUM_PARTS
>  };
>  
> @@ -346,6 +347,7 @@ struct inv_mpu6050_state {
>  #define INV_ICM20609_WHOAMI_VALUE		0xA6
>  #define INV_ICM20689_WHOAMI_VALUE		0x98
>  #define INV_ICM20602_WHOAMI_VALUE		0x12
> +#define INV_IAM20680_WHOAMI_VALUE		0xA9
>  
>  /* scan element definition for generic MPU6xxx devices */
>  enum inv_mpu6050_scan {
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 3803c40e7b24..393cec555be6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -84,6 +84,7 @@ static const struct spi_device_id inv_mpu_id[] = {
>  	{"icm20609", INV_ICM20609},
>  	{"icm20689", INV_ICM20689},
>  	{"icm20602", INV_ICM20602},
> +	{"iam20680", INV_IAM20680},
>  	{}
>  };
>  
> @@ -126,6 +127,10 @@ static const struct of_device_id inv_of_match[] = {
>  		.compatible = "invensense,icm20602",
>  		.data = (void *)INV_ICM20602
>  	},
> +	{
> +		.compatible = "invensense,iam20680",
> +		.data = (void *)INV_IAM20680
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, inv_of_match);

