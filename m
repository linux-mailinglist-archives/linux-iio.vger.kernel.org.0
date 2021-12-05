Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA5468C6B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 18:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhLERd5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhLERd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:33:56 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94112C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 09:30:29 -0800 (PST)
Received: from [81.101.6.87] (port=52498 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mtvLH-0005XY-HS; Sun, 05 Dec 2021 17:30:27 +0000
Date:   Sun, 5 Dec 2021 17:35:35 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] iio: trigger: Fix a scheduling whilst atomic issue
 seen on tsc2046
Message-ID: <20211205173517.59d6d913@jic23-huawei>
In-Reply-To: <20211124084822.GA18112@pengutronix.de>
References: <20211017172209.112387-1-jic23@kernel.org>
        <20211124084822.GA18112@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 24 Nov 2021 09:48:22 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Sun, Oct 17, 2021 at 06:22:09PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > IIO triggers are software IRQ chips that split an incoming IRQ into
> > separate IRQs routed to all devices using the trigger.
> > When all consumers are done then a trigger callback reenable() is
> > called.  There are a few circumstances under which this can happen
> > in atomic context.
> > 
> > 1) A single user of the trigger that calls the iio_trigger_done()
> > function from interrupt context.
> > 2) A race between disconnecting the last device from a trigger and
> > the trigger itself sucessfully being disabled.
> > 
> > To avoid a resulting scheduling whilst atomic, close this corner
> > by using schedule_work() to ensure the reenable is not done in atomic
> > context.
> > 
> > Note that drivers must be careful to manage the interaction of
> > set_state() and reenable() callbacks to ensure appropriate reference
> > counting if they are relying on the same hardware controls.
> > 
> > Completely untested beyond building. Given it is Sunday evening
> > very high chance of it being entirely wrong.  The potential race
> > conditions around this were giving me a headache, but I think this
> > is at least a step in the right direction and should work for Oleksij's
> > case.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>  
> 
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Works for me... Thank you! :)

This patch is in the category that make me nervous, so I'm 
not going to rush it in as a fix.  I've queued it up for the next
merge window (and marked it for Stable).  Hopefully any issues will
shake out before it hits a release kernel.

Applied to the togreg branch of iio.git and pushed out as testing.

Oleksij, what do you want to do about the work around you had?
If you think it is a good cleanup, please resend so we get it to the
top of people's inboxes!

Thanks,

Jonathan
> 
> 
> > ---
> >  drivers/iio/industrialio-trigger.c | 36 +++++++++++++++++++++++++++++-
> >  include/linux/iio/trigger.h        |  2 ++
> >  2 files changed, 37 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> > index b23caa2f2aa1..d3bdc9800b4a 100644
> > --- a/drivers/iio/industrialio-trigger.c
> > +++ b/drivers/iio/industrialio-trigger.c
> > @@ -162,6 +162,39 @@ static struct iio_trigger *iio_trigger_acquire_by_name(const char *name)
> >  	return trig;
> >  }
> >  
> > +static void iio_reenable_work_fn(struct work_struct *work)
> > +{
> > +	struct iio_trigger *trig = container_of(work, struct iio_trigger,
> > +						reenable_work);
> > +
> > +	/*
> > +	 * This 'might' occur after the trigger state is set to disabled -
> > +	 * in that case the driver should skip reenabling.
> > +	 */
> > +	trig->ops->reenable(trig);
> > +}
> > +
> > +/*
> > + * In general, reenable callbacks may need to sleep and this path is
> > + * not performance sensitive, so just queue up a work item
> > + * to reneable the trigger for us.
> > + *
> > + * Races that can cause this.
> > + * 1) A handler occurs entirely in interrupt context so the counter
> > + *    the final decrement is still in this interrupt.
> > + * 2) The trigger has been removed, but one last interrupt gets through.
> > + *
> > + * For (1) we must call reenable, but not in atomic context.
> > + * For (2) it should be safe to call reenanble, if drivers never blindly
> > + * reenable after state is off.
> > + */
> > +static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
> > +{
> > +	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
> > +	    trig->ops->reenable)
> > +		schedule_work(&trig->reenable_work);
> > +}
> > +
> >  void iio_trigger_poll(struct iio_trigger *trig)
> >  {
> >  	int i;
> > @@ -173,7 +206,7 @@ void iio_trigger_poll(struct iio_trigger *trig)
> >  			if (trig->subirqs[i].enabled)
> >  				generic_handle_irq(trig->subirq_base + i);
> >  			else
> > -				iio_trigger_notify_done(trig);
> > +				iio_trigger_notify_done_atomic(trig);
> >  		}
> >  	}
> >  }
> > @@ -535,6 +568,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
> >  	trig->dev.type = &iio_trig_type;
> >  	trig->dev.bus = &iio_bus_type;
> >  	device_initialize(&trig->dev);
> > +	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
> >  
> >  	mutex_init(&trig->pool_lock);
> >  	trig->subirq_base = irq_alloc_descs(-1, 0,
> > diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> > index 096f68dd2e0c..4c69b144677b 100644
> > --- a/include/linux/iio/trigger.h
> > +++ b/include/linux/iio/trigger.h
> > @@ -55,6 +55,7 @@ struct iio_trigger_ops {
> >   * @attached_own_device:[INTERN] if we are using our own device as trigger,
> >   *			i.e. if we registered a poll function to the same
> >   *			device as the one providing the trigger.
> > + * @reenable_work:	[INTERN] work item used to ensure reenable can sleep.
> >   **/
> >  struct iio_trigger {
> >  	const struct iio_trigger_ops	*ops;
> > @@ -74,6 +75,7 @@ struct iio_trigger {
> >  	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
> >  	struct mutex			pool_lock;
> >  	bool				attached_own_device;
> > +	struct work_struct		reenable_work;
> >  };
> >  
> >  
> > -- 
> > 2.33.1
> > 
> >   
> 

