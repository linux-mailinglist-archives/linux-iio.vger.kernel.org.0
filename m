Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26013C6DED
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhGMJ53 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbhGMJ5Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:57:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A83C0613E9;
        Tue, 13 Jul 2021 02:54:35 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t9so21149018pgn.4;
        Tue, 13 Jul 2021 02:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/yuQsegQlBUivq3X/0TnR8T+AwHpHJshtl8zKWEMD0=;
        b=EfXxUgtJOBh1fn1j2d8kZQneoxfhteJhOuuqWfo0eyCK/hVQvjHjjOg3RXPS0UfMlU
         XjwQG3es81ar3Xodk69SDwx0xyUcCI8m1d3g/rXMfNL32jp03JKO7wwn1Olva+m3o423
         b5wP07h+ZPH9LDedZGlNc3u5E/8xKHLa4YIlUs8zChKn+KhdekbhFRRvlD/ooJNBtO29
         Cm+DOGjAR+ihbDwINt2PkU94lJWbOKYaUwC0gskfGPv5ltIVDghbO2Y0XknHEsYKRUi3
         qc9DyNq2pDlBhvpvB37bbag2dK3kipYMgZswKX2jtSQuNTSh1c4q0RfaBEEyR+cbguVS
         iKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/yuQsegQlBUivq3X/0TnR8T+AwHpHJshtl8zKWEMD0=;
        b=rsf6GXeDZLDukIbCeyt77UA2erUJHZDfbx99H9fMYw+W8hIiXHaQTJiF3NocysnOYm
         A3BLXqDvQmqc77vKp54703kYHgQvCvM8O5tj9gQUdiRRZyWSPLiD5YmxMun9d9fY9kAq
         3bOkKYpy+T+msVQIa9TbYxJS2alhEcNriynmKOmeNosgsFp0fwdwzIzqr8e6xQ944qO/
         XSRuUOey2i1qLpowYZ/pAjgxcRPbetmswfGNH2vmfgw6bbeezmwLERePeMk64PcL8mih
         3vky5uwnQF3Vh+tN3Kcbwxwny5tiT88Ukc7pD10YmllA1Hnc/J7nAgx+/KDU6UJireJR
         zR2A==
X-Gm-Message-State: AOAM531udQHnMn5n8HWD8az6ixonwPTIDmcDOfSvWsZlTSl3AcLqfdDg
        TH65gsVhKfm61w/zstvVIno=
X-Google-Smtp-Source: ABdhPJwXCztQV5cNE9rwffFDP+7SHfUEs8Jd/Lnq1amlkWnLb2m/bWGcL2ffg1wGXe+7Hp8PST0SRw==
X-Received: by 2002:a65:6243:: with SMTP id q3mr3505723pgv.297.1626170074972;
        Tue, 13 Jul 2021 02:54:34 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:54:34 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v13 10/17] counter: Add character device interface
Date:   Tue, 13 Jul 2021 18:53:14 +0900
Message-Id: <ea787eb4139421bc2ec23ebbdecdc5c5db6fed81.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
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
 drivers/counter/counter-chrdev.c | 508 +++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |  14 +
 drivers/counter/counter-core.c   |  44 ++-
 include/linux/counter.h          |  47 +++
 include/uapi/linux/counter.h     |  98 ++++++
 6 files changed, 707 insertions(+), 6 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h

diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 1ab7e087fdc2..8fde6c100ebc 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_COUNTER) += counter.o
-counter-y := counter-core.o counter-sysfs.o
+counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
new file mode 100644
index 000000000000..d5af82d3c04b
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,508 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Counter character device interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#include <linux/cdev.h>
+#include <linux/counter.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/kfifo.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/nospec.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/timekeeping.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
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
+	int err = 0;
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
+		event_node = kmalloc(sizeof(*event_node), GFP_KERNEL);
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
+		    comp_node->comp.count_u8_read == cfg->comp.count_u8_read) {
+			err = -EINVAL;
+			goto exit_free_event_node;
+		}
+
+	/* Allocate component node */
+	comp_node = kmalloc(sizeof(*comp_node), GFP_KERNEL);
+	if (!comp_node) {
+		err = -ENOMEM;
+		goto exit_free_event_node;
+	}
+	*comp_node = *cfg;
+
+	/* Add component node to event node */
+	list_add_tail(&comp_node->l, &event_node->comp_list);
+
+exit_free_event_node:
+	/* Free event node if no one else is watching */
+	if (list_empty(&event_node->comp_list)) {
+		list_del(&event_node->l);
+		kfree(event_node);
+	}
+
+	return err;
+}
+
+static int counter_enable_events(struct counter_device *const counter)
+{
+	unsigned long flags;
+	int err = 0;
+
+	mutex_lock(&counter->n_events_list_lock);
+	spin_lock_irqsave(&counter->events_list_lock, flags);
+
+	counter_events_list_free(&counter->events_list);
+	list_replace_init(&counter->next_events_list,
+			  &counter->events_list);
+
+	if (counter->ops->events_configure)
+		err = counter->ops->events_configure(counter);
+
+	spin_unlock_irqrestore(&counter->events_list_lock, flags);
+	mutex_unlock(&counter->n_events_list_lock);
+
+	return err;
+}
+
+static int counter_disable_events(struct counter_device *const counter)
+{
+	unsigned long flags;
+	int err = 0;
+
+	spin_lock_irqsave(&counter->events_list_lock, flags);
+
+	counter_events_list_free(&counter->events_list);
+
+	if (counter->ops->events_configure)
+		err = counter->ops->events_configure(counter);
+
+	spin_unlock_irqrestore(&counter->events_list_lock, flags);
+
+	mutex_lock(&counter->n_events_list_lock);
+
+	counter_events_list_free(&counter->next_events_list);
+
+	mutex_unlock(&counter->n_events_list_lock);
+
+	return err;
+}
+
+static int counter_add_watch(struct counter_device *const counter,
+			     const unsigned long arg)
+{
+	void __user *const uwatch = (void __user *)arg;
+	struct counter_watch watch;
+	struct counter_comp_node comp_node = {};
+	size_t parent, id;
+	struct counter_comp *ext;
+	size_t num_ext;
+	int err = 0;
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
+	mutex_lock(&counter->n_events_list_lock);
+
+	if (counter->ops->watch_validate) {
+		err = counter->ops->watch_validate(counter, &watch);
+		if (err < 0)
+			goto err_exit;
+	}
+
+	comp_node.component = watch.component;
+
+	err = counter_set_event_node(counter, &watch, &comp_node);
+
+err_exit:
+	mutex_unlock(&counter->n_events_list_lock);
+
+	return err;
+}
+
+static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct counter_device *const counter = filp->private_data;
+
+	switch (cmd) {
+	case COUNTER_ADD_WATCH_IOCTL:
+		return counter_add_watch(counter, arg);
+	case COUNTER_ENABLE_EVENTS_IOCTL:
+		return counter_enable_events(counter);
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
+int counter_chrdev_add(struct counter_device *const counter)
+{
+	/* Initialize Counter events lists */
+	INIT_LIST_HEAD(&counter->events_list);
+	INIT_LIST_HEAD(&counter->next_events_list);
+	spin_lock_init(&counter->events_list_lock);
+	mutex_init(&counter->n_events_list_lock);
+	init_waitqueue_head(&counter->events_wait);
+	mutex_init(&counter->events_lock);
+
+	/* Initialize character device */
+	cdev_init(&counter->chrdev, &counter_fops);
+
+	/* Allocate Counter events queue */
+	return kfifo_alloc(&counter->events, 64, GFP_KERNEL);
+}
+
+void counter_chrdev_remove(struct counter_device *const counter)
+{
+	kfifo_free(&counter->events);
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
+	struct counter_event ev;
+	unsigned int copied = 0;
+	unsigned long flags;
+	struct counter_event_node *event_node;
+	struct counter_comp_node *comp_node;
+
+	ev.timestamp = ktime_get_ns();
+	ev.watch.event = event;
+	ev.watch.channel = channel;
+
+	/* Could be in an interrupt context, so use a spin lock */
+	spin_lock_irqsave(&counter->events_list_lock, flags);
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
+exit_early:
+	spin_unlock_irqrestore(&counter->events_list_lock, flags);
+
+	if (copied)
+		wake_up_poll(&counter->events_wait, EPOLLIN);
+}
+EXPORT_SYMBOL_GPL(counter_push_event);
diff --git a/drivers/counter/counter-chrdev.h b/drivers/counter/counter-chrdev.h
new file mode 100644
index 000000000000..5529d16703c4
--- /dev/null
+++ b/drivers/counter/counter-chrdev.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Counter character device interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _COUNTER_CHRDEV_H_
+#define _COUNTER_CHRDEV_H_
+
+#include <linux/counter.h>
+
+int counter_chrdev_add(struct counter_device *const counter);
+void counter_chrdev_remove(struct counter_device *const counter);
+
+#endif /* _COUNTER_CHRDEV_H_ */
diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 9442e3b91468..dd7f3f69328e 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -3,14 +3,20 @@
  * Generic Counter interface
  * Copyright (C) 2020 William Breathitt Gray
  */
+#include <linux/cdev.h>
 #include <linux/counter.h>
 #include <linux/device.h>
+#include <linux/device/bus.h>
 #include <linux/export.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/idr.h>
 #include <linux/init.h>
+#include <linux/kdev_t.h>
 #include <linux/module.h>
+#include <linux/types.h>
 
+#include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
 /* Provides a unique ID for each counter device */
@@ -34,6 +40,8 @@ static struct bus_type counter_bus_type = {
 	.dev_name = "counter",
 };
 
+static dev_t counter_devt;
+
 /**
  * counter_register - register Counter to the system
  * @counter:	pointer to Counter to register
@@ -60,6 +68,7 @@ int counter_register(struct counter_device *const counter)
 	dev->id = id;
 	dev->type = &counter_device_type;
 	dev->bus = &counter_bus_type;
+	dev->devt = MKDEV(MAJOR(counter_devt), id);
 	if (counter->parent) {
 		dev->parent = counter->parent;
 		dev->of_node = counter->parent->of_node;
@@ -67,18 +76,25 @@ int counter_register(struct counter_device *const counter)
 	device_initialize(dev);
 	dev_set_drvdata(dev, counter);
 
+	/* Add Counter character device */
+	err = counter_chrdev_add(counter);
+	if (err < 0)
+		goto err_free_id;
+
 	/* Add Counter sysfs attributes */
 	err = counter_sysfs_add(counter);
 	if (err < 0)
-		goto err_free_id;
+		goto err_remove_chrdev;
 
 	/* Add device to system */
-	err = device_add(dev);
+	err = cdev_device_add(&counter->chrdev, dev);
 	if (err < 0)
-		goto err_free_id;
+		goto err_remove_chrdev;
 
 	return 0;
 
+err_remove_chrdev:
+	counter_chrdev_remove(counter);
 err_free_id:
 	put_device(dev);
 	return err;
@@ -96,7 +112,8 @@ void counter_unregister(struct counter_device *const counter)
 	if (!counter)
 		return;
 
-	device_unregister(&counter->dev);
+	cdev_device_del(&counter->chrdev, &counter->dev);
+	put_device(&counter->dev);
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
 
@@ -130,13 +147,30 @@ int devm_counter_register(struct device *dev,
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
index 7c9f7e23953a..895d60a238a9 100644
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
  * @signal_read:	optional read callback for Signals. The read level of
@@ -222,6 +241,13 @@ struct counter_count {
  * @action_write:	optional write callback for Synapse action modes. The
  *			action mode to write for the respective Synapse is
  *			passed in via the action parameter.
+ * @events_configure:	optional write callback to configure events. The list of
+ *			struct counter_event_node may be accessed via the
+ *			events_list member of the counter parameter.
+ * @watch_validate:	optional callback to validate a watch. The Counter
+ *			component watch configuration is passed in via the watch
+ *			parameter. A return value of 0 indicates a valid Counter
+ *			component watch configuration.
  */
 struct counter_ops {
 	int (*signal_read)(struct counter_device *counter,
@@ -245,6 +271,9 @@ struct counter_ops {
 			    struct counter_count *count,
 			    struct counter_synapse *synapse,
 			    enum counter_synapse_action action);
+	int (*events_configure)(struct counter_device *counter);
+	int (*watch_validate)(struct counter_device *counter,
+			      const struct counter_watch *watch);
 };
 
 /**
@@ -260,6 +289,14 @@ struct counter_ops {
  * @num_ext:		number of Counter device extensions specified in @ext
  * @priv:		optional private data supplied by driver
  * @dev:		internal device structure
+ * @chrdev:		internal character device structure
+ * @events_list:	list of current watching Counter events
+ * @events_list_lock:	lock to protect Counter events list operations
+ * @next_events_list:	list of next watching Counter events
+ * @n_events_list_lock:	lock to protect Counter next events list operations
+ * @events:		queue of detected Counter events
+ * @events_wait:	wait queue to allow blocking reads of Counter events
+ * @events_lock:	lock to protect Counter events queue read operations
  */
 struct counter_device {
 	const char *name;
@@ -278,12 +315,22 @@ struct counter_device {
 	void *priv;
 
 	struct device dev;
+	struct cdev chrdev;
+	struct list_head events_list;
+	spinlock_t events_list_lock;
+	struct list_head next_events_list;
+	struct mutex n_events_list_lock;
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
index 6113938a6044..d0aa95aeff7b 100644
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
@@ -13,6 +26,91 @@ enum counter_scope {
 	COUNTER_SCOPE_COUNT,
 };
 
+/**
+ * struct counter_component - Counter component identification
+ * @type: component type (one of enum counter_component_type)
+ * @scope: component scope (one of enum counter_scope)
+ * @parent: parent ID (matching the ID suffix of the respective parent sysfs
+ *          path as described by the ABI documentation file
+ *          Documentation/ABI/testing/sysfs-bus-counter)
+ * @id: component ID (matching the ID provided by the respective *_component_id
+ *      sysfs attribute of the desired component)
+ *
+ * For example, if the Count 2 ceiling extension of Counter device 4 is desired,
+ * set type equal to COUNTER_COMPONENT_EXTENSION, scope equal to
+ * COUNTER_COUNT_SCOPE, parent equal to 2, and id equal to the value provided by
+ * the respective /sys/bus/counter/devices/counter4/count2/ceiling_component_id
+ * sysfs attribute.
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
+	/* Count value increased past ceiling */
+	COUNTER_EVENT_OVERFLOW,
+	/* Count value decreased past floor */
+	COUNTER_EVENT_UNDERFLOW,
+	/* Count value increased past ceiling, or decreased past floor */
+	COUNTER_EVENT_OVERFLOW_UNDERFLOW,
+	/* Count value reached threshold */
+	COUNTER_EVENT_THRESHOLD,
+	/* Index signal detected */
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
+/*
+ * Queues a Counter watch for the specified event.
+ *
+ * The queued watches will not be applied until COUNTER_ENABLE_EVENTS_IOCTL is
+ * called.
+ */
+#define COUNTER_ADD_WATCH_IOCTL _IOW(0x3E, 0x00, struct counter_watch)
+/*
+ * Enables monitoring the events specified by the Counter watches that were
+ * queued by COUNTER_ADD_WATCH_IOCTL.
+ *
+ * If events are already enabled, the new set of watches replaces the old one.
+ * Calling this ioctl also has the effect of clearing the queue of watches added
+ * by COUNTER_ADD_WATCH_IOCTL.
+ */
+#define COUNTER_ENABLE_EVENTS_IOCTL _IO(0x3E, 0x01)
+/*
+ * Stops monitoring the previously enabled events.
+ */
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
2.32.0

