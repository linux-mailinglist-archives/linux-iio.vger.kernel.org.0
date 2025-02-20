Return-Path: <linux-iio+bounces-15872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F32A3DCAD
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7943A9014
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADAF1FBC98;
	Thu, 20 Feb 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5wJgBhw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1FE1FAC25;
	Thu, 20 Feb 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061306; cv=none; b=AyqfLkS0x40C4AQnYg5+pm8euO9FqLGHgQnhoiz8zow+NGpu3C/zZ2a10je17B0ibDZrQMNC/+onGErkcYoyxWjUSq27t/qYR/uXJUEryWIZchkZvWcgQDgRB8RD8NCboDY2Ci94pSim8MowHFH7AG0d0MGKtVDnrpc/Js10KtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061306; c=relaxed/simple;
	bh=PpVzdWc+hNukxIACDuAxZaeAROL3OgZe4+gSpyqxYFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uuNngiy6+sXeuugJjoZWg6R0KhQ8JgodngFsdg4BcyIxhKlxyA8WOGrZbG+JuT7QELxhmrY/r1fljzCZbArfk+frjs53hljsf3Uy9binm/a/Y6Ix+0r+6xWzVR5VK9DUfNyEDGvdGbbKng9X1h6+1LOr0fsMjd5YS5PW0uRJe40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5wJgBhw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54605bfcc72so2406007e87.0;
        Thu, 20 Feb 2025 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740061303; x=1740666103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mzmoiLCG8SAcHQOd7ewiQtwf2LHT2fH6DKF15WTZxJc=;
        b=Z5wJgBhwdD+TzhkVluXL7JlBWzuZwO5hy+wlp4lfqzdQ2avgIN6DrE0hMGKV/te5LP
         jLJNjq9/if86cG3RkvW1O8hFTr8lenVBnn7Vo5W0jWYzeJ51GvXGifkPAE4HgFbN6vT8
         qKJBu9aATDiNBpfNfkokHFOdebQ2rGsg+P3kALz33b401buJsRa5Z5YQtc+PII7YRG2v
         vsFPLILY+0zRNG3OA4WdcZtSWEjS2d4oDuIw+h4dz3i7gppzRDn9lblK3gj91XMJTi4Q
         w/z9dbFZdOnTe8u9xrwmU0Yo7b2jQ/R9bWqBE4fwENtX9OluKjuifbrRjIiK+PkTcg2O
         CPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061303; x=1740666103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzmoiLCG8SAcHQOd7ewiQtwf2LHT2fH6DKF15WTZxJc=;
        b=Gi07b2nSjf1PRgkpo4rO8vQWHhEmIcFfSbAFzSEBP5v+hZTHGurlEu61JJVv3i+Fmq
         NzXehb1Y1ST5SKBg6xU6rSWlTUVTreQay3KAc1azvm1R8JyDd0rMzJ6ker+sm1OAN49S
         SHqrOfh+11Y+wMHjH2u6N5PlHc+i9F2toQTRtinjJ1wEOx2Ioj+L2ADAaoCIFgbR/xIB
         A9p5O7nb+Q3Hee0ADAlplZh82wTDZ9vwiPFPu4cvFTGCgG1uZNWfkL5BnGtyCw0v+flS
         bG92Q+IeiH5q1XVkuw2PRN5UfDqq0p7bmXZVY85hNE157Dap+/U/5vJw8NuF/QMT3F5V
         QO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkLl4J8AGgTxr1KPBR0n9YfM4I77KZMqhEMdkB8WLx3HBFYfdwJDKfoNQBXwqUn1mSRAo/HC1O73BHbLmE@vger.kernel.org, AJvYcCVbn2Awi6+nZpXKcR6srsANstXGdP9LFq17RHK4f8fQzq82O8bJCAlElBRP7qAZXIGXlsqQYBAORcWH@vger.kernel.org, AJvYcCXZJNpKNhwYpZrjavHpki4lebiKzViIvd17/7eLD5sAdXleFKnReQpFWSQs0wHl99shA1fw6Ru/KjPqAAEybEaxaFE=@vger.kernel.org, AJvYcCXjkkCOigGd0frIaKpqm6094F98UbjnOV5RmuDZ9FoMxe4lUjeh61XCmlBBEVOXgdQal7h8gFAXQJ3P@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfze3p3EbfIApoi+J/166a1ICAcjMB2dwWaSPIpXtHL/yKjCN1
	snIeIOyD00016rNW0DHehjpDDQ3JqDyF7cGWmoSfhETqHeZZh/F8
