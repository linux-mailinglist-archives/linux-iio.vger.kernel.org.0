Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B582264
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfHEQav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 12:30:51 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46598 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfHEQav (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 12:30:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id D26579E6A78;
        Mon,  5 Aug 2019 17:30:49 +0100 (BST)
Date:   Mon, 5 Aug 2019 17:30:46 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: be more explicit on supported
 chips
Message-ID: <20190805173046.49e1c80f@archlinux>
In-Reply-To: <20190805122630.8476-1-jmaneyrol@invensense.com>
References: <20190805122630.8476-1-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Aug 2019 12:26:50 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Since every chip has a different whoami, we are not supporting all
> existing variant of all chips. Add an explicit supported chips
> list in Kconfig description.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index 395f3bd7de0a..e4c4c12236a7 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -14,8 +14,9 @@ config INV_MPU6050_I2C
>  	select INV_MPU6050_IIO
>  	select REGMAP_I2C
>  	help
> -	  This driver supports the Invensense MPU6050/6500/9150 and
> -	  ICM20608/20602 motion tracking devices over I2C.
> +	  This driver supports the Invensense MPU6000/6050/6500/6515,
> +	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
> +	  over I2C.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-i2c.
>  
> @@ -25,7 +26,8 @@ config INV_MPU6050_SPI
>  	select INV_MPU6050_IIO
>  	select REGMAP_SPI
>  	help
> -	  This driver supports the Invensense MPU6050/6500/9150 and
> -	  ICM20608/20602 motion tracking devices over SPI.
> +	  This driver supports the Invensense MPU6000/6050/6500/6515,
> +	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
> +	  over SPI.
>  	  This driver can be built as a module. The module will be called
>  	  inv-mpu6050-spi.

