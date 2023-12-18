Return-Path: <linux-iio+bounces-1051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB88169F3
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5171F221BC
	for <lists+linux-iio@lfdr.de>; Mon, 18 Dec 2023 09:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1812B61;
	Mon, 18 Dec 2023 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFZw9C+y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA22125C8;
	Mon, 18 Dec 2023 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e23a4df33so2421471e87.2;
        Mon, 18 Dec 2023 01:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702892191; x=1703496991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YIvodjJ/uqcZK67kNnFAU9qFMXVMgAPp9QJLFWVolA=;
        b=TFZw9C+y2qSh1V7OF0Df4heF3yx2ECk8rNnJLV3cuue9jgfsyUHKvcvoja14cM475R
         w2fKO+L5NkYXuxJbDyGskeaWzOVSX/Q+vXtgvCuQrhwPJ4iku9GC3Xcp9uxfg/MI+x+t
         u+ZG5fy8omZ/YBBiaINbv413LhvQJ7QhYdfLCakFJAY5UMHyAV99LiVuO0FvBtP8z5DP
         NPeqjePrRTN9sQxe8etGpa6TNZErikRu32midhH+gPSNKnULrbgWq1UO+iks7USn/2zp
         PuP9OyJNIOTbLuFSKCviZ7Lhevy0Beret0to2/2z21WnBJXgsl5XPQwxQtyh7jmKKXwH
         Wyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702892191; x=1703496991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0YIvodjJ/uqcZK67kNnFAU9qFMXVMgAPp9QJLFWVolA=;
        b=u264fn4DKeCzjqxgD/PwDciAgIZJxUmXvvxLGOeQ9WckmN2DgoE2w7mJwUtpEJvqmj
         iYkN+z94St1kkcxABMS7HzplltSIaWE8Cp3lvGxeoXpn6f8nnbC1OCjOp9mKVRbZE0o1
         yL/6+JhXS1yM/SVSueBK3A0bVmUQYaFLsx7FZeOKZOOpYle9HtuejAmFG3/E3St7Iyjd
         RNYcrNMd01TTd6F67NjaUMyTCdgV1GwQtqvybscsHiJqXu2tv2b15oF1o2r3rmstetSS
         xA3D0NAeEf0ytTbzL8i2bnc8Yd5fzGFNAUTBDcg5niWu3kNGOS1TojCR55oDdL0C0M/K
         MjKQ==
X-Gm-Message-State: AOJu0Yzn6AhbKUn90T9RxIzvFan1tF4GOBT1KoaGahtiVb/4joo08gfV
	o0QNgrUvBdzca1oRfDWzFww=
X-Google-Smtp-Source: AGHT+IFuiH1eQ6Y/2h4/4Sh/l4ki28JcGPuWQmiiirVZBcPHW2WlInyyyKcyt6Tvw2TipioPVTt2dA==
X-Received: by 2002:a05:6512:3086:b0:50e:1ac0:c97c with SMTP id z6-20020a056512308600b0050e1ac0c97cmr4449121lfd.66.1702892190947;
        Mon, 18 Dec 2023 01:36:30 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id g42-20020a0565123baa00b0050bfe7a602csm2866425lfv.74.2023.12.18.01.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 01:36:30 -0800 (PST)
Message-ID: <57fbc795-b3ff-4a77-8064-ad6f7e07f96b@gmail.com>
Date: Mon, 18 Dec 2023 11:36:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>,
 Andre Werner <andre.werner@systec-electronic.com>, devicetree@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>
References: <20231121031043.327614-1-marex@denx.de>
 <20231121031043.327614-2-marex@denx.de>
 <8b865546-0e51-45ff-ab76-8189afaa9ad5@gmail.com>
 <cd21c72f-d9ff-471d-a08d-9b67bf180950@denx.de>
 <4a39aff2-bb1a-447c-8c33-8bfad06777e3@gmail.com>
 <dff1e2f9-c2a1-4262-b80b-ce0c144fdaf5@gmail.com>
 <20231217130613.47bab03d@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231217130613.47bab03d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/23 15:06, Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 14:06:32 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> On 11/23/23 09:24, Matti Vaittinen wrote:
>>> On 11/23/23 02:26, Marek Vasut wrote:
>>>> On 11/22/23 13:17, Matti Vaittinen wrote:
>>>>> On 11/21/23 05:10, Marek Vasut wrote:
>>
>> ..snip
>>
>>>>> I like this table-based look-up for write (and read) of scales.
>>>>> Looking at this I see an analogy to some of the regulator stuff, like
>>>>> for example the ramp-up values. What I do very much like in the
>>>>> regulator subsystem is the drivers/regulator/helpers.c
>>>>>
>>>>> I wonder if similar approach would be usable in IIO as well? I mean,
>>>>> providing readily written iio_regmap_read/write_raw_<functionality>()
>>>>> and iio_available_*() helpers for the simple devices where we just
>>>>> have value-register mapping? I mean, driver would just populate
>>>>> something like:
>>>>>
>>>>> struct iio_scale_desc {
>>>>>       int *scale_val_table;
>>>>>       int *scale_val2_table;
>>>>>       int num_scales;
>>>>
>>>> You'd also need type here (fractional, int+micro, ...), right ?
>>>
>>> Well, my thinking was to go with baby-steps. Eg, start by supporting
>>> just int+micro - but yes. As I wrote below, this can be expanded by
>>> allowing specifying the type.
>>>    
>>>>>       int scale_reg_addr;
>>>>>       int scale_reg_mask;
>>>>> };
>>>>>
>>>>> and call helper like
>>>>> int iio_regmap_read_raw_scale(struct iio_dev *idev,
>>>>>                     struct iio_scale_desc *sd, int *val,
>>>>>                     int *val2)"
>>>>> provided by IIO framework.
>>>>>
>>>>> Similar helper for writing new scales and getting available scales.
>>>>>
>>>>> Later this could be expanded by allowing specifying the type of
>>>>> provided values (in the example case, IIO_VAL_INT_PLUS_x - but maybe
>>>>> this would be extensible (and worth) to support also the other options?)
>>>>>   
>>
>> ... snip
>>
>>>>
>>>> The only thing I would wonder about is, should such a thing go into
>>>> regmap so it can be reused cross-subsystem instead of making this iio
>>>> specific ?
>>>
>>> I definitely think a relation "register value" <=> "item from a table"
>>> is very much used also outside the IIO. So yes, a generic regmap helper
>>> for doing write as a "look value from table and write corresponding
>>> value to a register" and "read value from register and return me a
>>> corresponding item from a table" would be very usable.
>>>
>>> There is a tradeoff when doing a generic one instead of making it
>>> targeted for IIO use. Supporting different types of data is likely to
>>> make the code a bit hairy. Also, the IIO way of having these IIO_VAL_*
>>> flags does probably require IIO - specific wrappers in any case.
>>
>> I had some spare time so drafted following:
>>
>> +struct reg_val_table {
>> +       int *reg_vals;
>> +       int *vals;
>> +       int num_vals;
>> +};
>>
>> ...
>>
>> +/**
>> + * regtable_find_val - find a value matching register setting
>> + *
>> + * Search given table for value mathcing a register setting.
>> + *
>> + * @table:     Table from which the register setting - value pairs are
>> + *             searched.
>> + * @reg:       Register value for which the matching physical value is
>> + *             searched.
>> + * @val:       Pointer to location where the found value will be stored.
>> + *
>> + * returns:    0 on success, negative errno if table is invalid or match is
>> + *             not found.
>> + */
>> +int regtable_find_val(const struct reg_val_table *table, int reg, int *val)
>>
>>
>> +/**
>> + * regtable_find_reg - find a register setting matching given value.
>> + *
>> + * Search given table for a register setting matching a value.
>> + *
>> + * @table:     Table from which the register setting - value pairs are
>> + *             searched.
>> + * @val:       Value for which the matching register setting is searched.
>> + * @reg:       Pointer to location where the found register value will be
>> + *             stored.
>> + *
>> + * returns:    0 on success, negative errno if table is invalid or match is
>> + *             not found.
>> + */
>> +int regtable_find_reg(const struct reg_val_table *table, int val, int *reg)
>>
>>
>> +/**
>> + * regtable_find_greater_than_val - find the closest greater val and reg
> Maybe use rounding terminology rather than greater than?
> 
> regtable_find_val_roundup()?

Would be much better indeed. Thanks!

>> + * Search given table for the smallest value which is still greater than
>> + * the given value. Both the found value and corresponding register
>> + * setting are returned unless given pointers are NULL.
>> + *
>> + * @table:     Table from which the register setting - value pairs are
>> + *             searched.
>> + * @val_cmp:   Value to which the values stored in table are compared to.
>> + * @reg:       NULL or pointer to location where the matching register
>> + *             setting value will be stored.
>> + * @val:       NULL or pointer to location where the found value will be
>> + *             stored.
>> + *
>> + * returns:    0 on success, negative errno if table is invalid or match is
>> + *             not found.
>> + */
>> +int regtable_find_greater_than_val(const struct reg_val_table *table,
>> int val_cmp,
>> +                                  int *reg, int *val)
> 
> regtable_find_val_rounddown()?

