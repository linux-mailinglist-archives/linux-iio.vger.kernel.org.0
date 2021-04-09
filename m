Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935E1359F82
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 15:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDINGQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 09:06:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15657 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDINGP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 09:06:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGyww3jPPzpWcK;
        Fri,  9 Apr 2021 21:03:12 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 21:05:50 +0800
Subject: Re: [PATCH 5/7] iio: core: simplify some devm functions
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, Tian Tao <tiantao6@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <1617881896-3164-6-git-send-email-yangyicong@hisilicon.com>
 <CA+U=DspZCGVjFxB0YH7OAPBKhFAKz=a9Q=O7xW-Xu4BPZKC=pA@mail.gmail.com>
 <9f1257a2-a69e-acbc-8c0a-2d2157274225@hisilicon.com>
 <CAHp75Ve_JwGeruZeZnVk3pXXmETVERQTdR2+MSPX=Y75+nQLcw@mail.gmail.com>
 <94bbe851-1f09-7099-38ac-2b6fcb056349@hisilicon.com>
 <CAHp75Ve7+-_=nsUjn5e3tR-37Fg622_PSPyR5CrgUWGxk6zPKA@mail.gmail.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <59831f7e-106b-013b-818d-8411777eed85@hisilicon.com>
Date:   Fri, 9 Apr 2021 21:05:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve7+-_=nsUjn5e3tR-37Fg622_PSPyR5CrgUWGxk6zPKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021/4/9 17:55, Andy Shevchenko wrote:
> On Fri, Apr 9, 2021 at 12:42 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>> On 2021/4/9 17:19, Andy Shevchenko wrote:
>>> On Fri, Apr 9, 2021 at 10:22 AM Yicong Yang <yangyicong@hisilicon.com> wrote:
>>>> On 2021/4/8 21:09, Alexandru Ardelean wrote:
>>>>> On Thu, Apr 8, 2021 at 2:41 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
> 
> ...
> 
>>> Actually Alexandru has a good point. Compare the pieces I left above.
>>>
>>
>> a little different from my perspective when I did this.
>>
>> previously:
>>
>> -       ptr = devres_alloc(devm_iio_device_release, sizeof(*ptr),
>> -                          GFP_KERNEL);
>> -       if (!ptr)
>> -               return NULL;
>>
>> if devres_alloc() failure we return NULL.
>>
>>
>>         iio_dev = iio_device_alloc(parent, sizeof_priv);
>> -       if (iio_dev) {
>> -               *ptr = iio_dev;
>> -               devres_add(parent, ptr);
>> -       } else {
>> -               devres_free(ptr);
>> -       }
>>
>>         return iio_dev;
>>
>> if iio_device_alloc() failed, we return what it returns.
>>
>> now we remove devres_alloc() and stay iio_device_alloc(), so I just
>> keep to return iio_dev.
>>
>> but actually iio_device_alloc() will return NULL at failure. :)
>> so return NULL here is definitely correct. i'll change to that if
>> it's recommended.
> 
> Confusing here (in your case) is that:
> 
> if (!FOO)
>  return BAR;
> 
> ...
> 
> return BAR;
> 
> I.e. twice returning BAR for different occasions. This makes
> additional cognitive work and decrease readability / maintainability
> of the code.
> 
> I.o.w., yes, it's preferred.
> 

got it. will return NULL and will check if other patches in this series
met the same condition.

thanks.

