Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE715D96E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2020 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgBNO2X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Feb 2020 09:28:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBNO2X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Feb 2020 09:28:23 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E239F206B6;
        Fri, 14 Feb 2020 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581690501;
        bh=RvVbC2i7/H1vcfgSdnQX/1SQ7dwjjVBtJXKMdJT1me4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FRoj2QAVcea7jSVEUNZ+vnfHBVrZ8gecK+hEIUzSV3T1D8vydS8bOaAdO5iyrqPPa
         RQ7Zsn7W/AFjsYQlGwsdaqdbVccbDPkMWiKtp9oVI3/T5FM6B5e6XK4yRI3wyD+epT
         Z5aiJCcKTCQ3HY/ti8pCiJA5UzSm1Z60wzx823k4=
Date:   Fri, 14 Feb 2020 14:28:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/9] iio: imu: adis16480: initialize adis_data
 statically
Message-ID: <20200214142817.3bd22a15@archlinux>
In-Reply-To: <20200210132606.9315-1-alexandru.ardelean@analog.com>
References: <20200210132606.9315-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Feb 2020 15:25:58 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change overrides commit 380b107bbf944 ("iio: adis: Introduce timeouts
> structure"). It removes the memory allocation and moves the 'adis_data'
> information to be static on the chip_info struct.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to poke at it.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * initialize 'adis_data' statically on adis16480,adis16136 & adis16400
> * split 'iio: imu: adis: Refactor adis_initial_startup' patch
>   - new: 'iio: imu: adis: add unlocked __adis_initial_startup()'
>   - new: 'iio: imu: adis: add support product ID check in adis_initial_startup'
>   - modified: 'iio: imu: adis: Refactor adis_initial_startup'
> * added 'prod_id' field together with 'prod_id_reg' on 'adis_data'
>   each device that wants to use the 'prod_id_reg' must also provide an
>   expected 'prod_id' value
> 
>  drivers/iio/imu/adis16480.c | 140 ++++++++++++++++--------------------
>  1 file changed, 62 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index dac87f1001fd..4c4de1b62769 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -138,7 +138,7 @@ struct adis16480_chip_info {
>  	unsigned int max_dec_rate;
>  	const unsigned int *filter_freqs;
>  	bool has_pps_clk_mode;
> -	const struct adis_timeout *timeouts;
> +	const struct adis_data adis_data;
>  };
>  
>  enum adis16480_int_pin {
> @@ -796,6 +796,55 @@ enum adis16480_variant {
>  	ADIS16497_3,
>  };
>  
> +#define ADIS16480_DIAG_STAT_XGYRO_FAIL 0
> +#define ADIS16480_DIAG_STAT_YGYRO_FAIL 1
> +#define ADIS16480_DIAG_STAT_ZGYRO_FAIL 2
> +#define ADIS16480_DIAG_STAT_XACCL_FAIL 3
> +#define ADIS16480_DIAG_STAT_YACCL_FAIL 4
> +#define ADIS16480_DIAG_STAT_ZACCL_FAIL 5
> +#define ADIS16480_DIAG_STAT_XMAGN_FAIL 8
> +#define ADIS16480_DIAG_STAT_YMAGN_FAIL 9
> +#define ADIS16480_DIAG_STAT_ZMAGN_FAIL 10
> +#define ADIS16480_DIAG_STAT_BARO_FAIL 11
> +
> +static const char * const adis16480_status_error_msgs[] = {
> +	[ADIS16480_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
> +	[ADIS16480_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
> +	[ADIS16480_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
> +	[ADIS16480_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
> +	[ADIS16480_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
> +	[ADIS16480_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
> +	[ADIS16480_DIAG_STAT_XMAGN_FAIL] = "X-axis magnetometer self-test failure",
> +	[ADIS16480_DIAG_STAT_YMAGN_FAIL] = "Y-axis magnetometer self-test failure",
> +	[ADIS16480_DIAG_STAT_ZMAGN_FAIL] = "Z-axis magnetometer self-test failure",
> +	[ADIS16480_DIAG_STAT_BARO_FAIL] = "Barometer self-test failure",
> +};
> +
> +static int adis16480_enable_irq(struct adis *adis, bool enable);
> +
> +#define ADIS16480_DATA(_timeouts)					\
> +{									\
> +	.diag_stat_reg = ADIS16480_REG_DIAG_STS,			\
> +	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,				\
> +	.has_paging = true,						\
> +	.read_delay = 5,						\
> +	.write_delay = 5,						\
> +	.self_test_mask = BIT(1),					\
> +	.status_error_msgs = adis16480_status_error_msgs,		\
> +	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |	\
> +		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |			\
> +		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),			\
> +	.enable_irq = adis16480_enable_irq,				\
> +	.timeouts = (_timeouts),					\
> +}
> +
>  static const struct adis_timeout adis16485_timeouts = {
>  	.reset_ms = 560,
>  	.sw_reset_ms = 120,
> @@ -838,7 +887,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
>  		.filter_freqs = adis16480_def_filter_freqs,
> -		.timeouts = &adis16485_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
>  	},
>  	[ADIS16480] = {
>  		.channels = adis16480_channels,
> @@ -851,7 +900,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
>  		.filter_freqs = adis16480_def_filter_freqs,
> -		.timeouts = &adis16480_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16480_timeouts),
>  	},
>  	[ADIS16485] = {
>  		.channels = adis16485_channels,
> @@ -864,7 +913,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
>  		.filter_freqs = adis16480_def_filter_freqs,
> -		.timeouts = &adis16485_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
>  	},
>  	[ADIS16488] = {
>  		.channels = adis16480_channels,
> @@ -877,7 +926,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.int_clk = 2460000,
>  		.max_dec_rate = 2048,
>  		.filter_freqs = adis16480_def_filter_freqs,
> -		.timeouts = &adis16485_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16485_timeouts),
>  	},
>  	[ADIS16490] = {
>  		.channels = adis16485_channels,
> @@ -891,7 +940,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
>  		.has_pps_clk_mode = true,
> -		.timeouts = &adis16495_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16495_timeouts),
>  	},
>  	[ADIS16495_1] = {
>  		.channels = adis16485_channels,
> @@ -905,7 +954,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
>  		.has_pps_clk_mode = true,
> -		.timeouts = &adis16495_1_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
>  	},
>  	[ADIS16495_2] = {
>  		.channels = adis16485_channels,
> @@ -919,7 +968,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
>  		.has_pps_clk_mode = true,
> -		.timeouts = &adis16495_1_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
>  	},
>  	[ADIS16495_3] = {
>  		.channels = adis16485_channels,
> @@ -933,7 +982,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
>  		.has_pps_clk_mode = true,
> -		.timeouts = &adis16495_1_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
>  	},
>  	[ADIS16497_1] = {
>  		.channels = adis16485_channels,
> @@ -947,7 +996,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
>  		.has_pps_clk_mode = true,
> -		.timeouts = &adis16495_1_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
>  	},
>  	[ADIS16497_2] = {
>  		.channels = adis16485_channels,
> @@ -961,7 +1010,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
>  		.has_pps_clk_mode = true,
> -		.timeouts = &adis16495_1_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
>  	},
>  	[ADIS16497_3] = {
>  		.channels = adis16485_channels,
> @@ -975,7 +1024,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.max_dec_rate = 4250,
>  		.filter_freqs = adis16495_def_filter_freqs,
>  		.has_pps_clk_mode = true,
> -		.timeouts = &adis16495_1_timeouts,
> +		.adis_data = ADIS16480_DATA(&adis16495_1_timeouts),
>  	},
>  };
>  
> @@ -1048,53 +1097,6 @@ static int adis16480_initial_setup(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -#define ADIS16480_DIAG_STAT_XGYRO_FAIL 0
> -#define ADIS16480_DIAG_STAT_YGYRO_FAIL 1
> -#define ADIS16480_DIAG_STAT_ZGYRO_FAIL 2
> -#define ADIS16480_DIAG_STAT_XACCL_FAIL 3
> -#define ADIS16480_DIAG_STAT_YACCL_FAIL 4
> -#define ADIS16480_DIAG_STAT_ZACCL_FAIL 5
> -#define ADIS16480_DIAG_STAT_XMAGN_FAIL 8
> -#define ADIS16480_DIAG_STAT_YMAGN_FAIL 9
> -#define ADIS16480_DIAG_STAT_ZMAGN_FAIL 10
> -#define ADIS16480_DIAG_STAT_BARO_FAIL 11
> -
> -static const char * const adis16480_status_error_msgs[] = {
> -	[ADIS16480_DIAG_STAT_XGYRO_FAIL] = "X-axis gyroscope self-test failure",
> -	[ADIS16480_DIAG_STAT_YGYRO_FAIL] = "Y-axis gyroscope self-test failure",
> -	[ADIS16480_DIAG_STAT_ZGYRO_FAIL] = "Z-axis gyroscope self-test failure",
> -	[ADIS16480_DIAG_STAT_XACCL_FAIL] = "X-axis accelerometer self-test failure",
> -	[ADIS16480_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
> -	[ADIS16480_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
> -	[ADIS16480_DIAG_STAT_XMAGN_FAIL] = "X-axis magnetometer self-test failure",
> -	[ADIS16480_DIAG_STAT_YMAGN_FAIL] = "Y-axis magnetometer self-test failure",
> -	[ADIS16480_DIAG_STAT_ZMAGN_FAIL] = "Z-axis magnetometer self-test failure",
> -	[ADIS16480_DIAG_STAT_BARO_FAIL] = "Barometer self-test failure",
> -};
> -
> -static const struct adis_data adis16480_data = {
> -	.diag_stat_reg = ADIS16480_REG_DIAG_STS,
> -	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,
> -	.has_paging = true,
> -
> -	.read_delay = 5,
> -	.write_delay = 5,
> -
> -	.status_error_msgs = adis16480_status_error_msgs,
> -	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |
> -		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),
> -
> -	.enable_irq = adis16480_enable_irq,
> -};
> -
>  static int adis16480_config_irq_pin(struct device_node *of_node,
>  				    struct adis16480 *st)
>  {
> @@ -1245,22 +1247,6 @@ static int adis16480_get_ext_clocks(struct adis16480 *st)
>  	return 0;
>  }
>  
> -static struct adis_data *adis16480_adis_data_alloc(struct adis16480 *st,
> -						   struct device *dev)
> -{
> -	struct adis_data *data;
> -
> -	data = devm_kmalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
> -	if (!data)
> -		return ERR_PTR(-ENOMEM);
> -
> -	memcpy(data, &adis16480_data, sizeof(*data));
> -
> -	data->timeouts = st->chip_info->timeouts;
> -
> -	return data;
> -}
> -
>  static int adis16480_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -1285,9 +1271,7 @@ static int adis16480_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16480_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	adis16480_data = adis16480_adis_data_alloc(st, &spi->dev);
> -	if (IS_ERR(adis16480_data))
> -		return PTR_ERR(adis16480_data);
> +	adis16480_data = &st->chip_info->adis_data;
>  
>  	ret = adis_init(&st->adis, indio_dev, spi, adis16480_data);
>  	if (ret)

