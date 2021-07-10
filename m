Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837883C3678
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 21:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGJTkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 15:40:17 -0400
Received: from vern.gendns.com ([98.142.107.122]:49264 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhGJTkQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 15:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XzefiRpeolNNMaVVRmpStfkxMyK3u1P/qkcYFkQ12sA=; b=EBf7ouqau8eVcmu12xjw0/wnNM
        AGt+nzjUT5QFlL2e+GjrwmPe4iog/IQJh3vQ3v6nDaOnKyo9iMtve91hlFRwDqg1h9wNPL9ceAoEY
        +zMzGxkF3gkwwL8XbYGA4Girtpxk0uN35yKqzoKcemkCN7RobCQY+mZ/ha9D439Xn2af1p7W4xikI
        XvBXTOrJXKOqYB8nYcvNh2cEPI/dJ06pH+M7wV6RfABXVvBmpYZhXiTvOFO8nw3dmd2aGZW3Adjt5
        Jx36dGjfQb4zf9aReocj2O/77P9KF+rDLDgLjHn5d0OUs6jvISg0lq4lDh8LUpgX2lFnydVQa0F45
        qgCseUBA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49732 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2Imm-00HM7j-Me; Sat, 10 Jul 2021 15:37:28 -0400
Subject: Re: [PATCH v12 10/17] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        o.rempel@pengutronix.de, jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <10cf764604827dea1b842cfe7a3cd31ca8ef6539.1625471640.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <8c858a25-f996-133a-ec3e-a0e1a30eebb0@lechnology.com>
Date:   Sat, 10 Jul 2021 14:37:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <10cf764604827dea1b842cfe7a3cd31ca8ef6539.1625471640.git.vilhelm.gray@gmail.com>
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

On 7/5/21 3:18 AM, William Breathitt Gray wrote:
> This patch introduces a character device interface for the Counter
> subsystem. Device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.
> 




> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> new file mode 100644
> index 000000000000..92805b1f65b8
> --- /dev/null
> +++ b/drivers/counter/counter-chrdev.c
> @@ -0,0 +1,494 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic Counter character device interface
> + * Copyright (C) 2020 William Breathitt Gray
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/counter.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/kfifo.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/nospec.h>
> +#include <linux/poll.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/timekeeping.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <linux/uaccess.h>

Move this up one for alphabetical order.

> +
> +#include "counter-chrdev.h"
> +
> +struct counter_comp_node {
> +	struct list_head l;
> +	struct counter_component component;
> +	struct counter_comp comp;
> +	void *parent;
> +};
> +
> +static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
> +				   size_t len, loff_t *f_ps)
> +{
> +	struct counter_device *const counter = filp->private_data;
> +	int err;
> +	unsigned int copied;
> +
> +	if (len < sizeof(struct counter_event))
> +		return -EINVAL;
> +
> +	do {
> +		if (kfifo_is_empty(&counter->events)) {
> +			if (filp->f_flags & O_NONBLOCK)
> +				return -EAGAIN;
> +
> +			err = wait_event_interruptible(counter->events_wait,
> +					!kfifo_is_empty(&counter->events));
> +			if (err < 0)
> +				return err;
> +		}
> +
> +		if (mutex_lock_interruptible(&counter->events_lock))
> +			return -ERESTARTSYS;
> +		err = kfifo_to_user(&counter->events, buf, len, &copied);
> +		mutex_unlock(&counter->events_lock);
> +		if (err < 0)
> +			return err;
> +	} while (!copied);
> +
> +	return copied;
> +}
> +
> +static __poll_t counter_chrdev_poll(struct file *filp,
> +				    struct poll_table_struct *pollt)
> +{
> +	struct counter_device *const counter = filp->private_data;
> +	__poll_t events = 0;
> +
> +	poll_wait(filp, &counter->events_wait, pollt);
> +
> +	if (!kfifo_is_empty(&counter->events))
> +		events = EPOLLIN | EPOLLRDNORM;
> +
> +	return events;
> +}
> +
> +static void counter_events_list_free(struct list_head *const events_list)
> +{
> +	struct counter_event_node *p, *n;
> +	struct counter_comp_node *q, *o;
> +
> +	list_for_each_entry_safe(p, n, events_list, l) {
> +		/* Free associated component nodes */
> +		list_for_each_entry_safe(q, o, &p->comp_list, l) {
> +			list_del(&q->l);
> +			kfree(q);
> +		}
> +
> +		/* Free event node */
> +		list_del(&p->l);
> +		kfree(p);
> +	}
> +}
> +
> +static int counter_set_event_node(struct counter_device *const counter,
> +				  struct counter_watch *const watch,
> +				  const struct counter_comp_node *const cfg)
> +{
> +	unsigned long flags;
> +	struct counter_event_node *event_node;
> +	int err = 0;
> +	struct counter_comp_node *comp_node;
> +
> +	spin_lock_irqsave(&counter->events_list_lock, flags);

Since this is just the next watch list and doesn't involve
enabled events, we should be able to use a mutex here instead
of disabling interrupts. This is a rather length operation
to have interrupts disabled when we don't really need to.

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
> +		if (!event_node) {
> +			err = -ENOMEM;
> +			goto exit_early;
> +		}
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
> +		    comp_node->comp.count_u8_read == cfg->comp.count_u8_read) {
Do we need to free event_node here?

> +			err = -EINVAL;
> +			goto exit_early;
> +		}
> +
> +	/* Allocate component node */
> +	comp_node = kmalloc(sizeof(*comp_node), GFP_ATOMIC);
> +	if (!comp_node) {
> +		/* Free event node if no one else is watching */
> +		if (list_empty(&event_node->comp_list)) {
> +			list_del(&event_node->l);
> +			kfree(event_node);
> +		}
> +		err = -ENOMEM;
> +		goto exit_early;
> +	}
> +	*comp_node = *cfg;
> +
> +	/* Add component node to event node */
> +	list_add_tail(&comp_node->l, &event_node->comp_list);
> +
> +exit_early:
> +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> +
> +	return err;
> +}
> +
> +static int counter_disable_events(struct counter_device *const counter)
> +{
> +	unsigned long flags;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&counter->events_list_lock, flags);
> +
> +	counter_events_list_free(&counter->events_list);
> +
> +	if (counter->ops->events_configure)
> +		err = counter->ops->events_configure(counter);
> +
> +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> +
> +	counter_events_list_free(&counter->next_events_list);

