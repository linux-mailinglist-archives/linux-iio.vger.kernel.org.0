Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2970335968A
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhDIHj1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 03:39:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15642 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhDIHj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 03:39:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGqgs0wQFzpWr4;
        Fri,  9 Apr 2021 15:36:25 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 15:39:04 +0800
Subject: Re: [PATCH 1/7] iio: adc: adi-axi-adc: simplify
 devm_adi_axi_adc_conv_register
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, Tian Tao <tiantao6@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
 <CA+U=Dsqia_QVcgJTWo_3s07H-FeZ3xmoE2XVCROFMdrP7iNsiw@mail.gmail.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <3349a264-b8a4-7c8b-1e13-8129ea7b69c5@hisilicon.com>
Date:   Fri, 9 Apr 2021 15:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CA+U=Dsqia_QVcgJTWo_3s07H-FeZ3xmoE2XVCROFMdrP7iNsiw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021/4/8 21:04, Alexandru Ardelean wrote:
> On Thu, Apr 8, 2021 at 2:42 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>>
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
>>         kfree(cl);
>>  }
>>
>> -static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
>> +static void devm_adi_axi_adc_conv_release(void *conv)
>>  {
>> -       adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
> 
> On a second pass, I'm wondering if this requires a cast like
> 
> static void devm_adi_axi_adc_conv_release(void *data)
> {
>        struct adi_axi_adc_conv *conv = data;
> 
> If the compiler doesn't complain, that I'm fine
> 

no warn noticed when make W=1.

>> +       adi_axi_adc_conv_unregister(conv);
>>  }
>>
>>  struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
>>                                                         size_t sizeof_priv)
>>  {
>> -       struct adi_axi_adc_conv **ptr, *conv;
>> -
>> -       ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
>> -                          GFP_KERNEL);
>> -       if (!ptr)
>> -               return ERR_PTR(-ENOMEM);
>> +       struct adi_axi_adc_conv *conv;
>> +       int ret;
>>
>>         conv = adi_axi_adc_conv_register(dev, sizeof_priv);
>> -       if (IS_ERR(conv)) {
>> -               devres_free(ptr);
>> +       if (IS_ERR(conv))
>>                 return ERR_CAST(conv);
>> -       }
>>
>> -       *ptr = conv;
>> -       devres_add(dev, ptr);
>> +       ret = devm_add_action_or_reset(dev, devm_adi_axi_adc_conv_release,
>> +                                      conv);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>>
>>         return conv;
>>  }
>> --
>> 2.8.1
>>
> 
> .
> 

