Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCD341264E
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385437AbhITS4t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 20 Sep 2021 14:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385809AbhITSw2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Sep 2021 14:52:28 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F57461374;
        Mon, 20 Sep 2021 17:39:55 +0000 (UTC)
Date:   Mon, 20 Sep 2021 18:43:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v2 15/16] iio: adc: max1027: Add support for external
 triggers
Message-ID: <20210920184338.0a9c5863@jic23-huawei>
In-Reply-To: <20210920103739.069ee8b2@xps13>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-16-miquel.raynal@bootlin.com>
        <20210905171046.1681482d@jic23-huawei>
        <20210915121832.7766fdd7@xps13>
        <20210918181308.1b41cc3a@jic23-huawei>
        <20210920103739.069ee8b2@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Sep 2021 10:37:39 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
> 
> jic23@kernel.org wrote on Sat, 18 Sep 2021 18:13:08 +0100:
> 
> > On Wed, 15 Sep 2021 12:18:32 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Hi Jonathan, Nuno,
> > > 
> > > jic23@kernel.org wrote on Sun, 5 Sep 2021 17:10:46 +0100:
> > >     
> > > > On Thu,  2 Sep 2021 23:14:36 +0200
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >       
> > > > > So far the driver only supported to use the hardware cnvst trigger. This
> > > > > was purely a software limitation.
> > > > > 
> > > > > The IRQ handler is already registered as being a poll function and thus
> > > > > can be called upon external triggering. In this case, a new conversion
> > > > > must be started, and one must wait for the data to be ready before
> > > > > reading the samples.
> > > > > 
> > > > > As the same handler can be called from different places, we check the
> > > > > value of the current IRQ with the value of the registered device
> > > > > IRQ. Indeed, the first step is to get called with a different IRQ number
> > > > > than ours, this is the "pullfunc" version which requests a new        
> > > > 
> > > > pullfunc?
> > > >       
> > > > > conversion. During the execution of the handler, we will wait for the
> > > > > EOC interrupt to happen. This interrupt is handled by the same
> > > > > helper. This time the IRQ number is the one we registered, we can in
> > > > > this case call complete() to unlock the primary handler and return. The
> > > > > primary handler continues executing by retrieving the data normally and
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
> > > > Trigger IRQ / EOC IRQ  (this is the spi->irq)  (currently iio_trigger_generic_data_poll_ready)
> > > >   |              |
> > > >   ---------      v
> > > >   |        |   complete
> > > >   v        v
> > > > TrigH1    (TrigH2)   (these are the IRQs below the irq_chip IIO uses to demux triggers)
> > > > 
> > > > 
> > > > So when using it's own trigger we are using an internal interrupt
> > > > tree burried inside the IIO core.  When using it only as an EOC interrupt we shouldn't
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
> > > > I am a little confused how this works with an external trigger because the Trig H1 interrupt
> > > > should be disabled unless we are using the trigger.  That control isn't exposed to the
> > > > driver at all.
> > > > 
> > > > Is my understanding right or have I gotten confused somewhere?      
> > > 
> > > I think the confusion comes from the fact that in the
> > > current implementation, Trigger IRQ and EOC IRQ handlers are the same.
> > > This comes from a possible misunderstanding in the previous review,
> > > where I understood that you and Nuno wanted to keep using
> > > iio_trigger_generic_data_rdy_poll() hand have a single handler in the
> > > driver (which I think is far from optimal). I can try to split that
> > > handler again to have two distinct paths.    
> > That is the right thing to do.  The split should be done a little differently
> > than you have it in v3. I've added comments to that patch.
> > 
> > Data ready triggers are always a little messy because we end up with a split that
> > is:
> > 
> > Trigger side -  Interrupt comes in here...
> > 
> > --------- GENERIC IIO HANDLING ----- Take the trigger and routes it to the device code --- 
> > 
> > Device side - We do the data reading here.
> > 
> > The reason for this is that we may well have other devices using the same trigger
> > and we want to keep the model looking the same for all devices.
> > 
> > A push into an iio buffer should always be on the device side of that boundary.  
> 
> This is much clearer, I think I have got the main idea.
> 
> However I have a question that is specific to the current situation. In
> the case of this particular device, I don't really understand how
> another device could use the same trigger than the hardware one,
> because we have no indication of the trigger being latched. When we get
> the information the data is already in the FIFO, this means we get the
> information much later than when the hardware transitioned to indicate
> a conversion request. Is it that in your model, we should be able to
> use the EOC IRQ handler to trigger another IIO device, even though
> this implies an additional delay?

It's not ideal, but sometimes it is better to have somewhat consistent
'synchronization' between multiple devices.  You are correct that anything
else using a data ready trigger will be a bit late - but the frequencies
will at least be matched.  Not great but the best possible under these
circumstances.

If it's possible to use a truely shared hardware trigger that is obviously
better than you can do here.

Jonathan

> 
> Thanks,
> Miquèl
> 
> > > > I also can't see a path in which the eoc interrupt will get fired for raw_reads.
> > > > 
> > > > Could you talk me through how that works currently?
> > > > 
> > > > I suspect part of the confusion here is that this driver happens to be using the
> > > > standard core handler iio_trigger_generic_data_rdy_poll which hides away that
> > > > there are two interrupt handlers in a normal IIO driver for a device with a
> > > > trigger and buffered mode.
> > > > 1 for the trigger and 1 for the buffer.  Whether the buffer one is a result
> > > > of the trigger one (via iio_poll_trigger) is down to whether the device is
> > > > using it's own trigger or not.      
> > > 
> > > Also, to answer Nuno about the question: is this actually working: IIRC
> > > I mentioned it in the cover letter but my hardware does not have the
> > > EOC line wired so I am unable to actually test that I am not breaking
> > > this. My main goal is to be able to use external triggers (such as a
> > > timer) and I am a bit struggling with the constraints of my hardware +
> > > the design of this chip.
> > > 
> > > I will provide a third implementation in v3 and if this still does not
> > > fit your mental model please guide me with maybe an untested code
> > > snippet just to show me how you think this should be implemented.
> > > 
> > > Thank you both for the numerous reviews and precious feedback anyway!
> > > Miquèl
> > >   

