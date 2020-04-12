Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7731A5E34
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgDLLS3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLLS3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:18:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1555C206E9;
        Sun, 12 Apr 2020 11:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586690309;
        bh=KVxlN5pn9biEvZszl+Y+7ZXezrAEjJJg578pji2Cn5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AELM0sLAn6vjIN6P4iu0wZmzKagd5DqiyEGAjE0ScHaCoZwabaIsabcfwpw4APzVL
         XyRtESekXsjNZeKly+q9PJZ7qN1pAeEryAR5klskxUwDL5Td6SrLz16TQZioDOKbbk
         DcEKF6AgVS+bylCoQ3fQCGFrJgFDILOXCZRuh9zU=
Date:   Sun, 12 Apr 2020 12:18:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
Subject: Re: [PATCH 1/3] iio: kfifo: add iio_device_attach_kfifo_buffer()
 helper
Message-ID: <20200412121824.2319c12d@archlinux>
In-Reply-To: <48e7f8d5f090971e0c48c0134ebb2dca86a0f144.camel@analog.com>
References: <20200401125936.6398-1-alexandru.ardelean@analog.com>
        <20200405114602.160c690b@archlinux>
        <48e7f8d5f090971e0c48c0134ebb2dca86a0f144.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Apr 2020 08:12:42 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-04-05 at 11:46 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Wed, 1 Apr 2020 15:59:34 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > This change adds the iio_device_attach_kfifo_buffer() helper/short-hand,
> > > which groups the simple routine of allocating a kfifo buffers via
> > > devm_iio_kfifo_allocate() and calling iio_device_attach_buffer().
> > > 
> > > The mode_flags parameter is required. The setup_ops parameter is optional.
> > > 
> > > This function will be a bit more useful when needing to define multiple
> > > buffers per IIO device.
> > > 
> > > One requirement [that is more a recommendation] for this helper, is to call
> > > it after 'indio_dev' has been populated.
> > > 
> > > Also, one consequence related to using this helper is that the resource
> > > management of the buffer will be tied to 'indio_dev->dev'. Previously it
> > > was open-coded, and each driver does it slightly differently. Most of them
> > > tied it to the parent device, some of them to 'indio_dev->dev'.
> > > This shouldn't be a problem, and may be a good idea when adding more
> > > buffers per-device.  
> > 
> > I'm glad you highlighted this subtlety.  I'm not sure it's safe in all cases
> > because the result is that the managed cleanup for this will occur once we
> > get to the cleanup for devm_iio_device_alloc and we release the indio_dev->dev
> > 
> > That would put it 'after' any other devm calls that are still hung off the
> > parent
> > device.
> > 
> > Now the question is whether that ever causes us problems... See next patch.
> > It potentially does.  I think we need to provide the dev separately even
> > if it feels a bit silly to do so.  Scope management is complex so I don't
> > really want to force people to mix and match between different devices
> > and so get it wrong by accident.
> > 
> > The other issue is that it's not readily apparent from the naming that
> > this function is registering stuff that is cleaned up automatically or
> > that it even allocates anything that might need that..
> > 
> > devm_iio_device_attach_new_kfifo_buffer maybe?
> > 
> > I'm sort of wondering if we should do what dma did and have
> > 
> > iiom_device_attach_new_kfifo_buffer to indicate it's managed in the
> > scope of the iio device?
> > 
> > What do people think?
> > 
> > However, see patch 2 before commenting.  Reality is I'm not sure forcing
> > managed calls to hang off iio_dev->dev is a good idea (at this stage given
> > where we are).  
> 
> What I am really after with this patch is to hide away these:
>      iio_kfifo_free(indio_dev->buffer);
>      iio_buffer_set_attrs(indio_dev->buffer, xxxx_fifo_attributes); 
> i.e. not have 'indio_dev->buffer' open-coded in drivers, and hide it in IIO core
> somewhere.
> Some ideas can go in parallel [like this one] to add support for multiple
> buffers.
> 
> So, I will think of a better [less sloppy] V2 for this.
> 
> One intermediate alternative is to do 'iio_device_kfifo_free(indio_dev)', but
> I'll still try to think of a better devm_ approach.
> devm_iio_device_attach_new_kfifo_buffer() sounds a bit long but may work.
> iiom_device_attach_new_kfifo_buffer() can also work.
> 
> What if we just default attaching to the parent device?

