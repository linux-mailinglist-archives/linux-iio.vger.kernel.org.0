Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6704C4107B3
	for <lists+linux-iio@lfdr.de>; Sat, 18 Sep 2021 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhIRRHE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Sep 2021 13:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233210AbhIRRHE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Sep 2021 13:07:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 042D960F9C;
        Sat, 18 Sep 2021 17:05:38 +0000 (UTC)
Date:   Sat, 18 Sep 2021 18:09:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v3 13/14] iio: adc: max1027: Deeply rework interrupt
 handling
Message-ID: <20210918180918.6908bbd9@jic23-huawei>
In-Reply-To: <20210915155117.475962-14-miquel.raynal@bootlin.com>
References: <20210915155117.475962-1-miquel.raynal@bootlin.com>
        <20210915155117.475962-14-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Sep 2021 17:51:16 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The interrupt will fire upon end of conversion. This currently can
> happen in three situations:
> * a single read was requested and the data is ready
> * the cnvst (internal) trigger was enabled and toggled
> * an external trigger was enabled and toggled
> 
> So far, the driver only supported raw reads without involving the IRQ
> and internal triggering. The internal trigger was actually the only
> possible trigger, leading to shortcuts in the implementation.
> 
> In order to clarify the interrupt handling mechanism and extend the
> software support to external triggers we must do all the following at
> the same time:
> * Create a hard IRQ handler only handling the EOC condition:
>   In this handler, check if we are doing a raw read or a triggered
>   read: maybe we just need to call complete() to unlock the waiting
>   process, maybe we also need to push samples.

This doesn't sound quite right.  Should be either complete, or all iio_trigger_poll()
to tell any trigger consumers that the trigger has occured.

> * Create a threaded IRQ handler only executed upon EOC condition only if
>   the internal trigger is used: as said above, the goal of this threaded
>   handler is to retrieve the data and push it to the buffers.

Again, not quite right..

> * Create another threaded IRQ handler that will be registered with
>   devm_iio_triggered_buffer_setup(), in order to fully handle an
>   external triggering event (start conversion, wait for EOC either by
>   busy-waiting or with the completion object unlocked by the hard IRQ
>   handler, retrieve the data, push it to the buffers).
> 
> In order to authorize external triggers, we need to drop the
> ->validate_trigger() verification.  

I've tried to suggest how you need to change this to bring it inline
with the normal trigger / device split model of IIO.

Thanks,

Jonathan

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 90 +++++++++++++++++++++++++++++++--------
>  1 file changed, 72 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index e0175448c899..9bf1c563042f 100644
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
> @@ -418,17 +429,6 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
>  	return spi_write(st->spi, val, 1);
>  }
>  
> -static int max1027_validate_trigger(struct iio_dev *indio_dev,
> -				    struct iio_trigger *trig)
> -{
> -	struct max1027_state *st = iio_priv(indio_dev);
> -
> -	if (st->trig != trig)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> @@ -473,13 +473,67 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static irqreturn_t max1027_trigger_handler(int irq, void *private)
> +static bool max1027_own_trigger_enabled(struct iio_dev *indio_dev)
> +{
> +	int ret = iio_trigger_validate_own_device(indio_dev->trig, indio_dev);
> +
> +	return ret ? false : true;
> +}
> +
> +static irqreturn_t max1027_eoc_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct max1027_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * If the buffers are disabled (raw read) or an external trigger is
> +	 * used, we just need to call complete() to unlock the waiters
> +	 * which will themselves handle the data.
> +	 */
> +	if (!iio_buffer_enabled(indio_dev) ||
> +	    !max1027_own_trigger_enabled(indio_dev)) {

This looks like what I'd expect here.  Should be able to use
!iio_trigger_using_own(indio_dev) for the second condition I think...


> +		complete(&st->complete);
> +		return IRQ_HANDLED;
> +	}

Here we should see the same as you find in the generic handler which is just

	iio_trigger_poll(private);

	return IRQ_HANDLED;

> +
> +	/*
> +	 * When using the internal trigger, the data handling is done in
> +	 * the threaded interrupt handler.

Wrong handler. It needs to be done in the one of the device side of the trigger / device split
not here which is on the trigger side.

> +	 */
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t max1027_int_trigger_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	int ret;
> +
> +	ret = max1027_read_scan(indio_dev);
> +	if (ret)
> +		dev_err(&indio_dev->dev,
> +			"Cannot read scanned values (%d)\n", ret);
> +
> +	iio_trigger_notify_done(indio_dev->trig);

This is acknowledging the trigger in a patch not called via the trigger.
It might work but it definitely isn't the right model to use.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t max1027_ext_trigger_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	int ret;
> 

Here there should be a

	if (iio_trigger_using_own(indio_dev)) {

		/* Just read the data and push to the buffer as we know we are using the EOC trigger*/
		/* I think that will be what you have in max1027_int_trigger_handler above */
		/* You may also want to provide a top half for the trigger handler to grab a timestamp
		   nearer the point of the EOC interrupt for this path...
		*/

	} else {
		/* Start the capture and wait for completion */

		ret = max1027_configure_chans_and_start(indio_dev);
		if (ret)
			goto out;
	
		ret = max1027_wait_eoc(indio_dev);
		if (ret)
			goto out;

	 	ret = max1027_read_scan(indio_dev);
...		
	}

> +	ret = max1027_configure_chans_and_start(indio_dev);
> +	if (ret)
> +		goto out;
> +
> +	ret = max1027_wait_eoc(indio_dev);
> +	if (ret)
> +		goto out;
> +
>  	ret = max1027_read_scan(indio_dev);
> +out:
>  	if (ret)
>  		dev_err(&indio_dev->dev,
>  			"Cannot read scanned values (%d)\n", ret);
> @@ -496,7 +550,6 @@ static const struct iio_trigger_ops max1027_trigger_ops = {
>  
>  static const struct iio_info max1027_info = {
>  	.read_raw = &max1027_read_raw,
> -	.validate_trigger = &max1027_validate_trigger,
>  	.debugfs_reg_access = &max1027_debugfs_reg_access,
>  };
>  
> @@ -517,6 +570,7 @@ static int max1027_probe(struct spi_device *spi)
>  	st->info = &max1027_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>  
>  	mutex_init(&st->lock);
> +	init_completion(&st->complete);
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &max1027_info;
> @@ -534,7 +588,7 @@ static int max1027_probe(struct spi_device *spi)
>  	if (spi->irq) {
>  		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
>  						      &iio_pollfunc_store_time,
> -						      &max1027_trigger_handler,
> +						      &max1027_ext_trigger_handler,

This isn't how this would normally be done.
Whatever trigger we are using, the handling should occur in the callback registered here.
We can do 'different' things depending on the trigger in use however.
The reason is that we want a model that allows us to use the EOC trigger for this device
and other devices at the same time.


>  						      NULL);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev, "Failed to setup buffer\n");
> @@ -561,11 +615,11 @@ static int max1027_probe(struct spi_device *spi)
>  		}
>  
>  		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
> -						iio_trigger_generic_data_rdy_poll,
> -						NULL,
> +						max1027_eoc_handler,
> +						max1027_int_trigger_handler,
>  						IRQF_TRIGGER_FALLING,
>  						spi->dev.driver->name,
> -						st->trig);
> +						indio_dev);
>  		if (ret < 0) {
>  			dev_err(&indio_dev->dev, "Failed to allocate IRQ.\n");
>  			return ret;

