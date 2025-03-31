Return-Path: <linux-iio+bounces-17424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D12A764E4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 13:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA077A23D4
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915A1E1C36;
	Mon, 31 Mar 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q90DRg5I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B71DF738;
	Mon, 31 Mar 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420178; cv=none; b=hnr2vVK44MoTuPNikoc7kDY9X9T1WK9KiUTBiyEvzEpu4cr6NfSsehQQVIzL7dT+TUCQveVRHGWgQQKyWbHy6xoO90HN8aDPkDKn3doN1PB0fPLT8v9pQk5mQflfJI/YPnVDWtfyVvmhVI4Fd+z515K0uvUdtYzhCqUptQULVSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420178; c=relaxed/simple;
	bh=+rM7H87bGjZOkexSahbMGJkksOwLNre4F+yLSRfdliM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2zCj4oneEYTE6AJ/n3aYFdEvxIYVooMkU1lCt++chyL+nCo0l50Fk8W8oGrbVCtNGw4rxzAq0euW2cump5VmxkTOgZ5QibOmJWdmTCr/jQ0sPwJsKzwKLc7DBJHQCB4DtTGwsOrfJgoCrE+x7Dj62BuWmJA5tfwupAJe+GGvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q90DRg5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD07DC4CEE3;
	Mon, 31 Mar 2025 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743420177;
	bh=+rM7H87bGjZOkexSahbMGJkksOwLNre4F+yLSRfdliM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q90DRg5IDDTHjxDPYNBUJRT7Tub/qoBUGW3Ci79Rv+2hTDAiNNwup+0VOa7+V33Se
	 jV8MO8FYKXsHkmL6iQfMvNfc0DZjbbfAxwD79+4/FtmK5UNjPbRQsmMTU1OqsYksqo
	 5AIXoDG/vg9rqb8nnI6H3Qf7YKZ4WplrTAOUdP59q7WAHgUIyQTWghBrpcHs9ApfCx
	 MdiZK6U2BB6T1JC2Y/SEz1v7Yryp93w20yVd/ZvW63MEz9k172Kp3EC9Bp3rx79HRQ
	 CCyXS6+rZe0/0O4EZS9QwuXFyKcpWoNKyISarZQo3TrEExGMQPB2hh29UeM5AcOGD9
	 XDEZc6UeGSrxw==
Date: Mon, 31 Mar 2025 12:22:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: adc: ti-adc128s052: Support ROHM BD79104
Message-ID: <20250331122247.05c6b09d@jic23-huawei>
In-Reply-To: <8e10f2d82362ca7c207324a5a97bb1759581acea.1742474322.git.mazziesaccount@gmail.com>
References: <cover.1742474322.git.mazziesaccount@gmail.com>
	<8e10f2d82362ca7c207324a5a97bb1759581acea.1742474322.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 11:03:58 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79104 ADC has identical SPI communication logic as the
> ti-adc128s052. Eg, SPI transfer should be 16 clk cycles, conversion is
> started when the CS is pulled low, and channel selection is done by
> writing the channel ID after two zero bits. Data is contained in
> big-endian format in the last 12 bits.

Nicely found match.  Sometimes these are tricky to spot.

> 
> The BD79104 has two input voltage pins. Data sheet uses terms "vdd" and
> "iovdd". The "vdd" is used also as an analog reference voltage. Hence
> the driver expects finding these from the device-tree, instead of having
> the "vref" only as TI's driver.
> 
> NOTE: The TI's data sheet[1] does show that the TI's IC does actually
> have two voltage inputs as well. Pins are called Va (analog reference)
> and Vd (digital supply pin) - but I keep the existing driver behaviour
> for the TI's IC "as is", because I have no HW to test changes, and
> because I have no real need to touch it.
> 
> NOTE II: The BD79104 requires SPI MODE 3.
> 
> NOTE III: I used evaluation board "BD79104FV-EVK-001" made by ROHM. With
> this board I had to drop the SPI speed below the 20M which is mentioned
> in the data-sheet [2]. This, however, may be a limitation of the EVK
> board, not the component itself.
> 
> [1]: https://www.ti.com/lit/ds/symlink/adc128s052.pdf
> 
> [2]:
> https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter/dac/bd79104fv-la-e.pdf
> 
Prefer Datasheet tags with # [1] 
after them for the cross references.  

