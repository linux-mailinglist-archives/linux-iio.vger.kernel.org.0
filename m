Return-Path: <linux-iio+bounces-12913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7D9DF597
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319C1B20E67
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9E1C07D3;
	Sun,  1 Dec 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngTbm/U8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB91BDAA5;
	Sun,  1 Dec 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733057477; cv=none; b=DNex1BAUNbIgqTQSQoBu/Tiylky381pP5dJY7J1PWG7QzC4CXKL8UrcezsNTFGoQ+b2nscAnsYBW00D3F32vegbhGIDC8RJ+A/uZJeun7vOy9PZnYRcXquhdffBAfTRsH3RC+QRz48dApL7+tEm6jKSjqOmCvho3tg6CTlndYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733057477; c=relaxed/simple;
	bh=KV44k5BTKi83D3nxirIEoEGOXK/oY3nsQ9bqh8HasWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QL3lJQt1ZnYyC5vVh8Fx7NFBW0PmySGygqGyenGlOeJC3U1vACY4hmRTqEU34EDXzckySwLItCkvDSsyxS9BIIkONM5MuHlHxvdh0hV89BMoNqTjm2JaQwVU2uNSw54FSgZa/88PLS+eTVfWaKw3nrO2x1hBA6JqeAOeFoTYGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngTbm/U8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A645BC4CECF;
	Sun,  1 Dec 2024 12:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733057477;
	bh=KV44k5BTKi83D3nxirIEoEGOXK/oY3nsQ9bqh8HasWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngTbm/U8J0b3ZysSQ6eSCHEVLqh5Jn3XdYJiBbMscbf7NImJ3jvWy2l0gTKKSb3zG
	 zLj/IjD5mDPrqMP1xqamoUjV1owp2vHwj9FZWTNbzX2kIeWeXLV37XwZBIHW6tj7c7
	 PHKAPWG6gE27p703/f2o2NNFW949ZqtNxO2zKOm/1WxBqHftuqVoW9Bc1vfsmoC7Fl
	 f+Hr2PAYhzAJQKUQeEtA3hSmoVIZ7jRM/i7/HEKSQ4HwgVou6bW28fD1xNOd3yPA46
	 5PyGX7uEBBBHQO9kmwwU3FYJviuv8vqzH3810djiKVo93imsuI/Wg/tDTAlO61FASM
	 mV0uga/uZrCmw==
Date: Sun, 1 Dec 2024 12:51:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rickard.andersson@axis.com>,
 <kernel@axis.com>
