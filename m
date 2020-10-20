Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B37294031
	for <lists+linux-iio@lfdr.de>; Tue, 20 Oct 2020 18:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437124AbgJTQGs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Oct 2020 12:06:48 -0400
Received: from vern.gendns.com ([98.142.107.122]:39302 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbgJTQGs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Oct 2020 12:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=974Pru8SQsTsWRztSFlkqkBRxzWVu5U32q4PL8EdyE0=; b=CFdn00D2yLVnQnBZSvE++F6RB2
        hwgF2+hqz/F0vUmiYOqU0jaKg+NbntGRoJ8NITvlS2fLmSPmeVAdNLSU0FbE4o1eKZ/8N55HGaQwL
        MipSGLiP92IMF/VwWfBSYkI5FD7RC3P/Zw5MoOHUGmhUnywHTnXKtvRNMYj5O9WM+fERe5dZUyoVG
        U3WhL09Ez004/nBbSvA6nx14dJwQTz8yS1n+eEN6+7S/CMsxhAUZVLXh6FXBX8PSZkDbDXxAIaEvN
        oEeStdGS5IfKzsKbh0LQzAnVgq5EM4wItLfeBOEEH3+4YYYd1IaGgKvb1iHXDLOl9iF2B2VGmFxN1
        MI2z9Gqw==;
Received: from [2600:1700:4830:165f::19e] (port=58074)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kUu9s-0005nK-CI; Tue, 20 Oct 2020 12:06:44 -0400
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
From:   David Lechner <david@lechnology.com>
Message-ID: <f2bac8b2-108d-fa4c-cb63-8ff85ce04d1f@lechnology.com>
Date:   Tue, 20 Oct 2020 11:06:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201018165822.GE231549@shinobu>
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

On 10/18/20 11:58 AM, William Breathitt Gray wrote:
> On Wed, Oct 14, 2020 at 05:40:44PM -0500, David Lechner wrote:
>> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
>>> +static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
>>> +				   size_t len, loff_t *f_ps)
>>> +{
>>> +	struct counter_device *const counter = filp->private_data;
>>> +	int err;
>>> +	unsigned long flags;
>>> +	unsigned int copied;
>>> +
>>> +	if (len < sizeof(struct counter_event))
>>> +		return -EINVAL;
>>> +
>>> +	do {
>>> +		if (kfifo_is_empty(&counter->events)) {
>>> +			if (filp->f_flags & O_NONBLOCK)
>>> +				return -EAGAIN;
>>> +
>>> +			err = wait_event_interruptible(counter->events_wait,
>>> +					!kfifo_is_empty(&counter->events));
>>> +			if (err)
>>> +				return err;
>>> +		}
>>> +
>>> +		raw_spin_lock_irqsave(&counter->events_lock, flags);
>>> +		err = kfifo_to_user(&counter->events, buf, len, &copied);
>>> +		raw_spin_unlock_irqrestore(&counter->events_lock, flags);
>>> +		if (err)
>>> +			return err;
>>> +	} while (!copied);
>>> +
>>> +	return copied;
>>> +}
>>
>> All other uses of kfifo_to_user() I saw use a mutex instead of spin
>> lock. I don't see a reason for disabling interrupts here.
> 
> The Counter character device interface is special in this case because
> counter->events could be accessed from an interrupt context. This is
> possible if counter_push_event() is called for an interrupt (as is the
> case for the 104_quad_8 driver). In this case, we can't use mutex
> because we can't sleep in an interrupt context, so our only option is to
> use spin lock.
> 


The way I understand it, locking is only needed for concurrent readers
and locking between reader and writer is not needed.
