Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A744E9D3A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbiC1RSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbiC1RSR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 13:18:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAF262122;
        Mon, 28 Mar 2022 10:16:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E811B81123;
        Mon, 28 Mar 2022 17:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077F5C34100;
        Mon, 28 Mar 2022 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648487793;
        bh=7/PboG33OIqzdypfO/o8d8wuwlx5CdgNBv1hZS48BT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KyFI9A4n86BFioR3tiaZuphvFDmuCaBuokvDyYldUtnhZECJHQVzrk0b2x12Ksncu
         4vCY67FLNTvmRjtedj5R5BRKPsId2jXOv7T7wfAaHD170RYk2/cnHwGCHFJeKpshrv
         2uiE4RIjwWekFGgjzRe1vswFFE3hK22oOgQj8Wr2yo5j1+Ufrvn9ZQQlBUsWVDjKQR
         hXNILyg8VU8hx01EZc+kQUkHGlGoEpZPMeYYZvLGVqTNw4HIo2oGHUnmAmcTq2buzY
         eR78uXKSOqoHv8TGFQTnj7DC5zCoMZYiMS+UMZzNJjCWGIzQ7GNYW8J9cpQpUArRxA
         cv7JQYiAJrAqA==
Date:   Mon, 28 Mar 2022 18:24:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/12] iio: buffer-dma: Enable buffer write support
Message-ID: <20220328182409.1e959386@jic23-huawei>
In-Reply-To: <20220207125933.81634-3-paul@crapouillou.net>
References: <20220207125933.81634-1-paul@crapouillou.net>
        <20220207125933.81634-3-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Feb 2022 12:59:23 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Adding write support to the buffer-dma code is easy - the write()
> function basically needs to do the exact same thing as the read()
> function: dequeue a block, read or write the data, enqueue the block
> when entirely processed.
> 
> Therefore, the iio_buffer_dma_read() and the new iio_buffer_dma_write()
> now both call a function iio_buffer_dma_io(), which will perform this
> task.
> 
> The .space_available() callback can return the exact same value as the
> .data_available() callback for input buffers, since in both cases we
> count the exact same thing (the number of bytes in each available
> block).
> 
> Note that we preemptively reset block->bytes_used to the buffer's size
> in iio_dma_buffer_request_update(), as in the future the
> iio_dma_buffer_enqueue() function won't reset it.
> 
> v2: - Fix block->state not being reset in
>       iio_dma_buffer_request_update() for output buffers.
>     - Only update block->bytes_used once and add a comment about why we
>       update it.
>     - Add a comment about why we're setting a different state for output
>       buffers in iio_dma_buffer_request_update()
>     - Remove useless cast to bool (!!) in iio_dma_buffer_io()
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
One comment inline.

