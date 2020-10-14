Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D3728D812
	for <lists+linux-iio@lfdr.de>; Wed, 14 Oct 2020 03:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388390AbgJNBkd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Oct 2020 21:40:33 -0400
Received: from vern.gendns.com ([98.142.107.122]:58112 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbgJNBkd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Oct 2020 21:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CNLYzPtlrnkaBQusXWfkK82NduWVaBMn3BK5TsjGKFw=; b=XucF4ZaEzJnqAiI50FPK0gLPHF
        CYiX/9BE8aTI7DX3cNHagFcvDkMilx3oQ8oQoTEK8x80y8mEtyAFzzMQJIKcylGfkEBsfFbjls/+2
        k9Nz+aKLXiq3t0tIabnPd7+wVxKBZLHYqSDLYx2YIH78nb3/F+cbPv/ONzP2EArpz2QDCBatNw2f+
        yXbJEWCRmzm5Lcx3GZUTWok472ozD9eaSfBGW+SNRMFt7z5rgbVnTATB9jnQeL2kvViFh0HAbljB3
        VGLJsRl+2wAxANC/YyXlOruQkFXsj0qW4RxVrzTsNFuZFh05qSaIH9+YxOXEl+ZjFmiEAd3lQWYwK
        O9cXZBMg==;
Received: from [2600:1700:4830:165f::19e] (port=55942)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kSVm9-0006TH-0d; Tue, 13 Oct 2020 21:40:21 -0400
Subject: Re: [PATCH v5 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <181eb08a-be0a-f7cc-259d-b2a0f279950b@lechnology.com>
Date:   Tue, 13 Oct 2020 20:40:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
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

On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> This patch introduces a character device interface for the Counter
> subsystem. Device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.
> 

Probably don't need to duplicate the full documentation in the commit
message.


> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> new file mode 100644
> index 000000000000..2be3846e4105
> --- /dev/null
> +++ b/drivers/counter/counter-chrdev.c


> +
> +static int counter_set_event_node(struct counter_device *const counter,
> +				  struct counter_watch *const watch,
> +				  const struct counter_comp_node *const cfg)
> +{
> +	struct counter_event_node *event_node;
> +	int err;
> +	struct counter_comp_node *comp_node;
> +
> +	/* Search for event in the list */
> +	list_for_each_entry(event_node, &counter->next_events_list, l)
> +		if (event_node->event == watch->event &&
> +		    event_node->channel == watch->channel)
> +			break;
> +
> +	/* If event is not already in the list */
> +	if (&event_node->l == &counter->next_events_list) {
> +		/* Allocate new event node */
> +		event_node = kmalloc(sizeof(*event_node), GFP_ATOMIC);
> +		if (!event_node)
> +			return -ENOMEM;
> +
> +		/* Configure event node and add to the list */
> +		event_node->event = watch->event;
> +		event_node->channel = watch->channel;
> +		INIT_LIST_HEAD(&event_node->comp_list);
> +		list_add(&event_node->l, &counter->next_events_list);
> +	}
> +
> +	/* Check if component watch has already been set before */
> +	list_for_each_entry(comp_node, &event_node->comp_list, l)
> +		if (comp_node->parent == cfg->parent &&
> +		    comp_node->comp.count_u8_read == cfg->comp.count_u8_read)
> +			return -EINVAL;

There are already enough things that could cause EINVAL, we could
probably skip this duplicate check to make troubleshooting easier.

> +
> +	/* Allocate component node */
> +	comp_node = kmalloc(sizeof(*comp_node), GFP_ATOMIC);
> +	if (!comp_node) {
> +		err = -ENOMEM;
> +		goto err_comp_node;

Since there is only one goto, we could just handle the error and
return here instead.

> +	}
> +	*comp_node = *cfg;
> +
> +	/* Add component node to event node */
> +	list_add_tail(&comp_node->l, &event_node->comp_list);
> +
> +	return 0;
> +
> +err_comp_node:

A comment explaining the list_empty() check would be nice.
It makes sense if you think about it, but it is not super
obvious.

> +	if (list_empty(&event_node->comp_list)) {
> +		list_del(&event_node->l);
> +		kfree(event_node);
> +	}
> +	return err;
> +}
> +
> +static int counter_set_watch(struct counter_device *const counter,
> +			     const unsigned long arg)
> +{
> +	void __user *const uwatch = (void __user *)arg;
> +	struct counter_watch watch;
> +	struct counter_comp_node comp_node;
> +	size_t parent, id;
> +	struct counter_comp *ext;
> +	size_t num_ext;
> +
> +	if (copy_from_user(&watch, uwatch, sizeof(watch)))
> +		return -EFAULT;
> +	parent = watch.component.parent;
> +	id = watch.component.id;
> +
> +	/* Configure parent component info for comp node */
> +	switch (watch.component.scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		comp_node.parent = NULL;
> +
> +		ext = counter->ext;
> +		num_ext = counter->num_ext;
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		if (counter->num_signals < parent + 1)

I think it would be more conventional this way:

	if (parent >= counter->num_signals)

> +			return -EINVAL;
> +
> +		comp_node.parent = counter->signals + parent;
> +
> +		ext = counter->signals[parent].ext;
> +		num_ext = counter->signals[parent].num_ext;
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		if (counter->num_counts < parent + 1)

Same here.

> +			return -EINVAL;
> +
> +		comp_node.parent = counter->counts + parent;
> +
> +		ext = counter->counts[parent].ext;
> +		num_ext = counter->counts[parent].num_ext;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Configure component info for comp node */
> +	switch (watch.component.type) {
> +	case COUNTER_COMPONENT_SIGNAL:
> +		if (watch.component.scope != COUNTER_SCOPE_SIGNAL)
> +			return -EINVAL;
> +
> +		comp_node.comp.type = COUNTER_COMP_SIGNAL_LEVEL;
> +		comp_node.comp.signal_u8_read = counter->ops->signal_read;
> +		break;
> +	case COUNTER_COMPONENT_COUNT:
> +		if (watch.component.scope != COUNTER_SCOPE_COUNT)
> +			return -EINVAL;
> +
> +		comp_node.comp.type = COUNTER_COMP_U64;
> +		comp_node.comp.count_u64_read = counter->ops->count_read;
> +		break;
> +	case COUNTER_COMPONENT_FUNCTION:
> +		if (watch.component.scope != COUNTER_SCOPE_COUNT)
> +			return -EINVAL;
> +
> +		comp_node.comp.type = COUNTER_COMP_FUNCTION;
> +		comp_node.comp.count_u8_read = counter->ops->function_read;
> +		break;
> +	case COUNTER_COMPONENT_SYNAPSE_ACTION:
> +		if (watch.component.scope != COUNTER_SCOPE_COUNT)
> +			return -EINVAL;
> +		if (counter->counts[parent].num_synapses < id + 1)

	if (id >= counter->counts[parent].num_synapses)

> +			return -EINVAL;
> +
> +		comp_node.comp.type = COUNTER_COMP_SYNAPSE_ACTION;
> +		comp_node.comp.action_read = counter->ops->action_read;
> +		comp_node.comp.priv = counter->counts[parent].synapses + id;
> +		break;
> +	case COUNTER_COMPONENT_EXTENSION:
> +		if (num_ext < id + 1)

	if (id >= num_ext)

> +			return -EINVAL;
> +
> +		comp_node.comp = ext[id];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (!comp_node.comp.count_u8_read)

A comment reminding us that count_u8_read is part of a union
would be helpful here since this is checking that any read
function was set, not just count_u8_read.

> +		return -EFAULT;

Would EOPNOTSUPP be a better error choice?

> +	comp_node.component = watch.component;
> +
> +	return counter_set_event_node(counter, &watch, &comp_node);
> +}
> +
> +static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
> +				 unsigned long arg)
> +{
> +	struct counter_device *const counter = filp->private_data;
> +	raw_spinlock_t *const events_lock = &counter->events_lock;
> +	unsigned long flags;
> +	struct list_head *const events_list = &counter->events_list;
> +	struct list_head *const next_events_list = &counter->next_events_list;
> +
> +	switch (cmd) {
> +	case COUNTER_CLEAR_WATCHES_IOCTL:
> +		raw_spin_lock_irqsave(events_lock, flags);
> +		counter_events_list_free(events_list);
> +		raw_spin_unlock_irqrestore(events_lock, flags);
> +		counter_events_list_free(next_events_list);

I think this ioctl is doing too much. If we have to use it for both
stopping events and clearing the list accumulated by
COUNTER_SET_WATCH_IOCTL, then we have a race condition of no events
after clearing watches during the time we are adding new ones and
until we load the new ones.

It would probably make more sense to call this ioctl
COUNTER_STOP_WATCHES_IOCTL and move counter_events_list_free(
next_events_list) to the end of COUNTER_LOAD_WATCHES_IOCTL.

> +		break;
> +	case COUNTER_SET_WATCH_IOCTL:
> +		return counter_set_watch(counter, arg);


Would it make more sense to call this COUNTER_ADD_WATCH_IOCTL since it
adds a watch to the list that will be loaded/enabled later?


> +	case COUNTER_LOAD_WATCHES_IOCTL:
> +		raw_spin_lock_irqsave(events_lock, flags);
> +		counter_events_list_free(events_list);
> +		list_replace_init(next_events_list, events_list);
> +		raw_spin_unlock_irqrestore(events_lock, flags);

For the eQEP driver, we will need a callback here to configure
interrupts for the events. Likewise a callback would be needed
here (for the case when we are replacing already loaded watches)
and in COUNTER_STOP_WATCHES_IOCTL to unconfigure them.

> +		break;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +
> +	return 0;
> +}
> +
> +static int counter_chrdev_open(struct inode *inode, struct file *filp)
> +{
> +	struct counter_device *const counter = container_of(inode->i_cdev,
> +							    typeof(*counter),
> +							    chrdev);
> +
> +	get_device(&counter->dev);
> +	filp->private_data = counter;
> +
> +	return nonseekable_open(inode, filp);
> +}
> +
> +static int counter_chrdev_release(struct inode *inode, struct file *filp)
> +{
> +	struct counter_device *const counter = filp->private_data;
> +	unsigned long flags;
> +
> +	put_device(&counter->dev);

put_device() should be at the end of the function in case it is the last
reference.

> +
> +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> +	counter_events_list_free(&counter->events_list);
> +	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> +	counter_events_list_free(&counter->next_events_list);
> +
> +	return 0;
> +}
> +

> +int counter_push_event(struct counter_device *const counter, const u8 event,
> +		       const u8 channel)
> +{
> +	struct counter_event ev = {0};
> +	unsigned int copied = 0;
> +	unsigned long flags;
> +	struct counter_event_node *event_node;
> +	struct counter_comp_node *comp_node;
> +	int err;
> +
> +	ev.timestamp = ktime_get_ns();
> +	ev.watch.event = event;
> +	ev.watch.channel = channel;
> +
> +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> +
> +	/* Search for event in the list */
> +	list_for_each_entry(event_node, &counter->events_list, l)
> +		if (event_node->event == event &&
> +		    event_node->channel == channel)
> +			break;
> +
> +	/* If event is not in the list */
> +	if (&event_node->l == &counter->events_list)
> +		goto exit_early;
> +
> +	/* Read and queue relevant comp for userspace */
> +	list_for_each_entry(comp_node, &event_node->comp_list, l) {
> +		err = counter_get_data(counter, comp_node, &ev.value_u8);
> +		if (err)
> +			goto err_counter_get_data;
> +
> +		ev.watch.component = comp_node->component;
> +
> +		copied += kfifo_put(&counter->events, ev);
> +	}
> +
> +	if (copied)
> +		wake_up_poll(&counter->events_wait, EPOLLIN);
> +
> +exit_early:
> +	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> +
> +	return 0;
> +
> +err_counter_get_data:
> +	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> +	return err;

This seems slightly redundant. Could just initialize err to 0
and combine the two labels.

> +}
> +EXPORT_SYMBOL_GPL(counter_push_event);


> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> index e66ed99dd5ea..cefef61f170d 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c


Not sure why sysfs changes are in the chrdev patch. Are these
changes related somehow?


> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> new file mode 100644
> index 000000000000..ad9a8686b2b0
> --- /dev/null
> +++ b/include/uapi/linux/counter.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace ABI for Counter character devices
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +#ifndef _UAPI_COUNTER_H_
> +#define _UAPI_COUNTER_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>

It would be very helpful to have documentation comments for all of
the defines in this file.

> +
> +#define COUNTER_SCOPE_DEVICE 0
> +#define COUNTER_SCOPE_SIGNAL 1
> +#define COUNTER_SCOPE_COUNT 2
> +
> +#define COUNTER_COMPONENT_SIGNAL 0
> +#define COUNTER_COMPONENT_COUNT 1
> +#define COUNTER_COMPONENT_FUNCTION 2
> +#define COUNTER_COMPONENT_SYNAPSE_ACTION 3
> +#define COUNTER_COMPONENT_EXTENSION 4

There are probably some cases where we will want to just
have an event without reading a component value, so we
could use something like COUNTER_SCOPE_NONE and
COUNTER_COMPONENT_NONE here.

> +
> +/**
> + * struct counter_component - Counter component identification
> + * @scope: component scope (Device, Count, or Signal)
> + * @parent: parent component identification number
> + * @type: component type (Count, extension, etc.)
> + * @id: component identification number
> + */
> +struct counter_component {
> +	__u8 scope;
> +	__u64 parent;
> +	__u8 type;
> +	__u64 id;
> +};


This will have alignment issues, e.g. when 64-bit kernel is used
with a 32-bit userspace. It looks like there is a __aligned_u64
type to help with this. But, unless we expect more that 4 billion
counter devices, there doesn't seem to be a reason for parent
and id to be 64-bit.

> +
> +#define COUNTER_EVENT_OVERFLOW 0
> +#define COUNTER_EVENT_UNDERFLOW 1
> +#define COUNTER_EVENT_OVERFLOW_UNDERFLOW 2

Would it make sense to just have individual overflow and
underflow events? For example, the Carry-Borrow interrupt
on 104-quad-8 could just call counter_push_event() twice.

> +#define COUNTER_EVENT_THRESHOLD 3
> +#define COUNTER_EVENT_INDEX 4
> +
> +/**
> + * struct counter_watch - Counter component watch configuration
> + * @event: event that triggers
> + * @channel: event channel

How is channel intended to be used? (The device I am working with
I assume would ignore the channel since it is just a single counter.)

> + * @component: component to watch when event triggers
> + */
> +struct counter_watch {
> +	__u8 event;
> +	__u8 channel;
> +	struct counter_component component;
> +};

To get the most compact layout, usually fields are ordered largest to smallest.

> +
> +#define COUNTER_CLEAR_WATCHES_IOCTL _IO(0x3E, 0x00)
> +#define COUNTER_SET_WATCH_IOCTL _IOW(0x3E, 0x01, struct counter_watch)
> +#define COUNTER_LOAD_WATCHES_IOCTL _IO(0x3E, 0x02)
> +
> +/**
> + * struct counter_event - Counter event data
> + * @timestamp: best estimate of time of event occurrence, in nanoseconds
> + * @watch: component watch configuration
> + * @value_u8: component value as __u8 data type
> + * @value_u64: component value as __u64 data type
> + */
> +struct counter_event {
> +	__u64 timestamp;
> +	struct counter_watch watch;
> +	union {
> +		__u8 value_u8;
> +		__u64 value_u64;
> +	};
> +};

Should probably use __aligned_u64 here too.

> +
> +#define COUNTER_COUNT_DIRECTION_FORWARD 0
> +#define COUNTER_COUNT_DIRECTION_BACKWARD 1
> +
> +#define COUNTER_COUNT_MODE_NORMAL 0
> +#define COUNTER_COUNT_MODE_RANGE_LIMIT 1
> +#define COUNTER_COUNT_MODE_NON_RECYCLE 2
> +#define COUNTER_COUNT_MODE_MODULO_N 3
> +
> +#define COUNTER_FUNCTION_INCREASE 0
> +#define COUNTER_FUNCTION_DECREASE 1
> +#define COUNTER_FUNCTION_PULSE_DIRECTION 2
> +#define COUNTER_FUNCTION_QUADRATURE_X1_A 3
> +#define COUNTER_FUNCTION_QUADRATURE_X1_B 4
> +#define COUNTER_FUNCTION_QUADRATURE_X2_A 5
> +#define COUNTER_FUNCTION_QUADRATURE_X2_B 6
> +#define COUNTER_FUNCTION_QUADRATURE_X4 7
> +
> +#define COUNTER_SIGNAL_LEVEL_LOW 0
> +#define COUNTER_SIGNAL_LEVEL_HIGH 1
> +
> +#define COUNTER_SYNAPSE_ACTION_NONE 0
> +#define COUNTER_SYNAPSE_ACTION_RISING_EDGE 1
> +#define COUNTER_SYNAPSE_ACTION_FALLING_EDGE 2
> +#define COUNTER_SYNAPSE_ACTION_BOTH_EDGES 3
> +
> +#endif /* _UAPI_COUNTER_H_ */
> 


Overall, I think we are getting close. I've started adding
events to the TI eQEP driver. You can find the code at [1].
I still have a bit of work to do to add the timer and edge
capture events.

[1]: https://github.com/dlech/linux/tree/bone-counter
