Return-Path: <linux-iio+bounces-22503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA732B1F613
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 21:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDF018C07E3
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1300A279DA0;
	Sat,  9 Aug 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW3Ki4is"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABB12E1CD;
	Sat,  9 Aug 2025 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754768910; cv=none; b=XOIaRN82hVbSbLB1ZDkvtfOEcanljNBF7mgy1nxYPJNUQbNeeDLqciTJ7Ij++cTQAQlYceU/Ahmxw+QnZBTvuc9w2rRdpPFNYcb2ZtniwmN0ncv529IQoBW5ke9R6UbVir/J20MYVs0lR98aEMiRTfVhMjODeh9yuOUoAGcP87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754768910; c=relaxed/simple;
	bh=kZKOnWSmfiYKAbhxP9TeIj78E+X0219vt+YwRgx5caA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oE5c3s9sTxtbAT3E0lmxrNd2ek0fyTgYHjFHPbIHKTT75LMC6oLQqcYm+Yith1bQvK0gFNRGJfeL3EbdkknTh69i/CLzN9+GiD/dtsMCFBiYUXguG+AG4RXVQsbb3iDaNS1Com+g6SXxO4zcJGZ3kJbwzlBskAPN5w0sxp1poVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW3Ki4is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6F0C4CEE7;
	Sat,  9 Aug 2025 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754768910;
	bh=kZKOnWSmfiYKAbhxP9TeIj78E+X0219vt+YwRgx5caA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GW3Ki4iswX83edgSTiywebaP2Tkoq9Z/2Z2cBdYlFoSW+sYXn4P4Cw7L3Laar0hCM
	 DYcge4uPqn4WvBxIqLMNo70w6vHYnY0wT3dWcrS9c5lr1XnTXNE7OqH7+2GeNurYA6
	 eUV2duYEEcyZ6u73hkDCEK2yvOHHOwgpJxE4P8R+16zfXo2j8rw/p63i4Ycr6gG4aG
	 fPDC6SRbXu1zZvOBaWskAwuNuluH5Bu5dyKSCnZneaiZaVu0jpRonJWdX3SVuNA4E0
	 lbG22aHZe5ke/I5xzQF5RlxfuSOW3lVnxG58G3Y/3TQ712FLJWKPU76y4Ma+1H8sbc
	 gsrXDlGLlcZiA==
Date: Sat, 9 Aug 2025 20:48:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ramona Nechita
 <ramona.nechita@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: adc: update ad7779 to use IIO backend
Message-ID: <20250809204820.3e0893fc@jic23-huawei>
In-Reply-To: <20250806192502.10120-4-Ioana.Risteiu@analog.com>
References: <20250806192502.10120-1-Ioana.Risteiu@analog.com>
	<20250806192502.10120-4-Ioana.Risteiu@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 22:25:00 +0300
Ioana Risteiu <Ioana.Risteiu@analog.com> wrote:

> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
Hi Ionna,

>  
> +static int ad7779_set_data_lines(struct iio_dev *indio_dev,
> +				 unsigned int num_lanes)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_set_sampling_frequency(st, num_lanes * AD7779_DEFAULT_SAMPLING_1LINE);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, num_lanes);
> +	if (ret)
> +		return ret;
> +
> +	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DOUT_FORMAT_MSK,
> +				    FIELD_PREP(AD7779_DOUT_FORMAT_MSK, 2 - ilog2(num_lanes)));
> +}
> +
> +static int ad7779_conf_channels(struct iio_dev *indio_dev, const struct ad7779_state *st)

As per other branch of thread.  This needs a name that makes it more
obvious it's a probe time setup rather that anything to do with configuring
channels at runtime.

> +{
> +	struct iio_chan_spec *channels;
> +	struct device *dev = &st->spi->dev;
> +	int num_channels = ARRAY_SIZE(ad7779_channels);
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
devm_kmemdup_array()?

> +	if (!channels)
> +		return -ENOMEM;
> +
> +	memcpy(channels, st->chip_info->channels, num_channels * sizeof(struct iio_chan_spec));
> +
> +	for (int i = 0; i < 8; i++)

Andy got this, but make sure to get that 8 from somewhere. It's num_channels I think. 
Though given most of this code collapses into a single call to devm_kmemdup_array()
I think that local variable may not make much sense. ARRAY_SIZE may be clearer.

> +		channels[i].scan_type.endianness = IIO_CPU;
> +
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +}
> +
> +static int setup_irq(struct ad7779_state *st, struct iio_dev *indio_dev)

As below. Do this in a precursor patch and give it a better name!
Pretty much everything in IIO driver gets namespaced with a driver
specific prefix. Makes future problems with new generic functions
much less likely and makes it clear what is local to the driver.

> +{
> +	int ret;
> +	struct device *dev = &st->spi->dev;
> +
> +	indio_dev->info = &ad7779_info;
> +	indio_dev->channels = st->chip_info->channels;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7779_trigger_ops;
> +
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
> +			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
> +			       st->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> +					st->spi->irq);
> +
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	init_completion(&st->completion);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad7779_trigger_handler,
> +					      &ad7779_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));

return ad7779_spi_write_mask...

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int setup_back(struct ad7779_state *st, struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret = -EINVAL;
> +	int num_lanes;
> +
> +	indio_dev->info = &ad7779_info_data;
> +
> +	ret = ad7779_conf_channels(indio_dev, st);
> +	if (ret)
> +		return ret;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back)) {
> +		dev_err_probe(dev, ret, "failed to get iio backend");
ret == 0 which isn't what you want.
> +		return PTR_ERR(st->back);

I think Andy pointed this out as well.  I'm not being too careful to not
duplicate unless I happen to remember he covered something in the earlier
review.

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
> +	ret = device_property_read_u32(dev, "adi,num-lanes", &num_lanes);
> +	if (ret < 0)

Whilst it's a bit fiddly as this is an array read underneath, the fact
num_lanes is not null is enough to ensure if (ret) is fine here.

> +		return ad7779_set_data_lines(indio_dev, 4);
> +
> +	return ad7779_set_data_lines(indio_dev, num_lanes);
> +}
> +
>  static int ad7779_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -760,9 +917,6 @@ static int ad7779_probe(struct spi_device *spi)
>  	struct device *dev = &spi->dev;
>  	int ret = -EINVAL;
>  
> -	if (!spi->irq)
> -		return dev_err_probe(dev, ret, "DRDY irq not present\n");
> -
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -804,45 +958,14 @@ static int ad7779_probe(struct spi_device *spi)
>  		return ret;
>  
>  	indio_dev->name = st->chip_info->name;
> -	indio_dev->info = &ad7779_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
>  
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
> +	if (device_property_present(dev, "io-backends"))
> +		ret = setup_back(st, indio_dev);
> +	else
> +		ret = setup_irq(st, indio_dev);

Do the factoring out of the setup_irq stuff in a precursor patch.
Then this one will just make it conditional as part of adding the new backend stuff.

setup_irq isn't a good name. It does a bunch of things that aren't
directly related to the irq.  Prefix the function as well
ad7779_setup_without_backend() maybe?


>  
> -	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> -				    AD7779_DCLK_CLK_DIV_MSK,
> -				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
>  	if (ret)
>  		return ret;
>  
> @@ -936,3 +1059,4 @@ module_spi_driver(ad7779_driver);
>  MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");


