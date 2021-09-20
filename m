Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E739941129E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbhITKKt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 06:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbhITKKt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 06:10:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFCDC061574;
        Mon, 20 Sep 2021 03:09:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so14786898pjc.3;
        Mon, 20 Sep 2021 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jEw6ewTR3ozZpsk8llej9mRRBdduIyxxFKpRZg1GKUQ=;
        b=YnQsHkfXvWZPEe9ZjQ1yqRPgNyun3gx/sUG9jh5l6Rm3dZ78XhYqD+lqxQOk+7MBla
         QzI30wkNrReOZ0T2CZZcO1cuoMj6TqQA0HN8OUGzfvf93SKL4i0RB49mkuGodDtCtpEv
         decykc6Aea4pt0kwheR9nLzcEqLNXF0nAJ0JNDJmJ3uN43XB9TIj1HbPlw0m2ra5UJBZ
         qagKBaHm0CI65xOoXkiWY76BuFTEyfPZw3POW+ALsZZ8dX/DfY8VPLJZFFCwDoZbsJ5T
         3/OVgrGfo1XgZEoCkbhJsl6yeq0CfuwREjKGaqPKsiPq4O8HwqaEXo6taAd0U7vN4gzn
         SYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jEw6ewTR3ozZpsk8llej9mRRBdduIyxxFKpRZg1GKUQ=;
        b=M19xjWdyD928hhr1xJyQg3F79WwmNKLWdULTKnYZZ/0lhIfF5ITpDCO3n0N47u+w1l
         uSQG1FMZ3c8rpCERILExP++97s0iRs4jgXPS38NDFSlHMZh9r7YabYaFOuiEkP0Ff+Gi
         dXJWzCOUl9WCkAUtR6U8SOUSrG2SORai3zGN/kmZNjwb319/8Kodk1tYlEbFjKOW6DZf
         tmZuNIMvOz9I/tk4C2uG+Tz2Cjdg/MxurzY96k8rqNDaCc6PLWrdvfmnOC7WcBagE+8I
         plsT8IMiu6uNDRpe2R3uL5MKMZAKZd9PUZg+tSpdfh7VExQBAq9IyU/u3nkZUAGFCqBM
         xRmw==
X-Gm-Message-State: AOAM5318MhIdQULkpKpWRpb5Ci3J2bI6avuhOKrzKpdClIal7/SSMakm
        CqXz1UFxncOMiuPoA47NYlk=
X-Google-Smtp-Source: ABdhPJyUGw0LEb09EuBDiZnycBJUtLbCjbpYAyPz4FY8wowDMPJ5GJlRlT7Nx3pWt4YWaaX6Xm1P2w==
X-Received: by 2002:a17:90b:14cc:: with SMTP id jz12mr28264217pjb.203.1632132561752;
        Mon, 20 Sep 2021 03:09:21 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 10sm15176743pgd.12.2021.09.20.03.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 03:09:20 -0700 (PDT)
Date:   Mon, 20 Sep 2021 19:09:13 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v16 07/14] counter: Add character device interface
Message-ID: <YUhdyRdzuBtUxOzT@shinobu>
References: <cover.1630031207.git.vilhelm.gray@gmail.com>
 <422c765c91d060cdebc4f17f7aeb255d9c1a4e16.1630031207.git.vilhelm.gray@gmail.com>
 <20210912171821.54af145b@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P6Q0QPYh5Th9wkzC"
Content-Disposition: inline
In-Reply-To: <20210912171821.54af145b@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--P6Q0QPYh5Th9wkzC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 12, 2021 at 05:18:42PM +0100, Jonathan Cameron wrote:
> On Fri, 27 Aug 2021 12:47:51 +0900
> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>=20
> > This patch introduces a character device interface for the Counter
> > subsystem. Device data is exposed through standard character device read
> > operations. Device data is gathered when a Counter event is pushed by
> > the respective Counter device driver. Configuration is handled via ioctl
> > operations on the respective Counter character device node.
> >=20
> > Cc: David Lechner <david@lechnology.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> Hi William,
>=20
> Why the bit based lock?  It feels like a mutex_trylock() type approach or
> spinlock_trylock() would be a more common solution to this problem.
> There is precedence for doing what you have here though so I'm not that
> worried about it.

Hi Jonathan,

We originally used a mutex for this, but Jarkko discovered that this
produced a warning because chrdev_lock would be held when returning to
user space:
https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m60721=
33d418d598a5f368bb942c945e46cfab9a5

Following David Lechner's suggestion, I decided to reimplement
chrdev_lock as a bitmap using an atomic flag.

> There are a few more things inline.
>=20
> I've now been through this patch with as fine toothed comb as I'm likely =
to
> do so.  Hence I won't do another review unless there are substantial chan=
ges.
> I nearly applied it as it stands, but given we aren't in a rush (merge wi=
ndow
> open), it's worth just a little more time to tidy up loose ends.
>=20
> Jonathan

Responses follow below.

