Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4019822D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgC3RWr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 13:22:47 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:11795 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgC3RWr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 13:22:47 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 13:22:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585588964;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=KxeIHeglbqB251Du7zG5m44JsZjNiJxHjofFRSSX30I=;
        b=JbhH6ZeZ/71d8ZQ2CivYkMey1CyT+K1VXKKrL3xNIpLK1ws5r1HhYM5ZfyHNaG+OKE
        IfEA0lAaLcyNKQe7/k9gR86Ztml55Pc1Iz/ohwXfEWQP/eSHfaJkW/PZ5cvBId1nvRq4
        u4xLXG2jDbDAJC96AhBgT2rC3nO8CGBgoteHpiaXa+5ZedT8neDocvNULufYyZMUoj1U
        yhgUU/sUU217gqQsJRP5n+ZRwBdIUUQ0gn2TLwOpcl9iPM1f0AGZekAG0NImfQONEVGp
        FPNJAArbFqy/P0SqCgjLV+W1J49UfrxxPLg1HO849J5tVo/lwmDOmJ5hgucwU3iqTtru
        UphQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJDdfbYs7ef"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id u043b8w2UHAcO1X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 30 Mar 2020 19:10:38 +0200 (CEST)
Date:   Mon, 30 Mar 2020 19:10:31 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     =?iso-8859-1?Q?Ga=EBtan_Andr=E9?= <rvlander@gaetanandre.eu>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 2/2] iio: accel: st_sensors:  add support for LIS2HH12
Message-ID: <20200330171031.GA41042@gerhold.net>
References: <20200330141923.280226-1-rvlander@gaetanandre.eu>
 <20200330141923.280226-2-rvlander@gaetanandre.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200330141923.280226-2-rvlander@gaetanandre.eu>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Mon, Mar 30, 2020 at 04:19:23PM +0200, Gaëtan André wrote:
> Add support for STMicroelectronics LISHH12 accelerometer in st_accel
> framework.
> 
> https://www.st.com/resource/en/datasheet/lis2hh12.pdf
> 
> Signed-off-by: Gaëtan André <rvlander@gaetanandre.eu>

Thanks a lot for sending this patch upstream!

> ---
>  drivers/iio/accel/Kconfig         |  2 +-
>  drivers/iio/accel/st_accel.h      |  2 +
>  drivers/iio/accel/st_accel_core.c | 77 +++++++++++++++++++++++++++++++
>  drivers/iio/accel/st_accel_i2c.c  |  5 ++
>  4 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 5d91a6dda894..24ebe9e76915 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -238,7 +238,7 @@ config IIO_ST_ACCEL_3AXIS
>  	  Say yes here to build support for STMicroelectronics accelerometers:
>  	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
>  	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
> -	  LNG2DM, LIS3DE, LIS2DE12
> +	  LNG2DM, LIS3DE, LIS2DE12, LIS2HH12
>  
>  	  This driver can also be built as a module. If so, these modules
>  	  will be created:
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 5b13e293cade..5d356288e001 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -35,6 +35,7 @@ enum st_accel_type {
>  	LIS2DW12,
>  	LIS3DHH,
>  	LIS2DE12,
> +	LIS2HH12,
>  	ST_ACCEL_MAX,
>  };
>  
> @@ -59,6 +60,7 @@ enum st_accel_type {
>  #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
>  #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
>  #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
> +#define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index e2ec5d127495..43c50167d220 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -904,6 +904,83 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> +	{
> +		.wai = 0x41,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = LIS2HH12_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
> +		.odr = {
> +			.addr = 0x20,
> +			.mask = 0x70,
> +			.odr_avl = {
> +				{ .hz = 10, .value = 0x01, },
> +				{ .hz = 50, .value = 0x02, },
> +				{ .hz = 100, .value = 0x03, },
> +				{ .hz = 200, .value = 0x04, },
> +				{ .hz = 400, .value = 0x05, },
> +				{ .hz = 800, .value = 0x06, },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x20,
> +			.mask = 0x70,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.enable_axis = {
> +			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +		},
> +		.fs = {
> +			.addr = 0x23,
> +			.mask = 0x30,
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_ACCEL_FS_AVL_2G,
> +					.value = 0x00,
> +					.gain = IIO_G_TO_M_S_2(61),
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_4G,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(122),
> +				},
> +				[2] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(244),
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = 0x20,
> +			.mask = 0x08,
> +		},
> +		.drdy_irq = {
> +			.int1 = {
> +				.addr = 0x22,
> +				.mask = 0x01,
> +			},
> +			.int2 = {
> +				.addr = 0x25,
> +				.mask = 0x01,
> +			},
> +			.addr_ihl = 0x24,
> +			.mask_ihl = 0x02,
> +			.stat_drdy = {
> +				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
> +				.mask = 0x07,
> +			},
> +		},
> +		.sim = {
> +			.addr = 0x23,
> +			.value = BIT(0),
> +		},
> +		.multi_read_bit = true,
> +		.bootime = 2,
> +	},
> +
>  };

I checked that this conforms to the information in the linked datasheet:

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 8c489312f668..821854251a7b 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -104,6 +104,10 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis2de12",
>  		.data = LIS2DE12_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2hh12",
> +		.data = LIS2HH12_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -138,6 +142,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS2DW12_ACCEL_DEV_NAME },
>  	{ LIS3DE_ACCEL_DEV_NAME },
>  	{ LIS2DE12_ACCEL_DEV_NAME },
> +	{ LIS2HH12_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> -- 
> 2.26.0
