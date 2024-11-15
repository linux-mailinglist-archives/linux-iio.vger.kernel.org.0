Return-Path: <linux-iio+bounces-12297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35989CD701
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 07:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3462F1F2232B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62809185B5B;
	Fri, 15 Nov 2024 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KngT3dxE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E080156C6C;
	Fri, 15 Nov 2024 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651635; cv=none; b=uxA1QGEv9phamnbYLkXkQDfEMC8r/tIj7TdSklVgcmLVCnP7BExbW7JJGDsYVRLvSvF+stzuANBBXnZ4JdVHFYo5Q8XVXVGQPZHSHMS+CDCJ46jzEcYc6e3EgCj5S0gruhql7LzCSezi9AT9UPEiFylg2iowJsyq+6WiYD0Vc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651635; c=relaxed/simple;
	bh=AmYlWfQ1hqFOtt/krsqaaeAgLSMnC2MC75YRVS2HAVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vht1XXeB5J0g1uWZWerDovLyvWWs56xDA0Bl+bGrAk62jGRA7a1Whc6tLR4vI1pF9zUlXeZV1oAGi8HA7RpRmr6KCMewVqnDp7ElUQcW6IaaRW6Yv3f4qs2CTM8odX6c+3truUMmhuc1nqjtq7if018vxbB6CzgJbTCwlRkOlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KngT3dxE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb518014b9so12358631fa.3;
        Thu, 14 Nov 2024 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731651631; x=1732256431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJk4SH7HyxsUDoLsYYv3aR5XZ89qJr6Dyonw5ce4SrA=;
        b=KngT3dxEqAANkX2FbA28efPZvL0qYn/0PFGxQLIvnXEw2+WOXCsDO9cfn8xh6CyQdc
         7dPeZ50frJJFl+nZZ+mM2wc8ykT9XmJBFuQqLPkGk81YEqMAIEGDb4/A9O2giiviVyQs
         SZgnN9KJsbRx2xjmoAjpGBx7nBeIFjm0bVurghocg4eB5o0dZ7Kf2MRuWbzLc2NZmN98
         iRe0flycMHgK1Tb9SBRqyJYMfKdjcr5f1up83VC6RQVfb6V17u1ikKbVfgb6VALoagsK
         +a8SENf38kwc/bAMWMh63T0ZlrPKAdqCVtwqCKitpXx8TOZaWE5hS+Z9RLqcEPNumSHK
         hjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731651631; x=1732256431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJk4SH7HyxsUDoLsYYv3aR5XZ89qJr6Dyonw5ce4SrA=;
        b=hLDQyDTu9GNTWQD+XfAkQBsRJDfcebZkc7fF7mzDHOiirfriHoRpPyfpA373H/c6K6
         EqJ5TU+2Xn9S0Gk43kpHvZpNdMDbAv1UjF4Ua8UBz5WALsEnpQq2QshdrGpWIKNCqN+d
         KSnyvb+pABnIdZbqXcTJnwfWGxeqbaC806HOkydUX6t/C/BnpOv7eEAE3HEFJHjduLzz
         WKdIAeoJL7fQZS6z9u96AugIMj5s+RKW7y41YbH29kcQbdbN3KniY1rlp7Tt91Ig+Qek
         PdNpJ5jRrH5vvWM730J5WMhoxnpWYP2GtO13ogx50b7ZQ6ssi2ccFHjsxC4ZbYH5tImE
         tzsg==
X-Forwarded-Encrypted: i=1; AJvYcCU+eRWo1aa2SZ2O6T85poTfm94wUmPQi30aEoUVpRdWcYC4agSVNlLPyqI/1SYRkQCB+izkm0auZ18=@vger.kernel.org, AJvYcCWyZSR16NlIJYttHaFC0/zRG29JSPHMPy5JmT9CmdMAM3nhGMvrfNE27JQMyhMtnobKOHboq28p7AYvKXZb@vger.kernel.org
X-Gm-Message-State: AOJu0YxXpev7UsdakwuQA1XU3sy0sxBS2eJ0PE9/oyrRnIqt+t0WmA6l
	tYzxEvwBNbEO7IhQe1vNumEva6SvLMElRj0zne3z4SPdsfdUTXRP70idoEhs
