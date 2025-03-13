Return-Path: <linux-iio+bounces-16777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF92A5F5C5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 14:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1473AC447
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 13:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301CF2676F2;
	Thu, 13 Mar 2025 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSqpxpsD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15071265610;
	Thu, 13 Mar 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871961; cv=none; b=aJb+WK868o8AswJG+ZNBsFlK4MC0Qhrjv5Gvmvt33AztcAjUiqUDwI89rF3Xydt8dNTpQEXLTQ3+9vkwqjcKmUmfP3AU/yUmsnv5Dxwy96hS5whUvQW63NDI47SKvGVDbhuz1d0SSrR8KNeJzDfOo4MyA6HXtXn/T+p4drDAM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871961; c=relaxed/simple;
	bh=kSLuroUKtiymbJTkEMP0+//NaZasHJELsrGBlpl58Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdzyKs1PAhPnwlAFLJbsyZqcweW7Odf6LhDjpmPd+y8iMeqPOCTKhqDFuBsEosZ5b7WTMl/wzE00TxUNtQNsz4YKx9OrxeUJANU4EE0dq/L4HFpXfHTTwayiPb/ujLP8SjRR4cLqaO6mbkRuh8A+IdHaP5H7N8DKTaqMT1sCyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSqpxpsD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741871959; x=1773407959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kSLuroUKtiymbJTkEMP0+//NaZasHJELsrGBlpl58Ow=;
  b=hSqpxpsDBByFbaQ5n2kGyGaa5317b6LiVfMDsCaVWgkT5W9y9oNMnyik
   1Arb1KTupkR8seLx81qfokXXCdDtVddWTsD5e67QgMKjZgMsxwGYuvz1B
   pVN/oTM9Ahn42yK2wyxrPeKlG33OEV8878lUBbyt83OHO04vafk97dGRc
   EgKAZwG2+EUP/p18DV/S3g91HX5kbbiY/G8iRg/HCjLveKniwGzww13Bm
   JHmKbgpCCcbbtylVDGZ7ha+dsi4/f7DUW65GJlCb13yMZk1w8avfYzjPe
   94XLS1IuadY1QDaoUSvrMBAQt8dQFxqys406ZMnMzaqrf34PorklXIxst
   A==;
X-CSE-ConnectionGUID: ctfUBktRT2yZUYQeqjzy8A==
X-CSE-MsgGUID: fiBHTIdJRKeTQvoDymhmlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43166149"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43166149"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:19:19 -0700
X-CSE-ConnectionGUID: nso5IsKiR4WPNcwdQX+9/A==
X-CSE-MsgGUID: WDwmSTWVRle4y6cCHMs9SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="151799809"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 06:19:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tsiSt-00000002BCV-2g2Q;
	Thu, 13 Mar 2025 15:19:11 +0200
