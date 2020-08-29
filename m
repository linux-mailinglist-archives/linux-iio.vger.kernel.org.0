Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041222568D1
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgH2Pvl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgH2Pvk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:51:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D798A20707;
        Sat, 29 Aug 2020 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598716298;
        bh=r8tVolSvlamHeZpS+h8uVJJwB2abXQGnZkBeBguUw8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eWqGFMyvS+TrpJvNlvWAAOLWySvhEFYFMf8xqIGo2MN0Ms7MLTT6A9Cc+7UYC4q06
         Ap9ZDY4acmSWzy5OuEfbL5BXmEjdYB4gPfQEzmpOEu1tSmVEmtW2n0u9tA5aZ+qU1s
         2QVWHgTpGnkp0YqwDAaL5cIEt57I638GIMO1QMgg=
Date:   Sat, 29 Aug 2020 16:51:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: adjust `bytes_used` with residue
 info
Message-ID: <20200829165134.3361315a@archlinux>
In-Reply-To: <CA+U=Dsp8KXNzmVGf9N=A+h7DyC2L7Hk2A7N4ERPL4jc+-M_mFg@mail.gmail.com>
References: <20200826052011.13348-1-lars@metafoo.de>
        <CA+U=Dsp8KXNzmVGf9N=A+h7DyC2L7Hk2A7N4ERPL4jc+-M_mFg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 09:36:39 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Wed, Aug 26, 2020 at 8:22 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> > From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >
> > A transfer may fall shorter than the bytes in the block.
> > This information is available in the residue from the DMA engine, so we can
> > compute actual `bytes_used` with that by subtracting the residue.
> >  
> 
> This was in my pipeline as well [obviously].
> Thanks :)
> 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

"smells" like a fix.  Is it?  Or are we looking at something that
only matters for some future hardware, or an optmization?

If it's a fix, where is the fixes tag?

Thanks, 

Jonathan

> > ---
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index 6dedf12b69a4..5789bda0745b 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -45,7 +45,8 @@ static struct dmaengine_buffer *iio_buffer_to_dmaengine_buffer(
> >         return container_of(buffer, struct dmaengine_buffer, queue.buffer);
> >  }
> >
> > -static void iio_dmaengine_buffer_block_done(void *data)
> > +static void iio_dmaengine_buffer_block_done(void *data,
> > +               const struct dmaengine_result *result)
> >  {
> >         struct iio_dma_buffer_block *block = data;
> >         unsigned long flags;
> > @@ -53,6 +54,7 @@ static void iio_dmaengine_buffer_block_done(void *data)
> >         spin_lock_irqsave(&block->queue->list_lock, flags);
> >         list_del(&block->head);
> >         spin_unlock_irqrestore(&block->queue->list_lock, flags);
> > +       block->bytes_used -= result->residue;
> >         iio_dma_buffer_block_done(block);
> >  }
> >
> > @@ -74,7 +76,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >         if (!desc)
> >                 return -ENOMEM;
> >
> > -       desc->callback = iio_dmaengine_buffer_block_done;
> > +       desc->callback_result = iio_dmaengine_buffer_block_done;
> >         desc->callback_param = block;
> >
> >         cookie = dmaengine_submit(desc);
> > --
> > 2.20.1
> >  

