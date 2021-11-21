Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01CE45855D
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 18:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhKURWx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 21 Nov 2021 12:22:53 -0500
Received: from aposti.net ([89.234.176.197]:57646 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235965AbhKURWx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 12:22:53 -0500
Date:   Sun, 21 Nov 2021 17:19:32 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 04/15] iio: buffer-dma: Enable buffer write support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?b?S/ZuaWc=?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Message-Id: <KSMX2R.V0Q6PW6OC9Q62@crapouillou.net>
In-Reply-To: <20211121142049.2d000c04@jic23-huawei>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115141925.60164-5-paul@crapouillou.net>
        <20211121142049.2d000c04@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Le dim., nov. 21 2021 at 14:20:49 +0000, Jonathan Cameron 
<jic23@kernel.org> a écrit :
> On Mon, 15 Nov 2021 14:19:14 +0000
> Paul Cercueil <paul@crapouillou.net> wrote:
> 
>>  Adding write support to the buffer-dma code is easy - the write()
>>  function basically needs to do the exact same thing as the read()
>>  function: dequeue a block, read or write the data, enqueue the block
>>  when entirely processed.
>> 
>>  Therefore, the iio_buffer_dma_read() and the new 
>> iio_buffer_dma_write()
>>  now both call a function iio_buffer_dma_io(), which will perform 
>> this
>>  task.
>> 
>>  The .space_available() callback can return the exact same value as 
>> the
>>  .data_available() callback for input buffers, since in both cases we
>>  count the exact same thing (the number of bytes in each available
>>  block).
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Hi Paul,
> 
> There are a few changes in here, such as the bytes_used value being 
> set that
> I'm not following the reasoning behind. More info on those?
> Also good to provide something about those in this patch description.
> 
> Thanks,
> 
> Jonathan
> 
> 
>>  ---
>>   drivers/iio/buffer/industrialio-buffer-dma.c | 75 
>> +++++++++++++++-----
>>   include/linux/iio/buffer-dma.h               |  7 ++
>>   2 files changed, 66 insertions(+), 16 deletions(-)
>> 
>>  diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c 
>> b/drivers/iio/buffer/industrialio-buffer-dma.c
>>  index abac88f20104..eeeed6b2e0cf 100644
>>  --- a/drivers/iio/buffer/industrialio-buffer-dma.c
>>  +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
>>  @@ -179,7 +179,8 @@ static struct iio_dma_buffer_block 
>> *iio_dma_buffer_alloc_block(
>>   	}
>> 
>>   	block->size = size;
>>  -	block->state = IIO_BLOCK_STATE_DEQUEUED;
>>  +	block->bytes_used = size;
>>  +	block->state = IIO_BLOCK_STATE_DONE;
> 
> I don't know why these are here - some more info?

When using an input buffer the block->bytes_used is unconditionally 
reset in iio_dmaengine_buffer_submit_block(), so this was fine until 
now.

When using an output buffer the block->bytes_used can actually (with 
the new API) be specified by the user, so we don't want 
iio_dmaengine_buffer_submit_block() to unconditionally override it. 
Which means that in the case where we have an output buffer in fileio 
mode, we do need block->bytes_used to be initialized to the buffer's 
size since it won't be set anywhere else.

About the change in block->state: in patch [01/15] we removed the 
incoming/outgoing queues, and while the "enqueued" state is still 
useful to know which buffers have to be submitted when the buffer is 
enabled, the "dequeued" state is not useful anymore since there is no 
more distinction vs. the "done" state.

I believe this change should be moved to patch [01/15] then, and I 
should go further and remove the IIO_BLOCK_STATE_DEQUEUED completely.

