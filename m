Return-Path: <linux-iio+bounces-2866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091B585DA55
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 567EDB2772D
	for <lists+linux-iio@lfdr.de>; Wed, 21 Feb 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7093580BFC;
	Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg7nzGwJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2073F80636
	for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522017; cv=none; b=Mm4W2kw522LU2WCtxsqf8qqW9UfNjIT0JdPYUy0GmelEDdkciZSa3yaZX4WrSHE1imEGD4YStqUKm55cPpFsSLvkYFnt8TxvHbQmQ9lbY5DkxOfgZZyyakXT4m6jgZgUm1UCyE8ImJCP6fGk9KydVuZUOLoh2VEQUJ/0UV32c0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522017; c=relaxed/simple;
	bh=Yc2XcApLeQPC5Cga6tipc/diQ/ZcLRFZn/0VaSIsb1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7Rgqt9zBIvtzBDbdNJBat/tHRLAH1R0LFrZ4lewoXs/5U9NRDFBajIMkC+0mxN6hjmeRoUyRwk/IhP7SYcA5/QDJhsneDr4v8uKxeny8xL6b3eLbN4QP5stRrrOSOroLedBvR2SZXdCLP875ikM1P1xSPCL+QbBctje9MOFbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg7nzGwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2A70C4166A;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708522017;
	bh=Yc2XcApLeQPC5Cga6tipc/diQ/ZcLRFZn/0VaSIsb1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jg7nzGwJlUpo/mS6aVpuDak5ePNgbhTzbiV1QIa6y15Q59J2FKZVtgeIn9JaGjRng
	 M5s0czf8KWLm6dBgKqnzo3qF/yi+TIOlmLLyxQ72qEGqZqGrGELqaFpztvj2mTqgjw
	 YfJXKxt0a3DT6XTsIX7l3F6pFxWjWBIXMjOzH0MbYc/RxpbZFfaxTgViP9xyA7FSJt
	 +j3FTROB1R7zf3uEzlbs9BGSxY7khMRP47+YFXE3XHz4MhXx4I0eQ/Dv32vJpJNzT0
	 HMR2DuWTSxWuWtXHnkMQhi9kNf19R5ChqZdVQdN2lKoJYfFBHRl0swV0YYnldg/Dqr
	 efO7VGmdsNJSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD66EC48BF6;
	Wed, 21 Feb 2024 13:26:56 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 Feb 2024 14:26:54 +0100
Subject: [PATCH 3/5] iio: trigger: move to the cleanup.h magic
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-iio-use-cleanup-magic-v1-3-f9c292666f26@analog.com>
References: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
In-Reply-To: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708522015; l=4771;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=liY2EgfcCQ+fpoavlXKSBy+HXdnNNmUtRsNu6mNFlMM=;
 b=kGjgu+Ha0hngNoNYLFpmLW15vdywV7m+D0W/U7W7+aZ5U1sXH8DpNbG8xK0a+aJungKwaR8Vi
 UnTGE+nNcqhB36Z9taEQkiN2b/LZ1s1fVsw8d91IwkFI+ecRI3qV7bs
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
 drivers/iio/industrialio-trigger.c | 64 ++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 18f83158f637..e4f0802fdd1d 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2008 Jonathan Cameron
  */
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/idr.h>
 #include <linux/err.h>
@@ -80,19 +81,18 @@ int iio_trigger_register(struct iio_trigger *trig_info)
 		goto error_unregister_id;
 
 	/* Add to list of available triggers held by the IIO core */
