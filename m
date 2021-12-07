Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1946C274
	for <lists+linux-iio@lfdr.de>; Tue,  7 Dec 2021 19:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhLGSOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Dec 2021 13:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240457AbhLGSOX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Dec 2021 13:14:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CBEC061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 10:10:52 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muevT-0005QS-4V; Tue, 07 Dec 2021 19:10:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1muevR-003GZI-3v; Tue, 07 Dec 2021 19:10:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1muevP-0004QJ-OO; Tue, 07 Dec 2021 19:10:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH RFC] counter: Expand API with a function for an exact timestamp
Date:   Tue,  7 Dec 2021 19:10:45 +0100
Message-Id: <20211207181045.1246688-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=NlKp1LK5v6xBCY+aNO8ybbv99ZeVpfy/fnmv/YwRJlQ=; m=bcFT8/le/Z563Yj+LzD3tdxG2XjNkioc5qyc9EZfryg=; p=jdEeJY70HJ0askaIZhRPa7rYx3iIbKtzW42Q5kL9YuY=; g=7d4bcac9999d9238c4bfa99bc790dd7b0ed7f359
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGvo6EACgkQwfwUeK3K7AnfgAf/WFN vbI4GEYXCOMjBxgv0jdD07G01mHG4lRfkVyt4Uox+1sKwebEtaPFcHqZ1313ORrCZ61E0tSffMXu+ wnU4pmzOquGg9puFzM6b5t1KqabnKshUMHWK+F2NNXuHsNTj5Ki9145FShLm/Pe/5YtPgbamfcaVI 7OoYLUMWp4ry5Dna9DBX+vix3fp0LoEhoIB9i445ByXJaRtHD4W2GyZJSvFFDvnA1oeUmmV0JrTR0 thjUe1vqHXO8vJlpvebya4gB5Syq+qAGPaoZBxLpKP4aPv77+ctXYw6n+SNWPSpUYzR1M2UmoEi0s inZVufqz8VCjSIXpm49WbN92BfznvSQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some hardware units capture a timestamp for the counted event. To
increase precision add a variant of counter_push_event() that allows
passing this timestamp.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the difficulty is that the captured timer value is in a unit different
from the one provided by ktime_get_ns(). So maybe some helper functions
will be needed to convert the local timer value to a ktime timestamp?

So usage would be something like:

	ktime_now = ktime_get_ns();
	local_now = readl(CNT);
	local_event = readl(...);

	ktime_event = ktime_now - (local_now - local_event) * somefactor >> someshift;

	counter_push_event_ts(count, event, channel, ktime_event);

This improves the precision because irq latency doesn't influence
the resulting timestamp. The precision then only depends on the timer
resolution and the delay between ktime_get_ns() and readl(CNT);

I don't have a driver (yet) that makes use of this, the hardware where
this will matter will be stm32mp1.

Best regards
Uwe

 drivers/counter/counter-chrdev.c | 25 +++++++++++++++++++++----
 include/linux/counter.h          |  2 ++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index b7c62f957a6a..6381f7246d59 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -521,16 +521,17 @@ static int counter_get_data(struct counter_device *const counter,
 }
 
 /**
- * counter_push_event - queue event for userspace reading
+ * counter_push_event_ts - queue event with a timestamp for userspace reading
  * @counter:	pointer to Counter structure
  * @event:	triggered event
  * @channel:	event channel
+ * @timestamp:	the ktime when the event occurred
  *
  * Note: If no one is watching for the respective event, it is silently
  * discarded.
  */
-void counter_push_event(struct counter_device *const counter, const u8 event,
-			const u8 channel)
+void counter_push_event_ts(struct counter_device *const counter, const u8 event,
+			   const u8 channel, u64 timestamp)
 {
 	struct counter_event ev;
 	unsigned int copied = 0;
@@ -538,7 +539,7 @@ void counter_push_event(struct counter_device *const counter, const u8 event,
 	struct counter_event_node *event_node;
 	struct counter_comp_node *comp_node;
 
-	ev.timestamp = ktime_get_ns();
+	ev.timestamp = timestamp;
 	ev.watch.event = event;
 	ev.watch.channel = channel;
 
@@ -570,4 +571,20 @@ void counter_push_event(struct counter_device *const counter, const u8 event,
 	if (copied)
 		wake_up_poll(&counter->events_wait, EPOLLIN);
 }
+EXPORT_SYMBOL_GPL(counter_push_event_ts);
+
+/**
+ * counter_push_event - queue event for userspace reading
+ * @counter:	pointer to Counter structure
+ * @event:	triggered event
+ * @channel:	event channel
+ *
+ * Note: If no one is watching for the respective event, it is silently
+ * discarded.
+ */
+void counter_push_event(struct counter_device *const counter, const u8 event,
+			const u8 channel)
+{
+	counter_push_event_ts(counter, event, channel, ktime_get_ns());
+}
 EXPORT_SYMBOL_GPL(counter_push_event);
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b7d0a00a61cf..596e7e58e463 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -333,6 +333,8 @@ int counter_register(struct counter_device *const counter);
 void counter_unregister(struct counter_device *const counter);
 int devm_counter_register(struct device *dev,
 			  struct counter_device *const counter);
+void counter_push_event_ts(struct counter_device *const counter, const u8 event,
+			   const u8 channel, u64 timestamp)
 void counter_push_event(struct counter_device *const counter, const u8 event,
 			const u8 channel);
 
-- 
2.30.2

