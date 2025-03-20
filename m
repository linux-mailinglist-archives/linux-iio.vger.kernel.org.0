Return-Path: <linux-iio+bounces-17149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98129A6A6EF
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 14:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE67D7B18A2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CB01DF97F;
	Thu, 20 Mar 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WX2IkUZh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B7290F;
	Thu, 20 Mar 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476621; cv=none; b=qvs8Arvu3v5D6XIzetOxZTit/rygFpFrQUTg5XcuO3DcWI6+JuN6ZBD3RN4sFOw5xqzS1/gNBSBIqM5xHCKcDsRRhiRrYoyRiy+Wz8xDQqHFVGprnqC/vhTSm1K2Gemk9W0Pvh/EVfkQU7x1/uqI/ga7SNHHYI/87576Pl+gbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476621; c=relaxed/simple;
	bh=00MwC8JxXDJFyOZk5Kcxyphos4THemMnvbnkezrwyn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5LQyhpeUfBf8PN5pQEsW1ZytyJwulr3WCLtx1lbKK7voFCyZcyjw0J6GvO8IJbn7cNArNBVvitIASDbOkiMc8GFDzrEPBo3Sf2A9bJTFHH/MXw1mQGbzmJ3KuTPhk7MQB+/Dk1S/Pj+S4E+y11tTKgb96dlLxP4yaHGjZ2TvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WX2IkUZh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742476620; x=1774012620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=00MwC8JxXDJFyOZk5Kcxyphos4THemMnvbnkezrwyn4=;
  b=WX2IkUZhlejxOQgquNZXTxhVcl8RqmJcUnZjVqInM5wnLVmcRml8GLV6
   nTzA5e46lw2+hz9z0t/hPWHH5KnobfcaxEiLONsaTbrchTYYrKUiVmbLZ
   RmXhP8VLkx77ThihPXK/SaV3l+Cf5N8nZOvlDJXGyQQh3IwCibUKrs85y
   sPdieG+Ptr5dZJz73QuFLOZXLnfEzEusMVyIxBYn9dOB7e8pa1BvgRHcH
   UwTEBLj3Chw+RfLJExM+6hGvl8/nIjMNfWGgfI0bfzOzCaBh0NBv1HVSv
   Gl4t0CoL9BWAFxrM/K5w1ug+Vx7440Wn+rcfMzDgcslU6WHOnXGOb609e
   g==;
X-CSE-ConnectionGUID: g+3TZuQ8SfSRSNVqQVW/+w==
X-CSE-MsgGUID: iYTH77i0TsGuh7caBHRMUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66167341"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="66167341"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:16:58 -0700
X-CSE-ConnectionGUID: Ga0BbP0dQPmJiPt0rDA+3w==
X-CSE-MsgGUID: RIs2sxGOSUi/muqgyQZGMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="154090982"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:16:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvFlT-00000004EGU-3930;
	Thu, 20 Mar 2025 15:16:51 +0200
Date: Thu, 20 Mar 2025 15:16:51 +0200
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
Subject: Re: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z9wVQ8vgV8kQylqG@smile.fi.intel.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
 <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 10:22:00AM +0200, Matti Vaittinen wrote:
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

> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
> +{
> +	struct bd79124_data *data = gpiochip_get_data(gc);
> +
> +	if (value)
> +		regmap_set_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
> +	else
> +		regmap_clear_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));

Hmm... Is there still any obstacle to use regmap_assign_bits()?

> +}

...

> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +				    unsigned long *bits)
> +{
> +	unsigned int val;
> +	int ret;
> +	struct bd79124_data *data = gpiochip_get_data(gc);
> +
> +	/* Ensure all GPIOs in 'mask' are set to be GPIOs */
> +	ret = regmap_read(data->map, BD79124_REG_PINCFG, &val);
> +	if (ret)
> +		return;

> +	if ((val & *mask) != *mask) {

This is basically an equivalent to

	if (val ^ *mask) {

> +		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");

> +		/* Do not set value for pins configured as ADC inputs */
> +		*mask &= val;

But this still puzzles me. If we have a valid_mask set, this should never
happen. Maybe I missed something, though.

On top of that I have just realised that you modifying the input here
which may ne quite surprising (I dunno why we don't have const specifier
in the callbacks from day 1.

> +	}
> +
> +	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);
> +}

...

> +struct bd79124_raw {
> +	u8 val_bit0_3; /* Is set in high bits of the byte */
> +	u8 val_bit4_11;
> +};

Again, this is confusing.

Just put a bit order map in the comment as I suggested previously.
When I see variable name containing bit range like above I think
about the same bit order, i.e. with your comment it makes like this

bit number	7 6 5 4 3 2 1 0
data bit	0 1 2 3 x x x x

All the same for the second variable.

> +#define BD79124_RAW_TO_INT(r) ((r.val_bit4_11 << 4) | (r.val_bit0_3 >> 4))
> +#define BD79124_INT_TO_RAW(val) {					\
> +	.val_bit4_11 = (val) >> 4,					\
> +	.val_bit0_3 = (val) << 4,					\
> +}
> +
> +/*
> + * The high and low limits as well as the recent result values are stored in
> + * the same way in 2 consequent registers. The first register contains 4 bits
> + * of the value. These bits are stored in the high bits [7:4] of register, but
> + * they represent the low bits [3:0] of the value.
> + * The value bits [11:4] are stored in the next register.
> + *
> + * Read data from register and convert to integer.
> + */
> +static int bd79124_read_reg_to_int(struct bd79124_data *data, int reg,
> +				   unsigned int *val)
> +{
> +	int ret;
> +	struct bd79124_raw raw;
> +
> +	ret = regmap_bulk_read(data->map, reg, &raw, sizeof(raw));
> +	if (ret) {
> +		dev_dbg(data->dev, "bulk_read failed %d\n", ret);
> +
> +		return ret;
> +	}
> +
> +	*val = BD79124_RAW_TO_INT(raw);
> +
> +	return 0;
> +}
> +
> +/*
> + * The high and low limits as well as the recent result values are stored in
> + * the same way in 2 consequent registers. The first register contains 4 bits
> + * of the value. These bits are stored in the high bits [7:4] of register, but
> + * they represent the low bits [3:0] of the value.
> + * The value bits [11:4] are stored in the next register.

And you probably don't need a long comment copied twice when data type is well
described.

> + * Convert the integer to register format and write it using rmw cycle.
> + */
> +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
> +				    unsigned int val)
> +{
> +	struct bd79124_raw raw = BD79124_INT_TO_RAW(val);
> +	unsigned int tmp;
> +	int ret;
> +
> +	ret = regmap_read(data->map, reg, &tmp);
> +	if (ret)
> +		return ret;

> +	raw.val_bit0_3 |= (tmp & 0xf);

Parentheses are not needed. Bit we already discussed that and it's principal
disagreement between us. :-(

> +	return regmap_bulk_write(data->map, reg, &raw, sizeof(raw));
> +}

...

> +static const struct iio_chan_spec bd79124_chan_template = {
> +	.type = IIO_VOLTAGE,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	.indexed = 1,
> +	.event_spec = bd79124_events,
> +	.num_event_specs = ARRAY_SIZE(bd79124_events),

+ array_size.h which is missing.

> +};

...

> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir == IIO_EV_DIR_RISING)
> +			*val = data->alarm_r_limit[chan->channel];
> +		else if (dir == IIO_EV_DIR_FALLING)
> +			*val = data->alarm_f_limit[chan->channel];
> +		else
> +			return -EINVAL;
> +
> +		return IIO_VAL_INT;

> +

Blank line...

> +	case IIO_EV_INFO_HYSTERESIS:
> +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
> +		ret = regmap_read(data->map, reg, val);
> +		if (ret)
> +			return ret;
> +
> +		*val &= BD79124_MSK_HYSTERESIS;
> +		/*
> +		 * The data-sheet says the hysteresis register value needs to be
> +		 * sifted left by 3.
> +		 */
> +		*val <<= 3;
> +
> +		return IIO_VAL_INT;

