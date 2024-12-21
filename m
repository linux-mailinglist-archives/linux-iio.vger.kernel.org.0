Return-Path: <linux-iio+bounces-13742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003A9FA1D8
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 19:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF187A2555
	for <lists+linux-iio@lfdr.de>; Sat, 21 Dec 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B0016F84F;
	Sat, 21 Dec 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cesrX0Gx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26EE1632C5;
	Sat, 21 Dec 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734805169; cv=none; b=YKKXuDsBhzy37fWe1/7McM7iGI3vLf6S35fR+Q0HQx7StgZECVywr0Gp5ynzh+fKZiJduPJ8uOrqaxNyVJQBliFnc9uTMMuE183oS05d79BCTAo4zA4SqdnLyDQzqTXU8N7OhM6aFQh0Y+EAFekwQarz9DXdrE6zKVJ+f+PTAa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734805169; c=relaxed/simple;
	bh=8A6eIH408Zxm0WoCIZuom7w03GEnoaEl1UT9rpBM0xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrKeHGlGSuaIQw+wWFdXvrsjwpHlMByRJBwaispLIY6BV/v+am0w/gCbqF0zpW0JMah8LmJ0Xd687tYUnDIxZjD0ZIPqwqq7kRPGuRlKTUYsXVL3Ll0LhtaNohtg5v1CT9LO39YoRsiWwFUJMGl7bahFjbbHpVLyFK8Bum+aaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cesrX0Gx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-540218726d5so2971433e87.2;
        Sat, 21 Dec 2024 10:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734805166; x=1735409966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWyNHTT7nGYtDukx/I19Gco3OvpuLD+raehZDNila/M=;
        b=cesrX0GxUR/GM2yiyYyyim5PB8uWiS4die/mdq1UtNDKSX56U5ieI8oHaB3Nrht3Q+
         Xuf3mM56p6SNTT94TC0AkLjYsFB5RHrmol16vfxNdBLEqvLIJWQdfE3i9CMGAAEe8rYA
         mL7Ch7S0YK+efcaBIsHDwhrCZBvk7614k8ZFDsG32n+EFdX8LJLZh0H+EUX6s8jUH/65
         7AzLCQagiVR4U4mS8441+jE550YGgy9kSC+DKT05KnEDvU83MQNLLneDMttGOA5FzOUl
         4QQopmHB9f8ieyrpmdOUQxdX73xMyxAQ2SGqPlt6jcA7wdZ7rKbNEeDQCPJfMq2AaQVf
         uHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734805166; x=1735409966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWyNHTT7nGYtDukx/I19Gco3OvpuLD+raehZDNila/M=;
        b=Vk1zb5B26TJ9+4qDcq+ODdNqOdndFAjgVPcEEqBq3zp6G9dJvAdQLPPP7hatBs8enr
         3AzQhIFV8XWzdeVjZBSsgtraB2N0deBMPOb4Xe/uvNoLQgkFx4ryfNjAilSUF961lDnn
         YrqQ3KVdBnbZ1es5UYvcW6DSEvjAqqzaAMq/dOxc8X0PjHbk4Dz9GGLdzKwpNFW5+NWr
         fcBZrAN09/uAFHBpyIqSFTMfqyNP4l1Ukn6zDUoQ76YP5jLMQDuVqb3C1cHYr/equ2zY
         6qinWuoXJRbuOmehvRLPwfrCbIkDoTtbwnoN80r8vrJOxVEBRXjC8KjMsZCjm3+pMeb1
         NQog==
X-Forwarded-Encrypted: i=1; AJvYcCUIzq7p+9QwpA2nYRHtMz6SdVcoY3ny/KI5A1MEqepDJ6cvCp5jpbPQDLmI3LNRnOHA98IzyJeNtyZ3ebw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUCVLYKSVXlv+y3f1YISsFf3opEap4+ENMDpxO05sI8vpd/hi+
	aLtYREgb8vBvMHVSycA5wNPxCxDJ0Lm+d9xryRKC4WKQSjYn0Fyl
X-Gm-Gg: ASbGncstQ5FXZIMvYU90pOh2WLI9xzENWt241rVldpOMbvJ3ReO9hhnlxjTYnqZxECC
	Hde2ZuIKf+Kn35hxiSjamcEooWmE73Gfg3kkPRSkAkiQkFSN2IaMkw39Hdb4ecz6N7Whypx8xgX
	BCV4PwxE25Qf6c+wUYl3XeK5XZmqn60JUg8gCCNCFO0HWSqL/DY1OSiA+/MEAmeitySjZ/JVUNK
	RUlcj1S/A8Y/3pUdHTwSGP6K7jFI58qhLBxuXTgk9263/cmZ/MCuZdpiZSkiSwhCUZ4NiBg8P8w
	z2pMF5DLSlU3kpXqMXZZIdwaV3naE6ATpvI=
X-Google-Smtp-Source: AGHT+IELQbqY9pfnZFvYFabgLl/9tyOmsAYzPd4FyfUJVYLFioADGp6I0AP13+L7gVAjVA/3/+DizA==
X-Received: by 2002:a05:6512:4019:b0:540:202f:4955 with SMTP id 2adb3069b0e04-542295603c8mr2090518e87.46.1734805165576;
        Sat, 21 Dec 2024 10:19:25 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223832c5bsm794318e87.274.2024.12.21.10.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 10:19:23 -0800 (PST)
