Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278C3FACF3
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhH2P53 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235646AbhH2P51 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:57:27 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E6260F42;
        Sun, 29 Aug 2021 15:56:33 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:59:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: return IRQ_HANDLED when fifo is
 flushed
Message-ID: <20210829165948.4a8051f9@jic23-huawei>
In-Reply-To: <20210817124336.1672169-1-sean@geanix.com>
References: <20210817124336.1672169-1-sean@geanix.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Aug 2021 14:43:36 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> fxls8962af_fifo_flush() will return the samples flushed.
> So return IRQ_NONE only if an error is returned.
> 
> Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/fxls8962af-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 078d87865fde..6b36eb362d07 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -738,7 +738,7 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  
>  	if (reg & FXLS8962AF_INT_STATUS_SRC_BUF) {
>  		ret = fxls8962af_fifo_flush(indio_dev);
> -		if (ret)
> +		if (ret < 0)
>  			return IRQ_NONE;
>  
>  		return IRQ_HANDLED;

