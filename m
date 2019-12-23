Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC421295B9
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 12:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLWL44 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 06:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfLWL4z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 06:56:55 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081C020709;
        Mon, 23 Dec 2019 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577102214;
        bh=jpS7g6XKcLH+XA191NLD5+ImL4nM3B63HJNx6kl3e6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AG+dGJYKhEBHBPKWF9sMpETKQz/d8H6c07QI0BWZhbHFW02LFzHCen5Yn89d1h9TP
         ArSOpdbyn+S1ILRonYPwx89nSKD2J7BSADaVtKYyBnY8wWqvz96gxHXqiMlYCT8+Kw
         o0Hy8Dt9iM8mjaPqG/ceU6wOELDZJF0ZudK0IylQ=
Date:   Mon, 23 Dec 2019 11:56:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 01/10] iio: adc: at91-sama5d2_adc: update for other
 trigger usage
Message-ID: <20191223115648.7deec1a3@archlinux>
In-Reply-To: <1576686157-11939-2-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
        <1576686157-11939-2-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Dec 2019 16:23:58 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> This change will allow the at91-sama5d2_adc driver to use other triggers
> than it's own.
> In particular, tested with the sysfs trigger.
> To be able to achieve this functionality, some changes were required:
> 1) Do not enable/disable channels when enabling/disabling the trigger.
> This is because the trigger is enabled/disabled only for our trigger
> (obviously). We need channels enabled/disabled regardless of what trigger is
> being used.
> 2) Cope with DMA : DMA cannot be used when using another type of trigger.
> Other triggers work through pollfunc, so we get polled anyway on every trigger.
> Thus we have to obtain data at every trigger.
> 3) When to start conversion? The usual pollfunc (store time from subsystem)
> is replaced with specific at91 code, that will start the software conversion
> on the poll action(if it's not our trigger).

This one runs into a 'interesting' corner of IIO.  For the early software
triggers we eventually used irq_work magic to make a top half happen.  Later
we wondered what the point was given the complex dance needed to make a top half
interrupt happen safely.  Hence the iio_loop driver for example and a few others
call the interrupt thread functions directly and never call anything in irq
context.  It's a corner I've been meaning to look at cleaning up for a long
time, but for now it may give you some odd results.  The safest option
is to trigger the read from the thread rather than the irq context.  The disadvantage
is that if you use a trigger with a hardware irq involved, you will
start the capture later than ideal.

> 4) When is the conversion done ? Usually it should be done at EOC (end of
> channel) interrupt. But we start the conversion in pollfunc. So, in the handler
> for this pollfunc, check if data is ready. If not ready, cannot busywait, so,
> start the workq to get the data later.

I don't think this is quite what the code is doing.  You trigger the capture
in the pollfunc top half which is in irq context and can't sleep, but you
schedule the work queue from the associated interrupt thread, which can.
I think you can sleep there.   Note I'm also unsure how you know the workqueue
itself happens after the data is available.  It could in theory happen very
quickly if there is not much else going on in the system.

> 5) Buffer config: we need to setup buffer regardless of our own device's
> trigger. We may get one attached later.
> 6) IRQ handling: we use our own device IRQ only if it's our own trigger
> and we do not use DMA . If we use DMA, we use the DMA controller's IRQ.
> 7) Touchscreen workq: the workq is now also used with other triggers. So, move
> this from the touchscreen state struct to the at91_adc_state.
> 8) Timestamp: the timestamp is kept in the pollfunc. However if in the handler
> we start a workq, the timestamp is no longer accessible. Copy it to our state
> struct.

I'm not sure you actually use that stashed timestamp in all the paths.
Approach is fine though!

A few more specific comments inline.

Also, please don't put parameter renames in the same patch as a function change.
Just makes it harder to review.  If you need them to make new code cleaner,
then do it as a precursor patch in the series.

Thanks,

Jonathan

> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 212 ++++++++++++++++++++++---------------
>  1 file changed, 127 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index e1850f3..c575970 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -378,7 +378,6 @@ struct at91_adc_touch {
>  	bool				touching;
>  	u16				x_pos;
>  	unsigned long			channels_bitmask;
> -	struct work_struct		workq;
>  };
>  
>  struct at91_adc_state {
> @@ -405,6 +404,8 @@ struct at91_adc_state {
>  	 * sysfs.
>  	 */
>  	struct mutex			lock;
> +	struct work_struct		workq;
> +	s64				timestamp;
>  };
>  
>  static const struct at91_adc_trigger at91_adc_trigger_list[] = {
> @@ -710,7 +711,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
>  	struct at91_adc_state *st = iio_priv(indio);
>  	u32 status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
> -	u8 bit;
>  
>  	/* clear TRGMOD */
>  	status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
> @@ -721,35 +721,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  	/* set/unset hw trigger */
>  	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
>  
> -	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
> -		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
> -
> -		if (!chan)
> -			continue;
> -		/* these channel types cannot be handled by this trigger */
> -		if (chan->type == IIO_POSITIONRELATIVE ||
> -		    chan->type == IIO_PRESSURE)
> -			continue;
> -
> -		if (state) {
> -			at91_adc_writel(st, AT91_SAMA5D2_CHER,
> -					BIT(chan->channel));
> -			/* enable irq only if not using DMA */
> -			if (!st->dma_st.dma_chan) {
> -				at91_adc_writel(st, AT91_SAMA5D2_IER,
> -						BIT(chan->channel));
> -			}
> -		} else {
> -			/* disable irq only if not using DMA */
> -			if (!st->dma_st.dma_chan) {
> -				at91_adc_writel(st, AT91_SAMA5D2_IDR,
> -						BIT(chan->channel));
> -			}
> -			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
> -					BIT(chan->channel));
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> @@ -873,69 +844,90 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
> +#define AT91_ADC_BUFFER_CHECK_USE_IRQ(use_irq)  { \

I'd rather see this as a function with clarity on parameters used etc.

> +	use_irq = true; \
> +	/* if using DMA, we do not use our own IRQ (we use DMA-controller) */ \
> +	if (st->dma_st.dma_chan) \
> +		use_irq = false; \
> +	/* if the trigger is not ours, then it has its own IRQ */ \
> +	if (iio_trigger_validate_own_device(indio->trig, indio)) \
> +		use_irq = false; \
> +	}
> +
> +static int at91_adc_buffer_postenable(struct iio_dev *indio)
>  {
>  	int ret;
> -	struct at91_adc_state *st = iio_priv(indio_dev);
> +	u8 bit;
> +	bool use_irq;
> +	struct at91_adc_state *st = iio_priv(indio);
>  
>  	/* check if we are enabling triggered buffer or the touchscreen */
> -	if (bitmap_subset(indio_dev->active_scan_mask,
> +	if (bitmap_subset(indio->active_scan_mask,
>  			  &st->touch_st.channels_bitmask,
>  			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
>  		/* touchscreen enabling */
>  		return at91_adc_configure_touch(st, true);
>  	}
>  	/* if we are not in triggered mode, we cannot enable the buffer. */
> -	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> +	if (!(indio->currentmode & INDIO_ALL_TRIGGERED_MODES))
>  		return -EINVAL;
>  
>  	/* we continue with the triggered buffer */
> -	ret = at91_adc_dma_start(indio_dev);
> +	ret = at91_adc_dma_start(indio);
>  	if (ret) {
> -		dev_err(&indio_dev->dev, "buffer postenable failed\n");
> +		dev_err(&indio->dev, "buffer postenable failed\n");
> +		iio_triggered_buffer_predisable(indio);
>  		return ret;
>  	}
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	AT91_ADC_BUFFER_CHECK_USE_IRQ(use_irq);
> +
> +	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
> +		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
> +
> +		if (!chan)
> +			continue;
> +		/* these channel types cannot be handled by this trigger */
> +		if (chan->type == IIO_POSITIONRELATIVE ||
> +		    chan->type == IIO_PRESSURE)
> +			continue;
> +
> +		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
> +		if (use_irq) {
> +			at91_adc_writel(st, AT91_SAMA5D2_IER,
> +					BIT(chan->channel));
> +		}
> +	}
> +	return iio_triggered_buffer_postenable(indio);
>  }
>  
> -static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
> +static int at91_adc_buffer_predisable(struct iio_dev *indio)

Rename shouldn't be on a patch doing other stuff. Just adds noise.

>  {
> -	struct at91_adc_state *st = iio_priv(indio_dev);
> +	struct at91_adc_state *st = iio_priv(indio);
>  	int ret;
>  	u8 bit;
> +	bool use_irq;
>  
>  	/* check if we are disabling triggered buffer or the touchscreen */
> -	if (bitmap_subset(indio_dev->active_scan_mask,
> +	if (bitmap_subset(indio->active_scan_mask,
>  			  &st->touch_st.channels_bitmask,
>  			  AT91_SAMA5D2_MAX_CHAN_IDX + 1)) {
>  		/* touchscreen disable */
>  		return at91_adc_configure_touch(st, false);
>  	}
>  	/* if we are not in triggered mode, nothing to do here */
> -	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
> +	if (!(indio->currentmode & INDIO_ALL_TRIGGERED_MODES))
>  		return -EINVAL;
>  
> -	/* continue with the triggered buffer */
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		dev_err(&indio_dev->dev, "buffer predisable failed\n");
> -
> -	if (!st->dma_st.dma_chan)
> -		return ret;
> -
> -	/* if we are using DMA we must clear registers and end DMA */
> -	dmaengine_terminate_sync(st->dma_st.dma_chan);
> -
> +	AT91_ADC_BUFFER_CHECK_USE_IRQ(use_irq);
>  	/*
> -	 * For each enabled channel we must read the last converted value
> +	 * For each enable channel we must disable it in hardware.
> +	 * In the case of DMA, we must read the last converted value
>  	 * to clear EOC status and not get a possible interrupt later.
> -	 * This value is being read by DMA from LCDR anyway
> +	 * This value is being read by DMA from LCDR anyway, so it's not lost.
>  	 */
> -	for_each_set_bit(bit, indio_dev->active_scan_mask,
> -			 indio_dev->num_channels) {
> -		struct iio_chan_spec const *chan =
> -					at91_adc_chan_get(indio_dev, bit);
> +	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
> +		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
>  
>  		if (!chan)
>  			continue;
> @@ -943,12 +935,29 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
>  		if (chan->type == IIO_POSITIONRELATIVE ||
>  		    chan->type == IIO_PRESSURE)
>  			continue;
> +
> +		if (use_irq) {
> +			at91_adc_writel(st, AT91_SAMA5D2_IDR,
> +					BIT(chan->channel));
> +		}
> +		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
> +
>  		if (st->dma_st.dma_chan)
>  			at91_adc_readl(st, chan->address);
>  	}
>  
>  	/* read overflow register to clear possible overflow status */
>  	at91_adc_readl(st, AT91_SAMA5D2_OVER);
> +
> +	/* continue with the triggered buffer */
> +	ret = iio_triggered_buffer_predisable(indio);
> +	if (ret < 0)
> +		dev_err(&indio->dev, "buffer predisable failed\n");
> +
> +	/* if we are using DMA we must clear registers and end DMA */
> +	if (st->dma_st.dma_chan)
> +		dmaengine_terminate_sync(st->dma_st.dma_chan);
> +
>  	return ret;
>  }
>  
> @@ -993,8 +1002,8 @@ static int at91_adc_trigger_init(struct iio_dev *indio)
>  	return 0;
>  }
>  
> -static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
> -					   struct iio_poll_func *pf)
> +static void at91_adc_read_and_push_channels(struct iio_dev *indio_dev,
> +					    s64 timestamp)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  	int i = 0;
> @@ -1028,11 +1037,30 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
>  		}
>  		i++;
>  	}
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer, timestamp);
> +}
> +
> +static int at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
> +					  struct iio_poll_func *pf)
> +{
> +	struct at91_adc_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * Check if the conversion is ready. If not, schedule a work to
> +	 * check again later.
> +	 */
> +	if (!(at91_adc_readl(st, AT91_SAMA5D2_ISR) & GENMASK(11, 0))) {

I'm wondering if we are making this harder to follow than it needs to be.
Two cases:

1) Trigger is our hardware one and data should be ready now as we used the EOC
   interrupt to get here. - By all means check that but it's probably an error
   if that condition fails.
2) Trigger is not our hardware and we have only just issued the conversion request.
   Data might be ready or not.

