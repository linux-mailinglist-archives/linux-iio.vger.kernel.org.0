Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C931B125
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhBNQKE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 11:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhBNQKC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 11:10:02 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B1F64DD1;
        Sun, 14 Feb 2021 16:09:18 +0000 (UTC)
Date:   Sun, 14 Feb 2021 16:09:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v2 2/3] iio: buffer-dma: Add mmap support
Message-ID: <20210214160911.5f6e6fb3@archlinux>
In-Reply-To: <20210212101143.18993-3-alexandru.ardelean@analog.com>
References: <20210212101143.18993-1-alexandru.ardelean@analog.com>
        <20210212101143.18993-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 12:11:42 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Add support for the new mmap interface to IIO DMA buffer. This interface
> allows to directly map the backing memory of a block to userspace. This is
> especially advantageous for high-speed devices where the extra copy from
> kernel space to userspace of the data incurs a significant overhead.
> 
> In addition this interface allows more fine grained control over how many
> blocks are allocated and their size.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

There are a few changes in here that could have been prequel noop patches
and made this easier to review.

factoring out iio_dma_buffer_fileio_free() for example

A few questions inline.

I'll admit I haven't followed every detail of what this is doing, but
in general it looks sensible.

Jonathan


> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c  | 314 ++++++++++++++++--
>  .../buffer/industrialio-buffer-dmaengine.c    |  22 +-
>  drivers/iio/industrialio-buffer.c             |   1 +
>  include/linux/iio/buffer-dma.h                |  20 +-
>  4 files changed, 321 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index d348af8b9705..befb0a3d2def 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -90,6 +90,9 @@
>   * callback is called from within the custom callback.
>   */
>  
> +static unsigned int iio_dma_buffer_max_block_size = SZ_16M;
> +module_param_named(max_block_size, iio_dma_buffer_max_block_size, uint, 0644);
> +
>  static void iio_buffer_block_release(struct kref *kref)
>  {
>  	struct iio_dma_buffer_block *block = container_of(kref,
> @@ -97,7 +100,7 @@ static void iio_buffer_block_release(struct kref *kref)
>  
>  	WARN_ON(block->state != IIO_BLOCK_STATE_DEAD);
>  
> -	dma_free_coherent(block->queue->dev, PAGE_ALIGN(block->size),
> +	dma_free_coherent(block->queue->dev, PAGE_ALIGN(block->block.size),
>  					block->vaddr, block->phys_addr);
>  
>  	iio_buffer_put(&block->queue->buffer);
> @@ -178,7 +181,7 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
>  		return NULL;
>  	}
>  
> -	block->size = size;
> +	block->block.size = size;
>  	block->state = IIO_BLOCK_STATE_DEQUEUED;
>  	block->queue = queue;
>  	INIT_LIST_HEAD(&block->head);
> @@ -243,7 +246,7 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
>  	spin_lock_irqsave(&queue->list_lock, flags);
>  	list_for_each_entry_safe(block, _block, list, head) {
>  		list_del(&block->head);
> -		block->bytes_used = 0;
> +		block->block.bytes_used = 0;
>  		_iio_dma_buffer_block_done(block);
>  		iio_buffer_block_put_atomic(block);
>  	}
> @@ -296,6 +299,10 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  
>  	mutex_lock(&queue->lock);
>  
> +	/* If in mmap mode dont do anything */
> +	if (queue->num_blocks)
> +		goto out_unlock;
> +
>  	/* Allocations are page aligned */
>  	if (PAGE_ALIGN(queue->fileio.block_size) == PAGE_ALIGN(size))
>  		try_reuse = true;
> @@ -330,7 +337,7 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  				iio_buffer_block_put(block);
>  				block = NULL;
>  			} else {
> -				block->size = size;
> +				block->block.size = size;
>  			}
>  		} else {
>  			block = NULL;
> @@ -345,6 +352,8 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  			queue->fileio.blocks[i] = block;
>  		}
>  
> +		block->block.id = i;
> +
>  		block->state = IIO_BLOCK_STATE_QUEUED;
>  		list_add_tail(&block->head, &queue->incoming);
>  	}
> @@ -356,6 +365,30 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_request_update);
>  
> +static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
> +{
> +	unsigned int i;
> +
> +	spin_lock_irq(&queue->list_lock);
> +	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +		if (!queue->fileio.blocks[i])
> +			continue;
> +		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> +	}
> +	INIT_LIST_HEAD(&queue->outgoing);
> +	spin_unlock_irq(&queue->list_lock);
> +
> +	INIT_LIST_HEAD(&queue->incoming);
> +
> +	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +		if (!queue->fileio.blocks[i])
> +			continue;
> +		iio_buffer_block_put(queue->fileio.blocks[i]);
> +		queue->fileio.blocks[i] = NULL;
> +	}
> +	queue->fileio.active_block = NULL;
> +}
> +
>  static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  	struct iio_dma_buffer_block *block)
>  {
> @@ -404,6 +437,7 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
>  	struct iio_dma_buffer_block *block, *_block;
>  
>  	mutex_lock(&queue->lock);
> +	queue->fileio.enabled = !queue->num_blocks;
>  	queue->active = true;
>  	list_for_each_entry_safe(block, _block, &queue->incoming, head) {
>  		list_del(&block->head);
> @@ -429,6 +463,7 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
>  	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
>  
>  	mutex_lock(&queue->lock);
> +	queue->fileio.enabled = false;
>  	queue->active = false;
>  
>  	if (queue->ops && queue->ops->abort)
> @@ -490,6 +525,11 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>  
>  	mutex_lock(&queue->lock);
>  
> +	if (!queue->fileio.enabled) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
>  	if (!queue->fileio.active_block) {
>  		block = iio_dma_buffer_dequeue(queue);
>  		if (block == NULL) {
> @@ -503,8 +543,8 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>  	}
>  
>  	n = rounddown(n, buffer->bytes_per_datum);
> -	if (n > block->bytes_used - queue->fileio.pos)
> -		n = block->bytes_used - queue->fileio.pos;
> +	if (n > block->block.bytes_used - queue->fileio.pos)
> +		n = block->block.bytes_used - queue->fileio.pos;
>  
>  	if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, n)) {
>  		ret = -EFAULT;
> @@ -513,7 +553,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>  
>  	queue->fileio.pos += n;
>  
> -	if (queue->fileio.pos == block->bytes_used) {
> +	if (queue->fileio.pos == block->block.bytes_used) {
>  		queue->fileio.active_block = NULL;
>  		iio_dma_buffer_enqueue(queue, block);
>  	}
> @@ -549,11 +589,11 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>  
>  	mutex_lock(&queue->lock);
>  	if (queue->fileio.active_block)
> -		data_available += queue->fileio.active_block->size;
> +		data_available += queue->fileio.active_block->block.size;
>  
>  	spin_lock_irq(&queue->list_lock);
>  	list_for_each_entry(block, &queue->outgoing, head)
> -		data_available += block->size;
> +		data_available += block->block.size;
>  	spin_unlock_irq(&queue->list_lock);
>  	mutex_unlock(&queue->lock);
>  
> @@ -561,6 +601,241 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>  }
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_data_available);
>  
> +int iio_dma_buffer_alloc_blocks(struct iio_buffer *buffer,
> +				struct iio_buffer_block_alloc_req *req)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	struct iio_dma_buffer_block **blocks;
> +	unsigned int num_blocks;
> +	unsigned int i;
> +	int ret = 0;
> +
> +	mutex_lock(&queue->lock);
> +
> +	/*
> +	 * If the buffer is enabled and in fileio mode new blocks can't be
> +	 * allocated.
> +	 */
> +	if (queue->fileio.enabled) {
> +		ret = -EBUSY;
> +		goto err_unlock;
> +	}
> +
> +	/* Free memory that might be in use for fileio mode */
> +	iio_dma_buffer_fileio_free(queue);
> +
> +	/* 64 blocks ought to be enough for anybody ;) */
> +	if (req->count > 64 - queue->num_blocks)
> +		req->count = 64 - queue->num_blocks;
> +	if (req->size > iio_dma_buffer_max_block_size)
> +		req->size = iio_dma_buffer_max_block_size;
> +
> +	req->id = queue->num_blocks;
> +
> +	if (req->count == 0 || req->size == 0) {
> +		ret = 0;
> +		goto err_unlock;
> +	}
> +
> +	num_blocks = req->count + queue->num_blocks;
> +
> +	blocks = krealloc(queue->blocks, sizeof(*blocks) * num_blocks,
> +		GFP_KERNEL);
> +	if (!blocks) {
> +		ret = -ENOMEM;
> +		goto err_unlock;
> +	}
> +
> +	for (i = queue->num_blocks; i < num_blocks; i++) {
> +		blocks[i] = iio_dma_buffer_alloc_block(queue, req->size);
> +		if (!blocks[i])

Is this an error path?  ret isn't set but I can't see why iio_dma_buffer_alloc_block()
would fail in a 'good' way.

> +			break;
> +		blocks[i]->block.id = i;
> +		blocks[i]->block.data.offset = queue->max_offset;
> +		queue->max_offset += PAGE_ALIGN(req->size);
> +	}
> +
> +	req->count = i - queue->num_blocks;
> +	queue->num_blocks = i;
> +	queue->blocks = blocks;
> +
> +err_unlock:
> +	mutex_unlock(&queue->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_alloc_blocks);
> +
> +int iio_dma_buffer_free_blocks(struct iio_buffer *buffer)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	unsigned int i;
> +
> +	mutex_lock(&queue->lock);
> +
> +	spin_lock_irq(&queue->list_lock);
> +	INIT_LIST_HEAD(&queue->incoming);
> +	INIT_LIST_HEAD(&queue->outgoing);
> +
> +	for (i = 0; i < queue->num_blocks; i++)
> +		queue->blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> +	spin_unlock_irq(&queue->list_lock);
> +
> +	for (i = 0; i < queue->num_blocks; i++)
> +		iio_buffer_block_put(queue->blocks[i]);
> +
> +	kfree(queue->blocks);
> +	queue->blocks = NULL;
> +	queue->num_blocks = 0;
> +	queue->max_offset = 0;
> +
> +	mutex_unlock(&queue->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_free_blocks);
> +
> +int iio_dma_buffer_query_block(struct iio_buffer *buffer,
> +			       struct iio_buffer_block *block)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	int ret = 0;
> +
> +	mutex_lock(&queue->lock);
> +
> +	if (block->id >= queue->num_blocks) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	*block = queue->blocks[block->id]->block;
> +
> +out_unlock:
> +	mutex_unlock(&queue->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_query_block);
> +
> +int iio_dma_buffer_enqueue_block(struct iio_buffer *buffer,
> +				 struct iio_buffer_block *block)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	struct iio_dma_buffer_block *dma_block;
> +	int ret = 0;
> +
> +	mutex_lock(&queue->lock);
> +
> +	if (block->id >= queue->num_blocks) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	dma_block = queue->blocks[block->id];
> +	dma_block->block.bytes_used = block->bytes_used;
> +	dma_block->block.flags = block->flags;
> +
> +	switch (dma_block->state) {
> +	case IIO_BLOCK_STATE_DONE:
> +		list_del_init(&dma_block->head);
> +		break;
> +	case IIO_BLOCK_STATE_QUEUED:
> +		/* Nothing to do */
> +		goto out_unlock;
> +	case IIO_BLOCK_STATE_DEQUEUED:
> +		break;
> +	default:
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	iio_dma_buffer_enqueue(queue, dma_block);
> +
> +out_unlock:
> +	mutex_unlock(&queue->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_enqueue_block);
> +
> +int iio_dma_buffer_dequeue_block(struct iio_buffer *buffer,
> +				 struct iio_buffer_block *block)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	struct iio_dma_buffer_block *dma_block;
> +	int ret = 0;
> +
> +	mutex_lock(&queue->lock);
> +
> +	dma_block = iio_dma_buffer_dequeue(queue);
> +	if (!dma_block) {
> +		ret = -EAGAIN;
> +		goto out_unlock;
> +	}
> +
> +	*block = dma_block->block;
> +
> +out_unlock:
> +	mutex_unlock(&queue->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_dequeue_block);
> +
> +static void iio_dma_buffer_mmap_open(struct vm_area_struct *area)
> +{
> +	struct iio_dma_buffer_block *block = area->vm_private_data;
> +
> +	iio_buffer_block_get(block);
> +}
> +
> +static void iio_dma_buffer_mmap_close(struct vm_area_struct *area)
> +{
> +	struct iio_dma_buffer_block *block = area->vm_private_data;
> +
> +	iio_buffer_block_put(block);
> +}
> +
> +static const struct vm_operations_struct iio_dma_buffer_vm_ops = {
> +	.open = iio_dma_buffer_mmap_open,
> +	.close = iio_dma_buffer_mmap_close,
> +};
> +
> +int iio_dma_buffer_mmap(struct iio_buffer *buffer, struct vm_area_struct *vma)
> +{
> +	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> +	struct iio_dma_buffer_block *block = NULL;
> +	size_t vm_offset;
> +	unsigned int i;
> +
> +	vm_offset = vma->vm_pgoff << PAGE_SHIFT;
> +
> +	for (i = 0; i < queue->num_blocks; i++) {
I wonder if we should be using a better search structure here than linear

search.  I guess mostly we are dealing with a small number of blocks though
so this should be fine.

> +		if (queue->blocks[i]->block.data.offset == vm_offset) {
> +			block = queue->blocks[i];
> +			break;
> +		}
> +	}
> +
> +	if (block == NULL)
> +		return -EINVAL;
> +
> +	if (PAGE_ALIGN(block->block.size) < vma->vm_end - vma->vm_start)
> +		return -EINVAL;
> +
> +	vma->vm_pgoff = 0;
> +
> +	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
> +	vma->vm_ops = &iio_dma_buffer_vm_ops;
> +	vma->vm_private_data = block;
> +
> +	vma->vm_ops->open(vma);
> +
> +	return dma_mmap_coherent(queue->dev, vma, block->vaddr,
> +		block->phys_addr, vma->vm_end - vma->vm_start);
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_mmap);
> +
>  /**
>   * iio_dma_buffer_set_bytes_per_datum() - DMA buffer set_bytes_per_datum callback
>   * @buffer: Buffer to set the bytes-per-datum for
> @@ -635,28 +910,9 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_init);
>   */
>  void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
>  {
> -	unsigned int i;
> -
>  	mutex_lock(&queue->lock);
>  
> -	spin_lock_irq(&queue->list_lock);
> -	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> -		if (!queue->fileio.blocks[i])
> -			continue;
> -		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> -	}
> -	INIT_LIST_HEAD(&queue->outgoing);
> -	spin_unlock_irq(&queue->list_lock);
> -
> -	INIT_LIST_HEAD(&queue->incoming);
> -
> -	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> -		if (!queue->fileio.blocks[i])
> -			continue;
> -		iio_buffer_block_put(queue->fileio.blocks[i]);
> -		queue->fileio.blocks[i] = NULL;
> -	}
> -	queue->fileio.active_block = NULL;
> +	iio_dma_buffer_fileio_free(queue);
>  	queue->ops = NULL;
>  
>  	mutex_unlock(&queue->lock);
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 8ecdbae83414..bb022922ec23 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -54,7 +54,7 @@ static void iio_dmaengine_buffer_block_done(void *data,
>  	spin_lock_irqsave(&block->queue->list_lock, flags);
>  	list_del(&block->head);
>  	spin_unlock_irqrestore(&block->queue->list_lock, flags);
> -	block->bytes_used -= result->residue;
> +	block->block.bytes_used -= result->residue;
>  	iio_dma_buffer_block_done(block);
>  }
>  
> @@ -66,12 +66,17 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  	struct dma_async_tx_descriptor *desc;
>  	dma_cookie_t cookie;
>  
> -	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
> -	block->bytes_used = rounddown(block->bytes_used,
> -			dmaengine_buffer->align);
> +	block->block.bytes_used = min(block->block.size,
> +		dmaengine_buffer->max_size);
> +	block->block.bytes_used = rounddown(block->block.bytes_used,
> +		dmaengine_buffer->align);
> +	if (block->block.bytes_used == 0) {
> +		iio_dma_buffer_block_done(block);
> +		return 0;
> +	}
>  
>  	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> -		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
> +		block->phys_addr, block->block.bytes_used, DMA_DEV_TO_MEM,
>  		DMA_PREP_INTERRUPT);
>  	if (!desc)
>  		return -ENOMEM;
> @@ -120,6 +125,13 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
>  	.data_available = iio_dma_buffer_data_available,
>  	.release = iio_dmaengine_buffer_release,
>  
> +	.alloc_blocks = iio_dma_buffer_alloc_blocks,
> +	.free_blocks = iio_dma_buffer_free_blocks,
> +	.query_block = iio_dma_buffer_query_block,
> +	.enqueue_block = iio_dma_buffer_enqueue_block,
> +	.dequeue_block = iio_dma_buffer_dequeue_block,
> +	.mmap = iio_dma_buffer_mmap,
> +
>  	.modes = INDIO_BUFFER_HARDWARE,
>  	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
>  };
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 50228df0b09f..a0d1ad86022f 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -19,6 +19,7 @@
>  #include <linux/mm.h>
>  #include <linux/poll.h>
>  #include <linux/sched/signal.h>
> +#include <linux/mm.h>

