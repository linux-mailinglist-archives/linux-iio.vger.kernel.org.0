Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F6430B9B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 20:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbhJQS6Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 14:58:16 -0400
Received: from vern.gendns.com ([98.142.107.122]:55906 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhJQS6Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 14:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9PqkJUqJulCDeghcpLaEnGtiSrJltHL41kG/Aty9XQY=; b=jfvXVbktfn2torihkWpnF5Uo4B
        TmTeZ8ZQgaTIX/UJ+wxb1x4OWFtyrfgCV9/jWddw9IUBbqYLTofiDlRKGmNdmXM+sfvNjFSHtMYxD
        SUox1FlQzzmGCZdIZ4HB1E3ULMqEMD++wVvoaxZhBoMNsHdO4SalsXt4RygvgHawmigYj3y4r+FFb
        va7U4AKk+m8c3coqwMqIzR8c0Q5WEwV5AExwCqqq+hUQu03OSmlKyVtbpA2J4uyikMbhMxADdLNvh
        c9Zw1ZlJfC9Fy5eO588z12mQLHAz/CWxo3jp8Cl5NHY8N4YDzFd6DNWhO9lmaGQPe7wzHqT08M3wj
        8aljALng==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60964 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mcBKF-0005I6-IE; Sun, 17 Oct 2021 14:56:04 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] counter: drop chrdev_lock
Date:   Sun, 17 Oct 2021 13:55:21 -0500
Message-Id: <20211017185521.3468640-1-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This removes the chrdev_lock from the counter subsystem. This was
intended to prevent opening the chrdev more than once. However, this
doesn't work in practice since userspace can duplicate file descriptors
and pass file descriptors to other processes. Since this protection
can't be relied on, it is best to just remove it.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/counter-chrdev.c |  6 ------
 drivers/counter/counter-sysfs.c  | 13 +++----------
 include/linux/counter.h          |  7 -------
 3 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 967c94ae95bb..b747dc81cfc6 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -384,10 +384,6 @@ static int counter_chrdev_open(struct inode *inode, struct file *filp)
 							    typeof(*counter),
 							    chrdev);
 
-	/* Ensure chrdev is not opened more than 1 at a time */
-	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
-		return -EBUSY;
-
 	get_device(&counter->dev);
 	filp->private_data = counter;
 
@@ -419,7 +415,6 @@ static int counter_chrdev_release(struct inode *inode, struct file *filp)
 	mutex_unlock(&counter->ops_exist_lock);
 
 	put_device(&counter->dev);
-	atomic_dec(&counter->chrdev_lock);
 
 	return ret;
 }
@@ -445,7 +440,6 @@ int counter_chrdev_add(struct counter_device *const counter)
 	mutex_init(&counter->events_lock);
 
 	/* Initialize character device */
-	atomic_set(&counter->chrdev_lock, 0);
 	cdev_init(&counter->chrdev, &counter_fops);
 
 	/* Allocate Counter events queue */
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 1ccd771da25f..7bf8882ff54d 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -796,25 +796,18 @@ static int counter_events_queue_size_write(struct counter_device *counter,
 					   u64 val)
 {
 	DECLARE_KFIFO_PTR(events, struct counter_event);
-	int err = 0;
-
-	/* Ensure chrdev is not opened more than 1 at a time */
-	if (!atomic_add_unless(&counter->chrdev_lock, 1, 1))
-		return -EBUSY;
+	int err;
 
 	/* Allocate new events queue */
 	err = kfifo_alloc(&events, val, GFP_KERNEL);
 	if (err)
-		goto exit_early;
+		return err;
 
 	/* Swap in new events queue */
 	kfifo_free(&counter->events);
 	counter->events.kfifo = events.kfifo;
 
-exit_early:
-	atomic_dec(&counter->chrdev_lock);
-
-	return err;
+	return 0;
 }
 
 static struct counter_comp counter_num_signals_comp =
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 22b14a552b1d..0fd99e255a50 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -297,7 +297,6 @@ struct counter_ops {
  * @events:		queue of detected Counter events
  * @events_wait:	wait queue to allow blocking reads of Counter events
  * @events_lock:	lock to protect Counter events queue read operations
- * @chrdev_lock:	lock to limit chrdev to a single open at a time
  * @ops_exist_lock:	lock to prevent use during removal
  */
 struct counter_device {
@@ -325,12 +324,6 @@ struct counter_device {
 	DECLARE_KFIFO_PTR(events, struct counter_event);
 	wait_queue_head_t events_wait;
 	struct mutex events_lock;
-	/*
-	 * chrdev_lock is locked by counter_chrdev_open() and unlocked by
-	 * counter_chrdev_release(), so a mutex is not possible here because
-	 * chrdev_lock will invariably be held when returning to user space
-	 */
-	atomic_t chrdev_lock;
 	struct mutex ops_exist_lock;
 };
 
-- 
2.25.1

