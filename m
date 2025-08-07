Return-Path: <linux-iio+bounces-22365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C05A2B1D0D8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 04:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978F318947A4
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 02:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8881BE23F;
	Thu,  7 Aug 2025 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UJinqgBH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FE515A864
	for <linux-iio@vger.kernel.org>; Thu,  7 Aug 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754532449; cv=none; b=sfT9S4ha2gCTPA3CkAdYWC/ZcOAkaFqnGbxFupNJ1SHtRXVWKyA8T5iMQNBL5InTncHp1bsaGLiGC0BmbofD4KPo1DZlbaBQGwotl2jJ7eKYcZVmmw15tcEjs4+I91uO68XU+zQzRgb7jyp25cH2jiFSHkEntCrwTTU9nZ+AEBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754532449; c=relaxed/simple;
	bh=HBtduZm08CzNWE71PmJ3hjXi+bmiwcXHmAvy9wR/cew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KNeYyiui9rcJOFT3Io96HGjO6jFjDmX3Zh1YrkhyBl+Np0BkGlgofc7Ly/Ea9ZbNke6vZ0/hZpdU51t5VbtXuLJTG+Rw6cBYb/C4Kv561X4crx6wCtJDmUTtcU723e6EUqffWUsXA7rBNMVqJ/rJgYhvz/fPVN3Cw/PFg/FzJrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UJinqgBH; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-306ab1b63fdso349318fac.1
        for <linux-iio@vger.kernel.org>; Wed, 06 Aug 2025 19:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754532445; x=1755137245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lxZC3/m+cJBEpmd6BJGiG3LzJfwfvLfaDT4UZ4rJbk=;
        b=UJinqgBHqLxtzCDlodKaNphJeCxqnUosuU1fAMa0n/BuPboBqZGOn0iy66ove9CWtW
         +htLX2Lzv7wmbpi14wbUbSgal5bEOGRFIV/akUrv9d4/xbxA9yqtBm9wfQ2rfcNtuMXD
         UMpScedfOrUaWvOxQGweDGiMjd3ftEoUDWfz9L445I8si5tZK4vrQCqqVNIvITBAt0Qb
         IffsSsTusYBpM1d0MdmmEQI5gvQRm48pPEMssPya8l9elQyJQjbKpjE93ELE8DskYJci
         BOVXAIE1tqoY0HMZyictTK2wRedvQxZozO/VBuLxirdAjCrI3ObpILo7cZDQvcBcVjNG
         6HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754532445; x=1755137245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lxZC3/m+cJBEpmd6BJGiG3LzJfwfvLfaDT4UZ4rJbk=;
        b=fwjqZLV/PuFL66cfJpObsv6IsXozbxxDAF8+Or2L11zukv0LYt9hZPwAxc42eOG7qi
         k/SdjSra0uUCIZ6yXVLmJW/vvrssiXzuk2HXADI0IxDdgUu1/bw6ULvxhh9siLmriM0x
         k80X+cvVSL+seiLT2tZWQNgD4vewmFNqUwe4Y5/WJLroypfGeOwM8zGx0wTH+hwuybzK
         gPuX3Ug/7We2KajBMr4L9E4f9xumaqf4LtRPkVe/peU85hoUdjxiGAfQ7zjM3kyklMFl
         WmVJQRGMqVSO69Q8eWs1Dv+Z7zmoY6H1kk2BaLUqvcGf9Ye8rzDuS60pMTZyNTii9VIP
         PVCw==
X-Forwarded-Encrypted: i=1; AJvYcCXbEU/JJo1xaZG80dx9TBGXa6Rt26Ij6LKlurdu+dR67elbIEf/2omVfttbTxIlZJwLwMkL8RbSfDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnh3wZY708r9jEKn0hzjLeDduBe18FD+s4hkZWGef8Lmdr5shf
	h8eD4jrMrHULG/L2lgAINWOTTvU0T70iuJNHvK5wkRFoxY1A4Txj7Tfh+XruE22ymZo=
X-Gm-Gg: ASbGncsRIjTlinrlXbcEhvQDXfE4uXL67w1k4amgiIrOYgP4mzVI4qCkl1RhQtwnaxi
	zwFLhQtVjGIayWnOtTZHLql5kgiyrM3VJ4UEJhnPNRAioYwrXcfm0piDMDo+VdLUs5G578kWgP8
	VFL8gSrP0fmD6k6gYiaUb9OjFMkZzXokQEEiYTT2lw0rrFSp4mIrnnlFxCsOD4k5J8ZJj97xbYz
	71yhVKMqvaXGplYzBYeJKYLmVHHf7BqtI/R4vZYGBJoLfyO/9a2EDA1zvATuKXt2gZHCA/by7tl
	eEXu9t033PF7jEEgvQVJG8XuYx4grfcmrfSWjGJa1jUey2lITS7zMpcGPnXyjRYygi+U+dlDTtN
	Lb2OqszMhCqCZaAWUXchLj2YWCfNf9tlKgJRWLPbMMt1XhWqH9wALasU0dUt3eAH1zr8girAhXe
	kXIFU1KBy1vg==
X-Google-Smtp-Source: AGHT+IHiJ5GYT+LDy0yvZa+3XXEXuBRlcKah5N8pdvv4QHyH+wukBVKdpxhP94RWeXsr6iK84NuLOw==
X-Received: by 2002:a05:6871:a591:b0:2d5:336f:1b5c with SMTP id 586e51a60fabf-30be604107cmr2814704fac.34.1754532444965;
        Wed, 06 Aug 2025 19:07:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-741b3779730sm2209142a34.50.2025.08.06.19.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 19:07:24 -0700 (PDT)
Message-ID: <d2b3fe8b-9f86-4b39-ae95-399cb7da685a@baylibre.com>
Date: Wed, 6 Aug 2025 21:07:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad9467: Replace PTR_ERR_OR_ZERO() in
 ad9467_reset()
To: Salah Triki <salah.triki@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJQDyzoxLsF8nKYW@pc>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aJQDyzoxLsF8nKYW@pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 8:39 PM, Salah Triki wrote:
> PTR_ERR_OR_ZERO() returns 0 if the argument is NULL, which can hide real
> issues when the caller expects an ERR_PTR on failure. Use a ternary
> expression instead to return the appropriate error code.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/adc/ad9467.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index f7a9f46ea0dc..70aee2666ff1 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -945,7 +945,7 @@ static int ad9467_reset(struct device *dev)
>  
>  	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR_OR_NULL(gpio))
> -		return PTR_ERR_OR_ZERO(gpio);
> +		return gpio ? PTR_ERR(gpio) : -ENODEV;
>  
>  	fsleep(1);
>  	gpiod_set_value_cansleep(gpio, 0);

The existing code looks correct to me. The reset gpio is optional
so early return of 0 when there is no gpio seems fine. Changing it
to return an error could break existing users since it will cause
probe to fail.

Also, if the original intention was to make the gpio required, then
it should just not use devm_gpiod_get_optional() and simplify the
whole thing. But I don't think that was the intention.


