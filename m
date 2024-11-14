Return-Path: <linux-iio+bounces-12247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428C89C88F6
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 12:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC141F24861
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 11:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936461F9A91;
	Thu, 14 Nov 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEjM8KwB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791721DA61E;
	Thu, 14 Nov 2024 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731583844; cv=none; b=FBz0tTL+muG2amRrn88YA8fy2ni+sjt5azw2SDedmlQzUUuB2WHdtyLXrXn+eK0uYHJvbxNmanD3MnlTzDhaW2cz7D58U5Pwby6lVKNRj45rTxK6w7u/aozyuWbaFnANY7OwnQhq9gqIHq5Bc+8d/MMoEiPZG6wSqb1/tESm2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731583844; c=relaxed/simple;
	bh=hRD4BKZVaxgBzUOHxWoudCPhmtWb5ew723zgsc94Izc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaOEfekyKs0/ji4ssC67yd0YeFP+3iaK2MUOXRMo5WRH0gojQJS5j+YnHdtxTWMXR3LqynnkCmMWMFAoqYsvbvnTSr0FxjP2h9P8e+O+PnAv9+RfbREXzyuEPQU81tyCVtog5CP2aMOJlcvadelZ0kxC8m/pByscWZsYbad34JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEjM8KwB; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e4b7409fso439209e87.0;
        Thu, 14 Nov 2024 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731583840; x=1732188640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEX5GwYmBNON0GE7V12uBchTc7MznAcgp4EpJUax770=;
        b=PEjM8KwBx/sYVs/+92Hks39DIKJfWfF7XF1bvSLq0adlFO5Oli2BOzEuDyPt9xr+zL
         pEjgPANfEF2HM/4HXLZMz6ZoKVz0IZo9pGmyzjKB9jrnC5Nh73x0qpTRHpJlRXmPaTAI
         ESqHS3YBZBUUuMl9+x7BUcChnEWJFN8W10I2cBo4BOXTV+fkL2umziDdVTxg+PgU/pGE
         cpWKdxkfagS6x6OkJFNI3cuSYz3poJwUVpNrAR/H+Si1GOisY1LzkhitX9sc8VZyClRh
         nHUFcew/4t7HOxQD6E3brF7iIYhJm0AH49oAAEZOqqkpUmX8W+1OqgsMdfFbLg4oLHAN
         nEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731583840; x=1732188640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEX5GwYmBNON0GE7V12uBchTc7MznAcgp4EpJUax770=;
        b=SfoV9UY5Iko/hoIIMtb2n9fFpjrduMG++/1P91WsC+HQQIv9hL9NM91HAB56j3bzzs
         Xs9hvwKmbZV6OtfmarRJa9pTsjtk8c7pPQnUHI85PWG3cJXBIfC9tDkt+j7WR1HRddze
         +Dp25vf58h5xzyiZqfKlUC0Z5sc8wKXdRxMOwCpQcBd6lTm4aORNTYz9J2gx6X3s806/
         SASmx/s/dhgT+lu1jWn74eaTGyzlV9Cu7Uo4pJQnNmHMATiz5bov+KsiWHaUN+xVDTTj
         9CFq5UNCaiwvTZ1UL5P6KZPo2zTYlnYWrhyulssu7kP/pJifMiTxs7H5b2hNwuAQIorz
         7Ifw==
X-Forwarded-Encrypted: i=1; AJvYcCUtimBUuxb0z7H57wtIhVuC5oD50Xv/yKKtqgsUaElq/DYXS/dBUfgW9Z7Ogklxi6haMKud/CeYrFBfva3v@vger.kernel.org, AJvYcCVoeriztOOns9K86nSNjmzgviOYh7ddK3fA2ah4STxWYa5/pc7f83bzn3irhk6RAwsbfO1a5Tz27Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/RJHkI33/yEtrAQFl51WHEWihXmsdsVeiV9cOIM76dn6PKCj
	NdTNs5fZ/cIUmTM0unDfVSuQCJR6eovaF6wFVxoAWTYjwVYMG4LN
X-Google-Smtp-Source: AGHT+IHkWIfqGoeDDAubCFqdpmqXKIZgbj0xXAVVaLn902NxJWgsKZRI0Mbl+aIBsYSSxu3826X0+A==
X-Received: by 2002:a05:6512:39d0:b0:53b:1f90:5779 with SMTP id 2adb3069b0e04-53da49bdc32mr743478e87.28.1731583839279;
        Thu, 14 Nov 2024 03:30:39 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da64f8c76sm154913e87.12.2024.11.14.03.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 03:30:37 -0800 (PST)
