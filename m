Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E68642E181
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhJNSnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 14:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52183 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231865AbhJNSnT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 14:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkJXoOMIi8EjDQ9VULG+D+wAgGPEco7K9r5xEARHX3o=;
        b=D2IlXZH/ZQ7G/dzprAAO4GP27lUPfwnKgf+Go7vNM3qFdEMm9yY56oCPF1FiF2vl741hk5
        rkI9qi2tH10dvRR9M9Tg6urLXp+JmZMjMu3Ku/0oUHlpu7z3eRodgOBCBQy+RMuXPdqfIx
        R+7lqdmBjor6Ce3XROEfXgBl28/LHEc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-X7Za29m2MlK1obXadXgzSw-1; Thu, 14 Oct 2021 14:41:13 -0400
X-MC-Unique: X7Za29m2MlK1obXadXgzSw-1
Received: by mail-ed1-f70.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so5936886edj.21
        for <linux-iio@vger.kernel.org>; Thu, 14 Oct 2021 11:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NkJXoOMIi8EjDQ9VULG+D+wAgGPEco7K9r5xEARHX3o=;
        b=Oo1oBLklvXkKx3nF1iIIIENNa+5jL+KRr7T6ZscIStnEiR4N6DmL8pOGFwjIFC5nnw
         fwkQtRePZtvAEWe0llMEKUJz6hMZOlCpnp0vkrIRKw8LtmI6okAy1roFEOeOJxO9l1pI
         98di+mIyaHBBPJ5l0qAdvc1X+Bm7wbaqqhQR4sVeV8hARg+MStNJyXKgN5v/o9ik03gF
         JwbIHTAYpdOVEKpQorOwyLe5NMPXfO4c8TlYJo9n+0U4r9/h6Fn0RBKMq51kbeaSTysg
         PPxAcUnKS9F/MUcwchPFZ2LpHthaIp8snPzjfEgWGkbynTb6qZcijRd/jZB5m0IkCdUJ
         2ISQ==
X-Gm-Message-State: AOAM530MdTc5DQpeKbV/Ho2gd0haDGEb1fYXypbvDjnwx71g5I2wz3W3
        BVdnjTh1odjmTyy6oBQn2FLFKeIwRVjwwXi8O2ESZfZTVXa5Pe5RwZ+bGs/jzF7cw9st8tRnoc5
        vQ57dYEjDR1vqYNgyQbTI
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr10924813edz.328.1634236871758;
        Thu, 14 Oct 2021 11:41:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiJ8B3k49LbOuRzfkEKGACr17b5r1Wg3RTgh4UETO5Oo+dvcHpHQDb72HyHT7ZNXQCEdjvZA==
X-Received: by 2002:a05:6402:848:: with SMTP id b8mr10924795edz.328.1634236871583;
        Thu, 14 Oct 2021 11:41:11 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m6sm2761819ejl.42.2021.10.14.11.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 11:41:11 -0700 (PDT)
Subject: Re: [PATCH] iio: accel: kxcjk-1013: Fix possible memory leak in probe
 and remove
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, andriy.shevchenko@linux.intel.com,
        ddvlad@gmail.com
References: <20211014035338.3750416-1-yangyingliang@huawei.com>
 <1a3a5582-51b0-4c58-ad6a-a58025054128@redhat.com>
 <20211014183833.70b49732@jic23-huawei>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <63921363-44af-1196-9d76-0978da230d67@redhat.com>
