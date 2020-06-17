Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C209B1FC3C2
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 03:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFQBkq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jun 2020 21:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgFQBkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jun 2020 21:40:42 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5714EC061755;
        Tue, 16 Jun 2020 18:40:42 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so574226qkm.12;
        Tue, 16 Jun 2020 18:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0csgoCX319PKYVdsQqv1oUno0AmosjDlVicGEj8q8Y0=;
        b=CIiN+ofB83aIeMUZC50qujee7nyKIdPxY+gJ7XFqCcReaByZXZQN2jj6iYj96+94dN
         XZUnRWBc3c5LfIXzO7eGLJHe8mzzWOGyPHkLfgumR/e/0UBQDdh2bQpbf3mHe+AJ6Bun
         +qGwjsUAigBjkp3t8BZZUnf6nKmpGV4XtrzlrhZI8Wr0TzLfvOBJWtiKoXPzxcO+c419
         kzo4MKGgEbwUA9pLPdfFT2GOEVcvq5sUNAg9w90jO3WFY9K1t1Eu+HZW9SpQu4E0ShGG
         VNYaXTwW5tq2vYR52aeOx+E7WIGMKpurJpwCVrHvPCPvZzbDZptHH9qwFSzMNN2K/aJj
         TBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0csgoCX319PKYVdsQqv1oUno0AmosjDlVicGEj8q8Y0=;
        b=IcHWajfJeV6loAPoRn6UeOLKoz+fBgLnhms4UAnerr65D3RcF6v25KD2ztfRdW4eLJ
         h1o5dNNvbzUqHYE0XXzUrH06lkt1lBdM5xT2JRVE363lpFjA5wchUNibmJukxW4JXlNS
         LmRDGt7oyUXE5GrE1T1y81h9k6WVbVKirn1rZ2xczCOZkSeEZRVIphskZXA/zxSQeI5u
         PZgsdWkn3HrdhKailHvEPy8g7iIUPAxGZQX3QVfACjvD3fl2TFeLz6x5RgX7js7lqTeH
         Ni3XT+Xfz696B1RIom2Vpu1oUz+5wl043On0ez4HNGmmLmEtyxwlEVjYnm5G7KwHSNUH
         uLsA==
X-Gm-Message-State: AOAM533KyfPEv4WP+5GJGCuTMIu3L2CZwywl/Zi8E9JP3LmMbOIWabM+
        /rUk+Kt7dS4+vTwabGDgp28=
X-Google-Smtp-Source: ABdhPJzjMOIMwyOtM20XvT2AAJaO8e9JJ5Bp7+k+tbyoWjPF3KmLxeThkOTqPjtN/M39G1vJk9lEGg==
X-Received: by 2002:ae9:e88c:: with SMTP id a134mr21913981qkg.316.1592358041381;
        Tue, 16 Jun 2020 18:40:41 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id a14sm1917014qkn.16.2020.06.16.18.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:40:40 -0700 (PDT)
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
Subject: [PATCH v3 3/4] counter: Add character device interface
Date:   Tue, 16 Jun 2020 21:40:01 -0400
Message-Id: <afe40ef2e24ecaca44fc229f7983cf4cde3374a8.1592341702.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592341702.git.vilhelm.gray@gmail.com>
References: <cover.1592341702.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces a character device interface for the Counter
subsystem. Device control is exposed through standard character device
read and write operations.

A /sys/bus/counter/devices/counterX/chrdev_format sysfs attribute is
introduced to expose the character device data format:

* Users may write to this sysfs attribute to select the components they
  want to interface -- the layout can be determined as well from the
  order. For example:

  # echo "C0 C3 C2" > /sys/bus/counter/devices/counter0/chrdev_format

  This would select Counts 0, 3, and 2 (in that order) to be available
  in the /dev/counter0 node as a contiguous memory region.

  You can select extensions in a similar fashion:

  # echo "C4E2 S1E0" > /sys/bus/counter/devices/counter0/chrdev_format

  This would select extension 2 from Count 4, and extension 0 from
  Signal 1.

