Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3CF1D63CD
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 21:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgEPTUo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 15:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgEPTUn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2020 15:20:43 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853BCC061A0C;
        Sat, 16 May 2020 12:20:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m44so4871725qtm.8;
        Sat, 16 May 2020 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11TPcs5o0DO7/jT3uUgXzZhv+LOOFIJIm6J1xwX89NM=;
        b=S45Y1WF14Mvl5uW6XjfDplmNiux5S/jxzW//xybxqmckyOsjKAtcZczMkNoY+d7Zej
         Ns5S8awJwWiZUJMZNFkp5xCa+MVJ1mWsUH88QmzQOJkPW5hE+eehs9CcCQ/dsiXsn5AO
         v7CUz8i1f7mta7KvBL1N3k9kfHX1wXCYc/MheS8KZFhEcOHTnT3cvZ3LAQme90+vcYz4
         64ESiKiFuhCZQXGPIP06dBmPTrVyyaS5d31fjDM2c8RwI1b3wcwVqO3dZlq8/lbm03RB
         Mhnyub0GdbGadltkcdJan/dIg8+wR3VQ80B3vXBv5vqy4Gl0Mt78n07ZfMAGIkCTliA1
         aJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11TPcs5o0DO7/jT3uUgXzZhv+LOOFIJIm6J1xwX89NM=;
        b=t6FqDRcU+YM+Yq983M1DExbySh1IrsotsKleBIkjkwXeLEIRhnmqCOY/cKpTNUryAG
         LlYM9K0s+7dQifexfryzF1VKQlf3iyNt35vPafcpqLYa/gNQoKNoguW5gRbgZBWwLfVm
         sIrMghgmxUGIR1gE5T0GDQ6Eop/ZVx9TcFGm4RuqkKuNb6Jwg7VmjSNTVU/kH9GNPneu
         WTFuCjGjfHX5JeGZJgYAJ/bCTlxAzpwedvaGeoMtnsURu86uR9fsHzJbcG7YczHEwZMi
         2fdRqMWQJLd7ZC/lbhJ3INHzonLyRdD/jI9K3TPeQ6s5P7oG1YBVIpRgJarRn/YP6+6r
         2Ilw==
X-Gm-Message-State: AOAM530kBy6NWMRayrtUXc3P7v5oj0JAkqVUvLx08TFVmxVji2cX+IeG
        OiIGrZkf0XG4jAW580i30rY=
X-Google-Smtp-Source: ABdhPJwpDI9/8ACtrx1TEoFzVI/Dmdz21QGi4a9z2DiEdgyWMASwgBXIotutoeeH8htj2pTOfQLlCg==
X-Received: by 2002:ac8:6e82:: with SMTP id c2mr9613014qtv.155.1589656842558;
        Sat, 16 May 2020 12:20:42 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id g19sm3160409qke.32.2020.05.16.12.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 12:20:41 -0700 (PDT)
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
Subject: [PATCH v2 3/4] counter: Add character device interface
Date:   Sat, 16 May 2020 15:20:01 -0400
Message-Id: <a722cbc1e59441cd477bf42fd0313eb7abd76e38.1589654470.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1589654470.git.vilhelm.gray@gmail.com>
References: <cover.1589654470.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces a character device interface for the Counter
subsystem. Device control is exposed through standard character device
read and write operations.

The first 196095 bytes of the character device serve as a control
selection area where control exposure of desired Counter components and
extensions may be selected. Each byte serves as a boolean selection
indicator for a respective Counter component or extension. The format of
this area is as follows:

* For each device extension, a byte is required.
* For each Signal, a byte is reserved for the Signal component, and a
  byte is reserved for each Signal extension.
* For each Count, a byte is reserved for the Count component, a byte is
  reserved for the count function, a byte is reserved for each Synapse
  action, and byte is reserved for each Count extension.

The selected Counter components and extensions may then be interfaced
after the first 196095 bytes via standard character device read/write
operations. The number of bytes available for each component or
extension is dependent on their respective data type: u8 will have 1
byte available, u64 will have 8 bytes available, strings will have 64
bytes available, etc.

