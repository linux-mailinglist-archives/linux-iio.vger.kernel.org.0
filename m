Return-Path: <linux-iio+bounces-13473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1739F2045
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 19:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C08163940
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6F11991C3;
	Sat, 14 Dec 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPVNuUBm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F75EBE;
	Sat, 14 Dec 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734200490; cv=none; b=UL31OHwpzqGzxF2Pm6xpfyq5iHb3nyqUpy1iubgKXgNx/RKfstrDuRf/CtzXBETsSOtdzUtU1TjMA69RADAMnaiKEWmSFVB74uNOy0iVFaObUWprLX9WiL79XL2iRrSf8lHh3tfE3aYd8Dg6QOlaxC8Qcwit3izq7YN8Ixoz96Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734200490; c=relaxed/simple;
	bh=Y0RMcvlzKBmq4ofeNxioAtixnjkXEzmyvq/MA2giVJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmxHA/9gX4TDxw/8sjNcBCJv6FESDLCWUoFi+l4wFDYCfl30QwtgqWKBVZTf+KlLpSdvS67JpyC3wYBWSkusmL+H6QBtnVXgyqLo+fyU3p07AXDCLo0vFHypHDMnjRvJi9HXw16SMHX8hMRbRGc6kHMD6Wrc1fLl1qfqoCey6s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPVNuUBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F823C4CED6;
	Sat, 14 Dec 2024 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734200490;
	bh=Y0RMcvlzKBmq4ofeNxioAtixnjkXEzmyvq/MA2giVJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPVNuUBm2GKRQhgoyIbYL/3fdggihNDMDfD94Ay/rdlMLTrrK8Np9bNrm5Mvo3B4h
	 Ro/+Re9bw6WId5wdFPiUALTiFs9lfrVZHG7lRKExJ5WMKlCwTHN1FOIW80wzfhndfe
	 7e41Yp8akMn3YTtCkfm9vdMIb1sjuuv1x8d7TNuBT3XZ2tz3bTBhaNs+3vO2E2iNHL
	 zw3xIFKqWFkmGOJ35cFOic1IEDIGLDAUZBaHPzOpQCcI3ip50VqAHNqryViOIedY4o
	 +1PFLyBDcFpenp+xj4g/sHUgh5e02gt1cHtaVIfT8iKq5q6sP/vII2LzOxjxdcKmvr
	 Kul9gBuY6ZF+Q==
Date: Sat, 14 Dec 2024 18:21:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
 <kernel@axis.com>
Subject: Re: [PATCH v9 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241214182123.22b5ede0@jic23-huawei>
In-Reply-To: <20241211140409.1619910-3-perdaniel.olsson@axis.com>
References: <20241211140409.1619910-1-perdaniel.olsson@axis.com>
	<20241211140409.1619910-3-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 15:04:09 +0100
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> 
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>

Hi Per-Daniel,

I think this is nearly there, but still some races or at least places
I can't currently convince myself aren't races.

I remember long ago being a wimp and failing to implement a similar dance
in the max1363 ADC driver. That manages one more complexity in that in
it's continuous mode if events are enabled, the data fields move.
It still only supports one of events, sysfs read back or buffered output,
not any combination.  Maybe if I can find the hardware I'll revisit that
one day.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> new file mode 100644
> index 000000000000..4a7d970c5d7c
> --- /dev/null
> +++ b/drivers/iio/light/opt4060.c


> +struct opt4060_chip {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct iio_trigger *trig;
> +	u8 int_time;
> +	int irq;
> +	struct mutex irq_setting_lock;

General rule is all locks need a comment on what data they protect
even when they have a nice specific name.  Bit advantage is it makes
it clear what they are not designed to protect!

> +	struct completion completion;
> +	bool thresh_event_lo_active;
> +	bool thresh_event_hi_active;
> +};

> +static void opt4060_claim_irq_setting_lock(struct opt4060_chip *chip)
> +{
> +	if (chip->irq)
I'm struggling to see why you'd be messing with irqs if you don't have
any?  I can't see a path in which chip->irq isn't set (which makes sense!)
and you get here.

So I think you can just move the mutex inline which avoids the mess
of lockdep warnings etc and let's you use guard() to simplify things.

> +		mutex_lock(&chip->irq_setting_lock);
> +}
> +
> +static void opt4060_release_irq_setting_lock(struct opt4060_chip *chip)
> +{
> +	if (chip->irq)
> +		mutex_unlock(&chip->irq_setting_lock);
> +}
> +
> +static int opt4060_set_int_state(struct opt4060_chip *chip, u32 state)
> +{
> +	int ret;
> +	unsigned int regval;
> +
> +	opt4060_claim_irq_setting_lock(chip);
> +	regval = FIELD_PREP(OPT4060_INT_CTRL_INT_CFG, state);
> +	ret = regmap_update_bits(chip->regmap, OPT4060_INT_CTRL,
> +				 OPT4060_INT_CTRL_INT_CFG, regval);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to set interrupt config\n");
> +	opt4060_release_irq_setting_lock(chip);
> +	return ret;
> +}
> +
> +static int opt4060_set_continuous_mode(struct opt4060_chip *chip,
> +				       bool continuous)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &reg);

