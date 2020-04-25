Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C750B1B877B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 17:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDYPrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 11:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDYPrS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:47:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7676520644;
        Sat, 25 Apr 2020 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587829637;
        bh=lSIPFWfPmqrhfz/68+uAdMRkD49fvIiQl3etQyD/o1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R9ZMQIWM2tvaGemmGWuzpvN1P3ZFzb8N4elLt+TJTMm7lXjo8xrYI0iaK5YhCkBEi
         BeioUomMnLg8CvK0xfzbwLMEu5+ma92R0ANiIO5xrHesAKjiDl/VDLcH2Pm9SAlbB3
         0aJ+K/Gb8umD9lbJAomdMpS3BfGQCm1mj3cu4UEY=
Date:   Sat, 25 Apr 2020 16:47:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: Use an early return in iio_device_alloc to
 simplify code.
Message-ID: <20200425164713.201c89cc@archlinux>
In-Reply-To: <0aac8f5bd4836b8ac0013bf19b2d8a0f9a8b5c47.camel@analog.com>
References: <20200419151337.43293-1-jic23@kernel.org>
        <0aac8f5bd4836b8ac0013bf19b2d8a0f9a8b5c47.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 06:17:32 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-04-19 at 16:13 +0100, jic23@kernel.org wrote:
> > [External]
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Noticed whilst reviewing Alexandru's patch to the same function.
> > If we simply flip the logic and return NULL immediately after memory
> > allocation failure we reduce the indent of the following block and
> > end up with more 'idiomatic' kernel code.
> >   
> 
> I also was tempted to do it, but was tempted [a bit more] by the initial change
> that I goofed.
> 
> A few thoughts on this [can be ignored].
> But, since doing this change, should 'dev' be renamed to 'indio_dev'?
> It shouldn't be a lot more code than the current change [I hope].
> When looking through IIO core, I got a minor/slight confusion on this alloc code
> about the name 'dev' [which is of type 'struct iio_dev' vs 'struct device', as
> is more customary].
> 
> If 'dev' was chosen to fit within any 80 col-width limit, that limit should be
> less likely to hit now.

A different type of cleanup, so I think worth a separate patch
(even though it's messing with the same block of code.)

Got to keep to the rules I pester everyone else into following :)

So I'll apply this as is and might get the dev->indio_dev one out
after I've caught up with rest of email queue. 

Thanks,

Jonathan

> 
> 1 more inline.
> 
> Well, even with/without these changes.
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/industrialio-core.c | 38 ++++++++++++++++-----------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index f4daf19f2a3b..96f6dacb206d 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1504,27 +1504,27 @@ struct iio_dev *iio_device_alloc(int sizeof_priv)
> >  	alloc_size += IIO_ALIGN - 1;
> >  
> >  	dev = kzalloc(alloc_size, GFP_KERNEL);
> > +	if (!dev)
> > +		return NULL;
> >  
> > -	if (dev) {
> > -		dev->dev.groups = dev->groups;
> > -		dev->dev.type = &iio_device_type;
> > -		dev->dev.bus = &iio_bus_type;
> > -		device_initialize(&dev->dev);
> > -		dev_set_drvdata(&dev->dev, (void *)dev);
> > -		mutex_init(&dev->mlock);
> > -		mutex_init(&dev->info_exist_lock);
> > -		INIT_LIST_HEAD(&dev->channel_attr_list);
> > -
> > -		dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> > -		if (dev->id < 0) {
> > -			/* cannot use a dev_err as the name isn't available */
> > -			pr_err("failed to get device id\n");
> > -			kfree(dev);
> > -			return NULL;
> > -		}
> > -		dev_set_name(&dev->dev, "iio:device%d", dev->id);
> > -		INIT_LIST_HEAD(&dev->buffer_list);
> > +	dev->dev.groups = dev->groups;
> > +	dev->dev.type = &iio_device_type;
> > +	dev->dev.bus = &iio_bus_type;
> > +	device_initialize(&dev->dev);
> > +	dev_set_drvdata(&dev->dev, (void *)dev);
> > +	mutex_init(&dev->mlock);
> > +	mutex_init(&dev->info_exist_lock);
> > +	INIT_LIST_HEAD(&dev->channel_attr_list);
> > +
> > +	dev->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> > +	if (dev->id < 0) {
> > +		/* cannot use a dev_err as the name isn't available */
> > +		pr_err("failed to get device id\n");
> > +		kfree(dev);
> > +		return NULL;  
> 
> would it be too much for this patch to move this right after the kzalloc()?
> no strong opinion from my side to do it or not;
> but it does save some init cycles, and compresses this init block a bit;

It doesn't really save any cycles because the chance of failure of ID allocation
is negligible...  Now I'd agree with you if writing from scratch, but as a
tidy up patch, it's good to keep things really simple.


> 
> >  	}
> > +	dev_set_name(&dev->dev, "iio:device%d", dev->id);
> > +	INIT_LIST_HEAD(&dev->buffer_list);
> >  
> >  	return dev;
> >  }  

