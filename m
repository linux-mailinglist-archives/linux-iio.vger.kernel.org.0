Return-Path: <linux-iio+bounces-10817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01D9A5417
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1601F223A7
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A824D19259A;
	Sun, 20 Oct 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z60yLC1/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4019004A;
	Sun, 20 Oct 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729428673; cv=none; b=IllIa2APvGsSawlg11RGG5y2gnZpGZEyBl3WnMtQayDDzO4tsdBuuVRR0X4SPNp8rWncE6gqh1iaBtmmShVgmG9ljWVL3cyLXFHCT83rWKwZ1mTTtY1BUmIPWcsUohJD8RIEUNdC3ALEF0+YTWx7pfUprUFUBc1Zp4KFQ+3m8zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729428673; c=relaxed/simple;
	bh=MvR3O2sA1XpTpYPv22OJbB2eFEPPX5fMpcXotOJp8uE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOJ+lMxoGljtcLapfjDw/aO8RDwoJY21gjeob9aPgbz2ckKY1DJWAFG825guvUDjPD7L0y9Lu12/RCCQF/SCuj0czMIEBhfp8iTKLZaRK/m6iIkUxkuzTv5bW674/Ahn4/LsXQfNE+VHc2btXG12lQeF61P8imaC6q5J5mGqHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z60yLC1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E079C4CEC6;
	Sun, 20 Oct 2024 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729428672;
	bh=MvR3O2sA1XpTpYPv22OJbB2eFEPPX5fMpcXotOJp8uE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z60yLC1/43EaGhAYFWy08hjiEIhj2CUmVAR1iIF19FTdNXps3NV08gJSVehfM/Fce
	 E3CM0fQjkVIP+IcKHzeqELeFwBXldyXPVvkRUHxlwLCEd7ZeYhLRonQKbiUr19xgIp
	 CNDcZc0ktE9l8P3DGm5LTjyubGLk8LvAvdg/7+bUUk9cGYp/GBa5dkFiuy9MqifJHH
	 8Ba6C953IWG00f0LGPZNccwfhtKgUibQlceVB660wUsgig611HcmSOkMkxZ/+1ovZK
	 qJd7L4gZy9PvZBfsFvArdLUcUYHiph2d9arfBHr8kZGExMgqJymL8XMyCjrI17xcEk
	 znFJEn5sbyMmA==
Date: Sun, 20 Oct 2024 13:51:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <rickard.andersson@axis.com>, <kernel@axis.com>
Subject: Re: [PATCH v4 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241020135105.36b29fe8@jic23-huawei>
In-Reply-To: <20241016213409.3823162-3-perdaniel.olsson@axis.com>
References: <20241016213409.3823162-1-perdaniel.olsson@axis.com>
	<20241016213409.3823162-3-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 23:34:09 +0200
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> 
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>

Hi Per-Daniel,

Comments inline.

Jonathan

> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> new file mode 100644
> index 000000000000..2c3761ec423a
> --- /dev/null
> +++ b/drivers/iio/light/opt4060.c
> @@ -0,0 +1,1259 @@

...

> +
> +struct opt4060_buffer {
> +	u32 chan[OPT4060_NUM_CHANS];
> +	s64 ts __aligned(8);

aligned_s64 is now available in linux-next + the IIO tree.

> +};
> +
> +static const struct opt4060_channel_factor opt4060_channel_factors[] = {
> +	{
> +		/* RED 2.4 * 2.15e-3 */
This needs more details on wrt to what standard etc.

The datasheet is a little vague, but it seems to me like TI invented their
own standard. To use this stuff in a consistent ABI we need to have
a common standard or at least an approximation of one.
The illuminance estimates from some devices are bad approximations, but they
are at least attempting to approximate a well defined standard.


> +		.mul = 516,
> +		.div = 100000,
> +	}, {
> +		/* GREEN 1.0 * 2.15e-3 */
> +		.mul = 215,
> +		.div = 100000,
> +	}, {
> +		/* BLUE 1.3 * 2.15e-3 */
> +		.mul = 258,
> +		.div = 100000,
> +	}, {
> +		/* CLEAR 1.0 * 2.15e-3 */
> +		.mul = 215,
> +		.div = 100000,
> +	},
> +};
>
> +
> +static int opt4060_trigger_one_shot(struct opt4060_chip *chip)
> +{
> +	int ret;
> +	unsigned int ctrl_reg, oper_mode;
> +
> +	/* Enable interrupt for conversion ready of all channels */
> +	ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_ALL_CH);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &ctrl_reg);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "Failed to read ctrl register\n");
> +		return ret;
> +	}
> +
> +	oper_mode = FIELD_GET(OPT4060_CTRL_OPER_MODE_MASK, ctrl_reg);
You are only using this once. Just put it inline and flip the logic

	if (FIELD_GET(....) ==
	    OPT4060_CTRL_OPER_MODE_CONTINUOUS)
		return 0;

	ctrl_reg...

