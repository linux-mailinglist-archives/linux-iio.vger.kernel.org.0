Return-Path: <linux-iio+bounces-27213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829DCD08B7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 16:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60B8530A92AF
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1016343D6F;
	Fri, 19 Dec 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJUH9/t/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DC342532
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158053; cv=none; b=Joocrn2KOZU6s+S/xacapXannryb8T85yoBHdcgqLR8qdkW/eXyDdaodja903vxis/LNzBAXGMeYngqoCLGYkyfaFEmwna/9pZK3LYlGwCO2H5W33V6m4R/mRBPLDD3tLGpxzu+sRH0njIXXHPmNnTcg36vedofjvFWbJgpCFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158053; c=relaxed/simple;
	bh=+isVgXa0n1sUKveMH5iXcdJbnPoNlSoxUT5cP8o5CWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgvpJjd9I960QfNOKUTBIwMOZkfqVNh8tidYnfe6MRidBuyrp2BWkmp2bygNZoKxjUTosGK2C2EyK0VZvM+oh8YsGyHU2x4heJNi4EFwumAvCiDSN96jAB0uGKPi5K6LgpN+lkm0sLm7NPnCkVH7KhgjCztwYHSNabnqiIvJ0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJUH9/t/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12A34C113D0;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766158052;
	bh=+isVgXa0n1sUKveMH5iXcdJbnPoNlSoxUT5cP8o5CWQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gJUH9/t/e5Phi4m8qU4L+yRFc9CiIgQUxLFiJSoxpFa5D9IAsG+IIcy5HvCzs+wsK
	 2U6smsWMprWLvqHkDBwaKu40F/INp/64Ex+4hICIfYTrMZR45MIxxyL2cFl/J3Avkp
	 5t+G0jb3QmYvCUj7sm7W70++F5idouW77gucQFU1ogXn6/Red6t8i30k0DFuryb0gu
	 UmPOHXLMwHklEbS+QwqCWxdx3aeQq95bEwg6RbSRT6uZ1F/j0UlhVqugUVDJDINWgY
	 rAvblLyjyrksyvXXgJ7gK7+MXfOqzeUcb+Zy/ORm7SEQYEOgkuxPLEdM3e6dhRIcFB
	 5aldabi/VaYRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F83D7878B;
	Fri, 19 Dec 2025 15:27:32 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Dec 2025 15:28:13 +0000
Subject: [PATCH v2 2/6] iio: buffer-dma: Use the cleanup.h API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251219-iio-dmabuf-improvs-v2-2-caa76de6e873@analog.com>
References: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
In-Reply-To: <20251219-iio-dmabuf-improvs-v2-0-caa76de6e873@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766158092; l=11413;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=l7KVg87YqMPHP8B26bzo5Q2CZWGho1a8gRwmAEA0hgE=;
 b=KJf0pV1EntiCf4aU8y98ol0RA2TQjIPHk2taJEGM5iK0cdd9fPVIaCjP4UiYJCckYnYO63XOR
 TuT0DxucbAeCytW14OEgDcfuG91U8y0m0f6mmekeL7F96AoSw/d5P7h
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make use of the cleanup.h API for locks and memory allocation in order
to simplify some code paths.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 155 +++++++++++----------------
 1 file changed, 62 insertions(+), 93 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 617b2d550c2f..1f918a3e6b93 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -136,9 +136,8 @@ static void iio_dma_buffer_cleanup_worker(struct work_struct *work)
 	struct iio_dma_buffer_block *block, *_block;
 	LIST_HEAD(block_list);
 
-	spin_lock_irq(&iio_dma_buffer_dead_blocks_lock);
-	list_splice_tail_init(&iio_dma_buffer_dead_blocks, &block_list);
-	spin_unlock_irq(&iio_dma_buffer_dead_blocks_lock);
+	scoped_guard(spinlock_irq, &iio_dma_buffer_dead_blocks_lock)
+		list_splice_tail_init(&iio_dma_buffer_dead_blocks, &block_list);
 
 	list_for_each_entry_safe(block, _block, &block_list, head)
 		iio_buffer_block_release(&block->kref);
@@ -148,13 +147,11 @@ static DECLARE_WORK(iio_dma_buffer_cleanup_work, iio_dma_buffer_cleanup_worker);
 static void iio_buffer_block_release_atomic(struct kref *kref)
 {
 	struct iio_dma_buffer_block *block;
-	unsigned long flags;
 
 	block = container_of(kref, struct iio_dma_buffer_block, kref);
 
-	spin_lock_irqsave(&iio_dma_buffer_dead_blocks_lock, flags);
-	list_add_tail(&block->head, &iio_dma_buffer_dead_blocks);
-	spin_unlock_irqrestore(&iio_dma_buffer_dead_blocks_lock, flags);
+	scoped_guard(spinlock_irqsave, &iio_dma_buffer_dead_blocks_lock)
+		list_add_tail(&block->head, &iio_dma_buffer_dead_blocks);
 
 	schedule_work(&iio_dma_buffer_cleanup_work);
 }