* Users may read from this chrdev_format sysfs attribute in order to see
  the currently configured format of the character device.

* Users may perform read/write operations on the /dev/counterX node
  directly; the layout of the data is what they user has configured via
  the chrdev_format sysfs attribute. For example:

  # echo "C0 C1 S0 S1" > /sys/bus/counter/devices/counter0/chrdev_format

  Yields the following /dev/counter0 memory layout:

  +-----------------+------------------+----------+----------+
  | Byte 0 - Byte 7 | Byte 8 - Byte 15 | Byte 16  | Byte 17  |
  +-----------------+------------------+----------+----------+
  | Count 0         | Count 1          | Signal 0 | Signal 2 |
  +-----------------+------------------+----------+----------+

  The number of bytes allotted for each component or extension is
  determined by its respective data type: u8 will have 1 byte allotted,
  u64 will have 8 bytes allotted, etc.

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
         ---------------                 ----------
        / const char * /                / u64     /
        ---------------                 ----------
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

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                      |   1 +
 drivers/counter/Makefile         |   2 +-
 drivers/counter/counter-chrdev.c | 612 +++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |  23 ++
 drivers/counter/counter-core.c   |  34 +-
 drivers/counter/counter-sysfs.c  |  38 +-
 include/linux/counter.h          |  12 +-
 7 files changed, 714 insertions(+), 8 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ea12db794be..b4ed407a13f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4413,6 +4413,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
