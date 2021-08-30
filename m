Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F573FB921
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 17:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbhH3Pkl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 30 Aug 2021 11:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237187AbhH3Pkk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 11:40:40 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F1260F44;
        Mon, 30 Aug 2021 15:39:43 +0000 (UTC)
Date:   Mon, 30 Aug 2021 16:42:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Mihail Chindris <mihail.chindris@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
        dragos.bogdan@analog.com, alexandru.ardelean@analog.com
Subject: Re: [PATCH v4 1/6] iio: Add output buffer support
Message-ID: <20210830164255.7b246bcb@jic23-huawei>
In-Reply-To: <2a67cb8ee77cb96bc899d82348cb0eb0bf44925c.camel@gmail.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
        <20210820165927.4524-2-mihail.chindris@analog.com>
        <2a67cb8ee77cb96bc899d82348cb0eb0bf44925c.camel@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Aug 2021 15:50:14 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Fri, 2021-08-20 at 16:59 +0000, Mihail Chindris wrote:
> > From: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > Currently IIO only supports buffer mode for capture devices like
> > ADCs. Add
> > support for buffered mode for output devices like DACs.
> > 
> > The output buffer implementation is analogous to the input buffer
> > implementation. Instead of using read() to get data from the buffer
> > write()
> > is used to copy data into the buffer.
> > 
> > poll() with POLLOUT will wakeup if there is space available for more
> > or
> > equal to the configured watermark of samples.
> > 
> > Drivers can remove data from a buffer using
> > iio_buffer_remove_sample(), the
> > function can e.g. called from a trigger handler to write the data to
> > hardware.
> > 
> > A buffer can only be either a output buffer or an input, but not
> > both. So,
> > for a device that has an ADC and DAC path, this will mean 2 IIO
> > buffers
> > (one for each direction).
> > 
> > The direction of the buffer is decided by the new direction field of
> > the
> > iio_buffer struct and should be set after allocating and before
> > registering
> > it.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> > ---
> >  drivers/iio/iio_core.h            |   4 +
> >  drivers/iio/industrialio-buffer.c | 133
> > +++++++++++++++++++++++++++++-
> >  drivers/iio/industrialio-core.c   |   1 +
> >  include/linux/iio/buffer.h        |   7 ++
> >  include/linux/iio/buffer_impl.h   |  11 +++
> >  5 files changed, 154 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > index 8f4a9b264962..61e318431de9 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file
> > *filp,
> >  				 struct poll_table_struct *wait);
> >  ssize_t iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> >  				size_t n, loff_t *f_ps);
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char
> > __user *buf,
> > +				 size_t n, loff_t *f_ps);
> >  
> >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> >  void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> >  
> >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)
> >  #define iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
> >  
> >  void iio_disable_all_buffers(struct iio_dev *indio_dev);
> >  void iio_buffer_wakeup_poll(struct iio_dev *indio_dev);
> > @@ -83,6 +86,7 @@ void iio_device_detach_buffers(struct iio_dev
> > *indio_dev);
> >  
> >  #define iio_buffer_poll_addr NULL
> >  #define iio_buffer_read_outer_addr NULL
> > +#define iio_buffer_write_outer_addr NULL
> >  
> >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> > *indio_dev)
> >  {
> > diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index a95cc2da56be..73d4451a0572 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -161,6 +161,69 @@ static ssize_t iio_buffer_read(struct file
> > *filp, char __user *buf,
> >  	return ret;
> >  }
> >  
> > +static size_t iio_buffer_space_available(struct iio_buffer *buf)
> > +{
> > +	if (buf->access->space_available)
> > +		return buf->access->space_available(buf);
> > +
> > +	return SIZE_MAX;
> > +}
> > +
> > +static ssize_t iio_buffer_write(struct file *filp, const char __user
> > *buf,
> > +				size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib = filp->private_data;
> > +	struct iio_buffer *rb = ib->buffer;
> > +	struct iio_dev *indio_dev = ib->indio_dev;
> > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > +	size_t datum_size;
> > +	size_t to_wait;
> > +	int ret;
> > +  
> 
> Even though I do not agree that this is suficient, we should have the
> same check as we have for input buffer:
> 
> 
> if (!indio_dev->info)
> 	return -ENODEV;
> 
> > +	if (!rb || !rb->access->write)
> > +		return -EINVAL;
> > +
> > +	datum_size = rb->bytes_per_datum;
> > +
> > +	/*
> > +	 * If datum_size is 0 there will never be anything to read from
> > the
> > +	 * buffer, so signal end of file now.
> > +	 */
> > +	if (!datum_size)
> > +		return 0;
> > +
> > +	if (filp->f_flags & O_NONBLOCK)
> > +		to_wait = 0;
> > +	else
> > +		to_wait = min_t(size_t, n / datum_size, rb->watermark);
> > +  
> 
> I had a bit of a crazy thought... Typically, output devices do not
> really have a typical trigger as we are used to have in input devices.
> Hence, typically we just use a hrtimer (maybe a pwm-trigger can also be
> added) trigger where we kind of poll the buffer for new data to send to
> the device.

htrimer-trigger effectively gives you the hrtimer option but lets you swap
it for other types. Maybe updating your DAC in sync with an ADC dataready to
change some input to a network you are measuring? 

An external pwm type trigger (effectively a hwtrigger) would indeed be
useful for much the same reason those get used for ADCs on SoCs.  For ADCs
that are doing self clocking you can think of that as an internal pwm trigger
that we can't see at all.

> So, I was wondering if we could just optionally bypass the
> kbuf path in output devices (via some optional buffer option)? At this
> point, we pretty much already know that we have data to consume :).
> This would be kind of a synchronous interface. One issue I see with
> this is that we cannot really have a deterministic (or close) sampling
> frequency as we have for example with a pwm based trigger.

If you are running without a buffer, the overhead of sysfs is unlikely to
be a particularly big problem, so do it that way if you want synchronous
control.  The purpose of the buffer is to smooth out those interactions.

I guess it 'might' make sense to have a special trigger that is a similar
to the poll trigger in that it will push data to the device as quickly
as possible as long as there is some there...  That would look like a
synchronous interface.

> 
> Anyways, just me throwing some ideas. This is not the most important
> thing for now...
> 
> - Nuno Sá 
> >   
> 

