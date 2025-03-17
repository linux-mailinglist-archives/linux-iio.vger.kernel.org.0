Return-Path: <linux-iio+bounces-16987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF8A658FE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A65E17B342
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15D61B0439;
	Mon, 17 Mar 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Joaqb2gF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB619F424;
	Mon, 17 Mar 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229842; cv=none; b=pJXcI0oWn4/7+qhitjAvOt/qDUuupaMgLvZvQlu/moz13qAc29uN0JglCCJ9h3RDvmdhOoIlT7vgZDEyr99zQPYNRKnQmcwHIqWg2BX0LAW92Lb1iiv0n7W7mYXp3itRIajPEVS8WGX5MsT33eseZ8+Cy3HHXYvEAHNuWd/e2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229842; c=relaxed/simple;
	bh=02M6yFoWMU3JLvlRdZcn0LHN9ibOfknzlPpS43/0MFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr5i/VtQcpkupgXZ3rEtwWfzqdDEbrnX9BDEJSlwLXzfqABt9Wa2EWobKMtcy0GXM8md/8HDX6wQtnjY8ShkWKTfzJY/LVf9SkXvXI5htrQwZO7dzUuNcw2WnF1OPbeAz8te6FapCscrKBo+p94ufvtT618JOwDCbVmLK+liw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Joaqb2gF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742229841; x=1773765841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=02M6yFoWMU3JLvlRdZcn0LHN9ibOfknzlPpS43/0MFw=;
  b=Joaqb2gFRAmnMXpoRWJmNFv06bCR8/bDPN2LZkCqyjYJHg4AvVkxtIUt
   bna/a6tEfdJsQYhigUYILHEYSTq4IMzuuy8eZFBX4EMwtx4aKpwwbStj+
   FE73gv/1CBb28cX/nV6JXwbYoemnVGf/k7J7W+FCNbl2HFMNmv4n9J0Ww
   QFenshznF71WGNBzLeMKdAF/F+J9cAycYmV/2c5A8Foz2cChuXhqxN65t
   293Fin2AJKKz3XdOl4hTqIrq01LuKHH0Aofr7efCKsHO5eaykEE06qg/u
   S6JvgL0ONdE4eaA3WyWohgWphLlOyuUgRMa+lIWitC1e1zWoyyBvuPMRM
   A==;
X-CSE-ConnectionGUID: 66zEry5+SLGhbahJhsDq2g==
X-CSE-MsgGUID: gP+UKTyZRQ+AHDw4DzCimg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43533993"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="43533993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:44:00 -0700
X-CSE-ConnectionGUID: iG2d1HxuT6edusunPADJZw==
X-CSE-MsgGUID: 0YyVXoJhSOyyIhNqTapqHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122005995"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:43:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuDZA-00000003MUS-2G8q;
	Mon, 17 Mar 2025 18:43:52 +0200
Date: Mon, 17 Mar 2025 18:43:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z9hRSLXCihCGwcT3@smile.fi.intel.com>
References: <cover.1742225817.git.mazziesaccount@gmail.com>
 <2b7ebdbeaa163e320b4071c040ee8e24241d693d.1742225817.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7ebdbeaa163e320b4071c040ee8e24241d693d.1742225817.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 17, 2025 at 05:51:25PM +0200, Matti Vaittinen wrote:
> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> an automatic measurement mode, with an alarm interrupt for out-of-window
> measurements. The window is configurable for each channel.
> 
> The I2C protocol for manual start of the measurement and data reading is
> somewhat peculiar. It requires the master to do clock stretching after
> sending the I2C slave-address until the slave has captured the data.
> Needless to say this is not well suopported by the I2C controllers.
> 
> Thus do not support the BD79124's manual measurement mode but implement
> the measurements using automatic measurement mode, relying on the
> BD79124's ability of storing latest measurements into register.
> 
> Support also configuring the threshold events for detecting the
> out-of-window events.
> 
> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> out of the configured window. Thus, prevent the user-space from choking
> on the events and mask the received event for a fixed duration (1 second)
> when an event is handled.
> 
> The ADC input pins can be also configured as general purpose outputs.
> Make those pins which don't have corresponding ADC channel node in the
> device-tree controllable as GPO.