+F:	include/uapi/linux/counter.h
 F:	include/uapi/linux/counter-types.h
 
 CPMAC ETHERNET DRIVER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index f48e337cbd85..d219b9c058e7 100644
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
index 000000000000..e143380edd21
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Counter character device interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+
+#include <linux/cdev.h>
+#include <linux/counter.h>
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+#include "counter-chrdev.h"
+#include "counter-common.h"
+
+struct counter_control {
+	loff_t offset;
+	size_t size;
+	struct list_head l;
+
+	struct counter_data data;
+	enum counter_owner_type type;
+	void *owner;
+};
+
+static int counter_data_u8_read(struct counter_device *const counter,
+				const struct counter_control *const control,
+				u8 __user *const buf)
+{
+	const struct counter_data *const data = &control->data;
+	int err;
+	u8 val;
+
+	switch (control->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = data->device_u8_read(counter, &val);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = data->signal_u8_read(counter, control->owner, &val);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		if (data->type == COUNTER_DATA_TYPE_SYNAPSE_ACTION)
+			err = data->action_read(counter, control->owner,
+						data->priv, &val);
+		else
+			err = data->count_u8_read(counter, control->owner,
+						  &val);
+		break;
+	}
+	if (err)
+		return err;
+
+	return put_user(val, buf);
+}
+
+static int counter_data_u64_read(struct counter_device *const counter,
+				 const struct counter_control *const control,
+				 char __user *const buf, const size_t len,
+				 const size_t offset)
+{
+	const struct counter_data *const data = &control->data;
+	int err;
+	u64 val;
+
+	switch (control->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = data->device_u64_read(counter, &val);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = data->signal_u64_read(counter, control->owner, &val);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		err = data->count_u64_read(counter, control->owner, &val);
+		break;
+	}
+	if (err)
+		return err;
+
+	return copy_to_user(buf, (const char *)&val + offset, len);
+}
+
+static int counter_control_read(struct counter_device *const counter,
+				const struct counter_control *const control,
+				char __user *const buf, const size_t len,
+				const size_t offset)
+{
+	/* Check if read operation is supported */
+	if (!control->data.device_u8_read)
+		return -EFAULT;
+
+	switch (control->data.type) {
+	case COUNTER_DATA_TYPE_U8:
+	case COUNTER_DATA_TYPE_BOOL:
+	case COUNTER_DATA_TYPE_SIGNAL:
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+	case COUNTER_DATA_TYPE_ENUM:
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		return counter_data_u8_read(counter, control, buf);
+	case COUNTER_DATA_TYPE_U64:
+		return counter_data_u64_read(counter, control, buf, len,
+					     offset);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
+				   size_t len, loff_t *f_ps)
+{
+	struct counter_device *const counter = filp->private_data;
+	const loff_t start_ps = *f_ps;
+	struct counter_control *control;
+	loff_t next_control_ps;
+	size_t read_size;
+	int err;
+
+	mutex_lock(&counter->control_lock);
+
+	/* Handle controls */
+	list_for_each_entry(control, &counter->control_list, l) {
+		next_control_ps = control->offset + control->size;
+
+		/* Find first control item */
+		if (*f_ps >= next_control_ps)
+			continue;
+
+		read_size = (*f_ps + len > next_control_ps) ?
+			    next_control_ps - *f_ps : len;
+
+		err = counter_control_read(counter, control, buf, read_size,
+					   control->offset - *f_ps);
+		if (err) {
+			mutex_unlock(&counter->control_lock);
+			return err;
+		}
+
+		*f_ps += read_size;
+		buf += read_size;
+		len -= read_size;
+		if (!len)
+			goto exit_chrdev_read;
+	}
+
+exit_chrdev_read:
+	mutex_unlock(&counter->control_lock);
+	return *f_ps - start_ps;
+}
+
+static int counter_data_u8_write(struct counter_device *const counter,
+				 const struct counter_control *const control,
+				 const u8 __user *const buf)
+{
+	const struct counter_data *const data = &control->data;
+	int err;
+	u8 val;
+
+	err = get_user(val, buf);
+	if (err)
+		return err;
+
+	switch (control->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = data->device_u8_write(counter, val);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = data->signal_u8_write(counter, control->owner, val);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		if (data->type == COUNTER_DATA_TYPE_SYNAPSE_ACTION)
+			err = data->action_write(counter, control->owner,
+						 data->priv, val);
+		else
+			err = data->count_u8_write(counter, control->owner,
+						   val);
+		break;
+	}
+
+	return err;
+}
+
+static int counter_data_u64_write(struct counter_device *const counter,
+				  const struct counter_control *const control,
+				  const char __user *const buf,
+				  const size_t len, const size_t offset)
+{
+	const struct counter_data *const data = &control->data;
+	int err;
+	u64 val = 0;
+
+	err = copy_from_user((char *)&val + offset, buf, len);
+	if (err)
+		return err;
+
+	switch (control->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = data->device_u64_write(counter, val);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = data->signal_u64_write(counter, control->owner, val);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		err = data->count_u64_write(counter, control->owner, val);
+		break;
+	}
+
+	return err;
+}
+
+static int counter_control_write(struct counter_device *const counter,
+				 const struct counter_control *const control,
+				 const char __user *const buf, const size_t len,
+				 const size_t offset)
+{
+	/* Check if write operation is supported */
+	if (!control->data.device_u8_write)
+		return -EFAULT;
+
+	switch (control->data.type) {
+	case COUNTER_DATA_TYPE_U8:
+	case COUNTER_DATA_TYPE_BOOL:
+	case COUNTER_DATA_TYPE_SIGNAL:
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+	case COUNTER_DATA_TYPE_ENUM:
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		return counter_data_u8_write(counter, control, buf);
+	case COUNTER_DATA_TYPE_U64:
+		return counter_data_u64_write(counter, control, buf, len,
+					      offset);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t counter_chrdev_write(struct file *filp, const char __user *buf,
+				    size_t len, loff_t *f_ps)
+{
+	struct counter_device *const counter = filp->private_data;
+	const loff_t start_ps = *f_ps;
+	struct counter_control *control;
+	loff_t next_control_ps;
+	size_t write_size;
+	int err;
+
+	mutex_lock(&counter->control_lock);
+
+	/* Handle controls */
+	list_for_each_entry(control, &counter->control_list, l) {
+		next_control_ps = control->offset + control->size;
+
+		/* Find first control item */
+		if (*f_ps >= next_control_ps)
+			continue;
+
+		write_size = (*f_ps + len > next_control_ps) ?
+			     next_control_ps - *f_ps : len;
+
+		err = counter_control_write(counter, control, buf, write_size,
+					    control->offset - *f_ps);
+		if (err) {
+			mutex_unlock(&counter->control_lock);
+			return err;
+		}
+
+		*f_ps += write_size;
+		buf += write_size;
+		len -= write_size;
+		if (!len)
+			goto exit_chrdev_write;
+	}
+
+	mutex_unlock(&counter->control_lock);
+
+	return -EFAULT;
+
+exit_chrdev_write:
+	mutex_unlock(&counter->control_lock);
+	return *f_ps - start_ps;
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
+	return generic_file_open(inode, filp);
+}
+
+static int counter_chrdev_release(struct inode *inode, struct file *filp)
+{
+	struct counter_device *const counter = container_of(inode->i_cdev,
+							    typeof(*counter),
+							    chrdev);
+
+	put_device(&counter->dev);
+
+	return 0;
+}
+
+static const struct file_operations counter_fops = {
+	.llseek = generic_file_llseek,
+	.read = counter_chrdev_read,
+	.write = counter_chrdev_write,
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
+	/* Initialize Counter character device selected controls list */
+	INIT_LIST_HEAD(&counter->control_list);
+
+	/* Initialize mutex for Counter character device selected controls */
+	mutex_init(&counter->control_lock);
+
+	/* Initialize character device */
+	cdev_init(chrdev, &counter_fops);
+	dev->devt = MKDEV(MAJOR(counter_devt), counter->id);
+	cdev_set_parent(chrdev, &dev->kobj);
+
+	return cdev_add(chrdev, dev->devt, 1);
+}
+
+static void counter_control_list_free(struct list_head *const controls)
+{
+	struct counter_control *p, *n;
+
+	list_for_each_entry_safe(p, n, controls, l) {
+		list_del(&p->l);
+		kfree(p);
+	}
+}
+
+void counter_chrdev_free(struct counter_device *const counter)
+{
+	cdev_del(&counter->chrdev);
+
+	mutex_lock(&counter->control_lock);
+	counter_control_list_free(&counter->control_list);
+	mutex_unlock(&counter->control_lock);
+}
+
+ssize_t counter_chrdev_format_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct counter_device *const counter = dev_get_drvdata(dev);
+	const struct counter_signal *signal = counter->signals;
+	const struct counter_count *count = counter->counts;
+	size_t len = 0;
+	struct counter_control *control;
+	struct counter_data *ext;
+	size_t idx;
+	const struct counter_synapse *synapse;
+
+	mutex_lock(&counter->control_lock);
+
+	list_for_each_entry(control, &counter->control_list, l) {
+		switch (control->type) {
+		case COUNTER_OWNER_TYPE_DEVICE:
+			ext = counter->ext;
+			idx = counter->num_ext;
+			break;
+		case COUNTER_OWNER_TYPE_SIGNAL:
+			signal = control->owner;
+			ext = signal->ext;
+			idx = signal->num_ext;
+			len += sprintf(buf + len, "S%zu",
+				       signal - counter->signals);
+			break;
+		case COUNTER_OWNER_TYPE_COUNT:
+			count = control->owner;
+			ext = count->ext;
+			idx = count->num_ext;
+			len += sprintf(buf + len, "C%zu",
+				       count - counter->counts);
+			break;
+		}
+
+		switch (control->data.type) {
+		default:
+			/* Handle "count" control item */
+			if (control->data.count_u64_read == counter->count_read)
+				break;
+
+			/* Determine extension index */
+			while (--idx)
+				if (!strcmp(ext[idx].name, control->data.name))
+					break;
+
+			len += sprintf(buf + len, "E%zu", idx);
+			break;
+		case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+			buf[len++] = 'F';
+			break;
+		case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+			synapse = control->data.priv;
+			len += sprintf(buf + len, "A%zu",
+				       synapse - count->synapses);
+			break;
+		case COUNTER_DATA_TYPE_SIGNAL:
+			break;
+		}
+
+		buf[len++] = ' ';
+	}
+
+	mutex_unlock(&counter->control_lock);
+
+	return len;
+}
+
+static int counter_control_add(struct list_head *const controls,
+			       const struct counter_data *const data,
+			       const enum counter_owner_type type,
+			       void *const owner)
+{
+	const struct counter_control *const tail = list_last_entry(controls,
+								   typeof(*tail),
+								   l);
+	struct counter_control *control;
+
+	/* Generate control list item */
+	control = kzalloc(sizeof(*control), GFP_KERNEL);
+	if (!control)
+		return -ENOMEM;
+
+	/* Configure control list item */
+	control->data = *data;
+	control->type = type;
+	control->owner = owner;
+	control->offset = list_empty(controls) ? 0 : tail->offset + tail->size;
+	switch (control->data.type) {
+	case COUNTER_DATA_TYPE_U8:
+	case COUNTER_DATA_TYPE_BOOL:
+	case COUNTER_DATA_TYPE_SIGNAL:
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+	case COUNTER_DATA_TYPE_ENUM:
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		control->size = sizeof(u8);
+		break;
+	case COUNTER_DATA_TYPE_U64:
+		control->size = sizeof(u64);
+		break;
+	}
+
+	/* Add control list item to the list */
+	list_add_tail(&control->l, controls);
+
+	return 0;
+}
+
+ssize_t counter_chrdev_format_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct list_head *const controls = &counter->control_list;
+	size_t pos = skip_spaces(buf) - buf;
+	int num;
+	char id, subid;
+	size_t idx, subidx, maxidx;
+	struct counter_signal *signal;
+	struct counter_count *count;
+	struct counter_data *ext;
+	struct counter_data data;
+	enum counter_owner_type type;
+	void *owner;
+	int err;
+
+	mutex_lock(&counter->control_lock);
+
+	/* Clean up old list */
+	counter_control_list_free(controls);
+
+	while (pos < len) {
+		/* Scan item */
+		num = sscanf(buf + pos, "%c%zu%c%zu", &id, &idx, &subid,
+			     &subidx);
+		if (num < 2) {
+			err = -EINVAL;
+			goto err_control_create;
+		}
+
+		/* Ignore trailing whitespace */
+		if (isspace(subid))
+			num = 2;
+
+		/* Process owner */
+		switch (id) {
+		case 'S':
+			if (idx > counter->num_signals - 1) {
+				err = -EINVAL;
+				goto err_control_create;
+			}
+			signal = counter->signals + idx;
+			ext = signal->ext;
+			maxidx = signal->num_ext - 1;
+
+			/* Handle Signal item */
+			data.type = COUNTER_DATA_TYPE_SIGNAL;
+			data.signal_u8_read = counter->signal_read;
+			type = COUNTER_OWNER_TYPE_SIGNAL;
+			owner = signal;
+			break;
+		case 'C':
+			if (idx > counter->num_counts - 1) {
+				err = -EINVAL;
+				goto err_control_create;
+			}
+			count = counter->counts + idx;
+			ext = count->ext;
+			maxidx = count->num_ext - 1;
+
+			/* Handle Count item */
+			data.type = COUNTER_DATA_TYPE_U64,
+			data.count_u64_read = counter->count_read;
+			data.count_u64_write = counter->count_write;
+			type = COUNTER_OWNER_TYPE_COUNT;
+			owner = count;
+			break;
+		case 'E':
+			if (num > 2 || idx > counter->num_ext - 1) {
+				err = -EINVAL;
+				goto err_control_create;
+			}
+
+			/* Handle device extension item */
+			data = counter->ext[idx];
+			type = COUNTER_OWNER_TYPE_DEVICE;
+			owner = NULL;
+			break;
+		default:
+			err = -EINVAL;
+			goto err_control_create;
+		}
+
+		if (num == 3) {
+			if (subid != 'F') {
+				err = -EINVAL;
+				goto err_control_create;
+			}
+
+			/* Handle count function item */
+			data.type = COUNTER_DATA_TYPE_COUNT_FUNCTION,
+			data.count_u8_read = counter->function_read;
+			data.count_u8_write = counter->function_write;
+		} else if (num == 4) {
+			if (subidx > maxidx) {
+				err = -EINVAL;
+				goto err_control_create;
+			}
+
+			switch (subid) {
+			case 'A':
+				/* Handle Synapse action item */
+				data.type = COUNTER_DATA_TYPE_SYNAPSE_ACTION;
+				data.action_read = counter->action_read;
+				data.action_write = counter->action_write;
+				data.priv = count->synapses + subidx;
+				break;
+			case 'E':
+				/* Handle component extension item */
+				data = ext[subidx];
+				break;
+			default:
+				err = -EINVAL;
+				goto err_control_create;
+			}
+		}
+
+		/* Generate control item */
+		err = counter_control_add(controls, &data, type, owner);
+		if (err)
+			goto err_control_create;
+
+		/* Jump to next item */
+		while (isalnum(buf[pos]))
+			pos++;
+		pos = skip_spaces(buf + pos) - buf;
+	}
+
+	mutex_unlock(&counter->control_lock);
+
+	return len;
+
+err_control_create:
+	counter_control_list_free(controls);
+	mutex_unlock(&counter->control_lock);
+	return err;
+}
diff --git a/drivers/counter/counter-chrdev.h b/drivers/counter/counter-chrdev.h
new file mode 100644
index 000000000000..73af6d236bc8
--- /dev/null
+++ b/drivers/counter/counter-chrdev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Counter character device interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _COUNTER_CHRDEV_H_
+#define _COUNTER_CHRDEV_H_
+
+#include <linux/counter.h>
+#include <linux/device.h>
+#include <linux/types.h>
+
+int counter_chrdev_add(struct counter_device *const counter,
+		       const dev_t counter_devt);
+void counter_chrdev_free(struct counter_device *const counter);
+
+ssize_t counter_chrdev_format_show(struct device *dev,
+				   struct device_attribute *attr, char *buf);
+ssize_t counter_chrdev_format_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len);
+
+#endif /* _COUNTER_CHRDEV_H_ */
diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 499664809c75..2d0886648201 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -6,11 +6,14 @@
 #include <linux/counter.h>
 #include <linux/device.h>
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
@@ -33,6 +36,8 @@ static struct bus_type counter_bus_type = {
 	.name = "counter"
 };
 
