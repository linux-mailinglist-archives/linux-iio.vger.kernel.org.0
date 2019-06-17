Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BD347796
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2019 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfFQB0O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 21:26:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18583 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727238AbfFQB0O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 21:26:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3281799FBA00CC102677;
        Mon, 17 Jun 2019 09:26:11 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Jun 2019
 09:26:05 +0800
Subject: Re: [PATCH] staging: iio: adt7316: Add missing include files
To:     Jonathan Cameron <jic23@kernel.org>
References: <20190614152846.28108-1-yuehaibing@huawei.com>
 <20190616141137.254a1291@archlinux>
CC:     <gregkh@linuxfoundation.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-iio@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <9732d7dc-a9a3-ee19-51fc-3aa8322423f3@huawei.com>
Date:   Mon, 17 Jun 2019 09:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190616141137.254a1291@archlinux>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2019/6/16 21:11, Jonathan Cameron wrote:
> On Fri, 14 Jun 2019 23:28:46 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> Fix build error:
>>
>> drivers/staging/iio/addac/adt7316.c: In function adt7316_store_update_DAC:
>> drivers/staging/iio/addac/adt7316.c:949:3: error: implicit declaration of
>>  function gpiod_set_value; did you mean gpio_set_value? [-Werror=implicit-function-declaration]
>>    gpiod_set_value(chip->ldac_pin, 0);
>>
>> drivers/staging/iio/addac/adt7316.c: In function adt7316_setup_irq:
>> drivers/staging/iio/addac/adt7316.c:1807:13: error: implicit declaration of
>>  function irqd_get_trigger_type; did you mean devm_iio_trigger_free? [-Werror=implicit-function-declaration]
>>   irq_type = irqd_get_trigger_type(irq_get_irq_data(chip->bus.irq));
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 7f6b6d553df7 ("Staging: iio: adt7316: Add all irq related code in adt7316_irq_setup()")
>> Fixes: c63460c4298f ("Staging: iio: adt7316: Use device tree data to set ldac_pin")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Hi yuehaibing,
> 
> You were second to send a fix for this. I've had it in my
> fixes branch since last week, but not done a pull request quite yet.
> I'll probably send it out later today.

Sorry, our robot report this again and I forgot this ...

> 
> https://patchwork.kernel.org/patch/10978301/
> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  drivers/staging/iio/addac/adt7316.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
>> index 37ce563..9d3d159 100644
>> --- a/drivers/staging/iio/addac/adt7316.c
>> +++ b/drivers/staging/iio/addac/adt7316.c
>> @@ -16,6 +16,8 @@
>>  #include <linux/i2c.h>
>>  #include <linux/rtc.h>
>>  #include <linux/module.h>
>> +#include <linux/irq.h>
>> +#include <linux/gpio/consumer.h>
>>  
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/events.h>
> 
> 
> .
> 

