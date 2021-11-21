Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC1F4583DE
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 14:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhKUNrX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 08:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234993AbhKUNrX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 08:47:23 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D012603E8;
        Sun, 21 Nov 2021 13:44:15 +0000 (UTC)
Date:   Sun, 21 Nov 2021 13:49:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 08/15] iio: buffer-dma: split
 iio_dma_buffer_fileio_free() function
Message-ID: <20211121134909.605cef5a@jic23-huawei>
In-Reply-To: <CA+U=DsqP0Wg54xgL3_-SmRc2v0GXQv9fDf=350P+sLvJhhYnng@mail.gmail.com>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115141925.60164-9-paul@crapouillou.net>
        <CA+U=DsqP0Wg54xgL3_-SmRc2v0GXQv9fDf=350P+sLvJhhYnng@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Nov 2021 12:59:30 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Nov 15, 2021 at 4:20 PM Paul Cercueil <paul@crapouillou.net> wrote:
> >
> > From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >
> > A part of the logic in the iio_dma_buffer_exit() is required for the change
> > to add mmap support to IIO buffers.
> > This change splits the logic into a separate function, which will be
> > re-used later.
> >  
> 
> Not sure how the protocol is here, since my old @analog.com email
> isn't working anymore.
> 
> But:
> 
> Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>

If you want to both document your email address change and make various scripts
find you more easily, send a patch for .mailmap

In meantime we can probably leave your original sign off in place but add
a Cc: with an up to date email address. That will reflect that the sign off
for this was (I assume) given back when you were at Analog.

> 
> Thanks :)
> Alex
> 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  drivers/iio/buffer/industrialio-buffer-dma.c | 39 +++++++++++---------
> >  1 file changed, 22 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> > index eeeed6b2e0cf..eb8cfd3af030 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> > @@ -358,6 +358,27 @@ int iio_dma_buffer_request_update(struct iio_buffer *buffer)
> >  }
> >  EXPORT_SYMBOL_GPL(iio_dma_buffer_request_update);
> >
> > +static void iio_dma_buffer_fileio_free(struct iio_dma_buffer_queue *queue)
> > +{
> > +       unsigned int i;
> > +
> > +       spin_lock_irq(&queue->list_lock);
> > +       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> > +               if (!queue->fileio.blocks[i])
> > +                       continue;
> > +               queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> > +       }
> > +       spin_unlock_irq(&queue->list_lock);
> > +
> > +       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> > +               if (!queue->fileio.blocks[i])
> > +                       continue;
> > +               iio_buffer_block_put(queue->fileio.blocks[i]);
> > +               queue->fileio.blocks[i] = NULL;
> > +       }
> > +       queue->fileio.active_block = NULL;
> > +}
> > +
> >  static void iio_dma_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >         struct iio_dma_buffer_block *block)
> >  {
> > @@ -681,25 +702,9 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_init);
> >   */
> >  void iio_dma_buffer_exit(struct iio_dma_buffer_queue *queue)
> >  {
> > -       unsigned int i;
> > -
> >         mutex_lock(&queue->lock);
> >
> > -       spin_lock_irq(&queue->list_lock);
> > -       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> > -               if (!queue->fileio.blocks[i])
> > -                       continue;
> > -               queue->fileio.blocks[i]->state = IIO_BLOCK_STATE_DEAD;
> > -       }
> > -       spin_unlock_irq(&queue->list_lock);
> > -
> > -       for (i = 0; i < ARRAY_SIZE(queue->fileio.blocks); i++) {
> > -               if (!queue->fileio.blocks[i])
> > -                       continue;
> > -               iio_buffer_block_put(queue->fileio.blocks[i]);
> > -               queue->fileio.blocks[i] = NULL;
> > -       }
> > -       queue->fileio.active_block = NULL;
> > +       iio_dma_buffer_fileio_free(queue);
> >         queue->ops = NULL;
> >
> >         mutex_unlock(&queue->lock);
> > --
> > 2.33.0
> >  

