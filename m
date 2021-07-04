Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294043BAE05
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jul 2021 19:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGDRZr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jul 2021 13:25:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhGDRZr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Jul 2021 13:25:47 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 288376112D;
        Sun,  4 Jul 2021 17:23:09 +0000 (UTC)
Date:   Sun, 4 Jul 2021 18:25:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: proximity: vcnl3020: add periodic mode
Message-ID: <20210704182534.720a6580@jic23-huawei>
In-Reply-To: <20210621143051.200800-2-i.mikhaylov@yadro.com>
References: <20210621143051.200800-1-i.mikhaylov@yadro.com>
        <20210621143051.200800-2-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Jun 2021 17:30:50 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add the possibility to run proximity sensor in periodic measurement
> mode.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Hi Ivan,

I'd probably have combined the two patches here, on the basis that a threshold detector
with no threshold value setting doesn't make much sense.

Still doesn't matter much.  A few minor comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/vcnl3020.c | 211 ++++++++++++++++++++++++++++++-
>  1 file changed, 209 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 43817f6b3086..2e65127d5359 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -3,7 +3,6 @@
>   * Support for Vishay VCNL3020 proximity sensor on i2c bus.
>   * Based on Vishay VCNL4000 driver code.
>   *
> - * TODO: interrupts.
>   */
>  
>  #include <linux/module.h>
> @@ -11,9 +10,11 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/interrupt.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
>  
>  #define VCNL3020_PROD_ID	0x21
>  
> @@ -37,6 +38,21 @@
>  					* measurement
>  					*/
>  
> +/* Enables periodic proximity measurement */
> +#define VCNL_PS_EN		BIT(1)
> +
> +/* Enables state machine and LP oscillator for self timed  measurements */
> +#define VCNL_PS_SELFTIMED_EN	BIT(0)
> +
> +/* Bit masks for ICR */
> +
> +/* Enable interrupts on low or high thresholds */
> +#define  VCNL_ICR_THRES_EN	BIT(1)
> +
> +/* Bit masks for ISR */
> +#define VCNL_INT_TH_HI		BIT(0)	/* High threshold hit */
> +#define VCNL_INT_TH_LOW		BIT(1)	/* Low threshold hit */
> +
>  #define VCNL_ON_DEMAND_TIMEOUT_US	100000
>  #define VCNL_POLL_US			20000
>  
> @@ -215,12 +231,145 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
>  	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
>  }
>  
> +static bool vcnl3020_is_in_periodic_mode(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int cmd;
> +
> +	rc = regmap_read(data->regmap, VCNL_COMMAND, &cmd);
> +	if (rc)
> +		return false;
> +
> +	return !!(cmd & VCNL_PS_SELFTIMED_EN);
> +}
> +
> +static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int icr;
> +
> +	rc = regmap_read(data->regmap, VCNL_PS_ICR, &icr);
> +	if (rc)
> +		return false;
> +
> +	return !!(icr & VCNL_ICR_THRES_EN);
> +}
> +
> +static int vcnl3020_enable_periodic(struct iio_dev *indio_dev,
> +				    struct vcnl3020_data *data)
> +{
> +	int rc;
> +	int icr;
> +	int cmd;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* Enable periodic measurement of proximity data. */
> +	cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> +
> +	/*
> +	 * Enable interrupts on threshold, for proximity data by
> +	 * default.
> +	 */
> +	icr = VCNL_ICR_THRES_EN;

Why have this local variable.  Just put it it directly in the
regmap_write() call below.

> +
> +	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
> +	if (rc)
> +		goto out_mutex;
> +
> +	rc = regmap_write(data->regmap, VCNL_PS_ICR, icr);
> +
> +out_mutex:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_disable_periodic(struct iio_dev *indio_dev,
> +				     struct vcnl3020_data *data)
> +{
> +	int rc;
> +
> +	mutex_lock(&data->lock);
> +
> +	rc = regmap_write(data->regmap, VCNL_COMMAND, 0);
> +	if (rc)
> +		goto out_mutex;
> +
> +	rc = regmap_write(data->regmap, VCNL_PS_ICR, 0);
> +	if (rc)
> +		goto out_mutex;
> +
> +	/* Clear interrupt flag bit */
> +	rc = regmap_write(data->regmap, VCNL_ISR, 0);
> +
> +out_mutex:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
> +{
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +	int rc;
> +
> +	if (state) {
> +		rc = vcnl3020_enable_periodic(indio_dev, data);

return vcnl... Save me reading down a few lines to see if anything else happens
in this path.

> +	} else {
> +		if (!vcnl3020_is_thr_enabled(data))
> +			return 0;
> +		rc = vcnl3020_disable_periodic(indio_dev, data);

return vcnl...


> +	}
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl3020_config_threshold(indio_dev, state);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl3020_is_thr_enabled(data);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_event_spec vcnl3020_event_spec[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  static const struct iio_chan_spec vcnl3020_channels[] = {
>  	{
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec = vcnl3020_event_spec,
> +		.num_event_specs = ARRAY_SIZE(vcnl3020_event_spec),
>  	},
>  };
>  
> @@ -233,6 +382,11 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +
> +		/* Protect against event capture. */
> +		if (vcnl3020_is_in_periodic_mode(data))
> +			return -EBUSY;
> +
>  		rc = vcnl3020_measure_proximity(data, val);
>  		if (rc)
>  			return rc;
> @@ -254,6 +408,10 @@ static int vcnl3020_write_raw(struct iio_dev *indio_dev,
>  	int rc;
>  	struct vcnl3020_data *data = iio_priv(indio_dev);
>  
> +	/* Protect against event capture. */
> +	if (vcnl3020_is_in_periodic_mode(data))

What can happen if we race against enabling of periodic_mode?
Is it just a bit unpredicatable or can we cause anything really nasty to 
happen? If just a bit unpredictable then the protection you have here is fine.

> +		return -EBUSY;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		rc = iio_device_claim_direct_mode(indio_dev);
> @@ -287,6 +445,8 @@ static const struct iio_info vcnl3020_info = {
>  	.read_raw = vcnl3020_read_raw,
>  	.write_raw = vcnl3020_write_raw,
>  	.read_avail = vcnl3020_read_avail,
> +	.read_event_config = vcnl3020_read_event_config,
> +	.write_event_config = vcnl3020_write_event_config,
>  };
>  
>  static const struct regmap_config vcnl3020_regmap_config = {
> @@ -295,6 +455,38 @@ static const struct regmap_config vcnl3020_regmap_config = {
>  	.max_register	= VCNL_PS_MOD_ADJ,
>  };
>  
> +static irqreturn_t vcnl3020_handle_irq(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +	unsigned int isr;
> +	int rc;
> +
> +	rc = regmap_read(data->regmap, VCNL_ISR, &isr);
> +	if (rc) {
> +		dev_err(data->dev, "Error (%d) reading reg (0x%x)\n",
> +			rc, VCNL_ISR);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (isr & VCNL_ICR_THRES_EN) {
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> +						    1,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +
> +		rc = regmap_write(data->regmap, VCNL_ISR,
> +				  isr & VCNL_ICR_THRES_EN);
> +		if (rc)
> +			dev_err(data->dev, "Error (%d) writing in reg (0x%x)\n",
> +				rc, VCNL_ISR);
> +	}

If it's not an event, should we not return IRQ_NONE to let the kernel's
spurious interrupt handing know about it?  We can't safely do that in error
cases, because it might be our interrupt, but in this case we know it isn't.

> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int vcnl3020_probe(struct i2c_client *client)
>  {
>  	struct vcnl3020_data *data;
> @@ -327,6 +519,21 @@ static int vcnl3020_probe(struct i2c_client *client)
>  	indio_dev->name = "vcnl3020";
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	if (client->irq) {
> +		rc = devm_request_irq(&client->dev, client->irq,

Use a threaded irq request.  We don't want to have any chance of calling the handle_irq
in interrupt context as many i2c controllers will sleep.

> +				      vcnl3020_handle_irq,
> +				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

General convention these days is to not specify the direction in here as
it prevents the driver working if there is an inverter on the interrupt line.
The sense of the interrupt should be set by firmware / device tree etc.

> +				      indio_dev->name, indio_dev);
> +		if (rc) {
> +			dev_err(&client->dev,
> +				"Error (%d) irq request failed (%u)\n", rc,
> +				client->irq);
> +			return rc;
> +		}
> +	} else {
> +		dev_info(&client->dev, "Starting without irq handle\n");

Not interesting.  If anyone want to know the, can look in /proc/interrupts
So drop this print.



> +	}
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  

