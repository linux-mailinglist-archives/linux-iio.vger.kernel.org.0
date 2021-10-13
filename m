Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0242BB52
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhJMJTT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Oct 2021 05:19:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28928 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbhJMJTS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Oct 2021 05:19:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTmyj18T8zbn7Q;
        Wed, 13 Oct 2021 17:12:45 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:17:10 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 17:17:09 +0800
Subject: Re: [PATCH] iio: buffer: Fix double-free in
 iio_buffers_alloc_sysfs_and_mask()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>
CC:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
 <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
 <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
 <61c28865036cd40a96f2d1bb4c27fbbb08c2d3a5.camel@perches.com>
 <CAHp75VfBXuMboFr6czRipXKfBpBNj8Syo9cvhiMXD7VaVaka+Q@mail.gmail.com>
 <fe8a022750e911159abcac979bada51940c03d72.camel@perches.com>
 <CAHp75Vdx1=q=5sNkn9o=mqnufxYiXnssmMJtXw9goFskGijc1w@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <04c752b5-3814-34d0-82e4-9d0d46af433f@huawei.com>
Date:   Wed, 13 Oct 2021 17:17:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vdx1=q=5sNkn9o=mqnufxYiXnssmMJtXw9goFskGijc1w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2021/10/13 4:58, Andy Shevchenko wrote:
> On Tue, Oct 12, 2021 at 8:55 PM Joe Perches <joe@perches.com> wrote:
>> On Tue, 2021-10-12 at 23:48 +0300, Andy Shevchenko wrote:
>>> On Tue, Oct 12, 2021 at 8:43 PM Joe Perches <joe@perches.com> wrote:
>>>> On Tue, 2021-10-12 at 23:30 +0300, Andy Shevchenko wrote:
>>>>> On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
>>>>> <ardeleanalex@gmail.com> wrote:
>>>>>> On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
>>>>>> <yangyingliang@huawei.com> wrote:
> ...
>
>>>>> I prefer to see
>>>>>
>>>>> - for (; unwind_idx >= 0; unwind_idx--) {
>>>>> + while (unwind_idx--)
>>>> Not the same code as unwind_idx would be decremented before entering
>>>> the code block.
>>> It's kinda cryptic what you are pointing out.
>> Not really,
> It's. It lacks the very same "additional" words to explain what you
> meant and why.
>
>>> What's needed additionally is to change
>>>
>>> - unwind_idx = iio_dev_opaque->attached_buffers_cnt - 1;
>>> + unwind_idx = i;
>> You left out that 'additional change' above from your reply.
> Yes, that's true, but it took some time to decrypt your message.
>
>>> Of course not. See above. The usual pattern is
>>>
>>>    while (i--)
>>>      do_clean_item(i);
>> Of course, but that's not what you replied.
>> I was merely pointing out that your reply included a logic change
>> converting a loop from for to while.
> I expect that developers actually think about the changes they do and
> double check what's proposed by reviewers. If they just copy'n'paste
> whatever others propose, I wouldn't take any patch from such a
> developer.
I think in alloc path is using for loop, and in error/free path also 
using for loop is better to read the code.
>
