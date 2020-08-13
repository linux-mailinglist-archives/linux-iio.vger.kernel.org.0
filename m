Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF64A2437DB
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgHMJqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 05:46:36 -0400
Received: from www381.your-server.de ([78.46.137.84]:56548 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMJqf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 05:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=/xGO+cFZgO3cJVLAGH4bB/pNEDCxzoetsTPK3J1y/NQ=; b=GWylLszoOlFfZrG7CAGz9ENlKL
        tw8KloPCQ0TDSI6ouCQLdRbIBDxSYtY3d7jQg19NKeDS1LQ7blkoJKTSOLTFQJuA+opdsaJQnIKxH
        ffdJQqjb7ht6wh8NR5QA4bivJp0X4OSlgNTPNHYkXmCcrwFOf77w3w3J5XJC5sS0c0Z04KH68eExU
        GE5JB6nJ2CSa3BOB5V0nOqFrANK7nrIBiZe+oNpW0i28E2VHjBctD1PXPVO8t5wSmQ+LGYHWucICr
        I82tpiNW0QBTO6jMqAoQ/jcZWYnzh4fzAFXGN+lcjPf3KCVppQlkaG6sCCLDlUVpb7pp91HRRPzZL
        F5ABSBPw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1k69oc-0006th-T0; Thu, 13 Aug 2020 11:46:30 +0200
Received: from [2001:a61:2517:6d01:9e5c:8eff:fe01:8578]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1k69oc-000L5d-Nu; Thu, 13 Aug 2020 11:46:30 +0200
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>, linux-iio@vger.kernel.org,
        tglx@linutronix.de
References: <20200813075358.13310-1-lars@metafoo.de>
 <20200813091107.kjelslak2jxkkc42@linutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de>
Date:   Thu, 13 Aug 2020 11:46:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813091107.kjelslak2jxkkc42@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25901/Thu Aug 13 09:01:24 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/13/20 11:11 AM, Sebastian Andrzej Siewior wrote:
> On 2020-08-13 09:53:57 [+0200], Lars-Peter Clausen wrote:
>> On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
>> interrupt expiry mode by default.
>>
>> The IIO hrtimer-trigger needs to run in hard interrupt context since it
>> will end up calling generic_handle_irq() which has the requirement to run
>> in hard interrupt context.
>>
>> Explicitly specify that the timer needs to run in hard interrupt context by
>> using the HRTIMER_MODE_REL_HARD flag.
> No, I don't think that this is good. It basically renders threaded-irqs
> in context of IIO useless. This also requires that the IRQ-handler in
> question runs with IRQs disabled / uses raw_spinlock_t which is in not
> good idea either.

It should not affect the IRQ handlers of individual drivers. The hrtimer 
triggers acts like an IRQ chip and will call generic_handle_irq() to 
multiplex the interrupt handling onto all consumers. As far as I 
understand it there is a requirement that generic_handle_irq() is called 
in hard irq context, even with PREEMT_RT=y.

If you are running with forced IRQ threads the only thing that will then 
happen in the actual hard IRQ context is the launching of the IRQ 
threads. Th e IRQ handler of the device driver will run in a threaded IRQ.

>
> Has this change (including the second patch in thread) been tested on RT
> in terms of locking and latency?

It has not been tested in terms of latency. But like I said if you are 
running with forced IRQ threads the effect should be minimal.

Without this patch there is an correctness issue when PREEMT_RT=y since 
generic_handle_irq() runs with interrupts on which breaks its internal 
assumptions.

