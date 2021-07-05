Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC143BB8EA
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhGEIXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 04:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhGEIXT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 04:23:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678FBC061574;
        Mon,  5 Jul 2021 01:20:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso11340817pjp.2;
        Mon, 05 Jul 2021 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJ5JyREZ5LpvYsK+0QASIvJ867/NXe9Cl2Yvt7ud23M=;
        b=RZX/aDqOz1vpn3LnYmIfFKdCCfW9QoOgr8SuZYs2YISBtw40q6xjy6GobZ2c2fH35r
         /HmSEQ7BLqid1XFINBFPY6rM8ot7AfjjJq+cfttLAQlJ4ebTpbqaeNZ5WBvJMNzONgGm
         bfisqgFcACnnvlIX2GwS2M9oCFkMdQr2egtne1J3vdBHdK7R0EImjDqKfyc+WIGMM6CK
         rNAqM2ATbt3HLYpPd5UxELrRLzGFG5gpyVdpQom4qClkVW4pm73pS7Zn33s5PJ/Qm7+Z
         mo/9Sr1MvS3yBgTxlw8rKf4/HafUAugGHrjkT13Ix8ExjowlQV+sfi9WoG3QKXswWwHx
         9wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJ5JyREZ5LpvYsK+0QASIvJ867/NXe9Cl2Yvt7ud23M=;
        b=S0ab49nx+BDk7qsRfN3dJMiFj0h/aqxafCqpOIGUkKkm1UlLnsAW8t4juz9Ods859B
         RQl7x6LZ9uy4e0V2WUf6ZXsYuKTzBksBu9ugZyDEzbhSoEKNOtEHODfn/m5HzShnCazB
         dFk3FU6ICmnGdwbaOicumejT+l9XkXdXZx3tvUnBkRODrtsJ8Z3w3H7+5g06Bp/MO39M
         IN4NolxbQfmAItlifdtYc9RlhdpIcIxqVZvAtoY75m7xeDdVwk2bx3OTqIfGLhK2vgAt
         KhXFDCRfqJeCtRU+6FTWjr0bWfPBdu7ovnIkvQa5DVQZr5qt7IckpQv8rs+VdEvsC1Pc
         iafA==
X-Gm-Message-State: AOAM531VSZsF+Zh4GYKSHo2S7QsRLqOPj5evANjHInzB9KeLTtVbycjO
        XPCHiGPvLLH6BybLLi7wSDU=
X-Google-Smtp-Source: ABdhPJwfFE1Okx71Js6IHRadfTJYlKRDeh+tPkSdb2+dq9wLCFYZ/j3/+hU+6FP7yjA5EuTR8UwbTg==
X-Received: by 2002:a17:90a:c484:: with SMTP id j4mr11163356pjt.218.1625473242038;
        Mon, 05 Jul 2021 01:20:42 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y11sm12209986pfo.160.2021.07.05.01.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 01:20:41 -0700 (PDT)
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
Subject: [PATCH v12 15/17] counter: Implement events_queue_size sysfs attribute
Date:   Mon,  5 Jul 2021 17:19:03 +0900
Message-Id: <e298043c880b350a42bdc40452376a3708bf533b.1625471640.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1625471640.git.vilhelm.gray@gmail.com>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
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
index e0e99adb0ecc..84ebb1ed28ed 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -233,6 +233,14 @@ Description:
 		shorter or equal to configured value are ignored. Value 0 means
 		filter is disabled.
 
+What:		/sys/bus/counter/devices/counterX/events_queue_size
+KernelVersion:	5.15
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
index 92805b1f65b8..13644c87d02a 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -323,6 +323,9 @@ static int counter_chrdev_open(struct inode *inode, struct file *filp)
 							    typeof(*counter),
 							    chrdev);
 
+	if (!mutex_trylock(&counter->chrdev_lock))
+		return -EBUSY;
+
 	get_device(&counter->dev);
 	filp->private_data = counter;
 
@@ -339,6 +342,7 @@ static int counter_chrdev_release(struct inode *inode, struct file *filp)
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
2.32.0

