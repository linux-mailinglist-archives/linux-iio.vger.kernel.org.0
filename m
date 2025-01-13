Return-Path: <linux-iio+bounces-14278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA1EA0B627
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 12:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F809188647C
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2FE1CAA9A;
	Mon, 13 Jan 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1wi0qxW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502D22CF02;
	Mon, 13 Jan 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736769391; cv=none; b=uHCRKXgnxwZZD80pT9FqzZqI32fsDd5apZhME656iczxSiF+cYS4tWMdZT2Azj+BWFVnmnAmNUYMhlAjzaxNR6WhM9cJFRigC8AXcuX8Vy+YtnlGTz60AWBrGxwYFInzYspknSmutvGpFXD6RarB2XYZRowi0tEOeu+I6K1GSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736769391; c=relaxed/simple;
	bh=hVqevC7qNlWGq9uv7woc0zVfFMZCSzh9eRbNV/1EhLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2TvfMpqtjb/iekWabeG5e8v1GY3idLnbgmIrKHSPfgkDeaug0T5qNLS0JMAjm6swWIq5hJVDQQYDOMJhCmcnqE2ttkHYg0hTSzK6oVp/FCo9A9lp1VpCr18u0kIA+uctQ9Y+vy2GgghS6d79t8QTsgQyUzGgYyCx0ZTX0fGkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1wi0qxW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so3924422e87.2;
        Mon, 13 Jan 2025 03:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736769386; x=1737374186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9Stm00tmsf9oKi3r3TKeNB9YWsGZxxcwe7EzIAY69E=;
        b=k1wi0qxWDvVf3qea1Jx+lDzHD4HJvrrYfFS57v9t6AB5RSFPflaUB4Zzv1fJsNFuOF
         xK4gnniDhdtlXVRH8iSpKH3x27wjrFxPKn76BJoTvDp4q7tumRmRnfLsDBZPI67Q69lw
         ZvwF0Y3rmgsoj9eSBm3vh+I8q0vgg+DP/tHQCG76Ai4ipIQZ/TBnivNzy3ZYgq+6OvFg
         J2ZyECi/OdGRZNy2pToaxrbYa22uMfGmZUgu4ZdxF5EyeQu1TydeMPBI4t6beNP031YA
         AUXZTj7WQGHKGJu+mk3yrpMqPBb8wEqaPT80Lvr2Ngk2yJuCu4DcSzMVsi5rB5aO2WOU
         umfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736769386; x=1737374186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9Stm00tmsf9oKi3r3TKeNB9YWsGZxxcwe7EzIAY69E=;
        b=JnkejsnVjmDZhLouxBZ2eCNvYA0z8tiZNyvD/2o6N7sAMrSyqgc21t1tylq+Vh7wKa
         Gj35v97NUTfvPzzFok7yJF770qNzmpfwT4hxF4hx2riz8wrczbapmseWdspxcIqZJV1T
         qhcVWY11f8bZ9fRXHSRBg5CsFBVbKpFNkOa+zQpA8870/PJUAHedcS6gbRTaArocKzuf
         oGPNQo/I//vIPgvIUvCt+vrE4q9zh6hHSIdJ7Sk8JA84cGwYjwLXSyfpBQDF2oShj/wg
         PK/eiMe8owtvBqcKAMHFhBlFKENImSnHDQFhVCUQc/QufVvf0d+VZQ1EKcbDNy4U7YCy
         Ar7w==
X-Forwarded-Encrypted: i=1; AJvYcCUAFCzvxpRoRvSG4FzJdNiQ2s3PNyAW3jkR3S+5USJijxDnSWITm31dvBkze1BBCy8wsQCSucJm37Y4bCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVoEkeczJuGzfdjTBRPdVq+Yzot9d70GJrOZH38atSZ1f9bd7
	mNod81GgtIiVCyfZoWRtmnQZO8HAS2w04EoG0fEJYtLuNnooVEWO
X-Gm-Gg: ASbGncvg+Jn/r6gQhMyPzNnSS2zy3BHZ/oUPRRhmnpuKXe08sbHEb/3kSEP0ExJr4dM
	Jm+/uZgn130cB9G83k5lLcw3JPqPsxuO28e216en/cnW5jKl15K8ZX3H89pvS2FzCQBlQzq0o4M
	FPGGOO6X663t1/V3lxny8kJ5IMhxX8Ohthq+hmQPWoCQr5jnsyPVH8VU079yZ3FQgdZgoTg8+jt
	NdUGlAq7gRgCt0UUs/UOVL5ns4ddY3XhSQ/GX+j5K9dV7PODErtyClIO4gnx1fRrzKSig==
