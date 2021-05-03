Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4A3713B6
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 12:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhECKjs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 3 May 2021 06:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230246AbhECKjs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 3 May 2021 06:39:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC8761027;
        Mon,  3 May 2021 10:38:53 +0000 (UTC)
Date:   Mon, 3 May 2021 11:39:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_na() for non aligned case.
Message-ID: <20210503113945.7334d3ff@jic23-huawei>
In-Reply-To: <PH0PR03MB63666DF4899946889AF77F95995B9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210501172515.513486-1-jic23@kernel.org>
        <20210501172515.513486-2-jic23@kernel.org>
        <PH0PR03MB6366C6AB21991C43CDF40B43995C9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20210502170849.2f8f7dcb@jic23-huawei>
        <PH0PR03MB6366F1D06AA32A935718AD99995B9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <PH0PR03MB63666DF4899946889AF77F95995B9@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 3 May 2021 07:46:49 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Sa, Nuno <Nuno.Sa@analog.com>
> > Sent: Monday, May 3, 2021 9:15 AM
> > To: Jonathan Cameron <jic23@kernel.org>
> > Cc: linux-iio@vger.kernel.org; Jonathan Cameron
> > <Jonathan.Cameron@huawei.com>
> > Subject: RE: [RFC PATCH 1/4] iio: core: Introduce
> > iio_push_to_buffers_with_ts_na() for non aligned case.
> > 
> > 
> > 
> >   
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, May 2, 2021 6:09 PM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio@vger.kernel.org; Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com>
> > > Subject: Re: [RFC PATCH 1/4] iio: core: Introduce
> > > iio_push_to_buffers_with_ts_na() for non aligned case.
> > >
> > >
> > > On Sun, 2 May 2021 09:10:56 +0000
> > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > >  
> > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > Sent: Saturday, May 1, 2021 7:25 PM
> > > > > To: linux-iio@vger.kernel.org
> > > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Subject: [RFC PATCH 1/4] iio: core: Introduce
> > > > > iio_push_to_buffers_with_ts_na() for non aligned case.
> > > > >
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >
> > > > > Whilst it is almost always possible to arrange for scan data to be
> > > > > read directly into a buffer that is suitable for passing to
> > > > > iio_push_to_buffers_with_timestamp(), there are a few places  
> > > where  
> > > > > leading data needs to be skipped over.
> > > > >
> > > > > For these cases introduce a function that will allocate an  
> > > appropriate  
> > > > > sized and aligned bounce buffer (if not already allocated) and  
> > copy  
> > > > > the unaligned data into that before calling
> > > > > iio_push_to_buffers_with_timestamp() on the bounce buffer.
> > > > > We tie the lifespace of this buffer to that of the iio_dev.dev
> > > > > which should ensure no memory leaks occur.
> > > > >
> > > > > Signed-off-by: Jonathan Cameron  
> > > <Jonathan.Cameron@huawei.com>  
> > > > > ---
> > > > >  drivers/iio/industrialio-buffer.c | 36
> > > > > +++++++++++++++++++++++++++++++
> > > > >  include/linux/iio/buffer.h        |  4 ++++
> > > > >  include/linux/iio/iio-opaque.h    |  4 ++++
> > > > >  3 files changed, 44 insertions(+)
> > > > >
> > > > > diff --git a/drivers/iio/industrialio-buffer.c  
> > > b/drivers/iio/industrialio-  
> > > > > buffer.c
> > > > > index 9a8e16c7e9af..818dfaa73665 100644
> > > > > --- a/drivers/iio/industrialio-buffer.c
> > > > > +++ b/drivers/iio/industrialio-buffer.c
> > > > > @@ -1727,6 +1727,42 @@ int iio_push_to_buffers(struct iio_dev
> > > > > *indio_dev, const void *data)
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(iio_push_to_buffers);
> > > > >
> > > > > +/**
> > > > > + * iio_push_to_buffers_with_ts_na() - push to registered  
> > buffer,  
> > > > > + *    no alignment or space requirements.
> > > > > + * @indio_dev:		iio_dev structure for device.
> > > > > + * @data:		channel data excluding the timestamp.
> > > > > + * @data_sz:		size of data.
> > > > > + * @timestamp:		timestamp for the sample data.
> > > > > + *
> > > > > + * This special variant of iio_push_to_buffers_with_timetamp()  
> > > does  
> > > > > + * not require space for the timestamp, or 8 byte alignment of  
> > > data.  
> > > > > + * It does however require an allocation on first call and  
> > additional  
> > > > > + * coppies on all calls, so should be avoided if possible
> > > > > + */
> > > > > +int iio_push_to_buffers_with_ts_na(struct iio_dev *indio_dev,
> > > > > +				   const void *data,
> > > > > +				   size_t data_sz,
> > > > > +				   int64_t timestamp)
> > > > > +{
> > > > > +	struct iio_dev_opaque *iio_dev_opaque =
> > > > > to_iio_dev_opaque(indio_dev);
> > > > > +
> > > > > +	data_sz = min_t(size_t, indio_dev->scan_bytes, data_sz);  
> > > > I'm not really sure  about this. Is it really a good idea to silently  
> > > truncate  
> > > > the data if some erroneous driver calls this with data_sz >  
> > > scan_bytes?  
> > > > (I don't think it's ever valid for data_sz to be bigger than  
> > scan_bytes)  
> > >
> > > It's not probably not.  This is just a fairly nasty way of papering over
> > > anyone doing that.
> > >  
> > > > We might be discarding data that userland actually requested. So,  
> > I'm  
> > > > not sure if it would not be better to be strict here and return error,  
> > > so that  
> > > > driver developers could catch this early on...  
> > >
> > > I'm fairly sure we'll never be discarding data userspace requested
> > > because scan_bytes will be the maximum possible and is the size of
> > > the
> > > kfifo element.  Any more data that comes in is going to be dropped
> > > anyway
> > > assuming it ends up in a kfifo_put()  
> > 
> > I think it depends. Think on a totally erroneous driver that does not
> > track
> > enabled elements and just pushes all elements to IIO buffers. If
> > userspace
> > just requested, let's say, the last 2 elements, I believe those would be
> > definitely discarded by this... More subtle things could also happen I
> > guess...
> > In this case, we can arguably say that the driver is completely broken
> > and while
> > I'm fairly sure such a scenario would never pass through revision, I
> > think that
> > if we make things more strict, we might minimize the chances of such
> > patches
> > to appear in the first place (unless someone is sending patches without
> > testing them at all).

Like me ;) *laughs*

