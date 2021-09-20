Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D63411315
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 12:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhITKtQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 20 Sep 2021 06:49:16 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41571 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhITKtM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 06:49:12 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0E8CEE0003;
        Mon, 20 Sep 2021 10:47:43 +0000 (UTC)
Date:   Mon, 20 Sep 2021 12:47:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 15/16] iio: adc: max1027: Add support for external
 triggers
Message-ID: <20210920124743.3b2618c0@xps13>
In-Reply-To: <20210918183920.236f4f0d@jic23-huawei>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-16-miquel.raynal@bootlin.com>
        <20210905171046.1681482d@jic23-huawei>
        <SA1PR03MB6355E88079A1B425FC236F3399D29@SA1PR03MB6355.namprd03.prod.outlook.com>
        <20210915174507.2f2d1482@xps13>
        <20210918183920.236f4f0d@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 18 Sep 2021 18:39:20 +0100:

> On Wed, 15 Sep 2021 17:45:07 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Nuno, Jonathan,
> > 
> > Nuno.Sa@analog.com wrote on Mon, 6 Sep 2021 09:53:15 +0000:
> >   
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Sunday, September 5, 2021 6:11 PM
> > > > To: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > Cc: Lars-Peter Clausen <lars@metafoo.de>; linux-iio@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Thomas Petazzoni
> > > > <thomas.petazzoni@bootlin.com>; Sa, Nuno <Nuno.Sa@analog.com>
> > > > Subject: Re: [PATCH v2 15/16] iio: adc: max1027: Add support for
> > > > external triggers
> > > > 
> > > > [External]
> > > > 
> > > > On Thu,  2 Sep 2021 23:14:36 +0200
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >       
> > > > > So far the driver only supported to use the hardware cnvst trigger.      
> > > > This      
> > > > > was purely a software limitation.
> > > > >
> > > > > The IRQ handler is already registered as being a poll function and      
> > > > thus      
> > > > > can be called upon external triggering. In this case, a new conversion
> > > > > must be started, and one must wait for the data to be ready before
> > > > > reading the samples.
> > > > >
> > > > > As the same handler can be called from different places, we check      
> > > > the      
> > > > > value of the current IRQ with the value of the registered device
> > > > > IRQ. Indeed, the first step is to get called with a different IRQ      
> > > > number      
> > > > > than ours, this is the "pullfunc" version which requests a new      
> > > > 
> > > > pullfunc?
> > > >       
> > > > > conversion. During the execution of the handler, we will wait for the
> > > > > EOC interrupt to happen. This interrupt is handled by the same
> > > > > helper. This time the IRQ number is the one we registered, we can in
> > > > > this case call complete() to unlock the primary handler and return.      
> > > > The      
> > > > > primary handler continues executing by retrieving the data normally      
> > > > and      
> > > > > finally returns.      
> > > > 
> > > > Interesting to use the irq number..
> > > > 
> > > > I'm a little nervous about how this has ended up structured.
> > > > I'm not 100% sure my understanding of how you've done it is correct.
> > > > 
> > > > We should have the following situation:
> > > > 
> > > > IRQ IN
> > > >   |
> > > >   v
> > > > Trigger IRQ / EOC IRQ  (this is the spi->irq)  (currently
> > > > iio_trigger_generic_data_poll_ready)
> > > >   |              |
> > > >   ---------      v
> > > >   |        |   complete
> > > >   v        v
> > > > TrigH1    (TrigH2)   (these are the IRQs below the irq_chip IIO uses to
> > > > demux triggers)
> > > > 
> > > > 
> > > > So when using it's own trigger we are using an internal interrupt
> > > > tree burried inside the IIO core.  When using it only as an EOC interrupt
> > > > we shouldn't
> > > > be anywhere near that internal interrupt chip.
> > > > 
> > > > So I'm surprised the IRQ matches with the spi->irq as
> > > > those trigH1 and trigH2 will have their own IRQ numbers.
> > > > 
> > > > For reference I think your architecture is currently
> > > > 
> > > > IRQ IN
> > > >   |
> > > >   v
> > > >   Trigger IRQ
> > > >   |
> > > >   v
> > > >  TRIG H1
> > > >  Either fills the buffer or does the completion.
> > > > 
> > > > I am a little confused how this works with an external trigger because
> > > > the Trig H1 interrupt
> > > > should be disabled unless we are using the trigger.  That control isn't
> > > > exposed to the
> > > > driver at all.
> > > > 
> > > > Is my understanding right or have I gotten confused somewhere?
> > > > I also can't see a path in which the eoc interrupt will get fired for
> > > > raw_reads.
> > > > 
> > > > Could you talk me through how that works currently?    
> > 
> > I forgot to do this, I think you misunderstood the following patch:
> > "iio: adc: max1027: Don't just sleep when the EOC interrupt is
> > available"
> > 
> > As I am having deep troubles reworking this once again, I will try to
> > explain how this is build below and look for your feedback on it.  
> 
> Unfortunately I'm not successfully managing to convey what I am trying
> to get you to change this to...

