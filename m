Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B42293FFB
	for <lists+linux-iio@lfdr.de>; Tue, 20 Oct 2020 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436951AbgJTPxj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Oct 2020 11:53:39 -0400
Received: from vern.gendns.com ([98.142.107.122]:36894 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436948AbgJTPxj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Oct 2020 11:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e9XW3jL6KSRGVR5MuWFAFYvj2Zv/gs4PcbWW0YWvtFQ=; b=P3RuPwL/u6XjviQQnM2x00N/BZ
        wF3Ap47wJroh41dfEJhjkUpcAl/89vXj4DR3P44tiaLiDFGJdFX87JSYs8A3kkCzQ9+5VRK3Svfud
        7gAUr+4AsweDb2CRkQYB2j+g/dzEYm2F724nN3VQseqhE6HKgumlpnlwF8KzSZbuZmEteXFLOc3P0
        P3/CJOgSP7Gd70Kh68nTfxjPdvjnMM81cCw8w2GSEi8CLyqbUXgTVctEubrBZ3teUUkTt/avjfj5V
        sGuzUrKNqJbJjiy8nzPp/opqPGXgvcWm0hYd6++M2shpTPN9oc5GA+ea72VWrMHH8MiswCBAHiTBW
        f43dnrPw==;
Received: from [2600:1700:4830:165f::19e] (port=57840)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kUtx8-00026P-2E; Tue, 20 Oct 2020 11:53:34 -0400
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
 <181eb08a-be0a-f7cc-259d-b2a0f279950b@lechnology.com>
 <20201018164905.GD231549@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <fe46666a-4b2f-31f4-b91d-50c33aba0e56@lechnology.com>
Date:   Tue, 20 Oct 2020 10:53:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201018164905.GD231549@shinobu>
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


>>> +static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
>>> +				 unsigned long arg)
>>> +{
>>> +	struct counter_device *const counter = filp->private_data;
>>> +	raw_spinlock_t *const events_lock = &counter->events_lock;
>>> +	unsigned long flags;
>>> +	struct list_head *const events_list = &counter->events_list;
>>> +	struct list_head *const next_events_list = &counter->next_events_list;
>>> +
>>> +	switch (cmd) {
>>> +	case COUNTER_CLEAR_WATCHES_IOCTL:
>>> +		raw_spin_lock_irqsave(events_lock, flags);
>>> +		counter_events_list_free(events_list);
>>> +		raw_spin_unlock_irqrestore(events_lock, flags);
>>> +		counter_events_list_free(next_events_list);
>>
>> I think this ioctl is doing too much. If we have to use it for both
>> stopping events and clearing the list accumulated by
>> COUNTER_SET_WATCH_IOCTL, then we have a race condition of no events
>> after clearing watches during the time we are adding new ones and
>> until we load the new ones.
>>
>> It would probably make more sense to call this ioctl
>> COUNTER_STOP_WATCHES_IOCTL and move counter_events_list_free(
>> next_events_list) to the end of COUNTER_LOAD_WATCHES_IOCTL.
> 
> I don't think we will necessarily have a race condition here.
> COUNTER_CLEAR_WATCHES_IOCTL is intended to just clear the watches; e.g.
> bring us back to a clear state when some sort of job has completely
> finished and the user is no longer going to watch events for a while
> (maybe they're adjusting the conveyor for the next job or some similar
> operation).
> 
> I think the scenario you're concerned about is when you need to swap
> watches in the middle of a job without losing events. In this case, you
> wouldn't need to use COUNTER_CLEAR_WATCHES_IOCTL at all. Instead, you
> would just set up the watches via COUNTER_SET_WATCH_IOCTL, and then use
> COUNTER_LOAD_WATCHES_IOCTL to perform the swap; after
> COUNTER_LOAD_WATCHES_IOCTL completes, next_events_list is empty (thanks
> to list_replace_init()) and you're ready for the next set of watches.
> 

Got it. I think I missed the fact that list_replace_init() clears
next_events_list.

>>> +
>>> +static int counter_chrdev_release(struct inode *inode, struct file *filp)
>>> +{
>>> +	struct counter_device *const counter = filp->private_data;
>>> +	unsigned long flags;
>>> +
>>> +	put_device(&counter->dev);
>>
>> put_device() should be at the end of the function in case it is the last
>> reference.
> 
> put_device() shouldn't affect the counter_device events members, so I
> don't think there's a difference in this case if it's called at the
> beginning or end of the counter_chrdev_release function.
> 

It isn't possible the some memory allocated with devm_kalloc() could be
be referenced after calling put_device() now or in the future?

>>> +}
>>> +EXPORT_SYMBOL_GPL(counter_push_event);
>>
>>
>>> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
>>> index e66ed99dd5ea..cefef61f170d 100644
>>> --- a/drivers/counter/counter-sysfs.c
>>> +++ b/drivers/counter/counter-sysfs.c
>>
>>
>> Not sure why sysfs changes are in the chrdev patch. Are these
>> changes related somehow?
> 
> Sorry, I forgot to explain this in the cover letter. The changes here
> are only useful for the character device interface. These changes
> introduce the extensionZ_name and extensionZ_width sysfs attributes.
> 
> In the character device interface, extensions are selected by their id
> number, and the value returned depends on the type of data. The new
> sysfs attributes introduced here allow users to match the id of an
> extension with its name, as well as the bit width of the value returned
> so that the user knows whether to use the value_u8 or value_u64 union
> member in struct counter_event.
> 

Are we sure that all value types will always be CPU-endian unsigned
integers? Or should we make an enum to describe the data type instead
of just the width?
