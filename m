Return-Path: <linux-iio+bounces-18027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A179A86EA1
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 20:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A33916BFCC
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4852080F4;
	Sat, 12 Apr 2025 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmsEAa59"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDB1A23B1;
	Sat, 12 Apr 2025 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481498; cv=none; b=ni5+9jz6oFsxia0wbKtswvNmQtm6OpI41QFTiDZ9WUJMQqV4VXena+RpYe/qGbPrZy6rhlGGPjbwci8y8yX/G10+HW0uvZlNeFCS2DQL5KCo7MZXdNC2xfiqXSeX2DR4GiHnkoN9CrczWdrSeKrX3hmKxu2aJp+8sRkq8u78vL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481498; c=relaxed/simple;
	bh=b3HaXXW+MR1VOkMnYXtzpEuVhn4y0K81DcGV47y/ueg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbKUh2DYTaLsgKVAmTZb93J/ehrwl8jHix1NsatIxWofZW9MoNOzQOknsXclb+VFLz/4v6AJDgApMUARbrUmmCUd9QajKZYFSIOtNh8GgN5pjUT4s17QA0XQpLhbDbeITjitSSO30zJc+6wWMOA0YK9aAcrtA1pwdb+07M8KQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmsEAa59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A616C4CEE3;
	Sat, 12 Apr 2025 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744481497;
	bh=b3HaXXW+MR1VOkMnYXtzpEuVhn4y0K81DcGV47y/ueg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmsEAa59dTWc4y15WeR8qPZcy1o85rX7iSQrRXWxqfJsPyfKbhnmdzeb4buEDW/bD
	 I2IGLnW+dIggXRY7Gpa4W6JAmJ8C0GOLuigBDxLn9bbJlq2rko5CSGuZ7nAfUOGLoo
	 uM+2dA3vnEWaNt2X72wPt3LgTkEeVQGsbd3PRMUjuQp+eYXK4tfi7X9Fhf/KzEDEn6
	 hzRsDF2Gb1jXabhNNR5obU24ed8MxfpnjY3jXr8KFnSePNU9JQkygO6PZTd3n685Po
	 edqSAzcmQu0JKO9KxzeAEOL6zNVDV0VLC/I2+1izvSZ2CNoxKE5PkfWmGYXnAuCsuX
	 lZpXd8M6l0c8A==
Date: Sat, 12 Apr 2025 19:11:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>, Pop
 Paul <paul.pop@analog.com>
Subject: Re: [PATCH v5 13/14] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <20250412191126.06c19115@jic23-huawei>
In-Reply-To: <e5ea27f88607d1cc12daecf310c18f71383a3bbe.1744325346.git.Jonathan.Santos@analog.com>
References: <cover.1744325346.git.Jonathan.Santos@analog.com>
	<e5ea27f88607d1cc12daecf310c18f71383a3bbe.1744325346.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



>  
> -static int ad7768_set_dig_fil(struct ad7768_state *st,
> -			      enum ad7768_dec_rate dec_rate)
> +static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
> +				     unsigned int dec_rate)
>  {
> -	unsigned int mode;
> +	unsigned int max_dec_rate;
> +	u8 dec_rate_reg[2];
>  	int ret;
>  
> -	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
> -		mode = AD7768_DIG_FIL_FIL(dec_rate);
> -	else
> -		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
> +	/*
> +	 * Maximum dec_rate is limited by the MCLK_DIV value
> +	 * and by the ODR. The edge case is for MCLK_DIV = 2
> +	 * ODR = 50 SPS.
> +	 * max_dec_rate <= MCLK / (2 * 50)
> +	 */
> +	max_dec_rate = st->mclk_freq / 100;
> +	dec_rate = clamp_t(unsigned int, dec_rate, 32, max_dec_rate);
> +	/*
> +	 * Calculate the equivalent value to sinc3 decimation ratio
> +	 * to be written on the SINC3_DECIMATION_RATE register:
> +	 *  Value = (DEC_RATE / 32) -1
> +	 */
> +	dec_rate = DIV_ROUND_UP(dec_rate, 32) - 1;
> +	dec_rate_reg[0] = FIELD_GET(AD7768_SINC3_DEC_RATE_MSB_MSK, dec_rate);
> +	dec_rate_reg[1] = FIELD_GET(AD7768_SINC3_DEC_RATE_LSB_MSK, dec_rate);
Looks like a larger big endian value. It's a little messy because of
the 12 bit mask but I think still clearer as

	u16 regval = FIELD_PREP(GENMASK(11, 0), dec_rate);
	
	unaligned_put_be16(dec_rate_reg, regval);

Avoids the use of masks to get bytes from the dec_rate value which is
is sort of backwards.


> +	ret = regmap_bulk_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_MSB,
> +				dec_rate_reg, 2);
> +	if (ret)
> +		return ret;
> 

