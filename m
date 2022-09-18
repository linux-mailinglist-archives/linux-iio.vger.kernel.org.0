Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA185BBE9D
	for <lists+linux-iio@lfdr.de>; Sun, 18 Sep 2022 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIRPRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Sep 2022 11:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIRPRA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2022 11:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC781B790
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 08:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69E5860B50
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2022 15:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A44C433D6;
        Sun, 18 Sep 2022 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663514217;
        bh=fEHubfe+pokxyb9Xf6Lz0f/qI7qrynmHFmBiUx0+b94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T0lZs5aX1fkucxAV0vOIb7djnzu7L5Z9tvBlvKPE+Mo1WIIV9SfTw9H6j2DTLSHBk
         SXMIYCoy3qWIGCLAjvaMgzUUHegbOHW9bflHjpQQHIX6oRGtiuGu5JxKg1Ia2q7pkn
         TK6EJoMrhc00+8uo+ISD/2njQFZdJaKFGPW3X4fkPczC8uQ8FaqDFLOxgIo+YSd47Y
         3TCnhR1J3uoIyKJCLEwb9XLLqdNQ+o5IIVMEJCzFFI7t+JG1VyRxac7N3gFrmqnry/
         vcdQS/IXpTLTZCZj580IJfU9i3cx1YI4EJ58uDkG355yD9P7lgTGCgwQ3tv7TMLXKq
         Bf9utZ36m8uUw==
Date:   Sun, 18 Sep 2022 16:17:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: Re: [PATCH v4 1/3] iio: adc: add max11410 adc driver
Message-ID: <20220918161701.1626376e@jic23-huawei>
In-Reply-To: <20220908144924.205547-2-Ibrahim.Tilki@analog.com>
References: <20220908144924.205547-1-Ibrahim.Tilki@analog.com>
        <20220908144924.205547-2-Ibrahim.Tilki@analog.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 8 Sep 2022 17:49:22 +0300
Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:

> Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
> has 3 differential reference and 10 differential channel inputs.
> Inputs and references can be buffered internally. Inputs can also
> be amplified with internal PGA.
> 
> Device has four digital filter modes: FIR50/60, FIR50, FIR60 and SINC4.
> FIR 50Hz and 60Hz rejections can be enabled/disabled separately.
> Digital filter selection affects sampling frequency range so driver
> has to consider the configured filter when configuring sampling frequency.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>

Hi Ibrahim,

Sorry for slow reply - busy week at Linux Plumbers.

Anyhow, a few new things introduced by v4 and looks like I missed
that you have a deadlock.

See inline,

Jonathan


> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> new file mode 100644
> index 000000000..7c1d0e725
> --- /dev/null
> +++ b/drivers/iio/adc/max11410.c
> @@ -0,0 +1,1051 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MAX11410 SPI ADC driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>

See below, but an of specific include is a bad sign in a modern driver.
There isn't anything in here that doesn't have support in property.h now
to enable various types of firmware (potentially at least!)

> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +

> +
> +struct max11410_state {
> +	struct spi_device *spi_dev;
> +	struct iio_trigger *trig;
> +	struct completion completion;
> +	struct mutex lock; /* Prevent changing channel config during sampling */
> +	struct regmap *regmap;
> +	struct regulator *avdd;
> +	struct regulator *vrefp[3];
> +	struct regulator *vrefn[3];
> +	struct max11410_channel_config *channels;
> +	struct {
> +		int data __aligned(IIO_DMA_MINALIGN);

int is not sized which seems unwise. Given this is about alignment of
data in the buffer you need to be careful, so make it a u32.


> +		s64 ts __aligned(8);
> +	} scan;
> +};
> +
> +static const struct iio_chan_spec chanspec_template = {
> +	.type = IIO_VOLTAGE,
> +	.indexed = 1,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			      BIT(IIO_CHAN_INFO_SCALE) |
> +			      BIT(IIO_CHAN_INFO_OFFSET),
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.scan_type = {
> +		.sign = 's',
> +		.realbits = 24,
> +		.storagebits = 24,

I guess I missed this before, but storagebits is a power of 2 to allow
for efficient non packed accessing.  So 32 here.  You might see odd results
if you were to run in buffered mode with the timestamp disabled for example.
Userspace code tends to correctly assume power of 2 storage bits elements in the scan.

> +		.endianness = IIO_LE,
> +	},
> +};
> +

