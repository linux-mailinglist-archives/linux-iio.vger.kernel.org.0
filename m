Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6F2279D7A
	for <lists+linux-iio@lfdr.de>; Sun, 27 Sep 2020 04:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgI0CSk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 22:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbgI0CSj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Sep 2020 22:18:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62137C0613D4;
        Sat, 26 Sep 2020 19:18:39 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c18so5648858qtw.5;
        Sat, 26 Sep 2020 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bejFktbD4saXNdCsG5rImUViKw/qjmkqfk7SeTcLh5c=;
        b=iBvPdREnXpRlfPRjJnuHRDxMNNx5Hv0dZkENs26RG8ei2jV2w/3iRx9Wn5MrSKNdus
         VBd/6HFNUFwdRwtSYOmsh2UGK+ND0k0DvY4r3O5ckmAzTfxNGwXPEcMZhiQOSgvvb/Zp
         bjOKscj6Gnnlf4MA34emXUvwrCjvoaqPGNdCEQ/wT0/oOCd199lPTrp3kWLKA4K/1tHi
         73o6J29S7lcvkdhw+GHOmzuCrJnU96erui70IvRJadNjbbg+5HnQUwZ6a3JnVaRVfr3q
         kqbgvpaR3tuPJip+TX7c6y+FKUcOsz9W0W1Lm8Qs7oo6RAMJYxMJHmK4Duf59cAyEVFm
         lnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bejFktbD4saXNdCsG5rImUViKw/qjmkqfk7SeTcLh5c=;
        b=DKxynflJLPFcdX5oGe0c8RCZn2KSryzmSX/MTfasn0GResilTcWlYPyLLVYFJnCqeZ
         m+zfJRDKpC0lHG9ndks1G/NNN/0+MC8n1NLlzwjORvVPgDAexGWEgNtJKAh5mLWbD3Fi
         IzV/atSYlfWawDUzDYJxE9o4gMlJ0IaWsIL3KkUS6Ueb3RkSBMemspbMCvz0T//+TCL7
         CCZLm2hKj4P3moyFAKttKJpYr28UDAv8f/mnNTvp79TKSffqiWyahAcg0zv+RfZZRWb3
         Ktug5Yd+eycwaayvkg2PUeRqhF4SNk0qIGSFN/Dyhbq23/IYSfOBZAStl2Q69t5eZJHL
         d6WQ==
X-Gm-Message-State: AOAM5308g/ybnL6aTLVpYq5JQHF70pQ+o7xZVaJnS2eczSp6AgVvbfI8
        KV0DX8y/41dAd/suZlqVAEE=
X-Google-Smtp-Source: ABdhPJzQcy8Yfu38vQbKNeOVc1XLXLHOxfzzbhdXuynO7lc4nanXkKrXIv72Zn4QxkeY8jkRiREoow==
X-Received: by 2002:ac8:6e89:: with SMTP id c9mr6684335qtv.3.1601173118351;
        Sat, 26 Sep 2020 19:18:38 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id f12sm5276906qti.70.2020.09.26.19.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 19:18:37 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 3/5] counter: Add character device interface
Date:   Sat, 26 Sep 2020 22:18:16 -0400
Message-Id: <00be1fccc672c5207f3b04fe4cc09c29e22641f4.1601170670.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601170670.git.vilhelm.gray@gmail.com>
References: <cover.1601170670.git.vilhelm.gray@gmail.com>
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

A high-level view of how a count value is passed down from a counter
driver is exemplified by the following. The driver callbacks are first
registered to the Counter core component for use by the Counter
userspace interface components:

                        +----------------------------+
	                | Counter device driver      |
                        +----------------------------+
                        | Processes data from device |
                        +----------------------------+
                                |
                         -------------------
                        / driver callbacks /
                        -------------------
                                |
                                V
                        +----------------------+
                        | Counter core         |
                        +----------------------+
                        | Routes device driver |
                        | callbacks to the     |
                        | userspace interfaces |
                        +----------------------+
                                |
                         -------------------
                        / driver callbacks /
                        -------------------
                                |
                +---------------+---------------+
                |                               |
                V                               V
        +--------------------+          +---------------------+
        | Counter sysfs      |          | Counter chrdev      |
        +--------------------+          +---------------------+
        | Translates to the  |          | Translates to the   |
        | standard Counter   |          | standard Counter    |
        | sysfs output       |          | character device    |
        +--------------------+          +---------------------+

