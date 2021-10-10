Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C755428275
	for <lists+linux-iio@lfdr.de>; Sun, 10 Oct 2021 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhJJQIf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Oct 2021 12:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJJQIe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Oct 2021 12:08:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3068B60D42;
        Sun, 10 Oct 2021 16:06:33 +0000 (UTC)
Date:   Sun, 10 Oct 2021 17:10:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: Re: [PATCH v6 1/6] iio: Add output buffer support
Message-ID: <20211010171040.631e7d4b@jic23-huawei>
In-Reply-To: <CA+U=Dsp-9hxDWQTg-xFu55gqXqU-kZJNXkRNmhN0K++-bzNhOA@mail.gmail.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
        <20211007080035.2531-2-mihail.chindris@analog.com>
        <20211007170533.5e314199@jic23-huawei>
        <SJ0PR03MB579191849B3BD15610A721AE99B19@SJ0PR03MB5791.namprd03.prod.outlook.com>
        <20211007181302.3be7d4dd@jic23-huawei>
        <CA+U=Dsp-9hxDWQTg-xFu55gqXqU-kZJNXkRNmhN0K++-bzNhOA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 8 Oct 2021 09:56:29 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Oct 7, 2021 at 8:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 7 Oct 2021 16:24:52 +0000
> > "Chindris, Mihail" <Mihail.Chindris@analog.com> wrote:
> >  
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Thursday, 7 October 2021 19:06
> > > > To: Chindris, Mihail <Mihail.Chindris@analog.com>
> > > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > > > lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> > > > Sa, Nuno <Nuno.Sa@analog.com>; Bogdan, Dragos
> > > > <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com
> > > > Subject: Re: [PATCH v6 1/6] iio: Add output buffer support
> > > >
> > > > On Thu, 7 Oct 2021 08:00:30 +0000
> > > > Mihail Chindris <mihail.chindris@analog.com> wrote:
> > > >  
> > > > > Currently IIO only supports buffer mode for capture devices like ADCs.
> > > > > Add support for buffered mode for output devices like DACs.
> > > > >
> > > > > The output buffer implementation is analogous to the input buffer
> > > > > implementation. Instead of using read() to get data from the buffer
> > > > > write() is used to copy data into the buffer.
> > > > >
> > > > > poll() with POLLOUT will wakeup if there is space available.
> > > > >
> > > > > Drivers can remove data from a buffer using iio_pop_from_buffer(), the
> > > > > function can e.g. called from a trigger handler to write the data to
> > > > > hardware.
> > > > >
> > > > > A buffer can only be either a output buffer or an input, but not both.
> > > > > So, for a device that has an ADC and DAC path, this will mean 2 IIO
> > > > > buffers (one for each direction).
> > > > >
> > > > > The direction of the buffer is decided by the new direction field of
> > > > > the iio_buffer struct and should be set after allocating and before
> > > > > registering it.
> > > > >
> > > > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>  
> > > >
> > > > Hi Mihail,
> > > >
> > > > I'm fine with this series now, but one question for this patch on whether we
> > > > can clarify the author chain.
> > > >
> > > > The above might mean one of two things.
> > > > 1) Lars wrote the code and Alex and yourself just 'handled' the patch on its
> > > >    way to posting.  If that were the case it should have a From: for Lars
> > > > 2) All 3 were involved in changes to this patch.  In that case we should have
> > > > Co-developed-by: lines for lars and Alex as described:
> > > > https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/
> > > > Documentation/process/submitting-
> > > > patches.rst*L475__;Iw!!A3Ni8CS0y2Y!t1IaOEZX3w2pZXl-
> > > > RyAlXgPPvxFtCON74ppfGuMgV_pKZcNjsLs-dKSk_mA34IsmlOU$
> > > >
> > > > This patch has a history well predating the Co-developed-tag but I'm happy
> > > > to add that if you can confirm that matches with the intent.
> > > >
> > > > Good to leave on the list for a few days anyway in case anyone else wants to
> > > > take a quick look.
> > > >
> > > > I'm looking forwards to merging this and thinking back to when Lars originally
> > > > discussed this feature with me rather a lot of years back!
> > > >
> > > > Jonathan
> > > >
> > > >  
> > >
> > > Hi Jonathan,
> > >
> > > What I have done with the patch was to take the V3 that Alex has left and implement the feedback. So I think this is considered as 'handled' from my side.
> > > What happened before V3 I think is better if Alex spokes for himself because I don't really know :)  
> >
> > Alex / Lars, what would you consider a fair way to represent this?  
> 
> I'm fine with whatever representation you (Jonathan) consider.
> I'm fine with either tag.