So this particular function is running as an interrupt thread and we push the
handling off to a work queue that will happen later.   Why should the data
be ready by the time that workqueue happens?

Also as this is an interrupt thread (I think,it's been a while since much
of interest happened around these ;), we can sleep in here just fine.
We shouldn't be calling trigger_notify_done until we are sure a race can't
occur with a future trigger anyway (which it probably can if we don't wait
for the data).


> +		schedule_work(&st->workq);
> +		return -EINPROGRESS;
> +	}
> +
> +	/* we have data, so let's extract and push it */
> +	at91_adc_read_and_push_channels(indio_dev, pf->timestamp);
> +
> +	return 0;
>  }
>  
> -static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
> +static int at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  	int transferred_len = at91_adc_dma_size_done(st);
> @@ -1079,6 +1107,8 @@ static void at91_adc_trigger_handler_dma(struct iio_dev *indio_dev)
>  	}
>  	/* adjust saved time for next transfer handling */
>  	st->dma_st.dma_ts = iio_get_time_ns(indio_dev);
> +
> +	return 0;
>  }
>  
>  static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
> @@ -1086,33 +1116,41 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> +	int ret;
>  
> +	st->timestamp = pf->timestamp;
>  	if (st->dma_st.dma_chan)
> -		at91_adc_trigger_handler_dma(indio_dev);
> +		ret = at91_adc_trigger_handler_dma(indio_dev);
>  	else
> -		at91_adc_trigger_handler_nodma(indio_dev, pf);
> +		ret = at91_adc_trigger_handler_nodma(indio_dev, pf);
>  
> -	iio_trigger_notify_done(indio_dev->trig);
> +	if (!ret)

