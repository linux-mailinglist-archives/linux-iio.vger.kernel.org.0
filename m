Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBBC341AFC
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhCSLD5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhCSLDl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:03:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F80C06175F;
        Fri, 19 Mar 2021 04:03:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so6572603pjb.0;
        Fri, 19 Mar 2021 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JO7Cai/fdh2OG/2z/jEAyOqlk0B+zcvIGOo1ydjYrlU=;
        b=kzohCOpglxzV1kXC5qUGQUCvk+GCMlVbLjAYPRxqjYKEnGWoZgizl0k1YyUa8BEQUm
         Vz27/RFavf8ytskVlz1c+hFyg2r1KKKCE1RuApeQ4syWoidHMGpb6wrCnd/B/74wZRAX
         IJen0AjcLDzHyJZ4X5g/O/RNnwz6Sm4aM1IVdNjYHnV0F9WZF12O8RRfgqH9qlq2Z3wF
         H4ZpjcDX2D7fN+X/9V/5Ty/zC1uXIpOUGuUpBXqA+Wq0Jy6oLye/YUduvJMnS0LvQ34U
         9gl2RIwFT8UFfx+lT71pNuBBtQcIPOxyyzD6uxSC0l1tB2cLKWkh3Ksfs+rxpqWgDdDT
         8WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JO7Cai/fdh2OG/2z/jEAyOqlk0B+zcvIGOo1ydjYrlU=;
        b=XvFI+0pkUDR7PdjpLUqRUBBqbLUoGhJYQUD+8rIJmrIHn3xvMsGR1bU1kMJoW/WUyO
         NXlvSZebiWApxPWfiZLoEu9X7+8f5d9YjpzEYsqEaMBBtesMpWzK/SnHpsWmljsHb8y/
         XwkXj6Pbs6V0B5k07vnSBp2rKXPtSZeluDNuyOMzHC2WEa/O4GFMNBK7776rA/TPx78V
         Dt6KuCbiRgw1sCVwwCYtimPVermioqXqWIBn+qEPgjSHYr5PuvBKWwEyb0mkKVi2UaEP
         K6zylfAd2o6uiH9ihq0SDyp2LX6Dr5rNU6B0cgs+70m92YkgvgJj7jQWAJzdDw4XeOYJ
         LLRg==
X-Gm-Message-State: AOAM533r8sFttf/BPv6VwYvK4X8bUcQLeSCWwBnfljRjUxBX5aXOaRUd
        AiAyZqLRdvpNzGR94IFOazpcgAXr8CNgqg==
X-Google-Smtp-Source: ABdhPJz/8DhQcL5BjAJcQ8VSJhxHchRYFNHupxXC1o8o1XvpJ+QtmSHQLzfC4Pwzh7JdRBppgFQfMQ==
X-Received: by 2002:a17:902:24d:b029:e3:cfa7:e308 with SMTP id 71-20020a170902024db02900e3cfa7e308mr13764417plc.82.1616151820840;
        Fri, 19 Mar 2021 04:03:40 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:03:40 -0700 (PDT)
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
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 31/33] counter: Implement events_queue_size sysfs attribute
Date:   Fri, 19 Mar 2021 20:00:50 +0900
Message-Id: <052410b645d7c2ce47f78540cfa93ebad489c1df.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
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
 drivers/counter/counter-chrdev.c            |  4 ++
 drivers/counter/counter-sysfs.c             | 44 +++++++++++++++++++++
 include/linux/counter.h                     |  2 +
 4 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 57b051ba53a9..a97d85e97184 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -224,6 +224,14 @@ Description:
 		Read-only attribute that indicates the component ID of the
 		respective extension or Synapse.
 
+What:		/sys/bus/counter/devices/counterX/events_queue_size
+KernelVersion:	5.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Size of the Counter events queue in number of struct
+		counter_event data structures. The number of elements will be
+		rounded-up to a power of 2.
+
 What:		/sys/bus/counter/devices/counterX/name
 KernelVersion:	5.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index d5f92b2d3bb4..d9f123ca0ed6 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -311,6 +311,9 @@ static int counter_chrdev_open(struct inode *inode, struct file *filp)
 							    typeof(*counter),
 							    chrdev);
 
+	if (!mutex_trylock(&counter->chrdev_lock))
+		return -EBUSY;
+
 	get_device(&counter->dev);
 	filp->private_data = counter;
 
@@ -327,6 +330,7 @@ static int counter_chrdev_release(struct inode *inode, struct file *filp)
 		return err;
 
 	put_device(&counter->dev);
+	mutex_unlock(&counter->chrdev_lock);
 
 	return 0;
 }
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index eb1505bfbd89..bf038eff4587 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -8,7 +8,9 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -782,12 +784,48 @@ static int counter_num_counts_read(struct counter_device *counter, u8 *val)
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
+	int err;
+	DECLARE_KFIFO_PTR(events, struct counter_event);
+
+	/* Verify chrdev is not currently being used */
+	if (!mutex_trylock(&counter->chrdev_lock))
+		return -EBUSY;
+
+	/* Allocate new events queue */
+	err = kfifo_alloc(&events, val, GFP_ATOMIC);
+	if (err)
+		return err;
+
+	/* Swap in new events queue */
+	kfifo_free(&counter->events);
+	counter->events.kfifo = events.kfifo;
+
+	mutex_unlock(&counter->chrdev_lock);
+
+	return 0;
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
 				  struct counter_attribute_group *group)
 {
@@ -826,6 +864,12 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
+	/* Create num_counts attribute */
+	err = counter_attr_create(dev, group, &counter_events_queue_size_comp,
+				  scope, NULL);
+	if (err < 0)
+		return err;
+
 	/* Create an attribute for each extension */
 	for (i = 0; i < counter->num_ext; i++) {
 		ext = counter->ext + i;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 3f0bbe4ff702..854fcaf49c32 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -289,6 +289,7 @@ struct counter_ops {
  * @priv:		optional private data supplied by driver
  * @dev:		internal device structure
  * @chrdev:		internal character device structure
+ * @chrdev_lock:	lock to limit chrdev to a single open at a time
  * @events_list:	list of current watching Counter events
  * @events_list_lock:	lock to protect Counter events list operations
  * @next_events_list:	list of next watching Counter events
@@ -314,6 +315,7 @@ struct counter_device {
 
 	struct device dev;
 	struct cdev chrdev;
+	struct mutex chrdev_lock;
 	struct list_head events_list;
 	spinlock_t events_list_lock;
 	struct list_head next_events_list;
-- 
2.30.2

