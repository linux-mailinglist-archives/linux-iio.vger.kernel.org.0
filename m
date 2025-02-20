Return-Path: <linux-iio+bounces-15854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5A1A3DB7F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C5637AA73E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8231F91E3;
	Thu, 20 Feb 2025 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaINY0PU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912701F8670;
	Thu, 20 Feb 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058838; cv=none; b=fx7BXhKJZ92X8wHZ3jbJ+iZgILRTV6MhNQCY6ktH6MV8xTQlos5tY8z1ca26rgFqQnnJZwHTIRgmEEj+j+sRi1M7WnZMivm25BW7QqRx14Ha7ofd15x6Gp+aA+a0q0fAAkbuXdZKq61DbXuE+sYeajJ4ng/wkL2SnFaKZWy3DDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058838; c=relaxed/simple;
	bh=VL1afRwVzotUlXLnDiyMHBOqDCnsj5I2aXklOFQIuzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fj5NxghOYU7wiCByDhsOAcajH4ts8/7FWntHFtyitYUeHffDzfwudIUVe72w+FDbuFW521q1e7HnLtfloD65qbyFaP17//TLmt+vZ7hYI91OGAkpCY/th6sfR8ukE2aUQ+DrMSukuvZiH4rAqYGc6LuWP74ANLm+cvcMk//3css=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaINY0PU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3061513d353so9420581fa.2;
        Thu, 20 Feb 2025 05:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740058835; x=1740663635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/3hluGD2/Epc1oOjzN+omEQoU/Qff+JZacIZJPu2mI=;
        b=eaINY0PU6dk3dmxzuZ7QAzxSZ8/9WZcONg7VXKcoiKj0xhiuCUBqqPzPpR93S7Gsfx
         unOcOY9YgyTPK/UiKi/ZWX98VQb6mxXxBV3Q0M+j4xs+392GSsJ0exCi3+lhTniY1DDS
         qxBGahxxSu1PcBYGUiTyr4DthHJe4hWSr1Wrh2DgHZQd7CCY6KnAiYCmgThisdyWms2H
         oDltPonFI7saVRaQlY3qrtoDpHENtLR0KzQbSauwMYuxkXjW9hqRmUfR61y0EMyVpUxe
         oaPhNsfZLnecKXeWsX7Cqspcftlx/Rxb7TDkB9EZHYyqRqFrtcxjB8H97ama1UbKKGB6
         6bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058835; x=1740663635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/3hluGD2/Epc1oOjzN+omEQoU/Qff+JZacIZJPu2mI=;
        b=oLDnzLcso2DuPZ15Aa04gdKEhU2sTnEwzTVTBYYpMydNAvM43ei06iHUfqVukLfVGd
         6co1CGZooddgb3N4K5gt7db2y45QeRhjP3kyVFlgo+f218gCg2679z6tUmDL6Ab1IhRp
         sLmlxtpHLelNZMAx86XWg72oQZ+XxCq1GOgEU+IYJHJX8e3IMN4quskYbBMvpCwpmvc5
         Zf1KtkDfuzrd8JE1FtCyyExMC5Mi4Za9Kpw4AIjiZZXAt6/Tb8TOn2fqeRpfBmXUn0Op
         kO7Ax1ujXrsF+3H19thJLMfe2QOGBqMURv1ECPsJJFXxO28H2flga1Pd7b5mEN0+0t6J
         yP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmhRpBI3XkOJKtuz4cgpBRkXekF10JsWIvyPJXE3/BWpI/+E7AbXfSOw1TietVhPaDjrdDDmK6oHV3fg5E@vger.kernel.org, AJvYcCWLSDxonpyNoOBVpO3P7oAZL/64HLjDp/VgLzP/e3Dr3MX80WJIk50dKazwn0VuW6wOlpeAuPved77BmDN/kPzmwCE=@vger.kernel.org, AJvYcCWMfaqeiy5gzTQ26ACng9e3hnRRQeECiYXHItCJkr1CpzB/2a/z1V9TlKs1umxv4gGVJ9j97yBJDzwP@vger.kernel.org, AJvYcCWgbqqUAsqE//1HSmN3yYXG2PFNZsppC617EQZZoJWrc+Qfswd13UwIcjcWfoQgcdWay9/PtbiEiB4I@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1BgwFcdUZCHoTe6K4yMoGJoJGVnbFZlduCS9IgIxXu/Kkk7r
	mfIo7S9eOTV9qQQdMOK6u9LdsAhtnKJTJWKngqcW//02uUDwz2cK
