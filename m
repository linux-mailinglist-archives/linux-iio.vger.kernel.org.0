Return-Path: <linux-iio+bounces-8394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A52C694DC1F
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 11:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBCE1F21EAA
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB1B15383C;
	Sat, 10 Aug 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRJdI8Wi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021E1798C;
	Sat, 10 Aug 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723283659; cv=none; b=dhHH7wDaky1skgWcbbBf43MS/16jlmUPMdPo8Ifl8h3iX8czuK1EY5p5b64HyuRSIjIBIhyYrDDdTLXvl0Y4BzRJP6AqVSSp7ALy5RPQiUoUX0GyUOyYmosZWSypnjPRbaY3lPKW7tQJxQtOUDZ2tiz8HSoJ32TrR3Z2EHio8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723283659; c=relaxed/simple;
	bh=vD/GVYgEx33+GRsz3bP143VKfVsdmGsrNmwftjVh2O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0rRWjNKEcNkpDNW4L+9WjFLLRyxeTGMXwP9L/84H3arvRDSfelFwaYaUdnEGJ5sEjKpDxBAJM0QL9dPcuO4wxZE3WH7JSxA1IYjEs09OGE0uIBZlc9EJPJ5cJ+GczQyXFB1Ap+nU/jXxHgc2XT+uVWKWmw766UYaGcyMAhJsxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRJdI8Wi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8EFC32781;
	Sat, 10 Aug 2024 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723283658;
	bh=vD/GVYgEx33+GRsz3bP143VKfVsdmGsrNmwftjVh2O8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VRJdI8Wi9cheKo3EwQoC6+guL3GF3ZkqoO5upO/S6/2nG/6KTCk9uys3/FYaBtYjY
	 Bt5aj/J8HhdsRV9W5bnTME7LQCHh/4rh30KZcNAZ51cnnOSEZ2Fc1vLfb5NQx0ADlm
	 SDbGq7rYNRFJBb/4jxtIU3cmEmAonVtRRVqf7ramvsXPRkfaLUG+gNOK9GZKdkQ/UD
	 J9AdnL0YA59rTrTGAJ68Y5hBF/SZ+4hreomg2y/bQ/isqaIDIuGRyOor9ezigoWT4t
	 9SmDd2jc10T20DjwWkBJCWeege2YIvSKu+FGPbsHFoN9yX5zDbC1SAjfp8M7apI7sy
	 l6piymPyrj1hg==
Date: Sat, 10 Aug 2024 10:54:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marius Cristea <marius.cristea@microchip.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: adc: add support for pac1921
Message-ID: <20240810105411.705cb225@jic23-huawei>
In-Reply-To: <66b1f288678b6_31cc370bc@njaxe.notmuch>
References: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
	<20240724-iio-pac1921-v4-3-723698e903a3@gmail.com>
	<20240728135306.422713ea@jic23-huawei>
	<66a784bac1db7_89a37017@njaxe.notmuch>
	<20240729211100.0d602d6e@jic23-huawei>
	<66b1f288678b6_31cc370bc@njaxe.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Aug 2024 11:53:12 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Jonathan Cameron wrote:
