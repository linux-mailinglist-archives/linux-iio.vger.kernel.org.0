Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD843A097A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhFIBhj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:37:39 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35418 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhFIBhi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:37:38 -0400
Received: by mail-pl1-f171.google.com with SMTP id x19so4550520pln.2;
        Tue, 08 Jun 2021 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbOzE7K/xfZlrJ54P7nyWnuj9+/2J6JgBhiOMg59zJ4=;
        b=FWdoqgc54sDr88wbLEzjc60GmERI8T/gFZW3LxNDqHwOQ00t3aqN/TZ1MY3Aut/vUv
         qhscRtFNZWsEq1rYdWPJTs0AvRti4se2vgF8X04qPFHf7MC8RLEOeNEEqajOls8jB0JG
         RmyPgejB/2Y0ypohcAp4z9pddkBy2UHxJ8k/ngXzWyj5Jg/0Ds3SGmbN3g0dCHuWtKX6
         fPKRU1K1lwp7LwvARzOY4lPIoojJd7hb6FfNgzGQoNbICdzE0e59s7GXgOA9jqsZUFbu
         wll7QJUdBG89IL7KqJvaLtg3QOQ/SNBrwZct1r21jX0F9L2CNBrahGcCSuSqA/eHVcne
         HDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KbOzE7K/xfZlrJ54P7nyWnuj9+/2J6JgBhiOMg59zJ4=;
        b=q9UbsbgWMvcGCsxT5GNiTn/rdwe5ML+XUeQLgSjft39nEeDdjCZVU1q8OsU79SrQaw
         jcYK429hh6oYAWqSPAwYr+PNSLvGIquSOiwckVkuiqwWEnmt16IG5oH0Budomgq97Dvd
         6uSD5AJN7nEVmCzHJXjbi0BC5UBQBtgKNgIPhpnYAGPgr2i/Px6SVsitcYKiVihHoYWL
         XpOMt44JbcSuTL6zBJnbcn0VSRqebOItNmnM9SCvz5Sgy/gtqTBfM4RadHy5E4pnydd5
         vzCyF8N0si4qaOGsNhScw1mKIkWaM7zJ0Bk6gvANGys9bj+QdOMrieq3l00W9wzMzHJm
         dozw==
X-Gm-Message-State: AOAM530/iaLwQBJ/Hb0EdGtR8m4ypCM6k+EOCgwkWVztIDM0Si/nCT7w
        IeezTLUFyznXQU33YzGrOaA=
X-Google-Smtp-Source: ABdhPJy/WYlmnIJMYoK2SRLZ75DDvH4IiIcXyOSW+Fsv47aazgGwO6wvUk29zLIdSHKqd1ZbUC4Gnw==
X-Received: by 2002:a17:902:db11:b029:110:a7cc:ff46 with SMTP id m17-20020a170902db11b0290110a7ccff46mr2948773plx.60.1623202471288;
        Tue, 08 Jun 2021 18:34:31 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:34:30 -0700 (PDT)
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
Subject: [PATCH v11 31/33] counter: Implement events_queue_size sysfs attribute
Date:   Wed,  9 Jun 2021 10:31:34 +0900
Message-Id: <119b74f066b64cf9534f6ea76c99db8d2a623a4f.1623201082.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
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
2.32.0

