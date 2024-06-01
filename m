Return-Path: <linux-iio+bounces-5574-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCE8D6FCE
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 14:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DFD283420
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFFF14F9E8;
	Sat,  1 Jun 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ+11BBU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC01E481;
	Sat,  1 Jun 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717246122; cv=none; b=hGAKAQ6TwhMUTYvHuIkOqUzcgZNkzwTMFPoHK4VVGwjhX9oXmqe0acglG2jMUpdn3VdWiDRsFvPNM5QhsHJwb5miNMVLdp6MHdZ4DrYXk/Nr8b4ZNyGsOIHPcR03hfJk4W+kyq6CtAjEeZ1gQoNDzHhnq5TTZgJDJ28APAMyNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717246122; c=relaxed/simple;
	bh=58IkfghORK5mSRBwh6TqDVlxAwNbReUZkA6ELrjjxEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iArdpE5FjerbfdAix/XqahS0/WE+2IVc2CoddiNvjwBP7sghhrjJKCJpsCdiqmzNxdr3MZ/sHP6F36XLf0sPzhJbxadrLRRREmrFvZji4YaX6LbynOjsJ/YmLOX8WSzvldDiBpPrXFOiyLA0Z9Udg221GKtavffNyuegDLVCUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ+11BBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0E9C116B1;
	Sat,  1 Jun 2024 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717246122;
	bh=58IkfghORK5mSRBwh6TqDVlxAwNbReUZkA6ELrjjxEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQ+11BBUPvwmjob7lUfleGd12aVQaOp1yVjb4P5Ju63kYEAepNaVEhlWmPrBGlYTz
	 uJuNfz4U2KzJeoyJCwRkHNY+cNKJlvJ27sWD74jZgsMx/UBrrvSr7uUKWXc3IX5L4d
	 Zz8dpybH4awUuPE93MmyE7PbBo7s4bPJg9QfVJtPUa/6hdPaD+1cNJ2Pu7R7zi5Ckx
	 a33GpcFK4ytEY585Y7lLYKsGZutEhIaJy+BEfhmB7Bww9aPUxy7B6xdcERGyyZ2JR7
	 ZDxRgXZ9ArgpBQ1VxlvrhHLQGrHGdf0RVrYxMuNySpwgHwqtnaYLI9vcrRtdFgejC5
	 8Zjf0D0JqRlvA==
Date: Sat, 1 Jun 2024 13:48:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240601134828.68c3acba@jic23-huawei>
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-1-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
	<20240531-iio-adc-ref-supply-refactor-v1-1-4b313c0615ad@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 16:19:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Error messages have changed slightly since there are now fewer places
> where we print an error. The rest of the logic of selecting which
> supply to use as the reference voltage remains the same.
> 
> Also 1000 is replaced by MILLI in a few places for consistency.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Ouch diff didn't like this one much and it is a bit hard to read.

One case where I think this has an unintended side effect.
See below.

