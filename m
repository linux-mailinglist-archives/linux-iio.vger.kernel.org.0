Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56003BAE1F
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhGDR50 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhGDR50 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 13:57:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C626E613C8;
        Sun,  4 Jul 2021 17:54:46 +0000 (UTC)
Date:   Sun, 4 Jul 2021 18:57:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: tsc2046: fix sleeping in atomic
 context warning and a deadlock after iio_trigger_poll() call
Message-ID: <20210704185710.07789b8f@jic23-huawei>
In-Reply-To: <20210625065922.8310-2-o.rempel@pengutronix.de>
References: <20210625065922.8310-1-o.rempel@pengutronix.de>
        <20210625065922.8310-2-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Jun 2021 08:59:22 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> If iio_trigger_poll() is called after IRQ was disabled, we will call
> reenable_trigger() directly from hard IRQ or hrtimer context instead of
> IRQ thread. In this case we will run in to multiple issue as sleeping in atomic
> context and a deadlock.

Hmm. This sounds like a problem that might bite us in other circumstances.

So do I have the basic issue right in thinking we have a race between
calling iio_trigger_poll() and having no devices still using that trigger?
Thus we end up with all of trig->subirqs not being enabled.

There was a previous discussion that the calls to iio_trigger_notify_done() in
iio_trigger_poll() are only meant to decrement the counter, as the assumption
was that the calls via threads would always happen later.  Unfortunately this
is all clearly a little bit racy and I suspect not many of the reenable() callbacks
are safe if they are called in interrupt context.

Perhaps an alternative would be to schedule the reenable() if we hit it from
that path thus ensuring it doesn't happen in a place where we can't sleep?

Would something like that solve your problem?
I'd do it by having a new function

iio_trigger_notify_done_schedule() that uses a work struct to call
trig->ops->reenable(trig) from a context that can sleep.

It's a rare corner case so I don't really care that in theory we might have
a device that was safe to reenable the trigger without sleeping.  That makes
it easier to just have one path for this which allows sleeping.

Jonathan

