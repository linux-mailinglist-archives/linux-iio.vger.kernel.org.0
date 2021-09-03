Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00016400175
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhICOrx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 3 Sep 2021 10:47:53 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49561 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhICOrx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 10:47:53 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AB69E20009;
        Fri,  3 Sep 2021 14:46:51 +0000 (UTC)
Date:   Fri, 3 Sep 2021 16:46:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
 conversion helper
Message-ID: <20210903164650.1b0384ff@xps13>
In-Reply-To: <SJ0PR03MB6359CF1E770ACFF90A03AB6099CF9@SJ0PR03MB6359.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-15-miquel.raynal@bootlin.com>
        <20210830113716.1f7cdc6f@jic23-huawei>
        <MW4PR03MB6363F50DC6A4B5D682BA16E299CB9@MW4PR03MB6363.namprd03.prod.outlook.com>
        <20210902171232.450a6d62@xps13>
        <SJ0PR03MB6359CF1E770ACFF90A03AB6099CF9@SJ0PR03MB6359.namprd03.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

Nuno.Sa@analog.com wrote on Fri, 3 Sep 2021 14:28:52 +0000:

> Hi Miquel,
> 
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Thursday, September 2, 2021 5:13 PM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; Thomas Petazzoni
> > <thomas.petazzoni@bootlin.com>; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
> > conversion helper
> > 
> > Hi Nuno,
> > 
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote on Mon, 30 Aug 2021
> > 12:44:48
> > +0000:
> >   
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Monday, August 30, 2021 12:37 PM
> > > > To: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Cc: Lars-Peter Clausen <lars@metafoo.de>; Thomas Petazzoni
> > > > <thomas.petazzoni@bootlin.com>; linux-iio@vger.kernel.org;  
> > linux-  
> > > > kernel@vger.kernel.org
> > > > Subject: Re: [PATCH 14/16] iio: adc: max1027: Consolidate the end  
> > of  
> > > > conversion helper
> > > >
> > > > On Wed, 18 Aug 2021 13:11:37 +0200
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >  
> > > > > Now that we have a dedicated handler for End Of Conversion  
> > > > interrupts,  
> > > > > let's create a second path:
> > > > > - Situation 1: we are using the external hardware trigger, a  
> > > > conversion  
> > > > >   has been triggered and the ADC pushed the data to its FIFO, we  
> > > > need to  
> > > > >   retrieve the data and push it to the IIO buffers.
> > > > > - Situation 2: we are not using the external hardware trigger,  
> > hence  
> > > > we  
> > > > >   are likely waiting in a blocked thread waiting for this interrupt to
> > > > >   happen: in this case we just wake up the waiting thread.
> > > > >
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > ---
> > > > >  drivers/iio/adc/max1027.c | 20 +++++++++++++++++---
> > > > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/adc/max1027.c  
> > b/drivers/iio/adc/max1027.c  
> > > > > index 8d86e77fb5db..8c5995ae59f2 100644
> > > > > --- a/drivers/iio/adc/max1027.c
> > > > > +++ b/drivers/iio/adc/max1027.c
> > > > > @@ -235,6 +235,7 @@ struct max1027_state {
> > > > >  	struct iio_trigger		*trig;
> > > > >  	__be16				*buffer;
> > > > >  	struct mutex			lock;
> > > > > +	bool				data_rdy;
> > > > >  	bool				cnvst_trigger;
> > > > >  	u8				reg ____cacheline_aligned;
> > > > >  };
> > > > > @@ -243,12 +244,22 @@ static  
> > > > DECLARE_WAIT_QUEUE_HEAD(max1027_queue);  
> > > > >
> > > > >  static int max1027_wait_eoc(struct iio_dev *indio_dev)
> > > > >  {
> > > > > +	struct max1027_state *st = iio_priv(indio_dev);
> > > > >  	unsigned int conversion_time =  
> > > > MAX1027_CONVERSION_UDELAY;  
> > > > > +	int ret;
> > > > >
> > > > > -	if (indio_dev->active_scan_mask)
> > > > > -		conversion_time *= hweight32(*indio_dev-
> > > > >active_scan_mask);
> > > > > +	if (st->spi->irq) {
> > > > > +		ret =  
> > > > wait_event_interruptible_timeout(max1027_queue,  
> > > > > +						       st->data_rdy, HZ /  
> > > > 1000);  
> > > > > +		st->data_rdy = false;
> > > > > +		if (ret == -ERESTARTSYS)
> > > > > +			return ret;
> > > > > +	} else {
> > > > > +		if (indio_dev->active_scan_mask)
> > > > > +			conversion_time *= hweight32(*indio_dev-
> > > > >active_scan_mask);
> > > > >
> > > > > -	usleep_range(conversion_time, conversion_time * 2);
> > > > > +		usleep_range(conversion_time, conversion_time * 2);
> > > > > +	}
> > > > >
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -481,6 +492,9 @@ static irqreturn_t  
> > > > max1027_eoc_irq_handler(int irq, void *private)  
> > > > >  	if (st->cnvst_trigger) {
> > > > >  		ret = max1027_read_scan(indio_dev);
> > > > >  		iio_trigger_notify_done(indio_dev->trig);
> > > > > +	} else {
> > > > > +		st->data_rdy = true;
> > > > > +		wake_up(&max1027_queue);  
> > > >
> > > > I can't see why a queue is appropriate for this.  Use a completion  
> > and  
> > > > have
> > > > one per instance of the device.  No need for the flag etc in that  
> > case as  
> > > > complete() means we have had an interrupt.
> > > >  
> > >
> > > In the case that 'st-> cnvst_trigger' is not set but the spi IRQ
> > > is present, we will wait until we get 'wake_up()' called from here. I  
> > wonder if  
> > > that is a good idea as the device own trigger is not being used. FWIW,  
> > I think this  
> > > sync logic is a bit confusing... I would still use the normal trigger  
> > infrastructure  
> > > ('iio_trigger_generic_data_rdy_poll()') and use the 'cnvst_trigger'  
> > flag in the  
> > > trigger handler to manually start conversions + wait till eoc. But I  
> > might be missing  
> > > something though.  
> > 
> > I implemented it your way, but I think I found a situation that was not
> > fully handled (the 3rd), which makes the handler very complicated
> > as we need to handle all the following cases:
> > 1/ no trigger, irq enabled -> single read EOC interrupt
> > 2/ external trigger, no irq -> handle the whole conversion process
> > 3/ external trigger, irq enabled -> handle the whole conversion process
> >    but also have a dedicated condition to handle the EOC interrupt
> >    properly (fortunately this is a threaded handler that can be
> >    preempted): we need to wait from the handler itself that the
> >    handler gets called again: the first time it is executed as
> >    "pollfunc", the second time as "EOC interrupt". In the second
> >    instance, call complete() in order to deliver the first running
> >    instance of the handler and continue until the reading part.
> > 4/ cnvst trigger, irq enabled -> only reads the data.
> > 5/ cnvst trigger, irq disabled -> not possible.
> > 
> > I added a lot of comments to make it clearer.
> >   
> > > Regarding this handler, I just realized that this is the hard IRQ handler  
> > which  
> > > might end up calling 'max1027_read_scan()' which in turn calls  
> > 'spi_read()'. Am I  
> > > missing something here?  
> > 
> > I renamed it to make it clear, but this is already a threaded handler.
> >   
> 
> Hmm, I think I get what you're trying to do.... FWIW, I think you're just going
> into a lot of trouble here for scenario 3 (I assume external trigger is something
> else other the device own one). IMO, I would just assume that if we are using
> an external trigger we have to wait (sleep) for the end of conversion (i.e, I would
> not care about the IRQ in this case). It would make things much more simpler and
> I guess it should be expected that if some user is deliberately not using the
> device own trigger, will have to wait more for scans.

I thought about that, but this means playing with enabling/disabling
IRQs, which in the end I fear could be almost as verbose :/

Can you look at the new implementation that I proposed and give me your
feedback on it?
[PATCH v2 15/16] iio: adc: max1027: Add support for external triggers

> I cannot also see a reason why someone would want to use some
> external trigger if the device one is available... Does it really make sense?

I would say that "genericity" is a good enough reason for that, but in
practice I agree with you.

Thanks,
Miquèl
