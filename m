Return-Path: <linux-iio+bounces-12733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED4D9DA9BE
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19E3165448
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F141FE45E;
	Wed, 27 Nov 2024 14:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIz+7dh3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA91FE454;
	Wed, 27 Nov 2024 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716887; cv=none; b=BmLuYnvUdlK1w5ciSJR4eKN1MKNT0Uv7T1BAzh7uXYK+dyBJpToC8LPRMaBzudAGqAff+Ft3giSWgSt3ay3q/ddPE3cL/4Rlt7zbmyJeZ57jUvs0/4kuchjRWk26HukuYw4yAkQ8PH28Fc41Q50u+IN1L6C/b2dgTmZff2U5Fjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716887; c=relaxed/simple;
	bh=paxZs3Cdlf93Q1+n3h1fBFQZMnc13IPiJrr77HuCbiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhdaUc1yrB74rEoG2/e9mlE3VPR+gBqcMew6Yph9zJzB/xTte/tvZ203bboJWrpnqu9XS3EzBBTpwElFXUIGyUz8PViAqE7uk9phtzGuaZtsR+822HDV3BKxLWOva08HWC+achNbGEsX0tBA9gfPT363C7zndlzVJMUprdIvAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIz+7dh3; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso6867718e87.0;
        Wed, 27 Nov 2024 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732716884; x=1733321684; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Um5TZq365fWOw0yCr9WfM9tBuVJrd4ZuD8M9A4DLXK0=;
        b=UIz+7dh3vqw+bkETFF0lryBbhPebcZSFyuJEagxITuPXgQFeBDNl8bv1ORSQvihTiZ
         sQxNnG7JQ2+50Z9jvkXiUsFuv/CbMbqgs8f+Nwuw3FqbMA2j+dEU0C4fos0aeMccMs9O
         kjbqkNvDYf+dUx8B7KDYbpqsugOF71I8HFQKgVgoQCPYpg/ttMVTEZUOJqJfSeCcvYck
         hKfGIN8CEEzAON4zEWTTYUt+VDJOs/Jt8Zg2XyWKt2/NGFEF71rknaB8vcSnMajHgn9P
         mERxlqBIRXncyO2CSecSOLXjKbF5E0I7mvfh7XDr2eV7lew8AU/n1ffffp48WQfsrmzd
         IqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716884; x=1733321684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Um5TZq365fWOw0yCr9WfM9tBuVJrd4ZuD8M9A4DLXK0=;
        b=vRD3LTwgO81wCWQqAcXnsGVigR8Qh5fBWiD6udj37eh/Zr7e4Fsap8XBlgR1GS1V22
         7Y1Rn14wmsZ3kFbc5pQEuDuE/aGiVAAL65e9qoMYS+YCWkFlv5d47v8wfkUjf8LMm3zd
         Gt+d3wRzOw0UF2388bTPezYW1aXr+IlOfnZuxIQx7VTIy773QYW5HFSL1TCentcO9eu7
         I0TxsvJVD7u/OhFXlhlVCpbAKBCLWh557v0Jt8ZWyIOK/7UUpDeFHVCKD41AziWVRE2S
         /5lICLWPgh9rKjBke0A92ArG9baIYa740/N6haOYb74pLfOS/Ot823cfG8GjENHUhgaO
         bAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUx50IdrWyzGG3w0ZJMPA8Xq72h/OdEFDOVoj3yT5V5+BJ8V9oXskJ0o2o3TZ4rxblWgS6OsnWW/eD8VpLo@vger.kernel.org, AJvYcCV0jeb3rfjT4iTrLYZ7f5bRUKijySIhQRuaYwbT0RGoi0Zx1CB9L1pDzjJ6zQmZHp3APKo8ciUrXjcY@vger.kernel.org, AJvYcCX0W6dCuwNkEYb7pQTO1BZPYiD3TxPVX/7/kibnRFOuTHWxd7TTkigDKLb3L9SJrjHLCBhj5mYvAoSh@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkgvFTxLQWWq9wW/yISEkcT4ybB3eFuT0S9lZjVLZ9zOymmP/
	0ToiAJ1Gixv8wF+b9y70/iTJCIbSt79lqsHUQpz3uAHeaIosyUEFNT1afw==
X-Gm-Gg: ASbGncuMTjGWoD3IdUI7ys8cu73S27zzWwS2hfJdp4rJD7PZSBSeSQbP8bFQcY3Q+0G
	/IZaNaxnG7pDDq9iSEFCifCBPUwsWzk47KJWor+IMY3qGWa8rbSeuMCLbgFmOZaK28b67SswkUF
	l6taILkurXW5jzTEpaXTsyDnLalM0zK5/IhGhBLm7l6CVwjqfOdA8MntLjA2IMWXVbzxy+eeqvQ
	pOkXpCBg29C2S4VbWWEqur+isAoV+XY5fQq06VdbkYangeCP7N7nSg1OBw2I4ehQBfm4T/1miAX
	6f8y1XmMCLC7Pc55Aej8md/N4o0Fehk=
X-Google-Smtp-Source: AGHT+IHmGIqaxMqackvlpmM5ajOcte2kcWyZ19LAd1LyiW8cxDqpxp6gMdyGjZJ5ScCnw/bZFnOq2Q==
X-Received: by 2002:a05:6512:3da4:b0:53d:d0ed:9e06 with SMTP id 2adb3069b0e04-53df0117880mr2065080e87.56.1732716883660;
        Wed, 27 Nov 2024 06:14:43 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2499995sm2316610e87.261.2024.11.27.06.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 06:14:43 -0800 (PST)
