Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD54C17D7E0
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 02:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCIBib (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Mar 2020 21:38:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726490AbgCIBib (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Mar 2020 21:38:31 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC89D6C0A121F7AC07DA;
        Mon,  9 Mar 2020 09:38:28 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Mar 2020
 09:38:20 +0800
Subject: Re: [PATCH -next] iio:ad7797: Use correct attribute_group
To:     Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
References: <20200302133249.23152-1-yuehaibing@huawei.com>
 <8d7a7062af94a3531dd519bd60fe26c8530c6a43.camel@analog.com>
 <20200307131026.39f55a61@archlinux>
CC:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <527d339d-fe32-1121-b83b-4b9385541c37@huawei.com>
Date:   Mon, 9 Mar 2020 09:38:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200307131026.39f55a61@archlinux>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020/3/7 21:10, Jonathan Cameron wrote:
> On Wed, 4 Mar 2020 06:35:28 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
>> On Mon, 2020-03-02 at 21:32 +0800, YueHaibing wrote:
>>> [External]
>>>
>>> It seems ad7797_attribute_group should be used in ad7797_info,
>>> according to commit ("iio:ad7793: Add support for the ad7796 and ad7797").  
>>
>> While the change looks good at first, I am thinking that this might introduce
>> another issue while fixing this one.
>>
>> It looks like the ad7797_attributes[] array may also require the
>> &iio_dev_attr_in_m_in_scale_available.dev_attr.attr attribute as well.
>> It looks like the available scales should be printed for AD7997 as well.
>>
>> That being said, this patch is fine as-is.
>> But it would require a patch [before-this-patch] to fix the ad7797_attributes
>> array.
>>
>> Something like this:
>>
>> static struct attribute *ad7797_attributes[] = {
>>         &iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
>> +       &iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
>>        NULL
>> };
>>
>> I'm hoping I'm right about this one. I sometimes don't notice things too well.
> 
> Agreed. Should have that addition as well.  If not we'll successfully fix
> one issue but drop a valid interface at the same time...
> 

Ok, will send v2 with this addtion, thanks!

> Thanks,
> 
> Jonathan
> 
>>
>>>
>>> Fixes: fd1a8b912841 ("iio:ad7793: Add support for the ad7796 and ad7797")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/iio/adc/ad7793.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
>>> index b747db9..e5691e3 100644
>>> --- a/drivers/iio/adc/ad7793.c
>>> +++ b/drivers/iio/adc/ad7793.c
>>> @@ -542,7 +542,7 @@ static const struct iio_info ad7797_info = {
>>>  	.read_raw = &ad7793_read_raw,
>>>  	.write_raw = &ad7793_write_raw,
>>>  	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
>>> -	.attrs = &ad7793_attribute_group,
>>> +	.attrs = &ad7797_attribute_group,
>>>  	.validate_trigger = ad_sd_validate_trigger,
>>>  };
>>>    
> 
> 
> .
> 