X-Gm-Gg: ASbGncvZjRn3kOVNyhKfqcAbHHC0im4e76iZyWGA28YIi2OOTK11i2wIFKlZZljUK2t
	H7Auj5tSoU7WJR53MWAsMZQPy0ERy3zEcQzvMXQcnHfJS6JibwXC37RQxs8QgM/j3KAiil7yJOs
	3RRrvhc3GXru8u+DkRiMqezpzhZls+auw00HZFIsCIThVr1UByz/B8ufxb1q0H79Usu9FY+bx0H
	NseScM7SnspWkwXTEucuIOHktkZf3biYrkKeSnCO5eH3Fn2bMr7dDQQjl3/PRzQimEp1EgyEEVT
	5Ed28vlGwDxPiVi1QnKC6IkmicOLHHn6QYz5y3U1k1fyi24UPjhU7ks2i6BXQd0tIbOjOiKt
X-Google-Smtp-Source: AGHT+IEnorexehar0T56dUSxxROrZLAf2XndxCCWnC99AsuPb3902B0+uwY/QTJ7hoY8ePb04Bn4Lg==
X-Received: by 2002:a05:6512:4010:b0:545:16a8:6a5d with SMTP id 2adb3069b0e04-546e3c9c9e0mr1209013e87.2.1740061302295;
        Thu, 20 Feb 2025 06:21:42 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452fcf6487sm1893226e87.137.2025.02.20.06.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:21:40 -0800 (PST)
Message-ID: <9018e23c-da28-41b0-b774-1598b946a2a1@gmail.com>
Date: Thu, 20 Feb 2025 16:21:37 +0200
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
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z7c2cBQpjoc9-Vyu@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2025 16:04, Andy Shevchenko wrote:
> On Thu, Feb 20, 2025 at 03:40:30PM +0200, Matti Vaittinen wrote:
>> On 20/02/2025 14:41, Andy Shevchenko wrote:
>>> On Thu, Feb 20, 2025 at 09:13:00AM +0200, Matti Vaittinen wrote:
>>>> On 19/02/2025 22:41, Andy Shevchenko wrote:
>>>>> On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>>>> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
>>>>>
>>>>> No namespace?
>>>>
>>>> I was considering also this. The IIO core functions don't belong into a
>>>> namespace - so I followed the convention to keep these similar to other IIO
>>>> core stuff.
>>>
>>> But it's historically. We have already started using namespaces
>>> in the parts of IIO, haven't we?
>>
>> Yes. But as I wrote, I don't think adding new namespaces for every helper
>> file with a function or two exported will scale. We either need something
>> common for IIO (or IIO "subsystems" like "adc", "accel", "light", ... ), or
>> then we just keep these small helpers same as most of the IIO core.
> 
> It can be still pushed to IIO_CORE namespace. Do you see an issue with that?

No. I've missed the fact we have IIO_CORE O_o. Thanks for pointing it out!

> Or a new opaque namespace for the mentioned cases, something like IIO_HELPERS.

I am unsure if it really benefits to split this out of the IIO_CORE. 
I've a feeling it falls into the category of making things harder for 
user with no apparent reason. But yes, the IIO_CORE makes sense.

>>>> (Sometimes I have a feeling that the trend today is to try make things
>>>> intentionally difficult in the name of the safety. Like, "more difficult I
>>>> make this, more experience points I gain in the name of the safety".)
>>>>
>>>> Well, I suppose I could add a namespace for these functions - if this
>>>> approach stays - but I'd really prefer having all IIO core stuff in some
>>>> global IIO namespace and not to have dozens of fine-grained namespaces for
>>>> an IIO driver to use...
> 
> ...
> 
>>>>>> +	if (!allowed_types || allowed_types & (~IIO_ADC_CHAN_PROP_TYPE_ALL)) {
>>>>>
>>>>> Unneeded parentheses around negated value.
>>>>>
>>>>>> +	if (found_types & (~allowed_types)) {
>>>>>
>>>>> Ditto.
>>>>>
>>>>>> +		long unknown_types = found_types & (~allowed_types);
>>>>>
>>>>> Ditto and so on...
>>>>>

...

>>>> during the moves I lost my printed list of operator precedences which I used
>>>> to have on my desk. I've been writing C for 25 years or so, and I still
>>>> don't remember the precedence rules for all bitwise operations - and I am
>>>> fairly convinced I am not the only one.
>>>
>>> ~ (a.k.a. negation) is higher priority in bitops and it's idiomatic
>>> (at least in LK project).
>>
>> I know there are well established, accurate rules. Problem is that I never
>> remember these without looking.
> 
> There are very obvious cases like below.

I think we just disagree on if this is obvious.

>>>> What I understood is that I don't really have to have a printed list at
>>>> home, or go googling when away from home. I can just make it very, very
>>>> obvious :) Helps me a lot.
>>>
>>> Makes code harder to read, especially in the undoubtful cases like
>>>
>>> 	foo &= (~...);
>>
>> This is not undoubtful case for me :) And believe me, reading and
>> deciphering the
>>
>> foo &= (~bar);
>>
>> is _much_ faster than seeing:
> 
> Strongly disagree. One need to parse an additional pair of parentheses,
> and especially when it's a big statement inside with nested ones along
> with understanding what the heck is going on that you need them in the
> first place.
> 
> On top of that, we have a common practices in the LK project and
> with our history of communication it seems you are trying to do differently
> from time to time. Sounds like a rebellion to me :-)

