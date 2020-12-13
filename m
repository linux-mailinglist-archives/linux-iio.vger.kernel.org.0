Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378A92D9141
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 00:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbgLMX7O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 18:59:14 -0500
Received: from vern.gendns.com ([98.142.107.122]:56018 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgLMX7O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 18:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rMQZwv/LURS0wqCtEAe0Ma2QSEL/VCwH1AdaCaJQmAE=; b=qYqmw2F3ymJtHU9hPxmPp46weq
        6gPiwIGDJyL6oreZi3+hguPJMzoz80cUQluzmQARGcskF275lFeH5l+RMqnbH8zZbQm5ABnMrPy9B
        gBfRjwuS0tjSk7Taz+yCyM+SARjB6K4yWz6op3vI7mU+nTqhAem+GaYtc8lKsS5ZLmv1Ry1KU4FpN
        ylznW+cyH2/yCTFyU9+79ycMPq8OVzoRG/R2AP8Bx0ah+Z6BXlE3WNkaC6ubf3my23TMgcN9FNx8Z
        Wm31ymDvIIdxBgni0Ru1SZqGgLpxKK1jBvE/QTNPOyGTJ+37rtad1HjIH3nbcjg6tUihvF1d4hv0d
        lgbybIiQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:39024 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1kobFz-0002Qr-Ub; Sun, 13 Dec 2020 18:58:28 -0500
Subject: Re: [PATCH v6 3/5] counter: Add character device interface
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
 <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <b5d49a3a-99ab-e5c0-3f0b-601eed9b54f5@lechnology.com>
Date:   Sun, 13 Dec 2020 17:58:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
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

On 11/22/20 2:29 PM, William Breathitt Gray wrote:
> This patch introduces a character device interface for the Counter
> subsystem. Device data is exposed through standard character device read
> operations. Device data is gathered when a Counter event is pushed by
> the respective Counter device driver. Configuration is handled via ioctl
> operations on the respective Counter character device node.
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---



> diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
> new file mode 100644
> index 000000000000..96fa7fbeef92
> --- /dev/null
> +++ b/drivers/counter/counter-chrdev.c


> +static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
> +				   size_t len, loff_t *f_ps)
> +{
> +	struct counter_device *const counter = filp->private_data;
> +	int err;
> +	unsigned long flags;
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
> +			if (err)
> +				return err;
> +		}
> +
> +		raw_spin_lock_irqsave(&counter->events_lock, flags);

As mentioned in my previous review, I think it would be fine to use a
mutex here instead of disabling interrupts. In fact, I think copy_to_user()
might sleep, in which case we really don't want to call this with
interrupts disabled.

> +		err = kfifo_to_user(&counter->events, buf, len, &copied);
> +		raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> +		if (err)
> +			return err;
> +	} while (!copied);
> +
> +	return copied;
> +}
> +


> +static int counter_add_watch(struct counter_device *const counter,
> +			     const unsigned long arg)
> +{
> +	void __user *const uwatch = (void __user *)arg;
> +	struct counter_watch watch;
> +	struct counter_comp_node comp_node = {0};
> +	size_t parent, id;
> +	struct counter_comp *ext;
> +	size_t num_ext;
> +
> +	if (copy_from_user(&watch, uwatch, sizeof(watch)))
> +		return -EFAULT;
> +
> +	/* Dummy components can skip evaluation */
> +	if (watch.component.type == COUNTER_COMPONENT_DUMMY)

I think "none" would be a better name than "dummy". Then it just
naturally makes sense why we would skip the evaluation.

> +		goto dummy_component;
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
> +dummy_component:
> +	comp_node.component = watch.component;


In my experiments, I added a events_validate driver callback here to
validate each event as it is added. This way the user can know exactly
which event caused the problem rather than waiting for the event_config
callback.


> +
> +	return counter_set_event_node(counter, &watch, &comp_node);
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
> +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> +	counter_events_list_free(&counter->events_list);

Do we need to call the events_config callback here?

> +	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> +	counter_events_list_free(&counter->next_events_list);
> +
> +	put_device(&counter->dev);
> +
> +	return 0;
> +}


> +/**
> + * counter_push_event - queue event for userspace reading
> + * @counter:	pointer to Counter structure
> + * @event:	triggered event
> + * @channel:	event channel
> + *
> + * Note: If no one is watching for the respective event, it is silently
> + * discarded.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int counter_push_event(struct counter_device *const counter, const u8 event,
> +		       const u8 channel)
> +{
> +	struct counter_event ev = {0};
> +	unsigned int copied = 0;
> +	unsigned long flags;
> +	struct counter_event_node *event_node;
> +	struct counter_comp_node *comp_node;
> +	int err = 0;
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
> +		err = counter_get_data(counter, comp_node, &ev.value);
> +		if (err)
> +			goto exit_early;

It looks like this will skip an event even if just one watch value
has an error. This doesn't seem so great.


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
> +	return err;

Interrupt handlers can't really do anything about the error here.
It could be nice to instead add an error field to the userspace
event struct, then userspace would know when an error occurred
and could do something about it. And it also fixes the one-error-
skips-all problem I mentioned above.

> +}
> +EXPORT_SYMBOL_GPL(counter_push_event);



> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 3f3f8ba6c1b4..98cd7c035968 100644
> --- a/include/linux/counter.h


> 
> +/**
> + * struct counter_event_node - Counter Event node
> + * @l:		list of current watching Counter events
> + * @event:	event that triggers
> + * @channel:	event channel
> + * @comp_list:	list of components to watch when event triggers
> + */
> +struct counter_event_node {
> +	struct list_head l;
> +	u8 event;
> +	u8 channel;
> +	struct list_head comp_list;
> +};
> +


Unless this is needed outside of the drivers/counter/ directory, I
would suggest putting it in drivers/counter/counter-chrdev.h instead
of include/linux/counter.h.