Do we need to hold a lock on counter->next_events_list here?


> +
> +	return err;
> +}
> +
> +static int counter_add_watch(struct counter_device *const counter,
> +			     const unsigned long arg)
> +{
> +	void __user *const uwatch = (void __user *)arg;
> +	struct counter_watch watch;
> +	struct counter_comp_node comp_node = {};
> +	size_t parent, id;
> +	struct counter_comp *ext;
> +	size_t num_ext;
> +	int err;
> +
> +	if (copy_from_user(&watch, uwatch, sizeof(watch)))
> +		return -EFAULT;
> +
> +	if (watch.component.type == COUNTER_COMPONENT_NONE)
> +		goto no_component;
> +
> +	parent = watch.component.parent;
> +
> +	/* Configure parent component info for comp node */
> +	switch (watch.component.scope) {
> +	case COUNTER_SCOPE_DEVICE:
> +		ext = counter->ext;
> +		num_ext = counter->num_ext;
> +		break;
> +	case COUNTER_SCOPE_SIGNAL:
> +		if (parent >= counter->num_signals)
> +			return -EINVAL;
> +		parent = array_index_nospec(parent, counter->num_signals);
> +
> +		comp_node.parent = counter->signals + parent;
> +
> +		ext = counter->signals[parent].ext;
> +		num_ext = counter->signals[parent].num_ext;
> +		break;
> +	case COUNTER_SCOPE_COUNT:
> +		if (parent >= counter->num_counts)
> +			return -EINVAL;
> +		parent = array_index_nospec(parent, counter->num_counts);
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
> +	id = watch.component.id;
> +
> +	/* Configure component info for comp node */
> +	switch (watch.component.type) {
> +	case COUNTER_COMPONENT_SIGNAL:
> +		if (watch.component.scope != COUNTER_SCOPE_SIGNAL)
> +			return -EINVAL;
> +
> +		comp_node.comp.type = COUNTER_COMP_SIGNAL_LEVEL;
> +		comp_node.comp.signal_u32_read = counter->ops->signal_read;
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
> +		comp_node.comp.count_u32_read = counter->ops->function_read;
> +		break;
> +	case COUNTER_COMPONENT_SYNAPSE_ACTION:
> +		if (watch.component.scope != COUNTER_SCOPE_COUNT)
> +			return -EINVAL;
> +		if (id >= counter->counts[parent].num_synapses)
> +			return -EINVAL;
> +		id = array_index_nospec(id, counter->counts[parent].num_synapses);
> +
> +		comp_node.comp.type = COUNTER_COMP_SYNAPSE_ACTION;
> +		comp_node.comp.action_read = counter->ops->action_read;
> +		comp_node.comp.priv = counter->counts[parent].synapses + id;
> +		break;
> +	case COUNTER_COMPONENT_EXTENSION:
> +		if (id >= num_ext)
> +			return -EINVAL;
> +		id = array_index_nospec(id, num_ext);
> +
> +		comp_node.comp = ext[id];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	/* Check if any read callback is set; this is part of a union */
> +	if (!comp_node.comp.count_u8_read)
> +		return -EOPNOTSUPP;
> +
> +no_component:
> +	if (counter->ops->watch_validate) {
> +		err = counter->ops->watch_validate(counter, &watch);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	comp_node.component = watch.component;
> +
> +	return counter_set_event_node(counter, &watch, &comp_node);

The mutex I suggested for next_events_list should probably be held
across the call to watch_validate() and counter_set_event_node().
Otherwise a new item could be added in between the time it was
validated and when it was added making it no longer valid.

Probably not likely to ever happen, but theoretially possible.

> +}
> +
> +static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
> +				 unsigned long arg)
> +{
> +	struct counter_device *const counter = filp->private_data;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case COUNTER_ADD_WATCH_IOCTL:
> +		return counter_add_watch(counter, arg);
> +	case COUNTER_ENABLE_EVENTS_IOCTL:
> +		spin_lock_irqsave(&counter->events_list_lock, flags);
> +
> +		counter_events_list_free(&counter->events_list);
> +		list_replace_init(&counter->next_events_list,
> +				  &counter->events_list);
> +
> +		if (counter->ops->events_configure)
> +			err = counter->ops->events_configure(counter);
> +
> +		spin_unlock_irqrestore(&counter->events_list_lock, flags);
> +		return err;

Could be nice to pull this out into a counter_enable_events() function
to balance counter_disable_events().

> +	case COUNTER_DISABLE_EVENTS_IOCTL:
> +		return counter_disable_events(counter);
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
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
> +	int err;
> +
> +	err = counter_disable_events(counter);
> +	if (err < 0)
> +		return err;
> +
> +	put_device(&counter->dev);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations counter_fops = {
> +	.llseek = no_llseek,
> +	.read = counter_chrdev_read,
> +	.poll = counter_chrdev_poll,
> +	.unlocked_ioctl = counter_chrdev_ioctl,
> +	.open = counter_chrdev_open,
> +	.release = counter_chrdev_release,
> +};
> +
> +int counter_chrdev_add(struct counter_device *const counter)
> +{
> +	/* Initialize Counter events lists */
> +	INIT_LIST_HEAD(&counter->events_list);
> +	INIT_LIST_HEAD(&counter->next_events_list);
> +	spin_lock_init(&counter->events_list_lock);
> +	init_waitqueue_head(&counter->events_wait);
> +	mutex_init(&counter->events_lock);
> +
> +	/* Initialize character device */
> +	cdev_init(&counter->chrdev, &counter_fops);
> +
> +	/* Allocate Counter events queue */
> +	return kfifo_alloc(&counter->events, 64, GFP_ATOMIC);

GFP_KERNEL?

> +}
> +
> +void counter_chrdev_remove(struct counter_device *const counter)
> +{
> +	kfifo_free(&counter->events);
> +}
> +
> +static int counter_get_data(struct counter_device *const counter,
> +			    const struct counter_comp_node *const comp_node,
> +			    u64 *const value)
> +{
> +	const struct counter_comp *const comp = &comp_node->comp;
> +	void *const parent = comp_node->parent;
> +	u8 value_u8 = 0;
> +	u32 value_u32 = 0;
> +	int ret;
> +
> +	if (comp_node->component.type == COUNTER_COMPONENT_NONE)
> +		return 0;
> +
> +	switch (comp->type) {
> +	case COUNTER_COMP_U8:
> +	case COUNTER_COMP_BOOL:
> +		switch (comp_node->component.scope) {
> +		case COUNTER_SCOPE_DEVICE:
> +			ret = comp->device_u8_read(counter, &value_u8);
> +			break;
> +		case COUNTER_SCOPE_SIGNAL:
> +			ret = comp->signal_u8_read(counter, parent, &value_u8);
> +			break;
> +		case COUNTER_SCOPE_COUNT:
> +			ret = comp->count_u8_read(counter, parent, &value_u8);
> +			break;
> +		}
> +		*value = value_u8;
> +		return ret;
> +	case COUNTER_COMP_SIGNAL_LEVEL:
> +	case COUNTER_COMP_FUNCTION:
> +	case COUNTER_COMP_ENUM:
> +	case COUNTER_COMP_COUNT_DIRECTION:
> +	case COUNTER_COMP_COUNT_MODE:
> +		switch (comp_node->component.scope) {
> +		case COUNTER_SCOPE_DEVICE:
> +			ret = comp->device_u32_read(counter, &value_u32);
> +			break;
> +		case COUNTER_SCOPE_SIGNAL:
> +			ret = comp->signal_u32_read(counter, parent,
> +						    &value_u32);
> +			break;
> +		case COUNTER_SCOPE_COUNT:
> +			ret = comp->count_u32_read(counter, parent, &value_u32);
> +			break;
> +		}
> +		*value = value_u32;
> +		return ret;
> +	case COUNTER_COMP_U64:
> +		switch (comp_node->component.scope) {
> +		case COUNTER_SCOPE_DEVICE:
> +			return comp->device_u64_read(counter, value);
> +		case COUNTER_SCOPE_SIGNAL:
> +			return comp->signal_u64_read(counter, parent, value);
> +		case COUNTER_SCOPE_COUNT:
> +			return comp->count_u64_read(counter, parent, value);
> +		default:
> +			return -EINVAL;
> +		}
> +	case COUNTER_COMP_SYNAPSE_ACTION:
> +		ret = comp->action_read(counter, parent, comp->priv,
> +					&value_u32);
> +		*value = value_u32;
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * counter_push_event - queue event for userspace reading
> + * @counter:	pointer to Counter structure
> + * @event:	triggered event
> + * @channel:	event channel
> + *
> + * Note: If no one is watching for the respective event, it is silently
> + * discarded.
> + */
> +void counter_push_event(struct counter_device *const counter, const u8 event,
> +			const u8 channel)
> +{
> +	struct counter_event ev = {};

It looks like we set all of the fields so we shouldn't need to initialize here.

> +	unsigned int copied = 0;
> +	unsigned long flags;
> +	struct counter_event_node *event_node;
> +	struct counter_comp_node *comp_node;
> +
> +	ev.timestamp = ktime_get_ns();
> +	ev.watch.event = event;
> +	ev.watch.channel = channel;
> +
> +	/* Could be in an interrupt context, so use a raw spin lock */

this is not a raw spin lock

> +	spin_lock_irqsave(&counter->events_list_lock, flags);
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
> +		ev.watch.component = comp_node->component;
> +		ev.status = -counter_get_data(counter, comp_node, &ev.value);
> +
> +		copied += kfifo_in(&counter->events, &ev, 1);
> +	}
> +
> +	if (copied)
> +		wake_up_poll(&counter->events_wait, EPOLLIN);

wake_up_poll() can probably be called after the lock is released.

> +
> +exit_early:
> +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(counter_push_event);


> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> index 6113938a6044..e55dfc9de887 100644
> --- a/include/uapi/linux/counter.h
> +++ b/include/uapi/linux/counter.h
> @@ -6,6 +6,19 @@
>   #ifndef _UAPI_COUNTER_H_
>   #define _UAPI_COUNTER_H_
>   
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* Component type definitions */
> +enum counter_component_type {
> +	COUNTER_COMPONENT_NONE,
> +	COUNTER_COMPONENT_SIGNAL,
> +	COUNTER_COMPONENT_COUNT,
> +	COUNTER_COMPONENT_FUNCTION,
> +	COUNTER_COMPONENT_SYNAPSE_ACTION,
> +	COUNTER_COMPONENT_EXTENSION,
> +};
> +
>   /* Component scope definitions */
>   enum counter_scope {
>   	COUNTER_SCOPE_DEVICE,
> @@ -13,6 +26,70 @@ enum counter_scope {
>   	COUNTER_SCOPE_COUNT,
>   };
>   
> +/**
> + * struct counter_component - Counter component identification
> + * @type: component type (one of enum counter_component_type)
> + * @scope: component scope (one of enum counter_scope)
> + * @parent: parent ID (matching the ID suffix of the respective parent sysfs
> + *          path as described by the ABI documentation file
> + *          Documentation/ABI/testing/sysfs-bus-counter; e.g. if the component
> + *          attribute path is /sys/bus/counter/devices/counter4/count2/count,
> + *          the parent is count2 and thus parent ID is 2)
> + * @id: component ID (matching the ID provided by the respective *_component_id
> + *      sysfs attribute of the desired component; for example, if the component
> + *      attribute path is /sys/bus/counter/devices/counter4/count2/ceiling, the
> + *      respective /sys/bus/counter/devices/counter4/count2/ceiling_component_id
> + *      attribute will provide the necessary component ID)
> + * )

It could be a bit nicer to have a separate complete example of
populating the struct instead of partial examples in the field
descripions.

> + */
> +struct counter_component {
> +	__u8 type;
> +	__u8 scope;
> +	__u8 parent;

Would it make more sense to call this parent_id instead?

> +	__u8 id;
> +};
> +
> +/* Event type definitions */

Should we document the descriptions of each member here?

> +enum counter_event_type {
> +	COUNTER_EVENT_OVERFLOW,
> +	COUNTER_EVENT_UNDERFLOW,
> +	COUNTER_EVENT_OVERFLOW_UNDERFLOW,

Is this overflow _and_ underflow or overflow _or_ underflow
or something else?

> +	COUNTER_EVENT_THRESHOLD,
> +	COUNTER_EVENT_INDEX,
> +};
> +
> +/**
> + * struct counter_watch - Counter component watch configuration
> + * @component: component to watch when event triggers

Maybe better?

	component that will trigger this event

> + * @event: event that triggers (one of enum counter_event_type)
> + * @channel: event channel (typically 0 unless the device supports concurrent

Should this say "component" instead of "device"?

> + *	     events of the same type)
> + */
> +struct counter_watch {
> +	struct counter_component component;
> +	__u8 event;
> +	__u8 channel;
> +};
> +
> +/* ioctl commands */
> +#define COUNTER_ADD_WATCH_IOCTL _IOW(0x3E, 0x00, struct counter_watch)
> +#define COUNTER_ENABLE_EVENTS_IOCTL _IO(0x3E, 0x01)
> +#define COUNTER_DISABLE_EVENTS_IOCTL _IO(0x3E, 0x02)
> +
> +/**
> + * struct counter_event - Counter event data
> + * @timestamp: best estimate of time of event occurrence, in nanoseconds
> + * @value: component value
> + * @watch: component watch configuration
> + * @status: return status (system error number)
> + */
> +struct counter_event {
> +	__aligned_u64 timestamp;
> +	__aligned_u64 value;
> +	struct counter_watch watch;
> +	__u8 status;

Not sure if this is a _good_ idea, but if status is a signed int, then
it could have negative error codes and positive values could be used
for event-specific non-error status. I can't think of any practical use
though. And forcing it to only be errno codes (0 - 255) probably encourages
better drivers anyway.

> +};
> +
>   /* Count direction values */
>   enum counter_count_direction {
>   	COUNTER_COUNT_DIRECTION_FORWARD,
> 

