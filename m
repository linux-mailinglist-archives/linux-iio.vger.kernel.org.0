Return-Path: <linux-iio+bounces-27674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55197D19D11
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A01143005189
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A1E38F92E;
	Tue, 13 Jan 2026 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LMVbzxrg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2922083
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317602; cv=none; b=bO13QQEKa0maB7GWVIlGs7t7w2DmGmPA+40YTL6Dz9+TOCjwQiE0JjkUTKWfYYTR4JKn1QhYMuuS6vGiusjVvhLo6wv5ZHUg/E5QfeZXXA+6gJGxTusHT0THthQtXQ9XjIh08dR6e5gt6K/irLlUvGrknGVS/v8T5q5+bvszY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317602; c=relaxed/simple;
	bh=u9QDlVi5vshsl+vRhqqYxfjpSezB/lW7iF66MEmIA8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN9wLpgIVRqH+mvG0utj9E9ZWfQkCx07bspJfVOS6ValXI60NHcKn3+2oq4EYhw5sFdI576F6i9DAay+CfTfF5+HWoaNSklHR6f5ops22b0qwSAVgYaPYYZOiqbLUD32fdWaW9wsCk53fzeAAliEx0eqAKvmp+QyupgBZWiu4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LMVbzxrg; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45a3145faddso2319562b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 07:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768317600; x=1768922400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jyu7NzFFuKWq53tGsr5pg2vni176XxXnsvICQ50qCzI=;
        b=LMVbzxrg4bWkZAy1sHPi1J3Aik5C4kGVfzwnuZ8nnWcB7fj/o8NPgzXilzpt1J7a0Q
         /IUFwWlBvHKVBkwSq3inO1jixUIQFHLfnFceJy/KavsB/8ZVeHSn0Cjn9zHMM7G5v0sM
         Ti14b8LRUQVKPro5VkXSwnfMwNCq7sHcX0Ed2lQKNHlmmGwCOQ/yMcxeIXmKnThWZryD
         Hixb5uxf8goggI/n61ioai3GEnNMORtrmavhUB7xQ1LC4kCi5oxakkUMXJOAzj3Gcx07
         Bq2Ictovo+PLUAjIKYUe480oNWpfCAfX+JPwLIroPkQi01SCnjHErsVTfSH4dhDaYcvC
         1f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317600; x=1768922400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyu7NzFFuKWq53tGsr5pg2vni176XxXnsvICQ50qCzI=;
        b=h7s8Vyq0fGNaXwQP45GnAhl3acGnXBa09YoG5dNmz2i5bIHyFDiKt+slin9JWVoiMZ
         lG/KlmmSceqmtw59QKIm197WFl4We1cblmWf0NruAF1nALhWRrUhCEiX5Xbo5enj1Cft
         aCL11YBqQcORJA/wSNz30ZY4/c9hm1R2kvqq6H+BQ5SqB1gD8PI0DccLhM4/CQYAEmO4
         rpMPM2FGsvTv1Nc2mi2fn9gXghPvYXsb0OvnXOtGijAkk8Hoi7CeflMB0WkTqBu+yW70
         h6SnvfC/OutmpgMm7O7yU6z+UU//0PiCWzq6HE+JB+yWacO3CCsxE5NP1SGLdaWlP/rx
         jvpA==
X-Gm-Message-State: AOJu0Yz3ZuJUaHvSoWRS803nGLUVHx+aeD6wvGRr4+3Bo20FtvZ6zQh/
	jrpTxNZ4SO2HwuEZvqoATyQZjVwWurXRDkuCaX5d20Nx70GRzGu82XNB9kU9/gTIlOo=
X-Gm-Gg: AY/fxX6ayeqd+RpPE6Fh6Z2dPQRZw0Ni1Om+d/gOVP/S0Ac7TLbrrYDJLGx8+Y9v2WK
	Ln9L+yZAwWiaibLievYeprLkVoJ7jVPbU130IL83ZyNfBgwMAPeRXl/WIMrerMF39AzLu2HyguJ
	b20Z7HNjAHW2P8UNlvam3pPDquFZClTW9L5yCGQ5iJSh378n9mtJ6VzobTozD2Y7WRjZRAgM1xJ
	LCMy9unV+W90WOleMx0iH60lig8+sTNG8qU1+ZS3B6FR1t2oYMmW6/X4iQcK8pMlhFKsw1C2r0l
	/lA6h14X2VRKVOnBx9Iv5wd48OhOHbrOyZD3UF53IkP93K4EOxPeTDpbfvZEysSopvRGgJuCrTI
	DUbOQ/PTP7PkW8FJOPQQlYRnbQtpnX1sccsVpfkjfonbbjRJfzVyN8Ch8ufcfWrFZUBM8tNPG3Z
	CwLfCHXlnY1qD7+sfI4RA3U+8IePrPuQAWC9izNvtYDetviWGf+ZoE6q+fa7h/
X-Google-Smtp-Source: AGHT+IF1pGQlTvSNUkaOR8+ke2GdpdxW5UboFnSiwOvVZ/7w1O4JoRpMuIbNcLLEOUliN4nj8DK/Fw==
X-Received: by 2002:a05:6808:4a58:10b0:459:b48b:c731 with SMTP id 5614622812f47-45a6bccccdfmr8266556b6e.2.1768317599608;
        Tue, 13 Jan 2026 07:19:59 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2f58:e1e3:bd08:f09e? ([2600:8803:e7e4:500:2f58:e1e3:bd08:f09e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50e1e29sm14572053fac.19.2026.01.13.07.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 07:19:58 -0800 (PST)
Message-ID: <f92e41e6-ab01-4693-8d0e-d5a9df6f6c6b@baylibre.com>
Date: Tue, 13 Jan 2026 09:19:57 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iio: adc: ad9467: check for backend capabilities
To: Tomas Melin <tomas.melin@vaisala.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-3-0a27e7e72f41@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260113-b4-ad9467-optional-backend-v2-3-0a27e7e72f41@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 6:12 AM, Tomas Melin wrote:
> For cases when the backend does not support test patterns or calibration,
> do not attempt to use those features.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/adc/ad9467.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 9cfe66425d4e91e215cccc40e24a92c5e99e9b87..ce7dde8b79540bb0eabfba9470b3984e8723d4b7 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -645,6 +645,9 @@ static int ad9467_backend_testmode_on(struct ad9467_state *st,
>  	};
>  	int ret;
>  
> +	if (!iio_backend_caps(st->back, IIO_BACKEND_CAP_TEST_PATTERNS))
> +		return 0;
> +
>  	ret = iio_backend_data_format_set(st->back, chan, &data);
>  	if (ret)
>  		return ret;
> @@ -665,6 +668,9 @@ static int ad9467_backend_testmode_off(struct ad9467_state *st,
>  	};
>  	int ret;
>  
> +	if (!iio_backend_caps(st->back, IIO_BACKEND_CAP_TEST_PATTERNS))
> +		return 0;
> +
>  	ret = iio_backend_chan_disable(st->back, chan);
>  	if (ret)
>  		return ret;
> @@ -807,6 +813,9 @@ static int ad9467_calibrate(struct ad9467_state *st)
>  	bool invert = false, stat;
>  	int ret;
>  
> +	if (!iio_backend_caps(st->back, IIO_BACKEND_CAP_CALIBRATION))
> +		return 0;
> +
>  	/* all points invalid */
>  	bitmap_fill(st->calib_map, st->calib_map_size);
>  
> 

Same comments from my review of patch 2 apply here.