Date: Thu, 13 Mar 2025 15:19:11 +0200
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
Subject: Re: [PATCH v7 06/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <Z9LbT1BvPEIp7U2N@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c02a5d75a20bbbf8c3370ccee615d269620117.1741849323.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 09:19:03AM +0200, Matti Vaittinen wrote:
> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> an automatic measurement mode, with an alarm interrupt for out-of-window
> measurements. The window is configurable for each channel.
> 
> The I2C protocol for manual start of the measurement and data reading is
> somewhat peculiar. It requires the master to do clock stretching after
> sending the I2C slave-address until the slave has captured the data.
> Needless to say this is not well suopported by the I2C controllers.
> 
> Thus the driver does not support the BD79124's manual measurement mode
> but implements the measurements using automatic measurement mode relying
> on the BD79124's ability of storing latest measurements into register.
> 
> The driver does also support configuring the threshold events for
> detecting the out-of-window events.
> 
> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> out of the configured window. Thus the driver masks the received event
> for a fixed duration (1 second) when an event is handled. This prevents
> the user-space from choking on the events
> 
> The ADC input pins can be also configured as general purpose outputs.
> Those pins which don't have corresponding ADC channel node in the
> device-tree will be controllable as GPO.

...

> +#define BD79124_REG_SYSTEM_STATUS	0x0

I would expect to see 0x00

> +#define BD79124_REG_GEN_CFG		0x01
> +#define BD79124_REG_OPMODE_CFG		0x04
> +#define BD79124_REG_PINCFG		0x05
> +#define BD79124_REG_GPO_VAL		0x0B
> +#define BD79124_REG_SEQUENCE_CFG	0x10
> +#define BD79124_REG_MANUAL_CHANNELS	0x11
> +#define BD79124_REG_AUTO_CHANNELS	0x12
> +#define BD79124_REG_ALERT_CH_SEL	0x14
> +#define BD79124_REG_EVENT_FLAG		0x18
> +#define BD79124_REG_EVENT_FLAG_HI	0x1a
> +#define BD79124_REG_EVENT_FLAG_LO	0x1c
> +#define BD79124_REG_HYSTERESIS_CH0	0x20
> +#define BD79124_REG_EVENTCOUNT_CH0	0x22
> +#define BD79124_REG_RECENT_CH0_LSB	0xa0
> +#define BD79124_REG_RECENT_CH7_MSB	0xaf

...

Wouldn't be better...

> +#define BD79124_MASK_CONV_MODE GENMASK(6, 5)
> +#define BD79124_MASK_AUTO_INTERVAL GENMASK(1, 0)
> +#define BD79124_CONV_MODE_MANSEQ 0
> +#define BD79124_CONV_MODE_AUTO 1
> +#define BD79124_INTERVAL_750_US 0

To group masks and values of the same bitfields?

#define BD79124_MASK_CONV_MODE GENMASK(6, 5)
#define BD79124_CONV_MODE_MANSEQ 0
#define BD79124_CONV_MODE_AUTO 1
#define BD79124_MASK_AUTO_INTERVAL GENMASK(1, 0)
#define BD79124_INTERVAL_750_US 0

> +#define BD79124_MASK_DWC_EN BIT(4)
> +#define BD79124_MASK_STATS_EN BIT(5)
> +#define BD79124_MASK_SEQ_START BIT(4)
> +#define BD79124_MASK_SEQ_MODE GENMASK(1, 0)
> +#define BD79124_MASK_SEQ_MANUAL 0
> +#define BD79124_MASK_SEQ_SEQ 1
> +
> +#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
> +#define BD79124_LOW_LIMIT_MIN 0
> +#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)

These masks are not named after registers (or I don't see it clearly), it's
hard to understand which one relates to which register. Also, why not using
bitfield.h?

...

> + * These macros return the address of the 1.st reg for the given channel

first

(and missing period at the end).

> +#define BD79124_GET_HIGH_LIMIT_REG(ch) (BD79124_REG_HYSTERESIS_CH0 + (ch) * 4)
> +#define BD79124_GET_LOW_LIMIT_REG(ch) (BD79124_REG_EVENTCOUNT_CH0 + (ch) * 4)
> +#define BD79124_GET_LIMIT_REG(ch, dir) ((dir) == IIO_EV_DIR_RISING ?		\
> +		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))
> +#define BD79124_GET_RECENT_RES_REG(ch) (BD79124_REG_RECENT_CH0_LSB + (ch) * 2)

Don't we want to have something in bitfield.h for arrays in the register, i.e.
when register(s) is(are) split to 2+ bits per an element in an array of the
same semantics. Would be nice to eliminate such a boilerplate here and in many
other drivers.

> +/*
> + * The hysteresis for a channel is stored in the same register where the
> + * 4 bits of high limit reside.
> + */
> +#define BD79124_GET_HYSTERESIS_REG(ch) BD79124_GET_HIGH_LIMIT_REG(ch)
> +
> +#define BD79124_MAX_NUM_CHANNELS 8
> +
> +struct bd79124_data {
> +	s64 timestamp;
> +	struct regmap *map;
> +	struct device *dev;
> +	int vmax;
> +	/*
> +	 * Keep measurement status so read_raw() knows if the measurement needs
> +	 * to be started.
> +	 */
> +	int alarm_monitored[BD79124_MAX_NUM_CHANNELS];
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
> +	u8 gpio_valid_mask;
> +};

...

> +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)

You should use .set_rv()

...

> +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> +				    unsigned long *bits)

Ditto, .set_multiple_rv().

