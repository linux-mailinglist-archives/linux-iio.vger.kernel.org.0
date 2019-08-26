Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC949F385
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfH0Tvx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 15:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbfH0Tvw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 15:51:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE6A21883;
        Tue, 27 Aug 2019 19:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566935511;
        bh=g52voPW02KMWFb+PZtEu9ej0gFuj3OTjw9uqyojV+XY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JzcQkBhDsuIik60i9vJOkPTv0iZwsczXDRslodZfjr01XJpp4Rjvy1Wo7kYURCXtb
         kPnCjAv10xUIKIJSUwARqn4fQ8csA+0zoh1lTrpvuzrMyCdfF8ICubUandW+uJEKcS
         DuGQjzPlB8kS3nBm7qKM+rwt9DhFQYMR3VC7/H7E=
Date:   Mon, 26 Aug 2019 09:13:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
Message-ID: <20190826091349.6a464baa@archlinux>
In-Reply-To: <20190821132520.28225-4-martin.kepplinger@puri.sm>
References: <20190821132520.28225-1-martin.kepplinger@puri.sm>
        <20190821132520.28225-4-martin.kepplinger@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 15:25:19 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (separately
> supported in iio/magnetometer/st_magn*) are located on a separate i2c addresses
> on the bus.
> 
> For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9ds1.pdf
> 
> Treat it just like the LSM6* devices and, despite it's name, hook it up
> to the st_lsm6dsx driver, using it's basic functionality.
> 
> accelerometer and gyroscope are not independently clocked. It runs at the gyro
> frequencies if both are enabled, see chapter 7.12 of the datasheet.
> We could have handled this as a single IIO device but we have split
> it up to be more consistent with the other more flexible devices.
> 
> Despite supporting and testing the LSM9DS1, we call the gyro channels
> iio_chan_spec struct "st_lsm6ds0_gyro_channels" because the register
> description is equal. This suggests that supporting LSM6DS0 should be
> trivial to do.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Typo in the patch title that I've fixed up.  After a bit of thought
I've added postfix -imu but only in minimal number of places.

I've not bothered with the internal defines as within the driver at least
it's obvious which part we are talking about.

imu isn't the perfect name but having both -gyroaccel or something similar
is also not great.  We still have time to change this if people feel
strongly about it.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig           |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 87 ++++++++++++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  5 ++
>  5 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 939058b27746..77aa0e77212d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -12,7 +12,7 @@ config IIO_ST_LSM6DSX
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
>  	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
> -	  ism330dhcx
> +	  ism330dhcx and the accelerometer/gyroscope of lsm9ds1.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 090b7bd3c5b0..196e344301f6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -24,6 +24,7 @@
>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>  #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
>  #define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -37,6 +38,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSR_ID,
>  	ST_LSM6DS3TRC_ID,
>  	ST_ISM330DHCX_ID,
> +	ST_LSM9DS1_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 1b46d9dc2089..ad839ccf871c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -10,6 +10,8 @@
>   * +-125/+-245/+-500/+-1000/+-2000 dps
>   * LSM6DSx series has an integrated First-In-First-Out (FIFO) buffer
>   * allowing dynamic batching of sensor data.
> + * LSM9DSx series is similar but includes an additional magnetometer, handled
> + * by a different driver.
>   *
>   * Supported sensors:
>   * - LSM6DS3:
> @@ -30,6 +32,13 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 3KB
>   *
> + * - LSM9DS1:
> + *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
> + *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> + *   - Gyroscope supported ODR [Hz]: 15, 60, 119, 238, 476, 952
> + *   - Gyroscope supported full-scale [dps]: +-245/+-500/+-2000
> + *   - FIFO size: 32
> + *
>   * Copyright 2016 STMicroelectronics Inc.
>   *
>   * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> @@ -70,7 +79,85 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x18, IIO_MOD_X, 0),
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1a, IIO_MOD_Y, 1),
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1c, IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
> +	{
> +		.wai = 0x68,
> +		.int1_addr = 0x0c,
> +		.int2_addr = 0x0d,
> +		.reset_addr = 0x22,
> +		.max_fifo_size = 32,
> +		.id = {
> +			{
> +				.hw_id = ST_LSM9DS1_ID,
> +				.name = ST_LSM9DS1_DEV_NAME,
> +			},
> +		},
> +		.channels = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.chan = st_lsm6dsx_acc_channels,
> +				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.chan = st_lsm6ds0_gyro_channels,
> +				.len = ARRAY_SIZE(st_lsm6ds0_gyro_channels),
> +			},
> +		},
> +		.odr_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x20,
> +					.mask = GENMASK(7, 5),
> +				},
> +				.odr_avl[0] = {  10, 0x01 },
> +				.odr_avl[1] = {  50, 0x02 },
> +				.odr_avl[2] = { 119, 0x03 },
> +				.odr_avl[3] = { 238, 0x04 },
> +				.odr_avl[4] = { 476, 0x05 },
> +				.odr_avl[5] = { 952, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(7, 5),
> +				},
> +				.odr_avl[0] = {  15, 0x01 },
> +				.odr_avl[1] = {  60, 0x02 },
> +				.odr_avl[2] = { 119, 0x03 },
> +				.odr_avl[3] = { 238, 0x04 },
> +				.odr_avl[4] = { 476, 0x05 },
> +				.odr_avl[5] = { 952, 0x06 },
> +			},
> +		},
> +		.fs_table = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.reg = {
> +					.addr = 0x20,
> +					.mask = GENMASK(4, 3),
> +				},
> +				.fs_avl[0] = {  599, 0x0 },
> +				.fs_avl[1] = { 1197, 0x2 },
> +				.fs_avl[2] = { 2394, 0x3 },
> +				.fs_avl[3] = { 4788, 0x1 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.reg = {
> +					.addr = 0x10,
> +					.mask = GENMASK(4, 3),
> +				},
> +				.fs_avl[0] = { IIO_DEGREE_TO_RAD(245), 0x0 },
> +				.fs_avl[1] = { IIO_DEGREE_TO_RAD(500), 0x1 },
> +				.fs_avl[2] = { IIO_DEGREE_TO_RAD(0), 0x2 },
> +				.fs_avl[3] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
> +			},
> +		},
> +	},
>  	{
>  		.wai = 0x69,
>  		.int1_addr = 0x0d,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 15c6aa5b6caa..2f1b30ff083b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,ism330dhcx",
>  		.data = (void *)ST_ISM330DHCX_ID,
>  	},
> +	{
> +		.compatible = "st,lsm9ds1",
> +		.data = (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -99,6 +103,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index a8430ee11310..421ce704f346 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,ism330dhcx",
>  		.data = (void *)ST_ISM330DHCX_ID,
>  	},
> +	{
> +		.compatible = "st,lsm9ds1",
> +		.data = (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -99,6 +103,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);

