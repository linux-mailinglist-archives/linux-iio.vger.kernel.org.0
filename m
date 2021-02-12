Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF7319E32
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhBLMSN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 07:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhBLMQk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 07:16:40 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F5C061797;
        Fri, 12 Feb 2021 04:15:59 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id r77so8386354qka.12;
        Fri, 12 Feb 2021 04:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/dq5yGecHRhOL4H/a5G1r5U6YeS+IFkmZnnpivpRxz0=;
        b=tXuGmxOXZjyIYnc4JHpPzHer/gQ/umhTIRqUuJ8cQa50uqekdJsbA3h4EjtioeGFxf
         JzwqtuRbhjg93Xn6RmJKEsnyxlyrkHHxrrQ3KqFTY/T2O2DY8j5ewbwqeCk+s+3zpwxH
         xNxCx1U3I/x3naLWre8EkQ/OBUhzEvBxw+H6FBh1qkwk1EVwxgBHk7FKb/YNSitaE6Ej
         3m0tTTFo1DhblZnvyD1mCLom3p4J8e+rikkdVJEGIYeT1vrZVN5WaerN6EK41zEHUOOd
         2ExeSBjDylw5hwCmMp/7gg0C37QwFBoEUp2jbcN/jBB2T1r1cKcP3CNwX4My6Qu3Vk3t
         4fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/dq5yGecHRhOL4H/a5G1r5U6YeS+IFkmZnnpivpRxz0=;
        b=tykkmm7SPUJaV/dh7mqW9VbsvbICAhK01FqatCHnBtSVyovfT0xzLv0j2VtKnxeDAz
         x2KjxHLukhS7qbG3lecshkJTvSD5yFmi4O2Dnf2xXKedDvUn6qWXPYRIpUtwsslHMzcQ
         qHCqwnXalGwytyhOwpnkFr/x7iechlkNxFNq0JeD6JiET82VjGZZ1QdGV6UVPntn6MTx
         n1LItak4WzHqQ13dbwEMXN5fq2ka8dsBZel0TfJAoNjcC5VGqALrei1zM0vYYD8zWQyh
         EdwDMLHrjh+SmVmU6s2IbNl+sXARtPSgU98DaDO6FYV6bokyjeONoHNQDJPz5JeXBEye
         8bUg==
X-Gm-Message-State: AOAM530NrYPEtydEVn8O7gMYe4uIJlHwcY5YsqrqZpovW8TKmtCuHCJy
        2oX0Y3KlTehfSf6OGX4KgYk=
X-Google-Smtp-Source: ABdhPJx+MOrmlkkISgi4I5vYgi3Ar2qnU+GE7hatn2Dxgegz33X0EKpQOMpBeF7PGWv4qKwzr0vY+Q==
X-Received: by 2002:a05:620a:b13:: with SMTP id t19mr2354370qkg.300.1613132159258;
        Fri, 12 Feb 2021 04:15:59 -0800 (PST)
Received: from localhost.localdomain ([193.27.12.132])
        by smtp.gmail.com with ESMTPSA id y135sm6278534qkb.14.2021.02.12.04.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 04:15:58 -0800 (PST)
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
Subject: [PATCH v8 20/22] counter: Implement events_queue_size sysfs attribute
Date:   Fri, 12 Feb 2021 21:13:44 +0900
Message-Id: <013b2b8682ddc3c85038083e6d5567696b6254b3.1613131238.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1613131238.git.vilhelm.gray@gmail.com>
References: <cover.1613131238.git.vilhelm.gray@gmail.com>
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
 Documentation/ABI/testing/sysfs-bus-counter |  8 +++++++
 drivers/counter/counter-chrdev.c            | 23 +++++++++++++++++++
 drivers/counter/counter-chrdev.h            |  2 ++
 drivers/counter/counter-sysfs.c             | 25 +++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 847e96f19d19..f6cb2a8b08a7 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -212,6 +212,14 @@ Description:
 		both edges:
 			Any state transition.
 
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
index 16f02df7f73d..53eea894e13f 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -375,6 +375,29 @@ void counter_chrdev_remove(struct counter_device *const counter)
 	cdev_del(&counter->chrdev);
 }
 
+int counter_chrdev_realloc_queue(struct counter_device *const counter,
+				 size_t queue_size)
+{
+	int err;
+	DECLARE_KFIFO_PTR(events, struct counter_event);
+	unsigned long flags;
+
+	/* Allocate new events queue */
+	err = kfifo_alloc(&events, queue_size, GFP_ATOMIC);
+	if (err)
+		return err;
+
+	raw_spin_lock_irqsave(&counter->events_list_lock, flags);
+
+	/* Swap in new events queue */
+	kfifo_free(&counter->events);
+	counter->events.kfifo = events.kfifo;
+
+	raw_spin_unlock_irqrestore(&counter->events_list_lock, flags);
+
+	return 0;
+}
+
 static int counter_get_data(struct counter_device *const counter,
 			    const struct counter_comp_node *const comp_node,
 			    u64 *const value)
diff --git a/drivers/counter/counter-chrdev.h b/drivers/counter/counter-chrdev.h
index cf5a318fe540..ff7fb0191852 100644
--- a/drivers/counter/counter-chrdev.h
+++ b/drivers/counter/counter-chrdev.h
@@ -12,5 +12,7 @@
 int counter_chrdev_add(struct counter_device *const counter,
 		       const dev_t counter_devt);
 void counter_chrdev_remove(struct counter_device *const counter);
+int counter_chrdev_realloc_queue(struct counter_device *const counter,
+				 size_t queue_size);
 
 #endif /* _COUNTER_CHRDEV_H_ */
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 0cb3dba950bc..9abc821a3871 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -13,6 +13,7 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
+#include "counter-chrdev.h"
 #include "counter-sysfs.h"
 
 /**
@@ -737,12 +738,30 @@ static int counter_num_counts_read(struct counter_device *counter, u8 *val)
 	return 0;
 }
 
+static int counter_events_queue_size_read(struct counter_device *counter,
+					  u64 *val)
+{
+	*val = counter->events.kfifo.mask + 1;
+	return 0;
+}
+
+static int counter_events_queue_size_write(struct counter_device *counter,
+					   u64 val)
+{
+	return counter_chrdev_realloc_queue(counter, val);
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
@@ -781,6 +800,12 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
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
-- 
2.30.0

