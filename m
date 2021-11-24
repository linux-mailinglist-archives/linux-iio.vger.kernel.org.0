Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4D45B6E9
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 09:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhKXIvi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 03:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKXIvh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 03:51:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FE5C061574
        for <linux-iio@vger.kernel.org>; Wed, 24 Nov 2021 00:48:25 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mpnx1-0007u6-9J; Wed, 24 Nov 2021 09:48:23 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mpnx0-0001U9-BE; Wed, 24 Nov 2021 09:48:22 +0100
Date:   Wed, 24 Nov 2021 09:48:22 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH] iio: trigger: Fix a scheduling whilst atomic issue
 seen on tsc2046
Message-ID: <20211124084822.GA18112@pengutronix.de>
References: <20211017172209.112387-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211017172209.112387-1-jic23@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:47:18 up 279 days, 12:11, 141 users,  load average: 0.27, 0.22,
 0.19
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 17, 2021 at 06:22:09PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> IIO triggers are software IRQ chips that split an incoming IRQ into
> separate IRQs routed to all devices using the trigger.
> When all consumers are done then a trigger callback reenable() is
> called.  There are a few circumstances under which this can happen
> in atomic context.
> 
> 1) A single user of the trigger that calls the iio_trigger_done()
> function from interrupt context.
> 2) A race between disconnecting the last device from a trigger and
> the trigger itself sucessfully being disabled.
> 
> To avoid a resulting scheduling whilst atomic, close this corner
> by using schedule_work() to ensure the reenable is not done in atomic
> context.
> 
> Note that drivers must be careful to manage the interaction of
> set_state() and reenable() callbacks to ensure appropriate reference
> counting if they are relying on the same hardware controls.
> 
> Completely untested beyond building. Given it is Sunday evening
> very high chance of it being entirely wrong.  The potential race
> conditions around this were giving me a headache, but I think this
> is at least a step in the right direction and should work for Oleksij's
> case.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

Works for me... Thank you! :)


> ---
>  drivers/iio/industrialio-trigger.c | 36 +++++++++++++++++++++++++++++-
>  include/linux/iio/trigger.h        |  2 ++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index b23caa2f2aa1..d3bdc9800b4a 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -162,6 +162,39 @@ static struct iio_trigger *iio_trigger_acquire_by_name(const char *name)
>  	return trig;
>  }
>  
> +static void iio_reenable_work_fn(struct work_struct *work)
> +{
> +	struct iio_trigger *trig = container_of(work, struct iio_trigger,
> +						reenable_work);
> +
> +	/*
> +	 * This 'might' occur after the trigger state is set to disabled -
> +	 * in that case the driver should skip reenabling.
> +	 */
> +	trig->ops->reenable(trig);
> +}
> +
> +/*
> + * In general, reenable callbacks may need to sleep and this path is
> + * not performance sensitive, so just queue up a work item
> + * to reneable the trigger for us.
> + *
> + * Races that can cause this.
> + * 1) A handler occurs entirely in interrupt context so the counter
> + *    the final decrement is still in this interrupt.
> + * 2) The trigger has been removed, but one last interrupt gets through.
> + *
> + * For (1) we must call reenable, but not in atomic context.
> + * For (2) it should be safe to call reenanble, if drivers never blindly
> + * reenable after state is off.
> + */
> +static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
> +{
> +	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
> +	    trig->ops->reenable)
> +		schedule_work(&trig->reenable_work);
> +}
> +
>  void iio_trigger_poll(struct iio_trigger *trig)
>  {
>  	int i;
> @@ -173,7 +206,7 @@ void iio_trigger_poll(struct iio_trigger *trig)
>  			if (trig->subirqs[i].enabled)
>  				generic_handle_irq(trig->subirq_base + i);
>  			else
> -				iio_trigger_notify_done(trig);
> +				iio_trigger_notify_done_atomic(trig);
>  		}
>  	}
>  }
> @@ -535,6 +568,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
>  	trig->dev.type = &iio_trig_type;
>  	trig->dev.bus = &iio_bus_type;
>  	device_initialize(&trig->dev);
> +	INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);
>  
>  	mutex_init(&trig->pool_lock);
>  	trig->subirq_base = irq_alloc_descs(-1, 0,
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 096f68dd2e0c..4c69b144677b 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -55,6 +55,7 @@ struct iio_trigger_ops {
>   * @attached_own_device:[INTERN] if we are using our own device as trigger,
>   *			i.e. if we registered a poll function to the same
>   *			device as the one providing the trigger.
> + * @reenable_work:	[INTERN] work item used to ensure reenable can sleep.
>   **/
>  struct iio_trigger {
>  	const struct iio_trigger_ops	*ops;
> @@ -74,6 +75,7 @@ struct iio_trigger {
>  	unsigned long pool[BITS_TO_LONGS(CONFIG_IIO_CONSUMERS_PER_TRIGGER)];
>  	struct mutex			pool_lock;
>  	bool				attached_own_device;
> +	struct work_struct		reenable_work;
>  };
>  
>  
> -- 
> 2.33.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
