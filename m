Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3FB435DD3
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 11:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJUJZj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 05:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231308AbhJUJZg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Oct 2021 05:25:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37E560E96;
        Thu, 21 Oct 2021 09:23:19 +0000 (UTC)
Date:   Thu, 21 Oct 2021 10:27:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: buffer: Fix memory leak in
 iio_buffers_alloc_sysfs_and_mask()
Message-ID: <20211021102737.5d54908a@jic23-huawei>
In-Reply-To: <CA+U=DsorPFMpz3QS=dYrV4_UmeyeZXbS2Afpt7UHCkwo3JEABA@mail.gmail.com>
References: <20211018063718.1971240-1-yangyingliang@huawei.com>
        <CA+U=DsorPFMpz3QS=dYrV4_UmeyeZXbS2Afpt7UHCkwo3JEABA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 09:41:10 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Mon, Oct 18, 2021 at 9:29 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> >
> > When 'iio_dev_opaque->buffer_ioctl_handler' alloc fails in
> > iio_buffers_alloc_sysfs_and_mask(), the 'attrs' allocated in
> > iio_buffer_register_legacy_sysfs_groups() will be leaked:
> >
> > unreferenced object 0xffff888108568d00 (size 128):
> >   comm "88", pid 2014, jiffies 4294963294 (age 26.920s)
> >   hex dump (first 32 bytes):
> >     80 3e da 02 80 88 ff ff 00 3a da 02 80 88 ff ff  .>.......:......
> >     00 35 da 02 80 88 ff ff 00 38 da 02 80 88 ff ff  .5.......8......
> >   backtrace:
> >     [<0000000095a9e51e>] __kmalloc+0x1a3/0x2f0
> >     [<00000000faa3735e>] iio_buffers_alloc_sysfs_and_mask+0xfa3/0x1480 [industrialio]
> >     [<00000000a46384dc>] __iio_device_register+0x52e/0x1b40 [industrialio]
> >     [<00000000210af05e>] __devm_iio_device_register+0x22/0x80 [industrialio]
> >     [<00000000730d7b41>] adjd_s311_probe+0x195/0x200 [adjd_s311]
> >     [<00000000c0f70eb9>] i2c_device_probe+0xa07/0xbb0
> >
> > The iio_buffer_register_legacy_sysfs_groups() is
> > called in __iio_buffer_alloc_sysfs_and_mask(),
> > so move the iio_buffer_unregister_legacy_sysfs_groups()
> > into __iio_buffer_free_sysfs_and_mask(), then the memory
> > will be freed.
> >  
> 
> Reviewed- by: Alexandru Ardelean <ardeleanalex@gmail.com>
Applied to the fixes-togreg branch of iio.git.  Given where we are in the
cycle I'll probably shift these over to queue up for the merge window now.

Marked for stable as well.

Thanks,

Jonathan

> 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: d9a625744ed0 ("iio: core: merge buffer/ & scan_elements/ attributes")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> > v2:
> >   move iio_buffer_unregister_legacy_sysfs_groups() into
> >   __iio_buffer_free_sysfs_and_mask()
> > ---
> >  drivers/iio/industrialio-buffer.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index a95cc2da56be..b29d105a75fe 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -1583,8 +1583,12 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> >         return ret;
> >  }
> >
> > -static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> > +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer,
> > +                                            struct iio_dev *indio_dev,
> > +                                            int index)
> >  {
> > +       if (index == 0)
> > +               iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
> >         bitmap_free(buffer->scan_mask);
> >         kfree(buffer->buffer_group.name);
> >         kfree(buffer->buffer_group.attrs);
> > @@ -1638,7 +1642,7 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >  error_unwind_sysfs_and_mask:
> >         for (; unwind_idx >= 0; unwind_idx--) {
> >                 buffer = iio_dev_opaque->attached_buffers[unwind_idx];
> > -               __iio_buffer_free_sysfs_and_mask(buffer);
> > +               __iio_buffer_free_sysfs_and_mask(buffer, indio_dev, unwind_idx);
> >         }
> >         return ret;
> >  }
> > @@ -1655,11 +1659,9 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >         iio_device_ioctl_handler_unregister(iio_dev_opaque->buffer_ioctl_handler);
> >         kfree(iio_dev_opaque->buffer_ioctl_handler);
> >
> > -       iio_buffer_unregister_legacy_sysfs_groups(indio_dev);
> > -
> >         for (i = iio_dev_opaque->attached_buffers_cnt - 1; i >= 0; i--) {
> >                 buffer = iio_dev_opaque->attached_buffers[i];
> > -               __iio_buffer_free_sysfs_and_mask(buffer);
> > +               __iio_buffer_free_sysfs_and_mask(buffer, indio_dev, i);
> >         }
> >  }
> >
> > --
> > 2.25.1
> >  

