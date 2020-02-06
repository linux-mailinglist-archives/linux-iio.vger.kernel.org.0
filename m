Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B017A154383
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 12:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgBFLwA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 06:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbgBFLwA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 06:52:00 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E2A206CC;
        Thu,  6 Feb 2020 11:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580989919;
        bh=FfucpD21SYPRRyYr/CL+PNRZSDEZk6xLwRJ2CsCmcXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QpA+wzlrmU7DqGnT3zr6Q0Mqbqe0XvYoLsyVybj066nVxy9Q1w9CJ2NJhRG64is73
         HodyqIPzp2aqksm5vUtY2qMGWnb0gkqJHP/0x1gSfw+cZ4RVpHgr3xUHsZ+7fjdEed
         IEJ3wURy1nmHg4v+mj+ynaKxr01h4usNCSWaRNRY=
Date:   Thu, 6 Feb 2020 11:51:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/6] iio: imu: inv_mpu6050: cleanup of/acpi support
Message-ID: <20200206115155.42dca690@archlinux>
In-Reply-To: <20200206103105.23666-2-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
        <20200206103105.23666-2-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 Feb 2020 11:31:00 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Use device_get_match_data for using of and acpi tables.
> In spi support add missing mpu6515 and of match table.
> Reorganize Kconfig to display chips grouped by generations.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Great.

Applied to the togreg branch of iio.git.  Clearly I took this
one very quickly after posting, but note it's not in a non rebasing
tree so I can still change that if anyone else has comments!

Thanks

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig       |  8 ++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 26 +++-----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 44 +++++++++++++++++++++--
>  3 files changed, 50 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index 017bc0fcc365..003134734646 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -15,8 +15,8 @@ config INV_MPU6050_I2C
>  	select INV_MPU6050_IIO
>  	select REGMAP_I2C
>  	help
> -	  This driver supports the Invensense MPU6050/6500/6515,
> -	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
> +	  This driver supports the Invensense MPU6050/9150,
> +	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
>  	  over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
> @@ -27,8 +27,8 @@ config INV_MPU6050_SPI
>  	select INV_MPU6050_IIO
>  	select REGMAP_SPI
>  	help
> -	  This driver supports the Invensense MPU6000/6500/6515,
> -	  MPU9250/9255 and ICM20608/20602 motion tracking devices
> +	  This driver supports the Invensense MPU6000,
> +	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
>  	  over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index f47a28b4be23..49e9aa777ba4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -10,6 +10,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/property.h>
>  #include "inv_mpu_iio.h"
>  
>  static const struct regmap_config inv_mpu_regmap_config = {
> @@ -54,20 +55,6 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	return 0;
>  }
>  
> -static const char *inv_mpu_match_acpi_device(struct device *dev,
> -					     enum inv_devices *chip_id)
> -{
> -	const struct acpi_device_id *id;
> -
> -	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> -	if (!id)
> -		return NULL;
> -
> -	*chip_id = (int)id->driver_data;
> -
> -	return dev_name(dev);
> -}
> -
>  static bool inv_mpu_i2c_aux_bus(struct device *dev)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
> @@ -130,6 +117,7 @@ static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
>  static int inv_mpu_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> +	const void *match;
>  	struct inv_mpu6050_state *st;
>  	int result;
>  	enum inv_devices chip_type;
> @@ -140,18 +128,14 @@ static int inv_mpu_probe(struct i2c_client *client,
>  				     I2C_FUNC_SMBUS_I2C_BLOCK))
>  		return -EOPNOTSUPP;
>  
> -	if (client->dev.of_node) {
> -		chip_type = (enum inv_devices)
> -			of_device_get_match_data(&client->dev);
> +	match = device_get_match_data(&client->dev);
> +	if (match) {
> +		chip_type = (enum inv_devices)match;
>  		name = client->name;
>  	} else if (id) {
>  		chip_type = (enum inv_devices)
>  			id->driver_data;
>  		name = id->name;
> -	} else if (ACPI_HANDLE(&client->dev)) {
> -		name = inv_mpu_match_acpi_device(&client->dev, &chip_type);
> -		if (!name)
> -			return -ENODEV;
>  	} else {
>  		return -ENOSYS;
>  	}
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index ec102d5a5c77..834bfa8e8684 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -4,6 +4,8 @@
>  */
>  #include <linux/module.h>
>  #include <linux/acpi.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/spi/spi.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
> @@ -41,17 +43,18 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
>  
>  static int inv_mpu_probe(struct spi_device *spi)
>  {
> +	const void *match;
>  	struct regmap *regmap;
>  	const struct spi_device_id *spi_id;
> -	const struct acpi_device_id *acpi_id;
>  	const char *name = NULL;
>  	enum inv_devices chip_type;
>  
>  	if ((spi_id = spi_get_device_id(spi))) {
>  		chip_type = (enum inv_devices)spi_id->driver_data;
>  		name = spi_id->name;
> -	} else if ((acpi_id = acpi_match_device(spi->dev.driver->acpi_match_table, &spi->dev))) {
> -		chip_type = (enum inv_devices)acpi_id->driver_data;
> +	} else if ((match = device_get_match_data(&spi->dev))) {
> +		chip_type = (enum inv_devices)match;
> +		name = dev_name(&spi->dev);
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -74,6 +77,7 @@ static int inv_mpu_probe(struct spi_device *spi)
>  static const struct spi_device_id inv_mpu_id[] = {
>  	{"mpu6000", INV_MPU6000},
>  	{"mpu6500", INV_MPU6500},
> +	{"mpu6515", INV_MPU6515},
>  	{"mpu9250", INV_MPU9250},
>  	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
> @@ -83,6 +87,39 @@ static const struct spi_device_id inv_mpu_id[] = {
>  
>  MODULE_DEVICE_TABLE(spi, inv_mpu_id);
>  
> +static const struct of_device_id inv_of_match[] = {
> +	{
> +		.compatible = "invensense,mpu6000",
> +		.data = (void *)INV_MPU6000
> +	},
> +	{
> +		.compatible = "invensense,mpu6500",
> +		.data = (void *)INV_MPU6500
> +	},
> +	{
> +		.compatible = "invensense,mpu6515",
> +		.data = (void *)INV_MPU6515
> +	},
> +	{
> +		.compatible = "invensense,mpu9250",
> +		.data = (void *)INV_MPU9250
> +	},
> +	{
> +		.compatible = "invensense,mpu9255",
> +		.data = (void *)INV_MPU9255
> +	},
> +	{
> +		.compatible = "invensense,icm20608",
> +		.data = (void *)INV_ICM20608
> +	},
> +	{
> +		.compatible = "invensense,icm20602",
> +		.data = (void *)INV_ICM20602
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_of_match);
> +
>  static const struct acpi_device_id inv_acpi_match[] = {
>  	{"INVN6000", INV_MPU6000},
>  	{ },
> @@ -93,6 +130,7 @@ static struct spi_driver inv_mpu_driver = {
>  	.probe		=	inv_mpu_probe,
>  	.id_table	=	inv_mpu_id,
>  	.driver = {
> +		.of_match_table = inv_of_match,
>  		.acpi_match_table = ACPI_PTR(inv_acpi_match),
>  		.name	=	"inv-mpu6000-spi",
>  		.pm     =       &inv_mpu_pmops,