...

> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bits.h>

bits.h is guaranteed by bitmap.h, but it's up to you to leave
or remove this line.

> +#include <linux/byteorder/generic.h>

This is incorrect. In some cases it even may produce build failures.
Should be asm/byteorder.h...

> +#include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqreturn.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...somewhere here.

> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/adc-helpers.h>

...

> +#define BD79124_GET_LIMIT_REG(ch, dir) ((dir) == IIO_EV_DIR_RISING ?		\
> +		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))

It's hard to read, better to split over few lines:

#define BD79124_GET_LIMIT_REG(ch, dir)						\
	((dir) == IIO_EV_DIR_RISING ?						\
		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))

or alike.

...

> +	/*
> +	 * The BD79124 does not allow disabling/enabling limit separately for
> +	 * one direction only. Hence, we do the disabling by changing the limit
> +	 * to maximum/minimum measurable value. This means we need to cache
> +	 * the limit in order to maintain it over the time limit is disabled.
> +	 */
> +	u16 alarm_r_limit[BD79124_MAX_NUM_CHANNELS];
> +	u16 alarm_f_limit[BD79124_MAX_NUM_CHANNELS];
> +	/* Bitmask of disabled events (for rate limiting) for each channel. */
> +	int alarm_suppressed[BD79124_MAX_NUM_CHANNELS];
> +	/*
> +	 * The BD79124 is configured to run the measurements in the background.
> +	 * This is done for the event monitoring as well as for the read_raw().
> +	 * Protect the measurement starting/stopping using a mutex.
> +	 */
> +	struct mutex mutex;
> +	struct delayed_work alm_enable_work;

> +	struct gpio_chip gc;

Hmm... Have you tried to shuffle fields to see if you gain a better code
generation. Also I don't remember if I asked about struct device *dev to be
the same as in regmap and would it be worse code without it?

> +	u8 gpio_valid_mask;

...

> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
> +{
> +	struct bd79124_data *data = gpiochip_get_data(gc);
> +
> +	if (value)
> +		regmap_set_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
> +	else
> +		regmap_clear_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));

regmap_assign_bits()

> +}

...

> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +				    unsigned long *bits)
> +{
> +	unsigned int val;
> +	int ret;
> +	struct bd79124_data *data = gpiochip_get_data(gc);

> +	/* Ensure all GPIOs in 'mask' are set to be GPIOs */

This sounds like it can utilise valid_mask, but it seems you already have it.
So the question is what is the practical issue here? I believe the condition
below will never be the case.

> +	ret = regmap_read(data->map, BD79124_REG_PINCFG, &val);
> +	if (ret)
> +		return;

> +	if ((val & *mask) != *mask) {
> +		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
> +		/* Do not set value for pins configured as ADC inputs */
> +		*mask &= val;
> +	}
> +
> +	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);

Can you rather utilise the respective bitmap APIs?

> +}

...

> +struct bd79124_raw {
> +	u8 bit0_3; /* Is set in high bits of the byte */
> +	u8 bit4_11;
> +};
> +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
> +#define BD79124_INT_TO_RAW(val) {					\
> +	.bit4_11 = (val) >> 4,						\
> +	.bit0_3 = (val) << 4,						\
> +}
> +
> +/*
> + * The high and low limits as well as the recent result values are stored in
> + * the same way in 2 consequent registers. The first register contains 4 bits
> + * of the value. These bits are stored in the high bits [7:4] of register, but
> + * they represent the low bits [3:0] of the value.

I believe this comment should go on top of the data structure. Also this is
still confusing as variable name above suggests one bit mapping, while text
here is referencing to another. Can you elaborate this more, please?

Like

	u8 foo_1; // represents bits 3 2 1 0 x x x x
	// ? or represents bits 0 1 2 3 x x x x

> + * The value bits [11:4] are stored in the next register.
> + *
> + * Read data from register and convert to integer.
> + */

