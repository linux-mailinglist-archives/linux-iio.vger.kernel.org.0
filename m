Return-Path: <linux-iio+bounces-16568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5AAA57BD4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C587A3DEB
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA5F1C9B9B;
	Sat,  8 Mar 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnX+fPQn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BA383A2;
	Sat,  8 Mar 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741450645; cv=none; b=Xwm5lmRPo3mjQ0UOtRxZ5pVdz3AZErOFNsEBexlC6rtQxrVUOH9Z6XyNAthxcigxoIExVzIqd9cfEFLE2qOZams8O2pRtO29uIK3+xQVg1KPG+R2pn/l356E84mlcII5K14Wz5bo/rvq2veZAVvYH0+gJxN4hN/qoULTPJeyOiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741450645; c=relaxed/simple;
	bh=xC1dhXRJhNJXV88A2GMTUC68oKasP1pQrkTR0oGtHRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6fUJgU6mgQkuD/vS7enA7OuBuxHcVmgAMZjAZiotu6LPrtpDTun7Y9IzMSgJ0Kf6/2lt+ZZc2dp158vktRVx6+pFXDGKJiA7KGO/zee5I6EYiXDMeny/NVNqfkJDQa/RwyXpN+7CBP+upSWW7qIFG8kwuNAtoYgWfB1KDqo+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnX+fPQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A921C4CEE0;
	Sat,  8 Mar 2025 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741450644;
	bh=xC1dhXRJhNJXV88A2GMTUC68oKasP1pQrkTR0oGtHRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EnX+fPQnSRCyreIT/+/blhaBEZEIbjj2Nqdp5unhGL2Edt9jDPyTRmWUDrU7fUjnw
	 B5gBHkvsQGWZKFg7j5738FYpcuQTp3q+/fXxOGV5PmhFuF/AQObW5YVKAdxGzKeR78
	 Kb8CFWkPODcVfnLUpZpjYpdmNqcw1j2pgemSrKY94fYRrgzvfQK3ObI5Xbykh2xMAk
	 s+wlBG3fUzfwDgx4X9DS+83Pm+EELcHb/WXOYAEYsCFkwnLldIiJ9ui8j6MVnBkWsG
	 eVXOHpbHWkKZRPlpHFXWZZLTHpjpPsWa36EacnSPGSaM+t5wcUqA5Qi2wzWjupXFGx
	 be1ludsQWP1rQ==
Date: Sat, 8 Mar 2025 16:17:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH v3 1/2] iio: ad7380: add support for SPI offload
Message-ID: <20250308161717.3842cbdf@jic23-huawei>
In-Reply-To: <20250304-wip-bl-spi-offload-ad7380-v3-1-2d830f863bd1@baylibre.com>
References: <20250304-wip-bl-spi-offload-ad7380-v3-0-2d830f863bd1@baylibre.com>
	<20250304-wip-bl-spi-offload-ad7380-v3-1-2d830f863bd1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Mar 2025 16:25:44 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Add support for SPI offload to the ad7380 driver. SPI offload allows
