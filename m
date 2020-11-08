Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C7D2AAC46
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 17:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgKHQts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Nov 2020 11:49:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgKHQts (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Nov 2020 11:49:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36B85206ED;
        Sun,  8 Nov 2020 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604854187;
        bh=/m565XO9IBC16nT+cZoefZ+84mjeVT4EAhB/178LoUI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OXQaHx/L3XK9tyIrjh57bUN1Nrn4AhyWrub3tKAueNN3FQWmJWDSAG8owx6qp8pka
         DJKqqME30/Pfwfdi+Rhsm8M5l1OoKD2UZJfi1zj6KFwXJpKmCh9V5LOxr58QsdDqOh
         CwT8IfqBQKUl+35CNqQ028Tq648pWsxXaBDmpff4=
Date:   Sun, 8 Nov 2020 16:49:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        armando.visconti@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201108164942.094e1112@archlinux>
In-Reply-To: <20201102181842.GC229825@lore-desk>
References: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
        <20201101163354.61ac7576@archlinux>
        <20201102101521.GA229825@lore-desk>
        <20201102174450.0000077e@Huawei.com>
        <20201102181842.GC229825@lore-desk>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020 19:18:42 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> > On Mon, 2 Nov 2020 11:15:21 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> > > > On Thu, 22 Oct 2020 11:26:53 +0200
> > > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > >     
> > > > > If the device is configured to trigger edge interrupts it is possible to
> > > > > miss samples since the sensor can generate an interrupt while the driver
> > > > > is still processing the previous one.
> > > > > Poll FIFO status register to process all pending interrupts.
> > > > > Configure IRQF_ONESHOT only for level interrupts.    
> > > >     
> > > 
> > > Hi Jonathan,
> > > 
> > > thx for the review :)
> > >   
> > > > Hmm. This sort of case is often extremely prone to race conditions.
> > > > I'd like to see more explanation of why we don't have one after this
> > > > fix.  Edge interrupts for FIFOs are horrible!
> > > > 
> > > > Dropping IRQF_ONESHOT should mean we enter the threaded handler with
> > > > interrupts enabled, but if another one happens we still have to wait
> > > > for the thread to finish before we schedule it again.
> > > > We should only do that if we disabled the interrupt in the top half,
> > > > which we haven't done here (you are working around the warnings
> > > > that would be printed with the otherwise pointless top half).    
> > > 
> > > looking at handle_edge_irq (please correct me if I am wrong) IRQF_ONESHOT
> > > takes effect only for level interrupts while for edge-sensitive interrupts
> > > the irq handler runs with the line unmasked. In fact the IRQF_ONESHOT part of
> > > the patch seems not relevant for fixing the issue, I just aligned the code to
> > > st_sensor general handling in st_sensors_allocate_trigger()
> > > (https://elixir.bootlin.com/linux/v5.9.3/source/drivers/iio/common/st_sensors/st_sensors_trigger.c#L182).
> > > I think the issue is a new interrupt can fire while we are still processing
> > > the previous one if watermark is low (e.g. 1) and the sensor is running at high
> > > ODR (e.g. 833Hz). Reading again the status register in st_lsm6dsx_handler_thread()
> > > fixes the issue in my tests.
> > > I guess we can just drop the IRQF_ONESHOT chunk and keep the while loop in
> > > st_lsm6dsx_handler_thread(). What do you think?  
> > 
> > I'd do that.  
> 
> ack, I will post a v2 with only this change.
> 
> >   
> > >   
> > > > 
> > > > I 'assume' that the interrupts are latched.  So we won't get a new
> > > > interrupt until we have taken some action to clear it?  In this
> > > > case that action is removing items from the fifo?    
> > > 
> > > I do not know :). Adding stm folks.
> > > @mario, denis, armando: any pointer for this?
> > >   
> > > > 
> > > > IIRC, if we get an interrupt whilst it is masked due to IRQF_ONESHOT
> > > > then it is left pending until we exit the thread.  So that should
> > > > be sufficient to close a potential edge condition where we clear
> > > > the fifo, and it immediately fires again.  This pending behaviour
> > > > is necessary to avoid the race that would happen in any normal handler.    
> > > 
> > > I did not get you on this point.  
> > 
> > If an interrupt occurs, even whilst we have it masked, we shouldn't
> > loose it.  If we did so then any normal handler that clears the interrupt
> > at the end of doing whatever it needs to do would race against a new interrupt.
> > 
> > So my suspicion is that you aren't actually missing an interrupt, but rather the
> > drop time is too short to be detected (or effectively not there at all).  
> 
> I guess since edge interrupts run with the line unmasked a new interrupt can fire
> while the irq thread is still running (so wake_up_process() will just return) but
> the driver has already read fifo_status register and so it will not read new
> sample. This case should be fixed reading again the fifo_status register.

It doesn't actually help because there is always a window after the fifo_status register
is read before we exit the thread.

