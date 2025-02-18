Return-Path: <linux-iio+bounces-15721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08E7A393DE
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 08:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627DC3A89F8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415A91B87D3;
	Tue, 18 Feb 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxHGra5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9A1ADC81
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864356; cv=none; b=bGrmE92MDCxAp7NyqO/kCttsOcgZIaAqTxr11SvvWBzVUuGuGVg0CRGSwFVo9ri2/EUUBFuDlO5q5UpwwKO4ajWPxZl70AnXIVfm7APh//B4sjL7VFB29LVgJjk9XHFTPQI+wKi21PMl7G5839UP/NyFeOTdD5xSdp6nVk/4W4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864356; c=relaxed/simple;
	bh=Lx6i9UHYmeMswxT38oGrFATI4C8wxAC7Ocl48Xif4BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRltMUjBErbfoRYlnJfNpp7l0cElRuGNx9gh9OEQtCQlAIggyN2WwIn9UySLIuuhfy1QvstAIMWwiHgZhq6kwBu2nffxm95QJK6xzqGg6UpeaCKNA2Pm2qSqRPVq+JDpEqMZhpqQ1aqTcWR8jowIaT3WlVoyyJ+5+Lqh0wZ8vA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxHGra5P; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso19430351fa.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 23:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739864352; x=1740469152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQJZObq8UOig0Zkf34PDCSdI2L86A+dRVW2DrghXhsM=;
        b=hxHGra5PAjtxiKsr9WAMOYBVDuKm8PjRvEyRmslR9s0fmFNihFToJket7gAAaaVAtM
         knNc4ma1T4v17JR6H9kBm55Ufnv5Xy9Eh7ecRfYkJk+58n2bMHqJM4CbhQsEzTZ85maq
         mjZy4SGDWU/CghdHMafaFaljsadn1/m8TDzoovGRzpGRl/8rLbzPOYotPDTmfzF26ahc
         molkV6FP1xhTfXj0LXmLB672w2FhaiE3AmMfLlhtdd7nkLjKEnV3i7qJWbXW4sLStGaW
         EDDv1MhrLXgO+KYjV2ToureaGixPUrxftmSdSkd8bDpjkJxrzPJPEfbYNpeh2FsYceEC
         sX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739864352; x=1740469152;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQJZObq8UOig0Zkf34PDCSdI2L86A+dRVW2DrghXhsM=;
        b=Lbd+pjA4d/UpPhHAOtdVY44faWFd9trjGCwDxyJm/xm4BQPVC+njmUvfyWFvx4ewyc
         rHIQU6bACv2GPe7zn5Co8PqfVyjoQOeSUlVB2br6F/0y4lHYQ7kd2aEI0KfkEeIRpyzJ
         NDKUBl2H2qRD+pucbYml0vKoRsJrGpwj+8vSYkRI9h0onVoFv8WZvSLjO2ULhq7k+l77
         kqjy/KGRNdO0Fa3oobow6IajqjRe3o1xuqXaRa4VIboV2Wgbf2uifgivMehXC8goLWKz
         C/vUag1l43rk90HM/Vg7at2OAFcZduTzgOhWPaDRy6gZ8jz1sV6BiBTAGYTqo3LjvvwL
         RNAA==
X-Forwarded-Encrypted: i=1; AJvYcCXPZjun/j37Rl8Swbp6uBVF80g45je09YDELYEJF2JqzIYoTZ/BQSVTyMegiSWkQrOmr9K+6Q5fd5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyEdQqNKQjhrtDWo7pbBbr1uEGYvnEHzG4pnbCw9pKqMpO7j1
	XiUcJUbpxbycH4XMkvPSldmZhAtkCAGn7QyUWcXTzRwrD6q7N/0AZrdvBw==
X-Gm-Gg: ASbGncv5i990zugUMTMFSKoxZvzecLRzK1JLUbaeQpgGEklALhebQRV9WdfKRty8Jrt
	N5CuiQK6OiNYJu/2Pq/BVpQ1KoMyKjt9HLOIZAAUwRv0UWc/4l39BwIPpm1gSAwqcY9nGL5pt0E
	cfXjc9zphlZqLqqCXwGiqhviOFnc6h08GFZlIG6Ut4+24+3vxBa2urAuuKHXcbIP1CZWM1Mr0sF
	M6b0Dz5+AkiN+GwgF712BqxrE2vgYpsUCLruGWjt44STJrEEi7FcU7auponKwbcvDT0nRck9fGQ
	NxnwxYwTxrnsT6GhVZ16Y4v8aDf7+Fom08Xx4ysnO9dVlVcRRwm7rtxUW5f06issMJhh5yWi
X-Google-Smtp-Source: AGHT+IGTX0ptxxcy/VnlV5HP5pnqGMX79MLC8iydD+ExclxVccMIiInOcoT3T3Z6Yi9GUT5WYn5Whw==
X-Received: by 2002:a05:6512:2214:b0:540:2da2:f282 with SMTP id 2adb3069b0e04-5452fe80876mr3567791e87.42.1739864351362;
        Mon, 17 Feb 2025 23:39:11 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545297b7c30sm1456306e87.234.2025.02.17.23.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 23:39:10 -0800 (PST)
Message-ID: <0e17116e-6160-4920-83d9-086218245299@gmail.com>
Date: Tue, 18 Feb 2025 09:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-6-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250217140135.896574-6-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2025 16:01, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>   drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 727e007c5fc1..07dcf5f0599f 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
>   	 * issues if users trust the watermark to be reached within known
>   	 * time-limit).
>   	 */
> -	ret = iio_device_claim_direct_mode(idev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(idev))
> +		return -EBUSY;

Not really in the scope of this review - but in my opinion the logic of 
this check is terribly counter intuitive. I mean,

 > +	if (iio_device_claim_direct(idev))
 > +		return -EBUSY;

would feel much more familiar. I actually had to look up the 
implementation of the iio_device_claim_direct() to see this was not a bug.

Other than that this looks very good to me.

Yours,
	-- Matti

