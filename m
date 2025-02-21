Return-Path: <linux-iio+bounces-15910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A8A3F182
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 11:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663D0189E2E0
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CA204F79;
	Fri, 21 Feb 2025 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9F8oyq1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140E1F4299;
	Fri, 21 Feb 2025 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132632; cv=none; b=tNnL/LmHaqnRLUEDhUX5Qf+4DRj7IxtxjUAYjG7RTIo/5Auh5Y7U+8Y700VluhHpY3+baW57pC7l9HkfWkZF8SF1qSFOUz6CPb+Q68reIkwFCGk6/IzdZI7rvPUNaF2MtsST+/1b6cnjT6Z9EWICHL3/E6a1/kuO02TYTYDWR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132632; c=relaxed/simple;
	bh=GABZIa1yk+ME7OqVVkc9YSIBFoStKBRMFdZ+km85+xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jc7/fZszjZ8ZNAO4l+lzazrA4QB6WvNVbOlnNJFTR4RZaZSK5n6h0k4lvQmeZIVwkVcPxPD5ZBd/lADp/TPSH1svtTJg8PeDX+igzoLAllvB7/qU63AYtSQC4aDNlH29aNFPSMGxGaEZqtXf/TM4mocUH0IEHO808cabffdyfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9F8oyq1; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30737db1aa9so18378171fa.1;
        Fri, 21 Feb 2025 02:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132628; x=1740737428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bG0BbpFoyNoqsk135c328imcMJ0+Nr3ev0Mcwuo/rmM=;
        b=T9F8oyq1hL0rRgqyIbsoObHQs7gYhQLyWFWQffnjgMteATI/nTSAKAs1rVILnj0g9x
         bbHKMio9ilwgPpAnOJ9XK3ckTqqo707Ebr18C1CPbONQvkXa9jebs4q+YVzzOqL55xUD
         7OyxOGz0ar03mneTGhR7Ib63zMvX5lbKK2Mk1iYpQSbBi0TSxnD3vVCE4mubMEezXLdI
         C4iGeg7VN+nerJXOb3jmNMKdgseswV+SCXxrPlToEcQ+1BwwZte8uIHeBxdj7xvXRnB6
         kObu1p1xtkIjd1M2DwyOBUS5W1V4B2k3sKyG9fs3fRSFUFRgjIKr5c83dmpkYRsnJ0mR
         3R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132628; x=1740737428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bG0BbpFoyNoqsk135c328imcMJ0+Nr3ev0Mcwuo/rmM=;
        b=PedEQTvatG8Q5u5DmRt6YOcZcryjo49kOa+OhCw5+nK7t305pHDDKvfxxsvFqT99EP
         UN9Iz3r71HxzWN6KnUqRI4aX3+kQJdFdunCp28ud0Tn555Q0HZxTTSLHXSxhbJh8mK+I
         rGO/vdjyQg1uue6fwPj/t7KydToBmVF53QazeUtqDWOe1Kxd0GZxFvj0dtctmVFH6ZsN
         dAMBUKaOMpX0ekKpaXUO7rlrG5yMKEE00G+QnChp3DHrNsFGqIq1P7cr6lYwvPf428Jm
         oXmZhKdDpavPpUi6ZSt2GD4Li9yxJptH8sj21zd1dRqYspm0Riq74C0ttVSZi3RKya0a
         7L9w==
X-Forwarded-Encrypted: i=1; AJvYcCW/LmlL9ad/qNLiFMiPgR6WCLoV19Sn2kM/vSkiWZ5vTTdFBft0HfYZRn3yOFopjI+oPwLGA5TT3QAT@vger.kernel.org, AJvYcCW/ZjeVFMtU7NLTLmvwFeXquiTTy+cDfauKPq7nRDYDl338LWbq3Iv7NLbsGP9I0js4R1jxDtV2BDTO@vger.kernel.org, AJvYcCWGJX9tbQjcOErhduAIIdsA+w9/S1jDtWJuGb7tlqH/GoUPV6R5sCQpKM/zubIVBb7hZo7VCVA74cd1QLn89wn8Fbs=@vger.kernel.org, AJvYcCWxSI5li4tlr8TMzxFMBk6DOA/KgtuJYJ35aq0C5cCRry7jP6cM9DvCGMWEbfgDTsVcI6JpJjRIqeMn+kaO@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpJktofVAn+4l8NmDuNieLEHNYLBdeon516m1M3QZEQbQvEGy
	Ifn1wToaSFEWVF0NjRD+Jsx3Y6vDo/p86gU3dQLTcxNqXzHUDNnI
