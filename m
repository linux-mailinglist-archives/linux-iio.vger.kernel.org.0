Return-Path: <linux-iio+bounces-13530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BEA9F2A76
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 07:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D40A7A308C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3B1D222B;
	Mon, 16 Dec 2024 06:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpX4+2yl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676C1D131E;
	Mon, 16 Dec 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331826; cv=none; b=Yv7GZEyLiORrVyXm9NjOeGfHy2TyI+aEkgyJOOVfu9nyyUl8OhY8a6guqfRGtCChtcSu87otTuujazNFu7T+Ez94ho+jQRMfNTGYdukL17JJPpdCP6nK+Juq8Rar9lsZ+AubVhx6KljGicwYg11uTbl6x9T/chN9IpGmi/vw+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331826; c=relaxed/simple;
	bh=r68r662fG2IDBe740XsEVE7lgoHsL8GlpGB/2BgzKWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeEqyBKmIzqjbLY5ZgI8C6MFyT/alZdsGy2I41fOstMjZGWWtzz8UxXxCY6mu/ROqn73ZPp+iNcHCJOpp40s0IK42+yalnT1YcLXqtrNp8AeW0Ko0pUMNEEV9vMVXkKdyN7Dr5IJliX/KodIjlNCeB2dhmlowlVBFaJu5wVgyc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpX4+2yl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-300392cc4caso45850591fa.3;
        Sun, 15 Dec 2024 22:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734331822; x=1734936622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6e0E1B0KaqPlulaM0aVJJcV28f7dUFWzbp6+A2m58Q=;
        b=jpX4+2ylHsU5trDWxwLuo9vZE5au3Y5F8Abn25jQh83U9+6KbA1ac6q0R1UM0+33sA
         /8/xt467zbmfA5BWWbirVFRvbcptibRAHlKG242VPqWWizZSgOyazcMerqRz2fe3bqGg
         n4irsxZisvwXTBekA5Em9Jnb75Nu21po48dg0yd7/P3LjGjclbSJCqKD+In++OpYXCmF
         UDzI9T0xrj4Dlvj+RfKKWa3UZwWJ+60lxbtHcACCgIG7GSh4b7MJzgq9ozVQp1C4krRg
         8fsGd1u5+RsP0DS0NiYwgvrRQ1kmAlv0uKt/zCU5UOIwwR2rAy8ZpvVgUwaY80JKi4QW
         9kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734331822; x=1734936622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6e0E1B0KaqPlulaM0aVJJcV28f7dUFWzbp6+A2m58Q=;
        b=NZhH4fp2qMcVxelXp/HshxhUBWOsD3xsiXYecqOqECh7Vvo8jkG/Y8J9KlhWrU+qcP
         3r+HJVENxRGNs/uwu7DY9vaX3Vh7rP+q9B48xvjBJHI3sYnBSIyuQq8EWPbkWGv/kvU2
         MVDVKffgdahKeX1zvKXxheUJRxtTQtE3eHQM37s1Am0EQ2reIpYn+zkrF9n09CQUFD3P
         2EXhkmRU/7qY+/NO5R4QvnqSDP1cYBni49a5GO1TLioH7TujwWXrwPD2ToySFthjN0ui
         ap7Fwzte992NNcmK8M1r0105uykw9FUj59qNJx38lqvjZFsdBFZmz8trwF8krfsxA0Zk
         vzAw==
X-Forwarded-Encrypted: i=1; AJvYcCWMYKK78QQ8kqFEC0cHRIRfvKE/ZGy/ozAVvnSvwZvRgqSrOG3hyqKKS+cbKMo69t/hTB+HPEj7E+U65R6a@vger.kernel.org, AJvYcCWWKKaAnW0gON4Dfx2V/gcVPx/WgR/vtDQT6QDcOab5KBJ1Ot9f7eCrFSJqq1wkHTYDAxRotCCtLz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWhrdYDa5cQQ5gK0PbCqmz5G0nfmhKSeq4/kFXZ17HLaCB5H9
	3PHjJcItTHcTlOYBQfq/V1qrY61RchjMe33zQmthH55o5ABWqFrg
X-Gm-Gg: ASbGncu5oWrEIrG869zLJa6ydoQUVn1dnUUNKC2jIt6S7iEQ0Hqw5/SOpX+yxpoIf8u
	sQDq1fihmKa4O10I7dIXPc9GSNxkeNEVqN3F33aBovrDbD4f0qzW/URQ+oTU32rjbrE3xYa6kYR
	whbJOY4FDYaI/1ttnkkQep59dWXMYyZCjW91V8htOqH20uSqu8BawaFqD1ylKTPC4UBflThjN1F
	dgK9M8msA4M6NCq/MNtU6LKJYUaGqzdL6GpPuK7XHO41MLztZv609Bb98Ph00Fdx/dSuA==
X-Google-Smtp-Source: AGHT+IEeGVxlPSkLdd7AQgG86ojqQ0Cj3CcWEn5DOtZGWSnvfnSJ7cI4Z19uT33szD/AjRMrS8DOSA==
X-Received: by 2002:a2e:9095:0:b0:302:17e7:e18e with SMTP id 38308e7fff4ca-3025449200dmr31231321fa.11.1734331822245;
        Sun, 15 Dec 2024 22:50:22 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13a22sm738763e87.189.2024.12.15.22.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 22:50:20 -0800 (PST)
Message-ID: <81cd44f7-616c-48a6-bcd6-dd741c32e794@gmail.com>
Date: Mon, 16 Dec 2024 08:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iio: gts: Simplify available scale table build
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Mudit Sharma <muditsharma.info@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <Z1ajMXzvlgU0Smdf@mva-rohm> <20241215125459.40e50028@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241215125459.40e50028@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jonathan,

