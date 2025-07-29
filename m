Return-Path: <linux-iio+bounces-22131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CBB1520D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 19:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 367C97AF69B
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1EE227B83;
	Tue, 29 Jul 2025 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WwfTKAHC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0761E3DF2
	for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810003; cv=none; b=GbLR9V1k/Q4e56YI5tf44alCFO5PJhD4veiQBpTjnJ9sgdjwY6EXq25HrHss5Ki7CqF2VCY3XhJENXW9cso3C9V5l1VjWFUf1DyXeAjqhblqLrQ08C/W8oF0Jh5Xh+T3ZuMKZ2x2zEaug0zLVnKLU/UzIwxZM+TJhJ7APo3Mr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810003; c=relaxed/simple;
	bh=ew4hoa0ZdqwplXKs3BigDkOJN17hxuJuh1roJpZ1EjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1XsChN31ZYgsr7iY3NHrtC90Wuq1thSt/iw5VS4voJh0qi4LMDRcC9ci+J3IhLz12EvCdBZm+r7dCW72kjImW1ARwaEny3Vqplr565UZVAFyYozN/fhcBhoY7TSlsHWgUIpAXXZJguKqWV0T1GrbECHD3hQU+KOj3h/kxgWObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WwfTKAHC; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2ffaf8283faso3469404fac.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Jul 2025 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753810000; x=1754414800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzXELiw3qA4PbUb5xwvnbt17FsZ4ZjrhU6Zg0sEBzlY=;
        b=WwfTKAHCo9cl54ipfAP2hlmw1Ns4no5g0jp5ReOLRzc7CzXLoUuZ9f1Bo4ry+qypKJ
         vODsVFJXPA0hpnbRQ6bKH0jfDbLGbiHi+3fiA8AVtYZ+tVEWO27c1I3fnfJd5v0jxY33
         Mlx+dg926oQ7hDp8SYkEAibxaNOsqD81NxMMWqO84S6aCoxvVeryAEv6vKRWXZtAB2lV
         NYn38E/+z+EhiXaCXTArNJRciaEbn3eqW0LYWCLvkrOTdjQgB+WL5lMtbkJ6tm71UNK1
         UM6KzZOxOLIiO2fI8VDdFZ1cqmSOdYycUlR/vtrGn/UkLxJH/cAjlWPbWWfhWziNm4El
         8DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753810000; x=1754414800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzXELiw3qA4PbUb5xwvnbt17FsZ4ZjrhU6Zg0sEBzlY=;
        b=lm9g6moY/feMu/mp6WR49NSRUUk5FcYpv+10wGNzoChp5FnUZ/F7GyOcuHoC0qhsiA
         1I26xfQwV42ZHX6omzLkIwB+jw6CtDzbNH+5701HyNGA5vweluUfGwXiY0EX3TlmxmVX
         JyAL0abjf13x72MOoZ7O6fhlQNQfVQyMH2jao4lDSlvxpi1XHTG5hb5vZ8ChGBpv9aRT
         /YaP+Mf59ivs9VLRj6gUQdzTJjITnDXyw3ioF1ZHax751ofOvNel5/bBTZz/IsNpGTAe
         GCnI+tp0poWL6gysBNLiCOpHmAX1JvCKD6j+7FqcDJlG/VxM+YxGdQEunPjeOYBrVwZx
         ZLbw==
X-Forwarded-Encrypted: i=1; AJvYcCVNSK3mUw0ePym+WcDtf/95ILxzMD2EqCg9h2ZU+mbMmwG/etHTgGVcKxYuBipyo5XwqRk1GVxvDOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnhpSCmQ+y3xFVBQj69qrgXyrucAJEtD4Z+hGr6G2BUTYTix/
	zxIkNCs/Pa/uU+3+w6ZdlTwj8VPfH8DLRqkBpu6A9hFdYLcwnNGbdE2oqd9DjSe2MfwP5rRf/dy
	oS/NY
