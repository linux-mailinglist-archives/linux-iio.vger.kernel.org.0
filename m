Return-Path: <linux-iio+bounces-20660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76184AD9D4F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7811898D91
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF752D9EF0;
	Sat, 14 Jun 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWiHo3cV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B72C15AC;
	Sat, 14 Jun 2025 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749910212; cv=none; b=OFixCgnWo9S6FdEBNlmFdVOCY+9/41SbzWj0qYM8Onx6+HVwFXHE1kAYpIRrGNJvOCVzfPn1dldaUVTRCw3zD4a5BYE54h3LQ9O5PiE+xKnqRKMNrq6w2u3KHv7M3Cs/txazrkEewyc0zaFPZ9z//8UCWZ0m7cfrVxR5ZUkWupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749910212; c=relaxed/simple;
	bh=hz1NwYRfhK1h1DV+M51iQjyhNlTu+VaCgtOWpAxOBmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFGmzUjLRWMrXs0R0uNjYEqbGEFMCH4PneergUvKtrQqMGdS1PwX0eP+Hwb3IbT/dDTwBntek+UPRALbJNowbeUgk7U7CeWJdSqr9mpacsf/oFTgSRXFa/i1BbK0T1lhFL57+eg4G1SJe8AYFUDkIzFRsLotAPrZXdaR1xt6gms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWiHo3cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73D2C4CEEB;
	Sat, 14 Jun 2025 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749910211;
	bh=hz1NwYRfhK1h1DV+M51iQjyhNlTu+VaCgtOWpAxOBmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWiHo3cVySEuFTA4XL3mfmpCuEE9UyJRk21tT36bE7DyadJa+iTi+i9t08Exm86se
	 4k6JKqB+wGkGXCeRH/0pmrK5/Oypb4sv14fXOiqfXsNpdGWPcVdkbQSvNc6K9Wdtuv
	 HxoVYAu8RnwZx38+q2dZHje9TdKE63Nm3RQ4sSlngVy5mZUYJC3Busy+fVa8CRVWHB
	 xLPmODLMwXGD6/q5oeQm8A+N2QH612I2Tjoj5e3lf0cHDE636w+ef5PW6dMLOlwkEZ
	 1ahMWnO/yn4aQP4bKMsCN7TjBykFE8+0kmAdGCqYYUsR8mK+T39HUJrakt9CdnnPeB
	 6ao3KRdDTMZkg==
Date: Sat, 14 Jun 2025 15:10:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 10/11] iio: accel: adxl345: extend inactivity time
 for less than 1s
Message-ID: <20250614151002.1582c732@jic23-huawei>
In-Reply-To: <20250610215933.84795-11-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:32 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Inactivity event and free-fall event are actually the same type of sensor
> events. Hence, inactivity detection using a period of 1 to 255s can be
> extended to be used for lower periods than 1s for covering free-fall
> detection.
> 
> When lower periods are defined, the driver automatically will setup
> threshold and period on the free-fall register, while using the
> inactivity threshold and period for periods above 1s. Using the
> free-fall register, no link bit will be set, and therefore no auto-sleep
> can be set in cases where also activity will be enabled.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Approach seems reasonable.  One comment on the code below.

>  /**
>   * adxl345_set_inact_time - Configure inactivity time explicitly or by ODR.
>   * @st: The sensor state instance.
> - * @val_s: A desired time value, between 0 and 255.
> + * @val_int: The inactivity time, integer part.
> + * @val_fract: The inactivity time, fractional part when val_int is 0.
>   *
> - * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0
> + * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0.00
>   * is configured by a user, then a default inactivity time will be computed.
>   *
>   * In such case, it should take power consumption into consideration. Thus it
> @@ -355,16 +381,18 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>   *
>   * Return: 0 or error value.
>   */
> -static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_int,
> +				  u32 val_fract)
>  {
>  	unsigned int max_boundary = 255;
>  	unsigned int min_boundary = 10;
> -	unsigned int val = min(val_s, max_boundary);
> +	unsigned int val;
>  	enum adxl345_odr odr;
>  	unsigned int regval;
>  	int ret;
>  
> -	if (val == 0) {
> +	if (val_int == 0 && val_fract == 0) {
> +		/* Generated inactivity time based on ODR */
>  		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
>  		if (ret)
>  			return ret;
> @@ -373,9 +401,41 @@ static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
>  
>  		val = (adxl345_odr_tbl[odr][0] > max_boundary)
>  			? min_boundary : max_boundary -	adxl345_odr_tbl[odr][0];
> +
> +		st->inact_time_ms = MILLI * val;
> +
> +		/* Inactivity time in s */
> +		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +		if (ret)
> +			return ret;
> +

Perhaps return in the good path here.

> +	} else if (val_int == 0 && val_fract > 0) {
> +		/* time < 1s, free-fall */
> +
> +		/*
> +		 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
> +		 *
> +		 * Recommended values between 100ms and 350ms (0x14 to 0x46)
> +		 */
> +		st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
> +
> +		ret = regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> +				   DIV_ROUND_CLOSEST(val_fract, 5));
> +		if (ret)
> +			return ret;
and here

> +	} else if (val_int > 0) {
> +		/* Time >= 1s, inactivity */
> +		st->inact_time_ms = MILLI * val_int;
> +
> +		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
> +		if (ret)
> +			return ret;
and here.

> +	} else {
Or given this covers any case where val_int > 0 do it first
and error out early?

> +		/* Do not support negative or wrong input. */
> +		return -EINVAL;
>  	}
>  
> -	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> +	return 0;
>  }


