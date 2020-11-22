Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782D92BC92F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Nov 2020 21:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgKVUaY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Nov 2020 15:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKVUaQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2020 15:30:16 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9BC0613CF;
        Sun, 22 Nov 2020 12:30:16 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id n9so1355325qvp.5;
        Sun, 22 Nov 2020 12:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8CicbUMFmxQUSxAt6FcCs4fIZ8f9j8M27SbGeRzYdw=;
        b=hPsDRkD2u2Pr0XjqVXrIEEjosW2vsgSYLH2iu+KhWL6WVEDx7Agq6XItBjMWUbiV2Y
         zdy17q8HMlWLRtgmk62vVFtdxK7kxvlNnVcI/WEPH8MRNqvIG+75NEagLaIFuHqKyX7z
         j0bJrN6SX4Pxqv8eqwS5Sw2gmQPL+UnJ2xKqP2E7ycCBJgkv+X61DU+bKT3txHRum4R5
         XEumK3st/cZlyqRz2v4EhQ8PJEqjFGsLs6IghjCFDrSynROIwCR6UPjIToRbzgsi0PZL
         /0QpG5a5LNc3w0J6r8Y3VQNmDnEIos2E9UQqcSYGH10oury7KLEJfg7Gbd/qYZpOpL+P
         8/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8CicbUMFmxQUSxAt6FcCs4fIZ8f9j8M27SbGeRzYdw=;
        b=UxcAva72OYOCgslmcVW3LVltRvgKJMlLYIDdA2sD0Q2qWcsF0gNl4R2WVPqfFtIVJ2
         UJwZh2aIsSwXUViMbTpQuCxphieVTU6dMlRBmMtg8QTu6U9RHoq8nerx5PZSB8kuvuvk
         bu1E/niNB6Lj1prQZQY3a4Z2Zhv9NvIe46VaMSlDDRI4MbSMBV5lUE8bSPGcqjfZM7LA
         ogUNkEIt/AVxwGu//Z5xuAYaBJnwiRV56kYJwuPeFPwPLNmte1vuVayrHUIw8t7bb+eX
         vWiIHs+EyDOa3BNzpxsq/sNoKZAeu6OXbj0p+46+dr43s2tm9gcAd1cv03rbhAGjI5Fh
         GJIw==
X-Gm-Message-State: AOAM531sv93917WeAW/vKPNum/2rk7PoPsVwE+M2WaEaiPFDHJrWGbGb
        nUC2sFwsLCrtsv/dhJKKoHQ=
X-Google-Smtp-Source: ABdhPJyvTJNS1GRequ4noxSh1RdRyh2B5V7jMiY75NkbN0YsouoXFvMOVT3y5Pvhmi2e2rEOJ6KCMg==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr24821476qvt.46.1606077015666;
        Sun, 22 Nov 2020 12:30:15 -0800 (PST)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id p73sm7446522qka.79.2020.11.22.12.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 12:30:15 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 3/5] counter: Add character device interface
Date:   Sun, 22 Nov 2020 15:29:54 -0500
Message-Id: <b52a62196399d33221f78a1689276ac193c10229.1606075915.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606075915.git.vilhelm.gray@gmail.com>
References: <cover.1606075915.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces a character device interface for the Counter
subsystem. Device data is exposed through standard character device read
operations. Device data is gathered when a Counter event is pushed by
the respective Counter device driver. Configuration is handled via ioctl
operations on the respective Counter character device node.

Cc: David Lechner <david@lechnology.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                      |   1 +
 drivers/counter/Makefile         |   2 +-
 drivers/counter/counter-chrdev.c | 476 +++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |  16 ++
 drivers/counter/counter-core.c   |  38 ++-
 drivers/counter/counter-sysfs.c  |  51 +++-
 include/linux/counter.h          |  66 +++--
 include/uapi/linux/counter.h     | 105 +++++++
 8 files changed, 711 insertions(+), 44 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 include/uapi/linux/counter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e0d8ca70912..beda3366b64c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4453,6 +4453,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
+F:	include/uapi/linux/counter.h
 
 CPMAC ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index cbe1d06af6a9..c4870eb5b1dd 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_COUNTER) += counter.o
