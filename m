Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F111432371
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhJRQGD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 12:06:03 -0400
Received: from vern.gendns.com ([98.142.107.122]:37180 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhJRQGD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 12:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6T5wfrK0LEtae0s+NQJAZleVvHNYYAyTeW+KAGeEySM=; b=iBsTpaLu/SHtNy+ARNTBisB7Bv
        9qB4jBEtlXdoxYdgVNpqj15qw5itxKEDI2kqzNUvMNaiaTmXO11WuPtTYq8hL0SRaioUWB5zoajI6
        PNBy3/b6MjceMocBU4Zyw7vq9HtO87Vd7mj2GrsQsY1emf3ZAgKQGWyp0BcWeU1oKFGm2y7BofqXt
        e8LSynNtOkDFL67nCYmcds6lFzpbPIoLanVW+DUyCh+uVAwwvFJ4rb3lZSopau/Rbo6v1MZzTpuzq
        xViNjJdE8gkhhrCAdt8FuTkp4Z5vuWLvSjZ9fCMlidxsiFxWuo7I+jbqZjPqL7ZR0Jl12T8YWrzXq
        Xlsb2/Kg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60946 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mcV74-0004xm-O8; Mon, 18 Oct 2021 12:03:50 -0400
Subject: Re: [PATCH] counter: drop chrdev_lock
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <20211017185521.3468640-1-david@lechnology.com>
 <YW0673OckeCY6Qs/@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <e8158cd7-fbde-5a9a-f4d9-a863745e3d58@lechnology.com>
Date:   Mon, 18 Oct 2021 11:03:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YW0673OckeCY6Qs/@shinobu>
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

On 10/18/21 4:14 AM, William Breathitt Gray wrote:
> On Sun, Oct 17, 2021 at 01:55:21PM -0500, David Lechner wrote:
>> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
>> index 1ccd771da25f..7bf8882ff54d 100644
>> --- a/drivers/counter/counter-sysfs.c
>> +++ b/drivers/counter/counter-sysfs.c
>> @@ -796,25 +796,18 @@ static int counter_events_queue_size_write(struct counter_device *counter,
>>   					   u64 val)
>>   {
>>   	DECLARE_KFIFO_PTR(events, struct counter_event);
>> -	int err = 0;
>> -
>> -	/* Ensure chrdev is not opened more than 1 at a time */
>> -	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
>> -		return -EBUSY;
>> +	int err;
>>   
>>   	/* Allocate new events queue */
>>   	err = kfifo_alloc(&events, val, GFP_KERNEL);
>>   	if (err)
>> -		goto exit_early;
>> +		return err;
>>   
>>   	/* Swap in new events queue */
>>   	kfifo_free(&counter->events);
>>   	counter->events.kfifo = events.kfifo;
> 
> Do we need to hold the events_lock mutex here for this swap in case
> counter_chrdev_read() is in the middle of reading the kfifo to
> userspace, or do the kfifo macros already protect us from a race
> condition here?
> 
Another possibility might be to disallow changing the size while
events are enabled. Otherwise, we also need to protect against
write after free.

I considered this:

	swap(counter->events.kfifo, events.kfifo);
	kfifo_free(&events);

But I'm not sure that would be safe enough.