Thereafter, data can be transferred directly between the Counter device
driver and Counter userspace interface:

                         ----------------------
                        / Counter device       \
                        +----------------------+
                        | Count register: 0x28 |
                        +----------------------+
                                |
                         -----------------
                        / raw count data /
                        -----------------
                                |
                                V
                        +----------------------------+
                        | Counter device driver      |
                        +----------------------------+
                        | Processes data from device |
                        |----------------------------|
                        | Type: u64                  |
                        | Value: 42                  |
                        +----------------------------+
                                |
                         ----------
                        / u64     /
                        ----------
                                |
                +---------------+---------------+
                |                               |
                V                               V
        +--------------------+          +---------------------+
        | Counter sysfs      |          | Counter chrdev      |
        +--------------------+          +---------------------+
        | Translates to the  |          | Translates to the   |
        | standard Counter   |          | standard Counter    |
        | sysfs output       |          | character device    |
        |--------------------|          |---------------------|
        | Type: const char * |          | Type: u64           |
        | Value: "42"        |          | Value: 42           |
        +--------------------+          +---------------------+
                |                               |
         ---------------                 -----------------------
        / const char * /                / struct counter_event /
        ---------------                 -----------------------
                |                               |
                |                               V
                |                       +-----------+
                |                       | read      |
                |                       +-----------+
                |                       \ Count: 42 /
                |                        -----------
                |
                V
        +--------------------------------------------------+
        | `/sys/bus/counter/devices/counterX/countY/count` |
        +--------------------------------------------------+
        \ Count: "42"                                      /
         --------------------------------------------------

Counter character device nodes are created under the `/dev` directory as
`counterX`, where `X` is the respective counter device id. Defines for
the standard Counter data types are exposed via the userspace
`include/uapi/linux/counter.h` file.

Counter events
--------------
Counter device drivers can support Counter events by utilizing the
`counter_push_event` function:

    int counter_push_event(struct counter_device *const counter,
    			   const u8 event, const u8 channel);

The event id is specified by the `event` parameter; the event channel id
is specified by the `channel` parameter. When this function is called,
the Counter data associated with the respective event is gathered, and a
`struct counter_event` is generated for each datum and pushed to
userspace.

Counter events can be configured by users to report various Counter
data of interest. This can be conceptualized as a list of Counter
component read calls to perform. For example:

    +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
    | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
    +~~~~~~~~~~~~~~~~~~~~~~~~+~~~~~~~~~~~~~~~~~~~~~~~~+
    | Channel 0              | Channel 0              |
    +------------------------+------------------------+
    | * Count 0              | * Signal 0             |
    | * Count 1              | * Signal 0 Extension 0 |
    | * Signal 3             | * Extension 4          |
    | * Count 4 Extension 2  +------------------------+
    | * Signal 5 Extension 0 | Channel 1              |
    |                        +------------------------+
    |                        | * Signal 4             |
    |                        | * Signal 4 Extension 0 |
    |                        | * Count 7              |
    +------------------------+------------------------+

When `counter_push_event(counter, COUNTER_EVENT_INDEX, 1)` is called for
example, it will go down the list for the `COUNTER_EVENT_INDEX` event
channel 1 and execute the read callbacks for Signal 4, Signal 4
Extension 0, and Count 4 -- the data returned for each is pushed to a
kfifo as a `struct counter_event`, which userspace can retrieve via a
standard read operation on the respective character device node.

Userspace
---------
Userspace applications can configure Counter events via ioctl operations
on the Counter character device node. There following ioctl codes are
supported and provided by the `linux/counter.h` userspace header file:

* COUNTER_CLEAR_WATCHES_IOCTL:
  Clear all Counter watches from all events

* COUNTER_SET_WATCH_IOCTL:
  Set a Counter watch for the specified event

* COUNTER_LOAD_WATCHES_IOCTL:
  Activates the Counter watches set earlier

To configure events to gather Counter data, users first populate a
`struct counter_watch` with the relevant event id, event channel id, and
the information for the desired Counter component from which to read,
and then pass it via the `COUNTER_SET_WATCH_IOCTL` ioctl command.

The `COUNTER_SET_WATCH_IOCTL` command will buffer these Counter watches.
When ready, the `COUNTER_LOAD_WATCHES_IOCTL` ioctl command may be used
to activate these Counter watches.

