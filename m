Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B86FFF44A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Nov 2019 18:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfKPRQJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Nov 2019 12:16:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfKPRQJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Nov 2019 12:16:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00912168B;
        Sat, 16 Nov 2019 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573924568;
        bh=VuWxOOFSXJsakrDZZAYE4qSXK4YN7TaiKQMCleB6Y74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kLvXpvnC/3WmUPjWbz4t0apsRFgLRl9EG8BqTVzY78NSVlujzV3aTdPAcox7SEBNX
         1mjfe9kuw2i5Dlc2bzcyxAZqWeL+Pdbm9Vl9e2STdJGKkBAIF35sYSUTMA7PwtvT4g
         T/JonnDcTt+jYDT4TpyZnqTAqrhzgDNWcV+91QNM=
Date:   Sat, 16 Nov 2019 17:16:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: inv_mpu6050: delete not existing MPU9150
 spi support
Message-ID: <20191116171604.17299f99@archlinux>
In-Reply-To: <20191115140622.6429-2-jmaneyrol@invensense.com>
References: <20191115140622.6429-1-jmaneyrol@invensense.com>
        <20191115140622.6429-2-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Nov 2019 15:06:21 +0100
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> MPU9150 is i2c only.
> Update Kconfig to delete in description chips that are i2c or
> spi only.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Good to clean this up.

Applied to the togreg branch of iio.git and pushed out as testing
to be ignored (hopefully)

> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig       | 6 +++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index e4c4c12236a7..963a0cafe0cb 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -14,7 +14,7 @@ config INV_MPU6050_I2C
>  	select INV_MPU6050_IIO
>  	select REGMAP_I2C
>  	help
> -	  This driver supports the Invensense MPU6000/6050/6500/6515,
> +	  This driver supports the Invensense MPU6050/6500/6515,
>  	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
>  	  over I2C.
>  	  This driver can be built as a module. The module will be called
> @@ -26,8 +26,8 @@ config INV_MPU6050_SPI
>  	select INV_MPU6050_IIO
>  	select REGMAP_SPI
>  	help
> -	  This driver supports the Invensense MPU6000/6050/6500/6515,
> -	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
> +	  This driver supports the Invensense MPU6000/6500/6515,
> +	  MPU9250/9255 and ICM20608/20602 motion tracking devices
>  	  over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 142692fc0758..ec102d5a5c77 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -74,7 +74,6 @@ static int inv_mpu_probe(struct spi_device *spi)
>  static const struct spi_device_id inv_mpu_id[] = {
>  	{"mpu6000", INV_MPU6000},
>  	{"mpu6500", INV_MPU6500},
> -	{"mpu9150", INV_MPU9150},
>  	{"mpu9250", INV_MPU9250},
>  	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},

