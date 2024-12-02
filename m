Return-Path: <linux-iio+bounces-12927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1E9DFAD5
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 07:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE62B21866
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691731D63F9;
	Mon,  2 Dec 2024 06:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtX8suNN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B201F8EF0;
	Mon,  2 Dec 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121906; cv=none; b=t7rBxMYi93hE9c5qvSzTyOq/kT7gaGGdiO0eonMtvAbkDadXFSmz8k8lGsVAyZ3tT8dmUTDjB3BDl1MiCxsW6l0aI8livdh9pyD6nXrHxD1Z0vWNRmHSEsbIW6oGioIe4/N8SDUV2pRB/kLOJTwxoNeHRUZjgQYC+G2+8qtCtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121906; c=relaxed/simple;
	bh=NWyhNFwkROuQEWkO0srSA6N8NQM9TB3aC1fKVL5H4GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1d3WSjFVUMXyOTKwUdoghzYIzpyTWr6ZO71UfrCOE1G1rGPUGYWYFHGZeen+v7z5p60hwXqGguqeazeWsPOJgaQsT5XJyW3CDQV9hFB99PFux8bZuULs3y7U4WCo2gp+QVXXvV0ZZla/J0vqDJs31tVF4kj1P4lTWefLE3GsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtX8suNN; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffbea0acc2so39575321fa.1;
        Sun, 01 Dec 2024 22:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733121902; x=1733726702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkvfc8rUC3zYH63ASpHPRmnBLTGKCK6yLd3NLu3Guzw=;
        b=RtX8suNNxylEkxzYGMbMDZfWxZBbkkT51MDFlBPsK+JYjZeyClRxrJI/BA+Ak3aXJ+
         e+uOQgJ1T1yosRTONHHwHRJXo/n8O8klwtessH26Sg8/ABl58W1p/7ndBOHH98BzPHzI
         Zhj637DE0iZCfl8gynTb0ktTe4OUHKlp5M8QQkUA8Uxf1ebfCmJDd0l1mgGeNaqGrIoV
         r5uuz3h7XKoKu9xg7e9/8tJvibAWx49WNprcFpIBe0ThjkX8nU2+sgBzo9ZjK2w5hJ5x
         Zhjf1LipKlQL43U5W56bSSgLqfJo2GULp9m+XBGNwXjbnKR+3ZwBzBQ/26mnXUSUm8Ml
         MdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733121902; x=1733726702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkvfc8rUC3zYH63ASpHPRmnBLTGKCK6yLd3NLu3Guzw=;
        b=lFcTaZAMZoP2p219hhRaUDqjJSXcG/tuZTGdUNbujDg63mEcD4hXcZETz2uOIwzYBr
         r5aYpu2p/FOlI24lKgQ2gLHx3CEeefrXTyUA+Ljcuhep5JFABLE/5LSN1/fSlz78nNK+
         XeGsw+X6FPmn7ZKKTQyqYYkjNWy9HitJzOlUt2KXQY6q/eMD9Tr8qGkKKZoXRWMawvED
         mhDrfyIh0PsfHYADlkn4gqEYMWx5XYbU4BT9bvOUrJiQnVZRRphW/rAOD5GdhkHT34Ht
         +XvfbdbgPdWOPL3RgCofSWx1VlPowFgq5EKlOA8eBVOCvmbtCSOv1np7oYACSf80xg01
         dhMw==
X-Forwarded-Encrypted: i=1; AJvYcCUEAfpGvqoStqJJSw0whPU3spwKh7r825wJlJHORF0oRHHavmFRRn+sOvkZSJcxDWl5cpZoOaDMzWk=@vger.kernel.org, AJvYcCXUyVyjlEuD1rgTS3q4i6zuhEC6EbO1Ismym/W11lPSBpAbM65xDgr7EN0rs2RPpzO3DuIipKUOKHkpFtNb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8BF87eI06XhPLa2WwgZYrqkstGhuMcYGRjbr8ovAROL1aVen
	+VGCeIE/4smhT8AL1QdLA0ADrkpxDeln5Q8gScVhB/V2PPwVow1AboFtBg==
