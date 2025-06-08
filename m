Return-Path: <linux-iio+bounces-20318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A340AAD133A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 18:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5993B188ABAE
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jun 2025 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE7919CD07;
	Sun,  8 Jun 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwtdajuw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE22629C;
	Sun,  8 Jun 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399276; cv=none; b=c+dsgDIiLZgBk3lIvJ1iyUP4icvObz85kgLTG2WA3vTdsCqXMYXq+4ZAyR61PW+9sNTzsnR/y1a7n0eaGQUryYxOgR/8HQKc2oyZ6EZiVslR9xE6kMcgqbS//Ux8ch3iNHzuyFBkujOfbHZLTTmZifbLdA9Ay6PsTyPRtodDuE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399276; c=relaxed/simple;
	bh=gbZO/RRvz3Ja0dEvss2KALNwk3mqOXhlGeAl034WO7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fS6AhFQ7gCVTphD1E8x+OpLZgQ0QykdkjqADcLp1ybeUvhDPipMWYesU8XHC4BkVugvuIC5HXjNy9j6e3zJBtqmfS99pOQpp2gEJnKgpW3r8ZdoPaE7vGzL3c5FxzMXvw/eGaKxkc76+JlKZfF8xR6uF01aBfatPHkUNqBJmGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwtdajuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB48C4CEEE;
	Sun,  8 Jun 2025 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749399275;
	bh=gbZO/RRvz3Ja0dEvss2KALNwk3mqOXhlGeAl034WO7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UwtdajuwLY/SrQIi6bStqlTXrcdvvlolmbjmF5l6vyopKDERgz58edKhBF/8A39KD
	 S31LjtffNtnSYFNdA2QcSMsR56J3kZDrJXY4t0VpRuf4K3CX152lVEsf714bxUFhDZ
	 poP0DwF2Cm5P2PX1nGjhTUww2nWPdTBt5yjS7PWaTge2nWV3Ky8nESMnyYGfAC8rug
	 Nt42MXA29Q9D9+QmyZZEFcywb7rAXlLrSj0T2OlNuK7qIvSGPS7MbwjK+JU0WRDfZ8
	 ZvTxJ4nxZNIzYEEqbj4X7riythbwEmmxkgagmT0AWKT6eTUHsyL6RiLRH1O17Rsr2x
	 REr1vBVo+0/zQ==
Date: Sun, 8 Jun 2025 17:14:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] iio: accel: adxl313: add inactivity sensing
Message-ID: <20250608171425.11269bf0@jic23-huawei>
In-Reply-To: <20250601172139.59156-9-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
	<20250601172139.59156-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Jun 2025 17:21:36 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Extend the interrupt handler to process interrupts as inactivity events.
> Add functions to set threshold and period registers for inactivity. Add
> functions to enable / disable inactivity. Extend the fake iio channel to
> deal with inactivity events on x, y and z combined with AND.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

> @@ -555,16 +621,30 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
>  	if (type != IIO_EV_TYPE_MAG)
>  		return -EINVAL;
>  
> -	if (info != IIO_EV_INFO_VALUE)
> -		return -EINVAL;
> -
> -	/* Scale factor 15.625 mg/LSB */
> -	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> -	switch (dir) {
> -	case IIO_EV_DIR_RISING:
> -		ret = regmap_write(data->regmap,
> -				   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> -				   regval);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		/* Scale factor 15.625 mg/LSB */
> +		regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = regmap_write(data->regmap,
> +					   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
> +					   regval);
> +			if (ret)
> +				return ret;
> +			return adxl313_set_measure_en(data, true);
> +		case IIO_EV_DIR_FALLING:
> +			ret = regmap_write(data->regmap,
> +					   adxl313_act_thresh_reg[ADXL313_INACTIVITY],
> +					   regval);
> +			if (ret)
> +				return ret;
> +			return adxl313_set_measure_en(data, true);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_EV_INFO_PERIOD:
> +		ret = adxl313_set_inact_time_s(data, val);
>  		if (ret)
>  			return ret;
>  		return adxl313_set_measure_en(data, true);

Having the enable in the case statement but he disable outside is misbalanced.
Do it one way or the other (either always disable / enable outside, or both
inside each relevant case statement.   If we need to do this, I'd have
a helper function do_adxl313_write_event_value() or similar that is called
between disabling and enabling measurement mode and contains all the other
stuff in this function (or along those lines anyway).  You can chose
whether or not to reenable measurement mode depending on what is returned
by the helper function.


