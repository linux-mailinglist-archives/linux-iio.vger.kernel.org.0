Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84C9196794
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgC1QpH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 12:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgC1Qnp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C9752082D;
        Sat, 28 Mar 2020 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585413824;
        bh=Re04u1HAwOne5R1dDJI3sq534z3p+bhSHx2Z4lDkbwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PAaIUY93a9jhpfi11FCMNe0cfhhWH/8Nup9e7iSsHAarE4r5NkTRGxf1P6kAYt1xn
         QV3kT7+73iKPXoU4J1c3XDvcuRHFTx6KSZxx2S5MvIRY1cTn9zAGqwN+LCUNxodBPE
         ASjpYIbgi6IaNjtZyc/ZMmOsA3Az5t2GNBUlYSAo=
Date:   Sat, 28 Mar 2020 16:43:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h
 includes
Message-ID: <20200328164335.064d8c02@archlinux>
In-Reply-To: <9f86acf4eb5a3bea823797705108e16949e89e34.camel@analog.com>
References: <20200324141624.30597-1-lars@metafoo.de>
        <9f86acf4eb5a3bea823797705108e16949e89e34.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 14:36:17 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2020-03-24 at 15:16 +0100, Lars-Peter Clausen wrote:
> > [External]
> > 
> > The IIO DMA buffer is a DMA buffer implementation. As such it should
> > include buffer_impl.h rather than buffer.h.
> > 
> > The include to buffer.h in buffer-dma.h should be buffer_impl.h so it has
> > access to the struct iio_buffer definition. The code currently only works
> > because all places that use buffer-dma.h include buffer_impl.h before it.
> > 
> > The include to buffer.h in industrialio-buffer-dma.c and
> > industrialio-buffer-dmaengine.c can be removed since those files don't
> > reference any of buffer consumer functions.  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks

Jonathan

> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  drivers/iio/buffer/industrialio-buffer-dma.c       | 1 -
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 1 -
> >  include/linux/iio/buffer-dma.h                     | 2 +-
> >  3 files changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c
> > b/drivers/iio/buffer/industrialio-buffer-dma.c
> > index a74bd9c0587c..d348af8b9705 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> > @@ -12,7 +12,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/sched.h>
> >  #include <linux/poll.h>
> > -#include <linux/iio/buffer.h>
> >  #include <linux/iio/buffer_impl.h>
> >  #include <linux/iio/buffer-dma.h>
> >  #include <linux/dma-mapping.h>
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index b129693af0fd..8b60dff527c8 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -14,7 +14,6 @@
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > -#include <linux/iio/buffer.h>
> >  #include <linux/iio/buffer_impl.h>
> >  #include <linux/iio/buffer-dma.h>
> >  #include <linux/iio/buffer-dmaengine.h>
> > diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> > index 016d8a068353..ff15c61bf319 100644
> > --- a/include/linux/iio/buffer-dma.h
> > +++ b/include/linux/iio/buffer-dma.h
> > @@ -11,7 +11,7 @@
> >  #include <linux/kref.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/mutex.h>
> > -#include <linux/iio/buffer.h>
> > +#include <linux/iio/buffer_impl.h>
> >  
> >  struct iio_dma_buffer_queue;
> >  struct iio_dma_buffer_ops;  

