Return-Path: <linux-iio+bounces-21132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F23AECF38
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10991895B1D
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845E923535F;
	Sun, 29 Jun 2025 17:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEUys3K7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB428FD;
	Sun, 29 Jun 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751218107; cv=none; b=BvFQZdOAtF0yb+Zalrt8LXlK2V/9IJEkHpZe+QqsOdh7qb7YOgZyGTalifn1Pd23v+dnPlBqzg37pYErI8wn7LiwHNX3eRQqWv4hpYXv1FR3nMwrz4fQu/PXMCd+4yvQvyeZH84rb7Th2IDwb6UrawAcAOFM8WY47K6Zf/8fRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751218107; c=relaxed/simple;
	bh=O5yjqg5YWrtKNRQNaZW2DZQGkzNgZgDKcCr4ArjY1yM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wj9im4/GyxdndQ/Mvtx6A1wjaOatl0/cXWsffHYg+/BIYEOk76AQPxrO+CuqEJUgOaBLeDn8aSHpaG/QpBd9OJYXSPkBI27a5Uy4yyD0qXwx6dbhVfBeWvgdhY0bu5F76xS8QDgzoeipmSjOMgZUF5LisvljZTFNqJw3Mqlp8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEUys3K7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A92C4CEEB;
	Sun, 29 Jun 2025 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751218106;
	bh=O5yjqg5YWrtKNRQNaZW2DZQGkzNgZgDKcCr4ArjY1yM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eEUys3K7gTYYLHjAGlRFCWC2mP0WgTBrxW+iqLxnyVs6bvdg8aA3QKHzcFrP95eTO
	 QLf5VkeNqVa9UVgGjcbD3sPVaNtM393TpQf/YHGtcXZBrmF2wcqxjBNXHT7MM4mUzD
	 qZfwQrNHEsqbDNYWDKJC4eAl9KcoQAOLbBJsD2TzOxiAxGuhalolzECw0vfz91c8a9
	 l0P/8toGMh/UZ/eJez1RzKfF0BNysd/awGePSXuYODPgRuJVmlDLlNeyIKf//PRijy
	 +E1tZRyX1Sy9lk/Tdyw2SlPbppzIFpq22f8/6aYKVEX1HnUrA5JG6uG7el2COiamZ0
	 63nUVZr358K+Q==
Date: Sun, 29 Jun 2025 18:28:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-adc081c: drop use of model array
Message-ID: <20250629182822.0d572b17@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-11-v1-1-268189459192@baylibre.com>
References: <20250628-iio-const-data-11-v1-1-268189459192@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:47:53 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change the ti-adc081c driver to use individual model structures instead
> of an array. This reduces the verbosity of the code. Also, the data is
> now const as it should have been in the first place.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-adc081c.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 4f514db5c26ea803660087ae02b2cf8ec71911e4..c09f41e8867c45a44a98f4409946c3256d34280f 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -112,18 +112,9 @@ DEFINE_ADCxx1C_CHANNELS(adc081c,  8);
>  DEFINE_ADCxx1C_CHANNELS(adc101c, 10);
>  DEFINE_ADCxx1C_CHANNELS(adc121c, 12);
>  
> -/* Model ids are indexes in _models array */
> -enum adcxx1c_model_id {
> -	ADC081C = 0,
> -	ADC101C = 1,
> -	ADC121C = 2,
> -};
> -
> -static struct adcxx1c_model adcxx1c_models[] = {
> -	ADCxx1C_MODEL(adc081c,  8),
> -	ADCxx1C_MODEL(adc101c, 10),
> -	ADCxx1C_MODEL(adc121c, 12),
> -};
> +static const struct adcxx1c_model adc081c_model = ADCxx1C_MODEL(adc081c,  8);
> +static const struct adcxx1c_model adc101c_model = ADCxx1C_MODEL(adc101c, 10);
> +static const struct adcxx1c_model adc121c_model = ADCxx1C_MODEL(adc121c, 12);

Is the macro actually worth while to just set two named elements?

static const struct adcxx1c_model adc081c_model = {
	.channels = adc081c_channels,
	.bits = 8,
};

static const struct adcxx1c_model adc101c_model = {
	.channels = adc101c_channels,
	.bits = 10,
};
etc are more readable to my eyes.


>  
>  static const struct iio_info adc081c_info = {
>  	.read_raw = adc081c_read_raw,
> @@ -203,24 +194,24 @@ static int adc081c_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id adc081c_id[] = {
> -	{ "adc081c", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
> -	{ "adc101c", (kernel_ulong_t)&adcxx1c_models[ADC101C] },
> -	{ "adc121c", (kernel_ulong_t)&adcxx1c_models[ADC121C] },
> +	{ "adc081c", (kernel_ulong_t)&adc081c_model },
> +	{ "adc101c", (kernel_ulong_t)&adc101c_model },
> +	{ "adc121c", (kernel_ulong_t)&adc121c_model },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adc081c_id);
>  
>  static const struct acpi_device_id adc081c_acpi_match[] = {
>  	/* Used on some AAEON boards */
> -	{ "ADC081C", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
> +	{ "ADC081C", (kernel_ulong_t)&adc081c_model },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
>  
>  static const struct of_device_id adc081c_of_match[] = {
> -	{ .compatible = "ti,adc081c", .data = &adcxx1c_models[ADC081C] },
> -	{ .compatible = "ti,adc101c", .data = &adcxx1c_models[ADC101C] },
> -	{ .compatible = "ti,adc121c", .data = &adcxx1c_models[ADC121C] },
> +	{ .compatible = "ti,adc081c", .data = &adc081c_model },
> +	{ .compatible = "ti,adc101c", .data = &adc101c_model },
> +	{ .compatible = "ti,adc121c", .data = &adc121c_model },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adc081c_of_match);
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-11-1c6b9e28aded
> 
> Best regards,


