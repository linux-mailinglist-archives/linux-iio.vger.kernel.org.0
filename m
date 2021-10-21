Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590BA435F1C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJUKiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 06:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJUKiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 06:38:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0B2C06161C;
        Thu, 21 Oct 2021 03:35:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kk10so208575pjb.1;
        Thu, 21 Oct 2021 03:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIQ1evG3JcfP14fnAmThR7DabXSKbcX4zhT17hg7Jpc=;
        b=ECp2xJ4eWy9H8KkGyneV/LJsYm9Ap+21RMBdPYbgJ5SWCNzEGpAaxuushG7hsgN+Ii
         ZWPpAP1PN+ar8FwjHl3fDfZPIixXOr6l2zN8ySsBicCUv5X4JG/nyiTv1JSIY1qWxEky
         NKCLxqfjaBKzz684Ymfo6lYqXQz5r8/AOD0aKR5/yvQ17qanPfHPUCdeEO8uKKeLOJOb
         4v1vtMOwIz4S7ffNCPb4nJJgWZKPBBf7dUsvZzSk+Dd5IOaBhbU76wiEZ88X1FTDhkNC
         bBBWKkFoYeW/zwTwUDtge5K0KmOhZzKIRHun+xTGYyPhC1+nOsUX6IzCxS3MMRVOj/Lv
         UmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZIQ1evG3JcfP14fnAmThR7DabXSKbcX4zhT17hg7Jpc=;
        b=BkCd+NC4LsNlF3VxaAqaSJPokfNZQ7Qprl5+c4y4klWYLrhHbHN7DXbbMHsK1mFtTO
         LTreYQFu/X1EHQWBducuo0T7VyiNzteMnT2yMKE1+XKzLi0h1jdnHmKXOsAjM/mKGqlq
         hq38C66Y9qBqswTaetG8p7uhujfBdfbPZSjsSnaKJ1Q/AhBJ8CfI0gOvf9/xzAIqd2Mu
         AqTvOquS1nfzMHqM+p9YaXx21FzZN+Gi2mglDkOJe/1AcIU3tP1I7P4Z4ToNUa1sh5oP
         IgASiPz/eflAhJqFmACGDIta06IZ91dQugzHy1gAX3aDG/VzwsWmbSsdFn95lptE4qRv
         pzvQ==
X-Gm-Message-State: AOAM530FKubg9QTNj3+m+uTfsLrtUwzUs0GGNQJ2wBVdOk/81HUew8Yt
        2KU/6bgyAUFxz7v1OIAOsok=
X-Google-Smtp-Source: ABdhPJzS1bp6aB4U0Dk4hRaow1971KKUEJujX0ARUme/LPN/WaAfxUvO9fgOzcSN0ljNgtuVCZegUw==
X-Received: by 2002:a17:902:d48a:b0:13f:4411:8ae9 with SMTP id c10-20020a170902d48a00b0013f44118ae9mr4407316plg.86.1634812549442;
        Thu, 21 Oct 2021 03:35:49 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id z1sm5872156pfh.150.2021.10.21.03.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:35:48 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] counter: Fix use-after-free race condition for events_queue_size write
Date:   Thu, 21 Oct 2021 19:35:40 +0900
Message-Id: <20211021103540.955639-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A race condition is possible when writing to events_queue_size where the
events kfifo is freed during the execution of a kfifo_in(), resulting in
a use-after-free. This patch prevents such a scenario by protecting the
events queue in operation with a spinlock and locking before performing
the events queue size adjustment.

The existing events_lock mutex is renamed to events_out_lock to reflect
that it only protects events queue out operations. Because the events
queue in operations can occur in an interrupt context, a new
events_in_lock spinlock is introduced and utilized.

Fixes: feff17a550c7 ("counter: Implement events_queue_size sysfs attribute")
Cc: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-chrdev.c | 10 ++++++----
 drivers/counter/counter-sysfs.c  |  7 +++++++
 include/linux/counter.h          |  6 ++++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index b747dc81c..afa41c517 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -82,10 +82,10 @@ static ssize_t counter_chrdev_read(struct file *filp, char __user *buf,
 				return -ENODEV;
 		}
 
-		if (mutex_lock_interruptible(&counter->events_lock))
+		if (mutex_lock_interruptible(&counter->events_out_lock))
 			return -ERESTARTSYS;
 		err = kfifo_to_user(&counter->events, buf, len, &copied);
-		mutex_unlock(&counter->events_lock);
+		mutex_unlock(&counter->events_out_lock);
 		if (err < 0)
 			return err;
 	} while (!copied);
@@ -437,7 +437,8 @@ int counter_chrdev_add(struct counter_device *const counter)
 	spin_lock_init(&counter->events_list_lock);
 	mutex_init(&counter->n_events_list_lock);
 	init_waitqueue_head(&counter->events_wait);
-	mutex_init(&counter->events_lock);
+	spin_lock_init(&counter->events_in_lock);
+	mutex_init(&counter->events_out_lock);
 
 	/* Initialize character device */
 	cdev_init(&counter->chrdev, &counter_fops);
@@ -560,7 +561,8 @@ void counter_push_event(struct counter_device *const counter, const u8 event,
 		ev.watch.component = comp_node->component;
 		ev.status = -counter_get_data(counter, comp_node, &ev.value);
 
-		copied += kfifo_in(&counter->events, &ev, 1);
+		copied += kfifo_in_spinlocked_noirqsave(&counter->events, &ev,
+							1, &counter->events_in_lock);
 	}
 
 exit_early:
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 8c2d7c29e..03564c3af 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -12,6 +12,8 @@
 #include <linux/kfifo.h>
 #include <linux/kstrtox.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -797,6 +799,7 @@ static int counter_events_queue_size_write(struct counter_device *counter,
 {
 	DECLARE_KFIFO_PTR(events, struct counter_event);
 	int err;
+	unsigned long flags;
 
 	/* Allocate new events queue */
 	err = kfifo_alloc(&events, val, GFP_KERNEL);
@@ -804,8 +807,12 @@ static int counter_events_queue_size_write(struct counter_device *counter,
 		return err;
 
 	/* Swap in new events queue */
+	mutex_lock(&counter->events_out_lock);
+	spin_lock_irqsave(&counter->events_in_lock, flags);
 	kfifo_free(&counter->events);
 	counter->events.kfifo = events.kfifo;
+	spin_unlock_irqrestore(&counter->events_in_lock, flags);
+	mutex_unlock(&counter->events_out_lock);
 
 	return 0;
 }
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 0fd99e255..b7d0a00a6 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -296,7 +296,8 @@ struct counter_ops {
  * @n_events_list_lock:	lock to protect Counter next events list operations
  * @events:		queue of detected Counter events
  * @events_wait:	wait queue to allow blocking reads of Counter events
- * @events_lock:	lock to protect Counter events queue read operations
+ * @events_in_lock:	lock to protect Counter events queue in operations
+ * @events_out_lock:	lock to protect Counter events queue out operations
  * @ops_exist_lock:	lock to prevent use during removal
  */
 struct counter_device {
@@ -323,7 +324,8 @@ struct counter_device {
 	struct mutex n_events_list_lock;
 	DECLARE_KFIFO_PTR(events, struct counter_event);
 	wait_queue_head_t events_wait;
-	struct mutex events_lock;
+	spinlock_t events_in_lock;
+	struct mutex events_out_lock;
 	struct mutex ops_exist_lock;
 };
 

base-commit: 8135cc5b270b3f224615bdee8bd7d66afee87991
-- 
2.33.1

