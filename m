Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB935C06F
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbhDLJNT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 05:13:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16570 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240615AbhDLJKr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 05:10:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJjZP2nSrz1BGg3;
        Mon, 12 Apr 2021 17:08:13 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 17:10:17 +0800
Subject: Re: [PATCH 1/7] iio: adc: adi-axi-adc: simplify
 devm_adi_axi_adc_conv_register
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
 <20210411151215.5d3e5494@jic23-huawei>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <e58b460c-33c7-e544-539c-2d25f96fa17a@hisilicon.com>
Date:   Mon, 12 Apr 2021 17:10:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210411151215.5d3e5494@jic23-huawei>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021/4/11 22:12, Jonathan Cameron wrote:
> On Thu, 8 Apr 2021 19:38:10 +0800
> Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
>> Use devm_add_action_or_reset() instead of devres_alloc() and
>> devres_add(), which works the same. This will simplify the
>> code. There is no functional changes.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/iio/adc/adi-axi-adc.c | 22 +++++++++-------------
>>  1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
>> index 9109da2..575a63f 100644
>> --- a/drivers/iio/adc/adi-axi-adc.c
>> +++ b/drivers/iio/adc/adi-axi-adc.c
>> @@ -210,29 +210,25 @@ static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
>>  	kfree(cl);
>>  }
>>  
>> -static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
>> +static void devm_adi_axi_adc_conv_release(void *conv)
>>  {
>> -	adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
>> +	adi_axi_adc_conv_unregister(conv);
>>  }
>>  
>>  struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
>>  							size_t sizeof_priv)
>>  {
>> -	struct adi_axi_adc_conv **ptr, *conv;
>> -
>> -	ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
>> -			   GFP_KERNEL);
>> -	if (!ptr)
>> -		return ERR_PTR(-ENOMEM);
>> +	struct adi_axi_adc_conv *conv;
>> +	int ret;
>>  
>>  	conv = adi_axi_adc_conv_register(dev, sizeof_priv);
>> -	if (IS_ERR(conv)) {
>> -		devres_free(ptr);
>> +	if (IS_ERR(conv))
>>  		return ERR_CAST(conv);
> 
> Is that ERR_CAST() needed here?  conv is already of the
> right type so we don't need to cast it to a void * and back gain.
> Obviously was there before an not needed either, but might as well
> tidy it up whilst we are here!

sure. thanks for the hint. I didn't notice this. will drop the ERR_CAST.

thanks!

> 
> Thanks,
> 
> Jonathan
> 
> 
> 
>> -	}
>>  
>> -	*ptr = conv;
>> -	devres_add(dev, ptr);
>> +	ret = devm_add_action_or_reset(dev, devm_adi_axi_adc_conv_release,
>> +				       conv);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>>  
>>  	return conv;
>>  }
> 
> 
> .
> 