-	mutex_lock(&iio_trigger_list_lock);
-	if (__iio_trigger_find_by_name(trig_info->name)) {
-		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
-		ret = -EEXIST;
-		goto error_device_del;
+	scoped_guard(mutex, &iio_trigger_list_lock) {
+		if (__iio_trigger_find_by_name(trig_info->name)) {
+			pr_err("Duplicate trigger name '%s'\n", trig_info->name);
+			ret =  -EEXIST;
+			goto error_device_del;
+		}
+		list_add_tail(&trig_info->list, &iio_trigger_list);
 	}
-	list_add_tail(&trig_info->list, &iio_trigger_list);
-	mutex_unlock(&iio_trigger_list_lock);
 
 	return 0;
 
 error_device_del:
-	mutex_unlock(&iio_trigger_list_lock);
 	device_del(&trig_info->dev);
 error_unregister_id:
 	ida_free(&iio_trigger_ida, trig_info->id);
@@ -102,9 +102,8 @@ EXPORT_SYMBOL(iio_trigger_register);
 
 void iio_trigger_unregister(struct iio_trigger *trig_info)
 {
-	mutex_lock(&iio_trigger_list_lock);
-	list_del(&trig_info->list);
-	mutex_unlock(&iio_trigger_list_lock);
+	scoped_guard(mutex, &iio_trigger_list_lock)
+		list_del(&trig_info->list);
 
 	ida_free(&iio_trigger_ida, trig_info->id);
 	/* Possible issue in here */
@@ -120,12 +119,11 @@ int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *tri
 		return -EINVAL;
 
 	iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	mutex_lock(&iio_dev_opaque->mlock);
+	guard(mutex)(&iio_dev_opaque->mlock);
 	WARN_ON(iio_dev_opaque->trig_readonly);
 
 	indio_dev->trig = iio_trigger_get(trig);
 	iio_dev_opaque->trig_readonly = true;
-	mutex_unlock(&iio_dev_opaque->mlock);
 
 	return 0;
 }
@@ -145,18 +143,14 @@ static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
 
 static struct iio_trigger *iio_trigger_acquire_by_name(const char *name)
 {
-	struct iio_trigger *trig = NULL, *iter;
+	struct iio_trigger *iter;
 
-	mutex_lock(&iio_trigger_list_lock);
+	guard(mutex)(&iio_trigger_list_lock);
 	list_for_each_entry(iter, &iio_trigger_list, list)
-		if (sysfs_streq(iter->name, name)) {
-			trig = iter;
-			iio_trigger_get(trig);
-			break;
-		}
-	mutex_unlock(&iio_trigger_list_lock);
+		if (sysfs_streq(iter->name, name))
+			return iio_trigger_get(iter);
 
-	return trig;
+	return NULL;
 }
 
 static void iio_reenable_work_fn(struct work_struct *work)
@@ -259,11 +253,10 @@ static int iio_trigger_get_irq(struct iio_trigger *trig)
 {
 	int ret;
 
-	mutex_lock(&trig->pool_lock);
-	ret = bitmap_find_free_region(trig->pool,
-				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
-				      ilog2(1));
-	mutex_unlock(&trig->pool_lock);
+	scoped_guard(mutex, &trig->pool_lock)
+		ret = bitmap_find_free_region(trig->pool,
+					      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
+					      ilog2(1));
 	if (ret >= 0)
 		ret += trig->subirq_base;
 
@@ -272,9 +265,8 @@ static int iio_trigger_get_irq(struct iio_trigger *trig)
 
 static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
 {
-	mutex_lock(&trig->pool_lock);
+	guard(mutex)(&trig->pool_lock);
 	clear_bit(irq - trig->subirq_base, trig->pool);
-	mutex_unlock(&trig->pool_lock);
 }
 
 /* Complexity in here.  With certain triggers (datardy) an acknowledgement
@@ -451,16 +443,12 @@ static ssize_t current_trigger_store(struct device *dev,
 	struct iio_trigger *trig;
 	int ret;
 
-	mutex_lock(&iio_dev_opaque->mlock);
-	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
-		mutex_unlock(&iio_dev_opaque->mlock);
-		return -EBUSY;
+	scoped_guard(mutex, &iio_dev_opaque->mlock) {
+		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
+			return -EBUSY;
+		if (iio_dev_opaque->trig_readonly)
+			return -EPERM;
 	}
-	if (iio_dev_opaque->trig_readonly) {
-		mutex_unlock(&iio_dev_opaque->mlock);
-		return -EPERM;
-	}
-	mutex_unlock(&iio_dev_opaque->mlock);
 
 	trig = iio_trigger_acquire_by_name(buf);
 	if (oldtrig == trig) {

-- 
2.43.0


