Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8BE68037
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfGNQ20 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfGNQ20 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:28:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D82214AE;
        Sun, 14 Jul 2019 16:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563121704;
        bh=JGJxJ7qPXorbqif1S9ppyYqsk4qdKSaNz9pvrjWvvRo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EoYM4ob64WwyP8yo87vwTCg5x0g1BUXUxKmW90Q2uQVDhON54alLQ+csnXyn2haJu
         OOSqmkU5zSCZWp7wtHxaEeb8ME9uL9h7bfpHLIRoRPG/PirjP0BKB7cdo0omSpXbmi
         LEDi6V7gHt7LwTRjSSAzniEMQ0WSqbKM5sA97pZo=
Date:   Sun, 14 Jul 2019 17:27:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DS3TR-C
Message-ID: <20190714172727.5b2a31a0@archlinux>
In-Reply-To: <c0cf032e04524d20f646993e61d5b8696b9d2fa8.1561802767.git.lorenzo@kernel.org>
References: <cover.1561802767.git.lorenzo@kernel.org>
        <c0cf032e04524d20f646993e61d5b8696b9d2fa8.1561802767.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 29 Jun 2019 12:13:53 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support to STM LSM6DS3TR-C 6-axis (acc + gyro) Mems sensor
> https://www.st.com/resource/en/datasheet/lsm6ds3tr-c.pdf
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig             | 2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 5 ++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
>  6 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 9e592973a8a6..b254d03e2043 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -9,7 +9,7 @@ config IIO_ST_LSM6DSX
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> -	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr
> +	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index cd1642bb4ec0..ffa8402763c5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -23,6 +23,7 @@
>  #define ST_ASM330LHH_DEV_NAME	"asm330lhh"
>  #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
> +#define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -34,6 +35,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_ASM330LHH_ID,
>  	ST_LSM6DSOX_ID,
>  	ST_LSM6DSR_ID,
> +	ST_LSM6DS3TRC_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 793598ee960a..61b20fa64108 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -1,10 +1,10 @@
>  /*
>   * STMicroelectronics st_lsm6dsx FIFO buffer library driver
>   *
> - * LSM6DS3/LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC: The FIFO buffer can be
> - * configured to store data from gyroscope and accelerometer. Samples are
> - * queued without any tag according to a specific pattern based on
> - * 'FIFO data sets' (6 bytes each):
> + * LSM6DS3/LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
> + * The FIFO buffer can be configured to store data from gyroscope and
> + * accelerometer. Samples are queued without any tag according to a
> + * specific pattern based on 'FIFO data sets' (6 bytes each):
>   *  - 1st data set is reserved for gyroscope data
>   *  - 2nd data set is reserved for accelerometer data
>   * The FIFO pattern changes depending on the ODRs and decimation factors
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 04233928d23e..dc479e139cfc 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -17,7 +17,7 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 8KB
>   *
> - * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC:
> + * - LSM6DS3H/LSM6DSL/LSM6DSM/ISM330DLC/LSM6DS3TR-C:
>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
> @@ -234,6 +234,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			}, {
>  				.hw_id = ST_ISM330DLC_ID,
>  				.name = ST_ISM330DLC_DEV_NAME,
> +			}, {
> +				.hw_id = ST_LSM6DS3TRC_ID,
> +				.name = ST_LSM6DS3TRC_DEV_NAME,
>  			},
>  		},
>  		.decimator = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 47581a4e456e..0542f64fb673 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -76,6 +76,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,lsm6dsr",
>  		.data = (void *)ST_LSM6DSR_ID,
>  	},
> +	{
> +		.compatible = "st,lsm6ds3tr-c",
> +		.data = (void *)ST_LSM6DS3TRC_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -90,6 +94,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> +	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index facf66978a4b..4e160dcb0d7d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -76,6 +76,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,lsm6dsr",
>  		.data = (void *)ST_LSM6DSR_ID,
>  	},
> +	{
> +		.compatible = "st,lsm6ds3tr-c",
> +		.data = (void *)ST_LSM6DS3TRC_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -90,6 +94,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> +	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);

