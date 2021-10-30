Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3CD440A36
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhJ3QkP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 12:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229694AbhJ3QkP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 12:40:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4AAA60E76;
        Sat, 30 Oct 2021 16:37:42 +0000 (UTC)
Date:   Sat, 30 Oct 2021 17:42:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, swboyd@chromium.org, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: sx9310: Extract common Semtech sensor logic
Message-ID: <20211030174210.207481ed@jic23-huawei>
In-Reply-To: <20211030111827.1494139-3-gwendal@chromium.org>
References: <20211030111827.1494139-1-gwendal@chromium.org>
        <20211030111827.1494139-3-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 Oct 2021 04:18:24 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Before adding new Semtech sensors, move common logic to all Semtech SAR
> sensor in its own file:
> - interface with IIO subsystem,
> - interrupt management,
> - channel access conrol,
> - event processing.
> 
> The change adds a bidirectional interface between sx93xx and sx_common.
> 
> The change is quite mechanical, as the impacted functions are moved
> and renamed.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Hi Gwendal,

The 2 step approach used for a common probe is unusual and I'm not sure
it's a good idea.   I'd be more inclined to have a single probe function
and pass some static const data into there to fill in most of the stuff
you have left in the individual driver.

See below.

Jonathan

> ---
>  drivers/iio/proximity/sx9310.c          | 629 +++---------------------
>  drivers/iio/proximity/sx_common.c       | 618 +++++++++++++++++++++++
>  include/linux/iio/proximity/sx_common.h | 129 +++++

What Lars said on location.  drivers/iio/proximity/sx_common.h


>  3 files changed, 803 insertions(+), 573 deletions(-)
>  create mode 100644 drivers/iio/proximity/sx_common.c
>  create mode 100644 include/linux/iio/proximity/sx_common.h
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 31d060c1b0103..577a16789f8b2 100644
> --- a/drivers/iio/proximity/sx9310.c
...

>  static int sx9310_probe(struct i2c_client *client)
>  {
>  	int ret;
>  	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
> -	struct sx9310_data *data;
> +	struct sx_common_data *data;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	data->client = client;
> -	data->supplies[0].supply = "vdd";
> -	data->supplies[1].supply = "svdd";
> -	mutex_init(&data->mutex);
> -	init_completion(&data->completion);
> -
> -	data->regmap = devm_regmap_init_i2c(client, &sx9310_regmap_config);
> -	if (IS_ERR(data->regmap))
> -		return PTR_ERR(data->regmap);
> -
> -	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> -				      data->supplies);
> -	if (ret)
> -		return ret;
> +	data->reg_stat = SX9310_REG_STAT0;
> +	data->reg_irq_msk = SX9310_REG_IRQ_MSK;
> +	data->reg_enable_chan = SX9310_REG_PROX_CTRL0;
> +	data->reg_reset = SX9310_REG_RESET;
>  
> -	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> -	if (ret)
> -		return ret;
> -	/* Must wait for Tpor time after initial power up */
> -	usleep_range(1000, 1100);
> +	data->mask_enable_chan = SX9310_REG_STAT1_COMPSTAT_MASK;
> +	data->irq_msk_offset = 3;
> +	data->num_channels = SX9310_NUM_CHANNELS;
>  
> -	ret = devm_add_action_or_reset(dev, sx9310_regulator_disable, data);
> +	/* Number of default registers to set at init */
> +	data->num_default_regs = ARRAY_SIZE(sx9310_default_regs);
> +
> +	ret = sx_common_probe_setup(indio_dev, client, &sx9310_regmap_config);
>  	if (ret)
>  		return ret;
>  
> @@ -1430,58 +948,23 @@ static int sx9310_probe(struct i2c_client *client)
>  		return ret;
>  	}
>  
> -	ret = sx9310_set_indio_dev_name(dev, indio_dev, data->whoami);
> -	if (ret)
> -		return ret;
> +	/* Low level entry points */
> +	data->read_prox_data = sx9310_read_prox_data;
> +	data->init_compensation = sx9310_init_compensation;
> +	data->wait_for_sample = sx9310_wait_for_sample;
> +	data->get_default_reg = sx9310_get_default_reg;
>  
> -	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
>  	indio_dev->channels = sx9310_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(sx9310_channels);
>  	indio_dev->info = &sx9310_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	i2c_set_clientdata(client, indio_dev);
> -
> -	ret = sx9310_init_device(indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	if (client->irq) {
> -		ret = devm_request_threaded_irq(dev, client->irq,
> -						sx9310_irq_handler,
> -						sx9310_irq_thread_handler,
> -						IRQF_ONESHOT,
> -						"sx9310_event", indio_dev);
> -		if (ret)
> -			return ret;
> -
> -		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> -						    indio_dev->name,
> -						    iio_device_id(indio_dev));
> -		if (!data->trig)
> -			return -ENOMEM;
> -
> -		data->trig->ops = &sx9310_trigger_ops;
> -		iio_trigger_set_drvdata(data->trig, indio_dev);
> -
> -		ret = devm_iio_trigger_register(dev, data->trig);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      iio_pollfunc_store_time,
> -					      sx9310_trigger_handler,
> -					      &sx9310_buffer_setup_ops);
> -	if (ret)
> -		return ret;
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	return sx_common_probe_register(indio_dev);
>  }
>  

