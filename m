Return-Path: <linux-iio+bounces-20650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2BAD9CE6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82691176498
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953202D0270;
	Sat, 14 Jun 2025 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQvdIW2J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6C116A395;
	Sat, 14 Jun 2025 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749907672; cv=none; b=U9oKlAwf8Abwt2zUQvg6VP9uCeCaLG+thCox2AkbuaAXD45PC81lwIHqiFbbdEbQeaCHn9x6rPXuSRrO1coUSpbB1q83vbokkirv5lV29uwKXK1zhKBzN3JZHVqKfgRwAtXvD/+SiKm+M4iu6/G0RaeJ80f3zJQhna3yISMWU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749907672; c=relaxed/simple;
	bh=ZHg8AahqkLokOXoKlKF4BfRQe1SR6DS8X5OqUQB/c5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZKAzaTGjpjvb7MVkmy9zUCQtJYllkE9Awx9/EAH60g9bvAA02n32F4hpOl8/MhqHTtz2/4wCxS+f31YCByCEm8YuwqjGZdKj47PcK2xGvdFi6nIebPGLkigC/rsg/vQsYTXyBSYrp4FRMEPsFiR/6YXjn3ZF/r8rJnRX81n2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQvdIW2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30994C4CEEB;
	Sat, 14 Jun 2025 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749907671;
	bh=ZHg8AahqkLokOXoKlKF4BfRQe1SR6DS8X5OqUQB/c5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iQvdIW2Jac9gkyaMr6NIxt7tDiczBb9X8YhgGnsuEWPKzr7xKnmXX4ng8Pe4Sc17D
	 cTp2v+lli18r0JGvBS4gO+naoB/hPsfQraAzsyAPGuPDlL8LlmlaB5aLxX/c/+kcXI
	 cbgMOK1sqrJzKRISYZQ46/MCMm7/w/dkhzjfQfEhlczaFIReiATUJqQovzsrEB6mQj
	 QkL34+lwmoHYrixMIPRDN0HiYLqes950lwm4tR5pdk/t+4E3oq6w7xtt+CDkyfecFu
	 pBnkTIxpJRYunmvsmdkp/RzLQIer5W8HHFFkmPaZBlR8wzbvCdvltlHAEchujbABX3
	 dKk/UZJ4tQpRA==
Date: Sat, 14 Jun 2025 14:27:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>, Nishanth Menon
 <nm@ti.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: adc: ti-adc128s052: Use shift and realbits
Message-ID: <20250614142743.23ee2203@jic23-huawei>
In-Reply-To: <20250614091504.575685-3-sbellary@baylibre.com>
References: <20250614091504.575685-1-sbellary@baylibre.com>
	<20250614091504.575685-3-sbellary@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 02:15:01 -0700
Sukrut Bellary <sbellary@baylibre.com> wrote:

> This adcxx communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12-bit data, of which the LSB bits
> are transmitted by the lower resolution devices as 0. The unavailable bits are
> 0 in LSB. Shift is calculated per resolution and used in scaling and raw data
> read.
> 
> Create a separate structure for each device type instead of an array.
> These changes help to reuse the driver to support the family of devices with
> name ADC<bb><c>S<sss>, where
> * bb is the resolution in number of bits (8, 10, 12)
> * c is the number of channels (1, 2, 4, 8)
> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> and 101 for 1 MSPS)
> 
> Complete datasheets are available at TI's website here:
> https://www.ti.com/lit/ds/symlink/adc<bb><c>s<sss>.pdf
> 
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> ---
>  drivers/iio/adc/ti-adc128s052.c | 115 ++++++++++++++++++--------------
>  1 file changed, 66 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 1b46a8155803..2b206745e53d 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -41,13 +41,14 @@ struct adc128 {
>  	} __aligned(IIO_DMA_MINALIGN);
>  };
>  
> -static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
> +static int adc128_adc_conversion(struct adc128 *adc,
> +				 struct iio_chan_spec const *channel)
>  {
>  	int ret;
>  
>  	guard(mutex)(&adc->lock);
>  
> -	adc->buffer[0] = channel << 3;
> +	adc->buffer[0] = channel->channel << 3;
>  	adc->buffer[1] = 0;
>  
>  	ret = spi_write(adc->spi, &adc->buffer, sizeof(adc->buffer));
> @@ -58,7 +59,10 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  	if (ret < 0)
>  		return ret;
>  
> -	return be16_to_cpu(adc->buffer16) & 0xFFF;
> +	ret = (be16_to_cpu(adc->buffer16) >> channel->scan_type.shift) &
> +	       GENMASK(channel->scan_type.realbits - 1, 0);
> +
Even though it is a bit long I'd go with

	return (be16_to_cpu(adc->buffer16) >> channel->scan_type.shift) &
		GENMASK();

> +	return ret;
>  }
>  
>  static int adc128_read_raw(struct iio_dev *indio_dev,
> @@ -71,7 +75,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  
> -		ret = adc128_adc_conversion(adc, channel->channel);
> +		ret = adc128_adc_conversion(adc, channel);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -81,7 +85,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  
>  		*val = adc->vref_mv;
> -		*val2 = 12;
> +		*val2 = channel->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
>  	default:
> @@ -90,15 +94,24 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  
>  }
>  
> -#define ADC128_VOLTAGE_CHANNEL(num)	\
> -	{ \
> -		.type = IIO_VOLTAGE, \
> -		.indexed = 1, \
> -		.channel = (num), \
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
> +#define _ADC128_VOLTAGE_CHANNEL(num, real_bits)				\
> +	{								\

I would minimise the churn and stick to existing style of one space then \
I don't think we have any specific style guidance around this.

> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (num),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = (num),					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = (real_bits),			\
> +			.storagebits = 16,				\
> +			.shift = (12 - real_bits),			\
> +		},							\
>  	}
>  
> +#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12)

I wonder if it would be clearer to just have the 12 explicit in each entry
and skip this two levels of macro thing?

> +
>  static const struct iio_chan_spec adc128s052_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(0),
>  	ADC128_VOLTAGE_CHANNEL(1),
> @@ -124,26 +137,30 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>  
>  static const char * const bd79104_regulators[] = { "iovdd" };
>  
> -static const struct adc128_configuration adc128_config[] = {
> -	{
> -		.channels = adc128s052_channels,
> -		.num_channels = ARRAY_SIZE(adc128s052_channels),
> -		.refname = "vref",
> -	}, {
> -		.channels = adc122s021_channels,
> -		.num_channels = ARRAY_SIZE(adc122s021_channels),
> -		.refname = "vref",
> -	}, {
> -		.channels = adc124s021_channels,
> -		.num_channels = ARRAY_SIZE(adc124s021_channels),
> -		.refname = "vref",
> -	}, {
> -		.channels = adc128s052_channels,
> -		.num_channels = ARRAY_SIZE(adc128s052_channels),
> -		.refname = "vdd",
> -		.other_regulators = &bd79104_regulators,
> -		.num_other_regulators = 1,
> -	},
> +static const struct adc128_configuration adc122s021_config = {
> +	.channels = adc122s021_channels,
> +	.num_channels = ARRAY_SIZE(adc122s021_channels),
> +	.refname = "vref",
> +};

Ideal would be to have this as a precursor patch rather than adding complexity
to this one which is focused on the bits related stuff.

It's a good change to have but does make it harder to spot the main
content in here.


> +
> +static const struct adc128_configuration adc124s021_config = {
> +	.channels = adc124s021_channels,
> +	.num_channels = ARRAY_SIZE(adc124s021_channels),
> +	.refname = "vref",
> +};


