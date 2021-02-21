Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4752320A2C
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 13:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhBUMKr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 07:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUMKo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 07:10:44 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F996186A;
        Sun, 21 Feb 2021 12:10:01 +0000 (UTC)
Date:   Sun, 21 Feb 2021 12:09:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [PATCH v3 6/6] iio: buffer-dma: add support for cyclic DMA
 transfers
Message-ID: <20210221120958.7623e02c@archlinux>
In-Reply-To: <20210219124012.92897-7-alexandru.ardelean@analog.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
        <20210219124012.92897-7-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 19 Feb 2021 14:40:12 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> This change adds support for cyclic DMA transfers using the IIO buffer DMA
> infrastructure.
> To do this, userspace must set the IIO_BUFFER_BLOCK_FLAG_CYCLIC flag on the
> block when enqueueing them via the ENQUEUE_BLOCK ioctl().
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Series in general looks good to me, but this change needs a little more
detail + probably some level of example userspace flow.

I don't really understand how this is used!

Also, it's easy to test output buffers with the kfifo support so we
should be able to move forward quickly with that part (1-3, 4 is probably
fine as well as clearly harmless).

The dma stuff worries me more, at least partly based on the experience
of the original dma buffers which basically sat their unused (in upstream)
for a very long time.   So to move these forward, they need to come
with users...

Thanks,

Jonathan

> ---
>  .../buffer/industrialio-buffer-dmaengine.c    | 24 ++++++++++++-------
>  include/uapi/linux/iio/buffer.h               |  1 +
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 65458a6cc81a..39cc230c7991 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -82,14 +82,22 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  
>  	direction = dmaengine_buffer->is_tx ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
>  
> -	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> -		block->phys_addr, block->block.bytes_used, direction,
> -		DMA_PREP_INTERRUPT);
> -	if (!desc)
> -		return -ENOMEM;
> -
> -	desc->callback_result = iio_dmaengine_buffer_block_done;
> -	desc->callback_param = block;
> +	if (block->block.flags & IIO_BUFFER_BLOCK_FLAG_CYCLIC) {
> +		desc = dmaengine_prep_dma_cyclic(dmaengine_buffer->chan,
> +			block->phys_addr, block->block.bytes_used,
> +			block->block.bytes_used, direction, 0);
> +		if (!desc)
> +			return -ENOMEM;
> +	} else {
> +		desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> +			block->phys_addr, block->block.bytes_used, direction,
> +			DMA_PREP_INTERRUPT);
> +		if (!desc)
> +			return -ENOMEM;
> +
> +		desc->callback_result = iio_dmaengine_buffer_block_done;
> +		desc->callback_param = block;
> +	}
>  
>  	cookie = dmaengine_submit(desc);
>  	if (dma_submit_error(cookie))
> diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> index 4e4ee9befea1..1bde508fe1b9 100644
> --- a/include/uapi/linux/iio/buffer.h
> +++ b/include/uapi/linux/iio/buffer.h
> @@ -33,6 +33,7 @@ struct iio_buffer_block_alloc_req {
>  
>  /* A function will be assigned later for BIT(0) */
>  #define IIO_BUFFER_BLOCK_FLAG_RESERVED		(1 << 0)
> +#define IIO_BUFFER_BLOCK_FLAG_CYCLIC		(1 << 1)
>  
>  /**
>   * struct iio_buffer_block - Descriptor for a single IIO block

