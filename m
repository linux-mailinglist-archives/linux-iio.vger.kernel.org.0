Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD88205A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfHEPfj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:35:39 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:46088 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEPfj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 11:35:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id A5DAD9E748F;
        Mon,  5 Aug 2019 16:35:36 +0100 (BST)
Date:   Mon, 5 Aug 2019 16:35:34 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "denis.ciocca@st.com" <denis.ciocca@st.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio:common: introduce
 st_sensors_buffer_preenable/predisable functions
Message-ID: <20190805163534.68c00bf3@archlinux>
In-Reply-To: <20190805162135.68dc97c4@archlinux>
References: <20190731215250.16403-1-denis.ciocca@st.com>
        <20190731215250.16403-2-denis.ciocca@st.com>
        <6939dc8b7c28b1f4ed00f33b5ed2cfde17b73d41.camel@analog.com>
        <20190805162135.68dc97c4@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 5 Aug 2019 16:21:35 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 1 Aug 2019 08:24:10 +0000
> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> 
> > On Wed, 2019-07-31 at 14:52 -0700, Denis Ciocca wrote:  
> > > [External]
> > > 
> > > This patch is introducing preenable/postdisable in the common
> > > st_sensors_buffer code in order to remove the memory allocation /
> > > de-allocation from each single st driver.
> > >     
> > 
> > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >   
> > > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>  
> 
> As a rework, this is clearly reasonable, however, if we are going to
> touch this code at all, there are a few things I would like to tidy
> up about it.
> 
> Firstly it's one of relatively few drivers that actually touch scan_bytes
> in the first place.  That is supposed to be internal state to the core
> subsystem and not used by drivers (see INTERN marking in iio.h).
> It bled across the boundary in too many places where I wasn't looking.
> 
> Secondly these allocations are small.  You would be better off just
> making them part of the main state structure and not dynamically allocated
> at all.
> 
> So move buffer_data to the end of struct st_sensor_data and make it
> whatever the maximum size needed is - I'm thinking probably 32 bytes
> but haven't checked.
Maths escapes me today, probably only 16 bytes as 3 channel devices
mostly 16 bits max + timestamp.

J
> 
> You call the bulk regmap API against it so you also need to ensure
> it's in it's own cacheline.  Use the __cacheline_aligned magic
> to enforce that.  The iio_priv region is always aligned appropriately
> to allow iio_priv accessed structures to pull this trick.
> 
> That way we don't need to do any memory handling on demand at all.
> We may or many not save memory as will depend on exactly how big
> that structure already is and what mood the allocator is in.
> 
> I don't think I'm missing a reason we can't take the approach of
> embedding the buffer and it definitely makes the code simpler.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > > ---
> > >  .../iio/common/st_sensors/st_sensors_buffer.c | 22 +++++++++++++++++++
> > >  include/linux/iio/common/st_sensors.h         |  2 ++
> > >  2 files changed, 24 insertions(+)
> > > 
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > index eee30130ae23..9da1c8104883 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > @@ -81,6 +81,28 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
> > >  }
> > >  EXPORT_SYMBOL(st_sensors_trigger_handler);
> > >  
> > > +int st_sensors_buffer_preenable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> > > +
> > > +	sdata->buffer_data = kmalloc(indio_dev->scan_bytes,
> > > +				     GFP_DMA | GFP_KERNEL);
> > > +	if (!sdata->buffer_data)
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(st_sensors_buffer_preenable);
> > > +
> > > +int st_sensors_buffer_postdisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> > > +
> > > +	kfree(sdata->buffer_data);
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(st_sensors_buffer_postdisable);
> > > +
> > >  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> > >  MODULE_DESCRIPTION("STMicroelectronics ST-sensors buffer");
> > >  MODULE_LICENSE("GPL v2");
> > > diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> > > index 28fc1f9fa7d5..c66ebb236a15 100644
> > > --- a/include/linux/iio/common/st_sensors.h
> > > +++ b/include/linux/iio/common/st_sensors.h
> > > @@ -254,6 +254,8 @@ struct st_sensor_data {
> > >  
> > >  #ifdef CONFIG_IIO_BUFFER
> > >  irqreturn_t st_sensors_trigger_handler(int irq, void *p);
> > > +int st_sensors_buffer_preenable(struct iio_dev *indio_dev);
> > > +int st_sensors_buffer_postdisable(struct iio_dev *indio_dev);
> > >  #endif
> > >  
> > >  #ifdef CONFIG_IIO_TRIGGER    
> 

