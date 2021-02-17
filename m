Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED1E31D5C1
	for <lists+linux-iio@lfdr.de>; Wed, 17 Feb 2021 08:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhBQHf5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Feb 2021 02:35:57 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1588 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhBQHfk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Feb 2021 02:35:40 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11H7LUtv028189;
        Wed, 17 Feb 2021 02:34:46 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjat5xg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Feb 2021 02:34:46 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 11H7YjZp003769
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Feb 2021 02:34:45 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 17 Feb 2021 02:34:43 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 17 Feb 2021 02:34:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Wed, 17 Feb 2021 02:34:43 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 11H7YS3j031303;
        Wed, 17 Feb 2021 02:34:40 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 5/6] iio: buffer-dma: Add mmap support
Date:   Wed, 17 Feb 2021 09:36:37 +0200
Message-ID: <20210217073638.21681-6-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210217073638.21681-1-alexandru.ardelean@analog.com>
References: <20210217073638.21681-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-17_06:2021-02-16,2021-02-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Add support for the new mmap interface to IIO DMA buffer. This interface
allows to directly map the backing memory of a block to userspace. This is
especially advantageous for high-speed devices where the extra copy from
kernel space to userspace of the data incurs a significant overhead.

In addition this interface allows more fine grained control over how many
blocks are allocated and their size.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dma.c  | 279 +++++++++++++++++-
 .../buffer/industrialio-buffer-dmaengine.c    |  22 +-
 include/linux/iio/buffer-dma.h                |  22 +-
 3 files changed, 306 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 858af7eea53e..e187c1640b17 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -90,6 +90,9 @@
  * callback is called from within the custom callback.
  */
 
+static unsigned int iio_dma_buffer_max_block_size = SZ_16M;
+module_param_named(max_block_size, iio_dma_buffer_max_block_size, uint, 0644);
+
 static void iio_buffer_block_release(struct kref *kref)
 {
 	struct iio_dma_buffer_block *block = container_of(kref,
@@ -97,7 +100,7 @@ static void iio_buffer_block_release(struct kref *kref)
 
 	WARN_ON(block->state != IIO_BLOCK_STATE_DEAD);
 
-	dma_free_coherent(block->queue->dev, PAGE_ALIGN(block->size),
+	dma_free_coherent(block->queue->dev, PAGE_ALIGN(block->block.size),
 					block->vaddr, block->phys_addr);
 
 	iio_buffer_put(&block->queue->buffer);
@@ -178,7 +181,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
 		return NULL;
 	}
 
-	block->size = size;
+	block->block.size = size;
 	block->state = IIO_BLOCK_STATE_DEQUEUED;
 	block->queue = queue;
 	INIT_LIST_HEAD(&block->head);
@@ -243,7 +246,7 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
 	spin_lock_irqsave(&queue->list_lock, flags);
 	list_for_each_entry_safe(block, _block, list, head) {
 		list_del(&block->head);
-		block->bytes_used = 0;
+		block->block.bytes_used = 0;
 		_iio_dma_buffer_block_done(block);
 		iio_buffer_block_put_atomic(block);
 	}
@@ -296,6 +299,10 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 
 	mutex_lock(&queue->lock);
 
+	/* If in mmap mode dont do anything */
+	if (queue->num_blocks)
+		goto out_unlock;
+
 	/* Allocations are page aligned */
 	if (PAGE_ALIGN(queue->fileio.block_size) == PAGE_ALIGN(size))
 		try_reuse = true;
@@ -330,7 +337,7 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 				iio_buffer_block_put(block);
 				block = NULL;
 			} else {
-				block->size = size;
+				block->block.size = size;
 			}
 		} else {
 			block = NULL;
@@ -345,6 +352,8 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
 			queue->fileio.blocks[i] = block;
 		}
 
+		block->block.id = i;
+
 		block->state = IIO_BLOCK_STATE_QUEUED;
 		list_add_tail(&block->head, &queue->incoming);
 	}
@@ -428,6 +437,7 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
 	struct iio_dma_buffer_block *block, *_block;
 
 	mutex_lock(&queue->lock);