You could use a regmap_update_bits() call to simplify this like you 
do for the int_state above.


> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to read ctrl register\n");
> +		return ret;
> +	}
> +	reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
> +	if (continuous)
> +		reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
> +				  OPT4060_CTRL_OPER_MODE_CONTINUOUS);
> +	else
> +		reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
> +				  OPT4060_CTRL_OPER_MODE_ONE_SHOT);
> +
> +	/* Trigger a new conversions by writing to CRTL register. */
> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to set ctrl register\n");
> +	return ret;
> +}
> +
> +static bool opt4060_event_active(struct opt4060_chip *chip)
> +{
> +	return chip->thresh_event_lo_active || chip->thresh_event_hi_active;
> +}
> +
> +static int opt4060_set_state_common(struct opt4060_chip *chip,
> +				    bool continuous_sampling,
> +				    bool continuous_irq, bool direct_mode)
> +{
> +	int ret = 0;
> +
> +	/* It is important to setup irq before sampling to avoid missing samples. */
> +	if (continuous_irq || !direct_mode)
> +		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_ALL_CH);
> +	else if (direct_mode)
> +		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to set irq state.\n");
> +		return ret;
> +	}
> +
> +	if (continuous_sampling || !direct_mode || opt4060_event_active(chip))

I think there may also a race around the event active check.  You could have
one event direction being enabled concurrently with the other being disabled.
I'm not sure it matters but worth checking.

Side effect of either claiming direct or buffered mode is that only one
caller can do it at a time, so that would close this race as well. 
Having said that, it's an implementation detail of the core (be it one that
has been there a long time) so you should really have your own driver
specific locking scheme prevent that.


> +		ret = opt4060_set_continuous_mode(chip, true);
> +	else if (direct_mode)
> +		ret = opt4060_set_continuous_mode(chip, false);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to set sampling state.\n");
> +	return ret;
> +}
> +
> +/*
> + * Function for setting the driver state for sampling and irq. When disabling
> + * continuous sampling or irq, the IIO direct mode must be claimed to prevent
> + * races with buffer enabling/disabling. In the case when the direct mode is
> + * not possible to claim, the function will keep continuous mode. All
> + * functions, sysfs read, events and buffer, work in continuous mode.
> + */
> +static int opt4060_set_driver_state(struct iio_dev *indio_dev,
> +				    bool continuous_sampling,
> +				    bool continuous_irq)
> +{
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	bool direct_mode = false;
> +	int ret = 0;
> +
> +	if (!iio_device_claim_direct_mode(indio_dev))
> +		direct_mode = true;

Hmm. I'm dubious about this pattern. Why is it fine if the driver
leaves buffered mode right here? I was expecting this to do
the dance with claiming either direct mode or buffered mode.
(with the retry loop).  Direct mode that you pass into the next
call may well be false when it should be true.

Even if you can reason why that isn't a problem (and there are worse
dances where it switches mode multiple times during your call
of the next function to consider) I think it is easier to reason
about if we know it is definitely not changing state until we
release it.

> +
> +	ret = opt4060_set_state_common(chip, continuous_sampling,
> +				       continuous_irq, direct_mode);
> +
> +	if (direct_mode)
> +		iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
> +/*
> + * This function is called in direct mode from the framework.
> + */
> +static int opt4060_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	return ret = opt4060_set_state_common(chip, state, state, true);

return opt_set_state_common() is probably the intent.

> +}

> +static int opt4060_trigger_new_samples(struct iio_dev *indio_dev)
> +{
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	/*
> +	 * The conversion time should be 500us startup time plus the integration time
> +	 * times the number of channels. An exact timeout isn't critical, it's better
> +	 * not to get incorrect errors in the log. Setting the timeout to double the
> +	 * theoretical time plus and extra 100ms margin.
> +	 */
> +	unsigned int timeout_us = (500 + OPT4060_NUM_CHANS *
> +				  opt4060_int_time_reg[chip->int_time][0]) * 2 + 100000;
> +
> +	/* Setting the state in one shot mode with irq on each sample. */
> +	ret = opt4060_set_driver_state(indio_dev, false, true);
> +	if (ret)
> +		return ret;
> +
> +	if (chip->irq) {
> +		reinit_completion(&chip->completion);
> +		opt4060_claim_irq_setting_lock(chip);
> +		if (wait_for_completion_timeout(&chip->completion,
> +						usecs_to_jiffies(timeout_us)) == 0) {
> +			dev_err(chip->dev, "Completion timed out.\n");
> +			opt4060_release_irq_setting_lock(chip);

This is where exposing the lock directly will simplify things as you can just use
a guard.

> +			return -ETIME;
> +		}
> +		opt4060_release_irq_setting_lock(chip);
> +	} else {
> +		unsigned int ready;
> +
> +		ret = regmap_read_poll_timeout(chip->regmap, OPT4060_RES_CTRL,
> +					       ready, (ready & OPT4060_RES_CTRL_CONV_READY),
> +					       1000, timeout_us);
> +		if (ret)
> +			dev_err(chip->dev, "Conversion ready did not finish within timeout.\n");
> +	}
> +	/* Setting the state in one shot mode with irq on thresholds. */
> +	ret = opt4060_set_driver_state(indio_dev, false, false);
> +
> +	return ret;

	return opt4060_...

> +}