Message-ID: <3d1154e3-bd5c-46b8-8cce-4ede9c39de4b@gmail.com>
Date: Sat, 21 Dec 2024 20:19:21 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: gts-helper: add helpers to ease searches of
 gain_sel and new_gain
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
 <20241220-veml3235_scale-v1-1-b43b190bbb6a@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241220-veml3235_scale-v1-1-b43b190bbb6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2024 21:28, Javier Carrasco wrote:
> This helper functions reduce the burden in the drivers that want to
> fetch a gain selector in all available times or a new optimal gain.
> 
> The former is currently achieved by calling
> iio_gts_find_gain_sel_for_scale_using_time() for the current time
> selector, and then iterating over the rest of time selectors if the
> gain selector was not found.
> 
> The latter requires a combination of multiple iio-gts helpers to find
> the new gain, look for an optimal gain if there was no exact match, and
> set a minimum gain if the optimal gain is not in the range of available
> gains.
> 
> Provide simpler workflows by means of functions that address common
> patterns in the users of the iio-gts helpers.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/iio/industrialio-gts-helper.c | 74 +++++++++++++++++++++++++++++++++++
>   include/linux/iio/iio-gts-helper.h    |  5 +++
>   2 files changed, 79 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 3b5a99815062..f88b0b7192dd 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -915,6 +915,38 @@ int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel
>   }
>   EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_for_scale_using_time, "IIO_GTS_HELPER");
>   
> +/**
> + * iio_gts_find_gain_sel_in_times - Fetch gain selector in the available times.
> + * @gts:	Gain time scale descriptor
> + * @scale_int:	Integral part of the scale (typically val1)
> + * @scale_nano:	Fractional part of the scale (nano or ppb)
> + * @gain_sel:	Pointer to value where gain selector is stored.
> + * @time_sel:	Pointer to value where time selector is stored.
> + *
> + * Wrapper around iio_gts_find_gain_for_scale_using_time() to fetch the
> + * gain selector for all supported integration times.
> + *
> + * Return: 0 on success and -EINVAL on error.
> + */
> +int iio_gts_find_gain_sel_in_times(struct iio_gts *gts, int scale_int,
> +				   int scale_nano, int *gain_sel, int *time_sel)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < gts->num_itime; i++) {
> +		*time_sel = gts->itime_table[i].sel;
> +		ret = iio_gts_find_gain_sel_for_scale_using_time(gts, *time_sel,
> +								 scale_int,
> +								 scale_nano,
> +								 gain_sel);
> +		if (!ret)
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_in_times, "IIO_GTS_HELPER");
> +
>   static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
>   {
>   	const struct iio_itime_sel_mul *itime;
> @@ -1086,6 +1118,48 @@ int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
>   }
>   EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_by_old_gain_time, "IIO_GTS_HELPER");
>   
> +/**
> + * iio_gts_find_new_gain_by_gain_time_min - compensate for time change
> + * @gts:	Gain time scale descriptor
> + * @old_gain:	Previously set gain
> + * @old_time:	Selector corresponding previously set time
> + * @new_time:	Selector corresponding new time to be set
> + * @new_gain:	Pointer to value where new gain is to be written
> + * @in_range:	Indicate if the @new_gain was in the range of
> + *		supported gains.
> + *
> + * Wrapper around iio_gts_find_new_gain_by_old_gain_time() that tries to
> + * set an optimal value if no exact match was found, defaulting to the
> + * minimum gain to avoid saturations if the optimal value is not in the
> + * range of supported gains.
> + *
> + * Return: 0 on success and a negative value if no gain was found.
> + */
> +int iio_gts_find_new_gain_by_gain_time_min(struct iio_gts *gts, int old_gain,
> +					   int old_time, int new_time,
> +					   int *new_gain, bool *in_range)
> +{
> +	int ret;
> +
> +	*in_range = true;
> +	ret = iio_gts_find_new_gain_by_old_gain_time(gts, old_gain, old_time,
> +						     new_time, new_gain);
> +	if (*new_gain < 0)
> +		return -EINVAL;
> +
> +	if (ret) {
> +		*new_gain = iio_find_closest_gain_low(gts, *new_gain, in_range);
> +		if (*new_gain < 0) {
> +			*new_gain = iio_gts_get_min_gain(gts);
> +			if (*new_gain < 0)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_by_gain_time_min, "IIO_GTS_HELPER");
> +
>   MODULE_LICENSE("GPL");
>   MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
>   MODULE_DESCRIPTION("IIO light sensor gain-time-scale helpers");
> diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> index 9cb6c80dea71..ae91ad008cc8 100644
> --- a/include/linux/iio/iio-gts-helper.h
> +++ b/include/linux/iio/iio-gts-helper.h
> @@ -188,6 +188,8 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
>   int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel,
>   					       int scale_int, int scale_nano,
>   					       int *gain_sel);
> +int iio_gts_find_gain_sel_in_times(struct iio_gts *gts, int scale_int,
> +				   int scale_nano, int *gain_sel, int *time_sel);
>   int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_int,
>   		      int *scale_nano);
>   int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
> @@ -196,6 +198,9 @@ int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
>   int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
>   					   int old_time, int new_time,
>   					   int *new_gain);
> +int iio_gts_find_new_gain_by_gain_time_min(struct iio_gts *gts, int old_gain,
> +					   int old_time, int new_time,
> +					   int *new_gain, bool *in_range);
>   int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
>   			int *length);
>   int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,
> 


