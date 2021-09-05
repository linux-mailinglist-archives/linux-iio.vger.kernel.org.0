Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83124010C3
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhIEQIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 12:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhIEQI3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 12:08:29 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C8260F5E;
        Sun,  5 Sep 2021 16:07:24 +0000 (UTC)
Date:   Sun, 5 Sep 2021 17:10:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH v2 15/16] iio: adc: max1027: Add support for external
 triggers
Message-ID: <20210905171046.1681482d@jic23-huawei>
In-Reply-To: <20210902211437.503623-16-miquel.raynal@bootlin.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-16-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:14:36 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> So far the driver only supported to use the hardware cnvst trigger. This
> was purely a software limitation.
> 
> The IRQ handler is already registered as being a poll function and thus
> can be called upon external triggering. In this case, a new conversion
> must be started, and one must wait for the data to be ready before
> reading the samples.
> 
> As the same handler can be called from different places, we check the
> value of the current IRQ with the value of the registered device
> IRQ. Indeed, the first step is to get called with a different IRQ number
> than ours, this is the "pullfunc" version which requests a new

pullfunc?

> conversion. During the execution of the handler, we will wait for the
> EOC interrupt to happen. This interrupt is handled by the same
> helper. This time the IRQ number is the one we registered, we can in
> this case call complete() to unlock the primary handler and return. The
> primary handler continues executing by retrieving the data normally and
> finally returns.

Interesting to use the irq number..

I'm a little nervous about how this has ended up structured.
I'm not 100% sure my understanding of how you've done it is correct.

We should have the following situation:

IRQ IN
  |
  v
Trigger IRQ / EOC IRQ  (this is the spi->irq)  (currently iio_trigger_generic_data_poll_ready)
  |              |
  ---------      v
  |        |   complete
  v        v
TrigH1    (TrigH2)   (these are the IRQs below the irq_chip IIO uses to demux triggers)


So when using it's own trigger we are using an internal interrupt
tree burried inside the IIO core.  When using it only as an EOC interrupt we shouldn't
be anywhere near that internal interrupt chip.

So I'm surprised the IRQ matches with the spi->irq as 
those trigH1 and trigH2 will have their own IRQ numbers.

For reference I think your architecture is currently

IRQ IN
  |
  v
  Trigger IRQ
  |
  v
 TRIG H1
 Either fills the buffer or does the completion.

I am a little confused how this works with an external trigger because the Trig H1 interrupt
should be disabled unless we are using the trigger.  That control isn't exposed to the
driver at all.

Is my understanding right or have I gotten confused somewhere?
I also can't see a path in which the eoc interrupt will get fired for raw_reads.

Could you talk me through how that works currently?

I suspect part of the confusion here is that this driver happens to be using the
standard core handler iio_trigger_generic_data_rdy_poll which hides away that
there are two interrupt handlers in a normal IIO driver for a device with a
trigger and buffered mode.
1 for the trigger and 1 for the buffer.  Whether the buffer one is a result
of the trigger one (via iio_poll_trigger) is down to whether the device is
using it's own trigger or not.

Jonathan



> 
> In order to authorize external triggers, we need to drop the
> ->validate_trigger() verification.  
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/iio/adc/max1027.c | 59 +++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index e734d32a5507..b9b7b9245509 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -414,17 +414,6 @@ static int max1027_debugfs_reg_access(struct iio_dev *indio_dev,
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
> @@ -469,6 +458,13 @@ static int max1027_read_scan(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static bool max1027_own_trigger_enabled(struct iio_dev *indio_dev)
> +{
> +	int ret = iio_trigger_validate_own_device(indio_dev->trig, indio_dev);
> +
> +	return ret ? false : true;
> +}
> +
>  static irqreturn_t max1027_threaded_handler(int irq, void *private)
>  {
>  	struct iio_poll_func *pf = private;
> @@ -487,7 +483,47 @@ static irqreturn_t max1027_threaded_handler(int irq, void *private)
>  		return IRQ_HANDLED;
>  	}
>  
> +	/* From that point on, buffers are enabled */
> +
> +	/*
> +	 * The cnvst HW trigger is not in use:
> +	 * we need to handle an external trigger request.
> +	 */
> +	if (!max1027_own_trigger_enabled(indio_dev)) {
> +		if (irq != st->spi->irq) {
> +			/*
> +			 * First, the IRQ number will be the one allocated for
> +			 * this poll function by the IIO core, it means that
> +			 * this is an external trigger request, we need to start
> +			 * a conversion.
> +			 */
> +			ret = max1027_configure_chans_and_start(indio_dev);
> +			if (ret)
> +				goto out;
> +
> +			ret = max1027_wait_eoc(indio_dev);
> +			if (ret)
> +				goto out;
> +		} else {
> +			/*
> +			 * The pollfunc that has been called "manually" by the
> +			 * IIO core now expects the EOC signaling (this is the
> +			 * device IRQ firing), we need to call complete().
> +			 */
> +			complete(&st->complete);

Completion shouldn't be down here in the trigger handler, it should be in the top
level interrupt handler.  So you need to replace the
iio_trigger_generic_data_poll with a specific handler for this device.

> +			return IRQ_HANDLED;
> +		}
> +	}
> +
> +	/*
> +	 * We end here under two situations:
> +	 * - an external trigger is in use and the *_wait_eoc() call succeeded,
> +	 *   the data is ready and may be retrieved.
> +	 * - the cnvst HW trigger is in use (the handler actually starts here),
> +	 *   the data is also ready.
> +	 */
>  	ret = max1027_read_scan(indio_dev);
> +out:
>  	if (ret)
>  		dev_err(&indio_dev->dev,
>  			"Cannot read scanned values (%d)\n", ret);
> @@ -504,7 +540,6 @@ static const struct iio_trigger_ops max1027_trigger_ops = {
>  
>  static const struct iio_info max1027_info = {
>  	.read_raw = &max1027_read_raw,
> -	.validate_trigger = &max1027_validate_trigger,
>  	.debugfs_reg_access = &max1027_debugfs_reg_access,
>  };
>  