X-Google-Smtp-Source: AGHT+IH1jMu6bbneAfOEm7FhH4HKvjLbcyxiy0vAPTVTJGgNpduy9grC/z65NIjw2qufJO81YwQn9w==
X-Received: by 2002:a2e:a9a9:0:b0:2fa:de52:f03c with SMTP id 38308e7fff4ca-2ff608f15a1mr5727201fa.5.1731651630773;
        Thu, 14 Nov 2024 22:20:30 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff59763e18sm4367521fa.21.2024.11.14.22.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 22:20:28 -0800 (PST)
Message-ID: <42461eea-3e6d-4a15-a2fc-fa154163d80a@gmail.com>
Date: Fri, 15 Nov 2024 08:20:26 +0200
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
 <1410938e-5135-434c-911e-7ba925bafd49@gmail.com>
 <b0a9eecb7b83c29aa545ed7717e3a6c2275b5e27.camel@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <b0a9eecb7b83c29aa545ed7717e3a6c2275b5e27.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/11/2024 14:26, Nuno Sá wrote:
> On Thu, 2024-11-14 at 13:30 +0200, Matti Vaittinen wrote:
>> On 14/11/2024 12:46, Nuno Sá wrote:
>>> On Thu, 2024-11-14 at 11:54 +0200, Matti Vaittinen wrote:
>>>> On 14/11/2024 11:43, Nuno Sá wrote:
>>>>> On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
>>>>>> All the sensors supported by kx022a driver seemed to require some
>>>>>> delay
>>>>>> after software reset to be operational again. More or less a random
>>>>>> msleep(1) was added to cause the driver to go to sleep so the sensor
>>>>>> has
>>>>>> time to become operational again.
>>>>>>
>>>>>> Now we have official docuumentation available:
>>>>>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>>>>>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>>>>>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>>>>>
>>>>>> stating the required time is 2 ms.
>>>>>>
>>>>>> Due to the nature of the current msleep implementation, the msleep(1)
>>>>>> is
>>>>>> likely to be sleeping more than 2ms already - but the value "1" is
>>>>>> misleading in case someone needs to optimize the start time and change
>>>>>> the msleep to a more accurate delay. Hence it is better for
>>>>>> "documentation" purposes to use value which actually reflects the
>>>>>> specified 2ms wait time.
>>>>>>
>>>>>> Change the value of delay after software reset to match the
>>>>>> specifications and add links to the power-on procedure specifications.
>>>>>>
>>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>> ---
>>>>>> Sorry for not including this to the KX134ACR-LBZ series I sent
>>>>>> yesterday. It was only half an hour after I had sent the KX134ACR-LBZ
>>>>>> support when I was notified about the existence of the KX022ACR-Z
>>>>>> start-up procedure specification... Hence this lone patch to code
>>>>>> which
>>>>>> I just sent a miscallaneous series for before.
>>>>>>
>>>>>>     drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
>>>>>>     1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
>>>>>> b/drivers/iio/accel/kionix-
>>>>>> kx022a.c
>>>>>> index 32387819995d..ccabe2e3b130 100644
>>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>>>>> @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct kx022a_data
>>>>>> *data)
>>>>>>     		return ret;
>>>>>>     
>>>>>>     	/*
>>>>>> -	 * I've seen I2C read failures if we poll too fast after the
>>>>>> sensor
>>>>>> -	 * reset. Slight delay gives I2C block the time to recover.
>>>>>> +	 * According to the power-on procedure documents, there is
>>>>>> (at
>>>>>> least)
>>>>>> +	 * 2ms delay required after the software reset. This should
>>>>>> be
>>>>>> same
>>>>>> for
>>>>>> +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and KX134ACR-
>>>>>> LBZ.
>>>>>> +	 *
>>>>>> +	 *
>>>>>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>>>>>> +	 *
>>>>>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>>>>>> +	 *
>>>>>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>>>>>     	 */
>>>>>> -	msleep(1);
>>>>>> +	msleep(2);
>>>>>
>>>>> msleep() is not advisable for something lower than 20ms. Maybe take the
>>>>> opportunity and change it to fsleep()?
>>>>
>>>> Thank you for the suggestion Nuno. I did originally consider using the
>>>> usleep_range() since the checkpatch knows to warn about msleep with
>>>> small times.
>>>>
>>>> However, there should be no rush to power-on the sensor at startup. It
>>>> usually does not matter if the sleep is 2 or 20 milli seconds, as long
>>>> as it is long enough. I wonder if interrupting the system with hrtimers
>>>> for _all_ smallish delays (when the longer delay would not really hurt)
>>>
>>> That's why you have ranges of about 20% (I think) in usleep() so you
>>> minimize
>>> hrtimers interrupts.
>>>
>>> Other thing is boot time... Sleeping 20ms instead of 2ms is a huge
>>> difference.
>>> Imagine if everyone thought like this for small sleeps :)?
>>
>> I think this is interesting question. My thoughts were along the line
>> that, even if small sleeps were extended to longer (where small sleep is
>> not a priority), the CPUs would still (especially during the boot up)
>> have their hands full. I don't know if we might indeed end up a
>> situation where CPUs were idling, waiting for next timer slot.
> 
> My problem is not the CPU but delaying probing devices as you probe one device
> at time...
> 
>>
>> What comes to boot time, I doubt the CPUs run out of things to do,
>> especially when we use the probe_type = PROBE_PREFER_ASYNCHRONOUS.
> 
> Yeah, with this, the above does not apply. Still, spending more time in a worker
> than needed (and 18ms is huge) seems a waste to me.

