Return-Path: <linux-iio+bounces-277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1D7F5929
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 08:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA44B20E1B
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 07:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0BF168D3;
	Thu, 23 Nov 2023 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEKUaux+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80285D54;
	Wed, 22 Nov 2023 23:24:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aab20e828so758742e87.2;
        Wed, 22 Nov 2023 23:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700724286; x=1701329086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxJ4WlLZ2ta0R9NSG1PI04mGrtOQnJCeqbRup8BIqRw=;
        b=mEKUaux+jnlXF+rkvf/QzmRiM6gv3xdfsPXFZua50gGEfJofFLC2Zw4B907iEbo/Dz
         o3hI/p5Z0+Uoidtj9B9AMrFZI+etmzoKZ8CFH+xz6R9sWI05PEQwmkMaLY7S8NsIAvoS
         whkpky8laBWOO7LvjhpgYqxlp6Y3tgtiRSlJrCM9XutekkbjcawkFxIumDbB4IoeLfAF
         z9ih+CoNlpGTzVs55ozcc06WcBPRIleef07lzsFyz6JSDiWPXsEcW6LfZac6WDNxFnpy
         S81NUypQzsE5EVGWQ8b4znAlZMC+fZXAFVT9vZ394LR+atvPkzlJxhJmcQvtaxVzwiOx
         hdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700724286; x=1701329086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxJ4WlLZ2ta0R9NSG1PI04mGrtOQnJCeqbRup8BIqRw=;
        b=dV00sV8/pg58jBGBTbrxYL6PIZXAyiJZ893vnBtjlJfTKpnqDWFyZB8mD5RrGs5eVL
         ydllClkd07IZDL8UVDBQDEBIvn8Lalc95XEcG2NYlp8BpZRnlqHSppmjsdIS49VM7g0R
         1Fh6YfpHNSm4HE2zUjUHM00Ra69baQ+PK22VYTqmDD7ruZUJiG35KtYv9mo+ynR5s0Ic
         b72qhoZNlxz7zn8YWsGMIkANId29uzR1gF6kW3yn8LfXeEf/x9wrYLk5H+sDpPsugT8G
         0h/JJt/qEiuzZCXTqeCEwPhgrR9dzc2Kvsv5xC96nTotJwvp+ywRFaMwsCE1evoXP7Z7
         HAcA==
X-Gm-Message-State: AOJu0YyMsioWDZ2Wuh+FcnuuH3RcqOKcJ7Uc2ZwHKJYcdVxi+hjBEAAa
	CtayCLu6deTpO9ey6BfF8dA=
X-Google-Smtp-Source: AGHT+IGmyZe4zZnn+yLWO1aAyaJTJF333uGOoZQy9d2C9yQ+/bqPiHHOQxx69QgchVZYWGlPPj303A==
X-Received: by 2002:a19:ca04:0:b0:504:2d54:b4d0 with SMTP id a4-20020a19ca04000000b005042d54b4d0mr3065625lfg.19.1700724285464;
        Wed, 22 Nov 2023 23:24:45 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id v19-20020a197413000000b0050574829e48sm107263lfe.298.2023.11.22.23.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 23:24:45 -0800 (PST)
Message-ID: <4a39aff2-bb1a-447c-8c33-8bfad06777e3@gmail.com>
Date: Thu, 23 Nov 2023 09:24:42 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US, en-GB
To: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231121031043.327614-1-marex@denx.de>
 <20231121031043.327614-2-marex@denx.de>
 <8b865546-0e51-45ff-ab76-8189afaa9ad5@gmail.com>
 <cd21c72f-d9ff-471d-a08d-9b67bf180950@denx.de>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cd21c72f-d9ff-471d-a08d-9b67bf180950@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/23/23 02:26, Marek Vasut wrote:
> On 11/22/23 13:17, Matti Vaittinen wrote:
>> On 11/21/23 05:10, Marek Vasut wrote:
>>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>>> other fancy functionality.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---

...

>>
>> I like this table-based look-up for write (and read) of scales. 
>> Looking at this I see an analogy to some of the regulator stuff, like 
>> for example the ramp-up values. What I do very much like in the 
>> regulator subsystem is the drivers/regulator/helpers.c
>>
>> I wonder if similar approach would be usable in IIO as well? I mean, 
>> providing readily written iio_regmap_read/write_raw_<functionality>() 
>> and iio_available_*() helpers for the simple devices where we just 
>> have value-register mapping? I mean, driver would just populate 
>> something like:
>>
>> struct iio_scale_desc {
>>      int *scale_val_table;
>>      int *scale_val2_table;
>>      int num_scales;
> 
> You'd also need type here (fractional, int+micro, ...), right ?

Well, my thinking was to go with baby-steps. Eg, start by supporting 
just int+micro - but yes. As I wrote below, this can be expanded by 
allowing specifying the type.

>>      int scale_reg_addr;
>>      int scale_reg_mask;
>> };
>>
>> and call helper like
>> int iio_regmap_read_raw_scale(struct iio_dev *idev,
>>                    struct iio_scale_desc *sd, int *val,
>>                    int *val2)"
>> provided by IIO framework.
>>
>> Similar helper for writing new scales and getting available scales.
>>
>> Later this could be expanded by allowing specifying the type of 
>> provided values (in the example case, IIO_VAL_INT_PLUS_x - but maybe 
>> this would be extensible (and worth) to support also the other options?)
>>
>> I know it's a bit much to be done in the context of this series. Hence 
>> I am definitely not insisting this to be done here! OTOH, the embedded 
>> Linux is not in EU next year so maybe Marek would forgive me before we 
>> meet next time :pondering:
> 
> toffee-- forgive++ , hehehe , no worries.

At least I know what I need to pack in the suitcase! ;) Oh, by the way, 
the wafers were great!

>> Anyways - does this sound like a sensible thing to do? I guess it 
>> could help simplifying some drivers a little.
> 
> The only thing I would wonder about is, should such a thing go into 
> regmap so it can be reused cross-subsystem instead of making this iio 
> specific ?

I definitely think a relation "register value" <=> "item from a table" 
is very much used also outside the IIO. So yes, a generic regmap helper 
for doing write as a "look value from table and write corresponding 
value to a register" and "read value from register and return me a 
corresponding item from a table" would be very usable.

There is a tradeoff when doing a generic one instead of making it 
targeted for IIO use. Supporting different types of data is likely to 
make the code a bit hairy. Also, the IIO way of having these IIO_VAL_* 
flags does probably require IIO - specific wrappers in any case.

>> Oh. Only after writing of this I noticed the range is written in HW 
>> only together with the 'start' command. I guess this is how the IC 
>> operates - 
> 
> The IC is just simple, a few bits in command register to control it and 
> nothing fancy, so it is just easier to write the 8 bits at a time 
> instead of doing RMW .
> 
>> you need to write all configs together with starting the measurement? 
>> Or is that just an optimization to avoid extra writes? If it's the 
>> first, then a suggested iio_regmap_*() -helper wouldn't work here. I 
>> might've added a comment explaining why range is written in 
>> isl76682_get() and not here to the isl76682_get().
> 
> It is just easier and cheaper to write it all at once instead of RMW .
> It also isn't like RMW would win anything here, rather the opposite.

Yep. Kind of makes sense. It's just me who is already used to see the 
regmap writes straight in the scale setting function - and RMW provided 
by regmap is really pretty simple when regmap lock is used. But this is 
very much Ok for me just like you wrote it.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


