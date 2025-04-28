Return-Path: <linux-iio+bounces-18778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B310AA9F1EB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14653BDDEB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 13:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA626E172;
	Mon, 28 Apr 2025 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIP7XYq3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E754726D4DA;
	Mon, 28 Apr 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745845852; cv=none; b=NljnD9gXXIgaJghAHNn+NRaIE2LgQFXxb67YeUYdI3AkA9qHKEt+DDmQt1YBw8dYYMLoJpvjXRaNuK/NzTSIj8Co9XrOiOrv5tf+79c5T6n6jIegI2YaqeZPYdgODhCjLm5sNss3CUbL+3FsptzoEwWrh26wRV9DP+SqGKkAByQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745845852; c=relaxed/simple;
	bh=j9Uzm1w8Fd75eezPJkkUVqfV0l0UWce0x32TsE1Prd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cElU3ldoI5lUIeXrQR1sV4wWotnlNG4JtLYTyD8w8LuxO4nuo+2x2PQ2jhC8JsbAg4SZDqYzhSkXNdSyV/EaIr5usyF0d4mHJS9GEgH83bupBCl1H/CtlPusFD/Pg46BhFXgBC/EpSQrYEPO0OCA0nSU7RpQboPouF5UmP2iYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIP7XYq3; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c091b54aaso41735051fa.3;
        Mon, 28 Apr 2025 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745845849; x=1746450649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tu4QfTgg80SyZ/aPn5oHJnGIimNmX+43hWgOIQN+JZc=;
        b=mIP7XYq3MkvPrURsORCFNOtPS3JuTwy0Fq3VfBKaqzZWYVx6vRIE1tkWU6QkY5b52f
         tWlCd8kn+4BTkNA2cFO+/aobmEKNnSNcWRr3R+CqpX0m3NxE6iO00iR5POlY9jQFz7Zh
         zoovsFgaN1oCxVt4CPVOfFQNdPD2vmjfGQDizmMEP0AopRIVn94IcjW4+/ECBXz52Dna
         scibnvywMBWQxOq35hkAxI5M4qd2eelYzkme16myKbbVS9uBJarCynPAI7NtzfnMgA4q
         4WS/0vFO4BJXGW+g9Suxbes9V3rDK2phmqFUqpFA5GFET86VSDk9wKR0xPhrOi9KDVRC
         hxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745845849; x=1746450649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu4QfTgg80SyZ/aPn5oHJnGIimNmX+43hWgOIQN+JZc=;
        b=KIlWI62t8oH7zrOhZIH8X0YP3VEu+S5DPzNSG/jR9QtNdBfX8FcoVRu6IDmYMrHpWf
         XFbv1LOP07KqkpvYOaiLyyDi+5DLXAgRu/POyIRB+zXO62p/BGuQGbh9Ev5FKxr4rmxM
         Nx7FuxfD7Yni198cvy8wVhGvBWSvHs7KKVnCJEBFnLsnyftMwoBWdb/CjtM0rVcTLAf5
         5GtYkQl42RLe4uxNSembRaJMJpX0QeTz+ATLaYD6SpnDmJ3435f6RZhvZqBXRY5Eqeqn
         /Ved00jUiPHMT4niurGXV59BQndxp3KaS/gQFgyrws/L6fEYRxv8etg3mAJhYvQD7jO7
         tp3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTtWKmjB6sWfQMHVlWGV69IP0WJIyizjctjC3zXm1zUvn2ZbCfzMJlsTMNO2ApyYja1hwbpDVHoy38Nt+G@vger.kernel.org, AJvYcCXtTbxTi+4wzeE0hb2k/y2MXea1MJky0QG7/3TKIA5VPZNPjm994lGlSS3uD/w2CeScGvus8cWJHNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtco6wPn7ps6EOO3TRYytr8s3cI1pvmdZworvr48+ayKdaTb3c
	J1vYy9GF48Ia2o2EVSIH6VY2Cvxo5OacttzZVRnEqGMjoZeRPiSp
X-Gm-Gg: ASbGncthrOWYI4RL50qeX7OmV1c+u6UqZ/RD213mKga6fMtief0znMB1CnHBA36dmb2
	yvwgkvQjgS0lhVJMC6KcfWZfhA5og073beXO99dItAbwJ2Hz9zF2UmV6smykuNClyHnUTOaFw+a
	B/uSIvoytxLz3pPhBj+917gvL+OkwEECVbnjGanH/223sqlHC4+AUUhC4Brl92iNOl0FdbIlFB4
	e7Xr9b8qarbTCVV04IMwhnaJ2aM/f892Pr0gT0BGWS08iSs9+vLuOtnbMLNpPH6nKLCCbhPUP+n
	+KLz1Z13j4ckq0v+xOmqTUaLSJGUFHx9Wy4hDMU2fVdAvxMOhba9mQ==
