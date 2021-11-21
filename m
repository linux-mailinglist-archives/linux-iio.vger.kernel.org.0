Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB54583F6
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 15:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbhKUOGh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 09:06:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238265AbhKUOGg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 09:06:36 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD1A60E75;
        Sun, 21 Nov 2021 14:03:28 +0000 (UTC)
Date:   Sun, 21 Nov 2021 14:08:23 +0000
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
Subject: Re: [PATCH 03/15] iio: buffer-dma: Use round_down() instead of
 rounddown()
Message-ID: <20211121140823.6b2922f6@jic23-huawei>
In-Reply-To: <20211115141925.60164-4-paul@crapouillou.net>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115141925.60164-4-paul@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 15 Nov 2021 14:19:13 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> We know that the buffer's alignment will always be a power of two;
> therefore, we can use the faster round_down() macro.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
*groan*.  I don't want to know where the naming of these two came from but that
is spectacular... 

Anyhow, happy to pick up 1-3 now if you like as all are good cleanup of
existing code.

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 1ac94c4e9792..f8ce26a24c57 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -67,7 +67,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  	dma_cookie_t cookie;
>  
>  	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
> -	block->bytes_used = rounddown(block->bytes_used,
> +	block->bytes_used = round_down(block->bytes_used,
>  			dmaengine_buffer->align);
>  
>  	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,

