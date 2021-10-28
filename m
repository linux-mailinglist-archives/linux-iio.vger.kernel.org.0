Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4476143E5BB
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJ1QGw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 12:06:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:48668 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJ1QGw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=eyq2aL0ppUjOjE9RjUfqvR3oA27tGGnS22rdI5Pt+VM=; b=EK8BlKI8dKds+A9rx4pkPUDTTm
        ZUbACmUs/5CKmz8G5BjaSwP8GhJsmCFaVpR0Wh7RW0+fHkZ+p1O4F2JdeL9UHhJ+lFOvWeqm38Vz7
        kQjMVz9IrDSZLYaggcLibn8VfGELjjG3yX+cWvGl8hAY4q3GGPZVENPcij1OtrpeO5uRwoNmUGCSf
        dehSxG4KUL7+e8+O8/DUh4njo3hk7yQC+Z5AEFigo7eyzqkmVD3W4RDfjgPK+Ym2k3tXzweX1Lddj
        FDxqS9eXOSTahgUaiuO9YCciy4ZxAhTScU8pw2cg5QP3S6AK+H44KuZkfy6lbgUbeCvvBPSthGSJl
        6d4e+vDA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mg7t8-000FYt-M6; Thu, 28 Oct 2021 18:04:22 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mg7t8-000DbY-Hj; Thu, 28 Oct 2021 18:04:22 +0200
Subject: Re: [PATCH 2/2] iio: trigger: Fix reference counting
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Fuzzey <mfuzzey@parkeon.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20211024092700.6844-1-lars@metafoo.de>
 <20211024092700.6844-2-lars@metafoo.de>
 <20211028151607.7ccb0b6c@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <41bc22f4-071e-9ede-bce2-2d3c9cdf0344@metafoo.de>
Date:   Thu, 28 Oct 2021 18:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211028151607.7ccb0b6c@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26336/Thu Oct 28 10:21:55 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/28/21 4:16 PM, Jonathan Cameron wrote:
> On Sun, 24 Oct 2021 11:27:00 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> In viio_trigger_alloc() device_initialize() is used to set the initial
>> reference count of the trigger to 1. Then another get_device() is called on
>> trigger. This sets the reference count to 2 before the trigger is returned.
>>
>> iio_trigger_free(), which is the matching API to viio_trigger_alloc(),
>> calls put_device() which decreases the reference count by 1. But the second
>> reference count acquired in viio_trigger_alloc() is never dropped.
>>
>> As a result the iio_trigger_release() function is never called and the
>> memory associated with the trigger is never freed.
>>
>> Since there is no reason for the trigger to start its lifetime with two
>> reference counts just remove the extra get_device() in
>> viio_trigger_alloc().
>>
>> Fixes: 5f9c035cae18 ("staging:iio:triggers. Add a reference get to the core for triggers.")
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> I fully agree the current code is wrong, but we really should be using
> device_put() in the error path after device_initialize() has been called.
>
> There are multiple places where we currently do this wrong in IIO but this particular
> one looks like a local fix would be safe.
> Worth doing that in the same patch at this one given it's all about reference
> counting logic being wrong?  If not, we can do it as a separate follow up patch.
I already have that patch. Just waiting for this to be applied since it 
has a dependency.
>
> Jonathan
>
>
>> ---
>> I'm a bit unsure about the fixes tag. I've looked at the IIO tree at the
>> point when this was introduced and I believe it was incorrect even back
>> then.
>>
>> But we also had a few drivers that directly assigned the indio_dev->trig
>> without getting an extra reference. So these two bugs, one in the core, one
>> in the drivers sort of even out. Except that iio_trigger_get() also gets a
>> reference to the drivers module and iio_trigger_put() releases it again. So
>> with the missing iio_trigger_get() there is still the problem that, even
>> though the device references balance out, there is a module reference count
>> imbalance.
>> ---
>>   drivers/iio/industrialio-trigger.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
>> index b23caa2f2aa1..93990ff1dfe3 100644
>> --- a/drivers/iio/industrialio-trigger.c
>> +++ b/drivers/iio/industrialio-trigger.c
>> @@ -556,7 +556,6 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>>   		irq_modify_status(trig->subirq_base + i,
>>   				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
>>   	}
>> -	get_device(&trig->dev);
>>   
>>   	return trig;
>>   


