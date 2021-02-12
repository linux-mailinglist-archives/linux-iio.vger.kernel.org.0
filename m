Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947DD319E2E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBLMRZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhBLMQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:16:22 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FCAC061756;
        Fri, 12 Feb 2021 04:15:42 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 81so68435qkf.4;
        Fri, 12 Feb 2021 04:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xfv6joc37WDcyxiIixY2RHgWdSY+vRGSlBbAguHAZZE=;
        b=RAByW2tqHoQuewk+5vffkTmqZF4Zh63r5UECa7iPwBu82Ss4qWTrFi1JjNw+4rIBxP
         RKtOHn8ygibuZIeD6mZE5ZBE8u1USVvKXW4Dukr2ddzAv0M7HfzYclfA758ottL99ln4
         xhsV+XRPSfpiG5FlDTfCe3S7FgMdA7FJVIKowscurpk971VqsA7zVhZ0g1G6tKPuytjK
         GwI/8wLb71dKbqIvl6uuBmZNdGWWjgMUC/jy3v/fvssdiH5CXPn8aeF9FHeaQGR297Be
         psUDihr9h69Szsr+QwAdv0CYxjJar1FX4xpnQIhcz1HvkzV3+JQxvp84EEIwTvdrn9ds
         iLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xfv6joc37WDcyxiIixY2RHgWdSY+vRGSlBbAguHAZZE=;
        b=CaMM2Zofj37VGj9YacXgdefAeZhKPngZfeunUzTIilsBaMIAfnLQx1Bs0NNlo//Sm+
         7NaIJm560QhQRZtT0OZL99Z/UDzQsxBtAQ66wQop7rNewwFE8FlPhA07vkve6j1oxpBa
         L05JWK+xMTWTI5j3C3LqaLsTQl/BqFpkbFWK6VaDvZLp/r1SPtl1O0ypK72kaZGrU4rk
         2hAk8ohjnud4iBJH6wwz+9YtD3Zhi/bzKqo9hcpCKL9PcsvScD2iVCrgTgLDzq+cgDIe
         gYsWl7lUIqgvbOmuFbV3iPYzcG2OCnwSwcGWclm3JyjGTQ/JPFwnntk5ssZUZcFBLAhB
         xtZQ==
X-Gm-Message-State: AOAM5302f3OVIvaqKlLTyQxUYJ7Gyddq+vClZPvlupl+4mt7i2H6NiOh
        vSsERaxGVlaP+YhGJTLL0VwUtJCorxg=
X-Google-Smtp-Source: ABdhPJyz3GfO6MFlepQ8W87+McGgwuFlAtBqoK2oI+2fmFJjIYNnJv7G3guG+85IBJ0YEUFTuHd/sQ==
X-Received: by 2002:a05:620a:11a5:: with SMTP id c5mr2306784qkk.163.1613132141427;
        Fri, 12 Feb 2021 04:15:41 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:15:40 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v8 17/22] counter: Add character device interface
