Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9433C35C6
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 19:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhGJR2q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 10 Jul 2021 13:28:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhGJR2p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 13:28:45 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7FDA6135D;
        Sat, 10 Jul 2021 17:25:57 +0000 (UTC)
Date:   Sat, 10 Jul 2021 18:28:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/1] iio: proximity: vcnl3020: add periodic mode
Message-ID: <20210710182830.28002491@jic23-huawei>
In-Reply-To: <PH0PR03MB6366A1F0B5AB2963081A8CDB99189@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210708124115.558186-1-i.mikhaylov@yadro.com>
        <20210708124115.558186-2-i.mikhaylov@yadro.com>
        <PH0PR03MB6366A1F0B5AB2963081A8CDB99189@PH0PR03MB6366.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 9 Jul 2021 07:15:55 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Ivan,
> 
> This looks good. Some comments inline...
> 
> > From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > Sent: Thursday, July 8, 2021 2:41 PM
> > To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; Peter Meerwald-Stadler
> > <pmeerw@pmeerw.net>
> > Cc: Ivan Mikhaylov <i.mikhaylov@yadro.com>; linux-
> > kernel@vger.kernel.org; linux-iio@vger.kernel.org; kernel test robot
> > <lkp@intel.com>
> > Subject: [PATCH v3 1/1] iio: proximity: vcnl3020: add periodic mode
> > 
> > [External]
> > 
> > Add the possibility to run proximity sensor in periodic measurement
> > mode with thresholds.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> > ---
> >  drivers/iio/proximity/vcnl3020.c | 297
> > ++++++++++++++++++++++++++++++-
> >  1 file changed, 295 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/vcnl3020.c
> > b/drivers/iio/proximity/vcnl3020.c
> > index 43817f6b3086..cd5e9a34b93c 100644
> > --- a/drivers/iio/proximity/vcnl3020.c
> > +++ b/drivers/iio/proximity/vcnl3020.c
> > @@ -3,7 +3,6 @@
> >   * Support for Vishay VCNL3020 proximity sensor on i2c bus.
> >   * Based on Vishay VCNL4000 driver code.
> >   *
> > - * TODO: interrupts.
> >   */
> > 
> >  #include <linux/module.h>
> > @@ -11,9 +10,10 @@
> >  #include <linux/err.h>
> >  #include <linux/delay.h>
> >  #include <linux/regmap.h>
> > +#include <linux/interrupt.h>
> > 
> >  #include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > 
> >  #define VCNL3020_PROD_ID	0x21
> > 
> > @@ -37,6 +37,21 @@
> >  					* measurement
> >  					*/
> > 
> > +/* Enables periodic proximity measurement */
> > +#define VCNL_PS_EN		BIT(1)
> > +
> > +/* Enables state machine and LP oscillator for self timed
> > measurements */
> > +#define VCNL_PS_SELFTIMED_EN	BIT(0)
> > +
> > +/* Bit masks for ICR */
> > +
> > +/* Enable interrupts on low or high thresholds */
> > +#define  VCNL_ICR_THRES_EN	BIT(1)
> > +
> > +/* Bit masks for ISR */
> > +#define VCNL_INT_TH_HI		BIT(0)	/* High threshold hit */
> > +#define VCNL_INT_TH_LOW		BIT(1)	/* Low threshold hit */
> > +
> >  #define VCNL_ON_DEMAND_TIMEOUT_US	100000
> >  #define VCNL_POLL_US			20000
> > 
> > @@ -215,12 +230,230 @@ static int
> > vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
> >  	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE,
> > index);
> >  }
> > 
> > +static bool vcnl3020_is_in_periodic_mode(struct vcnl3020_data
> > *data)
> > +{
> > +	int rc;
> > +	unsigned int cmd;
> > +
> > +	rc = regmap_read(data->regmap, VCNL_COMMAND, &cmd);
> > +	if (rc)
> > +		return false;
> > +
> > +	return !!(cmd & VCNL_PS_SELFTIMED_EN);
> > +}
> > +
> > +static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
> > +{
> > +	int rc;
> > +	unsigned int icr;
> > +
> > +	rc = regmap_read(data->regmap, VCNL_PS_ICR, &icr);
> > +	if (rc)
> > +		return false;
> > +
> > +	return !!(icr & VCNL_ICR_THRES_EN);
> > +}
> > +
> > +static int vcnl3020_read_event(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info,
> > +			       int *val, int *val2)
> > +{
> > +	int rc;
> > +	struct vcnl3020_data *data = iio_priv(indio_dev);
> > +	__be16 res;
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			rc = regmap_bulk_read(data->regmap,
> > VCNL_PS_HI_THR_HI,
> > +					      &res, sizeof(res));  
> 
> Me and Jonathan actually spoke about this in the beginning of
> the week [1]. For IIO we enforce that this has to be DMA safe
> even though it's a 2 byte transfer... Check on IIO driver's using
> ' ____cacheline_aligned'. Note, that it actually matters for the
> buffer/data to be the last member of the structure...
> 
> > +			if (rc < 0)
> > +				return rc;
> > +			*val = be16_to_cpu(res);
> > +			return IIO_VAL_INT;
> > +		case IIO_EV_DIR_FALLING:
> > +			rc = regmap_bulk_read(data->regmap,
> > VCNL_PS_LO_THR_HI,
> > +					      &res, sizeof(res));
> > +			if (rc < 0)
> > +				return rc;
> > +			*val = be16_to_cpu(res);
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int vcnl3020_write_event(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info,
> > +				int val, int val2)
> > +{
> > +	int rc;
> > +	__be16 buf;
> > +	struct vcnl3020_data *data = iio_priv(indio_dev);
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			/* 16 bit word/ low * high */
> > +			buf = cpu_to_be16(val);
> > +			rc = regmap_bulk_write(data->regmap,
> > VCNL_PS_HI_THR_HI,
> > +					       &buf, sizeof(buf));  
> 
> Typically, AFAIK, ' regmap_bulk_write()' creates a DMA safe bounce
> buffer for you. However I don't thinks that's done with that in mind
> and I don't see anywhere on docs that this is something we can rely
> on. Thus, I would also use the DMA safe buffer here and not rely on
> regmap implementation details...

Interesting, I'd missed the duplication.
It was introduced as an endian fix.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0812d8ffa9955251ba0077488d4408d8987ec091

Ah well, so in this case we are safe, but as Nuno states, it's not
guaranteed to always be the case.  An obvious optimization would
be to not duplicate if we didn't need to do any reformatting of
the data.

 
> 
> > +			if (rc < 0)
> > +				goto out_mutex;
> > +			rc = IIO_VAL_INT;
> > +			goto out_mutex;
> > +		case IIO_EV_DIR_FALLING:
> > +			buf = cpu_to_be16(val);
> > +			rc = regmap_bulk_write(data->regmap,
> > VCNL_PS_LO_THR_HI,
> > +					       &buf, sizeof(buf));
> > +			if (rc < 0)
> > +				goto out_mutex;
> > +			rc = IIO_VAL_INT;
> > +			goto out_mutex;
> > +		default:
> > +			rc = -EINVAL;
> > +			goto out_mutex;
> > +		}
> > +	default:
> > +		rc = -EINVAL;
> > +		goto out_mutex;
> > +	}
> > +out_mutex:
> > +	mutex_unlock(&data->lock);
> > +
> > +	return rc;
> > +}
> > +
> > +static int vcnl3020_enable_periodic(struct iio_dev *indio_dev,
> > +				    struct vcnl3020_data *data)
> > +{
> > +	int rc;
> > +	int cmd;
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	/* Enable periodic measurement of proximity data. */
> > +	cmd = VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> > +
> > +	rc = regmap_write(data->regmap, VCNL_COMMAND, cmd);
> > +	if (rc)
> > +		goto out_mutex;
> > +
> > +	/*
> > +	 * Enable interrupts on threshold, for proximity data by
> > +	 * default.
> > +	 */
> > +	rc = regmap_write(data->regmap, VCNL_PS_ICR,
> > VCNL_ICR_THRES_EN);
> > +
> > +out_mutex:
> > +	mutex_unlock(&data->lock);
> > +
> > +	return rc;
> > +}
> > +
> > +static int vcnl3020_disable_periodic(struct iio_dev *indio_dev,
> > +				     struct vcnl3020_data *data)
> > +{
> > +	int rc;
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	rc = regmap_write(data->regmap, VCNL_COMMAND, 0);
> > +	if (rc)
> > +		goto out_mutex;
> > +
> > +	rc = regmap_write(data->regmap, VCNL_PS_ICR, 0);
> > +	if (rc)
> > +		goto out_mutex;
> > +
> > +	/* Clear interrupt flag bit */
> > +	rc = regmap_write(data->regmap, VCNL_ISR, 0);
> > +
> > +out_mutex:
> > +	mutex_unlock(&data->lock);
> > +
> > +	return rc;
> > +}
> > +
> > +static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool
> > state)
> > +{
> > +	struct vcnl3020_data *data = iio_priv(indio_dev);
> > +
> > +	if (state) {
> > +		return vcnl3020_enable_periodic(indio_dev, data);
> > +	} else {
> > +		if (!vcnl3020_is_thr_enabled(data))
> > +			return 0;
> > +		return vcnl3020_disable_periodic(indio_dev, data);
> > +	}
> > +}
> > +
> > +static int vcnl3020_write_event_config(struct iio_dev *indio_dev,
> > +				       const struct iio_chan_spec *chan,
> > +				       enum iio_event_type type,
> > +				       enum iio_event_direction dir,
> > +				       int state)
> > +{
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		return vcnl3020_config_threshold(indio_dev, state);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int vcnl3020_read_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir)
> > +{
> > +	struct vcnl3020_data *data = iio_priv(indio_dev);
> > +
> > +	switch (chan->type) {
> > +	case IIO_PROXIMITY:
> > +		return vcnl3020_is_thr_enabled(data);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct iio_event_spec vcnl3020_event_spec[] = {
> > +	{
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_RISING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +	}, {
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_FALLING,
> > +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +	}, {
> > +		.type = IIO_EV_TYPE_THRESH,
> > +		.dir = IIO_EV_DIR_EITHER,
> > +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > +};
> > +
> >  static const struct iio_chan_spec vcnl3020_channels[] = {
> >  	{
> >  		.type = IIO_PROXIMITY,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >  				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >  		.info_mask_separate_available =
> > BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.event_spec = vcnl3020_event_spec,
> > +		.num_event_specs =
> > ARRAY_SIZE(vcnl3020_event_spec),
> >  	},
> >  };
> > 
> > @@ -233,6 +466,11 @@ static int vcnl3020_read_raw(struct iio_dev
> > *indio_dev,
> > 
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > +
> > +		/* Protect against event capture. */
> > +		if (vcnl3020_is_in_periodic_mode(data))
> > +			return -EBUSY;  
> 
> This does not give you any guarantee that you won't end up calling
> 'vcnl3020_measure_proximity()' with periodic mode enabled... The
> 'if()' should be done under the same data lock that you use for
> enabling/disabling this mode. Just push the check inside
> 'vcnl3020_measure_proximity()'.
> 
> >  		rc = vcnl3020_measure_proximity(data, val);
> >  		if (rc)
> >  			return rc;
> > @@ -254,6 +492,10 @@ static int vcnl3020_write_raw(struct iio_dev
> > *indio_dev,
> >  	int rc;
> >  	struct vcnl3020_data *data = iio_priv(indio_dev);
> > 
> > +	/* Protect against event capture. */
> > +	if (vcnl3020_is_in_periodic_mode(data))
> > +		return -EBUSY;  
> 
> ditto...
> 
> [1]: https://marc.info/?l=linux-kernel&m=162556231125061&w=2
> - Nuno Sá
> 
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		rc = iio_device_claim_direct_mode(indio_dev);
> > @@ -287,6 +529,10 @@ static const struct iio_info vcnl3020_info = {
> >  	.read_raw = vcnl3020_read_raw,
> >  	.write_raw = vcnl3020_write_raw,
> >  	.read_avail = vcnl3020_read_avail,
> > +	.read_event_value = vcnl3020_read_event,
> > +	.write_event_value = vcnl3020_write_event,
> > +	.read_event_config = vcnl3020_read_event_config,
> > +	.write_event_config = vcnl3020_write_event_config,
> >  };
> > 
> >  static const struct regmap_config vcnl3020_regmap_config = {
> > @@ -295,6 +541,40 @@ static const struct regmap_config
> > vcnl3020_regmap_config = {
> >  	.max_register	= VCNL_PS_MOD_ADJ,
> >  };
> > 
> > +static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev = p;
> > +	struct vcnl3020_data *data = iio_priv(indio_dev);
> > +	unsigned int isr;
> > +	int rc;
> > +
> > +	rc = regmap_read(data->regmap, VCNL_ISR, &isr);
> > +	if (rc) {
> > +		dev_err(data->dev, "Error (%d) reading reg (0x%x)\n",
> > +			rc, VCNL_ISR);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (isr & VCNL_ICR_THRES_EN) {
> > +		iio_push_event(indio_dev,
> > +
> > IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> > +						    1,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_RISING),
> > +			       iio_get_time_ns(indio_dev));
> > +
> > +		rc = regmap_write(data->regmap, VCNL_ISR,
> > +				  isr & VCNL_ICR_THRES_EN);
> > +		if (rc)
> > +			dev_err(data->dev, "Error (%d) writing in reg
> > (0x%x)\n",
> > +				rc, VCNL_ISR);
> > +	} else {
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int vcnl3020_probe(struct i2c_client *client)
> >  {
> >  	struct vcnl3020_data *data;
> > @@ -327,6 +607,19 @@ static int vcnl3020_probe(struct i2c_client
> > *client)
> >  	indio_dev->name = "vcnl3020";
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > 
> > +	if (client->irq) {
> > +		rc = devm_request_threaded_irq(&client->dev, client-  
> > >irq,  
> > +					       NULL,
> > vcnl3020_handle_irq_thread,
> > +					       IRQF_ONESHOT, indio_dev-  
> > >name,  
> > +					       indio_dev);
> > +		if (rc) {
> > +			dev_err(&client->dev,
> > +				"Error (%d) irq request failed (%u)\n",
> > rc,
> > +				client->irq);
> > +			return rc;
> > +		}
> > +	}
> > +
> >  	return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> > 
> > --
> > 2.31.1  
> 