> +
> +static int max11410_sample(struct max11410_state *st, int *sample_raw,
> +			   struct iio_chan_spec const *chan)
> +{
> +	int val, ret;
> +
> +	ret = max11410_configure_channel(st, chan);
> +	if (ret)
> +		return ret;
> +
> +	if (st->spi_dev->irq > 0)
> +		reinit_completion(&st->completion);
> +
> +	/* Start Conversion */
> +	ret = max11410_write_reg(st, MAX11410_REG_CONV_START,
> +				 MAX11410_CONV_TYPE_SINGLE);
> +	if (ret)
> +		return ret;
> +
> +	if (st->spi_dev->irq > 0) {

All this irq stuff should be via the irq that you get from
fwnode_irq_by_name(), not the one cached in the spi_dev.
Obviously it doesn't matter that much as you are just using it
as a flag here, but it's better to use the right source for that flag.

> +		/* Wait for an interrupt. */
> +		ret = wait_for_completion_timeout(&st->completion,
> +						  msecs_to_jiffies(MAX11410_CONVERSION_TIMEOUT_MS));
> +		if (!ret)
> +			return -ETIMEDOUT;
> +	} else {
> +		/* Wait for status register Conversion Ready flag */
> +		ret = read_poll_timeout(max11410_read_reg, ret,
> +					ret || (val & MAX11410_STATUS_CONV_READY_BIT),
> +					5000, MAX11410_CONVERSION_TIMEOUT_MS * 1000,
> +					true, st, MAX11410_REG_STATUS, &val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Read ADC Data */
> +	return max11410_read_reg(st, MAX11410_REG_DATA0, sample_raw);
> +}
> +

> +
> +static int max11410_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct max11410_state *state = iio_priv(indio_dev);
> +	struct max11410_channel_config cfg = state->channels[chan->address];
> +	int ret, reg_val, filter, rate;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = max11410_get_scale(state, cfg);
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (cfg.bipolar)
> +			*val = -BIT(chan->scan_type.realbits - 1);
> +		else
> +			*val = 0;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&state->lock);
> +
> +		ret = max11410_sample(state, &reg_val, chan);
> +
> +		mutex_unlock(&state->lock);
> +
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(state->regmap, MAX11410_REG_FILTER, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		filter = FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
> +		rate = reg_val & MAX11410_FILTER_RATE_MASK;
> +		if (rate >= max11410_sampling_len[filter])
> +			rate = max11410_sampling_len[filter] - 1;
> +
> +		*val = max11410_sampling_rates[filter][rate][0];
> +		*val2 = max11410_sampling_rates[filter][rate][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	return -EINVAL;
> +}
> +
> +static int max11410_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct max11410_state *st = iio_priv(indio_dev);
> +	int i, ret, reg_val, filter, gain;
> +	u32 *scale_avail;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		scale_avail = st->channels[chan->address].scale_avail;
> +		if (!scale_avail)
> +			return -EOPNOTSUPP;
> +
> +		/* Accept values in range 0.000001 <= scale < 1.000000 */
> +		if (val != 0 || val2 == 0)
> +			return -EINVAL;
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		/* Convert from INT_PLUS_MICRO to FRACTIONAL_LOG2 */
> +		val2 = val2 * DIV_ROUND_CLOSEST(BIT(24), 1000000);
> +		val2 = DIV_ROUND_CLOSEST(scale_avail[0], val2);
> +		gain = order_base_2(val2);
> +
> +		st->channels[chan->address].gain = clamp_val(gain, 0, 7);
> +
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
> +
> +		ret = regmap_read(st->regmap, MAX11410_REG_FILTER, &reg_val);
> +		if (ret)
> +			goto out;
> +
> +		filter = FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
> +
> +		for (i = 0; i < max11410_sampling_len[filter]; ++i) {
> +			if (val == max11410_sampling_rates[filter][i][0] &&
> +			    val2 == max11410_sampling_rates[filter][i][1])
> +				break;
> +		}
> +		if (i == max11410_sampling_len[filter]) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			goto out;
> +
> +		ret = regmap_write_bits(st->regmap, MAX11410_REG_FILTER,
> +					MAX11410_FILTER_RATE_MASK, i);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +out:
> +		mutex_unlock(&st->lock);

Hmm. This could be problematic.  Normally we claim direct_mode (which takes
iio_dev->mlock) before we grab a driver specific lock.  
You've done that in some paths here, and in others you have reversed
the ordering. As such I think we have a deadlock (vs read_raw, _RAW path
above for example)

I may have missed other instances, so please look at that carefully.

 
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int max11410_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long info)
> +{
> +	struct max11410_state *st = iio_priv(indio_dev);
> +	struct max11410_channel_config cfg;
> +	int ret, reg_val, filter;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(st->regmap, MAX11410_REG_FILTER, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		filter = FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
> +
> +		*vals = (const int *)max11410_sampling_rates[filter];
> +		*length = max11410_sampling_len[filter] * 2;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		cfg = st->channels[chan->address];
> +
> +		if (!cfg.scale_avail)
> +			return -EINVAL;
> +
> +		*vals = cfg.scale_avail;
> +		*length = 8 * 2;

Better to add a define for that 8 and then use that to enforce this list
is always of that size at point of allocation and access.

> +		*type = IIO_VAL_FRACTIONAL_LOG2;
> +
> +		return IIO_AVAIL_LIST;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info max11410_info = {
> +	.read_raw = max11410_read_raw,
> +	.write_raw = max11410_write_raw,
> +	.read_avail = max11410_read_avail,
> +	.attrs = &max11410_attribute_group,
> +};

> +
> +static int max11410_init_vref(struct device *dev,
> +			      struct regulator **vref,
> +			      const char *id)
> +{
> +	int ret;
> +	struct regulator *reg;
In a lot of cases you've gone with reverse xmas tree ordering,
which is good because it makes the ordering of declarations
consistent.  Here, you haven't. I'd prefer you did that everywhere.

> +
> +	reg = devm_regulator_get_optional(dev, id);
> +	if (PTR_ERR(reg) == -ENODEV) {
> +		*vref = NULL;
> +		return 0;
> +	} else if (IS_ERR(reg)) {
> +		return PTR_ERR(reg);
> +	}
> +	ret = regulator_enable(reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable regulator %s\n", id);
> +
> +	*vref = reg;
> +	return devm_add_action_or_reset(dev, max11410_disable_reg, reg);
> +}
> +


...

> +
> +static int max11410_probe(struct spi_device *spi)
> +{
> +	struct max11410_state *st;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	const char *vrefp_regs[] = { "vref0p", "vref1p", "vref2p" };
> +	const char *vrefn_regs[] = { "vref0n", "vref1n", "vref2n" };
> +	int ret;
> +	int i;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi_dev = spi;
> +	init_completion(&st->completion);
> +	mutex_init(&st->lock);
> +
> +	indio_dev->name = "max11410";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &max11410_info;
> +
> +	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "regmap initialization failed\n");
> +
> +	st->avdd = devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(st->avdd))
> +		return dev_err_probe(dev, PTR_ERR(st->avdd),
> +				     "avdd-supply is required.\n");
> +
> +	ret = regulator_enable(st->avdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, max11410_disable_reg, st->avdd);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(vrefp_regs); i++) {
> +		ret = max11410_init_vref(dev, &st->vrefp[i], vrefp_regs[i]);
> +		if (ret)
> +			return ret;
> +
> +		ret = max11410_init_vref(dev, &st->vrefn[i], vrefn_regs[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Regulators must be configured before parsing channels for
> +	 * validating "adi,reference" property of each channel.
> +	 */
> +	ret = max11410_parse_channels(st, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (of_irq_get_byname(dev->of_node, "gpio0") > 0)

Please use the generic firmware accessors not the of specific ones as that
restricts the firmware that can be used to instantiate this device.
Here that means using fwnode_irq_get_by_name(dev_fwnode(dev), ...0) 

We should also be using the irq returned by the call, not spi->irq.
Otherwise we may get a different IRQ if multiple are specified.

> +		ret = regmap_write(st->regmap, MAX11410_REG_GPIO_CTRL(0),
> +				   MAX11410_GPIO_INTRB);
> +	else if (of_irq_get_byname(dev->of_node, "gpio1") > 0)
> +		ret = regmap_write(st->regmap, MAX11410_REG_GPIO_CTRL(1),
> +				   MAX11410_GPIO_INTRB);
> +	else if (spi->irq > 0)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "no interrupt name specified");
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(st->regmap, MAX11410_REG_CTRL,
> +			      MAX11410_CTRL_FORMAT_BIT);
> +	if (ret)
> +		return ret;
> +
> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +					  iio_device_id(indio_dev));

You seems to be allocating the trigger whether or not the irq is provided?
There is no reason to do that - just move this block down to alongside
the bit where we register the trigger so it's protected by the if (irq).

> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &max11410_trigger_ops;
> +	indio_dev->trig = iio_trigger_get(st->trig);

I'm not particularly keen on default triggers as they create a rather odd requirement
on removing the driver that you have to set current_trigger to "" in order to get
the reference count to drop.  If the device works fine with other triggers,
selecting it's own one is just a policy choice and should be left to userspace.

Also, the trigger is optional - so if you use it as the default, make sure
the trigger is present.  Finally, don't take a reference to the trigger until
after you have registered the trigger.

> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      &max11410_trigger_handler,
> +					      &max11410_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	if (spi->irq > 0) {
> +		ret = devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
> +						&max11410_interrupt,
> +						IRQF_ONESHOT,
> +						"max11410", indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = max11410_self_calibrate(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "cannot perform device self calibration\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +

