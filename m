Return-Path: <linux-iio+bounces-27212-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE3CD088A
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CB92300D321
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54F34402D;
	Fri, 19 Dec 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOumG+rC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109334321A
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158053; cv=none; b=AzsQZ7Nx1S+zKqz5Vb4UIbJgMb/w/UPwMW2sLC7J3VYP7aEHiiiY6bXouqdfTeYUBPolexpPH7Q2g/ZFvq4VVd3sQMMC5fploU9itoPrkv0IiyVbwO+DPqoFHNX6V1J34mV9wBxHLfpfte1WZFbE197Cz5QJfPFf0krXesVOUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158053; c=relaxed/simple;
	bh=ShfYcJVa9XGU/NxEgQv05/Rc/5X149HntlrvbF8cTY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EI2tTCyBWS8Mph8W7XVc+QLFDDbalSgl4UV8TuYr4gZlF4SDwaOW9kTZipEQV7NETEP+mIPjWVvYt7BrZp9YbJl2zDW7GnpAgFt9Ki9Hrg6anug65nQIM0Wa9zTqbgntg2HOyVW5VdnM6yxUuXVeboneCUSkR8dyZ/PsjHCtxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOumG+rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27EECC19423;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158052;
	bh=ShfYcJVa9XGU/NxEgQv05/Rc/5X149HntlrvbF8cTY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qOumG+rC0yh5ZDfHLh3EEbONrHiU3ZvB0DHBwdKaoyrkXaPAWa62ATVmcTFiC1rLI
	 HWpL4x1xZ0hla45EJ+JAqLZnKqHVK3FFAQdY8CBmXWAy4FrZ8OktNKmrRUH8g7LYVq
	 k+nPXntijxNo/c8qqkPxhtEvVYnZ76MsB3959nbhhVQbDW5paNIPJItOfNmz/Mblaq
	 fWFZk59YLcmbMT8e5fyLNc4Up+2nhOpbUgeLAHdvTYki9cmzU6dDnWLj9g+CiDF8g0
	 /SPATx5Uyro3FWPPWmUxvm0AH/rqVMc7MsNDJZ1QZpuAJO+4fGjywfiXHFKg1tKx8X
	 HMGIa6kjldH6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C7D7878C;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:28:15 +0000
Subject: [PATCH v2 4/6] iio: buffer-dma: Fix coding style complains
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-dmabuf-improvs-v2-4-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158092; l=5574;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=SbxLyWBIRlvzIeqgT6s1t+24wKyNWFZtWl8YsGhyo1E=;
 b=HInAxWVyFqFiEfl2OUHrJc6tWIBO1SG0MjEoglsi18mP9AydwwpOGWHKpZvLnfo25TyjVrMor
 ovfZwTvPDN0CxucQLnsVxRbkyrzrA2aM8kWxT5UBQRGzxKNTgwBAVgm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Just making sure checkpatch is happy. No functional change intended.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 23 ++++++++++-------------
 include/linux/iio/buffer-dma.h               | 16 ++++++++++------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 3ab1349f9ea5..c5ee58effc92 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -169,8 +169,9 @@ static struct iio_dma_buffer_queue *iio_buffer_to_queue(struct iio_buffer *buf)
 	return container_of(buf, struct iio_dma_buffer_queue, buffer);
 }
 
-static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
-	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
+static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(struct iio_dma_buffer_queue *queue,
+							       size_t size,
+							       bool fileio)
 {
 	struct iio_dma_buffer_block *block __free(kfree) =
 			kzalloc(sizeof(*block), GFP_KERNEL);
@@ -254,7 +255,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_block_done, "IIO_DMA_BUFFER");
  * hand the blocks back to the queue.
  */
 void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
-	struct list_head *list)
+				     struct list_head *list)
 {
 	struct iio_dma_buffer_block *block, *_block;
 	bool cookie;
@@ -434,7 +435,7 @@ static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
 }
 
 static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *queue,
-	struct iio_dma_buffer_block *block)
+					struct iio_dma_buffer_block *block)
 {
 	int ret;
 
@@ -478,8 +479,7 @@ static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *queue,
  *
  * This will allocate the DMA buffers and start the DMA transfers.
  */
-int iio_dma_buffer_enable(struct iio_buffer *buffer,
-	struct iio_dev *indio_dev)
+int iio_dma_buffer_enable(struct iio_buffer *buffer, struct iio_dev *indio_dev)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 	struct iio_dma_buffer_block *block, *_block;
@@ -503,8 +503,7 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_enable, "IIO_DMA_BUFFER");
  * Needs to be called when the device that the buffer is attached to stops
  * sampling. Typically should be the iio_buffer_access_ops disable callback.
  */
-int iio_dma_buffer_disable(struct iio_buffer *buffer,
-	struct iio_dev *indio_dev)
+int iio_dma_buffer_disable(struct iio_buffer *buffer, struct iio_dev *indio_dev)
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 
@@ -519,7 +518,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_disable, "IIO_DMA_BUFFER");
 
 static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *queue,
-	struct iio_dma_buffer_block *block)
+				   struct iio_dma_buffer_block *block)
 {
 	if (block->state == IIO_BLOCK_STATE_DEAD) {
 		iio_buffer_block_put(block);
@@ -531,8 +530,7 @@ static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *queue,
 	}
 }
 
-static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
-	struct iio_dma_buffer_queue *queue)
+static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(struct iio_dma_buffer_queue *queue)
 {
 	struct iio_dma_buffer_block *block;
 	unsigned int idx;
@@ -661,8 +659,7 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
 	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
 		block = queue->fileio.blocks[i];
 
-		if (block != queue->fileio.active_block
-		    && block->state == IIO_BLOCK_STATE_DONE)
+		if (block != queue->fileio.active_block && block->state == IIO_BLOCK_STATE_DONE)
 			data_available += block->size;
 	}
 
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 91f678e5be71..f794af0970bd 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -119,7 +119,12 @@ struct iio_dma_buffer_queue {
 	struct device *dev;
 	const struct iio_dma_buffer_ops *ops;
 
+	/*
+	 * A mutex to protect accessing, configuring (eg: enqueuing DMA blocks)
+	 * and do file IO on struct iio_dma_buffer_queue objects.
+	 */
 	struct mutex lock;
+	/* A spin lock to protect adding/removing blocks to the queue list */
 	spinlock_t list_lock;
 	struct list_head incoming;
 
@@ -136,20 +141,19 @@ struct iio_dma_buffer_queue {
  */
 struct iio_dma_buffer_ops {
 	int (*submit)(struct iio_dma_buffer_queue *queue,
-		struct iio_dma_buffer_block *block);
+		      struct iio_dma_buffer_block *block);
 	void (*abort)(struct iio_dma_buffer_queue *queue);
 };
 
 void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block);
 void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
-	struct list_head *list);
+				     struct list_head *list);
 
-int iio_dma_buffer_enable(struct iio_buffer *buffer,
-	struct iio_dev *indio_dev);
+int iio_dma_buffer_enable(struct iio_buffer *buffer, struct iio_dev *indio_dev);
 int iio_dma_buffer_disable(struct iio_buffer *buffer,
-	struct iio_dev *indio_dev);
+			   struct iio_dev *indio_dev);
 int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
-	char __user *user_buffer);
+			char __user *user_buffer);
 int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
 			 const char __user *user_buffer);
 size_t iio_dma_buffer_usage(struct iio_buffer *buffer);

-- 
2.52.0



