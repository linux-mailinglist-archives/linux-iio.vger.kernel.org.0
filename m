Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851383225F7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 07:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBWGfm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Feb 2021 01:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBWGfk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Feb 2021 01:35:40 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C7C061574;
        Mon, 22 Feb 2021 22:35:00 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id s24so15971163iob.6;
        Mon, 22 Feb 2021 22:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBq/fDzJJZK8J6HmNcmzMw7q0LORfsgo8PXuQM6yZUs=;
        b=e6PwqemdISkuwn9ya9rgdpLdsO9YhOPBMVAL99GFNpw1x2EQgzBZJ5DVeJNkcRI3kC
         iGyTUt6cYcsDBYBb8X6O+EZHaO3gQ1Ma4UPdyZ6VSx46K3c/zBGMDJq/rhO6bnPPL6kK
         cP54CTDyxexzoL2/jynLqO6ORMChillnpgFl38a8G/6QbCdYA4kOEb0TF0BUnvTM6Pn+
         4HvDFjE9loe7Fk1yMwCvcYpD90v8tkjf0c4CmK0cslkPoJq/aSC3Br4E1K1U2dhaMEEh
         ywcjAO4C8/qIzxgnmbECmRIa+PNow2vGhuw/ukFQE+22Rhff2tW43LlkDSiG6+QWMJGn
         R4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBq/fDzJJZK8J6HmNcmzMw7q0LORfsgo8PXuQM6yZUs=;
        b=XagTnv6A0olyyZkMToOZp0Y4S4k17Ayi87pkd79SUK+NWrjFeU2x72hzFgkGXKyHBG
         ifsAsNO7Ru75DZ419mVuNqtWxGEW3DtwX46fJ82wpHkvjnVLdsSfmNTNVCuYq7pPOwJ8
         2USqJ9abJQZrGjMU/EevJsPzXZN/Tzn8JG9+9Fodi7BaWTiVVio9Cw9W9n55PrXTOWB+
         E44fC2M871ytletc+ccbucQArLygbdzoZlfe4FLhePqa5gKfKKzr78SPX+eYwMS6qEx7
         JCdwFFhwaR7S4862eEhwhVHlDMTFY1nQK6w5qBTCejxB2PZzt9wvTKl67XQth1q1tLOq
         Febw==
X-Gm-Message-State: AOAM5316l51vVSoQl6zEmjwO+kFp5g9HRYp0ze0Gjs42FtD9RA3G4nF7
        V3P50Oj93QV3MSO+BGi+Ood5Ot4WrAS30JXR8a8hkwgplqmG3g==
X-Google-Smtp-Source: ABdhPJyyqJZQ4YOQaU0HPvzUth+6UK0lbwQ/B9VhlOAfdCBV9cWm2iMFpK1yEV5kNi7UbOYIUgPq4k7Vp/0wWOtnXZs=
X-Received: by 2002:a02:390a:: with SMTP id l10mr25595005jaa.88.1614062100095;
 Mon, 22 Feb 2021 22:35:00 -0800 (PST)
MIME-Version: 1.0
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
 <20210219124012.92897-7-alexandru.ardelean@analog.com> <20210221120958.7623e02c@archlinux>
In-Reply-To: <20210221120958.7623e02c@archlinux>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 23 Feb 2021 08:34:46 +0200
Message-ID: <CA+U=Dsouj+P0AfWU2r9B4pcp_jGUCZgaOOwq1zHYHxOxShCCcQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] iio: buffer-dma: add support for cyclic DMA transfers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 21, 2021 at 2:11 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 19 Feb 2021 14:40:12 +0200
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > From: Lars-Peter Clausen <lars@metafoo.de>
> >
> > This change adds support for cyclic DMA transfers using the IIO buffer DMA
> > infrastructure.
> > To do this, userspace must set the IIO_BUFFER_BLOCK_FLAG_CYCLIC flag on the
> > block when enqueueing them via the ENQUEUE_BLOCK ioctl().
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Series in general looks good to me, but this change needs a little more
> detail + probably some level of example userspace flow.
>
> I don't really understand how this is used!
>
> Also, it's easy to test output buffers with the kfifo support so we
> should be able to move forward quickly with that part (1-3, 4 is probably
> fine as well as clearly harmless).
>
> The dma stuff worries me more, at least partly based on the experience
> of the original dma buffers which basically sat their unused (in upstream)
> for a very long time.   So to move these forward, they need to come
> with users...

So, this series will need to be re-sent/re-tested by someone else.
I'm on my last week at ADI and I'm on vacation.

Maybe I can manage to setup something to test as well, but it will take a while.



>
> Thanks,
>
> Jonathan
>
> > ---
> >  .../buffer/industrialio-buffer-dmaengine.c    | 24 ++++++++++++-------
> >  include/uapi/linux/iio/buffer.h               |  1 +
> >  2 files changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index 65458a6cc81a..39cc230c7991 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -82,14 +82,22 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >
> >       direction = dmaengine_buffer->is_tx ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> >
> > -     desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> > -             block->phys_addr, block->block.bytes_used, direction,
> > -             DMA_PREP_INTERRUPT);
> > -     if (!desc)
> > -             return -ENOMEM;
> > -
> > -     desc->callback_result = iio_dmaengine_buffer_block_done;
> > -     desc->callback_param = block;
> > +     if (block->block.flags & IIO_BUFFER_BLOCK_FLAG_CYCLIC) {
> > +             desc = dmaengine_prep_dma_cyclic(dmaengine_buffer->chan,
> > +                     block->phys_addr, block->block.bytes_used,
> > +                     block->block.bytes_used, direction, 0);
> > +             if (!desc)
> > +                     return -ENOMEM;
> > +     } else {
> > +             desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
> > +                     block->phys_addr, block->block.bytes_used, direction,
> > +                     DMA_PREP_INTERRUPT);
> > +             if (!desc)
> > +                     return -ENOMEM;
> > +
> > +             desc->callback_result = iio_dmaengine_buffer_block_done;
> > +             desc->callback_param = block;
> > +     }
> >
> >       cookie = dmaengine_submit(desc);
> >       if (dma_submit_error(cookie))
> > diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
> > index 4e4ee9befea1..1bde508fe1b9 100644
> > --- a/include/uapi/linux/iio/buffer.h
> > +++ b/include/uapi/linux/iio/buffer.h
> > @@ -33,6 +33,7 @@ struct iio_buffer_block_alloc_req {
> >
> >  /* A function will be assigned later for BIT(0) */
> >  #define IIO_BUFFER_BLOCK_FLAG_RESERVED               (1 << 0)
> > +#define IIO_BUFFER_BLOCK_FLAG_CYCLIC         (1 << 1)
> >
> >  /**
> >   * struct iio_buffer_block - Descriptor for a single IIO block
>