+static dev_t counter_devt;
+
 /**
  * counter_register - register Counter to the system
  * @counter:	pointer to Counter to register
@@ -62,10 +67,15 @@ int counter_register(struct counter_device *const counter)
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
@@ -76,6 +86,8 @@ int counter_register(struct counter_device *const counter)
 
 err_free_sysfs:
 	counter_sysfs_free(counter);
+err_free_chrdev:
+	counter_chrdev_free(counter);
 err_free_id:
 	ida_simple_remove(&counter_ida, counter->id);
 	return err;
@@ -93,6 +105,7 @@ void counter_unregister(struct counter_device *const counter)
 	if (counter) {
 		device_del(&counter->dev);
 		counter_sysfs_free(counter);
+		counter_chrdev_free(counter);
 	}
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
@@ -139,13 +152,30 @@ int devm_counter_register(struct device *dev,
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
index ca69e9d4e833..1279bd8a8af1 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 
 #include "counter-common.h"
+#include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
 struct counter_attribute {
@@ -658,11 +659,29 @@ static int counter_num_counts_read(struct counter_device *counter, u8 *val)
 	return 0;
 }
 
-static struct counter_data counter_num_signals_data =
-	COUNTER_DATA_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
+static int counter_format_attr_create(struct counter_attribute_group *group,
+				      struct counter_device *const counter)
+{
+	struct counter_attribute *counter_attr;
+	struct device_attribute *dev_attr;
 
-static struct counter_data counter_num_counts_data =
-	COUNTER_DATA_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
+	/* Allocate Counter attribute */
+	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
+	if (!counter_attr)
+		return -ENOMEM;
+	list_add(&counter_attr->l, &group->attr_list);
+	group->num_attr++;
+
+	/* Configure device attribute */
+	dev_attr = &counter_attr->dev_attr;
+	sysfs_attr_init(&dev_attr->attr);
+	dev_attr->attr.name = "chrdev_format";
+	dev_attr->attr.mode = 0644;
+	dev_attr->show = counter_chrdev_format_show;
+	dev_attr->store = counter_chrdev_format_store;
+
+	return 0;
+}
 
 static void counter_groups_list_free(struct counter_device *const counter)
 {
@@ -685,6 +704,12 @@ static void counter_groups_list_free(struct counter_device *const counter)
 	kfree(counter->groups_list);
 }
 
