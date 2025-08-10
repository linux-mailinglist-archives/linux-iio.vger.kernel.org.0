Return-Path: <linux-iio+bounces-22520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6678DB1FBA5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BBD3B2D6E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2C81E32B9;
	Sun, 10 Aug 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5wdvC/7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BE1B0413
	for <linux-iio@vger.kernel.org>; Sun, 10 Aug 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754849962; cv=none; b=heZkBL0g1uKW3O5qF8sR67rHdaGUeklh5XRgHQ3bVV2WotLj723ZVrH8Egqz08H1JAIr2i0H2OS+W2mBpMF1+QdwaDT5FR9DKJwfANa/+o7ajbgPSztdPKlVP/Crqpb5QcxRPv88nfa9aIdtiZHRP2mXQpY8KfVLpKXLYFhZxL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754849962; c=relaxed/simple;
	bh=YoTnRuT5ueP/0F2UUMxprS37uf7kLcPoN7hrlsVwt5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ76ehqzqGM1MDTAX5EMnv+Aku3DDR0roYzbHTqnnKNPCSo+asvHzsKhqaPeQXrxePYfaP0g1ya8cncT+LeFmnWBE8HlYEcY7RlfhDQExvPvfDGU1Tosfql/W1v0xXovuzAIfUl8DcSC5wsAsYT0l8Q8uc9Nwyiniu+pY6OT84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5wdvC/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B37C4CEEB;
	Sun, 10 Aug 2025 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754849961;
	bh=YoTnRuT5ueP/0F2UUMxprS37uf7kLcPoN7hrlsVwt5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V5wdvC/7URGR+kBGLFjaDn4CFIvynADhQZ+eJghDIHFRu65Qd3ZmBTgho7Xqn5B5J
	 fYcdjUcuEpqgGrQb59CHc3x8zvS4eN18svgrh19wDdm2OaYnLkhCuR9mV1eHLaeWH1
	 wulml0JKIIGmPS93t4wDC28oBlVrk/lJO2Ghn37BTBTbEmJ6PQir0O+QfLJfT2/qD/
	 DYqi1pBkT0Hbm7KDDaDBH3wULfbVkOtIUMdaTwgIixliA/oCohoSOjYxmocnx7m1UK
	 v0kcnUTcVv4o8aZlhsLE5c/bcexIOLPjYnlTcRa4jPL/DvZ4rF4I+dZhFvOdOWLOre
	 ARV4+a4gwhq/g==
Date: Sun, 10 Aug 2025 19:19:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [bmp280 v1 5/6] iio: pressure: bmp280: remove code duplication
Message-ID: <20250810191914.4d2559ad@jic23-huawei>
In-Reply-To: <20250803140802.36888-6-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-6-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Aug 2025 16:08:01 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Refactor to get rid of duplicated code.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Hmm. I can't remember the history of this, but I guess this was a driver
that got in with a _PROCESSED interface when it shouldn't have done
(As we don't normally do raw and processed except when things are non linear
and there are events involved).

whilst it saves quite a bit of code I'm not sure it is worth while. Kind of
depends on what happens with the earlier patch.

One comment inline.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 89 +++++-------------------------
>  1 file changed, 15 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index b3dcee3fe9b3..5cdaf7516940 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -658,6 +658,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  	int prev_oversampling_humid, prev_oversampling_press, prev_oversampling_temp;
>  	int temp_oversampling_humid, temp_oversampling_press, temp_oversampling_temp;
>  	int switch_off, switch_threshold = -1;
> +	int raw = 0;
>  
>  	guard(mutex)(&data->lock);
>  
> @@ -668,6 +669,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  	data->op_mode = data->sampling_freq ? BMP280_NORMAL : BMP280_FORCED;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		raw = 1;

Needs a fall through marking comment (see other code for what that looks like)
or the static anaylsis tools will send us lots of bug reports.

