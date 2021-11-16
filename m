Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC46E452FA1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 11:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhKPLCj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 06:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhKPLCj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 06:02:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689AC061570;
        Tue, 16 Nov 2021 02:59:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gt5so15435235pjb.1;
        Tue, 16 Nov 2021 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwJhNR6UVdEygqQ3NpO69n0AQg/9IjTmtT9BR0BsSDI=;
        b=Ewo6F1PsoUATgegT2NT/vHjl4DaF6x4zbQJuhePSSwF02g7aOM2Yf8SfftPULxqGWb
         quKiwGUIxf66Hvhwjajfdk1ONoIuiveXYuYJTVCeEV3mUozKT5yqZ3JXQdLfj3M7T8MI
         sl/U5SZMu3dlB7PgIxkJoD7I2znL/BzyjiKYFbJpsc7LwU2IPJziT4XwpVvAyRLWbVBj
         Ven6aMsVKtXJWC8fBqmcLJ3L0OfZuW/Qepe5GYTgSfTPIOlzb6kRmKig2Mt9UyevelFT
         wC4pKvWZNCYgrQ+n1/MRcKToyiSYV9R8o71Ewy5kROAWV+tReK+1R3sfvDXzSDFOBvYJ
         twVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwJhNR6UVdEygqQ3NpO69n0AQg/9IjTmtT9BR0BsSDI=;
        b=d/nFlipeXurA6KHz87CKLMEKZaeKVsPKu3PKXLHeip748bhaAcjJ9bwF5uCstjYNg4
         cbT40JjvmAa8YtTRHpahepcU5nLHFQIRtK+8dJF9AaWJCBFjHIbPWZPK3bknPACLlvAi
         JDG54d9hbWqylY8o87ZuzP3AQq/qXmJgaIs9OKO0T52eYzHu7DFfMKFHBLohE4u+ov1J
         khk88N0xt35x9QWrzXZ7tuHAVAGqdQD9+ChWz8Me2GciOZ79d8nXTwF+jIETbLPsKAYM
         vPQmxRxiO9eN8qTsHWnRVvsfHTYlDBE7F2KxVMsh/9vSUABmb4Y5tyGgvFwqTWOm9kgH
         JxHw==
X-Gm-Message-State: AOAM530Xq5VqtbUh3JiwmZTntG7JEQfh5Bs5ttOY2y/eKKnDnTPYlW8L
        R4dECrrKaCHXRRmBem07qjcNd8P+6q7tvZl0i/0=
X-Google-Smtp-Source: ABdhPJyrFmZgydacRbJ7ebXIcokEPtXardd6vRzH+DpmfljRBpWz4sIfT768ZJCEn/wLoeBC7NJdLfjfnps2MQuvAJ0=
X-Received: by 2002:a17:90a:e54c:: with SMTP id ei12mr73995641pjb.81.1637060382020;
 Tue, 16 Nov 2021 02:59:42 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115141925.60164-9-paul@crapouillou.net>
In-Reply-To: <20211115141925.60164-9-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 12:59:30 +0200
Message-ID: <CA+U=DsqP0Wg54xgL3_-SmRc2v0GXQv9fDf=350P+sLvJhhYnng@mail.gmail.com>
Subject: Re: [PATCH 08/15] iio: buffer-dma: split iio_dma_buffer_fileio_free() function
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 15, 2021 at 4:20 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> A part of the logic in the iio_dma_buffer_exit() is required for the change
> to add mmap support to IIO buffers.
> This change splits the logic into a separate function, which will be
> re-used later.
>

Not sure how the protocol is here, since my old @analog.com email
isn't working anymore.

But:

Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>

Thanks :)
Alex

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 39 +++++++++++---------
>  1 file changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index eeeed6b2e0cf..eb8cfd3af030 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -358,6 +358,27 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
>  }
>  EXPORT_SYMBOL_GPL(iio_dma_buffer_request_update);
>
> +static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
> +{
> +       unsigned int i;
> +
> +       spin_lock_irq(&queue->list_lock);
> +       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +               if (!queue->fileio.blocks[i])
> +                       continue;
> +               queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> +       }
> +       spin_unlock_irq(&queue->list_lock);
> +
> +       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> +               if (!queue->fileio.blocks[i])
> +                       continue;
> +               iio_buffer_block_put(queue->fileio.blocks[i]);
> +               queue->fileio.blocks[i] = NULL;
> +       }
> +       queue->fileio.active_block = NULL;
> +}
> +
>  static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>         struct iio_dma_buffer_block *block)
>  {
> @@ -681,25 +702,9 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_init);
>   */
>  void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
>  {
> -       unsigned int i;
> -
>         mutex_lock(&queue->lock);
>
> -       spin_lock_irq(&queue->list_lock);
> -       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> -               if (!queue->fileio.blocks[i])
> -                       continue;
> -               queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> -       }
> -       spin_unlock_irq(&queue->list_lock);
> -
> -       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> -               if (!queue->fileio.blocks[i])
> -                       continue;
> -               iio_buffer_block_put(queue->fileio.blocks[i]);
> -               queue->fileio.blocks[i] = NULL;
> -       }
> -       queue->fileio.active_block = NULL;
> +       iio_dma_buffer_fileio_free(queue);
>         queue->ops = NULL;
>
>         mutex_unlock(&queue->lock);
> --
> 2.33.0
>
