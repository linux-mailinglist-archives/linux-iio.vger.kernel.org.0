Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9751BE5F2
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 20:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgD2SMK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727122AbgD2SMC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 14:12:02 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70777C035494;
        Wed, 29 Apr 2020 11:12:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b188so2974572qkd.9;
        Wed, 29 Apr 2020 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMWCXFqPNvhEPK2mqnfUXlPJrRHb10i4WAvB8Ay5seM=;
        b=NiASIR5epbSYQoqxQVGjUsoqG8G0jHkYlF4feBMKDVP4OpQ11Yhl+1kcNG+CXJxfeT
         5UmIU8IU50X8/ZyRtInxqtkzKzjNkdiHNHLkogEg+MpdpTBevW35ke7NoF7og5aRkX9a
         NPv9M85GFMpFyAqccR5TG8kyjkMsTPOqIo0qDP83UwFq1ox+dhoDnOPXWK1M/jf/R2OG
         4VeuHXAHGMIC3bQnHeOaQnZLvIfJpdFVnCcl/2ao5+zrOL92CZ0f/cstLZRKcA895lXj
         in5g8/0f0nvk9z9gFKqE8qo7yHDc+Bjsm0id+n0SE6pGwkGF7fgPdvPERPkDzTukRZWc
         hoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMWCXFqPNvhEPK2mqnfUXlPJrRHb10i4WAvB8Ay5seM=;
        b=g7yF6o6yW1Vm7Hmde1sl4D/yhM5yHAXU65uEHM3XTVF2qOSqg1j7AJ98u0PC8kB0mf
         CHyfS5ZSMwD/YUGNkNsaz1Nh0e7UwRP1fKCTnV9fpQpmQvtodbmR89+ZA487g0adKEAr
         uLx4YDgFmLYUh3jPl2qpOs59qiNjjb5mErsujJ5CUbCTmiNdxjxeULNu+4MWdl4kXKbl
         eNVl9HW2Vo2LkHYTNOecLLShfTTo4cDDJ6gmgI0T1PXqg63h0UgXs+/CSQsG7PgoIS+h
         ZDhX2EiRI5b4D8u7l49/xWIKp3ZcER3uXLwKMMVfXW61thMxlJuu6QW/fCFccixVyddb
         d+Qw==
X-Gm-Message-State: AGi0PubMp5YibEFaAh06rnw0FAc4qS1FTnoP/ZQ5j2xSPnw096OSGpUn
        svFIZGoAenDPTAExLcKbOiA=
X-Google-Smtp-Source: APiQypLUl+TCQbvawr5tyR/PVvF6bhqqY2tXYk0WasrdUDL3ChfUik6elCIEyq9X0z+rim1O0bGoaA==
X-Received: by 2002:a05:620a:81b:: with SMTP id s27mr34579533qks.351.1588183920994;
        Wed, 29 Apr 2020 11:12:00 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id o43sm16315082qtf.46.2020.04.29.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:12:00 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        felipe.balbi@linux.intel.com, fabien.lahoudere@collabora.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 3/4] counter: Add character device interface
Date:   Wed, 29 Apr 2020 14:11:37 -0400
Message-Id: <531bf7d00146c6f0cca3ce9a1492cb76ec3bc8f5.1588176662.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588176662.git.vilhelm.gray@gmail.com>
References: <cover.1588176662.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch introduces a character device interface for the Counter
subsystem. Device information and control is exposed through a standard
set of ioctl commands.

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
                | Type: unsigned long        |  -------------------
                | Value: 42                  |          |
                +----------------------------+          |
                        |                               |
                 ----------------                       |
                / unsigned long /                       |
                ----------------                        |
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
        | Type: const char * |     | Type: unsigned long |
        | Value: "42"        |     | Value: 42           |
        +--------------------+     +---------------------+
                |                               |
         ---------------                 ----------------
        / const char * /                / unsigned long /
        ---------------                 ----------------
                |                               |
                |                               V
                |                       +-----------+
                |                       | ioctl     |
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
 MAINTAINERS                      |    1 +
 drivers/counter/Makefile         |    3 +-
 drivers/counter/counter-chrdev.c | 1134 ++++++++++++++++++++++++++++++
 drivers/counter/counter-chrdev.h |   16 +
 drivers/counter/counter-core.c   |   34 +-
 include/linux/counter.h          |    2 +
 include/uapi/linux/counter.h     |  313 +++++++++
 7 files changed, 1500 insertions(+), 3 deletions(-)
 create mode 100644 drivers/counter/counter-chrdev.c
 create mode 100644 drivers/counter/counter-chrdev.h
 create mode 100644 include/uapi/linux/counter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 89def3fe1c76..b8c7677e6564 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4367,6 +4367,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
+F:	include/uapi/linux/counter.h
 F:	include/uapi/linux/counter-types.h
 
 CPMAC ETHERNET DRIVER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 2d2644bd7777..86a93100e3f6 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -4,7 +4,8 @@
 #
 
 obj-$(CONFIG_COUNTER) += counter.o
