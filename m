Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233722A44C0
	for <lists+linux-iio@lfdr.de>; Tue,  3 Nov 2020 13:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKCMEh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Nov 2020 07:04:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7133 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgKCMEh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Nov 2020 07:04:37 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQT3Y5tlyz15R0b;
        Tue,  3 Nov 2020 20:04:25 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 20:04:24 +0800
Subject: Re: [PATCH v2] iio: adc: rockchip_saradc: fix missing
 clk_disable_unprepare() on error in rockchip_saradc_resume
To:     Robin Murphy <robin.murphy@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Heiko Stuebner <heiko@sntech.de>
CC:     <linux-iio@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201103074909.195465-1-miaoqinglang@huawei.com>
 <50da9bf1-7317-b24b-9a87-e9dfb4e4a694@arm.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <c86c7e85-31ec-725f-ed75-563c804868c7@huawei.com>
Date:   Tue, 3 Nov 2020 20:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <50da9bf1-7317-b24b-9a87-e9dfb4e4a694@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



在 2020/11/3 19:11, Robin Murphy 写道:
> On 2020-11-03 07:49, Qinglang Miao wrote:
>> Fix the missing clk_disable_unprepare() of info->pclk
>> before return from rockchip_saradc_resume in the error
>> handling case when fails to prepare and enable info->clk.
>>
>> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/iio/adc/rockchip_saradc.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/rockchip_saradc.c 
>> b/drivers/iio/adc/rockchip_saradc.c
>> index 1f3d7d639..5eb566274 100644
>> --- a/drivers/iio/adc/rockchip_saradc.c
>> +++ b/drivers/iio/adc/rockchip_saradc.c
>> @@ -461,9 +461,10 @@ static int rockchip_saradc_resume(struct device 
>> *dev)
>>           return ret;
>>       ret = clk_prepare_enable(info->clk);
>> -    if (ret)
>> +    if (ret) {
>> +        clk_disable_unprepare(info->pclk);
>>           return ret;
> 
> No need to add braces, just replace this utterly pointless "early" 
> return ;)
> 
> Robin.
You are right Robin, thanks a lot! :D

I've sent a 'real' v2 patch based on your advice.
> 
>> -
>> +    }
>>       return ret;
>>   }
>>   #endif
>>
> .