@@ -175,19 +172,16 @@ static struct iio_dma_buffer_queue *iio_buffer_to_queue(struct iio_buffer *buf)
 static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
 	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
 {
-	struct iio_dma_buffer_block *block;
-
-	block = kzalloc(sizeof(*block), GFP_KERNEL);
+	struct iio_dma_buffer_block *block __free(kfree) =
+			kzalloc(sizeof(*block), GFP_KERNEL);
 	if (!block)
 		return NULL;
 
 	if (fileio) {
 		block->vaddr = dma_alloc_coherent(queue->dev, PAGE_ALIGN(size),
 						  &block->phys_addr, GFP_KERNEL);
-		if (!block->vaddr) {
-			kfree(block);
+		if (!block->vaddr)
 			return NULL;
-		}
 	}
 
 	block->fileio = fileio;
@@ -202,7 +196,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
 	if (!fileio)
 		atomic_inc(&queue->num_dmabufs);
 
-	return block;
+	return_ptr(block);
 }
 
 static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
@@ -233,14 +227,12 @@ static void iio_dma_buffer_queue_wake(struct iio_dma_buffer_queue *queue)
 void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
 {
 	struct iio_dma_buffer_queue *queue = block->queue;
-	unsigned long flags;
 	bool cookie;
 
 	cookie = dma_fence_begin_signalling();
 
-	spin_lock_irqsave(&queue->list_lock, flags);
-	_iio_dma_buffer_block_done(block);
-	spin_unlock_irqrestore(&queue->list_lock, flags);
+	scoped_guard(spinlock_irqsave, &queue->list_lock)
+		_iio_dma_buffer_block_done(block);
 
 	if (!block->fileio)
 		iio_buffer_signal_dmabuf_done(block->fence, 0);
@@ -265,22 +257,22 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
 	struct list_head *list)
 {
 	struct iio_dma_buffer_block *block, *_block;
-	unsigned long flags;
 	bool cookie;
 
 	cookie = dma_fence_begin_signalling();
 
-	spin_lock_irqsave(&queue->list_lock, flags);
-	list_for_each_entry_safe(block, _block, list, head) {
-		list_del(&block->head);
-		block->bytes_used = 0;
-		_iio_dma_buffer_block_done(block);
+	scoped_guard(spinlock_irqsave, &queue->list_lock) {
+		list_for_each_entry_safe(block, _block, list, head) {
+			list_del(&block->head);
+			block->bytes_used = 0;
+			_iio_dma_buffer_block_done(block);
 
-		if (!block->fileio)
-			iio_buffer_signal_dmabuf_done(block->fence, -EINTR);
-		iio_buffer_block_put_atomic(block);
+			if (!block->fileio)
+				iio_buffer_signal_dmabuf_done(block->fence,
+							      -EINTR);
+			iio_buffer_block_put_atomic(block);
+		}
 	}
-	spin_unlock_irqrestore(&queue->list_lock, flags);
 
 	if (queue->fileio.enabled)
 		queue->fileio.enabled = false;
@@ -329,7 +321,6 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 	struct iio_dma_buffer_block *block;
 	bool try_reuse = false;
 	size_t size;
-	int ret = 0;
 	int i;
 
 	/*
@@ -340,13 +331,13 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 	size = DIV_ROUND_UP(queue->buffer.bytes_per_datum *
 		queue->buffer.length, 2);
 
-	mutex_lock(&queue->lock);
+	guard(mutex)(&queue->lock);
 
 	queue->fileio.enabled = iio_dma_buffer_can_use_fileio(queue);
 
 	/* If DMABUFs were created, disable fileio interface */
 	if (!queue->fileio.enabled)
-		goto out_unlock;
+		return 0;
 
 	/* Allocations are page aligned */
 	if (PAGE_ALIGN(queue->fileio.block_size) == PAGE_ALIGN(size))
@@ -355,22 +346,22 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 	queue->fileio.block_size = size;
 	queue->fileio.active_block = NULL;
 
-	spin_lock_irq(&queue->list_lock);
-	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
-		block = queue->fileio.blocks[i];
+	scoped_guard(spinlock_irq, &queue->list_lock) {
+		for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
+			block = queue->fileio.blocks[i];
 
-		/* If we can't re-use it free it */
-		if (block && (!iio_dma_block_reusable(block) || !try_reuse))
-			block->state = IIO_BLOCK_STATE_DEAD;
+			/* If we can't re-use it free it */
+			if (block && (!iio_dma_block_reusable(block) || !try_reuse))
+				block->state = IIO_BLOCK_STATE_DEAD;
+		}
+
+		/*
+		 * At this point all blocks are either owned by the core or
+		 * marked as dead. This means we can reset the lists without
+		 * having to fear corruption.
+		 */
 	}
 
-	/*
-	 * At this point all blocks are either owned by the core or marked as
-	 * dead. This means we can reset the lists without having to fear
-	 * corrution.
-	 */
-	spin_unlock_irq(&queue->list_lock);
-
 	INIT_LIST_HEAD(&queue->incoming);
 
 	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
@@ -389,10 +380,9 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 
 		if (!block) {
 			block = iio_dma_buffer_alloc_block(queue, size, true);
-			if (!block) {
-				ret = -ENOMEM;
-				goto out_unlock;
-			}
+			if (!block)
+				return -ENOMEM;
+
 			queue->fileio.blocks[i] = block;
 		}
 
@@ -416,10 +406,7 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 		}
 	}
 
