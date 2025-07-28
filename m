Return-Path: <linux-iio+bounces-22107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C50B13CD8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 16:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F909540BD0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520D26CE31;
	Mon, 28 Jul 2025 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqbywbBy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C226658A;
	Mon, 28 Jul 2025 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711841; cv=none; b=YMYEiINcXI+cI2qNajk6FvD1nmet8ys2eSDsVqeegrq6v6BaF9KIguTgY8vYo1uuEM4G3YaPxUpKtCaZLLKK2C9Sw7CqZ5ILOCqGnxSUCphyOO+ujX0j3PEECOSZxt3nct4genNghcxA93/ccfl55e8AFxGYb/dPWAhCfVCVfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711841; c=relaxed/simple;
	bh=DEeHl6q6BiMCaTPnAlaMb6hi7U/jcMZK5J3IyMwTa+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqBC0Z7vFCwjuGrnfd6H5Q/mhco2YvnTzUBL7mfmEnMhCfWFO35HNnzhqHisfYmGGRaZvctLYnoaGKwsx99tqfsgtWNYttgBJCv9TvV49v+EC01iBgSrmBz4Y1Srw+AMw2NpnKjOulJEBeAn8CTQp1A9/zVAg3QXW3WSa7x3NNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqbywbBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2FEC4CEE7;
	Mon, 28 Jul 2025 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753711840;
	bh=DEeHl6q6BiMCaTPnAlaMb6hi7U/jcMZK5J3IyMwTa+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZqbywbByzSUJbisa8FdvmmAwdLYHbZyT6jt3uGoNtcRnxyCcUyLDRw7Ea5odX1LSP
	 V/gRYqRD+iAdItujswB2hbiMyBK0iZoxohf9I1mVdpk++Yb7RC7oozcG8j+gt8q0QP
	 BC6MXsXPd0fR0ZidrcxlOpimRgeuxOXg892t/P4laU3JUaOeAaVbhGDns3Wqcc1JVv
	 Uk32VGrZ+RU5nAXZKUFXUebFZfIlnygSZ9F0HQo6I2DlUeav5WdxbLNKsB+RTcvQbP
	 aqc4UcRDWtjNyq4QJRn1z6XK5t9LMVweaQdWuAEDQKlm9Q/mxhCjDyorYKAcbRUY9w
	 w85NZyEny/dZg==
Date: Mon, 28 Jul 2025 15:10:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ramona Nechita
 <ramona.nechita@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: adc: Update ad7779 to use IIO backend
Message-ID: <20250728151030.3f9d08b1@jic23-huawei>
In-Reply-To: <20250728134340.3644-5-Ioana.Risteiu@analog.com>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
	<20250728134340.3644-5-Ioana.Risteiu@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 16:43:36 +0300
Ioana Risteiu <Ioana.Risteiu@analog.com> wrote:

> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>

Hi Ioana,

There is some new ABI (I think) in here.  I'm not clear what it is for and
ABI documentation is missing.

A few other minor comments inline.

Thanks,

Jonathan

> +static int ad7779_set_data_lines(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 unsigned int mode)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DOUT_FORMAT_MSK,
> +				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, mode));
> +	switch (mode) {
> +	case AD7779_4LINES:
> +		ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_FREQ);
> +		if (ret)
> +			return ret;
> +		ret = iio_backend_num_lanes_set(st->back, 4);
> +		break;
> +	case AD7779_2LINES:
> +		ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_2LINE);
> +		if (ret)
> +			return ret;
> +		ret = iio_backend_num_lanes_set(st->back, 2);
> +		break;
> +	case AD7779_1LINE:
> +		ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_1LINE);
> +		if (ret)
> +			return ret;
> +		ret = iio_backend_num_lanes_set(st->back, 1);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +

	return ret;
or better yet, return in the various cases above.


> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

t struct iio_chan_spec_ext_info ad7779_ext_info_filter[] = {
> +	IIO_ENUM("data_lines", IIO_SHARED_BY_ALL, &ad7779_data_lines_enum),

New ABI.  Needs documentation in Documentation/ABI/testing/sysfs-bus-iio*

I'm not clear why we need to expose it to userspace, and documentation
might explain that to me.


> +	IIO_ENUM_AVAILABLE("data_lines", IIO_SHARED_BY_ALL,
> +			   &ad7779_data_lines_enum),
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7779_filter_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> +			   &ad7779_filter_enum),
> +	{ }
> +};
>
> +
> +static int ad7779_register_back(struct ad7779_state *st, struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret = -EINVAL;
> +
> +	indio_dev->info = &ad7779_info_data;
> +
> +	if (strcmp(st->chip_info->name, "ad7771") == 0) {

Don't do string matching.  Much preferred to add another pointer + num_channels
to chip_info.  Just add backend_channels, num_backend_channels or something like that.


> +		indio_dev->channels = ad7779_channels_filter_data;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels_filter_data);
> +	} else {
> +		indio_dev->channels = ad7779_channels_data;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels_data);
> +	}
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back)) {
> +		dev_err_probe(dev, ret, "failed to get iio backend");
> +		return PTR_ERR(st->back);
return dev_err_probe() key being that your message here has ret
different to what you return.

> +	}
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, 4);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
>  static int ad7779_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -760,8 +1009,8 @@ static int ad7779_probe(struct spi_device *spi)
>  	struct device *dev = &spi->dev;
>  	int ret = -EINVAL;
>  
> -	if (!spi->irq)
> -		return dev_err_probe(dev, ret, "DRDY irq not present\n");
> +	if (!spi->irq && !device_property_present(dev, "io-backends"))
> +		return dev_err_probe(dev, ret, "Either DRDY interrupt or io-backends property required\n");

Very long line. break before the string at least.

In the binding you aren't disallowing both the irq and io-backends.
That's fine but I wonder here if we should prioritize io-backends
if both are set? 

>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -804,49 +1053,12 @@ static int ad7779_probe(struct spi_device *spi)
>  		return ret;
>  
>  	indio_dev->name = st->chip_info->name;
> -	indio_dev->info = &ad7779_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
> -
> -	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> -					  iio_device_id(indio_dev));
> -	if (!st->trig)
> -		return -ENOMEM;
> -
> -	st->trig->ops = &ad7779_trigger_ops;
> -
> -	iio_trigger_set_drvdata(st->trig, st);
> -
> -	ret = devm_request_irq(dev, spi->irq, iio_trigger_generic_data_rdy_poll,
> -			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
> -			       st->trig);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> -				     st->spi->irq);
> -
> -	ret = devm_iio_trigger_register(dev, st->trig);
> -	if (ret)
> -		return ret;
> -
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -
> -	init_completion(&st->completion);
> -
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7779_trigger_handler,
> -					      &ad7779_buffer_setup_ops);
> -	if (ret)
> -		return ret;
>  
> -	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> -				    AD7779_DCLK_CLK_DIV_MSK,
> -				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
> -	if (ret)
> -		return ret;
> -
> -	return devm_iio_device_register(dev, indio_dev);

This call happens in bother cases. I'd be tempted to rename the functions
as setup_irq() / setup_back() and keep this call outside of either
function.

> +	if (spi->irq)
> +		return ad7779_register_irq(st, indio_dev);
> +	else
> +		return ad7779_register_back(st, indio_dev);
>  }