I only rebel when I (in my opinion) have a solid reason :)

>> foo &= ~bar;
>>
>> and having to google the priorities.
> 
> Again, this is something a (regular) kernel developer keeps refreshed.
> Or even wider, C-language developer.

Ha. As I mentioned, I've been writing C on a daily bases for almost 25 
years. I wonder if you intent to say I am not a kernel/C-language 
developer? Bold claim.

>>>>>> +		int type;
>>>>>> +
>>>>>> +		for_each_set_bit(type, &unknown_types,
>>>>>> +				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
>>>>>> +			dev_err(dev, "Unsupported channel property %s\n",
>>>>>> +				iio_adc_type2prop(type));
>>>>>> +		}
>>>>>> +
>>>>>> +		return -EINVAL;
>>>>>> +	}
> 
> ...
> 
>>>>>> +		tmp.required &= (~BIT(IIO_ADC_CHAN_PROP_COMMON));
>>>>>
>>>>> Redundant outer parentheses. What's the point, please?
>>>>
>>>> Zero need to think of precedence.
>>>
>>> Huh? See above.
>>> Everything with equal sign is less precedence than normal ops.
>>
>> Sure. It's obvious if you remember that "Everything with equal sign is less
>> precedence than normal ops". But as I said, I truly have hard time
>> remembering these rules. When I try "going by memory" I end up having odd
>> errors and suggestions to add parenthesis from the compiler...
> 
> The hardest to remember probably the
> 
> 	foo && bar | baz
> 
> case and alike. These are the only ones that I totally agree on with you.
> But negation.
> 
>> By the way, do you know why anyone has bothered to add these
>> warnings/suggestions about adding the parenthesis to the compiler? My guess
>> is that I am not only one who needs the precedence charts ;)
> 
> Maybe someone programmed too much in LISP?.. (it's a rhetorical one)
> 
> ...
> 
>>>>>> +		ret = fwnode_property_read_u32(child, "common-mode-channel",
>>>>>> +					       &common);
>>>>>
>>>>> I believe this is okay to have on a single line,
>>>>
>>>> I try to keep things under 80 chars. It really truly helps me as I'd like to
>>>> have 3 parallel terminals open when writing code. Furthermore, I hate to
>>>> admit it but during the last two years my near vision has deteriorated... :/
>>>> 40 is getting more distant and 50 is approaching ;)
>>>
>>> It's only 86 altogether with better readability.
>>> We are in the second quarter of 21st century,
>>> the 80 should be left in 80s...
>>>
>>> (and yes, I deliberately put the above too short).
>>
>> I didn't even notice you had squeezed the lines :)
>>
>> But yeah, I truly have problems fitting even 3 80 column terminals on screen
>> with my current monitor. And when working on laptop screen it becomes
>> impossible. Hence I strongly prefer keeping the 80 chars limit.
> 
> Maybe you need a bigger monitor after all? (lurking now :-)

Wouldn't fit my table :)

> ...
> 
>>>>>> +#include <linux/iio/iio.h>
>>>>>
>>>>> I'm failing to see how this is being used in this header.
>>>>
>>>> I suppose it was the struct iio_chan_spec. Yep, forward declaration could
>>>> do, but I guess there would be no benefit because anyone using this header
>>>> is more than likely to use the iio.h as well.
>>>
>>> Still, it will be a beast to motivate people not thinking about what they are
>>> doing. I strongly prefer avoiding the use of the "proxy" or dangling headers.
>>
>> Ehh. There will be no IIO user who does not include the iio.h.
> 
> It's not your concern. That's the idea of making C units as much independent
> and modular as possible (with common sense in mind). And in this case I see
> no point of including this header. Again, the main problem is this will call
> people to use the new header as a "proxy" and that's what I fully against to.
> 
>> And, I need the iio_chan_spec here.
> 
> Do you really need it or is it just a pointer?

Just a pointer. Forward declaration could do it. Hmm. I didn't think of 
people using this header as a proxy. I guess you have a point here :)

> 
> ...
> 
>> And as I said, I suggest saving some of the energy for reviewing the next
>> version. I doubt the "property type" -flags and bitwise operations stay, and
>> it may be all of this will be just meld in the bd79124 code - depending on
>> what Jonathan & others think of it.
> 
> Whenever this code will be trying to land, the review comments still apply.

Sure! But chances are plenty of this code gets erased :) I just wanted 
to warn you that some of the effort on this version is likely to get 
wasted. I did consider reverting this back to a RFC - but going back'n 
forth with the RFC status felt odd...

Yours,
	-- Matti


