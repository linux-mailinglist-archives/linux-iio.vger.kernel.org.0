Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD43D326AAB
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 01:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhB0APS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Feb 2021 19:15:18 -0500
Received: from vern.gendns.com ([98.142.107.122]:59606 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhB0APR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 26 Feb 2021 19:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s16MGPq7cmMC6iNOsv2GUH6wTNHOr8Jp0D2VwkY95zg=; b=WdqLnQAWYjusoziOcrrjFj5HhY
        0rcJETlMmTmJvyP9fOd9mmWivdwn6cj4K7n21WeuP2UAmM4/S3kbjJX7y8PrCcaX2OYkI83bhQcBv
        dxdu44MxZvXI7GtgInJpnBX0pkWpcKq220NjdJzRwLCN0mGHmagQr4rEq4DJdJg/IsfffblTgxBZN
        a6jCAnkL7blx66u1Vg0xESqYw/iXJyi9BgzvOGCn1UmBdOoQfWfNfnNSGB72jUz9TbxnQbtGmeprP
        jV/tdANz/7VPPgO0iuf9sD/Q8zkO6Cr/TAybOHKkf33vc6Yod1BryFqhML3+qwZYanIPZWLYwHKyF
        j11p8JGQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52154 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1lFnFg-0001uQ-IX; Fri, 26 Feb 2021 19:14:32 -0500
Subject: Re: [PATCH v8 20/22] counter: Implement events_queue_size sysfs
 attribute
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
 <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
 <20210214181146.66d43da7@archlinux> <YC5CMLuKnXbkZond@shinobu>
 <20210221155140.3e1ef13c@archlinux> <YDg65OmLa05g53qc@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <37ea96a2-d4a1-7d4c-a68a-8dc82896e86c@lechnology.com>
Date:   Fri, 26 Feb 2021 18:14:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDg65OmLa05g53qc@shinobu>
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

On 2/25/21 6:03 PM, William Breathitt Gray wrote:
> On Sun, Feb 21, 2021 at 03:51:40PM +0000, Jonathan Cameron wrote:
>> On Thu, 18 Feb 2021 19:32:16 +0900
>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>>
>>> On Sun, Feb 14, 2021 at 06:11:46PM +0000, Jonathan Cameron wrote:
>>>> On Fri, 12 Feb 2021 21:13:44 +0900
>>>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>>>>    
>>>>> The events_queue_size sysfs attribute provides a way for users to
>>>>> dynamically configure the Counter events queue size for the Counter
>>>>> character device interface. The size is in number of struct
>>>>> counter_event data structures. The number of elements will be rounded-up
>>>>> to a power of 2 due to a requirement of the kfifo_alloc function called
>>>>> during reallocation of the queue.
>>>>>
>>>>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
>>>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>>>>> ---
>>>>>   Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
>>>>>   drivers/counter/counter-chrdev.c            | 23 +++++++++++++++++++
>>>>>   drivers/counter/counter-chrdev.h            |  2 ++
>>>>>   drivers/counter/counter-sysfs.c             | 25 +++++++++++++++++++++
>>>>>   4 files changed, 58 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
>>>>> index 847e96f19d19..f6cb2a8b08a7 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-counter
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-counter
>>>>> @@ -212,6 +212,14 @@ Description:
>>>>>   		both edges:
>>>>>   			Any state transition.
>>>>>   
>>>>> +What:		/sys/bus/counter/devices/counterX/events_queue_size
>>>>> +KernelVersion:	5.13
>>>>> +Contact:	linux-iio@vger.kernel.org
>>>>> +Description:
>>>>> +		Size of the Counter events queue in number of struct
>>>>> +		counter_event data structures. The number of elements will be
>>>>> +		rounded-up to a power of 2.
>>>>> +
>>>>>   What:		/sys/bus/counter/devices/counterX/name
>>>>>   KernelVersion:	5.2
>>>>>   Contact:	linux-iio@vger.kernel.org
>>>>> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
>>>>> index 16f02df7f73d..53eea894e13f 100644
>>>>> --- a/drivers/counter/counter-chrdev.c
>>>>> +++ b/drivers/counter/counter-chrdev.c
>>>>> @@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_device *const counter)
>>>>>   	cdev_del(&counter->chrdev);
>>>>>   }
>>>>>   
>>>>> +int counter_chrdev_realloc_queue(struct counter_device *const counter,
>>>>> +				 size_t queue_size)
>>>>> +{
>>>>> +	int err;
>>>>> +	DECLARE_KFIFO_PTR(events, struct counter_event);
>>>>> +	unsigned long flags;
>>>>> +
>>>>> +	/* Allocate new events queue */
>>>>> +	err = kfifo_alloc(&events, queue_size, GFP_ATOMIC);
>>>>
>>>> Is there any potential for losing events?
>>>
>>> We take the events_list_lock down below so we're safe against missing an
>>> event, but past events currently unread in the queue will be lost.
>>>
>>> Shortening the size of the queue is inherently a destructive process if
>>> we have more events in the current queue than can fit in the new queue.
>>> Because we a liable to lose some events in such a case, I think it's
>>> best to keep the behavior of this reallocation consistent and have it
>>> provide a fresh empty queue every time, as opposed to sometimes dropping
>>> events and sometimes not.
>>>
>>> I also suspect an actual user would be setting the size of their queue
>>> to the required amount before they begin watching events, rather than
>>> adjusting it sporadically during a live operation.
>>>
>>
>> Absolutely agree.   As such I wonder if you are better off enforcing this
>> behaviour?  If the cdev is open for reading, don't allow the fifo to be
>> resized.
>>
>> Jonathan
> 
> I can't really think of a good reason not to, so let's enforce it: if
> the cdev is open, then we'll return an EINVAL if the user attempts to
> resize the queue.
> 
> What is a good way to check for this condition? Should I just call
> kref_read() and see if it's greater than 1? For example, in
> counter_chrdev_realloc_queue():
> 
> 	if (kref_read(&counter->dev.kobj.kref) > 1)
> 		return -EINVAL;
> 
> William Breathitt Gray
> 

Wouldn't EBUSY make more sense?
