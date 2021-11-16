Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB79452D35
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhKPIz7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhKPIz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 03:55:57 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF608C061570;
        Tue, 16 Nov 2021 00:53:00 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id m15so13098218pgu.11;
        Tue, 16 Nov 2021 00:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7ozIO2OMjSg3nLofpiXdH7GW9aQLdLtTg5yeYPp4+s=;
        b=Wxlx7IdbLwqdTB4KIf/2SPtSW9QpFdqKAvxnaQM6IzQDauYXbXL4uGY3nzouvtZjV+
         E1IYtr+zB/cpC39iBgBwmD6onNhl8hQAsjwDEGFWDPXLlDnThg9obufAIIRereYrRRFw
         LevtfJAqFPMk6PEiK3NH5b4FZm1Z1WAufuWGx9uuiGgc+tYrRApAPBrvrZKFpO2YWN/Z
         lLLmyEedg8G389sH83n3I/CxwJ0cbEJdgo137cRpOIbWOenGz6zoGT8Owv2j/DU93TYf
         d4GDt1EWUzSzuzTcKf451I0BNtfN3oOxq0hAIPNkQuuz1D9oqskZw48T1QK8qS6xpc3e
         MUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7ozIO2OMjSg3nLofpiXdH7GW9aQLdLtTg5yeYPp4+s=;
        b=IGRwtodvpCLcBpj/GKyJ5KDb0pA+JmKABEne9ZvP2749fPwm8iFx8omUz08xtfiIEz
         zzGgKQlamKspZ6SHPhHen2RF7Gm8ghCZsyYFWRzySg0fYU9RLblyLUtATRQPCc4oZTkE
         dvWqIo5AYBB9vhs4XYZF12RD27W8WGT2P5BaZJgInXKKIILl9Y3YGq9aT8bQ+tQeiec3
         UJfKroUyRoqRQivPUYzX7fmBVi+HBCJA+U8wNpOOQ+KU9ovOogVDTWQ7KG2kQw2jVBzT
         c6EXLyyWevyWTftzCuK8Sqe5uYCBuqYLYOkZuw46R1oGb3XxF72Ygm9K3ihNMI1McCe1
         1gcA==
X-Gm-Message-State: AOAM532g1YptEAnDd8m+U9eJSqWZdOpoCf4gaCVH8PJB2iOCiJE2U9MC
        NfcuZr1nHy8WD6BzETL2+o0xUowFpEl05TgQ5ABP1Xe304w=
X-Google-Smtp-Source: ABdhPJzfeTSzJszrtnpjhYFcQpwvngnEOczcizp9WRmuXToIqd69035gfjrmX5uo39JsX+QptwOQ6vXgXf/366gsXSc=
X-Received: by 2002:a63:584e:: with SMTP id i14mr3791695pgm.356.1637052780269;
 Tue, 16 Nov 2021 00:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115141925.60164-5-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-5-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 10:52:48 +0200
Message-ID: <CA+U=DsrNb=PYvfqd4c9UFTZpK8RrzSBoneCzz3j0KL5YWUKERg@mail.gmail.com>
Subject: Re: [PATCH 04/15] iio: buffer-dma: Enable buffer write support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 4:19 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
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

A few comments inline from me.
Otherwise fine from me.


Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>



> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 75 +++++++++++++++-----
>  include/linux/iio/buffer-dma.h               |  7 ++
>  2 files changed, 66 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index abac88f20104..eeeed6b2e0cf 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -179,7 +179,8 @@ static struct iio_dma_buffer_block *iio_dma_buffer_alloc_block(
>         }
>
>         block->size = size;
> -       block->state = IIO_BLOCK_STATE_DEQUEUED;
> +       block->bytes_used = size;
> +       block->state = IIO_BLOCK_STATE_DONE;

This initial state change looks like it could use a comment in the git log.
Maybe it's fine, but I can't remember 100% about it.

