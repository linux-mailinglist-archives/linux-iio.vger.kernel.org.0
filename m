Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDC31EB94
	for <lists+linux-iio@lfdr.de>; Thu, 18 Feb 2021 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhBRP30 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Feb 2021 10:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233122AbhBROGM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Feb 2021 09:06:12 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD7D64EAD;
        Thu, 18 Feb 2021 14:05:09 +0000 (UTC)
Date:   Thu, 18 Feb 2021 14:05:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Mihail Chindris <Mihail.Chindris@analog.com>,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 5/5] iio: dac: ad5686: Add PWM as a trigger source
Message-ID: <20210218140506.02b28d8a@archlinux>
In-Reply-To: <20210217083438.37865-6-alexandru.ardelean@analog.com>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
        <20210217083438.37865-6-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 17 Feb 2021 10:34:38 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Mircea Caprioru <mircea.caprioru@analog.com>
> 
> A PWM signal will be used as a trigger source to have a deterministic
> sampling frequency since this family of DAC has no hardware interrupt
> source.
> 
> This feature is made optional however, as there are some board setups where
> this isn't used.
> 

So this is taking a very generic setup, but then implementing it
as a bit of a hack within the driver.

It's effectively a PWM connected up to an instance
of iio/triggers/iio-trig-interrupt.c

Now, I've not looked at that trigger driver for a while, so you may well
need to figure out how to add a binding to instantiate it.
(looks like no one has used it since board file days, or via instantiation
from another driver).