Message-ID: <2d16bf36-57d3-4c54-bbee-2e7d93399f29@gmail.com>
Date: Wed, 27 Nov 2024 16:14:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] iio: gts: Simplify using __free
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1732105157.git.mazziesaccount@gmail.com>
 <5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com>
 <20241123163713.2ec03a37@jic23-huawei>
 <964035d9-cccd-4e12-af71-00ca39cc3596@gmail.com>
 <20241126175214.76609ba9@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241126175214.76609ba9@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi & Thanks Jonathan,

On 26/11/2024 19:52, Jonathan Cameron wrote:
> On Mon, 25 Nov 2024 11:16:22 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Hi Jonathan,
>>
>> Thanks once again for the review :)
>>
>> On 23/11/2024 18:37, Jonathan Cameron wrote:
>>> On Thu, 21 Nov 2024 10:20:07 +0200
>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>>    
>>>> The error path in the gain_to_scaletables() uses goto for unwinding an
>>>> allocation on failure. This can be slightly simplified by using the
>>>> automated free when exiting the scope.
>>>>
>>>> Use __free(kfree) and drop the goto based error handling.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>
>>>> ---
>>>>
>>>> Revision history:
>>>>     v1 => v2:
>>>>     - patch number changed because a change was added to the series.
>>>>     - rebased on iio/testing to avoid conflicts with queued fixes
>>>> ---
>>>>    drivers/iio/industrialio-gts-helper.c | 19 ++++++++-----------
>>>>    1 file changed, 8 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>>>> index 291c0fc332c9..602d3d338e66 100644
>>>> --- a/drivers/iio/industrialio-gts-helper.c
>>>> +++ b/drivers/iio/industrialio-gts-helper.c
>>>> @@ -4,6 +4,7 @@
>>>>     * Copyright (c) 2023 Matti Vaittinen <mazziesaccount@gmail.com>
>>>>     */
>>>>    
>>>> +#include <linux/cleanup.h>
>>>>    #include <linux/device.h>
>>>>    #include <linux/errno.h>
>>>>    #include <linux/export.h>
>>>> @@ -167,8 +168,8 @@ static int iio_gts_gain_cmp(const void *a, const void *b)
>>>>    
>>>>    static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>>>>    {
>>>> -	int i, j, new_idx, time_idx, ret = 0;
>>>> -	int *all_gains;
>>>> +	int ret, i, j, new_idx, time_idx;
>>>> +	int *all_gains __free(kfree) = NULL;
>>> See the docs in cleanup.h (added recently).
>>>
>>> Constructor and destructor should go together.   Dan wrote good docs on this
>>> (which are now in cleanup.h) so I'll not go into why!
>>
>> I went through the cleanup.h, and noticed the nice explanation for the
>> pitfall where we have multiple "scoped operations" with specific
>> ordering required. I didn't see other reasoning beyond that - I do hope
>> I didn't miss anything.
>>
>> I find introducing variables mid-function very confusing. Only exception
>> for this has been introducing temporary variables at the start of a
>> block, to reduce the scope. I would still like to avoid this when it
>> isn't absolutely necessary, as it bleeds my eyes :)
>>
>> I really don't see why we would have other cleanups which required
>> specific ordering with the allocated "all_gains".
>>
>> Anyways, if you think we really have a problem here, would it then
>> suffice if I moved the:
>>
>>           gain_bytes = array_size(gts->num_hwgain, sizeof(int));
>>           all_gains = kcalloc(gts->num_itime, gain_bytes, GFP_KERNEL);
>>           if (!all_gains)
>>                   return -ENOMEM;
>>
>> to the beginning of the function, and the "int *all_gains __free(kfree)
>> = NULL;" as last variable declaration?
>>
> 
> No.  You need to follow the standard way. It is something we are
> all getting used to, but all use of cleanup.h needs to follow same rules
> so that reviewers find it easy to review once they are seeing lots of
> instances of it.
> 
> Many indeed find this ugly but reality is it's happening all over the place
> just usually hidden in a macro.  From cleanup.h look at how
> guard() works for instance.

Well, those macros are better in that the variables they internally 
declare aren't visible in the outside code. The 'all_gains' pointer is 
used throughout the function, and I really dislike having local 
variables which aren't declared at the beginning of a function/block 
emerge out of nowhere. Makes me think: "why this terribly named global?".

Well, maybe I really just need to try to adapt these things but I will 
drop this one out of the series for now. TBH, I don't really like how 
this table building function looks like. It's too long and confusing. I 
will see if there is a sane way to split it, and maybe get the __free() 
pointers to the beginning of a function as well ;)

>> (This is not optimal as we will then do the allocation even if
>> converting gains to scales failed - but I don't think this is a real
>> problem as this should never happen after the driver is proven working
>> for the first time).
>>
>>> Upshot is this goes where you do the kcalloc, not up here.
>>
>> *whining* "but, but, but ... it is ugly..." :)
> 
> :)  It won't look ugly after a few years!

Could be. But now I am in the middle of "everything used to be better in 
the good old day" -crisis. Playing 8-bit NES games and wondering if I 
could fix my old C64 ^_^;

In any case, thanks for the guidance (and optimism!) XD

Yours,
	-- Matti

