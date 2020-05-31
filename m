Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0FE1E9871
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgEaPVc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 11:21:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgEaPVa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 11:21:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F532067B;
        Sun, 31 May 2020 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590938487;
        bh=Jddne4yXKRLRpzmwkdRlurtCqKQNiMbwq6ofz0J8Zss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g6p4mkpNduHaVNFeUPqy3PvQIg5B7z4MgWkHlpxTIyFq984HcQa7Vd/o+j6rLcq3G
         0H7SBoNv5+M1rTz0n3qQ8NE0MvYyGh6hQKZZ3G3PIZqrPTLS3n5sZp2LWDFuvQpJhN
         R+XSZ00cP8Cl2h3STyZuqtx9oeI8lBX6wp1kA2Ys=
Date:   Sun, 31 May 2020 16:21:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RFC PATCH 09/14] iio: buffer: split buffer sysfs creation to
 take buffer as primary arg
Message-ID: <20200531162123.401d54f5@archlinux>
In-Reply-To: <cfcc097a2cf6582cc8a5cc47d9ea8b868eda0ed9.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
        <20200508135348.15229-10-alexandru.ardelean@analog.com>
        <20200524174916.2ff91965@archlinux>
        <cfcc097a2cf6582cc8a5cc47d9ea8b868eda0ed9.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 07:28:18 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-05-24 at 17:49 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Fri, 8 May 2020 16:53:43 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > Currently the iio_buffer_{alloc,free}_sysfs_and_mask() take 'indio_dev' as
> > > primary argument. This change converts to take an IIO buffer as a primary
> > > argument.
> > > 
> > > That will allow the functions to get called for multiple buffers.
> > > 
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > 
> > Looks good to me.  We'll need this whatever the interface ends up being as
> > need the separate control infrastructure.  
> 
> I was wanting to split this into it's own patch at some point and send it now.
> I'll probably do it.

Great.
> 
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/iio/industrialio-buffer.c | 46 ++++++++++++++++++++-----------
> > >  1 file changed, 30 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-
> > > buffer.c
> > > index e7a847e7b103..6b1b5d5387bd 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1312,26 +1312,14 @@ static struct attribute *iio_buffer_attrs[] = {
> > >  	&dev_attr_data_available.attr,
> > >  };
> > >  
> > > -int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > > +static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer)
> > >  {
> > > +	struct iio_dev *indio_dev = buffer->indio_dev;
> > >  	struct iio_dev_attr *p;
> > >  	struct attribute **attr;
> > > -	struct iio_buffer *buffer = indio_dev->buffer;
> > >  	int ret, i, attrn, attrcount, attrcount_orig = 0;
> > >  	const struct iio_chan_spec *channels;
> > >  
> > > -	channels = indio_dev->channels;
> > > -	if (channels) {
> > > -		int ml = indio_dev->masklength;
> > > -
> > > -		for (i = 0; i < indio_dev->num_channels; i++)
> > > -			ml = max(ml, channels[i].scan_index + 1);
> > > -		indio_dev->masklength = ml;
> > > -	}
> > > -
> > > -	if (!buffer)
> > > -		return 0;
> > > -
> > >  	attrcount = 0;
> > >  	if (buffer->attrs) {
> > >  		while (buffer->attrs[attrcount] != NULL)
> > > @@ -1411,19 +1399,45 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  	return ret;
> > >  }
> > >  
> > > -void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > > +int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
> > >  {
> > >  	struct iio_buffer *buffer = indio_dev->buffer;
> > > +	const struct iio_chan_spec *channels;
> > > +	int i;
> > > +
> > > +	channels = indio_dev->channels;
> > > +	if (channels) {
> > > +		int ml = indio_dev->masklength;
> > > +
> > > +		for (i = 0; i < indio_dev->num_channels; i++)
> > > +			ml = max(ml, channels[i].scan_index + 1);
> > > +		indio_dev->masklength = ml;
> > > +	}
> > >  
> > >  	if (!buffer)
> > > -		return;
> > > +		return 0;
> > > +
> > > +	return __iio_buffer_alloc_sysfs_and_mask(buffer);
> > > +}
> > >  
> > > +static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
> > > +{
> > >  	iio_buffer_free_scanmask(buffer);
> > >  	kfree(buffer->buffer_group.attrs);
> > >  	kfree(buffer->scan_el_group.attrs);
> > >  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > >  }
> > >  
> > > +void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> > > +{
> > > +	struct iio_buffer *buffer = indio_dev->buffer;
> > > +
> > > +	if (!buffer)
> > > +		return;
> > > +
> > > +	__iio_buffer_free_sysfs_and_mask(buffer);
> > > +}
> > > +
> > >  static const struct file_operations iio_buffer_fileops = {
> > >  	.read = iio_buffer_read_outer,
> > >  	.release = iio_buffer_chrdev_release,  