Thanks for the comments!

On 15/12/2024 14:54, Jonathan Cameron wrote:
> On Mon, 9 Dec 2024 09:58:41 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Make available scale building more clear. This hurts the performance
>> quite a bit by looping throgh the scales many times instead of doing
>> everything in one loop. It however simplifies logic by:
>>   - decoupling the gain and scale allocations & computations
>>   - keeping the temporary 'per_time_gains' table inside the
>>     per_time_scales computation function.
>>   - separating building the 'all scales' table in own function and doing
>>     it based on the already computed per-time scales.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Hi Matti,
> 
> I'm definitely keen to see easier to follow code and agree that the
> cost doesn't matter (Within reason).
> 
> I think a few more comments and rethinks of function names would
> make it clearer still.  If each subfunction called has a clear
> statement of what it's inputs and outputs are that would help
> a lot as sort functions in particular tend to be tricky to figure out
> by eyeballing them.

I'll see if I can come up with something more descriptive while keeping 
the names reasonably short.

>> ---
>> In my (not always) humble (enough) opinion:
>>   - Building the available scales tables was confusing.
>>   - The result of this patch looks much clearer and is simpler to follow.
>>   - Handles memory allocations and freeing in somehow easyish to follow
>>     manner while still:
>>       - Avoids introducing mid-function variables
>>       - Avoids mixing and matching 'scoped' allocs with regular ones
>>
>> I however send this as an RFC because it hurts the performance quite a
>> bit. (No measurements done, I doubt exact numbers matter. I'd just say
>> it more than doubles the time, prbably triples or quadruples). Well, it
>> is not really on a hot path though, tables are computed once at
>> start-up, and with a sane amount of gains/times this is likely not a
>> real problem.
>>
>> This has been tested only by running the kunit tests for the gts-helpers
>> in a beaglebone black. Further testing and eyeing is appreciated :)
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 250 +++++++++++++++-----------
>>   1 file changed, 149 insertions(+), 101 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> index 291c0fc332c9..01206bc3e48e 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -160,16 +160,108 @@ static void iio_gts_purge_avail_scale_table(struct iio_gts *gts)
>>   	gts->num_avail_all_scales = 0;
>>   }
> 
>> +
>> +static int do_combined_scaletable(struct iio_gts *gts, size_t scale_bytes)
> 
> Probably name this to indicate what it is doing to the combined scaletable.

Hmm. I think I understand what you mean. Still, I kind of think the 
function name should reflect what the function does (creates the scale 
table where all the scales are listed by combining all unique scales 
from the per-time scale tables).

Maybe this could be accompanied by a comment which also explains what 
how this is done.

> Maybe make it clear that scale_bytes is of the whole scale table (i think!)
> scale_table_bytes. 

I like this idea :)

> 
> A few comments might also be useful.

I agree. Especially if we keep the name reflecting the creation of the 
"all scales" table :)

>> +{
>> +	int t_idx, i, new_idx;
>> +	int **scales = gts->per_time_avail_scale_tables;
>> +	int *all_scales = kcalloc(gts->num_itime, scale_bytes, GFP_KERNEL);
>> +
>> +	if (!all_scales)
>> +		return -ENOMEM;
>> +
>> +	t_idx = gts->num_itime - 1;
>> +	memcpy(all_scales, scales[t_idx], scale_bytes);
> 
> I'm not 100% sure what that is copying in, so maybe a comment.
> Is it just filling the final integration time with the unadjusted
> scale table?  If so, maybe say why.
> 
>> +	new_idx = gts->num_hwgain * 2;
> 
> Comment on where you are starting the index. One row into a matrix?
> 
>> +
>> +	while (t_idx-- > 0) {
>> +		for (i = 0; i < gts->num_hwgain ; i++) {
>> +			int *candidate = &scales[t_idx][i * 2];
>> +			int chk;
>> +
>> +			if (scale_smaller(candidate, &all_scales[new_idx - 2])) {
>> +				all_scales[new_idx] = candidate[0];
>> +				all_scales[new_idx + 1] = candidate[1];
>> +				new_idx += 2;
>> +
>> +				continue;
>> +			}
>> +			for (chk = 0; chk < new_idx; chk += 2)
>> +				if (!scale_smaller(candidate, &all_scales[chk]))
>> +					break;
>> +
>> +
>> +			if (scale_eq(candidate, &all_scales[chk]))
>> +				continue;
>> +
>> +			memmove(&all_scales[chk + 2], &all_scales[chk],
>> +				(new_idx - chk) * sizeof(int));
>> +			all_scales[chk] = candidate[0];
>> +			all_scales[chk + 1] = candidate[1];
>> +			new_idx += 2;
>> +		}
>> +	}
>> +
>> +	gts->num_avail_all_scales = new_idx / 2;
>> +	gts->avail_all_scales_table = all_scales;
>> +
>> +	return 0;
>> +}
> 
> 
>> -	/*
>> -	 * We assume all the gains for same integration time were unique.
>> -	 * It is likely the first time table had greatest time multiplier as
>> -	 * the times are in the order of preference and greater times are
>> -	 * usually preferred. Hence we start from the last table which is likely
>> -	 * to have the smallest total gains.
>> -	 */
> ah. This is one of the comments I'd like to see up above.

Right! I'll re-add this comment to correct location :)

> 
>> -	time_idx = gts->num_itime - 1;
>> -	memcpy(all_gains, gains[time_idx], gain_bytes);
>> -	new_idx = gts->num_hwgain;
>> +static void compute_per_time_gains(struct iio_gts *gts, int **gains)
>> +{
>> +	int i, j;
>>   

Thanks a lot Jonathan! I feel your feedback helps to make this better :)


Yours,
	-- Matti


