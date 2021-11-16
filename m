Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30903452CA3
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 09:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhKPI02 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 03:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhKPI02 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 03:26:28 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09FEC061570;
        Tue, 16 Nov 2021 00:23:31 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u11so16792246plf.3;
        Tue, 16 Nov 2021 00:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSjQ9jafB/VFi3/bAW7yuqbaBiErG/FKqUEAhVEpKXs=;
        b=mVBGUbZmJMF5+AdErkQ+7iNd03BI+h46tIEJa6NYkfIyWQOPqPQU+3SXHQbmkS9o4u
         HtXtnDc9kOP7047dD/s6LsZ2THQlVSSqs0gyHMOA5GBZzFsD7d0usv0uFenZITUNdt4D
         mc6HLm6gQKevuriAjVeC2XxYOOyoswjmGy+e2G/7jD1ZGfsp5O96u4ACQnAO1Rhy1ybg
         b0i8iIm3kGhPGyn4VOZ5V/oDoJ2yAMuSb2J/ic8sf1xPivFhYHb8/+y3hyaaNUPPJm3d
         A6c9cKt8HbQnbiGrMsKHGFF3fDWDXh67QjwyzLysJTwMTBLdBhL89IwvZI26qsM580S8
         6sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSjQ9jafB/VFi3/bAW7yuqbaBiErG/FKqUEAhVEpKXs=;
        b=Y5LuIw1BxgL0hJH19KyDc3olnPYkgW2TftXIyY2Cb8KGfC606DFyq8MbC9/w1+DP8Y
         /T56kzWPeHFANDHgIfTK4spMfbKDRkRzzTnp/Xst/eTDfvX4bwzgL8+c7391QELUvGeZ
         WSDCnEIr3UkyyzYcHV+BbBtGbdk4LUdM+jsI1AaGI9tadXVYJDRLTSYVyCy62olZKWkT
         Tv+vlkPLWdFkJbdt/T3xQrbN8Y3EYaQUpRO5lRumB5oy+vZd/w9IbPYdvy/gVRzJXV1+
         Bf6O/fpgS81txP1z+7H4VynkS50eUtxV9hYfHr9gUVlcbcxRDoqIkOCY4E6jY4s8DbFD
         mJrg==
X-Gm-Message-State: AOAM531xxjxPd5S63ooTkKbx2x6FfSotkf4maXNM/msYSxabvMoGmcTS
        RrpSyecR+HXlbIP849ZSHlM2P/c9Cs45rG78ju0=
X-Google-Smtp-Source: ABdhPJyhbjWk4xbYynOYBmsMeBuaCIFgHYTXvMzj0WoFi7C72fcR6wNrePMxB2asWRlDwpNdg3x0Ef6Fhp88UgpNQhU=
X-Received: by 2002:a17:90a:e54c:: with SMTP id ei12mr72973286pjb.81.1637051011090;
 Tue, 16 Nov 2021 00:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115141925.60164-2-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-2-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 10:23:19 +0200