> ---
>  drivers/iio/adc/ad7192.c | 98 +++++++++++++++++-------------------------------
>  1 file changed, 35 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 0789121236d6..e08bf066b3f6 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -200,8 +200,6 @@ struct ad7192_chip_info {
>  
>  struct ad7192_state {
>  	const struct ad7192_chip_info	*chip_info;
> -	struct regulator		*avdd;
> -	struct regulator		*vref;
>  	struct clk			*mclk;
>  	u16				int_vref_mv;
>  	u32				aincom_mv;
> @@ -1189,17 +1187,11 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
>  	},
>  };
>  
> -static void ad7192_reg_disable(void *reg)
> -{
> -	regulator_disable(reg);
> -}
> -
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
> -	struct regulator *aincom;
> -	int ret;
> +	int ret, avdd_mv;
>  
>  	if (!spi->irq) {
>  		dev_err(&spi->dev, "no IRQ?\n");
> @@ -1219,74 +1211,54 @@ static int ad7192_probe(struct spi_device *spi)
>  	 * Newer firmware should provide a zero volt fixed supply if wired to
>  	 * ground.
>  	 */
> -	aincom = devm_regulator_get_optional(&spi->dev, "aincom");
> -	if (IS_ERR(aincom)) {
> -		if (PTR_ERR(aincom) != -ENODEV)
> -			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
> -					     "Failed to get AINCOM supply\n");
> -
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "aincom");
> +	if (ret == -ENODEV)
>  		st->aincom_mv = 0;
> -	} else {
> -		ret = regulator_enable(aincom);
> -		if (ret)
> -			return dev_err_probe(&spi->dev, ret,
> -					     "Failed to enable specified AINCOM supply\n");
> +	else if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret, "Failed to get AINCOM voltage\n");
> +	else
> +		st->aincom_mv = ret / MILLI;
>  
> -		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);
> +	/* AVDD can optionally be used as reference voltage */
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "avdd");
> +	if (ret == -EINVAL) {
> +		/*
> +		 * We get -EINVAL if avdd is a supply with unknown voltage. We
> +		 * still need to enable it since it is also a power supply.
> +		 */
> +		ret = devm_regulator_get_enable(&spi->dev, "avdd");

What happens if the entry simply isn't there in the DT.
Previously I think the regulator framework would supply a stub whereas
the devm_regulator_get_enable_read_voltage() returns -ENODEV so isn't
caught by the handling and I think it should be.

>  		if (ret)
> -			return ret;
> -
> -		ret = regulator_get_voltage(aincom);
> -		if (ret < 0)
>  			return dev_err_probe(&spi->dev, ret,
> -					     "Device tree error, AINCOM voltage undefined\n");
> -		st->aincom_mv = ret / MILLI;
> -	}
> +					     "Failed to enable AVDD supply\n");
>  
> -	st->avdd = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->avdd))
> -		return PTR_ERR(st->avdd);
> -
> -	ret = regulator_enable(st->avdd);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
> -		return ret;
> +		avdd_mv = 0;
> +	} else if (ret < 0) {
> +		return dev_err_probe(&spi->dev, ret, "Failed to get AVDD voltage\n");
> +	} else {
> +		avdd_mv = ret / MILLI;
>  	}
>  
> -	ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->avdd);
> -	if (ret)
> -		return ret;
>  
>  	ret = devm_regulator_get_enable(&spi->dev, "dvdd");
>  	if (ret)
>  		return dev_err_probe(&spi->dev, ret, "Failed to enable specified DVdd supply\n");
>  
> -	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
> -	if (IS_ERR(st->vref)) {
> -		if (PTR_ERR(st->vref) != -ENODEV)
> -			return PTR_ERR(st->vref);
> -
> -		ret = regulator_get_voltage(st->avdd);
> -		if (ret < 0)
> -			return dev_err_probe(&spi->dev, ret,
> -					     "Device tree error, AVdd voltage undefined\n");
> +	/*
> +	 * This is either REFIN1 or REFIN2 depending on adi,refin2-pins-enable.
> +	 * If this supply is not present, fall back to AVDD as reference.
> +	 */
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> +	if (ret == -ENODEV) {
> +		if (avdd_mv == 0)
> +			return dev_err_probe(&spi->dev, -ENODEV,
> +					     "No reference voltage available\n");
> +
> +		st->int_vref_mv = avdd_mv;
> +	} else if (ret < 0) {
> +		return ret;
>  	} else {
> -		ret = regulator_enable(st->vref);
> -		if (ret) {
> -			dev_err(&spi->dev, "Failed to enable specified Vref supply\n");
> -			return ret;
> -		}
> -
> -		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st->vref);
> -		if (ret)
> -			return ret;
> -
> -		ret = regulator_get_voltage(st->vref);
> -		if (ret < 0)
> -			return dev_err_probe(&spi->dev, ret,
> -					     "Device tree error, Vref voltage undefined\n");
> +		st->int_vref_mv = ret / MILLI;
>  	}
> -	st->int_vref_mv = ret / 1000;
>  
>  	st->chip_info = spi_get_device_match_data(spi);
>  	indio_dev->name = st->chip_info->name;
> 


