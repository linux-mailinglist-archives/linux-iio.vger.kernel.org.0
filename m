Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA96F370DBC
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEBPxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 11:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhEBPxW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 May 2021 11:53:22 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71B0F61359;
        Sun,  2 May 2021 15:52:29 +0000 (UTC)
Date:   Sun, 2 May 2021 16:53:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_na() for non aligned case.
Message-ID: <20210502165320.1eaea741@jic23-huawei>
In-Reply-To: <CAHp75VdRTh6Pzj8yy6sDQqfhfAJj1nGZ79UmzBckNR4b1h5sog@mail.gmail.com>
References: <20210501172515.513486-1-jic23@kernel.org>
        <20210501172515.513486-2-jic23@kernel.org>
        <CAHp75VdRTh6Pzj8yy6sDQqfhfAJj1nGZ79UmzBckNR4b1h5sog@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 22:25:55 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, May 1, 2021 at 8:28 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst it is almost always possible to arrange for scan data to be
> > read directly into a buffer that is suitable for passing to
> > iio_push_to_buffers_with_timestamp(), there are a few places where
> > leading data needs to be skipped over.
> >
> > For these cases introduce a function that will allocate an appropriate
> > sized and aligned bounce buffer (if not already allocated) and copy
> > the unaligned data into that before calling
> > iio_push_to_buffers_with_timestamp() on the bounce buffer.
> > We tie the lifespace of this buffer to that of the iio_dev.dev
> > which should ensure no memory leaks occur.  
> 
> ...
> 
> > +/**
> > + * iio_push_to_buffers_with_ts_na() - push to registered buffer,
> > + *    no alignment or space requirements.
> > + * @indio_dev:         iio_dev structure for device.
> > + * @data:              channel data excluding the timestamp.
> > + * @data_sz:           size of data.
> > + * @timestamp:         timestamp for the sample data.
> > + *
> > + * This special variant of iio_push_to_buffers_with_timetamp() does
> > + * not require space for the timestamp, or 8 byte alignment of data.
> > + * It does however require an allocation on first call and additional
> > + * coppies on all calls, so should be avoided if possible  
> 
> copies

One day I'll remember to actually spell check *sigh*

> 
> > + */  
> 
> I do not like the _na part in the name (My first impression was with a
> Timestamp that was not available, what?!). Can we spell it better?

I struggled with the naming.  Ideally we'd have started with this
as the iio_push_to_buffers_with_timestamp() and had
an _aligned version for the existing case.

Perhaps spend the characters and just make it
_with_ts_unaligned()

> 
> > +int iio_push_to_buffers_with_ts_na(struct iio_dev *indio_dev,
> > +                                  const void *data,
> > +                                  size_t data_sz,
> > +                                  int64_t timestamp)
> > +{
> > +       struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> > +
> > +       data_sz = min_t(size_t, indio_dev->scan_bytes, data_sz);
> > +       if (iio_dev_opaque->bounce_buffer_size !=  indio_dev->scan_bytes) {  
> 
> > +               iio_dev_opaque->bounce_buffer =
> > +                       devm_krealloc(&indio_dev->dev,
> > +                                     iio_dev_opaque->bounce_buffer,  
> 
> Oh la la, foo = realloc(foo, ...) is 101 type of mistakes.
> Please, don't do this.

For realloc I'd agree because if the new allocation fails we'd just have
lost the pointer, but with a managed case, I think we'll leave the original
pointer alone from the point of view of the devm_ cleanup. 

The only exit paths of interest in devm_krealloc() are the ones where we
are trying to allocate a new larger object (otherwise it either does nothing
or it is just a call to devm_kmalloc().

The one on failure to find the original managed resource, so can't loose
it because it wasn't there.

Am I missing something?

> 
> > +                                     indio_dev->scan_bytes, GFP_KERNEL);
> > +               if (!iio_dev_opaque)
> > +                       return -ENOMEM;

As you observed this is clearly garbage. I should have sat on this patch
for a day and at least reread it or ideally done some testing.

Failing to set the bounce_buffer_size() definitely doesn't help either..

> > +       }
> > +       memcpy(iio_dev_opaque->bounce_buffer, data, data_sz);
> > +       return iio_push_to_buffers_with_timestamp(indio_dev,
> > +                                                 iio_dev_opaque->bounce_buffer,
> > +                                                 timestamp);
> > +}  
> 