It's a slightly odd corner case as what it reflects is that we have
an interrupt available that is intended to drive some sort of data
capture or output (it's a trigger signal) - but exactly what is done
is a runtime configurable.  In this particular case that interrupt
is hooked up to a PWM and we also want to represent that.

The fact it's being driven via a PWM is interesting but we should be
able to extend that trigger driver to optionally accept a pwm provider
and if it has one provide frequency control.

Binding might look something like the following..

interrupt-trigger {
   interrupts = <>;
   pwms = <&pwm 0 4000 PWM_POLARITY_INVERTED>;	
};

@Rob, what do you think of this odd beast?

So all in all, this generic facility needs a generic implementation, not
one buried in a driver.

Another open question here is whether you really can't just use an hrtimer
to get similar precision?  Way back at the dawn of time in IIO we had
code to use the RTC periodic ticks as a trigger with the theory that they
would give very precise and even timing.  In the end it turned out that
hrtimers worked just as well (and RTCs drivers emulated the periodic
ticks via hrtimers, dropping their use of the hardware periodic timers).

Jonathan



> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> Signed-off-by: Mihail Chindris <Mihail.Chindris@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/dac/ad5686-spi.c |   2 +-
>  drivers/iio/dac/ad5686.c     | 146 ++++++++++++++++++++++++++++++++++-
>  drivers/iio/dac/ad5686.h     |   7 +-
>  drivers/iio/dac/ad5696-i2c.c |   2 +-
>  4 files changed, 152 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 0188ded5137c..07fadcf8e1e3 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -92,7 +92,7 @@ static int ad5686_spi_probe(struct spi_device *spi)
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  
>  	return ad5686_probe(&spi->dev, id->driver_data, id->name,
> -			    ad5686_spi_write, ad5686_spi_read);
> +			    ad5686_spi_write, ad5686_spi_read, spi->irq);
>  }
>  
>  static int ad5686_spi_remove(struct spi_device *spi)
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 7d6792ac1020..9e48559ec566 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -16,6 +16,10 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #include "ad5686.h"
>  
> @@ -123,6 +127,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> +	struct pwm_state state;
>  	int ret;
>  
>  	switch (m) {
> @@ -139,6 +144,10 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  		*val = st->vref_mv;
>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		pwm_get_state(st->pwm, &state);
> +		*val = DIV_ROUND_CLOSEST_ULL(1000000000ULL, state.period);
> +		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;
>  }
> @@ -150,6 +159,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> +	struct pwm_state state;
>  	int ret;
>  
>  	switch (mask) {
> @@ -164,6 +174,14 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  				val << chan->scan_type.shift);
>  		mutex_unlock(&st->lock);
>  		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		pwm_get_state(st->pwm, &state);
> +
> +		state.period = DIV_ROUND_CLOSEST_ULL(1000000000ULL, val);
> +		pwm_set_relative_duty_cycle(&state, 50, 100);
> +
> +		ret = pwm_apply_state(st->pwm, &state);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -171,7 +189,37 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int ad5686_trig_set_state(struct iio_trigger *trig,
> +				 bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +	struct pwm_state pwm_st;
> +
> +	pwm_get_state(st->pwm, &pwm_st);
> +	pwm_st.enabled = state;
> +
> +	return pwm_apply_state(st->pwm, &pwm_st);
> +}
> +
> +static int ad5686_validate_trigger(struct iio_dev *indio_dev,
> +				    struct iio_trigger *trig)
> +{
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +
> +	if (st->trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops ad5686_trigger_ops = {
> +	.validate_device = &iio_trigger_validate_own_device,
> +	.set_trigger_state = &ad5686_trig_set_state,
> +};
> +
>  static const struct iio_info ad5686_info = {
> +	.validate_trigger = &ad5686_validate_trigger,
>  	.read_raw = ad5686_read_raw,
>  	.write_raw = ad5686_write_raw,
>  };
> @@ -194,8 +242,10 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
>  		.output = 1,					\
>  		.channel = chan,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
> +					    BIT(IIO_CHAN_INFO_SAMP_FREQ),\
>  		.address = addr,				\
> +		.scan_index = chan,				\
>  		.scan_type = {					\
>  			.sign = 'u',				\
>  			.realbits = (bits),			\
> @@ -428,13 +478,57 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
>  	},
>  };
>  
> +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	const struct iio_chan_spec *chan;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +	u8 sample[2];
> +	unsigned int i;
> +	u16 val;
> +	int ret;
> +
> +	ret = iio_buffer_remove_sample(buffer, sample);
> +	if (ret < 0)
> +		goto out;
> +
> +	mutex_lock(&st->lock);
> +	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> +		val = (sample[1] << 8) + sample[0];
> +
> +		chan = iio_find_channel_from_si(indio_dev, i);
> +		ret = st->write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> +				chan->address, val << chan->scan_type.shift);
> +	}
> +	mutex_unlock(&st->lock);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ad5686_irq_handler(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct ad5686_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll(st->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  int ad5686_probe(struct device *dev,
>  		 enum ad5686_supported_device_ids chip_type,
>  		 const char *name, ad5686_write_func write,
> -		 ad5686_read_func read)
> +		 ad5686_read_func read, int irq)
>  {
>  	struct ad5686_state *st;
>  	struct iio_dev *indio_dev;
> +	struct pwm_state state;
>  	unsigned int val, ref_bit_msk;
>  	u8 cmd;
>  	int ret, i, voltage_uv = 0;
> @@ -450,6 +544,23 @@ int ad5686_probe(struct device *dev,
>  	st->write = write;
>  	st->read = read;
>  
> +	mutex_init(&st->lock);
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", name, indio_dev->id);
> +	if (st->trig == NULL)
> +		ret = -ENOMEM;
> +
> +	st->trig->ops = &ad5686_trigger_ops;
> +	st->trig->dev.parent = dev;
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	/* select default trigger */
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
>  	st->reg = devm_regulator_get_optional(dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
> @@ -463,6 +574,30 @@ int ad5686_probe(struct device *dev,
>  		voltage_uv = ret;
>  	}
>  
> +	/* PWM configuration */
> +	st->pwm = devm_pwm_get(dev, "pwm-trigger");
> +	if (!IS_ERR(st->pwm)) {
> +		/* Set a default pwm frequency of 1kHz and 50% duty cycle */
> +		pwm_init_state(st->pwm, &state);
> +		state.enabled = false;
> +		state.period = 1000000;
> +		pwm_set_relative_duty_cycle(&state, 50, 100);
> +		ret = pwm_apply_state(st->pwm, &state);
> +		if (ret < 0)
> +			return ret;
> +	}

Hmm. This shouldn't be part of the individual device driver.
It's just an irq trigger that happens to be driven from a pwm.


> +
> +	/* Configure IRQ */
> +	if (irq) {
> +		ret = devm_request_threaded_irq(dev, irq, NULL, ad5686_irq_handler,
> +						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +						"ad5686 irq", indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		st->irq = irq;
> +	}
> +
>  	st->chip_info = &ad5686_chip_info_tbl[chip_type];
>  
>  	if (voltage_uv)
> @@ -513,6 +648,13 @@ int ad5686_probe(struct device *dev,
>  	if (ret)
>  		goto error_disable_reg;
>  
> +	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
> +						  &ad5686_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_OUT,
> +						  NULL, NULL);
> +	if (ret)
> +		goto error_disable_reg;
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;