...

> new file mode 100644
> index 0000000000000..1dd5dcb75de71
> --- /dev/null
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -0,0 +1,618 @@

...

> +
> +/**
> + * sx_common_read_event_config() - Configure event setting.
> + *
> + * IIO vector to return the current event configuration.
> + */
> +int sx_common_read_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +
> +	return !!(data->chan_event & BIT(chan->channel));
> +}
> +EXPORT_SYMBOL_GPL(sx_common_read_event_config);
> +
> +/**
> + * sx_common_write_event_config() - Configure event setting.

kernel-doc should be complete. Please check the files by pointing
scripts/kernel-doc at them as it will warn about this.

> + *
> + * IIO vector to enable/disable events.
> + */
> +int sx_common_write_event_config(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 enum iio_event_type type,
> +				 enum iio_event_direction dir, int state)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	unsigned int eventirq = SX_COMMON_FAR_IRQ | SX_COMMON_CLOSE_IRQ;
> +	int ret;
> +
> +	/* If the state hasn't changed, there's nothing to do. */
> +	if (!!(data->chan_event & BIT(chan->channel)) == state)
> +		return 0;
> +
> +	mutex_lock(&data->mutex);
> +	if (state) {
> +		ret = sx_common_get_event_channel(data, chan->channel);
> +		if (ret)
> +			goto out_unlock;
> +		if (!(data->chan_event & ~BIT(chan->channel))) {
> +			ret = sx_common_enable_irq(data, eventirq);
> +			if (ret)
> +				sx_common_put_event_channel(data, chan->channel);
> +		}
> +	} else {
> +		ret = sx_common_put_event_channel(data, chan->channel);
> +		if (ret)
> +			goto out_unlock;
> +		if (!data->chan_event) {
> +			ret = sx_common_disable_irq(data, eventirq);
> +			if (ret)
> +				sx_common_get_event_channel(data, chan->channel);
> +		}
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sx_common_write_event_config);

...


> +
> +const struct iio_buffer_setup_ops sx_common_buffer_setup_ops = {
> +	.preenable = sx_common_buffer_preenable,
> +	.postdisable = sx_common_buffer_postdisable,
> +};
> +EXPORT_SYMBOL_GPL(sx_common_buffer_setup_ops);

Why?  Currently only used in here. If you need to do this for a later
patch please do it in that patch.