-counter-y := counter-core.o counter-sysfs.o
+counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
new file mode 100644
index 000000000000..96fa7fbeef92
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Counter character device interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+
+#include <linux/cdev.h>
+#include <linux/counter.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/nospec.h>
+#include <linux/poll.h>
+#include <linux/kdev_t.h>
+#include <linux/kfifo.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/timekeeping.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/uaccess.h>
+
+#include "counter-chrdev.h"
+
+struct counter_comp_node {
+	struct list_head l;
+	struct counter_component component;
+	struct counter_comp comp;
+	void *parent;
+};
+
+static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
+				   size_t len, loff_t *f_ps)
+{
+	struct counter_device *const counter = filp->private_data;
+	int err;
+	unsigned long flags;
+	unsigned int copied;
+
+	if (len < sizeof(struct counter_event))
+		return -EINVAL;
+
+	do {
+		if (kfifo_is_empty(&counter->events)) {
+			if (filp->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			err = wait_event_interruptible(counter->events_wait,
+					!kfifo_is_empty(&counter->events));
+			if (err)
+				return err;
+		}
+
+		raw_spin_lock_irqsave(&counter->events_lock, flags);
+		err = kfifo_to_user(&counter->events, buf, len, &copied);
+		raw_spin_unlock_irqrestore(&counter->events_lock, flags);
+		if (err)
+			return err;
+	} while (!copied);
+
+	return copied;
+}
+
+static __poll_t counter_chrdev_poll(struct file *filp,
+				    struct poll_table_struct *pollt)
+{
+	struct counter_device *const counter = filp->private_data;
+	__poll_t events = 0;
+
+	poll_wait(filp, &counter->events_wait, pollt);
+
+	if (!kfifo_is_empty(&counter->events))
+		events = EPOLLIN | EPOLLRDNORM;
+
+	return events;
+}
+
+static void counter_events_list_free(struct list_head *const events_list)
+{
+	struct counter_event_node *p, *n;
+	struct counter_comp_node *q, *o;
+
+	list_for_each_entry_safe(p, n, events_list, l) {
+		/* Free associated component nodes */
+		list_for_each_entry_safe(q, o, &p->comp_list, l) {
+			list_del(&q->l);
+			kfree(q);
+		}
+
+		/* Free event node */
+		list_del(&p->l);
+		kfree(p);
+	}
+}
+
+static int counter_set_event_node(struct counter_device *const counter,
+				  struct counter_watch *const watch,
+				  const struct counter_comp_node *const cfg)
+{
+	struct counter_event_node *event_node;
+	struct counter_comp_node *comp_node;
+
+	/* Search for event in the list */
+	list_for_each_entry(event_node, &counter->next_events_list, l)
+		if (event_node->event == watch->event &&
+		    event_node->channel == watch->channel)
+			break;
+
+	/* If event is not already in the list */
+	if (&event_node->l == &counter->next_events_list) {
+		/* Allocate new event node */
+		event_node = kmalloc(sizeof(*event_node), GFP_ATOMIC);
+		if (!event_node)
+			return -ENOMEM;
+
+		/* Configure event node and add to the list */
+		event_node->event = watch->event;
+		event_node->channel = watch->channel;
+		INIT_LIST_HEAD(&event_node->comp_list);
+		list_add(&event_node->l, &counter->next_events_list);
+	}
+
+	/* Check if component watch has already been set before */
+	list_for_each_entry(comp_node, &event_node->comp_list, l)
+		if (comp_node->parent == cfg->parent &&
+		    comp_node->comp.count_u8_read == cfg->comp.count_u8_read)
+			return -EINVAL;
+
+	/* Allocate component node */
+	comp_node = kmalloc(sizeof(*comp_node), GFP_ATOMIC);
+	if (!comp_node) {
+		/* Free event node if no one else is watching */
+		if (list_empty(&event_node->comp_list)) {
+			list_del(&event_node->l);
+			kfree(event_node);
+		}
+		return -ENOMEM;
+	}
+	*comp_node = *cfg;
+
+	/* Add component node to event node */
+	list_add_tail(&comp_node->l, &event_node->comp_list);
+
+	return 0;
+}
+
+static int counter_add_watch(struct counter_device *const counter,
+			     const unsigned long arg)
+{
+	void __user *const uwatch = (void __user *)arg;
+	struct counter_watch watch;
+	struct counter_comp_node comp_node = {0};
+	size_t parent, id;
+	struct counter_comp *ext;
+	size_t num_ext;
+
+	if (copy_from_user(&watch, uwatch, sizeof(watch)))
+		return -EFAULT;
+
+	/* Dummy components can skip evaluation */
+	if (watch.component.type == COUNTER_COMPONENT_DUMMY)
+		goto dummy_component;
+
+	parent = watch.component.parent;
+
+	/* Configure parent component info for comp node */
+	switch (watch.component.scope) {
+	case COUNTER_SCOPE_DEVICE:
+		ext = counter->ext;
+		num_ext = counter->num_ext;
+		break;
+	case COUNTER_SCOPE_SIGNAL:
+		if (parent >= counter->num_signals)
+			return -EINVAL;
+		parent = array_index_nospec(parent, counter->num_signals);
+
+		comp_node.parent = counter->signals + parent;
+
+		ext = counter->signals[parent].ext;
+		num_ext = counter->signals[parent].num_ext;
+		break;
+	case COUNTER_SCOPE_COUNT:
+		if (parent >= counter->num_counts)
+			return -EINVAL;
+		parent = array_index_nospec(parent, counter->num_counts);
+
+		comp_node.parent = counter->counts + parent;
+
+		ext = counter->counts[parent].ext;
+		num_ext = counter->counts[parent].num_ext;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	id = watch.component.id;
+
+	/* Configure component info for comp node */
+	switch (watch.component.type) {
+	case COUNTER_COMPONENT_SIGNAL:
+		if (watch.component.scope != COUNTER_SCOPE_SIGNAL)
+			return -EINVAL;
+
+		comp_node.comp.type = COUNTER_COMP_SIGNAL_LEVEL;
+		comp_node.comp.signal_u8_read = counter->ops->signal_read;
+		break;
+	case COUNTER_COMPONENT_COUNT:
+		if (watch.component.scope != COUNTER_SCOPE_COUNT)
+			return -EINVAL;
+
+		comp_node.comp.type = COUNTER_COMP_U64;
+		comp_node.comp.count_u64_read = counter->ops->count_read;
+		break;
+	case COUNTER_COMPONENT_FUNCTION:
+		if (watch.component.scope != COUNTER_SCOPE_COUNT)
+			return -EINVAL;
+
+		comp_node.comp.type = COUNTER_COMP_FUNCTION;
+		comp_node.comp.count_u8_read = counter->ops->function_read;
+		break;
+	case COUNTER_COMPONENT_SYNAPSE_ACTION:
+		if (watch.component.scope != COUNTER_SCOPE_COUNT)
+			return -EINVAL;
+		if (id >= counter->counts[parent].num_synapses)
+			return -EINVAL;
+		id = array_index_nospec(id, counter->counts[parent].num_synapses);
+
+		comp_node.comp.type = COUNTER_COMP_SYNAPSE_ACTION;
+		comp_node.comp.action_read = counter->ops->action_read;
+		comp_node.comp.priv = counter->counts[parent].synapses + id;
+		break;
+	case COUNTER_COMPONENT_EXTENSION:
+		if (id >= num_ext)
+			return -EINVAL;
+		id = array_index_nospec(id, num_ext);
+
+		comp_node.comp = ext[id];
+		break;
+	default:
+		return -EINVAL;
+	}
+	/* Check if any read callback is set; this is part of a union */
+	if (!comp_node.comp.count_u8_read)
+		return -EOPNOTSUPP;
+
+dummy_component:
+	comp_node.component = watch.component;
+
+	return counter_set_event_node(counter, &watch, &comp_node);
+}
+
+static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct counter_device *const counter = filp->private_data;
+	raw_spinlock_t *const events_lock = &counter->events_lock;
+	unsigned long flags;
+	struct list_head *const events_list = &counter->events_list;
+	struct list_head *const next_events_list = &counter->next_events_list;
+	int err = 0;
+
+	switch (cmd) {
+	case COUNTER_CLEAR_WATCHES_IOCTL:
+		raw_spin_lock_irqsave(events_lock, flags);
+
+		counter_events_list_free(events_list);
+
+		if (counter->ops->events_config)
+			err = counter->ops->events_config(counter);
+
+		raw_spin_unlock_irqrestore(events_lock, flags);
+
+		counter_events_list_free(next_events_list);
+		break;
+	case COUNTER_ADD_WATCH_IOCTL:
+		return counter_add_watch(counter, arg);
+	case COUNTER_LOAD_WATCHES_IOCTL:
+		raw_spin_lock_irqsave(events_lock, flags);
+
+		counter_events_list_free(events_list);
+		list_replace_init(next_events_list, events_list);
+
+		if (counter->ops->events_config)
+			err = counter->ops->events_config(counter);
+
+		raw_spin_unlock_irqrestore(events_lock, flags);
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return err;
+}
+
+static int counter_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct counter_device *const counter = container_of(inode->i_cdev,
+							    typeof(*counter),
+							    chrdev);
+
+	get_device(&counter->dev);
+	filp->private_data = counter;
+
+	return nonseekable_open(inode, filp);
+}
+
+static int counter_chrdev_release(struct inode *inode, struct file *filp)
+{
+	struct counter_device *const counter = filp->private_data;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&counter->events_lock, flags);
+	counter_events_list_free(&counter->events_list);
+	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
+	counter_events_list_free(&counter->next_events_list);
+
+	put_device(&counter->dev);
+
+	return 0;
+}
+
+static const struct file_operations counter_fops = {
+	.llseek = no_llseek,
+	.read = counter_chrdev_read,
+	.poll = counter_chrdev_poll,
+	.unlocked_ioctl = counter_chrdev_ioctl,
+	.open = counter_chrdev_open,
+	.release = counter_chrdev_release,
+};
+
+int counter_chrdev_add(struct counter_device *const counter,
+		       const dev_t counter_devt)
+{
+	struct device *const dev = &counter->dev;
+	struct cdev *const chrdev = &counter->chrdev;
+
+	/* Initialize Counter events lists */
+	INIT_LIST_HEAD(&counter->events_list);
+	INIT_LIST_HEAD(&counter->next_events_list);
+	raw_spin_lock_init(&counter->events_lock);
+
+	/* Initialize Counter events queue */
+	INIT_KFIFO(counter->events);
+	init_waitqueue_head(&counter->events_wait);
+
+	/* Initialize character device */
+	cdev_init(chrdev, &counter_fops);
+	dev->devt = MKDEV(MAJOR(counter_devt), counter->id);
+	cdev_set_parent(chrdev, &dev->kobj);
+
+	return cdev_add(chrdev, dev->devt, 1);
+}
+
+void counter_chrdev_remove(struct counter_device *const counter)
+{
+	cdev_del(&counter->chrdev);
+}
+
+static int counter_get_data(struct counter_device *const counter,
+			    const struct counter_comp_node *const comp_node,
+			    u64 *const value)
+{
+	const struct counter_comp *const comp = &comp_node->comp;
+	void *const parent = comp_node->parent;
+	int err = 0;
+	u8 value_u8;
+
+	/* Dummy components don't have data so return early */
+	if (comp_node->component.type == COUNTER_COMPONENT_DUMMY)
+		return 0;
+
+	switch (comp->type) {
+	case COUNTER_COMP_U8:
+	case COUNTER_COMP_BOOL:
+	case COUNTER_COMP_SIGNAL_LEVEL:
+	case COUNTER_COMP_FUNCTION:
+	case COUNTER_COMP_ENUM:
+	case COUNTER_COMP_COUNT_DIRECTION:
+	case COUNTER_COMP_COUNT_MODE:
+		switch (comp_node->component.scope) {
+		case COUNTER_SCOPE_DEVICE:
+			err = comp->device_u8_read(counter, &value_u8);
+			break;
+		case COUNTER_SCOPE_SIGNAL:
+			err = comp->signal_u8_read(counter, parent, &value_u8);
+			break;
+		case COUNTER_SCOPE_COUNT:
+			err = comp->count_u8_read(counter, parent, &value_u8);
+			break;
+		}
+		if (err)
+			return err;
+		*value = value_u8;
+		break;
+	case COUNTER_COMP_U64:
+		switch (comp_node->component.scope) {
+		case COUNTER_SCOPE_DEVICE:
+			return comp->device_u64_read(counter, value);
+		case COUNTER_SCOPE_SIGNAL:
+			return comp->signal_u64_read(counter, parent, value);
+		case COUNTER_SCOPE_COUNT:
+			return comp->count_u64_read(counter, parent, value);
+		}
+		break;
+	case COUNTER_COMP_SYNAPSE_ACTION:
+		err = comp->action_read(counter, parent, comp->priv, &value_u8);
+		if (err)
+			return err;
+		*value = value_u8;
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * counter_push_event - queue event for userspace reading
+ * @counter:	pointer to Counter structure
+ * @event:	triggered event
+ * @channel:	event channel
+ *
+ * Note: If no one is watching for the respective event, it is silently
+ * discarded.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int counter_push_event(struct counter_device *const counter, const u8 event,
+		       const u8 channel)
+{
+	struct counter_event ev = {0};
+	unsigned int copied = 0;
+	unsigned long flags;
+	struct counter_event_node *event_node;
+	struct counter_comp_node *comp_node;
+	int err = 0;
+
+	ev.timestamp = ktime_get_ns();
+	ev.watch.event = event;
+	ev.watch.channel = channel;
+
+	raw_spin_lock_irqsave(&counter->events_lock, flags);
+
+	/* Search for event in the list */
+	list_for_each_entry(event_node, &counter->events_list, l)
+		if (event_node->event == event &&
+		    event_node->channel == channel)
+			break;
+
+	/* If event is not in the list */
+	if (&event_node->l == &counter->events_list)
+		goto exit_early;
+
+	/* Read and queue relevant comp for userspace */
+	list_for_each_entry(comp_node, &event_node->comp_list, l) {
+		err = counter_get_data(counter, comp_node, &ev.value);
+		if (err)
+			goto exit_early;
+
+		ev.watch.component = comp_node->component;
+
+		copied += kfifo_put(&counter->events, ev);
+	}
+
+	if (copied)
+		wake_up_poll(&counter->events_wait, EPOLLIN);
+
+exit_early:
+	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(counter_push_event);
diff --git a/drivers/counter/counter-chrdev.h b/drivers/counter/counter-chrdev.h
new file mode 100644
index 000000000000..cf5a318fe540
--- /dev/null
+++ b/drivers/counter/counter-chrdev.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Counter character device interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _COUNTER_CHRDEV_H_
+#define _COUNTER_CHRDEV_H_
+
+#include <linux/counter.h>
+#include <linux/types.h>
+
+int counter_chrdev_add(struct counter_device *const counter,
+		       const dev_t counter_devt);
+void counter_chrdev_remove(struct counter_device *const counter);
+
+#endif /* _COUNTER_CHRDEV_H_ */
diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 251627b95a3a..088886e93898 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -5,12 +5,16 @@
  */
 #include <linux/counter.h>
 #include <linux/device.h>
+#include <linux/device/bus.h>
 #include <linux/export.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/types.h>
 
+#include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
 /* Provides a unique ID for each counter device */
@@ -33,6 +37,8 @@ static struct bus_type counter_bus_type = {
 	.name = "counter"
 };
 
+static dev_t counter_devt;
+
 /**
  * counter_register - register Counter to the system
  * @counter:	pointer to Counter to register
@@ -51,7 +57,6 @@ int counter_register(struct counter_device *const counter)
 	if (counter->id < 0)
 		return counter->id;
 
-	/* Configure device structure for Counter */
 	dev->type = &counter_device_type;
 	dev->bus = &counter_bus_type;
 	if (counter->parent) {
@@ -62,18 +67,25 @@ int counter_register(struct counter_device *const counter)
 	device_initialize(dev);
 	dev_set_drvdata(dev, counter);
 
+	/* Add Counter character device */
+	err = counter_chrdev_add(counter, counter_devt);
+	if (err)
+		goto err_free_id;
+
 	/* Add Counter sysfs attributes */
 	err = counter_sysfs_add(counter);
 	if (err)
-		goto err_free_id;
+		goto err_remove_chrdev;
 
 	/* Add device to system */
 	err = device_add(dev);
 	if (err)
-		goto err_free_id;
+		goto err_remove_chrdev;
 
 	return 0;
 
+err_remove_chrdev:
+	counter_chrdev_remove(counter);
 err_free_id:
 	put_device(dev);
 	return err;
@@ -92,6 +104,7 @@ void counter_unregister(struct counter_device *const counter)
 		return;
 
 	device_unregister(&counter->dev);
+	counter_chrdev_remove(counter);
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
 
@@ -135,13 +148,30 @@ int devm_counter_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_counter_register);
 
+#define COUNTER_DEV_MAX 256
+
 static int __init counter_init(void)
 {
-	return bus_register(&counter_bus_type);
+	int err;
+
+	err = bus_register(&counter_bus_type);
+	if (err < 0)
+		return err;
+
+	err = alloc_chrdev_region(&counter_devt, 0, COUNTER_DEV_MAX, "counter");
+	if (err < 0)
+		goto err_unregister_bus;
+
+	return 0;
+
+err_unregister_bus:
+	bus_unregister(&counter_bus_type);
+	return err;
 }
 
 static void __exit counter_exit(void)
 {
+	unregister_chrdev_region(counter_devt, COUNTER_DEV_MAX);
 	bus_unregister(&counter_bus_type);
 }
 
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index c767754d0310..7b677c7de251 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -437,6 +437,7 @@ static ssize_t counter_comp_name_show(struct device *dev,
 
 static int counter_name_attr_create(struct device *const dev,
 				    struct counter_attribute_group *const group,
+				    const char *const attr_name,
 				    const char *const name)
 {
 	struct counter_attribute *counter_attr;
@@ -451,7 +452,7 @@ static int counter_name_attr_create(struct device *const dev,
 
 	/* Configure device attribute */
 	sysfs_attr_init(&counter_attr->dev_attr.attr);
-	counter_attr->dev_attr.attr.name = "name";
+	counter_attr->dev_attr.attr.name = attr_name;
 	counter_attr->dev_attr.attr.mode = 0444;
 	counter_attr->dev_attr.show = counter_comp_name_show;
 
@@ -462,6 +463,18 @@ static int counter_name_attr_create(struct device *const dev,
 	return 0;
 }
 
+static int counter_ext_name_attr_create(struct device *const dev,
+	struct counter_attribute_group *const group, const size_t i,
+	const char *const name)
+{
+	const char *attr_name;
+
+	attr_name = devm_kasprintf(dev, GFP_KERNEL, "extension%zu_name", i);
+	if (!attr_name)
+		return -ENOMEM;
+
+	return counter_name_attr_create(dev, group, attr_name, name);
+}
 
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
@@ -477,6 +490,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -486,14 +500,19 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 		return err;
 
 	/* Create Signal name attribute */
-	err = counter_name_attr_create(dev, group, signal->name);
+	err = counter_name_attr_create(dev, group, "name", signal->name);
 	if (err)
 		return err;
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < signal->num_ext; i++) {
-		err = counter_attr_create(dev, group, signal->ext + i, scope,
-					  signal);
+		ext = signal->ext + i;
+
+		err = counter_attr_create(dev, group, ext, scope, signal);
+		if (err)
+			return err;
+
+		err = counter_ext_name_attr_create(dev, group, i, ext->name);
 		if (err)
 			return err;
 	}
@@ -578,6 +597,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -588,7 +608,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 		return err;
 
 	/* Create Count name attribute */
-	err = counter_name_attr_create(dev, group, count->name);
+	err = counter_name_attr_create(dev, group, "name", count->name);
 	if (err)
 		return err;
 
@@ -602,8 +622,13 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < count->num_ext; i++) {
-		err = counter_attr_create(dev, group, count->ext + i, scope,
-					  count);
+		ext = count->ext + i;
+
+		err = counter_attr_create(dev, group, ext, scope, count);
+		if (err)
+			return err;
+
+		err = counter_ext_name_attr_create(dev, group, i, ext->name);
 		if (err)
 			return err;
 	}
@@ -667,6 +692,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, group);
@@ -681,7 +707,7 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	group += counter->num_counts;
 
 	/* Create name attribute */
-	err = counter_name_attr_create(dev, group, counter->name);
+	err = counter_name_attr_create(dev, group, "name", counter->name);
 	if (err)
 		return err;
 
@@ -699,8 +725,13 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 
 	/* Create an attribute for each extension */
 	for (i = 0; i < counter->num_ext; i++) {
-		err = counter_attr_create(dev, group, counter->ext + i, scope,
-					  NULL);
+		ext = counter->ext + i;
+
+		err = counter_attr_create(dev, group, ext, scope, NULL);
+		if (err)
+			return err;
+
+		err = counter_ext_name_attr_create(dev, group, i, ext->name);
 		if (err)
 			return err;
 	}
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 3f3f8ba6c1b4..98cd7c035968 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,9 +6,14 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
+#include <linux/wait.h>
+#include <uapi/linux/counter.h>
 
 struct counter_device;
 struct counter_count;
@@ -27,35 +32,6 @@ enum counter_comp_type {
 	COUNTER_COMP_COUNT_MODE,
 };
 
-#define COUNTER_SCOPE_DEVICE 0
-#define COUNTER_SCOPE_SIGNAL 1
-#define COUNTER_SCOPE_COUNT 2
-
-#define COUNTER_COUNT_DIRECTION_FORWARD 0
-#define COUNTER_COUNT_DIRECTION_BACKWARD 1
-
-#define COUNTER_COUNT_MODE_NORMAL 0
-#define COUNTER_COUNT_MODE_RANGE_LIMIT 1
-#define COUNTER_COUNT_MODE_NON_RECYCLE 2
-#define COUNTER_COUNT_MODE_MODULO_N 3
-
-#define COUNTER_FUNCTION_INCREASE 0
-#define COUNTER_FUNCTION_DECREASE 1
-#define COUNTER_FUNCTION_PULSE_DIRECTION 2
-#define COUNTER_FUNCTION_QUADRATURE_X1_A 3
-#define COUNTER_FUNCTION_QUADRATURE_X1_B 4
-#define COUNTER_FUNCTION_QUADRATURE_X2_A 5
-#define COUNTER_FUNCTION_QUADRATURE_X2_B 6
-#define COUNTER_FUNCTION_QUADRATURE_X4 7
-
-#define COUNTER_SIGNAL_LEVEL_LOW 0
-#define COUNTER_SIGNAL_LEVEL_HIGH 1
-
-#define COUNTER_SYNAPSE_ACTION_NONE 0
-#define COUNTER_SYNAPSE_ACTION_RISING_EDGE 1
-#define COUNTER_SYNAPSE_ACTION_FALLING_EDGE 2
-#define COUNTER_SYNAPSE_ACTION_BOTH_EDGES 3
-
 /**
  * struct counter_comp - Counter component node
  * @type:		Counter component data type
@@ -195,6 +171,20 @@ struct counter_count {
 	size_t num_ext;
 };
 
+/**
+ * struct counter_event_node - Counter Event node
+ * @l:		list of current watching Counter events
+ * @event:	event that triggers
+ * @channel:	event channel
+ * @comp_list:	list of components to watch when event triggers
+ */
+struct counter_event_node {
+	struct list_head l;
+	u8 event;
+	u8 channel;
+	struct list_head comp_list;
+};
+
 /**
  * struct counter_ops - Callbacks from driver
  * @signal_read:	read callback for Signals. The read value of the
@@ -217,6 +207,9 @@ struct counter_count {
  * @action_write:	write callback for Synapse action modes. The action mode
  * 			to write for the respective Synapse is passed in via the
  * 			action parameter.
+ * @events_config:	write callback to configure events. The list of struct
+ * 			counter_event_node may be accessed via the events_list
+ * 			member of the counter parameter.
  */
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
@@ -235,6 +228,7 @@ struct counter_ops {
 	int (*action_write)(struct counter_device *counter,
 			    struct counter_count *count,
 			    struct counter_synapse *synapse, u8 action);
+	int (*events_config)(struct counter_device *counter);
 };
 
 /**
@@ -251,6 +245,12 @@ struct counter_ops {
  * @priv:		optional private data supplied by driver
  * @id:			unique ID used to identify the Counter
  * @dev:		internal device structure
+ * @chrdev:		internal character device structure
+ * @events_lock:	synchronization lock for Counter events
+ * @events_list:	list of current watching Counter events
+ * @next_events_list:	list of next watching Counter events
+ * @events:		queue of detected Counter events
+ * @events_wait:	wait queue to allow blocking reads of Counter events
  */
 struct counter_device {
 	const char *name;
@@ -270,12 +270,20 @@ struct counter_device {
 
 	int id;
 	struct device dev;
+	struct cdev chrdev;
+	raw_spinlock_t events_lock;
+	struct list_head events_list;
+	struct list_head next_events_list;
+	DECLARE_KFIFO(events, struct counter_event, 64);
+	wait_queue_head_t events_wait;
 };
 
 int counter_register(struct counter_device *const counter);
 void counter_unregister(struct counter_device *const counter);
 int devm_counter_register(struct device *dev,
 			  struct counter_device *const counter);
+int counter_push_event(struct counter_device *const counter, const u8 event,
+		       const u8 channel);
 
 #define COUNTER_COMP_DEVICE_U8(_name, _read, _write) \
 { \
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
new file mode 100644
index 000000000000..0a3a412c7061
--- /dev/null
+++ b/include/uapi/linux/counter.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace ABI for Counter character devices
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _UAPI_COUNTER_H_
+#define _UAPI_COUNTER_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Component type definitions */
+#define COUNTER_COMPONENT_DUMMY 0
+#define COUNTER_COMPONENT_SIGNAL 1
+#define COUNTER_COMPONENT_COUNT 2
+#define COUNTER_COMPONENT_FUNCTION 3
+#define COUNTER_COMPONENT_SYNAPSE_ACTION 4
+#define COUNTER_COMPONENT_EXTENSION 5
+
+/* Component scope definitions */
+#define COUNTER_SCOPE_DEVICE 0
+#define COUNTER_SCOPE_SIGNAL 1
+#define COUNTER_SCOPE_COUNT 2
+
+/**
+ * struct counter_component - Counter component identification
+ * @type: component type (Count, extension, etc.)
+ * @scope: component scope (Device, Count, or Signal)
+ * @parent: parent component identification number
+ * @id: component identification number
+ */
+struct counter_component {
+	__u8 type;
+	__u8 scope;
+	__u8 parent;
+	__u8 id;
+};
+
+/* Event type definitions */
+#define COUNTER_EVENT_OVERFLOW 0
+#define COUNTER_EVENT_UNDERFLOW 1
+#define COUNTER_EVENT_OVERFLOW_UNDERFLOW 2
+#define COUNTER_EVENT_THRESHOLD 3
+#define COUNTER_EVENT_INDEX 4
+
+/**
+ * struct counter_watch - Counter component watch configuration
+ * @component: component to watch when event triggers
+ * @event: event that triggers
+ * @channel: event channel
+ */
+struct counter_watch {
+	struct counter_component component;
+	__u8 event;
+	__u8 channel;
+};
+
+/* ioctl commands */
+#define COUNTER_CLEAR_WATCHES_IOCTL _IO(0x3E, 0x00)
+#define COUNTER_ADD_WATCH_IOCTL _IOW(0x3E, 0x01, struct counter_watch)
+#define COUNTER_LOAD_WATCHES_IOCTL _IO(0x3E, 0x02)
+
+/**
+ * struct counter_event - Counter event data
+ * @watch: component watch configuration
+ * @timestamp: best estimate of time of event occurrence, in nanoseconds
+ * @value: component value
+ */
+struct counter_event {
+	struct counter_watch watch;
+	__aligned_u64 timestamp;
+	__aligned_u64 value;
+};
+
+/* Count direction values */
+#define COUNTER_COUNT_DIRECTION_FORWARD 0
+#define COUNTER_COUNT_DIRECTION_BACKWARD 1
+
+/* Count mode values */
+#define COUNTER_COUNT_MODE_NORMAL 0
+#define COUNTER_COUNT_MODE_RANGE_LIMIT 1
+#define COUNTER_COUNT_MODE_NON_RECYCLE 2
+#define COUNTER_COUNT_MODE_MODULO_N 3
+
+/* Count function values */
+#define COUNTER_FUNCTION_INCREASE 0
+#define COUNTER_FUNCTION_DECREASE 1
+#define COUNTER_FUNCTION_PULSE_DIRECTION 2
+#define COUNTER_FUNCTION_QUADRATURE_X1_A 3
+#define COUNTER_FUNCTION_QUADRATURE_X1_B 4
+#define COUNTER_FUNCTION_QUADRATURE_X2_A 5
+#define COUNTER_FUNCTION_QUADRATURE_X2_B 6
+#define COUNTER_FUNCTION_QUADRATURE_X4 7
+
+/* Signal values */
+#define COUNTER_SIGNAL_LEVEL_LOW 0
+#define COUNTER_SIGNAL_LEVEL_HIGH 1
+
+/* Action mode values */
+#define COUNTER_SYNAPSE_ACTION_NONE 0
+#define COUNTER_SYNAPSE_ACTION_RISING_EDGE 1
+#define COUNTER_SYNAPSE_ACTION_FALLING_EDGE 2
+#define COUNTER_SYNAPSE_ACTION_BOTH_EDGES 3
+
+#endif /* _UAPI_COUNTER_H_ */
-- 
2.29.2

