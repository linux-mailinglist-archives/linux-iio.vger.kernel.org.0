Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555653E45D5
	for <lists+linux-iio@lfdr.de>; Mon,  9 Aug 2021 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhHIMjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Aug 2021 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhHIMjJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Aug 2021 08:39:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F74CC061799;
        Mon,  9 Aug 2021 05:38:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c16so16172780plh.7;
        Mon, 09 Aug 2021 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=501FGUGr+wDXj4ObY1nsPy9qx/iYl7JAzl3fYbbvm8A=;
        b=vFk+k/wjVuJo+igVsNhV6wdTtKMuXAnR2yr+MiHGWE3fKGc3Ml+t3vhdHW0+up/KQe
         73jMtpNQmGzFUKwd6th60kFX9y49D85FMPbQ1X4CcAfYx0WEp0m101bCdLuqtMOZfVMs
         iphczO7cZNwFuUnQZJ9j2LwOnp/ONpHXTHWd/hO3t9cgC2ADZl6TBQNvA4+tqkB3apsF
         1PLej3XK5eqBA2nX9d4CrrBVqaqwiPT6eMn5Rn0n7qDAYUdE3IZ4DQlmF5pc8InuPA1Z
         uIkg2vYBf0YNm+MorP2GqQrqVFXEKWRWiK+LM77wqPeiThsbA7R2ATlJAvLA8l9/7QTO
         UAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=501FGUGr+wDXj4ObY1nsPy9qx/iYl7JAzl3fYbbvm8A=;
        b=iGuGT3XlJMp7uQFHU7kfXdqnyJMkyMH82StOry+hDKxGY6LhyIGehaBWvPZ+oJ6mK4
         0rkYEkd2cDRXue6pkOXrFZXTteCNUobvirvxwzEE6AMfGcRDGUDWy/rnyofO3Z3Mymaw
         eUFNWnKrGdSHctGt6PyTwo26wRtKtHrQFJJsDCifkMokW4M8a2Hyxp7IA6wdulgJVLfD
         jDamjqapiFQLTvIza5mNLEbYhiUDmNsBwZ80QTOQU9STqNgRKNIZ6O6kTHOtF/ijVUgY
         +DKlIHLCtl33A9agg9KDzfgjwDjDzuZzg9+gHQc5VFm7wiQyEdWFU+d4LgMCh8VrmaGf
         wpTQ==
X-Gm-Message-State: AOAM533WuABhfWNNEpF9gh2jjgMzFzrC7ETclJog2l21p5XirNgXQNud
        uaPLYrSFn9g6f/63+dYPjnQ=
X-Google-Smtp-Source: ABdhPJwQDlKYj82TU8roh5g3IqMy+LnGDP83kJy0n1ymNIJYAj/6/mFdXBp7Gt8ROA1bBpiw+lEQWw==
X-Received: by 2002:a65:63d7:: with SMTP id n23mr523128pgv.46.1628512729135;
        Mon, 09 Aug 2021 05:38:49 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id e35sm22382177pjk.28.2021.08.09.05.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 05:38:48 -0700 (PDT)
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
Subject: [PATCH v15 11/13] counter: Implement events_queue_size sysfs attribute
Date:   Mon,  9 Aug 2021 21:37:36 +0900
Message-Id: <ca9595cfd824a2a21399b21906aacad18b5f9328.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
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
-- 
2.32.0

