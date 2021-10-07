Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A08425490
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbhJGNsm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 09:48:42 -0400
Received: from smtp1.axis.com ([195.60.68.17]:31231 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241536AbhJGNsl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 09:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633614408;
  x=1665150408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ppm3Ewnf2Md+cj+s4kZ2wV6nmavY+aJ0xnD36dXp9/Q=;
  b=mB2tYtxe0IZFjBjqKFLR8y3oi2RpHW0O125KefPDDoJLgWP9s6wfAzeT
   Iqc64fIR+fMIkNCfBd60TKrcWioQTYkjAxvkBbB9b+f74vmKmYIPc7r0G
   3jzIt6QKQ1rFzEl3EzkdykmGgmF5V/ObTtFSPTXWL/i9ufK1rWee3zwWc
   gvoO3QwSEqCYTgoAf8Zis6En4J89GBB3Qdu17rKpZM4aSv2hgcME4JTz2
   SpkWlKdTWHKx6UDZgkylNzmmdyQ7Bk0Rq+fVXeDRDsErMYN75KjEyXRXS
   rYfuR6DMxLUk41Bh8Tt5ZjJp2KNJym3jqVwoVgxqMtjR6NGHsgbtyRj72
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <peda@axentia.se>, <jic23@kernel.org>, <devicetree@vger.kernel.org>
CC:     <kernel@axis.com>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 1/3] mux: add support for delay after muxing
Date:   Thu, 7 Oct 2021 15:46:39 +0200
Message-ID: <20211007134641.13417-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211007134641.13417-1-vincent.whitchurch@axis.com>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hardware may require some time for the muxed analog signals to settle
after the muxing is changed.  Allow users of the mux subsystem to
specify this delay with the new mux_control_select_delay() function (and
the _try equivalent).

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mux/core.c           | 36 +++++++++++++++++++++++++++++++-----
 include/linux/mux/consumer.h | 23 +++++++++++++++++++----
 include/linux/mux/driver.h   |  4 ++++
 3 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 1fb22388e7e0..dee6945e92f7 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "mux-core: " fmt
 
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
@@ -116,6 +117,7 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
 		sema_init(&mux->lock, 1);
 		mux->cached_state = MUX_CACHE_UNKNOWN;
 		mux->idle_state = MUX_IDLE_AS_IS;
+		mux->last_change = ktime_get();
 	}
 
 	device_initialize(&mux_chip->dev);
@@ -129,6 +131,8 @@ static int mux_control_set(struct mux_control *mux, int state)
 	int ret = mux->chip->ops->set(mux, state);
 
 	mux->cached_state = ret < 0 ? MUX_CACHE_UNKNOWN : state;
+	if (ret >= 0)
+		mux->last_change = ktime_get();
 
 	return ret;
 }
@@ -314,10 +318,25 @@ static int __mux_control_select(struct mux_control *mux, int state)
 	return ret;
 }
 
+static void mux_control_delay(struct mux_control *mux, unsigned int delay_us)
+{
+	ktime_t delayend;
+	s64 remaining;
+
+	if (!delay_us)
+		return;
+
+	delayend = ktime_add_us(mux->last_change, delay_us);
+	remaining = ktime_us_delta(delayend, ktime_get());
+	if (remaining > 0)
+		fsleep(remaining);
+}
+
 /**
- * mux_control_select() - Select the given multiplexer state.
+ * mux_control_select_delay() - Select the given multiplexer state.
  * @mux: The mux-control to request a change of state from.
  * @state: The new requested state.
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
  *
  * On successfully selecting the mux-control state, it will be locked until
  * there is a call to mux_control_deselect(). If the mux-control is already
@@ -331,7 +350,8 @@ static int __mux_control_select(struct mux_control *mux, int state)
  * Return: 0 when the mux-control state has the requested state or a negative
  * errno on error.
  */
-int mux_control_select(struct mux_control *mux, unsigned int state)
+int mux_control_select_delay(struct mux_control *mux, unsigned int state,
+			     unsigned int delay_us)
 {
 	int ret;
 
@@ -340,18 +360,21 @@ int mux_control_select(struct mux_control *mux, unsigned int state)
 		return ret;
 
 	ret = __mux_control_select(mux, state);
+	if (ret >= 0)
+		mux_control_delay(mux, delay_us);
 
 	if (ret < 0)
 		up(&mux->lock);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mux_control_select);
+EXPORT_SYMBOL_GPL(mux_control_select_delay);
 
 /**
  * mux_control_try_select() - Try to select the given multiplexer state.
  * @mux: The mux-control to request a change of state from.
  * @state: The new requested state.
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
  *
  * On successfully selecting the mux-control state, it will be locked until
  * mux_control_deselect() called.
@@ -363,7 +386,8 @@ EXPORT_SYMBOL_GPL(mux_control_select);
  * Return: 0 when the mux-control state has the requested state or a negative
  * errno on error. Specifically -EBUSY if the mux-control is contended.
  */
-int mux_control_try_select(struct mux_control *mux, unsigned int state)
+int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
+				 unsigned int delay_us)
 {
 	int ret;
 
@@ -371,13 +395,15 @@ int mux_control_try_select(struct mux_control *mux, unsigned int state)
 		return -EBUSY;
 
 	ret = __mux_control_select(mux, state);
+	if (ret >= 0)
+		mux_control_delay(mux, delay_us);
 
 	if (ret < 0)
 		up(&mux->lock);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(mux_control_try_select);
+EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
 
 /**
  * mux_control_deselect() - Deselect the previously selected multiplexer state.
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 5fc6bb2fefad..7a09b040ac39 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -16,10 +16,25 @@ struct device;
 struct mux_control;
 
 unsigned int mux_control_states(struct mux_control *mux);
-int __must_check mux_control_select(struct mux_control *mux,
-				    unsigned int state);
-int __must_check mux_control_try_select(struct mux_control *mux,
-					unsigned int state);
+int __must_check mux_control_select_delay(struct mux_control *mux,
+					  unsigned int state,
+					  unsigned int delay_us);
+int __must_check mux_control_try_select_delay(struct mux_control *mux,
+					      unsigned int state,
+					      unsigned int delay_us);
+
+static inline int __must_check mux_control_select(struct mux_control *mux,
+						  unsigned int state)
+{
+	return mux_control_select_delay(mux, state, 0);
+}
+
+static inline int __must_check mux_control_try_select(struct mux_control *mux,
+						      unsigned int state)
+{
+	return mux_control_try_select_delay(mux, state, 0);
+}
+
 int mux_control_deselect(struct mux_control *mux);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
index 627a2c6bc02d..18824064f8c0 100644
--- a/include/linux/mux/driver.h
+++ b/include/linux/mux/driver.h
@@ -12,6 +12,7 @@
 
 #include <dt-bindings/mux/mux.h>
 #include <linux/device.h>
+#include <linux/ktime.h>
 #include <linux/semaphore.h>
 
 struct mux_chip;
@@ -33,6 +34,7 @@ struct mux_control_ops {
  * @states:		The number of mux controller states.
  * @idle_state:		The mux controller state to use when inactive, or one
  *			of MUX_IDLE_AS_IS and MUX_IDLE_DISCONNECT.
+ * @last_change:	Timestamp of last change
  *
  * Mux drivers may only change @states and @idle_state, and may only do so
  * between allocation and registration of the mux controller. Specifically,
@@ -47,6 +49,8 @@ struct mux_control {
 
 	unsigned int states;
 	int idle_state;
+
+	ktime_t last_change;
 };
 
 /**
-- 
2.28.0