> +
> +static int sx_common_set_indio_dev_name(struct device *dev,
> +					struct iio_dev *indio_dev,
> +					unsigned int whoami)
> +{
> +	unsigned int long ddata;
> +
> +	ddata = (uintptr_t)device_get_match_data(dev);
> +	if (ddata != whoami) {
> +		dev_err(dev, "WHOAMI does not match device data: %u\n", whoami);
> +		return -ENODEV;
> +	}
> +
> +	switch (whoami) {
> +	case SX9310_WHOAMI_VALUE:
> +		indio_dev->name = "sx9310";
> +		break;
> +	case SX9311_WHOAMI_VALUE:
> +		indio_dev->name = "sx9311";
> +		break;
> +	case SX9324_WHOAMI_VALUE:

Too early. You don't support these yet...  Also this is a job for
the drivers implementing the per device type support.  Move it out there
and pass the name into the common probe.


> +		indio_dev->name = "sx9324";
> +		break;
> +	case SX9360_WHOAMI_VALUE:
> +		indio_dev->name = "sx9360";
> +		break;
> +	default:
> +		dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sx_common_regulator_disable(void *_data)
> +{
> +	struct sx_common_data *data = _data;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> +}
> +
> +#define SX_COMMON_SOFT_RESET				0xde
> +
> +static int sx_common_init_device(struct iio_dev *indio_dev)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	struct sx_common_reg_default tmp;
> +	const struct sx_common_reg_default *initval;
> +	int ret;
> +	unsigned int i, val;
> +
> +	ret = regmap_write(data->regmap, data->reg_reset, SX_COMMON_SOFT_RESET);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000); /* power-up time is ~1ms. */
> +
> +	/* Clear reset interrupt state by reading SX_COMMON_REG_IRQ_SRC. */
> +	ret = regmap_read(data->regmap, SX_COMMON_REG_IRQ_SRC, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Program some sane defaults. */
> +	for (i = 0; i < data->num_default_regs; i++) {
> +		initval = data->get_default_reg(&indio_dev->dev, i, &tmp);
> +		ret = regmap_write(data->regmap, initval->reg, initval->def);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return data->init_compensation(indio_dev);
> +}
> +
> +/**
> + * sx_common_probe_setup() - Common setup for Semtech SAR sensor
> + * @indio_dev:		iio device structure of the device
> + * @client:		I2C client object
> + * @regmap_config:	Sensor registers map configuration.
> + */
> +int sx_common_probe_setup(struct iio_dev *indio_dev,
> +			  struct i2c_client *client,
> +			  const struct regmap_config *regmap_config)
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	data->client = client;
> +	data->supplies[0].supply = "vdd";
> +	data->supplies[1].supply = "svdd";
> +	mutex_init(&data->mutex);
> +	init_completion(&data->completion);
> +
> +	data->regmap = devm_regmap_init_i2c(client, regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> +				      data->supplies);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> +	if (ret)
> +		return ret;
> +	/* Must wait for Tpor time after initial power up */
> +	usleep_range(1000, 1100);
> +
> +	ret = devm_add_action_or_reset(dev, sx_common_regulator_disable, data);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
It will go anyway if you follow suggestion below, but...

	return devm_add_action...

btw one of the static checkers loves this so if you don't 'fix' it on submission
we'll just end up with an annoying tidy up patch a few weeks later :)

> +}
> +EXPORT_SYMBOL_GPL(sx_common_probe_setup);
> +
> +/**
> + * sx_common_probe_register() - Common register function for Semtech SAR sensor
> + * @indio_dev:		iio device structure of the device
> + *
> + * Register the IRQ handlers and trigger object.
> + * Register to the IIO subsystem.
> + */
> +int sx_common_probe_register(struct iio_dev *indio_dev)

Interesting to do a split register like this.  You might be better
off passing a const structure into an sx_common_probe() with all
the relevant data to copy to it's final destination.  Particularly as
much of it is constant - or ops.

I'd have something like.

struct sx_ops {
	int (*read_prox_data)(struct sx_common_data *data,
			      const struct iio_chan_spec *chan, __be16 *val);
	int (*init_compensation)(struct iio_dev *indio_dev);
	int (*wait_for_sample)(struct sx_common_data *data);
	const struct sx_common_reg_default *
		(*get_default_reg)(struct device *dev, int idx,
				   struct sx_common_reg_default *reg_def);
};

struct sx_chip_info {
	unsigned int reg_stat;
	unsigned int reg_irq_msk;
	unsigned int reg_enable_chan;
	unsigned int reg_reset;
	unsigned int mask_enable_chan;
	unsigned int irq_msk_offset;
	int num_default_regs;
	struct iio_chan_spec *channels; /* copy this into place in probe_common() */
	int num_channels; /* copy into place in probe_common()
	struct sx_ops ops; /* As it's all const you just have the ops inline */
	struct iio_info *info;
	// some other stuff like attributes, though might be better to convert that over
	// to read_avail() before doing the rest of this if possible.
};

Have a static const instance of this an pass it into a single probe function that does
all your setup.

Everything else plus a pointer to the sx_chip_info structure in your struct sx_common_data

That small amount of indirection means a lot of stuff is now constant that we had to
set in code before.
 
> +{
> +	struct sx_common_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	struct device *dev = &client->dev;
> +	int ret;
> +
> +	ret = sx_common_set_indio_dev_name(dev, indio_dev, data->whoami);
> +	if (ret)
> +		return ret;
> +
> +	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = sx_common_init_device(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(dev, client->irq,
> +						sx_common_irq_handler,
> +						sx_common_irq_thread_handler,
> +						IRQF_ONESHOT,
> +						"sx_event", indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						    indio_dev->name,
> +						    iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->ops = &sx_common_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, data->trig);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      sx_common_trigger_handler,
> +					      &sx_common_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(sx_common_probe_register);
> +
> +MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
> +MODULE_DESCRIPTION("Common functions and structures for Semtech sensor");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/proximity/sx_common.h b/include/linux/iio/proximity/sx_common.h
> new file mode 100644
> index 0000000000000..60c3291e7925c
> --- /dev/null
> +++ b/include/linux/iio/proximity/sx_common.h
> @@ -0,0 +1,129 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Code shared between the different Qualcomm PMIC voltage ADCs
> + */
> +
> +#ifndef IIO_SX_COMMON_H
> +#define IIO_SX_COMMON_H
> +
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

drop regmap.h and provide the forwards defintions for the few structures need
for pointers.  But some missing that should be here.

#include <linux/bitops.h>
#include <linux/completion.h>
#include <linux/mutex.h>

struct regmap;
struct regmap_config;
struct iio_chan_spec;
struct iio_device;
struct iio_trigger;
struct i2c_client;

etc

I'm trying to scrub the IIO includes to sort this stuff out, so not keen to
see more unnecessary or missing includes to clean up.

More or less always include the headers you use in a file and ensure you don't
include ones you don't have to.

> +
> +#define SX_COMMON_REG_IRQ_SRC				0x00
> +
> +#define   SX9310_WHOAMI_VALUE				0x01
> +#define   SX9311_WHOAMI_VALUE				0x02
> +#define   SX9324_WHOAMI_VALUE				0x23
> +#define   SX9360_WHOAMI_VALUE				0x60
> +
> +#define SX_COMMON_MAX_NUM_CHANNELS	4
> +static_assert(SX_COMMON_MAX_NUM_CHANNELS < BITS_PER_LONG);
> +
> +struct sx_common_reg_default {
> +	u8 reg;
> +	u8 def;
> +};
> +
> +/**
> + * struct sx_common_data: Semtech Sensor private data structure.
> +	@reg_stat:	Main status register address.
> +	@reg_irq_msk:	IRQ mask register address.
> +	@reg_enable_chan: Address to enable/disable channels/phases.
> +	@reg_reset:	Reset register address.
> +
> +	@mask_enable_chan: Mask over the channels bits in the enable channel
> +			   register.
> +	@irq_msk_offset:	Offset to enable interrupt in the IRQ mask
> +				register.
> +
> +	@mutex:		Serialize access to registers and channel configuration.
> +	@num_channels:	Number of channel/phase.
> +	@completion:	completion object to wait for data acquisition.
> +	@client:	I2C client structure.
> +	@trig:		IIO trigger object.
> +	@regmap:	Register map.
> +
> +	@num_default_regs: Number of default registers to set at init.
> +	@supplies:	Power supplies object.
> +	@chan_prox_stat: Last reading of the proximity status for each channel.
> +			 We only send an event to user space when this changes.
> +	@trigger_enabled: True when the device trigger is enabled.
> +
> +	@buffer:	Bufffer to store raw samples.
> +	@suspend_ctrl:  Remember enabled channels and sample rate during suspend.
> +	@chan_read:	Bit field for each raw channel enabled.
> +	@chan_event:	Bit field for each event enabled.
> +	@whoami:	Content of WHOAMI register.
> +
> +	@read_prox_data: Function to read proximity data.
> +	@init_compensation: Function to set initial compensation.
> +	@wait_for_sample: When there are no physical IRQ, function to wait for a
> +			sample to be ready.

get_default_reg is missing.

> + */
> +struct sx_common_data {
> +	unsigned int reg_stat;
> +	unsigned int reg_irq_msk;
> +	unsigned int reg_enable_chan;
> +	unsigned int reg_reset;
> +
> +	unsigned int mask_enable_chan;
> +	unsigned int irq_msk_offset;
> +
> +	struct mutex mutex;
> +	unsigned int num_channels;
> +	struct completion completion;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +
> +	int num_default_regs;
> +	struct regulator_bulk_data supplies[2];
> +	unsigned long chan_prox_stat;
> +	bool trigger_enabled;
> +
> +	/* Ensure correct alignment of timestamp when present. */
> +	struct {
> +		__be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
> +		s64 ts __aligned(8);
> +	} buffer;
> +
> +	unsigned int suspend_ctrl;
> +	unsigned long chan_read;
> +	unsigned long chan_event;
> +	unsigned int whoami;
> +
> +	int (*read_prox_data)(struct sx_common_data *data,
> +			      const struct iio_chan_spec *chan, __be16 *val);
> +	int (*init_compensation)(struct iio_dev *indio_dev);
> +	int (*wait_for_sample)(struct sx_common_data *data);
> +	const struct sx_common_reg_default *
> +		(*get_default_reg)(struct device *dev, int idx,
> +				   struct sx_common_reg_default *reg_def);
These look to be constant ops pointers. Break them out to a separate structure
and that can then be static const in the individual drivers.

Good thing to do form a security point of view and normally ends
up simpler.

> +};
> +
> +int sx_common_read_avail(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 const int **vals, int *type, int *length,
> +			 long mask);
> +
> +int sx_common_read_proximity(struct sx_common_data *data,
> +			     const struct iio_chan_spec *chan, int *val);
> +
> +int sx_common_read_event_config(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir);
> +int sx_common_write_event_config(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 enum iio_event_type type,
> +				 enum iio_event_direction dir, int state);
> +
> +int sx_common_probe_setup(struct iio_dev *indio_dev,
> +			  struct i2c_client *client,
> +			  const struct regmap_config *regmap_config);
> +int sx_common_probe_register(struct iio_dev *indio_dev);
> +
> +extern const struct iio_buffer_setup_ops sx_common_buffer_setup_ops;
> +extern const struct iio_event_spec sx_common_events[3];
> +
> +#endif  /* IIO_SX_COMMON_H */

