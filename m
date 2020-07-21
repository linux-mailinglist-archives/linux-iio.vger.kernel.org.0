Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D1E228944
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 21:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgGUTgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbgGUTgO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 15:36:14 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C1C061794;
        Tue, 21 Jul 2020 12:36:14 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so9865128qvb.13;
        Tue, 21 Jul 2020 12:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9tyAwUinMCB1oJUAyOuuifwIeIOtmGEvSaPKx2dPaQ=;
        b=LcAncKg+OFDSpjv3wz/xQjdQ1CYHU6fWdYJbzD6XZIQRUTKIzroS/xVyFlQ97n+YYq
         PSn63MEkBsux3uPYghE2nx7ZbWGZcWCL32yfJ63MqrYeZFVyPAwuTWkHHp2b9B4NLtYf
         bhLVnFSNySsPvi/iKnNnpMMoMOykNh0Gnz8BqdTFqTwROQHgR+x+0UXL/rToaS1/2Uf8
         5jYVOwCm6o05EX+Yjo7B77C1jm25y7VNiqFTFHBZfjdFCNqs+ONR/8XPbH9u/cmVnETQ
         PCVBMl1PmBuHF9BG7vwtPkm981yF6qx+zyEjZuoMugl5NtiPTRERbF5JJmh8JZpqUa7m
         q0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9tyAwUinMCB1oJUAyOuuifwIeIOtmGEvSaPKx2dPaQ=;
        b=inYTZoTY1fNbh0NSqavDFdhma2RG4l2eKczF2GxFn0RUrKrutLQaUwGNMie9wu5/oo
         pTkQdQABHMqcPxXPxq488uekO3yLCAVzSpRjeq7HJDSSA5u/FZuPtQHTb/cHObsnQGub
         wf/JbQCi4+TeBU8FAUUnABeyHIH+MC26mDGmaEIkY9/DMuCXvS5/oDq3f29JJ9xpBIVT
         u6fpo0Vfz3LA/V7MuGFZtDwpJA6X4mYjYSawqCNHmQosdRViiazlc6OIAa1HRwDsj2e6
         FkOgBrrI5heIRsOe2ValjoPDchusv2/eQdBux8m7Hob0RX0HawzFovb2LEIkbxq5gr5s
         swkg==
X-Gm-Message-State: AOAM533jtMBd9LETiYqn60ib5VKV/6uoRkWNN9u1Z2Ar2vlDPSLG21A7
        KX7kgxhicAY+5k18fXtLuVc=
X-Google-Smtp-Source: ABdhPJwVViaSfl+JWVubq5SDBxy/8we9OD74Z6Q+YmvkZ5B1zDf4IYe5yO6eSe8HCxz9f2+cIS/mHw==
X-Received: by 2002:a0c:a993:: with SMTP id a19mr28465400qvb.34.1595360173586;
        Tue, 21 Jul 2020 12:36:13 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id j72sm3331351qke.20.2020.07.21.12.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:36:12 -0700 (PDT)
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
Subject: [PATCH v4 3/5] counter: Add character device interface
Date:   Tue, 21 Jul 2020 15:35:49 -0400
Message-Id: <08b3ac7349a59ba7fa5cd438bbe78360842ccd11.1595358237.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595358237.git.vilhelm.gray@gmail.com>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces a character device interface for the Counter
subsystem. Device data is exposed through standard character device read
operations. Device data is gathered when a Counter event is pushed by
the respective Counter device driver. Configuration is handled via ioctl
operations on the respective Counter character device node.

A high-level view of how a count value is passed down from a counter
driver is exemplified by the following:

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
                | Counter device driver      |----------+
                +----------------------------+          |
                | Processes data from device |   -------------------
                |----------------------------|  / driver callbacks /
                | Type: u64                  |  -------------------
                | Value: 42                  |          |
                +----------------------------+          |
                        |                               |
                 ----------                             |
                / u64     /                             |
                ----------                              |
                        |                               |
                        |                               V
                        |               +----------------------+
                        |               | Counter core         |
                        |               +----------------------+
                        |               | Routes device driver |
                        |               | callbacks to the     |
                        |               | userspace interfaces |
                        |               +----------------------+
                        |                       |
                        |                -------------------
                        |               / driver callbacks /
                        |               -------------------
                        |                       |
                +-------+---------------+       |
                |                       |       |
                |               +-------|-------+
                |               |       |
                V               |       V
        +--------------------+  |  +---------------------+
        | Counter sysfs      |<-+->| Counter chrdev      |
        +--------------------+     +---------------------+
        | Translates to the  |     | Translates to the   |
        | standard Counter   |     | standard Counter    |
        | sysfs output       |     | character device    |
        |--------------------|     |---------------------+
        | Type: const char * |     | Type: u64           |
        | Value: "42"        |     | Value: 42           |
        +--------------------+     +---------------------+
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
                           const u8 event);