I'll add co-developed for Lars and Alex and Mihail is an author by merit
of being first sign off that isn't also co-developed. I think that fairly
reflects the flow.

> 
> My main contribution here is that the "direction" parameter is part of
> "struct iio_buffer", whereas Lars' implementation made it part of
> "struct iio_dev".
> 
> I seem to recall that there was an "iio_buffer->direction"
> implementation before the "iio_dev->direction" in the ADI kernel tree.
> Maybe there was some change of mind somewhere.
> But the history was pretty messy in those early days (at least that's
> what the "git log" told me), as IIO was also moved out of staging and
> heavy development was being done.
> 
> In any case, this patch works on top of the new multi-buffer support.
> Which would mean that with this patch, a new class of ADDAC devices
> (not sure how popular they are these days) can be supported.
> As well as some basic transceivers.
> 
> >
> > (added some working addresses for Alex...)
> >
> >  
> > >
> > > Mihail
> > >  
> > > >  
> > > > > ---
> > > > >  drivers/iio/iio_core.h            |   4 +
> > > > >  drivers/iio/industrialio-buffer.c | 127  
> > > > +++++++++++++++++++++++++++++-  
> > > > >  drivers/iio/industrialio-core.c   |   1 +
> > > > >  include/linux/iio/buffer.h        |   7 ++
> > > > >  include/linux/iio/buffer_impl.h   |  11 +++
> > > > >  5 files changed, 148 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h index
> > > > > 8f4a9b264962..61e318431de9 100644
> > > > > --- a/drivers/iio/iio_core.h
> > > > > +++ b/drivers/iio/iio_core.h
> > > > > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file *filp,
> > > > >                            struct poll_table_struct *wait);  ssize_t
> > > > > iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> > > > >                           size_t n, loff_t *f_ps);
> > > > > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
> > > > > +                          size_t n, loff_t *f_ps);
> > > > >
> > > > >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> > > > > void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> > > > >
> > > > >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)  #define
> > > > > iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > > > > +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
> > > > >
> > > > >  void iio_disable_all_buffers(struct iio_dev *indio_dev);  void
> > > > > iio_buffer_wakeup_poll(struct iio_dev *indio_dev); @@ -83,6 +86,7 @@
> > > > > void iio_device_detach_buffers(struct iio_dev *indio_dev);
> > > > >
> > > > >  #define iio_buffer_poll_addr NULL
> > > > >  #define iio_buffer_read_outer_addr NULL
> > > > > +#define iio_buffer_write_outer_addr NULL
> > > > >
> > > > >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> > > > > *indio_dev)  { diff --git a/drivers/iio/industrialio-buffer.c
> > > > > b/drivers/iio/industrialio-buffer.c
> > > > > index a95cc2da56be..7286563e6234 100644
> > > > > --- a/drivers/iio/industrialio-buffer.c
> > > > > +++ b/drivers/iio/industrialio-buffer.c
> > > > > @@ -120,6 +120,9 @@ static ssize_t iio_buffer_read(struct file *filp, char  
> > > > __user *buf,  
> > > > >   if (!rb || !rb->access->read)
> > > > >           return -EINVAL;
> > > > >
> > > > > + if (rb->direction != IIO_BUFFER_DIRECTION_IN)
> > > > > +         return -EPERM;
> > > > > +
> > > > >   datum_size = rb->bytes_per_datum;
> > > > >
> > > > >   /*
> > > > > @@ -161,6 +164,65 @@ static ssize_t iio_buffer_read(struct file *filp, char  
> > > > __user *buf,  
> > > > >   return ret;
> > > > >  }
> > > > >
> > > > > +static size_t iio_buffer_space_available(struct iio_buffer *buf) {
> > > > > + if (buf->access->space_available)
> > > > > +         return buf->access->space_available(buf);
> > > > > +
> > > > > + return SIZE_MAX;
> > > > > +}
> > > > > +
> > > > > +static ssize_t iio_buffer_write(struct file *filp, const char __user *buf,
> > > > > +                         size_t n, loff_t *f_ps)
> > > > > +{
> > > > > + struct iio_dev_buffer_pair *ib = filp->private_data;
> > > > > + struct iio_buffer *rb = ib->buffer;
> > > > > + struct iio_dev *indio_dev = ib->indio_dev;
> > > > > + DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > > > > + int ret;
> > > > > + size_t written;
> > > > > +
> > > > > + if (!indio_dev->info)
> > > > > +         return -ENODEV;
> > > > > +
> > > > > + if (!rb || !rb->access->write)
> > > > > +         return -EINVAL;
> > > > > +
> > > > > + if (rb->direction != IIO_BUFFER_DIRECTION_OUT)
> > > > > +         return -EPERM;
> > > > > +
> > > > > + written = 0;
> > > > > + add_wait_queue(&rb->pollq, &wait);
> > > > > + do {
> > > > > +         if (indio_dev->info == NULL)
> > > > > +                 return -ENODEV;
> > > > > +
> > > > > +         if (!iio_buffer_space_available(rb)) {
> > > > > +                 if (signal_pending(current)) {
> > > > > +                         ret = -ERESTARTSYS;
> > > > > +                         break;
> > > > > +                 }
> > > > > +
> > > > > +                 wait_woken(&wait, TASK_INTERRUPTIBLE,
> > > > > +                                 MAX_SCHEDULE_TIMEOUT);
> > > > > +                 continue;
> > > > > +         }
> > > > > +
> > > > > +         ret = rb->access->write(rb, n - written, buf + written);
> > > > > +         if (ret == 0 && (filp->f_flags & O_NONBLOCK))
> > > > > +                 ret = -EAGAIN;
> > > > > +
> > > > > +         if (ret > 0) {
> > > > > +                 written += ret;
> > > > > +                 if (written != n && !(filp->f_flags & O_NONBLOCK))
> > > > > +                         continue;
> > > > > +         }
> > > > > + } while (ret == 0);
> > > > > + remove_wait_queue(&rb->pollq, &wait);
> > > > > +
> > > > > + return ret < 0 ? ret : n;
> > > > > +}
> > > > > +
> > > > >  /**
> > > > >   * iio_buffer_poll() - poll the buffer to find out if it has data
> > > > >   * @filp:        File structure pointer for device access
> > > > > @@ -181,8 +243,18 @@ static __poll_t iio_buffer_poll(struct file *filp,
> > > > >           return 0;
> > > > >
> > > > >   poll_wait(filp, &rb->pollq, wait);
> > > > > - if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > > > > -         return EPOLLIN | EPOLLRDNORM;
> > > > > +
> > > > > + switch (rb->direction) {
> > > > > + case IIO_BUFFER_DIRECTION_IN:
> > > > > +         if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > > > > +                 return EPOLLIN | EPOLLRDNORM;
> > > > > +         break;
> > > > > + case IIO_BUFFER_DIRECTION_OUT:
> > > > > +         if (iio_buffer_space_available(rb))
> > > > > +                 return EPOLLOUT | EPOLLWRNORM;
> > > > > +         break;
> > > > > + }
> > > > > +
> > > > >   return 0;
> > > > >  }
> > > > >
> > > > > @@ -199,6 +271,19 @@ ssize_t iio_buffer_read_wrapper(struct file *filp,  
> > > > char __user *buf,  
> > > > >   return iio_buffer_read(filp, buf, n, f_ps);  }
> > > > >
> > > > > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user *buf,
> > > > > +                          size_t n, loff_t *f_ps)
> > > > > +{
> > > > > + struct iio_dev_buffer_pair *ib = filp->private_data;
> > > > > + struct iio_buffer *rb = ib->buffer;
> > > > > +
> > > > > + /* check if buffer was opened through new API */
> > > > > + if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> > > > > +         return -EBUSY;
> > > > > +
> > > > > + return iio_buffer_write(filp, buf, n, f_ps); }
> > > > > +
> > > > >  __poll_t iio_buffer_poll_wrapper(struct file *filp,
> > > > >                            struct poll_table_struct *wait)
> > > > >  {
> > > > > @@ -231,6 +316,15 @@ void iio_buffer_wakeup_poll(struct iio_dev  
> > > > *indio_dev)  
> > > > >   }
> > > > >  }
> > > > >
> > > > > +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data) {
> > > > > + if (!buffer || !buffer->access || !buffer->access->remove_from)
> > > > > +         return -EINVAL;
> > > > > +
> > > > > + return buffer->access->remove_from(buffer, data); }
> > > > > +EXPORT_SYMBOL_GPL(iio_pop_from_buffer);
> > > > > +
> > > > >  void iio_buffer_init(struct iio_buffer *buffer)  {
> > > > >   INIT_LIST_HEAD(&buffer->demux_list);
> > > > > @@ -1156,6 +1250,10 @@ int iio_update_buffers(struct iio_dev  
> > > > *indio_dev,  
> > > > >   if (insert_buffer == remove_buffer)
> > > > >           return 0;
> > > > >
> > > > > + if (insert_buffer &&
> > > > > +     (insert_buffer->direction == IIO_BUFFER_DIRECTION_OUT))
> > > > > +         return -EINVAL;
> > > > > +
> > > > >   mutex_lock(&iio_dev_opaque->info_exist_lock);
> > > > >   mutex_lock(&indio_dev->mlock);
> > > > >
> > > > > @@ -1277,6 +1375,22 @@ static ssize_t  
> > > > iio_dma_show_data_available(struct device *dev,  
> > > > >   return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
> > > > >  }
> > > > >
> > > > > +static ssize_t direction_show(struct device *dev,
> > > > > +                       struct device_attribute *attr,
> > > > > +                       char *buf)
> > > > > +{
> > > > > + struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
> > > > > +
> > > > > + switch (buffer->direction) {
> > > > > + case IIO_BUFFER_DIRECTION_IN:
> > > > > +         return sprintf(buf, "in\n");
> > > > > + case IIO_BUFFER_DIRECTION_OUT:
> > > > > +         return sprintf(buf, "out\n");
> > > > > + default:
> > > > > +         return -EINVAL;
> > > > > + }
> > > > > +}
> > > > > +
> > > > >  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> > > > >              iio_buffer_write_length);
> > > > >  static struct device_attribute dev_attr_length_ro = __ATTR(length, @@
> > > > > -1289,12 +1403,20 @@ static struct device_attribute  
> > > > dev_attr_watermark_ro = __ATTR(watermark,  
> > > > >   S_IRUGO, iio_buffer_show_watermark, NULL);  static
> > > > > DEVICE_ATTR(data_available, S_IRUGO,
> > > > >           iio_dma_show_data_available, NULL);
> > > > > +static DEVICE_ATTR_RO(direction);
> > > > >
> > > > > +/*
> > > > > + * When adding new attributes here, put the at the end, at least
> > > > > +until
> > > > > + * the code that handles the length/length_ro &
> > > > > +watermark/watermark_ro
> > > > > + * assignments gets cleaned up. Otherwise these can create some weird
> > > > > + * duplicate attributes errors under some setups.
> > > > > + */
> > > > >  static struct attribute *iio_buffer_attrs[] = {
> > > > >   &dev_attr_length.attr,
> > > > >   &dev_attr_enable.attr,
> > > > >   &dev_attr_watermark.attr,
> > > > >   &dev_attr_data_available.attr,
> > > > > + &dev_attr_direction.attr,
> > > > >  };
> > > > >
> > > > >  #define to_dev_attr(_attr) container_of(_attr, struct
> > > > > device_attribute, attr) @@ -1397,6 +1519,7 @@ static const struct  
> > > > file_operations iio_buffer_chrdev_fileops = {  
> > > > >   .owner = THIS_MODULE,
> > > > >   .llseek = noop_llseek,
> > > > >   .read = iio_buffer_read,
> > > > > + .write = iio_buffer_write,
> > > > >   .poll = iio_buffer_poll,
> > > > >   .release = iio_buffer_chrdev_release,  }; diff --git
> > > > > a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > > > > index 2dbb37e09b8c..537a08549a69 100644
> > > > > --- a/drivers/iio/industrialio-core.c
> > > > > +++ b/drivers/iio/industrialio-core.c
> > > > > @@ -1822,6 +1822,7 @@ static const struct file_operations  
> > > > iio_buffer_fileops = {  
> > > > >   .owner = THIS_MODULE,
> > > > >   .llseek = noop_llseek,
> > > > >   .read = iio_buffer_read_outer_addr,
> > > > > + .write = iio_buffer_write_outer_addr,
> > > > >   .poll = iio_buffer_poll_addr,
> > > > >   .unlocked_ioctl = iio_ioctl,
> > > > >   .compat_ioctl = compat_ptr_ioctl,
> > > > > diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> > > > > index b6928ac5c63d..fe2e680d9b5e 100644
> > > > > --- a/include/linux/iio/buffer.h
> > > > > +++ b/include/linux/iio/buffer.h
> > > > > @@ -11,8 +11,15 @@
> > > > >
> > > > >  struct iio_buffer;
> > > > >
> > > > > +enum iio_buffer_direction {
> > > > > + IIO_BUFFER_DIRECTION_IN,
> > > > > + IIO_BUFFER_DIRECTION_OUT,
> > > > > +};
> > > > > +
> > > > >  int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
> > > > >
> > > > > +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
> > > > > +
> > > > >  /**
> > > > >   * iio_push_to_buffers_with_timestamp() - push data and timestamp to  
> > > > buffers  
> > > > >   * @indio_dev:           iio_dev structure for device.
> > > > > diff --git a/include/linux/iio/buffer_impl.h
> > > > > b/include/linux/iio/buffer_impl.h index 245b32918ae1..e2ca8ea23e19
> > > > > 100644
> > > > > --- a/include/linux/iio/buffer_impl.h
> > > > > +++ b/include/linux/iio/buffer_impl.h
> > > > > @@ -7,6 +7,7 @@
> > > > >  #ifdef CONFIG_IIO_BUFFER
> > > > >
> > > > >  #include <uapi/linux/iio/buffer.h>
> > > > > +#include <linux/iio/buffer.h>
> > > > >
> > > > >  struct iio_dev;
> > > > >  struct iio_buffer;
> > > > > @@ -23,6 +24,10 @@ struct iio_buffer;
> > > > >   * @read:                try to get a specified number of bytes (must exist)
> > > > >   * @data_available:      indicates how much data is available for reading from
> > > > >   *                       the buffer.
> > > > > + * @remove_from: remove scan from buffer. Drivers should calls this to
> > > > > + *                       remove a scan from a buffer.
> > > > > + * @write:               try to write a number of bytes
> > > > > + * @space_available:     returns the amount of bytes available in a  
> > > > buffer  
> > > > >   * @request_update:      if a parameter change has been marked,  
> > > > update underlying  
> > > > >   *                       storage.
> > > > >   * @set_bytes_per_datum:set number of bytes per datum @@ -49,6  
> > > > +54,9  
> > > > > @@ struct iio_buffer_access_funcs {
> > > > >   int (*store_to)(struct iio_buffer *buffer, const void *data);
> > > > >   int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
> > > > >   size_t (*data_available)(struct iio_buffer *buffer);
> > > > > + int (*remove_from)(struct iio_buffer *buffer, void *data);
> > > > > + int (*write)(struct iio_buffer *buffer, size_t n, const char __user  
> > > > *buf);  
> > > > > + size_t (*space_available)(struct iio_buffer *buffer);
> > > > >
> > > > >   int (*request_update)(struct iio_buffer *buffer);
> > > > >
> > > > > @@ -80,6 +88,9 @@ struct iio_buffer {
> > > > >   /**  @bytes_per_datum: Size of individual datum including  
> > > > timestamp. */  
> > > > >   size_t bytes_per_datum;
> > > > >
> > > > > + /* @direction: Direction of the data stream (in/out). */
> > > > > + enum iio_buffer_direction direction;
> > > > > +
> > > > >   /**
> > > > >    * @access: Buffer access functions associated with the
> > > > >    * implementation.  
> > >  
> >  

