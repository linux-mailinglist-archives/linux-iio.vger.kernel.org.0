Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8B4898BF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jan 2022 13:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245594AbiAJMjN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jan 2022 07:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiAJMjK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jan 2022 07:39:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180CC061748
        for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2022 04:39:10 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n6tx1-0007Gd-W2; Mon, 10 Jan 2022 13:39:03 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n6tx1-00083y-CO; Mon, 10 Jan 2022 13:39:03 +0100
Date:   Mon, 10 Jan 2022 13:39:03 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 1/1] iio: adc: tsc2046: rework the trigger state
 machine
Message-ID: <20220110123903.GC3326@pengutronix.de>
References: <20220107074017.2762347-1-o.rempel@pengutronix.de>
 <20220109154404.75e0ed2f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109154404.75e0ed2f@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:12:59 up 30 days, 16:58, 71 users,  load average: 0.10, 0.15,
 0.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 09, 2022 at 03:44:04PM +0000, Jonathan Cameron wrote:
> On Fri,  7 Jan 2022 08:40:17 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > Initially this was designed to:
> > | Fix sleeping in atomic context warning and a deadlock after iio_trigger_poll()
> > | call
> > |
> > | If iio_trigger_poll() is called after IRQ was disabled, we will call
> > | reenable_trigger() directly from hard IRQ or hrtimer context instead of
> > | IRQ thread. In this case we will run in to multiple issue as sleeping in atomic
> > | context and a deadlock.
> > |
> > | To avoid this issue, rework the trigger to use state machine. All state
> > | changes are done over the hrtimer, so it allows us to drop fsleep() and
> > | avoid the deadlock.
> > 
> > This issue was fixed by: 9020ef659885 ("iio: trigger: Fix a scheduling
> > whilst atomic issue seen on tsc2046").
> > 
> > Even if the root cause of this issue probably will and can be fixed in the iio
> > core, this patch can be seen as clean-up to provide better internal state
> > machine.
> 
> Probably want to update this text?

ack

> A few comments below.
> > 
> > Fixes: 9374e8f5a38d ("iio: adc: add ADC driver for the TI TSC2046 controller")
> 
> From above isn't this now fixed?  The cleanup here is just making things easier
> to follow I think...

done

> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/iio/adc/ti-tsc2046.c | 102 ++++++++++++++++++++---------------
> >  1 file changed, 58 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> > index d84ae6b008c1..91f6bd5effe7 100644
> > --- a/drivers/iio/adc/ti-tsc2046.c
> > +++ b/drivers/iio/adc/ti-tsc2046.c
> > @@ -123,14 +123,21 @@ struct tsc2046_adc_ch_cfg {
> >  	unsigned int oversampling_ratio;
> >  };
> >  
> > +enum tsc2046_state {
> > +	TSC2046_STATE_STANDBY,
> > +	TSC2046_STATE_ENABLE_IRQ_POLL,
> > +	TSC2046_STATE_POLL,
> > +	TSC2046_STATE_ENABLE_IRQ,
> > +};
> > +
> >  struct tsc2046_adc_priv {
> >  	struct spi_device *spi;
> >  	const struct tsc2046_adc_dcfg *dcfg;
> >  
> >  	struct iio_trigger *trig;
> >  	struct hrtimer trig_timer;
> > -	spinlock_t trig_lock;
> > -	unsigned int trig_more_count;
> > +	enum tsc2046_state state;
> > +	spinlock_t state_lock;
> >  
> >  	struct spi_transfer xfer;
> >  	struct spi_message msg;
> > @@ -411,21 +418,47 @@ static const struct iio_info tsc2046_adc_info = {
> >  	.update_scan_mode = tsc2046_adc_update_scan_mode,
> >  };
> >  
> > -static enum hrtimer_restart tsc2046_adc_trig_more(struct hrtimer *hrtimer)
> > +static enum hrtimer_restart tsc2046_adc_timer(struct hrtimer *hrtimer)
> >  {
> >  	struct tsc2046_adc_priv *priv = container_of(hrtimer,
> >  						     struct tsc2046_adc_priv,
> >  						     trig_timer);
> >  	unsigned long flags;
> >  
> > -	spin_lock_irqsave(&priv->trig_lock, flags);
> > -
> > -	disable_irq_nosync(priv->spi->irq);
> > -
> > -	priv->trig_more_count++;
> > -	iio_trigger_poll(priv->trig);
> > -
> > -	spin_unlock_irqrestore(&priv->trig_lock, flags);
> > +	spin_lock_irqsave(&priv->state_lock, flags);
> > +	switch (priv->state) {
> > +	case TSC2046_STATE_ENABLE_IRQ_POLL:
> > +		/*
> > +		 * IRQ handler called iio_trigger_poll() to sample ADC.
> > +		 * Here we
> > +		 * - re-enable IRQs
> > +		 * - start hrtimer for timeout if no IRQ will occur
> > +		 */
> > +		priv->state = TSC2046_STATE_POLL;
> > +		enable_irq(priv->spi->irq);
> 
> I comment on this below, but I'm not sure why you don't move the enable_irq()
> here out of this timer function and then have the first entry of the timer
> go directly to TSC2046_STATE_POLL after a longer initial wait.

Hm... yes. You are right.

> It's been a long time since I looked at this, so perhaps I'm missing the
> point.  What you have here works as far as I can see, it just seems to push
> more than necessary into the state machine.

The IRQ line is a level shifter connected to one of channels muxed to the core
ADC. If we switch internal muxer to different channel, the IRQ line will
change the state.

So, we need a trigger which:
- do not triggers if we do ADC readings.
- keeps triggering as long as we have some state changes on the IRQ line
- trigger only with specific rate
- still triggers for some amount of time after last interrupt event was
  detected. Current implementation is doing only one extra read.

I reworked it a bit, will send new patch soon.

> > +		hrtimer_start(&priv->trig_timer,
> > +			      ns_to_ktime(priv->scan_interval_us *
> > +					  NSEC_PER_USEC),
> > +			      HRTIMER_MODE_REL_SOFT);
> > +		break;


> > -
> > -	spin_unlock_irqrestore(&priv->trig_lock, flags);
> > +	tim = ns_to_ktime((priv->scan_interval_us - priv->time_per_scan_us) *
> > +			  NSEC_PER_USEC);
> > +	hrtimer_start(&priv->trig_timer, tim, HRTIMER_MODE_REL_SOFT);
> 
> This moves enabling the irq to the first instance of the timer - is that ever too late?

no, we should disable IRQ if we do readings anyway.

> >  }
> >  
> >  static int tsc2046_adc_set_trigger_state(struct iio_trigger *trig, bool enable)
> > @@ -493,8 +506,8 @@ static int tsc2046_adc_set_trigger_state(struct iio_trigger *trig, bool enable)
> >  	if (enable) {
> >  		enable_irq(priv->spi->irq);
> >  	} else {
> > +		hrtimer_cancel(&priv->trig_timer);
> 
> So this will wait for the callback to finish.  However, is there a chance
> of an interrupt just after this but before disable_irq that ends up
> starting the timer again?

Yes, you are right. I'll rework it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
