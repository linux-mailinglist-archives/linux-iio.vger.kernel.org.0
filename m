Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DB128E8C4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Oct 2020 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgJNWdB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Oct 2020 18:33:01 -0400
Received: from vern.gendns.com ([98.142.107.122]:45968 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgJNWdB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Oct 2020 18:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pqfve9QSwJ97lwFe5PUL5oCSivPq5QqIIRkVs7VEbRc=; b=pWvwvcvsEWpMVOnY15/WSPNrFG
        W+iqT8m+vE1iqkyyTyS3BgpZdObFYIhxIEHh4CigI694dn0aS7MZ1ZSirVibJiY1T4bnl5QUushIV
        5b8eNWin3KaoD+cPmJMigfUnD/WvOUrIBSVqp1LFK7g8WWxq24pgrVLHTSrQPmVOo3C/eR3Cgj4kM
        g6xnGZfxORaKzuCA2mnlIGy1/ZAcvroGVdhwMjL1vMLYQcPz/iy+GKRXroyZlpCvbqnP0II7Hw92K
        5+J3lBTbro39rw64yge3wO6c1JjbbetE6oKGmcBAq0YZ+fJrsf+yI+B3BuuHSV9dcc09Y2/KBzSEB
        W+ClXZBQ==;
Received: from [2600:1700:4830:165f::19e] (port=50504)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kSpKL-0000An-70; Wed, 14 Oct 2020 18:32:57 -0400
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
 <67a0290e-731b-822a-5113-30b56bde6c88@lechnology.com>
 <20201014190526.GA13439@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <e9fe486c-7f4f-911a-7f40-f713ff0deb17@lechnology.com>
Date:   Wed, 14 Oct 2020 17:32:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014190526.GA13439@shinobu>
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

On 10/14/20 2:05 PM, William Breathitt Gray wrote:
> On Wed, Oct 14, 2020 at 12:43:08PM -0500, David Lechner wrote:
>> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
>>> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
>>> new file mode 100644
>>> index 000000000000..2be3846e4105
>>> --- /dev/null
>>> +++ b/drivers/counter/counter-chrdev.c
>>
>>
>>> +/**
>>> + * counter_push_event - queue event for userspace reading
>>> + * @counter:	pointer to Counter structure
>>> + * @event:	triggered event
>>> + * @channel:	event channel
>>> + *
>>> + * Note: If no one is watching for the respective event, it is silently
>>> + * discarded.
>>> + *
>>> + * RETURNS:
>>> + * 0 on success, negative error number on failure.
>>> + */
>>> +int counter_push_event(struct counter_device *const counter, const u8 event,
>>> +		       const u8 channel)
>>> +{
>>> +	struct counter_event ev = {0};
>>> +	unsigned int copied = 0;
>>> +	unsigned long flags;
>>> +	struct counter_event_node *event_node;
>>> +	struct counter_comp_node *comp_node;
>>> +	int err;
>>> +
>>> +	ev.timestamp = ktime_get_ns();
>>> +	ev.watch.event = event;
>>> +	ev.watch.channel = channel;
>>> +
>>> +	raw_spin_lock_irqsave(&counter->events_lock, flags);
>>> +
>>> +	/* Search for event in the list */
>>> +	list_for_each_entry(event_node, &counter->events_list, l)
>>> +		if (event_node->event == event &&
>>> +		    event_node->channel == channel)
>>> +			break;
>>> +
>>> +	/* If event is not in the list */
>>> +	if (&event_node->l == &counter->events_list)
>>> +		goto exit_early;
>>> +
>>> +	/* Read and queue relevant comp for userspace */
>>> +	list_for_each_entry(comp_node, &event_node->comp_list, l) {
>>> +		err = counter_get_data(counter, comp_node, &ev.value_u8);
>>
>> Currently all counter devices are memory mapped devices so calling
>> counter_get_data() here with interrupts disabled is probably OK, but
>> if any counter drivers are added that use I2C/SPI/etc. that will take
>> a long time to read, it would cause problems leaving interrupts
>> disabled here.
>>
>> Brainstorming: Would it make sense to separate the event from the
>> component value being read? As I mentioned in one of my previous
>> reviews, I think there are some cases where we would just want to
>> know when an event happened and not read any additional data anyway.
>> In the case of a slow communication bus, this would also let us
>> queue the event in the kfifo and notify poll right away and then
>> defer the reads in a workqueue for later.
> 
> I don't see any problems with reporting just an event without any
> component value attached (e.g. userspace could handle the component
> reads via sysfs at a later point). We would just need a way to inform
> userspace that the struct counter_component in the struct counter_watch
> returned should be ignored.
> 
> Perhaps we can add an additional member to struct counter_watch
> indicating whether it's an empty watch; or alternatively, add a new
> component scope define to differentiate between an actual component and
> an empty one (e.g. COUNTER_SCOPE_EVENT). What do you think?
> 
> William Breathitt Gray
> 

I made the same suggestion in one of my other replies - except
I called it COUNTER_SCOPE_NONE.
