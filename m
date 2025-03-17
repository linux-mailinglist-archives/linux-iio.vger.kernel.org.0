Return-Path: <linux-iio+bounces-16945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB952A649D0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AA81703B0
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D63226D16;
	Mon, 17 Mar 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOfyaZeY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5313B7A3;
	Mon, 17 Mar 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207292; cv=none; b=TrRDOyZgJ3yzEPnj94f9U3qc9UcebuuCBsz2saGef47kBYk8ZfPZvJvu63LLOHvRsKFwTshO+VCBOhph/+OESHD3IvqVschv8opfjYIlCsem4QkbwUaz4miO0czZvNZ2eaFTsNufND8z5o/E5DsnTl6xOgxLXCOlIWHat0rCoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207292; c=relaxed/simple;
	bh=qS18CGlLGP0tpSmU21eSar6JGn73St59+DNZX7wwsqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ppf0cSEf2w6LvDu6UkvzL6T4zJGRQRT+ZF3k7dSTcDK1o1e3nTCjvjjcpwJylhlnQAw08d80W7i1NVtpnAzgvsAbo4Wj74YdMkcLnvfh/XDqjjhujoLEckt5HT6IGyA8zyhvXThAJp5WNZ3dDi3+SoI3eg2KWjBcu9jR7P8Sbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOfyaZeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B4FC4CEE3;
	Mon, 17 Mar 2025 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207292;
	bh=qS18CGlLGP0tpSmU21eSar6JGn73St59+DNZX7wwsqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QOfyaZeYEI/OA3HfCH4/HVVnTYPCdzNiRnk9t3ntUUPQY4QNK9itk93JiwDD5Puxm
	 Ok4wa+dXq2E1zhK7g55FYRd5x9E+TcyUVaUX6bHhKzk5z7THPCXGZuj1cacUNfnfWx
	 5TtW6t7i6ym4G4T71RnJs3BXPyd9QR3FHM8HDze/ahDL7wa9osi1oRvHnuO6TWj7dO
	 ldu8jLFmd305q+7nk0dXE5oVHYh+kvLjUWJ+IrdTeRtLZeceVqYlOYZGuxmLIbyzCM
	 WZG8ZNqIMKJQjgJFXO6eEZsDDq+BYh6LIxjHiL7Ncle+hk81/7kLDTQ8ET5+0s9N6v
	 p7pX9GTZtIeUg==
Date: Mon, 17 Mar 2025 10:27:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <corbet@lwn.net>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
Message-ID: <20250317102751.5702fb82@jic23-huawei>
In-Reply-To: <301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
	<301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 14:18:39 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
> The PWM IP is used to trigger SPI-Engine offload modules that in turn set
> SPI-Engine to execute transfers to poll data from the ADC. That allows data
> to be read at the maximum sample rates. Also, it is possible to set a
> specific sample rate by setting the proper PWM duty cycle and related state
> parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
> trigger) is used in combination with SPI-Engine.
> 
> Add support for SPI offload.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

A few minor things inline.  

Jonathan

> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 4fe8dee48da9..6c9b71e7a2fb 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c

> +
> +static int ad4000_offload_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4000_state *st = iio_priv(indio_dev);
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);

Trivial. Prefer a blank line before a 'simple return' like this one.

> +	return 0;
> +}


