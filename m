Return-Path: <linux-iio+bounces-11736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7A99B8A1C
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 04:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1D01C21709
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277D146592;
	Fri,  1 Nov 2024 03:49:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4781ACA;
	Fri,  1 Nov 2024 03:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432963; cv=none; b=d+Q4mDZlOr81lGXCH6ATPdXhybCW6vxEwlqEQ9EAIxv2kf/NRYnYV/szPy5kabK50ypINhZPPeB+y/26xahWp3uZ+2rcPHFDobnKuAlw145+4iVQAU/bX++csP4q+4iMDy2KVUvFeelaAtEXasKlBJFS/kS63eINL57V1ExaStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432963; c=relaxed/simple;
	bh=Dz75ZST8dWVDzo/Q/bFdydwcpqxQ44P49x8eC5sWkbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F/ARxi7HV8NqDfGbLpe5a7LQjywcFIc5WdOM9QNSUdkOTAL7Fm+ANSiOUCa1PrYkqVX4R4KTh2nFMBwVaD+jZTrDrNEXcMdi3Lx/sghNUNzP4b7VSYPOOHUuwXDosQwVkzLB8NlXJ4rimGVEqegLuNHDoU5W52jnXcdDiFy80Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xfn0v5h19z1ynfx;
	Fri,  1 Nov 2024 11:49:19 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id BC0AA1A016C;
	Fri,  1 Nov 2024 11:49:10 +0800 (CST)
Received: from [10.67.109.114] (10.67.109.114) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 11:49:10 +0800
Message-ID: <d2997f40-a328-4c86-be2f-982e72b06401@huawei.com>
Date: Fri, 1 Nov 2024 11:49:09 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: fix memory leak for
 iio_gts_build_avail_scale_table()
To: Matti Vaittinen <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>
References: <20241031014743.2313121-1-quzicheng@huawei.com>
 <9ee46109-8503-4b5d-bfd4-45b7ac03029a@gmail.com>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <9ee46109-8503-4b5d-bfd4-45b7ac03029a@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500008.china.huawei.com (7.185.36.147) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi Matti,

Thank you for your concern! I haven't used it in my projects yet. I came 
across this issue while using smatch for code analysis. After reviewing 
the code, I noticed a few minor issues. However, I did not realize that 
the patch for the memory leak has already been submitted couple of days 
ago. Apologies for not checking the patches thoroughly and submitting a 
duplicate.

Yours,

-- Zicheng

On 2024/10/31 15:32, Matti Vaittinen wrote:
> Hi Zicheng
>
> On 31/10/2024 03:47, Zicheng Qu wrote:
>> In iio_gts_build_avail_scale_table(), the memory allocated for
>> per_time_gains is freed using kfree(per_time_gains) before return 0.
>> However, the type per_time_gains is 'int **', and the memory allocated
>> for its inner elements is not being freed, leading to a memory leak.
>>
>> Cc: stable@vger.kernel.org # v6.6+
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c 
>> b/drivers/iio/industrialio-gts-helper.c
>> index 59d7615c0f56..f2450b2e740d 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -307,6 +307,8 @@ static int iio_gts_build_avail_scale_table(struct 
>> iio_gts *gts)
>>       if (ret)
>>           goto err_free_out;
>>   +    for (j = 0; j < gts->num_itime; j++)
>> +        kfree(per_time_gains[i]);
>>       kfree(per_time_gains);
>>       gts->per_time_avail_scale_tables = per_time_scales;
>
> You're right, thanks!
> This, however, was already fixed by:
> https://lore.kernel.org/all/20241011095512.3667549-1-ruanjinjie@huawei.com/ 
>
>
> Out of the curiosity (and no need to respond if you don't feel like) - 
> are you using the gts helpers in some of your project(s)? I am glad 
> seeing these fixes coming in and just wondered if all these bugs are 
> found because these helpers are being used outside the ROHM drivers :)
>
> Yours,
>     -- Matti
>

