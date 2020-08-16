Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475212456D5
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgHPIwW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 04:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgHPIwT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 04:52:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F5E2065C;
        Sun, 16 Aug 2020 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597567939;
        bh=oPTDgZxJRD5PjeJuP6EdHc8oemk/ztIgJgKwBSsjXHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=az1Cc7uWF33NtCUHk53+nNxDq6l4DjJGP4fqWJvL9r8G4iq7LQAIJOJWDBdXT0B4C
         HC97NuqCdMkGNg7x6Nvk2pukeWfYwAPn7pouZr6/v1DU+CVYdWhqVG0Fb46RzuVqR0
         b6sVstGeWH54z2WfzZgReHh8iphoj10Ij5Vs/ipY=
Date:   Sun, 16 Aug 2020 09:52:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and
 SC7A30E
Message-ID: <20200816095215.6f3513d2@archlinux>
In-Reply-To: <20200811134846.3981475-3-daniel@0x0f.com>
References: <20200811134846.3981475-1-daniel@0x0f.com>
        <20200811134846.3981475-3-daniel@0x0f.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Aug 2020 22:48:46 +0900
Daniel Palmer <daniel@0x0f.com> wrote:

> This chips are not from ST but seem to be clones of the ST parts.
> The register and bit settings in the datasheets match those in the
> LIS2DH datasheet.
Same issue with sign off.

+ Needs to be added to the device tree documentation in
Documentation/devicetree/bindings/iio/st-sensors.txt

Thanks,

Jonathan


> ---
>  drivers/iio/accel/st_accel.h      |   4 +
>  drivers/iio/accel/st_accel_core.c | 159 +++++++++++++++++++++++++++++-
>  drivers/iio/accel/st_accel_i2c.c  |  10 ++
>  3 files changed, 172 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index 5d356288e001..784c2df83dde 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -36,6 +36,8 @@ enum st_accel_type {
>  	LIS3DHH,
>  	LIS2DE12,
>  	LIS2HH12,
> +	SC7A20,
> +	SC7A30E,
>  	ST_ACCEL_MAX,
>  };
>  
> @@ -61,6 +63,8 @@ enum st_accel_type {
>  #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
>  #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
>  #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
> +#define SC7A20_ACCEL_DEV_NAME		"sc7a20"
> +#define SC7A30E_ACCEL_DEV_NAME		"sc7a30e"
>  
>  /**
>  * struct st_sensors_platform_data - default accel platform data
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 43c50167d220..23fdbf27d44c 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -980,7 +980,164 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> -
> +	{
> +		.wai = 0x11,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = SC7A20_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> +		.odr = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.odr_avl = {
> +				{ .hz = 1, .value = 0x01, },
> +				{ .hz = 10, .value = 0x02, },
> +				{ .hz = 25, .value = 0x03, },
> +				{ .hz = 50, .value = 0x04, },
> +				{ .hz = 100, .value = 0x05, },
> +				{ .hz = 200, .value = 0x06, },
> +				{ .hz = 400, .value = 0x07, },
> +				{ .hz = 1600, .value = 0x08, },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
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
> +					.gain = IIO_G_TO_M_S_2(1000),
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_4G,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(2000),
> +				},
> +				[2] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(4000),
> +				},
> +				[3] = {
> +					.num = ST_ACCEL_FS_AVL_16G,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(12000),
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = 0x23,
> +			.mask = 0x80,
> +		},
> +		.drdy_irq = {
> +			.int1 = {
> +				.addr = 0x22,
> +				.mask = 0x10,
> +			},
> +			.addr_ihl = 0x25,
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
> +	{
> +		.wai = 0x33,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = SC7A30E_ACCEL_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
> +		.odr = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
> +			.odr_avl = {
> +				{ .hz = 1, .value = 0x01, },
> +				{ .hz = 10, .value = 0x02, },
> +				{ .hz = 25, .value = 0x03, },
> +				{ .hz = 50, .value = 0x04, },
> +				{ .hz = 100, .value = 0x05, },
> +				{ .hz = 200, .value = 0x06, },
> +				{ .hz = 400, .value = 0x07, },
> +				{ .hz = 1600, .value = 0x08, },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x20,
> +			.mask = 0xf0,
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
> +					.gain = IIO_G_TO_M_S_2(1000),
> +				},
> +				[1] = {
> +					.num = ST_ACCEL_FS_AVL_4G,
> +					.value = 0x01,
> +					.gain = IIO_G_TO_M_S_2(2000),
> +				},
> +				[2] = {
> +					.num = ST_ACCEL_FS_AVL_8G,
> +					.value = 0x02,
> +					.gain = IIO_G_TO_M_S_2(4000),
> +				},
> +				[3] = {
> +					.num = ST_ACCEL_FS_AVL_16G,
> +					.value = 0x03,
> +					.gain = IIO_G_TO_M_S_2(12000),
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = 0x23,
> +			.mask = 0x80,
> +		},
> +		.drdy_irq = {
> +			.int1 = {
> +				.addr = 0x22,
> +				.mask = 0x10,
> +			},
> +			.addr_ihl = 0x25,
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
>  };
>  
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 360e16f2cadb..2c9e91ef5e19 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -108,6 +108,14 @@ static const struct of_device_id st_accel_of_match[] = {
>  		.compatible = "st,lis2hh12",
>  		.data = LIS2HH12_ACCEL_DEV_NAME,
>  	},
> +	{
> +		.compatible = "silan,sc7a20-accel",
> +		.data = SC7A20_ACCEL_DEV_NAME,
> +	},
> +	{
> +		.compatible = "silan,sc7a30e-accel",
> +		.data = SC7A30E_ACCEL_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_accel_of_match);
> @@ -143,6 +151,8 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  	{ LIS3DE_ACCEL_DEV_NAME },
>  	{ LIS2DE12_ACCEL_DEV_NAME },
>  	{ LIS2HH12_ACCEL_DEV_NAME },
> +	{ SC7A20_ACCEL_DEV_NAME },
> +	{ SC7A30E_ACCEL_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

