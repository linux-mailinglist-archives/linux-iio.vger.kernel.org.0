Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1F041BD42
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 05:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbhI2DS4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 23:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbhI2DSy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Sep 2021 23:18:54 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BB7C061746;
        Tue, 28 Sep 2021 20:17:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q23so744433pfs.9;
        Tue, 28 Sep 2021 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qa5ZCeGErb5j0p2Gqn+aZhp7ud7tKxLIEmaMkDpWT38=;
        b=WSwhqWonIxzhiz2hIT5o4Bkl771G1ArxckUQ0wwGagp13+kfNh05CtLG8edArruzbT
         kxCL8eaED1mWWn8Piv0OFB3uaqwVATI0bUtipjI4c9cD1/0sf/kf6zHqLVRgfA6OEVv4
         XPy1gAfNkNrv78gVhfVUBm2Lm3xntohFqywezofWZ5ccCKVDK+bwSjKUbrCMj8dVY+Yk
         auCxPyULEjMTkkf2or0ihA+yhjdw+T1PGPNsN3ZOvkzu5lXIg26fgLiD5zxAzGo+agzl
         Q0YQHSI6UIjid4kBYwHNqI7RGPdhJrRDPEVGCUGZtHE04SqEpgQLE2QHAa/Ke2xL2Zzx
         OPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qa5ZCeGErb5j0p2Gqn+aZhp7ud7tKxLIEmaMkDpWT38=;
        b=5qOjiwZOx9Np80Z6Y/yJD8suFuFN8iyyuNdJTInWeXNyNjfKb1PS5dk4HeU9qVrYYE
         A3egdfa5fJe9ooZXu27lbPerbnAM98q50NAJNkEfh/Fm9W2agOQPza3+XRzCil3ej4kt
         ECbWuOr3mckmwXZeN3b9b/jP73SRdbTnUE8ZlUic4MGF3+as2OjgJaSyIaPfgO16gvy8
         riyQxs7fBS0dk6dZL/YUrfDxVS/JKTkkMbcvRi6jrlA+OzzTCd54UGfh2nlAyjLeqTHO
         R7KpXZvWkrjtYeQWh6rouUZcr1GXFx1O4+BJ/1QiZmiEfJoIkkxKigPHJAILu5Oo5nRV
         b1Kg==
X-Gm-Message-State: AOAM5315BAD/YMGIu+9FYAvkjWCSuueJi6Abc7VWOAARnJQU8ALk1Q4d
        MrLP/dA5odlVxqeC0JPGwp0=
X-Google-Smtp-Source: ABdhPJxpn4EftGQF+8jjmSTtCuQwegWeEb3D4qCNrylx6ekMc7l0pclEY+3TVCKYHjlRUh0cl+Dwzw==
X-Received: by 2002:a63:330f:: with SMTP id z15mr7663526pgz.402.1632885434094;
        Tue, 28 Sep 2021 20:17:14 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 65sm464203pfv.210.2021.09.28.20.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 20:17:13 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v17 7/9] counter: Implement events_queue_size sysfs attribute
Date:   Wed, 29 Sep 2021 12:16:04 +0900
Message-Id: <c914b2db2ea0a2637633bcc3e86ded3c94783f2e.1632884256.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1632884256.git.vilhelm.gray@gmail.com>
References: <cover.1632884256.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The events_queue_size sysfs attribute provides a way for users to
dynamically configure the Counter events queue size for the Counter
character device interface. The size is in number of struct
counter_event data structures. The number of elements will be rounded-up
to a power of 2 due to a requirement of the kfifo_alloc function called
during reallocation of the queue.

Cc: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-counter |  8 ++++
 drivers/counter/counter-sysfs.c             | 45 +++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 0ce16669157e..06c2b3e27e0b 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -233,6 +233,14 @@ Description:
 		shorter or equal to configured value are ignored. Value 0 means
 		filter is disabled.
 
+What:		/sys/bus/counter/devices/counterX/events_queue_size
+KernelVersion:	5.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Size of the Counter events queue in number of struct
+		counter_event data structures. The number of elements will be
+		rounded-up to a power of 2.
+
 What:		/sys/bus/counter/devices/counterX/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 97d8d7c2a2b6..1ccd771da25f 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -3,11 +3,13 @@
  * Generic Counter sysfs interface
  * Copyright (C) 2020 William Breathitt Gray
  */
+#include <linux/atomic.h>
 #include <linux/counter.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/kstrtox.h>
 #include <linux/list.h>
 #include <linux/string.h>
@@ -783,12 +785,49 @@ static int counter_num_counts_read(struct counter_device *counter, u8 *val)
 	return 0;
 }
 
+static int counter_events_queue_size_read(struct counter_device *counter,
+					  u64 *val)
+{
+	*val = kfifo_size(&counter->events);
+	return 0;
+}
+
+static int counter_events_queue_size_write(struct counter_device *counter,
+					   u64 val)
+{
+	DECLARE_KFIFO_PTR(events, struct counter_event);
+	int err = 0;
+
+	/* Ensure chrdev is not opened more than 1 at a time */
+	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
+		return -EBUSY;
+
+	/* Allocate new events queue */
+	err = kfifo_alloc(&events, val, GFP_KERNEL);
+	if (err)
+		goto exit_early;
+
+	/* Swap in new events queue */
+	kfifo_free(&counter->events);
+	counter->events.kfifo = events.kfifo;
+
+exit_early:
+	atomic_dec(&counter->chrdev_lock);
+
+	return err;
+}
+
 static struct counter_comp counter_num_signals_comp =
 	COUNTER_COMP_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
 
 static struct counter_comp counter_num_counts_comp =
 	COUNTER_COMP_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
 
+static struct counter_comp counter_events_queue_size_comp =
+	COUNTER_COMP_DEVICE_U64("events_queue_size",
+				counter_events_queue_size_read,
+				counter_events_queue_size_write);
+
 static int counter_sysfs_attr_add(struct counter_device *const counter,
 				  struct counter_attribute_group *cattr_group)
 {
@@ -827,6 +866,12 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
+	/* Create events_queue_size attribute */
+	err = counter_attr_create(dev, cattr_group,
+				  &counter_events_queue_size_comp, scope, NULL);
+	if (err < 0)
+		return err;
+
 	/* Create an attribute for each extension */
 	for (i = 0; i < counter->num_ext; i++) {
 		ext = &counter->ext[i];
-- 
2.33.0