I'd like a comment here on what 'ret' actually is telling us
(I assume that all handling wrt to the trigger is done and we can
have another one).

Actually with a slight tweak the code can become 'obvious'
and it'll make the flow clearer. (obvious to me anyway ;)

	if (st->dma_st.dma_chan) {
		at91_adc_trigger_handler_dma(indio_dev)
		iio_trigger_notify_done(indio_dev->trig);
	} else {
		ret = at91_adc_trigger_handler_nodma(indio_dev);
		if (ret != -EINPROGRESS)
			iio_trigger_notify_done(indio_dev->trig);
	}

> +		iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
>  }
>  
> -static int at91_adc_buffer_init(struct iio_dev *indio)
> +irqreturn_t at91_adc_pollfunc(int irq, void *p)
>  {
> -	struct at91_adc_state *st = iio_priv(indio);
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> -	if (st->selected_trig->hw_trig) {
> -		return devm_iio_triggered_buffer_setup(&indio->dev, indio,
> -			&iio_pollfunc_store_time,
> -			&at91_adc_trigger_handler, &at91_buffer_setup_ops);
> -	}
>  	/*
> -	 * we need to prepare the buffer ops in case we will get
> -	 * another buffer attached (like a callback buffer for the touchscreen)
> +	 * If it's not our trigger, start a conversion now, as we are
> +	 * actually polling the trigger now.
>  	 */
> -	indio->setup_ops = &at91_buffer_setup_ops;
> +	if (iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> +		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
>  
> -	return 0;
> +	return iio_pollfunc_store_time(irq, p);
> +}
> +
> +static int at91_adc_buffer_init(struct iio_dev *indio)
> +{
> +	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
> +		&at91_adc_pollfunc,
> +		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
>  }
>  
>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
> @@ -1195,7 +1233,7 @@ static void at91_adc_touch_data_handler(struct iio_dev *indio_dev)
>  	 * from our IRQ context. Which is something we better avoid.
>  	 * Let's schedule it after our IRQ is completed.
>  	 */
> -	schedule_work(&st->touch_st.workq);
> +	schedule_work(&st->workq);
>  }
>  
>  static void at91_adc_pen_detect_interrupt(struct at91_adc_state *st)
> @@ -1228,13 +1266,17 @@ static void at91_adc_no_pen_detect_interrupt(struct at91_adc_state *st)
>  
>  static void at91_adc_workq_handler(struct work_struct *workq)
>  {
> -	struct at91_adc_touch *touch_st = container_of(workq,
> -					struct at91_adc_touch, workq);
> -	struct at91_adc_state *st = container_of(touch_st,
> -					struct at91_adc_state, touch_st);
> +	struct at91_adc_state *st = container_of(workq,
> +					struct at91_adc_state, workq);
>  	struct iio_dev *indio_dev = iio_priv_to_dev(st);
>  
> -	iio_push_to_buffers(indio_dev, st->buffer);
> +	if ((indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES) &&
> +	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev)) {
Let me just check my understanding of these two conditions.

First one verifies we are doing triggered ADC capture, rather than touch screen
magic.

The second verifies that it's our own trigger rather than a different one...
> +		at91_adc_read_and_push_channels(indio_dev, st->timestamp);
> +		iio_trigger_notify_done(indio_dev->trig);
> +	} else {

So we can get here either because this is really touch screen stuff and
the triggering is effectively opaque to IIO, or because we have for example
a sysfs or high res timer type trigger.

If it's a sysfs type trigger why no timestamp?
I'm also surprised that path doesn't call iio_trigger_notify done.  We don't
want to allow that trigger to fire again until the capture is finished
and that includes pushing to the buffer.  Otherwise fun race conditions
can occur.


> +		iio_push_to_buffers(indio_dev, st->buffer);
> +	}
>  }
>  
>  static irqreturn_t at91_adc_interrupt(int irq, void *private)
> @@ -1711,7 +1753,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	init_waitqueue_head(&st->wq_data_available);
>  	mutex_init(&st->lock);
> -	INIT_WORK(&st->touch_st.workq, at91_adc_workq_handler);
> +	INIT_WORK(&st->workq, at91_adc_workq_handler);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)

