Return-Path: <linux-iio+bounces-10596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E7A99DE3B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 08:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532801F23959
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 06:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8BB189B9B;
	Tue, 15 Oct 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMSZVvaM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B847170A0B;
	Tue, 15 Oct 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973621; cv=none; b=GXzQe7gIS53tbTi4MdDmzlE974+SdT3hatFXmagqtw6M/CrxB90SeZC4jHxRm5bfF5ky3AEOyB2bgLK2+mXocJZzUvVrX6gIQMyacT7CsBy1hr96Ju2jzyBeIUkBBGk5tF1rFRHTRyFQ1gBx3t18M6VCPGnqTi0S0ZQB5hC76dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973621; c=relaxed/simple;
	bh=t/BWOM+SqRlIfLDQtvvBnVm2IbaLuareqWYIChp937I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMRfrJumNa4XJaSicOJbujpu5y8bPgmvPD2HB+6IWHqJAjqluT9UuxIjWkpK7l3BcYecxotedHqKRwL/1iPeV2zOo0Wtw0X8Sf+XyGr8XlsSqsahwfyfaIFVuPrBioe3wrIu8vedzASn9ozbVkeB/SVeG/Q1PpncGKqG/AXZ184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMSZVvaM; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb443746b8so14506161fa.0;
        Mon, 14 Oct 2024 23:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728973618; x=1729578418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2o/wObrfOWpsAJFL/fh01+JCx9B90c5uyr52Uh4qWI=;
        b=PMSZVvaMvO7iPos2mOy20mEztkM2E29SrkR795YwJXo/3/nDtSe7Pj0MAzzMdx1OaB
         xmetNNdNonltRlSrgQvXRgcmiwObQzQ/j1kLZ4Bu9/AMpDw0rvDfx9nrXvSOVdYtA3ct
         /O8XW117ud6+epUsz/35vKNxw2cTs7f2BEAla66fGgYx7eeqtQ/vfnJzPj+kmtqTTEGa
         kClKmB+eLgmImYKZYDDICVmJZqvKUqSw5iH5YY+A89mCvxVXK05wIjenqbXkMLEhzMUO
         QhWk8Wq4y4V2WoXb1q52JgZWI5c8/D0Xu2PH2Xu2UbCNA13wDqPEwndihimtTFIRmLbO
         XjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728973618; x=1729578418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2o/wObrfOWpsAJFL/fh01+JCx9B90c5uyr52Uh4qWI=;
        b=X9zLirxVI6xUQdc4epGadhm1kWbt9GHqaR215IohzP04Pm0kST5tJHRd5xODW985Nk
         KHFOBqk2YcleGRxxnn5Ec7FCtPOTEUCnl63tfmrZCsNGHplW9Sf0vj0mEz9I9Zk6+2A4
         4b2kz9YYZmWQ239sg0otTmNjiqRlhXUMjJYCUAzwTKzOrZObvnb1J1LFW2G618c6z7WY
         YvXvSdlUUm7Ge9KFjvD/5qgdjrO/GjKwj9cgx412A+d/lEjZpJfNNBQVBqiCKva8x0o0
         ScdKzkghgLmmBDPLka0eMlSZ2kDaM0om2cDS6hNHCRgZcXozb5hYrI0rNTV6kfkEWeke
         kmcg==
X-Forwarded-Encrypted: i=1; AJvYcCU5LUMYO8VfUoDUZoACrE5ECCq+i1EzywDzPt+QKsDiVMcB5xBJItTEVedlfqGiXPhoJWOY6D4klTc=@vger.kernel.org, AJvYcCX0C2I5KsVYJyy3pu9nWSy8Jm5Yex7R/Gdgxs53UfB76Q4yTmwPO4Jy8Do12ophjvsK23dG60oAcuSAqYXF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29VS8beCjv7rw4iZiA/SanQ4EJrOBv/W+NFOhvHABUwULAISH
	eIQ0oxvoCgq1Hgl58Z5XCGtzrQsPBHvOKVlUax6E9brJTFsGUG8D
X-Google-Smtp-Source: AGHT+IFs9GuiCOJhjSSzeVzgdO9K2anERy59SaMHjgpfsvLc6DIcLZ5EQuByzExUoZpO1dRUzrLAhA==
X-Received: by 2002:a2e:b8c6:0:b0:2fb:58c0:de5b with SMTP id 38308e7fff4ca-2fb58c0dfa9mr17257851fa.11.1728973617757;
        Mon, 14 Oct 2024 23:26:57 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb5d1a86a2sm801441fa.112.2024.10.14.23.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 23:26:55 -0700 (PDT)