Subject: Re: [PATCH v8 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241201125107.2e62ffcc@jic23-huawei>
In-Reply-To: <20241126155312.1660271-3-perdaniel.olsson@axis.com>
References: <20241126155312.1660271-1-perdaniel.olsson@axis.com>
	<20241126155312.1660271-3-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 16:53:12 +0100
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> 
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>

Hi Per-Daniel.

I think we've been talking a bit cross purposes on the scale.  That
needs to be a multiplier, not a multiplied channel reading.

Other than that, I'd previously missed some issues around races wrt to the enabling
and disabling of the buffer.   They are unlikely to happen, but also fairly easy
to close, particularly if you don't mind not allowing channel reads via sysfs
at the same time as buffered capture.  This is a common restriction because
it greatly simplifies some drivers and the combined case isn't a usecase normally
cares about.

Thanks,

Jonathan

> diff --git a/Documentation/iio/opt4060.rst b/Documentation/iio/opt4060.rst
> new file mode 100644
> index 000000000000..f12552f27b26
> --- /dev/null
> +++ b/Documentation/iio/opt4060.rst
> @@ -0,0 +1,58 @@

> +
> +3. Scaled color values
> +=============================
> +
> +The driver supports scaled values for red, green and blue. The raw values are
> +scaled so that for a particular test light source, typically white, the
> +measurement intensity is the same across the different color channels. This is
> +calculated in the following way:
> +
> +R = RED_RAW x 2.4
> +G = GREEN_RAW x 1.0
> +B = BLUE_RAW x 1.3
> +
> +The values are accessed from:
> +/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
> +/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
> +/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale

This doesn't work with the normal IIO ABI definitions.  Those scales should be 2.4, 1.0 and 1.3
not a value calculated from the current value.


> +
> +The data sheet suggests using the scaled values to normalize the scaled R, G
> +and B values. This is useful to get a value for the ratio between colors
> +independent of light intensity. A userspace appliction can do this in the
> +following way:
> +
> +R_NORMALIZED = R / (R + G + B)
> +G_NORMALIZED = G / (R + G + B)
> +B_NORMALIZED = B / (R + G + B)
> +
> +See section 8.4.5.2 in the data sheet for additional details.
>
> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> new file mode 100644
> index 000000000000..086fe87e1325
> --- /dev/null
> +++ b/drivers/iio/light/opt4060.c
> @@ -0,0 +1,1289 @@

> +static int opt4060_trigger_one_shot(struct opt4060_chip *chip)
> +{
> +	int ret;
> +	unsigned int ctrl_reg;
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
> +	/* If the device is already in continuous mode, one-shot is not needed. */
> +	if (FIELD_GET(OPT4060_CTRL_OPER_MODE_MASK, ctrl_reg) ==
> +	    OPT4060_CTRL_OPER_MODE_CONTINUOUS)
With change suggested below to claim direct mode for read_raw() paths to here,
I think this only applies if the threshold interrupts are enabled?  If so
perhaps amend the comment if you do block the buffered capture and sysfs
at the same time path.

> +		return 0;
> +
> +	ctrl_reg &= ~OPT4060_CTRL_OPER_MODE_MASK;
> +	ctrl_reg |= FIELD_PREP(OPT4060_CTRL_OPER_MODE_MASK,
> +				OPT4060_CTRL_OPER_MODE_ONE_SHOT);
> +
> +	/* Trigger a new conversion by writing to CRTL register. */
> +	ret = regmap_write(chip->regmap, OPT4060_CTRL, ctrl_reg);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to set ctrl register\n");
> +	return ret;
> +}
> 
> +
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
> +	if (chip->irq) {
> +		reinit_completion(&chip->completion);
> +		ret = opt4060_trigger_one_shot(chip);
> +		if (ret)
> +			return ret;
> +		if (wait_for_completion_timeout(&chip->completion,
> +						usecs_to_jiffies(timeout_us)) == 0) {
> +			dev_err(chip->dev, "Completion timed out.\n");
> +			return -ETIME;
> +		}
> +		/*
> +		 * The opt4060_trigger_one_shot() function will enable irq on
> +		 * every conversion. If the buffer isn't enabled, irq should
> +		 * only be enabled for thresholds.
> +		 */
> +		if (!iio_buffer_enabled(indio_dev)) {

This is the race with buffer enable / disable in read_raw() call stack. That transition
can be avoided by iio_device_claim_direct_mode().  For this one I don't think we care
about that potentially blocking reads via sysfs.  That's a common thing anyway
for drivers to not support when the buffer is in use because it greatly simplifies the
code and normally mixing buffered interface and sysfs reads isn't something anyone does.

> +			ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
> +			if (ret)
> +				return ret;
> +		}
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
> +	return ret;
> +}

> +
> +/*
> + * Scales the raw value so that for a particular test light source, typically
> + * white, the measurement intensity is the same across different color channels.

I got lost in previous review discussion, but I thought we were getting rid of this.
Userspace software tends to assume that if it takes no actions to change
the configuration, scales will remain fixed.

If we really need to role these into sensors readings then we need to provide
a channel that does this.

Personally I see this as a user space problem.  I don't mind providing the
color factors as scale, but not a manipulated version of the channel reading.

Scale is applied as a multiplier on raw, not meaning 'scaled already channel'.



> + */
> +static int opt4060_read_chan_scale(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   int *val, int *val2)
> +{
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	static const u32 color_factors[] = { 24, 10, 13 };
> +	u32 adc_raw;
> +	int ret;
> +
> +	ret = opt4060_trigger_new_samples(indio_dev);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to trigger new samples.\n");
> +		return ret;
> +	}
> +
> +	ret = opt4060_read_raw_value(chip, chan->address, &adc_raw);
> +	if (ret) {
> +		dev_err(chip->dev, "Reading raw channel data failed\n");
> +		return ret;
> +	}
> +	adc_raw *= color_factors[chan->scan_index];
> +	*val = DIV_U64_ROUND_CLOSEST((u64)adc_raw, 10);
> +	return IIO_VAL_INT;
> +}


> +static int opt4060_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return opt4060_read_chan_raw(indio_dev, chan, val);

As mentioned elsewhere, this code relies on the mode not transitioning form
buffered to polled (or the opposite). So you should claim direct mode to pin
it as not moving to buffered mode.

> +	case IIO_CHAN_INFO_SCALE:
> +		return opt4060_read_chan_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_PROCESSED:
> +		return opt4060_read_illuminance(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = opt4060_int_time_reg[chip->int_time][0];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int opt4060_read_available(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  const int **vals, int *type, int *length,
> +				  long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(opt4060_int_time_available) * 2;
> +		*vals = (const int *)opt4060_int_time_available;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int opt4060_event_set_state(struct iio_dev *indio_dev, bool state)
> +{
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (state)
> +		ret = opt4060_set_continous_mode(chip, true);
> +	else if (!iio_buffer_enabled(indio_dev) && chip->irq)

See below - this is the call that races because we don't have the
device fixed in a particular state.

> +		ret = opt4060_set_continous_mode(chip, false);
> +
> +	if (ret)
> +		dev_err(chip->dev, "Failed to set event state.\n");
> +
> +	return ret;
> +}

>
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
This makes me a little nervous because we are allowing the control of
continous mode from here and the buffer setup and not preventing them
running at the same time.  Maybe there are no races, but I'm not convinced.

It is possible to avoid this, but fiddly as we shouldn't directly
take the iio_dev->mlock from a driver (which protects the buffer state
transitions.  Basically we need to successfully pin the device in
either direct or buffered mode and if we miss in both (due to a transition
in flight) retry.

There is one example doing this in the max30102.c
https://elixir.bootlin.com/linux/v6.12.1/source/drivers/iio/health/max30102.c#L479
(that one is weird because we read the channel in an entirely different way depending
 on the device mode).

I suspect we have other cases missed during review however.

The tricky bit is that most races around buffer enable are harmless
as they tend to mean we get one extra or one less sample pushed to the
buffer, or an read that perturbs the buffered capture timing.  So it
is fairly hard to spot a real one :(

This one is vanishingly unlikely though so I'm fine taking the driver
on the basis you'll take another look at close the race if you agree
with my analysis.  The side effect of this one is that we either
burn some power when no one is interested, or fail to enable data capture
if we hit the race. Neither is great, but not that bad either.

Jonathan


> +	return opt4060_event_set_state(indio_dev, chip->thresh_event_hi_active |
> +				       chip->thresh_event_lo_active);
> +}



