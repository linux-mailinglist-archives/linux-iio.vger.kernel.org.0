Return-Path: <linux-iio+bounces-6334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91FB90A52F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 08:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866A828E116
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 06:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E248C190042;
	Mon, 17 Jun 2024 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncza7NtE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC3187358;
	Mon, 17 Jun 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604838; cv=none; b=tuVx1YRsJP6kxs3dS7piVQlrlbglg5FT188URK0AG+yM+PeD/d+kl0saON10J5Lri9a9ZJ/jkSJPPKOJhnL8q/fFjP/lwwwuYUSaHXpEB21AndWCY7BBUodtL+7kLuVhecXtoQ81f3ZtRFV91+EYnEKcw7dYgHUAIGkSUqSaRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604838; c=relaxed/simple;
	bh=pWljAqkTfkrt+3zYt1Ce5GoIspvAKUkLfQj2oQVNffA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFSW4kdYvtFjKDaVFhE0hkjX0QLZXUDp+XZqqpYrIMUgQw93oV/hTT+Ie3sTnNNOHO8NaFc9OUBJ21HUi1mWRGMxABJ7SFVoZq1mJqmklEc1PMC/vHMKXrYSFG8Y+aUdw0/srtsJ+odDt9s+yR0RnzXXeJ9amn4tE3OrY6ownuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncza7NtE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so44299921fa.2;
        Sun, 16 Jun 2024 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718604835; x=1719209635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZntQxnrQUChH66lPydEN459mEVnoXqBtAC5FdClnOM=;
        b=ncza7NtE9VClZPNXzksPBmWHYmsQZYswjzq+Jye9VAkEytQFQxL6lzO4qRQezINHrK
         9NYvrKBMIOXISNjrGdGSzkxlgXQYDUWkSRVYuqKLasAafHK64H5YGmgICtiyOpM5EQYY
         ZzMxRjKRa1ztulIw+QVy6Dy9S9i4S1JFqpZLzU/AoC5zTnMgQ3TPTicXNa/S4NGatgPC
         gW/4qTNvvckNk7Bzzml5vzMeMxzqu14KHmAwHzIpr6QJIYNHQF+OyEa+z/q2GH25L5vM
         FL4QCQ9Cur21Pwx3iAZuL9RyOrPvARrAAtAiqEcHVK0WmbeJE6RMr4xXAtis2LSqmShx
         C/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718604835; x=1719209635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZntQxnrQUChH66lPydEN459mEVnoXqBtAC5FdClnOM=;
        b=i3ZGJUiJr2C7wGbhRB/bBMpeEMJ8fjX7fY+CPCfFwTgiUTKlXARJFbdiaq+W+1JsDS
         uGW1QaNmMa4roeUB92T9yk3rasxXsX2hBIBE9/mhCTGGrgzfVkkBJBj5Jf7bE+C8tNTx
         drrrWXsyw9kMv+WiJ9D5iftKOZWBeeTuOriuhAgYpY2mjjZ4RtHwlsrHhFTwOlv6pmOP
         6ii9MoTlgGl3Ex6f8xRHJat5ubx+SzMAqLR0WS+C0ITZ9e1nGoxIDU1JWtzFR4GYTUVj
         KnUYLzCmCa6NEStlg/rT4LkhsheXtRwxSMMQ+aNO0soCVs5EGSmUycLJMvl5fQ8uaMOG
         XKvw==
X-Forwarded-Encrypted: i=1; AJvYcCUjghY8tFy23dOX9inhiCS27S8pNbyYdzDmaw51Jjbw6I3smf0IOt4g+z1zoQ4uNmyQse9wUc6+l8U0WpTuySJC6eJO9zHdCxzwS4YIt9WWW6Wv6nb8PjPohDOriTvZ68OFuOxMY27wJZwAZhsk086YLW3bg7rPpVKCDXxSvcGG
X-Gm-Message-State: AOJu0YxWJ+mG2wymDaIbbocj5jRjSE32HF0BeW7Z2KkbHPVY3pabXm/0
	hWYy4Zwb0UQ4OGfsJLymbuXtOlmYZjpSYpEKtjhrLQ1njx5qmUlX
X-Google-Smtp-Source: AGHT+IHk5DcOwhCSZUVJBsZjTN1uHmzBc7hffy1mCYO/f7qQ+ieH3Tq4m1d1riCwGa/LPv5a9YSrdw==
X-Received: by 2002:a05:651c:1425:b0:2ec:17e6:f9e0 with SMTP id 38308e7fff4ca-2ec17e6fa7dmr61467741fa.8.1718604834996;
        Sun, 16 Jun 2024 23:13:54 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec07b7cb80sm12250991fa.1.2024.06.16.23.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 23:13:54 -0700 (PDT)
Message-ID: <4cb8af25-078c-45be-a544-653e2e2c6947@gmail.com>
Date: Mon, 17 Jun 2024 09:13:53 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: trigger: Fix condition for own trigger
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Cc: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240614143658.3531097-1-jpaulo.silvagoncalves@gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240614143658.3531097-1-jpaulo.silvagoncalves@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/14/24 17:36, João Paulo Gonçalves wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> The condition for checking if triggers belong to the same IIO device to
> set attached_own_device is currently inverted, causing
> iio_trigger_using_own() to return an incorrect value. Fix it by testing
> for the correct return value of iio_validate_own_trigger().
> 
> Cc: stable@vger.kernel.org
> Fixes: 517985ebc531 ("iio: trigger: Add simple trigger_validation helper")
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks for fixing this!

> ---
>   drivers/iio/industrialio-trigger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 16de57846bd9..2e84776f4fbd 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -315,7 +315,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>   	 * this is the case if the IIO device and the trigger device share the
>   	 * same parent device.
>   	 */
> -	if (iio_validate_own_trigger(pf->indio_dev, trig))
> +	if (!iio_validate_own_trigger(pf->indio_dev, trig))
>   		trig->attached_own_device = true;
> 
>   	return ret;
> --
> 2.34.1

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


