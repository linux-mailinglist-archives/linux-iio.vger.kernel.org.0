Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445A42B2EFC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 18:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgKNRbG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 12:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgKNRbG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 12:31:06 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B3B206D9;
        Sat, 14 Nov 2020 17:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605375065;
        bh=fv0w2541o+hjlxfojdw/rPebsr2gbpxB5930G81cgHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pDpqZR2RhDNnlPqVKu+0MhlahGPKpvS5jvKdlrQ+tAHoSpCg/8zuYnbcRWqjJ/hyj
         chTGK1PvXzWKTHDPVQWb1RJz/tJTnMHKv2PXMaQle/vSiGT3j22ecTbxRfNZwkOKgy
         C8RHnJDjrpcKFg1QfiHrU07qVygv730YhTOw9HeM=
Date:   Sat, 14 Nov 2020 17:31:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, mario.tesi@st.com, denis.ciocca@st.com,
        armando.visconti@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201114173100.0d6ce33e@archlinux>
In-Reply-To: <20201114164840.GA3993@lore-desk>
References: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
        <20201101163354.61ac7576@archlinux>
        <20201102101521.GA229825@lore-desk>
        <20201102174450.0000077e@Huawei.com>
        <20201102181842.GC229825@lore-desk>
        <20201108164942.094e1112@archlinux>
        <20201108182728.GA17810@lore-desk>
        <20201114150630.6d8401a6@archlinux>
        <20201114164840.GA3993@lore-desk>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Nov 2020 17:48:40 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > On Sun, 8 Nov 2020 19:27:28 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >   
> [...]
> > 
> > So the thing I've been trying to say badly here is that I'm fairly sure the
> > issue isn't what you think it is at all.  (Note I've spent a lot of
> > time with scopes on interrupt lines looking for similar issues - it's
> > not fun).
> > 
> > I think the actual condition here is that you have an interrupt that is not
> > guaranteed to go low for long enough between being cleared and set.  Thus if you are
> > read the fifo at almost exactly the moment new data is written you may in theory
> > have the interrupt drop, but in practice analog electronics kicks in an you won't
> > get an interrupt detected at all. This why the sensor needs to put guarantees
> > on that drop time (some do - but I'm not seeing in datasheet for this one).
> > On a more mundane note, I'm not sure in this case that there is a guarantee
> > it will ever drop even in theory - this buffer could for this short period be
> > filling faster than we drain it.  
> 
> ack, very nice explanation :)
> 
> > 
> > The reason your change makes this much less likely to happen is that, by checking
> > again you are generally much closer to the time of the change of the level in
> > the fifo.  Thus, unless you are preempted you should clear it long before it
> > would be set again, and thus get a nice clean drop on the interrupt.
> > 
> > So for some asci art   
> 
> very nice :)
> 
> > 
> > Previously we have
> > 
> > data samples       |       |       |
> >                           _
> > Read of fifo   ___________|_____ 
> >                     _______ _____________
> > interrupt line ____|       |              Interrupt stuck high as edge missed.
> >                            ^       
> >                            1       
> > 
> > With your fix
> > 
> > data samples       |       |       |
> >                           _
> > Read of fifo   ___________|__|__ 
> >                     _______ __
> > interrupt line ____|       |  |____|
> >                            ^       ^
> >                            1       2
> > 
> > So we would have missed 1, but because we check the fifo level again immediate
> > after we would have made it drop, if we hit this unfortunately timing we will
> > very quickly pull new data from the sensor and result in a drop well before the
> > next interrupt comes in.  
> 
> in the last case, even if we introduce a little bit of burstiness, I guess it
> works because we read both 1 and 2, right?

We should always be fine, because the extra check must take a bit of time. Either
the event happens after that time (in which case the interrupt will have been low
long enough) or it doesn't and we will catch it.