>         block->queue = queue;
>         INIT_LIST_HEAD(&block->head);
>         kref_init(&block->kref);
> @@ -195,6 +196,18 @@ static void _iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
>                 block->state = IIO_BLOCK_STATE_DONE;
>  }
>
> +static void iio_dma_buffer_queue_wake(struct iio_dma_buffer_queue *queue)
> +{
> +       __poll_t flags;
> +
> +       if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
> +               flags = EPOLLIN | EPOLLRDNORM;
> +       else
> +               flags = EPOLLOUT | EPOLLWRNORM;
> +
> +       wake_up_interruptible_poll(&queue->buffer.pollq, flags);
> +}
> +
>  /**
>   * iio_dma_buffer_block_done() - Indicate that a block has been completed
>   * @block: The completed block
> @@ -212,7 +225,7 @@ void iio_dma_buffer_block_done(struct iio_dma_buffer_block *block)
>         spin_unlock_irqrestore(&queue->list_lock, flags);
>
>         iio_buffer_block_put_atomic(block);
> -       wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
> +       iio_dma_buffer_queue_wake(queue);
>  }
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_block_done);
>
> @@ -241,7 +254,7 @@ void iio_dma_buffer_block_list_abort(struct iio_dma_buffer_queue *queue,
>         }
>         spin_unlock_irqrestore(&queue->list_lock, flags);
>
> -       wake_up_interruptible_poll(&queue->buffer.pollq, EPOLLIN | EPOLLRDNORM);
> +       iio_dma_buffer_queue_wake(queue);
>  }
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_block_list_abort);
>
> @@ -334,7 +347,8 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>                         queue->fileio.blocks[i] = block;
>                 }
>
> -               block->state = IIO_BLOCK_STATE_QUEUED;
> +               if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN)
> +                       block->state = IIO_BLOCK_STATE_QUEUED;
>         }
>
>  out_unlock:
> @@ -467,20 +481,12 @@ static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
>         return block;
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
> -       char __user *user_buffer)
> +static int iio_dma_buffer_io(struct iio_buffer *buffer,
> +                            size_t n, char __user *user_buffer, bool is_write)
>  {
>         struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
>         struct iio_dma_buffer_block *block;
> +       void *addr;
>         int ret;
>
>         if (n < buffer->bytes_per_datum)
> @@ -503,8 +509,13 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>         n = rounddown(n, buffer->bytes_per_datum);
>         if (n > block->bytes_used - queue->fileio.pos)
>                 n = block->bytes_used - queue->fileio.pos;
> +       addr = block->vaddr + queue->fileio.pos;
>
> -       if (copy_to_user(user_buffer, block->vaddr + queue->fileio.pos, n)) {
> +       if (is_write)
> +               ret = !!copy_from_user(addr, user_buffer, n);
> +       else
> +               ret = !!copy_to_user(user_buffer, addr, n);
> +       if (ret) {
>                 ret = -EFAULT;
>                 goto out_unlock;
>         }
> @@ -513,6 +524,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>
>         if (queue->fileio.pos == block->bytes_used) {
>                 queue->fileio.active_block = NULL;
> +               block->bytes_used = block->size;
>                 iio_dma_buffer_enqueue(queue, block);
>         }
>
> @@ -523,8 +535,39 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>
>         return ret;
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
> +       char __user *user_buffer)
> +{
> +       return iio_dma_buffer_io(buffer, n, user_buffer, false);
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
> +                        const char __user *user_buffer)
> +{
> +       return iio_dma_buffer_io(buffer, n, (__force char *)user_buffer, true);
> +}
> +EXPORT_SYMBOL_GPL(iio_dma_buffer_write);
> +
>  /**
>   * iio_dma_buffer_data_available() - DMA buffer data_available callback
>   * @buf: Buffer to check for data availability
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index a65a005c4a19..09c07d5563c0 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -132,6 +132,8 @@ int iio_dma_buffer_disable(struct iio_buffer *buffer,
>         struct iio_dev *indio_dev);
>  int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>         char __user *user_buffer);
> +int iio_dma_buffer_write(struct iio_buffer *buffer, size_t n,
> +                        const char __user *user_buffer);
>  size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
>  int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
>  int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
> @@ -142,4 +144,9 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
>  void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue);
>  void iio_dma_buffer_release(struct iio_dma_buffer_queue *queue);
>
> +static inline size_t iio_dma_buffer_space_available(struct iio_buffer *buffer)
> +{
> +       return iio_dma_buffer_data_available(buffer);
> +}

Maybe re-using iio_dma_buffer_data_available() (and updating the
return type) would have been a little neater than wrapping this.
Also fine like this though.

> +
>  #endif
> --
> 2.33.0
>