Those belong here in the tag block (no blank lines)
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

One request for an additional cleanup precursor patch given you are
touching the relevant code anyway.   It's a small one that you can
test so hope you don't mind doing that whilst here.

I'm relying on the incredibly small chance anyone has a variable
regulator wired up to the reference that they are modifying at runtime.
I have seen that done (once long ago on a crazy dev board for a really
noisy humidity sensor) when the reference was VDD but not on a separate
reference pin.  That means we almost certainly won't break the existing
parts and can't have a regression on your new one so we should be fine
to make the change.

Thanks,

Jonathan

> 
> ---
> ---
>  drivers/iio/adc/Kconfig         |  2 +-
>  drivers/iio/adc/ti-adc128s052.c | 40 +++++++++++++++++++++++++++++----
>  2 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..148a52b3db94 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1425,7 +1425,7 @@ config TI_ADC128S052
>  	depends on SPI
>  	help
>  	  If you say yes here you get support for Texas Instruments ADC128S052,
> -	  ADC122S021 and ADC124S021 chips.
> +	  ADC122S021, ADC124S021 and ROHM Semiconductor BD79104 chips.
>  
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc128s052.
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index c68ee4e17a03..c7283d606d2e 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -21,6 +21,9 @@
>  struct adc128_configuration {
>  	const struct iio_chan_spec	*channels;
>  	u8				num_channels;
> +	const char			*refname;
> +	int				num_other_regulators;
> +	const char * const		(*other_regulators)[];
>  };
>  
>  struct adc128 {
> @@ -119,10 +122,28 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(3),
>  };
>  
> +static const char * const bd79104_regulators[] = { "iovdd" };
> +
>  static const struct adc128_configuration adc128_config[] = {
> -	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
> -	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
> -	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
> +	{
> +		.channels = adc128s052_channels,
> +		.num_channels = ARRAY_SIZE(adc128s052_channels),
> +		.refname = "vref",
> +	}, {
> +		.channels = adc122s021_channels,
> +		.num_channels = ARRAY_SIZE(adc122s021_channels),
> +		.refname = "vref",
> +	}, {
> +		.channels = adc124s021_channels,
> +		.num_channels = ARRAY_SIZE(adc124s021_channels),
> +		.refname = "vref",
> +	}, {
> +		.channels = adc128s052_channels,
> +		.num_channels = ARRAY_SIZE(adc128s052_channels),
> +		.refname = "vdd",
> +		.other_regulators = &bd79104_regulators,
> +		.num_other_regulators = 1,
> +	},
>  };
>  
>  static const struct iio_info adc128_info = {
> @@ -157,7 +178,7 @@ static int adc128_probe(struct spi_device *spi)
>  	indio_dev->channels = config->channels;
>  	indio_dev->num_channels = config->num_channels;
>  
> -	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	adc->reg = devm_regulator_get(&spi->dev, config->refname);

Hmm. It is very unusual for a reference regulator to be variable
after power up.  As such, maybe refactor the driver to use
devm_regulator_get_enable_read_voltage() which will save a few lines of
code and generally be easier to read.

That would need to be a separate precursor patch though.


>  	if (IS_ERR(adc->reg))
>  		return PTR_ERR(adc->reg);
>  
> @@ -169,6 +190,15 @@ static int adc128_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	if (config->num_other_regulators) {
> +		ret = devm_regulator_bulk_get_enable(&spi->dev,
> +						config->num_other_regulators,
> +						*config->other_regulators);
> +		if (ret)
> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to enable regulators\n");
> +	}
> +
>  	devm_mutex_init(&spi->dev, &adc->lock);
>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);
> @@ -182,6 +212,7 @@ static const struct of_device_id adc128_of_match[] = {
>  	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
>  	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
>  	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> +	{ .compatible = "rohm,bd79104", .data = &adc128_config[3] },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);
> @@ -194,6 +225,7 @@ static const struct spi_device_id adc128_id[] = {
>  	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
>  	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
>  	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> +	{ "bd79104", (kernel_ulong_t)&adc128_config[3] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);