> +static int opt4060_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return IIO_VAL_INT_PLUS_MICRO;
IIRC That's the default, so you don't need to provide write_raw_get_fmt,
though no harm in doing so I guess.

> +	default:
> +		return -EINVAL;
> +	}
> +}


> +static int opt4060_get_channel_sel(struct opt4060_chip *chip, int *ch_sel)
> +{
> +	int ret;
> +	u32 regval;
> +
> +	ret = regmap_read(chip->regmap, OPT4060_INT_CTRL, &regval);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to get channel selection.\n");

if you have garbage, not sure it's valid to update ch_sel.

> +	*ch_sel = FIELD_GET(OPT4060_INT_CTRL_THRESH_SEL, regval);
> +	return ret;
> +}
> +


> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, bool state)
> +{
> +	int ch_sel, ch_idx = chan->scan_index;
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (chan->type != IIO_INTENSITY)
> +		return -EINVAL;
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	ret = opt4060_get_channel_sel(chip, &ch_sel);
> +	if (ret)
> +		return ret;
> +
> +	if (state) {
> +		/* Only one channel can be active at the same time */
> +		if ((chip->thresh_event_lo_active ||
> +			chip->thresh_event_hi_active) && (ch_idx != ch_sel))

That's a bit nasty to ready. I'd use a slightly long line and get the || pair
on the first line.

Hmm. We've never made rules on this but some devices to fifo type
selection if they have limitations on events enabled at the same time.
With hindsight I think this scheme of just saying no is probably more
user friendly.

> +			return -EBUSY;
> +		if (dir == IIO_EV_DIR_FALLING)
> +			chip->thresh_event_lo_active = true;
> +		else if (dir == IIO_EV_DIR_RISING)
> +			chip->thresh_event_hi_active = true;
> +		ret = opt4060_set_channel_sel(chip, ch_idx);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (ch_idx == ch_sel) {
> +			if (dir == IIO_EV_DIR_FALLING)
> +				chip->thresh_event_lo_active = false;
> +			else if (dir == IIO_EV_DIR_RISING)
> +				chip->thresh_event_hi_active = false;
> +		}
> +	}
> +
> +	return opt4060_set_driver_state(indio_dev, chip->thresh_event_hi_active |
> +					chip->thresh_event_lo_active, false);
Maybe wrap it to have the | pair on lines with nothing else.  They are a little bit burried
otherwise.
	return opt4060_set_driver_state(indio_dev,
					chip->thresh_event_hi_active |
					chip->thresh_event_lo_active,
					false);

> +}
> +
> +static const struct iio_info opt4060_info = {
> +	.read_raw = opt4060_read_raw,
> +	.write_raw = opt4060_write_raw,
> +	.write_raw_get_fmt = opt4060_write_raw_get_fmt,
> +	.read_avail = opt4060_read_available,
> +	.read_event_value = opt4060_read_event,
> +	.write_event_value = opt4060_write_event,
> +	.read_event_config = opt4060_read_event_config,
> +	.write_event_config = opt4060_write_event_config,
> +};

Given you have option for no irq it is probably worth picking a version of this
info structure with all the event callbacks removed.   Technically it isn't
required but it does harden the code (by crashing horribly if you call them ;)



> +static irqreturn_t opt4060_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct opt4060_chip *chip = iio_priv(idev);
> +	struct  {
> +		u32 chan[OPT4060_NUM_CHANS];
> +		aligned_s64 ts;
> +	} raw;
> +	int i = 0;
> +	int chan, ret;
> +
> +	/* If the trigger is coming for a different driver, a new sample is needed.*/

from a different driver?

