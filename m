Return-Path: <linux-iio+bounces-1941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F23B83EDC0
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 16:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF281F21E84
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jan 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4674B28DB5;
	Sat, 27 Jan 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiaPvcKC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FDE25629;
	Sat, 27 Jan 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706367644; cv=none; b=hwyaCgyVbFyjBRqQti4yWOjlT6ZlN7DQuvOCsluBRgZXLx3b1cB4Dl9JvC4fjchZsZpbopCCHskoFOGYyLIyMTtfA2G6W/Kf7Ris6cNIE9YDzo/TEZeAAkoXjWmnZZoZWhpth8foVJBsML9NOFV+6Gtg0RQbmK6BXbm4sGrPr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706367644; c=relaxed/simple;
	bh=nfIzBmBdlFCV+jugrOHpB0OoVqFTAdQEgyUc9lWlF90=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXTQtD/nWjYrwOVoSxxm9mOyzVODtnY7e2p989P7KIDEiVRjFWI8BrKpBWC3/D67GtAhGR7z5YbaINKGltn+LJhXoTsmcM7jPiQAhtTKAk6VkIy/ROfavjUI3uSwnYLz7wYMX6nzwiYgF33rpzoNHKWau1FFE/dt6jgXqQr1SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiaPvcKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEE1C433F1;
	Sat, 27 Jan 2024 15:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706367643;
	bh=nfIzBmBdlFCV+jugrOHpB0OoVqFTAdQEgyUc9lWlF90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oiaPvcKCP2KAbQA8BcXTzFoHqBjvMIfKDptslPkfYHzPFtmlRlB359OLD7YGWWBtd
	 IwttrZDiNG8AJ7B8FW0adrry7pEtKKt9uXj5qpuY0b5mB4R9cpFcixyuxBBUfmGQdT
	 B/72BEXi115RVRmn4iJAmdYYXbwVB1+hRcy8wz1WnZN6znfJY/p8hkL38eoennZYjZ
	 pLHB+CiemyS71bkvNkQvi4yI9jPGoc++fjRy2tTlLZG3mAzsFc/zLh+5lKM99kvwlw
	 FVXIZXDUBMijEvo0F56jAZRREtqCjMDOmTlth/kP1yx3Z/4eli6MOKi1QOQHS39YAZ
	 0+lbFkPdqaAUw==
Date: Sat, 27 Jan 2024 15:00:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
Message-ID: <20240127150029.1a9b49b2@jic23-huawei>
In-Reply-To: <eda2aac7da048e4ef1e1ea659ed4993f424ac810.1706093274.git.lorenzo@kernel.org>
References: <cover.1706093274.git.lorenzo@kernel.org>
	<eda2aac7da048e4ef1e1ea659ed4993f424ac810.1706093274.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 11:52:33 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support to STM ASM330LHHXG1 (accelerometer and gyroscope) Mems
> sensor.
> The ASM330LHHXG1 sensor can use ASM330LHHX as fallback device since it
> implements all the ASM330LHHXG1 features currently implemented in
> st_lsm6dsx.
> 
> Link: https://www.st.com/resource/en/datasheet/asm330lhhxg1.pdf
Datasheet:
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo.

A few comments inline.  Mostly about make it less noisy to
add additional devices in future.

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |  4 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 48 ++++++++++---------
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 ++
>  6 files changed, 43 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 5865a295a4df..645039edd606 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -14,8 +14,8 @@ config IIO_ST_LSM6DSX
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
>  	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
>  	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
> -	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, lsm6dst
> -	  and the accelerometer/gyroscope of lsm9ds1.
> +	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, asm330lhhxg1,
> +	  lsm6dst and the accelerometer/gyroscope of lsm9ds1.

I think it is worth a precursor to reformat this into a one entry per line
list so that changes become less noisy (and easier to deal with merge conflicts)
There are some examples of lists in drivers/hid/Kconfig and they look
find in menuconfig etc.

If I were not requesting other changes I'd have suggested this as a follow up
patch but given you are going to be respinning again, it would be neater
as a precursor!


