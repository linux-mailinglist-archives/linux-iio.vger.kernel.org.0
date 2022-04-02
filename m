Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825574F04C7
	for <lists+linux-iio@lfdr.de>; Sat,  2 Apr 2022 18:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357849AbiDBQQ5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Apr 2022 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357843AbiDBQQy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Apr 2022 12:16:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2402FFFC;
        Sat,  2 Apr 2022 09:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC297B80A25;
        Sat,  2 Apr 2022 16:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5ECC340EE;
        Sat,  2 Apr 2022 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648916099;
        bh=EayLZ6lxH+sJs16pkHM5UkBfG0pD4DNS+an1vp240j4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ej6QB+ImXYXyFRauAlEhLVmGItNcVDXh8s29JW/VrOkNzsqndby96YjgcZ2EHImc/
         taB+/40De1kRPNqwPtQtL2ltvTp87RqJ8WMdV2+p8PrW1iyYTkqKB1tPEPj/JGuCL8
         EhtOkvJbsgvVkOzfB6wmyBbOieJEk5xGvx3yp8Qfi9s1OBv+IPxoWJOuH0DJRth3Qe
         M0D8KxvCJGt08jFnhcsxabibcdbxUxzTOuIgsknnOnHGIiigOYpptd9UgdDuIDwthJ
         1Nfvekl7O7GBaNDUw398n+KVA1GnmUy+pjjRKkcan6o8pYXcdq4FUGxsDlieMGxLO/
         FmTzgDmISPG1A==
Date:   Sat, 2 Apr 2022 17:22:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ASM330LHHX
Message-ID: <20220402172240.2465e7f5@jic23-huawei>
In-Reply-To: <05cd9e612bf7304542aa1adf12025ae396b87cf2.1648893892.git.lorenzo@kernel.org>
References: <cover.1648893892.git.lorenzo@kernel.org>
        <05cd9e612bf7304542aa1adf12025ae396b87cf2.1648893892.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat,  2 Apr 2022 12:09:29 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Add support to STM  ASM330LHHX (acc + gyro) Mems sensor
> https://www.st.com/resource/en/datasheet/asm330lhhx.pdf
Use a Datasheet tag as below.
Perhaps mention it's an automotive rated sensor and that
it's compatible otherwise with xxx existing part.

Quick glance at the datasheet suggests this part has a sensor hub...
Should it be in a the block with parameters for that as you
currently have it in the one for no sensorhub I think.

Or is it using an incompatible sensor hub interface?

> 
Datasheet: https://www.st.com/resource/en/datasheet/asm330lhhx.pdf
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig             | 6 +++---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 6 +++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    | 5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    | 5 +++++
>  6 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 85860217aaf3..fefd0b939100 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -11,9 +11,9 @@ config IIO_ST_LSM6DSX
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> -	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
> -	  ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, the accelerometer/gyroscope
> -	  of lsm9ds1 and lsm6dst.
> +	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
> +	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop,
> +	  the accelerometer/gyroscope of lsm9ds1 and lsm6dst.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 6ac4eac36458..a86dd29a4738 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -31,6 +31,7 @@
>  #define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
>  #define ST_LSM6DST_DEV_NAME	"lsm6dst"
>  #define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
> +#define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -49,6 +50,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSRX_ID,
>  	ST_LSM6DST_ID,
>  	ST_LSM6DSOP_ID,
> +	ST_ASM330LHHX_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 16730a780964..38bb5f645ebd 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -14,7 +14,8 @@
>   * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
>   * value of the decimation factor and ODR set for each FIFO data set.
>   *
> - * LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/LSM6DSRX/ISM330DHCX/LSM6DST/LSM6DSOP:
> + * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
> + * LSM6DST/LSM6DSOP:
>   * The FIFO buffer can be configured to store data from gyroscope and
>   * accelerometer. Each sample is queued with a tag (1B) indicating data
>   * source (gyroscope, accelerometer, hw timer).
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index b1d8d5a66f01..910397716833 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -26,7 +26,7 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 4KB
>   *
> - * - LSM6DSO/LSM6DSOX/ASM330LHH/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP:
> + * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/LSM6DSOP:
>   *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, 208, 416,
>   *     833
>   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> @@ -786,6 +786,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.hw_id = ST_LSM6DST_ID,
>  				.name = ST_LSM6DST_DEV_NAME,
>  				.wai = 0x6d,
> +			}, {
> +				.hw_id = ST_ASM330LHHX_ID,
> +				.name = ST_ASM330LHHX_DEV_NAME,
> +				.wai = 0x6b,

Probably nicer to put it next to he other 0x6b entries.

>  			},
>  		},
>  		.channels = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 8b4fc2c15622..715fbdc8190e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -101,6 +101,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,lsm6dsop",
>  		.data = (void *)ST_LSM6DSOP_ID,
>  	},
> +	{
> +		.compatible = "st,asm330lhhx",
> +		.data = (void *)ST_ASM330LHHX_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -122,6 +126,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
>  	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
>  	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
> +	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index e80110b6b280..f5767cf76c1d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -101,6 +101,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,lsm6dsop",
>  		.data = (void *)ST_LSM6DSOP_ID,
>  	},
> +	{
> +		.compatible = "st,asm330lhhx",
> +		.data = (void *)ST_ASM330LHHX_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -122,6 +126,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_LSM6DSRX_DEV_NAME, ST_LSM6DSRX_ID },
>  	{ ST_LSM6DST_DEV_NAME, ST_LSM6DST_ID },
>  	{ ST_LSM6DSOP_DEV_NAME, ST_LSM6DSOP_ID },
> +	{ ST_ASM330LHHX_DEV_NAME, ST_ASM330LHHX_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);