X-Gm-Gg: ASbGncsS58XY8ZEhI8qE7GV6HgcsgN/Jsj/iE/yWytmNE4vlRiSDf6aEzdjmYh1Uqsq
	D7ie12HBvwOj5SZ1tEVz7VzI6i7i1cw3usVC4+mcbTOqCXLm4I3tObDn0YKvvClaV0S5ShQvuLt
	6OXBq9Go75/fmRoJiFUuvHVyunwRt3jxh3aA+s/S1+8tTJTBjnjaVjkpvBnLpKN9uyucFVKFknM
	yvQyk4gSXES89LrFaMjPouiuZY9qfDWsEpR5/kcmxs02Z1x7Xe+oW24+Y6QGhafo02U36kzG98R
	93vUvRShdqzWj69zO+Kbpp1V5zeMioY=
X-Google-Smtp-Source: AGHT+IGaTieny3qw0MVJptpe5t5N20qahfFypOA6x/u1+MkXUji6aaCcXd2JoPkFxlDZChxNmvTeLg==
X-Received: by 2002:a2e:a98a:0:b0:2ff:a7cd:ee7e with SMTP id 38308e7fff4ca-2ffd6040dc0mr94963181fa.6.1733121901858;
        Sun, 01 Dec 2024 22:45:01 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfccad87sm12248851fa.121.2024.12.01.22.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 22:45:00 -0800 (PST)
Message-ID: <670d860b-f6fc-4ef1-ba05-bbce24ed82fd@gmail.com>
Date: Mon, 2 Dec 2024 08:44:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: gts: Simplify using __free
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1732811829.git.mazziesaccount@gmail.com>
 <1f8e1388b69df8a5a1a87748e9c748d2a3aa0533.1732811829.git.mazziesaccount@gmail.com>
 <20241130175141.14d3589a@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241130175141.14d3589a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/11/2024 19:51, Jonathan Cameron wrote:
> On Thu, 28 Nov 2024 18:50:24 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The error path in the gain_to_scaletables() uses goto for unwinding an
>> allocation on failure. This can be slightly simplified by using the
>> automated free when exiting the scope.
>>
>> Use __free(kfree) and drop the goto based error handling.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> This is derived from the:
>> https://lore.kernel.org/lkml/5efc30d832275778d1f48d7e2c75b1ecc63511d5.1732105157.git.mazziesaccount@gmail.com/
> 
> Hi Matti
> 
> A few comments on specific parts of this below
> 
> Thanks,
> 
> Jonathan
> 
>> +static int build_combined_table(struct iio_gts *gts, int **gains, size_t gain_bytes)
>> +{
>> +	int ret, i, j, new_idx, time_idx;
>> +	int *all_gains __free(kfree) = kcalloc(gts->num_itime, gain_bytes,
>> +					       GFP_KERNEL);
>> +
>>   	if (!all_gains)
>>   		return -ENOMEM;
>>   
>> @@ -232,10 +238,9 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>>   
>>   	gts->avail_all_scales_table = kcalloc(new_idx, 2 * sizeof(int),
>>   					      GFP_KERNEL);
> 
> I'm not particularly keen in a partial application of __free magic.

I am starting to think the partial application of __free would actually 
be what I preferred... (see below).

> Perhaps you can use a local variable for this and a no_free_ptr() to assign it after we know
> there can't be an error that requires it to be freed.

I am having second thoughts of this whole series. I do love the idea of 
__free() magic, when applied on a simple temporary allocations that are 
intended to be freed at the end of a function. Eg, for cases where we 
know the scope from the very beginning. With a consistent use of __free 
in such cases could make it much more obvious for a reader that this 
stuff is valid only for a duration of this block. I have a feeling that 
mixing the no_free_ptr() is a violation, and will obfuscate this.

I know I used it in this series while trying to simplify the flow - and 
I am already regretting this.

Additionally, I indeed am not okay with introducing variables in middle 
of a function. I do really feel quite strongly about that.

It seems that in many functions it makes sense to have some checks or 
potentially failing operations done before doing memory allocations. So, 
keeping the allocation at the start of a block can often require some 
additional "check/do these things before calling an internal function 
which does alloc + rest of the work" -wrappers.

It will then also mean that the internal function (called from a wrapper 
with checks) will lack of the aforementioned checks, and, is thus 
somehow unsafe. I am not saying such wrappers are always wrong - 
sometimes it may be ok - but it probably should be consistent approach 
and not a mixture of conventions depending on allocations...

Also, sometimes this would result some very strangely split functions 
with no well defined purpose.

As a result, I would definitely only use the "__free magic" in places 
where it does fit well for freeing a memory which is known to be needed 
only for a specific block. And, I would only use it where the alloc can 
be done at the beginning of a function in a rather natural way. This, 
however, is very likely to lead in mixed use of "__free magic" and 
regular allocs.

>> -	if (!gts->avail_all_scales_table) {
>> -		ret = -ENOMEM;
>> -		goto free_out;
>> -	}
>> +	if (!gts->avail_all_scales_table)
>> +		return -ENOMEM;
>> +
>>   	gts->num_avail_all_scales = new_idx;
>>   
>>   	for (i = 0; i < gts->num_avail_all_scales; i++) {
>> @@ -246,14 +251,25 @@ static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>>   		if (ret) {
>>   			kfree(gts->avail_all_scales_table);
>>   			gts->num_avail_all_scales = 0;
>> -			goto free_out;
>> +			return ret;
>>   		}
>>   	}
>>   
>> -free_out:
>> -	kfree(all_gains);
>> +	return 0;
>> +}
>>   
>> -	return ret;
>> +static int gain_to_scaletables(struct iio_gts *gts, int **gains, int **scales)
>> +{
>> +	int ret;
>> +	size_t gain_bytes;
>> +
>> +	ret = fill_and_sort_scaletables(gts, gains, scales);
>> +	if (ret)
>> +		return ret;
>> +
>> +	gain_bytes = array_size(gts->num_hwgain, sizeof(int));
> 
> array_size is documented as being for 2D arrays, not an array of a multi byte
> type.  We should not use it for this purpose.

Thanks for pointing this out. I was not familiar with that. I am 
actually pretty sure that using the array_size() has been recommended to 
me :)