Date:   Thu, 14 Oct 2021 20:41:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211014183833.70b49732@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/14/21 7:38 PM, Jonathan Cameron wrote:
> On Thu, 14 Oct 2021 10:20:34 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 10/14/21 5:53 AM, Yang Yingliang wrote:
>>> When ACPI type is ACPI_SMO8500, the data->dready_trig will not be set, the
>>> memory allocated by iio_triggered_buffer_setup() will not be freed, and cause
>>> memory leak as follows:
>>>
>>> unreferenced object 0xffff888009551400 (size 512):
>>>   comm "i2c-SMO8500-125", pid 911, jiffies 4294911787 (age 83.852s)
>>>   hex dump (first 32 bytes):
>>>     02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>     00 00 00 00 00 00 00 00 20 e2 e5 c0 ff ff ff ff  ........ .......
>>>   backtrace:
>>>     [<0000000041ce75ee>] kmem_cache_alloc_trace+0x16d/0x360
>>>     [<000000000aeb17b0>] iio_kfifo_allocate+0x41/0x130 [kfifo_buf]
>>>     [<000000004b40c1f5>] iio_triggered_buffer_setup_ext+0x2c/0x210 [industrialio_triggered_buffer]
>>>     [<000000004375b15f>] kxcjk1013_probe+0x10c3/0x1d81 [kxcjk_1013]
>>>     [<0000000020115b9a>] i2c_device_probe+0xa31/0xbe0
>>>     [<00000000d9f581a6>] really_probe+0x299/0xc30
>>>     [<00000000c6c16cde>] __driver_probe_device+0x357/0x500
>>>     [<00000000909852a1>] driver_probe_device+0x4e/0x140
>>>     [<000000008419ba53>] __device_attach_driver+0x257/0x340
>>>     [<00000000533bb466>] bus_for_each_drv+0x166/0x1e0
>>>     [<000000005bf45d75>] __device_attach+0x272/0x420
>>>     [<0000000075220311>] bus_probe_device+0x1eb/0x2a0
>>>     [<0000000015587e85>] device_add+0xbf0/0x1f90
>>>     [<0000000086901b9e>] i2c_new_client_device+0x622/0xb20
>>>     [<000000000865ca18>] new_device_store+0x1fa/0x420
>>>     [<0000000059a3d183>] dev_attr_store+0x58/0x80
>>>
>>> Fix it by remove data->dready_trig condition in probe and remove.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Fixes: a25691c1f967 ("iio: accel: kxcjk1013: allow using an external trigger")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>  
>>
>> Hmm, wouldn't the right fix be to also move the
>> iio_triggered_buffer_setup() call to inside the:
>>
>> 	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
>> 	}
>>
>> block ?
>>
>> Jonathan (jic23) can you take a look at this, to me it seems that having
>> a triggered buffer allocated without any triggers is not useful ?
> 
> It can use another trigger not supplied by this particular device.
> e.g. sysfs or hrtimer trigger.  This is common for cases where
> we may or may not have an irq wired and the validate_* callbacks are
> not provided (which would indicate we had to use the device's own trigger).

Ok, thank you for clarifying this.

With that resolved, this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


>>> ---
>>>  drivers/iio/accel/kxcjk-1013.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>>> index a51fdd3c9b5b..24c9387c2968 100644
>>> --- a/drivers/iio/accel/kxcjk-1013.c
>>> +++ b/drivers/iio/accel/kxcjk-1013.c
>>> @@ -1595,8 +1595,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
>>>  	return 0;
>>>  
>>>  err_buffer_cleanup:
>>> -	if (data->dready_trig)
>>> -		iio_triggered_buffer_cleanup(indio_dev);
>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>>  err_trigger_unregister:
>>>  	if (data->dready_trig)
>>>  		iio_trigger_unregister(data->dready_trig);
>>> @@ -1618,8 +1617,8 @@ static int kxcjk1013_remove(struct i2c_client *client)
>>>  	pm_runtime_disable(&client->dev);
>>>  	pm_runtime_set_suspended(&client->dev);
>>>  
>>> +	iio_triggered_buffer_cleanup(indio_dev);
>>>  	if (data->dready_trig) {
>>> -		iio_triggered_buffer_cleanup(indio_dev);
>>>  		iio_trigger_unregister(data->dready_trig);
>>>  		iio_trigger_unregister(data->motion_trig);
>>>  	}
>>>   
>>
> 