...

> +static int bd79124_read_reg_to_int(struct bd79124_data *data, int reg,
> +				   unsigned int *val)
> +{
> +	int ret;
> +	struct bd79124_raw raw;
> +
> +	ret = regmap_bulk_read(data->map, reg, &raw, sizeof(raw));
> +	if (ret) {

> +		dev_dbg(data->dev, "bulk_read failed %d\n", ret);

Do we need this (and alike)? It can be achieved via regmap tracepoints.

> +		return ret;
> +	}
> +
> +	*val = BD79124_RAW_TO_INT(raw);
> +
> +	return 0;
> +}

...

> +/*
> + * The high and low limits as well as the recent result values are stored in
> + * the same way in 2 consequent registers. The first register contains 4 bits
> + * of the value. These bits are stored in the high bits [7:4] of register, but
> + * they represent the low bits [3:0] of the value.
> + * The value bits [11:4] are stored in the next register.

Same as above, rather comment once at data type.

> + * Convert the integer to register format and write it using rmw cycle.
> + */

...

> +	raw.bit0_3 |= (0xf & tmp);

Btw, why Yoda style?

...

> +static int bd79124_stop_measurement(struct bd79124_data *data, int chan)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* See if already stopped */
> +	ret = regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &val);
> +	if (!(val & BIT(chan)))
> +		return 0;
> +
> +	ret = regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
> +				BD79124_MSK_SEQ_START);
> +
> +	/* Clear the channel from the measured channels */
> +	ret = regmap_write(data->map, BD79124_REG_AUTO_CHANNELS,
> +			   ~BIT(chan) & val);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Stop background conversion for power saving if it was the last
> +	 * channel

Missing period.

> +	 */
> +	if (!(~BIT(chan) & val)) {

Seems to me as you have the same above, perhaps just update the val?

> +		int regval = FIELD_PREP(BD79124_MSK_CONV_MODE,
> +					BD79124_CONV_MODE_MANSEQ);
> +
> +		ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
> +					 BD79124_MSK_CONV_MODE, regval);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regmap_set_bits(data->map, BD79124_REG_SEQ_CFG,
> +			       BD79124_MSK_SEQ_START);
> +}

...

> +	/* Add the channel to the list of monitored channels */
> +	ret = regmap_set_bits(data->map, BD79124_REG_ALERT_CH_SEL,
> +			      BIT(channel));

Perfectly one line, and you have similar cases with 82 characters already,
while here it's just 81.

> +	if (ret)
> +		return ret;

...

> +	return regmap_set_bits(data->map, BD79124_REG_GEN_CFG,
> +				      BD79124_MSK_DWC_EN);

Can be done here, as it's only 83 characters.

...

