Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F600E6444
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJ0Qin (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 12:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfJ0Qin (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 12:38:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318D421726;
        Sun, 27 Oct 2019 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572194322;
        bh=pTyOkc8lWHKpKQaVDCLi4915Unw3xojiQ98ejWmscTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s531xbKhEzDPZgwvriC4YInfpv61zd26hOWs0CBy/0bPLmaJjzVsXTiklz8pnF7WY
         9XmjIdhSN/aQKgMqQW0xmejd+ZRvAs2BmVsduFgO2VQRNu/ahnRSpwghAmNKD4ETsH
         wqVhU/7DJFicFQPBc/T5bX6/c5fyl6DTNsT7c+v4=
Date:   Sun, 27 Oct 2019 16:38:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to LSM6DSRX
Message-ID: <20191027163838.3fdc1249@archlinux>
In-Reply-To: <92cfd5eef9cb794f15853ab83c4ef84482887fc4.1571931470.git.lorenzo@kernel.org>
References: <cover.1571931470.git.lorenzo@kernel.org>
        <92cfd5eef9cb794f15853ab83c4ef84482887fc4.1571931470.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Oct 2019 17:42:33 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support to STM LSM6DSRX 6-axis (acc + gyro) Mems sensor
> https://www.st.com/resource/en/datasheet/lsm6dsrx.pdf
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig             | 3 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 3 +++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
>  6 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index b425a356d99e..28f59d09208a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -12,7 +12,8 @@ config IIO_ST_LSM6DSX
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
>  	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
> -	  ism330dhcx, lsm6ds0 and the accelerometer/gyroscope of lsm9ds1.
> +	  ism330dhcx, lsm6dsrx, lsm6ds0 and the accelerometer/gyroscope
> +	  of lsm9ds1.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index f660359ccb4d..37e499fe6bcf 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -27,6 +27,7 @@
>  #define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
>  #define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
>  #define ST_LSM6DS0_DEV_NAME	"lsm6ds0"
> +#define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -42,6 +43,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_ISM330DHCX_ID,
>  	ST_LSM9DS1_ID,
>  	ST_LSM6DS0_ID,
> +	ST_LSM6DSRX_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index ffeb2596b97b..31cd90d2c60e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -14,10 +14,10 @@
>   * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
>   * value of the decimation factor and ODR set for each FIFO data set.
>   *
> - * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX: The FIFO buffer can be
> - * configured to store data from gyroscope and accelerometer. Each sample
> - * is queued with a tag (1B) indicating data source (gyroscope, accelerometer,
> - * hw timer).
> + * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/LSM6DSRX/ISM330DHCX:
> + * The FIFO buffer can be configured to store data from gyroscope and
> + * accelerometer. Each sample is queued with a tag (1B) indicating data
> + * source (gyroscope, accelerometer, hw timer).
>   *
>   * FIFO supported modes:
>   *  - BYPASS: FIFO disabled
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index f9c83aa2c9b7..1f28a7733fc0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1084,6 +1084,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			}, {
>  				.hw_id = ST_ISM330DHCX_ID,
>  				.name = ST_ISM330DHCX_DEV_NAME,
> +			}, {
> +				.hw_id = ST_LSM6DSRX_ID,
> +				.name = ST_LSM6DSRX_DEV_NAME,
>  			},
>  		},
>  		.channels = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index e57744affbd0..cd47ec1fedcb 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -91,6 +91,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,lsm6ds0",
>  		.data = (void *)ST_LSM6DS0_ID,
>  	},
> +	{
> +		.compatible = "st,lsm6dsrx",
> +		.data = (void *)ST_LSM6DSRX_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -109,6 +113,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
>  	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
> +	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index 933d4f9f6a4a..67ff36eac247 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -91,6 +91,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,lsm6ds0",
>  		.data = (void *)ST_LSM6DS0_ID,
>  	},
> +	{
> +		.compatible = "st,lsm6dsrx",
> +		.data = (void *)ST_LSM6DSRX_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -109,6 +113,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
>  	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{ ST_LSM6DS0_DEV_NAME, ST_LSM6DS0_ID },
> +	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);