> +
> +	/* If the device is already in continuous mode, one-shot is not needed. */
> +	if (oper_mode != OPT4060_CTRL_OPER_MODE_CONTINUOUS) {
> +		ctrl_reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
> +		ctrl_reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
> +				       OPT4060_CTRL_OPER_MODE_ONE_SHOT);
> +
> +		/* Trigger a new conversion by writing to CRTL register. */
> +		ret = regmap_write(chip->regmap, OPT4060_CTRL, ctrl_reg);
> +		if (ret)
> +			dev_err(chip->dev, "Failed to set ctrl register\n");
> +	}
> +	return ret;
> +}

> +static int opt4060_read_raw_value(struct opt4060_chip *chip,
> +				  unsigned long address, u32 *raw)
> +{
> +	int ret;
> +	u32 result, mantissa_raw;
> +	u16 msb, lsb;
> +	u8 exp, count, crc, calc_crc;
> +
> +	ret = regmap_bulk_read(chip->regmap, address, &result, 2);
You have the channel types for buffered access as little endian which is
not what this code will generate.

If this bulk read is little endian, then you need to read into an appropriate
type buffer and convert that to CPU endian before doing any of the maths.

Then the channel spec needs to be native endian not little endian.

> +	if (ret) {
> +		dev_err(chip->dev, "Reading channel data failed\n");
return here.

> +	} else {

All this then doesn't need to be indented.

> +		count = FIELD_GET(OPT4060_COUNTER_MASK, result >> 16);
> +		crc = FIELD_GET(OPT4060_CRC_MASK, result >> 16);
> +		lsb = FIELD_GET(OPT4060_LSB_MASK, result >> 16);
> +		exp = FIELD_GET(OPT4060_EXPONENT_MASK, result);
> +		msb = FIELD_GET(OPT4060_MSB_MASK, result);
> +		mantissa_raw = (msb << 8) + lsb;
> +		calc_crc = opt4060_calculate_crc(exp, mantissa_raw, count);
> +		if (calc_crc != crc)
> +			return -EIO;
> +
> +		*raw = mantissa_raw << exp;
> +	}
> +	return ret;
return 0.
> +}
> +
> +static int opt4060_read_chan_value(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2, bool processed)
> +{
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	u32 adc_raw;
> +	int ret;
> +	/*
> +	 * The conversion time should be 500us startup time plus the integration time
> +	 * times the number of channels. An exact timeout isn't critical, it's better
> +	 * not to get incorrect errors in the log. Setting the timeout to double the
> +	 * theoretical time plus and extra 100ms margin.
> +	 */
> +	unsigned int timeout_us = (500 + OPT4060_NUM_CHANS *
> +				  opt4060_int_time_reg[chip->int_time][0]) * 2 + 100000;
> +
> +	if (chip->irq) {
> +		reinit_completion(&chip->completion);
> +		ret = opt4060_trigger_one_shot(chip);
> +		if (ret)
> +			return ret;
> +		if (wait_for_completion_timeout(&chip->completion,
> +						usecs_to_jiffies(timeout_us)) == 0)
> +			dev_err(chip->dev, "Completion timed out.\n");

If so, return an appropriate error value, don't just carry on.

> +	} else {
> +		unsigned int ready;
> +
> +		ret = opt4060_trigger_one_shot(chip);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read_poll_timeout(chip->regmap, OPT4060_RES_CTRL,
> +					       ready, (ready & OPT4060_RES_CTRL_CONV_READY),
> +					       1000, timeout_us);
> +		if (ret)
> +			dev_err(chip->dev, "Conversion ready did not finish within timeout.\n");
> +	}
> +
> +	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
> +	if (ret) {
> +		dev_err(chip->dev, "Reading raw channel data failed\n");
> +		return ret;
> +	}
> +	if (processed) {
> +		/*
> +		 * The processed value are multiplied by factors that correspond to optical
> +		 * parameters in the sensor. The processed values gives more correct comparison
> +		 * between channels.
> +		 */

No to these.  We discussed this in review thread of earlier version. There is no
standard unit of comparison defined so this ABI is not something that userspace
can currently understand.

I'm not against introducing one, though it would need a bunch of investigation
into what the appropriate way to define this is. TI have chosen an option that
I don't recall seeing used by anyone else but maybe I'm wrong on that.
There are several competing RGB standards. https://en.wikipedia.org/wiki/RGB_color_spaces
provides some info

Also, thse are linear scales, so if we support them in the future
it would be via IIO_CHAN_INFO_SCALE not _PROCESSED.

> +		u32 lux_raw, rem;
> +		u32 mul = opt4060_channel_factors[chan->scan_index].mul;
> +		u32 div = opt4060_channel_factors[chan->scan_index].div;
> +
> +		lux_raw = adc_raw * mul;
> +		*val = div_u64_rem(lux_raw, div, &rem);
> +		*val2 = rem * div_u64(div, 10);
> +		return IIO_VAL_INT_PLUS_NANO;
> +	}
> +	*val = adc_raw;
> +	return IIO_VAL_INT;
> +}