X-Google-Smtp-Source: AGHT+IHIQ9Hm7wrXqJfkcJZZuZnTsbzYM8no9mbq7DHjqor2lNOw8ZRxCiREbrFNfK0l9dCJCWUB0Q==
X-Received: by 2002:a05:6512:1396:b0:542:2486:697b with SMTP id 2adb3069b0e04-54284503d0dmr6276800e87.10.1736769385943;
        Mon, 13 Jan 2025 03:56:25 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428bec3ee8sm1305552e87.226.2025.01.13.03.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 03:56:24 -0800 (PST)
Message-ID: <129de6d6-50f4-44d7-9a06-db61a6669810@gmail.com>
Date: Mon, 13 Jan 2025 13:56:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: light: veml6030: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com>
 <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250107-veml6030-scale-v1-2-1281e3ad012c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2025 22:50, Javier Carrasco wrote:
> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
> 
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet and drop dedicated variables to store the current values of
> the integration time, gain and resolution. When at it, use 'scale'
> instead of 'gain' consistently for the get/set functions to avoid
> misunderstandings.
> 
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Thanks for the patch Javier.

And, sorry for a review which is more about questions than suggested 
improvements. I find it hard to focus on reading code today.

> ---
>   drivers/iio/light/Kconfig    |   1 +
>   drivers/iio/light/veml6030.c | 499 ++++++++++++++++---------------------------
>   2 files changed, 189 insertions(+), 311 deletions(-)
> 

I like the diffstats of this Fix! :) It's nice you found gts-helpers 
helpful :)

...

> +
> +static int veml6030_process_als(struct veml6030_data *data, int raw,
> +				int *val, int *val2)
> +{
> +	int ret, scale_int, scale_nano;
> +	u64 tmp;
> +
> +	ret = veml6030_get_scale(data, &scale_int, &scale_nano);
> +	if (ret < 0)
> +		return ret;
> +
> +	tmp = (u64)raw * scale_nano;
> +	*val = raw * scale_int + div_u64(tmp, NANO);
> +	*val2 = div_u64(do_div(tmp, NANO), MILLI);

do_div() is horrible on some platforms. Or, at least it used to be. Is 
there really no way to go without it? We're dealing with 16bit data and 
maximum of 512x total gain only, so maybe there was a way(?)

Maybe a stupid question (in which case I blame mucus in my head) - could 
you just divide the raw value by the total gain?

> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +

...

>   
>   static irqreturn_t veml6030_event_handler(int irq, void *private)
> @@ -1084,6 +968,13 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
>   	int ret, val;
>   	struct veml6030_data *data = iio_priv(indio_dev);
>   
> +	ret = devm_iio_init_iio_gts(dev, 2, 150400000,

Can you please explain the seemingly odd choice for the max scale?

Just a quick look at the sensor spec and this driver allows me to assume 
following:

Maximum 'total gain' from both HWGAIN and integration time is 16 * 32 = 512.

If we chose the 'total gain' 1x to match scale 1, then the smallest 
scale would be 1/512 = 0.001 953 125

This is 1953125 NANOs. This would mean the max-scale 1X => gain 1X would 
not cause precision loss. (Well, I'm not at my sharpest as I've caught 
cold - but I _think_ this is true, right?)

If I read this correctly, the only channel where the scale gets applied 
is the INTENSITY channel, right? Hence it should be possible to chose 
the scale as we see best. (Unless the idea of this seemingly odd scale 
is to maintain the old intensity / scale values in order to not shake 
userland any more - in which case this could be mentioned).

> +				    veml6030_gain_sel, ARRAY_SIZE(veml6030_gain_sel),
> +				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
> +				    &data->gts);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init iio gts\n");
> +
>   	ret = veml6030_als_shut_down(data);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "can't shutdown als\n");
> @@ -1119,11 +1010,6 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
>   		return dev_err_probe(dev, ret,
>   				     "can't clear als interrupt status\n");
>   
> -	/* Cache currently active measurement parameters */
> -	data->cur_gain = 3;
> -	data->cur_resolution = 5376;
> -	data->cur_integration_time = 3;
> -
>   	return ret;
>   }
>   

Yours,
	-- Matti


