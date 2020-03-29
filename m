Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C612196C5A
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 12:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgC2KIS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 06:08:18 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51096 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2KIS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 06:08:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 78F109E78E5;
        Sun, 29 Mar 2020 11:08:14 +0100 (BST)
Date:   Sun, 29 Mar 2020 11:08:12 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h
 includes
Message-ID: <20200329110812.6ec65bde@archlinux>
In-Reply-To: <20200328164335.064d8c02@archlinux>
References: <20200324141624.30597-1-lars@metafoo.de>
        <9f86acf4eb5a3bea823797705108e16949e89e34.camel@analog.com>
        <20200328164335.064d8c02@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 28 Mar 2020 16:43:35 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 24 Mar 2020 14:36:17 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Tue, 2020-03-24 at 15:16 +0100, Lars-Peter Clausen wrote:  
> > > [External]
> > > 
> > > The IIO DMA buffer is a DMA buffer implementation. As such it should
> > > include buffer_impl.h rather than buffer.h.
> > > 
> > > The include to buffer.h in buffer-dma.h should be buffer_impl.h so it has
> > > access to the struct iio_buffer definition. The code currently only works
> > > because all places that use buffer-dma.h include buffer_impl.h before it.
> > > 
> > > The include to buffer.h in industrialio-buffer-dma.c and
> > > industrialio-buffer-dmaengine.c can be removed since those files don't
> > > reference any of buffer consumer functions.    
> > 
> > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >   
> Applied to the togreg branch of iio.git and pushed out as testing.
And reverted again.

The usecase that was introduced in another path meant this finally
got built in my tests and this patch broke it :(

Seems we use iio_buffer_set_attrs in the dmaengine buffer
and that's in buffer.h.

I haven't looked to see how to fix this (e.g. can we just
move that definition to buffer_impl).

Jonathan

> 
> Thanks
> 
> Jonathan
> 
> > > 
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > ---
> > >  drivers/iio/buffer/industrialio-buffer-dma.c       | 1 -
> > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 1 -
> > >  include/linux/iio/buffer-dma.h                     | 2 +-
> > >  3 files changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c
> > > b/drivers/iio/buffer/industrialio-buffer-dma.c
> > > index a74bd9c0587c..d348af8b9705 100644
> > > --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> > > @@ -12,7 +12,6 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/poll.h>
> > > -#include <linux/iio/buffer.h>
> > >  #include <linux/iio/buffer_impl.h>
> > >  #include <linux/iio/buffer-dma.h>
> > >  #include <linux/dma-mapping.h>
> > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > index b129693af0fd..8b60dff527c8 100644
> > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > @@ -14,7 +14,6 @@
> > >  
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > > -#include <linux/iio/buffer.h>
> > >  #include <linux/iio/buffer_impl.h>
> > >  #include <linux/iio/buffer-dma.h>
> > >  #include <linux/iio/buffer-dmaengine.h>
> > > diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> > > index 016d8a068353..ff15c61bf319 100644
> > > --- a/include/linux/iio/buffer-dma.h
> > > +++ b/include/linux/iio/buffer-dma.h
> > > @@ -11,7 +11,7 @@
> > >  #include <linux/kref.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/mutex.h>
> > > -#include <linux/iio/buffer.h>
> > > +#include <linux/iio/buffer_impl.h>
> > >  
> > >  struct iio_dma_buffer_queue;
> > >  struct iio_dma_buffer_ops;    
> 

