Return-Path: <linux-iio+bounces-12391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD30D9D1FC9
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 06:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D82809DC
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 05:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A83F14D70B;
	Tue, 19 Nov 2024 05:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUXrB6U1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A828142E7C;
	Tue, 19 Nov 2024 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731995735; cv=none; b=QVo+WUgY/ZT7PVlRUMuXmjNtARn12W0qp9aC5+FnyjPlmzhkkKinZ3JBctgJNBDWQM3kGMK1PRFklNjIvYpIk5CN8VUWZi6pOfGazTrVWnM15q7OozDwc2Gy7uxMyH0vzrZz8qMgcBBbvhrRokenNtWsBEdWdMoVq/O14T67gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731995735; c=relaxed/simple;
	bh=0IMQ4hgl4N5J4helA2WK+ae17Sh+6YQliw7GRUgg9pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLNs/Ls8VxLqlWdhWdH5NCm23qD84Ap1MtqNUdBY3st6+XFSmBnBSdwvbClLGSNqQnaBLZYDWl3CjVtrNoV8SMHPxVAIDnMboUVCW6eZVxgzxsWuxllP5mGw7NLdA1fvGGN90/VNnTBz0CkFN1H3fXWZ8B1NsDwBb4dVym5vc44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUXrB6U1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so712177e87.1;
        Mon, 18 Nov 2024 21:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731995731; x=1732600531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMZBGPIpqbzYnIlvpQMDp1Zjz6uQ/rvsdprb5GggxOw=;
        b=AUXrB6U19Sh1FVGTAkgZCW3VGKnQDW6KdlNJ37FQ9RJcJlAWgs5/Uu+BhjmJNOaW/5
         BNNIq7bXCW/j1d8GrWqzzXEh63xKM4bLq9BlY/odG3ebR33xZquuUqhsoD2iVr34rgj6
         59pFSUzyBeFHZa/J1QqfwbY/bZU1xRd14EFyLJUEJdDRNMWn1s6CGt1TM159NLkCOAmx
         uJ+mUi1xwIq2Fvi4HjKRPrPjxySc4QTGrNZB8N0VwfWX+Ot2vUIuGLQjNyJSAC0Wf9/L
         oLBKvUdwHw10zlMIdsaPObNOwBufsx1nJogQA8PpqSJThaiymYP8eChSCdzRwYc0lJJ+
         X+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731995731; x=1732600531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMZBGPIpqbzYnIlvpQMDp1Zjz6uQ/rvsdprb5GggxOw=;
        b=Esmd1Mp5cUbtjudpiYsURaU0XFv3D/PeelU+ViI4caYkGh+x5e8KGTWgdh4ZA73o7A
         Uzst/Xb6T/TaSK1sZIyHQ4J7/9veVxwV0IO7bScflp5srCpw9wJggSHdsVicqw+4/Vfk
         j9udpxSIqFODZo8atU7W7nuJ5DUFndkJ2JnjpXpgE92YvdyhxveS9o8hPXZKQkrcqAPD
         +vbUzzFfIonNr28R/LOam2tCnh0UNlq9u4KER0kfCi/wHoj9oPerTceCf8YDTJBjajX+
         DdYUfcyd5MqZ/QwqKDZ7Z+zkQhjZsAm3oFLDMKRxNEihlXkmGkG/ylA4OPIi2wfb63/8
         6UCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkHFdCT3+uS6/W9OePjqJgwbhcWPOJanKrg8nK/uGWymV06S3n/tSYOv/1IVnH8kvd77iiYF+pQR0=@vger.kernel.org, AJvYcCWsavwvnykXhUumFCAm5NKeuDbD3W5m6fx8dZUAT85rtuY0vmbOm6vrOXYv/UbxCwXDfNpJAlhOOn6+Nx21@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZX/9cxM1gbEmGfA0JYKnpn4wx2fwVZNCp6re9Fht3JdlMaet
	cMz+JQ71Wb3XMVld9Z9xDfmujDkyQlGXJ4VPPgzNZR/v3yDPN181
X-Google-Smtp-Source: AGHT+IGs+IQgtv7gpNRIU370TzLXUW9y7tNCRzRZinkhoTJhIQncxo5iLLKEv9+LhVZlKOaN1lRnBg==
X-Received: by 2002:a05:6512:3ba5:b0:52c:d819:517e with SMTP id 2adb3069b0e04-53dab2a6343mr6496892e87.30.1731995730590;
        Mon, 18 Nov 2024 21:55:30 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd4672e1sm183364e87.144.2024.11.18.21.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 21:55:29 -0800 (PST)