That would work and be consistent with the vast majority of current cases.

> 
> Would it work to also attach the parent device in devm_iio_device_alloc() by
> default?

That would need a thorough audit to check nothing crazy is done by
a driver with an odd structure.  Such a driver would (I think) be
buggy though as the child lifetime should be dependent on the parent
and not some other device.

> Or change 'iio_device_alloc()' to take a parent device as argument?

I think there are only a couple of users, so that would work.

> Which for devm_iio_device_alloc(dev,...) would implicitly mean that 'dev' is
> 'parent'?

I think that's a fair assumption (though needs a sanity check)

> 
> These are just some thoughts.
> 
> 
> > 
> > Thanks
> > 
> > Jonathan
> > 
> >   
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > ---
> > >  drivers/iio/buffer/kfifo_buf.c | 37 ++++++++++++++++++++++++++++++++++
> > >  include/linux/iio/kfifo_buf.h  |  4 ++++
> > >  2 files changed, 41 insertions(+)
> > > 
> > > diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> > > index 3150f8ab984b..05b7c5fc6f1d 100644
> > > --- a/drivers/iio/buffer/kfifo_buf.c
> > > +++ b/drivers/iio/buffer/kfifo_buf.c
> > > @@ -228,4 +228,41 @@ void devm_iio_kfifo_free(struct device *dev, struct
> > > iio_buffer *r)
> > >  }
> > >  EXPORT_SYMBOL(devm_iio_kfifo_free);
> > >  
> > > +/**
> > > + * iio_device_attach_kfifo_buffer - Allocate a kfifo buffer & attach it to
> > > an IIO device
> > > + * @indio_dev: The device the buffer should be attached to
> > > + * @mode_flags: The mode flags for this buffer (INDIO_BUFFER_SOFTWARE
> > > and/or
> > > + *		INDIO_BUFFER_TRIGGERED).
> > > + * @setup_ops: The setup_ops required to configure the HW part of the
> > > buffer (optional)
> > > + *
> > > + * This function allocates a kfifo buffer via devm_iio_kfifo_allocate() and
> > > + * attaches it to the IIO device via iio_device_attach_buffer().
> > > + * This is meant to be a bit of a short-hand/helper function as many driver
> > > + * seem to do this.
> > > + */
> > > +int iio_device_attach_kfifo_buffer(struct iio_dev *indio_dev,
> > > +				   int mode_flags,
> > > +				   const struct iio_buffer_setup_ops *setup_ops)
> > > +{
> > > +	struct iio_buffer *buffer;
> > > +
> > > +	if (mode_flags)
> > > +		mode_flags &= kfifo_access_funcs.modes;
> > > +
> > > +	if (!mode_flags)
> > > +		return -EINVAL;
> > > +
> > > +	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
> > > +	if (!buffer)
> > > +		return -ENOMEM;
> > > +
> > > +	iio_device_attach_buffer(indio_dev, buffer);
> > > +
> > > +	indio_dev->modes |= mode_flags;
> > > +	indio_dev->setup_ops = setup_ops;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_device_attach_kfifo_buffer);
> > > +
> > >  MODULE_LICENSE("GPL");
> > > diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
> > > index 764659e01b68..2363a931be14 100644
> > > --- a/include/linux/iio/kfifo_buf.h
> > > +++ b/include/linux/iio/kfifo_buf.h
> > > @@ -11,4 +11,8 @@ void iio_kfifo_free(struct iio_buffer *r);
> > >  struct iio_buffer *devm_iio_kfifo_allocate(struct device *dev);
> > >  void devm_iio_kfifo_free(struct device *dev, struct iio_buffer *r);
> > >  
> > > +int iio_device_attach_kfifo_buffer(struct iio_dev *indio_dev,
> > > +				   int mode_flags,
> > > +				   const struct iio_buffer_setup_ops
> > > *setup_ops);
> > > +
> > >  #endif  