>>   	block->queue = queue;
>>   	INIT_LIST_HEAD(&block->head);
>>   	kref_init(&block->kref);
>>  @@ -195,6 +196,18 @@ static void _iio_dma_buffer_block_done(struct 
>> iio_dma_buffer_block *block)
>>   		block->state = IIO_BLOCK_STATE_DONE;
>>   }
>> 
>>  +static void iio_dma_buffer_queue_wake(struct iio_dma_buffer_queue 
>> *queue)
>>  +{
>>  +	__poll_t flags;
>>  +
>>  +	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
>>  +		flags = EPOLLIN | EPOLLRDNORM;
>>  +	else
>>  +		flags = EPOLLOUT | EPOLLWRNORM;
>>  +
>>  +	wake_up_interruptible_poll(&queue->buffer.pollq, flags);
>>  +}
>>  +
>>   /**
>>    * iio_dma_buffer_block_done() - Indicate that a block has been 
>> completed
>>    * @block: The completed block
>>  @@ -212,7 +225,7 @@ void iio_dma_buffer_block_done(struct 
>> iio_dma_buffer_block *block)
>>   	spin_unlock_irqrestore(&queue->list_lock, flags);
>> 
>>   	iio_buffer_block_put_atomic(block);
>>  -	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | 
>> EPOLLRDNORM);
>>  +	iio_dma_buffer_queue_wake(queue);
>>   }
>>   EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
>> 
>>  @@ -241,7 +254,7 @@ void iio_dma_buffer_block_list_abort(struct 
>> iio_dma_buffer_queue *queue,
>>   	}
>>   	spin_unlock_irqrestore(&queue->list_lock, flags);
>> 
>>  -	wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | 
>> EPOLLRDNORM);
>>  +	iio_dma_buffer_queue_wake(queue);
>>   }
>>   EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
>> 
>>  @@ -334,7 +347,8 @@ int iio_dma_buffer_request_update(struct 
>> iio_buffer *buffer)
>>   			queue->fileio.blocks[i] = block;
>>   		}
>> 
>>  -		block->state = IIO_BLOCK_STATE_QUEUED;
>>  +		if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
>>  +			block->state = IIO_BLOCK_STATE_QUEUED;
> 
> Possibly worth a comment on the state being set here.  I figured it 
> out, but might
> save some brain cells in future if it's stated in the code.

Ok.

>>   	}
>> 
>>   out_unlock:
>>  @@ -467,20 +481,12 @@ static struct iio_dma_buffer_block 
>> *iio_dma_buffer_dequeue(
>>   	return block;
>>   }
>> 
>>  -/**
>>  - * iio_dma_buffer_read() - DMA buffer read callback
>>  - * @buffer: Buffer to read form
>>  - * @n: Number of bytes to read
>>  - * @user_buffer: Userspace buffer to copy the data to
>>  - *
>>  - * Should be used as the read callback for iio_buffer_access_ops
>>  - * struct for DMA buffers.
>>  - */
>>  -int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>>  -	char __user *user_buffer)
>>  +static int iio_dma_buffer_io(struct iio_buffer *buffer,
>>  +			     size_t n, char __user *user_buffer, bool is_write)
>>   {
>>   	struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
>>   	struct iio_dma_buffer_block *block;
>>  +	void *addr;
>>   	int ret;
>> 
>>   	if (n < buffer->bytes_per_datum)
>>  @@ -503,8 +509,13 @@ int iio_dma_buffer_read(struct iio_buffer 
>> *buffer, size_t n,
>>   	n = rounddown(n, buffer->bytes_per_datum);
>>   	if (n > block->bytes_used - queue->fileio.pos)
>>   		n = block->bytes_used - queue->fileio.pos;
>>  +	addr = block->vaddr + queue->fileio.pos;
>> 
>>  -	if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, 
>> n)) {
>>  +	if (is_write)
>>  +		ret = !!copy_from_user(addr, user_buffer, n);
>>  +	else
>>  +		ret = !!copy_to_user(user_buffer, addr, n);
> 
> What is the !! gaining us here?  We only care about == 0 vs != 0 so
> forcing it to be 0 or 1 isn't useful.

Right.

>>  +	if (ret) {
>>   		ret = -EFAULT;
>>   		goto out_unlock;
>>   	}
>>  @@ -513,6 +524,7 @@ int iio_dma_buffer_read(struct iio_buffer 
>> *buffer, size_t n,
>> 
>>   	if (queue->fileio.pos == block->bytes_used) {
>>   		queue->fileio.active_block = NULL;
>>  +		block->bytes_used = block->size;
> 
> This seems to be a functional change that isn't called out in the 
> patch description.

See the explanation above. Although I most likely don't need to set it 
at two different spots... I'll check that in detail next week.

Cheers,
-Paul

>>   		iio_dma_buffer_enqueue(queue, block);
>>   	}
>> 
>>  @@ -523,8 +535,39 @@ int iio_dma_buffer_read(struct iio_buffer 
>> *buffer, size_t n,
>> 
>>   	return ret;
>>   }
>>  +
>>  +/**
>>  + * iio_dma_buffer_read() - DMA buffer read callback
>>  + * @buffer: Buffer to read form
>>  + * @n: Number of bytes to read
>>  + * @user_buffer: Userspace buffer to copy the data to
>>  + *
>>  + * Should be used as the read callback for iio_buffer_access_ops
>>  + * struct for DMA buffers.
>>  + */
>>  +int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>>  +	char __user *user_buffer)
>>  +{
>>  +	return iio_dma_buffer_io(buffer, n, user_buffer, false);
>>  +}
>>   EXPORT_SYMBOL_GPL(iio_dma_buffer_read);
>> 
>>  +/**
>>  + * iio_dma_buffer_write() - DMA buffer write callback
>>  + * @buffer: Buffer to read form
>>  + * @n: Number of bytes to read
>>  + * @user_buffer: Userspace buffer to copy the data from
>>  + *
>>  + * Should be used as the write callback for iio_buffer_access_ops
>>  + * struct for DMA buffers.
>>  + */
>>  +int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
>>  +			 const char __user *user_buffer)
>>  +{
>>  +	return iio_dma_buffer_io(buffer, n, (__force char *)user_buffer, 
>> true);
>>  +}
>>  +EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
>>  +
>>   /**
>>    * iio_dma_buffer_data_available() - DMA buffer data_available 
>> callback
>>    * @buf: Buffer to check for data availability
>>  diff --git a/include/linux/iio/buffer-dma.h 
>> b/include/linux/iio/buffer-dma.h
>>  index a65a005c4a19..09c07d5563c0 100644
>>  --- a/include/linux/iio/buffer-dma.h
>>  +++ b/include/linux/iio/buffer-dma.h
>>  @@ -132,6 +132,8 @@ int iio_dma_buffer_disable(struct iio_buffer 
>> *buffer,
>>   	struct iio_dev *indio_dev);
>>   int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>>   	char __user *user_buffer);
>>  +int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
>>  +			 const char __user *user_buffer);
>>   size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
>>   int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, 
>> size_t bpd);
>>   int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned 
>> int length);
>>  @@ -142,4 +144,9 @@ int iio_dma_buffer_init(struct 
>> iio_dma_buffer_queue *queue,
>>   void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
>>   void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
>> 
>>  +static inline size_t iio_dma_buffer_space_available(struct 
>> iio_buffer *buffer)
>>  +{
>>  +	return iio_dma_buffer_data_available(buffer);
>>  +}
>>  +
>>   #endif
> 