> +static int opt4060_trigger_set_state(struct iio_trigger *trig, bool state)
This should be just enabling or disabling the hardware trigger, not
modifying anything else about the state tracking in the IIO core etc
so if you need to do that, maybe we have a bug in the core.
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (indio_dev->trig) {
> +		iio_trigger_put(indio_dev->trig);
> +		indio_dev->trig = NULL;

You should not touch indio_dev->trig directly.  Why do you think it is needed?
If there is another driver doing that, then which one as it's probably a bug.

> +	}
> +
> +	if (state) {
> +		indio_dev->trig = iio_trigger_get(trig);
This should all be handled via the sysfs attribute handling in the core. You should
not need to modify the assigned trigger or do any reference counting.

The only use for setting this when there is only one valid trigger
and you want to initialize the driver using it at probe.  After that, don't touch 
indio-dev->trigger from your driver.

> +		ret = opt4060_set_continous_mode(chip, true);
> +	} else if (!opt4060_event_active(chip) && chip->irq) {
> +		ret = opt4060_set_continous_mode(chip, false);
> +	}

If these failed. Return an error. Don't try to just carry on.

> +
> +	if (trig == chip->data_trig) {
> +		chip->data_trigger_active = state;
> +		chip->threshold_trigger_active = !state;
> +	} else if (trig == chip->threshold_trig) {
> +		chip->data_trigger_active = !state;
> +		chip->threshold_trigger_active = state;
> +	}
> +
> +	return ret;
> +}

> +
> +static int opt4060_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	int ch_sel, ch_idx = chan->scan_index;
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_INTENSITY)
> +		return -EINVAL;
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (opt4060_get_channel_sel(chip, &ch_sel))
> +		return -EFAULT;
> +
> +	if (((dir == IIO_EV_DIR_FALLING) && chip->thresh_event_lo_active) ||
> +	    ((dir == IIO_EV_DIR_RISING) && chip->thresh_event_hi_active))
> +		return (ch_sel == ch_idx);
Brackets not needed
		return ch_sel == ch_idx;
is fine.

> +
> +	return FALSE;
false.
Check for any more of these.