Message-ID: <fda40996-abe5-436d-a4f1-9edfa01bfb1d@gmail.com>
Date: Tue, 19 Nov 2024 07:55:27 +0200
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
 <42461eea-3e6d-4a15-a2fc-fa154163d80a@gmail.com>
 <9073554f353273d0aa99a7aebfc5f367cfaa7c1a.camel@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <9073554f353273d0aa99a7aebfc5f367cfaa7c1a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/11/2024 09:44, Nuno Sá wrote:
> On Fri, 2024-11-15 at 08:20 +0200, Matti Vaittinen wrote:
>> On 14/11/2024 14:26, Nuno Sá wrote:
>>> On Thu, 2024-11-14 at 13:30 +0200, Matti Vaittinen wrote:
>>>> On 14/11/2024 12:46, Nuno Sá wrote:
>>>>> On Thu, 2024-11-14 at 11:54 +0200, Matti Vaittinen wrote:
>>>>>> On 14/11/2024 11:43, Nuno Sá wrote:
>>>>>>> On Thu, 2024-11-14 at 08:57 +0200, Matti Vaittinen wrote:
>>>>>>>> All the sensors supported by kx022a driver seemed to require some
>>>>>>>> delay
>>>>>>>> after software reset to be operational again. More or less a
>>>>>>>> random
>>>>>>>> msleep(1) was added to cause the driver to go to sleep so the
>>>>>>>> sensor
>>>>>>>> has
>>>>>>>> time to become operational again.
>>>>>>>>
>>>>>>>> Now we have official docuumentation available:
>>>>>>>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>>>>>>>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>>>>>>>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>>>>>>>
>>>>>>>> stating the required time is 2 ms.
>>>>>>>>
>>>>>>>> Due to the nature of the current msleep implementation, the
>>>>>>>> msleep(1)
>>>>>>>> is
>>>>>>>> likely to be sleeping more than 2ms already - but the value "1" is
>>>>>>>> misleading in case someone needs to optimize the start time and
>>>>>>>> change
>>>>>>>> the msleep to a more accurate delay. Hence it is better for
>>>>>>>> "documentation" purposes to use value which actually reflects the
>>>>>>>> specified 2ms wait time.
>>>>>>>>
>>>>>>>> Change the value of delay after software reset to match the
>>>>>>>> specifications and add links to the power-on procedure
>>>>>>>> specifications.
>>>>>>>>
>>>>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>>>> ---
>>>>>>>> Sorry for not including this to the KX134ACR-LBZ series I sent
>>>>>>>> yesterday. It was only half an hour after I had sent the KX134ACR-
>>>>>>>> LBZ
>>>>>>>> support when I was notified about the existence of the KX022ACR-Z
>>>>>>>> start-up procedure specification... Hence this lone patch to code
>>>>>>>> which
>>>>>>>> I just sent a miscallaneous series for before.
>>>>>>>>
>>>>>>>>      drivers/iio/accel/kionix-kx022a.c | 11 ++++++++---
>>>>>>>>      1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/iio/accel/kionix-kx022a.c
>>>>>>>> b/drivers/iio/accel/kionix-
>>>>>>>> kx022a.c
>>>>>>>> index 32387819995d..ccabe2e3b130 100644
>>>>>>>> --- a/drivers/iio/accel/kionix-kx022a.c
>>>>>>>> +++ b/drivers/iio/accel/kionix-kx022a.c
>>>>>>>> @@ -1121,10 +1121,15 @@ static int kx022a_chip_init(struct
>>>>>>>> kx022a_data
>>>>>>>> *data)
>>>>>>>>      		return ret;
>>>>>>>>      
>>>>>>>>      	/*
>>>>>>>> -	 * I've seen I2C read failures if we poll too fast after
>>>>>>>> the
>>>>>>>> sensor
>>>>>>>> -	 * reset. Slight delay gives I2C block the time to
>>>>>>>> recover.
>>>>>>>> +	 * According to the power-on procedure documents, there
>>>>>>>> is
>>>>>>>> (at
>>>>>>>> least)
>>>>>>>> +	 * 2ms delay required after the software reset. This
>>>>>>>> should
>>>>>>>> be
>>>>>>>> same
>>>>>>>> for
>>>>>>>> +	 * all, KX022ACR-Z, KX132-1211, KX132ACR-LBZ and
>>>>>>>> KX134ACR-
>>>>>>>> LBZ.
>>>>>>>> +	 *
>>>>>>>> +	 *
>>>>>>>> https://fscdn.rohm.com/kionix/en/document/AN010_KX022ACR-Z_Power-on_Procedure_E.pdf
>>>>>>>> +	 *
>>>>>>>> https://fscdn.rohm.com/kionix/en/document/TN027-Power-On-Procedure.pdf
>>>>>>>> +	 *
>>>>>>>> https://fscdn.rohm.com/kionix/en/document/AN011_KX134ACR-LBZ_Power-on_Procedure_E.pdf
>>>>>>>>      	 */
>>>>>>>> -	msleep(1);
>>>>>>>> +	msleep(2);
>>>>>>>
>>>>>>> msleep() is not advisable for something lower than 20ms. Maybe take
>>>>>>> the
>>>>>>> opportunity and change it to fsleep()?
>>>>>>
>>>>>> Thank you for the suggestion Nuno. I did originally consider using the
>>>>>> usleep_range() since the checkpatch knows to warn about msleep with
>>>>>> small times.
>>>>>>
>>>>>> However, there should be no rush to power-on the sensor at startup. It
>>>>>> usually does not matter if the sleep is 2 or 20 milli seconds, as long
>>>>>> as it is long enough. I wonder if interrupting the system with
>>>>>> hrtimers
>>>>>> for _all_ smallish delays (when the longer delay would not really
>>>>>> hurt)
>>>>>
>>>>> That's why you have ranges of about 20% (I think) in usleep() so you
>>>>> minimize
>>>>> hrtimers interrupts.
>>>>>
>>>>> Other thing is boot time... Sleeping 20ms instead of 2ms is a huge
>>>>> difference.
>>>>> Imagine if everyone thought like this for small sleeps :)?
>>>>
>>>> I think this is interesting question. My thoughts were along the line
>>>> that, even if small sleeps were extended to longer (where small sleep is
>>>> not a priority), the CPUs would still (especially during the boot up)
>>>> have their hands full. I don't know if we might indeed end up a
>>>> situation where CPUs were idling, waiting for next timer slot.
>>>
>>> My problem is not the CPU but delaying probing devices as you probe one
>>> device
>>> at time...
>>>
>>>>
>>>> What comes to boot time, I doubt the CPUs run out of things to do,
>>>> especially when we use the probe_type = PROBE_PREFER_ASYNCHRONOUS.
>>>
>>> Yeah, with this, the above does not apply. Still, spending more time in a
>>> worker
>>> than needed (and 18ms is huge) seems a waste to me.
>>
>> This is likely to be my ignorance, but I don't know what is wasted here.
>> (genuine question, not trying to be a smart-ass).
> 
> Well, AFAIK, async probing is using the async.c API which is based on workers.