+static struct counter_data counter_num_signals_data =
+	COUNTER_DATA_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
+
+static struct counter_data counter_num_counts_data =
+	COUNTER_DATA_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
+
 static int counter_device_register(struct counter_attribute_group *group,
 				   struct counter_device *const counter)
 {
@@ -732,6 +757,11 @@ static int counter_device_register(struct counter_attribute_group *group,
 			goto err_free_groups_list;
 	}
 
+	/* Create chrdev_format attribute */
+	err = counter_format_attr_create(group, counter);
+	if (err)
+		goto err_free_groups_list;
+
 	return 0;
 
 err_free_groups_list:
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 3eb567a5884b..88cc4f32dc2d 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,9 +6,11 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <uapi/linux/counter-types.h>
 
@@ -21,8 +23,8 @@ enum counter_data_type {
 	COUNTER_DATA_TYPE_U8,
 	COUNTER_DATA_TYPE_U64,
 	COUNTER_DATA_TYPE_BOOL,
-	COUNTER_DATA_TYPE_COUNT_FUNCTION,
 	COUNTER_DATA_TYPE_SIGNAL,
+	COUNTER_DATA_TYPE_COUNT_FUNCTION,
 	COUNTER_DATA_TYPE_SYNAPSE_ACTION,
 	COUNTER_DATA_TYPE_ENUM,
 	COUNTER_DATA_TYPE_COUNT_DIRECTION,
@@ -166,6 +168,9 @@ struct counter_attribute_group {
  * @priv:		optional private data supplied by driver
  * @id:			unique ID used to identify the Counter
  * @dev:		internal device structure
+ * @chrdev:		internal character device structure
+ * @control_list:	Counter character device selected controls
+ * @control_lock:	Mutex for Counter character device selected controls
  * @dynamic_names_list:	List for dynamic names
  * @groups_list:	attribute groups list (for Signals, Counts, and ext)
  * @num_groups:		number of attribute groups containers
@@ -204,6 +209,11 @@ struct counter_device {
 
 	int id;
 	struct device dev;
+	struct cdev chrdev;
+
+	struct list_head control_list;
+	struct mutex control_lock;
+
 	struct list_head dynamic_names_list;
 	struct counter_attribute_group *groups_list;
 	size_t num_groups;
-- 
2.26.2

