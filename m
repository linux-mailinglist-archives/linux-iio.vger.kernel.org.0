Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83721433898
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhJSOqT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 10:46:19 -0400
Received: from vern.gendns.com ([98.142.107.122]:49254 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhJSOqT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 10:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L8VL5ArDykffnlkPO1OTtII+oPNsIDaz69+QNBhUbVs=; b=iJ1ubvRJ/ags9sMFu4AeSgHr/p
        Y0u1OuvMpg0k/opyYilV4m683rxNedxHyL2HrCfYcKorNglnq/3ZRqsMnliSyYOUslHNgW4Ae5c/3
        N6+RSjPSWsNSUJC/OwP+4bn6J4ZuEpLdhJi4nd7BFjwkSdN+7sKVtSHafi52Ez1ziaQ2RCg1tdMno
        rCnN7KhzL+3tQa6CHPtulOhHVL4sofsqgyUirzYYS9ylwRWZjRMQjhJwWaGD8029BNzzXn+agaYC2
        alEJX97pCkf5qsq1UOxh5Zo5QW56TPPlPyZP1OZV5vKONhsdteGMOGBT9WK1a+rzoUf1TfzMLdSJ1
        4oWpmaHA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39122 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mcqLP-0000Qo-SO; Tue, 19 Oct 2021 10:44:05 -0400
Subject: Re: [PATCH] counter: drop chrdev_lock
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
 <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
 <YW5rVLrbrVVJ75SY@shinobu> <YW5uxIQ1WuW66cf0@kroah.com>
 <YW5xUtWdvW5zHFx5@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <c0a4cd67-6046-b06d-c33c-c0f3374d0b52@lechnology.com>
Date:   Tue, 19 Oct 2021 09:44:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW5xUtWdvW5zHFx5@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/19/21 2:18 AM, William Breathitt Gray wrote:
> On Tue, Oct 19, 2021 at 09:07:48AM +0200, Greg KH wrote:
>> On Tue, Oct 19, 2021 at 03:53:08PM +0900, William Breathitt Gray wrote:
>>> On Mon, Oct 18, 2021 at 11:03:49AM -0500, David Lechner wrote:
>>>> On 10/18/21 4:14 AM, William Breathitt Gray wrote:
>>>>> On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
>>>>>> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
>>>>>> index 1ccd771da25f..7bf8882ff54d 100644
>>>>>> --- a/drivers/counter/counter-sysfs.c
>>>>>> +++ b/drivers/counter/counter-sysfs.c
>>>>>> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write(struct counter_device *counter,
>>>>>>    					   u64 val)
>>>>>>    {
>>>>>>    	DECLARE_KFIFO_PTR(events, struct counter_event);
>>>>>> -	int err = 0;
>>>>>> -
>>>>>> -	/* Ensure chrdev is not opened more than 1 at a time */
>>>>>> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
>>>>>> -		return -EBUSY;
>>>>>> +	int err;
>>>>>>    
>>>>>>    	/* Allocate new events queue */
>>>>>>    	err = kfifo_alloc(&events, val, GFP_KERNEL);
>>>>>>    	if (err)
>>>>>> -		goto exit_early;
>>>>>> +		return err;
>>>>>>    
>>>>>>    	/* Swap in new events queue */
>>>>>>    	kfifo_free(&counter->events);
>>>>>>    	counter->events.kfifo = events.kfifo;
>>>>>
>>>>> Do we need to hold the events_lock mutex here for this swap in case
>>>>> counter_chrdev_read() is in the middle of reading the kfifo to
>>>>> userspace, or do the kfifo macros already protect us from a race
>>>>> condition here?
>>>>>
>>>> Another possibility might be to disallow changing the size while
>>>> events are enabled. Otherwise, we also need to protect against
>>>> write after free.
>>>>
>>>> I considered this:
>>>>
>>>> 	swap(counter->events.kfifo, events.kfifo);
>>>> 	kfifo_free(&events);
>>>>
>>>> But I'm not sure that would be safe enough.
>>>
>>> I think it depends on whether it's safe to call kfifo_free() while other
>>> kfifo_*() calls are executing. I suspect it is not safe because I don't
>>> think kfifo_free() waits until all kfifo read/write operations are
>>> finished before freeing -- but if I'm wrong here please let me know.
>>>
>>> Because of that, will need to hold the counter->events_lock afterall so
>>> that we don't modify the events fifo while a kfifo read/write is going
>>> on, lest we suffer an address fault. This can happen regardless of
>>> whether you swap before or after the kfifo_free() because the old fifo
>>> address could still be in use within those uncompleted kfifo_*() calls
>>> if they were called before the swap but don't complete before the
>>> kfifo_free().
>>>
>>> So we have a problem now that I think you have already noticed: the
>>> kfifo_in() call in counter_push_events() also needs protection, but it's
>>> executing within an interrupt context so we can't try to lock a mutex
>>> lest we end up sleeping.
>>>
>>> One option we have is as you suggested: we disallow changing size while
>>> events are enabled. However, that will require us to keep track of when
>>> events are disabled and implement a spinlock to ensure that we don't
>>> disable events in the middle of a kfifo_in().
>>>
>>> Alternatively, we could change events_lock to a spinlock and use it to
>>> protect all these operations on the counter->events fifo. Would this
>>> alternative be a better option so that we avoid creating another
>>> separate lock?
>>
>> I would recommend just having a single lock here if at all possible,
>> until you determine that there a performance problem that can be
>> measured that would require it to be split up.
>>
>> thanks,
>>
>> greg k-h
> 
> All right let's go with a single events_lock spinlock then. David, if
> you make those changes and submit a v2, I'll be okay with this patch and
> can provide my ack for it.
> 

We can't use a spin lock for everything since there are operations
that can sleep that need to be in the critical sections. Likewise,
we can't use a mutex for everything since some critical sections
are in interrupt handlers. But, I suppose we can try combining
the existing mutexes. Since the kfifo is accessed from both
contexts, it seems like it still needs more consideration than
just a mutex or a spin lock, e.g. if events are enabled, don't
allow swapping out the kfifo buffer.