> 
> > 
> >   
> > > 
> > > @denis, mario, armando: can you please confirm the hw does not support pulsed
> > > interrupts for fifo-watermark?
> > > 
> > > If not one possible approach would be to disable the interrupt generation on
> > > the sensor at the beginning of st_lsm6dsx_handler_thread() and schedule a
> > > workqueue at the end of st_lsm6dsx_handler_thread() to re-enable the sensor
> > > interrupt generation. What do you think?  
> > 
> > Reenabling it in the thread should work as well.  It is a heavy weight solution
> > but it is what you are expected to do in cases like this. 
> > 
> > I'd be very surprised if that doesn't work.  The normal operation of edge
> > interrupt handlers is to reenable in the thread after we are sure we have
> > cleared the condition for the original interrupt.  That will take long enough
> > (as bus transaction involved) that the interrupt will definitely have dropped
> > for long enough to be detected.  
> 
> agree it should work
> 
> > 
> > In some similar cases we've just concluded the right option is to not
> > support edge interrupts. Do we know if we have boards out there that are using
> > it in that mode and is there any chance they would support level interrupts
> > as that's going to be a lot simpler and more reliable for this?  
> 
> I do not know about it, I just received a report about the issue from stm folks.
> I am fine to drop support for edge interrupts but do we have a similar issue for
> st sensors (acc, magn, gyro) as well? Please consider:
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/st_sensors/st_sensors_trigger.c#L113

It was a part now supported by that driver that I hit this issue on
years ago.  As a side note, there is a bug in there though, be it one we
probably can't hit?  stat_drdy has to be defined, if not the while loop will get
a negative back (which is true) and loop for ever.  

https://elixir.bootlin.com/linux/latest/source/drivers/iio/common/st_sensors/st_sensors_trigger.c#L36
Probably want's to return 0 but print an error message.  Whilst there even better
if that function just returns a boolean so we cant accidentally put such a bug
back in again in future.

Lets go with your fix, but perhaps we should add a note to the dt binding to
say level interrupts preferred?  Saving a check or two in the common case is
definitely beneficial if the host supports level interrupts.

If you can do a v3 with updated explanation and comments that would be great.

Thanks,

Jonathan

