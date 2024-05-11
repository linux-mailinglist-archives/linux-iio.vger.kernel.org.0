Return-Path: <linux-iio+bounces-4970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C77818C32A2
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2FB2132C
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345D1B813;
	Sat, 11 May 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfBkufG4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8C7F;
	Sat, 11 May 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715446727; cv=none; b=bM3qBpgXNoGIKqi/Hw0BF/vr/pZdDt+eHaWwRZZk7kJ4BHYJ4ZezWnCjwRG+QydYhXMqHQ2YBDxTVTXbddDfJ/S2eJOpzYuLxYGLUqQT5R5LTBXw21wBv+LFar5AfUrKmDaAgld3WQDrLLGlvalH0gj27jUTkKZ5yhafNeWz95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715446727; c=relaxed/simple;
	bh=5AVH771LZeh7JEIvEAl1rITnWhqrlp/jLeqDnOLxo2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rg98trtJKv36guG0YSICphJ7nGgLdsXjn3UpKKIMKJ+U7Gq2mx0243PBWx4kU13GDE1vlUOu5Uw7Ukphp9GXtkvxOiztCk2Jbh+/l7y9g5kPTteIdayRaN12QL4vFcDqozetpRxTDOtnDss44iq0XE8i8HuUQWnoMOCPDapUTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfBkufG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B80C2BBFC;
	Sat, 11 May 2024 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715446726;
	bh=5AVH771LZeh7JEIvEAl1rITnWhqrlp/jLeqDnOLxo2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfBkufG4JbhTFf4YjKyC1dwViTWh/PvlHouFVbu5ui4J06pma431kOdW9o6dZAfXB
	 +NGNlspLwZ1Ul0MzUnd+ZC6npiruCInwnulqcjkwRvLmIppR0zETIlRbRfzrgaWkK0
	 68Fo9w81UUmcvBkfzNyTUppr0Fllr3g9V0ppjcz923aw3bUgmQ5I6fqc2f3jriuQ1T
	 0Je+wIiJOOoGEb1WxOX9s1opJGWSqL6QO9CD8vVAIGYBW05qPiOynXP3DHlAuqmi2q
	 m1viUQR3piEV3bHOBwkPDns04oha1qpM/Or9hvu3CLAKpXympClx7KcZx2U0XywZxU
	 Cum1zWWKydnYw==
Date: Sat, 11 May 2024 17:58:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 8/8] iio: adc: ad7944: add support for SPI
 offload
Message-ID: <20240511175832.6c2f6517@jic23-huawei>
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-8-8707a870c435@baylibre.com>
References: <20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	<20240510-dlech-mainline-spi-engine-offload-2-v2-8-8707a870c435@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 19:44:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for SPI offload to the ad7944 driver. This allows
> reading data at the max sample rate of 2.5 MSPS.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v2 changes:
> 
> In the previous version, there was a new separate driver for the PWM
> trigger and DMA hardware buffer. This was deemed too complex so they
> are moved into the ad7944 driver.
> 
> It has also been reworked to accommodate for the changes described in
> the other patches.
> 
> RFC: This isn't very polished yet, just FYI. A few things to sort out:
> 
> Rather than making the buffer either triggered buffer or hardware buffer,
> I'm considering allowing both, e.g. buffer0 will always be the triggered
> buffer and buffer1 will will be the hardware buffer if connected to a SPI
> controller with offload support, otherwise buffer1 is absent. But since
> multiple buffers haven't been used much so far, more investigation is
> needed to see how that would work in practice. If we do that though, then
> we would always have the sampling_frequency attribute though even though
> it only applies to one buffer.

Why would someone who has this nice IP in the path want the conventional
triggered buffer?  I'm not against the two buffer option, but I'd like to know
the reasoning not to just provide the hardware buffer if this SPI offload
is available.

I can conjecture reasons but would like you to write them out for me :)
This feels like if someone has paid for the expensive hardware they probably
only want the best performance.

Jonathan


