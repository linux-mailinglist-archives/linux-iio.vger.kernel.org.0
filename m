Return-Path: <linux-iio+bounces-13944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA0A03347
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 00:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A51885ADC
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 23:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0E81E22EB;
	Mon,  6 Jan 2025 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ImDBoDtN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1981E102D
	for <linux-iio@vger.kernel.org>; Mon,  6 Jan 2025 23:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205727; cv=none; b=B27sf4iIa9wp8BhKU/uLEZUKz+ujoL16ANHkqjNEfE4oO7Y/6rGuevHIbgqnC9Y56Wwpj0goh5Yfz/FZor+g47B8lLL36hjAtp9vGQ5grVdsnime4lZrWFaMYxn3oG6luNbjPeGAXiogxmIIejKhV8Ijs3i9TCPl8FhxlyCLExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205727; c=relaxed/simple;
	bh=CX8YutDXF5szLK0tDyse/s6AXzl1PWiu+YpgRlJyaRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L45HghH42L3ZRBRJehlznLOEnM/feXnTwPRShapS6lXZnRJWfS6/7laEsvFzXO90SsOZjSC4yMz0D7O8ZhLTrPHmd/izFT8b0r9DeKvIx2t/mLFpUmgOs/+UQNFPAF54T9AVDkyo4pNW12C5yAECnG2hAwvAffVUpH/yO6S/DmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ImDBoDtN; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29fbba47ca4so6775097fac.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jan 2025 15:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736205724; x=1736810524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94fDD3ujqsO3OXPfurlhcgUIk/RNFAC/tF7wz2Zod8g=;
        b=ImDBoDtNQ4l08nQzozhIwCqI9v9oItSPVD5Ggt08xDRsFLJFfjkzkVDrEyURPb0A6C
         ekJiiY8dTr8RrEalLRSlJkD9Vw0f/AOgSMs6yr/lLF+8vmG7CVmuVwzY3SnhjIXVXhvJ
         5pVoEO4XuvcHBfSovSp877AtPNQOoiWZc3hj6HOlHiUVfZjZE6KjpgYUXU0pnxARmgzy
         pAgxg8zhQe+6nHERJpi3MoOrqBHsjcz+2q32emWv3V0I3oSueHy1ovmgqFNpphikRYhR
         VqmXjS+ahHPjIBqjrpClnP8OtL39fHjd96xtoZNMbuqYKUowLch/b07evU+cxc0p806R
         LNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205724; x=1736810524;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94fDD3ujqsO3OXPfurlhcgUIk/RNFAC/tF7wz2Zod8g=;
        b=eyM9DOII3Fq66RVc9/EGR2GZtpETQ43lv80cR7QiwH4mkFYTHctLmA4qK8sO23VW8T
         T7To3SdAikEHAReAkt4WVfCQgVUjF70LMB4+nqQUr/31p6nNS/qubS+fvNsQGicTA8ar
         b3guTdstgGdOBrafWmru6y4qWLIK1XnV7ZDohKW7p/Lnclr6RawNiJ3FggQmWfUcSCOQ
         WVeNTpTC5gU8tp7SgeJeuJFw7ktWHqqStoLFS6X/gcwaA2Wsse9RNHQ1GjhUkQ5CJFNU
         +WSNBeSljBU5fFTU3/HZXKorexgC4m3GVWe3bsMPFjXB/E0DsqgO+YNcMKL+Xk9wOP1A
         HIUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpMVU0SkqhALOuEH9yb5AOoWa5q4Niss886hw6+Pp/6NREj5rvZirzlulrXKq6WwVaWuT7+LPKEGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznVFQCOOlsS/Use7EPLpZN9cT8a83GHH2sPd7Ldu3b3vChHlfn
	hB+0irrNGgQgunOx7mTrxrMkapD1eV7Ea3ATXqegND1se2lNKPX606l/I947+R8tFDAQoGsrtB1
	/
X-Gm-Gg: ASbGncsL/hkFyqRBne+bVKLnkrn2Ie/p4FP6uUfqCjPulE2f0TpjKSbXz92H1vwb600
	pHYimKHb+czJd+Y/0K6S2z4IkYzC49gWshQApGYYg6g4WYXs4+nlaUB5zcp066jGgqXsc0QnUPf
	H5l2SbYsOmYK6tIRJYwqTQPf+QZNuaU2JQ+1HrNz8tsYaXiXK9kfk3E0veu4dxM1EXiCqAOyubx
	4cPU3hu0ACgWn+3wEC7niMIGoYREqkz3sVTKFy2SF83Jt97L+bjDsv3FAtToyKZepdTNA5mUIRs
	VQ5Q/jLIzTOXz51ewg==
X-Google-Smtp-Source: AGHT+IGJ642l6O5VyVJWy9qRXl9eE2uwhTPQc0i4YqF/MLAvNPmSwxy42bbjbLcmdKqs8l4z1LTm/A==
X-Received: by 2002:a05:6870:5691:b0:29e:2d18:2718 with SMTP id 586e51a60fabf-2a7fb2f9e64mr30652558fac.28.1736205723757;
        Mon, 06 Jan 2025 15:22:03 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a7d74c1fdcsm11946356fac.17.2025.01.06.15.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:22:02 -0800 (PST)
Message-ID: <d760f728-9519-4b15-b9c4-585acbeb8c00@baylibre.com>
Date: Mon, 6 Jan 2025 17:22:00 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/27] iio: chemical: scd30: Switch to sparse friendly
 claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-3-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250105172613.1204781-3-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/25 11:25 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver caused a false positive with __cond_lock() style solution
> but is fine with the simple boolean return approach now used.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/chemical/scd30_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index d613c54cb28d..cfbf2f5e9443 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -211,18 +211,19 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>  			break;
>  		}
>  
> -		ret = iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> +		if (!iio_device_claim_direct(indio_dev)) {
> +			ret = -EBUSY;
>  			break;
> +		}
>  
>  		ret = scd30_read(state);
>  		if (ret) {
> -			iio_device_release_direct_mode(indio_dev);
> +			iio_device_release_direct(indio_dev);
>  			break;
>  		}
>  
>  		*val = state->meas[chan->address];
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_SCALE:

Could do with a precursor patch to use guard(mutex) to allow returning directly
everywhere and avoid break;.

