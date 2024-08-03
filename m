Return-Path: <linux-iio+bounces-8221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC752946B17
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 21:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5495A281B69
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513C03AC01;
	Sat,  3 Aug 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eB9oZh/0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662737700;
	Sat,  3 Aug 2024 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722714165; cv=none; b=mxji2RI0iSxbdsiJLZOmC/GemTvqyUO3KKc9srhf1H/OzsuitKPv/zUofFnwCSA6fRdyF7fQJ67fxJw3rL/NpfJZtUxdNxpyDb9p5TwYJE7beikkfbTj4FGbGngTfFgtP9Dnt5rqmPqKbUS5BzIQzh0gs6juiafHysIZFT+6Gss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722714165; c=relaxed/simple;
	bh=vJ6Oc4HlbHn+19UFrejTmI5Ne1QgD/GfIVMyz7SHOuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BM/YlYpp5vbSaluQypHuz/aUejeeUnE8mT8jV0Nhlcswp28S48wcXGftfLcNtcXSf+wrKnhJzUvYkQ73Ksob2k4dfWku3tbEE0rVBP9gNiJgzsZNSMRECwMHQOin2nEPq1yoReeVyNmeA00oklApcp76KFpbqr+fcs/m2i54nNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eB9oZh/0; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id aKeEs4EgIWPKVaKeEsRBek; Sat, 03 Aug 2024 21:42:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722714159;
	bh=tHCt2cSmPbujQGrBxkHoez24fylTAStJKqhJAGm5IKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=eB9oZh/0hzOm6fIRQol606u2IaWjkxmgVAzg9qo31LLoplxCxGSsv8LZnjWlGkRKJ
	 iRwqO2ASxt3qDa/X/w27rXpnEyoOWEVPuyriFTbWYP66bJ/kKuYJLpfEpZnQo8q8Ds
	 0eMJrSbP5UyGcFOa+rUZmJtvAZQt/vXN8cjfxRfQrejcrr7P8wqjGLw4y0BbSK+zcp
	 PHapNz/M0DaTfZ+v/c5bREENnk6n3WThCmw+lKNOv00tmJMnvbUODYiGlEHS3bDjuT
	 ZQLyKz1HEatDFbSxQxGTZPTd6V96EE5zd88LUxOph5Acd1oABqrZIAmoxGZvxWA389
	 A1qpjXR3ChTpg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 03 Aug 2024 21:42:39 +0200
X-ME-IP: 90.11.132.44
Message-ID: <9927c607-5740-406a-8cd6-0550e8b92038@wanadoo.fr>
Date: Sat, 3 Aug 2024 21:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
To: abhashkumarjha123@gmail.com
Cc: anshulusr@gmail.com, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240803180950.32821-1-abhashkumarjha123@gmail.com>
 <20240803180950.32821-2-abhashkumarjha123@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240803180950.32821-2-abhashkumarjha123@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/08/2024 à 20:09, Abhash Jha a écrit :
> Add new ALS channel and allow reading lux and scale values.
> Also provide gain and resolution configuration for ALS channel.
> Add automatic mode switching between the UVS and ALS channel
> based on which channel is being accessed.
> The default mode in which the sensor start is ALS mode.
> 
> Signed-off-by: Abhash Jha <abhashkumarjha123-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

Hi,

...

> @@ -95,6 +101,25 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
>   	return get_unaligned_le24(recieve_buffer);
>   }
>   
> +static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
> +{
> +	if (data->mode == mode)
> +		return 0;
> +
> +	switch (mode) {
> +	case LTR390_SET_ALS_MODE:
> +		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);

Should this be:
	ret = regmap_clear_bits();
	if (ret)
		return ret;
?

Otherwise, 0 is returned in all cases and ltr390_read_raw() could be 
simplified.

> +		break;
> +
> +	case LTR390_SET_UVS_MODE:
> +		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);

Same.

> +		break;
> +	}
> +
> +	data->mode = mode;
> +	return 0;
> +}
> +
>   static int ltr390_read_raw(struct iio_dev *iio_device,
>   			   struct iio_chan_spec const *chan, int *val,
>   			   int *val2, long mask)
> @@ -105,15 +130,47 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
>   	guard(mutex)(&data->lock);
>   	switch (mask) {
>   	case IIO_CHAN_INFO_RAW:
> -		ret = ltr390_register_read(data, LTR390_UVS_DATA);
> -		if (ret < 0)
> -			return ret;
> +		switch (chan->type) {
> +		case IIO_UVINDEX:
> +			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = ltr390_register_read(data, LTR390_UVS_DATA);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +
> +		case IIO_LIGHT:
> +			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
> +			if (ret < 0)
> +				return ret;
> +
> +			ret = ltr390_register_read(data, LTR390_ALS_DATA);
> +			if (ret < 0)
> +				return ret;
> +			break;

...

CJ