Userspace applications can then execute a `read` operation (optionally
calling `poll` first) on the Counter character device node to retrieve
`struct counter_event` elements with the desired data.

For example, the following userspace code opens `/dev/counter0`,
configures the `COUNTER_EVENT_INDEX` event channel 0 to gather Count 0
and Count 1, and prints out the data as it becomes available on the
character device node:

    #include <fcntl.h>
    #include <linux/counter.h>
    #include <poll.h>
    #include <stdio.h>
    #include <sys/ioctl.h>
    #include <unistd.h>

    struct counter_watch watches[2] = {
            {
                    .event = COUNTER_EVENT_INDEX,
                    .channel = 0,
                    .component.scope = COUNTER_SCOPE_COUNT,
                    .component.parent = 0,
                    .component.type = COUNTER_COMPONENT_COUNT,
            },
            {
                    .event = COUNTER_EVENT_INDEX,
                    .channel = 0,
                    .component.scope = COUNTER_SCOPE_COUNT,
                    .component.parent = 1,
                    .component.type = COUNTER_COMPONENT_COUNT,
            },
    };

    int main(void)
    {
            struct pollfd pfd = { .events = POLLIN };
            struct counter_event event_data[2];

            pfd.fd = open("/dev/counter0", O_RDWR);

            ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
            ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);
            ioctl(pfd.fd, COUNTER_LOAD_WATCHES_IOCTL);

            for (;;) {
                    poll(&pfd, 1, -1);

                    read(pfd.fd, event_data, sizeof(event_data));

                    printf("Timestamp 0: %llu\nCount 0: %llu\n"
                           "Timestamp 1: %llu\nCount 1: %llu\n",
                           (unsigned long long)event_data[0].timestamp,
                           (unsigned long long)event_data[0].value_u64,
                           (unsigned long long)event_data[1].timestamp,
                           (unsigned long long)event_data[1].value_u64);
            }

            return 0;
    }