-out_unlock:
-	mutex_unlock(&queue->lock);
-
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_request_update, "IIO_DMA_BUFFER");
 
@@ -427,13 +414,13 @@ static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
 {
 	unsigned int i;
 
-	spin_lock_irq(&queue->list_lock);
-	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
-		if (!queue->fileio.blocks[i])
-			continue;
-		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
+	scoped_guard(spinlock_irq, &queue->list_lock) {
+		for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
+			if (!queue->fileio.blocks[i])
+				continue;
+			queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
+		}
 	}
-	spin_unlock_irq(&queue->list_lock);
 
 	INIT_LIST_HEAD(&queue->incoming);
 
@@ -497,13 +484,12 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 	struct iio_dma_buffer_block *block, *_block;
 
-	mutex_lock(&queue->lock);
+	guard(mutex)(&queue->lock);
 	queue->active = true;
 	list_for_each_entry_safe(block, _block, &queue->incoming, head) {
 		list_del(&block->head);
 		iio_dma_buffer_submit_block(queue, block);
 	}
-	mutex_unlock(&queue->lock);
 
 	return 0;
 }
@@ -522,12 +508,11 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 {
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 
-	mutex_lock(&queue->lock);
+	guard(mutex)(&queue->lock);
 	queue->active = false;
 
 	if (queue->ops && queue->ops->abort)
 		queue->ops->abort(queue);
-	mutex_unlock(&queue->lock);
 
 	return 0;
 }
@@ -552,19 +537,16 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
 	struct iio_dma_buffer_block *block;
 	unsigned int idx;
 
-	spin_lock_irq(&queue->list_lock);
+	guard(spinlock_irq)(&queue->list_lock);
 
 	idx = queue->fileio.next_dequeue;
 	block = queue->fileio.blocks[idx];
 
-	if (block->state == IIO_BLOCK_STATE_DONE) {
-		idx = (idx + 1) % ARRAY_SIZE(queue->fileio.blocks);
-		queue->fileio.next_dequeue = idx;
-	} else {
-		block = NULL;
-	}
+	if (block->state != IIO_BLOCK_STATE_DONE)
+		return NULL;
 
-	spin_unlock_irq(&queue->list_lock);
+	idx = (idx + 1) % ARRAY_SIZE(queue->fileio.blocks);
+	queue->fileio.next_dequeue = idx;
 
 	return block;
 }
@@ -580,14 +562,13 @@ static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
 	if (n < buffer->bytes_per_datum)
 		return -EINVAL;
 
-	mutex_lock(&queue->lock);
+	guard(mutex)(&queue->lock);
 
 	if (!queue->fileio.active_block) {
 		block = iio_dma_buffer_dequeue(queue);
-		if (block == NULL) {
-			ret = 0;
-			goto out_unlock;
-		}
+		if (!block)
+			return 0;
+
 		queue->fileio.pos = 0;
 		queue->fileio.active_block = block;
 	} else {
@@ -603,10 +584,8 @@ static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
 		ret = copy_from_user(addr, user_buffer, n);
 	else
 		ret = copy_to_user(user_buffer, addr, n);
-	if (ret) {
-		ret = -EFAULT;
-		goto out_unlock;
-	}
+	if (ret)
+		return -EFAULT;
 
 	queue->fileio.pos += n;
 
@@ -615,12 +594,7 @@ static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
 		iio_dma_buffer_enqueue(queue, block);
 	}
 
-	ret = n;
-
-out_unlock:
-	mutex_unlock(&queue->lock);
-
-	return ret;
+	return n;
 }
 
 /**
@@ -678,11 +652,11 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
 	 * but won't increase since all blocks are in use.
 	 */
 
-	mutex_lock(&queue->lock);
+	guard(mutex)(&queue->lock);
 	if (queue->fileio.active_block)
 		data_available += queue->fileio.active_block->size;
 
-	spin_lock_irq(&queue->list_lock);
+	guard(spinlock_irq)(&queue->list_lock);
 
 	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
 		block = queue->fileio.blocks[i];
@@ -692,9 +666,6 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
 			data_available += block->size;
 	}
 
-	spin_unlock_irq(&queue->list_lock);
-	mutex_unlock(&queue->lock);
-
 	return data_available;
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_usage, "IIO_DMA_BUFFER");
@@ -876,12 +847,10 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_init, "IIO_DMA_BUFFER");
  */
 void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
 {
-	mutex_lock(&queue->lock);
+	guard(mutex)(&queue->lock);
 
 	iio_dma_buffer_fileio_free(queue);
 	queue->ops = NULL;
-
-	mutex_unlock(&queue->lock);
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_exit, "IIO_DMA_BUFFER");
 

-- 
2.52.0



