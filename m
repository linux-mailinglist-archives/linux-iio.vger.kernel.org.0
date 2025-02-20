Return-Path: <linux-iio+bounces-15821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F6A3D160
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 07:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFA3B9DA3
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F131DFE20;
	Thu, 20 Feb 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnxdIHXY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E525130E58
	for <linux-iio@vger.kernel.org>; Thu, 20 Feb 2025 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032786; cv=none; b=KamJrniM6tY/81W1k+KYk82rj0vWmw20RE/oK9Mr6vSciN9rDrGUS7yjFCk2GTsx8AImT0aPYuamw2CcDNaA6XNEB2ku+aWbZAAKVjJsJlD8fZcQea10kIENtTMceRpBl1SWkE6DMpTEz5XYGWVdRrGVdiWrSS1ds9MJxBjxM7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032786; c=relaxed/simple;
	bh=caYYLHC0HUYjUffFnMJi/XnIY3C5YEzI7Hme2snjMCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwIhN3FU39yetlndAdaE5OEFg4sdTu5QAqsHFU8VKe7+OPktkSAq/ZNhZBIHcMI2EU8CtBLtO4OAQQsOvAvKMfIVEPizQNH0fVceottMpALuRkR/k1ZerSBPUgeqvGCMugzU80PeILDlQb8fERn13K+pJOq33o08aqB4OPL0HV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnxdIHXY; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54626a71b40so578615e87.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 22:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740032782; x=1740637582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKK0FMqqtrkA6op+JhNiPaB1rguxi70RKm2zpquCdLY=;
        b=ZnxdIHXYp7rQLae/pGu4WAa2JZ9nf9AIJ2N8Ja9f9IOIauPAqLtE892rDZDLloiLsW
         0VPmIPYYgBW6EVhWQzz6NRaZkRdMHCtXN5lsYH3Qd9ZDtF5WUDGvtachY2B6G5gaMGot
         2ocUmEbYESXcgglkcyueouh1kBX3LXDa8GwrC1pUbQzNqylmuQL1AdRh6Tv9vfRzMrdw
         hppsd3tHMUxm3iH5jlpM9ZjUcBdsnR1S0xvGnvyqgELYRCh0lHv8Nd2uevWhCTYi1/cz
         OG+DCIzulJ6Ngh+6KKpmsRjkOfyZuTH6hjj/MI3M23zZqoQxWgXn8es9XOtxhMiFeGGD
         QixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740032782; x=1740637582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKK0FMqqtrkA6op+JhNiPaB1rguxi70RKm2zpquCdLY=;
        b=MOywpBavZBiRNdim0HgNsuXFhqU2xjWwkqz+z+dD1/RpwfHIENYgUlNoDD2OpZ83yB
         wafa4p1cHBxwwpoEGgc6GWc//HjmLcxEa8BIVIs1tOfTBcpO6oSMEkO+yrBuWoR6TgoC
         2fKx5YUzsNc9ppJL3FEwKZEOlPvUJfhih/QBA5zuUoA9TmVVfC+qheC+RQ3unA6ChRSR
         iuCgHwW4LCwgPX9/wmhcs+jkHPvtd+t6mEEQRfXQ55OMfvYd5CfY09cGwXkCT2hPveKE
         fbVcQwRabXXOrLWimaTCVrClgOs41nfLIbJJ5is9MFpONDumE9wj7VN+nqarwSwNHAor
         q0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnSy89lCb3ouDMrMwbQzWJAv4yaGqVJo83kYC9Ow+QEU29eWJwFTBm8sMqBkF/WTiodCZ8M5UH7O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBIr22BUPGmh95g6gQK3G+Q95DY+nbb8lc2GZO3OIhwoT4dBw
	zZzZQrJM3JZa38Mm0+JcFD0XGjf8RI1uvkSc0FsjETZW+EleQLKs
X-Gm-Gg: ASbGncs1KK547Odexg1fJFswWkyTZCCCoRn6tc34bGOwq5SnRoHEIMdtY0ieTTwZP8M
	kuR1m+4WibP5kehktcV+uBaKnjsSDzQOwxuYHQ05tQsKF66k+7kpJd2PdV8BtsOZGoxR/Tq2yEK
	8NUjuEO2xPfTdtL+mU0q/t4D/VYN1RbKOpfTDv8ka7fLKGX6yFh70dvlTzbW09h4gjpLVfdzPww
	o9XuQB2kOrCjHjQVjfW8Z+PmC1ySLNb8v94sDzDHBEpz2iy/6FhGt56Oo9a3Aaz4jXmm1da/1Al
	Tw/E6K17kyQ0PvlWajj6gxBUCb5INzG3T4wosBXldKlZbS/ShCQJAFk8T1uWtTmiO5hB8i1q