>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch_off = 0;
>  		if (data->op_mode == BMP280_FORCED) {
> @@ -723,6 +726,10 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  
> +			if (raw) {
> +				*val = chan_value;
> +				return IIO_VAL_INT;
> +			}
>  			*val = data->chip_info->humid_coeffs[0] * chan_value;
>  			*val2 = data->chip_info->humid_coeffs[1];
>  			return data->chip_info->humid_coeffs_type;
> @@ -731,6 +738,10 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  
> +			if (raw) {
> +				*val = chan_value;
> +				return IIO_VAL_INT;
> +			}
>  			*val = data->chip_info->press_coeffs[0] * chan_value;
>  			*val2 = data->chip_info->press_coeffs[1];
>  			return data->chip_info->press_coeffs_type;
> @@ -739,86 +750,16 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  
> +			if (raw) {
> +				*val = chan_value;
> +				return IIO_VAL_INT;
> +			}
>  			*val = data->chip_info->temp_coeffs[0] * chan_value;
>  			*val2 = data->chip_info->temp_coeffs[1];
>  			return data->chip_info->temp_coeffs_type;
>  		default:
>  			return -EINVAL;
>  		}
> -	case IIO_CHAN_INFO_RAW:
> -		switch_off = 0;
> -		if (data->op_mode == BMP280_FORCED) {
> -			/* MODE_FORCED, switch off unused channels */
> -			switch (chan->type) {
> -			case IIO_HUMIDITYRELATIVE:
> -				temp_oversampling_press = 0-1;
> -				switch_off |= (prev_oversampling_press > switch_threshold);
> -				/* can't be switched off as it is needed for compensation */
> -				temp_oversampling_temp  = 1-1;
> -				break;
> -			case IIO_PRESSURE:
> -				temp_oversampling_humid = 0-1;
> -				switch_off |= (prev_oversampling_humid > switch_threshold);
> -				/* can't be switched off as it is needed for compensation */
> -				temp_oversampling_temp  = 1-1;
> -				break;
> -			case IIO_TEMP:
> -				temp_oversampling_humid = 0-1;
> -				temp_oversampling_press = 0-1;
> -				switch_off = (prev_oversampling_humid > switch_threshold) |
> -					     (prev_oversampling_press > switch_threshold);
> -				break;
> -			default:
> -				return -EINVAL;
> -			}
> -		}
> -		if (switch_off) {
> -			data->oversampling_humid = temp_oversampling_humid;
> -			data->oversampling_press = temp_oversampling_press;
> -			data->oversampling_temp  = temp_oversampling_temp;
> -			ret = data->chip_info->chip_config(data);
> -			if (ret)
> -				goto restore;
> -		}
> -
> -		ret = data->chip_info->wait_conv(data);
> -		if (ret)
> -			goto restore;
> -
> -		if (switch_off) {
> -			data->oversampling_humid = prev_oversampling_humid;
> -			data->oversampling_press = prev_oversampling_press;
> -			data->oversampling_temp  = prev_oversampling_temp;
> -			data->chip_info->chip_config(data);
> -			if (ret)
> -				return ret;
> -		}
> -
> -		switch (chan->type) {
> -		case IIO_HUMIDITYRELATIVE:
> -			ret = data->chip_info->read_humid(data, &chan_value);
> -			if (ret)
> -				return ret;
> -
> -			*val = chan_value;
> -			return IIO_VAL_INT;
> -		case IIO_PRESSURE:
> -			ret = data->chip_info->read_press(data, &chan_value);
> -			if (ret)
> -				return ret;
> -
> -			*val = chan_value;
> -			return IIO_VAL_INT;
> -		case IIO_TEMP:
> -			ret = data->chip_info->read_temp(data, &chan_value);
> -			if (ret)
> -				return ret;
> -
> -			*val = chan_value;
> -			return IIO_VAL_INT;
> -		default:
> -			return -EINVAL;
> -		}
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:


