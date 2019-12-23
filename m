Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064251295F2
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLWMUd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 07:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfLWMUd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 07:20:33 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CCF20715;
        Mon, 23 Dec 2019 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577103631;
        bh=TpJfXPgSRuwL/c72Cja8P/w1/cM3OuXHaibAaaqw+ew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JomMEZzZX6YYsBuIV6KFhA+Ml0w6SRPZKm+UDwaHVOcfrNwQnfS+TqmTl2ewx7dX+
         WjL5ldoyqZ7vC+WdWQVkIky/GioooqdTN28UN6Kir0guVZTC7dw78Sz7tUxXJd5jY6
         BEN6u+u3FBfvyI+Qvh6ZUzJxXVnhMJUgJJ2SLTOQ=
Date:   Mon, 23 Dec 2019 12:20:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Eugen.Hristev@microchip.com>
Cc:     <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <Nicolas.Ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <a.zummo@towertech.it>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH 06/10] iio: adc: at91-sama5d2_adc: handle unfinished
 conversions
Message-ID: <20191223122027.7b93129f@archlinux>
In-Reply-To: <1576686157-11939-7-git-send-email-eugen.hristev@microchip.com>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
        <1576686157-11939-7-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Dec 2019 16:24:01 +0000
<Eugen.Hristev@microchip.com> wrote:

> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> It can happen that on IRQ trigger, not all conversions are done if
> we are enabling multiple channels.
> The IRQ is triggered on first EOC (end of channel), but it can happen
> that not all channels are done. This leads into erroneous reports to
> userspace (zero values or previous values).

Ouch. That's an unfortunate hardware design.

> To solve this, in trigger handler, check if the mask of done channels
> is the same as the mask of active scan channels.
> If it's the same, proceed and push to buffers. Otherwise, to avoid sleeping
> in trigger handler, start a workq that will wait until all channels are
> ready.

You are fine sleeping in that handler. It's an interrupt thread ;)

> Normally, it should happen that in a short time fashion, all channels are
> ready, since the first IRQ triggered.
> The workq can stall in a loop if a hardware fault happens (for example
> the clock suddently dissappears), but if it's a hardware fault then
> even exiting the workq won't fix the hardware.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index c575970..a6b4dff 100644
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
> @@ -487,6 +488,21 @@ static inline int at91_adc_of_xlate(struct iio_dev *indio_dev,
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
> @@ -1044,12 +1060,13 @@ static int at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
>  					  struct iio_poll_func *pf)
>  {
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> +	u32 mask = at91_adc_active_scan_mask_to_reg(indio_dev);
>  
>  	/*
>  	 * Check if the conversion is ready. If not, schedule a work to
>  	 * check again later.
>  	 */
> -	if (!(at91_adc_readl(st, AT91_SAMA5D2_ISR) & GENMASK(11, 0))) {
> +	if ((at91_adc_readl(st, AT91_SAMA5D2_ISR) & mask) != mask) {
>  		schedule_work(&st->workq);
>  		return -EINPROGRESS;
>  	}
> @@ -1269,9 +1286,13 @@ static void at91_adc_workq_handler(struct work_struct *workq)
>  	struct at91_adc_state *st = container_of(workq,
>  					struct at91_adc_state, workq);
>  	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> +	u32 mask = at91_adc_active_scan_mask_to_reg(indio_dev);
>  
>  	if ((indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES) &&
>  	    iio_trigger_validate_own_device(indio_dev->trig, indio_dev)) {
> +		while ((at91_adc_readl(st, AT91_SAMA5D2_ISR) & mask) != mask)
> +			udelay(1);
> +
ok. This fixes the issue raised earlier.  Please reorganize the series
so we never introduce this code in a broken fashion.  + look at doing it
in the interrupt thread anyway.

Jonathan
>  		at91_adc_read_and_push_channels(indio_dev, st->timestamp);
>  		iio_trigger_notify_done(indio_dev->trig);
>  	} else {

