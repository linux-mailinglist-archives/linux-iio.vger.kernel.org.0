Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81F0291863
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 18:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgJRQtK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgJRQtK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Oct 2020 12:49:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3AC061755;
        Sun, 18 Oct 2020 09:49:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c2so6074756qkf.10;
        Sun, 18 Oct 2020 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=muYtMvJ4UCQEDRFkrd89Gaqw/zKMWK3YmgO4yypshKo=;
        b=X4Wv7BSJOQA5A7ERLvkSKsake68tkTsxycRsGktheEpUXp0R/9HJoI0I+fvKLQNMOD
         YkPraVX6wFn2slaKjzvzZ0vjkjcUtKtGZgGpbgTYQnH/E0lCQHgHRWgMu5io6qciW7RU
         C2RS2GTkiu3Mi0WhC+3Hix0bqPQC3vwgY2tuyp8pI4eMpFRmTm39YOpRi4b8mwUeHQkt
         hFAHttqjL8h7vzoAK6SIibGeBFEvHqTGgRQOADyvRW9IIfJJL44hI++pZyqZ0mQ2+Df/
         pWAPhsJQusjhcIL73XG+3WdpWEvn0iFuTtOHiDtzAS9n0AfDQjOPR92b/3enpBGY4DgZ
         VwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=muYtMvJ4UCQEDRFkrd89Gaqw/zKMWK3YmgO4yypshKo=;
        b=SGibKg/SMdhN6wTiX513u4E7r2HOor8aut6ILh8iFlMx/q5OCo3GDekW4qogpq/zuR
         TBew1jH0/nfPLuz5ImFmfcVkA1zsh7N6Mb9jEtkmX3RSv1FW8LZdtfOxPprnnngmYmOa
         /O5kps5OO9WpAsoBYr/kq6/ekEGxrGLkTHv0udiEU3u69cifZwFinP8o2siclp5SMxVV
         /BEaqL+9zZHryiJCFMuO6G3j1vi6+qzzz/vn4fwqDAJ3sM+vPcpqb7WgufV0tgLs9A1S
         tj756mOGpU9PZoNGUycdEi7M95tb9qHEiWqZU6G5WRSVDcY0tKer/C9PYRgBVb3ZuR0t
         dExw==
X-Gm-Message-State: AOAM532IjCG4qPVcZe26+7pBjcISJIz1Flwn99P4VnsfZGBZjWgkFXow
        okKOiKDT4JBlW0nq7oBRGao=
X-Google-Smtp-Source: ABdhPJySDToG/SLPFhTZmFId7z8g0dN2BHZX39UIvI3m+AcFd4fovSyh69A7x1vdLPnMF0XHL8qksw==
X-Received: by 2002:a05:620a:52e:: with SMTP id h14mr6858506qkh.281.1603039748930;
        Sun, 18 Oct 2020 09:49:08 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id e19sm1842214qkl.94.2020.10.18.09.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 09:49:08 -0700 (PDT)
Date:   Sun, 18 Oct 2020 12:49:05 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Subject: Re: [PATCH v5 3/5] counter: Add character device interface
Message-ID: <20201018164905.GD231549@shinobu>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
 <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
 <181eb08a-be0a-f7cc-259d-b2a0f279950b@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <181eb08a-be0a-f7cc-259d-b2a0f279950b@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 08:40:18PM -0500, David Lechner wrote:
> On 9/26/20 9:18 PM, William Breathitt Gray wrote:
> > This patch introduces a character device interface for the Counter
> > subsystem. Device data is exposed through standard character device read
> > operations. Device data is gathered when a Counter event is pushed by
> > the respective Counter device driver. Configuration is handled via ioctl
> > operations on the respective Counter character device node.
> >=20
>=20
> Probably don't need to duplicate the full documentation in the commit
> message.

Ack.

> > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter=
-chrdev.c
> > new file mode 100644
> > index 000000000000..2be3846e4105
> > --- /dev/null
> > +++ b/drivers/counter/counter-chrdev.c
>=20
>=20
> > +
> > +static int counter_set_event_node(struct counter_device *const counter,
> > +				  struct counter_watch *const watch,
> > +				  const struct counter_comp_node *const cfg)
> > +{
> > +	struct counter_event_node *event_node;
> > +	int err;
> > +	struct counter_comp_node *comp_node;
> > +
> > +	/* Search for event in the list */
> > +	list_for_each_entry(event_node, &counter->next_events_list, l)
> > +		if (event_node->event =3D=3D watch->event &&
> > +		    event_node->channel =3D=3D watch->channel)
> > +			break;
> > +
> > +	/* If event is not already in the list */
> > +	if (&event_node->l =3D=3D &counter->next_events_list) {
> > +		/* Allocate new event node */
> > +		event_node =3D kmalloc(sizeof(*event_node), GFP_ATOMIC);
> > +		if (!event_node)
> > +			return -ENOMEM;
> > +
> > +		/* Configure event node and add to the list */
> > +		event_node->event =3D watch->event;
> > +		event_node->channel =3D watch->channel;
> > +		INIT_LIST_HEAD(&event_node->comp_list);
> > +		list_add(&event_node->l, &counter->next_events_list);
> > +	}
> > +
> > +	/* Check if component watch has already been set before */
> > +	list_for_each_entry(comp_node, &event_node->comp_list, l)
> > +		if (comp_node->parent =3D=3D cfg->parent &&
> > +		    comp_node->comp.count_u8_read =3D=3D cfg->comp.count_u8_read)
> > +			return -EINVAL;
>=20
> There are already enough things that could cause EINVAL, we could
> probably skip this duplicate check to make troubleshooting easier.

I'm not sure it would be safe to remove this check. This prevents
duplicate watches from being allocated for the same component -- the
rationale is that there's no benefit in repeating a component value grab
for the same event. Although a typical user will not have the motivation
to do this, a bad actor could purposely keep allocating duplicate
watches in order to starve all the available memory.

> > +
> > +	/* Allocate component node */
> > +	comp_node =3D kmalloc(sizeof(*comp_node), GFP_ATOMIC);
> > +	if (!comp_node) {
> > +		err =3D -ENOMEM;
> > +		goto err_comp_node;
>=20
> Since there is only one goto, we could just handle the error and
> return here instead.

Ack.

> > +	}
> > +	*comp_node =3D *cfg;
> > +
> > +	/* Add component node to event node */
> > +	list_add_tail(&comp_node->l, &event_node->comp_list);
> > +
> > +	return 0;
> > +
> > +err_comp_node:
>=20
> A comment explaining the list_empty() check would be nice.
> It makes sense if you think about it, but it is not super
> obvious.

Ack.

> > +	if (list_empty(&event_node->comp_list)) {
> > +		list_del(&event_node->l);
> > +		kfree(event_node);
> > +	}
> > +	return err;
> > +}
> > +
> > +static int counter_set_watch(struct counter_device *const counter,
> > +			     const unsigned long arg)
> > +{
> > +	void __user *const uwatch =3D (void __user *)arg;
> > +	struct counter_watch watch;
> > +	struct counter_comp_node comp_node;
> > +	size_t parent, id;
> > +	struct counter_comp *ext;
> > +	size_t num_ext;
> > +
> > +	if (copy_from_user(&watch, uwatch, sizeof(watch)))
> > +		return -EFAULT;
> > +	parent =3D watch.component.parent;
> > +	id =3D watch.component.id;
> > +
> > +	/* Configure parent component info for comp node */
> > +	switch (watch.component.scope) {
> > +	case COUNTER_SCOPE_DEVICE:
> > +		comp_node.parent =3D NULL;
> > +
> > +		ext =3D counter->ext;
> > +		num_ext =3D counter->num_ext;
> > +		break;
> > +	case COUNTER_SCOPE_SIGNAL:
> > +		if (counter->num_signals < parent + 1)
>=20
> I think it would be more conventional this way:
>=20
> 	if (parent >=3D counter->num_signals)

Ack.

> > +			return -EINVAL;
> > +
> > +		comp_node.parent =3D counter->signals + parent;
> > +
> > +		ext =3D counter->signals[parent].ext;
> > +		num_ext =3D counter->signals[parent].num_ext;
> > +		break;
> > +	case COUNTER_SCOPE_COUNT:
> > +		if (counter->num_counts < parent + 1)
>=20
> Same here.

Ack.

> > +			return -EINVAL;
> > +
> > +		comp_node.parent =3D counter->counts + parent;
> > +
> > +		ext =3D counter->counts[parent].ext;
> > +		num_ext =3D counter->counts[parent].num_ext;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Configure component info for comp node */
> > +	switch (watch.component.type) {
> > +	case COUNTER_COMPONENT_SIGNAL:
> > +		if (watch.component.scope !=3D COUNTER_SCOPE_SIGNAL)
> > +			return -EINVAL;
> > +
> > +		comp_node.comp.type =3D COUNTER_COMP_SIGNAL_LEVEL;
> > +		comp_node.comp.signal_u8_read =3D counter->ops->signal_read;
> > +		break;
> > +	case COUNTER_COMPONENT_COUNT:
> > +		if (watch.component.scope !=3D COUNTER_SCOPE_COUNT)
> > +			return -EINVAL;
> > +
> > +		comp_node.comp.type =3D COUNTER_COMP_U64;
> > +		comp_node.comp.count_u64_read =3D counter->ops->count_read;
> > +		break;
> > +	case COUNTER_COMPONENT_FUNCTION:
> > +		if (watch.component.scope !=3D COUNTER_SCOPE_COUNT)
> > +			return -EINVAL;
> > +
> > +		comp_node.comp.type =3D COUNTER_COMP_FUNCTION;
> > +		comp_node.comp.count_u8_read =3D counter->ops->function_read;
> > +		break;
> > +	case COUNTER_COMPONENT_SYNAPSE_ACTION:
> > +		if (watch.component.scope !=3D COUNTER_SCOPE_COUNT)
> > +			return -EINVAL;
> > +		if (counter->counts[parent].num_synapses < id + 1)
>=20
> 	if (id >=3D counter->counts[parent].num_synapses)

Ack.

> > +			return -EINVAL;
> > +
> > +		comp_node.comp.type =3D COUNTER_COMP_SYNAPSE_ACTION;
> > +		comp_node.comp.action_read =3D counter->ops->action_read;
> > +		comp_node.comp.priv =3D counter->counts[parent].synapses + id;
> > +		break;
> > +	case COUNTER_COMPONENT_EXTENSION:
> > +		if (num_ext < id + 1)
>=20
> 	if (id >=3D num_ext)

Ack.

> > +			return -EINVAL;
> > +
> > +		comp_node.comp =3D ext[id];
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	if (!comp_node.comp.count_u8_read)
>=20
> A comment reminding us that count_u8_read is part of a union
> would be helpful here since this is checking that any read
> function was set, not just count_u8_read.

Ack.

> > +		return -EFAULT;
>=20
> Would EOPNOTSUPP be a better error choice?

You're right, that would be a more apt return.

> > +	comp_node.component =3D watch.component;
> > +
> > +	return counter_set_event_node(counter, &watch, &comp_node);
> > +}
> > +
> > +static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
> > +				 unsigned long arg)
> > +{
> > +	struct counter_device *const counter =3D filp->private_data;
> > +	raw_spinlock_t *const events_lock =3D &counter->events_lock;
> > +	unsigned long flags;
> > +	struct list_head *const events_list =3D &counter->events_list;
> > +	struct list_head *const next_events_list =3D &counter->next_events_li=
st;
> > +
> > +	switch (cmd) {
> > +	case COUNTER_CLEAR_WATCHES_IOCTL:
> > +		raw_spin_lock_irqsave(events_lock, flags);
> > +		counter_events_list_free(events_list);
> > +		raw_spin_unlock_irqrestore(events_lock, flags);
> > +		counter_events_list_free(next_events_list);
>=20
> I think this ioctl is doing too much. If we have to use it for both
> stopping events and clearing the list accumulated by
> COUNTER_SET_WATCH_IOCTL, then we have a race condition of no events
> after clearing watches during the time we are adding new ones and
> until we load the new ones.
>=20
> It would probably make more sense to call this ioctl
> COUNTER_STOP_WATCHES_IOCTL and move counter_events_list_free(
> next_events_list) to the end of COUNTER_LOAD_WATCHES_IOCTL.

I don't think we will necessarily have a race condition here.
COUNTER_CLEAR_WATCHES_IOCTL is intended to just clear the watches; e.g.
bring us back to a clear state when some sort of job has completely
finished and the user is no longer going to watch events for a while
(maybe they're adjusting the conveyor for the next job or some similar
operation).

I think the scenario you're concerned about is when you need to swap
watches in the middle of a job without losing events. In this case, you
wouldn't need to use COUNTER_CLEAR_WATCHES_IOCTL at all. Instead, you
would just set up the watches via COUNTER_SET_WATCH_IOCTL, and then use
COUNTER_LOAD_WATCHES_IOCTL to perform the swap; after
COUNTER_LOAD_WATCHES_IOCTL completes, next_events_list is empty (thanks
to list_replace_init()) and you're ready for the next set of watches.

> > +		break;
> > +	case COUNTER_SET_WATCH_IOCTL:
> > +		return counter_set_watch(counter, arg);
>=20
>=20
> Would it make more sense to call this COUNTER_ADD_WATCH_IOCTL since it
> adds a watch to the list that will be loaded/enabled later?

That's a good point because "set" might easily be confused for a
configuration operation. I'll rename this to be clearer.

> > +	case COUNTER_LOAD_WATCHES_IOCTL:
> > +		raw_spin_lock_irqsave(events_lock, flags);
> > +		counter_events_list_free(events_list);
> > +		list_replace_init(next_events_list, events_list);
> > +		raw_spin_unlock_irqrestore(events_lock, flags);
>=20
> For the eQEP driver, we will need a callback here to configure
> interrupts for the events. Likewise a callback would be needed
> here (for the case when we are replacing already loaded watches)
> and in COUNTER_STOP_WATCHES_IOCTL to unconfigure them.

Ack, I'll add in a callback for interrupt configuration where needed.

> > +		break;
> > +	default:
> > +		return -ENOIOCTLCMD;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int counter_chrdev_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct counter_device *const counter =3D container_of(inode->i_cdev,
> > +							    typeof(*counter),
> > +							    chrdev);
> > +
> > +	get_device(&counter->dev);
> > +	filp->private_data =3D counter;
> > +
> > +	return nonseekable_open(inode, filp);
> > +}
> > +
> > +static int counter_chrdev_release(struct inode *inode, struct file *fi=
lp)
> > +{
> > +	struct counter_device *const counter =3D filp->private_data;
> > +	unsigned long flags;
> > +
> > +	put_device(&counter->dev);
>=20
> put_device() should be at the end of the function in case it is the last
> reference.

put_device() shouldn't affect the counter_device events members, so I
don't think there's a difference in this case if it's called at the
beginning or end of the counter_chrdev_release function.

> > +
> > +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> > +	counter_events_list_free(&counter->events_list);
> > +	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> > +	counter_events_list_free(&counter->next_events_list);
> > +
> > +	return 0;
> > +}
> > +
>=20
> > +int counter_push_event(struct counter_device *const counter, const u8 =
event,
> > +		       const u8 channel)
> > +{
> > +	struct counter_event ev =3D {0};
> > +	unsigned int copied =3D 0;
> > +	unsigned long flags;
> > +	struct counter_event_node *event_node;
> > +	struct counter_comp_node *comp_node;
> > +	int err;
> > +
> > +	ev.timestamp =3D ktime_get_ns();
> > +	ev.watch.event =3D event;
> > +	ev.watch.channel =3D channel;
> > +
> > +	raw_spin_lock_irqsave(&counter->events_lock, flags);
> > +
> > +	/* Search for event in the list */
> > +	list_for_each_entry(event_node, &counter->events_list, l)
> > +		if (event_node->event =3D=3D event &&
> > +		    event_node->channel =3D=3D channel)
> > +			break;
> > +
> > +	/* If event is not in the list */
> > +	if (&event_node->l =3D=3D &counter->events_list)
> > +		goto exit_early;
> > +
> > +	/* Read and queue relevant comp for userspace */
> > +	list_for_each_entry(comp_node, &event_node->comp_list, l) {
> > +		err =3D counter_get_data(counter, comp_node, &ev.value_u8);
> > +		if (err)
> > +			goto err_counter_get_data;
> > +
> > +		ev.watch.component =3D comp_node->component;
> > +
> > +		copied +=3D kfifo_put(&counter->events, ev);
> > +	}
> > +
> > +	if (copied)
> > +		wake_up_poll(&counter->events_wait, EPOLLIN);
> > +
> > +exit_early:
> > +	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> > +
> > +	return 0;
> > +
> > +err_counter_get_data:
> > +	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
> > +	return err;
>=20
> This seems slightly redundant. Could just initialize err to 0
> and combine the two labels.

Ack.

> > +}
> > +EXPORT_SYMBOL_GPL(counter_push_event);
>=20
>=20
> > diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-=
sysfs.c
> > index e66ed99dd5ea..cefef61f170d 100644
> > --- a/drivers/counter/counter-sysfs.c
> > +++ b/drivers/counter/counter-sysfs.c
>=20
>=20
> Not sure why sysfs changes are in the chrdev patch. Are these
> changes related somehow?

Sorry, I forgot to explain this in the cover letter. The changes here
are only useful for the character device interface. These changes
introduce the extensionZ_name and extensionZ_width sysfs attributes.

In the character device interface, extensions are selected by their id
number, and the value returned depends on the type of data. The new
sysfs attributes introduced here allow users to match the id of an
extension with its name, as well as the bit width of the value returned
so that the user knows whether to use the value_u8 or value_u64 union
member in struct counter_event.

> > diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> > new file mode 100644
> > index 000000000000..ad9a8686b2b0
> > --- /dev/null
> > +++ b/include/uapi/linux/counter.h
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Userspace ABI for Counter character devices
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#ifndef _UAPI_COUNTER_H_
> > +#define _UAPI_COUNTER_H_
> > +
> > +#include <linux/ioctl.h>
> > +#include <linux/types.h>
>=20
> It would be very helpful to have documentation comments for all of
> the defines in this file.

Ack.

> > +
> > +#define COUNTER_SCOPE_DEVICE 0
> > +#define COUNTER_SCOPE_SIGNAL 1
> > +#define COUNTER_SCOPE_COUNT 2
> > +
> > +#define COUNTER_COMPONENT_SIGNAL 0
> > +#define COUNTER_COMPONENT_COUNT 1
> > +#define COUNTER_COMPONENT_FUNCTION 2
> > +#define COUNTER_COMPONENT_SYNAPSE_ACTION 3
> > +#define COUNTER_COMPONENT_EXTENSION 4
>=20
> There are probably some cases where we will want to just
> have an event without reading a component value, so we
> could use something like COUNTER_SCOPE_NONE and
> COUNTER_COMPONENT_NONE here.

I'll come up with a solution for this use-case.

> > +
> > +/**
> > + * struct counter_component - Counter component identification
> > + * @scope: component scope (Device, Count, or Signal)
> > + * @parent: parent component identification number
> > + * @type: component type (Count, extension, etc.)
> > + * @id: component identification number
> > + */
> > +struct counter_component {
> > +	__u8 scope;
> > +	__u64 parent;
> > +	__u8 type;
> > +	__u64 id;
> > +};
>=20
>=20
> This will have alignment issues, e.g. when 64-bit kernel is used
> with a 32-bit userspace. It looks like there is a __aligned_u64
> type to help with this. But, unless we expect more that 4 billion
> counter devices, there doesn't seem to be a reason for parent
> and id to be 64-bit.

Fair point, I'll redefine these id as __u8 since it's unlikely we'll
ever have a device that needs more than 255 components.

> > +
> > +#define COUNTER_EVENT_OVERFLOW 0
> > +#define COUNTER_EVENT_UNDERFLOW 1
> > +#define COUNTER_EVENT_OVERFLOW_UNDERFLOW 2
>=20
> Would it make sense to just have individual overflow and
> underflow events? For example, the Carry-Borrow interrupt
> on 104-quad-8 could just call counter_push_event() twice.

I can see what you mean, but I think a dedicated OVERFLOW_UNDERFLOW
event is useful because of the directional implications of an OVERFLOW
or UNDERFLOW event by itself: if we see an OVERFLOW event we can be
certain that the counter changed conceptually from a ceiling value to
floor value (and vice-versa for an UNDERFLOW event). By providing the
OVERFLOW_UNDERFLOW event we have an explicit way to indicate that the
device is not concerned with the direction of the change that trigger
the event. I think that's useful information to have for a user.

> > +#define COUNTER_EVENT_THRESHOLD 3
> > +#define COUNTER_EVENT_INDEX 4
> > +
> > +/**
> > + * struct counter_watch - Counter component watch configuration
> > + * @event: event that triggers
> > + * @channel: event channel
>=20
> How is channel intended to be used? (The device I am working with
> I assume would ignore the channel since it is just a single counter.)

Yes, this is for physical devices that have multiple counters
("channels") such as the 104-QUAD-8 which has 8 available on a single
PC104 card. For the device you're working on, you would probably just
set channel to 0 for all your uses since you only have one counter.

> > + * @component: component to watch when event triggers
> > + */
> > +struct counter_watch {
> > +	__u8 event;
> > +	__u8 channel;
> > +	struct counter_component component;
> > +};
>=20
> To get the most compact layout, usually fields are ordered largest to sma=
llest.

Ack.

> > +
> > +#define COUNTER_CLEAR_WATCHES_IOCTL _IO(0x3E, 0x00)
> > +#define COUNTER_SET_WATCH_IOCTL _IOW(0x3E, 0x01, struct counter_watch)
> > +#define COUNTER_LOAD_WATCHES_IOCTL _IO(0x3E, 0x02)
> > +
> > +/**
> > + * struct counter_event - Counter event data
> > + * @timestamp: best estimate of time of event occurrence, in nanosecon=
ds
> > + * @watch: component watch configuration
> > + * @value_u8: component value as __u8 data type
> > + * @value_u64: component value as __u64 data type
> > + */
> > +struct counter_event {
> > +	__u64 timestamp;
> > +	struct counter_watch watch;
> > +	union {
> > +		__u8 value_u8;
> > +		__u64 value_u64;
> > +	};
> > +};
>=20
> Should probably use __aligned_u64 here too.

Ack.

> > +
> > +#define COUNTER_COUNT_DIRECTION_FORWARD 0
> > +#define COUNTER_COUNT_DIRECTION_BACKWARD 1
> > +
> > +#define COUNTER_COUNT_MODE_NORMAL 0
> > +#define COUNTER_COUNT_MODE_RANGE_LIMIT 1
> > +#define COUNTER_COUNT_MODE_NON_RECYCLE 2
> > +#define COUNTER_COUNT_MODE_MODULO_N 3
> > +
> > +#define COUNTER_FUNCTION_INCREASE 0
> > +#define COUNTER_FUNCTION_DECREASE 1
> > +#define COUNTER_FUNCTION_PULSE_DIRECTION 2
> > +#define COUNTER_FUNCTION_QUADRATURE_X1_A 3
> > +#define COUNTER_FUNCTION_QUADRATURE_X1_B 4
> > +#define COUNTER_FUNCTION_QUADRATURE_X2_A 5
> > +#define COUNTER_FUNCTION_QUADRATURE_X2_B 6
> > +#define COUNTER_FUNCTION_QUADRATURE_X4 7
> > +
> > +#define COUNTER_SIGNAL_LEVEL_LOW 0
> > +#define COUNTER_SIGNAL_LEVEL_HIGH 1
> > +
> > +#define COUNTER_SYNAPSE_ACTION_NONE 0
> > +#define COUNTER_SYNAPSE_ACTION_RISING_EDGE 1
> > +#define COUNTER_SYNAPSE_ACTION_FALLING_EDGE 2
> > +#define COUNTER_SYNAPSE_ACTION_BOTH_EDGES 3
> > +
> > +#endif /* _UAPI_COUNTER_H_ */
> >=20
>=20
>=20
> Overall, I think we are getting close. I've started adding
> events to the TI eQEP driver. You can find the code at [1].
> I still have a bit of work to do to add the timer and edge
> capture events.
>=20
> [1]: https://github.com/dlech/linux/tree/bone-counter

I just want to mention again that I appreciate all the reviews you send
for these patchsets, it really helps to have someone to bounce ideas off
of as well an extra set of eyes to catch all the silly bugs that I miss
during the revisions. :-)

Thanks,

William Breathitt Gray

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl+McfYACgkQhvpINdm7
VJIRrA/+PNJdqFodh8Krdn2lLzoJ5WptGuSY1wL/G8lhX2N6AhDAkzd0LxhLOELu
5S4u+gTFyaZwmzrXBwcSGo3YWzhrdP1MxIDd2hy1Kj/7NGy+PFYAzAfF+ukofPXd
QqMAwJBKeHu/RSjPAiz9Y3keRfRPpwUMHAbtTaVQQ0IJhXiDCIdcnKPJmknJ1OUR
sgGRWanr/DkXKpipifUZf5naJLDu7hyb9hSd4rX37vao3UaYgW0o1UtZR6XxsTH8
6UOpCre7UrBsVNieIW8LLlNT1rfZwejJ3hCkCytnZXkklhVfwWr/Eg8kGeZ9zBFw
FaarEGjqovgtqmZQzK+vprWwB5RbOKHgpOG1tW1c6/2ooWOGcDdPTpv7DYfsFR8b
mJ7QJQJMz3UEqMmy61WWERzucYX0VSU1t8f6toJaDey9OXuQH2B38oiAtS1uNv8V
cB8b9VI9jSz92C4Y0UZx04dgsvZDLOpyFSKO6Kbm4PbghIjW5xa6ifmZR5AWjpSp
jvkXlhnF7RJnB66IIO7drgJ//7WHVK7eutWqgKK8y+Ah02flhiIhnSAQ94QaA2TG
eBnG8HTDMNFj2mLKwVYTwgjuOaLr8wY4ecIedUiyYKjdcm2CBBUVLF7qWjKBzPpk
3+a9YU1zABlKAlvivdEd+fZF7YNNUvgugFHTIbpfU4Xtl4YL+aQ=
=2LNY
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
