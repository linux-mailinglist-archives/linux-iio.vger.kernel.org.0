Return-Path: <linux-iio+bounces-23498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9DAB3CEED
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E716A778
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6382DCC1B;
	Sat, 30 Aug 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUUnSt3u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E83257AF3;
	Sat, 30 Aug 2025 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756581084; cv=none; b=VzToEuvoNHFnmZiKpmszOgPOCPlYa9t3w4q1bmzro3SuDyZFwTLM3OTq0MXIROyTl+678CLSZC6NHIadzJcG8sHlwfLpyClAk40DvWSc/gc4lMyLvXpoTl88477QknoIHJHDoPs5K5Fju6v2UAgQI0J8L45fy9U3UsW2P+XPHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756581084; c=relaxed/simple;
	bh=MyE3pqyLVbld26pEgWknWcMBrihOQjvuBuX/OtdkRaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU7qMaatcSprVJfUB1Dc06RIA/9GXiW+qyV8DoGUqbcIzHdjOKxKIUFqFk6hHm9GGqZy5zUqXLyl0PzG/rcZLXPZb5cegBrUlYYMCZU9a/cPjk7PUIoHS1OfePG4CO7vEwOEtMwkgsgbg3uCCTmy0kLqKsm9n7s1B3eaVf9SLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUUnSt3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA5EC4CEEB;
	Sat, 30 Aug 2025 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756581083;
	bh=MyE3pqyLVbld26pEgWknWcMBrihOQjvuBuX/OtdkRaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PUUnSt3uX2DbVP9xUtZmCggMgFNvOfdVmEcI7oQ7hGXOhmniJmpvXEdQCiqns4II1
	 3dJ7wpRau2RaNIi8hnOuZ+9FB2T8Zc7paD9WOlvk694i47LsHFJciG1fMFqnMDmDdt
	 sJVK1mXRBswX3pTMUegN5Rl2gB2/uOvxlgI1j15u/2oD4lsVbMHXTxjmE5CjnxhDCI
	 lWQCM1QtCcEFxw1GVMeYacOxZi6khHJIxAk+RC/LRiwK5l+RdnZA6/SKx9ujhYNcFE
	 8Io5DK2jW6Va7m6/Cdq52JQbiSO5Ft2/zQ44c3aQHgcv0tuSUgTpJD8l4DiYl+SFJW
	 b4c33TvdOkRHg==
Date: Sat, 30 Aug 2025 20:11:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <Michael.Hennerich@analog.com>,
 <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
 <andy@kernel.org>, <corbet@lwn.net>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <broonie@kernel.org>,
 <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
 <ahaslam@baylibre.com>, <sergiu.cuciurean@analog.com>,
 <tgamblin@baylibre.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH 07/15] iio: adc: ad4030: Add SPI offload support
Message-ID: <20250830201110.0f768545@jic23-huawei>
In-Reply-To: <0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
	<0d9f377295635d977e0767de9db96d0a6ad06de0.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 21:42:50 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> samples per second (MSPS). Not all SPI controllers are able to achieve
> such high throughputs and even when the controller is fast enough to run
> transfers at the required speed, it may be costly to the CPU to handle
> transfer data at such high sample rates.  Add SPI offload support for
> AD4030 and similar ADCs so to enable ADC data capture at maximum sample
> rates.
> 
> Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Cc: Nuno Sa <nuno.sa@analog.com>
> Cc: Trevor Gamblin <tgamblin@baylibre.com>
> Cc: Axel Haslam <ahaslam@baylibre.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Most of the code in this patch is based on work from Sergiu Cuciurean, Nuno Sa,
> Axel Haslam, and Trevor Gamblin, hence the many co-developed-by tags. I also
> draw inspiration from other drivers supporting SPI offload, many of them written
> by David Lechner.

A few things inline. 

> +
> +static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (PTR_ERR_OR_ZERO(st->offload))
> +		return -EINVAL;
> +
> +	if (!freq || freq > st->chip->max_sample_rate_hz)
> +		return -EINVAL;
> +
> +	ret = __ad4030_set_sampling_freq(st, freq);
> +	iio_device_release_direct(indio_dev);
Where is the claim?
> +
> +	return ret;
> +}


>  
>  static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
> @@ -903,6 +1038,67 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
>  	.validate_scan_mask = ad4030_validate_scan_mask,
>  };
>  
> +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4030_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));
> +	if (ret)
> +		return ret;
> +
> +	st->offload_msg.offload = st->offload;
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret < 0)
> +		goto out_reset_mode;
> +
> +	ret = pwm_set_waveform_might_sleep(st->conv_trigger, &st->conv_wf, false);
> +	if (ret)
> +		goto out_unoptimize;
> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &st->offload_trigger_config);
> +	if (ret)
> +		goto out_pwm_disable;
Blank line here.

> +	return 0;
Blank line here.

> +out_pwm_disable:
> +	pwm_disable(st->conv_trigger);
> +out_unoptimize:
> +	spi_unoptimize_message(&st->offload_msg);
> +out_reset_mode:
> +	/* reenter register configuration mode */
> +	ret = ad4030_enter_config_mode(st);
> +	if (ret)
> +		dev_warn(&st->spi->dev,
> +			 "couldn't reenter register configuration mode\n");
> +	return ret;
> +}

> +
> +static void ad4030_prepare_offload_msg(struct ad4030_state *st)
> +{
> +	u8 data_width = st->chip->precision_bits;
> +	u8 offload_bpw;
> +
> +	if (st->lane_mode == AD4030_LANE_MD_INTERLEAVED)
> +		/*
> +		 * This means all channels on 1 lane.
> +		 */

Single line comment looks like enough here.

> +		offload_bpw = data_width * st->chip->num_voltage_inputs;
> +	else
> +		offload_bpw  = data_width;
> +
> +	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;
> +	st->offload_xfer.bits_per_word = offload_bpw;
> +	st->offload_xfer.len = roundup_pow_of_two(BITS_TO_BYTES(offload_bpw));
> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +}


> @@ -1103,6 +1393,20 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
>  		.shift = 2,
>  		.endianness = IIO_BE,
>  	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 24,
> +		.shift = 0,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_CPU,
> +	},
>  };
>  
>  static const struct iio_scan_type ad4030_16_scan_types[] = {
> @@ -1119,7 +1423,21 @@ static const struct iio_scan_type ad4030_16_scan_types[] = {
>  		.realbits = 30,
>  		.shift = 2,
>  		.endianness = IIO_BE,
> -	}
> +	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 16,
> +		.shift = 0,
> +		.endianness = IIO_CPU,
> +	},
> +	[AD4030_OFFLOAD_SCAN_TYPE_AVG] = {
> +		.sign = 's',
> +		.storagebits = 32,
> +		.realbits = 30,
> +		.shift = 2,
> +		.endianness = IIO_CPU,
> +	},
>  };
>  
>  static const struct ad4030_chip_info ad4030_24_chip_info = {
> @@ -1130,10 +1448,15 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
>  		AD4030_CHAN_CMO(1, 0),
>  		IIO_CHAN_SOFT_TIMESTAMP(2),
>  	},
> +	.offload_channels = {
> +		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_scan_types),

This array still has the non offload cases.  Do they make sense?

> +		AD4030_CHAN_CMO(1, 0),
> +	},
>  	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
>  	.precision_bits = 24,
>  	.num_voltage_inputs = 1,
>  	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
> +	.max_sample_rate_hz = 2 * MEGA,
>  };