Yes.

> If you spend (worst case scenario) 18ms more than you need in the handler (and
> 18ms is __huge__), it means that worker can't go on and do some other useful
> stuff, right?

I thought there can be more than one concurrent active work items? It 
would be surprizing to me if aynchronous probe would block other probes. 
Please, let me know if this is the case.

>>>>>> is a the best design choice. Hence I'd rather keep the msleep when we
>>>>>> don't need to guarantee delay to be short instead of defaulting to
>>>>>> hrtimers or even busy-loop when it is not required.
>>>>>>
>>>>>> Do you think I am mistaken?
>>>>>>
>>>>>
>>>>> To me this is more about correctness and do what the docs tell us to do
>>>>> :).
>>>>> Sure, here you know what you're doing and you don't care if you end up
>>>>> sleeping
>>>>> more than 2ms but that's not always the case and code like this allows
>>>>> for
>>>>> legit
>>>>> mistakes (if someone just copy paste this for example).
>>>>
>>>> Right. I just wonder if always requiring stricter wake-up instead of
>>>> allowing things to run uninterrupted is the best role model either?
>>>
>>> Why not :)? If we just need to wait 2ms, why waiting more? I would be very
>>> surprised if hrtimers are a deal breaker in here. Otherwise, we should
>>> remove it
>>> from the docs...
>>
>> Again I may be wrong, but I think each of the interrupts we add, require
>> tiny bit of handling - which I thought is more of a waste than sleeping.
>>
> 
> Not that it's even every likely that you're not adding a new interrupt
> necessarily. That's the point of the range in usleep(). So that multiple
> handlers can be done in one interrupt.

This could be true. Especially if every other "thing" which needs some 
delay (but has no strict lower limit) defaults to hrtimers.

> Put it this way... if that was true, I would assume it would be somewhere
> described in the sleeping docs. More, I don't think the rule of thumb would be
> to use hrtirmers for things < 20ms.

This is exactly why I questioned the rule-of-thumb. I deeply dislike 
"rules of thumb" - when I don't understand the rationale. If we assume 
hrtimers came without a cost, then we should have no need for msleep() 
at all, right?

Everything I read suggests the msleep() is actually lighter (but with 
the downside it can't guarantee short timeouts). Hence I have preferred 
it when short timeout does _not_ need to be guaranteed. (I still very 
much understand the checkpatch warn because one might very well assume 
msleep() could be used to sleep 1 ms).

After all this discussing, I don't really see point of switching to 
fsleep() - unless delaying of the (asynchronous) probe proves to be a 
real problem. If it does, then my assumption that the short timeout does 
not need to be guaranteed is false and this should be changed.

Thanks for the insight :)

Yours,
	-- Matti

