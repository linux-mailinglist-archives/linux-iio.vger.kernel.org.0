Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B2B1CE1E4
	for <lists+linux-iio@lfdr.de>; Mon, 11 May 2020 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgEKRmi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 May 2020 13:42:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2189 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbgEKRmi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 May 2020 13:42:38 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 357B61B5DFF4298CFAE2;
        Mon, 11 May 2020 18:42:36 +0100 (IST)
Received: from localhost (10.47.24.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 11 May
 2020 18:42:35 +0100
Date:   Mon, 11 May 2020 18:42:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: core: wrap IIO device into a iio_dev_priv
 object
Message-ID: <20200511184213.0000003c@Huawei.com>
In-Reply-To: <b667b10489c65b541aacadd7975b0a6352672153.camel@analog.com>
References: <20200508141306.17222-1-alexandru.ardelean@analog.com>
        <20200508164015.0000223f@Huawei.com>
        <20200508164430.00001741@Huawei.com>
        <b667b10489c65b541aacadd7975b0a6352672153.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.74]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 May 2020 09:16:32 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Fri, 2020-05-08 at 16:44 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Fri, 8 May 2020 16:40:15 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Fri, 8 May 2020 17:13:04 +0300
> > > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> > >   
> > > > There are plenty of bad designs we want to discourage or not have to
> > > > review
> > > > manually usually about accessing private (marked as [INTERN]) fields of
> > > > 'struct iio_dev'.    
> > > 
> > > This has been on the todo list for many years so great you are having a go.
> > >    
> > > > This is difficult, as a lot of users copy drivers, and not always the best
> > > > examples.
> > > > 
> > > > A better idea is to hide those fields into the framework.
> > > > For 'struct iio_dev' this is a 'struct iio_dev_priv' which wraps a public
> > > > 'struct iio_dev' object.
> > > > 
> > > > In the next patches, some fields will be moved to this new struct, each
> > > > with it's own rework.
> > > > 
> > > > This rework will not be complete[-able] for a while, as many fields need
> > > > some drivers to be reworked in order to finalize them
> > > > (e.g. 'indio_dev->mlock').
> > > > 
> > > > But some fields can already be moved, and in time, all of them may get
> > > > there (in the 'struct iio_dev_priv' object).
> > > > 
> > > > We also need to hide the implementations for 'iio_priv()' &
> > > > 'iio_priv_to_dev()', as the pointer arithmetic will not match once things
> > > > are moved.    
> > > 
> > > This last bit has the disadvantage of potentially putting a function
> > > call in some fast paths where there wasn't one before.  
> 
> Hmm.
> I think we can change this to have a void *ptr in the public iio.h header and
> that points to the private data in the private struct, and we compute it once,
> and just return it.
> 
> so:
> 
> struct iio_dev_opaque;
> 
> struct iio_dev {
>     struct iio_dev_opaque *opaque;  // compute this during iio_device_alloc()
>     void *priv;                     // compute this during iio_device_alloc()
> };
> 
> static inline void *iio_priv(const struct iio_dev *indio_dev)
> {
>         return indio_dev->priv;
> }
> 
> [ or even just convert it to a macro ; no preference ]

That works for me and avoids any of the messy stuff below.

Make sure to add a comment that the region that points to is guaranteed
to maintain cacheline alignment as thats hidden now.

