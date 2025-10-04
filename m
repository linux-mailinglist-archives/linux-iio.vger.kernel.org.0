Return-Path: <linux-iio+bounces-24722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C19BB8F4C
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 308734E41D4
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBA26B96A;
	Sat,  4 Oct 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4bnM/bZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07B26A1C4
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759590732; cv=none; b=CwC7eZZG8Wt4Gor9ajytdCTd4T1KKgK+ZJB75yLwyW32gCBanpVEcyqhSv1fcQ/aWvTthLucoJpEp463uMWlXTHBvsuL/Tb8xvZ1AI/FO50sPPAgn30+wcOwfe5XCQOvL4cEwDTVUO7RSnqlxH9d1nuFkafX6DnF2SqigoqJZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759590732; c=relaxed/simple;
	bh=lxka+JMT+MHrpYtW16RmIFiDkh0VjyoNnqVSRnjHnV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGGSPYULzxRWGZNbwF/mJd5Tnuid54OARsEvckC2DO4wp/NcGdsCnV2SH7G+PlLAveSqk0Jce2goUfINCPC6r9TEEidr+7YtUIrVWPLLG9ZGM8aJLL4PzOyLkWeagsYDZG3h19uEL/Twh0OetlycyOI8GwNd0fPswjArVtYKp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4bnM/bZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5110DC4CEF1;
	Sat,  4 Oct 2025 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759590731;
	bh=lxka+JMT+MHrpYtW16RmIFiDkh0VjyoNnqVSRnjHnV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4bnM/bZ2HefDt+88W7Ct0QQ0HEzBc8MiC+AZ/yDrr/RZJRURcEA3454sSC+5RaCc
	 L2s0If5elyO8SER/CZyKCh6B2AnmbWeUCqLwaD0a7KphwSOMK2ONgRsv3g8DC4WF4j
	 x1CD+jBikYZh1cFg6BFZnq5FcOdnB+S4dFDzuR8zu2iKeQR7LfbgRbHnwsAiP4KUqb
	 cIWHhaoduisfbVNE/E9Avqr6Fkp9jbekTTcy6unHx794BVQAftrH2KJB2TewM29w+P
	 m74lkdjc/Ddpf/niuW7eK99Ph8vdysBGMkEJMejdBjXNLDe6VmbiXSY6XY8WKWA/Ub
	 tXRAS+TDaiFWw==
Date: Sat, 4 Oct 2025 16:12:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v3 5/9] iio: pressure: bmp280: remove code
 duplication
Message-ID: <20251004161204.0d394c6e@jic23-huawei>
In-Reply-To: <20250928172637.37138-7-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
	<20250928172637.37138-7-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Sep 2025 19:26:33 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Eliminate code duplication from bmp280_read_raw_impl() by handling raw
> and processed channel reads together.  The decision about which data format
> to output is pre-computed in bool info_raw so that the switch
> statement needs no fallthrough macro.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Hi Achim

One minor thing inline. If nothing else comes up I might tweak this whilst
applying (though it's so minor I might not bother!)

J

> ---
>  drivers/iio/pressure/bmp280-core.c | 46 +++++++++++-------------------
>  1 file changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 2dd36493acb4..4f5c4bd89067 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -619,10 +619,12 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  	struct bmp280_data *data = iio_priv(indio_dev);
>  	int chan_value;
>  	int ret;
> +	bool info_raw = mask & IIO_CHAN_INFO_RAW;
>  
>  	guard(mutex)(&data->lock);
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
>  	case IIO_CHAN_INFO_PROCESSED:
>  		ret = data->chip_info->conv(data);
>  		if (ret)
> @@ -634,6 +636,11 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  
> +			if (info_raw) {
> +				*val = chan_value;
> +				return IIO_VAL_INT;
> +			}
> +
>  			*val = data->chip_info->humid_coeffs[0] * chan_value;
>  			*val2 = data->chip_info->humid_coeffs[1];
>  			return data->chip_info->humid_coeffs_type;
> @@ -642,6 +649,10 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  
> +			if (info_raw) {
> +				*val = chan_value;
> +				return IIO_VAL_INT;
> +			}

Should you be respinning for any reason. Blank line here would be consistent with
other cases above and below.

>  			*val = data->chip_info->press_coeffs[0] * chan_value;
>  			*val2 = data->chip_info->press_coeffs[1];
>  			return data->chip_info->press_coeffs_type;
> @@ -650,42 +661,17 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
>  			if (ret)
>  				return ret;
>  
> +			if (info_raw) {
> +				*val = chan_value;
> +				return IIO_VAL_INT;
> +			}
> +
>  			*val = data->chip_info->temp_coeffs[0] * chan_value;
>  			*val2 = data->chip_info->temp_coeffs[1];
>  			return data->chip_info->temp_coeffs_type;
>  		default:
>  			return -EINVAL;
>  		}
> -	case IIO_CHAN_INFO_RAW:
> -		ret = data->chip_info->conv(data);
> -		if (ret)
> -			return ret;
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