> +}
> +
> +static int opt4060_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	int ch_sel, ch_idx = chan->scan_index;
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_INTENSITY)
> +		return -EINVAL;
> +	if (type != IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (opt4060_get_channel_sel(chip, &ch_sel))
> +		return -EFAULT;
> +
> +	if (state) {
> +		/* Only one channel can be active at the same time */
> +		if ((chip->thresh_event_lo_active ||
> +			chip->thresh_event_hi_active) && (ch_idx != ch_sel))
> +			return -EBUSY;
> +		if (dir == IIO_EV_DIR_FALLING)
> +			chip->thresh_event_lo_active = TRUE;
true

> +		else if (dir == IIO_EV_DIR_RISING)
> +			chip->thresh_event_hi_active = TRUE;
true

> +		if (opt4060_set_channel_sel(chip, ch_idx))
> +			return -EFAULT;
Don't eat the return value. Return whatever the function gives
you if it is an error. May convey more useful information.
> +	} else {
> +		if (ch_idx == ch_sel) {
> +			if (dir == IIO_EV_DIR_FALLING)
> +				chip->thresh_event_lo_active = FALSE;
> +			else if (dir == IIO_EV_DIR_RISING)
> +				chip->thresh_event_hi_active = FALSE;
> +		}
> +	}
> +
> +	if (opt4060_event_set_state(chip, chip->thresh_event_hi_active |
> +					chip->thresh_event_lo_active))
> +		return -EFAULT;

As above. Avoid eating error values from lower levels.
Check for other instances of this as I won't comment on more.

> +	return 0;
> +}

...

> +static int opt4060_load_defaults(struct opt4060_chip *chip)
> +{
> +	u16 reg;
> +	int ret;
> +
> +	chip->int_time = OPT4060_DEFAULT_CONVERSION_TIME;
> +
> +	/* Set initial MIN/MAX thresholds */
> +	ret = opt4060_set_thresholds(chip, 0, UINT_MAX);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Setting auto-range, latched window for thresholds, one-shot conversion
> +	 * and quick wake-up mode as default.
> +	 */
> +	reg = FIELD_PREP(OPT4060_CTRL_RANGE_MASK,
> +			 OPT4060_CTRL_LIGHT_SCALE_AUTO);
> +	reg |= FIELD_PREP(OPT4060_CTRL_CONV_TIME_MASK, chip->int_time);
> +	reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
> +				OPT4060_CTRL_OPER_MODE_ONE_SHOT);
As below - this seems to be where the device is turned on, so...
> +	reg |= OPT4060_CTRL_QWAKE_MASK | OPT4060_CTRL_LATCH_MASK;
> +
> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, reg);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to set configuration\n");
> +
I'd really expect to see the devm_add_action_or_reset() that turns it off
again here (or immediately after handling any errors from this function
at the caller).

> +	return ret;
> +}

> +
> +static int opt4060_buffer_preenable(struct iio_dev *idev)
> +{
> +	struct opt4060_chip *chip = iio_priv(idev);
> +
> +	return opt4060_trigger_one_shot(chip);
This needs a comment. Not obvious why a preenable would trigger anything.

> +}
> +
> +static const struct iio_buffer_setup_ops opt4060_buffer_ops = {
> +	.preenable = opt4060_buffer_preenable,
> +};
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
> +	if (!chip->data_trigger_active) {
> +		/* Only trigger interrupts on thresholds */
> +		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);

This looks unusual. It seems to be modifying the interrupt
control register in an interrupt handler.  Writing a status register to clear
is fine but this doesn't make much sense to me as you are changing what generates
an interrupt in the handler for that interrupt.

