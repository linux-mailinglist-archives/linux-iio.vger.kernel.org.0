Return-Path: <linux-iio+bounces-11671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A99B7515
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A547FB240FF
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C81487E5;
	Thu, 31 Oct 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvxhs6lI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281EC1487D1;
	Thu, 31 Oct 2024 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358805; cv=none; b=A7pcfSqYIcTBRqKiA0y8Pz36T+dbh+gXbv8O3PJm8edn6d8yiOFNOQGK8/jB8tTZmWu72T69YEaRhgiACHrC51nTyyef9iqDJ9VtaFXTiURe/JMSIbAGwQFKJxCKJI5y9LCOcGFRfLHV5X8L8ua+glAAICV90tgVxPit/Mlyml4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358805; c=relaxed/simple;
	bh=n5s7BqFiTVpjwTRoFk2o50PhU1UZYPkhkSQjRdzBSsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZuHDjGBTUDNfXx1tDR5/Nfro0/YTG6w9+0l0i9/4XyMOryijJLs/mfcBoyLyL9i9sQ/ASYs0iksqmY8IPNXrGWRSM3vq5vKAykmq5e+KTHLqYyOgxEwqFlV2QrUxETqqwOjZcWHPczKEKCUeVwO68fAz21M1QhYSb9tRfEm9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvxhs6lI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53c779ef19cso633262e87.3;
        Thu, 31 Oct 2024 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730358801; x=1730963601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYNKPpW5+LOAj9rPQp09PnGF4rkl3/FgO55cWEjPbcI=;
        b=Cvxhs6lIdsOxZAmEV5Fpssss4TNO+ZyPMVewKhno7oijkwdxzhoEiUPb/1FR8oZPTs
         7Pfukg4WLw5XT68E5cTzPl5mWUK8rd4JtVgc0MlCtpAHC+7hUlE67UztcWw1OsTjB7EQ
         NtZwT6ayrAVk6e599B0T/ByHDHZ3I7cdsTvZMb48nkxxsjtsdWO/Z3ahAy0xArLoqnQj
         yFXQD01BxxFrHNQ5Tgx2M3X7XF+q5dwbfUck+JrUfQeskyshazWTCeXqdSniQN4RVnl+
         a66jxwsLWP77C1Hq6MspWbzbmztsIiMbw5NEiDAPmXZAQgLDeLlV+DiqkXHP+zWtgdRP
         TOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730358801; x=1730963601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYNKPpW5+LOAj9rPQp09PnGF4rkl3/FgO55cWEjPbcI=;
        b=uMHlsyCROt4oW43wDoYq4osxWqJiwyglOgqiv6/Y/vTXzBLwVIo5xvimn7quBX3xR9
         2wrPq7LSt7CIDIlV39GNQGtXzuMERfXd6bXjB4tGMqixEyApuYA4/RiEXe0aTOaPoZ2V
         cS/c5H5AE4AINMWRref6RUbBPlGrSqq3mluTOEp6GIHH73MjGpxqjpdp3RlGLtT6J9J0
         l22IF+RWUgVqNzt8Xe9q/aGphBBUK/jlJxc3mJGmH5nkJ7yHN2FbZ2o+aT8TBJItgiQH
         sC5qJqRnMGuUHygwRdc8jTbTI7l7qnlYX0yvRL2evTQia4znennXWlK+MmIQPCN+vrY9
         nGTg==
X-Forwarded-Encrypted: i=1; AJvYcCW0yqtQsp8SVmz28icHEJXHd9jk2uJPE4oj4uz6DceK6RR86GLzTAxM+zmTAfuKGn9j7yBcOQciabI=@vger.kernel.org, AJvYcCXrkm7XRTZ2zJgqebk9KmkRF+H3n2YHB1dIflC3Bf6K+bb2KzvrIzFcABFhH7JHnDdVqVAsPl8kTVeuEksR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99QSAj6QxjJp24ORFP7/Ix2SPlH6o9dk2eP2Um0wNF4ReX8T2
	z7q2lkq/aKq5KlU6FK4kWZEGGVlHGjqEDA/7xCEzRZlMKJcomFIHJD8+g5A2
X-Google-Smtp-Source: AGHT+IGaq/3cf1ZA6yndcd7zOvzovZRCdC7n8N9ta65eO3kLRkR97DVsBL2jOkPLcT0ci6t/nnvjeg==
X-Received: by 2002:a05:6512:4012:b0:539:f26f:d285 with SMTP id 2adb3069b0e04-53c79e15c9fmr963931e87.3.1730358800885;
        Thu, 31 Oct 2024 00:13:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbfa6sm108212e87.208.2024.10.31.00.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 00:13:19 -0700 (PDT)
Message-ID: <5f80c1a2-118a-4685-ac1b-81b3479f5064@gmail.com>
Date: Thu, 31 Oct 2024 09:13:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix uninitialized symbol 'ret'
To: Zicheng Qu <quzicheng@huawei.com>, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
References: <20241031014505.2313035-1-quzicheng@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241031014505.2313035-1-quzicheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Zicheng,

Thanks for the patch.

On 31/10/2024 03:45, Zicheng Qu wrote:
> Initialize the variable ret at the time of declaration to prevent it from
> being returned without a defined value. Fixes smatch warning:
> drivers/iio/industrialio-gts-helper.c:256 gain_to_scaletables() error:
> uninitialized symbol 'ret'.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>   drivers/iio/industrialio-gts-helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 59d7615c0f56..c5dc5b51693d 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -167,7 +167,7 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
>   
>   static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>   {
> -	int ret, i, j, new_idx, time_idx;
> +	int i, j, new_idx, time_idx, ret = 0;
>   	int *all_gains;
>   	size_t gain_bytes;
>   

So, if I read it right, this handles a (corner) case where there is no 
times given. I am not sure how well such use has been considered because 
the point of GTS is helping out with cases where the gain and 
integration time both impact to scale.

How do you see the benefits of the gts if there is no such shared impact 
to scale? Sure the gts could still provide the 'standard table format' 
to present the gains (or times), and conversions from the register 
values to gains (or times), and perhaps the available scale table(s) - 
but I suppose it also brings a lot of unused code and some 
initialization overhead. (I have a vague feeling this was discussed with 
Jonathan during the reviews).

Reason I am asking these questions is that I wonder if the usage should 
be limited to cases where we have both gains and times? We could check 
this in the iio_gts_sanity_check(). (And, I am actually a bit surprized 
this check was not implemented).

Well, initialization fixes a potential bug here and does not really cost 
much - so big thanks to you :)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
  -- Matti Vaittinen


