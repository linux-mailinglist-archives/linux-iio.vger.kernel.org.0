Return-Path: <linux-iio+bounces-12085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141A89C2E07
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317C01C20E4A
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12895199FCC;
	Sat,  9 Nov 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPXXeaFO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11EF19994D;
	Sat,  9 Nov 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731165000; cv=none; b=WHwuMcIdoMphnLlQoJUIvfMz9tJOZjrLK5vGOu6Rzw5pJe0joyVFBsrjvq3JVTnBMvY+RWmw8yTLXrVijoYYvzgCDwzLKTlwxBJeWYsg64dgY/qwm/lGHl1Y/op4CSGBR1TcPpIwDWWAMawheirZGoMiVd0tuAv8cIYp+XJiGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731165000; c=relaxed/simple;
	bh=mRph8EVaPEejEg+ESFNOmA5jgnJVCj518ZEkO7JBl28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdIIrDsJ6QZdm69+nu1qbecU3P628FiyIiKC1+etWXXW9Wtlx/cWz2RwY5Oeg05fKqKRNHpPrBt/+0prvJAo8jq00BWZxoEALaDtDsfbOZl4Za7MMzblaEskvPBZDdhSllYDv/AmfsKSdtr02zI8GbZiAXlJIB/Mj4u66HmJzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPXXeaFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F2C4CED2;
	Sat,  9 Nov 2024 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731165000;
	bh=mRph8EVaPEejEg+ESFNOmA5jgnJVCj518ZEkO7JBl28=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nPXXeaFO3jR+8TQX2Ll1x5ZwJkvkaTseS/SLiTIkYHGgaKj4EZCLONd/Mp+kotmjq
	 iUhE+p2KEnkU88IyuCL7hTtnP65/021KmIK/BYpqD4kjrsDOeT2J4e0aa0nkjaX1r6
	 g2b1Hww0Yw9SK2C3f7AoxZAuhd/+9yVh4cgY/54SClvRCfy8kLi+5K9+fuY4np/xS5
	 rO/F3gpJUbRG6XyiaDqw9vQ5R/+h4k7+JyVWBAQ9SB3oc3UiKC39aarqH526trtJJM
	 QmtsL9QTd+faG8oqPCHxg1YtgIgGaCK0oI9LC6oTnm77pNyY4jcAgflasnCyylRQRv
	 ka9M87zqKJ8Sg==
Date: Sat, 9 Nov 2024 15:09:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <rickard.andersson@axis.com>, <kernel@axis.com>
Subject: Re: [PATCH v5 2/2] iio: light: Add support for TI OPT4060 color
 sensor
Message-ID: <20241109150955.7526c416@jic23-huawei>
In-Reply-To: <20241106120036.986755-3-perdaniel.olsson@axis.com>
References: <20241106120036.986755-1-perdaniel.olsson@axis.com>
	<20241106120036.986755-3-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 13:00:36 +0100
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> Add support for Texas Instruments OPT4060 RGBW Color sensor.
> 
> Signed-off-by: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Hi Per-Daniel

Main comment in here is that the ABI is standard (though oddly
missing in some cases from the main ABI doc). Annoyingly the
docs build process (try make htmldocs) does not work if there
are multiple entries for the same ABI, so we need to ensure that
the documentation for common ABI is in just one place.
That makes device specific ABI docs tricky, so instead we tend
to use extra rst files in Documentation/iio/ to provide more details.

Jonathan


> ---
>  .../ABI/testing/sysfs-bus-iio-light-opt4060   |   66 +
>  drivers/iio/light/Kconfig                     |   13 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/opt4060.c                   | 1282 +++++++++++++++++
>  4 files changed, 1362 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
>  create mode 100644 drivers/iio/light/opt4060.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060 b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
> new file mode 100644
> index 000000000000..187e750602ee
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-opt4060
> @@ -0,0 +1,66 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_raw

Huh... This is general ABI but not present in the sysfs-bus-iio
where it should be.  There are some control parameters on these channels
but not the actual channels.

Please add them there instead of in a device specific file.
Also group the 3 colors together as done for intensity_x, _y, _z

> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Unit-less raw value for red intensity.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_red_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Decimal value for the red component of the light. The value
> +		is normalized to give the relative red component
> +		independently of the light intensity.

I'm not sure I understand this text.   Also why Decimal?
Maybe something like:

"Scales the raw value so that for a particular test light source, typically
white, the measurement intensity is the same across different colour channels."

>  The raw value for red
> +		is multiplied by 2.4 before being normalized, this to adapt
> +		to the relative sensitivity of the red filter of the sensor.
> +		The factor for green is 1.0 and the factor for blue is 1.3.
An unfortunately characteristic of the ABI docs is we can't have duplication so
once this is moved to the general docs this detail will have to go in favour
of generality.  You could add a little 'footnote' to the entry to say that
for this particular device the meaning is this.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_raw
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Unit-less raw value for green intensity.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_green_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Decimal value for the green component of the light. The
> +		value is normalized to give the relative green component
> +		independently of the light intensity. The raw value for
> +		green is multiplied by 1.0 before being normalized, this to
> +		adapt to the relative sensitivity of the green filter of
> +		the sensor. The factor for red is 2.4 and the factor for
> +		blue is 1.3.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_raw
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Unit-less raw value for blue intensity.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_blue_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Decimal value for the blue component of the light. The
> +		value is normalized to give the relative blue component
> +		independently of the light intensity. The raw value for
> +		blue is multiplied by 1.3 before being normalized, this to
> +		adapt to the relative sensitivity of the blue filter of the
> +		sensor. The factor for red is 2.4 and the factor for green
> +		is 1.0.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_clear_raw
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Unit-less raw value for clear intensity.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_input
This is already in the main ABI doc. 
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lux value for the light illuminance. The value is
> +		calculated using the wide spectrum green channel and
> +		multiplied by 2.15e-3.
It may be worth capturing these details in an rst file under 
Documentation/iio/  Just remember to add an entry in the index.rst file
there so that they get included in the docs buidl.

> diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
> new file mode 100644
> index 000000000000..218ca3fd74f5
> --- /dev/null
> +++ b/drivers/iio/light/opt4060.c
> @@ -0,0 +1,1282 @@

> +
> +static int opt4060_trigger_set_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct opt4060_chip *chip = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (state) {
> +		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_ALL_CH);
> +		if (ret)
> +			return ret;
> +		ret = opt4060_set_continous_mode(chip, true);
> +	} else {
> +		if (!opt4060_event_active(chip) && chip->irq) {
> +			ret = opt4060_set_continous_mode(chip, false);
> +			if (ret)
> +				return ret;
> +		}
> +		ret = opt4060_set_int_state(chip, OPT4060_INT_CTRL_THRESHOLD);
> +	}
> +	return ret;
return in the if / else as nothing common to do down ehre.

> +}
> +
> +static ssize_t opt4060_read_ev_period(struct opt4060_chip *chip, int *val,
> +				     int *val2)
> +{
> +	int ret, pers, fault_count, int_time;
> +	u64 uval;
> +
> +	int_time = opt4060_int_time_reg[chip->int_time][0];
> +
> +	ret = regmap_read(chip->regmap, OPT4060_CTRL, &fault_count);
> +	if (ret < 0)
> +		return ret;
> +
> +	fault_count = fault_count & OPT4060_CTRL_FAULT_COUNT_MASK;
> +	switch (fault_count) {
> +	case OPT4060_CTRL_FAULT_COUNT_2:
> +		pers = 2;
> +		break;
> +	case OPT4060_CTRL_FAULT_COUNT_4:
> +		pers = 4;
> +		break;
> +	case OPT4060_CTRL_FAULT_COUNT_8:
> +		pers = 8;
> +		break;
> +
> +	default:
> +		pers = 1;
break from here too.  Not strictly necessary of course.

> +	}
> +
> +	uval = mul_u32_u32(int_time, pers);
> +	*val = div_u64_rem(uval, MICRO, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

> +
> +static irqreturn_t opt4060_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *idev = pf->indio_dev;
> +	struct opt4060_chip *chip = iio_priv(idev);
> +	struct opt4060_buffer raw;

Type only used in here, bring the definition down here as well.

> +	int ret, chan = 0, i = 0;
I'd prefer you don't mix assigned and unassign declarations on one line.
	int chan = 0, i = 0;
	int ret;

> +
> +	memset(&raw, 0, sizeof(raw));
> +
> +	iio_for_each_active_channel(idev, chan) {
Fairly sure that will init chan for you so shouldn't be needed above.
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
> +			code = IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
> +						    chan,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING);
> +			iio_push_event(idev, code, iio_get_time_ns(idev));
> +		}
> +		/* Check if the interrupt is from the upper threshold */
> +		if (int_res & OPT4060_RES_CTRL_FLAG_H) {
> +			code = IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
Unmodified?  Your channels are modified so this should be as well I think.



> +						    chan,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING);
> +			iio_push_event(idev, code, iio_get_time_ns(idev));
> +		}
> +	}
> +
> +	/* Handle conversion ready */
> +	if (int_res & OPT4060_RES_CTRL_CONV_READY) {
> +		/* Signal completion for potentially waiting reads */
> +		complete(&chip->completion);
> +
> +		/* Handle data ready triggers */
> +		if (iio_buffer_enabled(idev))
> +			iio_trigger_poll_nested(chip->trig);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static int opt4060_setup_triggers(struct opt4060_chip *chip, struct iio_dev *idev)
> +{
> +	struct iio_trigger *data_trigger;
> +	char *name;
> +	int ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(chip->dev, idev,
> +					      &iio_pollfunc_store_time,
> +					      opt4060_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret,
> +				     "iio_triggered_buffer_setup_ext FAIL\n");
>
Note using the ext form. Also I'd talk about what failed (buffer setup) rather
than the function that failed.

> +
> +static int opt4060_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct opt4060_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +	uint dev_id;
uint usages is unusual. and regmap takes an unsigned int
so spell it out fully.


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
> +	chip->dev = dev;
> +	chip->irq = client->irq;
> +	init_completion(&chip->completion);

Perhaps move to be dependent on the irq actually being available as I don't
think it is used otherwise.

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

Use a different variable for the register value and the field.
It is less confusing to read that way.

> +	if (dev_id != OPT4060_DEVICE_ID_VAL)
> +		dev_info(dev, "Device ID: %#04x unknown\n", dev_id);
> +
> +	if (chip->irq) {
> +		indio_dev->channels = opt4060_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels);
> +	} else {
> +		indio_dev->channels = opt4060_channels_no_events;
> +		indio_dev->num_channels = ARRAY_SIZE(opt4060_channels_no_events);
> +	}
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = "opt4060";
> +
> +	ret = opt4060_load_defaults(chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to set sensor defaults\n");
> +
> +	ret = devm_add_action_or_reset(dev, opt4060_chip_off_action, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to setup power off action\n");
> +
> +	if (chip->irq) {
> +		ret = opt4060_setup_triggers(chip, indio_dev);
Currently you only restrict the trigger to definitely be used with this device
but the device can be used with other triggers.  If that's intentional
you should setup the buffer whether or not the irq is available.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

