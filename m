Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DB63D483A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Jul 2021 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhGXOY4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Jul 2021 10:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGXOY4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jul 2021 10:24:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBF160E9C;
        Sat, 24 Jul 2021 15:05:25 +0000 (UTC)
Date:   Sat, 24 Jul 2021 16:07:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/3] iio: proximity: vcnl3020: add periodic mode
Message-ID: <20210724160756.41a782e2@jic23-huawei>
In-Reply-To: <20210722154420.915082-3-i.mikhaylov@yadro.com>
References: <20210722154420.915082-1-i.mikhaylov@yadro.com>
        <20210722154420.915082-3-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Jul 2021 18:44:19 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Add the possibility to run proximity sensor in periodic measurement
> mode with thresholds.
> 
> Reported-by: kernel test robot <lkp@intel.com> 

A reported by in a patch that isn't obviously a fix should really have
a comment to explain what was reported.  It definitely wasn't the lack
of interrupt support in the driver! Assuming I take this without a v6
I'll add a note that it was a repeated include.

> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  drivers/iio/proximity/vcnl3020.c | 318 ++++++++++++++++++++++++++++++-
>  1 file changed, 315 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index c90f9c6e9e97..6d724657677a 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -2,8 +2,6 @@
>  /*
>   * Support for Vishay VCNL3020 proximity sensor on i2c bus.
>   * Based on Vishay VCNL4000 driver code.
> - *
> - * TODO: interrupts.
>   */
>  
>  #include <linux/module.h>
> @@ -11,9 +9,10 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/interrupt.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
>  
>  #define VCNL3020_PROD_ID	0x21
>  
> @@ -37,6 +36,21 @@
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
> @@ -142,6 +156,21 @@ static int vcnl3020_init(struct vcnl3020_data *data)
>  					       vcnl3020_led_current_property);
>  };
>  
> +static bool vcnl3020_is_in_periodic_mode(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int cmd;
> +
> +	rc = regmap_read(data->regmap, VCNL_COMMAND, &cmd);
> +	if (rc) {
> +		dev_err(data->dev,
> +			"Error (%d) reading command register\n", rc);
> +		return false;
> +	}
> +
> +	return !!(cmd & VCNL_PS_SELFTIMED_EN);
> +}
> +
>  static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
>  {
>  	int rc;
> @@ -149,6 +178,12 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
>  
>  	mutex_lock(&data->lock);
>  
> +	/* Protect against event capture. */
> +	if (vcnl3020_is_in_periodic_mode(data)) {
> +		rc = -EBUSY;
> +		goto err_unlock;
> +	}
> +
>  	rc = regmap_write(data->regmap, VCNL_COMMAND, VCNL_PS_OD);
>  	if (rc)
>  		goto err_unlock;
> @@ -202,6 +237,10 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
>  	unsigned int i;
>  	int index = -1;
>  
> +	/* Protect against event capture. */
> +	if (vcnl3020_is_in_periodic_mode(data))
> +		return -EBUSY;
> +
>  	for (i = 0; i < ARRAY_SIZE(vcnl3020_prox_sampling_frequency); i++) {
>  		if (val == vcnl3020_prox_sampling_frequency[i][0] &&
>  		    val2 == vcnl3020_prox_sampling_frequency[i][1]) {
> @@ -216,12 +255,234 @@ static int vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
>  	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE, index);
>  }
>  
> +static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int icr;
> +
> +	rc = regmap_read(data->regmap, VCNL_PS_ICR, &icr);
> +	if (rc) {
> +		dev_err(data->dev,
> +			"Error (%d) reading ICR register\n", rc);
> +		return false;
> +	}
> +
> +	return !!(icr & VCNL_ICR_THRES_EN);
> +}
> +
> +static int vcnl3020_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	int rc;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			rc = regmap_bulk_read(data->regmap, VCNL_PS_HI_THR_HI,
> +					      &data->buf, sizeof(data->buf));
> +			if (rc < 0)
> +				return rc;
> +			*val = be16_to_cpu(data->buf);
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			rc = regmap_bulk_read(data->regmap, VCNL_PS_LO_THR_HI,
> +					      &data->buf, sizeof(data->buf));
> +			if (rc < 0)
> +				return rc;
> +			*val = be16_to_cpu(data->buf);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	int rc;
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			/* 16 bit word/ low * high */
> +			data->buf = cpu_to_be16(val);
> +			rc = regmap_bulk_write(data->regmap, VCNL_PS_HI_THR_HI,
> +					       &data->buf, sizeof(data->buf));
> +			if (rc < 0)
> +				goto err_unlock;
> +			rc = IIO_VAL_INT;
> +			goto err_unlock;
> +		case IIO_EV_DIR_FALLING:
> +			data->buf = cpu_to_be16(val);
> +			rc = regmap_bulk_write(data->regmap, VCNL_PS_LO_THR_HI,
> +					       &data->buf, sizeof(data->buf));
> +			if (rc < 0)
> +				goto err_unlock;
> +			rc = IIO_VAL_INT;
> +			goto err_unlock;
> +		default:
> +			rc = -EINVAL;
> +			goto err_unlock;
> +		}
> +	default:
> +		rc = -EINVAL;
> +		goto err_unlock;
> +	}
> +err_unlock:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_enable_periodic(struct iio_dev *indio_dev,
> +				    struct vcnl3020_data *data)
> +{
> +	int rc;
> +	int cmd;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* Enable periodic measurement of proximity data. */
> +	cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> +
> +	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
> +	if (rc) {
> +		dev_err(data->dev,
> +			"Error (%d) writing command register\n", rc);
> +		goto err_unlock;
> +	}
> +
> +	/*
> +	 * Enable interrupts on threshold, for proximity data by
> +	 * default.
> +	 */
> +	rc = regmap_write(data->regmap, VCNL_PS_ICR, VCNL_ICR_THRES_EN);
> +	if (rc)
> +		dev_err(data->dev,
> +			"Error (%d) reading ICR register\n", rc);
> +
> +err_unlock:
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
> +	if (rc) {
> +		dev_err(data->dev,
> +			"Error (%d) writing command register\n", rc);
> +		goto err_unlock;
> +	}
> +
> +	rc = regmap_write(data->regmap, VCNL_PS_ICR, 0);
> +	if (rc) {
> +		dev_err(data->dev,
> +			"Error (%d) writing ICR register\n", rc);
> +		goto err_unlock;
> +	}
> +
> +	/* Clear interrupt flag bit */
> +	rc = regmap_write(data->regmap, VCNL_ISR, 0);
> +	if (rc)
> +		dev_err(data->dev,
> +			"Error (%d) writing ISR register\n", rc);
> +
> +err_unlock:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool state)
> +{
> +	struct vcnl3020_data *data = iio_priv(indio_dev);
> +
> +	if (state) {
> +		return vcnl3020_enable_periodic(indio_dev, data);
> +	} else {
> +		if (!vcnl3020_is_thr_enabled(data))
> +			return 0;
> +		return vcnl3020_disable_periodic(indio_dev, data);
> +	}
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
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	}, {
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
> @@ -288,6 +549,10 @@ static const struct iio_info vcnl3020_info = {
>  	.read_raw = vcnl3020_read_raw,
>  	.write_raw = vcnl3020_write_raw,
>  	.read_avail = vcnl3020_read_avail,
> +	.read_event_value = vcnl3020_read_event,
> +	.write_event_value = vcnl3020_write_event,
> +	.read_event_config = vcnl3020_read_event_config,
> +	.write_event_config = vcnl3020_write_event_config,
>  };
>  
>  static const struct regmap_config vcnl3020_regmap_config = {
> @@ -296,6 +561,40 @@ static const struct regmap_config vcnl3020_regmap_config = {
>  	.max_register	= VCNL_PS_MOD_ADJ,
>  };
>  
> +static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
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
> +	} else {
> +		return IRQ_NONE;
> +	}

It doesn't matter a lot, but this would have been neater done as

	if (!(isr & VCNL_ICR_THRESH_EN))
		return IRQ_NONE;

	iio_push_event(...

if that's all that turns up I'll flip it around whilst applying.
	
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int vcnl3020_probe(struct i2c_client *client)
>  {
>  	struct vcnl3020_data *data;
> @@ -328,6 +627,19 @@ static int vcnl3020_probe(struct i2c_client *client)
>  	indio_dev->name = "vcnl3020";
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	if (client->irq) {
> +		rc = devm_request_threaded_irq(&client->dev, client->irq,
> +					       NULL, vcnl3020_handle_irq_thread,
> +					       IRQF_ONESHOT, indio_dev->name,
> +					       indio_dev);
> +		if (rc) {
> +			dev_err(&client->dev,
> +				"Error (%d) irq request failed (%u)\n", rc,
> +				client->irq);
> +			return rc;
> +		}
> +	}
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  

