Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6A339FD7
	for <lists+linux-iio@lfdr.de>; Sat, 13 Mar 2021 19:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhCMS2r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Mar 2021 13:28:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234010AbhCMS2j (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Mar 2021 13:28:39 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCE864E58;
        Sat, 13 Mar 2021 18:28:38 +0000 (UTC)
Date:   Sat, 13 Mar 2021 18:28:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] iio: buffer: fix use-after-free for attached_buffers
 array
Message-ID: <20210313182832.588ed3d5@archlinux>
In-Reply-To: <CA+U=DsoutVL5yeV_piZLJBSkUrMwTRZurUqW=mrZ-S-=LVw2VQ@mail.gmail.com>
References: <20210306164710.9944-1-ardeleanalex@gmail.com>
        <20210307185444.32924-1-ardeleanalex@gmail.com>
        <CA+U=DsoutVL5yeV_piZLJBSkUrMwTRZurUqW=mrZ-S-=LVw2VQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Mar 2021 09:29:39 +0200
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Mar 7, 2021 at 8:55 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> >
> > Thanks to Lars for finding this.
> > The free of the 'attached_buffers' array should be done as late as
> > possible. This change moves it to iio_buffers_put(), which looks like
> > the best place for it, since it takes place right before the IIO device
> > data is free'd.
> > The free of this array will be handled by calling iio_device_free().
> > The iio_buffers_put() function is renamed to iio_device_detach_buffers()
> > since the role of this function changes a bit.
> >
> > It looks like this issue was ocurring on the error path of
> > iio_buffers_alloc_sysfs_and_mask() and in
> > iio_buffers_free_sysfs_and_mask()
> >
> > Added a comment in the doc-header of iio_device_attach_buffer() to
> > mention how this will be free'd in case anyone is reading the code
> > and becoming confused about it.
> >
> > Fixes: 36f3118c414d ("iio: buffer: introduce support for attaching more IIO buffers")
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan
> > ---  
> 
> Forgot the changelog.
> 
> Changelog v1 -> v2:
> * rename iio_buffers_put() -> iio_device_detach_buffers()
> 
> >  drivers/iio/iio_core.h            | 4 ++--
> >  drivers/iio/industrialio-buffer.c | 9 +++++----
> >  drivers/iio/industrialio-core.c   | 2 +-
> >  3 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index 062fe16c6c49..8f4a9b264962 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -77,7 +77,7 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> >
> >  void iio_disable_all_buffers(struct iio_dev *indio_dev);
> >  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> > -void iio_buffers_put(struct iio_dev *indio_dev);
> > +void iio_device_detach_buffers(struct iio_dev *indio_dev);
> >
> >  #else
> >
> > @@ -93,7 +93,7 @@ static inline void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev) {}
> >
> >  static inline void iio_disable_all_buffers(struct iio_dev *indio_dev) {}
> >  static inline void iio_buffer_wakeup_poll(struct iio_dev *indio_dev) {}
> > -static inline void iio_buffers_put(struct iio_dev *indio_dev) {}
> > +static inline void iio_device_detach_buffers(struct iio_dev *indio_dev) {}
> >
> >  #endif
> >
> > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > index 1a415e97174e..1ff7f731b044 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -326,7 +326,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
> >  }
> >  EXPORT_SYMBOL(iio_buffer_init);
> >
> > -void iio_buffers_put(struct iio_dev *indio_dev)
> > +void iio_device_detach_buffers(struct iio_dev *indio_dev)
> >  {
> >         struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >         struct iio_buffer *buffer;
> > @@ -336,6 +336,8 @@ void iio_buffers_put(struct iio_dev *indio_dev)
> >                 buffer = iio_dev_opaque->attached_buffers[i];
> >                 iio_buffer_put(buffer);
> >         }
> > +
> > +       kfree(iio_dev_opaque->attached_buffers);
> >  }
> >
> >  static ssize_t iio_show_scan_index(struct device *dev,
> > @@ -1764,7 +1766,6 @@ int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> >                 buffer = iio_dev_opaque->attached_buffers[unwind_idx];
> >                 __iio_buffer_free_sysfs_and_mask(buffer);
> >         }
> > -       kfree(iio_dev_opaque->attached_buffers);
> >         return ret;
> >  }
> >
> > @@ -1786,8 +1787,6 @@ void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev)
> >                 buffer = iio_dev_opaque->attached_buffers[i];
> >                 __iio_buffer_free_sysfs_and_mask(buffer);
> >         }
> > -
> > -       kfree(iio_dev_opaque->attached_buffers);
> >  }
> >
> >  /**
> > @@ -2062,6 +2061,8 @@ static int iio_buffer_mmap(struct file *filep, struct vm_area_struct *vma)
> >   * This function attaches a buffer to a IIO device. The buffer stays attached to
> >   * the device until the device is freed. For legacy reasons, the first attached
> >   * buffer will also be assigned to 'indio_dev->buffer'.
> > + * The array allocated here, will be free'd via the iio_device_detach_buffers()
> > + * call which is handled by the iio_device_free().
> >   */
> >  int iio_device_attach_buffer(struct iio_dev *indio_dev,
> >                              struct iio_buffer *buffer)
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index d74fbac908df..3be5f75c2846 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1587,7 +1587,7 @@ static void iio_dev_release(struct device *device)
> >         iio_device_unregister_eventset(indio_dev);
> >         iio_device_unregister_sysfs(indio_dev);
> >
> > -       iio_buffers_put(indio_dev);
> > +       iio_device_detach_buffers(indio_dev);
> >
> >         ida_simple_remove(&iio_ida, indio_dev->id);
> >         kfree(iio_dev_opaque);
> > --
> > 2.25.1
> >  