X-Google-Smtp-Source: AGHT+IF+cxh6zyKWWKOKbqoFI8EqWk+Cn8QDu/s1UE64+5kV4C7RjsRp2cRbajwJXfxEqM5Lr3Mk1A==
X-Received: by 2002:a05:6512:1054:b0:545:1d96:d701 with SMTP id 2adb3069b0e04-5452fe80840mr6387339e87.36.1740032781861;
        Wed, 19 Feb 2025 22:26:21 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54624a025bcsm1041885e87.88.2025.02.19.22.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 22:26:20 -0800 (PST)
Message-ID: <2b8c9b3d-0479-4b4d-aaa5-f0f9fd69fda7@gmail.com>
Date: Thu, 20 Feb 2025 08:26:17 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] iio: accel: kx022a: Switch to sparse friendly
 iio_device_claim/release_direct()
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250217140135.896574-1-jic23@kernel.org>
 <20250217140135.896574-6-jic23@kernel.org>
 <0e17116e-6160-4920-83d9-086218245299@gmail.com>
 <85d97cbe-9d34-462c-a89f-de6fc1ac6e34@baylibre.com>
 <ead33fc6-48b9-488c-8993-2ca647e59735@gmail.com>
 <df700bd7c8d3aab89177b122ed9adf0269bde62d.camel@gmail.com>
 <ade6ee75-7f38-4826-9359-2411165decb5@gmail.com>
 <2ad4ca67-5a70-4b7b-b744-d9bd92ce386a@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2ad4ca67-5a70-4b7b-b744-d9bd92ce386a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2025 17:25, David Lechner wrote:
> On 2/19/25 6:21 AM, Matti Vaittinen wrote:
>> On 19/02/2025 12:51, Nuno Sá wrote:
>>> On Wed, 2025-02-19 at 07:36 +0200, Matti Vaittinen wrote:
>>>> On 18/02/2025 17:42, David Lechner wrote:
>>>>> On 2/18/25 1:39 AM, Matti Vaittinen wrote:
>>>>>> On 17/02/2025 16:01, Jonathan Cameron wrote:
>>>>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>>
>>>>>>> These new functions allow sparse to find failures to release
>>>>>>> direct mode reducing chances of bugs over the claim_direct_mode()
>>>>>>> functions that are deprecated.
>>>>>>>
>>>>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>>> ---
>>>>>>>      drivers/iio/accel/kionix-kx022a.c | 14 ++++++--------
>>>>>>>      1 file changed, 6 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
>>>>>>> b/drivers/iio/accel/kionix-kx022a.c
>>>>>>> index 727e007c5fc1..07dcf5f0599f 100644
>>>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>>>>>> @@ -577,13 +577,12 @@ static int kx022a_write_raw(struct iio_dev *idev,
>>>>>>>           * issues if users trust the watermark to be reached within known
>>>>>>>           * time-limit).
>>>>>>>           */
>>>>>>> -    ret = iio_device_claim_direct_mode(idev);
>>>>>>> -    if (ret)
>>>>>>> -        return ret;
>>>>>>> +    if (!iio_device_claim_direct(idev))
>>>>>>> +        return -EBUSY;
>>>>>>
>>>>>> Not really in the scope of this review - but in my opinion the logic of
>>>>>> this check is terribly counter intuitive. I mean,
>>>>>>
>>>>>>> +    if (iio_device_claim_direct(idev))
>>>>>>> +        return -EBUSY;
>>>>>
>>>>> I'm curious how you read this then. I read this as:
>>>>>
>>>>> "If claiming direct mode succeeded, then return an error!"
>>>>
>>>> I am used to seeing a pattern where function returning zero indicates a
>>>> success. I have no statistics but I believe this is true for a vast
>>>> majority of functions in the kernel. I believe this was the case with
>>>> the old 'iio_device_claim_direct_mode(idev)' too.
>>>>
>>>
>>> Fair enough... Note though this is returning a boolean where true makes total
>>> sense for the "good" case. I do agree it's not super clear just by reading the
>>> code that the API is supposed to return a boolean.
>>
>> Exactly. Just seeing the call in code was not obvious to me. It required finding the prototype to understand what happens.
>>
>> Anyways, I guess this discussion is out of the scope of this patch and if no one else sees this important enough to go and change the iio_device_claim_direct() - then I am fine with this patch. So, with a bit of teeth grinding:
>>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> Yours,
>>    -- Matti
> 
> Would a name like iio_device_try_claim_direct_mode() make it more
> obvious that it returned a bool instead of int?

In general? I don't know. For me ... I am afraid I wouldn't have guessed 
the type of the return value (or 0 == "failure to claim direct") even 
with such name. It's still fair to say that I do _really_ rarely use 
stuff like mutex_trylock(), so I can't say if different naming would 
help someone else who uses those variants more.

What I would expect is -EBUSY when claiming fails, 0 if it succeeds :)

If this won't work for what ever reasons, then I'll just live with this 
function using bool and returning true on success, and move on ;)

Yours,
	-- Matti


