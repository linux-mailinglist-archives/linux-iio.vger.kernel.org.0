Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944E019EB0E
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 13:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDEL7V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 07:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgDEL7U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 07:59:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B68D20675;
        Sun,  5 Apr 2020 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586087960;
        bh=+wGxOfzb3Kic1eA+umuFEn0WHWrxSh5LLIkTr9+zSD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cg6XDwMrmYu47NlK2zZ+5P9zLL9+d4rZi7FJ05z977umTVaqvrvnTxYQufRmZSRR/
         yJBZD/PKp35eOfg5LIs0dxC/XZXMTHaNI243QJAnxQoDawjH36M+qyziCVX8erx3XO
         q5otDKTjoMpc2+0hPnLPe0Qz/x/2M3DSNSmb7Dq8=
Date:   Sun, 5 Apr 2020 12:59:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h
 includes
Message-ID: <20200405125916.7f4c235c@archlinux>
In-Reply-To: <20200401165706.30416-1-lars@metafoo.de>
References: <20200401165706.30416-1-lars@metafoo.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  1 Apr 2020 18:57:06 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The IIO DMA buffer is a DMA buffer implementation. As such it should
> include buffer_impl.h rather than buffer.h.
> 
> The include to buffer.h in buffer-dma.h should be buffer_impl.h so it has
> access to the struct iio_buffer definition. The code currently only works
> because all places that use buffer-dma.h include buffer_impl.h before it.
> 
> The include to buffer.h in industrialio-buffer-dma.c  can be removed since
> those file does not reference any of buffer consumer functions.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.

Thanks,

Jonathan

> ---
> Changes since v1:
> 	* Don't remove buffer.h include in buffer-dma.h since it is needed
> 	  after all.
> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 1 -
>  include/linux/iio/buffer-dma.h               | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index a74bd9c0587c..d348af8b9705 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -12,7 +12,6 @@
>  #include <linux/mutex.h>
>  #include <linux/sched.h>
>  #include <linux/poll.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
>  #include <linux/iio/buffer-dma.h>
>  #include <linux/dma-mapping.h>
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 016d8a068353..ff15c61bf319 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -11,7 +11,7 @@
>  #include <linux/kref.h>
>  #include <linux/spinlock.h>
>  #include <linux/mutex.h>
> -#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer_impl.h>
>  
>  struct iio_dma_buffer_queue;
>  struct iio_dma_buffer_ops;

