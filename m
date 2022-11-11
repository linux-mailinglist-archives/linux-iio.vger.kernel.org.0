Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5820D625A35
	for <lists+linux-iio@lfdr.de>; Fri, 11 Nov 2022 13:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiKKMGZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Nov 2022 07:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiKKMF5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2022 07:05:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BBFF37
        for <linux-iio@vger.kernel.org>; Fri, 11 Nov 2022 04:05:48 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7y7g3P35zmVnW;
        Fri, 11 Nov 2022 20:05:03 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 20:05:18 +0800
Message-ID: <af061980-6409-1439-fe5c-d3ebcc8067cc@huawei.com>
Date:   Fri, 11 Nov 2022 20:05:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] iio: fix kobject_put warning in iio_device_register
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <jic23@kernel.org>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <liwei391@huawei.com>
References: <20221110132615.331454-1-zengheng4@huawei.com>
 <20221111113141.00000917@Huawei.com>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <20221111113141.00000917@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 2022/11/11 19:31, Jonathan Cameron wrote:
> On Thu, 10 Nov 2022 21:26:15 +0800
> Zeng Heng <zengheng4@huawei.com> wrote:
>
>> There is warning reported by kobject lib in kobject_put():
>>
>> kobject: '(null)' (00000000be81a546): is not initialized, yet kobject_put() is being called.
>> WARNING: CPU: 0 PID: 535 at lib/kobject.c:718 kobject_put+0x12c/0x180
>> Call Trace:
>>   cdev_device_add
>>   __iio_device_register
>>   __devm_iio_device_register
>>   tmp117_probe
>>
>> If don't need to register chardev for most of IIO devices,
>> we just register them with device_add() only, and use device_del()
>> to unregister them.
>
>
>> Otherwise, when device_add() fails in internal and calls kobject_put()
>> in error handling path, it would report warning because the device
>> never be registered as chardev and there is no release function for it.
>>
>> Fixes: 8ebaa3ff1e71 ("iio: core: register chardev only if needed")
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> Interesting corner case. The cdev_device_add() call is fine with
> !dev->devt which is what this code was taking advantage of. The exception
> as you have highlighted is the error path of device_add().
>
> So I think it should also cope with unwinding if device_add() fails
> and not be calling cdev_del()  Note that cdev_device_del() has the
> appropriate guards to be safe whether or not (dev->devt) is true.
>
> Perhaps change cdev_device_add() to have
>
> 	rc = device_add(dev);
> 	if (rc && dev->devt)
> 		cdev_del(cdev);
>
> 	return rc;

yes, I agree with your opinion about cdev_device_add(), which would be 
more flexible

for callers.

And I found there is existing patch trying to fix this out.

https://lore.kernel.org/lkml/Y1fmgCS7fuf%2FLQBc@kroah.com/

So just pass the patch.


Best Regards,

Zeng Heng

>> ---
>>   drivers/iio/industrialio-core.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 151ff3993354..f4f48bda07f7 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -1982,7 +1982,11 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>>   	/* assign device groups now; they should be all registered now */
>>   	indio_dev->dev.groups = iio_dev_opaque->groups;
>>   
>> -	ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
>> +	if (iio_dev_opaque->attached_buffers_cnt || iio_dev_opaque->event_interface)
>> +		ret = cdev_device_add(&iio_dev_opaque->chrdev, &indio_dev->dev);
>> +	else
>> +		ret = device_add(&indio_dev->dev);
>> +
>>   	if (ret < 0)
>>   		goto error_unreg_eventset;
>>   
>> @@ -2008,7 +2012,10 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>>   {
>>   	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>>   
>> -	cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
>> +	if (iio_dev_opaque->chrdev.kobj.state_initialized)
>> +		cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
>> +	else
>> +		device_del(&indio_dev->dev);
>>   
>>   	mutex_lock(&iio_dev_opaque->info_exist_lock);
>>   