The event id is specified by the `event` parameter. When this function
is called, the Counter data associated with the respective event is
gathered, and a `struct counter_event` is generated for each datum and
pushed to userspace.

Counter events can be configured by users to report various Counter
data of interest. This can be conceptualized as a list of Counter
component read calls to perform. For example:

    +------------------------+------------------------+
    | Event 0                | Event 1                |
    +------------------------+------------------------+
    | * Count 0              | * Signal 0             |
    | * Count 1              | * Signal 0 Extension 0 |
    | * Signal 3             | * Extension 4          |
    | * Count 4 Extension 2  |                        |
    | * Signal 5 Extension 0 |                        |
    +------------------------+------------------------+

When `counter_push_event(counter, 1)` is called for example, it will go
down the list for Event 1 and execute the read callbacks for Signal 0,
Signal 0 Extension 0, and Extension 4 -- the data returned for each is
pushed to a kfifo as a `struct counter_event`, which userspace can
retrieve via a standard read operation on the respective character
device node.

Userspace
---------
Userspace applications can configure Counter events via ioctl operations
on the Counter character device node. There following ioctl codes are
supported and provided by the `linux/counter.h` userspace header file:

* COUNTER_CLEAR_WATCHES_IOCTL:
  Clear all Counter watches from all events

* COUNTER_SET_WATCH_IOCTL:
  Set a Counter watch on the specified event

To configure events to gather Counter data, users first populate a
`struct counter_watch` with the relevant event id and the information
for the desired Counter component from which to read, and then pass it
via the `COUNTER_SET_WATCH_IOCTL` ioctl command.

Userspace applications can then execute a `read` operation (optionally
calling `poll` first) on the Counter character device node to retrieve
`struct counter_event` elements with the desired data.