Double include - guessing you rebase issues.

>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/iio-opaque.h>
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 6564bdcdac66..315a8d750986 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -47,7 +47,7 @@ enum iio_block_state {
>  struct iio_dma_buffer_block {
>  	/* May only be accessed by the owner of the block */
>  	struct list_head head;
> -	size_t bytes_used;
> +	struct iio_buffer_block block;

Docs update

>  
>  	/*
>  	 * Set during allocation, constant thereafter. May be accessed read-only
> @@ -55,7 +55,6 @@ struct iio_dma_buffer_block {
>  	 */
>  	void *vaddr;
>  	dma_addr_t phys_addr;
> -	size_t size;

Structure has docs that need updating.  However, size is documented
in the wrong place (order wise) so not easily missed!

>  	struct iio_dma_buffer_queue *queue;
>  
>  	/* Must not be accessed outside the core. */
> @@ -73,12 +72,14 @@ struct iio_dma_buffer_block {
>   * @active_block: Block being used in read()
>   * @pos: Read offset in the active block
>   * @block_size: Size of each block
> + * @enabled: Whether the buffer is operating in fileio mode
>   */
>  struct iio_dma_buffer_queue_fileio {
>  	struct iio_dma_buffer_block *blocks[2];
>  	struct iio_dma_buffer_block *active_block;
>  	size_t pos;
>  	size_t block_size;
> +	bool enabled;
>  };
>  
>  /**
> @@ -109,6 +110,10 @@ struct iio_dma_buffer_queue {
>  
>  	bool active;
>  
> +	unsigned int num_blocks;
> +	struct iio_dma_buffer_block **blocks;
> +	unsigned int max_offset;
> +
>  	struct iio_dma_buffer_queue_fileio fileio;
>  };
>  
> @@ -143,4 +148,15 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
>  void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
>  void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
>  
> +int iio_dma_buffer_alloc_blocks(struct iio_buffer *buffer,
> +				struct iio_buffer_block_alloc_req *req);
> +int iio_dma_buffer_free_blocks(struct iio_buffer *buffer);
> +int iio_dma_buffer_query_block(struct iio_buffer *buffer,
> +			       struct iio_buffer_block *block);
> +int iio_dma_buffer_enqueue_block(struct iio_buffer *buffer,
> +				 struct iio_buffer_block *block);
> +int iio_dma_buffer_dequeue_block(struct iio_buffer *buffer,
> +				 struct iio_buffer_block *block);
> +int iio_dma_buffer_mmap(struct iio_buffer *buffer, struct vm_area_struct *vma);
> +
>  #endif

