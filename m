Return-Path: <linux-iio+bounces-2868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E585DA53
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 14:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A571C20ECD
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099580BFD;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5inKxLp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEC80BED
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522017; cv=none; b=CeV7shKPeSvo/cbxIWUOmaF4Y0IQfiDH6OcVOMLiZLDh8ijRStpLjSpKebMXvzFis2243hNH20rz6e2bQsXIEHTIRYeHAR70ZkKQbDg8nAe83niL7xt3wY+wSQ6gzlkO08DnUxKcusZIFsp0bjHNNfQM4RycWgCKCY9Zav7ugjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522017; c=relaxed/simple;
	bh=ECng3VSIMsYDL8aS60+QSvrXSymf9admElA86qKGDS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5+YkVRL9B7Hh19jOvU6jf7VIzGDznA6fBINO0rDsOQBCgC8+o/QB3JnLLn/H756QuyilA9ZxfpQ5Lx81l50hVWXpxfX6Lfi6aA1yoQbtOxwvF3GWRsQ3i4qrbPl4lHVP0DKN0LETGtnc/phgd167w/5YCTFvquZ035E/VELnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5inKxLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDB7CC43142;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522016;
	bh=ECng3VSIMsYDL8aS60+QSvrXSymf9admElA86qKGDS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W5inKxLpxZhomwDPYW52a9jWdRSeb9dfubNaJ1BrCImyX3gFsjW9OBx3ye3HUCWmZ
	 izLJrQQlqWiTtt2XbGMlMTmPUV1HJOg3xOR5FbXMN3VPaXK6oy4AzVefhQ20+FPXdg
	 r5dM3X+rvfxBH4RAvh7SgCFS7MEZVTKEmn/uYqPANo6B2amfoP8Wx615uCBIE8AIby
	 azCYbiHMw8ce5atg4rJ3fKAI569DJsRjyDxLqRUaS3HlmvtBmOTRw5C8KhEaceaK6k
	 6oa9wzyqT9pg7dHY5HEQw++uqXBy1WT93bQ8C0RjQHQd3DI4PHpTsAdn1iS0DwtLVc
	 ZN8N5yYCT6uLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD6C54788;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 Feb 2024 14:26:52 +0100
Subject: [PATCH 1/5] iio: core: move to cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-iio-use-cleanup-magic-v1-1-f9c292666f26@analog.com>
References: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
In-Reply-To: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708522015; l=3677;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WddubecxlqcyyhVh2mUw5FZVx2FoerYmAw/tQVz73zs=;
 b=WLgx2GUMCc5Wk5e8wIFDH5xyqW+5a4fp7NRA19EIZyL6qxrF9LHQop1+gAeTbgUEqL5M+RlQu
 6/vPEJA7rmZCyPFXsJomveMyiemCa8z03FijT5YUrKj17KuCdlYQCzS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Note that we keep the plain mutex calls in the
iio_device_release|acquire() APIs since in there the macros would likely
not help much (as we want to keep the lock acquired when he leave the
APIs).

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 52 +++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9b2877fe8689..7e6497828364 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -11,6 +11,7 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -268,20 +269,16 @@ EXPORT_SYMBOL(iio_read_const_attr);
  */
 int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 {
-	int ret;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	const struct iio_event_interface *ev_int = iio_dev_opaque->event_interface;
 
-	ret = mutex_lock_interruptible(&iio_dev_opaque->mlock);
-	if (ret)
-		return ret;
-	if ((ev_int && iio_event_enabled(ev_int)) ||
-	    iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&iio_dev_opaque->mlock);
-		return -EBUSY;
+	scoped_cond_guard(mutex_intr, return -EINTR, &iio_dev_opaque->mlock) {
+		if ((ev_int && iio_event_enabled(ev_int)) ||
+		    iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		iio_dev_opaque->clock_id = clock_id;
 	}
-	iio_dev_opaque->clock_id = clock_id;
-	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return 0;
 }
@@ -1806,31 +1803,22 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct iio_dev *indio_dev = ib->indio_dev;
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	struct iio_ioctl_handler *h;
-	int ret = -ENODEV;
-
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
 
+	guard(mutex)(&iio_dev_opaque->info_exist_lock);
 	/*
 	 * The NULL check here is required to prevent crashing when a device
 	 * is being removed while userspace would still have open file handles
 	 * to try to access this device.
 	 */
 	if (!indio_dev->info)
-		goto out_unlock;
+		return -ENODEV;
 
 	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
-		ret = h->ioctl(indio_dev, filp, cmd, arg);
-		if (ret != IIO_IOCTL_UNHANDLED)
-			break;
+		if (h->ioctl(indio_dev, filp, cmd, arg) != IIO_IOCTL_UNHANDLED)
+			return 0;
 	}
 
-	if (ret == IIO_IOCTL_UNHANDLED)
-		ret = -ENODEV;
-
-out_unlock:
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-
-	return ret;
+	return -ENODEV;
 }
 
 static const struct file_operations iio_buffer_fileops = {
@@ -2058,18 +2046,16 @@ void iio_device_unregister(struct iio_dev *indio_dev)
 
 	cdev_device_del(&iio_dev_opaque->chrdev, &indio_dev->dev);
 
-	mutex_lock(&iio_dev_opaque->info_exist_lock);
+	scoped_guard(mutex, &iio_dev_opaque->info_exist_lock) {
+		iio_device_unregister_debugfs(indio_dev);
 
-	iio_device_unregister_debugfs(indio_dev);
+		iio_disable_all_buffers(indio_dev);
 
-	iio_disable_all_buffers(indio_dev);
+		indio_dev->info = NULL;
 
-	indio_dev->info = NULL;
-
-	iio_device_wakeup_eventset(indio_dev);
-	iio_buffer_wakeup_poll(indio_dev);
-
-	mutex_unlock(&iio_dev_opaque->info_exist_lock);
+		iio_device_wakeup_eventset(indio_dev);
+		iio_buffer_wakeup_poll(indio_dev);
+	}
 
 	iio_buffers_free_sysfs_and_mask(indio_dev);
 }

-- 
2.43.0