> sampling data at the max sample rate (2MSPS with one SDO line).
> 
> This is developed and tested against the ADI example FPGA design for
> this family of ADCs [1].
> 
> [1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Hi Angelo

A couple of trivial comments inline.

This has crossed with Julien adding an extra device to the supported
set. I could have guessed what the necessary changes were but probably
better for you to do it and check for any problems.

https://lore.kernel.org/all/20250226-ad7380-add-adaq4381-4-support-v1-1-f350ab872d37@baylibre.com/

Jonathan

> ---
>  drivers/iio/adc/Kconfig  |   2 +
>  drivers/iio/adc/ad7380.c | 509 +++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 475 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216cb3f83cf1d995b9ffc22bf01776a4..c528f4632c0ef6782269d8afa89c17d2046d28a3 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -218,7 +218,9 @@ config AD7298
>  config AD7380
>  	tristate "Analog Devices AD7380 ADC driver"
>  	depends on SPI_MASTER
> +	select SPI_OFFLOAD
>  	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index f232ad1a49634baeedc655916bc7a967604a1206..39a5e55fa7e8a6706e15750d07fa4b0fda7175eb 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -15,6 +15,9 @@
>   * ad7386/7/8-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7386-4-7387-4-7388-4.pdf
>   * adaq4370-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4370-4.pdf
>   * adaq4380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4380-4.pdf
> + *
> + * HDL ad738x_fmc: https://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
> + *

Pet dislike of mine.  No lines at ends of comment blocks with nothing on them.  The */ provides
any necessary space.

>   */
>  
>  #include <linux/align.h>
> @@ -29,11 +32,13 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/spi/offload/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/units.h>
>  #include <linux/util_macros.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger_consumer.h>
> @@ -92,6 +97,12 @@
>  #define AD7380_NUM_SDO_LINES		1
>  #define AD7380_DEFAULT_GAIN_MILLI	1000
>  
> +/*
> + * Using SPI offload, storagebits is always 32, so can't be used to compute struct
> + * spi_transfer.len. Using realbits instead.
> + */
> +#define AD7380_SPI_BYTES(scan_type)	((scan_type)->realbits > 16 ? 4 : 2)
> +
>  struct ad7380_timing_specs {
>  	const unsigned int t_csh_ns;	/* CS minimum high time */
>  };
> @@ -99,6 +110,7 @@ struct ad7380_timing_specs {
>  struct ad7380_chip_info {
>  	const char *name;
>  	const struct iio_chan_spec *channels;
> +	const struct iio_chan_spec *offload_channels;
>  	unsigned int num_channels;
>  	unsigned int num_simult_channels;
>  	bool has_hardware_gain;
> @@ -111,6 +123,7 @@ struct ad7380_chip_info {
>  	unsigned int num_vcm_supplies;
>  	const unsigned long *available_scan_masks;
>  	const struct ad7380_timing_specs *timing_specs;
> +	u32 max_conversion_rate_hz;
>  };
>  
>  static const struct iio_event_spec ad7380_events[] = {
> @@ -216,6 +229,91 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
>  	},
>  };
>  
> +/*
> + * Defining here scan types for offload mode, since with current available HDL
> + * only a value of 32 for storagebits is supported.
> + */
> +
> +/* Extended scan types for 12-bit unsigned chips, offload support. */
> +static const struct iio_scan_type ad7380_scan_type_12_u_offload[] = {
> +	[AD7380_SCAN_TYPE_NORMAL] = {
> +		.sign = 'u',
> +		.realbits = 12,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 'u',
> +		.realbits = 14,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +};
> +
> +/* Extended scan types for 14-bit signed chips, offload support. */
> +static const struct iio_scan_type ad7380_scan_type_14_s_offload[] = {
> +	[AD7380_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.realbits = 14,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +};
> +
> +/* Extended scan types for 14-bit unsigned chips, offload support. */
> +static const struct iio_scan_type ad7380_scan_type_14_u_offload[] = {
> +	[AD7380_SCAN_TYPE_NORMAL] = {
> +		.sign = 'u',
> +		.realbits = 14,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 'u',
> +		.realbits = 16,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +};
> +
> +/* Extended scan types for 16-bit signed_chips, offload support. */
> +static const struct iio_scan_type ad7380_scan_type_16_s_offload[] = {
> +	[AD7380_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.realbits = 16,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 's',
> +		.realbits = 18,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +};
> +
> +/* Extended scan types for 16-bit unsigned chips, offload support. */
> +static const struct iio_scan_type ad7380_scan_type_16_u_offload[] = {
> +	[AD7380_SCAN_TYPE_NORMAL] = {
> +		.sign = 'u',
> +		.realbits = 16,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 'u',
> +		.realbits = 18,
> +		.storagebits = 32,
> +		.endianness = IIO_CPU,
> +	},
> +};

You could have perhaps used a macro for these to reduce repetition but it
is perhaps slightly more readable without doing that.

Jonathan




