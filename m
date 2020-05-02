Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97511C277B
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 20:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEBSMs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 14:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgEBSMs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 14:12:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D540E206CD;
        Sat,  2 May 2020 18:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588443166;
        bh=Ur+zvGNhBRzpx5YCIfnkV/VY4X+PW2QlTOtRCvL2/rE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tp9mmQp6mmXP4vD22n6N4V9mEFSjQYrf1bCBdl3r42lLRHJ6v1VofGujO6mMZYb4m
         u879WlGm0ZXXHyL7N77Fkz9GyfvAIDRCMBPKRAGSSm0sP52E5vzrr0fRieRthWWllb
         vd5NHDSeOA47K4bS5yoFnddv0wnSv5G7K2a7msFQ=
Date:   Sat, 2 May 2020 19:12:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/4] iio: Move scan mask management to the core
Message-ID: <20200502191242.310fa73d@archlinux>
In-Reply-To: <9f8e44988909f6d26ad6b383ccead1f121594d5e.camel@analog.com>
References: <20200424051818.6408-1-alexandru.ardelean@analog.com>
        <20200424051818.6408-2-alexandru.ardelean@analog.com>
        <20200426104538.657a2d9a@archlinux>
        <9f8e44988909f6d26ad6b383ccead1f121594d5e.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 27 Apr 2020 06:25:19 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-04-26 at 10:45 +0100, Jonathan Cameron wrote:
> > [External]
> > 
> > On Fri, 24 Apr 2020 08:18:15 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > From: Lars-Peter Clausen <lars@metafoo.de>
> > > 
> > > Let the core handle the buffer scan mask management including allocation
> > > and channel selection. Having this handled in a central place rather than
> > > open-coding it all over the place will make it easier to change the
> > > implementation.
> > > 
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > 
> > Hi Alex,
> > 
> > For some reason I only have patch 1 of this series of 4.
> > 
> > This one looks reasonable to me as abstracts away how it is implemented
> > which is good. A few comments and a question inline.
> >   
> 
> Replies inline.
> 
> Since the discussion about patches 3 & 4 got a little more complicated [than I'd
> like to focus on at this point in time], would it be ok to split patches 1 & 2
> into a separate series? [after discussions are resolved]
> Even just those 2 patches helps me work on 2 kernel trees [the ADI internal &
> the IIO upstream one], as it minimizes the diff.
> 

That would be fine.

