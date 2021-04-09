Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789CD359644
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 09:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhDIHWP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 03:22:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15994 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhDIHWO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 03:22:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGqJh3jbvzvS38;
        Fri,  9 Apr 2021 15:19:48 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 15:21:53 +0800
Subject: Re: [PATCH 5/7] iio: core: simplify some devm functions
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, Tian Tao <tiantao6@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
 <CA+U=DspZCGVjFxB0YH7OAPBKhFAKz=a9Q=O7xW-Xu4BPZKC=pA@mail.gmail.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <9f1257a2-a69e-acbc-8c0a-2d2157274225@hisilicon.com>
Date:   Fri, 9 Apr 2021 15:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CA+U=DspZCGVjFxB0YH7OAPBKhFAKz=a9Q=O7xW-Xu4BPZKC=pA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021/4/8 21:09, Alexandru Ardelean wrote:
> On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>>
>> Use devm_add_action_or_reset() instead of devres_alloc() and
>> devres_add(), which works the same. This will simplify the
>> code. There is no functional changes.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/iio/industrialio-core.c | 43 +++++++++++++++--------------------------
>>  1 file changed, 16 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 7db761a..2dfbed3 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1627,9 +1627,9 @@ void iio_device_free(struct iio_dev *dev)
>>  }
>>  EXPORT_SYMBOL(iio_device_free);
>>
>> -static void devm_iio_device_release(struct device *dev, void *res)
>> +static void devm_iio_device_release(void *iio_dev)
>>  {
>> -       iio_device_free(*(struct iio_dev **)res);
>> +       iio_device_free(iio_dev);
>>  }
>>
>>  /**
>> @@ -1645,20 +1645,17 @@ static void devm_iio_device_release(struct device *dev, void *res)
>>   */
>>  struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
>>  {
>> -       struct iio_dev **ptr, *iio_dev;
>> -
>> -       ptr = devres_alloc(devm_iio_device_release, sizeof(*ptr),
>> -                          GFP_KERNEL);
>> -       if (!ptr)
>> -               return NULL;
>> +       struct iio_dev *iio_dev;
>> +       int ret;
>>
>>         iio_dev = iio_device_alloc(parent, sizeof_priv);
>> -       if (iio_dev) {
>> -               *ptr = iio_dev;
>> -               devres_add(parent, ptr);
>> -       } else {
>> -               devres_free(ptr);
>> -       }
>> +       if (!iio_dev)
>> +               return iio_dev;
> 
> This is correct.
> But the preference is usually:
>         if (!iio_dev)
>             return NULL;
> 

since it returned iio_dev when failure before, so i just keep as is

>> +
>> +       ret = devm_add_action_or_reset(parent, devm_iio_device_release,
>> +                                      iio_dev);
>> +       if (ret)
>> +               return ERR_PTR(ret);
>>
>>         return iio_dev;
>>  }
>> @@ -1889,29 +1886,21 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>>  }
>>  EXPORT_SYMBOL(iio_device_unregister);
>>
>> -static void devm_iio_device_unreg(struct device *dev, void *res)
>> +static void devm_iio_device_unreg(void *indio_dev)
>>  {
>> -       iio_device_unregister(*(struct iio_dev **)res);
>> +       iio_device_unregister(indio_dev);
>>  }
>>
>>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>>                                struct module *this_mod)
>>  {
>> -       struct iio_dev **ptr;
>>         int ret;
>>
>> -       ptr = devres_alloc(devm_iio_device_unreg, sizeof(*ptr), GFP_KERNEL);
>> -       if (!ptr)
>> -               return -ENOMEM;
>> -
>> -       *ptr = indio_dev;
>>         ret = __iio_device_register(indio_dev, this_mod);
>> -       if (!ret)
>> -               devres_add(dev, ptr);
>> -       else
>> -               devres_free(ptr);
>> +       if (ret)
>> +               return ret;
>>
>> -       return ret;
>> +       return devm_add_action_or_reset(dev, devm_iio_device_unreg, indio_dev);
>>  }
>>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>>
>> --
>> 2.8.1
>>
> 
> .
> 

