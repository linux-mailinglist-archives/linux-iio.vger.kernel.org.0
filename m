Return-Path: <linux-iio+bounces-18426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97814A95104
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8280D3A969A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CB1264F9A;
	Mon, 21 Apr 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geC/2wbw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDF2263F3A;
	Mon, 21 Apr 2025 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238871; cv=none; b=hCFXFXe0zyIxmMbNTSZHF1H031FFwA/ouCkcQh7fFLiK7sVoGNHasQLGDLJ9bTexu8wkEtHjgTmObsboJlpNQoPqYff29WogPUJ2Bb4J97ljuGmeqzjQIyx3aEZJLCzngsGM7MC5QxUwaeszHzM7iAwpMlV+ArPUztjpkDx1sqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238871; c=relaxed/simple;
	bh=xrauOpA4/vhOQFxpBIPOet7Xc8Z+xF1XZzZkt6m+Ot0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUfM2ZY3a5E65Vgpi1ThK+gbJWk4sM5z9+JUEIeKb7KKvbjhKCKy2brsnj5YSXjQ1wyqovhXS0VySj5u2fcpF6pTYU2LS8/Nks2TfkM1xo2G4KUvl/7O/3Hs6VMcbOzW/u38l2MsdgO1xH0T09Syi36/zRG++Cfn6a8pJCdbi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geC/2wbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04115C4CEE4;
	Mon, 21 Apr 2025 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745238870;
	bh=xrauOpA4/vhOQFxpBIPOet7Xc8Z+xF1XZzZkt6m+Ot0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=geC/2wbwJ9gTVO7FI2haYfOwzQCq4ws3InzjoXohF6sKRomK+jXdUWxAxLzeyyeXd
	 TOC4sxLizCNmwDGAuSpHTF32pN3w6wiQiXL9BMWfE8NjWcSIEGITmEdCVuc+udQPw8
	 z4OJNokB1/2l8Sfw3TRcByFlAg0ozVxD3YBUHMAy/M2QRJc7X61aLpvBKaPbEBjDQu
	 2TIVBuU+XtlvlZOq3COaLRPz7NqleOJ5To5mhBp5Zi5wOwFQAbCOm5aR6Z6N3jLedG
	 DYpwK9RbOokAvkvptCMFAm51fFxBX9EKnqjBSP29dIjXLJefa/uQB/NM/m+HWFiqCm
	 /gFbZ36wVHAXg==
Date: Mon, 21 Apr 2025 13:34:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, sonic.zhang@analog.com, vapier@gentoo.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v5 3/5] staging: iio: adc: ad7816: Introduce chip_info
 and use pointer matching
Message-ID: <20250421133423.3833e911@jic23-huawei>
In-Reply-To: <20250420014910.849934-4-gshahrouzi@gmail.com>
References: <20250420014910.849934-1-gshahrouzi@gmail.com>
	<20250420014910.849934-4-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 21:49:08 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> Introduce struct ad7816_chip_info to centralize static properties (e.g.
> name, max channels) that differ between chip variants (AD7816/7/8) but
> are constant for any specific type.
> 
> Store pointers to these instances in the of_device_id (.data) and
> spi_device_id (driver_data) tables. Retrieve the pointer in probe()
> using the firmware-independent device_get_match_data() and store it in
> the ad7816_state struct.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Hi Gabriel

A few minor things inline.

I think this went a little too far in splitting up changes and you should combine
patches 3 and 4 to avoid a nasty intermediate bit of code.

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c | 55 +++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index cad2e55aff3f9..39310ade770d0 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -41,8 +41,28 @@
>   * struct ad7816_state - chip specific information
>   */
>  
> +struct ad7816_chip_info {
> +	const char *name;
> +	u8 max_channels;

Something called max_channels should be the number of channels.
If you called it max_channel then it could be used for the maximum channel
number present. I assume that is what you have here as otherwise the
ad7816 has no channels which seems odd!

> +};
> +
> +static const struct ad7816_chip_info ad7816_info_ad7816 = {
> +	.name = "ad7816",
> +	.max_channels = 0,
> +};
> +
> +static const struct ad7816_chip_info ad7817_info_ad7817 = {
> +	.name = "ad7817",
> +	.max_channels = 3,
> +};
> +
> +static const struct ad7816_chip_info ad7818_info_ad7818 = {
> +	.name = "ad7818",
> +	.max_channels = 1,
> +};
> +
>  struct ad7816_state {
> -	kernel_ulong_t id;
> +	const struct ad7816_chip_info *chip_info;
>  	struct spi_device *spi_dev;
>  	struct gpio_desc *rdwr_pin;
>  	struct gpio_desc *convert_pin;
> @@ -52,12 +72,6 @@ struct ad7816_state {
>  	u8  mode;
>  };
>  
> -enum ad7816_type {
> -	ID_AD7816,
> -	ID_AD7817,
> -	ID_AD7818,
> -};
> -
>  /*
>   * ad7816 data access by SPI
>   */
> @@ -84,7 +98,7 @@ static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {

Hmm. I'd be tempted to squash the next patch with this one simply to avoid this
horrible intermediate state where you match on pointers.

It is all part of moving from the enum over to data so I think is
fine in one patch.

>  		while (gpiod_get_value(chip->busy_pin))
>  			cpu_relax();
>  	}
> @@ -353,6 +367,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  {
>  	struct ad7816_state *chip;
>  	struct iio_dev *indio_dev;
> +	const struct ad7816_chip_info *info;
>  	int i, ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> @@ -362,11 +377,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	/* this is only used for device removal purposes */
>  	dev_set_drvdata(&spi_dev->dev, indio_dev);
>  
> +	info = device_get_match_data(&spi_dev->dev);
> +	if (!info)
> +		return -ENODEV;
> +	chip->chip_info = info;
> +
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  
> -	chip->id = spi_get_device_id(spi_dev)->driver_data;
>  	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HIGH);
>  	if (IS_ERR(chip->rdwr_pin)) {
>  		ret = PTR_ERR(chip->rdwr_pin);
> @@ -382,7 +401,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  			ret);
>  		return ret;
>  	}
> -	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
>  		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
>  						GPIOD_IN);
>  		if (IS_ERR(chip->busy_pin)) {
> @@ -393,7 +412,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		}
>  	}
>  
> -	indio_dev->name = spi_get_device_id(spi_dev)->name;
> +	indio_dev->name = chip->chip_info->name;
>  	indio_dev->info = &ad7816_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> @@ -420,18 +439,18 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  }
>  
>  static const struct of_device_id ad7816_of_match[] = {
> -	{ .compatible = "adi,ad7816", },
> -	{ .compatible = "adi,ad7817", },
> -	{ .compatible = "adi,ad7818", },
> +	{ .compatible = "adi,ad7816", .data = &ad7816_info_ad7816 },
> +	{ .compatible = "adi,ad7817", .data = &ad7817_info_ad7817 },
> +	{ .compatible = "adi,ad7818", .data = &ad7818_info_ad7818 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad7816_of_match);
>  
>  static const struct spi_device_id ad7816_id[] = {
> -	{ "ad7816", ID_AD7816 },
> -	{ "ad7817", ID_AD7817 },
> -	{ "ad7818", ID_AD7818 },
> -	{}
> +	{ "ad7816", (kernel_ulong_t)&ad7816_info_ad7816 },
> +	{ "ad7817", (kernel_ulong_t)&ad7817_info_ad7817 },
> +	{ "ad7818", (kernel_ulong_t)&ad7818_info_ad7818 },
> +	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(spi, ad7816_id);