Cc: David Lechner <david@lechnology.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                      |   1 +
 drivers/counter/Makefile         |   2 +-
 drivers/counter/counter-chrdev.c | 451 +++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |  16 ++
 drivers/counter/counter-core.c   |  38 ++-
 drivers/counter/counter-sysfs.c  | 109 +++++++-
 include/linux/counter.h          |  48 ++--
 include/uapi/linux/counter.h     |  99 +++++++
 8 files changed, 720 insertions(+), 44 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 include/uapi/linux/counter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4969e997061a..de6685a683c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4459,6 +4459,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
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
index 000000000000..2be3846e4105
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,451 @@
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
+struct counter_event_node {
+	struct list_head l;
+	u8 event;
+	u8 channel;
+	struct list_head comp_list;
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
+	int err;
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
+		err = -ENOMEM;
+		goto err_comp_node;
+	}
+	*comp_node = *cfg;
+
+	/* Add component node to event node */
+	list_add_tail(&comp_node->l, &event_node->comp_list);
+
+	return 0;
+
+err_comp_node:
+	if (list_empty(&event_node->comp_list)) {
+		list_del(&event_node->l);
+		kfree(event_node);
+	}
+	return err;
+}
+
+static int counter_set_watch(struct counter_device *const counter,
+			     const unsigned long arg)
+{
+	void __user *const uwatch = (void __user *)arg;
+	struct counter_watch watch;
+	struct counter_comp_node comp_node;
+	size_t parent, id;
+	struct counter_comp *ext;
+	size_t num_ext;
+
+	if (copy_from_user(&watch, uwatch, sizeof(watch)))
+		return -EFAULT;
+	parent = watch.component.parent;
+	id = watch.component.id;
+
+	/* Configure parent component info for comp node */
+	switch (watch.component.scope) {
+	case COUNTER_SCOPE_DEVICE:
+		comp_node.parent = NULL;
+
+		ext = counter->ext;
+		num_ext = counter->num_ext;
+		break;
+	case COUNTER_SCOPE_SIGNAL:
+		if (counter->num_signals < parent + 1)
+			return -EINVAL;
+
+		comp_node.parent = counter->signals + parent;
+
+		ext = counter->signals[parent].ext;
+		num_ext = counter->signals[parent].num_ext;
+		break;
+	case COUNTER_SCOPE_COUNT:
+		if (counter->num_counts < parent + 1)
+			return -EINVAL;
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
+		if (counter->counts[parent].num_synapses < id + 1)
+			return -EINVAL;
+
+		comp_node.comp.type = COUNTER_COMP_SYNAPSE_ACTION;
+		comp_node.comp.action_read = counter->ops->action_read;
+		comp_node.comp.priv = counter->counts[parent].synapses + id;
+		break;
+	case COUNTER_COMPONENT_EXTENSION:
+		if (num_ext < id + 1)
+			return -EINVAL;
+
+		comp_node.comp = ext[id];
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (!comp_node.comp.count_u8_read)
+		return -EFAULT;
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
+
+	switch (cmd) {
+	case COUNTER_CLEAR_WATCHES_IOCTL:
+		raw_spin_lock_irqsave(events_lock, flags);
+		counter_events_list_free(events_list);
+		raw_spin_unlock_irqrestore(events_lock, flags);
+		counter_events_list_free(next_events_list);
+		break;
+	case COUNTER_SET_WATCH_IOCTL:
+		return counter_set_watch(counter, arg);
+	case COUNTER_LOAD_WATCHES_IOCTL:
+		raw_spin_lock_irqsave(events_lock, flags);
+		counter_events_list_free(events_list);
+		list_replace_init(next_events_list, events_list);
+		raw_spin_unlock_irqrestore(events_lock, flags);
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
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
+	put_device(&counter->dev);
+
+	raw_spin_lock_irqsave(&counter->events_lock, flags);
+	counter_events_list_free(&counter->events_list);
+	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
+	counter_events_list_free(&counter->next_events_list);
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
+			    void *const value)
+{
+	const struct counter_comp *const comp = &comp_node->comp;
+	void *const parent = comp_node->parent;
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
+			return comp->device_u8_read(counter, value);
+		case COUNTER_SCOPE_SIGNAL:
+			return comp->signal_u8_read(counter, parent, value);
+		case COUNTER_SCOPE_COUNT:
+			return comp->count_u8_read(counter, parent, value);
+		}
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
+		return comp->action_read(counter, parent, comp->priv, value);
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
+	int err;
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
+		err = counter_get_data(counter, comp_node, &ev.value_u8);
+		if (err)
+			goto err_counter_get_data;
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
+	return 0;
+
+err_counter_get_data:
+	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
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
index 987c6e8277eb..e9c01de36fcf 100644
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
@@ -32,6 +36,8 @@ static struct bus_type counter_bus_type = {
 	.name = "counter"
 };
 
+static dev_t counter_devt;
+
 /**
  * counter_register - register Counter to the system
  * @counter:	pointer to Counter to register
@@ -50,7 +56,6 @@ int counter_register(struct counter_device *const counter)
 	if (counter->id < 0)
 		return counter->id;
 
-	/* Configure device structure for Counter */
 	dev->type = &counter_device_type;
 	dev->bus = &counter_bus_type;
 	if (counter->parent) {
@@ -61,20 +66,27 @@ int counter_register(struct counter_device *const counter)
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
 	if (err) {
 		put_device(dev);
-		goto err_free_id;
+		goto err_remove_chrdev;
 	}
 
 	return 0;
 
+err_remove_chrdev:
+	counter_chrdev_remove(counter);
 err_free_id:
 	/* get_device/put_device combo used to free managed resources */
 	get_device(dev);
@@ -96,6 +108,7 @@ void counter_unregister(struct counter_device *const counter)
 		return;
 
 	device_unregister(&counter->dev);
+	counter_chrdev_remove(counter);
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
 
@@ -142,13 +155,30 @@ int devm_counter_register(struct device *dev,
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
index e66ed99dd5ea..cefef61f170d 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -434,6 +434,7 @@ static ssize_t counter_comp_name_show(struct device *dev,
 
 static int counter_name_attr_create(struct device *const dev,
 				    struct counter_attribute_group *const group,
+				    const char *const attr_name,
 				    const char *const name)
 {
 	struct counter_attribute *counter_attr;
@@ -448,7 +449,7 @@ static int counter_name_attr_create(struct device *const dev,
 
 	/* Configure device attribute */
 	sysfs_attr_init(&counter_attr->dev_attr.attr);
-	counter_attr->dev_attr.attr.name = "name";
+	counter_attr->dev_attr.attr.name = attr_name;
 	counter_attr->dev_attr.attr.mode = 0444;
 	counter_attr->dev_attr.show = counter_comp_name_show;
 
@@ -459,6 +460,76 @@ static int counter_name_attr_create(struct device *const dev,
 	return 0;
 }
 
+static ssize_t counter_comp_width_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	switch (to_counter_attribute(attr)->comp.type) {
+	case COUNTER_COMP_U8:
+	case COUNTER_COMP_BOOL:
+	case COUNTER_COMP_SIGNAL_LEVEL:
+	case COUNTER_COMP_FUNCTION:
+	case COUNTER_COMP_SYNAPSE_ACTION:
+	case COUNTER_COMP_ENUM:
+	case COUNTER_COMP_COUNT_DIRECTION:
+	case COUNTER_COMP_COUNT_MODE:
+		return sprintf(buf, "8\n");
+	case COUNTER_COMP_U64:
+		return sprintf(buf, "64\n");
+	}
+
+	return 0;
+}
+
+static int counter_ext_width_attr_create(struct device *const dev,
+	struct counter_attribute_group *const group, const size_t i,
+	const struct counter_comp *const ext)
+{
+	struct counter_attribute *counter_attr;
+	const char *name;
+
+	/* Allocate Counter attribute */
+	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
+	if (!counter_attr)
+		return -ENOMEM;
+
+	/* Generate attribute name */
+	name = devm_kasprintf(dev, GFP_KERNEL, "extension%zu_width", i);
+	if (!name)
+		return -ENOMEM;
+
+	/* Configure Counter attribute */
+	counter_attr->comp.type = ext->type;
+
+	/* Configure device attribute */
+	sysfs_attr_init(&counter_attr->dev_attr.attr);
+	counter_attr->dev_attr.attr.name = name;
+	counter_attr->dev_attr.attr.mode = 0444;
+	counter_attr->dev_attr.show = counter_comp_width_show;
+
+	/* Store list node */
+	list_add(&counter_attr->l, &group->attr_list);
+	group->num_attr++;
+
+	return 0;
+}
+
+static int counter_ext_meta_attrs_create(struct device *const dev,
+	struct counter_attribute_group *const group, const size_t i,
+	const struct counter_comp *const ext)
+{
+	const char *attr_name;
+	int err;
+
+	attr_name = devm_kasprintf(dev, GFP_KERNEL, "extension%zu_name", i);
+	if (!attr_name)
+		return -ENOMEM;
+
+	err = counter_name_attr_create(dev, group, attr_name, ext->name);
+	if (err)
+		return err;
+
+	return counter_ext_width_attr_create(dev, group, i, ext);
+}
 
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
@@ -474,6 +545,7 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -483,14 +555,19 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
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
+		err = counter_ext_meta_attrs_create(dev, group, i, ext);
 		if (err)
 			return err;
 	}
@@ -575,6 +652,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	int err;
 	struct counter_comp comp;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -585,7 +663,7 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 		return err;
 
 	/* Create Count name attribute */
-	err = counter_name_attr_create(dev, group, count->name);
+	err = counter_name_attr_create(dev, group, "name", count->name);
 	if (err)
 		return err;
 
@@ -599,8 +677,13 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 
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
+		err = counter_ext_meta_attrs_create(dev, group, i, ext);
 		if (err)
 			return err;
 	}
@@ -664,6 +747,7 @@ static int counter_device_register(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	size_t i;
+	struct counter_comp *ext;
 
 	/* Register Signals */
 	err = counter_signals_register(counter, group);
@@ -678,7 +762,7 @@ static int counter_device_register(struct counter_device *const counter,
 	group += counter->num_counts;
 
 	/* Create name attribute */
-	err = counter_name_attr_create(dev, group, counter->name);
+	err = counter_name_attr_create(dev, group, "name", counter->name);
 	if (err)
 		return err;
 
@@ -696,8 +780,13 @@ static int counter_device_register(struct counter_device *const counter,
 
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
+		err = counter_ext_meta_attrs_create(dev, group, i, ext);
 		if (err)
 			return err;
 	}
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 132bfecca5c3..25d79047c9fc 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,10 +6,15 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
+#include <linux/wait.h>
+#include <uapi/linux/counter.h>
 
 struct counter_device;
 struct counter_count;
@@ -28,35 +33,6 @@ enum counter_comp_type {
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
 struct counter_comp {
 	enum counter_comp_type type;
 	const char *name;
@@ -205,6 +181,12 @@ struct counter_ops {
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
@@ -224,6 +206,12 @@ struct counter_device {
 
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
@@ -232,6 +220,8 @@ int devm_counter_register(struct device *dev,
 			  struct counter_device *const counter);
 void devm_counter_unregister(struct device *dev,
 			     struct counter_device *const counter);
+int counter_push_event(struct counter_device *const counter, const u8 event,
+		       const u8 channel);
 
 #define COUNTER_COMP_DEVICE_U8(_name, _read, _write) \
 { \
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
new file mode 100644
index 000000000000..ad9a8686b2b0
--- /dev/null
+++ b/include/uapi/linux/counter.h
@@ -0,0 +1,99 @@
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
+#define COUNTER_SCOPE_DEVICE 0
+#define COUNTER_SCOPE_SIGNAL 1
+#define COUNTER_SCOPE_COUNT 2
+
+#define COUNTER_COMPONENT_SIGNAL 0
+#define COUNTER_COMPONENT_COUNT 1
+#define COUNTER_COMPONENT_FUNCTION 2
+#define COUNTER_COMPONENT_SYNAPSE_ACTION 3
+#define COUNTER_COMPONENT_EXTENSION 4
+
+/**
+ * struct counter_component - Counter component identification
+ * @scope: component scope (Device, Count, or Signal)
+ * @parent: parent component identification number
+ * @type: component type (Count, extension, etc.)
+ * @id: component identification number
+ */
+struct counter_component {
+	__u8 scope;
+	__u64 parent;
+	__u8 type;
+	__u64 id;
+};
+
+#define COUNTER_EVENT_OVERFLOW 0
+#define COUNTER_EVENT_UNDERFLOW 1
+#define COUNTER_EVENT_OVERFLOW_UNDERFLOW 2
+#define COUNTER_EVENT_THRESHOLD 3
+#define COUNTER_EVENT_INDEX 4
+
+/**
+ * struct counter_watch - Counter component watch configuration
+ * @event: event that triggers
+ * @channel: event channel
+ * @component: component to watch when event triggers
+ */
+struct counter_watch {
+	__u8 event;
+	__u8 channel;
+	struct counter_component component;
+};
+
+#define COUNTER_CLEAR_WATCHES_IOCTL _IO(0x3E, 0x00)
+#define COUNTER_SET_WATCH_IOCTL _IOW(0x3E, 0x01, struct counter_watch)
+#define COUNTER_LOAD_WATCHES_IOCTL _IO(0x3E, 0x02)
+
+/**
+ * struct counter_event - Counter event data
+ * @timestamp: best estimate of time of event occurrence, in nanoseconds
+ * @watch: component watch configuration
+ * @value_u8: component value as __u8 data type
+ * @value_u64: component value as __u64 data type
+ */
+struct counter_event {
+	__u64 timestamp;
+	struct counter_watch watch;
+	union {
+		__u8 value_u8;
+		__u64 value_u64;
+	};
+};
+
+#define COUNTER_COUNT_DIRECTION_FORWARD 0
+#define COUNTER_COUNT_DIRECTION_BACKWARD 1
+
+#define COUNTER_COUNT_MODE_NORMAL 0
+#define COUNTER_COUNT_MODE_RANGE_LIMIT 1
+#define COUNTER_COUNT_MODE_NON_RECYCLE 2
+#define COUNTER_COUNT_MODE_MODULO_N 3
+
+#define COUNTER_FUNCTION_INCREASE 0
+#define COUNTER_FUNCTION_DECREASE 1
+#define COUNTER_FUNCTION_PULSE_DIRECTION 2
+#define COUNTER_FUNCTION_QUADRATURE_X1_A 3
+#define COUNTER_FUNCTION_QUADRATURE_X1_B 4
+#define COUNTER_FUNCTION_QUADRATURE_X2_A 5
+#define COUNTER_FUNCTION_QUADRATURE_X2_B 6
+#define COUNTER_FUNCTION_QUADRATURE_X4 7
+
+#define COUNTER_SIGNAL_LEVEL_LOW 0
+#define COUNTER_SIGNAL_LEVEL_HIGH 1
+
+#define COUNTER_SYNAPSE_ACTION_NONE 0
+#define COUNTER_SYNAPSE_ACTION_RISING_EDGE 1
+#define COUNTER_SYNAPSE_ACTION_FALLING_EDGE 2
+#define COUNTER_SYNAPSE_ACTION_BOTH_EDGES 3
+
+#endif /* _UAPI_COUNTER_H_ */
-- 
2.28.0

