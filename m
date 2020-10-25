Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA26298291
	for <lists+linux-iio@lfdr.de>; Sun, 25 Oct 2020 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417230AbgJYQfq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Oct 2020 12:35:46 -0400
Received: from vern.gendns.com ([98.142.107.122]:34248 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415565AbgJYQfA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Oct 2020 12:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=n5FVkuP6oeXTkxGkaquPxRYSUT/cnDUdCk1h4wEC6ts=; b=ZAMgcC6Bny5GPl6Cj9m+tyNJSg
        ubofQ5n5zGZ0/YhijB25Qm3jRuAU1At8XF6kwC9rpuOdI5vw1TVmszX/iRTPqFPyg4VNFpB5SLjBT
        c1gBpgIKQJtPtBfUHkFUocU/sO6+gXJEct3ZQD5o2ulLchsl6+pHqRQSalqoasJZ5+Sy+M8zp8BQp
        4pa1moxL0+sTKgns74Pf/xgukMQfy3gyP9BNILEGvi9db2NRX5aqgqINTkaeD9LJAryced34MgCAF
        +3d9oXcYCrZAzB+YoOq2adO2LMcjyvCi2R0PwYT82YEwh+b5/3Qo8F0VIhUBWAAd7H69YtV4z9KQj
        5OhvJPAg==;
Received: from [2600:1700:4830:165f::19e] (port=37582)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kWiyu-00056T-HR; Sun, 25 Oct 2020 12:34:56 -0400
Subject: Re: [PATCH v5 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
 <cc1f7e4d-18d1-bc28-8ce3-e3edcd91bcab@lechnology.com>
 <20201018165822.GE231549@shinobu>
 <f2bac8b2-108d-fa4c-cb63-8ff85ce04d1f@lechnology.com>
 <20201025131809.GB3458@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <e0b7989f-6a99-0fae-471c-8d06c8e951b0@lechnology.com>
Date:   Sun, 25 Oct 2020 11:34:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201025131809.GB3458@shinobu>
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

On 10/25/20 8:18 AM, William Breathitt Gray wrote:
> On Tue, Oct 20, 2020 at 11:06:42AM -0500, David Lechner wrote:
>> On 10/18/20 11:58 AM, William Breathitt Gray wrote:
>>> On Wed, Oct 14, 2020 at 05:40:44PM -0500, David Lechner wrote:
>>>> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
>>>>> +static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
>>>>> +				   size_t len, loff_t *f_ps)
>>>>> +{
>>>>> +	struct counter_device *const counter = filp->private_data;
>>>>> +	int err;
>>>>> +	unsigned long flags;
>>>>> +	unsigned int copied;
>>>>> +
>>>>> +	if (len < sizeof(struct counter_event))
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	do {
>>>>> +		if (kfifo_is_empty(&counter->events)) {
>>>>> +			if (filp->f_flags & O_NONBLOCK)
>>>>> +				return -EAGAIN;
>>>>> +
>>>>> +			err = wait_event_interruptible(counter->events_wait,
>>>>> +					!kfifo_is_empty(&counter->events));
>>>>> +			if (err)
>>>>> +				return err;
>>>>> +		}
>>>>> +
>>>>> +		raw_spin_lock_irqsave(&counter->events_lock, flags);
>>>>> +		err = kfifo_to_user(&counter->events, buf, len, &copied);
>>>>> +		raw_spin_unlock_irqrestore(&counter->events_lock, flags);
>>>>> +		if (err)
>>>>> +			return err;
>>>>> +	} while (!copied);
>>>>> +
>>>>> +	return copied;
>>>>> +}
>>>>
>>>> All other uses of kfifo_to_user() I saw use a mutex instead of spin
>>>> lock. I don't see a reason for disabling interrupts here.
>>>
>>> The Counter character device interface is special in this case because
>>> counter->events could be accessed from an interrupt context. This is
>>> possible if counter_push_event() is called for an interrupt (as is the
>>> case for the 104_quad_8 driver). In this case, we can't use mutex
>>> because we can't sleep in an interrupt context, so our only option is to
>>> use spin lock.
>>>
>>
>>
>> The way I understand it, locking is only needed for concurrent readers
>> and locking between reader and writer is not needed.
> 
> You're right, it does say in the kfifo.h comments that with only one
> concurrent reader and one current write, we don't need extra locking to
> use these macros. Because we only have one kfifo_to_user() operating on
> counter->events, does that mean we don't need locking at all here for
> the counter_chrdev_read() function?
> 
> William Breathitt Gray
> 

Even if we have the policy that only one file handle to the chrdev
can be open at a time, it is still possible that the it could be
read from multiple threads. So it I think it makes sense to keep
it just to be safe.