Message-ID: <1410938e-5135-434c-911e-7ba925bafd49@gmail.com>
Date: Thu, 14 Nov 2024 13:30:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: kx022a: Improve reset delay
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZzWfXbjaDkFnu_Jg@mva-rohm>
 <be375e24f74997743743fadf68125e176c23e2df.camel@gmail.com>
 <f4cf3437-87ea-4d0f-8dab-890d89f85605@gmail.com>
 <1f315c2f3eea86fe4db48f0168660ab4b0b020f1.camel@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <1f315c2f3eea86fe4db48f0168660ab4b0b020f1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/2024 12:46, Nuno Sá wrote:
> On Thu, 2024-11-14 at 11:54 +0200, Matti Vaittinen wrote:
>> On 14/11/2024 11:43, Nuno Sá wrote:
>>> On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
>>>> All the sensors supported by kx022a driver seemed to require some delay
>>>> after software reset to be operational again. More or less a random
>>>> msleep(1) was added to cause the driver to go to sleep so the sensor has
>>>> time to become operational again.
>>>>
>>>> Now we have official docuumentation available:
>>>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>>>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>>>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>>>
>>>> stating the required time is 2 ms.
>>>>
>>>> Due to the nature of the current msleep implementation, the msleep(1) is
>>>> likely to be sleeping more than 2ms already - but the value "1" is
>>>> misleading in case someone needs to optimize the start time and change
>>>> the msleep to a more accurate delay. Hence it is better for
>>>> "documentation" purposes to use value which actually reflects the
>>>> specified 2ms wait time.
>>>>
>>>> Change the value of delay after software reset to match the
>>>> specifications and add links to the power-on procedure specifications.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>> Sorry for not including this to the KX134ACR-LBZ series I sent
>>>> yesterday. It was only half an hour after I had sent the KX134ACR-LBZ
>>>> support when I was notified about the existence of the KX022ACR-Z
>>>> start-up procedure specification... Hence this lone patch to code which
>>>> I just sent a miscallaneous series for before.
>>>>
>>>>    drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
>>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-
>>>> kx022a.c
>>>> index 32387819995d..ccabe2e3b130 100644
>>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>>> @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct kx022a_data
>>>> *data)
>>>>    		return ret;
>>>>    
>>>>    	/*
>>>> -	 * I've seen I2C read failures if we poll too fast after the
>>>> sensor
>>>> -	 * reset. Slight delay gives I2C block the time to recover.
>>>> +	 * According to the power-on procedure documents, there is (at
>>>> least)
>>>> +	 * 2ms delay required after the software reset. This should be
>>>> same
>>>> for
>>>> +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and KX134ACR-LBZ.
>>>> +	 *
>>>> +	 *
>>>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>>>> +	 *
>>>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>>>> +	 *
>>>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>>>    	 */
>>>> -	msleep(1);
>>>> +	msleep(2);
>>>
>>> msleep() is not advisable for something lower than 20ms. Maybe take the
>>> opportunity and change it to fsleep()?
>>
>> Thank you for the suggestion Nuno. I did originally consider using the
>> usleep_range() since the checkpatch knows to warn about msleep with
>> small times.
>>
>> However, there should be no rush to power-on the sensor at startup. It
>> usually does not matter if the sleep is 2 or 20 milli seconds, as long
>> as it is long enough. I wonder if interrupting the system with hrtimers
>> for _all_ smallish delays (when the longer delay would not really hurt)
> 
> That's why you have ranges of about 20% (I think) in usleep() so you minimize
> hrtimers interrupts.
> 
> Other thing is boot time... Sleeping 20ms instead of 2ms is a huge difference.
> Imagine if everyone thought like this for small sleeps :)?

I think this is interesting question. My thoughts were along the line 
that, even if small sleeps were extended to longer (where small sleep is 
not a priority), the CPUs would still (especially during the boot up) 
have their hands full. I don't know if we might indeed end up a 
situation where CPUs were idling, waiting for next timer slot.

What comes to boot time, I doubt the CPUs run out of things to do, 
especially when we use the probe_type = PROBE_PREFER_ASYNCHRONOUS.


>> is a the best design choice. Hence I'd rather keep the msleep when we
>> don't need to guarantee delay to be short instead of defaulting to
>> hrtimers or even busy-loop when it is not required.
>>
>> Do you think I am mistaken?
>>
> 
> To me this is more about correctness and do what the docs tell us to do :).
> Sure, here you know what you're doing and you don't care if you end up sleeping
> more than 2ms but that's not always the case and code like this allows for legit
> mistakes (if someone just copy paste this for example).

Right. I just wonder if always requiring stricter wake-up instead of 
allowing things to run uninterrupted is the best role model either?

> Not a big deal anyways...

Agree :) But I think this is a spot where I could learn a bit. I will 
gladly switch to the fsleep() if someone explains me relying on hrtimers 
should be preferred also when there is no real need to wake up quicker 
than msleep() allows.

Thanks for the discussion!

Yours,
	-- Matti


