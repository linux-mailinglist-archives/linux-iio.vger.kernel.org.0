Return-Path: <linux-iio+bounces-26684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D9C9F72B
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A9583061163
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 15:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24056326945;
	Wed,  3 Dec 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9GmeyUu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676B32571F
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774657; cv=none; b=ZxY/SlZMJqX346JI6zTHhtCATKVS/Igzcmc3KDaDnSC6CeJKIwV25FPnME4YkXDkeBf1KoFBoTUbVFfaTtZ3hI6RUCWn3VJYwHUdxoGqZzVafrkw6vqzZmL2HUccIRQI+5HKCob52gyRwhmO1iSoFGrcZgNTxZVYGAQOfiBOZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774657; c=relaxed/simple;
	bh=kcIAIdAnl5ojXSA2kg0uIVNwPz6Xstx/LzVqxpp+o0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjB6MOWzXQURHsl9KFIxfoTNC0eG45UXa+R+J32OCmaen/21FE7rMYb7yFee4NLb3DXT5IGHkLW/z7FH2PcEtVbxwUUApsECBdi+MLxY5D0vovocgH8tv7h/A9gkY/66Hz5nK7gupJwppIx/AQAH2m0c2QVUd/NA2g6iGq99130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9GmeyUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FB60C4AF09;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764774657;
	bh=kcIAIdAnl5ojXSA2kg0uIVNwPz6Xstx/LzVqxpp+o0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b9GmeyUuksLN1ZYJbVGU+F8MzAfa0AZ4WRf63ElQEu99Gd/yEKfYqtYrqhzDJ42NG
	 k42KBamAxI/HvriA3JIqUhAG9i4ORjYBTNvVYs/WZ9HxzlQSwDDoGbiWMxIs1Tiqh1
	 7uoa1QUH/x5CdEHKGqAYTkhf38/yr6PSk0kI0UewFSYu+tuqnkUCYRKa1FX8EyzXyp
	 I97nrZbcsNYJ0Gj7rTah77FPVl4qw0rajpVmvOQMZb7zxwugnnwzzKf3wA5NfhOSRZ
	 5WKxSFPBO/8ptN9f49Wc4I49pGggu8ge2oVFpkYiLko6ZqJF6ErLXCwW43+tA+Ljxo
	 yEpjpX6SozWvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B3ED12D7A;
	Wed,  3 Dec 2025 15:10:57 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 03 Dec 2025 15:11:37 +0000
Subject: [PATCH 2/6] iio: buffer-dma: Use the cleanup.h API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251203-iio-dmabuf-improvs-v1-2-0e4907ce7322@analog.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
In-Reply-To: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764774697; l=11408;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XIu9IP8lNh5fxa8qeg+4VkhKSEUOhNwaiCQyKRn6qjw=;
 b=VD2s810M5oA1NcTB22st1mHRYF424KQytIOw6NdbQixm2DCVprjfdYBVuSp7A0qgcpgKkrF5Y
 b+4ydoctZR2Bh3mHwQRyjDj16Mr8/vbzg9iOVFDonDWMfN+gCqsjWR4
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
 drivers/iio/buffer/industrialio-buffer-dma.c | 154 +++++++++++----------------
 1 file changed, 61 insertions(+), 93 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 617b2d550c2f..026b42552a0a 100644
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
@@ -175,19 +172,15 @@ static struct iio_dma_buffer_queue *iio_buffer_to_queue(struct iio_buffer *buf)
 static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
 	struct iio_dma_buffer_queue *queue, size_t size, bool fileio)
 {
-	struct iio_dma_buffer_block *block;
-
-	block = kzalloc(sizeof(*block), GFP_KERNEL);
+	struct iio_dma_buffer_block *block __free(kfree) = kzalloc(sizeof(*block), GFP_KERNEL);
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
@@ -202,7 +195,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
 	if (!fileio)
 		atomic_inc(&queue->num_dmabufs);
 
-	return block;
+	return_ptr(block);
 }
 
 static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
@@ -233,14 +226,12 @@ static void iio_dma_buffer_queue_wake(struct iio_dma_buffer_queue *queue)
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
@@ -265,22 +256,22 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
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
@@ -329,7 +320,6 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 	struct iio_dma_buffer_block *block;
 	bool try_reuse = false;
 	size_t size;
-	int ret = 0;
 	int i;
 
 	/*
@@ -340,13 +330,13 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
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
@@ -355,22 +345,22 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
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
@@ -389,10 +379,9 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 
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
 
@@ -416,10 +405,7 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 		}
 	}
 
-out_unlock:
-	mutex_unlock(&queue->lock);
-
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_request_update, "IIO_DMA_BUFFER");
 
@@ -427,13 +413,13 @@ static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
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
 
@@ -497,13 +483,12 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
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
@@ -522,12 +507,11 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
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
@@ -552,19 +536,16 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
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
@@ -580,14 +561,13 @@ static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
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
@@ -603,10 +583,8 @@ static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
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
 
@@ -615,12 +593,7 @@ static int iio_dma_buffer_io(struct iio_buffer *buffer, size_t n,
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
@@ -678,11 +651,11 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
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
@@ -692,9 +665,6 @@ size_t iio_dma_buffer_usage(struct iio_buffer *buf)
 			data_available += block->size;
 	}
 
-	spin_unlock_irq(&queue->list_lock);
-	mutex_unlock(&queue->lock);
-
 	return data_available;
 }
 EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_usage, "IIO_DMA_BUFFER");
@@ -876,12 +846,10 @@ EXPORT_SYMBOL_NS_GPL(iio_dma_buffer_init, "IIO_DMA_BUFFER");
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



