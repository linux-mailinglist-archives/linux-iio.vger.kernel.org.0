Return-Path: <linux-iio+bounces-7653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E05933A20
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 11:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3E41C227CC
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 09:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6044C76;
	Wed, 17 Jul 2024 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b026PwC1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBBB6BB5B;
	Wed, 17 Jul 2024 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209116; cv=none; b=di0ewUin3aa2+U3U63a1bhghG61pMvIuWJuBd81YcRAEhb+j7kCYVQBxc0is3cyDPx+5ZiSS5rDMwhnGNRopywRa5bu9HvHRT7goSU5nI0K2KAm56r8CosCjY6AM2tEBJyM1eckqeRBXGsh5jxLUdzCrA20Ry9tvP4kxoY+4VkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209116; c=relaxed/simple;
	bh=1guYZIYQNHhoKmLTIMKpaYvKahfTw5ESfPxUjAAS1OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sfozore0W4sqf8cBf/uXSH8zXPOuptk6eal0PFwVdxQLJpiVCDwm8+suMHA3+S75fJJy2lSmiBzhzdcpj/7qtdV2K+QWz2dy4MTJqEKwppv91zZDXIMnsq+VqmJLYZ8mF5DzajyU8V+dMubbFYHrook5PdZHeEaFDgJxfpOyzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b026PwC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415A3C4AF09;
	Wed, 17 Jul 2024 09:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721209115;
	bh=1guYZIYQNHhoKmLTIMKpaYvKahfTw5ESfPxUjAAS1OY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=b026PwC1pvgZZmxvYTXHl3PhkIJSL06DtTtcR+EBiH0GYyIR7vGS1BO9E57qSyjcx
	 z7U/64oOHnvCnnLNnwG2hT/mOKVhkWUXPtn1yPEWx7i4gBClKk7gbr2UjDfePTIaSk
	 SvujIlkvJv5JTvXEnXZti3bJCIhes+cRf4erkx/7cauPwQctsEIh5sKlHoi4VNpOHl
	 HldELZYMbYP9nNS6Tqz5kFVdNiR2mmFC21G4d+FSxnYiaDkRfnK+m4qmoiXWgZ7BTw
	 kNTvCPHk6l8tSRj6LZPDOUVAedKYxZh7lHHVP1hkMEVf/4nQsdQMfOKQ+OjZ+ViGRA
	 XufZPGOWTL30w==
Message-ID: <c26f39fc-94bd-40f2-9c3a-7075eb3e6dba@kernel.org>
Date: Wed, 17 Jul 2024 11:38:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: frequency: adf4377: add adf4378 support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dragos Bogdan <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240717093034.9221-1-antoniu.miclaus@analog.com>
 <20240717093034.9221-2-antoniu.miclaus@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240717093034.9221-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2024 11:30, Antoniu Miclaus wrote:
> Add separate handling for adf4378 within the driver.
> 
> The main difference between adf4377 and adf4378 is that adf4378 has only
> one output which is handled by only one gpio.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/frequency/adf4377.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> index 9284c13f1abb..e02298a8b47f 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -387,6 +387,11 @@
>  #define ADF4377_FREQ_PFD_250MHZ			(250 * HZ_PER_MHZ)
>  #define ADF4377_FREQ_PFD_320MHZ			(320 * HZ_PER_MHZ)
>  
> +enum adf4377_dev_type {
> +	ADF4377,
> +	ADF4378,
> +};
> +
>  enum {
>  	ADF4377_FREQ,
>  };
> @@ -402,6 +407,7 @@ enum muxout_select_mode {
>  
>  struct adf4377_state {
>  	struct spi_device	*spi;
> +	enum adf4377_dev_type	type;
>  	struct regmap		*regmap;
>  	struct clk		*clkin;
>  	/* Protect against concurrent accesses to the device and data content */
> @@ -687,7 +693,7 @@ static void adf4377_gpio_init(struct adf4377_state *st)
>  	if (st->gpio_enclk1)
>  		gpiod_set_value(st->gpio_enclk1, 1);
>  
> -	if (st->gpio_enclk2)
> +	if (st->gpio_enclk2 && st->type == ADF4377)

Why? Isn't everything correct for NULL?

>  		gpiod_set_value(st->gpio_enclk2, 1);
>  }
>  
> @@ -889,11 +895,13 @@ static int adf4377_properties_parse(struct adf4377_state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
>  				     "failed to get the CE GPIO\n");
>  
> -	st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
> -						  GPIOD_OUT_LOW);
> -	if (IS_ERR(st->gpio_enclk2))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
> -				     "failed to get the CE GPIO\n");
> +	if (st->type == ADF4377) {

So the device does not have this pin? Then you should express it in the
bindings.

> +		st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
> +							  GPIOD_OUT_LOW);
> +		if (IS_ERR(st->gpio_enclk2))
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
> +					"failed to get the CE GPIO\n");
> +	}
>  
>  	ret = device_property_match_property_string(&spi->dev, "adi,muxout-select",
>  						    adf4377_muxout_modes,
> @@ -945,6 +953,7 @@ static int adf4377_probe(struct spi_device *spi)
>  
>  	st->regmap = regmap;
>  	st->spi = spi;
> +	st->type = spi_get_device_id(spi)->driver_data;


spi_get_device_match_data()

>  	mutex_init(&st->lock);
>  
>  	ret = adf4377_properties_parse(st);
> @@ -964,13 +973,15 @@ static int adf4377_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id adf4377_id[] = {
> -	{ "adf4377", 0 },
> +	{ "adf4377", ADF4377 },
> +	{ "adf4378", ADF4378 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, adf4377_id);
>  
>  static const struct of_device_id adf4377_of_match[] = {
>  	{ .compatible = "adi,adf4377" },
> +	{ .compatible = "adi,adf4378" },

Your device ID tables have incoherent match data. Considering that one
type is 0, this is error-prone and discouraged.

Best regards,
Krzysztof