> +	if (iio_trigger_validate_own_device(idev->trig, idev))
> +		opt4060_trigger_new_samples(idev);
> +
> +	memset(&raw, 0, sizeof(raw));
> +
> +	iio_for_each_active_channel(idev, chan) {
> +		if (chan == OPT4060_ILLUM)
> +			ret = opt4060_calc_illuminance(chip, &raw.chan[i++]);
> +		else
> +			ret = opt4060_read_raw_value(chip,
> +						     idev->channels[chan].address,
> +						     &raw.chan[i++]);
> +		if (ret) {
> +			dev_err(chip->dev, "Reading channel data failed\n");
> +			goto err_read;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
> +err_read:
> +	iio_trigger_notify_done(idev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t opt4060_irq_thread(int irq, void *private)
> +{
> +	struct iio_dev *idev = private;
> +	struct opt4060_chip *chip = iio_priv(idev);
> +	int ret, dummy;
> +	unsigned int int_res;
> +
> +	ret = regmap_read(chip->regmap, OPT4060_RES_CTRL, &int_res);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to read interrupt reasons.\n");
> +		return IRQ_NONE;
> +	}
> +
> +	/* Read OPT4060_CTRL to clear interrupt */
> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &dummy);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to clear interrupt\n");
> +		return IRQ_NONE;
> +	}
> +
> +	/* Handle events */
> +	if (int_res & (OPT4060_RES_CTRL_FLAG_H | OPT4060_RES_CTRL_FLAG_L)) {
> +		u64 code;
> +		int chan = 0;
> +
> +		ret = opt4060_get_channel_sel(chip, &chan);
> +		if (ret) {
> +			dev_err(chip->dev, "Failed to read threshold channel.\n");
> +			return IRQ_NONE;
> +		}
> +
> +		/* Check if the interrupt is from the lower threshold */
> +		if (int_res & OPT4060_RES_CTRL_FLAG_L) {
> +			code = IIO_MOD_EVENT_CODE(IIO_INTENSITY,
> +						  chan,
> +						  idev->channels[chan].channel2,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING);
> +			iio_push_event(idev, code, iio_get_time_ns(idev));
> +		}
> +		/* Check if the interrupt is from the upper threshold */
> +		if (int_res & OPT4060_RES_CTRL_FLAG_H) {
> +			code = IIO_MOD_EVENT_CODE(IIO_INTENSITY,
> +						  chan,
> +						  idev->channels[chan].channel2,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_RISING);
> +			iio_push_event(idev, code, iio_get_time_ns(idev));
> +		}
> +	}
> +
> +	/* Handle conversion ready */
> +	if (int_res & OPT4060_RES_CTRL_CONV_READY) {
> +		/* Signal completion for potentially waiting reads */
> +		complete(&chip->completion);

That looks problematic as you haven't necessarily reset the completion
if the buffer is enabled.  So you probably need a flag or something similar
to say a sysfs read has been requested.


> +
> +		/* Handle data ready triggers */
> +		if (iio_buffer_enabled(idev))
> +			iio_trigger_poll_nested(chip->trig);
> +	}
> +	return IRQ_HANDLED;
> +}

> +static int opt4060_setup_trigger(struct opt4060_chip *chip, struct iio_dev *idev)
> +{
> +	struct iio_trigger *data_trigger;
> +	char *name;
> +	int ret;
> +
> +	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
> +					      idev->name, iio_device_id(idev));
> +	if (!data_trigger)
> +		return -ENOMEM;
> +
> +	/* The data trigger allows for sample capture on each new conversion ready interrupt. */

Make that a multiline comment.

> +	chip->trig = data_trigger;
> +	data_trigger->ops = &opt4060_trigger_ops;
> +	iio_trigger_set_drvdata(data_trigger, idev);
> +	ret = devm_iio_trigger_register(chip->dev, data_trigger);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "Data ready trigger registration failed\n");
> +
> +	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
> +			      dev_name(chip->dev));
> +	if (!name)
> +		return dev_err_probe(chip->dev, -ENOMEM, "Failed to alloc chip name\n");
> +
> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL, opt4060_irq_thread,
> +					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
That's unusual for a trigger type interrupt and seems likely to give a lot
of spurious interrupts.  Even if the pulse is short, some interrupt controllers
will hang on to the bonus edge and trigger again when you reenable the interrupt.

If intent is to use this for events, then I think you can configure it to latched
window mode and one edge type and it will all work.

> +					IRQF_ONESHOT, name, idev);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
> +
> +	init_completion(&chip->completion);
> +
> +	mutex_init(&chip->irq_setting_lock);

Trivial and I might not even bother changing it, but slightly preference for
	ret = devm_mutex_init(...)
	if (ret)
		return ret;

> +
> +	ret = regmap_write_bits(chip->regmap, OPT4060_INT_CTRL,
> +				OPT4060_INT_CTRL_OUTPUT,
> +				OPT4060_INT_CTRL_OUTPUT);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "Failed to set interrupt as output\n");
> +
> +	return 0;
> +}