Agreed there is nothing stopping at least adding a warning print here
and it might help weed out gross bugs even if it is imprecise.

> >   
> > > I wondered if we wanted to enforce this?  It would not seem totally
> > > silly for a driver that wasn't bothering to track the size of it's enabled
> > > channels to provide data_sz == maximum size it ever needs.
> > > Docs should definitely say if that's valid however, and it's definitely  
> > less  
> > > than optimal because we may copy garbage that will then be
> > > overwritten by
> > > the timestamp.
> > >  
> > > >
> > > > data_sz < scan_bytes is also probably not valid as that might  
> > happen  
> > > > if some drivers call this without the scan elements properly aligned
> > > > which will definitely be problematic... Naturally in this case we  
> > would  
> > > > have to take into account timestamp possible alignment fill bytes as  
> > it  
> > > > could be possible (and likely) that data_sz won't include those  
> > bits...  
> > >
> > > data_sz < scan_bytes is intentionally valid (and indeed I made one
> > > of the drivers do this).  Given we are bouncing anyway, why insist  
> > the  
> > > driver provides space for padding + timestamp?  That can be done  
> > for  
> > > the bounce buffer.  
> > 
> > What I meant was that if data_sz < scan_bytes - timestamp - padding,
> > then
> > the driver is most likely not guaranteeing properly aligned elements. I
> > was
> > not that clear :)

