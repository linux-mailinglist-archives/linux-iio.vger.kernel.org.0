Return-Path: <linux-iio+bounces-11679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 876E19B7551
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F13B1F213B0
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D10B1494BF;
	Thu, 31 Oct 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNjsDuDA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97DA1494B2;
	Thu, 31 Oct 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359525; cv=none; b=CWjsbPL+XtMlLoMU5RoyTsPvz4hIgrg5mj/JmLZiEq22oFJIZMg4lV56E7ZyBPq1ylQTDk4qzSneHVGc1VRAebQkBSjw7bfMvGb7KXpR3NQScH2znq5Mczb5TRFt7nsjURgX0VZncPPOyhfTNx6ZGX9WyoCYCvWj2lhMFFsUhqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359525; c=relaxed/simple;
	bh=Sz7qDKICTc5bBuDPsYR42CI3Rb1sCu9teJwpA4RUY2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDe0WaJkXz//58zMbYG0ZCGurqjdJ8yIhntxjsXoDUuIxlUfMws0sDFxlZJISctndkM7qfR4Pq9VPIVSI8oOXaHRhM5cBlw4r8fbM0YCbdS8r/EaEh6TBiFmR/r9xONXs0ECK6bSm+riJecn85Y6fmIcJ/nEvhlhDCFW3ghE/R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNjsDuDA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso5217641fa.0;
        Thu, 31 Oct 2024 00:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730359521; x=1730964321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7I6q0OWTgGB2347r7NhGbbFs0GMHHfMCetjtNNAxog=;
        b=JNjsDuDAx10hJd7nhaxF+9Z+9aTk62oDk1ATsh0Pyr1+wZ4qGFIosxXUBnMN2jsu4B
         n/Q/S4udY4GlKfWM+iV65VDbKCbLnt4BkLTqZP3NJZgssjHZpu4mXsWHHg1Zvn5Dj2ss
         6lnubIHRbtA65EsD9B8n14UkW/usikO9HTvM9qikfUo+ConyD2npnPjrOljkzNN/SiT6
         yPnkmpVElo8k3RjdgMsxQwQpDNKM6Zl5PMpn96r8M/ILd0bSxqF8jyy2/Eb6zh1oVmuT
         YeWMEzlSphXe8d7IJi1ywTYYSl1MtsI+G3b+nrdo1avJMdZ5hGFrgKq7+QCvAoAQeXZE
         1cBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730359521; x=1730964321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7I6q0OWTgGB2347r7NhGbbFs0GMHHfMCetjtNNAxog=;
        b=ZfppbXqu043Kc/yxrPKUxHLUHliy5XUcLFo0IMesiOAjhsVF134i+gAbWVk9PNRv2e
         q7/kC8e8wO+yEoaa2kxp8bWAxJAqjrncS1c9QpWnwZZebZ2lnX6p5zW4ywOT1UR2LMgn
         glNXkdjTMb+uNnSQbThjB0ynL1NnedLkerkT0YjvNQ6jp3fz3UmF/Hnk8QhUU8H61qkB
         GO9dR8xOw+A+IzvQRlWPnp/xMblzT/i/1uRZGEuNUHQ0tZtN2VxoWWj3p9gcUs/wsHZt
         zFLGDkZaBajFonDmeiXKl8fHZHNnes3VtSx/OHaYdes8kBlbjPFewwGYkHXg4Wu9FGQC
         PX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv6f7jf5bzj4ib3ye+0y/bMQhAK7+Q6JzKq7qn+yyaI4ti9DQfaZKODcl9VbFhT3IHCn6jVWqj1m0=@vger.kernel.org, AJvYcCXecG29sBqLaPRKnUmR5uyXRy63YL/ynVk/CVQveMFMbZo+3VYdfgUoZhUA3OwFAXj90waHzyQQ8OUkLnw8@vger.kernel.org
X-Gm-Message-State: AOJu0YxDefBDbSPOfkuly/vKs677e5NvamTGAfaTDWiGOQ/jYKaLTtyL
	vP7P5oyWZ0RPoFZYy9YxLEpfI1n6w/3i7edLEHJ8zSu2bvHk2V6ZxbLeRVkk
X-Google-Smtp-Source: AGHT+IFFkKLJwxLXGkUZpjP6xjSxY1TOEzKg5XHG5OP1/9/PxTLmE9TVCN4SvKx9SZw59oBG/SYFCw==
X-Received: by 2002:a05:651c:b22:b0:2fb:51e0:951 with SMTP id 38308e7fff4ca-2fdec47a727mr11068841fa.7.1730359520619;
        Thu, 31 Oct 2024 00:25:20 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef5d5ca0sm1344081fa.30.2024.10.31.00.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 00:25:18 -0700 (PDT)
Message-ID: <5dae4924-5c07-48b6-a818-809cd4dd1c80@gmail.com>
Date: Thu, 31 Oct 2024 09:25:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: fix infinite loop for gain_to_scaletables()
To: Zicheng Qu <quzicheng@huawei.com>, jic23@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
References: <20241031014626.2313077-1-quzicheng@huawei.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241031014626.2313077-1-quzicheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks again Zicheng!

On 31/10/2024 03:46, Zicheng Qu wrote:
> In iio_gts_build_avail_time_table(), it is checked that gts->num_itime is
> non-zero, but gts->num_itime is not checked in gain_to_scaletables(). The
> variable time_idx is initialized as gts->num_itime - 1. This implies that
> time_idx might initially be set to -1 (0 - 1 = -1). Consequently, using
> while (time_idx--) could lead to an infinite loop.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>   drivers/iio/industrialio-gts-helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 59d7615c0f56..f3acd392f4fc 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -205,7 +205,7 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>   	memcpy(all_gains, gains[time_idx], gain_bytes);
>   	new_idx = gts->num_hwgain;
>   
> -	while (time_idx--) {
> +	while (time_idx-- > 0) {
>   		for (j = 0; j < gts->num_hwgain; j++) {
>   			int candidate = gains[time_idx][j];
>   			int chk;

This, too, brings the question if supporting 0 times is worth.

At least this shows that it'd be nice to cover the "only times, no 
hw-gains" and "no times, only hw-gains" cases in the Kunit tests...

Anyways - Thanks!

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	-- Matti


