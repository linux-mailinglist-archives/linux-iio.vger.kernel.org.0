Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D0614101E
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2020 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgAQRmy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 12:42:54 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729674AbgAQRmw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jan 2020 12:42:52 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 682291981C328265B92A;
        Fri, 17 Jan 2020 17:42:51 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 Jan 2020 17:42:50 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 17 Jan
 2020 17:42:50 +0000
Date:   Fri, 17 Jan 2020 17:42:49 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v2 3/3] iio: adc: at91-sama5d2_adc: update for other
 trigger usage
Message-ID: <20200117174249.000011af@Huawei.com>
In-Reply-To: <1578917098-9674-4-git-send-email-eugen.hristev@microchip.com>
References: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
        <1578917098-9674-4-git-send-email-eugen.hristev@microchip.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Jan 2020 12:07:10 +0000
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
> would be in hard irq and this would be a good way, but current iio subsystem
> recommends to have it in the threaded irq. Thus adding software start
> code in this handler.
> 4) Buffer config: we need to setup buffer regardless of our own device's
> trigger. We may get one attached later.
> 5) IRQ handling: we use our own device IRQ only if it's our own trigger
> and we do not use DMA . If we use DMA, we use the DMA controller's IRQ.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

+CC Alexandru as he's doing a lot of cleanup around the buffer functions.
I'd like Alex to take a look at this.

A few comments inline from me.

Thanks,

Jonathan



> ---
> Changes in v2:
> - adapt to the situation of having the previous two patches ahead in the series
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 140 +++++++++++++++++++------------------
>  1 file changed, 73 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 454a493..34df043 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -728,7 +728,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  	struct iio_dev *indio = iio_trigger_get_drvdata(trig);
>  	struct at91_adc_state *st = iio_priv(indio);
>  	u32 status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
> -	u8 bit;
>  
>  	/* clear TRGMOD */
>  	status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
> @@ -739,45 +738,6 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  	/* set/unset hw trigger */
>  	at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
>  
> -	for_each_set_bit(bit, indio->active_scan_mask, indio->num_channels) {
> -		struct iio_chan_spec const *chan = at91_adc_chan_get(indio, bit);
> -		u32 cor;
> -
> -		if (!chan)
> -			continue;
> -		/* these channel types cannot be handled by this trigger */
> -		if (chan->type == IIO_POSITIONRELATIVE ||
> -		    chan->type == IIO_PRESSURE)
> -			continue;
> -
> -		if (state) {
> -			cor = at91_adc_readl(st, AT91_SAMA5D2_COR);
> -
> -			if (chan->differential)
> -				cor |= (BIT(chan->channel) |
> -					BIT(chan->channel2)) <<
> -					AT91_SAMA5D2_COR_DIFF_OFFSET;
> -			else
> -				cor &= ~(BIT(chan->channel) <<
> -				       AT91_SAMA5D2_COR_DIFF_OFFSET);
> -
> -			at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
> -		}
> -
> -		if (state)
> -			at91_adc_writel(st, AT91_SAMA5D2_CHER,
> -					BIT(chan->channel));
> -		else
> -			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
> -					BIT(chan->channel));
> -	}
> -	/* enable irq only if not using DMA */
> -	if (state && !st->dma_st.dma_chan)
> -		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
> -	/* disable irq only if not using DMA */
> -	if (!state && !st->dma_st.dma_chan)
> -		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
> -
>  	return 0;
>  }
>  
> @@ -901,9 +861,22 @@ static int at91_adc_dma_start(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static bool at91_adc_buffer_check_use_irq(struct iio_dev *indio,
> +					  struct at91_adc_state *st)
> +{
> +	/* if using DMA, we do not use our own IRQ (we use DMA-controller) */
> +	if (st->dma_st.dma_chan)
> +		return false;
> +	/* if the trigger is not ours, then it has its own IRQ */
> +	if (iio_trigger_validate_own_device(indio->trig, indio))
> +		return false;
> +	return true;
> +}
> +
>  static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	int ret;
> +	u8 bit;
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
>  	/* check if we are enabling triggered buffer or the touchscreen */
> @@ -921,9 +894,40 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = at91_adc_dma_start(indio_dev);
>  	if (ret) {
>  		dev_err(&indio_dev->dev, "buffer postenable failed\n");
> +		iio_triggered_buffer_predisable(indio_dev);

This seems odd given you have called the iio_triggered_buffer_postenable yet..
That is below.

>  		return ret;
>  	}
>  
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->num_channels) {
> +		struct iio_chan_spec const *chan =
> +					at91_adc_chan_get(indio_dev, bit);
> +		u32 cor;
> +
> +		if (!chan)
> +			continue;
> +		/* these channel types cannot be handled by this trigger */
> +		if (chan->type == IIO_POSITIONRELATIVE ||
> +		    chan->type == IIO_PRESSURE)
> +			continue;
> +
> +		cor = at91_adc_readl(st, AT91_SAMA5D2_COR);
> +
> +		if (chan->differential)
> +			cor |= (BIT(chan->channel) | BIT(chan->channel2)) <<
> +				AT91_SAMA5D2_COR_DIFF_OFFSET;
> +		else
> +			cor &= ~(BIT(chan->channel) <<
> +			       AT91_SAMA5D2_COR_DIFF_OFFSET);
> +
> +		at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
> +
> +		at91_adc_writel(st, AT91_SAMA5D2_CHER, BIT(chan->channel));
> +	}
> +
> +	if (at91_adc_buffer_check_use_irq(indio_dev, st))
> +		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
> +
>  	return iio_triggered_buffer_postenable(indio_dev);
>  }
>  
> @@ -944,21 +948,11 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
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
>  	/*
> -	 * For each enabled channel we must read the last converted value
> +	 * For each enable channel we must disable it in hardware.
> +	 * In the case of DMA, we must read the last converted value
>  	 * to clear EOC status and not get a possible interrupt later.
> -	 * This value is being read by DMA from LCDR anyway
> +	 * This value is being read by DMA from LCDR anyway, so it's not lost.
>  	 */
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
>  			 indio_dev->num_channels) {
> @@ -971,12 +965,28 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
>  		if (chan->type == IIO_POSITIONRELATIVE ||
>  		    chan->type == IIO_PRESSURE)
>  			continue;
> +
> +		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
> +
>  		if (st->dma_st.dma_chan)
>  			at91_adc_readl(st, chan->address);
>  	}
>  
> +	if (at91_adc_buffer_check_use_irq(indio_dev, st))
> +		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
> +
>  	/* read overflow register to clear possible overflow status */
>  	at91_adc_readl(st, AT91_SAMA5D2_OVER);
> +
> +	/* continue with the triggered buffer */
> +	ret = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret < 0)
> +		dev_err(&indio_dev->dev, "buffer predisable failed\n");
> +
> +	/* if we are using DMA we must clear registers and end DMA */
> +	if (st->dma_st.dma_chan)
> +		dmaengine_terminate_sync(st->dma_st.dma_chan);