> 
> > > 
> > > We may not need to 'forcefully' hide the internal parts.  May be
> > > enough to just make their use really obvious.  If you have to cast
> > > to an iio_dev_priv then you are doing something very wrong.  
> > 
> > Note, definitely keep the to_* macro only in the private core header.
> >   
> > > The old stick __ in front of it may make that even more obvious.
> > > 
> > > Naming is a bit confusing though.  iio_dev_priv sounds like private
> > > to the device... iio_dev_opaque maybe?  
> 
> regarding the 'opaque' part, that would be a 'struct iio_dev_opaque {' that
> lives somewhere like
> 
> struct iio_dev_opaque {
>     struct iio_dev   indio_dev;  // public IIO device part
>     ... // opaque IIO device parts
>     ... // iio_priv data
> }
> 
> The stick __ in front, may work just fine as well.
> 
> Personally, I would prefer to forcefully hide stuff, because then the compiler
> could also be useful in telling people not to use some private fields.
> People [juniors usually] listen to compilers more than they listen to review-
> comments. 
> We could move the 'struct iio_dev_opaque' in 'include/linux/iio/iio-opaque.h',
> so that if they need to access some fields for some advanced/hacky debugging, it
> should work as well.
> 
> Still, if it's more preferred to prefix them, I can do that as well.
> But we should prefix them as we manage to somehow make the more opaque, or
> remove the fields from places they should be used.
> Otherwise it is pointless, as people would copy 'indio_dev->__mlock' anyway.
> 
> 
> > > 
> > >   
> > > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > > ---
> > > > 
> > > > Just as a note here, I've been running this patchset without a problem
> > > > for 2 weeks now in a work branch.
> > > > But it's only been a setup, so no idea if some other thing may cause
> > > > bigger issues.
> > > > 
> > > > This small patchset is meant to kickstart this, for GSoC people or for
> > > > people wanting to start contributing to IIO.
> > > > 
> > > >  drivers/iio/iio_core.h          | 11 +++++++++++
> > > >  drivers/iio/industrialio-core.c | 32 +++++++++++++++++++++++++++-----
> > > >  include/linux/iio/iio.h         | 12 ++----------
> > > >  3 files changed, 40 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> > > > index fd9a5f1d5e51..84f3b4590c05 100644
> > > > --- a/drivers/iio/iio_core.h
> > > > +++ b/drivers/iio/iio_core.h
> > > > @@ -17,6 +17,17 @@ struct iio_dev;
> > > >  
> > > >  extern struct device_type iio_device_type;
> > > >  
> > > > +/**
> > > > + * struct iio_dev_priv - industrial I/O device private information
> > > > + * @indio_dev:			public IIO device object
> > > > + */
> > > > +struct iio_dev_priv {
> > > > +	struct iio_dev			indio_dev;
> > > > +};
> > > > +
> > > > +#define to_iio_dev_priv(indio_dev)	\
> > > > +	container_of(indio_dev, struct iio_dev_priv, indio_dev)
> > > > +
> > > >  int __iio_add_chan_devattr(const char *postfix,
> > > >  			   struct iio_chan_spec const *chan,
> > > >  			   ssize_t (*func)(struct device *dev,
> > > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-
> > > > core.c
> > > > index 462d3e810013..f0888dd84d3d 100644
> > > > --- a/drivers/iio/industrialio-core.c
> > > > +++ b/drivers/iio/industrialio-core.c
> > > > @@ -164,6 +164,23 @@ static const char * const iio_chan_info_postfix[] = {
> > > >  	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
> > > >  };
> > > >  
> > > > +
> > > > +void *iio_priv(const struct iio_dev *indio_dev)
> > > > +{
> > > > +	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
> > > > +	return (char *)iio_dev_priv + ALIGN(sizeof(struct iio_dev_priv),
> > > > IIO_ALIGN);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(iio_priv);
> > > > +
> > > > +struct iio_dev *iio_priv_to_dev(void *priv)
> > > > +{
> > > > +	struct iio_dev_priv *iio_dev_priv =
> > > > +		(struct iio_dev_priv *)((char *)priv -
> > > > +				  ALIGN(sizeof(struct iio_dev_priv),
> > > > IIO_ALIGN));
> > > > +	return &iio_dev_priv->indio_dev;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(iio_priv_to_dev);
> > > > +
> > > >  /**
> > > >   * iio_find_channel_from_si() - get channel from its scan index
> > > >   * @indio_dev:		device
> > > > @@ -1476,6 +1493,8 @@ static void iio_device_unregister_sysfs(struct
> > > > iio_dev *indio_dev)
> > > >  static void iio_dev_release(struct device *device)
> > > >  {
> > > >  	struct iio_dev *indio_dev = dev_to_iio_dev(device);
> > > > +	struct iio_dev_priv *iio_dev_priv = to_iio_dev_priv(indio_dev);
> > > > +
> > > >  	if (indio_dev->modes & INDIO_ALL_TRIGGERED_MODES)
> > > >  		iio_device_unregister_trigger_consumer(indio_dev);
> > > >  	iio_device_unregister_eventset(indio_dev);
> > > > @@ -1484,7 +1503,7 @@ static void iio_dev_release(struct device *device)
> > > >  	iio_buffer_put(indio_dev->buffer);
> > > >  
> > > >  	ida_simple_remove(&iio_ida, indio_dev->id);
> > > > -	kfree(indio_dev);
> > > > +	kfree(iio_dev_priv);
> > > >  }
> > > >  
> > > >  struct device_type iio_device_type = {
> > > > @@ -1498,10 +1517,11 @@ struct device_type iio_device_type = {
> > > >   **/
> > > >  struct iio_dev *iio_device_alloc(int sizeof_priv)
> > > >  {
> > > > +	struct iio_dev_priv *iio_dev_priv;
> > > >  	struct iio_dev *dev;
> > > >  	size_t alloc_size;
> > > >  
> > > > -	alloc_size = sizeof(struct iio_dev);
> > > > +	alloc_size = sizeof(struct iio_dev_priv);
> > > >  	if (sizeof_priv) {
> > > >  		alloc_size = ALIGN(alloc_size, IIO_ALIGN);
> > > >  		alloc_size += sizeof_priv;
> > > > @@ -1509,10 +1529,12 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
> > > >  	/* ensure 32-byte alignment of whole construct ? */
> > > >  	alloc_size += IIO_ALIGN - 1;
> > > >  
> > > > -	dev = kzalloc(alloc_size, GFP_KERNEL);
> > > > -	if (!dev)
> > > > +	iio_dev_priv = kzalloc(alloc_size, GFP_KERNEL);
> > > > +	if (!iio_dev_priv)
> > > >  		return NULL;
> > > >  
> > > > +	dev = &iio_dev_priv->indio_dev;
> > > > +
> > > >  	dev->dev.groups = dev->groups;
> > > >  	dev->dev.type = &iio_device_type;
> > > >  	dev->dev.bus = &iio_bus_type;
> > > > @@ -1526,7 +1548,7 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
> > > >  	if (dev->id < 0) {
> > > >  		/* cannot use a dev_err as the name isn't available */
> > > >  		pr_err("failed to get device id\n");
> > > > -		kfree(dev);
> > > > +		kfree(iio_dev_priv);
> > > >  		return NULL;
> > > >  	}
> > > >  	dev_set_name(&dev->dev, "iio:device%d", dev->id);
> > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > > index 5f9f439a4f01..38c4ea505394 100644
> > > > --- a/include/linux/iio/iio.h
> > > > +++ b/include/linux/iio/iio.h
> > > > @@ -678,16 +678,8 @@ static inline void *iio_device_get_drvdata(struct
> > > > iio_dev *indio_dev)
> > > >  #define IIO_ALIGN L1_CACHE_BYTES
> > > >  struct iio_dev *iio_device_alloc(int sizeof_priv);
> > > >  
> > > > -static inline void *iio_priv(const struct iio_dev *indio_dev)
> > > > -{
> > > > -	return (char *)indio_dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
> > > > -}
> > > > -
> > > > -static inline struct iio_dev *iio_priv_to_dev(void *priv)
> > > > -{
> > > > -	return (struct iio_dev *)((char *)priv -
> > > > -				  ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
> > > > -}
> > > > +void *iio_priv(const struct iio_dev *indio_dev);
> > > > +struct iio_dev *iio_priv_to_dev(void *priv);
> > > >  
> > > >  void iio_device_free(struct iio_dev *indio_dev);
> > > >  struct iio_dev *devm_iio_device_alloc(struct device *dev, int
> > > > sizeof_priv);    
> > 
> >   


