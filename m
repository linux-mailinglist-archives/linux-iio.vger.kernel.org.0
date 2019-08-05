Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73A181EF4
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfHEOX7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfHEOX7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:23:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C57A2086D;
        Mon,  5 Aug 2019 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565015037;
        bh=mrUgom1wPAew67ZTsWqrZCkFmMt1Tl4+L4g7xhuGLC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rpxUVYRXbshyfyiFo8OQiOKrzGiWkrhSJZ9YeGyiwjKYCl5Z323uTc0ZEnW6wyC05
         C6T6NW3w8WI/bsIgpBBRBCmKP6U6BkTUBhmbzePUzCLZNAmjXACMf2puGGVPuY7hIp
         8TjV80IjA3Pona4Xvgf3Dj/p6OzUyDSrOSEhJIWI=
Date:   Mon, 5 Aug 2019 15:23:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ISM330DHCX
Message-ID: <20190805152353.17b4a0eb@archlinux>
In-Reply-To: <a3391b8b4734c483286f1352520dd1d6f8b96d4e.1564999807.git.lorenzo@kernel.org>
References: <cover.1564999807.git.lorenzo@kernel.org>
        <a3391b8b4734c483286f1352520dd1d6f8b96d4e.1564999807.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  5 Aug 2019 12:18:43 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support to STM ISM330DHCX 6-axis (acc + gyro) Mems sensor
> https://www.st.com/resource/en/datasheet/ism330dhcx.pdf
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Given these are exceptionally straight forward and I'm
hoovering up the outstanding patches on this driver today,
I'll be cheeky and not let them sit on the mailing list 
before applying.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to do their usual sanity check.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig             | 3 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 7 ++++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 5 ++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
>  6 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 6cbf65a7e11e..939058b27746 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -11,7 +11,8 @@ config IIO_ST_LSM6DSX
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> -	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c
> +	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
> +	  ism330dhcx
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 5090f1b3525a..4d47ba36de84 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -23,6 +23,7 @@
>  #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>  #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
> +#define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -35,6 +36,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSOX_ID,
>  	ST_LSM6DSR_ID,
>  	ST_LSM6DS3TRC_ID,
> +	ST_ISM330DHCX_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 1be1cec2ab23..2c03a5b80f80 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -14,9 +14,10 @@
>   * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
>   * value of the decimation factor and ODR set for each FIFO data set.
>   *
> - * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR: The FIFO buffer can be configured to
> - * store data from gyroscope and accelerometer. Each sample is queued with
> - * a tag (1B) indicating data source (gyroscope, accelerometer, hw timer).
> + * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX: The FIFO buffer can be
> + * configured to store data from gyroscope and accelerometer. Each sample
> + * is queued with a tag (1B) indicating data source (gyroscope, accelerometer,
> + * hw timer).
>   *
>   * FIFO supported modes:
>   *  - BYPASS: FIFO disabled
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index fc4d18b58c97..85824d6739ee 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -24,7 +24,7 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 4KB
>   *
> - * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR
> + * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX:
>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
> @@ -645,6 +645,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			{
>  				.hw_id = ST_LSM6DSR_ID,
>  				.name = ST_LSM6DSR_DEV_NAME,
> +			}, {
> +				.hw_id = ST_ISM330DHCX_ID,
> +				.name = ST_ISM330DHCX_DEV_NAME,
>  			},
>  		},
>  		.channels = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 28581eb0532c..15c6aa5b6caa 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -79,6 +79,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,lsm6ds3tr-c",
>  		.data = (void *)ST_LSM6DS3TRC_ID,
>  	},
> +	{
> +		.compatible = "st,ism330dhcx",
> +		.data = (void *)ST_ISM330DHCX_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -94,6 +98,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> +	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index 0371e8b94a3e..a8430ee11310 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -79,6 +79,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,lsm6ds3tr-c",
>  		.data = (void *)ST_LSM6DS3TRC_ID,
>  	},
> +	{
> +		.compatible = "st,ism330dhcx",
> +		.data = (void *)ST_ISM330DHCX_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -94,6 +98,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> +	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);