This is certainly more related to my lack of 'IIO culture', I think all
this makes much more sense now that (I think) I understand the
theoretical model and I need to thank you a lot for your patience and
all the clarifications you brought until now.

> > > > I suspect part of the confusion here is that this driver happens to be
> > > > using the
> > > > standard core handler iio_trigger_generic_data_rdy_poll which hides
> > > > away that
> > > > there are two interrupt handlers in a normal IIO driver for a device with
> > > > a
> > > > trigger and buffered mode.
> > > > 1 for the trigger and 1 for the buffer.  Whether the buffer one is a
> > > > result
> > > > of the trigger one (via iio_poll_trigger) is down to whether the device
> > > > is
> > > > using it's own trigger or not.
> > > >     
> > 
> > [...]
> >    
> > > I'm also confused by this. Going through the series, I was actually
> > > thinking that raw_reads were in fact using the EOC IRQ until I realized
> > > that 'complete()' was being called from the trigger handler... So,
> > > I'm also not sure how is this supposed to work?    
> > 
> > I renamed this handler with a generic name, because it actually serves
> > several different purposes, see below.
> >   
> > > But I'm probably
> > > missing something as I guess you tested this and how I'm understanding
> > > things, you should have gotten timeouts for raw_reads.
> > > 
> > > Anyways, as Jonathan said, I was also expecting to see the 'complete()' call
> > > from the device IRQ handler. Other thing than that is just asking for trouble
> > > :). 
> > > 
> > > - Nuno Sá    
> >   
> I'm going to take a multi pronged approach to trying to get us on the same
> page design wise.   I've replied to v3 with code snippets that will hopefully
> convey the explanation I'm giving here.
> 
> Data ready triggers always provide some blurring of the nice clean
> trigger -> IIO CORE HANDLING -> device handling to grab data and push it out..
> but we have a fairly standard model for this and whilst limited in functionality
> I think the max1027 was keeping to this model.
> 
> > So here is how I understand the device:
> > * During a raw read:
> >   The IRQ indicates an EOC.
> > * During a triggered read (internal trigger):
> >   The driver has no knowledge of the trigger being fired, it only
> >   sees the IRQ firing at EOC. This means the internal trigger cannot be
> >   used without the IRQ.
> > 
> > Now here is what I understand from the IIO subsystem and what I tried
> > to implement:
> > * Perform a raw read:
> >   The driver needs to setup the channels, start the operation, wait for
> >   the end of the conversion, return the value. This is all done in the  
> >   ->raw_read() hook in process context. Raw reads can either use the    
> >   EOC IRQ if wired or just wait for a sufficiently large amount of
> >   time.
> > * Perform a triggered read (internal trigger):
> >   The device will get triggered by a hardware event that is out of
> >   control from the driver. The driver is only aware of the IRQ firing
> >   when the conversion is done. It then must push the samples to a set
> >   of buffers and notify the IIO core.  
> 
> True, but there are two steps to this.
> 1) The trigger IRQ fires.  That then calls a tree of other interrupts
> (iio_trigger_poll()).
> One of that tree of interrupts is attached by the driver.
> That interrupt handler is then called to actually take the data indicated
> by the EOC interrupt and push it to the buffer.  Note this second interrupt
> is registered as part of iio_triggered_buffer_setup() which is why that
> function takes interrupt handlers.
> 
> > * Perform a triggered read (external trigger):
> >   This looks very much like a raw read from the driver point of view,
> >   the difference being that, when the external trigger fires, the IIO
> >   core will first call iio_pollfunc_store_time() as hard IRQ handler
> >   and then calls a threaded handler that is supposed to configure the
> >   channels, start the conversions, wait for it and again push the
> >   samples when their are ready. These two handlers are registered by
> >   devm_iio_triggered_buffer_setup().  
> 
> 
> That is true in your code, but it is not the correct way to do this because
> in the event of a trigger other than the EOC one, we should not have the
> interrupt to indicate the end of the read we are manually starting calling
> into the handler for the trigger (as it wasn't the trigger!) - it should
> be handled at the level above that.
> 
> If you have a different trigger than the EOC one provided by this driver then
> the top level interrupt handler (the one that actually handles the EOC interrupt
> should not call iio_trigger_generic_data_ready_poll() because we need to do
> something different in that interrupt handler.  It is this handler that
> you should modify so that it does different things depending on whether or
> not the EOC trigger is in use. (you can check this using iio_trigger_using_own(iio_dev))
> 
> I've tried to find a simple example of this, but they are all rather convoluted for
> various device specific reasons (getting the best possible timestamp for example)
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/pressure/zpa2326.c#L786
> more or less follows the model I'm describing with some rather fiddly timestamp
> handling..
> 
> > 
> > There is an additional level of complexity as, my hardware does not
> > feature this EOC IRQ (it is not wired and thus cannot be used). I want
> > to be able to also support the absence of IRQ which is not necessary
> > for any operation but the internal trigger use.
> > 
> > How I ended-up implementing things in v2:
> > * Raw read:
> >   Start the conversion.
> >   Wait for the conversion to be done:
> >   - With IRQ: use wait_for_completion(), the IRQ will fire, calling
> >     iio_trigger_generic_data_rdy_poll() [1], calling complete() in this
> >     situation.
> >   - Without IRQ: busy wait loop.
> > 
> > [1] Maybe this is the thing that is bothering you, using the internal
> > IIO trigger interrupt tree logic to handle a regular EOC situation.  
> 
> Yes.
> 
> > In
> > all drivers that I had a chance to look at, it's always done like that
> > but perhaps it was bad luck and the more I look at it, the less I
> > understand its use. I will propose an alternative where the hard IRQ
> > handler really is the EOC handler and eventually calls a threaded
> > handler in the case of an internal triggering to push the samples.
> > I don't see the point of using iio_trigger_generic_data_rdy_poll()
> > anymore (maybe I'm wrong, tell me after reading v3?).  
> 
> 
> 
> > 
> > I ended-up writing this driver this way because I thought that I had to
> > provide a single IRQ handler and use
> > iio_trigger_generic_data_rdy_poll() but now I think I either
> > misinterpreted the comments or it was bad advise. I fell that the
> > driver is much simpler to understand in v3 where there is:
> > - one hard IRQ handler registered as the primary interrupt handler:
> >   its purpose is to handle EOC conditions
> > - one threaded handler registered as the secondary interrupt handler:
> >   it will only be triggered when using the internal trigger, its purpose
> >   is to read and push the samples
> > - one threaded handler registered as the external trigger handler:
> >   it will start the conversion, wait for EOC (either by busy waiting if
> >   there is no IRQ or by waiting for completion otherwise - complete()
> >   being called in the primary IRQ handler), read the data and push it
> >   to the buffers.  
> This nearly works, but I think the trigger reference counting will be broken
> because you call iio_trigger_notify_done() without calling iio_trigger_poll().
> You could cheat and drop the notify_done() - which is the solution used when
> we have fifos involved and hence have to do a still more complex dance but
> that isn't the right solution here.
> 
> This is more complex than should be needed and doesn't fit the model IIO
> uses to separate triggers and data capture.
> 
> A few 'rules' which get bent occasionally, particularly when a driver only
> supports it's own trigger.
> * iio_trigger_poll() only called in an interrupt handler that is handling
>   the interrupt which is the trigger in use.  So in this case, only when
>   the driver is configured to use the EOC based trigger.
> * iio_push_to_buffers_*(), iio_trigger_notify_done() only called from a
>   trigger handler which is registered with iio_triggered_buffer_setup))
> 
> To keep to this set of rules we need two paths in the trigger irq handler
> and in the trigger handler (the one on the 'device' side of the internal
> irq chip that IIO uses to 'broadcast' triggers).
> 
> I may well have messed up details in the following but hopefully I manage
> to convey the basic approach I'm suggesting.

With this and your previous answer, I think I well understand now what
you meant in your first reviews. Thank you so much for all the
guidance, I'll try to make v4 fit.

> So replace that iio_trigger_generic_data_rdy_poll() with one that does
> something along the lines of
> 
> irqreturn_t irq_handler(int irq, void *private)
> {
> 	struct iio_dev *indio_dev = private;
> 	struct max1027_state *st = iio_priv(indio_dev);
> 
> 	if (!iio_buffer_enabled(indio_dev) ||
> 	    !iio_trigger_using_own(trigger) {
> 		complete(st->completion);
> 		return IRQ_HANDLED;
> 	}
> 	/* So we only use this as a trigger - if it is the trigger! */
> 	return iio_trigger_generic_data_rdy_poll(st->trig, irq); 	

Understood.

> }
> 
> registered in the 
> dev_request_threaded_irq() call with the private parameter changed to indio_dev
> as you have done in v3.
> 
> and
> 
> irqreturn_t trigger_handler(void *private, int irq)
> {
> 	struct iio_poll_func *pf = private;
> 	struct io_dev *indio_dev = pf->indio_dev;
> 
> 	if (!iio_trigger_using_own(indio_dev)) {
> 		ret = max1027_configure_chans_and_start(indio_dev);
> 		if (ret)
> 			return IRQ_HANDLED;
> 
> 		ret = max1027_wait_eoc(indio_dev);
> 		if (ret)
> 			return IRQ_HANDLED;
> 
> 	 	ret = max1027_read_scan(indio_dev);
> 		if (ret)
> 			return IRQ_HANDLED;	
> 		iio_trigger_notify_done(indio_dev);
> 		return IRQ_HANDLED;
> 	} else {
> 		ret = max1027_read_scan(indio_dev);
> 		if (ret)
> 			dev_err(&indio_dev->dev,
> 			"Cannot read scanned values (%d)\n", ret);
> 	
> 		iio_trigger_notify_done(indio_dev->trig);
> 	
> 		return IRQ_HANDLED;
> 	}
> /* Feel free to rearrange as you like! */
> 
> }
> 
> > 
> > If this implementation does not fit your requirements, I will really
> > need more advanced advises about what you require, what I should avoid
> > and perhaps what is wrong in the above explanation :)
> > 
> > Thanks,
> > Miquèl  
> 


Thanks,
Miquèl