X-Gm-Gg: ASbGnctUbu1cN7UCwUk7dbNtQvbtMHuFoOc8G7Eu869rXqHmRBLm8Tc//LoZki8sO+H
	fCSVKPRLFLJ+ZxZ7OuftPbwNpn0vwNcgb5NkhEFpmndWPahK7Id6+LG6S5DneeiDhJlnrzWMQpg
	tmlNaMh+zAUWx8/6yjNzXxmNWL5tEQF4Yww9s5R7D59VkXvM9vg1HB9RQRPwLuQ1sGvoEVJulHR
	CX/0NoZrWEjNLMIaKbOYLoyE2XD6NOxICnTVajLlIcf7+Zb59sKciFPNIC+hSWdKrOwB/gycGYt
	5TuPdcK8LDtmyRvLAjXb4+attTEj0eJjl2ONbm8d2T+2M7weDID9Q4MzY2beumPsaJd+eeoYbfY
	piTJ3v9CkrBYmm/w2i1ottNYcOEZkaUHKI8Q6UGsVhbK8vnUQb9qXdcm94WvUx5x24F1GZQIB1o
	M=
X-Google-Smtp-Source: AGHT+IFMEOfgpg8WrHn8rWtBrrRI4U6xa36WgD+HAwMOPGOWzvwSZYGyt2acwLN+C6ktG2HDCgyHZw==
X-Received: by 2002:a05:6870:f20f:b0:2ff:a6d7:52a1 with SMTP id 586e51a60fabf-30785d56c87mr147234fac.35.1753810000263;
        Tue, 29 Jul 2025 10:26:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54? ([2600:8803:e7e4:1d00:c7d5:61e1:68d6:dd54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-307136fe57dsm2277973fac.35.2025.07.29.10.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 10:26:39 -0700 (PDT)
Message-ID: <de1b173b-d6fa-4ebf-a399-262c035ecef8@baylibre.com>
Date: Tue, 29 Jul 2025 12:26:38 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
To: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
References: <20250727210639.196351-1-hansg@kernel.org>
 <20250727210639.196351-2-hansg@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250727210639.196351-2-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/25 4:06 PM, Hans de Goede wrote:
> Before this change iio_read_channel_processed_scale() always assumes that
> channels which advertise IIO_CHAN_INFO_PROCESSED capability return
> IIO_VAL_INT on success.
> 
> Ignoring any fractional values from drivers which return
> IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO. These fractional values
> might become non fractional after scaling so these should be taken into
> account.
> 
> While at it also error out for IIO_VAL_* values which
> iio_read_channel_processed_scale() does not know how to handle.
> 
> Signed-off-by: Hans de Goede <hansg@kernel.org>
> ---
> Changes in v3:
> - Use div_s64() instead of div_u64() to fix -1.0 - 0.0 range
> - Directly return IIO_VAL_INT from valid cases and drop the final
>   return ret after the switch-case
> 
> Changes in v2:
> - New patch in v2 of this patch-series
> ---
>  drivers/iio/inkern.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c174ebb7d5e6..46900be16ff8 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -714,20 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
>  				     unsigned int scale)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(chan->indio_dev);
> -	int ret;
> +	int ret, val2;
>  
>  	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>  	if (!chan->indio_dev->info)
>  		return -ENODEV;
>  
>  	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
> -		ret = iio_channel_read(chan, val, NULL,
> +		ret = iio_channel_read(chan, val, &val2,
>  				       IIO_CHAN_INFO_PROCESSED);
>  		if (ret < 0)
>  			return ret;
> -		*val *= scale;
>  
> -		return ret;
> +		switch (ret) {
> +		case IIO_VAL_INT:
> +			*val *= scale;
> +			return IIO_VAL_INT;
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			*val *= scale;
> +			*val += div_s64((s64)val2 * scale, 1000000LL);
> +			return IIO_VAL_INT;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			*val *= scale;
> +			*val += div_s64((s64)val2 * scale, 1000000000LL);
> +			return IIO_VAL_INT;

I would feel better if we had some kunit tests on this function since
the negative values can be tricky. I.e. something similar to
iio_test_iio_format_value_fixedpoint() that tests the 4 possible
interesting cases for val and val2.

I think that would find a bug here. For example, if the processed
value is -1.5 with IIO_VAL_INT_PLUS_MICRO, then *val would be
-1 and *val2 would be 500_000 (before applying scale). And suppose
scale is 2. The expected result would be -1.5 * 2 = -3. But the math
here is:

-1 * 2 + 500_000 * 2 / 1_000_000 = -1 != -3


> +		default:
> +			dev_err_once(&chan->indio_dev->dev,
> +				     "unsupported processed IIO-val-type: %d\n",
> +				     ret);
> +			return -EINVAL;
> +		}
>  	} else {
>  		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>  		if (ret < 0)


