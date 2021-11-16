Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3462D452E6F
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhKPJzb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 04:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhKPJzT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Nov 2021 04:55:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CD0C0432DF;
        Tue, 16 Nov 2021 01:50:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so1744225pjc.4;
        Tue, 16 Nov 2021 01:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jbl1bKB28ZQInN+16uM3WF1uI4nnrdBSKaIDe4FDIn4=;
        b=NczuZoG9lJzIkj+khBgbYgrCnlf/dviLGHYxxjBvLZqdX3qYA8iMv51JgOHt0AbHSJ
         i8vVjtkhFLiVROY5Cq3hxHvFZWODNrlxIUPm2/Ux4G4h2oTOGtPy6xmP/leu9oyI5yhW
         YJDsKLi1482S1NFJaNCVtV0NaKmHYhV0vzw2SAHlaTmPQ3lBjcc+4BCnOCgLTvH15G9T
         8Qh+vFs+AM70fyR+tS52pq3WG/LyD6v5e06PK6rjmgek5L+dR4IuhntQIYVpbvyBXUFP
         Y2jR1djZSSTrGPex0XjKwTrPtyC1/BOvUeMh7p+OtUDfJPAUGGRrQHW+VGdIUxfDTh3k
         5tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jbl1bKB28ZQInN+16uM3WF1uI4nnrdBSKaIDe4FDIn4=;
        b=wgpOdm0v2lBRlwXxneHfJa0Dgyi+8Qvxm+asNuI7fKoGWxUyc3YB/jwDBvkvk2EZ5s
         bGCjmR0BIXizxzyn9UOX/6XKmHz7kypg0zEDszO0gohFynG8mqUfp9IlbJrpPIP5S0Oh
         5FLjNcJBbC7AYoY28ZcS4l+Zd6i7M3EBtQ5RQb6imNVdhFD+cwA/GYChpaeVuA7kXKmV
         8hO+aOTtwSMEsr+j9nJKNCP4FvDI4IYhBPgZgYeGe/ruNpwiguihLDaUn97d9O3Qd0vH
         SSvSvTauH7McIbuC24brHBVJqHb5/Ft9nvUnu8tZQVVyiFEJ8nUrvSC0QxJHJnEzOtTA
         CA9w==
X-Gm-Message-State: AOAM530yy/cY2ecNVM6SluK/szgapU2H23N1GyaScdJazakXOCEj+lAv
        XPIGgNDoAP8H5ZZMk8l33UrKAxq1SDeYdkGLaOc=
X-Google-Smtp-Source: ABdhPJx0v8IzfnU05ejmdXMqJmDMXeb3PF++qh8Md5OR3XMUslrUChQ77cv06uovViNWiQhcy4Q3KXk00wiWecHoznA=
X-Received: by 2002:a17:90a:e54c:: with SMTP id ei12mr73525634pjb.81.1637056250074;
 Tue, 16 Nov 2021 01:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20211115141925.60164-1-paul@crapouillou.net> <20211115142243.60605-1-paul@crapouillou.net>
 <20211115142243.60605-3-paul@crapouillou.net>
In-Reply-To: <20211115142243.60605-3-paul@crapouillou.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 16 Nov 2021 11:50:38 +0200
Message-ID: <CA+U=Dsp4P_q6gS9-iS1BujGfhia=uEjBZFy_VEZqFwT-rCOXQQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] iio: buffer-dmaengine: Add support for cyclic buffers
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

On Mon, Nov 15, 2021 at 4:23 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Handle the IIO_BUFFER_DMABUF_CYCLIC flag to support cyclic buffers.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c      |  1 +
>  .../iio/buffer/industrialio-buffer-dmaengine.c    | 15 ++++++++++++---
>  include/linux/iio/buffer-dma.h                    |  3 +++
>  3 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index fb39054d8c15..6658f103ee17 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -933,6 +933,7 @@ int iio_dma_buffer_enqueue_dmabuf(struct iio_buffer *buffer,
>         }
>
>         dma_block->bytes_used = iio_dmabuf->bytes_used ?: dma_block->size;
> +       dma_block->cyclic = iio_dmabuf->flags & IIO_BUFFER_DMABUF_CYCLIC;
>
>         switch (dma_block->state) {
>         case IIO_BLOCK_STATE_QUEUED:
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 57a8b2e4ba3c..952e2160a11e 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -81,9 +81,18 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>         if (!block->bytes_used || block->bytes_used > max_size)
>                 return -EINVAL;
>
> -       desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> -               block->phys_addr, block->bytes_used, dma_dir,
> -               DMA_PREP_INTERRUPT);
> +       if (block->cyclic) {
> +               desc = dmaengine_prep_dma_cyclic(dmaengine_buffer->chan,
> +                                                block->phys_addr,
> +                                                block->size,
> +                                                block->bytes_used,
> +                                                dma_dir, 0);
> +       } else {
> +               desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> +                                                  block->phys_addr,
> +                                                  block->bytes_used, dma_dir,
> +                                                  DMA_PREP_INTERRUPT);
> +       }
>         if (!desc)
>                 return -ENOMEM;
>
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 85e55fe35282..27639fdf7b54 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -42,6 +42,7 @@ enum iio_block_state {
>   * @phys_addr: Physical address of the blocks memory
>   * @queue: Parent DMA buffer queue
>   * @state: Current state of the block
> + * @cyclic: True if this is a cyclic buffer
>   * @fileio: True if this buffer is used for fileio mode
>   * @dmabuf: Underlying DMABUF object
>   */
> @@ -65,6 +66,8 @@ struct iio_dma_buffer_block {
>          */
>         enum iio_block_state state;
>
> +       bool cyclic;
> +
>         bool fileio;
>         struct dma_buf *dmabuf;
>  };
> --
> 2.33.0
>
