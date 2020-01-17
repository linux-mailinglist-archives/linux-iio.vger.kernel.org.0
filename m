Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18AED140FF2
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2020 18:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAQRe3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 12:34:29 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2280 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbgAQRe3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jan 2020 12:34:29 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 41B5894D8F95FE973F68;
        Fri, 17 Jan 2020 17:34:26 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 Jan 2020 17:34:25 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 17 Jan
 2020 17:34:25 +0000
Date:   Fri, 17 Jan 2020 17:34:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <Eugen.Hristev@microchip.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH v2 2/3] iio: adc: at91-sama5d2_adc: handle unfinished
 conversions
Message-ID: <20200117173424.0000244f@Huawei.com>
In-Reply-To: <1578917098-9674-3-git-send-email-eugen.hristev@microchip.com>
References: <1578917098-9674-1-git-send-email-eugen.hristev@microchip.com>
        <1578917098-9674-3-git-send-email-eugen.hristev@microchip.com>
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

On Mon, 13 Jan 2020 12:07:09 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> It can happen that on IRQ trigger, not all conversions are done if
> we are enabling multiple channels.
> The IRQ is triggered on first EOC (end of channel), but it can happen
> that not all channels are done. This leads into erroneous reports to
> userspace (zero values or previous values).
> To solve this, in trigger handler, check if the mask of done channels
> is the same as the mask of active scan channels.
> If it's the same, proceed and push to buffers. Otherwise, use usleep
> to sleep until the conversion is done or we timeout.
> Normally, it should happen that in a short time fashion, all channels are
> ready, since the first IRQ triggered.
> If a hardware fault happens (for example the clock suddently dissappears),
> the handler will not be completed, in which case we do not report anything to
> userspace anymore.
> Also, change from using the EOC interrupts to DRDY interrupt.
> This helps with the fact that not 'n' interrupt statuses are enabled,
> each being able to trigger an interrupt, and instead only data ready
> interrupt can wake up the CPU. Like this, when data is ready, check in
> handler which and how many channels are done. While the DRDY is raised,
> other IRQs cannot occur. Once the channel data is being read, we ack the
> IRQ and finish the conversion.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - move start of conversion to threaded irq, removed specific at91 pollfunc
> - add timeout to channel mask readiness check in trigger handler
> - use DRDY irq instead of EOC irqs.
> - move enable irq after DRDY has been acked in reenable_trigger
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 62 ++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 2a6950a..454a493 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
> @@ -100,6 +101,8 @@
>  #define AT91_SAMA5D2_IER_YRDY   BIT(21)
>  /* Interrupt Enable Register - TS pressure measurement ready */
>  #define AT91_SAMA5D2_IER_PRDY   BIT(22)
> +/* Interrupt Enable Register - Data ready */
> +#define AT91_SAMA5D2_IER_DRDY   BIT(24)
>  /* Interrupt Enable Register - general overrun error */
>  #define AT91_SAMA5D2_IER_GOVRE BIT(25)
>  /* Interrupt Enable Register - Pen detect */
> @@ -486,6 +489,21 @@ static inline int at91_adc_of_xlate(struct iio_dev *indio_dev,
>  	return at91_adc_chan_xlate(indio_dev, iiospec->args[0]);
>  }
>  
> +static unsigned int at91_adc_active_scan_mask_to_reg(struct iio_dev *indio_dev)
> +{
> +	u32 mask = 0;
> +	u8 bit;
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->num_channels) {
> +		struct iio_chan_spec const *chan =
> +			 at91_adc_chan_get(indio_dev, bit);
> +		mask |= BIT(chan->channel);
> +	}
> +
> +	return mask & GENMASK(11, 0);
> +}
> +
>  static void at91_adc_config_emr(struct at91_adc_state *st)
>  {
>  	/* configure the extended mode register */
> @@ -746,24 +764,19 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
>  			at91_adc_writel(st, AT91_SAMA5D2_COR, cor);
>  		}
>  
> -		if (state) {
> +		if (state)
>  			at91_adc_writel(st, AT91_SAMA5D2_CHER,
>  					BIT(chan->channel));
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
> +		else
>  			at91_adc_writel(st, AT91_SAMA5D2_CHDR,
>  					BIT(chan->channel));
> -		}
>  	}
> +	/* enable irq only if not using DMA */
> +	if (state && !st->dma_st.dma_chan)
> +		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
> +	/* disable irq only if not using DMA */
> +	if (!state && !st->dma_st.dma_chan)
> +		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
Hmm. Would have been nicer to avoid the refactor and just have the change to
what was written. If you want to keep it, perhaps:

	/* Nothing to do if using DMA */
	if (!st->dma_st.dma_chan)
		return 0;

	if (state)
		at91...
	else
		at91...

>  
>  	return 0;
>  }
> @@ -777,10 +790,10 @@ static int at91_adc_reenable_trigger(struct iio_trigger *trig)
>  	if (st->dma_st.dma_chan)
>  		return 0;
>  
> -	enable_irq(st->irq);
> -
>  	/* Needed to ACK the DRDY interruption */
>  	at91_adc_readl(st, AT91_SAMA5D2_LCDR);
> +
> +	enable_irq(st->irq);

Why this change?  I'm not totally following the description above.

>  	return 0;
>  }
>  
> @@ -1015,6 +1028,22 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
>  	int i = 0;
>  	int val;
>  	u8 bit;
> +	u32 mask = at91_adc_active_scan_mask_to_reg(indio_dev);
> +	unsigned int timeout = 50;
> +
> +	/*
> +	 * Check if the conversion is ready. If not, wait a little bit, and
> +	 * in case of timeout exit with an error.
> +	 */
> +	while ((at91_adc_readl(st, AT91_SAMA5D2_ISR) & mask) != mask &&
> +	       timeout) {
> +		usleep_range(50, 100);
> +		timeout--;
> +	}
> +
> +	/* Cannot read data, not ready. Continue without reporting data */
> +	if (!timeout)
> +		return;
>  
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
>  			 indio_dev->num_channels) {
> @@ -1281,7 +1310,8 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
>  		status = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
>  		status = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
>  		status = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
> -	} else if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
> +	} else if (iio_buffer_enabled(indio) &&
> +		   (status & AT91_SAMA5D2_IER_DRDY)) {
>  		/* triggered buffer without DMA */
>  		disable_irq_nosync(irq);
>  		iio_trigger_poll(indio->trig);


