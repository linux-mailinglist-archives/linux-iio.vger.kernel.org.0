Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3813D41260A
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385958AbhITSwy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 20 Sep 2021 14:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385888AbhITSwh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2C5613AD;
        Mon, 20 Sep 2021 18:00:35 +0000 (UTC)
Date:   Mon, 20 Sep 2021 19:04:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v5 1/6] iio: Add output buffer support
Message-ID: <20210920190419.04291227@jic23-huawei>
In-Reply-To: <SJ0PR03MB6359EFF08F0830A5D0EE181199A09@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210916182914.1810-1-mihail.chindris@analog.com>
        <20210916182914.1810-2-mihail.chindris@analog.com>
        <20210919180244.1f935bcd@jic23-huawei>
        <SJ0PR03MB6359EFF08F0830A5D0EE181199A09@SJ0PR03MB6359.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Sep 2021 08:02:29 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Sunday, September 19, 2021 7:03 PM
> > To: Chindris, Mihail <Mihail.Chindris@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > lars@metafoo.de; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Sa, Nuno
> > <Nuno.Sa@analog.com>; Bogdan, Dragos
> > <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com
> > Subject: Re: [PATCH v5 1/6] iio: Add output buffer support
> > 
> > On Thu, 16 Sep 2021 18:29:09 +0000
> > Mihail Chindris <mihail.chindris@analog.com> wrote:
> >   
> > > Currently IIO only supports buffer mode for capture devices like  
> > ADCs. Add  
> > > support for buffered mode for output devices like DACs.
> > >
> > > The output buffer implementation is analogous to the input buffer
> > > implementation. Instead of using read() to get data from the buffer  
> > write()  
> > > is used to copy data into the buffer.
> > >
> > > poll() with POLLOUT will wakeup if there is space available.
> > >
> > > Drivers can remove data from a buffer using iio_pop_from_buffer(),  
> > the  
> > > function can e.g. called from a trigger handler to write the data to
> > > hardware.
> > >
> > > A buffer can only be either a output buffer or an input, but not both.  
> > So,  
> > > for a device that has an ADC and DAC path, this will mean 2 IIO  
> > buffers  
> > > (one for each direction).
> > >
> > > The direction of the buffer is decided by the new direction field of  
> > the  
> > > iio_buffer struct and should be set after allocating and before  
> > registering  
> > > it.
> > >
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Alexandru Ardelean  
> > <alexandru.ardelean@analog.com>  
> > > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>  
> > 
> > A few minor things inline.  I would have expected the missing check
> > on insert_buffer to have resulted in a nasty deference of a null pointer
> > though which does make me nervous about whether we have tested
> > this
> > series enough.
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/iio_core.h            |   4 +
> > >  drivers/iio/industrialio-buffer.c | 120  
> > +++++++++++++++++++++++++++++-  
> > >  drivers/iio/industrialio-core.c   |   1 +
> > >  include/linux/iio/buffer.h        |   7 ++
> > >  include/linux/iio/buffer_impl.h   |  11 +++
> > >  5 files changed, 141 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > > index 8f4a9b264962..61e318431de9 100644
> > > --- a/drivers/iio/iio_core.h
> > > +++ b/drivers/iio/iio_core.h
> > > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file  
> > *filp,  
> > >  				 struct poll_table_struct *wait);
> > >  ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> > >  				size_t n, loff_t *f_ps);
> > > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user  
> > *buf,  
> > > +				 size_t n, loff_t *f_ps);
> > >
> > >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> > >  void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> > >
> > >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
> > >  #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > > +#define iio_buffer_write_outer_addr  
> > (&iio_buffer_write_wrapper)  
> > >
> > >  void iio_disable_all_buffers(struct iio_dev *indio_dev);
> > >  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> > > @@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev  
> > *indio_dev);  
> > >
> > >  #define iio_buffer_poll_addr NULL
> > >  #define iio_buffer_read_outer_addr NULL
> > > +#define iio_buffer_write_outer_addr NULL
> > >
> > >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev  
> > *indio_dev)  
> > >  {
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-  
> > buffer.c  
> > > index a95cc2da56be..a2a34c5652a7 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -161,6 +161,62 @@ static ssize_t iio_buffer_read(struct file *filp,  
> > char __user *buf,  
> > >  	return ret;
> > >  }
> > >
> > > +static size_t iio_buffer_space_available(struct iio_buffer *buf)
> > > +{
> > > +	if (buf->access->space_available)
> > > +		return buf->access->space_available(buf);
> > > +
> > > +	return SIZE_MAX;
> > > +}
> > > +
> > > +static ssize_t iio_buffer_write(struct file *filp, const char __user  
> > *buf,  
> > > +				size_t n, loff_t *f_ps)
> > > +{
> > > +	struct iio_dev_buffer_pair *ib = filp->private_data;
> > > +	struct iio_buffer *rb = ib->buffer;
> > > +	struct iio_dev *indio_dev = ib->indio_dev;
> > > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > > +	int ret;
> > > +	size_t written;
> > > +
> > > +	if (!indio_dev->info)
> > > +		return -ENODEV;
> > > +
> > > +	if (!rb || !rb->access->write)
> > > +		return -EINVAL;
> > > +  
> 
> As the buffer implementation can support both 'read()' and 'write()', the following
> check might make sense:
> 
> if (rb->direction != IIO_BUFFER_DIRECTION_OUT)
>       return -EPERM;

Makes sense.  Whether EPERM is the right error code is a different question.
Doesn't seem perfectly aligned with this case, but it's not too bad.

Jonathan

> 
> If going with this, we should add an extra patch to do a similar thing on the read side...
> 
> - Nuno Sá
> 