> > ---
> >  drivers/counter/Makefile         |   2 +-
> >  drivers/counter/counter-chrdev.c | 553 +++++++++++++++++++++++++++++++
> >  drivers/counter/counter-chrdev.h |  14 +
> >  drivers/counter/counter-core.c   |  60 +++-
> >  include/linux/counter.h          |  51 +++
> >  include/uapi/linux/counter.h     |  98 ++++++
> >  6 files changed, 770 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/counter/counter-chrdev.c
> >  create mode 100644 drivers/counter/counter-chrdev.h
> >=20
> > diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> > index 1ab7e087fdc2..8fde6c100ebc 100644
> > --- a/drivers/counter/Makefile
> > +++ b/drivers/counter/Makefile
> > @@ -4,7 +4,7 @@
> >  #
> > =20
> >  obj-$(CONFIG_COUNTER) +=3D counter.o
> > -counter-y :=3D counter-core.o counter-sysfs.o
> > +counter-y :=3D counter-core.o counter-sysfs.o counter-chrdev.o
> > =20
> >  obj-$(CONFIG_104_QUAD_8)	+=3D 104-quad-8.o
> >  obj-$(CONFIG_INTERRUPT_CNT)		+=3D interrupt-cnt.o
> > diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter=
-chrdev.c
> > new file mode 100644
> > index 000000000000..30659b67d8f3
> > --- /dev/null
> > +++ b/drivers/counter/counter-chrdev.c
> > @@ -0,0 +1,553 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Generic Counter character device interface
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#include <linux/bitops.h>
> > +#include <linux/cdev.h>
> > +#include <linux/counter.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/export.h>
> > +#include <linux/fs.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/list.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nospec.h>
> > +#include <linux/poll.h>
> > +#include <linux/slab.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/timekeeping.h>
> > +#include <linux/types.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/wait.h>
> > +
> > +#include "counter-chrdev.h"
> > +
> > +struct counter_comp_node {
> > +	struct list_head l;
> > +	struct counter_component component;
> > +	struct counter_comp comp;
> > +	void *parent;
> > +};
> > +
> > +static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
> > +				   size_t len, loff_t *f_ps)
> > +{
> > +	struct counter_device *const counter =3D filp->private_data;
> > +	int err;
> > +	unsigned int copied;
> > +
> > +	if (!counter->ops)
> > +		return -ENODEV;
> > +
> > +	if (len < sizeof(struct counter_event))
> > +		return -EINVAL;
> > +
> > +	do {
> > +		if (kfifo_is_empty(&counter->events)) {
> > +			if (filp->f_flags & O_NONBLOCK)
> > +				return -EAGAIN;
> > +
> > +			err =3D wait_event_interruptible(counter->events_wait,
> > +					!kfifo_is_empty(&counter->events) ||
> > +					!counter->ops);
> > +			if (err < 0)
> > +				return err;
> > +			if (!counter->ops)
> > +				return -ENODEV;
> > +		}
> > +
> > +		if (mutex_lock_interruptible(&counter->events_lock))
> > +			return -ERESTARTSYS;
> > +		err =3D kfifo_to_user(&counter->events, buf, len, &copied);
> > +		mutex_unlock(&counter->events_lock);
> > +		if (err < 0)
> > +			return err;
> > +	} while (!copied);
> > +
> > +	return copied;
> > +}
> > +
> > +static __poll_t counter_chrdev_poll(struct file *filp,
> > +				    struct poll_table_struct *pollt)
> > +{
> > +	struct counter_device *const counter =3D filp->private_data;
> > +	__poll_t events =3D 0;
> > +
> > +	if (!counter->ops)
> > +		return events;
> > +
> > +	poll_wait(filp, &counter->events_wait, pollt);
> > +
> > +	if (!kfifo_is_empty(&counter->events))
> > +		events =3D EPOLLIN | EPOLLRDNORM;
> > +
> > +	return events;
> > +}
> > +
> > +static void counter_events_list_free(struct list_head *const events_li=
st)
> > +{
> > +	struct counter_event_node *p, *n;
> > +	struct counter_comp_node *q, *o;
> > +
> > +	list_for_each_entry_safe(p, n, events_list, l) {
> > +		/* Free associated component nodes */
> > +		list_for_each_entry_safe(q, o, &p->comp_list, l) {
> > +			list_del(&q->l);
> > +			kfree(q);
> > +		}
> > +
> > +		/* Free event node */
> > +		list_del(&p->l);
> > +		kfree(p);
> > +	}
> > +}
> > +
> > +static int counter_set_event_node(struct counter_device *const counter,
> > +				  struct counter_watch *const watch,
> > +				  const struct counter_comp_node *const cfg)
> > +{
> > +	struct counter_event_node *event_node;
> > +	int err =3D 0;
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
> > +		event_node =3D kmalloc(sizeof(*event_node), GFP_KERNEL);
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
> > +		    comp_node->comp.count_u8_read =3D=3D cfg->comp.count_u8_read) {
> > +			err =3D -EINVAL;
> > +			goto exit_free_event_node;
> > +		}
> > +
> > +	/* Allocate component node */
> > +	comp_node =3D kmalloc(sizeof(*comp_node), GFP_KERNEL);
> > +	if (!comp_node) {
> > +		err =3D -ENOMEM;
> > +		goto exit_free_event_node;
> > +	}
> > +	*comp_node =3D *cfg;
> > +
> > +	/* Add component node to event node */
> > +	list_add_tail(&comp_node->l, &event_node->comp_list);
> > +
> > +exit_free_event_node:
> > +	/* Free event node if no one else is watching */
> > +	if (list_empty(&event_node->comp_list)) {
> > +		list_del(&event_node->l);
> > +		kfree(event_node);
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static int counter_enable_events(struct counter_device *const counter)
> > +{
> > +	unsigned long flags;
> > +	int err =3D 0;
> > +
> > +	mutex_lock(&counter->n_events_list_lock);
> > +	spin_lock_irqsave(&counter->events_list_lock, flags);
> > +
> > +	counter_events_list_free(&counter->events_list);
> > +	list_replace_init(&counter->next_events_list,
> > +			  &counter->events_list);
> > +
> > +	if (counter->ops->events_configure)
> > +		err =3D counter->ops->events_configure(counter);
> > +
> > +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> > +	mutex_unlock(&counter->n_events_list_lock);
> > +
> > +	return err;
> > +}
> > +
> > +static int counter_disable_events(struct counter_device *const counter)
> > +{
> > +	unsigned long flags;
> > +	int err =3D 0;
> > +
> > +	spin_lock_irqsave(&counter->events_list_lock, flags);
> > +
> > +	counter_events_list_free(&counter->events_list);
> > +
> > +	if (counter->ops->events_configure)
> > +		err =3D counter->ops->events_configure(counter);
> > +
> > +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> > +
> > +	mutex_lock(&counter->n_events_list_lock);
> > +
> > +	counter_events_list_free(&counter->next_events_list);
> > +
> > +	mutex_unlock(&counter->n_events_list_lock);
> > +
> > +	return err;
> > +}
> > +
> > +static int counter_add_watch(struct counter_device *const counter,
> > +			     const unsigned long arg)
> > +{
> > +	void __user *const uwatch =3D (void __user *)arg;
> > +	struct counter_watch watch;
> > +	struct counter_comp_node comp_node =3D {};
> > +	size_t parent, id;
> > +	struct counter_comp *ext;
> > +	size_t num_ext;
> > +	int err =3D 0;
> > +
> > +	if (copy_from_user(&watch, uwatch, sizeof(watch)))
> > +		return -EFAULT;
> > +
> > +	if (watch.component.type =3D=3D COUNTER_COMPONENT_NONE)
> > +		goto no_component;
> > +
> > +	parent =3D watch.component.parent;
> > +
> > +	/* Configure parent component info for comp node */
> > +	switch (watch.component.scope) {
> > +	case COUNTER_SCOPE_DEVICE:
> > +		ext =3D counter->ext;
> > +		num_ext =3D counter->num_ext;
> > +		break;
> > +	case COUNTER_SCOPE_SIGNAL:
> > +		if (parent >=3D counter->num_signals)
> > +			return -EINVAL;
> > +		parent =3D array_index_nospec(parent, counter->num_signals);
> > +
> > +		comp_node.parent =3D counter->signals + parent;
> > +
> > +		ext =3D counter->signals[parent].ext;
> > +		num_ext =3D counter->signals[parent].num_ext;
> > +		break;
> > +	case COUNTER_SCOPE_COUNT:
> > +		if (parent >=3D counter->num_counts)
> > +			return -EINVAL;
> > +		parent =3D array_index_nospec(parent, counter->num_counts);
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
> > +	id =3D watch.component.id;
> > +
> > +	/* Configure component info for comp node */
> > +	switch (watch.component.type) {
> > +	case COUNTER_COMPONENT_SIGNAL:
> > +		if (watch.component.scope !=3D COUNTER_SCOPE_SIGNAL)
> > +			return -EINVAL;
> > +
> > +		comp_node.comp.type =3D COUNTER_COMP_SIGNAL_LEVEL;
> > +		comp_node.comp.signal_u32_read =3D counter->ops->signal_read;
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
> > +		comp_node.comp.count_u32_read =3D counter->ops->function_read;
> > +		break;
> > +	case COUNTER_COMPONENT_SYNAPSE_ACTION:
> > +		if (watch.component.scope !=3D COUNTER_SCOPE_COUNT)
> > +			return -EINVAL;
> > +		if (id >=3D counter->counts[parent].num_synapses)
> > +			return -EINVAL;
> > +		id =3D array_index_nospec(id, counter->counts[parent].num_synapses);
> > +
> > +		comp_node.comp.type =3D COUNTER_COMP_SYNAPSE_ACTION;
> > +		comp_node.comp.action_read =3D counter->ops->action_read;
> > +		comp_node.comp.priv =3D counter->counts[parent].synapses + id;
> > +		break;
> > +	case COUNTER_COMPONENT_EXTENSION:
> > +		if (id >=3D num_ext)
> > +			return -EINVAL;
> > +		id =3D array_index_nospec(id, num_ext);
> > +
> > +		comp_node.comp =3D ext[id];
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +	/* Check if any read callback is set; this is part of a union */
> > +	if (!comp_node.comp.count_u8_read)
>=20
> This isn't valid for C.  The compiler is allowed to treat the elements
> of a union as not being in the same memory etc unless they are of the same
> type (which isn't true here - I think anyway)...
>=20
> So whilst it seems silly you need to check all the callbacks in this if
> statement. It will 'almost' always work as you have it, but it's possible
> some future optimisation by the compiler will mean that u8_read would be
> set by this point, but it delayed setting e.g. u32_read until after
> this check.

Ack, I'll recreate a couple macros to handle these checks.

> > +		return -EOPNOTSUPP;
> > +
> > +no_component:
> > +	mutex_lock(&counter->n_events_list_lock);
> > +
> > +	if (counter->ops->watch_validate) {
> > +		err =3D counter->ops->watch_validate(counter, &watch);
> > +		if (err < 0)
> > +			goto err_exit;
> > +	}
> > +
> > +	comp_node.component =3D watch.component;
> > +
> > +	err =3D counter_set_event_node(counter, &watch, &comp_node);
> > +
> > +err_exit:
> > +	mutex_unlock(&counter->n_events_list_lock);
> > +
> > +	return err;
> > +}
> > +
> > +static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
> > +				 unsigned long arg)
> > +{
> > +	struct counter_device *const counter =3D filp->private_data;
> > +	int ret =3D -ENODEV;
> > +
> > +	mutex_lock(&counter->ops_exist_lock);
> > +
> > +	if (!counter->ops)
> > +		goto out_unlock;
> > +
> > +	switch (cmd) {
> > +	case COUNTER_ADD_WATCH_IOCTL:
> > +		ret =3D counter_add_watch(counter, arg);
> > +		break;
> > +	case COUNTER_ENABLE_EVENTS_IOCTL:
> > +		ret =3D counter_enable_events(counter);
> > +		break;
> > +	case COUNTER_DISABLE_EVENTS_IOCTL:
> > +		ret =3D counter_disable_events(counter);
> > +		break;
> > +	default:
> > +		ret =3D -ENOIOCTLCMD;
> > +		break;
> > +	}
> > +
> > +out_unlock:
> > +	mutex_unlock(&counter->ops_exist_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int counter_chrdev_open(struct inode *inode, struct file *filp)
> > +{
> > +	struct counter_device *const counter =3D container_of(inode->i_cdev,
> > +							    typeof(*counter),
> > +							    chrdev);
> > +
> > +	if (test_and_set_bit_lock(0, counter->chrdev_lock))
> > +		return -EBUSY;
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
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&counter->ops_exist_lock);
> > +
> > +	if (!counter->ops) {
>=20
> This needs a comment to explain how you would get here and
> why these two lists need cleaning up here if we do.
>=20
> Superficially it feels to me like you could just add a counter->ops check=
 in
> counter_disable_events() and then call that directly.  I'm guessing
> I am missing a deadlock or similar however.

I don't believe there is a risk of a deadlock, I just felt this
conditional check isn't really related to the counter_disable_events()
path so I kept it seperate; the events lists are freed in
counter_disable_events() but that's incidental rather than the purpose
of the function. My reasoning for the separation is that there are two
scenarios where counter_chrdev_release is called: the first is when a
user closes the chrdev, while the second is when the Counter driver is
removed.

For the first scenario, the counter_disable_events() function is called
to stop events from firing off when noone has the chrdev open. In the
second scenario, we are not interested in disabling events, we know
we're no longer going to be interacting with this device again so we
want to free any held memory.

I want to keep the intention of these code paths clear because the
distinction is important if we start managing additional memory in the
future (i.e. memory unrelated to the events list that would not be freed
in counter_disable_events()), so I'll add a comment explaining what's
happening in this path. Alternatively, I could define a
counter_chrdev_free() function and toss those list free calls into
there, but perhaps that would be overkill right now for just two calls.

> > +		counter_events_list_free(&counter->events_list);
> > +		counter_events_list_free(&counter->next_events_list);
> > +		ret =3D -ENODEV;
> > +		goto out_unlock;
> > +	}
> > +
> > +	ret =3D counter_disable_events(counter);
> > +	if (ret < 0) {
> > +		mutex_unlock(&counter->ops_exist_lock);
> > +		return ret;
> > +	}
> > +
> > +out_unlock:
> > +	mutex_unlock(&counter->ops_exist_lock);
> > +
> > +	put_device(&counter->dev);
> > +	clear_bit_unlock(0, counter->chrdev_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations counter_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.llseek =3D no_llseek,
> > +	.read =3D counter_chrdev_read,
> > +	.poll =3D counter_chrdev_poll,
> > +	.unlocked_ioctl =3D counter_chrdev_ioctl,
> > +	.open =3D counter_chrdev_open,
> > +	.release =3D counter_chrdev_release,
> > +};
> > +
> > +int counter_chrdev_add(struct counter_device *const counter)
>=20
> To think about: This isn't doing the add. So would counter_chrdev_init() =
be more
> appropriate? The fact it can fail due to the kfifo_alloc makes that
> naming less than ideal though.

I've been using the "add" here to refer to adding the chrdev to the
counter_device structure rather than to the rest of the system. I used a
similar naming convention for the counter-sysfs.c file so I think
"counter_chrdev_add" here should be all right and is consistent with the
existing "counter_sysfs_add" function.

> > +{
> > +	/* Initialize Counter events lists */
> > +	INIT_LIST_HEAD(&counter->events_list);
> > +	INIT_LIST_HEAD(&counter->next_events_list);
> > +	spin_lock_init(&counter->events_list_lock);
> > +	mutex_init(&counter->n_events_list_lock);
> > +	init_waitqueue_head(&counter->events_wait);
> > +	mutex_init(&counter->events_lock);
> > +
> > +	/* Initialize character device */
> > +	clear_bit(0, counter->chrdev_lock);
> > +	cdev_init(&counter->chrdev, &counter_fops);
> > +
> > +	/* Allocate Counter events queue */
> > +	return kfifo_alloc(&counter->events, 64, GFP_KERNEL);
> > +}
> > +
> > +void counter_chrdev_remove(struct counter_device *const counter)
> > +{
> > +	kfifo_free(&counter->events);
> > +}
> > +
> > +static int counter_get_data(struct counter_device *const counter,
> > +			    const struct counter_comp_node *const comp_node,
> > +			    u64 *const value)
> > +{
> > +	const struct counter_comp *const comp =3D &comp_node->comp;
> > +	void *const parent =3D comp_node->parent;
> > +	u8 value_u8 =3D 0;
> > +	u32 value_u32 =3D 0;
> > +	int ret;
> > +
> > +	if (comp_node->component.type =3D=3D COUNTER_COMPONENT_NONE)
> > +		return 0;
> > +
> > +	switch (comp->type) {
> > +	case COUNTER_COMP_U8:
> > +	case COUNTER_COMP_BOOL:
> > +		switch (comp_node->component.scope) {
> > +		case COUNTER_SCOPE_DEVICE:
> > +			ret =3D comp->device_u8_read(counter, &value_u8);
> > +			break;
> > +		case COUNTER_SCOPE_SIGNAL:
> > +			ret =3D comp->signal_u8_read(counter, parent, &value_u8);
> > +			break;
> > +		case COUNTER_SCOPE_COUNT:
> > +			ret =3D comp->count_u8_read(counter, parent, &value_u8);
> > +			break;
> > +		}
> > +		*value =3D value_u8;
> > +		return ret;
> > +	case COUNTER_COMP_SIGNAL_LEVEL:
> > +	case COUNTER_COMP_FUNCTION:
> > +	case COUNTER_COMP_ENUM:
> > +	case COUNTER_COMP_COUNT_DIRECTION:
> > +	case COUNTER_COMP_COUNT_MODE:
> > +		switch (comp_node->component.scope) {
> > +		case COUNTER_SCOPE_DEVICE:
> > +			ret =3D comp->device_u32_read(counter, &value_u32);
> > +			break;
> > +		case COUNTER_SCOPE_SIGNAL:
> > +			ret =3D comp->signal_u32_read(counter, parent,
> > +						    &value_u32);
> > +			break;
> > +		case COUNTER_SCOPE_COUNT:
> > +			ret =3D comp->count_u32_read(counter, parent, &value_u32);
> > +			break;
> > +		}
> > +		*value =3D value_u32;
> > +		return ret;
> > +	case COUNTER_COMP_U64:
> > +		switch (comp_node->component.scope) {
> > +		case COUNTER_SCOPE_DEVICE:
> > +			return comp->device_u64_read(counter, value);
> > +		case COUNTER_SCOPE_SIGNAL:
> > +			return comp->signal_u64_read(counter, parent, value);
> > +		case COUNTER_SCOPE_COUNT:
> > +			return comp->count_u64_read(counter, parent, value);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case COUNTER_COMP_SYNAPSE_ACTION:
> > +		ret =3D comp->action_read(counter, parent, comp->priv,
> > +					&value_u32);
> > +		*value =3D value_u32;
> > +		return ret;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +/**
> > + * counter_push_event - queue event for userspace reading
> > + * @counter:	pointer to Counter structure
> > + * @event:	triggered event
> > + * @channel:	event channel
> > + *
> > + * Note: If no one is watching for the respective event, it is silently
> > + * discarded.
> > + */
> > +void counter_push_event(struct counter_device *const counter, const u8=
 event,
> > +			const u8 channel)
> > +{
> > +	struct counter_event ev;
> > +	unsigned int copied =3D 0;
> > +	unsigned long flags;
> > +	struct counter_event_node *event_node;
> > +	struct counter_comp_node *comp_node;
> > +
> > +	ev.timestamp =3D ktime_get_ns();
> > +	ev.watch.event =3D event;
> > +	ev.watch.channel =3D channel;
> > +
> > +	/* Could be in an interrupt context, so use a spin lock */
> > +	spin_lock_irqsave(&counter->events_list_lock, flags);
> > +
> > +	/* Search for event in the list */
>=20
> Worth keeping in mind that searching a list is not exactly a scalable
> solution even if it's fine for now.
>=20
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
> > +		ev.watch.component =3D comp_node->component;
> > +		ev.status =3D -counter_get_data(counter, comp_node, &ev.value);
> > +
> > +		copied +=3D kfifo_in(&counter->events, &ev, 1);
>=20
> I had a short debate with myself on whether this or kfifo_put() was more =
appropriate
> (as fixed record length).  I think this particular case they end up the s=
ame anyway
> so it doesn't matter (nothing to do here!)
> =20
> > +	}
> > +
> > +exit_early:
> > +	spin_unlock_irqrestore(&counter->events_list_lock, flags);
> > +
> > +	if (copied)
> > +		wake_up_poll(&counter->events_wait, EPOLLIN);
> > +}
> > +EXPORT_SYMBOL_GPL(counter_push_event);
> > diff --git a/drivers/counter/counter-chrdev.h b/drivers/counter/counter=
-chrdev.h
> > new file mode 100644
> > index 000000000000..5529d16703c4
> > --- /dev/null
> > +++ b/drivers/counter/counter-chrdev.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Counter character device interface
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#ifndef _COUNTER_CHRDEV_H_
> > +#define _COUNTER_CHRDEV_H_
> > +
> > +#include <linux/counter.h>
> > +
> > +int counter_chrdev_add(struct counter_device *const counter);
> > +void counter_chrdev_remove(struct counter_device *const counter);
> > +
> > +#endif /* _COUNTER_CHRDEV_H_ */
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > index 3cda2c47bacb..28dc1ff63c94 100644
> > --- a/drivers/counter/counter-core.c
> > +++ b/drivers/counter/counter-core.c
> > @@ -3,14 +3,22 @@
> >   * Generic Counter interface
> >   * Copyright (C) 2020 William Breathitt Gray
> >   */
> > +#include <linux/cdev.h>
> >  #include <linux/counter.h>
> >  #include <linux/device.h>
> > +#include <linux/device/bus.h>
> >  #include <linux/export.h>
> > +#include <linux/fs.h>
> >  #include <linux/gfp.h>
> >  #include <linux/idr.h>
> >  #include <linux/init.h>
> > +#include <linux/kdev_t.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/types.h>
> > +#include <linux/wait.h>
> > =20
> > +#include "counter-chrdev.h"
> >  #include "counter-sysfs.h"
> > =20
> >  /* Provides a unique ID for each counter device */
> > @@ -18,6 +26,9 @@ static DEFINE_IDA(counter_ida);
> > =20
> >  static void counter_device_release(struct device *dev)
> >  {
> > +	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > +
> > +	counter_chrdev_remove(counter);
> >  	ida_free(&counter_ida, dev->id);
> >  }
> > =20
> > @@ -31,6 +42,8 @@ static struct bus_type counter_bus_type =3D {
> >  	.dev_name =3D "counter",
> >  };
> > =20
> > +static dev_t counter_devt;
> > +
> >  /**
> >   * counter_register - register Counter to the system
> >   * @counter:	pointer to Counter to register
> > @@ -53,10 +66,13 @@ int counter_register(struct counter_device *const c=
ounter)
> >  	if (id < 0)
> >  		return id;
> > =20
> > +	mutex_init(&counter->ops_exist_lock);
> > +
> >  	/* Configure device structure for Counter */
> >  	dev->id =3D id;
> >  	dev->type =3D &counter_device_type;
> >  	dev->bus =3D &counter_bus_type;
> > +	dev->devt =3D MKDEV(MAJOR(counter_devt), id);
> >  	if (counter->parent) {
> >  		dev->parent =3D counter->parent;
> >  		dev->of_node =3D counter->parent->of_node;
> > @@ -64,18 +80,22 @@ int counter_register(struct counter_device *const c=
ounter)
> >  	device_initialize(dev);
> >  	dev_set_drvdata(dev, counter);
> > =20
> > -	/* Add Counter sysfs attributes */
> > -	err =3D counter_sysfs_add(counter);
> > +	err =3D counter_chrdev_add(counter);
> >  	if (err < 0)
> >  		goto err_free_id;
> > =20
> > -	/* Add device to system */
> > -	err =3D device_add(dev);
> > +	err =3D counter_sysfs_add(counter);
> >  	if (err < 0)
> > -		goto err_free_id;
> > +		goto err_remove_chrdev;
> > +
> > +	err =3D cdev_device_add(&counter->chrdev, dev);
> > +	if (err < 0)
> > +		goto err_remove_chrdev;
> > =20
> >  	return 0;
> > =20
> > +err_remove_chrdev:
> > +	counter_chrdev_remove(counter);
>=20
> Totally trivial, but the sysfs cleanup is managed by devm_ whilst this co=
unter_chrdev_remove()
> is manual.  That leaves us in a case where the unwind order is subtly dif=
ferent from the
> reverse of the setup order.  Is there any reason to not do the sysfs part=
 of register first
> and hence have the ordering match?

I think in an earlier revision of this patchset counter-chrdev had a
dependency on counter-sysfs, but that's no longer the case so we should
be able to reorder these calls so that the unwind order matches.

> >  err_free_id:
> >  	put_device(dev);
> >  	return err;
> > @@ -93,7 +113,16 @@ void counter_unregister(struct counter_device *cons=
t counter)
> >  	if (!counter)
> >  		return;
> > =20
> > -	device_unregister(&counter->dev);
> > +	cdev_device_del(&counter->chrdev, &counter->dev);
> > +
> > +	mutex_lock(&counter->ops_exist_lock);
> > +
> > +	counter->ops =3D NULL;
> > +	wake_up(&counter->events_wait);
> > +
> > +	mutex_unlock(&counter->ops_exist_lock);
> > +
> > +	put_device(&counter->dev);
> >  }
> >  EXPORT_SYMBOL_GPL(counter_unregister);
> > =20
> > @@ -127,13 +156,30 @@ int devm_counter_register(struct device *dev,
> >  }
> >  EXPORT_SYMBOL_GPL(devm_counter_register);
> > =20
> > +#define COUNTER_DEV_MAX 256
> > +
> >  static int __init counter_init(void)
> >  {
> > -	return bus_register(&counter_bus_type);
> > +	int err;
> > +
> > +	err =3D bus_register(&counter_bus_type);
>=20
> Hmm. This isn't ideal in IIO either, but logically bus_register() is the =
part that
> exposes the infrastructure for other drivers to attach to so should be la=
st thing
> in init.  However, I'm fairly sure the dependency handing will ensure thi=
s init()
> is finished before it tries to register any counter drivers.  Hence we ar=
e fine
> anyway.
>=20
> So in conclusion - nothing needs changing here...

Ack. Given that things work all right rigth now, I'll revisit this again
in the future as a general cleanup improvment after this patchset is
merged so that we don't risk complicating the Counter character device
functionality introduction any further.

> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX, "count=
er");
> > +	if (err < 0)
> > +		goto err_unregister_bus;
> > +
> > +	return 0;
> > +
> > +err_unregister_bus:
> > +	bus_unregister(&counter_bus_type);
> > +	return err;
> >  }
> > =20
> >  static void __exit counter_exit(void)
> >  {
> > +	unregister_chrdev_region(counter_devt, COUNTER_DEV_MAX);
> >  	bus_unregister(&counter_bus_type);
> >  }
> > =20
> > diff --git a/include/linux/counter.h b/include/linux/counter.h
> > index 7c9f7e23953a..9c9984655f8c 100644
> > --- a/include/linux/counter.h
> > +++ b/include/linux/counter.h
> > @@ -6,9 +6,14 @@
> >  #ifndef _COUNTER_H_
> >  #define _COUNTER_H_
> > =20
> > +#include <linux/cdev.h>
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kfifo.h>
> > +#include <linux/mutex.h>
> > +#include <linux/spinlock_types.h>
> >  #include <linux/types.h>
> > +#include <linux/wait.h>
> >  #include <uapi/linux/counter.h>
> > =20
> >  struct counter_device;
> > @@ -199,6 +204,20 @@ struct counter_count {
> >  	size_t num_ext;
> >  };
> > =20
> > +/**
> > + * struct counter_event_node - Counter Event node
> > + * @l:		list of current watching Counter events
> > + * @event:	event that triggers
> > + * @channel:	event channel
> > + * @comp_list:	list of components to watch when event triggers
> > + */
> > +struct counter_event_node {
> > +	struct list_head l;
> > +	u8 event;
> > +	u8 channel;
> > +	struct list_head comp_list;
> > +};
> > +
> >  /**
> >   * struct counter_ops - Callbacks from driver
> >   * @signal_read:	optional read callback for Signals. The read level of
> > @@ -222,6 +241,13 @@ struct counter_count {
> >   * @action_write:	optional write callback for Synapse action modes. The
> >   *			action mode to write for the respective Synapse is
> >   *			passed in via the action parameter.
> > + * @events_configure:	optional write callback to configure events. The=
 list of
> > + *			struct counter_event_node may be accessed via the
> > + *			events_list member of the counter parameter.
> > + * @watch_validate:	optional callback to validate a watch. The Counter
> > + *			component watch configuration is passed in via the watch
> > + *			parameter. A return value of 0 indicates a valid Counter
> > + *			component watch configuration.
> >   */
> >  struct counter_ops {
> >  	int (*signal_read)(struct counter_device *counter,
> > @@ -245,6 +271,9 @@ struct counter_ops {
> >  			    struct counter_count *count,
> >  			    struct counter_synapse *synapse,
> >  			    enum counter_synapse_action action);
> > +	int (*events_configure)(struct counter_device *counter);
> > +	int (*watch_validate)(struct counter_device *counter,
> > +			      const struct counter_watch *watch);
> >  };
> > =20
> >  /**
> > @@ -260,6 +289,16 @@ struct counter_ops {
> >   * @num_ext:		number of Counter device extensions specified in @ext
> >   * @priv:		optional private data supplied by driver
> >   * @dev:		internal device structure
> > + * @chrdev:		internal character device structure
> > + * @events_list:	list of current watching Counter events
> > + * @events_list_lock:	lock to protect Counter events list operations
> > + * @next_events_list:	list of next watching Counter events
> > + * @n_events_list_lock:	lock to protect Counter next events list opera=
tions
> > + * @events:		queue of detected Counter events
> > + * @events_wait:	wait queue to allow blocking reads of Counter events
> > + * @events_lock:	lock to protect Counter events queue read operations
> > + * @chrdev_lock:	lock to limit chrdev to a single open at a time
> > + * @ops_exist_lock:	lock to prevent use during removal
> >   */
> >  struct counter_device {
> >  	const char *name;
> > @@ -278,12 +317,24 @@ struct counter_device {
> >  	void *priv;
> > =20
> >  	struct device dev;
> > +	struct cdev chrdev;
> > +	struct list_head events_list;
> > +	spinlock_t events_list_lock;
> > +	struct list_head next_events_list;
> > +	struct mutex n_events_list_lock;
> > +	DECLARE_KFIFO_PTR(events, struct counter_event);
> > +	wait_queue_head_t events_wait;
> > +	struct mutex events_lock;
> > +	DECLARE_BITMAP(chrdev_lock, 1);
>=20
> Why use a bitmap for this rather than any of the other lock types?

We can't use a mutex due to the problems mentioned in
https://lore.kernel.org/linux-arm-kernel/YOq19zTsOzKA8v7c@shinobu/T/#m60721=
33d418d598a5f368bb942c945e46cfab9a5
so I think a bitmap might be the most straightforward solution here. It
goes without saying that I'm open to any other suggestions as well if
there is a better solution for this case.

William Breathitt Gray

> > +	struct mutex ops_exist_lock;
> >  };
> > =20
> >  int counter_register(struct counter_device *const counter);
> >  void counter_unregister(struct counter_device *const counter);
> >  int devm_counter_register(struct device *dev,
> >  			  struct counter_device *const counter);
> > +void counter_push_event(struct counter_device *const counter, const u8=
 event,
> > +			const u8 channel);
> > =20
> >  #define COUNTER_COMP_DEVICE_U8(_name, _read, _write) \
> >  { \

--P6Q0QPYh5Th9wkzC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmFIXckACgkQhvpINdm7
VJJM+g/+P8L8S79cVWjIubbe5P3L5jmeWXXGmFcXpZYwtNwtg7Q2otvnCD83K6ta
sQ0uFqpApJU6rpRxUuXDHPIqPp/BtjKWTEAMsAo2utLcAdBRLHyfC2nscTuYRF3K
M2IUe8FE+BT3DJqXZORbF8slFXJnVLJErFs1q1CPEYUM5uJtgevbPj+IOq62Dh2y
IOq5YPVmOTEeMHqShRrrdvk4k6MfmEWioNNtrXx5ODixOLdj+F1MMGsUB7LSFU5Y
+3jjcIFgQC7zkd10M17hlKpmQ96+07vvbndabYTYSTY1VhRwOs0xCB4GbdrFVR1C
f2fOx0/3fKr+2DcahoGbbrkKEBRI5309RykW8okdMSMLxlwwp2vU05nV5MehNPC/
DdGLOQq0U365p2+8d3c9Rau6d4XWEr1gQUenRpN2rY5RmIdpP0YtjAb/2ZrpMeP+
9e8ocU5WTfuHBdCGAlEjM0DozfUdOaK19/iDojXk80kClyZUOX/SpzYynI7kichx
M0AUJ+694wV58fvKVq1s2R6nGrmi+rFwsnTgVAWZuHJ+FCL4BsMDgWuCkMVG7395
Vp4yzhhKu4FpQ0o/jP+KmmJlew07bhgxjDlGaiiz4dl4X7RnPSpnHEr9Bh687pLM
Cv8nhstl4nxThOu1vyvHsZpwnnSClG+OMJs6C3HmCnV+x1T0yFs=
=7OlG
-----END PGP SIGNATURE-----

--P6Q0QPYh5Th9wkzC--