Date:   Fri, 12 Feb 2021 21:13:41 +0900
Message-Id: <720278e3aaf3f249657ec18d158eca3f962baf8e.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
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
Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/Makefile         |   2 +-
 drivers/counter/counter-chrdev.c | 496 +++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |  16 +
 drivers/counter/counter-core.c   |  37 ++-
 include/linux/counter.h          |  45 +++
 include/uapi/linux/counter.h     |  70 +++++
 6 files changed, 661 insertions(+), 5 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h

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
index 000000000000..16f02df7f73d
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,496 @@
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
+#include <linux/kdev_t.h>
+#include <linux/kfifo.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/nospec.h>
+#include <linux/poll.h>
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
+			if (err < 0)
+				return err;
+		}
+
+		if (mutex_lock_interruptible(&counter->events_lock))
+			return -ERESTARTSYS;
+		err = kfifo_to_user(&counter->events, buf, len, &copied);
+		mutex_unlock(&counter->events_lock);
+		if (err < 0)
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
+static int counter_disable_events(struct counter_device *const counter)
+{
+	unsigned long flags;
+	int err = 0;
+
+	raw_spin_lock_irqsave(&counter->events_list_lock, flags);
+
+	counter_events_list_free(&counter->events_list);
+
+	if (counter->ops->events_configure)
+		err = counter->ops->events_configure(counter);
+
+	raw_spin_unlock_irqrestore(&counter->events_list_lock, flags);
+
+	counter_events_list_free(&counter->next_events_list);
+
+	return err;
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
+	int err;
+
+	if (copy_from_user(&watch, uwatch, sizeof(watch)))
+		return -EFAULT;
+
+	if (watch.component.type == COUNTER_COMPONENT_NONE)
+		goto no_component;
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
+		comp_node.comp.signal_u32_read = counter->ops->signal_read;
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
+		comp_node.comp.count_u32_read = counter->ops->function_read;
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
+no_component:
+	if (counter->ops->watch_validate) {
+		err = counter->ops->watch_validate(counter, &watch);
+		if (err < 0)
+			return err;
+	}
+
+	comp_node.component = watch.component;
+
+	return counter_set_event_node(counter, &watch, &comp_node);
+}
+
+static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct counter_device *const counter = filp->private_data;
+	unsigned long flags;
+	int err = 0;
+
+	switch (cmd) {
+	case COUNTER_ADD_WATCH_IOCTL:
+		return counter_add_watch(counter, arg);
+	case COUNTER_ENABLE_EVENTS_IOCTL:
+		raw_spin_lock_irqsave(&counter->events_list_lock, flags);
+
+		counter_events_list_free(&counter->events_list);
+		list_replace_init(&counter->next_events_list,
+				  &counter->events_list);
+
+		if (counter->ops->events_configure)
+			err = counter->ops->events_configure(counter);
+
+		raw_spin_unlock_irqrestore(&counter->events_list_lock, flags);
+		return err;
+	case COUNTER_DISABLE_EVENTS_IOCTL:
+		return counter_disable_events(counter);
+	default:
+		return -ENOIOCTLCMD;
+	}
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
+	int err;
+
+	err = counter_disable_events(counter);
+	if (err < 0)
+		return err;
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
+	int err;
+
+	/* Initialize Counter events lists */
+	INIT_LIST_HEAD(&counter->events_list);
+	INIT_LIST_HEAD(&counter->next_events_list);
+	raw_spin_lock_init(&counter->events_list_lock);
+
+	/* Initialize Counter events queue */
+	err = kfifo_alloc(&counter->events, 64, GFP_ATOMIC);
+	if (err)
+		return err;
+	init_waitqueue_head(&counter->events_wait);
+	mutex_init(&counter->events_lock);
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
+	kfifo_free(&counter->events);
+	cdev_del(&counter->chrdev);
+}
+
+static int counter_get_data(struct counter_device *const counter,
+			    const struct counter_comp_node *const comp_node,
+			    u64 *const value)
+{
+	const struct counter_comp *const comp = &comp_node->comp;
+	void *const parent = comp_node->parent;
+	u8 value_u8 = 0;
+	u32 value_u32 = 0;
+	int ret;
+
+	if (comp_node->component.type == COUNTER_COMPONENT_NONE)
+		return 0;
+
+	switch (comp->type) {
+	case COUNTER_COMP_U8:
+	case COUNTER_COMP_BOOL:
+		switch (comp_node->component.scope) {
+		case COUNTER_SCOPE_DEVICE:
+			ret = comp->device_u8_read(counter, &value_u8);
+			break;
+		case COUNTER_SCOPE_SIGNAL:
+			ret = comp->signal_u8_read(counter, parent, &value_u8);
+			break;
+		case COUNTER_SCOPE_COUNT:
+			ret = comp->count_u8_read(counter, parent, &value_u8);
+			break;
+		}
+		*value = value_u8;
+		return ret;
+	case COUNTER_COMP_SIGNAL_LEVEL:
+	case COUNTER_COMP_FUNCTION:
+	case COUNTER_COMP_ENUM:
+	case COUNTER_COMP_COUNT_DIRECTION:
+	case COUNTER_COMP_COUNT_MODE:
+		switch (comp_node->component.scope) {
+		case COUNTER_SCOPE_DEVICE:
+			ret = comp->device_u32_read(counter, &value_u32);
+			break;
+		case COUNTER_SCOPE_SIGNAL:
+			ret = comp->signal_u32_read(counter, parent,
+						    &value_u32);
+			break;
+		case COUNTER_SCOPE_COUNT:
+			ret = comp->count_u32_read(counter, parent, &value_u32);
+			break;
+		}
+		*value = value_u32;
+		return ret;
+	case COUNTER_COMP_U64:
+		switch (comp_node->component.scope) {
+		case COUNTER_SCOPE_DEVICE:
+			return comp->device_u64_read(counter, value);
+		case COUNTER_SCOPE_SIGNAL:
+			return comp->signal_u64_read(counter, parent, value);
+		case COUNTER_SCOPE_COUNT:
+			return comp->count_u64_read(counter, parent, value);
+		default:
+			return -EINVAL;
+		}
+	case COUNTER_COMP_SYNAPSE_ACTION:
+		ret = comp->action_read(counter, parent, comp->priv,
+					&value_u32);
+		*value = value_u32;
+		return ret;
+	default:
+		return -EINVAL;
+	}
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
+ */
+void counter_push_event(struct counter_device *const counter, const u8 event,
+			const u8 channel)
+{
+	struct counter_event ev = {0};
+	unsigned int copied = 0;
+	unsigned long flags;
+	struct counter_event_node *event_node;
+	struct counter_comp_node *comp_node;
+
+	ev.timestamp = ktime_get_ns();
+	ev.watch.event = event;
+	ev.watch.channel = channel;
+
+	/* Could be in an interrupt context, so use a raw spin lock */
+	raw_spin_lock_irqsave(&counter->events_list_lock, flags);
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
+		ev.watch.component = comp_node->component;
+		ev.status = -counter_get_data(counter, comp_node, &ev.value);
+
+		copied += kfifo_in(&counter->events, &ev, 1);
+	}
+
+	if (copied)
+		wake_up_poll(&counter->events_wait, EPOLLIN);
+
+exit_early:
+	raw_spin_unlock_irqrestore(&counter->events_list_lock, flags);
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
index bcf672e1fc0d..c137fcb97d9c 100644
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
@@ -54,7 +60,6 @@ int counter_register(struct counter_device *const counter)
 	if (counter->id < 0)
 		return counter->id;
 
-	/* Configure device structure for Counter */
 	dev->type = &counter_device_type;
 	dev->bus = &counter_bus_type;
 	if (counter->parent) {
@@ -65,18 +70,25 @@ int counter_register(struct counter_device *const counter)
 	device_initialize(dev);
 	dev_set_drvdata(dev, counter);
 
+	/* Add Counter character device */
+	err = counter_chrdev_add(counter, counter_devt);
+	if (err < 0)
+		goto err_free_id;
+
 	/* Add Counter sysfs attributes */
 	err = counter_sysfs_add(counter);
 	if (err < 0)
-		goto err_free_id;
+		goto err_remove_chrdev;
 
 	/* Add device to system */
 	err = device_add(dev);
 	if (err < 0)
-		goto err_free_id;
+		goto err_remove_chrdev;
 
 	return 0;
 
+err_remove_chrdev:
+	counter_chrdev_remove(counter);
 err_free_id:
 	put_device(dev);
 	return err;
@@ -138,13 +150,30 @@ int devm_counter_register(struct device *dev,
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
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 2d544f58a79c..af896143d533 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,9 +6,14 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
+#include <linux/mutex.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 #include <uapi/linux/counter.h>
 
 struct counter_device;
@@ -199,6 +204,20 @@ struct counter_count {
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
  * @signal_read:	read callback for Signals. The read level of the
@@ -221,6 +240,13 @@ struct counter_count {
  * @action_write:	write callback for Synapse action modes. The action mode
  *			to write for the respective Synapse is passed in via the
  *			action parameter.
+ * @events_configure:	write callback to configure events. The list of struct
+ *			counter_event_node may be accessed via the events_list
+ *			member of the counter parameter.
+ * @watch_validate:	callback to validate a watch. The Counter component
+ *			watch configuration is passed in via the watch
+ *			parameter. A return value of 0 indicates a valid Counter
+ *			component watch configuration.
  */
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
@@ -244,6 +270,9 @@ struct counter_ops {
 			    struct counter_count *count,
 			    struct counter_synapse *synapse,
 			    enum counter_synapse_action action);
+	int (*events_configure)(struct counter_device *counter);
+	int (*watch_validate)(struct counter_device *counter,
+			      const struct counter_watch *watch);
 };
 
 /**
@@ -260,6 +289,13 @@ struct counter_ops {
  * @priv:		optional private data supplied by driver
  * @id:			unique ID used to identify the Counter
  * @dev:		internal device structure
+ * @chrdev:		internal character device structure
+ * @events_list:	list of current watching Counter events
+ * @events_list_lock:	lock to protect Counter events list operations
+ * @next_events_list:	list of next watching Counter events
+ * @events:		queue of detected Counter events
+ * @events_wait:	wait queue to allow blocking reads of Counter events
+ * @events_lock:	lock to protect Counter events queue read operations
  */
 struct counter_device {
 	const char *name;
@@ -279,12 +315,21 @@ struct counter_device {
 
 	int id;
 	struct device dev;
+	struct cdev chrdev;
+	struct list_head events_list;
+	raw_spinlock_t events_list_lock;
+	struct list_head next_events_list;
+	DECLARE_KFIFO_PTR(events, struct counter_event);
+	wait_queue_head_t events_wait;
+	struct mutex events_lock;
 };
 
 int counter_register(struct counter_device *const counter);
 void counter_unregister(struct counter_device *const counter);
 int devm_counter_register(struct device *dev,
 			  struct counter_device *const counter);
+void counter_push_event(struct counter_device *const counter, const u8 event,
+			const u8 channel);
 
 #define COUNTER_COMP_DEVICE_U8(_name, _read, _write) \
 { \
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 6113938a6044..3d647a5383b8 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -6,6 +6,19 @@
 #ifndef _UAPI_COUNTER_H_
 #define _UAPI_COUNTER_H_
 
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Component type definitions */
+enum counter_component_type {
+	COUNTER_COMPONENT_NONE,
+	COUNTER_COMPONENT_SIGNAL,
+	COUNTER_COMPONENT_COUNT,
+	COUNTER_COMPONENT_FUNCTION,
+	COUNTER_COMPONENT_SYNAPSE_ACTION,
+	COUNTER_COMPONENT_EXTENSION,
+};
+
 /* Component scope definitions */
 enum counter_scope {
 	COUNTER_SCOPE_DEVICE,
@@ -13,6 +26,63 @@ enum counter_scope {
 	COUNTER_SCOPE_COUNT,
 };
 
+/**
+ * struct counter_component - Counter component identification
+ * @type: component type (one of enum counter_component_type)
+ * @scope: component scope (one of enum counter_scope)
+ * @parent: parent component ID (matching the Y/Z suffix of the respective sysfs
+ *	    path as described in Documentation/ABI/testing/sysfs-bus-counter)
+ * @id: component ID (matching the Y/Z suffix of the respective sysfs path as
+ *	described in Documentation/ABI/testing/sysfs-bus-counter)
+ */
+struct counter_component {
+	__u8 type;
+	__u8 scope;
+	__u8 parent;
+	__u8 id;
+};
+
+/* Event type definitions */
+enum counter_event_type {
+	COUNTER_EVENT_OVERFLOW,
+	COUNTER_EVENT_UNDERFLOW,
+	COUNTER_EVENT_OVERFLOW_UNDERFLOW,
+	COUNTER_EVENT_THRESHOLD,
+	COUNTER_EVENT_INDEX,
+};
+
+/**
+ * struct counter_watch - Counter component watch configuration
+ * @component: component to watch when event triggers
+ * @event: event that triggers (one of enum counter_event_type)
+ * @channel: event channel (typically 0 unless the device supports concurrent
+ *	     events of the same type)
+ */
+struct counter_watch {
+	struct counter_component component;
+	__u8 event;
+	__u8 channel;
+};
+
+/* ioctl commands */
+#define COUNTER_ADD_WATCH_IOCTL _IOW(0x3E, 0x00, struct counter_watch)
+#define COUNTER_ENABLE_EVENTS_IOCTL _IO(0x3E, 0x01)
+#define COUNTER_DISABLE_EVENTS_IOCTL _IO(0x3E, 0x02)
+
+/**
+ * struct counter_event - Counter event data
+ * @timestamp: best estimate of time of event occurrence, in nanoseconds
+ * @value: component value
+ * @watch: component watch configuration
+ * @status: return status (system error number)
+ */
+struct counter_event {
+	__aligned_u64 timestamp;
+	__aligned_u64 value;
+	struct counter_watch watch;
+	__u8 status;
+};
+
 /* Count direction values */
 enum counter_count_direction {
 	COUNTER_COUNT_DIRECTION_FORWARD,
-- 
2.30.0

