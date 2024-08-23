Return-Path: <linux-iio+bounces-8731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C495D581
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58201F23A71
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5C192586;
	Fri, 23 Aug 2024 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGLGGcdN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA0191F9C;
	Fri, 23 Aug 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438943; cv=none; b=u+Ja05d1N+hRB3fF7ARehEvNXdOFFTELnEYYONToAXTgRc4ZukzeHmKypBgAd1q6SCO5n7KaKFxKHRq57h5xFx7rfquz58hp9PQtkGustPd8M9YF9FoF+5/E0Q8rVxWuaaeNJDy+AlPEZa6tgue9bj9oqpA8Xyn188HZdo4uP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438943; c=relaxed/simple;
	bh=cWy2nEWs2KrRrBfFk6UIt2HinYabtHMMjbnzuXOfPTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=leyuaK2xjhS9n9t7BM7uqM68fJnem2PCF5/OL9ao0YfHDrSpxy6AwuuG2bwKfzidOTeNC8/Jk8HeBqSroMPwHkaGua4VSGkDQ9nnEgV2YgSTnpm89EfNvRh1tMGGMJlM/L45EyAoyUFh8fKCH4rfciIXL9dhJbjstZw2F+jw9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGLGGcdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6232BC32786;
	Fri, 23 Aug 2024 18:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724438942;
	bh=cWy2nEWs2KrRrBfFk6UIt2HinYabtHMMjbnzuXOfPTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YGLGGcdNOYByD/L4LqRodK1g8dRV4Omux2+3/oOEqULY3Kj9vpeNXx+Gnp9l3KJGd
	 7jxeSblyJiTM/lKFyA+TfQJcRk0nxViWPJa4b7HsUNUA2w29lohsyqSis4BvAqwGnX
	 0PembGsW/I6+bSVzttrD9tN2Jt5H8okFx+XSO5rPR8FOcMP4V+EiGF8+7XxVFm2zzT
	 5YUMfvXx9gtKg3rBo2n3UhQRqs/mtUNgAxC4xxkU7/fEZx7ACiINV6LZ2nljHRIWY4
	 NIBKflCPwxAH/RTA0mbuYeRCkjjGS3OcNgKNX3tDioR8Ydjdl8hcbs3xyZxzaFHggb
	 qdj6U0P1LT2hQ==
Date: Fri, 23 Aug 2024 19:48:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: adc: ad7625: add driver
Message-ID: <20240823194852.4d855eb3@jic23-huawei>
In-Reply-To: <20240819-ad7625_r1-v3-2-75d5217c76b5@baylibre.com>
References: <20240819-ad7625_r1-v3-0-75d5217c76b5@baylibre.com>
	<20240819-ad7625_r1-v3-2-75d5217c76b5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 10:11:44 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add a driver for the AD762x and AD796x family of ADCs. These are
> pin-compatible devices using an LVDS interface for data transfer,
> capable of sampling at rates of 6 (AD7625), 10 (AD7626), and 5
> (AD7960/AD7961) MSPS, respectively. They also feature multiple voltage
> reference options based on the configuration of the EN1/EN0 pins, which
> can be set in the devicetree.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Hi Trevor
A few really minor things in here.  Given we are waiting on the 
PWM set anyway, I haven't just tidied them up whilst applying.
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  15 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7625.c | 688 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 705 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2361f92751dd..a90972e1c5c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1268,6 +1268,7 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
> +F:	drivers/iio/adc/ad7625.c
>  
>  ANALOG DEVICES INC AD7768-1 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f60fe85a30d5..e25fb505f545 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -219,6 +219,21 @@ config AD7606_IFACE_SPI
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7606_spi.
>  
> +config AD7625
> +        tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
> +        select IIO_BACKEND
> +        help
> +          Say yes here to build support for Analog Devices:
> +	  * AD7625 16-Bit, 6 MSPS PulSAR Analog-to-Digital Converter
Looks like some tabs mixed in with otherwise spaces.
Should be tabs + spaces as per entry above.
> +	  * AD7626 16-Bit, 10 MSPS PulSAR Analog-to-Digital Converter
> +	  * AD7960 18-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
> +	  * AD7961 16-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
> +
> +          The driver requires the assistance of the AXI ADC IP core to operate.
> +
> +          To compile this driver as a module, choose M here: the module will be
> +          called ad7625.
> +
>  config AD7766
>  	tristate "Analog Devices AD7766/AD7767 ADC driver"
>  	depends on SPI_MASTER

> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> new file mode 100644
> index 000000000000..3ac3c56d43eb
> --- /dev/null
> +++ b/drivers/iio/adc/ad7625.c
> @@ -0,0 +1,688 @@

> +
> +struct ad7625_chip_info {
> +	const char *name;
> +	const unsigned int max_sample_rate_hz;
> +	const struct ad7625_timing_spec *timing_spec;
> +	const struct iio_chan_spec chan_spec;
> +	const bool has_power_down_state;
> +	const bool has_bandwidth_control;
> +	const bool has_internal_vref;
Not sure I'd bother marking these bools const. Unlikely the compiler
can do anything with that info it can't do without it. I guess it does no
real harm thowever.
> +};


> +static int ad7625_probe(struct platform_device *pdev)
> +{

...

> +	/*
> +	 * Set the initial sampling frequency to the maximum, unless the
> +	 * AD796x device is limited to narrow bandwidth by EN2 == 1, in
> +	 * which case the sampling frequency should be limited to 2MSPS
> +	 */
> +	if (!st->info->has_bandwidth_control) {
> +		default_sample_freq = st->info->max_sample_rate_hz;
> +	} else {
> +		default_sample_freq = !st->can_wide_bandwidth ?

Flip the logic.
		default_sample_freq = st->can_wide_bandwidth ?
				      st->info->max_sample_rate_hz :
				      AD7960_MAX_NBW_FREQ;

seems simpler or set a default and override it.
	default_sample_freq = st->info_max_sample_rate_hz;
	if (st->info->has_bandwidth_control &&
	    !st->can_wide_bandwidth)
		default_sampling_freq = AD7960_MAX_NBW_FREQ;
		

> +				      AD7960_MAX_NBW_FREQ :
> +				      st->info->max_sample_rate_hz;
> +	}

