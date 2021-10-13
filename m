Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9593442B2ED
	for <lists+linux-iio@lfdr.de>; Wed, 13 Oct 2021 04:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhJMC4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Oct 2021 22:56:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28922 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhJMC4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2021 22:56:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTcTJ4b8lzbn6b;
        Wed, 13 Oct 2021 10:50:12 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 10:54:37 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 10:54:37 +0800
Subject: Re: [PATCH] iio: buffer: Fix double-free in
 iio_buffers_alloc_sysfs_and_mask()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Jonathan Cameron" <jic23@kernel.org>
References: <20211012092513.1349295-1-yangyingliang@huawei.com>
 <CA+U=DsrHSwaiS7mT4rcHT_ZQwfPg+-Hwm-jkib11+m7W-VA_FQ@mail.gmail.com>
 <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <b0d08d06-31c2-934f-6279-f73df39c39b4@huawei.com>
Date:   Wed, 13 Oct 2021 10:54:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf+DHNxiP5HzsKzzh5hFmr20P8SzOTnLXAvhC5Vb6hzMA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2021/10/13 4:30, Andy Shevchenko wrote:
> On Tue, Oct 12, 2021 at 2:37 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
>> On Tue, Oct 12, 2021 at 12:18 PM Yang Yingliang
>> <yangyingliang@huawei.com> wrote:
>>> When __iio_buffer_alloc_sysfs_and_mask() failed, 'unwind_idx' should be
>>> set to 'i - 1' to prevent double-free when cleanup resources.
>>>
>>> BUG: KASAN: double-free or invalid-free in __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
>>> Call Trace:
>>>   kfree+0x117/0x4c0
>>>   __iio_buffer_free_sysfs_and_mask+0x32/0xb0 [industrialio]
>>>   iio_buffers_alloc_sysfs_and_mask+0x60d/0x1570 [industrialio]
>>>   __iio_device_register+0x483/0x1a30 [industrialio]
>>>   ina2xx_probe+0x625/0x980 [ina2xx_adc]
>>>
>> Makes sense.
>> Thanks for the catch.
>>
>> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> ...
>
>>>                  ret = __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev, i);
>>>                  if (ret) {
>>> -                       unwind_idx = i;
>>> +                       unwind_idx = i - 1;
>>>                          goto error_unwind_sysfs_and_mask;
> I prefer to see
>
> - for (; unwind_idx >= 0; unwind_idx--) {
> + while (unwind_idx--)
>
> instead.
With using while loop, 'unwind_idx = 
iio_dev_opaque->attached_buffers_cnt - 1;' need
be changed.
I think my change is clear and simple, do I need resend a new version 
with using while loop ?

Thanks,
Yang
>
>>>                  }
>>>          }
