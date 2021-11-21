Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BEF4583EF
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 15:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhKUOEK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 09:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233010AbhKUOEJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 09:04:09 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B37760462;
        Sun, 21 Nov 2021 14:01:02 +0000 (UTC)
Date:   Sun, 21 Nov 2021 14:05:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 01/15] iio: buffer-dma: Get rid of incoming/outgoing
 queues
Message-ID: <20211121140555.7239715f@jic23-huawei>
In-Reply-To: <20211115141925.60164-2-paul@crapouillou.net>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115141925.60164-2-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Nov 2021 14:19:11 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> The buffer-dma code was using two queues, incoming and outgoing, to
> manage the state of the blocks in use.
> 
> While this totally works, it adds some complexity to the code,
> especially since the code only manages 2 blocks. It is much easier to
> just check each block's state manually, and keep a counter for the next
> block to dequeue.
> 
> Since the new DMABUF based API wouldn't use these incoming and outgoing
> queues anyway, getting rid of them now makes the upcoming changes
> simpler.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
This looks to be a nice little cleanup on it's own.

Let me know if you'd like me to pick this up before the main discussion
comes to any conclusion.

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 68 ++++++++++----------
>  include/linux/iio/buffer-dma.h               |  7 +-
>  2 files changed, 37 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index d348af8b9705..abac88f20104 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -191,16 +191,8 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
>  
>  static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
>  {
> -	struct iio_dma_buffer_queue *queue = block->queue;
> -
> -	/*
> -	 * The buffer has already been freed by the application, just drop the
> -	 * reference.
> -	 */
> -	if (block->state != IIO_BLOCK_STATE_DEAD) {
> +	if (block->state != IIO_BLOCK_STATE_DEAD)
>  		block->state = IIO_BLOCK_STATE_DONE;
> -		list_add_tail(&block->head, &queue->outgoing);
> -	}
>  }
>  
>  /**
> @@ -317,11 +309,8 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  	 * dead. This means we can reset the lists without having to fear
>  	 * corrution.
>  	 */
> -	INIT_LIST_HEAD(&queue->outgoing);
>  	spin_unlock_irq(&queue->list_lock);
>  
> -	INIT_LIST_HEAD(&queue->incoming);
> -
>  	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
>  		if (queue->fileio.blocks[i]) {
>  			block = queue->fileio.blocks[i];
> @@ -346,7 +335,6 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  		}
>  
>  		block->state = IIO_BLOCK_STATE_QUEUED;
> -		list_add_tail(&block->head, &queue->incoming);
>  	}
>  
>  out_unlock:
> @@ -401,13 +389,18 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
>  	struct iio_dev *indio_dev)
>  {
>  	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> -	struct iio_dma_buffer_block *block, *_block;
> +	struct iio_dma_buffer_block *block;
> +	unsigned int i;
>  
>  	mutex_lock(&queue->lock);
>  	queue->active = true;
> -	list_for_each_entry_safe(block, _block, &queue->incoming, head) {
> -		list_del(&block->head);
> -		iio_dma_buffer_submit_block(queue, block);
> +	queue->fileio.next_dequeue = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +		block = queue->fileio.blocks[i];
> +
> +		if (block->state == IIO_BLOCK_STATE_QUEUED)
> +			iio_dma_buffer_submit_block(queue, block);
>  	}
>  	mutex_unlock(&queue->lock);
>  
> @@ -442,28 +435,33 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_disable);
>  static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *queue,
>  	struct iio_dma_buffer_block *block)
>  {
> -	if (block->state == IIO_BLOCK_STATE_DEAD) {
> +	if (block->state == IIO_BLOCK_STATE_DEAD)
>  		iio_buffer_block_put(block);
> -	} else if (queue->active) {
> +	else if (queue->active)
>  		iio_dma_buffer_submit_block(queue, block);
> -	} else {
> +	else
>  		block->state = IIO_BLOCK_STATE_QUEUED;
> -		list_add_tail(&block->head, &queue->incoming);
> -	}
>  }
>  
>  static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
>  	struct iio_dma_buffer_queue *queue)
>  {
>  	struct iio_dma_buffer_block *block;
> +	unsigned int idx;
>  
>  	spin_lock_irq(&queue->list_lock);
> -	block = list_first_entry_or_null(&queue->outgoing, struct
> -		iio_dma_buffer_block, head);
> -	if (block != NULL) {
> -		list_del(&block->head);
> +
> +	idx = queue->fileio.next_dequeue;
> +	block = queue->fileio.blocks[idx];
> +
> +	if (block->state == IIO_BLOCK_STATE_DONE) {
>  		block->state = IIO_BLOCK_STATE_DEQUEUED;
> +		idx = (idx + 1) % ARRAY_SIZE(queue->fileio.blocks);
> +		queue->fileio.next_dequeue = idx;
> +	} else {
> +		block = NULL;
>  	}
> +
>  	spin_unlock_irq(&queue->list_lock);
>  
>  	return block;
> @@ -539,6 +537,7 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>  	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
>  	struct iio_dma_buffer_block *block;
>  	size_t data_available = 0;
> +	unsigned int i;
>  
>  	/*
>  	 * For counting the available bytes we'll use the size of the block not
> @@ -552,8 +551,15 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>  		data_available += queue->fileio.active_block->size;
>  
>  	spin_lock_irq(&queue->list_lock);
> -	list_for_each_entry(block, &queue->outgoing, head)
> -		data_available += block->size;
> +
> +	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +		block = queue->fileio.blocks[i];
> +
> +		if (block != queue->fileio.active_block
> +		    && block->state == IIO_BLOCK_STATE_DONE)
> +			data_available += block->size;
> +	}
> +
>  	spin_unlock_irq(&queue->list_lock);
>  	mutex_unlock(&queue->lock);
>  
> @@ -616,9 +622,6 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
>  	queue->dev = dev;
>  	queue->ops = ops;
>  
> -	INIT_LIST_HEAD(&queue->incoming);
> -	INIT_LIST_HEAD(&queue->outgoing);
> -
>  	mutex_init(&queue->lock);
>  	spin_lock_init(&queue->list_lock);
>  
> @@ -645,11 +648,8 @@ void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
>  			continue;
>  		queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
>  	}
> -	INIT_LIST_HEAD(&queue->outgoing);
>  	spin_unlock_irq(&queue->list_lock);
>  
> -	INIT_LIST_HEAD(&queue->incoming);
> -
>  	for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
>  		if (!queue->fileio.blocks[i])
>  			continue;
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index ff15c61bf319..d4ed5ff39d44 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -78,12 +78,15 @@ struct iio_dma_buffer_block {
>   * @active_block: Block being used in read()
>   * @pos: Read offset in the active block
>   * @block_size: Size of each block
> + * @next_dequeue: index of next block that will be dequeued
>   */
>  struct iio_dma_buffer_queue_fileio {
>  	struct iio_dma_buffer_block *blocks[2];
>  	struct iio_dma_buffer_block *active_block;
>  	size_t pos;
>  	size_t block_size;
> +
> +	unsigned int next_dequeue;
>  };
>  
>  /**
> @@ -97,8 +100,6 @@ struct iio_dma_buffer_queue_fileio {
>   *   atomic context as well as blocks on those lists. This is the outgoing queue
>   *   list and typically also a list of active blocks in the part that handles
>   *   the DMA controller
> - * @incoming: List of buffers on the incoming queue
> - * @outgoing: List of buffers on the outgoing queue
>   * @active: Whether the buffer is currently active
>   * @fileio: FileIO state
>   */
> @@ -109,8 +110,6 @@ struct iio_dma_buffer_queue {
>  
>  	struct mutex lock;
>  	spinlock_t list_lock;
> -	struct list_head incoming;
> -	struct list_head outgoing;
>  
>  	bool active;
>  

