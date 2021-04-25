Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D938F36A5FE
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 11:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhDYJOt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 05:14:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17816 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJOt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 05:14:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FSj2N5KsKz7w4x;
        Sun, 25 Apr 2021 17:11:40 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Sun, 25 Apr 2021
 17:13:57 +0800
Subject: Re: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <prime.zeng@huawei.com>, <tiantao6@hisilicon.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
 <20210411152120.0c806bba@jic23-huawei> <20210424151455.0de017f4@jic23-huawei>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <9a5f9f2d-f9f4-434e-27be-1bce5af931e6@hisilicon.com>
Date:   Sun, 25 Apr 2021 17:13:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210424151455.0de017f4@jic23-huawei>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021/4/24 22:15, Jonathan Cameron wrote:
> On Sun, 11 Apr 2021 15:21:20 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Thu, 8 Apr 2021 19:38:09 +0800
>> Yicong Yang <yangyicong@hisilicon.com> wrote:
>>
>>> Some devm variants are implemented with devres_alloc() and devres_add()
>>> manually to only manage a single pointer. This can be simplified with
>>> devm_add_action_or_reset() which works the same. Simplify these functions.
>>>
>>> Yicong Yang (7):
>>>   iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
>>>   iio: buffer-dmaengine: simplify __devm_iio_dmaengine_buffer_free
>>>   iio: hw_consumer: simplify devm_iio_hw_consumer_alloc
>>>   iio: triggered-buffer: simplify devm_iio_triggered_buffer_setup_ext
>>>   iio: core: simplify some devm functions
>>>   iio: trigger: simplify __devm_iio_trigger_register
>>>   iio: inkern: simplify some devm functions  
>>
>> Nice set.  Note no rush for a v2 as IIO is effectively closed for the
>> coming merge window.  Hence these won't hit linux-next now until after
>> the merge window closes.
> 
> On second thoughts was just easier for me to make the minor tweaks and
> apply so I did that.
> 
> All applied to the togreg branch of iio.git and pushed out as testing
> for autobuilders etc to poke at.
> 

Thanks a lot! Sorry for didn't update, I have intended to send a v2 series after
the tree reopened. :)

Regards,
Yicong

> Thanks,
> 
> Jonathan
> 
>>
>> Thanks,
>>
>> Jonathan
>>
>>>
>>>  drivers/iio/adc/adi-axi-adc.c                      | 22 ++++----
>>>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 22 ++++----
>>>  drivers/iio/buffer/industrialio-hw-consumer.c      | 25 ++++-----
>>>  drivers/iio/buffer/industrialio-triggered-buffer.c | 19 ++-----
>>>  drivers/iio/industrialio-core.c                    | 43 ++++++---------
>>>  drivers/iio/industrialio-trigger.c                 | 18 ++-----
>>>  drivers/iio/inkern.c                               | 61 ++++++++--------------
>>>  7 files changed, 78 insertions(+), 132 deletions(-)
>>>   
>>
> 
> 
> .
> 