I 'think' what happens (it's been a while since I dug through this stuff) is
that you end up with the task being added to the runqueue, even though it's
already running. Upshot the thread gets scheduled gain. 

If this were not the case there would be a race with any edge based interrupt
as the thread has to reenable the interrupt and it will always be able to fire
whilst the thread is still running.

Jonathan




> 
> Regards,
> Lorenzo
> 
> >   
> > >   
> > > > 
> > > > 
> > > > Hmm. Having had a look at one of the datasheets, I'm far from convinced these
> > > > parts truely support edge interrupts.  I can't see anything about minimum
> > > > off periods etc that you need for true edge interrupts. Otherwise they are
> > > > going to be prone to races.    
> > > 
> > > @mario, denis, armando: any pointer for this?
> > >   
> > > > 
> > > > So I think the following can happen.
> > > > 
> > > > A) We drain the fifo and it stays under the limit. Hence once that
> > > >    is crossed in future we will interrupt as normal.
> > > > 
> > > > B) We drain the fifo but it either has a very low watermark, or is
> > > >    filling very fast.   We manage to drain enough to get the interrupt
> > > >    to fire again, so all is fine if less than ideal.  With you loop we
> > > >    may up entering the interrupt handler when we don't actually need to.
> > > >    If you want to avoid that you would need to disable the interrupt,
> > > >    then drain the fifo and finally do a dance to successfully reenable
> > > >    the interrupt, whilst ensuring no chance of missing by checking it
> > > >    should not have fired (still below the threshold)
> > > > 
> > > > C) We try to drain the fifo, but it is actually filling fast enough that
> > > >    we never get it under the limit, so no interrupt ever fires.
> > > >    With new code, we'll keep spinning to 0 so might eventually drain it.
> > > >    That needs a timeout so we just give up eventually.
> > > > 
> > > > D) watershed is one sample, we drain low enough to successfully get down
> > > >    to zero at the moment of the read, but very very soon after that we get
> > > >    one sample again. There is a window in which the interrupt line dropped
> > > >    but analogue electronics etc being what they are, it may not have been
> > > >    detectable.  Hence we miss an interrupt...  What you are doing is reducing
> > > >    the chance of hitting this.  It is nasty, but you might be able to ensure
> > > >    a reasonable period by widening this window.  Limit the watermark to 2
> > > >    samples?  
> > > > 
> > > > Also needs a fixes tag :)    
> > > 
> > > ack, I will add them in v2
> > > 
> > > Regards,
> > > Lorenzo  
> > > >     
> > > > > 
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 +++++++++++++++-----
> > > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > index 5e584c6026f1..d43b08ceec01 100644
> > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > @@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
> > > > >  	return data & event_settings->wakeup_src_status_mask;
> > > > >  }
> > > > >  
> > > > > +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > > > > +{
> > > > > +	return IRQ_WAKE_THREAD;
> > > > > +}
> > > > > +
> > > > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> > > > >  {
> > > > >  	struct st_lsm6dsx_hw *hw = private;
> > > > > +	int fifo_len = 0, len = 0;
> > > > >  	bool event;
> > > > > -	int count;
> > > > >  
> > > > >  	event = st_lsm6dsx_report_motion_event(hw);
> > > > >  
> > > > >  	if (!hw->settings->fifo_ops.read_fifo)
> > > > >  		return event ? IRQ_HANDLED : IRQ_NONE;
> > > > >  
> > > > > -	mutex_lock(&hw->fifo_lock);
> > > > > -	count = hw->settings->fifo_ops.read_fifo(hw);
> > > > > -	mutex_unlock(&hw->fifo_lock);
> > > > > +	/*
> > > > > +	 * If we are using edge IRQs, new samples can arrive while
> > > > > +	 * processing current IRQ and those may be missed unless we
> > > > > +	 * pick them here, so let's try read FIFO status again
> > > > > +	 */
> > > > > +	do {
> > > > > +		mutex_lock(&hw->fifo_lock);
> > > > > +		len = hw->settings->fifo_ops.read_fifo(hw);
> > > > > +		mutex_unlock(&hw->fifo_lock);
> > > > > +
> > > > > +		fifo_len += len;
> > > > > +	} while (len > 0);
> > > > >  
> > > > > -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> > > > >  }
> > > > >  
> > > > >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > > @@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > >  
> > > > >  	switch (irq_type) {
> > > > >  	case IRQF_TRIGGER_HIGH:
> > > > > +		irq_type |= IRQF_ONESHOT;
> > > > > +		fallthrough;
> > > > >  	case IRQF_TRIGGER_RISING:
> > > > >  		irq_active_low = false;
> > > > >  		break;
> > > > >  	case IRQF_TRIGGER_LOW:
> > > > > +		irq_type |= IRQF_ONESHOT;
> > > > > +		fallthrough;
> > > > >  	case IRQF_TRIGGER_FALLING:
> > > > >  		irq_active_low = true;
> > > > >  		break;
> > > > > @@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > >  	}
> > > > >  
> > > > >  	err = devm_request_threaded_irq(hw->dev, hw->irq,
> > > > > -					NULL,
> > > > > +					st_lsm6dsx_handler_irq,
> > > > >  					st_lsm6dsx_handler_thread,
> > > > > -					irq_type | IRQF_ONESHOT,
> > > > > -					"lsm6dsx", hw);
> > > > > +					irq_type, "lsm6dsx", hw);
> > > > >  	if (err) {
> > > > >  		dev_err(hw->dev, "failed to request trigger irq %d\n",
> > > > >  			hw->irq);    
> > > >     
> > >   
> >   