X-Gm-Gg: ASbGnctsif/5BvrnEkMoiW5E7pb8xdN15k4gzhk7rZD+VriK8cdg8IWl2mPqX6dHTHH
	JxEabgqfaX95Nk5qUVvkhVNJwJiKzVxGr7v6Io/Q4quBuMmGB3VT5gc5R7l9XgApMf1XXCenql3
	CfDqggqhPTrQKZtnNOm2swqYG9tSTz9VfhmNyabUobvTAlZpHdTBBvTV1wM33U44cYQ3hEiKHoi
	49nTyBlMJ5zZie45b/P1Ze8zYG6OyMQwjCjXagZIWoLWSkBLIWTa9b5RDfX//fWIADdO3aePvDa
	oC9E5Mqv11vhezTfeFBoGZZw3Bn8VgSsOTk1dGLuaGKIzX5Efze70P6HLChVJfZFi2ipNJpn
X-Google-Smtp-Source: AGHT+IE9fOsEW40k2P/ApWNjhsvBUHeB5RBB1//MbXn1MZVFPTFngeWOwjgnKakJ6UoD6YMMUW/W8w==
X-Received: by 2002:a05:6512:31d2:b0:545:296e:ac28 with SMTP id 2adb3069b0e04-5452fe4232emr8815090e87.24.1740058834180;
        Thu, 20 Feb 2025 05:40:34 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462fd36f53sm480013e87.185.2025.02.20.05.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:40:32 -0800 (PST)
Message-ID: <ec76334b-bb13-4076-811d-9174170dd677@gmail.com>
Date: Thu, 20 Feb 2025 15:40:30 +0200
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
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z7ci7tUlRQqZEZSN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2025 14:41, Andy Shevchenko wrote:
> On Thu, Feb 20, 2025 at 09:13:00AM +0200, Matti Vaittinen wrote:
>> On 19/02/2025 22:41, Andy Shevchenko wrote:
>>> On Wed, Feb 19, 2025 at 02:30:27PM +0200, Matti Vaittinen wrote:
> 
> ...
> 
>>>> obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
>>>>    obj-$(CONFIG_GEHC_PMC_ADC) += gehc-pmc-adc.o
>>>>    obj-$(CONFIG_HI8435) += hi8435.o
>>>>    obj-$(CONFIG_HX711) += hx711.o
>>>
>>>> +obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
>>>
>>> Shouldn't this be grouped with other IIO core related objects?
>>
>> I was unsure where to put this. The 'adc' subfolder contained no other IIO
>> core files, so there really was no group. I did consider putting it on top
>> of the file but then just decided to go with the alphabetical order. Not
>> sure what is the right way though.
> 
> I think it would be nice to have it grouped even if this one becomes
> the first one.

I will move this on top of the file. (If these helpers stay. I think I 
wrote somewhere - maybe in the cover letter - that people are not sure 
if this is worth or if every driver should just use the fwnode APIs. 
Reviewers may want to save energy and do more accurate review only to 
the next version...)

>>>>    obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
>>>>    obj-$(CONFIG_IMX8QXP_ADC) += imx8qxp-adc.o
>>>>    obj-$(CONFIG_IMX93_ADC) += imx93_adc.o
> 
> ...
> 
>>>> +EXPORT_SYMBOL_GPL(iio_adc_device_num_channels);
>>>
>>> No namespace?
>>
>> I was considering also this. The IIO core functions don't belong into a
>> namespace - so I followed the convention to keep these similar to other IIO
>> core stuff.
> 
> But it's historically. We have already started using namespaces
> in the parts of IIO, haven't we?

Yes. But as I wrote, I don't think adding new namespaces for every 
helper file with a function or two exported will scale. We either need 
something common for IIO (or IIO "subsystems" like "adc", "accel", 
"light", ... ), or then we just keep these small helpers same as most of 
the IIO core.

