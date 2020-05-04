Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C246A1C35FA
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgEDJp2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 05:45:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726625AbgEDJp2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 May 2020 05:45:28 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F344D28FFBBEBC844D6A;
        Mon,  4 May 2020 10:45:26 +0100 (IST)
Received: from localhost (10.47.88.153) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 10:45:26 +0100
Date:   Mon, 4 May 2020 10:45:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] iio: Move scan mask management to the core
Message-ID: <20200504104507.00002e5c@Huawei.com>
In-Reply-To: <5c66a2ac28fd0b0a603393579164b59450f41329.camel@analog.com>
References: <20200429151740.85917-1-alexandru.ardelean@analog.com>
        <20200503135117.4cddccfa@archlinux>
        <5c66a2ac28fd0b0a603393579164b59450f41329.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.153]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 May 2020 06:45:27 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sun, 2020-05-03 at 13:51 +0100, Jonathan Cameron wrote:
> > On Wed, 29 Apr 2020 18:17:39 +0300
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >   
> > > From: Lars-Peter Clausen <lars@metafoo.de>
> > > 
> > > Let the core handle the buffer scan mask management including allocation
> > > and channel selection. Having this handled in a central place rather than
> > > open-coding it all over the place will make it easier to change the
> > > implementation (if needed).
> > > At the very least, this change abstracts scan-mask management away from
> > > buffer implementations.
> > > 
> > > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>  
> > 
> > I'm not 100% happy with including the buffer_impl.h header in the inkern
> > code, but I can't see a simple way around it.  
> 
> I actually also tried to not do it [I suspect Lars may have tried as well].
> But you end up either having to expose 'struct iio_channel' outside of
> 'inkern.c' or having to include 'iio/consumer.h' in industrialio-buffer.c
> 
> Since there will be a V3, I will probably try to look again at a potential
> different solution. Maybe there is a better solution I haven't considered.
> 
> > 
> > However, there are some missing statics in here and I'm feeling lazy
> > so not going to fix them up for you.
> >   
> 
> No problem from my side.
> I'll fix them up.
> I prefer it when people don't cleanup after me. Makes me feel less guilty.
> Though I will admit, it's a double-edged feeling: I am greatful when someone
> cleans up after me, but I also feel slightly guilty [about it].
> 

*laughs*.  It's a trade off for the patch applier between

1) Making people feel guilty so they are more careful in future.
2) Effort to actually make trivial fixes.
3) Having to get their brain back in gear when they get around to looking
   at the next version.

Mostly 3 wins out though I like to go with 1 every now and then when
I'm feeling grump.  Warning for all, lock down makes me grumpy so
you may all suffer the effects :)

J

> 
> > Thanks,
> > 
> > Jonathan
> >   
> > > ---
> > > 
> > > Changelog v1 -> v2:
> > > - split away from initial series; the `buffer->channel_mask` attribute
> > >   requires a bit more dicussion; or may even be dropped; just these 2
> > >   patches helps with diff-ing 2 trees, as applying patches between my
> > >   work tree & IIO has fewer conflicts
> > > - return -EINVAL if masklength is 0 in iio_buffer_alloc_scanmask()
> > > - convert 2nd parameter to `unsigned int masklength` in
> > >   iio_buffer_alloc_scanmask()
> > > 
> > >  drivers/iio/buffer/industrialio-buffer-cb.c | 17 +++++-----
> > >  drivers/iio/industrialio-buffer.c           | 36 +++++++++++++++------
> > >  drivers/iio/inkern.c                        | 15 +++++++++
> > >  include/linux/iio/consumer.h                | 10 ++++++
> > >  4 files changed, 59 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c
> > > b/drivers/iio/buffer/industrialio-buffer-cb.c
> > > index 47c96f7f4976..dc5bb2ab533a 100644
> > > --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> > > +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> > > @@ -34,7 +34,7 @@ static void iio_buffer_cb_release(struct iio_buffer
> > > *buffer)
> > >  {
> > >  	struct iio_cb_buffer *cb_buff = buffer_to_cb_buffer(buffer);
> > >  
> > > -	bitmap_free(cb_buff->buffer.scan_mask);
> > > +	iio_buffer_free_scanmask(&cb_buff->buffer);
> > >  	kfree(cb_buff);
> > >  }
> > >  
> > > @@ -72,27 +72,26 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct
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
> > > +	ret = iio_buffer_alloc_scanmask(&cb_buff->buffer,
> > > +					cb_buff->indio_dev->masklength);
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
> > > index eae39eaf49af..c6b63f4474ff 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -208,6 +208,26 @@ void iio_buffer_init(struct iio_buffer *buffer)
> > >  }
> > >  EXPORT_SYMBOL(iio_buffer_init);
> > >  
> > > +int iio_buffer_alloc_scanmask(struct iio_buffer *buffer,
> > > +			      unsigned int masklength)
> > > +{
> > > +	if (!masklength)
> > > +		return -EINVAL;
> > > +
> > > +	buffer->scan_mask = bitmap_zalloc(masklength, GFP_KERNEL);
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
> > > @@ -1306,14 +1326,10 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  				indio_dev->scan_index_timestamp =
> > >  					channels[i].scan_index;
> > >  		}
> > > -		if (indio_dev->masklength && buffer->scan_mask == NULL) {
> > > -			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
> > > -							  GFP_KERNEL);
> > > -			if (buffer->scan_mask == NULL) {
> > > -				ret = -ENOMEM;
> > > -				goto error_cleanup_dynamic;
> > > -			}
> > > -		}
> > > +
> > > +		ret = iio_buffer_alloc_scanmask(buffer, indio_dev->masklength);
> > > +		if (ret)
> > > +			goto error_cleanup_dynamic;
> > >  	}
> > >  
> > >  	buffer->scan_el_group.name = iio_scan_elements_group_name;
> > > @@ -1334,7 +1350,7 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  	return 0;
> > >  
> > >  error_free_scan_mask:
> > > -	bitmap_free(buffer->scan_mask);
> > > +	iio_buffer_free_scanmask(buffer);
> > >  error_cleanup_dynamic:
> > >  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> > >  	kfree(buffer->buffer_group.attrs);
> > > @@ -1349,7 +1365,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev
> > > *indio_dev)
> > >  	if (!buffer)
> > >  		return;
> > >  
> > > -	bitmap_free(buffer->scan_mask);
> > > +	iio_buffer_free_scanmask(buffer);
> > >  	kfree(buffer->buffer_group.attrs);
> > >  	kfree(buffer->scan_el_group.attrs);
> > >  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
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
> > > index c4118dcb8e05..9fcd320c2fb4 100644
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
> > > +			      unsigned int masklength);
> > > +void iio_buffer_free_scanmask(struct iio_buffer *buffer);
> > > +
> > >  /**
> > >   * iio_get_channel_ext_info_count() - get number of ext_info attributes
> > >   *				      connected to the channel.  