For example, the following userspace code opens `/dev/counter0`,
configures Event 0 to gather Count 0 and Count 1, and prints out the
data as it becomes available on the character device node:

    #include <fcntl.h>
    #include <linux/counter.h>
    #include <poll.h>
    #include <stdio.h>
    #include <sys/ioctl.h>
    #include <unistd.h>

    struct counter_watch watches[2] = {
            {
                    .event = 0,
                    .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
                    .component.owner_id = 0,
                    .component.type = COUNTER_COMPONENT_TYPE_COUNT,
            },
            {
                    .event = 0,
                    .component.owner_type = COUNTER_OWNER_TYPE_COUNT,
                    .component.owner_id = 1,
                    .component.type = COUNTER_COMPONENT_TYPE_COUNT,
            },
    };

    int main(void)
    {
            struct pollfd pfd = { .events = POLLIN };
            struct counter_event event_data[2];

            pfd.fd = open("/dev/counter0", O_RDWR);

            ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches);
            ioctl(pfd.fd, COUNTER_SET_WATCH_IOCTL, watches + 1);

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
 drivers/counter/Makefile         |   2 +-
 drivers/counter/counter-chrdev.c | 441 +++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |  16 ++
 drivers/counter/counter-core.c   |  35 ++-
 include/linux/counter.h          |  15 ++
 include/uapi/linux/counter.h     |  52 ++++
 6 files changed, 558 insertions(+), 3 deletions(-)
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
index 000000000000..9aa2d32e7bc9
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,441 @@
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
+struct counter_data_item {
+	struct list_head l;
+	struct counter_component component;
+	struct counter_data data;
+	void *owner;
+};
+
+struct counter_event_item {
+	struct list_head l;
+	u8 event;
+	struct list_head data_list;
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
+static void counter_events_list_free(struct counter_device *const counter)
+{
+	unsigned long flags;
+	struct counter_event_item *p, *n;
+	struct counter_data_item *q, *o;
+
+	raw_spin_lock_irqsave(&counter->events_lock, flags);
+
+	list_for_each_entry_safe(p, n, &counter->events_list, l) {
+		/* Free associated data items */
+		list_for_each_entry_safe(q, o, &p->data_list, l) {
+			list_del(&q->l);
+			kfree(q);
+		}
+
+		/* Free event item */
+		list_del(&p->l);
+		kfree(p);
+	}
+
+	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
+}
+
+static int counter_set_event_item(struct counter_device *const counter,
+				  const u8 event,
+				  const struct counter_data_item *const cfg)
+{
+	unsigned long flags;
+	struct counter_event_item *event_item;
+	int err;
+	struct counter_data_item *data_item;
+
+	raw_spin_lock_irqsave(&counter->events_lock, flags);
+
+	/* Search for event in the list */
+	list_for_each_entry(event_item, &counter->events_list, l)
+		if (event_item->event == event)
+			break;
+
+	/* If event is not already in the list */
+	if (&event_item->l == &counter->events_list) {
+		/* Allocate new event item */
+		event_item = kmalloc(sizeof(*event_item), GFP_ATOMIC);
+		if (!event_item) {
+			err = -ENOMEM;
+			goto err_event_item;
+		}
+
+		/* Configure event item and add to the list */
+		event_item->event = event;
+		INIT_LIST_HEAD(&event_item->data_list);
+		list_add(&event_item->l, &counter->events_list);
+	}
+
+	/* Search for data item in the list */
+	list_for_each_entry(data_item, &event_item->data_list, l)
+		if (data_item->owner == cfg->owner &&
+		    data_item->data.count_u8_read == cfg->data.count_u8_read) {
+			err = -EINVAL;
+			goto err_data_item;
+		}
+
+	/* Allocate data item */
+	data_item = kmalloc(sizeof(*data_item), GFP_ATOMIC);
+	if (!data_item) {
+		err = -ENOMEM;
+		goto err_data_item;
+	}
+	*data_item = *cfg;
+
+	/* Add data item to event item */
+	list_add_tail(&data_item->l, &event_item->data_list);
+
+	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
+
+	return 0;
+
+err_data_item:
+	if (list_empty(&event_item->data_list)) {
+		list_del(&event_item->l);
+		kfree(event_item);
+	}
+err_event_item:
+	raw_spin_unlock_irqrestore(&counter->events_lock, flags);
+	return err;
+}
+
+static int counter_set_watch(struct counter_device *const counter,
+			     const unsigned long arg)
+{
+	void __user *const uwatch = (void __user *)arg;
+	struct counter_watch watch;
+	struct counter_data_item data_item;
+	size_t owner_id, id;
+	struct counter_data *ext;
+	size_t num_ext;
+
+	if (copy_from_user(&watch, uwatch, sizeof(watch)))
+		return -EFAULT;
+	owner_id = watch.component.owner_id;
+	id = watch.component.id;
+
+	/* Configure owner info for data item */
+	switch (watch.component.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		data_item.owner = NULL;
+
+		ext = counter->ext;
+		num_ext = counter->num_ext;
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		if (counter->num_signals < owner_id + 1)
+			return -EINVAL;
+
+		data_item.owner = counter->signals + owner_id;
+
+		ext = counter->signals[owner_id].ext;
+		num_ext = counter->signals[owner_id].num_ext;
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		if (counter->num_counts < owner_id + 1)
+			return -EINVAL;
+
+		data_item.owner = counter->counts + owner_id;
+
+		ext = counter->counts[owner_id].ext;
+		num_ext = counter->counts[owner_id].num_ext;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Configure component info for data item */
+	switch (watch.component.type) {
+	case COUNTER_COMPONENT_TYPE_SIGNAL:
+		if (watch.component.owner_type != COUNTER_OWNER_TYPE_SIGNAL)
+			return -EINVAL;
+
+		data_item.data.type = COUNTER_DATA_TYPE_SIGNAL;
+		data_item.data.signal_u8_read = counter->signal_read;
+		break;
+	case COUNTER_COMPONENT_TYPE_COUNT:
+		if (watch.component.owner_type != COUNTER_OWNER_TYPE_COUNT)
+			return -EINVAL;
+
+		data_item.data.type = COUNTER_DATA_TYPE_U64;
+		data_item.data.count_u64_read = counter->count_read;
+		break;
+	case COUNTER_COMPONENT_TYPE_COUNT_FUNCTION:
+		if (watch.component.owner_type != COUNTER_OWNER_TYPE_COUNT)
+			return -EINVAL;
+
+		data_item.data.type = COUNTER_DATA_TYPE_COUNT_FUNCTION;
+		data_item.data.count_u8_read = counter->function_read;
+		break;
+	case COUNTER_COMPONENT_TYPE_SYNAPSE_ACTION:
+		if (watch.component.owner_type != COUNTER_OWNER_TYPE_COUNT)
+			return -EINVAL;
+		if (counter->counts[owner_id].num_synapses < id + 1)
+			return -EINVAL;
+
+		data_item.data.type = COUNTER_DATA_TYPE_SYNAPSE_ACTION;
+		data_item.data.action_read = counter->action_read;
+		data_item.data.priv = counter->counts[owner_id].synapses + id;
+		break;
+	case COUNTER_COMPONENT_TYPE_EXTENSION:
+		if (num_ext < id + 1)
+			return -EINVAL;
+
+		data_item.data = ext[id];
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (!data_item.data.count_u8_read)
+		return -EFAULT;
+	data_item.component = watch.component;
+
+	return counter_set_event_item(counter, watch.event, &data_item);
+}
+
+static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct counter_device *const counter = filp->private_data;
+
+	switch (cmd) {
+	case COUNTER_CLEAR_WATCHES_IOCTL:
+		counter_events_list_free(counter);
+		break;
+	case COUNTER_SET_WATCH_IOCTL:
+		return counter_set_watch(counter, arg);
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
+
+	put_device(&counter->dev);
+
+	counter_events_list_free(counter);
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
+	/* Initialize Counter events list */
+	INIT_LIST_HEAD(&counter->events_list);
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
+void counter_chrdev_free(struct counter_device *const counter)
+{
+	cdev_del(&counter->chrdev);
+}
+
+static int counter_get_data(struct counter_device *const counter,
+			    const struct counter_data_item *const data_item,
+			    void *const value)
+{
+	const struct counter_data *const data = &data_item->data;
+	void *const owner = data_item->owner;
+
+	switch (data->type) {
+	case COUNTER_DATA_TYPE_U8:
+	case COUNTER_DATA_TYPE_BOOL:
+	case COUNTER_DATA_TYPE_SIGNAL:
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+	case COUNTER_DATA_TYPE_ENUM:
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		switch (data_item->component.owner_type) {
+		case COUNTER_OWNER_TYPE_DEVICE:
+			return data->device_u8_read(counter, value);
+		case COUNTER_OWNER_TYPE_SIGNAL:
+			return data->signal_u8_read(counter, owner, value);
+		case COUNTER_OWNER_TYPE_COUNT:
+			return data->count_u8_read(counter, owner, value);
+		}
+		break;
+	case COUNTER_DATA_TYPE_U64:
+		switch (data_item->component.owner_type) {
+		case COUNTER_OWNER_TYPE_DEVICE:
+			return data->device_u64_read(counter, value);
+		case COUNTER_OWNER_TYPE_SIGNAL:
+			return data->signal_u64_read(counter, owner, value);
+		case COUNTER_OWNER_TYPE_COUNT:
+			return data->count_u64_read(counter, owner, value);
+		}
+		break;
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+		return data->action_read(counter, owner, data->priv, value);
+	}
+
+	return 0;
+}
+
+/**
+ * counter_push_event - queue event for userspace reading
+ * @counter:	pointer to Counter structure
+ * @event:	triggered event
+ *
+ * Note: If no one is watching for the respective event, it is silently
+ * discarded.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int counter_push_event(struct counter_device *const counter, const u8 event)
+{
+	struct counter_event ev = { .watch.event = event };
+	unsigned int copied = 0;
+	unsigned long flags;
+	struct counter_event_item *event_item;
+	struct counter_data_item *data_item;
+	int err;
+
+	ev.timestamp = ktime_get_ns();
+
+	raw_spin_lock_irqsave(&counter->events_lock, flags);
+
+	/* Search for event in the list */
+	list_for_each_entry(event_item, &counter->events_list, l)
+		if (event_item->event == event)
+			break;
+
+	/* If event is not in the list */
+	if (&event_item->l == &counter->events_list)
+		goto exit_early;
+
+	/* Read and queue relevant data for userspace */
+	list_for_each_entry(data_item, &event_item->data_list, l) {
+		err = counter_get_data(counter, data_item, &ev.value_u8);
+		if (err)
+			goto err_counter_get_data;
+
+		ev.watch.component = data_item->component;
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
index 000000000000..7ab0797d3857
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
+void counter_chrdev_free(struct counter_device *const counter);
+
+#endif /* _COUNTER_CHRDEV_H_ */
diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 499664809c75..d9ae889a0a8c 100644
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
@@ -62,10 +68,15 @@ int counter_register(struct counter_device *const counter)
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
+		goto err_free_chrdev;
 
 	/* Add device to system */
 	err = device_add(dev);
@@ -76,6 +87,8 @@ int counter_register(struct counter_device *const counter)
 
 err_free_sysfs:
 	counter_sysfs_free(counter);
+err_free_chrdev:
+	counter_chrdev_free(counter);
 err_free_id:
 	ida_simple_remove(&counter_ida, counter->id);
 	return err;
@@ -93,6 +106,7 @@ void counter_unregister(struct counter_device *const counter)
 	if (counter) {
 		device_del(&counter->dev);
 		counter_sysfs_free(counter);
+		counter_chrdev_free(counter);
 	}
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
@@ -139,13 +153,30 @@ int devm_counter_register(struct device *dev,
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
index 76657d203a26..d4f2f2463ea3 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,10 +6,14 @@
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
 #include <uapi/linux/counter.h>
 
 struct counter_device;
@@ -166,6 +170,11 @@ struct counter_attribute_group {
  * @priv:		optional private data supplied by driver
  * @id:			unique ID used to identify the Counter
  * @dev:		internal device structure
+ * @chrdev:		internal character device structure
+ * @events_list:	list for Counter events
+ * @events_lock:	synchronization lock for Counter events
+ * @events_wait:	wait queue to allow blocking reads of Counter events
+ * @events:		queue of detected Counter events
  * @dynamic_names_list:	list for dynamically allocated names
  * @groups_list:	attribute groups list (for Signals, Counts, and ext)
  * @num_groups:		number of attribute groups containers
@@ -204,6 +213,11 @@ struct counter_device {
 
 	int id;
 	struct device dev;
+	struct cdev chrdev;
+	struct list_head events_list;
+	raw_spinlock_t events_lock;
+	wait_queue_head_t events_wait;
+	DECLARE_KFIFO(events, struct counter_event, 64);
 	struct list_head dynamic_names_list;
 	struct counter_attribute_group *groups_list;
 	size_t num_groups;
@@ -216,6 +230,7 @@ int devm_counter_register(struct device *dev,
 			  struct counter_device *const counter);
 void devm_counter_unregister(struct device *dev,
 			     struct counter_device *const counter);
+int counter_push_event(struct counter_device *const counter, const u8 event);
 
 #define COUNTER_DATA_DEVICE_U8(_name, _read, _write) \
 { \
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 2ddee9fc93e0..b903d2ad9a94 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -6,10 +6,62 @@
 #ifndef _UAPI_COUNTER_H_
 #define _UAPI_COUNTER_H_
 
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
 #define COUNTER_OWNER_TYPE_DEVICE 0
 #define COUNTER_OWNER_TYPE_SIGNAL 1
 #define COUNTER_OWNER_TYPE_COUNT 2
 
+#define COUNTER_COMPONENT_TYPE_SIGNAL 0
+#define COUNTER_COMPONENT_TYPE_COUNT 1
+#define COUNTER_COMPONENT_TYPE_COUNT_FUNCTION 2
+#define COUNTER_COMPONENT_TYPE_SYNAPSE_ACTION 3
+#define COUNTER_COMPONENT_TYPE_EXTENSION 4
+
+/**
+ * struct counter_component - Counter component identification
+ * @owner_type: owner type (Device, Count, or Signal)
+ * @owner_id: owner identification number
+ * @type: component type (Count, extension, etc.)
+ * @id: component identification number
+ */
+struct counter_component {
+	__u8 owner_type;
+	__u64 owner_id;
+	__u8 type;
+	__u64 id;
+};
+
+/**
+ * struct counter_watch - Counter component watch configuration
+ * @event: event that triggers
+ * @component: component to watch when event triggers
+ */
+struct counter_watch {
+	__u8 event;
+	struct counter_component component;
+};
+
+#define COUNTER_CLEAR_WATCHES_IOCTL _IO(0x3E, 0x00)
+#define COUNTER_SET_WATCH_IOCTL _IOW(0x3E, 0x01, struct counter_watch)
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
 #define COUNTER_COUNT_DIRECTION_FORWARD 0
 #define COUNTER_COUNT_DIRECTION_BACKWARD 1
 
-- 
2.27.0

