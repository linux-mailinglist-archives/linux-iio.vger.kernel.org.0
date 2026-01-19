Return-Path: <linux-iio+bounces-27971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C831D3ACC8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3719B304D4B9
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CB137E2F8;
	Mon, 19 Jan 2026 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhtBPEhu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417123D7E0;
	Mon, 19 Jan 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833931; cv=none; b=WQYCXz8tVTiHXpGwrHjtJWrwLMn3fPyCdRXUaPOtyRMiYJ8eUnwqiX8XbpGEd5OXpBlpSmw8MBBbjHO9iT3t+xXz/fOFMScAPazdXqJDb6iHAdrd/pb0IeGML3fR+tZu9zAY0ucu7hZaQV+0bZCF8/UB1c9x2GHRuiwR62Jb9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833931; c=relaxed/simple;
	bh=3GTGKDDnP7XCjEX+FxD5k5nZjD6jo9PGJKQU43xseE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX9BR5+yPKNRwcwOor2WWRjD0Hpq85Kx9JMU5SxbThbXAqaSolmEQjwNl/mBxxoUEpKhhP1zw6sv7O6eo7MvftVsIttCe8OxWw2pV81C4LNSUAq0r2z8If3GdY9asJD+6Ni516OmFh+QRgl2My/xLHlBPGfhqqTcxvohSD6JfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhtBPEhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FC2C116C6;
	Mon, 19 Jan 2026 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833931;
	bh=3GTGKDDnP7XCjEX+FxD5k5nZjD6jo9PGJKQU43xseE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lhtBPEhuSJsFp9fSgiU/h4WliHmweyxFdhdAjBpZ5lwnq1b91TYgSxhSW7mK9aveM
	 sNw6eRQjypQtyQMtiS9Od4a/8HLAZeD5wnXZWZntpMb7VxVVPhxGiY44sSp6+Ox/cm
	 xPRcfVqxAMb73R80CrdQ4Fd/ILH1pukOtRipZlovvSUmde2SN/1T6xF4rUtWfZmvUC
	 +bN3sSF/r3VactlLoXpq/U7MnNYMtMTtLBuSu8NT+UPgiFGQZz8cZdNRhBhp+2XUmw
	 ns2c4eSWvjtLWeUBa3WGECYNn1zd9Mx9hED541ecNcnPUmWbkbcsLhrPwMO+UcUvmE
	 bf9qDOAC7q0lg==
Message-ID: <836b3f85-1ba3-4d49-b027-06990325fc4d@kernel.org>
Date: Mon, 19 Jan 2026 15:45:26 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] iio: amplifiers: ad8366: simplify resource management
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
 <20260119-iio-ad8366-update-v1-6-8044e23e964a@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260119-iio-ad8366-update-v1-6-8044e23e964a@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 15:37, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Device resource managed simplified with:

Use more readable style.
https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94

> - voltage regulator managed internally by the device.
> - IIO device registration handled with devm_iio_device_register().
> - removal of goto's from the probe function.
> - ad8366_remove() removed as it is not needed anymore.
> 
> Also, dev_err_probe() is used to report probe errors with created local
> device pointer.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/amplifiers/ad8366.c | 68 +++++++++++------------------------------
>  1 file changed, 18 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 26856cb4216e..d3fd8d44eae7 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -53,7 +53,6 @@ struct ad8366_info {
>  
>  struct ad8366_state {
>  	struct spi_device	*spi;
> -	struct regulator	*reg;
>  	struct mutex            lock; /* protect sensor state */
>  	struct gpio_desc	*reset_gpio;
>  	struct gpio_desc	*enable_gpio;
> @@ -321,26 +320,22 @@ static int ad8366_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ad8366_state *st;
> +	struct device *dev = &spi->dev;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -
> -	st->reg = devm_regulator_get(&spi->dev, "vcc");
> -	if (!IS_ERR(st->reg)) {
> -		ret = regulator_enable(st->reg);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	spi_set_drvdata(spi, indio_dev);
>  	st->spi = spi;
>  	st->type = spi_get_device_id(spi)->driver_data;
>  
> -	ret = devm_mutex_init(&spi->dev, &st->lock);

No need to change the line twice. Just use dev in previous commit. Or
re-order commits.

> +	ret = devm_regulator_get_enable(dev, "vcc");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulator\n");
> +
> +	ret = devm_mutex_init(dev, &st->lock);
>  	if (ret)
>  		return ret;
>  
> @@ -359,25 +354,21 @@ static int ad8366_probe(struct spi_device *spi)
>  	case ID_ADRF5731:
>  	case ID_HMC1018:
>  	case ID_HMC1019:
> -		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
> -		if (IS_ERR(st->reset_gpio)) {
> -			ret = PTR_ERR(st->reset_gpio);
> -			goto error_disable_reg;
> -		}
> +		st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +		if (IS_ERR(st->reset_gpio))
> +			return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
> +					     "Failed to get reset GPIO\n");
>  
> -		st->enable_gpio = devm_gpiod_get_optional(&spi->dev, "enable", GPIOD_OUT_HIGH);
> -		if (IS_ERR(st->enable_gpio)) {
> -			ret = PTR_ERR(st->enable_gpio);
> -			goto error_disable_reg;
> -		}
> +		st->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);

You just added these lines before. Cleanups always go BEFORE new
feature. Always.

> +		if (IS_ERR(st->enable_gpio))
> +			return dev_err_probe(dev, PTR_ERR(st->enable_gpio),
> +					     "Failed to get enable GPIO\n");
>  
>  		indio_dev->channels = ada4961_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
>  		break;
>  	default:
> -		dev_err(&spi->dev, "Invalid device ID\n");
> -		ret = -EINVAL;
> -		goto error_disable_reg;
> +		return dev_err_probe(dev, -EINVAL, "Invalid device ID\n");
>  	}
>  
>  	st->info = &ad8366_infos[st->type];
> @@ -387,31 +378,9 @@ static int ad8366_probe(struct spi_device *spi)
>  
>  	ret = ad8366_write(indio_dev, 0, 0);
>  	if (ret < 0)
> -		goto error_disable_reg;
> +		return dev_err_probe(dev, ret, "failed to write initial gain\n");
>  
Best regards,
Krzysztof

