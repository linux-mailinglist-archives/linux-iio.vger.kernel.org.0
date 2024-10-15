Return-Path: <linux-iio+bounces-10609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AF399E26F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072591C21FCE
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768D21DAC93;
	Tue, 15 Oct 2024 09:10:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C31E7658;
	Tue, 15 Oct 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983444; cv=none; b=o/88z3VU2xbpHyUA3let5aMV78GnHM/PNVtHyqqSklPPLYouJQgAvVnqtVYfP+OxhBo9/KbohIkTZAsVYtRVSgFlg/fpLPQyzbEeXFQVx2EaD51fN+x+guxBMYxceVo3mK5kHksuWljjz3Cw8X7u7MskwbzlpQzwQkzz1lLdkow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983444; c=relaxed/simple;
	bh=3NIexYHb3oKJa4jdkE7d25U0gkswgtbHF4VH6JcS+cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b5W8/zZUtg39A9lFn7xX9GJSQ0Hz63g44oGKJXVWNDYyqx8JomrC+SEkLiOFFnUPjfHM/q83kGHlS6pA0zOw1tN7k94bjPfvtLkbt/NookmWD/XiqUqsDFfPQny2mK0QQ6ru147naDPkCihdie0ZakmKi84BABitjuVkYp3PsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XSSxd1X38z1yn8h;
	Tue, 15 Oct 2024 17:10:45 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A4551A0188;
	Tue, 15 Oct 2024 17:10:39 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Oct 2024 17:10:38 +0800
Message-ID: <ec2e2c43-e369-e932-0344-9bbbfea735b5@huawei.com>
Date: Tue, 15 Oct 2024 17:10:38 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] iio: gts-helper: Fix memory leaks for i = 1 error path
Content-Language: en-US
To: Matti Vaittinen <mazziesaccount@gmail.com>, <jic23@kernel.org>,
	<lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241014013144.576701-1-ruanjinjie@huawei.com>
 <76d96ab6-4e13-42b9-bff0-03a2e1b96f57@gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <76d96ab6-4e13-42b9-bff0-03a2e1b96f57@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/15 17:03, Matti Vaittinen wrote:
> Thanks a lot Jinjie. I appreciate your fixes!
> 
> On 14/10/2024 04:31, Jinjie Ruan wrote:
>> If i = 1, and per_time_scales[i] or per_time_gains[i] kcalloc fails in
>> iio_gts_build_avail_scale_table(), the err_free_out will fail to enter
>> kfree for loop because i-- is 0, and all the per_time_scales[0] and
>> per_time_gains[0] will not be freed, which will cause memory leaks.
> 
> I guess the loop never frees the memory pointed by the first pointer in
> these arrays. I mean, the freeing is not working as it should even if
> the 'i' was something else but 1.

Yes, the title is not very clear. In fact, all the per_time_scales[0] or
per_time_scales[0] in the function error path are not released.

> 
>>
>> Fix it by checking if i >= 0.
> 
> The fix seems good to me. So, with a tiny change in commit message:
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   drivers/iio/industrialio-gts-helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-gts-helper.c
>> b/drivers/iio/industrialio-gts-helper.c
>> index 7326c7949244..5f131bc1a01e 100644
>> --- a/drivers/iio/industrialio-gts-helper.c
>> +++ b/drivers/iio/industrialio-gts-helper.c
>> @@ -315,7 +315,7 @@ static int iio_gts_build_avail_scale_table(struct
>> iio_gts *gts)
>>       return 0;
>>     err_free_out:
>> -    for (i--; i; i--) {
>> +    for (i--; i >= 0; i--) {
>>           kfree(per_time_scales[i]);
>>           kfree(per_time_gains[i]);
>>       }
> 

