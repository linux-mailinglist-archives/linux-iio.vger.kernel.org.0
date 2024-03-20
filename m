Return-Path: <linux-iio+bounces-3635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6050880EC3
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 10:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125B91C21E3F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Mar 2024 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50333B78B;
	Wed, 20 Mar 2024 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSEL64Yh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF732C60
	for <linux-iio@vger.kernel.org>; Wed, 20 Mar 2024 09:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927469; cv=none; b=NZ8cbsuvHTvlgnOo7xxTKYXm7HTFqWXfbplK0a008g488+X2qpgY6gIOuKg/HITyYInRIv4J07a6UVy1YuiaN3lSeWVWrcZLZppuAd3leJd5JCF4khCfd5FLajOvntjN2JKicyxzlW13rAkc+ovETYktO2pPJSPwtO1eH/j3M00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927469; c=relaxed/simple;
	bh=i/o5sRNIfaA5hJadnKQb+e+WdwHMkKnKubv664PT9M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ea7/iMFqXRq1anY44ekWJL2FfSuGus9ePw3OTFTL6saU6o6p0MEJIZaDQqCGtFXpv5uG5CHKdSSm02zIppkGpP25WL7Osqi1M0v8FzK+HzW5xu+UzXZmxpj7BFCSgG5d+zMohyLM4tZHISUFBNA5RqEZjbyj2t72kV5wq+dlUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSEL64Yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E86C433C7;
	Wed, 20 Mar 2024 09:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710927468;
	bh=i/o5sRNIfaA5hJadnKQb+e+WdwHMkKnKubv664PT9M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gSEL64YhZ9ncxgqEkm2QOmLNEK4niRX9UOpJ2nl+w5GnOWq+OSi0XtHSygAQueBoB
	 CCmyZB3R/Jbc6bcig5Yd7M2f8wyr4lvvjy86Ou8vqi1NEI4kPRGA+AYYXsyu3HXSBQ
	 yriT/VETvNiL9dEYbD908+qC1aG7rCBzN2XIpzFw1Q7yxb6TSS69SL/MkLkzm7O6uV
	 +U/tROhxJPNvYR+TM496eJiCu/h16EZRNiHYqlXDVdMjpMwyMk7VoPm5C/z/8l9ozs
	 Q1diaGDj8Bx/z9bW4k5q/giLy4/hgCzE3j/rYnNY6ZsNXsetkGituDf++JYG8J+4yk
	 Qhu/JVNjpP4NA==
Message-ID: <7f349041-bf2f-434d-a9cd-a82ac902f613@kernel.org>
Date: Wed, 20 Mar 2024 10:37:42 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adxl345: add spi-3wire
To: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, eraretuya@gmail.com
References: <20240319212713.257600-1-l.rubusch@gmail.com>
 <20240319212713.257600-2-l.rubusch@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240319212713.257600-2-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 22:27, Lothar Rubusch wrote:
> Adds the spi-3wire feature and adds general refactoring to the

Add

> iio driver.
> 
> The patch moves driver wide constants and fields into the

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> header. Thereby reduces redundant info struct definitions.
> Allows to pass a function pointer from SPI/I2C specific probe,
> and smaller refactorings. A regmap_update_bits() in the core
> file replaces the regmap_write() to format_data.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---



>  static int adxl345_spi_probe(struct spi_device *spi)
>  {
> +	const struct adxl345_chip_info *chip_data;
>  	struct regmap *regmap;
>  
> +	/* Retrieve device name to pass it as driver specific data */
> +	chip_data = device_get_match_data(&spi->dev);
> +	if (!chip_data)
> +		chip_data = (const struct adxl345_chip_info *) spi_get_device_id(spi)->driver_data;

Are you sure you need the cast?

And why aren't you using spi_get_device_match_data()?

> +
>  	/* Bail out if max_speed_hz exceeds 5 MHz */
>  	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
>  		return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz exceeds 5 MHz\n",
>  				     spi->max_speed_hz);
>  
>  	regmap = devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
> -	if (IS_ERR(regmap))
> -		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing spi regmap: %ld\n",
> +			      PTR_ERR(regmap));
> +		return PTR_ERR(regmap);

Why are you changing correct code into incorrect?

> +	}
>  
> -	return adxl345_core_probe(&spi->dev, regmap);
> +	return adxl345_core_probe(&spi->dev, regmap, chip_data, &adxl345_spi_setup);
>  }


Best regards,
Krzysztof