Message-ID: <CA+U=DsrdB=LMdLZbSq1GeB0jsLAP08TZk6O=RgtN8ASf7fFzrQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] iio: buffer-dma: Get rid of incoming/outgoing queues
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

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
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
> -       struct iio_dma_buffer_queue *queue = block->queue;
> -
> -       /*
> -        * The buffer has already been freed by the application, just drop the
> -        * reference.
> -        */
> -       if (block->state != IIO_BLOCK_STATE_DEAD) {
> +       if (block->state != IIO_BLOCK_STATE_DEAD)
>                 block->state = IIO_BLOCK_STATE_DONE;
> -               list_add_tail(&block->head, &queue->outgoing);
> -       }
>  }
>
>  /**
> @@ -317,11 +309,8 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>          * dead. This means we can reset the lists without having to fear
>          * corrution.
>          */
> -       INIT_LIST_HEAD(&queue->outgoing);
>         spin_unlock_irq(&queue->list_lock);
>
> -       INIT_LIST_HEAD(&queue->incoming);
> -
>         for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
>                 if (queue->fileio.blocks[i]) {
>                         block = queue->fileio.blocks[i];
> @@ -346,7 +335,6 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>                 }
>
>                 block->state = IIO_BLOCK_STATE_QUEUED;
> -               list_add_tail(&block->head, &queue->incoming);
>         }
>
>  out_unlock:
> @@ -401,13 +389,18 @@ int iio_dma_buffer_enable(struct iio_buffer *buffer,
>         struct iio_dev *indio_dev)
>  {
>         struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buffer);
> -       struct iio_dma_buffer_block *block, *_block;
> +       struct iio_dma_buffer_block *block;
> +       unsigned int i;
>
>         mutex_lock(&queue->lock);
>         queue->active = true;
> -       list_for_each_entry_safe(block, _block, &queue->incoming, head) {
> -               list_del(&block->head);
> -               iio_dma_buffer_submit_block(queue, block);
> +       queue->fileio.next_dequeue = 0;
> +
> +       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +               block = queue->fileio.blocks[i];
> +
> +               if (block->state == IIO_BLOCK_STATE_QUEUED)
> +                       iio_dma_buffer_submit_block(queue, block);
>         }
>         mutex_unlock(&queue->lock);
>
> @@ -442,28 +435,33 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_disable);
>  static void iio_dma_buffer_enqueue(struct iio_dma_buffer_queue *queue,
>         struct iio_dma_buffer_block *block)
>  {
> -       if (block->state == IIO_BLOCK_STATE_DEAD) {
> +       if (block->state == IIO_BLOCK_STATE_DEAD)
>                 iio_buffer_block_put(block);
> -       } else if (queue->active) {
> +       else if (queue->active)
>                 iio_dma_buffer_submit_block(queue, block);
> -       } else {
> +       else
>                 block->state = IIO_BLOCK_STATE_QUEUED;
> -               list_add_tail(&block->head, &queue->incoming);
> -       }
>  }
>
>  static struct iio_dma_buffer_block *iio_dma_buffer_dequeue(
>         struct iio_dma_buffer_queue *queue)
>  {
>         struct iio_dma_buffer_block *block;
> +       unsigned int idx;
>
>         spin_lock_irq(&queue->list_lock);
> -       block = list_first_entry_or_null(&queue->outgoing, struct
> -               iio_dma_buffer_block, head);
> -       if (block != NULL) {
> -               list_del(&block->head);
> +
> +       idx = queue->fileio.next_dequeue;
> +       block = queue->fileio.blocks[idx];
> +
> +       if (block->state == IIO_BLOCK_STATE_DONE) {
>                 block->state = IIO_BLOCK_STATE_DEQUEUED;
> +               idx = (idx + 1) % ARRAY_SIZE(queue->fileio.blocks);
> +               queue->fileio.next_dequeue = idx;
> +       } else {
> +               block = NULL;
>         }
> +
>         spin_unlock_irq(&queue->list_lock);
>
>         return block;
> @@ -539,6 +537,7 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>         struct iio_dma_buffer_queue *queue = iio_buffer_to_queue(buf);
>         struct iio_dma_buffer_block *block;
>         size_t data_available = 0;
> +       unsigned int i;
>
>         /*
>          * For counting the available bytes we'll use the size of the block not
> @@ -552,8 +551,15 @@ size_t iio_dma_buffer_data_available(struct iio_buffer *buf)
>                 data_available += queue->fileio.active_block->size;
>
>         spin_lock_irq(&queue->list_lock);
> -       list_for_each_entry(block, &queue->outgoing, head)
> -               data_available += block->size;
> +
> +       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +               block = queue->fileio.blocks[i];
> +
> +               if (block != queue->fileio.active_block
> +                   && block->state == IIO_BLOCK_STATE_DONE)
> +                       data_available += block->size;
> +       }
> +
>         spin_unlock_irq(&queue->list_lock);
>         mutex_unlock(&queue->lock);
>
> @@ -616,9 +622,6 @@ int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
>         queue->dev = dev;
>         queue->ops = ops;
>
> -       INIT_LIST_HEAD(&queue->incoming);
> -       INIT_LIST_HEAD(&queue->outgoing);
> -
>         mutex_init(&queue->lock);
>         spin_lock_init(&queue->list_lock);
>
> @@ -645,11 +648,8 @@ void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
>                         continue;
>                 queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
>         }
> -       INIT_LIST_HEAD(&queue->outgoing);
>         spin_unlock_irq(&queue->list_lock);
>
> -       INIT_LIST_HEAD(&queue->incoming);
> -
>         for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
>                 if (!queue->fileio.blocks[i])
>                         continue;
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
>         struct iio_dma_buffer_block *blocks[2];
>         struct iio_dma_buffer_block *active_block;
>         size_t pos;
>         size_t block_size;
> +
> +       unsigned int next_dequeue;
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
>         struct mutex lock;
>         spinlock_t list_lock;
> -       struct list_head incoming;
> -       struct list_head outgoing;
>
>         bool active;
>
> --
> 2.33.0
>