X-Gm-Gg: ASbGncsY4keqD3Ok8ABJgIHZ4Lhha4G6+7rfOPZNXzHlCOTEVBPgf897i58BWXK6grQ
	Jw2TSsq+GRKtpw65MXBK83RVM9CeLsFzfjcYiXPRTbTJb4mqqObSfQ87hjPQXjtd/6ixAwt7K5B
	RVEMfRJHuWqHs1YoCkJ8kSlNeL/sjxwWDEYgNdf0R0EysQQEL6l57ZjFVjDn9HRw+QU7m45aVJ7
	xejEw7zATiDN1g7WlEku4a57Uc++sboNUsxWHzvVFp/hVP4rrOcb5Zq28j30KIv5f5m8/Iv5Vdq
	qt6mhkWaUpRvcwl5E06GmdYgT5yTNjLPfYK/T2uruhL0SdoD2JqNZlR/K+NefMPe624gaO4gPx8
	2OL1we1A=
X-Google-Smtp-Source: AGHT+IEF7HCPBupTpoTIufUdFzsU1NW7CnwkRmSqsaZ2XXJ41DlnitRvGydjhmN16iRmcwFrBfhXBA==
X-Received: by 2002:a05:6512:3f05:b0:542:2e09:639a with SMTP id 2adb3069b0e04-54838edddd1mr724643e87.10.1740132627920;
        Fri, 21 Feb 2025 02:10:27 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105c2fsm2638305e87.117.2025.02.21.02.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:10:26 -0800 (PST)
Message-ID: <cb27d8b1-c978-4443-9ad2-96e930701976@gmail.com>
Date: Fri, 21 Feb 2025 12:10:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] iio: adc: add helpers for parsing ADC nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1739967040.git.mazziesaccount@gmail.com>
 <6c5b678526e227488592d004c315a967b9809701.1739967040.git.mazziesaccount@gmail.com>
 <Z7ZB7RQhyI5Dohrq@smile.fi.intel.com>
 <b1c1ed68-2f4d-447c-9957-5a1bbc63ef6e@gmail.com>
 <Z7ci7tUlRQqZEZSN@smile.fi.intel.com>
 <ec76334b-bb13-4076-811d-9174170dd677@gmail.com>
 <Z7c2cBQpjoc9-Vyu@smile.fi.intel.com>
 <9018e23c-da28-41b0-b774-1598b946a2a1@gmail.com>
 <Z7dCnRzuQTaJXzmb@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z7dCnRzuQTaJXzmb@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2025 16:56, Andy Shevchenko wrote:
> On Thu, Feb 20, 2025 at 04:21:37PM +0200, Matti Vaittinen wrote:
>> On 20/02/2025 16:04, Andy Shevchenko wrote:
>>> On Thu, Feb 20, 2025 at 03:40:30PM +0200, Matti Vaittinen wrote:
>>>> On 20/02/2025 14:41, Andy Shevchenko wrote:
>>>>> On Thu, Feb 20, 2025 at 09:13:00AM +0200, Matti Vaittinen wrote:
>>>>>> On 19/02/2025 22:41, Andy Shevchenko wrote:
>>>>>>> On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>>>>>> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
>>>>>>>
>>>>>>> No namespace?
>>>>>>
>>>>>> I was considering also this. The IIO core functions don't belong into a
>>>>>> namespace - so I followed the convention to keep these similar to other IIO
>>>>>> core stuff.
>>>>>
>>>>> But it's historically. We have already started using namespaces
>>>>> in the parts of IIO, haven't we?
>>>>
>>>> Yes. But as I wrote, I don't think adding new namespaces for every helper
>>>> file with a function or two exported will scale. We either need something
>>>> common for IIO (or IIO "subsystems" like "adc", "accel", "light", ... ), or
>>>> then we just keep these small helpers same as most of the IIO core.
>>>
>>> It can be still pushed to IIO_CORE namespace. Do you see an issue with that?
>>
>> No. I've missed the fact we have IIO_CORE O_o. Thanks for pointing it out!
>>
>>> Or a new opaque namespace for the mentioned cases, something like IIO_HELPERS.
>>
>> I am unsure if it really benefits to split this out of the IIO_CORE. I've a
>> feeling it falls into the category of making things harder for user with no
>> apparent reason. But yes, the IIO_CORE makes sense.
> 
> Probably I was not clear, I mean to put this under a given namespace. There is
> no a such, we have currently:
> 
> IIO_BACKEND
> IIO_DMA_BUFFER
> IIO_DMAENGINE_BUFFER
> IIO_GTS_HELPER
> IIO_RESCALE

