Return-Path: <linux-iio+bounces-7968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55993DF59
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53719283823
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6258175F;
	Sat, 27 Jul 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe1lgLg6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503280C1C;
	Sat, 27 Jul 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083641; cv=none; b=cgCAmI/FZRjHb8+9A1PFimoQ/12DaOc44FjmgO2+CqNCohpRkx/FZ1cMK43GZXbyyCB3KhaTawMVTF4HLtQiLlXzFoSpWOG9rHnRK2M/vM+EJMuQpPP6TWLczKNDW32uN+Rt2lD7mX6H4o7qHRsV1hAFM/TD5ZcA+Amlj8fvteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083641; c=relaxed/simple;
	bh=gP3Cgwn2K1FsOLXTVKWMiwV0rMcPk/Bs69a5bD10uzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES3zWLogR+f+AxTw+TB0ZeW7QmELwOQqpvlOr49Gv4gkw9Jit6rlBy83KKyrEo3t5GzFgl72KVEE5ptecX8rewtnABsIEQpeczQ4qnExPSSiQLCBMZWvFZiuP8kTW501w2iIVmRzXwzpi3wIQrALupM1a2BumvhjUjQOr0LG1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe1lgLg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BDFC32781;
	Sat, 27 Jul 2024 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722083640;
	bh=gP3Cgwn2K1FsOLXTVKWMiwV0rMcPk/Bs69a5bD10uzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pe1lgLg6VXSzWo+Eg6GgtciyrvtBoDaE2tI949L2xJ4nsfK3EBRtM+Y3f0hal1El2
	 LPQV2pqZijq0Hz7G2FXy2/Ya+0J5jk5AOH1Koqwn1LVKSjuY3blsnDvqGTNhhep3Ls
	 4RnV3gy+Z5qWzgpy7Bnlx2WgMJhtymGESbMg3wFV8hqk3yMUxyxM0uxtiWAMtKo0QM
	 XEH7tyQzimZza6MGXlwounRExLSA7TGrgWNMxsmMxdn+8knp0Qz+DZc3Ydaec/NYHC
	 i1KAxoqCjIAXjjHvKSk6BsOy75eIIbAllnVUpwcBHlecpnB/knipcZ8dTD4BIzKnwa
	 7z5YR5ZNyhOFQ==
Date: Sat, 27 Jul 2024 13:33:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Dragos Bogdan" <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: frequency: adf4377: add adf4378 support
Message-ID: <20240727133352.549f48df@jic23-huawei>
In-Reply-To: <20240722134508.25234-2-antoniu.miclaus@analog.com>
References: <20240722134508.25234-1-antoniu.miclaus@analog.com>
	<20240722134508.25234-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 16:45:06 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add separate handling for adf4378 within the driver.
> 
> The main difference between adf4377 and adf4378 is that adf4378 has only
> one output which is handled by only one gpio.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Follow up comments on the v2 changes inline.

For future series, please always use a cover letter 
--cover-letter in git format-patch as it provides somewhere for general
comments and gives the series a nice name etc in patchwork.

Jonathan

> ---
> changes in v2:
>  - use chip_info structure to handle new added part (adf4378)
>  - use spi_get_device_match_data
>  - drop redundant check in if statement.
>  drivers/iio/frequency/adf4377.c | 36 ++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> index 9284c13f1abb..82374f5d2695 100644
> --- a/drivers/iio/frequency/adf4377.c
> +++ b/drivers/iio/frequency/adf4377.c
> @@ -400,7 +400,13 @@ enum muxout_select_mode {
>  	ADF4377_MUXOUT_HIGH = 0x8,
>  };
>  
> +struct adf4377_chip_info {
> +	const char *name;
> +	bool has_gpio_enclk2;
> +};
> +
>  struct adf4377_state {
> +	const struct adf4377_chip_info	*chip_info;
>  	struct spi_device	*spi;
>  	struct regmap		*regmap;
>  	struct clk		*clkin;
> @@ -889,11 +895,13 @@ static int adf4377_properties_parse(struct adf4377_state *st)
>  		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
>  				     "failed to get the CE GPIO\n");
>  
> -	st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
> -						  GPIOD_OUT_LOW);
> -	if (IS_ERR(st->gpio_enclk2))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
> -				     "failed to get the CE GPIO\n");
> +	if (st->chip_info->has_gpio_enclk2) {
> +		st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
> +							  GPIOD_OUT_LOW);
> +		if (IS_ERR(st->gpio_enclk2))
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
> +					"failed to get the CE GPIO\n");
> +	}
>  
>  	ret = device_property_match_property_string(&spi->dev, "adi,muxout-select",
>  						    adf4377_muxout_modes,
> @@ -921,6 +929,17 @@ static int adf4377_freq_change(struct notifier_block *nb, unsigned long action,
>  	return NOTIFY_OK;
>  }
>  
> +static const struct adf4377_chip_info adf4377_chip_info_tbl[] = {
See below on why an array is not useful here.

> +	{
> +		.name = "adf4377",
> +		.has_gpio_enclk2 = true,
> +	},
> +	{
> +		.name = "adf4378",
> +		.has_gpio_enclk2 = false,
> +	},
> +};
> +
>  static int adf4377_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -945,6 +964,7 @@ static int adf4377_probe(struct spi_device *spi)
>  
>  	st->regmap = regmap;
>  	st->spi = spi;
> +	st->chip_info = spi_get_device_match_data(spi);
>  	mutex_init(&st->lock);
>  
>  	ret = adf4377_properties_parse(st);
> @@ -964,13 +984,15 @@ static int adf4377_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id adf4377_id[] = {
> -	{ "adf4377", 0 },
> +	{ "adf4377", (kernel_ulong_t)&adf4377_chip_info_tbl[0] },
> +	{ "adf4378", (kernel_ulong_t)&adf4377_chip_info_tbl[1] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, adf4377_id);
>  
>  static const struct of_device_id adf4377_of_match[] = {
> -	{ .compatible = "adi,adf4377" },
> +	{ .compatible = "adi,adf4377", .data = &adf4377_chip_info_tbl[0] },
> +	{ .compatible = "adi,adf4378", .data = &adf4377_chip_info_tbl[1]},
We've been moving away from this use of an array because it means you then need
an enum to say which is which.  Better to just have two named structures
as then it's obvious which one is which.

adf4377_chip_info and adf4378_chip_info

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, adf4377_of_match);