This is likely to be my ignorance, but I don't know what is wasted here. 
(genuine question, not trying to be a smart-ass).

>>>> is a the best design choice. Hence I'd rather keep the msleep when we
>>>> don't need to guarantee delay to be short instead of defaulting to
>>>> hrtimers or even busy-loop when it is not required.
>>>>
>>>> Do you think I am mistaken?
>>>>
>>>
>>> To me this is more about correctness and do what the docs tell us to do :).
>>> Sure, here you know what you're doing and you don't care if you end up
>>> sleeping
>>> more than 2ms but that's not always the case and code like this allows for
>>> legit
>>> mistakes (if someone just copy paste this for example).
>>
>> Right. I just wonder if always requiring stricter wake-up instead of
>> allowing things to run uninterrupted is the best role model either?
> 
> Why not :)? If we just need to wait 2ms, why waiting more? I would be very
> surprised if hrtimers are a deal breaker in here. Otherwise, we should remove it
> from the docs...

Again I may be wrong, but I think each of the interrupts we add, require 
tiny bit of handling - which I thought is more of a waste than sleeping.

I admit this is all hand-waving as I have no test data to back up my 
pondering. And, I believe you are right that this surely is not a deal 
breaker - but neither do I see adding more interrupts (when not really 
needed) as a good design.

>>> Not a big deal anyways...
>>
>> Agree :) But I think this is a spot where I could learn a bit. I will
>> gladly switch to the fsleep() if someone explains me relying on hrtimers
>> should be preferred also when there is no real need to wake up quicker
>> than msleep() allows.
>>
> 
> Personally, I think that sleeping more than needed is always a wast and then it
> comes back to my correctness comment. In here you know what you're doing but I
> dunno that switching to hrtimers will do any arm to the device :) and allows
> proper patterns to be copied.

I have been thinking that handling the (hrtimer) interrupts generates 
more overhead (waste) than sleeping.

By the way, thanks for the reviewing work Nuno! :) I appreciate it.

Yours,
     -- Matti