> 
> > Jonathan
> > 
> >   
> > > ---
> > >  drivers/iio/buffer/industrialio-buffer-cb.c | 17 ++++------
> > >  drivers/iio/industrialio-buffer.c           | 36 +++++++++++++++------
> > >  drivers/iio/inkern.c                        | 15 +++++++++
> > >  include/linux/iio/consumer.h                | 10 ++++++
> > >  4 files changed, 58 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c
> > > b/drivers/iio/buffer/industrialio-buffer-cb.c
> > > index 47c96f7f4976..b50f1f48cac6 100644
> > > --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> > > @@ -33,8 +33,7 @@ static int iio_buffer_cb_store_to(struct iio_buffer
> > > *buffer, const void *data)
> > >  static void iio_buffer_cb_release(struct iio_buffer *buffer)
> > >  {
> > >  	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
> > > -
> > > -	bitmap_free(cb_buff->buffer.scan_mask);
> > > +	iio_buffer_free_scanmask(buffer);
> > >  	kfree(cb_buff);
> > >  }
> > >  
> > > @@ -72,27 +71,25 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct
> > > device *dev,
> > >  	}
> > >  
> > >  	cb_buff->indio_dev = cb_buff->channels[0].indio_dev;
> > > -	cb_buff->buffer.scan_mask = bitmap_zalloc(cb_buff->indio_dev-  
> > > >masklength,  
> > > -						  GFP_KERNEL);
> > > -	if (cb_buff->buffer.scan_mask == NULL) {
> > > -		ret = -ENOMEM;
> > > +
> > > +	ret = iio_buffer_alloc_scanmask(&cb_buff->buffer, cb_buff->indio_dev);
> > > +	if (ret)
> > >  		goto error_release_channels;
> > > -	}
> > > +
> > >  	chan = &cb_buff->channels[0];
> > >  	while (chan->indio_dev) {
> > >  		if (chan->indio_dev != cb_buff->indio_dev) {
> > >  			ret = -EINVAL;
> > >  			goto error_free_scan_mask;
> > >  		}
> > > -		set_bit(chan->channel->scan_index,
> > > -			cb_buff->buffer.scan_mask);
> > > +		iio_buffer_channel_enable(&cb_buff->buffer, chan);
> > >  		chan++;
> > >  	}
> > >  
> > >  	return cb_buff;
> > >  
> > >  error_free_scan_mask:
> > > -	bitmap_free(cb_buff->buffer.scan_mask);
> > > +	iio_buffer_free_scanmask(&cb_buff->buffer);
> > >  error_release_channels:
> > >  	iio_channel_release_all(cb_buff->channels);
> > >  error_free_cb_buff:
> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-
> > > buffer.c
> > > index 221157136af6..c06691281287 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -206,6 +206,26 @@ void iio_buffer_init(struct iio_buffer *buffer)
> > >  }
> > >  EXPORT_SYMBOL(iio_buffer_init);
> > >  
> > > +int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
> > > +			      struct iio_dev *indio_dev)  
> > I'm not sure passing the indio_dev in here makes sense as it
> > obscures that all we are getting from it is the masklength.
> > May be better to pass that explicitly.  
> 
> Passing indio_dev seems to make more sense if we are also doing the channel_mask
> thing in the next patches.
> If we do the buffer->indio_dev back-ref, then we can just pass the buffer.
> But that may obscure things a bit more about the 'masklength'; though, that may
> be one of the intentions I suppose [can't be sure]
> 
> >   
> > > +{
> > > +	if (!indio_dev->masklength)
> > > +		return 0;  
> > 
> > This is a bit of an oddity of the old code.  Any idea why we
> > allow things to continue with a masklength of 0?  Seems to me
> > that it is thoroughly broken if that occurs!  
> 
> See [1]
> 
> >   
> > > +
> > > +	buffer->scan_mask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
> > > +	if (buffer->scan_mask == NULL)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_buffer_alloc_scanmask);
> > > +
> > > +void iio_buffer_free_scanmask(struct iio_buffer *buffer)
> > > +{
> > > +	bitmap_free(buffer->scan_mask);
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_buffer_free_scanmask);
> > > +
> > >  /**
> > >   * iio_buffer_set_attrs - Set buffer specific attributes
> > >   * @buffer: The buffer for which we are setting attributes
> > > @@ -1301,14 +1321,10 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  				indio_dev->scan_index_timestamp =
> > >  					channels[i].scan_index;
> > >  		}
> > > -		if (indio_dev->masklength && buffer->scan_mask == NULL) {  
> 
> [1] I suspect when this patch was written, it had this part in mind [with the
> retun 0]
> So, it preserves behavior a bit.
> The 'buffer->scan_mask == NULL' check is a bit odd; I wonder if the initial
> intent was to also allow to pass a 'scan_mask' from somewhere else.
> 
> So, updating '!indio_dev->masklength' to return -EINVAL in
> iio_buffer_alloc_scanmask() sounds like a good idea, but I'll need to add a note
> in the commit description.

Yup. Sounds good.
> 
> 
> > > -			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
> > > -							  GFP_KERNEL);
> > > -			if (buffer->scan_mask == NULL) {
> > > -				ret = -ENOMEM;
> > > -				goto error_cleanup_dynamic;
> > > -			}
> > > -		}
> > > +
> > > +		ret = iio_buffer_alloc_scanmask(buffer, indio_dev);
> > > +		if (ret)
> > > +			goto error_cleanup_dynamic;
> > >  	}
> > >  
> > >  	buffer->scan_el_group.name = iio_scan_elements_group_name;
> > > @@ -1329,7 +1345,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  	return 0;
> > >  
> > >  error_free_scan_mask:
> > > -	bitmap_free(buffer->scan_mask);
> > > +	iio_buffer_free_scanmask(buffer);
> > >  error_cleanup_dynamic:
> > >  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > >  	kfree(indio_dev->buffer->buffer_group.attrs);
> > > @@ -1342,7 +1358,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  	if (!indio_dev->buffer)
> > >  		return;
> > >  
> > > -	bitmap_free(indio_dev->buffer->scan_mask);
> > > +	iio_buffer_free_scanmask(indio_dev->buffer);
> > >  	kfree(indio_dev->buffer->buffer_group.attrs);
> > >  	kfree(indio_dev->buffer->scan_el_group.attrs);
> > >  	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
> > > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > > index ede99e0d5371..f35cb9985edc 100644
> > > --- a/drivers/iio/inkern.c
> > > +++ b/drivers/iio/inkern.c
> > > @@ -11,6 +11,7 @@
> > >  
> > >  #include <linux/iio/iio.h>
> > >  #include "iio_core.h"
> > > +#include <linux/iio/buffer_impl.h>
> > >  #include <linux/iio/machine.h>
> > >  #include <linux/iio/driver.h>
> > >  #include <linux/iio/consumer.h>
> > > @@ -857,6 +858,20 @@ int iio_write_channel_raw(struct iio_channel *chan, int
> > > val)
> > >  }
> > >  EXPORT_SYMBOL_GPL(iio_write_channel_raw);
> > >  
> > > +void iio_buffer_channel_enable(struct iio_buffer *buffer,
> > > +			       const struct iio_channel *chan)
> > > +{
> > > +	set_bit(chan->channel->scan_index, buffer->scan_mask);
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_buffer_channel_enable);
> > > +
> > > +void iio_buffer_channel_disable(struct iio_buffer *buffer,
> > > +				const struct iio_channel *chan)
> > > +{
> > > +	clear_bit(chan->channel->scan_index, buffer->scan_mask);
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_buffer_channel_disable);
> > > +
> > >  unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
> > >  {
> > >  	const struct iio_chan_spec_ext_info *ext_info;
> > > diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> > > index c4118dcb8e05..dbc87c26250a 100644
> > > --- a/include/linux/iio/consumer.h
> > > +++ b/include/linux/iio/consumer.h
> > > @@ -12,6 +12,7 @@
> > >  
> > >  struct iio_dev;
> > >  struct iio_chan_spec;
> > > +struct iio_buffer;
> > >  struct device;
> > >  
> > >  /**
> > > @@ -342,6 +343,15 @@ int iio_read_channel_scale(struct iio_channel *chan,
> > > int *val,
> > >  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
> > >  	int *processed, unsigned int scale);
> > >  
> > > +void iio_buffer_channel_enable(struct iio_buffer *buffer,
> > > +			       const struct iio_channel *chan);
> > > +void iio_buffer_channel_disable(struct iio_buffer *buffer,
> > > +				const struct iio_channel *chan);
> > > +
> > > +int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
> > > +			      struct iio_dev *indio_dev);
> > > +void iio_buffer_free_scanmask(struct iio_buffer *buffer);
> > > +
> > >  /**
> > >   * iio_get_channel_ext_info_count() - get number of ext_info attributes
> > >   *				      connected to the channel.  