> 
> To avoid this issue, rework the trigger to use state machine. All state
> changes are done over the hrtimer, so it allows us to drop fsleep() and
> avoid the deadlock.
> 
> Fixes: 9374e8f5a38d ("iio: adc: add ADC driver for the TI TSC2046 controller")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/iio/adc/ti-tsc2046.c | 102 ++++++++++++++++++++---------------
>  1 file changed, 58 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index d84ae6b008c1..91f6bd5effe7 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -123,14 +123,21 @@ struct tsc2046_adc_ch_cfg {
>  	unsigned int oversampling_ratio;
>  };
>  
> +enum tsc2046_state {
> +	TSC2046_STATE_STANDBY,
> +	TSC2046_STATE_ENABLE_IRQ_POLL,
> +	TSC2046_STATE_POLL,
> +	TSC2046_STATE_ENABLE_IRQ,
> +};
> +
>  struct tsc2046_adc_priv {
>  	struct spi_device *spi;
>  	const struct tsc2046_adc_dcfg *dcfg;
>  
>  	struct iio_trigger *trig;
>  	struct hrtimer trig_timer;
> -	spinlock_t trig_lock;
> -	unsigned int trig_more_count;
> +	enum tsc2046_state state;
> +	spinlock_t state_lock;
>  
>  	struct spi_transfer xfer;
>  	struct spi_message msg;
> @@ -411,21 +418,47 @@ static const struct iio_info tsc2046_adc_info = {
>  	.update_scan_mode = tsc2046_adc_update_scan_mode,
>  };
>  
> -static enum hrtimer_restart tsc2046_adc_trig_more(struct hrtimer *hrtimer)
> +static enum hrtimer_restart tsc2046_adc_timer(struct hrtimer *hrtimer)
>  {
>  	struct tsc2046_adc_priv *priv = container_of(hrtimer,
>  						     struct tsc2046_adc_priv,
>  						     trig_timer);
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&priv->trig_lock, flags);
> -
> -	disable_irq_nosync(priv->spi->irq);
> -
> -	priv->trig_more_count++;
> -	iio_trigger_poll(priv->trig);
> -
> -	spin_unlock_irqrestore(&priv->trig_lock, flags);
> +	spin_lock_irqsave(&priv->state_lock, flags);
> +	switch (priv->state) {
> +	case TSC2046_STATE_ENABLE_IRQ_POLL:
> +		/*
> +		 * IRQ handler called iio_trigger_poll() to sample ADC.
> +		 * Here we
> +		 * - re-enable IRQs
> +		 * - start hrtimer for timeout if no IRQ will occur
> +		 */
> +		priv->state = TSC2046_STATE_POLL;
> +		enable_irq(priv->spi->irq);
> +		hrtimer_start(&priv->trig_timer,
> +			      ns_to_ktime(priv->scan_interval_us *
> +					  NSEC_PER_USEC),
> +			      HRTIMER_MODE_REL_SOFT);
> +		break;
> +	case TSC2046_STATE_POLL:
> +		disable_irq_nosync(priv->spi->irq);
> +		priv->state = TSC2046_STATE_ENABLE_IRQ;
> +		/* iio_trigger_poll() starts hrtimer */
> +		iio_trigger_poll(priv->trig);
> +		break;
> +	case TSC2046_STATE_ENABLE_IRQ:
> +		priv->state = TSC2046_STATE_STANDBY;
> +		enable_irq(priv->spi->irq);
> +		break;
> +	case TSC2046_STATE_STANDBY:
> +		fallthrough;
> +	default:
> +		dev_warn(&priv->spi->dev, "Got unexpected state: %i\n",
> +			 priv->state);
> +		break;
> +	}
> +	spin_unlock_irqrestore(&priv->state_lock, flags);
>  
>  	return HRTIMER_NORESTART;
>  }
> @@ -434,16 +467,17 @@ static irqreturn_t tsc2046_adc_irq(int irq, void *dev_id)
>  {
>  	struct iio_dev *indio_dev = dev_id;
>  	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> -
> -	spin_lock(&priv->trig_lock);
> +	unsigned long flags;
>  
>  	hrtimer_try_to_cancel(&priv->trig_timer);
>  
> -	priv->trig_more_count = 0;
> +	spin_lock_irqsave(&priv->state_lock, flags);
>  	disable_irq_nosync(priv->spi->irq);
> -	iio_trigger_poll(priv->trig);
> +	priv->state = TSC2046_STATE_ENABLE_IRQ_POLL;
>  
> -	spin_unlock(&priv->trig_lock);
> +	/* iio_trigger_poll() starts hrtimer */
> +	iio_trigger_poll(priv->trig);
> +	spin_unlock_irqrestore(&priv->state_lock, flags);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -452,37 +486,16 @@ static void tsc2046_adc_reenable_trigger(struct iio_trigger *trig)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> -	unsigned long flags;
> -	int delta;
> +	ktime_t tim;
>  
>  	/*
>  	 * We can sample it as fast as we can, but usually we do not need so
>  	 * many samples. Reduce the sample rate for default (touchscreen) use
>  	 * case.
> -	 * Currently we do not need a highly precise sample rate. It is enough
> -	 * to have calculated numbers.
> -	 */
> -	delta = priv->scan_interval_us - priv->time_per_scan_us;
> -	if (delta > 0)
> -		fsleep(delta);
> -
> -	spin_lock_irqsave(&priv->trig_lock, flags);
> -
> -	/*
> -	 * We need to trigger at least one extra sample to detect state
> -	 * difference on ADC side.
>  	 */
> -	if (!priv->trig_more_count) {
> -		int timeout_ms = DIV_ROUND_UP(priv->scan_interval_us,
> -					      USEC_PER_MSEC);
> -
> -		hrtimer_start(&priv->trig_timer, ms_to_ktime(timeout_ms),
> -			      HRTIMER_MODE_REL_SOFT);
> -	}
> -
> -	enable_irq(priv->spi->irq);
> -
> -	spin_unlock_irqrestore(&priv->trig_lock, flags);
> +	tim = ns_to_ktime((priv->scan_interval_us - priv->time_per_scan_us) *
> +			  NSEC_PER_USEC);
> +	hrtimer_start(&priv->trig_timer, tim, HRTIMER_MODE_REL_SOFT);
>  }
>  
>  static int tsc2046_adc_set_trigger_state(struct iio_trigger *trig, bool enable)
> @@ -493,8 +506,8 @@ static int tsc2046_adc_set_trigger_state(struct iio_trigger *trig, bool enable)
>  	if (enable) {
>  		enable_irq(priv->spi->irq);
>  	} else {
> +		hrtimer_cancel(&priv->trig_timer);
>  		disable_irq(priv->spi->irq);
> -		hrtimer_try_to_cancel(&priv->trig_timer);
>  	}
>  
>  	return 0;
> @@ -668,10 +681,11 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  	iio_trigger_set_drvdata(trig, indio_dev);
>  	trig->ops = &tsc2046_adc_trigger_ops;
>  
> -	spin_lock_init(&priv->trig_lock);
> +	spin_lock_init(&priv->state_lock);
> +	priv->state = TSC2046_STATE_STANDBY;
>  	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
>  		     HRTIMER_MODE_REL_SOFT);
> -	priv->trig_timer.function = tsc2046_adc_trig_more;
> +	priv->trig_timer.function = tsc2046_adc_timer;
>  
>  	ret = devm_iio_trigger_register(dev, trig);
>  	if (ret) {

