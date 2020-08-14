Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048A124447C
	for <lists+linux-iio@lfdr.de>; Fri, 14 Aug 2020 07:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgHNFZH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Aug 2020 01:25:07 -0400
Received: from www381.your-server.de ([78.46.137.84]:57016 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNFZH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2020 01:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=J8ADe4d3q9B0MM3XEkRRHfeBY/16QdMt4Pw6JyExp0w=; b=JzpotPL8UCYtN8YHIyxgnjhI7g
        gfwRcybT3IzPdRUnf5BtebC3ASncUNe4mzy8ncLgtVw5DXSU7tB5SR2X6b5KULQEgY79QZVGdF6ZI
        J1EkPgCZ6t/A897TxlxTBo1aDjUKuscwz3i0RIhIGo6T0c75FNgqzgqXIpasqV+A2eMI6PYfNtRC3
        w6/7+nNQggZn4mnK1CjV+DV069CrgwBnPWvbKH2i0wliALg5ucwx6gITDsB/55Qcq2C8Cc7waZ85s
        Q6APRVolDhFjxGpntT9dWxaTA6KlOHBcIIWPCGBdTKgk9IySo9l45sK9zXGYbEWwIQG4U5v1TZCWJ
        AXiTNeCw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1k6SCz-0000RJ-Qf; Fri, 14 Aug 2020 07:24:54 +0200
Received: from [2001:a61:2517:6d01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1k6SCz-000BX3-IT; Fri, 14 Aug 2020 07:24:53 +0200
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>, linux-iio@vger.kernel.org
References: <20200813075358.13310-1-lars@metafoo.de>
 <20200813091107.kjelslak2jxkkc42@linutronix.de>
 <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de>
 <20200813112741.grdytusuwrlskpwa@linutronix.de>
 <877du2louq.fsf@nanos.tec.linutronix.de> <20200813155519.00000684@Huawei.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4236c3e3-6c7b-a4fc-3d25-1edf4eebec3e@metafoo.de>
Date:   Fri, 14 Aug 2020 07:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813155519.00000684@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25901/Thu Aug 13 09:01:24 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/13/20 4:55 PM, Jonathan Cameron wrote:
> On Thu, 13 Aug 2020 14:19:57 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>>> On 2020-08-13 11:46:30 [+0200], Lars-Peter Clausen wrote:
>>>> If you are running with forced IRQ threads the only thing that will then
>>>> happen in the actual hard IRQ context is the launching of the IRQ threads.
>>>> Th e IRQ handler of the device driver will run in a threaded IRQ.
>>> So if it is really just the wakeup of the IRQ-thread then it should be
>>> okay.
>>> One thing: iio_trigger_poll() may invoke iio_trigger_notify_done(). This
>>> would invoke trig->ops->try_reenable callback if available.
>>> I grepped and found
>>> - bma180_trig_try_reen()
>>>    It appears to perform i2c_smbus_read_byte_data() and smbus sounds
>>>    sleeping. I don't know if it attempts to acquire any spinlock_t but it
>>>    will be wrong on RT.
>> It's wrong even on !RT. i2c reads cannot be invoked from hard interrupt
>> context.
>>
> We would hit this (and resulting warnings) all the time if it actually
> happened, so my suspicion is that it doesn't.
>
> I think the path doesn't actually exist although it looks at first glance like it does.
>
> The interrupt can only be enabled if there is someone using the trigger.
> Thus usecount will be non zero and for at least one element
> trig->subirq[i].enabled == true
>
> So we will decrement trig->usecount in the call to iio_trigger_notify_done
> but never reach 0 thus the call to trig->ops->try_reenable never happens
> in the hard interrupt context.

I think there is a race condition here. If a consumer is disabled 
concurrently with iio_trigger_poll() there is a chance that `enabled` is 
false for all consumers.

The odds of this happening are very low, but there is nothing that 
prevents it.

>
> It does happen later when which ever driver we triggered finishes the
> threaded part of it's handler and calls iio_trigger_notify_done, but that
> is fine.
>
> Assuming people agree with my analysis it would be good to make it explicit
> that we cannot hit the problem path.
>
> Perhaps call a new iio_trigger_notify_no_needed() that simply does
> the decrement without test, or does it with test and spits out a
> warning if we hit 0.

I think we need to re-think the whole try_reenable() functionality. 
Looking at it I think there are more issues here.

For example lets say we call iio_trigger_notify_done() from the threaded 
handler and try_reenable() returns true. We'd now call 
iio_trigger_poll() from the threaded context, which is wrong.

There is also the issue that iio_trigger_poll() effectively can end up 
calling itself recursively indefinitely via the 
iio_trigger_notify_done() chain, which might not be the best thing in 
hard IRQ context.


