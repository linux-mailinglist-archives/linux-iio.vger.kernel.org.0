Return-Path: <linux-iio+bounces-2867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E03F85DA54
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 14:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4567B1C20BE8
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D780BFE;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4rM3sJk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077B80BE0
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522017; cv=none; b=oxRQBUaM/rWpd5ljrEqy1FwDTzZ8DnBM4NeVvspEmrVobgc7Qt1jb9dNadRwr8utMPKWBv/UzAHfsnHIiw+vSM9Ji6bMCN3dxj1EA2ijZXGuN+N/f9EiTzarB9d5ttv6qfESxULcNtvvihwG+NhpOfiWJBV1yiG9/sKdvPtqMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522017; c=relaxed/simple;
	bh=UkqKTeGUUut2j8HvehZKu/bEd0NKNp+XBY6NKpU9vIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YX1Qf59ztVfxrVOInYxX8D79T/OAzHFbZ+DOHv8DkB7A06Vx3G1ITHdB/odQf+qZY5K5Pn+rJ6Uo5kT4D6argy6evZHdR8xdMFgvN0DFjVozUAcC9l7M0rpoulYcMiV3Gp4qCBiB8uM3rHTYCOpxLxEw03qUgKBQzoptuALfJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4rM3sJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8237C43143;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522016;
	bh=UkqKTeGUUut2j8HvehZKu/bEd0NKNp+XBY6NKpU9vIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q4rM3sJk6frmIyqp89M4NARqrGtb2LbSy36fyvgEOB77mw2Wogd+3xsdOPZSU8r9D
	 CGoQfwyjrOM5oO0vxwnUR6zBbLcOs58vv/I9zTsUls4Ldr4BV2mYQq5dnF2LS/0B3Z
	 rqcmBhIBCPE+aLqfAHvhHZrZYvA0k4qOYAWSSPEl0Xt0npuPI+/3XndEEGqoCWFDOa
	 /2LNXzQ3RLIk6TpJmnH+nw5jvKDzV7Q/vIPTuW4ZA8g/hGRDUT1MXXxay8+6t6Loki
	 g0y9peEhqz5nAGA9V2PYgV7OHk9BdJL82uks2+VUJn06T5lo4OPrJmvTelvx7R9/pK
	 srl2bsa1jFxAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF78BC5478A;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 Feb 2024 14:26:53 +0100
Subject: [PATCH 2/5] iio: events: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-iio-use-cleanup-magic-v1-2-f9c292666f26@analog.com>
References: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
In-Reply-To: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708522015; l=2320;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ar4mjNbR1mkb3YDznQ99CF7o8RhZbjmjysmAiRM0D9s=;
 b=lhOpOc2oWqZWuKulvYHKNGnXpwEt0gEmEcdIqM7tzLpXSPwihJcyh8Fkbs8gkrd2f8FB5cWNW
 vSJyYUhoKPgDk//D4N6uTeRk3VlrS+yBDuIbue7IH/9l0xX4cVUvIfF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Use the new cleanup magic for handling mutexes in IIO. This allows us to
greatly simplify some code paths.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-event.c | 42 +++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 910c1f14abd5..ef3cecbce915 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -146,11 +147,10 @@ static ssize_t iio_event_chrdev_read(struct file *filep,
 				return -ENODEV;
 		}
 
-		if (mutex_lock_interruptible(&ev_int->read_lock))
-			return -ERESTARTSYS;
-		ret = kfifo_to_user(&ev_int->det_events, buf, count, &copied);
-		mutex_unlock(&ev_int->read_lock);
-
+		scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
+				  &ev_int->read_lock)
+			ret = kfifo_to_user(&ev_int->det_events, buf, count,
+					    &copied);
 		if (ret)
 			return ret;
 
@@ -198,28 +198,22 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 	if (ev_int == NULL)
 		return -ENODEV;
 
-	fd = mutex_lock_interruptible(&iio_dev_opaque->mlock);
-	if (fd)
-		return fd;
+	scoped_cond_guard(mutex_intr, return -EINTR, &iio_dev_opaque->mlock) {
+		if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags))
+			return -EBUSY;
 
-	if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
-		fd = -EBUSY;
-		goto unlock;
+		iio_device_get(indio_dev);
+
+		fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
+				      indio_dev, O_RDONLY | O_CLOEXEC);
+		if (fd < 0) {
+			clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
+			iio_device_put(indio_dev);
+		} else {
+			kfifo_reset_out(&ev_int->det_events);
+		}
 	}
 
-	iio_device_get(indio_dev);
-
-	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
-				indio_dev, O_RDONLY | O_CLOEXEC);
-	if (fd < 0) {
-		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
-		iio_device_put(indio_dev);
-	} else {
-		kfifo_reset_out(&ev_int->det_events);
-	}
-
-unlock:
-	mutex_unlock(&iio_dev_opaque->mlock);
 	return fd;
 }
 

-- 
2.43.0


