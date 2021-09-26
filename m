Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D003418978
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhIZOet convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 26 Sep 2021 10:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231743AbhIZOes (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 10:34:48 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB7C61090;
        Sun, 26 Sep 2021 14:33:10 +0000 (UTC)
Date:   Sun, 26 Sep 2021 15:36:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v4 14/16] iio: adc: max1027: Use the EOC IRQ when
 populated for single reads
Message-ID: <20210926153659.70162a99@jic23-huawei>
In-Reply-To: <20210921115408.66711-15-miquel.raynal@bootlin.com>
References: <20210921115408.66711-1-miquel.raynal@bootlin.com>
        <20210921115408.66711-15-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Sep 2021 13:54:06 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> So far the End-Of-Conversion interrupt was only used in conjunction with
> the internal trigger to process the data. Let's extend the use of this
> interrupt handler to support regular single-shot conversions as well.
> 
> Doing so requires writing our own hard IRQ handler. This handler has to
> check if buffers are enabled or not:
> 
> *** Buffers disabled condition ***
> 
>   This means the user requested a single conversion and the sample is
>   ready to be retrieved.
> 
>     -> This implies adding the relevant completion boilerplate.  
> 
> *** Buffers enabled condition ***
> 
>   Triggers are used. So far there is only support for the internal
>   trigger but this trigger might soon be attached to another device as
>   well so it is the core duty to decide which handler to call in order
>   to process the data. The core will decide to either:
> 
>   * Call the internal trigger handler which will extract the data that
>     is already present in the ADC FIFOs
> 
>   or
> 
>   * Call the trigger handler of another driver when using this trigger
>     with another device, even though this call will be slightly delayed
>     by the fact that the max1027 IRQ is a data-ready interrupt rather
>     than a real trigger:
> 
>   -> The new handler will manually inform the core about the trigger  
>      having transitioned by directly calling iio_trigger_poll() (which
>      iio_trigger_generic_data_rdy_poll() initially did).
> 
> In order for the handler to be "source" agnostic, we also need to change
> the private pointer and provide the IIO device instead of the trigger
> object.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Jonathan,
> 
> I hope this fits the IIO model now. In order to be sure I got the big
> picture I first refused to look at your code snippets. Just with your
> "plain english" explanations I wrote most of these three patches, before
> checking back that they were indeed fully aligned with your examples. I
> truly hope they do now, but do not hesitate if I missed something.

Looks great to me (in fact I just applied it but I'll reply to the cover letter
shortly for that).

Thanks for persisting with this and I'm looking forward to that blog you
mentioned.  If you have time / inclination to help improve the documentation
in the kernel tree that would also be great.  This discussion has made it
clear to me that it would be great to have a set of 'patterns' for common
types of device + how we map them onto the model of IIO (particularly
when they don't quite fit that idealised model).  There are similar
compromises around when to use multiple buffers for instance.

It is always on the list of things to work on but somehow there is always
something else more urgent :(


Thanks,

Jonathan

> 
> Cheers,
> Miquèl
> 
>  drivers/iio/adc/max1027.c | 43 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 84217e18ef70..0fa7b0fbdba0 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -270,15 +270,26 @@ struct max1027_state {
>  	struct iio_trigger		*trig;
>  	__be16				*buffer;
>  	struct mutex			lock;
> +	struct completion		complete;
>  
>  	u8				reg ____cacheline_aligned;
>  };
>  
>  static int max1027_wait_eoc(struct iio_dev *indio_dev)
>  {
> +	struct max1027_state *st = iio_priv(indio_dev);
>  	unsigned int conversion_time = MAX1027_CONVERSION_UDELAY;
> +	int ret;
>  
> -	usleep_range(conversion_time, conversion_time * 2);
> +	if (st->spi->irq) {
> +		ret = wait_for_completion_timeout(&st->complete,
> +						  msecs_to_jiffies(1000));
> +		reinit_completion(&st->complete);
> +		if (!ret)
> +			return ret;
> +	} else {
> +		usleep_range(conversion_time, conversion_time * 2);
> +	}
>  
>  	return 0;
>  }
> @@ -473,6 +484,30 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static irqreturn_t max1027_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct max1027_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * If buffers are disabled (raw read), we just need to unlock the
> +	 * waiters which will then handle the data.
> +	 *
> +	 * When using the internal trigger, we must hand-off the choice of the
> +	 * handler to the core which will then lookup through the interrupt tree
> +	 * for the right handler registered with iio_triggered_buffer_setup()
> +	 * to execute, as this trigger might very well be used in conjunction
> +	 * with another device. The core will then call the relevant handler to
> +	 * perform the data processing step.
> +	 */
> +	if (!iio_buffer_enabled(indio_dev))
> +		complete(&st->complete);
> +	else
> +		iio_trigger_poll(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t max1027_trigger_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = private;
> @@ -517,6 +552,7 @@ static int max1027_probe(struct spi_device *spi)
>  	st->info = &max1027_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>  
>  	mutex_init(&st->lock);
> +	init_completion(&st->complete);
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &max1027_info;
> @@ -560,10 +596,9 @@ static int max1027_probe(struct spi_device *spi)
>  			return ret;
>  		}
>  
> -		ret = devm_request_irq(&spi->dev, spi->irq,
> -				       iio_trigger_generic_data_rdy_poll,
> +		ret = devm_request_irq(&spi->dev, spi->irq, max1027_handler,
>  				       IRQF_TRIGGER_FALLING,
> -				       spi->dev.driver->name, st->trig);
> +				       spi->dev.driver->name, indio_dev);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
>  			return ret;

