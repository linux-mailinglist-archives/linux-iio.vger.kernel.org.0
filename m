Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76694432390
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhJRQQ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 12:16:28 -0400
Received: from vern.gendns.com ([98.142.107.122]:40362 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhJRQQ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 12:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/di40QAvs9FSfvQLcMkMeDro61kriZm8xprT8l0yyOY=; b=W95MTsvlN2nrvkU1q88Eu+flWa
        v2I3XyUK9dnL9wNwZl6dGw25gPF88XvMe22UBuHQkS2YjcVH4IfiXkBNUzPqD/2q3E79W2Q7rS+zR
        immqMWJr1tJbHKBvueV3ksG+ZGY5YCD9rWO01fE8Qq32+k+Cjc0byE4G9pTzECXNpttc+ev8lFozE
        GVl+WC7UFtkKXJBeGt+XQvsT85GkthxYELpU58LINKmko1wJlUih8X74JDy8DwKcx+D6jREwDxwu+
        Bw/BKGDcZ3wR5tyl4YF6CPRy7b38h42uyA5tSn+HcFtDM01kvGJ2kSKjzm3NnqxbLGS5Q1mSmI+A7
        e1imORyQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:32950 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mcVHA-0006qM-Jj; Mon, 18 Oct 2021 12:14:15 -0400
Subject: Re: [PATCH] counter: drop chrdev_lock
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0PVYT/GCKAnjN9@kroah.com> <YW03PSmpMkMVnHdp@shinobu>
 <YW06rLixA2Uush+n@kroah.com> <YW1Dl7ylRqyPxH2c@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <6aa0e966-478c-4233-fe9b-d16c3c9d4989@lechnology.com>
Date:   Mon, 18 Oct 2021 11:14:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW1Dl7ylRqyPxH2c@shinobu>
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

On 10/18/21 4:51 AM, William Breathitt Gray wrote:
> On Mon, Oct 18, 2021 at 11:13:16AM +0200, Greg KH wrote:
>> On Mon, Oct 18, 2021 at 05:58:37PM +0900, William Breathitt Gray wrote:
>>> On Mon, Oct 18, 2021 at 08:08:21AM +0200, Greg KH wrote:
>>>> On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
>>>>> This removes the chrdev_lock from the counter subsystem. This was
>>>>> intended to prevent opening the chrdev more than once. However, this
>>>>> doesn't work in practice since userspace can duplicate file descriptors
>>>>> and pass file descriptors to other processes. Since this protection
>>>>> can't be relied on, it is best to just remove it.
>>>>
>>>> Much better, thanks!
>>>>
>>>> One remaining question:
>>>>
>>>>> --- a/include/linux/counter.h
>>>>> +++ b/include/linux/counter.h
>>>>> @@ -297,7 +297,6 @@ struct counter_ops {
>>>>>    * @events:		queue of detected Counter events
>>>>>    * @events_wait:	wait queue to allow blocking reads of Counter events
>>>>>    * @events_lock:	lock to protect Counter events queue read operations
>>>>> - * @chrdev_lock:	lock to limit chrdev to a single open at a time
>>>>>    * @ops_exist_lock:	lock to prevent use during removal
>>>>
>>>> Why do you still need 2 locks for the same structure?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Originally there was only the events_lock mutex. Initially I tried using
>>> it to also limit the chrdev to a single open, but then came across a
>>> "lock held when returning to user space" warning:
>>> https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m6072133d418d598a5f368bb942c945e46cfab9a5
>>>
>>> Instead of losing the benefits of a mutex lock for protecting the
>>> events, I ultimately implemented the chrdev_lock separately as an
>>> atomic_t. If the chrdev_lock is removed, then we'll use events_lock
>>> solely from now on for this structure.
>>
>> chrdev_lock should be removed, it doesn't really do what you think it
>> does, as per the thread yesterday :)
>>
>> So does this mean you can also drop the ops_exist_lock?
>>
>> thanks,
>>
>> greg k-h
> 
> When counter_unregister is called, the ops member is set to NULL to
> indicate that the driver will be removed and that no new device
> operations should occur (because the ops callbacks will no longer be
> valid). The ops_exist_lock is used to allow existing ops callback
> dereferences to complete before the driver is removed so that we do not
> suffer a page fault.
> 
> I don't believe we can remove this protection (or can we?) but perhaps
> we can merge the three mutex locks (n_events_list_lock, events_lock, and
> ops_exist_lock) into a single "counter_lock" that handles all mutex
> locking for this structure.
> 

The different mutexes protect individual parts of the counter struct
rather than the struct as a whole (a linked list, kfifo reads, and
callback ops), so I think it makes the code clearer having individual
mutexes for each rather than having a global mutex for unrelated
actions.

