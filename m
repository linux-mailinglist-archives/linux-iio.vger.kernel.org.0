Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEF33C6DFB
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbhGMJ5w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbhGMJ5w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:57:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425DCC0613DD;
        Tue, 13 Jul 2021 02:55:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id o201so14013420pfd.1;
        Tue, 13 Jul 2021 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWjLrUHBiLSo33bWGjicMkKY6TK3RrLryAVl43qJWWE=;
        b=POBRJFxcN2v8dWroVk7UINXfSAA3ELwRmTDuXOb81+CzLxsSXoPd/FbwflwrRRiQFl
         skst+uvIpQYyGpOpqXKO0cGj7zLYyV7DySuxO3XV78xjnzyyakt3r2rzvt41NdiFbJWf
         HEhXFiITo50LxunLCZOY+ptk4/PF8gRaVB7V+JxgPjxjNATNWHxbKe2JeGJgeBCwa/t2
         0Q0kiH9FFLgM8VAl0MRga9BgSX7RhVHKj75vTHI1PsuZau+UDu9GwtK0zBr6VSdeJD/+
         BR+mFoHras6XRSFQ40AWlPvyCPOmYe51/OBY4OtNclGtyHMV+Ay6p9Olhwt9KWKEdF2B
         XFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWjLrUHBiLSo33bWGjicMkKY6TK3RrLryAVl43qJWWE=;
        b=n915gkN4aJ0grS23Tn5yeto91KQGjAGpDd8qecknH3qQiFkYVeHbt99YoVdvpL8LvV
         eCR6x8ZeSqDV9kbjP8g1/JeeJLiP9aEgitKTZw9jwIxeWCbwQhiPlWuq2oQ2g9E2gdiM
         7GDt8Z15xp/nawr5TFvyLigKOHZUe7mfbcNWeDaXKcGmVwLaaIdQufZjQlqmM53xnEcR
         oKDbmQlwqUC/OUojfhDk8rekDxVedWoTX/GJ9ptNnOkY+5DGix/aolQR4HbQ4YQiDUXK
         zxmZ+ur0jLgdCEMKfh0L5sQeupDai72uI3WiPAfOaWG8S8vKmJqbsbcpr30hIVbkOede
         kTVA==
X-Gm-Message-State: AOAM532CtuUQnnxMEQH/eI6ejV1hjYqm/2EDCbsj4laVZS5+2TSVKKkQ
        e4LjiiIHDB5NGkJTyS9P0gs=
X-Google-Smtp-Source: ABdhPJxHZ4bdBYrcOXBls+u/zUk8LYHEBtv5ijVOofd2p5c1gibDWG+URMgApG7KCLv1D0XA+tLbOg==
X-Received: by 2002:a63:1252:: with SMTP id 18mr2599232pgs.126.1626170101855;
        Tue, 13 Jul 2021 02:55:01 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f6sm18153854pfj.28.2021.07.13.02.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 02:55:01 -0700 (PDT)
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
Subject: [PATCH v13 15/17] counter: Implement events_queue_size sysfs attribute
Date:   Tue, 13 Jul 2021 18:53:19 +0900
Message-Id: <7ec39add7db353b4e8d1c53f52b356007364ad14.1626165765.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1626165764.git.vilhelm.gray@gmail.com>
References: <cover.1626165764.git.vilhelm.gray@gmail.com>
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
 drivers/counter/counter-chrdev.c            |  6 +++
 drivers/counter/counter-sysfs.c             | 45 +++++++++++++++++++++
 include/linux/counter.h                     |  2 +
 4 files changed, 61 insertions(+)

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
index d5af82d3c04b..cf94e8f1c4ea 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -3,6 +3,7 @@
  * Generic Counter character device interface
  * Copyright (C) 2020 William Breathitt Gray
  */
+#include <linux/bitops.h>
 #include <linux/cdev.h>
 #include <linux/counter.h>
 #include <linux/err.h>
@@ -336,6 +337,9 @@ static int counter_chrdev_open(struct inode *inode, struct file *filp)
 							    typeof(*counter),
 							    chrdev);
 
+	if (test_and_set_bit_lock(0, counter->chrdev_lock))
+		return -EBUSY;
+
 	get_device(&counter->dev);
 	filp->private_data = counter;
 
@@ -352,6 +356,7 @@ static int counter_chrdev_release(struct inode *inode, struct file *filp)
 		return err;
 
 	put_device(&counter->dev);
+	clear_bit_unlock(0, counter->chrdev_lock);
 
 	return 0;
 }
@@ -376,6 +381,7 @@ int counter_chrdev_add(struct counter_device *const counter)
 	mutex_init(&counter->events_lock);
 
 	/* Initialize character device */
+	clear_bit(0, counter->chrdev_lock);
 	cdev_init(&counter->chrdev, &counter_fops);
 
 	/* Allocate Counter events queue */
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index df1d75e0d7b8..d2d6495f73c5 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -3,11 +3,13 @@
  * Generic Counter sysfs interface
  * Copyright (C) 2020 William Breathitt Gray
  */
+#include <linux/bitops.h>
 #include <linux/counter.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
+#include <linux/kfifo.h>
 #include <linux/kstrtox.h>
 #include <linux/list.h>
 #include <linux/string.h>
@@ -785,12 +787,49 @@ static int counter_num_counts_read(struct counter_device *counter, u8 *val)
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
+	/* Verify chrdev is not currently being used */
+	if (test_and_set_bit_lock(0, counter->chrdev_lock))
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
+	clear_bit_unlock(0, counter->chrdev_lock);
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
@@ -829,6 +868,12 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
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
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 895d60a238a9..bfd96fa1f7fe 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -297,6 +297,7 @@ struct counter_ops {
  * @events:		queue of detected Counter events
  * @events_wait:	wait queue to allow blocking reads of Counter events
  * @events_lock:	lock to protect Counter events queue read operations
+ * @chrdev_lock:	lock to limit chrdev to a single open at a time
  */
 struct counter_device {
 	const char *name;
@@ -323,6 +324,7 @@ struct counter_device {
 	DECLARE_KFIFO_PTR(events, struct counter_event);
 	wait_queue_head_t events_wait;
 	struct mutex events_lock;
+	DECLARE_BITMAP(chrdev_lock, 1);
 };
 
 int counter_register(struct counter_device *const counter);
-- 
2.32.0