> > > > > +
> > > > > +/*
> > > > > + * Emit on sysfs the list of available scales contained in scales_tbl
> > > > > + *
> > > > > + * TODO:: this function can be replaced with iio_format_avail_list() if the
> > > > > + * latter will ever be exported.    
> > > > 
> > > > You could just have added a precursor patch doing that.
> > > > If you have time I'd certainly consider a patch that does export that function
> > > > and uses it here.
> > > >    
> > > I wasn't sure that one usage was enough to justify the export. I could
> > > definitely do it, I am assuming it would now go to a new patch series since
> > > this has already been merged into testing, right?  
> > The requirements for justifying exporting an existing function is less
> > than it would be to add a new one.  As such I think it makes sense.
> > 
> > As you note, needs a separate patch on top of the tree.
> >   
> I will try to address this more generally by adding a new
> read_avail_release_resource() iio_info function, see below. If that goes
> through, exporting the iio_format_avail_list() would not be necessary since the
> driver could directly use the read_avail iio_info function.
> 
> > >   
> > > > > + *
> > > > > + * Must be called with lock held if the scales_tbl can change runtime (e.g. for
> > > > > + * the current scales table)
> > > > > + */
> > > > > +static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
> > > > > +					  size_t size, char *buf)
> > > > > +{
> > > > > +	ssize_t len = 0;
> > > > > +
> > > > > +	for (unsigned int i = 0; i < size; i++) {
> > > > > +		if (i != 0) {
> > > > > +			len += sysfs_emit_at(buf, len, " ");
> > > > > +			if (len >= PAGE_SIZE)
> > > > > +				return -EFBIG;
> > > > > +		}
> > > > > +		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
> > > > > +				     scales_tbl[i][1]);
> > > > > +		if (len >= PAGE_SIZE)
> > > > > +			return -EFBIG;
> > > > > +	}
> > > > > +
> > > > > +	len += sysfs_emit_at(buf, len, "\n");
> > > > > +	return len;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * Read available scales for a specific channel
> > > > > + *
> > > > > + * NOTE: using extended info insted of iio.read_avail() because access to
> > > > > + * current scales must be locked as they depend on shunt resistor which may
> > > > > + * change runtime. Caller of iio.read_avail() would access the table unlocked
> > > > > + * instead.    
> > > > 
> > > > That's a corner case we should think about closing. Would require an indicator
> > > > to read_avail that the buffer it has been passed is a snapshot that it should
> > > > free on completion of the string building.  I don't like passing ownership
> > > > of data around like that, but it is fiddly to do anything else given
> > > > any simple double buffering is subject to race conditions.
> > > >    
> > > If I understand your suggestion the driver would allocate a new table and copy
> > > the values into it at each read_avail() call. Then
> > > iio_read_channel_info_avail() would free the buffer if some sort of
> > > free-after-use indicator flag is set. I guess such indicator might be set via an
> > > additional read_avail function argument (would be an extensive API change) or
> > > maybe via a new iio_chan_spec attribute.  
> > 
> > Probably needs to be in read_avail() as otherwise we end up with yet more masks.
> > However, doesn't need to be global.  read_avail_ext() could be added that
> > is used in preference to read_avail() if it is supplied.  That new one can
> > be used only be drivers that need to handle the allocation and free.
> > However I prefer the explicit resource free option as we can in theory
> > at least do much cleverer things than simply freeing the buffer.
> >   
> > >   
> > > > An alternative would use a key of sometype to associate individual read_avail
> > > > calls with new ones to read_avail_release_resource. That might be cleaner.
> > > >     
> > > Are you referring to introduce a new read_avail_realease_resource callback that
> > > would be called at the end of iio_read_channel_info_avail() if set? Similarly
> > > to the previous point the driver would allocate a new table and copy the values
> > > into it at each read_avail() call, but the driver would also define a release
> > > callback to free such table. If otherwise you are referring to something less
> > > trivial, is there a similar API in the kernel that can be referred to for
> > > clarity?  
> > 
> > Indeed what you suggest. Key is it puts the burden on the driver to do it's
> > own management. That avoids handing ownership of the buffer to the core
> > which is a pattern I'm not that keen on if we can avoid it.
> > 
> > The new callback would take the buffer pointer that came back from read_avail()
> > and pass that back to the driver.  In simple case the driver could just
> > free the buffer.  However, it could also do some cleverer stuff to keep
> > it around if a write hasn't raced with this code.  That might make sense if
> > it's a big table and calculating the values is expensive.
> >  
> I am trying to achieve this and it looks pretty straightforward for the case we
> considered, iio would be extended like the following:
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e6fad8a6a1fc..fe6ad8e9722f 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -860,12 +860,20 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
>                 return ret;
>         switch (ret) {
>         case IIO_AVAIL_LIST:
> -               return iio_format_avail_list(buf, vals, type, length);
> +               ret = iio_format_avail_list(buf, vals, type, length);
> +               break;
>         case IIO_AVAIL_RANGE:
> -               return iio_format_avail_range(buf, vals, type);
> +               ret = iio_format_avail_range(buf, vals, type);
> +               break;
>         default:
> -               return -EINVAL;
> +               ret = -EINVAL;
>         }
> +
> +       if (indio_dev->info->read_avail_release_resource)
> +               indio_dev->info->read_avail_release_resource(
> +                       indio_dev, this_attr->c, vals, this_attr->address);
> +
> +       return ret;
>  }
> 
>  /**
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index f6c0499853bb..0ab08b94bad0 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -491,6 +491,10 @@ struct iio_info {
>                           int *length,
>                           long mask);
> 
> +       void (*read_avail_release_resource)(struct iio_dev *indio_dev,
> +                                           struct iio_chan_spec const *chan,
> +                                           const int *vals, long mask);
> +
>         int (*write_raw)(struct iio_dev *indio_dev,
>                          struct iio_chan_spec const *chan,
>                          int val, 
> 
> And with the following usage example for the pac1921 driver:
> 
> static int pac1921_read_avail(struct iio_dev *indio_dev,
> 			      struct iio_chan_spec const *chan,
> 			      const int **vals, int *type, int *length,
> 			      long mask)
> {
> 	switch (mask) {
> 	//...
> 	case IIO_CHAN_INFO_SCALE:
> 		switch (chan->channel) {
> 		//...
> 		case PAC1921_CHAN_CURRENT: {
> 			struct pac1921_priv *priv = iio_priv(indio_dev);
> 			size_t len;
> 			int *buf;
> 
> 			len = ARRAY_SIZE(priv->current_scales) * 2;
> 			buf = kmalloc_array(len, sizeof(int), GFP_KERNEL);
> 			if (!buf)
> 				return -ENOMEM;
> 
> 			for (unsigned int i = 0; i < len; i++)
> 				buf[i] = ((int *)priv->current_scales)[i];
> 
> 			*vals = buf;
> 			*length = (int)len;
> 			*type = IIO_VAL_INT_PLUS_NANO;
> 			return IIO_AVAIL_LIST;
> 		}
> 		default:
> 			return -EINVAL;
> 		}
> 	default:
> 		return -EINVAL;
> 	}
> }
> 
> static void pac1921_read_avail_release_res(struct iio_dev *indio_dev,
> 					   struct iio_chan_spec const *chan,
> 					   const int *vals, long mask)
> {
> 	if (mask == IIO_CHAN_INFO_SCALE &&
> 	    chan->channel == PAC1921_CHAN_CURRENT)
> 		kfree(vals);
> }
> 
> static const struct iio_info pac1921_iio = {
> 	//...
> 	.read_avail = pac1921_read_avail,
> 	.read_avail_release_resource = pac1921_read_avail_release_res,
> };
> 
> However I noticed that some consumer drivers also expose the producer's
> available lists through the following functions:
> - iio_read_avail_channel_attribute()
> - iio_read_avail_channel_raw()
> - iio_channel_read_max()
> - iio_channel_read_min()
> 
> While addressing the read_max()/read_min() is trivial since the
> release_resource() can be called at the end of those function, I think the
> first twos should be tracked as well for later release by the consumer drivers.

We can mostly avoid this by taking a copy in the consumers that use these interfaces then
immediately calling the release. 

> So for example the consumer driver would also expose a
> iio_read_avail_channel_attribute_release_resource() (any suggestion for shorter
> function names?) mapped to the read_avail_release_resource() iio_info function.

> However the fact that iio_read_avail_channel_attribute() locks on
> info_exist_lock, makes me think that the driver could be unregistered between a
> read_avail() and a read_avail_release_resource() and in that case an allocated
> list would be leaked, right? Any suggestion on how best handle this case? My
> guess is to let iio destroy the list at some point during device release, that
> would be done if the list allocation was done through devm_kmalloc (or similar)
> but I think it would result in double frees during usual case, so maybe there
> should be a way to let it free the list only if not already freed? Or maybe a
> complete different approach?

Locking is a bit of a pain. I don't want to reference count for something
as trivial as this.

Perhaps the original idea of a release callback isn't best solution for these
in kernel interfaces and we should just 'always' make a copy of the data to
avoid the lifetime issue.  I don't want to do that for the IIO core case
because it's a big waste of memory and we don't have the lifetime issues,
but for the in kernel consumer interfaces copying sounds fine.

> 
> > >   
> > > > oh well, a cleanup job for another day.   I suspect we have drivers today
> > > > that are subject to tearing of their available lists.
> > > >     
> > > I've just taken a quick look at the other drivers and the following twos seem
> > > to have the race condition issue since they are updating an available table
> > > during a write_raw() call and also exposing it during a read_avail() call:
> > > * drivers/iio/light/as73211.c: see int_time_avail table
> > > * drivers/iio/adc/ad7192.c: see filter_freq_avail table
> > > 
> > > There might be others, I've only looked into those that seemed likely to have
> > > this issue after some trivial greps.
> > > 
> > > Is there already a common way for iio to keep track of open issues (e.g. Issue
> > > tracker/TODO lists/etc)?  
> > 
> > Not really.  Email to the list tends to be the most we do for tracking.
> > I have had various todo lists public over the years, but they tend to rot.
> > 
> > Fix stuff before we forget about it! :(
> >   
> I could try to provide fix patches for those two drivers as well, but I could
> not test them on the real HW. I am wondering whether to add them to the same
> release_resource() patch series or into a separate series since those fixes
> could be sit for a while waiting for additional tests.
Either is fine.  I don't necessarily have to pick the whole series up in one
go.  Just put those other drivers towards the end.

Jonathan

> 
> Thanks,
> Matteo Martelli
> 