>> (Sometimes I have a feeling that the trend today is to try make things
>> intentionally difficult in the name of the safety. Like, "more difficult I
>> make this, more experience points I gain in the name of the safety".)
>>
>> Well, I suppose I could add a namespace for these functions - if this
>> approach stays - but I'd really prefer having all IIO core stuff in some
>> global IIO namespace and not to have dozens of fine-grained namespaces for
>> an IIO driver to use...
> 
> ...
> 
>>>> +	if (!allowed_types || allowed_types & (~IIO_ADC_CHAN_PROP_TYPE_ALL)) {
>>>
>>> Unneeded parentheses around negated value.
>>>
>>>> +	if (found_types & (~allowed_types)) {
>>>
>>> Ditto.
>>>
>>>> +		long unknown_types = found_types & (~allowed_types);
>>>
>>> Ditto and so on...
>>>
>>> Where did you get this style from? I think I see it first time in your
>>> contributions. Is it a new preferences? Why?
>>
>> Last autumn I found out my house was damaged by water. I had to empty half
>> of the rooms and finally move out for 2.5 months.
> 
> Sad to hear that... Hope that your house had been recovered (to some extent?).

Thanks. I finalized rebuilding last weekend. Just moved back and now I'm 
trying to carry things back to right places... :rolleyes:

>> Now I'm finally back, but
>> during the moves I lost my printed list of operator precedences which I used
>> to have on my desk. I've been writing C for 25 years or so, and I still
>> don't remember the precedence rules for all bitwise operations - and I am
>> fairly convinced I am not the only one.
> 
> ~ (a.k.a. negation) is higher priority in bitops and it's idiomatic
> (at least in LK project).

I know there are well established, accurate rules. Problem is that I 
never remember these without looking.

>> What I understood is that I don't really have to have a printed list at
>> home, or go googling when away from home. I can just make it very, very
>> obvious :) Helps me a lot.
> 
> Makes code harder to read, especially in the undoubtful cases like
> 
> 	foo &= (~...);

This is not undoubtful case for me :) And believe me, reading and 
deciphering the

foo &= (~bar);

is _much_ faster than seeing:

foo &= ~bar;

and having to google the priorities.

>>>> +		int type;
>>>> +
>>>> +		for_each_set_bit(type, &unknown_types,
>>>> +				 IIO_ADC_CHAN_NUM_PROP_TYPES - 1) {
>>>> +			dev_err(dev, "Unsupported channel property %s\n",
>>>> +				iio_adc_type2prop(type));
>>>> +		}
>>>> +
>>>> +		return -EINVAL;
>>>> +	}
> 
> ...
> 
>>>> +		tmp.required &= (~BIT(IIO_ADC_CHAN_PROP_COMMON));
>>>
>>> Redundant outer parentheses. What's the point, please?
>>
>> Zero need to think of precedence.
> 
> Huh? See above.
> Everything with equal sign is less precedence than normal ops.

Sure. It's obvious if you remember that "Everything with equal sign is 
less precedence than normal ops". But as I said, I truly have hard time 
remembering these rules. When I try "going by memory" I end up having 
odd errors and suggestions to add parenthesis from the compiler...

By the way, do you know why anyone has bothered to add these 
warnings/suggestions about adding the parenthesis to the compiler? My 
guess is that I am not only one who needs the precedence charts ;)

> ...
> 
>>>> +		ret = fwnode_property_read_u32(child, "common-mode-channel",
>>>> +					       &common);
>>>
>>> I believe this is okay to have on a single line,
>>
>> I try to keep things under 80 chars. It really truly helps me as I'd like to
>> have 3 parallel terminals open when writing code. Furthermore, I hate to
>> admit it but during the last two years my near vision has deteriorated... :/
>> 40 is getting more distant and 50 is approaching ;)
> 
> It's only 86 altogether with better readability.
> We are in the second quarter of 21st century,
> the 80 should be left in 80s...
> 
> (and yes, I deliberately put the above too short).

I didn't even notice you had squeezed the lines :)

But yeah, I truly have problems fitting even 3 80 column terminals on 
screen with my current monitor. And when working on laptop screen it 
becomes impossible. Hence I strongly prefer keeping the 80 chars limit.

> ...
> 
>>>> +#include <linux/iio/iio.h>
>>>
>>> I'm failing to see how this is being used in this header.
>>
>> I suppose it was the struct iio_chan_spec. Yep, forward declaration could
>> do, but I guess there would be no benefit because anyone using this header
>> is more than likely to use the iio.h as well.
> 
> Still, it will be a beast to motivate people not thinking about what they are
> doing. I strongly prefer avoiding the use of the "proxy" or dangling headers.

Ehh. There will be no IIO user who does not include the iio.h. And, I 
need the iio_chan_spec here.

> ...
> 
>>>> +/*
>>>> + * Channel property types to be used with iio_adc_device_get_channels,
>>>> + * devm_iio_adc_device_alloc_chaninfo, ...
>>>
>>> Looks like unfinished sentence...
>>
>> Intention was to just give user an example of functions where this gets
>> used, and leave room for more functions to be added. Reason is that lists
>> like this tend to end up being incomplete anyways. Hence the ...
> 
> At least you may add ').' (without quotes) to that to make it clear.

Thanks. I agree, that's a good idea.

And as I said, I suggest saving some of the energy for reviewing the 
next version. I doubt the "property type" -flags and bitwise operations 
stay, and it may be all of this will be just meld in the bd79124 code - 
depending on what Jonathan & others think of it.

Yours,
	-- Matti


