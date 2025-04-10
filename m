Return-Path: <linux-iio+bounces-17915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14602A846FE
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 16:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A12D189B7B0
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF3428A40B;
	Thu, 10 Apr 2025 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CcX2t6FD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488814F9D6
	for <linux-iio@vger.kernel.org>; Thu, 10 Apr 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296725; cv=none; b=tUxre6abIkxhEjl12xUWMfEPh53p4FAxM19uvrB6Uv4NtMOE3uIgNiuTCEhO2Ejkg+W11ASt55UFVfUgw3rtrPIpILU6xX9ChMgXXE0A3RW+bI8/fSconZHe0k9urMHu0Z0qnLZopxRaI52az/2g/nBbJaZr0DAYfl1dugoF8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296725; c=relaxed/simple;
	bh=eBi8FrMYdAv96WqoDBdECWOvbUZG2lDDGziG85MEw5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zi+RQWsTFtLAcqbIOAEW3wuanzor4B6ymtuOc2tRseE6DjAhlRMHScrluQkGnCRdcnjTqJQInEMiQKPpyvs1/e85g3WBB5yeIcMICeE+DpinsoSsV/qt8pmW3ZHWjcr1e04qGaji1gvBjKRF/SoekOULaiNKXWSPnR7WX1LaiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CcX2t6FD; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-603be85490bso475702eaf.2
        for <linux-iio@vger.kernel.org>; Thu, 10 Apr 2025 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744296720; x=1744901520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gOno/gJ7gBboQpb02wlzMcv67wZeVwPKwITP1UuvCY=;
        b=CcX2t6FDAT3zaHCpVPUAKdb+3fQrfnbsxHYaR9nWt8/Zj8DySNDbG4YEdxI1RRiGyQ
         YDaRZh7wj+KMqBsY1q7rUfL0fXJkv0Dyk5/VxYKHJTIVLpw7IpCO4H2roKi57mVMNI9c
         dQ6iHr3QIB+nD1TokGB2lQrdFzX+rCpvN7GoS+iy5/+1YTdQxS11333qG2jphgbwr2Of
         ENRF4zJLCeZ0dgwjzLdCTTrgSUZqkufMQ1qK1cs9uharIzmJikNB/7jnVYnt+ZjsBPvG
         wh+MdU+xTf4m+9gRZZm9apaDqUL6veM0uQGcdVyGTdx/Uh+GjuI6UgHs+BaeFV9xaM5s
         tC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744296720; x=1744901520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gOno/gJ7gBboQpb02wlzMcv67wZeVwPKwITP1UuvCY=;
        b=oTo92hP78UVvb7DkD7HGGZ/AyG3r+gq5ug33nPIgYYJHGl2CgCaRHqPwICFhUo/Cls
         hl6wQQdd8cV2y1pcVl1HPKl6wBHMtKWZj2LqMv9qLu2tj9t4yzpz/rby2tpWOb+Kt0Jt
         0iskEz3qhuI92warvDI3k4C+9K37uZyM23fw/iznEDoycogujKPiW4wsrabrYQM+jg8H
         6Z6qEal0WPu5S3wkkFrIAC4GWJTWwR2vXcuoVOzapkWKqzGKk4di4WedTQdBSZwE/xc3
         Spu4V9Nu5auKLcAv7+xmb0upPuXki4p3RqQm48VbTTIlDcwzkwc6xw4PL7hGeM0cvsx4
         TkJA==
X-Gm-Message-State: AOJu0Yxwf4U9tnzY9RVJq6oTVuPYmvndE5PhTYNsr7t/3yQTGIWRPu30
	FrYbJ0LDbv5vXySgjWRshMwLUW6qKz/A5RAYMq3OAE1uYBQzqATSTzEm+Ynihy0=
X-Gm-Gg: ASbGncvC2B/IS5C04HVJeWKimoSGIWhyoeuBD8tpBQfnQVqCWzbTMZZ5TkpVEFIjHE8
	ghAU4fjEZs6U0WKE4di+C8M4W0Mc5CAvkiDOCyE17kyjKcoU+X2zENS1uv7v3OETt9FrCJc6RJv
	Pikc9RNt/kVtXajlpTX/VRcJ4SJXAQ1O1ry7SU5RtOBKL+Z+BpDQNjLIz8Q7BMY1G58prvNH8ll
	d0wPRKvjtMSlNgmE9o7H9/d0iAHX17LajkcSUa92ULAj0bQbC3O/wG081jcxabd00mEjpO7f/50
	MDdjpjMfGWpZJvvGO0L4mbPJ9bNr+c+Wcf3MKLCtIqjUE92OWEiasRonqm5bZNnLafBKLKpfBtC
	mIA==
X-Google-Smtp-Source: AGHT+IFUJXtIwbiWLX/m7VjN4bLSRvII3p6HjstMTq0XFlrXhNxKjwC2cdba/PqsU5xVZ2Oqe4rO3Q==
X-Received: by 2002:a05:6820:2d04:b0:604:2ac:840a with SMTP id 006d021491bc7-60466c47874mr1397703eaf.6.1744296720499;
        Thu, 10 Apr 2025 07:52:00 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f523066sm557756eaf.14.2025.04.10.07.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 07:51:59 -0700 (PDT)
Message-ID: <1254dfd7-e872-4c65-bd17-8015e1b2eba4@baylibre.com>
Date: Thu, 10 Apr 2025 09:51:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: addac: ad74115: Fix use of uninitialized variable
 rate
To: Purva Yeshi <purvayeshi550@gmail.com>, cosmin.tanislav@analog.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409202945.205088-1-purvayeshi550@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250409202945.205088-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 3:29 PM, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/iio/addac/ad74115.c:823 _ad74115_get_adc_code() error:
> uninitialized symbol 'rate'.
> 
> The variable rate was declared but not given any value before being used
> in a division. If the code reached that point without setting rate, it
> would cause unpredictable behavior.
> 
> Declare and initialize 'rate' to zero inside the 'else' block where it is
> used. This ensures 'rate' is always initialized before being passed to
> DIV_ROUND_CLOSEST.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  drivers/iio/addac/ad74115.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/addac/ad74115.c b/drivers/iio/addac/ad74115.c
> index a7e480f2472d..26770c68e5fa 100644
> --- a/drivers/iio/addac/ad74115.c
> +++ b/drivers/iio/addac/ad74115.c
> @@ -814,7 +814,7 @@ static int _ad74115_get_adc_code(struct ad74115_state *st,
>  			return -ETIMEDOUT;
>  	} else {
>  		unsigned int regval, wait_time;
> -		int rate;
> +		int rate = 0;
>  
>  		ret = ad74115_get_adc_rate(st, channel, &rate);
>  		if (ret < 0)

I don't see how rate could be used uninitialized since we are
returning the error if ad74115_get_adc_rate() fails.

Also, initializing to 0 would then cause a divide by 0 error
if that value was actually used later in the code.