>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index c19237717e81..78d12d3c2759 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -15,29 +15,30 @@
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
>  
> -#define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
> -#define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> -#define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
> -#define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
> -#define ST_ISM330DLC_DEV_NAME	"ism330dlc"
> -#define ST_LSM6DSO_DEV_NAME	"lsm6dso"
> -#define ST_ASM330LHH_DEV_NAME	"asm330lhh"
> -#define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
> -#define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
> -#define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
> -#define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
> -#define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
> -#define ST_LSM6DS0_DEV_NAME	"lsm6ds0"
> -#define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
> -#define ST_LSM6DST_DEV_NAME	"lsm6dst"
> -#define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
> -#define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
> -#define ST_LSM6DSTX_DEV_NAME	"lsm6dstx"
> -#define ST_LSM6DSV_DEV_NAME	"lsm6dsv"
> -#define ST_LSM6DSV16X_DEV_NAME	"lsm6dsv16x"
> -#define ST_LSM6DSO16IS_DEV_NAME	"lsm6dso16is"
> -#define ST_ISM330IS_DEV_NAME	"ism330is"
> -#define ST_ASM330LHB_DEV_NAME	"asm330lhb"
> +#define ST_LSM6DS3_DEV_NAME		"lsm6ds3"
> +#define ST_LSM6DS3H_DEV_NAME		"lsm6ds3h"
> +#define ST_LSM6DSL_DEV_NAME		"lsm6dsl"
> +#define ST_LSM6DSM_DEV_NAME		"lsm6dsm"
> +#define ST_ISM330DLC_DEV_NAME		"ism330dlc"
> +#define ST_LSM6DSO_DEV_NAME		"lsm6dso"
> +#define ST_ASM330LHH_DEV_NAME		"asm330lhh"
> +#define ST_LSM6DSOX_DEV_NAME		"lsm6dsox"
> +#define ST_LSM6DSR_DEV_NAME		"lsm6dsr"
> +#define ST_LSM6DS3TRC_DEV_NAME		"lsm6ds3tr-c"
> +#define ST_ISM330DHCX_DEV_NAME		"ism330dhcx"
> +#define ST_LSM9DS1_DEV_NAME		"lsm9ds1-imu"
> +#define ST_LSM6DS0_DEV_NAME		"lsm6ds0"
> +#define ST_LSM6DSRX_DEV_NAME		"lsm6dsrx"
> +#define ST_LSM6DST_DEV_NAME		"lsm6dst"
> +#define ST_LSM6DSOP_DEV_NAME		"lsm6dsop"
> +#define ST_ASM330LHHX_DEV_NAME		"asm330lhhx"
> +#define ST_LSM6DSTX_DEV_NAME		"lsm6dstx"
> +#define ST_LSM6DSV_DEV_NAME		"lsm6dsv"
> +#define ST_LSM6DSV16X_DEV_NAME		"lsm6dsv16x"
> +#define ST_LSM6DSO16IS_DEV_NAME		"lsm6dso16is"
> +#define ST_ISM330IS_DEV_NAME		"ism330is"
> +#define ST_ASM330LHB_DEV_NAME		"asm330lhb"
> +#define ST_ASM330LHHXG1_DEV_NAME	"asm330lhhxg1"

Too much noise. I don't care if they are all aligned the same.
If you really want to do this, break it out to a precursor patch.
I'd just have one entry with a different indent :)


>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID = 1,
> @@ -63,6 +64,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSO16IS_ID,
>  	ST_ISM330IS_ID,
>  	ST_ASM330LHB_ID,
> +	ST_ASM330LHHXG1_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 066fe561c5e8..5d9539822ec6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -15,7 +15,7 @@
>   * value of the decimation factor and ODR set for each FIFO data set.
>   *
>   * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
> - * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB:
> + * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB/ASM330LHHXG1:

A list here as well would help.

>   * The FIFO buffer can be configured to store data from gyroscope and
>   * accelerometer. Each sample is queued with a tag (1B) indicating data
>   * source (gyroscope, accelerometer, hw timer).
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index b6e6b1df8a61..27ecf2a5d0bc 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -27,7 +27,7 @@
>   *   - FIFO size: 4KB
>   *
>   * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP/
> - *   LSM6DSTX/LSM6DSO16IS/ISM330IS:
> + *   LSM6DSTX/LSM6DSO16IS/ISM330IS/ASM330LHHXG1:

Another place where reformatting as a list would make adding new entries less noisy
+ whilst doing that, please fix the ordering to be alphabetical.

>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
>   *     833
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> @@ -820,6 +820,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.hw_id = ST_ASM330LHHX_ID,
>  				.name = ST_ASM330LHHX_DEV_NAME,
>  				.wai = 0x6b,
> +			}, {
> +				.hw_id = ST_ASM330LHHXG1_ID,
> +				.name = ST_ASM330LHHXG1_DEV_NAME,
> +				.wai = 0x6b,
>  			}, {
>  				.hw_id = ST_LSM6DSTX_ID,
>  				.name = ST_LSM6DSTX_DEV_NAME,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 911444ec57c0..cddf41cc0ca9 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -134,6 +134,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,asm330lhb",
>  		.data = (void *)ST_ASM330LHB_ID,
>  	},
> +	{
> +		.compatible = "st,asm330lhhxg1",
> +		.data = (void *)ST_ASM330LHHXG1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -168,6 +172,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
>  	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
>  	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
> +	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index f56c170c41a9..c122c8831365 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -129,6 +129,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,asm330lhb",
>  		.data = (void *)ST_ASM330LHB_ID,
>  	},
> +	{
> +		.compatible = "st,asm330lhhxg1",
> +		.data = (void *)ST_ASM330LHHXG1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -157,6 +161,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
>  	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
>  	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
> +	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);


