Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E7E3FB3EE
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhH3KfA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236325AbhH3KfA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:35:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC37610CB;
        Mon, 30 Aug 2021 10:34:04 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:37:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/16] iio: adc: max1027: Consolidate the end of
 conversion helper
Message-ID: <20210830113716.1f7cdc6f@jic23-huawei>
In-Reply-To: <20210818111139.330636-15-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-15-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 13:11:37 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Now that we have a dedicated handler for End Of Conversion interrupts,
> let's create a second path:
> - Situation 1: we are using the external hardware trigger, a conversion
>   has been triggered and the ADC pushed the data to its FIFO, we need to
>   retrieve the data and push it to the IIO buffers.
> - Situation 2: we are not using the external hardware trigger, hence we
>   are likely waiting in a blocked thread waiting for this interrupt to
>   happen: in this case we just wake up the waiting thread.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 8d86e77fb5db..8c5995ae59f2 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -235,6 +235,7 @@ struct max1027_state {
>  	struct iio_trigger		*trig;
>  	__be16				*buffer;
>  	struct mutex			lock;
> +	bool				data_rdy;
>  	bool				cnvst_trigger;
>  	u8				reg ____cacheline_aligned;
>  };
> @@ -243,12 +244,22 @@ static DECLARE_WAIT_QUEUE_HEAD(max1027_queue);
>  
>  static int max1027_wait_eoc(struct iio_dev *indio_dev)
>  {
> +	struct max1027_state *st = iio_priv(indio_dev);
>  	unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
> +	int ret;
>  
> -	if (indio_dev->active_scan_mask)
> -		conversion_time *= hweight32(*indio_dev->active_scan_mask);
> +	if (st->spi->irq) {
> +		ret = wait_event_interruptible_timeout(max1027_queue,
> +						       st->data_rdy, HZ / 1000);
> +		st->data_rdy = false;
> +		if (ret == -ERESTARTSYS)
> +			return ret;
> +	} else {
> +		if (indio_dev->active_scan_mask)
> +			conversion_time *= hweight32(*indio_dev->active_scan_mask);
>  
> -	usleep_range(conversion_time, conversion_time * 2);
> +		usleep_range(conversion_time, conversion_time * 2);
> +	}
>  
>  	return 0;
>  }
> @@ -481,6 +492,9 @@ static irqreturn_t max1027_eoc_irq_handler(int irq, void *private)
>  	if (st->cnvst_trigger) {
>  		ret = max1027_read_scan(indio_dev);
>  		iio_trigger_notify_done(indio_dev->trig);
> +	} else {
> +		st->data_rdy = true;
> +		wake_up(&max1027_queue);

I can't see why a queue is appropriate for this.  Use a completion and have
one per instance of the device.  No need for the flag etc in that case as
complete() means we have had an interrupt.

>  	}
>  
>  	if (ret)