> I'd be tempted to not worry about overflow, but if you do want to be sure then
> copy what kcalloc does and use a check_mul_overflow()
> 
> https://elixir.bootlin.com/linux/v6.12.1/source/include/linux/slab.h#L919

Thanks for the direct pointer :) I'll take a look at it!

> 
> You don't have to tidy that up in this patch though.
> 
>> +
>> +	return build_combined_table(gts, gains, gain_bytes);
>>   }
> 
>>   
>> +/**
>> + * iio_gts_build_avail_time_table - build table of available integration times
>> + * @gts:	Gain time scale descriptor
>> + *
>> + * Build the table which can represent the available times to be returned
>> + * to users using the read_avail-callback.
>> + *
>> + * NOTE: Space allocated for the tables must be freed using
>> + * iio_gts_purge_avail_time_table() when the tables are no longer needed.
>> + *
>> + * Return: 0 on success.
>> + */
>> +static int iio_gts_build_avail_time_table(struct iio_gts *gts)
> Hmm. I guess this wrapper exists because perhaps you aren't comfortable
> yet with the __free() handling mid function.  It does not harm so I'm fine
> having this.

Yes. This was the reason for this wrapper. But I'm not really happy 
about the wrappers either (even if I agree with you that it does not 
really hurt here). Furthermore, if you're feeling strongly about not 
mixing the __free and regular allocs, then I simply prefer not using the 
magic one. I don't think using the __free with allocations intended to 
last longer than the scope is clear. Ues, goto sequences may not always 
be simple, but at least people are used to be wary with them.

>> +{
>> +	if (!gts->num_itime)
>> +		return 0;
>> +
>> +	return __iio_gts_build_avail_time_table(gts);
>> +}
>> +
>>   /**
>>    * iio_gts_purge_avail_time_table - free-up the available integration time table
>>    * @gts:	Gain time scale descriptor
> 

Thanks a ton for the review :) It helped me to clarify my thoughts on this!

Yours,
	-- Matti