> +{
> +	struct bd79124_data *data = iio_priv(iio_dev);
> +	int reg;
> +
> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir == IIO_EV_DIR_RISING) {
> +			guard(mutex)(&data->mutex);

What does this mutex protect? chan->channel access? I don't think so, then it
can be scoped_guard().

> +			data->alarm_r_limit[chan->channel] = val;
> +			reg = BD79124_GET_HIGH_LIMIT_REG(chan->channel);
> +		} else if (dir == IIO_EV_DIR_FALLING) {
> +			guard(mutex)(&data->mutex);

Ditto.

> +			data->alarm_f_limit[chan->channel] = val;
> +			reg = BD79124_GET_LOW_LIMIT_REG(chan->channel);
> +		} else {
> +			return -EINVAL;
> +		}
> +		/*
> +		 * We don't want to enable the alarm if it is not enabled or
> +		 * if it is suppressed. In that case skip writing to the
> +		 * register.
> +		 */
> +		if (!(data->alarm_monitored[chan->channel] & BIT(dir)) ||
> +		    data->alarm_suppressed[chan->channel] & BIT(dir))
> +			return 0;
> +
> +		return bd79124_write_int_to_reg(data, reg, val);
> +
> +	case IIO_EV_INFO_HYSTERESIS:
> +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
> +		val >>= 3;
> +
> +		return regmap_update_bits(data->map, reg, BD79124_MSK_HYSTERESIS,
> +					  val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int bd79124_read_raw(struct iio_dev *iio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long m)
> +{
> +	struct bd79124_data *data = iio_priv(iio_dev);
> +	int ret;
> +
> +	if (chan->channel >= BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		unsigned int old_chan_cfg, regval;
> +		int tmp;
> +
> +		guard(mutex)(&data->mutex);
> +
> +		/*
> +		 * Start the automatic conversion. This is needed here if no
> +		 * events have been enabled.
> +		 */

> +		regval = FIELD_PREP(BD79124_MSK_CONV_MODE,
> +				    BD79124_CONV_MODE_AUTO);

Only 83 characters for one line.

> +		ret = regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
> +					 BD79124_MSK_CONV_MODE, regval);
> +		if (ret)
> +			return ret;
> +
> +		ret = bd79124_single_chan_seq(data, chan->channel, &old_chan_cfg);
> +		if (ret)
> +			return ret;
> +
> +		/* The maximum conversion time is 6 uS. */
> +		udelay(6);
> +
> +		ret = bd79124_read_reg_to_int(data,
> +			BD79124_GET_RECENT_RES_REG(chan->channel), val);
> +		/*
> +		 * Return the old chan config even if data reading failed in
> +		 * order to re-enable the event monitoring.
> +		 */
> +		tmp = bd79124_single_chan_seq_end(data, old_chan_cfg);
> +		if (tmp)
> +			dev_err(data->dev,
> +				"Failed to return config. Alarms may be disabled\n");
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = data->vmax / 1000;
> +		*val2 = BD79124_ADC_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int __bd79124_event_ratelimit(struct bd79124_data *data, int reg,
> +				     unsigned int limit)
> +{
> +	int ret;
> +
> +	if (limit > BD79124_HIGH_LIMIT_MAX)
> +		return -EINVAL;
> +
> +	ret = bd79124_write_int_to_reg(data, reg, limit);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * We use 1 sec 'grace period'. At the moment I see no reason to make
> +	 * this user configurable. We need an ABI for this if configuration is
> +	 * needed.
> +	 */
> +	schedule_delayed_work(&data->alm_enable_work,
> +			      msecs_to_jiffies(1000));

Perfectly one line even for the 80 character limit fanatics :-)

> +	return 0;
> +}

> +static int bd79124_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
> +{
> +	int i, gpio_channels;
> +
> +	/*
> +	 * Let's initialize the mux config to say that all 8 channels are
> +	 * GPIOs. Then we can just loop through the iio_chan_spec and clear the
> +	 * bits for found ADC channels.
> +	 */
> +	gpio_channels = GENMASK(7, 0);
> +	for (i = 0; i < num_channels; i++)
> +		gpio_channels &= ~BIT(cs[i].channel);
> +
> +	return gpio_channels;
> +}

...

> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, template,
> +		BD79124_MAX_NUM_CHANNELS - 1, &cs);
> +	if (ret < 0) {
> +		if (ret == -ENOENT)
> +			goto register_gpios;
> +		return ret;
> +	}

Also can be written as

	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, template,
		BD79124_MAX_NUM_CHANNELS - 1, &cs);
	/* Register all channels as GPIOs in case no ADC functionality required */
	if (ret == -ENOENT)
		goto register_gpios;
	if (ret < 0)
		return ret;

-- 
With Best Regards,
Andy Shevchenko