-counter-y := counter-core.o counter-sysfs.o counter-sysfs-callbacks.o
+counter-y := counter-core.o counter-sysfs.o counter-sysfs-callbacks.o \
+             counter-chrdev.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
new file mode 100644
index 000000000000..00b1d9f62527
--- /dev/null
+++ b/drivers/counter/counter-chrdev.c
@@ -0,0 +1,1134 @@
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
+#include <linux/fs.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/counter.h>
+
+#include "counter-function-types.h"
+
+static long counter_device_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_device_info info;
+	void __user *const uinfo = (void __user *)arg;
+
+	snprintf(info.name, sizeof(info.name), "%s", counter->name);
+	info.num_signals = counter->num_signals;
+	info.num_counts = counter->num_counts;
+	info.num_ext = counter->num_ext;
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_signal_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_signal_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_signal *signal;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	if (info.index >= counter->num_signals)
+		return -EINVAL;
+
+	signal = counter->signals + info.index;
+
+	info.id = signal->id;
+	snprintf(info.name, sizeof(info.name), "%s", signal->name);
+	info.num_ext = signal->num_ext;
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_synapse_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_synapse_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_synapse *synapse;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	if (info.count_index >= counter->num_counts)
+		return -EINVAL;
+
+	if (info.index >= counter->counts[info.count_index].num_synapses)
+		return -EINVAL;
+
+	synapse = counter->counts[info.count_index].synapses + info.index;
+
+	info.num_actions = synapse->num_actions;
+	info.signal_index = synapse->signal - counter->signals;
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_count_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_count_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_count *count;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	if (info.index >= counter->num_counts)
+		return -EINVAL;
+
+	count = counter->counts + info.index;
+
+	info.id = count->id;
+	snprintf(info.name, sizeof(info.name), "%s", count->name);
+	info.num_functions = count->num_functions;
+	info.num_synapses = count->num_synapses;
+	info.num_ext = count->num_ext;
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static const struct counter_data *counter_get_ext(
+	const enum counter_owner_type type, const size_t owner_index,
+	const size_t index, const struct counter_device *const counter)
+{
+	const struct counter_data *ext;
+
+	switch (type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		if (index >= counter->num_ext)
+			return ERR_PTR(-EINVAL);
+
+		ext = counter->ext + index;
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		if (owner_index >= counter->num_signals)
+			return ERR_PTR(-EINVAL);
+
+		if (index >= counter->signals[owner_index].num_ext)
+			return ERR_PTR(-EINVAL);
+
+		ext = counter->signals[owner_index].ext + index;
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		if (owner_index >= counter->num_counts)
+			return ERR_PTR(-EINVAL);
+
+		if (index >= counter->counts[owner_index].num_ext)
+			return ERR_PTR(-EINVAL);
+
+		ext = counter->counts[owner_index].ext + index;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return ext;
+}
+
+static long counter_ext_info_ioctl(const unsigned long arg,
+				   const struct counter_device *const counter)
+{
+	struct counter_ext_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_data *ext;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	ext = counter_get_ext(info.owner_type, info.owner_index, info.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	info.type = ext->type;
+	snprintf(info.name, sizeof(info.name), "%s", ext->name);
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_signal_get_ioctl(const unsigned long arg,
+				     struct counter_device *const counter)
+{
+	const counter_signal_signal_read signal_read = counter->signal_read;
+	struct counter_signal_request req;
+	void __user *const ureq = (void __user *)arg;
+	int err;
+
+	if (!signal_read)
+		return -EINVAL;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	if (req.index >= counter->num_signals)
+		return -EINVAL;
+
+	err = signal_read(counter, counter->signals + req.index, &req.value);
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_count_get_ioctl(const unsigned long arg,
+				    struct counter_device *const counter)
+{
+	const counter_count_lu_read count_read = counter->count_read;
+	struct counter_count_request req;
+	void __user *const ureq = (void __user *)arg;
+	int err;
+
+	if (!count_read)
+		return -EINVAL;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	if (req.index >= counter->num_counts)
+		return -EINVAL;
+
+	err = count_read(counter, counter->counts + req.index, &req.value);
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_count_set_ioctl(const unsigned long arg,
+				    struct counter_device *const counter)
+{
+	const counter_count_lu_write count_write = counter->count_write;
+	struct counter_count_request req;
+	void __user *const ureq = (void __user *)arg;
+	int err;
+
+	if (!count_write)
+		return -EINVAL;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	if (req.index >= counter->num_counts)
+		return -EINVAL;
+
+	err = count_write(counter, counter->counts + req.index, req.value);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static long counter_count_function_get_ioctl(const unsigned long arg,
+	struct counter_device *const counter)
+{
+	const counter_count_function_read func_read = counter->function_read;
+	struct counter_count_function_request req;
+	void __user *const ureq = (void __user *)arg;
+	int err;
+
+	if (!func_read)
+		return -EINVAL;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	if (req.index >= counter->num_counts)
+		return -EINVAL;
+
+	err = func_read(counter, counter->counts + req.index, &req.function);
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_count_function_set_ioctl(const unsigned long arg,
+	struct counter_device *const counter)
+{
+	const counter_count_function_write func_write = counter->function_write;
+	struct counter_count_function_request req;
+	void __user *const ureq = (void __user *)arg;
+	struct counter_count *count;
+	size_t i;
+	int err;
+
+	if (!func_write)
+		return -EINVAL;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	if (req.index >= counter->num_counts)
+		return -EINVAL;
+
+	count = counter->counts + req.index;
+
+	/* Find requested function mode */
+	for (i = 0; i < count->num_functions; i++)
+		if (req.function == count->functions_list[i])
+			break;
+
+	/* If requested function mode is not found */
+	if (i >= count->num_functions)
+		return -EINVAL;
+
+	err = func_write(counter, count, req.function);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static long counter_synapse_action_get_ioctl(const unsigned long arg,
+	struct counter_device *const counter)
+{
+	const counter_synapse_action_read action_read = counter->action_read;
+	struct counter_synapse_action_request req;
+	void __user *const ureq = (void __user *)arg;
+	struct counter_count *count;
+	struct counter_synapse *synapse;
+	int err;
+
+	if (!action_read)
+		return -EINVAL;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	if (req.count_index >= counter->num_counts)
+		return -EINVAL;
+
+	count = counter->counts + req.count_index;
+
+	if (req.index >= count->num_synapses)
+		return -EINVAL;
+
+	synapse = count->synapses + req.index;
+
+	err = action_read(counter, count, synapse, &req.action);
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_synapse_action_set_ioctl(const unsigned long arg,
+	struct counter_device *const counter)
+{
+	const counter_synapse_action_write action_write = counter->action_write;
+	struct counter_synapse_action_request req;
+	void __user *const ureq = (void __user *)arg;
+	struct counter_count *count;
+	struct counter_synapse *synapse;
+	size_t i;
+	int err;
+
+	if (!action_write)
+		return -EINVAL;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	if (req.count_index >= counter->num_counts)
+		return -EINVAL;
+
+	count = counter->counts + req.count_index;
+
+	if (req.index >= count->num_synapses)
+		return -EINVAL;
+
+	synapse = count->synapses + req.index;
+
+	/* Find requested action mode */
+	for (i = 0; i < synapse->num_actions; i++)
+		if (req.action == synapse->actions_list[i])
+			break;
+
+	/* If requested action mode is not found */
+	if (i >= synapse->num_actions)
+		return -EINVAL;
+
+	err = action_write(counter, count, synapse, req.action);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static long counter_count_function_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_count_function_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_count *count;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	if (info.count_index >= counter->num_counts)
+		return -EINVAL;
+
+	count = counter->counts + info.count_index;
+
+	if (info.index >= count->num_functions)
+		return -EINVAL;
+
+	info.function = count->functions_list[info.index];
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_synapse_action_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_synapse_action_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_count *count;
+	const struct counter_synapse *synapse;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	if (info.count_index >= counter->num_counts)
+		return -EINVAL;
+
+	count = counter->counts + info.count_index;
+
+	if (info.synapse_index >= count->num_synapses)
+		return -EINVAL;
+
+	synapse = count->synapses + info.synapse_index;
+
+	if (info.index >= synapse->num_actions)
+		return -EINVAL;
+
+	info.action = synapse->actions_list[info.index];
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_ext_bool_get_ioctl(const unsigned long arg,
+				       struct counter_device *const counter)
+{
+	counter_device_bool_read device_bool_read;
+	counter_signal_bool_read signal_bool_read;
+	counter_count_bool_read count_bool_read;
+	struct counter_ext_bool_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	int err = 0;
+	struct counter_count *count;
+	struct counter_signal *signal;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->read)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_bool_read = ext->read;
+		err = device_bool_read(counter, &req.data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_bool_read = ext->read;
+		signal = counter->signals + req.owner_index;
+		err = signal_bool_read(counter, signal, &req.data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_bool_read = ext->read;
+		count = counter->counts + req.owner_index;
+		err = count_bool_read(counter, count, &req.data);
+		break;
+	}
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_ext_bool_set_ioctl(const unsigned long arg,
+				       struct counter_device *const counter)
+{
+	counter_device_bool_write device_bool_write;
+	counter_signal_bool_write signal_bool_write;
+	counter_count_bool_write count_bool_write;
+	struct counter_ext_bool_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	int retval = 0;
+	struct counter_count *count;
+	struct counter_signal *signal;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->write)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_bool_write = ext->write;
+		retval = device_bool_write(counter, req.data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_bool_write = ext->write;
+		signal = counter->signals + req.owner_index;
+		retval = signal_bool_write(counter, signal, req.data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_bool_write = ext->write;
+		count = counter->counts + req.owner_index;
+		retval = count_bool_write(counter, count, req.data);
+		break;
+	}
+
+	return retval;
+}
+
+static long counter_ext_lu_get_ioctl(const unsigned long arg,
+				     struct counter_device *const counter)
+{
+	counter_device_lu_read device_lu_read;
+	counter_signal_lu_read signal_lu_read;
+	counter_count_lu_read count_lu_read;
+	struct counter_ext_lu_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	int err = 0;
+	struct counter_count *count;
+	struct counter_signal *signal;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->read)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_lu_read = ext->read;
+		err = device_lu_read(counter, &req.data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_lu_read = ext->read;
+		signal = counter->signals + req.owner_index;
+		err = signal_lu_read(counter, signal, &req.data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_lu_read = ext->read;
+		count = counter->counts + req.owner_index;
+		err = count_lu_read(counter, count, &req.data);
+		break;
+	}
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_ext_lu_set_ioctl(const unsigned long arg,
+				     struct counter_device *const counter)
+{
+	counter_device_lu_write device_lu_write;
+	counter_signal_lu_write signal_lu_write;
+	counter_count_lu_write count_lu_write;
+	struct counter_ext_lu_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	int retval = 0;
+	struct counter_count *count;
+	struct counter_signal *signal;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->write)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_lu_write = ext->write;
+		retval = device_lu_write(counter, req.data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_lu_write = ext->write;
+		signal = counter->signals + req.owner_index;
+		retval = signal_lu_write(counter, signal, req.data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_lu_write = ext->write;
+		count = counter->counts + req.owner_index;
+		retval = count_lu_write(counter, count, req.data);
+		break;
+	}
+
+	return retval;
+}
+
+static long counter_ext_string_get_ioctl(const unsigned long arg,
+					 struct counter_device *const counter)
+{
+	counter_device_s_read device_s_read;
+	counter_signal_s_read signal_s_read;
+	counter_count_s_read count_s_read;
+	struct counter_ext_string_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	ssize_t len = 0;
+	struct counter_count *count;
+	struct counter_signal *signal;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->read)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_s_read = ext->read;
+		len = device_s_read(counter, req.data, sizeof(req.data));
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_s_read = ext->read;
+		signal = counter->signals + req.owner_index;
+		len = signal_s_read(counter, signal, req.data,
+				    sizeof(req.data));
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_s_read = ext->read;
+		count = counter->counts + req.owner_index;
+		len = count_s_read(counter, count, req.data, sizeof(req.data));
+		break;
+	}
+	if (len < 0)
+		return len;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_ext_string_set_ioctl(const unsigned long arg,
+					 struct counter_device *const counter)
+{
+	counter_device_s_write device_s_write;
+	counter_signal_s_write signal_s_write;
+	counter_count_s_write count_s_write;
+	struct counter_ext_string_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	ssize_t len = 0;
+	struct counter_count *count;
+	struct counter_signal *signal;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->write)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_s_write = ext->write;
+		len = device_s_write(counter, req.data, sizeof(req.data));
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_s_write = ext->write;
+		signal = counter->signals + req.owner_index;
+		len = signal_s_write(counter, signal, req.data,
+				     sizeof(req.data));
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_s_write = ext->write;
+		count = counter->counts + req.owner_index;
+		len = count_s_write(counter, count, req.data, sizeof(req.data));
+		break;
+	}
+	if (len < 0)
+		return len;
+
+	return 0;
+}
+
+static long counter_ext_enum_get_ioctl(const unsigned long arg,
+				       struct counter_device *const counter)
+{
+	counter_device_zu_read device_enum_read;
+	counter_signal_zu_read signal_enum_read;
+	counter_count_zu_read count_enum_read;
+	struct counter_ext_enum_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	int err = 0;
+	size_t enum_index;
+	struct counter_count *count;
+	struct counter_signal *signal;
+	const struct counter_enum *cntr_enum;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->read)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_enum_read = ext->read;
+		err = device_enum_read(counter, &enum_index);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_enum_read = ext->read;
+		signal = counter->signals + req.owner_index;
+		err = signal_enum_read(counter, signal, &enum_index);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_enum_read = ext->read;
+		count = counter->counts + req.owner_index;
+		err = count_enum_read(counter, count, &enum_index);
+		break;
+	}
+	if (err)
+		return err;
+
+	cntr_enum = ext->priv;
+
+	if (enum_index >= cntr_enum->num_items)
+		return -EINVAL;
+
+	req.enum_index = enum_index;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_ext_enum_set_ioctl(const unsigned long arg,
+				       struct counter_device *const counter)
+{
+	counter_device_zu_write device_enum_write;
+	counter_signal_zu_write signal_enum_write;
+	counter_count_zu_write count_enum_write;
+	struct counter_ext_enum_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	int retval = 0;
+	struct counter_count *count;
+	struct counter_signal *signal;
+	const struct counter_enum *cntr_enum;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(req.owner_type, req.owner_index, req.index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->write)
+		return -EINVAL;
+
+	cntr_enum = ext->priv;
+	if (req.enum_index >= cntr_enum->num_items)
+		return -EINVAL;
+
+	switch (req.owner_type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		device_enum_write = ext->write;
+		retval = device_enum_write(counter, req.enum_index);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		signal_enum_write = ext->write;
+		signal = counter->signals + req.owner_index;
+		retval = signal_enum_write(counter, signal, req.enum_index);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		count_enum_write = ext->write;
+		count = counter->counts + req.owner_index;
+		retval = count_enum_write(counter, count, req.enum_index);
+		break;
+	}
+
+	return retval;
+}
+
+static long counter_ext_enum_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_ext_enum_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_data *ext;
+	const struct counter_enum *cntr_enum;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	ext = counter_get_ext(info.owner_type, info.owner_index, info.ext_index,
+			      counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	cntr_enum = ext->priv;
+
+	if (info.index >= cntr_enum->num_items)
+		return -EINVAL;
+
+	snprintf(info.value, sizeof(info.value), "%s",
+		 cntr_enum->items[info.index]);
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_count_direction_get_ioctl(const unsigned long arg,
+	struct counter_device *const counter)
+{
+	counter_count_direction_read count_direction_read;
+	struct counter_count_direction_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	struct counter_count *count;
+	int err;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(COUNTER_OWNER_TYPE_COUNT, req.count_index,
+			      req.index, counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->read)
+		return -EINVAL;
+
+	count_direction_read = ext->read;
+	count = counter->counts + req.count_index;
+	err = count_direction_read(counter, count, &req.direction);
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_count_mode_get_ioctl(const unsigned long arg,
+					 struct counter_device *const counter)
+{
+	counter_count_mode_read count_mode_read;
+	struct counter_count_mode_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	struct counter_count *count;
+	int err;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(COUNTER_OWNER_TYPE_COUNT, req.count_index,
+			      req.index, counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->read)
+		return -EINVAL;
+
+	count_mode_read = ext->read;
+	count = counter->counts + req.count_index;
+	err = count_mode_read(counter, count, &req.count_mode);
+	if (err)
+		return err;
+
+	if (copy_to_user(ureq, &req, sizeof(req)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_count_mode_set_ioctl(const unsigned long arg,
+					 struct counter_device *const counter)
+{
+	counter_count_mode_write count_mode_write;
+	struct counter_count_mode_request req;
+	void __user *const ureq = (void __user *)arg;
+	const struct counter_data *ext;
+	const struct counter_available *available;
+	const enum counter_count_mode *count_modes;
+	size_t i;
+	struct counter_count *count;
+	int err;
+
+	if (copy_from_user(&req, ureq, sizeof(req)))
+		return -EFAULT;
+
+	ext = counter_get_ext(COUNTER_OWNER_TYPE_COUNT, req.count_index,
+			      req.index, counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	if (!ext->write)
+		return -EINVAL;
+
+	available = ext->priv;
+	count_modes = available->items;
+
+	/* Find requested count mode */
+	for (i = 0; i < available->num_items; i++) {
+		if (req.count_mode == count_modes[i])
+			break;
+	}
+	/* If requested count mode not found */
+	if (i >= available->num_items)
+		return -EINVAL;
+
+	count_mode_write = ext->write;
+	count = counter->counts + req.count_index;
+	err = count_mode_write(counter, count, req.count_mode);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static long counter_count_mode_info_ioctl(const unsigned long arg,
+	const struct counter_device *const counter)
+{
+	struct counter_count_mode_info info;
+	void __user *const uinfo = (void __user *)arg;
+	const struct counter_data *ext;
+	const struct counter_available *available;
+	const enum counter_count_mode *count_modes;
+
+	if (copy_from_user(&info, uinfo, sizeof(info)))
+		return -EFAULT;
+
+	ext = counter_get_ext(COUNTER_OWNER_TYPE_COUNT, info.count_index,
+			      info.ext_index, counter);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	available = ext->priv;
+
+	if (info.index >= available->num_items)
+		return -EINVAL;
+
+	count_modes = available->items;
+	info.count_mode = count_modes[info.index];
+
+	if (copy_to_user(uinfo, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long counter_chrdev_ioctl(struct file *filp, unsigned int cmd,
+				 unsigned long arg)
+{
+	struct counter_device *const counter = filp->private_data;
+
+	switch (cmd) {
+	case COUNTER_DEVICE_INFO_IOCTL:
+		return counter_device_info_ioctl(arg, counter);
+	case COUNTER_SIGNAL_INFO_IOCTL:
+		return counter_signal_info_ioctl(arg, counter);
+	case COUNTER_SYNAPSE_INFO_IOCTL:
+		return counter_synapse_info_ioctl(arg, counter);
+	case COUNTER_COUNT_INFO_IOCTL:
+		return counter_count_info_ioctl(arg, counter);
+	case COUNTER_EXT_INFO_IOCTL:
+		return counter_ext_info_ioctl(arg, counter);
+	case COUNTER_SIGNAL_GET_IOCTL:
+		return counter_signal_get_ioctl(arg, counter);
+	case COUNTER_COUNT_GET_IOCTL:
+		return counter_count_get_ioctl(arg, counter);
+	case COUNTER_COUNT_SET_IOCTL:
+		return counter_count_set_ioctl(arg, counter);
+	case COUNTER_COUNT_FUNCTION_GET_IOCTL:
+		return counter_count_function_get_ioctl(arg, counter);
+	case COUNTER_COUNT_FUNCTION_SET_IOCTL:
+		return counter_count_function_set_ioctl(arg, counter);
+	case COUNTER_SYNAPSE_ACTION_GET_IOCTL:
+		return counter_synapse_action_get_ioctl(arg, counter);
+	case COUNTER_SYNAPSE_ACTION_SET_IOCTL:
+		return counter_synapse_action_set_ioctl(arg, counter);
+	case COUNTER_COUNT_FUNCTION_INFO_IOCTL:
+		return counter_count_function_info_ioctl(arg, counter);
+	case COUNTER_SYNAPSE_ACTION_INFO_IOCTL:
+		return counter_synapse_action_info_ioctl(arg, counter);
+	case COUNTER_EXT_BOOL_GET_IOCTL:
+		return counter_ext_bool_get_ioctl(arg, counter);
+	case COUNTER_EXT_BOOL_SET_IOCTL:
+		return counter_ext_bool_set_ioctl(arg, counter);
+	case COUNTER_EXT_LU_GET_IOCTL:
+		return counter_ext_lu_get_ioctl(arg, counter);
+	case COUNTER_EXT_LU_SET_IOCTL:
+		return counter_ext_lu_set_ioctl(arg, counter);
+	case COUNTER_EXT_STRING_GET_IOCTL:
+		return counter_ext_string_get_ioctl(arg, counter);
+	case COUNTER_EXT_STRING_SET_IOCTL:
+		return counter_ext_string_set_ioctl(arg, counter);
+	case COUNTER_EXT_ENUM_GET_IOCTL:
+		return counter_ext_enum_get_ioctl(arg, counter);
+	case COUNTER_EXT_ENUM_SET_IOCTL:
+		return counter_ext_enum_set_ioctl(arg, counter);
+	case COUNTER_EXT_ENUM_INFO_IOCTL:
+		return counter_ext_enum_info_ioctl(arg, counter);
+	case COUNTER_COUNT_DIRECTION_GET_IOCTL:
+		return counter_count_direction_get_ioctl(arg, counter);
+	case COUNTER_COUNT_MODE_GET_IOCTL:
+		return counter_count_mode_get_ioctl(arg, counter);
+	case COUNTER_COUNT_MODE_SET_IOCTL:
+		return counter_count_mode_set_ioctl(arg, counter);
+	case COUNTER_COUNT_MODE_INFO_IOCTL:
+		return counter_count_mode_info_ioctl(arg, counter);
+	default:
+		break;
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+static int counter_chrdev_open(struct inode *inode, struct file *filp)
+{
+	struct counter_device *const counter = container_of(inode->i_cdev,
+							    struct counter_device,
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
+	struct counter_device *const counter = container_of(inode->i_cdev,
+							    struct counter_device,
+							    chrdev);
+
+	put_device(&counter->dev);
+
+	return 0;
+}
+
+static const struct file_operations counter_fops = {
+	.llseek = no_llseek,
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
index 008d51284a2c..a345d3273ccd 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -7,12 +7,15 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
 #include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/types.h>
 
+#include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
 /* Provides a unique ID for each counter device */
@@ -36,6 +39,8 @@ static struct bus_type counter_bus_type = {
 	.name = "counter"
 };
 
+static dev_t counter_devt;
+
 /**
  * counter_register - register Counter to the system
  * @counter:	pointer to Counter to register
@@ -65,10 +70,15 @@ int counter_register(struct counter_device *const counter)
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
@@ -79,6 +89,8 @@ int counter_register(struct counter_device *const counter)
 
 err_free_sysfs:
 	counter_sysfs_free(counter);
+err_free_chrdev:
+	counter_chrdev_free(counter);
 err_free_id:
 	ida_simple_remove(&counter_ida, counter->id);
 	return err;
@@ -96,6 +108,7 @@ void counter_unregister(struct counter_device *const counter)
 	if (counter) {
 		device_del(&counter->dev);
 		counter_sysfs_free(counter);
+		counter_chrdev_free(counter);
 	}
 }
 EXPORT_SYMBOL_GPL(counter_unregister);
@@ -172,13 +185,30 @@ void devm_counter_unregister(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_counter_unregister);
 
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
index d628c7eaf754..2ae361b4734c 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,6 +6,7 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -162,6 +163,7 @@ struct counter_device {
 
 	int id;
 	struct device dev;
+	struct cdev chrdev;
 	struct list_head synapse_names_list;
 	struct counter_attribute_group *groups_list;
 	size_t num_groups;
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
new file mode 100644
index 000000000000..7e4b1f158d57
--- /dev/null
+++ b/include/uapi/linux/counter.h
@@ -0,0 +1,313 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace ABI for Counter character devices
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _UAPI_COUNTER_H_
+#define _UAPI_COUNTER_H_
+
+#include <linux/counter-types.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct counter_device_info - Counter device information
+ * @name:		name of the device
+ * @num_signals:	number of Signals
+ * @num_counts:		number of Counts
+ * @num_ext:		number of Counter device extensions
+ */
+struct counter_device_info {
+	char name[32];
+	size_t num_signals;
+	size_t num_counts;
+	size_t num_ext;
+};
+
+/**
+ * struct counter_signal_info - Signal information
+ * @index:	index of the Signal
+ * @id:		unique ID used to identify the Signal
+ * @name:	device-specific Signal name
+ * @num_ext:	number of Signal extensions
+ */
+struct counter_signal_info {
+	size_t index;
+
+	int id;
+	char name[32];
+	size_t num_ext;
+};
+
+/**
+ * struct counter_synapse_info - Synapse information
+ * @count_index:	index of the Count
+ * @index:		index of the Synapse
+ * @num_actions:	number of action modes
+ * @signal_index:	index of the associated Signal
+ */
+struct counter_synapse_info {
+	size_t count_index;
+	size_t index;
+
+	size_t num_actions;
+	size_t signal_index;
+};
+
+/**
+ * struct counter_count_info - Count information
+ * @index:		index of the Count
+ * @id:			unique ID used to identify Count
+ * @name:		device-specific Count name
+ * @num_functions:	number of function modes
+ * @num_synapses:	number of synapses
+ * @num_ext:		number of Count extensions
+ */
+struct counter_count_info {
+	size_t index;
+
+	int id;
+	char name[32];
+	size_t num_functions;
+	size_t num_synapses;
+	size_t num_ext;
+};
+
+/**
+ * struct counter_ext_info - Counter extension information
+ * @owner_type:		component type of the owner
+ * @owner_index:	index of the owning Count or Signal
+ * @index:		index of the extension
+ * @type:		data type of the extension
+ * @name:		name of the extension
+ */
+struct counter_ext_info {
+	enum counter_owner_type owner_type;
+	size_t owner_index;
+	size_t index;
+
+	enum counter_data_type type;
+	char name[32];
+};
+
+/**
+ * struct counter_signal_request - Signal request
+ * @index:	index of the Signal
+ * @value:	Signal value
+ */
+struct counter_signal_request {
+	size_t index;
+
+	enum counter_signal_value value;
+};
+
+/**
+ * struct counter_count_request - Count request
+ * @index:	index of the Count
+ * @value:	Count value
+ */
+struct counter_count_request {
+	size_t index;
+
+	unsigned long value;
+};
+
+/**
+ * struct counter_count_function_request - Count function mode request
+ * @index:	index of the Count
+ * @function:	Count function mode
+ */
+struct counter_count_function_request {
+	size_t index;
+
+	enum counter_count_function function;
+};
+
+/**
+ * struct counter_synapse_action_request - Synapse action mode request
+ * @count_index:	index of the Count
+ * @index:		index of the Synapse
+ * @action:		Synapse action mode
+ */
+struct counter_synapse_action_request {
+	size_t count_index;
+	size_t index;
+
+	enum counter_synapse_action action;
+};
+
+/**
+ * struct counter_count_function_info - Count function mode information
+ * @count_index:	index of the Count
+ * @index:		index of the Count function mode
+ * @function:		Count function mode
+ */
+struct counter_count_function_info {
+	size_t count_index;
+	size_t index;
+
+	enum counter_count_function function;
+};
+
+/**
+ * struct counter_synapse_action_info - Synapse action mode information
+ * @count_index:	index of the Count
+ * @synapse_index:	index of the Synapse
+ * @index:		index of the Synapse action mode
+ * @action:		Synapse action mode
+ */
+struct counter_synapse_action_info {
+	size_t count_index;
+	size_t synapse_index;
+	size_t index;
+
+	enum counter_synapse_action action;
+};
+
+/**
+ * struct counter_ext_bool_request - Counter extension bool data request
+ * @owner_type:		component type of the owner
+ * @owner_index:	index of the owning Count or Signal
+ * @index:		index of the extension
+ * @data:		extension data
+ */
+struct counter_ext_bool_request {
+	enum counter_owner_type owner_type;
+	size_t owner_index;
+	size_t index;
+
+	bool data;
+};
+
+/**
+ * struct counter_ext_lu_request - Counter extension unsigned long data request
+ * @owner_type:		component type of the owner
+ * @owner_index:	index of the owning Count or Signal
+ * @index:		index of the extension
+ * @data:		extension data
+ */
+struct counter_ext_lu_request {
+	enum counter_owner_type owner_type;
+	size_t owner_index;
+	size_t index;
+
+	unsigned long data;
+};
+
+/**
+ * struct counter_ext_string_request - Counter extension string data request
+ * @owner_type:		component type of the owner
+ * @owner_index:	index of the owning Count or Signal
+ * @index:		index of the extension
+ * @data:		extension data
+ */
+struct counter_ext_string_request {
+	enum counter_owner_type owner_type;
+	size_t owner_index;
+	size_t index;
+
+	char data[32];
+};
+
+/**
+ * struct counter_ext_enum_request - Counter extension enum request
+ * @owner_type:		component type of the owner
+ * @owner_index:	index of the owning Count or Signal
+ * @index:		index of the extension
+ * @enum_index:		index of the extension enum
+ */
+struct counter_ext_enum_request {
+	enum counter_owner_type owner_type;
+	size_t owner_index;
+	size_t index;
+
+	size_t enum_index;
+};
+
+/**
+ * struct counter_ext_enum_info - Counter extension enum information
+ * @owner_type:		component type of the owner
+ * @owner_index:	index of the owning Count or Signal
+ * @ext_index:		index of the extension
+ * @index:		index of the extension enum
+ * @data:		extension enum value
+ */
+struct counter_ext_enum_info {
+	enum counter_owner_type owner_type;
+	size_t owner_index;
+	size_t ext_index;
+	size_t index;
+
+	char value[32];
+};
+
+/**
+ * struct counter_count_direction_request - Counter count direction request
+ * @count_index:	index of the Count
+ * @index:		index of the extension
+ * @direction:		Count direction
+ */
+struct counter_count_direction_request {
+	size_t count_index;
+	size_t index;
+
+	enum counter_count_direction direction;
+};
+
+/**
+ * struct counter_count_mode_request - Counter count mode request
+ * @count_index:	index of the Count
+ * @index:		index of the extension
+ * @count_mode:		count mode
+ */
+struct counter_count_mode_request {
+	size_t count_index;
+	size_t index;
+
+	enum counter_count_mode count_mode;
+};
+
+/**
+ * struct counter_count_mode_info - Counter count mode information
+ * @count_index:	index of the Count
+ * @ext_index:		index of the extension
+ * @index:		index of the count mode
+ * @count_mode:		count mode
+ */
+struct counter_count_mode_info {
+	size_t count_index;
+	size_t ext_index;
+	size_t index;
+
+	enum counter_count_mode count_mode;
+};
+
+#define COUNTER_DEVICE_INFO_IOCTL _IOR(0x3E, 0x00, struct counter_device_info)
+#define COUNTER_SIGNAL_INFO_IOCTL _IOWR(0x3E, 0x01, struct counter_signal_info)
+#define COUNTER_SYNAPSE_INFO_IOCTL _IOWR(0x3E, 0x02, struct counter_synapse_info)
+#define COUNTER_COUNT_INFO_IOCTL _IOWR(0x3E, 0x03, struct counter_count_info)
+#define COUNTER_EXT_INFO_IOCTL _IOWR(0x3E, 0x04, struct counter_ext_info)
+#define COUNTER_SIGNAL_GET_IOCTL _IOWR(0x3E, 0x05, struct counter_signal_request)
+#define COUNTER_COUNT_GET_IOCTL _IOWR(0x3E, 0x06, struct counter_count_request)
+#define COUNTER_COUNT_SET_IOCTL _IOW(0x3E, 0x07, struct counter_count_request)
+#define COUNTER_COUNT_FUNCTION_GET_IOCTL _IOWR(0x3E, 0x08, struct counter_count_function_request)
+#define COUNTER_COUNT_FUNCTION_SET_IOCTL _IOW(0x3E, 0x09, struct counter_count_function_request)
+#define COUNTER_SYNAPSE_ACTION_GET_IOCTL _IOWR(0x3E, 0x0A, struct counter_synapse_action_request)
+#define COUNTER_SYNAPSE_ACTION_SET_IOCTL _IOW(0x3E, 0x0B, struct counter_synapse_action_request)
+#define COUNTER_COUNT_FUNCTION_INFO_IOCTL _IOWR(0x3E, 0x0C, struct counter_count_function_info)
+#define COUNTER_SYNAPSE_ACTION_INFO_IOCTL _IOWR(0x3E, 0x0D, struct counter_synapse_action_info)
+#define COUNTER_EXT_BOOL_GET_IOCTL _IOWR(0x3E, 0x0E, struct counter_ext_bool_request)
+#define COUNTER_EXT_BOOL_SET_IOCTL _IOW(0x3E, 0x0F, struct counter_ext_bool_request)
+#define COUNTER_EXT_LU_GET_IOCTL _IOWR(0x3E, 0x10, struct counter_ext_lu_request)
+#define COUNTER_EXT_LU_SET_IOCTL _IOW(0x3E, 0x11, struct counter_ext_lu_request)
+#define COUNTER_EXT_STRING_GET_IOCTL _IOWR(0x3E, 0x12, struct counter_ext_string_request)
+#define COUNTER_EXT_STRING_SET_IOCTL _IOW(0x3E, 0x13, struct counter_ext_string_request)
+#define COUNTER_EXT_ENUM_GET_IOCTL _IOWR(0x3E, 0x14, struct counter_ext_enum_request)
+#define COUNTER_EXT_ENUM_SET_IOCTL _IOW(0x3E, 0x15, struct counter_ext_enum_request)
+#define COUNTER_EXT_ENUM_INFO_IOCTL _IOWR(0x3E, 0x16, struct counter_ext_enum_info)
+#define COUNTER_COUNT_DIRECTION_GET_IOCTL _IOWR(0x3E, 0x17, struct counter_count_direction_request)
+#define COUNTER_COUNT_MODE_GET_IOCTL _IOWR(0x3E, 0x18, struct counter_count_mode_request)
+#define COUNTER_COUNT_MODE_SET_IOCTL _IOW(0x3E, 0x19, struct counter_count_mode_request)
+#define COUNTER_COUNT_MODE_INFO_IOCTL _IOWR(0x3E, 0x1A, struct counter_count_mode_info)
+
+#endif /* _UAPI_COUNTER_H_ */
-- 
2.26.2