> +
> +/*
> + * This executes a data sample transfer when using SPI offloading for when the
> + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
> + * tree property is absent. In this connection mode, the ADC SDI pin is
> + * connected to MOSI or to VIO and ADC CNV pin is connected to a SPI controller
> + * CS (it can't be connected to a GPIO).
> + *
> + * In order to achieve the maximum sample rate, we only do one transfer per
> + * SPI offload trigger. This has the effect that the first sample data is not
> + * valid because it is reading the previous conversion result. We also use

As below. Should mention what happens with that invalid sample.

> + * bits_per_word to ensure the minimum of SCLK cycles are used. And a delay is
> + * added to make sure we meet the minimum quiet time before releasing the CS
> + * line. Plus the CS change delay is set to ensure that we meet the minimum
> + * quiet time before asserting CS again.
> + *
> + * This timing is only valid if turbo mode is enabled (reading during conversion).
> + */
> +static int ad4000_prepare_offload_turbo_message(struct ad4000_state *st,
> +						const struct iio_chan_spec *chan)
> +{
> +
> +/*
> + * This executes a data sample transfer when using SPI offloading for when the
> + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
> + * tree property is set to "high". In this connection mode, the ADC SDI pin is
> + * connected to VIO and ADC CNV pin is connected to a SPI controller CS (it
> + * can't be connected to a GPIO).
> + *
> + * In order to achieve the maximum sample rate, we only do one transfer per
> + * SPI offload trigger. This has the effect that the first sample data is not
> + * valid because it is reading the previous conversion result. We also use

Say what happens to that invalid sample.  Is it dropped or provided to userspace
as if it were valid?  (I hope dropped!)

> + * bits_per_word to ensure the minimum of SCLK cycles are used. And a delay is
> + * added to make sure we meet the minimum quiet time before releasing the CS
> + * line. Plus the CS change delay is set to ensure that we meet the minimum
> + * conversion time before asserting CS again.
> + *
> + * This timing is only valid if turbo mode is disabled (reading during acquisition).
> + */
> +static int ad4000_prepare_offload_message(struct ad4000_state *st,
> +					  const struct iio_chan_spec *chan)
> +

...

>  /*
>   * This executes a data sample transfer for when the device connections are
>   * in "3-wire" mode, selected when the adi,sdi-pin device tree property is
> @@ -689,7 +975,9 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
>  	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
>  
>  	xfers[1].rx_buf = &st->scan.data;
> -	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
> +	if (chan->scan_type.endianness != IIO_BE)

As below. Endianness being related to bits_per_word is odd. So needs
explanation.

> +		xfers[1].bits_per_word = chan->scan_type.realbits;
>  	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
>  	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
>  
> @@ -719,7 +1007,9 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
>  	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
>  
>  	xfers[1].rx_buf = &st->scan.data;
> -	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
> +	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
> +	if (chan->scan_type.endianness != IIO_BE)

This is odd enough to require a comment.  Why is endianness relevant?

> +		xfers[1].bits_per_word = chan->scan_type.realbits;
> @@ -733,6 +1023,9 @@ static int ad4000_config(struct ad4000_state *st)
>  	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
>  		reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);
>  
> +	if (st->using_offload)
> +		reg_val |= FIELD_PREP(AD4000_CFG_TURBO, 1);
> +
>  	return ad4000_write_reg(st, reg_val);
>  }
>  


> +		if (st->using_offload) {
> +			indio_dev->channels = &chip->reg_access_offload_chan_spec;
Set num_channels here
> +			ret = ad4000_prepare_offload_turbo_message(st, indio_dev->channels);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to optimize SPI msg\n");
> +		} else {
> +			indio_dev->channels = chip->reg_access_chan_spec;
and here as well. I think you can use ARRAY_SIZE() to make the connection even more
obvious.

> +		}
> +
> +		/*
> +		 * Call ad4000_prepare_3wire_mode_message() so single-shot read
> +		 * SPI messages are always initialized.
> +		 */
>  		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
>  		if (ret)
> -			return ret;
> +			return dev_err_probe(dev, ret,
> +					     "Failed to optimize SPI msg\n");
>  
>  		ret = ad4000_config(st);
>  		if (ret < 0)
> @@ -806,19 +1134,36 @@ static int ad4000_probe(struct spi_device *spi)
>  
>  		break;
>  	case AD4000_SDI_VIO:
> -		indio_dev->info = &ad4000_info;
> -		indio_dev->channels = chip->chan_spec;
> +		if (st->using_offload) {
> +			indio_dev->info = &ad4000_offload_info;
> +			indio_dev->channels = &chip->offload_chan_spec;

here as well.

> +
> +			spi->cs_hold.value = AD4000_TCONV_NS;
> +			spi->cs_hold.unit = SPI_DELAY_UNIT_NSECS;
> +			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Failed to optimize SPI msg\n");
> +		} else {
> +			indio_dev->info = &ad4000_info;
> +			indio_dev->channels = chip->chan_spec;

Also set size here.  Obviously this means a little duplication but still good
to keep them together.


> +		}

>  	case AD4000_SDI_GND:
> @@ -830,7 +1175,10 @@ static int ad4000_probe(struct spi_device *spi)
>  	}
>  
>  	indio_dev->name = chip->dev_name;
> -	indio_dev->num_channels = 2;
> +	if (st->using_offload)
> +		indio_dev->num_channels = 1;
> +	else
> +		indio_dev->num_channels = 2;

Move this up to where you set channels so that the array
and size are set together.

>  
>  	ret = devm_mutex_init(dev, &st->lock);
>  	if (ret)
> @@ -853,12 +1201,6 @@ static int ad4000_probe(struct spi_device *spi)
>  
>  	ad4000_fill_scale_tbl(st, &indio_dev->channels[0]);
>  
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad4000_trigger_handler, NULL);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  
> @@ -947,3 +1289,4 @@ module_spi_driver(ad4000_driver);
>  MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");