I'd be tempted to queue this up with that fixed, but do we have
any users?  Even though it's trivial I'm not that keen on code
upstream well in advance of it being used.

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 88 ++++++++++++++++----
>  include/linux/iio/buffer-dma.h               |  7 ++
>  2 files changed, 79 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index 1fc91467d1aa..a9f1b673374f 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -195,6 +195,18 @@ static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
>  		block->state = IIO_BLOCK_STATE_DONE;
>  }
>  
> +static void iio_dma_buffer_queue_wake(struct iio_dma_buffer_queue *queue)
> +{
> +	__poll_t flags;
> +
> +	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
> +		flags = EPOLLIN | EPOLLRDNORM;
> +	else
> +		flags = EPOLLOUT | EPOLLWRNORM;
> +
> +	wake_up_interruptible_poll(&queue->buffer.pollq, flags);
> +}
> +
>  /**
>   * iio_dma_buffer_block_done() - Indicate that a block has been completed
>   * @block: The completed block
> @@ -212,7 +224,7 @@ void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
>  	spin_unlock_irqrestore(&queue->list_lock, flags);
>  
>  	iio_buffer_block_put_atomic(block);
> -	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
> +	iio_dma_buffer_queue_wake(queue);
>  }
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
>  
> @@ -241,7 +253,7 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
>  	}
>  	spin_unlock_irqrestore(&queue->list_lock, flags);
>  
> -	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
> +	iio_dma_buffer_queue_wake(queue);
>  }
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
>  
> @@ -335,8 +347,24 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  			queue->fileio.blocks[i] = block;
>  		}
>  
> -		block->state = IIO_BLOCK_STATE_QUEUED;
> -		list_add_tail(&block->head, &queue->incoming);
> +		/*
> +		 * block->bytes_used may have been modified previously, e.g. by
> +		 * iio_dma_buffer_block_list_abort(). Reset it here to the
> +		 * block's so that iio_dma_buffer_io() will work.
> +		 */
> +		block->bytes_used = block->size;
> +
> +		/*
> +		 * If it's an input buffer, mark the block as queued, and
> +		 * iio_dma_buffer_enable() will submit it. Otherwise mark it as
> +		 * done, which means it's ready to be dequeued.
> +		 */
> +		if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
> +			block->state = IIO_BLOCK_STATE_QUEUED;
> +			list_add_tail(&block->head, &queue->incoming);
> +		} else {
> +			block->state = IIO_BLOCK_STATE_DONE;
> +		}
>  	}
>  
>  out_unlock:
> @@ -465,20 +493,12 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
>  	return block;
>  }
>  
> -/**
> - * iio_dma_buffer_read() - DMA buffer read callback
> - * @buffer: Buffer to read form
> - * @n: Number of bytes to read
> - * @user_buffer: Userspace buffer to copy the data to
> - *
> - * Should be used as the read callback for iio_buffer_access_ops
> - * struct for DMA buffers.
> - */
> -int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> -	char __user *user_buffer)
> +static int iio_dma_buffer_io(struct iio_buffer *buffer,
> +			     size_t n, char __user *user_buffer, bool is_write)
>  {
>  	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
>  	struct iio_dma_buffer_block *block;
> +	void *addr;
>  	int ret;
>  
>  	if (n < buffer->bytes_per_datum)
> @@ -501,8 +521,13 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>  	n = rounddown(n, buffer->bytes_per_datum);
>  	if (n > block->bytes_used - queue->fileio.pos)
>  		n = block->bytes_used - queue->fileio.pos;
> +	addr = block->vaddr + queue->fileio.pos;
>  
> -	if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, n)) {
> +	if (is_write)
> +		ret = copy_from_user(addr, user_buffer, n);
> +	else
> +		ret = copy_to_user(user_buffer, addr, n);
> +	if (ret) {
>  		ret = -EFAULT;
>  		goto out_unlock;
>  	}
> @@ -521,8 +546,39 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>  
>  	return ret;
>  }
> +
> +/**
> + * iio_dma_buffer_read() - DMA buffer read callback
> + * @buffer: Buffer to read form
> + * @n: Number of bytes to read
> + * @user_buffer: Userspace buffer to copy the data to
> + *
> + * Should be used as the read callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
> +	char __user *user_buffer)
> +{
> +	return iio_dma_buffer_io(buffer, n, user_buffer, false);
> +}
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
>  
> +/**
> + * iio_dma_buffer_write() - DMA buffer write callback
> + * @buffer: Buffer to read form
> + * @n: Number of bytes to read
> + * @user_buffer: Userspace buffer to copy the data from
> + *
> + * Should be used as the write callback for iio_buffer_access_ops
> + * struct for DMA buffers.
> + */
> +int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
> +			 const char __user *user_buffer)
> +{
> +	return iio_dma_buffer_io(buffer, n, (__force char *)user_buffer, true);

Casting away the const is a little nasty.   Perhaps it's worth adding a
parameter to iio_dma_buffer_io so you can have different parameters
for the read and write cases and hence keep the const in place?
return iio_dma_buffer_io(buffer, n, NULL, user_buffer, true);
and
return iio_dma_buffer_io(buffer,n, user_buffer, NULL, false);

> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
> +
>  /**
>   * iio_dma_buffer_data_available() - DMA buffer data_available callback
>   * @buf: Buffer to check for data availability
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 18d3702fa95d..490b93f76fa8 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -132,6 +132,8 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
>  	struct iio_dev *indio_dev);
>  int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>  	char __user *user_buffer);
> +int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
> +			 const char __user *user_buffer);
>  size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
>  int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
>  int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
> @@ -142,4 +144,9 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
>  void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
>  void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
>  
> +static inline size_t iio_dma_buffer_space_available(struct iio_buffer *buffer)
> +{
> +	return iio_dma_buffer_data_available(buffer);
> +}
> +
>  #endif

