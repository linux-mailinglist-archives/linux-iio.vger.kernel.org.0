Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFB14F8C6
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2020 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgBAQRE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Feb 2020 11:17:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgBAQRE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Feb 2020 11:17:04 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB81F206E3;
        Sat,  1 Feb 2020 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580573823;
        bh=ghKdg5YnErPfJqMCR96sq44hzGMrpHJOnWQD+FPmWHc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=obaoKBFtwPSL6XLGMgdn0U0A0wm/ixxKlfLvc5Pc4D3CNF08jCpqNgN0R/jrDkn5G
         +6g8e7YzEN1iNwgEEDnx+QXMCxLSGuJ1qT7M+gxKaMA/dWe94WhMJnQSgLe6qwURwR
         nUOhu12m8FCbo5d8qshXVor71JewOLtZHJP1I4gs=
Date:   Sat, 1 Feb 2020 16:16:59 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/9] iio: imu: inv_mpu6050: cleanup spi support
Message-ID: <20200201161659.52f3fe49@archlinux>
In-Reply-To: <20200120093620.9681-3-jmaneyrol@invensense.com>
References: <20200120093620.9681-1-jmaneyrol@invensense.com>
        <20200120093620.9681-3-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jan 2020 10:36:13 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Add missing mpu6515 support and add of match table.
> Reorganize Kconfig to display chips grouped by generations.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

The handling of of / acpi / directly probed could do with cleaning up in
here.

> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig       |  8 +++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 35 +++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 4 deletions(-)
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
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index ec102d5a5c77..f7276f9d83fc 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -74,6 +74,7 @@ static int inv_mpu_probe(struct spi_device *spi)
>  static const struct spi_device_id inv_mpu_id[] = {
>  	{"mpu6000", INV_MPU6000},
>  	{"mpu6500", INV_MPU6500},
> +	{"mpu6515", INV_MPU6515},
>  	{"mpu9250", INV_MPU9250},
>  	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
> @@ -83,6 +84,39 @@ static const struct spi_device_id inv_mpu_id[] = {
>  
>  MODULE_DEVICE_TABLE(spi, inv_mpu_id);
>  
> +static const struct of_device_id inv_of_match[] = {
> +	{
> +		.compatible = "invensense,mpu6000",
> +		.data = (void *)INV_MPU6000

The current code won't actually get this field as it uses
spi_id->driver_data directly.

We should be looking I think to moved to more unified handling
rather than explicit acpi / dt legs.

device_get_match_data should simplify things and will mean
the data pointers here are actually used.

Will still need the special handling for the case where
the driver wasn't probed as a result of dt or ACPI.

Thanks,

Jonathan

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
> @@ -93,6 +127,7 @@ static struct spi_driver inv_mpu_driver = {
>  	.probe		=	inv_mpu_probe,
>  	.id_table	=	inv_mpu_id,
>  	.driver = {
> +		.of_match_table = inv_of_match,
>  		.acpi_match_table = ACPI_PTR(inv_acpi_match),
>  		.name	=	"inv-mpu6000-spi",
>  		.pm     =       &inv_mpu_pmops,