> +{
> +	int ret, val;

Here and everywhere else, the returned value by regmap is unsigned int.

> +	struct bd79124_data *data = gpiochip_get_data(gc);
> +
> +	/* Ensure all GPIOs in 'mask' are set to be GPIOs */
> +	ret = regmap_read(data->map, BD79124_REG_PINCFG, &val);
> +	if (ret)
> +		return;
> +
> +	if ((val & *mask) != *mask) {
> +		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
> +		/* Do not set value for pins configured as ADC inputs */
> +		*mask &= val;
> +	}
> +
> +	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);
> +}

...

> +struct bd79124_raw {
> +	u8 bit0_3; /* Is set in high bits of the byte */
> +	u8 bit4_11;
> +};
> +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))

And how this is different from treating it as __le16? Needs a good comment
about bit layout.

...

> +static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
> +				    unsigned int val)
> +{
> +	struct bd79124_raw raw;
> +	int ret, tmp;

> +	raw.bit4_11 = (u8)(val >> 4);
> +	raw.bit0_3 = (u8)(val << 4);

Why casting?


Make sense to have a symmetrical macro instead of hiding it in the code.

> +	ret = regmap_read(data->map, reg, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	raw.bit0_3 |= (0xf & tmp);

GENMASK() ?

> +	return regmap_bulk_write(data->map, reg, &raw, sizeof(raw));
> +}

...

> +		/*
> +		 * The data-sheet says the hysteresis register value needs to be
> +		 * sifted left by 3

Missing period.

> +		 */

...

> +	return (data->alarm_monitored[chan->channel] & BIT(dir));

Unneeded parentheses.

...

> +	case IIO_EV_INFO_HYSTERESIS:
> +		reg = BD79124_GET_HYSTERESIS_REG(chan->channel);
> +		val >>= 3;

Second time I see this. Perhaps you need a macro to explain this right shift?

> +		return regmap_update_bits(data->map, reg, BD79124_MASK_HYSTERESIS,
> +					  val);

Can be one line.

...

> +static irqreturn_t bd79124_event_handler(int irq, void *priv)
> +{
> +	int ret, i_hi, i_lo, i;
> +	struct iio_dev *iio_dev = priv;
> +	struct bd79124_data *data = iio_priv(iio_dev);
> +
> +	/*
> +	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
> +	 * subsystem to disable the offending IRQ line if we get a hardware
> +	 * problem. This behaviour has saved my poor bottom a few times in the
> +	 * past as, instead of getting unusably unresponsive, the system has
> +	 * spilled out the magic words "...nobody cared".
> +	 */
> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret = regmap_read(data->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
> +	if (ret)
> +		return IRQ_NONE;

Only I don't get why you can't use bulk read here.
The registers seem to be sequential.

> +	if (!i_lo && !i_hi)
> +		return IRQ_NONE;
> +
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
> +			ret = bd79124_event_ratelimit_lo(data, i);
> +			if (ret)
> +				return IRQ_NONE;
> +		}
> +	}
> +
> +	ret = regmap_write(data->map, BD79124_REG_EVENT_FLAG_HI, i_hi);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret = regmap_write(data->map, BD79124_REG_EVENT_FLAG_LO, i_lo);
> +	if (ret)
> +		return IRQ_NONE;

In the similar way bulk write.

> +	return IRQ_HANDLED;
> +}

...

> +static int bd79124_chan_init(struct bd79124_data *data, int channel)
> +{
> +	int ret;
> +
> +	ret = regmap_write(data->map, BD79124_GET_HIGH_LIMIT_REG(channel), 4095);

BD79124_HIGH_LIMIT_MAX ?

> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(data->map, BD79124_GET_LOW_LIMIT_REG(channel), 0);

BD79124_HIGH_LIMIT_MIN ?

> +}

...

> +	for (i = 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
> +		ret = bd79124_chan_init(data, i);
> +		if (ret)
> +			return ret;
> +		data->alarm_r_limit[i] = 4095;

As per above?

> +	}

...

> +	gpio_pins = bd79124_get_gpio_pins(iio_dev->channels,
> +					  iio_dev->num_channels);

It may be a single line (84 characters).

...

> +static const struct i2c_device_id bd79124_id[] = {
> +	{ "bd79124", },

Redundant inner comma.

> +	{ }
> +};


-- 
With Best Regards,
Andy Shevchenko