X-Google-Smtp-Source: AGHT+IHqfoIC67IeYJTwogL9O/vl3stgQv17WOClfj/CoQYz6df1Fr8+mevirsbjZBqxPpkJc7r+ug==
X-Received: by 2002:a05:651c:1468:b0:30d:b31e:262d with SMTP id 38308e7fff4ca-31905b6a911mr43951891fa.8.1745845848534;
        Mon, 28 Apr 2025 06:10:48 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cf659b79sm21359461fa.14.2025.04.28.06.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 06:10:47 -0700 (PDT)
Message-ID: <e0f8a39e-195d-4b72-8787-36769c1e62c8@gmail.com>
Date: Mon, 28 Apr 2025 16:10:47 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: ti-adc128s052: Drop variable vref
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <59106e24332743a7f9eb0b13ad6a2f5595ab485a.1745823530.git.mazziesaccount@gmail.com>
 <CAHp75VcUcrj-BLp9QDsYMDY_SeQS76LDGge5vVqrx-MVwukP0w@mail.gmail.com>
 <4085fd58-c92c-406b-842b-ecda2fb3c895@gmail.com>
 <CAHp75VdAEefH5Vgk5BZz8vGDXyu0EmEy3hwoeRDJsKmkjaQW9w@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAHp75VdAEefH5Vgk5BZz8vGDXyu0EmEy3hwoeRDJsKmkjaQW9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/04/2025 12:49, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 12:45 PM Matti Vaittinen
> <mazziesaccount@gmail.com> wrote:
>> On 28/04/2025 10:08, Andy Shevchenko wrote:
>>> On Mon, Apr 28, 2025 at 10:02 AM Matti Vaittinen
>>> <mazziesaccount@gmail.com> wrote:
> 
> ...
> 
>>>> +       int vref_mv;
>>>
>>> vref_mV please. And yes, I know historical and other reasons for them
>>> all being small, but let's try to be more scientific in these crazy
>>> days.
>>
>> Sorry Andy but I see zero reason to use capital letters here. In my
>> opinion, this is perfectly clear as it is. Capital letters in variables
>> are ugly (to me) and absolutely not needed to explain the meaning.
> 
> And I see zero reason to not use the correct scientific unitis there.

I find this ridiculous reason. There is zero confusion what the vref_mv 
stands for, and I prefer variables in lower case.

> Note, that regulator framework

Actually, the regulator framework uses _both_ lower and upper case in 
some places, and I believe the reason is that bikeshedding over the 
capitalization isn't Mark's cup of tea.

> and some other drivers are using that
> and I consider this is the correct way to go.
> 
> ...
> 
>>> Or actually a time to introduce MILLIVOLT_PER_VOLT in units.h ?
>>
>> I really fail to see the benefit. Do you think we should add
>> MILLIx_PER_x for each unit we can imagine/use?
>>
>> That doesn't really scale or make sense to me. We have MILLI. It does
>> not really matter if it is volts, amps, ohms or horse heads - it's still
>> 1000. It just gets cumbersome to search the headers to see if we have
>> some fancy define for unit we have at our hands.
> 
> In some contexts this gives the understanding of the units and how big
> the value is. Even with some defined constants it's not possible to
> describe in their names everything that this definition adds. I do see
> a benefit of it.

You can suggest adding it if you wish. I still find it silly as I don't 
see why one wouldn't then end up adding base SI units too.

MILLIVOLT_PER_VOLT
MILLIKILOGRAM_PER_KILOGRAM
MILLIMETER_PER_METER
MILLISECOND_PER_SECON
MILLIAMPERE_PER_AMPERE
MILLIKELVIN_PER_KELVIN
MILLIMOLE_PER_MOLE
MILLICANDELA_PER_CANDELA

Oh, and because Volt is added, then also:

Newton, Heryz, Coulomb, Henry, Farad, Ohm, Siemens, Weber, Tesla, Joule, 
Watt, Radian, Bequerel and Lumen.

And, sure adding Kelvin warrants adding Celsius and Fahrenheit. Oh, 
probably also imperial units, right?

All being the same MILLI.

No thanks. I am opposing this as it will only make life of a code writer 
(and maybe also reader) harder. I'm not suggesting a patch adding 
something I feel is rather silly.

Yours,
	-- Matti


