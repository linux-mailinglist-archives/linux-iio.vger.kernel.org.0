Return-Path: <linux-iio+bounces-22406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29924B1DB48
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 18:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AEE585CAC
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0121273D68;
	Thu,  7 Aug 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j0enLXZF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65D26CE2C
	for <linux-iio@vger.kernel.org>; Thu,  7 Aug 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582586; cv=none; b=HfwTyVMeBypAX9GyASsdEvxm+Wp0JYMNZD4IP0xfwJ53A8HqWdNXLnmx9O6TnftBEpl+5wFvLUyuaQaTggPwedn8nSRkAIEPAMicYiM7+TtIVSoJ737PpdZuRiq2EGZK9S2WS90pPEXbJ9SbGtWl54EEGf2R7dv6kXKti3dn/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582586; c=relaxed/simple;
	bh=SmbMv/qdEz28m9GrWcI4c2WD55LP+jRQUDQcxubXHCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bObBlu7pISD+08RXLdEStLci4vmtr1vTbfIrawPgjISbiVSlogOhPIWb5292/oA7NLiwaHRy7zn013UVRvpqe0PTL9xegDvq1dkGnJducACc0h7qUSXeb7L/k7l7dohCk2YnauDGNLQwUZm/zAxfJa65ENqL8iEERsR88RKQF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j0enLXZF; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2eb6c422828so1678960fac.1
        for <linux-iio@vger.kernel.org>; Thu, 07 Aug 2025 09:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754582582; x=1755187382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IiA/OxVAqFEZu+6RNkj75UQ6W/OZ49cY1TnC8j0a0xo=;
        b=j0enLXZFkwlMEHVqCs9FWUWuz6ZLTouHCgw7L6KuArVnA2FBnaIqTpsuTWmv9Zd9Nz
         zBtjxqMYYVwuSkqb0TkQEPlSdLW6F4ddV/icQG5MMwBh6vdatXpXGKR2TUh0aSbTER/y
         YlFf4qYvoFsahBFONizVbtTjCaOm3lQd+P3YHjosdfeUtehI2hksCc4vTmvLt5EKjrYX
         X9wdB+j6SjPOkF/29jA/t7WBWAL+yG1OAEQQFBJVRHYAkQZ6vmEmxM6ttOKfM1nqDD3Q
         H9zfi4+taE6N2wZfbSM0bfQb3QtbChxeFYdpxu1FmadI2FFw54LK+WH7w1cV0HlTbHVW
         My6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582582; x=1755187382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiA/OxVAqFEZu+6RNkj75UQ6W/OZ49cY1TnC8j0a0xo=;
        b=KzTMC2zr9dU3OtM+QAuHlT/cQGuHyo43AggJY+IZZQXwydd4i64X3ut9xa1cUoZDPp
         B3wyaLfsrBEOHUTv5PxF3e7lc0eoyW8kvbnbf8rHFE3b2KSq594dRSFC6kpgBYdg6S4v
         Lw0bIpa760YVPtpyngQpylieoQtW8kI4J4Qq0jZcFqxU6I9EwBdDWZa0OWleCoKa+/1r
         dGlPrNqK4mqu2gm2uABDuxrrvhKu8qytQgOag740XmpB3E+0q05SQaVqDiOxNEYNOOKV
         2JQznCRSRsppFGr8/32Ilpa/YKJKITx8ozKi4N64k+QnwD3XQTJMOO2TsPj60D0ZeJjg
         ienQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA/kSy/rrnNlRIixeb6dg2vLrIDas7CCtH+d4axfvHLkQsulImjA+kDPkt7LOMuesZ2wfdNmcjSYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwfdmO7g1bwcWtqEjPqGmsMbJNvkh6butli/XxFlIMFxwXVGL
	UK0bre4QyvklD6O/MEFVy0+S8O+8ChI13bahTTR/B5fOPrzYCtzcsaB4NYlYS5BeFbs=
X-Gm-Gg: ASbGncumgaE6IqNEYFoWPYqmOn/cKg1b6kcN6YTGjO9X5Qy2dyhDVGoD+I8z5BpwK+l
	MCiZo36xFHPsKUZxRu82EkTlF3B46g8gyYcjdHu/QqKirRBdo15N+uXLQqgF9giHKpk1j5zWz3/
	AFRWfrVJ7zOHY5NRF9CQwMt7RDvZkqcd6RcG0l2QCbbuHzQMJYjlpsy+sJjtQhbsLEqPuFURRTX
	BUiri1EMdwL2izLMgLkqjLai7D3GUJe/C5WGEKDm+LUPsm1QrUGhfCBEoDxfLvb1j419WikFXfT
	t8i+zbvkPCcgIUESafXYKTc5LdJ5idyQf6aXznDKswekv6fZ9VQ6lEvudt7Jl5QUKH7mLX5eChg
	Fzawpuh0WWDGTk+CLgk7p7EqGvLyoSVJVFMy31926FWTmVZb64EuYROE58wnyz541hFN393+p2L
	o=
X-Google-Smtp-Source: AGHT+IEDd9iWnbMRuwQ1lQVibSMLGfaiPKZhtrHEAEpQskYUkoxN/o/4EBgUPXTI+PhOLsKX+tnrsg==
X-Received: by 2002:a05:6871:24e7:b0:2c2:4d73:ec43 with SMTP id 586e51a60fabf-30c004ddf0bmr2547212fac.15.1754582582003;
        Thu, 07 Aug 2025 09:03:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ce54:d09f:5709:ac85? ([2600:8803:e7e4:1d00:ce54:d09f:5709:ac85])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30ba8228a79sm2726450fac.35.2025.08.07.09.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 09:03:00 -0700 (PDT)
Message-ID: <fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
Date: Thu, 7 Aug 2025 11:02:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to improve
 error logging
To: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJReTh-t5D45aZNV@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJReTh-t5D45aZNV@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/25 3:05 AM, Salah Triki wrote:
> Use `ERR_PTR(ret)` with `%pe` in `ad4170_read_sample()` to properly display
> symbolic error codes (e.g. `-ENOMEM`) instead of raw integers (e.g. `-12`),
> improving readability and debug clarity.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> Changes in v2:
>    - Improve commit title
> 
>  drivers/iio/adc/ad4170-4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
> index 6cd84d6fb08b..6296b5dc930b 100644
> --- a/drivers/iio/adc/ad4170-4.c
> +++ b/drivers/iio/adc/ad4170-4.c
> @@ -1253,11 +1253,11 @@ static int ad4170_read_sample(struct iio_dev *indio_dev,
>  
>  	ret = __ad4170_read_sample(indio_dev, chan, val);
>  	if (ret) {
> -		dev_err(dev, "failed to read sample: %d\n", ret);
> +		dev_err(dev, "failed to read sample: %pe\n", ERR_PTR(ret));
>  
>  		ret2 = ad4170_set_channel_enable(st, chan->address, false);
>  		if (ret2)
> -			dev_err(dev, "failed to disable channel: %d\n", ret2);
> +			dev_err(dev, "failed to disable channel: %pe\n", ERR_PTR(ret2));
>  
>  		return ret;
>  	}

Interesting, I didn't know we had this format specifier. But I think
this is something we would want to do kernel-wide or not at all to stay
consistent.

And if we are doing this in more places, it would make sense to have a new
format specifier for integer error values instead of casting them to
pointers.

