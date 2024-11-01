Return-Path: <linux-iio+bounces-11735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4579B8A09
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 04:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C601C2110F
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 03:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5471413E028;
	Fri,  1 Nov 2024 03:43:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAE3FF1;
	Fri,  1 Nov 2024 03:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730432611; cv=none; b=JZfbtnuWRwWoI6dNJMD63kV2HiBQn21Ov0dKKZ2BJNyR1NTc/9Pbl3RuLOfrWz1wY/t3+TnNjlRQJuziA48bxDJIlgoyDxvyndUuDLdJoxWWNxBGaqy5zXOQhOWNoJtyXgWis+5K135b4dmGcr4hRSnjGLqLKCyDZdPxPvmUn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730432611; c=relaxed/simple;
	bh=pRMfJhGuoGdcGTTVVjevgwIk+6vs3s7GylTeKPL117A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YGvyYBsvBTImWqyTfIAAW++D0HedLqUZQdv+u4MprDoFNyFiAbUMM928eqmqKOQ6AehrtsJgddFOcVBxZU2R62F43sBQkc/20ITXCEzj2ai+UeAfUa7J4TauotiXkf0lbDemg+6cwjBnepNLanfXIEPa82ExUlOWztkIeIoIpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XfmrH5Nr1z1jwFG;
	Fri,  1 Nov 2024 11:41:51 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id D808B1400D3;
	Fri,  1 Nov 2024 11:43:25 +0800 (CST)
Received: from [10.67.109.114] (10.67.109.114) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 1 Nov 2024 11:43:25 +0800
Message-ID: <1a004693-5dd5-458c-b8ff-b9a978298122@huawei.com>
Date: Fri, 1 Nov 2024 11:43:24 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Fix uninitialized symbol 'ret'
To: Matti Vaittinen <mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>
References: <20241031014505.2313035-1-quzicheng@huawei.com>
 <5f80c1a2-118a-4685-ac1b-81b3479f5064@gmail.com>
From: Zicheng Qu <quzicheng@huawei.com>
In-Reply-To: <5f80c1a2-118a-4685-ac1b-81b3479f5064@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500008.china.huawei.com (7.185.36.147) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi Matti,

It might be better but I am not pretty sure whether have to have both 
gains and times, so I modified 'ret' in places where issues might arise, 
rather than adding a restriction in iio_gts_sanity_check().

In the corner case, there is a restriction that both num_hwgain and 
num_itime cannot be 0 simultaneously in the iio_gts_sanity_check(). 
However, in the gain_to_scaletables() , if num_itime is 1 and num_hwgain 
is 0, the 'gain_bytes' becomes 0 and 'all_gains' is not null after the 
'for' loop, which causes the subsequent 'while' or 'for' to become 
ineffective, leading to an undefined 'ret' being returned in the 'free_out'.

Yours,

-- Zicheng

On 2024/10/31 15:13, Matti Vaittinen wrote:
> Hi Zicheng,
>
> Thanks for the patch.
>
> On 31/10/2024 03:45, Zicheng Qu wrote:
>> Initialize the variable ret at the time of declaration to prevent it 
>> from
>> being returned without a defined value. Fixes smatch warning:
>> drivers/iio/industrialio-gts-helper.c:256 gain_to_scaletables() error:
>> uninitialized symbol 'ret'.
>>
>> Cc: stable@vger.kernel.org # v6.6+
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c 
>> b/drivers/iio/industrialio-gts-helper.c
>> index 59d7615c0f56..c5dc5b51693d 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -167,7 +167,7 @@ static int iio_gts_gain_cmp(const void *a, const 
>> void *b)
>>     static int gain_to_scaletables(struct iio_gts *gts, int **gains, 
>> int **scales)
>>   {
>> -    int ret, i, j, new_idx, time_idx;
>> +    int i, j, new_idx, time_idx, ret = 0;
>>       int *all_gains;
>>       size_t gain_bytes;
>
> So, if I read it right, this handles a (corner) case where there is no 
> times given. I am not sure how well such use has been considered 
> because the point of GTS is helping out with cases where the gain and 
> integration time both impact to scale.
>
> How do you see the benefits of the gts if there is no such shared 
> impact to scale? Sure the gts could still provide the 'standard table 
> format' to present the gains (or times), and conversions from the 
> register values to gains (or times), and perhaps the available scale 
> table(s) - but I suppose it also brings a lot of unused code and some 
> initialization overhead. (I have a vague feeling this was discussed 
> with Jonathan during the reviews).
>
> Reason I am asking these questions is that I wonder if the usage 
> should be limited to cases where we have both gains and times? We 
> could check this in the iio_gts_sanity_check(). (And, I am actually a 
> bit surprized this check was not implemented).
>
> Well, initialization fixes a potential bug here and does not really 
> cost much - so big thanks to you :)
>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>
> Yours,
>  -- Matti Vaittinen
>