> ---
>  drivers/iio/adc/ad7944.c | 147 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 111 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index 4602ab5ed2a6..6724d6c92778 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -9,6 +9,7 @@
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -21,6 +22,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> @@ -65,6 +67,8 @@ struct ad7944_adc {
>  	bool always_turbo;
>  	/* Reference voltage (millivolts). */
>  	unsigned int ref_mv;
> +	/* Clock that triggers SPI offload. */
> +	struct clk *trigger_clk;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -123,6 +127,7 @@ static const struct ad7944_chip_info _name##_chip_info = {		\
>  			.scan_type.endianness = IIO_CPU,		\
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
>  					| BIT(IIO_CHAN_INFO_SCALE),	\
> +			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
>  		},							\
>  		IIO_CHAN_SOFT_TIMESTAMP(1),				\
>  	},								\
> @@ -134,18 +139,12 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
>  /* fully differential */
>  AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
>  
> -static void ad7944_unoptimize_msg(void *msg)
> -{
> -	spi_unoptimize_message(msg);
> -}
> -
> -static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> -					 const struct iio_chan_spec *chan)
> +static void ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> +					  const struct iio_chan_spec *chan)
>  {
>  	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
>  						   : adc->timing_spec->conv_ns;
>  	struct spi_transfer *xfers = adc->xfers;
> -	int ret;
>  
>  	/*
>  	 * NB: can get better performance from some SPI controllers if we use
> @@ -174,21 +173,14 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
>  	xfers[2].bits_per_word = chan->scan_type.realbits;
>  
>  	spi_message_init_with_transfers(&adc->msg, xfers, 3);
> -
> -	ret = spi_optimize_message(adc->spi, &adc->msg);
> -	if (ret)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
>  }
>  
> -static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> -				      const struct iio_chan_spec *chan)
> +static void ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> +				       const struct iio_chan_spec *chan)
>  {
>  	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
>  						   : adc->timing_spec->conv_ns;
>  	struct spi_transfer *xfers = adc->xfers;
> -	int ret;
>  
>  	/*
>  	 * NB: can get better performance from some SPI controllers if we use
> @@ -208,12 +200,6 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
>  	xfers[1].bits_per_word = chan->scan_type.realbits;
>  
>  	spi_message_init_with_transfers(&adc->msg, xfers, 2);
> -
> -	ret = spi_optimize_message(adc->spi, &adc->msg);
> -	if (ret)
> -		return ret;
> -
> -	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
>  }
>  
>  static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
> @@ -345,6 +331,30 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!adc->trigger_clk)
> +			return -EOPNOTSUPP;
> +
> +		*val = clk_get_rate(adc->trigger_clk);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7944_write_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad7944_adc *adc = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!adc->trigger_clk)
> +			return -EOPNOTSUPP;
> +
> +		return clk_set_rate(adc->trigger_clk, val);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -352,6 +362,28 @@ static int ad7944_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad7944_iio_info = {
>  	.read_raw = &ad7944_read_raw,
> +	.write_raw = &ad7944_write_raw,
> +};
> +
> +static int ad7944_offload_ex_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7944_adc *adc = iio_priv(indio_dev);
> +
> +	return spi_offload_hw_trigger_enable(adc->spi, 0);
> +}
> +
> +static int ad7944_offload_ex_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad7944_adc *adc = iio_priv(indio_dev);
> +
> +	spi_offload_hw_trigger_disable(adc->spi, 0);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops ad7944_offload_ex_buffer_setup_ops = {
> +	.postenable = &ad7944_offload_ex_buffer_postenable,
> +	.predisable = &ad7944_offload_ex_buffer_predisable,
>  };
>  
>  static irqreturn_t ad7944_trigger_handler(int irq, void *p)
> @@ -471,6 +503,18 @@ static void ad7944_ref_disable(void *ref)
>  	regulator_disable(ref);
>  }
>  
> +static void ad7944_offload_unprepare(void *p)
> +{
> +	struct ad7944_adc *adc = p;
> +
> +	spi_offload_unprepare(adc->spi, 0, &adc->msg);
> +}
> +
> +static void ad7944_unoptimize_msg(void *msg)
> +{
> +	spi_unoptimize_message(msg);
> +}
> +
>  static int ad7944_probe(struct spi_device *spi)
>  {
>  	const struct ad7944_chip_info *chip_info;
> @@ -603,16 +647,10 @@ static int ad7944_probe(struct spi_device *spi)
>  
>  	switch (adc->spi_mode) {
>  	case AD7944_SPI_MODE_DEFAULT:
> -		ret = ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
> -		if (ret)
> -			return ret;
> -
> +		ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
>  		break;
>  	case AD7944_SPI_MODE_SINGLE:
> -		ret = ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
> -		if (ret)
> -			return ret;
> -
> +		ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
>  		break;
>  	case AD7944_SPI_MODE_CHAIN:
>  		ret = device_property_read_u32(dev, "#daisy-chained-devices",
> @@ -649,11 +687,48 @@ static int ad7944_probe(struct spi_device *spi)
>  		indio_dev->num_channels = ARRAY_SIZE(chip_info->channels);
>  	}
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      iio_pollfunc_store_time,
> -					      ad7944_trigger_handler, NULL);
> -	if (ret)
> -		return ret;
> +	if (device_property_present(dev, "spi-offloads")) {
> +		/* TODO: make this a parameter to ad7944_3wire_cs_mode_init_msg() */
> +		/* FIXME: wrong index for 4-wire mode */
> +		adc->xfers[2].rx_buf = NULL;
> +		adc->xfers[2].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +
> +		ret = spi_offload_prepare(adc->spi, 0, &adc->msg);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to prepare offload\n");
> +
> +		ret = devm_add_action_or_reset(dev, ad7944_offload_unprepare, adc);
> +		if (ret)
> +			return ret;
> +
> +		adc->trigger_clk = devm_clk_get_enabled(dev, "trigger");
> +		if (IS_ERR(adc->trigger_clk))
> +			return dev_err_probe(dev, PTR_ERR(adc->trigger_clk),
> +					     "failed to get trigger clk\n");
> +
> +		ret = devm_iio_dmaengine_buffer_setup(dev, indio_dev, "rx");
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->setup_ops = &ad7944_offload_ex_buffer_setup_ops;
> +		/* offload can't have soft timestamp */
> +		indio_dev->num_channels--;
> +	} else {
> +		ret = spi_optimize_message(adc->spi, &adc->msg);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						      iio_pollfunc_store_time,
> +						      ad7944_trigger_handler,
> +						      NULL);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }
> 


