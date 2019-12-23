Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37643129617
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 13:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWMpk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 07:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfLWMpk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 07:45:40 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF02A20709;
        Mon, 23 Dec 2019 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577105139;
        bh=HeZsH1VLgcB3LmomnXR8N9hEB74A0CBPSGBt4pnc3gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y+cP7ZNTYglY0H+wYDZsu0bTNUWBrbCXmcSxmLHpsDrw/DV9ATDSvr8NVPRla3/dp
         9cJrmsAJvEAQEhOc21eKGOnr8v4Kfk4So28IvChuAH0xAt9fjiO4rPvjt/Bs4p9tsL
         Axel44GziCsi569wiwz3aeJl5uoF42rCnFROyVjU=
Date:   Mon, 23 Dec 2019 12:45:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH v1] iio: st_gyro: Correct data for LSM9DS0 gyro
Message-ID: <20191223124534.1ed2d23b@archlinux>
In-Reply-To: <20191217171038.17004-1-andriy.shevchenko@linux.intel.com>
References: <20191217171038.17004-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 19:10:38 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The commit 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
> assumes that gyro in LSM9DS0 is the same as others with 0xd4 WAI ID,
> but datasheet tells slight different story, i.e. the first scale factor
> for the chip is 245 dps, and not 250 dps.
> 
> Correct this by introducing a separate settings for LSM9DS0.
> 
> Fixes: 41c128cb25ce ("iio: st_gyro: Add lsm9ds0-gyro support")
> Depends-on: 45a4e4220bf4 ("iio: gyro: st_gyro: fix L3GD20H support")
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks good to me.  Will just leave it a bit longer to give others
time to check it.

Give me a shout if I seem to have missed this by about a week into the new
year (to let people get back from holidays etc).

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/st_gyro_core.c | 75 ++++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
> index 57be68b291fa..26c50b24bc08 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -138,7 +138,6 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  			[2] = LSM330DLC_GYRO_DEV_NAME,
>  			[3] = L3G4IS_GYRO_DEV_NAME,
>  			[4] = LSM330_GYRO_DEV_NAME,
> -			[5] = LSM9DS0_GYRO_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
>  		.odr = {
> @@ -208,6 +207,80 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
>  		.multi_read_bit = true,
>  		.bootime = 2,
>  	},
> +	{
> +		.wai = 0xd4,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = LSM9DS0_GYRO_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
> +		.odr = {
> +			.addr = 0x20,
> +			.mask = GENMASK(7, 6),
> +			.odr_avl = {
> +				{ .hz = 95, .value = 0x00, },
> +				{ .hz = 190, .value = 0x01, },
> +				{ .hz = 380, .value = 0x02, },
> +				{ .hz = 760, .value = 0x03, },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x20,
> +			.mask = BIT(3),
> +			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.enable_axis = {
> +			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
> +			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
> +		},
> +		.fs = {
> +			.addr = 0x23,
> +			.mask = GENMASK(5, 4),
> +			.fs_avl = {
> +				[0] = {
> +					.num = ST_GYRO_FS_AVL_245DPS,
> +					.value = 0x00,
> +					.gain = IIO_DEGREE_TO_RAD(8750),
> +				},
> +				[1] = {
> +					.num = ST_GYRO_FS_AVL_500DPS,
> +					.value = 0x01,
> +					.gain = IIO_DEGREE_TO_RAD(17500),
> +				},
> +				[2] = {
> +					.num = ST_GYRO_FS_AVL_2000DPS,
> +					.value = 0x02,
> +					.gain = IIO_DEGREE_TO_RAD(70000),
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = 0x23,
> +			.mask = BIT(7),
> +		},
> +		.drdy_irq = {
> +			.int2 = {
> +				.addr = 0x22,
> +				.mask = BIT(3),
> +			},
> +			/*
> +			 * The sensor has IHL (active low) and open
> +			 * drain settings, but only for INT1 and not
> +			 * for the DRDY line on INT2.
> +			 */
> +			.stat_drdy = {
> +				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
> +				.mask = GENMASK(2, 0),
> +			},
> +		},
> +		.sim = {
> +			.addr = 0x23,
> +			.value = BIT(0),
> +		},
> +		.multi_read_bit = true,
> +		.bootime = 2,
> +	},
>  	{
>  		.wai = 0xd7,
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,