This ordering is going to stop Alex doing his rework to remove the need
to manually call iio_triggered_buffer_predisable.  Why does it make
sense to do the dma stuff after that?

Ah I see it always did and the postenable is the opposite of what Alex
has been moving to as well.

> +
>  	return ret;
>  }
>  
> @@ -1131,6 +1141,13 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	/*
> +	 * If it's not our trigger, start a conversion now, as we are
> +	 * actually polling the trigger now.
> +	 */
> +	if (iio_trigger_validate_own_device(indio_dev->trig, indio_dev))
> +		at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_START);
> +
>  	if (st->dma_st.dma_chan)
>  		at91_adc_trigger_handler_dma(indio_dev);
>  	else
> @@ -1143,20 +1160,9 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  
>  static int at91_adc_buffer_init(struct iio_dev *indio)
>  {
> -	struct at91_adc_state *st = iio_priv(indio);
> -
> -	if (st->selected_trig->hw_trig) {
> -		return devm_iio_triggered_buffer_setup(&indio->dev, indio,
> -			&iio_pollfunc_store_time,
> -			&at91_adc_trigger_handler, &at91_buffer_setup_ops);
> -	}
> -	/*
> -	 * we need to prepare the buffer ops in case we will get
> -	 * another buffer attached (like a callback buffer for the touchscreen)
> -	 */
> -	indio->setup_ops = &at91_buffer_setup_ops;
> -
> -	return 0;
> +	return devm_iio_triggered_buffer_setup(&indio->dev, indio,
> +		&iio_pollfunc_store_time,
> +		&at91_adc_trigger_handler, &at91_buffer_setup_ops);
>  }
>  
>  static unsigned at91_adc_startup_time(unsigned startup_time_min,


