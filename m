Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0C1B872D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDYOwy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 10:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgDYOwy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 10:52:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3D720714;
        Sat, 25 Apr 2020 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587826373;
        bh=+13CHPNmfmCKf+0SVFYF37GqQiMCAaZRQBxv+QtM87o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OulI3xUdPjn50jbNzvZ8tMsNtjmM9jrKFZ+7nIv5avHBRDKjJg553M1LtNyHlYByI
         ITdynEsnKVHySeySGiFrmI0Wf0B105B8OhH1eQjh9LABM8joxhNK6yaYpiti3Sd2Pe
         TQ7Km1tat6aYfVrW2QxsyXgqmD2kTu/3+FgVeXkc=
Date:   Sat, 25 Apr 2020 15:52:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 2/3] iio: adc: at91-sama5d2_adc: handle unfinished
 conversions
Message-ID: <20200425155249.15fb855f@archlinux>
In-Reply-To: <1580216189-27418-3-git-send-email-eugen.hristev@microchip.com>
References: <1580216189-27418-1-git-send-email-eugen.hristev@microchip.com>
        <1580216189-27418-3-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jan 2020 12:57:40 +0000
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

Applied this and patch 3 to the togreg branch of iio.git and pushed out as testing.

Thanks for reminding me about these.  Were still in the queue but I might
have forgotten to check this far back!

Jonathan

> ---
> Changes in v3:
> - rewrite some code as suggested by Jonathan (w.r.t. state and dma enabled in
> configure_trigger
> - move back enable_irq in reenable_trigger : looks like it was a leftover,
> thanks Jonathan
> 
> Changes in v2:
> - move start of conversion to threaded irq, removed specific at91 pollfunc
> - add timeout to channel mask readiness check in trigger handler
> - use DRDY irq instead of EOC irqs.
> - move enable irq after DRDY has been acked in reenable_trigger
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 62 +++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 2a6950a..49c2b9d 100644
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
> @@ -746,25 +764,23 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
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
>  
> +	/* Nothing to do if using DMA */
> +	if (st->dma_st.dma_chan)
> +		return 0;
> +
> +	if (state)
> +		at91_adc_writel(st, AT91_SAMA5D2_IER, AT91_SAMA5D2_IER_DRDY);
> +	else
> +		at91_adc_writel(st, AT91_SAMA5D2_IDR, AT91_SAMA5D2_IER_DRDY);
> +
>  	return 0;
>  }
>  
> @@ -781,6 +797,7 @@ static int at91_adc_reenable_trigger(struct iio_trigger *trig)
>  
>  	/* Needed to ACK the DRDY interruption */
>  	at91_adc_readl(st, AT91_SAMA5D2_LCDR);
> +
>  	return 0;
>  }
>  
> @@ -1015,6 +1032,22 @@ static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
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
> @@ -1281,7 +1314,8 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
>  		status = at91_adc_readl(st, AT91_SAMA5D2_XPOSR);
>  		status = at91_adc_readl(st, AT91_SAMA5D2_YPOSR);
>  		status = at91_adc_readl(st, AT91_SAMA5D2_PRESSR);
> -	} else if (iio_buffer_enabled(indio) && !st->dma_st.dma_chan) {
> +	} else if (iio_buffer_enabled(indio) &&
> +		   (status & AT91_SAMA5D2_IER_DRDY)) {
>  		/* triggered buffer without DMA */
>  		disable_irq_nosync(irq);
>  		iio_trigger_poll(indio->trig);

