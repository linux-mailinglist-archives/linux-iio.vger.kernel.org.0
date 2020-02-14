Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C169915D976
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgBNO32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:57848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbgBNO32 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:29:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6117C206B6;
        Fri, 14 Feb 2020 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581690567;
        bh=LW9dzIFSNlWFh9drmcycqYT6FqQpnMAH/duyru+4AgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FbgxzYNknaS1lM7c9L12T9NAMl7bP3BMdN5ovPWZdULdukSgtkPeVHyefirxIkcnU
         XcrUIeXsALfch3xtjy0EF86reRbVLId9rHZRK380V/2vi1zkEt23+Or1DsDI1Oe11w
         QbmwPqGCsoasFIzfIlqPBNrRtpuaP13DkthYZpR4=
Date:   Fri, 14 Feb 2020 14:29:23 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/9] iio: imu: adis16400: initialize adis_data
 statically
Message-ID: <20200214142923.7838cdf7@archlinux>
In-Reply-To: <20200210132606.9315-2-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
        <20200210132606.9315-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:25:59 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change overrides commit 380b107bbf944 ("iio: adis: Introduce timeouts
> structure"). It removes the memory allocation and moves the 'adis_data'
> information to be static on the chip_info struct.
> 
> This also adds a timeout structure to ADIS16334, since it was initially
> omitted. This was omitted (by accident) when the change was done.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.  Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16400.c | 139 ++++++++++++++++--------------------
>  1 file changed, 63 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index cfb1c19eb930..1c0770e03ec9 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -156,7 +156,7 @@ struct adis16400_state;
>  
>  struct adis16400_chip_info {
>  	const struct iio_chan_spec *channels;
> -	const struct adis_timeout *timeouts;
> +	const struct adis_data adis_data;
>  	const int num_channels;
>  	const long flags;
>  	unsigned int gyro_scale_micro;
> @@ -930,12 +930,63 @@ static const struct iio_chan_spec adis16334_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(ADIS16400_SCAN_TIMESTAMP),
>  };
>  
> +static const char * const adis16400_status_error_msgs[] = {
> +	[ADIS16400_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
> +	[ADIS16400_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
> +	[ADIS16400_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
> +	[ADIS16400_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
> +	[ADIS16400_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
> +	[ADIS16400_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
> +	[ADIS16400_DIAG_STAT_ALARM2] = "Alarm 2 active",
> +	[ADIS16400_DIAG_STAT_ALARM1] = "Alarm 1 active",
> +	[ADIS16400_DIAG_STAT_FLASH_CHK] = "Flash checksum error",
> +	[ADIS16400_DIAG_STAT_SELF_TEST] = "Self test error",
> +	[ADIS16400_DIAG_STAT_OVERFLOW] = "Sensor overrange",
> +	[ADIS16400_DIAG_STAT_SPI_FAIL] = "SPI failure",
> +	[ADIS16400_DIAG_STAT_FLASH_UPT] = "Flash update failed",
> +	[ADIS16400_DIAG_STAT_POWER_HIGH] = "Power supply above 5.25V",
> +	[ADIS16400_DIAG_STAT_POWER_LOW] = "Power supply below 4.75V",
> +};
> +
> +#define ADIS16400_DATA(_timeouts)					\
> +{									\
> +	.msc_ctrl_reg = ADIS16400_MSC_CTRL,				\
> +	.glob_cmd_reg = ADIS16400_GLOB_CMD,				\
> +	.diag_stat_reg = ADIS16400_DIAG_STAT,				\
> +	.read_delay = 50,						\
> +	.write_delay = 50,						\
> +	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,			\
> +	.status_error_msgs = adis16400_status_error_msgs,		\
> +	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |	\
> +		BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |			\
> +		BIT(ADIS16400_DIAG_STAT_XACCL_FAIL) |			\
> +		BIT(ADIS16400_DIAG_STAT_XGYRO_FAIL) |			\
> +		BIT(ADIS16400_DIAG_STAT_YGYRO_FAIL) |			\
> +		BIT(ADIS16400_DIAG_STAT_ZGYRO_FAIL) |			\
> +		BIT(ADIS16400_DIAG_STAT_ALARM2) |			\
> +		BIT(ADIS16400_DIAG_STAT_ALARM1) |			\
> +		BIT(ADIS16400_DIAG_STAT_FLASH_CHK) |			\
> +		BIT(ADIS16400_DIAG_STAT_SELF_TEST) |			\
> +		BIT(ADIS16400_DIAG_STAT_OVERFLOW) |			\
> +		BIT(ADIS16400_DIAG_STAT_SPI_FAIL) |			\
> +		BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |			\
> +		BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |			\
> +		BIT(ADIS16400_DIAG_STAT_POWER_LOW),			\
> +	.timeouts = (_timeouts),					\
> +}
> +
>  static const struct adis_timeout adis16300_timeouts = {
>  	.reset_ms = ADIS16400_STARTUP_DELAY,
>  	.sw_reset_ms = ADIS16400_STARTUP_DELAY,
>  	.self_test_ms = ADIS16400_STARTUP_DELAY,
>  };
>  
> +static const struct adis_timeout adis16334_timeouts = {
> +	.reset_ms = 60,
> +	.sw_reset_ms = 60,
> +	.self_test_ms = 14,
> +};
> +
>  static const struct adis_timeout adis16362_timeouts = {
>  	.reset_ms = 130,
>  	.sw_reset_ms = 130,
> @@ -972,7 +1023,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
> -		.timeouts = &adis16300_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
>  	},
>  	[ADIS16334] = {
>  		.channels = adis16334_channels,
> @@ -985,6 +1036,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
>  		.set_freq = adis16334_set_freq,
>  		.get_freq = adis16334_get_freq,
> +		.adis_data = ADIS16400_DATA(&adis16334_timeouts),
>  	},
>  	[ADIS16350] = {
>  		.channels = adis16350_channels,
> @@ -996,7 +1048,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
> -		.timeouts = &adis16300_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
>  	},
>  	[ADIS16360] = {
>  		.channels = adis16350_channels,
> @@ -1009,7 +1061,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
> -		.timeouts = &adis16300_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
>  	},
>  	[ADIS16362] = {
>  		.channels = adis16350_channels,
> @@ -1022,7 +1074,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
> -		.timeouts = &adis16362_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16362_timeouts),
>  	},
>  	[ADIS16364] = {
>  		.channels = adis16350_channels,
> @@ -1035,7 +1087,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
> -		.timeouts = &adis16362_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16362_timeouts),
>  	},
>  	[ADIS16367] = {
>  		.channels = adis16350_channels,
> @@ -1048,7 +1100,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
> -		.timeouts = &adis16300_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16300_timeouts),
>  	},
>  	[ADIS16400] = {
>  		.channels = adis16400_channels,
> @@ -1060,7 +1112,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
>  		.set_freq = adis16400_set_freq,
>  		.get_freq = adis16400_get_freq,
> -		.timeouts = &adis16400_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16400_timeouts),
>  	},
>  	[ADIS16445] = {
>  		.channels = adis16445_channels,
> @@ -1074,7 +1126,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
>  		.set_freq = adis16334_set_freq,
>  		.get_freq = adis16334_get_freq,
> -		.timeouts = &adis16445_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16445_timeouts),
>  	},
>  	[ADIS16448] = {
>  		.channels = adis16448_channels,
> @@ -1088,7 +1140,7 @@ static struct adis16400_chip_info adis16400_chips[] = {
>  		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
>  		.set_freq = adis16334_set_freq,
>  		.get_freq = adis16334_get_freq,
> -		.timeouts = &adis16448_timeouts,
> +		.adis_data = ADIS16400_DATA(&adis16448_timeouts),
>  	}
>  };
>  
> @@ -1099,52 +1151,6 @@ static const struct iio_info adis16400_info = {
>  	.debugfs_reg_access = adis_debugfs_reg_access,
>  };
>  
> -static const char * const adis16400_status_error_msgs[] = {
> -	[ADIS16400_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
> -	[ADIS16400_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
> -	[ADIS16400_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
> -	[ADIS16400_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
> -	[ADIS16400_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
> -	[ADIS16400_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
> -	[ADIS16400_DIAG_STAT_ALARM2] = "Alarm 2 active",
> -	[ADIS16400_DIAG_STAT_ALARM1] = "Alarm 1 active",
> -	[ADIS16400_DIAG_STAT_FLASH_CHK] = "Flash checksum error",
> -	[ADIS16400_DIAG_STAT_SELF_TEST] = "Self test error",
> -	[ADIS16400_DIAG_STAT_OVERFLOW] = "Sensor overrange",
> -	[ADIS16400_DIAG_STAT_SPI_FAIL] = "SPI failure",
> -	[ADIS16400_DIAG_STAT_FLASH_UPT] = "Flash update failed",
> -	[ADIS16400_DIAG_STAT_POWER_HIGH] = "Power supply above 5.25V",
> -	[ADIS16400_DIAG_STAT_POWER_LOW] = "Power supply below 4.75V",
> -};
> -
> -static const struct adis_data adis16400_data = {
> -	.msc_ctrl_reg = ADIS16400_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16400_GLOB_CMD,
> -	.diag_stat_reg = ADIS16400_DIAG_STAT,
> -
> -	.read_delay = 50,
> -	.write_delay = 50,
> -
> -	.self_test_mask = ADIS16400_MSC_CTRL_MEM_TEST,
> -
> -	.status_error_msgs = adis16400_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16400_DIAG_STAT_ZACCL_FAIL) |
> -		BIT(ADIS16400_DIAG_STAT_YACCL_FAIL) |
> -		BIT(ADIS16400_DIAG_STAT_XACCL_FAIL) |
> -		BIT(ADIS16400_DIAG_STAT_XGYRO_FAIL) |
> -		BIT(ADIS16400_DIAG_STAT_YGYRO_FAIL) |
> -		BIT(ADIS16400_DIAG_STAT_ZGYRO_FAIL) |
> -		BIT(ADIS16400_DIAG_STAT_ALARM2) |
> -		BIT(ADIS16400_DIAG_STAT_ALARM1) |
> -		BIT(ADIS16400_DIAG_STAT_FLASH_CHK) |
> -		BIT(ADIS16400_DIAG_STAT_SELF_TEST) |
> -		BIT(ADIS16400_DIAG_STAT_OVERFLOW) |
> -		BIT(ADIS16400_DIAG_STAT_SPI_FAIL) |
> -		BIT(ADIS16400_DIAG_STAT_FLASH_UPT) |
> -		BIT(ADIS16400_DIAG_STAT_POWER_HIGH) |
> -		BIT(ADIS16400_DIAG_STAT_POWER_LOW),
> -};
> -
>  static void adis16400_setup_chan_mask(struct adis16400_state *st)
>  {
>  	const struct adis16400_chip_info *chip_info = st->variant;
> @@ -1158,23 +1164,6 @@ static void adis16400_setup_chan_mask(struct adis16400_state *st)
>  			st->avail_scan_mask[0] |= BIT(ch->scan_index);
>  	}
>  }
> -
> -static struct adis_data *adis16400_adis_data_alloc(struct adis16400_state *st,
> -						   struct device *dev)
> -{
> -	struct adis_data *data;
> -
> -	data = devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
> -	if (!data)
> -		return ERR_PTR(-ENOMEM);
> -
> -	memcpy(data, &adis16400_data, sizeof(*data));
> -
> -	data->timeouts = st->variant->timeouts;
> -
> -	return data;
> -}
> -
>  static int adis16400_probe(struct spi_device *spi)
>  {
>  	struct adis16400_state *st;
> @@ -1207,9 +1196,7 @@ static int adis16400_probe(struct spi_device *spi)
>  			st->adis.burst->extra_len = sizeof(u16);
>  	}
>  
> -	adis16400_data = adis16400_adis_data_alloc(st, &spi->dev);
> -	if (IS_ERR(adis16400_data))
> -		return PTR_ERR(adis16400_data);
> +	adis16400_data = &st->variant->adis_data;
>  
>  	ret = adis_init(&st->adis, indio_dev, spi, adis16400_data);
>  	if (ret)