Message-ID: <8671e3dc-dda6-4a45-864e-b01c668cd9d9@gmail.com>
Date: Tue, 15 Oct 2024 09:26:54 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gts-helper: Fix memory leaks in
 iio_gts_build_avail_scale_table()
To: Jonathan Cameron <jic23@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241011095512.3667549-1-ruanjinjie@huawei.com>
 <20241012171559.2c118a2f@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241012171559.2c118a2f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jinjie, Jonathan,

On 12/10/2024 19:15, Jonathan Cameron wrote:
> On Fri, 11 Oct 2024 17:55:12 +0800
> Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> modprobe iio-test-gts and rmmod it, then the following memory leak
>> occurs:
>>
>> 	unreferenced object 0xffffff80c810be00 (size 64):
>> 	  comm "kunit_try_catch", pid 1654, jiffies 4294913981
>> 	  hex dump (first 32 bytes):
>> 	    02 00 00 00 08 00 00 00 20 00 00 00 40 00 00 00  ........ ...@...
>> 	    80 00 00 00 00 02 00 00 00 04 00 00 00 08 00 00  ................
>> 	  backtrace (crc a63d875e):
>> 	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
>> 	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
>> 	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
>> 	    [<0000000071bb4b09>] 0xffffffdf052a62e0
>> 	    [<000000000315bc18>] 0xffffffdf052a6488
>> 	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
>> 	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
>> 	    [<00000000f505065d>] kthread+0x2e8/0x374
>> 	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
>> 	unreferenced object 0xffffff80cbfe9e70 (size 16):
>> 	  comm "kunit_try_catch", pid 1658, jiffies 4294914015
>> 	  hex dump (first 16 bytes):
>> 	    10 00 00 00 40 00 00 00 80 00 00 00 00 00 00 00  ....@...........
>> 	  backtrace (crc 857f0cb4):
>> 	    [<0000000028c1b3c2>] kmemleak_alloc+0x34/0x40
>> 	    [<000000001d6ecc87>] __kmalloc_noprof+0x2bc/0x3c0
>> 	    [<00000000393795c1>] devm_iio_init_iio_gts+0x4b4/0x16f4
>> 	    [<0000000071bb4b09>] 0xffffffdf052a62e0
>> 	    [<000000007d089d45>] 0xffffffdf052a6864
>> 	    [<00000000f9dc55b5>] kunit_try_run_case+0x13c/0x3ac
>> 	    [<00000000175a3fd4>] kunit_generic_run_threadfn_adapter+0x80/0xec
>> 	    [<00000000f505065d>] kthread+0x2e8/0x374
>> 	    [<00000000bbfb0e5d>] ret_from_fork+0x10/0x20
>> 	......
>>
>> It includes 5*5 times "size 64" memory leaks, which correspond to 5 times
>> test_init_iio_gain_scale() calls with gts_test_gains size 10 (10*size(int))
>> and gts_test_itimes size 5. It also includes 5*1 times "size 16"
>> memory leak, which correspond to one time __test_init_iio_gain_scale()
>> call with gts_test_gains_gain_low size 3 (3*size(int)) and gts_test_itimes
>> size 5.
>>
>> The reason is that the per_time_gains[i] is not freed which is allocated in
>> the "gts->num_itime" for loop in iio_gts_build_avail_scale_table().
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Hi Jinjie,
> 
> Your explanation looks correct to me.  I'll wait a while though to give Matti time
> to take a look as well.

Sorry for late reply - I spent last couple of days walking through the 
swamps and forests in the wilderness.

Something was bothering me with this. I browsed through the code and all 
the allocations and I'm not able to see why these arrays shouldn't be 
freed. I did even go through the versions I've sent on list trying to 
find out what bothers me.

Well, I found nothing. The version 2 had some code which looped through 
these arrays freeing them - in an error path - but not in successful 
case. It seemed as if I had thought these values had to be maintained - 
but I really can't see why.

So - thanks. I suppose leaving the memory not freed is just a bug :) 
Nice that you killed this one :)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
>> index 59d7615c0f56..7326c7949244 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -307,6 +307,8 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>>   	if (ret)
>>   		goto err_free_out;
>>   
>> +	for (i = 0; i < gts->num_itime; i++)
>> +		kfree(per_time_gains[i]);
>>   	kfree(per_time_gains);
>>   	gts->per_time_avail_scale_tables = per_time_scales;
>>   
> 