> +		if (ret) {
> +			dev_err(chip->dev, "Failed to set interrupt state\n");
> +			return IRQ_NONE;
> +		}
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
> +			code = IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> +						    chan,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING);
> +			iio_push_event(idev, code, iio_get_time_ns(idev));
> +		}
> +		/* Check if the interrupt is from the upper threshold */
> +		if (int_res & OPT4060_RES_CTRL_FLAG_H) {
> +			code = IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> +						    chan,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING);
> +			iio_push_event(idev, code, iio_get_time_ns(idev));
> +		}
> +		/* Handle threshold triggers */
> +		if (chip->threshold_trigger_active && iio_buffer_enabled(idev))
> +			iio_trigger_poll_nested(chip->threshold_trig);
> +	}
> +
> +	/* Handle conversion ready */
> +	if (int_res & OPT4060_RES_CTRL_CONV_READY) {
> +		/* Signal completion for potentially waiting reads */
> +		complete(&chip->completion);
> +
> +		/* Handle data ready triggers */
> +		if (chip->data_trigger_active && iio_buffer_enabled(idev))
> +			iio_trigger_poll_nested(chip->data_trig);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static int opt4060_setup_triggers(struct opt4060_chip *chip, struct iio_dev *idev)
> +{
> +	struct iio_trigger *data_trigger;
> +	struct iio_trigger *threshold_trigger;
> +	char *name;
> +	int ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(chip->dev, idev,
> +					      &iio_pollfunc_store_time,
> +					      opt4060_trigger_handler,
> +					      &opt4060_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL\n");
> +
> +	data_trigger = devm_iio_trigger_alloc(chip->dev, "%s-data-ready-dev%d",
> +					      idev->name, iio_device_id(idev));
> +	if (!data_trigger)
> +		return -ENOMEM;
> +
> +	/* The data trigger allows for sample capture on each new conversion ready interrupt. */
> +	chip->data_trig = data_trigger;
> +	data_trigger->ops = &opt4060_trigger_ops;
> +	iio_trigger_set_drvdata(data_trigger, idev);
> +	ret = devm_iio_trigger_register(chip->dev, data_trigger);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "Data ready trigger registration failed\n");
> +
> +	threshold_trigger = devm_iio_trigger_alloc(chip->dev, "%s-threshold-dev%d",
> +				       idev->name, iio_device_id(idev));
> +	if (!threshold_trigger)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The threshold trigger allows for sample capture on threshold interrupts.
> +	 * Just using events does not enable a way to get the samples that actually
> +	 * triggered the threshold interrupt.
> +	 */
> +	chip->threshold_trig = threshold_trigger;
> +	threshold_trigger->ops = &opt4060_trigger_ops;

Whilst I understand your usecase for this, I'd rather not have it in the initial
driver.  The use of events to trigger data capture should be a generic feature
not one buried in a specific driver.  Best bet for initial merge would be
to just stick to the dataready trigger alone.
+ I'd also encourage you to look at if your usespace code can be made less sensitive
to slightly late read back and hence potentially not a precise match with the
trigger event.


> +	iio_trigger_set_drvdata(threshold_trigger, idev);
> +	ret = devm_iio_trigger_register(chip->dev, threshold_trigger);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "Threshold trigger registration failed\n");
> +
> +	name = devm_kasprintf(chip->dev, GFP_KERNEL, "%s-opt4060",
> +			      dev_name(chip->dev));
> +	if (!name)
> +		return dev_err_probe(chip->dev, -ENOMEM, "Failed to alloc chip name\n");
> +
> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL, opt4060_irq_thread,
> +					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> +					IRQF_ONESHOT, name, idev);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret, "Could not request IRQ\n");
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
> +
> +static int opt4060_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct opt4060_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	uint dev_id;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &opt4060_regmap_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(dev, PTR_ERR(chip->regmap),
> +				     "regmap initialization failed\n");
> +
> +	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);

This isn't obvious paired with a setup routine. I think it matches with the
write to oneshot mode in opt4060_load_defaults.
As such this devm action setup should be immediately after that call, not
up here.

Functionally it makes little difference because turning the chip off
should be idempotent, but none the less it makes code more logical to follow
if we can keep that type coupling of setup and tear down.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to setup power off action\n");
> +
> +	chip->dev = dev;
> +	chip->irq = client->irq;
> +	init_completion(&chip->completion);
> +
> +	indio_dev->info = &opt4060_info;
> +
> +	ret = regmap_reinit_cache(chip->regmap, &opt4060_regmap_config);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to reinit regmap cache\n");
> +
> +	ret = regmap_read(chip->regmap, OPT4060_DEVICE_ID, &dev_id);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"Failed to read the device ID register\n");
> +
> +	dev_id = FIELD_GET(OPT4060_DEVICE_ID_MASK, dev_id);
> +	if (dev_id != OPT4060_DEVICE_ID_VAL)
> +		dev_info(dev, "Device ID: %#04x unknown\n", dev_id);
> +
> +	if (chip->irq) {
> +		indio_dev->channels = opt4060_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels);
> +	} else {
> +		indio_dev->channels = opt4060_channels_no_irq;
> +		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels_no_irq);
> +	}
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = dev->driver->name;

I'd prefer it hard coded. The driver name can change more easily than ABI
like this. Better to just have the string inline here as well.

> +
> +	ret = opt4060_load_defaults(chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set sensor defaults\n");
ret = devm_add_action_or_oreset(dev, opt4060_chip_off_action, chip)
should either be here, or moved into load_defaults to be right next to the
register write this is reversing.

> +
> +	if (chip->irq) {
> +		ret = opt4060_setup_triggers(chip, indio_dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


