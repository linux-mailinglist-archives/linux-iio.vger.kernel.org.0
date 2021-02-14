Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF2731B13E
	for <lists+linux-iio@lfdr.de>; Sun, 14 Feb 2021 17:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhBNQc2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Feb 2021 11:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhBNQc2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Feb 2021 11:32:28 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03AFF60232;
        Sun, 14 Feb 2021 16:31:45 +0000 (UTC)
Date:   Sun, 14 Feb 2021 16:31:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>
Subject: Re: [RFC PATCH 5/5] iio: buffer-dma: add support for cyclic DMA
 transfers
Message-ID: <20210214163142.52263d58@archlinux>
In-Reply-To: <20210212102021.47276-6-alexandru.ardelean@analog.com>
References: <20210212102021.47276-1-alexandru.ardelean@analog.com>
        <20210212102021.47276-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Feb 2021 12:20:21 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> This change adds support for cyclic DMA transfers using the IIO buffer DMA
> infrastructure.
> To do this, userspace must set the IIO_BUFFER_BLOCK_FLAG_CYCLIC flag on the
> block when enqueueing them via the ENQUEUE_BLOCK ioctl().

We should have more than that in the way of documentation!

What is the dataflow that we end up with as a result of this?

Jonathan


> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../buffer/industrialio-buffer-dmaengine.c    | 24 ++++++++++++-------
>  include/uapi/linux/iio/buffer.h               |  1 +
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 013cc7c1ecf4..94c93a636ad4 100644
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
> index 70ad3aea01ea..0e0c95f1c38b 100644
> --- a/include/uapi/linux/iio/buffer.h
> +++ b/include/uapi/linux/iio/buffer.h
> @@ -13,6 +13,7 @@ struct iio_buffer_block_alloc_req {
>  };
>  
>  #define IIO_BUFFER_BLOCK_FLAG_TIMESTAMP_VALID	(1 << 0)
> +#define IIO_BUFFER_BLOCK_FLAG_CYCLIC		(1 << 1)
>  
>  struct iio_buffer_block {
>  	__u32 id;