...no blank line. Can you choose one style and use it everywhere?

> +	default:
> +		return -EINVAL;
> +	}

...

> +static int bd79124_disable_event(struct bd79124_data *data,
> +				 enum iio_event_direction dir, int channel)
> +{
> +	int dir_bit = BIT(dir);
> +	int reg;
> +	unsigned int limit;
> +
> +	guard(mutex)(&data->mutex);

+ Blank line?

> +	/*
> +	 * Set thresholds either to 0 or to 2^12 - 1 as appropriate to prevent
> +	 * alerts and thus disable event generation.
> +	 */
> +	if (dir == IIO_EV_DIR_RISING) {
> +		reg = BD79124_GET_HIGH_LIMIT_REG(channel);
> +		limit = BD79124_HIGH_LIMIT_MAX;
> +	} else if (dir == IIO_EV_DIR_FALLING) {
> +		reg = BD79124_GET_LOW_LIMIT_REG(channel);
> +		limit = BD79124_LOW_LIMIT_MIN;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	data->alarm_monitored[channel] &= ~dir_bit;

Ditto.

> +	/*
> +	 * Stop measurement if there is no more events to monitor.
> +	 * We don't bother checking the retval because the limit
> +	 * setting should in any case effectively disable the alarm.
> +	 */
> +	if (!data->alarm_monitored[channel]) {
> +		bd79124_stop_measurement(data, channel);
> +		regmap_clear_bits(data->map, BD79124_REG_ALERT_CH_SEL,
> +				  BIT(channel));
> +	}
> +
> +	return bd79124_write_int_to_reg(data, reg, limit);
> +}

...

> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		unsigned int old_chan_cfg, regval;
> +		int tmp;

This tmp sounds to me like

		int ret2; // or rc, retval, etc.

> +		guard(mutex)(&data->mutex);
> +
> +		/*
> +		 * Start the automatic conversion. This is needed here if no
> +		 * events have been enabled.
> +		 */
> +		regval = FIELD_PREP(BD79124_MSK_CONV_MODE,
> +				    BD79124_CONV_MODE_AUTO);
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

...

> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
> +		u64 ecode;
> +
> +		if (BIT(i) & i_hi) {
> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +						     IIO_EV_TYPE_THRESH,
> +						     IIO_EV_DIR_RISING);
> +
> +			iio_push_event(iio_dev, ecode, data->timestamp);
> +			/*
> +			 * The BD79124 keeps the IRQ asserted for as long as
> +			 * the voltage exceeds the threshold. It causes the IRQ
> +			 * to keep firing.
> +			 *
> +			 * Disable the event for the channel and schedule the
> +			 * re-enabling the event later to prevent storm of
> +			 * events.
> +			 */
> +			ret = bd79124_event_ratelimit_hi(data, i);
> +			if (ret)
> +				return IRQ_NONE;
> +		}
> +		if (BIT(i) & i_lo) {

> +			ecode = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +						     IIO_EV_TYPE_THRESH,
> +						     IIO_EV_DIR_FALLING);
> +
> +			iio_push_event(iio_dev, ecode, data->timestamp);

Sounds like possibility to deduplicate as the above only differs by ecode.

> +			ret = bd79124_event_ratelimit_lo(data, i);
> +			if (ret)
> +				return IRQ_NONE;
> +		}
> +	}

...

> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, template,
> +		BD79124_MAX_NUM_CHANNELS - 1, &cs);
> +	if (ret < 0) {
> +		/* Register all pins as GPOs if there are no ADC channels */
> +		if (ret == -ENOENT)
> +			goto register_gpios;

It's possible to move outside of the above conditional, but I think I got your
idea, however it is still not a hot path.

> +		return ret;
> +	}


-- 
With Best Regards,
Andy Shevchenko



