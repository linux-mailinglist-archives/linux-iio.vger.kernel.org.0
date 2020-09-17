Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD626E305
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIQR4o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 13:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgIQR4F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 13:56:05 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F8A20707;
        Thu, 17 Sep 2020 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600365364;
        bh=JPsTCcKQSJWwioUgZClYmjeaDcco+sofmS5Hjg0G3ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5ag4xwb9mY1gMrrsG6c8EQLFPZ/cX/gXYPDYWqZbG8xFOrK7iAWLAbu7jffpeIj7
         qFl6zqMq8hBlU355hSDh67wO+0ZmiTpgXYQvvrtjMc5wom6ya0PpeGFlxoSOLV68vk
         +BhWrpgM3aCOuxrq1diqfXfgQrn+DpkSwKIEG0ig=
Date:   Thu, 17 Sep 2020 18:55:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: split buffer sysfs creation to take buffer
 as primary arg
Message-ID: <20200917185559.7d6971e3@archlinux>
In-Reply-To: <CA+U=DspN3WYX5_1MZpRPzUcC5NV4=iSekQ9jNSehad1jfi2bQw@mail.gmail.com>
References: <20200917125951.861-1-alexandru.ardelean@analog.com>
        <20200917181626.59eb84c8@archlinux>
        <CA+U=DspN3WYX5_1MZpRPzUcC5NV4=iSekQ9jNSehad1jfi2bQw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Sep 2020 20:41:08 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Thu, Sep 17, 2020 at 8:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Thu, 17 Sep 2020 15:59:51 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >  
> > > Currently the iio_buffer_{alloc,free}_sysfs_and_mask() take 'indio_dev' as
> > > primary argument. This change splits the main logic into a private function
> > > that takes an IIO buffer as primary argument.
> > >
> > > That way, the functions can be extended to configure the sysfs for multiple
> > > buffers.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> >
> > One comment inline.  Whilst I think it is safe as you have it, I'd
> > rather avoid the minor change in logic if we don't need to make it.
> >
> > Thanks,
> >
> > Jonathan
Applied to the togreg branch of iio.git.

See below for my pathetic Diff confused me excuse :)

Jonathan

> >
> >  
> > > ---
> > >  drivers/iio/industrialio-buffer.c | 46 ++++++++++++++++++++-----------
> > >  1 file changed, 30 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> > > index a7d7e5143ed2..a4f6bb96d4f4 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1264,26 +1264,14 @@ static struct attribute *iio_buffer_attrs[] = {
> > >       &dev_attr_data_available.attr,
> > >  };
> > >
> > > -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > > +static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
> > > +                                          struct iio_dev *indio_dev)
> > >  {
> > >       struct iio_dev_attr *p;
> > >       struct attribute **attr;
> > > -     struct iio_buffer *buffer = indio_dev->buffer;
> > >       int ret, i, attrn, attrcount;
> > >       const struct iio_chan_spec *channels;
> > >
> > > -     channels = indio_dev->channels;
> > > -     if (channels) {
> > > -             int ml = indio_dev->masklength;
> > > -
> > > -             for (i = 0; i < indio_dev->num_channels; i++)
> > > -                     ml = max(ml, channels[i].scan_index + 1);
> > > -             indio_dev->masklength = ml;
> > > -     }
> > > -
> > > -     if (!buffer)
> > > -             return 0;
> > > -
> > >       attrcount = 0;
> > >       if (buffer->attrs) {
> > >               while (buffer->attrs[attrcount] != NULL)
> > > @@ -1367,19 +1355,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > >       return ret;
> > >  }
> > >
> > > -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > > +int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > >  {
> > >       struct iio_buffer *buffer = indio_dev->buffer;
> > > +     const struct iio_chan_spec *channels;
> > > +     int i;
> > > +
> > > +     channels = indio_dev->channels;
> > > +     if (channels) {
> > > +             int ml = indio_dev->masklength;
> > > +
> > > +             for (i = 0; i < indio_dev->num_channels; i++)
> > > +                     ml = max(ml, channels[i].scan_index + 1);
> > > +             indio_dev->masklength = ml;
> > > +     }  
> >
> > I've not really figured out if it matters, but this is a logic change.
> > Previously we didn't compute masklength if there was no buffer provided.
> > Now we do.  It's probably better to move the if (!buffer) check above
> > this block or at least mention this change in the patch description.
> >  
> 
> Umm, are you referring that this patch is a logic change or you are
> suggesting a logic change?
> The "if (!buffer)" check was positioned after the masklength
> computation even in the old code.
> 
Got you.  Diff confused me :)


> >  
> > >
> > >       if (!buffer)
> > > -             return;
> > > +             return 0;
> > > +
> > > +     return __iio_buffer_alloc_sysfs_and_mask(buffer, indio_dev);
> > > +}
> > >
> > > +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> > > +{
> > >       bitmap_free(buffer->scan_mask);
> > >       kfree(buffer->buffer_group.attrs);
> > >       kfree(buffer->scan_el_group.attrs);
> > >       iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > >  }
> > >
> > > +void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > > +{
> > > +     struct iio_buffer *buffer = indio_dev->buffer;
> > > +
> > > +     if (!buffer)
> > > +             return;
> > > +
> > > +     __iio_buffer_free_sysfs_and_mask(buffer);
> > > +}
> > > +
> > >  /**
> > >   * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
> > >   * @indio_dev: the iio device  
> >  