Ah. So, the IIO core stuff is still not in a namespace. Those listed 
above are all too specific (I believe, in general, and definitely to 
carry ADC helpers).

Adding 'ADC_HELPERS' would just add yet another way too specific one. 
So, currently there is no suitable namespace for these helpers, and I 
still believe they fit best to where the rest of the IIO-core stuff is.

If we want really play the namespace game, then the existing IIO stuff 
should be put in a IIO_CORE-namespace instead of creating more new small 
ones. I am afraid that adding all existing IIO core to a IIO_CORE 
namespace and converting all existing users to use the IIO_CORE is not a 
reasonable request for a person trying to:

1. Write a driver
2. Add a small helper to aid others (instead of just melding it all in 
the given new driver - which does not benefit anyone else and just leads 
to code duplication in the long run...)

>>>>>> (Sometimes I have a feeling that the trend today is to try make things
>>>>>> intentionally difficult in the name of the safety. Like, "more difficult I
>>>>>> make this, more experience points I gain in the name of the safety".)
>>>>>>
>>>>>> Well, I suppose I could add a namespace for these functions - if this
>>>>>> approach stays - but I'd really prefer having all IIO core stuff in some
>>>>>> global IIO namespace and not to have dozens of fine-grained namespaces for
>>>>>> an IIO driver to use...
> 
> ...
> 
>>>> foo &= (~bar);
>>>>
>>>> is _much_ faster than seeing:
>>>
>>> Strongly disagree. One need to parse an additional pair of parentheses,
>>> and especially when it's a big statement inside with nested ones along
>>> with understanding what the heck is going on that you need them in the
>>> first place.
>>>
>>> On top of that, we have a common practices in the LK project and
>>> with our history of communication it seems you are trying to do differently
>>> from time to time. Sounds like a rebellion to me :-)
>>
>> I only rebel when I (in my opinion) have a solid reason :)
>>
>>>> foo &= ~bar;
>>>>
>>>> and having to google the priorities.
>>>
>>> Again, this is something a (regular) kernel developer keeps refreshed.
>>> Or even wider, C-language developer.
>>
>> Ha. As I mentioned, I've been writing C on a daily bases for almost 25
>> years. I wonder if you intent to say I am not a kernel/C-language developer?
>> Bold claim.
> 
> I'm just surprised by seeing that style from a 25y experienced C developer,
> that's all.

I am not. If something, these 25 years have taught me to understand that 
even if something is simple and obvious to me, it may not be simple and 
obvious to someone else. Similarly, something obvious to someone else, 
is not obvious to me. Hence, I am very careful when telling people that:

 >>> Again, this is something a (regular) kernel developer keeps refreshed.
 >>> Or even wider, C-language developer.

I may however say that "this is something _I_ keep refreshed (as a 
kernel/C-developer)".

As an example,

 >>>> foo &= (~bar);

This is something _I_ find very clear and exact, with zero doubt if 
negation is applied before &=. For _me_ the parenthesis there _help_, 
and for _me_ the parenthesis cause no confusion when reading the code.

I won't go and tell that I'd expect any C or kernel developer to be able 
to fluently parse "foo &= (~bar)". (Whether I think they should is 
another matter).

Oh well, let's wait and see what Jonathan thinks of these helpers in 
general. We can continue the parenthesis discussion when we know whether 
the code is going to stay.

Yours,
	-- Matti