> 
> Regards,
> Lorenzo
> 
> > 
> > Jonathan  
> > > 
> > > Regards,
> > > Lorenzo
> > >   
> > > > 
> > > > Jonathan
> > > > 
> > > > 
> > > > 
> > > >     
> > > > > 
> > > > > Regards,
> > > > > Lorenzo
> > > > >     
> > > > > >       
> > > > > > >       
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Hmm. Having had a look at one of the datasheets, I'm far from convinced these
> > > > > > > > parts truely support edge interrupts.  I can't see anything about minimum
> > > > > > > > off periods etc that you need for true edge interrupts. Otherwise they are
> > > > > > > > going to be prone to races.        
> > > > > > > 
> > > > > > > @mario, denis, armando: any pointer for this?
> > > > > > >       
> > > > > > > > 
> > > > > > > > So I think the following can happen.
> > > > > > > > 
> > > > > > > > A) We drain the fifo and it stays under the limit. Hence once that
> > > > > > > >    is crossed in future we will interrupt as normal.
> > > > > > > > 
> > > > > > > > B) We drain the fifo but it either has a very low watermark, or is
> > > > > > > >    filling very fast.   We manage to drain enough to get the interrupt
> > > > > > > >    to fire again, so all is fine if less than ideal.  With you loop we
> > > > > > > >    may up entering the interrupt handler when we don't actually need to.
> > > > > > > >    If you want to avoid that you would need to disable the interrupt,
> > > > > > > >    then drain the fifo and finally do a dance to successfully reenable
> > > > > > > >    the interrupt, whilst ensuring no chance of missing by checking it
> > > > > > > >    should not have fired (still below the threshold)
> > > > > > > > 
> > > > > > > > C) We try to drain the fifo, but it is actually filling fast enough that
> > > > > > > >    we never get it under the limit, so no interrupt ever fires.
> > > > > > > >    With new code, we'll keep spinning to 0 so might eventually drain it.
> > > > > > > >    That needs a timeout so we just give up eventually.
> > > > > > > > 
> > > > > > > > D) watershed is one sample, we drain low enough to successfully get down
> > > > > > > >    to zero at the moment of the read, but very very soon after that we get
> > > > > > > >    one sample again. There is a window in which the interrupt line dropped
> > > > > > > >    but analogue electronics etc being what they are, it may not have been
> > > > > > > >    detectable.  Hence we miss an interrupt...  What you are doing is reducing
> > > > > > > >    the chance of hitting this.  It is nasty, but you might be able to ensure
> > > > > > > >    a reasonable period by widening this window.  Limit the watermark to 2
> > > > > > > >    samples?  
> > > > > > > > 
> > > > > > > > Also needs a fixes tag :)        
> > > > > > > 
> > > > > > > ack, I will add them in v2
> > > > > > > 
> > > > > > > Regards,
> > > > > > > Lorenzo      
> > > > > > > >         
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 +++++++++++++++-----
> > > > > > > > >  1 file changed, 25 insertions(+), 8 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > index 5e584c6026f1..d43b08ceec01 100644
> > > > > > > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > > > > > > @@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
> > > > > > > > >  	return data & event_settings->wakeup_src_status_mask;
> > > > > > > > >  }
> > > > > > > > >  
> > > > > > > > > +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > > > > > > > > +{
> > > > > > > > > +	return IRQ_WAKE_THREAD;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> > > > > > > > >  {
> > > > > > > > >  	struct st_lsm6dsx_hw *hw = private;
> > > > > > > > > +	int fifo_len = 0, len = 0;
> > > > > > > > >  	bool event;
> > > > > > > > > -	int count;
> > > > > > > > >  
> > > > > > > > >  	event = st_lsm6dsx_report_motion_event(hw);
> > > > > > > > >  
> > > > > > > > >  	if (!hw->settings->fifo_ops.read_fifo)
> > > > > > > > >  		return event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > >  
> > > > > > > > > -	mutex_lock(&hw->fifo_lock);
> > > > > > > > > -	count = hw->settings->fifo_ops.read_fifo(hw);
> > > > > > > > > -	mutex_unlock(&hw->fifo_lock);
> > > > > > > > > +	/*
> > > > > > > > > +	 * If we are using edge IRQs, new samples can arrive while
> > > > > > > > > +	 * processing current IRQ and those may be missed unless we
> > > > > > > > > +	 * pick them here, so let's try read FIFO status again
> > > > > > > > > +	 */
> > > > > > > > > +	do {
> > > > > > > > > +		mutex_lock(&hw->fifo_lock);
> > > > > > > > > +		len = hw->settings->fifo_ops.read_fifo(hw);
> > > > > > > > > +		mutex_unlock(&hw->fifo_lock);
> > > > > > > > > +
> > > > > > > > > +		fifo_len += len;
> > > > > > > > > +	} while (len > 0);
> > > > > > > > >  
> > > > > > > > > -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > > +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> > > > > > > > >  }
> > > > > > > > >  
> > > > > > > > >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > > > > > > @@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > > > > > >  
> > > > > > > > >  	switch (irq_type) {
> > > > > > > > >  	case IRQF_TRIGGER_HIGH:
> > > > > > > > > +		irq_type |= IRQF_ONESHOT;
> > > > > > > > > +		fallthrough;
> > > > > > > > >  	case IRQF_TRIGGER_RISING:
> > > > > > > > >  		irq_active_low = false;
> > > > > > > > >  		break;
> > > > > > > > >  	case IRQF_TRIGGER_LOW:
> > > > > > > > > +		irq_type |= IRQF_ONESHOT;
> > > > > > > > > +		fallthrough;
> > > > > > > > >  	case IRQF_TRIGGER_FALLING:
> > > > > > > > >  		irq_active_low = true;
> > > > > > > > >  		break;
> > > > > > > > > @@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> > > > > > > > >  	}
> > > > > > > > >  
> > > > > > > > >  	err = devm_request_threaded_irq(hw->dev, hw->irq,
> > > > > > > > > -					NULL,
> > > > > > > > > +					st_lsm6dsx_handler_irq,
> > > > > > > > >  					st_lsm6dsx_handler_thread,
> > > > > > > > > -					irq_type | IRQF_ONESHOT,
> > > > > > > > > -					"lsm6dsx", hw);
> > > > > > > > > +					irq_type, "lsm6dsx", hw);
> > > > > > > > >  	if (err) {
> > > > > > > > >  		dev_err(hw->dev, "failed to request trigger irq %d\n",
> > > > > > > > >  			hw->irq);        
> > > > > > > >         
> > > > > > >       
> > > > > >       
> > > >     
> >   

