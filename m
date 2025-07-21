Return-Path: <linux-iio+bounces-21835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D67B0CA2B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8844A1889995
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175AE2C08D0;
	Mon, 21 Jul 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PakhYktd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B1C1607A4
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753120749; cv=none; b=hKrnX/NZHQh98J7TCy9AyvuZunxy+qiF+keeMelJJT5ZCvsgPx9unAfAcltOb7suieUJwrtm0SXlr5s6sU5FZvg4r8OtMAg40wxn7bZQtP0KpOEOC3cpOv6RrkNC3iFldCmByRJE+vdrq2a3dLTjRoU5+HovF0IuNKxIOhEswiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753120749; c=relaxed/simple;
	bh=T5guu2QPuE/A1iamSqRr2YPKDo8sEtIbICaOWhYZZQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1dOjLfjOm6mtqo4HM7fvP2sBbHb+e8yzx6P8UsOrzSwTcOkZSVwymjn6sKCwQkHxyoDy9jDCF9yKx+DH3+DNtpY/jBMIbgMX3HZsGANA3EVh4xhZk5cJhYEiuoTeaFhOUBC4J2cFc7d+E+YgxJWeuHbH7VvaWDoOMEpO32K4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PakhYktd; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-41eaf6805ebso2009155b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753120746; x=1753725546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7hl6QIgCfgw9wGmzX4fBBBDbussEjoveKf9kwN4pyg=;
        b=PakhYktdIzdKsa6cfeQQJvOGZyLB/7d/ygksRgITLMsWHdeFD11ZMR3v2TzAUBOtyL
         7i523sWSZJqDUy5uNJ22MDUXsycWbRVuo2peR3M68QoqTAa6D9OAtDtO+G3NkE952Bs6
         RAPIMGo6YHOItKdN3/OH0+UwSvN+w2TC5gUetntPFGoaqnMit2MNHABGOOuzPIH39Mhk
         w0saFLnrVsL+GSymK21NFO8w6dQmhTyQve2kGs7qgiHXIFPTPQMG7PPMES+cr3Ijj8+T
         5X/83X3k0XJsLIQsGY3GpwPzs0scTqmcsIZ2EEt8kbZLDDluw4OqCF2SGMc/aYsexhCL
         nsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753120746; x=1753725546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7hl6QIgCfgw9wGmzX4fBBBDbussEjoveKf9kwN4pyg=;
        b=Sbor+eNHVAr3c162DBqd4XzKcGlskolGCCPXhMoHkB9FWhiIppIJbMS4BtXMmE8GAv
         lNyZB8fyyOJ9IVJlSzNp/7bcasVMvtAOkie7Aj7KXOiLn55+7i+16J4INzX9G4oqLEIT
         8BZyYH2+MD7gbfZFSQx2b3c+FqetXwGhgTu8RX9gstpdPZQ68Ehqpcdq0XvCMOr/04Ak
         T1qk4SkJuqEZPxQGnJTO6zOxf1aHEYvLFz6e+eo7uwyGTCM14HgMPUTo9HB1WbhIsRJ7
         5hWUUSC1xgaC3yYUc1s7oMyOb/wlUmf/zN0RHlhGGIK3y1JRcUt4oH0gAzwfHfPau4zC
         q4aA==
X-Forwarded-Encrypted: i=1; AJvYcCX4xoX7bWcte+J7d61EYoH9vJ6qpgwQc2j5zXnxTOATsJauSuum2sMeljZqaXC8KJ5uRQF4r+jcYOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWh2tM/elau3B5YY7sJGb6tYx8kJ0j3MIz2vMcevv7gTkMwVEP
	4pJr7mfd+rjbzo7h0avSdO+n/AuRrK0OUdMWMRj19pipcmeagmXs7k2Y9My2pmJkIT4=
X-Gm-Gg: ASbGncu+Sg16wGB7EA0vwHDeSO5Ca/3i3nK3D8yOQSpXU6s1487NLgJ/30TBeTujbXv
	qMU/RF043mdteo+u1p7x5zNfC5Czz5IC0jr1ShIsujz2fVZAr0p497DCel0F19Otl9L7uWhzq0r
	kfTc4qxxxIeE6KPjdy+V/NE1/hiPsFuzddUrzS5rTkQarEtP0Rbdwi45OZ1Xr2yO9I810uH7kmH
	P/HipGchbW4RupCrpNlzxJg3zkY8skgCJc08uBXp+O18DaIloplgLBnDMzEpqufUlboQR6fw8Pc
	5RBC3qwQtpHpY6rrPwqcVVYb8wi5fZL47NXUqkPPp1d6Lppk6Fla0xP5aDJ2IUJk8tY/WCLfSyo
	LZYCyBaGKuyI35bvznQcbUVmLtk74UKg6oyCx9OMXi5mNZvpj2lPcddf43JpyY6AbgbhzjjLNOT
	g=
X-Google-Smtp-Source: AGHT+IF+V8Vo9s+uN5JpwnzGcq8Tsy3wfotf/BIAZd1AeC27xeQxm2FOV4VJH2qcTb6jBXfKi/AsgA==
X-Received: by 2002:a05:6808:1308:b0:410:f243:a502 with SMTP id 5614622812f47-41cee2765c8mr14499777b6e.8.1753120745654;
        Mon, 21 Jul 2025 10:59:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb? ([2600:8803:e7e4:1d00:3bea:f296:60f2:c6cb])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd536d613sm2691362b6e.36.2025.07.21.10.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 10:59:04 -0700 (PDT)
Message-ID: <73409000-c68b-4c22-966e-aaa56ca3744b@baylibre.com>
Date: Mon, 21 Jul 2025 12:59:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: Improve iio_read_channel_processed_scale()
 precision
To: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250721150614.51918-1-hansg@kernel.org>
 <20250721150614.51918-2-hansg@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250721150614.51918-2-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/21/25 10:06 AM, Hans de Goede wrote:
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
> Changes in v2:
> - New patch in v3 of this patch-series
> ---
>  drivers/iio/inkern.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c174ebb7d5e6..e9669f552eb3 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -714,18 +714,36 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
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
> +
> +		switch (ret) {
> +		case IIO_VAL_INT:
> +			*val *= scale;
> +			break;

Just return 0 here.

> +		case IIO_VAL_INT_PLUS_MICRO:
> +			*val *= scale;
> +			*val += div_u64((u64)val2 * scale, 1000000LLU);

If the processed value is between 0 and -1, then val2 will be negative
(val is 0 in this case, which can't be negative so val2 contains the
sign), so casting without checking the sign first isn't safe.

Also, would just use MICRO from linux/units.h instead of 1000000LLU.

> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			*val *= scale;
> +			*val += div_u64((u64)val2 * scale, 1000000000LLU);

Same applies here of course.

> +			break;
> +		default:
> +			dev_err_once(&chan->indio_dev->dev,
> +				     "unsupported processed IIO-val-type: %d\n",
> +				     ret);
> +			return -EINVAL;
> +		}
>  
>  		return ret;

And drop this return as all cases should return directly.

>  	} else {