Yes.

>> +/**
>> + * regtable_find_smaller_than_val - find the closest smaller val and reg
>> + *
>> + * Search given table for the greatest value which is still smaller than
>> + * the given value. Both the found value and corresponding register
>> + * setting are returned unless given pointers are NULL.
>> + *
>> + * @table:     Table from which the register setting - value pairs are
>> + *             searched.
>> + * @val_cmp:   Value to which the values stored in table are compared to.
>> + * @reg:       NULL or pointer to location where the matching register
>> + *             setting value will be stored.
>> + * @val:       NULL or pointer to location where the found value will be
>> + *             stored.
>> + *
>> + * returns:    0 on success, negative errno if table is invalid or match is
>> + *             not found.
>> + */
>> +int regtable_find_smaller_than_val(const struct reg_val_table *table,
>> +                                  int val_cmp, int *reg, int *val)
>>
>>
>> and
>>
>> +struct regmap_regval_table {
>> +       const struct reg_val_table table;
>> +       int reg;
>> +       int mask;
>> +};
>>
>> +/**
>> + * regmap_table_value_set - update register to match
>> human-understandable value
>> + * @map:       Register map
>> + * @table:     Table describing register-value, human-readable value
>> relation
>> + * value:      Human understandable value to configure in hardware.
>> + *
>> + * Return:     0 on success, negative errno on error.
>> + */
>> +int regmap_table_value_set(struct regmap *map,
>> +                          const struct regmap_regval_table *table, int
>> value)
>>
>>
>> +/**
>> + * regmap_table_value_get - return human-understandable configuration
>> + *
>> + * Reads hardware or regmap cache for current hardware configuration and
>> + * converts the read register value to human understandable entity.
>> + * @map:       Register map
>> + * @table:     Table describing register-value, human-readable value
>> relation
>> + * value:      Human understandable value to configure in hardware.
>> + *
>> + * Return:     0 on success, negative errno on error.
>> + */
>> +int regmap_table_value_get(struct regmap *map,
>> +                          const struct regmap_regval_table *table, int
>> *value)
>>
>>
>> (for anyone interested, whole thing + tests can be found from:
>> https://github.com/M-Vaittinen/linux/commits/regtable/
>> Just last 3 commits.)
>>
>> I am however having difficulties in seeing how this could be utilized by
>> IIO, which tends to rely on values being represented by two integers
>> (val and val2).
> 
> Two integers and a type to make it harder still... IIO_VAL_INT_PLUS_MICRO etc
> though I guess that might not need representing as generally the caller
> would know what that was.  Fixed point (ish) is a pain, but not come up with a better
> presentation yet :(

I think the IIO-representation is fine. Sure it sucks that the real 
world is set up in such a imperfect way that we do need fractions, but 
as we do, IIO-way is just fine.

The thing IIO 'stuff' requires (and is not available in this draft) is 
64 storage bits for the values. I guess I could increase the size in 
tables to use u64 - and have an IIO-specific layer which could 
pack/unpack the val and val2 in that 64 bits appropriately - but I'm not 
sure it's worth the hassle. Besides, when users only need 32bits, 64bit 
tables would be waste.

Adding support for both 32 and 64 bit tables would probably work - but 
maybe this is just an overkill for a simple task. Creating just 
IIO-specific helpers would be much leaner.

>> Any suggestions regarding this idea? I'm wondering if I should just
>> scrap this and try seeing if I can make an IIO-specific helper(s) - or
>> if someone sees this would bring additional value worth an proper RFC? I
>> don't want to sen an RFC for people to properly review if this idea is
>> just plain stupid :)
> 
> It seems useful in general but I guess it's a question of whether you can find
> enough users to justify it.

You're right of course. I think my question should've been if someone 
can instantly think a type of devices that could benefit from these 
helpers :)

Anyways, bit Thank You for the input! Your help is much appreciated as 
always! :) Let's see if my "hands NOT full" time continues so I can 
rethink this.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