+	queue->fileio.enabled = !queue->num_blocks;
 	queue->active = true;
 	list_for_each_entry_safe(block, _block, &queue->incoming, head) {
 		list_del(&block->head);
@@ -453,6 +463,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
 	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
 
 	mutex_lock(&queue->lock);
+	queue->fileio.enabled = false;
 	queue->active = false;
 
 	if (queue->ops && queue->ops->abort)
@@ -514,6 +525,11 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 
 	mutex_lock(&queue->lock);
 
+	if (!queue->fileio.enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (!queue->fileio.active_block) {
 		block = iio_dma_buffer_dequeue(queue);
 		if (block == NULL) {
@@ -527,8 +543,8 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 	}
 
 	n = rounddown(n, buffer->bytes_per_datum);
-	if (n > block->bytes_used - queue->fileio.pos)
-		n = block->bytes_used - queue->fileio.pos;
+	if (n > block->block.bytes_used - queue->fileio.pos)
+		n = block->block.bytes_used - queue->fileio.pos;
 
 	if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, n)) {
 		ret = -EFAULT;
@@ -537,7 +553,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
 
 	queue->fileio.pos += n;
 
-	if (queue->fileio.pos == block->bytes_used) {
+	if (queue->fileio.pos == block->block.bytes_used) {
 		queue->fileio.active_block = NULL;
 		iio_dma_buffer_enqueue(queue, block);
 	}
@@ -573,11 +589,11 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 
 	mutex_lock(&queue->lock);
 	if (queue->fileio.active_block)
-		data_available += queue->fileio.active_block->size;
+		data_available += queue->fileio.active_block->block.size;
 
 	spin_lock_irq(&queue->list_lock);
 	list_for_each_entry(block, &queue->outgoing, head)
-		data_available += block->size;
+		data_available += block->block.size;
 	spin_unlock_irq(&queue->list_lock);
 	mutex_unlock(&queue->lock);
 
@@ -585,6 +601,251 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
 }
 EXPORT_SYMBOL_GPL(iio_dma_buffer_data_available);
 
+int iio_dma_buffer_alloc_blocks(struct iio_buffer *buffer,
+				struct iio_buffer_block_alloc_req *req)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
+	struct iio_dma_buffer_block **blocks;
+	unsigned int num_blocks;
+	unsigned int i;
+	int ret = 0;
+
+	mutex_lock(&queue->lock);
+
+	/*
+	 * If the buffer is enabled and in fileio mode new blocks can't be
+	 * allocated.
+	 */
+	if (queue->fileio.enabled) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	/* Free memory that might be in use for fileio mode */
+	iio_dma_buffer_fileio_free(queue);
+
+	/* 64 blocks ought to be enough for anybody ;) */
+	if (req->count > 64 - queue->num_blocks)
+		req->count = 64 - queue->num_blocks;
+	if (req->size > iio_dma_buffer_max_block_size)
+		req->size = iio_dma_buffer_max_block_size;
+
+	req->id = queue->num_blocks;
+
+	if (req->count == 0 || req->size == 0) {
+		ret = 0;
+		goto err_unlock;
+	}
+
+	num_blocks = req->count + queue->num_blocks;
+
+	blocks = krealloc(queue->blocks, sizeof(*blocks) * num_blocks,
+			  GFP_KERNEL);
+	if (!blocks) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+
+	for (i = queue->num_blocks; i < num_blocks; i++) {
+		blocks[i] = iio_dma_buffer_alloc_block(queue, req->size);
+		if (!blocks[i]) {
+			ret = -ENOMEM;
+			goto err_unwind;
+		}
+		blocks[i]->block.id = i;
+		blocks[i]->block.data.offset = queue->max_offset;
+		queue->max_offset += PAGE_ALIGN(req->size);
+	}
+
+	req->count = i - queue->num_blocks;
+	queue->num_blocks = i;
+	queue->blocks = blocks;
+
+	mutex_unlock(&queue->lock);
+
+	return 0;
+
+err_unwind:
+	for (; i >= 0; i--)
+		iio_buffer_block_put(blocks[i]);
+	kfree(blocks);
+err_unlock:
+	mutex_unlock(&queue->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_alloc_blocks);
+
+int iio_dma_buffer_free_blocks(struct iio_buffer *buffer)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
+	unsigned int i;
+
+	mutex_lock(&queue->lock);
+
+	spin_lock_irq(&queue->list_lock);
+	INIT_LIST_HEAD(&queue->incoming);
+	INIT_LIST_HEAD(&queue->outgoing);
+
+	for (i = 0; i < queue->num_blocks; i++)
+		queue->blocks[i]->state = IIO_BLOCK_STATE_DEAD;
+	spin_unlock_irq(&queue->list_lock);
+
+	for (i = 0; i < queue->num_blocks; i++)
+		iio_buffer_block_put(queue->blocks[i]);
+
+	kfree(queue->blocks);
+	queue->blocks = NULL;
+	queue->num_blocks = 0;
+	queue->max_offset = 0;
+
+	mutex_unlock(&queue->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_free_blocks);
+
+int iio_dma_buffer_query_block(struct iio_buffer *buffer,
+			       struct iio_buffer_block *block)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
+	int ret = 0;
+
+	mutex_lock(&queue->lock);
+
+	if (block->id >= queue->num_blocks) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	*block = queue->blocks[block->id]->block;
+
+out_unlock:
+	mutex_unlock(&queue->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_query_block);
+
+int iio_dma_buffer_enqueue_block(struct iio_buffer *buffer,
+				 struct iio_buffer_block *block)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
+	struct iio_dma_buffer_block *dma_block;
+	int ret = 0;
+
+	mutex_lock(&queue->lock);
+
+	if (block->id >= queue->num_blocks) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	dma_block = queue->blocks[block->id];
+	dma_block->block.bytes_used = block->bytes_used;
+	dma_block->block.flags = block->flags;
+
+	switch (dma_block->state) {
+	case IIO_BLOCK_STATE_DONE:
+		list_del_init(&dma_block->head);
+		break;
+	case IIO_BLOCK_STATE_QUEUED:
+		/* Nothing to do */
+		goto out_unlock;
+	case IIO_BLOCK_STATE_DEQUEUED:
+		break;
+	default:
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	iio_dma_buffer_enqueue(queue, dma_block);
+
+out_unlock:
+	mutex_unlock(&queue->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_enqueue_block);
+
+int iio_dma_buffer_dequeue_block(struct iio_buffer *buffer,
+				 struct iio_buffer_block *block)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
+	struct iio_dma_buffer_block *dma_block;
+	int ret = 0;
+
+	mutex_lock(&queue->lock);
+
+	dma_block = iio_dma_buffer_dequeue(queue);
+	if (!dma_block) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	*block = dma_block->block;
+
+out_unlock:
+	mutex_unlock(&queue->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_dequeue_block);
+
+static void iio_dma_buffer_mmap_open(struct vm_area_struct *area)
+{
+	struct iio_dma_buffer_block *block = area->vm_private_data;
+
+	iio_buffer_block_get(block);
+}
+
+static void iio_dma_buffer_mmap_close(struct vm_area_struct *area)
+{
+	struct iio_dma_buffer_block *block = area->vm_private_data;
+
+	iio_buffer_block_put(block);
+}
+
+static const struct vm_operations_struct iio_dma_buffer_vm_ops = {
+	.open = iio_dma_buffer_mmap_open,
+	.close = iio_dma_buffer_mmap_close,
+};
+
+int iio_dma_buffer_mmap(struct iio_buffer *buffer, struct vm_area_struct *vma)
+{
+	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
+	struct iio_dma_buffer_block *block = NULL;
+	size_t vm_offset;
+	unsigned int i;
+
+	vm_offset = vma->vm_pgoff << PAGE_SHIFT;
+
+	for (i = 0; i < queue->num_blocks; i++) {
+		if (queue->blocks[i]->block.data.offset == vm_offset) {
+			block = queue->blocks[i];
+			break;
+		}
+	}
+
+	if (block == NULL)
+		return -EINVAL;
+
+	if (PAGE_ALIGN(block->block.size) < vma->vm_end - vma->vm_start)
+		return -EINVAL;
+
+	vma->vm_pgoff = 0;
+
+	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_ops = &iio_dma_buffer_vm_ops;
+	vma->vm_private_data = block;
+
+	vma->vm_ops->open(vma);
+
+	return dma_mmap_coherent(queue->dev, vma, block->vaddr,
+		block->phys_addr, vma->vm_end - vma->vm_start);
+}
+EXPORT_SYMBOL_GPL(iio_dma_buffer_mmap);
+
 /**
  * iio_dma_buffer_set_bytes_per_datum() - DMA buffer set_bytes_per_datum callback
  * @buffer: Buffer to set the bytes-per-datum for
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 19fbe5d9ef5b..6db24be7e11d 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -54,7 +54,7 @@ static void iio_dmaengine_buffer_block_done(void *data,
 	spin_lock_irqsave(&block->queue->list_lock, flags);
 	list_del(&block->head);
 	spin_unlock_irqrestore(&block->queue->list_lock, flags);
-	block->bytes_used -= result->residue;
+	block->block.bytes_used -= result->residue;
 	iio_dma_buffer_block_done(block);
 }
 
@@ -66,12 +66,17 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	struct dma_async_tx_descriptor *desc;
 	dma_cookie_t cookie;
 
-	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
-	block->bytes_used = rounddown(block->bytes_used,
-			dmaengine_buffer->align);
+	block->block.bytes_used = min(block->block.size,
+		dmaengine_buffer->max_size);
+	block->block.bytes_used = rounddown(block->block.bytes_used,
+		dmaengine_buffer->align);
+	if (block->block.bytes_used == 0) {
+		iio_dma_buffer_block_done(block);
+		return 0;
+	}
 
 	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
+		block->phys_addr, block->block.bytes_used, DMA_DEV_TO_MEM,
 		DMA_PREP_INTERRUPT);
 	if (!desc)
 		return -ENOMEM;
@@ -120,6 +125,13 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.data_available = iio_dma_buffer_data_available,
 	.release = iio_dmaengine_buffer_release,
 
+	.alloc_blocks = iio_dma_buffer_alloc_blocks,
+	.free_blocks = iio_dma_buffer_free_blocks,
+	.query_block = iio_dma_buffer_query_block,
+	.enqueue_block = iio_dma_buffer_enqueue_block,
+	.dequeue_block = iio_dma_buffer_dequeue_block,
+	.mmap = iio_dma_buffer_mmap,
+
 	.modes = INDIO_BUFFER_HARDWARE,
 	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
 };
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 9de27d23e791..f6f2ce3e2ed1 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -36,7 +36,7 @@ enum iio_block_state {
 /**
  * struct iio_dma_buffer_block - IIO buffer block
  * @head: List head
- * @size: Total size of the block in bytes
+ * @block: Underlying block object for this DMA buffer block
  * @bytes_used: Number of bytes that contain valid data
  * @vaddr: Virutal address of the blocks memory
  * @phys_addr: Physical address of the blocks memory
@@ -47,7 +47,7 @@ enum iio_block_state {
 struct iio_dma_buffer_block {
 	/* May only be accessed by the owner of the block */
 	struct list_head head;
-	size_t bytes_used;
+	struct iio_buffer_block block;
 
 	/*
 	 * Set during allocation, constant thereafter. May be accessed read-only
@@ -55,7 +55,6 @@ struct iio_dma_buffer_block {
 	 */
 	void *vaddr;
 	dma_addr_t phys_addr;
-	u32 size;
 	struct iio_dma_buffer_queue *queue;
 
 	/* Must not be accessed outside the core. */
@@ -73,12 +72,14 @@ struct iio_dma_buffer_block {
  * @active_block: Block being used in read()
  * @pos: Read offset in the active block
  * @block_size: Size of each block
+ * @enabled: Whether the buffer is operating in fileio mode
  */
 struct iio_dma_buffer_queue_fileio {
 	struct iio_dma_buffer_block *blocks[2];
 	struct iio_dma_buffer_block *active_block;
 	size_t pos;
 	size_t block_size;
+	bool enabled;
 };
 
 /**
@@ -109,6 +110,10 @@ struct iio_dma_buffer_queue {
 
 	bool active;
 
+	unsigned int num_blocks;
+	struct iio_dma_buffer_block **blocks;
+	unsigned int max_offset;
+
 	struct iio_dma_buffer_queue_fileio fileio;
 };
 
@@ -143,4 +148,15 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
 void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
 void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
 
+int iio_dma_buffer_alloc_blocks(struct iio_buffer *buffer,
+				struct iio_buffer_block_alloc_req *req);
+int iio_dma_buffer_free_blocks(struct iio_buffer *buffer);
+int iio_dma_buffer_query_block(struct iio_buffer *buffer,
+			       struct iio_buffer_block *block);
+int iio_dma_buffer_enqueue_block(struct iio_buffer *buffer,
+				 struct iio_buffer_block *block);
+int iio_dma_buffer_dequeue_block(struct iio_buffer *buffer,
+				 struct iio_buffer_block *block);
+int iio_dma_buffer_mmap(struct iio_buffer *buffer, struct vm_area_struct *vma);
+
 #endif
-- 
2.17.1

