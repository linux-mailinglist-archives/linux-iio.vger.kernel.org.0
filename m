Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B75E19EB05
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDELwY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 07:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbgDELwY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 07:52:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBBE206C3;
        Sun,  5 Apr 2020 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586087543;
        bh=Ow1tfwRfxDT3c5hBboE3+C49CQ0nIRzVWNb00H3h5S4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H4c6RH6VBFGTY8tfJXGV3v2pS34vR7m6reKOcfGDfNW3EeLrWzsGiGckJGkmWZc4j
         Sn/jnnuWfvUTw2l/hZ2iNMhGkq2a/z1HGiErWBWcu8yhOWJ0rr/ZZvO+BM+d21tmgp
         VNklo8jiD/ftshIKya7xsP8GmkHR+cdyn0XbOyEY=
Date:   Sun, 5 Apr 2020 12:52:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: dma-buffer: Cleanup buffer.h/buffer_impl.h
 includes
Message-ID: <20200405125219.5cbe63c8@archlinux>
In-Reply-To: <490a1fe0296f3ea92c0419c2887cb02b615af572.camel@analog.com>
References: <20200401165706.30416-1-lars@metafoo.de>
        <490a1fe0296f3ea92c0419c2887cb02b615af572.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2 Apr 2020 15:13:12 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2020-04-01 at 18:57 +0200, Lars-Peter Clausen wrote:
> > [External]
> > 
> > The IIO DMA buffer is a DMA buffer implementation. As such it should
> > include buffer_impl.h rather than buffer.h.
> > 
> > The include to buffer.h in buffer-dma.h should be buffer_impl.h so it has
> > access to the struct iio_buffer definition. The code currently only works
> > because all places that use buffer-dma.h include buffer_impl.h before it.
> > 
> > The include to buffer.h in industrialio-buffer-dma.c  can be removed since
> > those file does not reference any of buffer consumer functions.
> >   
> 
> Tested-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> > Changes since v1:
> > 	* Don't remove buffer.h include in buffer-dma.h since it is needed
> > 	  after all.
> > ---
> >  drivers/iio/buffer/industrialio-buffer-dma.c | 1 -
> >  include/linux/iio/buffer-dma.h               | 2 +-
> >  2 files changed, 1 insertion(+), 2 deletions(-)
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