A high-level view of how a count value is passed down from a counter
driver can be exemplified by the following:

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
 drivers/counter/counter-chrdev.c | 656 +++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |  16 +
 drivers/counter/counter-core.c   |  34 +-
 include/linux/counter.h          |  16 +
 6 files changed, 722 insertions(+), 3 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ef72b5755793..150ad8a9bb87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4365,6 +4365,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
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
index 000000000000..7fd55bf71e47
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,656 @@
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
+#include <linux/fs.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+
+enum counter_owner_type {
+	COUNTER_OWNER_TYPE_DEVICE,
+	COUNTER_OWNER_TYPE_SIGNAL,
+	COUNTER_OWNER_TYPE_COUNT,
+};
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
+	default: return -EINVAL;
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
+	default: return -EINVAL;
+	}
+	if (err)
+		return err;
+
+	return copy_to_user(buf, (const char *)&val + offset, len);
+}
+
+static int counter_data_string_read(struct counter_device *const counter,
+				    const struct counter_control *const control,
+				    char __user *const buf, const size_t len,
+				    const size_t offset)
+{
+	const struct counter_data *const data = &control->data;
+	int err;
+	char str[64] = "";
+
+	switch (control->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = data->device_string_read(counter, str, sizeof(str));
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = data->signal_string_read(counter, control->owner, str,
+					       sizeof(str));
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		err = data->count_string_read(counter, control->owner, str,
+					      sizeof(str));
+		break;
+	default: return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	return copy_to_user(buf, str + offset, len);
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
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		return counter_data_u8_read(counter, control, buf);
+	case COUNTER_DATA_TYPE_U64:
+		return counter_data_u64_read(counter, control, buf, len,
+					     offset);
+	case COUNTER_DATA_TYPE_STRING:
+		return counter_data_string_read(counter, control, buf, len,
+						offset);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
+				   size_t len, loff_t *f_ps)
+{
+	const loff_t start_ps = *f_ps;
+	struct counter_device *const counter = filp->private_data;
+	size_t read_size;
+	struct counter_control *control;
+	int err;
+	loff_t next_control_ps;
+
+	/* Handle Counter control selection */
+	if (*f_ps < COUNTER_SELECTION_SIZE) {
+		read_size = (*f_ps + len > COUNTER_SELECTION_SIZE) ?
+			    COUNTER_SELECTION_SIZE - *f_ps : len;
+
+		if (copy_to_user(buf, counter->selection + *f_ps, read_size))
+			return -EFAULT;
+
+		*f_ps += read_size;
+		buf += read_size;
+		len -= read_size;
+		if (!len)
+			goto exit_chrdev_read;
+	}
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
+		if (err)
+			return err;
+
+		*f_ps += read_size;
+		buf += read_size;
+		len -= read_size;
+		if (!len)
+			goto exit_chrdev_read;
+	}
+
+exit_chrdev_read:
+	return *f_ps - start_ps;
+}
+
+static int counter_control_ext_add(const u8 *const selection,
+				   const enum counter_owner_type type,
+				   void *const owner, const size_t num_ext,
+				   const struct counter_data *const ext,
+				   struct list_head *const cntrl_list,
+				   loff_t *const offset)
+{
+	struct counter_control *p = list_last_entry(cntrl_list, typeof(*p), l);
+	struct counter_control *n;
+	size_t i;
+	struct counter_control *control;
+	int err;
+
+	for (i = 0; i < num_ext; i++) {
+		/* Check if extension is selected */
+		if (!selection[i])
+			continue;
+
+		/* Generate control list item */
+		control = kzalloc(sizeof(*control), GFP_KERNEL);
+		if (!control) {
+			err = -ENOMEM;
+			goto err_control_ext_create;
+		}
+		list_add_tail(&control->l, cntrl_list);
+
+		/* Configure control list item */
+		control->data = ext[i],
+		control->type = type;
+		control->owner = owner;
+		control->offset = *offset;
+		switch (control->data.type) {
+		case COUNTER_DATA_TYPE_U8:
+		case COUNTER_DATA_TYPE_BOOL:
+		case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+		case COUNTER_DATA_TYPE_COUNT_MODE:
+			control->size = sizeof(u8);
+			break;
+		case COUNTER_DATA_TYPE_U64:
+			control->size = sizeof(u64);
+			break;
+		case COUNTER_DATA_TYPE_STRING:
+			control->size = 64;
+			break;
+		default:
+			err = -EINVAL;
+			goto err_control_ext_create;
+		}
+		*offset += control->size;
+	}
+
+	return 0;
+
+err_control_ext_create:
+	list_for_each_entry_safe_continue(p, n, cntrl_list, l) {
+		list_del(&p->l);
+		kfree(p);
+	}
+	return err;
+}
+
+static void counter_control_list_free(struct list_head *const cntrl_list)
+{
+	struct counter_control *p, *n;
+
+	list_for_each_entry_safe(p, n, cntrl_list, l) {
+		list_del(&p->l);
+		kfree(p);
+	}
+}
+
+static int counter_control_list_create(struct counter_device *const counter)
+{
+	const u8 *selection = counter->selection;
+	loff_t offset = COUNTER_SELECTION_SIZE;
+	size_t i, j;
+	struct counter_signal *signal;
+	struct counter_count *count;
+	struct counter_control *control;
+	int err;
+
+	/* Clean up old list */
+	counter_control_list_free(&counter->control_list);
+
+	/* Handle device extensions */
+	err = counter_control_ext_add(selection, COUNTER_OWNER_TYPE_DEVICE,
+				      NULL, counter->num_ext, counter->ext,
+				      &counter->control_list, &offset);
+	if (err)
+		goto err_control_create;
+	selection += counter->num_ext;
+
+	/* Handle Signals */
+	for (i = 0; i < counter->num_signals; i++) {
+		signal = counter->signals + i;
+
+		/* Check if Signal is selected */
+		if (*selection++) {
+			/* Generate control list item */
+			control = kzalloc(sizeof(*control), GFP_KERNEL);
+			if (!control) {
+				err = -ENOMEM;
+				goto err_control_create;
+			}
+			list_add_tail(&control->l, &counter->control_list);
+
+			/* Configure control list item */
+			control->data.type = COUNTER_DATA_TYPE_SIGNAL,
+			control->data.signal_u8_read = counter->signal_read;
+			control->type = COUNTER_OWNER_TYPE_SIGNAL;
+			control->owner = signal;
+			control->offset = offset;
+			control->size = sizeof(u8);
+			offset += control->size;
+		}
+
+		/* Handle extensions */
+		err = counter_control_ext_add(selection,
+					      COUNTER_OWNER_TYPE_SIGNAL, signal,
+					      signal->num_ext, signal->ext,
+					      &counter->control_list, &offset);
+		if (err)
+			goto err_control_create;
+		selection += signal->num_ext;
+	}
+
+	/* Handle Counts */
+	for (i = 0; i < counter->num_counts; i++) {
+		count = counter->counts + i;
+
+		/* Check if Count is selected */
+		if (*selection++) {
+			/* Generate control list item */
+			control = kzalloc(sizeof(*control), GFP_KERNEL);
+			if (!control) {
+				err = -ENOMEM;
+				goto err_control_create;
+			}
+			list_add_tail(&control->l, &counter->control_list);
+
+			/* Configure control list item */
+			control->data.type = COUNTER_DATA_TYPE_U64,
+			control->data.count_u64_read = counter->count_read;
+			control->data.count_u64_write = counter->count_write;
+			control->type = COUNTER_OWNER_TYPE_COUNT;
+			control->owner = count;
+			control->offset = offset;
+			control->size = sizeof(u64);
+			offset += control->size;
+		}
+
+		/* Handle count function */
+		if (*selection++) {
+			/* Generate control list item */
+			control = kzalloc(sizeof(*control), GFP_KERNEL);
+			if (!control) {
+				err = -ENOMEM;
+				goto err_control_create;
+			}
+			list_add_tail(&control->l, &counter->control_list);
+
+			/* Configure control list item */
+			control->data.type = COUNTER_DATA_TYPE_COUNT_FUNCTION,
+			control->data.count_u8_read = counter->function_read;
+			control->data.count_u8_write = counter->function_write;
+			control->type = COUNTER_OWNER_TYPE_COUNT;
+			control->owner = count;
+			control->offset = offset;
+			control->size = sizeof(u8);
+			offset += control->size;
+		}
+
+		/* Handle Synapses */
+		for (j = 0; j < count->num_synapses; j++) {
+			/* Check if extension is selected */
+			if (!*selection++)
+				continue;
+
+			/* Generate control list item */
+			control = kzalloc(sizeof(*control), GFP_KERNEL);
+			if (!control) {
+				err = -ENOMEM;
+				goto err_control_create;
+			}
+			list_add_tail(&control->l, &counter->control_list);
+
+			/* Configure control list item */
+			control->data.type = COUNTER_DATA_TYPE_SYNAPSE_ACTION;
+			control->data.action_read = counter->action_read;
+			control->data.action_write = counter->action_write;
+			control->data.priv = count->synapses + j;
+			control->type = COUNTER_OWNER_TYPE_COUNT;
+			control->owner = count;
+			control->offset = offset;
+			control->size = sizeof(u8);
+			offset += control->size;
+		}
+
+		/* Handle extensions */
+		err = counter_control_ext_add(selection,
+					      COUNTER_OWNER_TYPE_COUNT, count,
+					      count->num_ext, count->ext,
+					      &counter->control_list, &offset);
+		if (err)
+			goto err_control_create;
+		selection += count->num_ext;
+	}
+
+	return 0;
+
+err_control_create:
+	counter_control_list_free(&counter->control_list);
+	return err;
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
+	default: return -EINVAL;
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
+	default: return -EINVAL;
+	}
+
+	return err;
+}
+
+static int counter_data_string_write(struct counter_device *const counter,
+				     const struct counter_control *const control,
+				     const char __user *const buf,
+				     const size_t len, const size_t offset)
+{
+	const struct counter_data *const data = &control->data;
+	int err;
+	char str[64] = "";
+
+	err = copy_from_user(str + offset, buf, len);
+	if (err)
+		return err;
+
+	switch (control->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = data->device_string_write(counter, str, sizeof(str));
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = data->signal_string_write(counter, control->owner, str,
+						sizeof(str));
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		err = data->count_string_write(counter, control->owner, str,
+					       sizeof(str));
+		break;
+	default: return -EINVAL;
+	}
+	if (err < 0)
+		return err;
+
+	return 0;
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
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		return counter_data_u8_write(counter, control, buf);
+	case COUNTER_DATA_TYPE_U64:
+		return counter_data_u64_write(counter, control, buf, len,
+					      offset);
+	case COUNTER_DATA_TYPE_STRING:
+		return counter_data_string_write(counter, control, buf, len,
+						 offset);
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t counter_chrdev_write(struct file *filp, const char __user *buf,
+				    size_t len, loff_t *f_ps)
+{
+	const loff_t start_ps = *f_ps;
+	struct counter_device *const counter = filp->private_data;
+	size_t write_size;
+	struct counter_control *control;
+	int err;
+	loff_t next_control_ps;
+
+	/* Handle Counter control selection */
+	if (*f_ps < COUNTER_SELECTION_SIZE) {
+		write_size = (*f_ps + len > COUNTER_SELECTION_SIZE) ?
+			    COUNTER_SELECTION_SIZE - *f_ps : len;
+		if (copy_from_user(counter->selection + *f_ps, buf, write_size))
+			return -EFAULT;
+
+		/* Create new list based on updated selection array */
+		err = counter_control_list_create(counter);
+		if (err)
+			return err;
+
+		*f_ps += write_size;
+		buf += write_size;
+		len -= write_size;
+		if (!len)
+			goto exit_chrdev_write;
+	}
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
+		if (err)
+			return err;
+
+		*f_ps += write_size;
+		buf += write_size;
+		len -= write_size;
+		if (!len)
+			goto exit_chrdev_write;
+	}
+
+	return -EFAULT;
+
+exit_chrdev_write:
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
+	/* Initialize Counter character device control selection */
+	memset(counter->selection, 0, sizeof(counter->selection));
+
+	/* Initialize Counter character device selected controls list */
+	INIT_LIST_HEAD(&counter->control_list);
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
+	counter_control_list_free(&counter->control_list);
+}
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
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index e8abbaf47a4b..22e91d00a880 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,6 +6,7 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -170,6 +171,9 @@ struct counter_attribute_group {
  * @priv:		optional private data supplied by driver
  * @id:			unique ID used to identify the Counter
  * @dev:		internal device structure
+ * @chrdev:		internal character device structure
+ * @selection:		Counter character device control selection
+ * @control_list:	Counter character device selected controls
  * @dynamic_names_list:	List for dynamic names
  * @groups_list:	attribute groups list (for Signals, Counts, and ext)
  * @num_groups:		number of attribute groups containers
@@ -208,6 +212,18 @@ struct counter_device {
 
 	int id;
 	struct device dev;
+	struct cdev chrdev;
+
+#define MAX_EXT 255
+#define MAX_SIGNALS 255
+#define MAX_SYNAPSES 255
+#define MAX_COUNTS 255
+#define SIGNALS_SELECTION_SIZE ((1 + MAX_EXT) * MAX_SIGNALS)
+#define COUNTS_SELECTION_SIZE ((1 + 1 + MAX_SYNAPSES + MAX_EXT) * MAX_COUNTS)
+#define COUNTER_SELECTION_SIZE (MAX_EXT + SIGNALS_SELECTION_SIZE + COUNTS_SELECTION_SIZE)
+	u8 selection[COUNTER_SELECTION_SIZE];
+	struct list_head control_list;
+
 	struct list_head dynamic_names_list;
 	struct counter_attribute_group *groups_list;
 	size_t num_groups;
-- 
2.26.2