If you hit that condition I think it would be a bug as not enough data provided.
We could easily enforce data_sz < scan_bytes - timstamp, but the padding would
need to be stashed somewhere. + I've been lazy in one of the drivers because
I couldn't figure it out in a trivial fashion - perhaps I should take another
look at that one and see if I can make the check accurate rather than a worst
case bound.

> > 
> > Anyways, I still feel that if we are taking the data_sz parameter on the
> > API,
> > we should handle it more strictly. But I do not feel too strong about
> > this (as
> > you said, It's not expected to exist too much users of this) and in the
> > end
> > of the day it still behaves the same way as
> > 'iio_push_to_buffers_with_timestamp()'...
> >   
> > > >
> > > > Alternatively, we could be consistent with  
> > > 'iio_push_to_buffers_with_timestamp()'  
> > > > and assume drivers play along in terms of alignment and size
> > > > (so, removing the data_sz parameter)...
> > > >
> > > > My point is, if we are taking the data_sz parameter, maybe we  
> > > should be pedantic  
> > > > about it...  
> > > > > +	if (iio_dev_opaque->bounce_buffer_size !=  indio_dev-  
> > > > > >scan_bytes) {  
> > > >
> > > > Where do we set ' bounce_buffer_size '? I guess we do not want  
> > to  
> > > > get  here all the time...  
> > >
> > > :( oops
> > >  
> > > > > +		iio_dev_opaque->bounce_buffer =
> > > > > +			devm_krealloc(&indio_dev->dev,
> > > > > +				      iio_dev_opaque->bounce_buffer,
> > > > > +				      indio_dev->scan_bytes,
> > > > > GFP_KERNEL);  
> > > >
> > > > I'm also not a big fan of realloc so I prefer to avoid it unless really  
> > > needed...  
> > > > Here, maybe we could just allocate this once during device/buffer  
> > > initialization  
> > > > and allocate it for the maximum possible size, i.e all scan elements  
> > > enabled...
> > >
> > > We can but to do that requires more invasive changes. Perhaps not
> > > horrible ones,
> > > but we'd need to add stuff to caller drivers to configure the bounce
> > > buffer, or
> > > some flag to see they needed to enable support for this.  Only 3
> > > drivers out of
> > > all those in IIO are currently using this code (might be a few others  
> > that  
> > > could
> > > take advantage but not many - so need to keep it localized).  
> > 
> > I was not thinking that way. I was just thinking in always allocating the
> > bounce
> > buffer. But I do agree that it is less than ideal to allocate something
> > that will
> > almost never be used...

Ah got you.  We could do that, but I think it wants to be opt in just because
I'd feel bad adding an extra allocation to every driver.

> >   
> > > I suppose we could have an
> > > iio_unaligned_push_to_buffers_prepare() to be called from the
> > > update_scan_mode()
> > > callback (typed to be useable as that callback if nothing else to be  
> > done  
> > > in
> > > the relevant drivers.  
> > 
> > It could also be an option... If we want to not use realloc, we would
> > have to manually
> > control the lifespan of the buffer and free it in the disable path. But I
> > guess that might feel
> > like too much handling...
> > 
> > Anyways, maybe sticking with realloc, we could just use a more normal
> > pattern like:
> > 
> > tmp = devm_realloc(bounce_fuffer, ...);
> > if (!tmp)
> >     error;
> > 
> > bounce_buffer = tmp;
> >   
> 
> I just read your reply to Andy about this and I think you are right... If the
> new allocation fails, the older pointer is still preserved. However, I find
> the above form a bit more readable and straight :)
> 
Understood.  Given it's causing confusion (and I had to think about it 
in the first place), simply have the more standard pattern is probably
wise even if strictly speaking unnecessary!  Give people what they expect
to see rather than being 'clever' :)

> - Nuno Sá

