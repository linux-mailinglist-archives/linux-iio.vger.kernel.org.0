Return-Path: <linux-iio+bounces-6101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7ED9015C0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 12:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38213281A92
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 10:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4B22626;
	Sun,  9 Jun 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOzMYnSO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA2208A0;
	Sun,  9 Jun 2024 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717930387; cv=none; b=uqc72VD3/ZqJFnq5WP8J2M1CeVeVfWtXVevHgtNRyW1vPAlZUAbwNZH4CUtlr9npbOFrOLWBeprw13+BZxh7xFa6e0nhIkKtrcQzL6v4ettt3V4hbvZBN6Z2Hoa0NuxrrsWS4lrAwthnHWVujKwmlLNz7utuT2v0bZo4ysVzhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717930387; c=relaxed/simple;
	bh=4TjzXdy2y/vloKIRbES0m2lSAlhGGCOCU+yF5rVVpLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1kl9ALrhRFjG5YkPvNOQH3mNhWPWx7D2rReCxhqVMCq3dTU5aMUAsQwsdiBCTDD9MQGeVLfYI5jUzYqHrtrcZhT8kO/vZRvfKi9p1oWQoF37fbxO82RzVRbNbeWs2xHayTmekOVlP5UYbNtnUOI1unytIhw5/UgkLDoE95dcak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOzMYnSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD82C2BD10;
	Sun,  9 Jun 2024 10:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717930386;
	bh=4TjzXdy2y/vloKIRbES0m2lSAlhGGCOCU+yF5rVVpLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MOzMYnSO5ol+sPQPmUhTtpD8en6SuHDnThlN/hSzkwuFLKiMUM34li1yP2cbgq2Bv
	 CyGxlqloCWgwV+LE7PeAzBaz0AHf1UWSKjzRGaukpqBzfjTdj7DWDV3KdTwr+AgkXz
	 ZZTqM3H7Li+hKX63FIl8nsK7/KchL61HH3QDNsITwVdeFj35QOsBZMvCKTYmv4ENOu
	 D6SUQDy5vzSl85z58mViW5BTaZt8a/ysQtijViY4S3FP7fW4EjCskZ6f9KNligEQxe
	 hQ4Go0l47AJomEbNSWVBXATxGpaxXaLPPu4X5G/Q42U/gZXukMT124Pt1x5YZM+Anw
	 eMtR0zfWIxufA==
Date: Sun, 9 Jun 2024 11:52:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <20240609115234.20e08840@jic23-huawei>
In-Reply-To: <20240606163529.87528-3-francesco@dolcini.it>
References: <20240606163529.87528-1-francesco@dolcini.it>
	<20240606163529.87528-3-francesco@dolcini.it>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  6 Jun 2024 18:35:29 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
>=20
> The ADS1119 is a precision, 16-bit, analog-to-digital converter (ADC)
> that features two differential or four single-ended inputs through a
> flexible input multiplexer (MUX), rail-to-rail input
> buffers, a programmable gain stage, a voltage reference, and an
> oscillator.
>=20
> Apart from normal single conversion, the driver also supports
> continuous conversion mode using a triggered buffer. However, in this
> mode only one channel can be scanned at a time, and it only uses the data
> ready interrupt as a trigger. This is because the device channels are
> multiplexed, and using its own data ready interrupt as a trigger guarante=
es
> the signal sampling frequency.
>=20
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

A few more comments inline. Some of these I missed in the first
versions - sorry about that.  Takes a few passes to pick up
on everything unfortunately.

> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> new file mode 100644
> index 000000000000..ea0573f07279
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -0,0 +1,850 @@

> +
> +struct ads1119_state {
> +	unsigned long scan_masks[ADS1119_MAX_CHANNELS + 1];

Could you just use the onehot support in the IIO core?
iio_validate_scan_mask_onehot()=20

That combined with the channels not being available should
provide the required restrictions I think.

> +	u8 scan_buf[ADS1119_SCAN_BUFFER_SIZE];
> +	struct completion completion;
> +	struct i2c_client *client;
> +	struct gpio_desc *reset_gpio;
> +	struct iio_trigger *trig;
> +	struct ads1119_channel_config *channels_cfg;
> +	unsigned int num_bytes_sample;
> +	unsigned int num_channels_cfg;
> +	int vref_uV;
> +};

> +
> +static int ads1119_cmd(struct ads1119_state *st, unsigned int cmd)
> +{
> +	dev_dbg(&st->client->dev, "cmd: %#x\n", cmd);
> +
> +	return i2c_smbus_write_byte(st->client, cmd);
I'm not a fan of tiny wrappers to add debug info.
The i2c core has trace points that let you get to the relevant data. Better
to use those for debug and flatten this code so we
see the actual bus accesses inline.

> +}
> +
> +static int ads1119_cmd_wreg(struct ads1119_state *st, unsigned int val)
> +{
> +	dev_dbg(&st->client->dev, "wreg: %#x\n", val);
> +
> +	return i2c_smbus_write_byte_data(st->client, ADS1119_CMD_WREG, val);
> +}
> +
> +
> +static int ads1119_get_hw_datarate(int datarate)
> +{
> +	switch (datarate) {
> +	case 90:
> +		datarate =3D ADS1119_DR_90_SPS;
		return ADS1...
etc

> +		break;
> +	case 330:
> +		datarate =3D ADS1119_DR_330_SPS;
> +		break;
> +	case 1000:
> +		datarate =3D ADS1119_DR_1000_SPS;
> +		break;
> +	case 20:
> +	default:
> +		datarate =3D ADS1119_DR_20_SPS;
> +		break;
> +	}
> +
> +	return datarate;
and this can go as unused.
> +}
> +

> +
> +static int ads1119_poll_data_ready(struct ads1119_state *st,
> +				   struct iio_chan_spec const *chan)
> +{
> +	unsigned int datarate =3D st->channels_cfg[chan->address].datarate;
> +	unsigned long wait_time;
> +	bool data_ready;
> +
> +	/* Sleep between poll half of the data rate */
> +	wait_time =3D DIV_ROUND_CLOSEST(1000000, 2 * datarate);
> +
> +	return read_poll_timeout(ads1119_data_ready,
> +				 data_ready,
> +				 (data_ready =3D=3D true),
> +				 wait_time,
> +				 ADS1119_MAX_DRDY_TIMEOUT,
> +				 false,
> +				 st);
Over wrapped. Aim for closer to 80 chars.

> +}
> +
> +static int ads1119_read_data(struct ads1119_state *st,
> +			     struct iio_chan_spec const *chan,
> +			     unsigned int *val)
> +{
> +	unsigned int timeout;
> +	int ret =3D 0;
> +
> +	timeout =3D msecs_to_jiffies(ADS1119_MAX_DRDY_TIMEOUT);
> +
> +	if (!st->client->irq)
> +		ret =3D ads1119_poll_data_ready(st, chan);
		if (ret)
			return ret;
	} else if () {
> +	else if (!wait_for_completion_timeout(&st->completion, timeout))
> +		ret =3D -ETIMEDOUT;
		return -ETIMEDOUT;
}

Is probably clearer to the reader than poking a value into ret in the
timeout path just to share this error check.

> +
> +	if (ret)
> +		return ret;
> +
> +	return ads1119_cmd_rdata(st, val);
> +}
> +
> +static int ads1119_single_conversion(struct ads1119_state *st,
> +				     struct iio_chan_spec const *chan,
> +				     int *val,
> +				     bool calib_offset)
> +{
> +	struct device *dev =3D &st->client->dev;
> +	int mux, gain, datarate;
> +	unsigned int sample;
> +	int ret;
> +
> +	mux =3D st->channels_cfg[chan->address].mux;
> +	gain =3D st->channels_cfg[chan->address].gain;
> +	datarate =3D st->channels_cfg[chan->address].datarate;
> +
> +	if (calib_offset)
> +		mux =3D ADS1119_MUX_SHORTED;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		goto end;
> +
> +	ret =3D ads1119_configure_channel(st, mux, gain, datarate);
> +	if (ret)
> +		goto pdown;
> +
> +	ret =3D ads1119_cmd(st, ADS1119_CMD_START_SYNC);
> +	if (ret)
> +		goto pdown;
> +
> +	ret =3D ads1119_read_data(st, chan, &sample);
> +	if (ret)
> +		goto pdown;
> +
> +	*val =3D sign_extend32(sample, chan->scan_type.realbits - 1);
> +	ret =3D IIO_VAL_INT;
> +pdown:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +end:

Just return above rather than having this label.

> +	return ret;
> +}
> +

> +
> +static int ads1119_validate_gain(struct ads1119_state *st, int scale, in=
t uscale)
> +{
> +	int gain =3D 1000000 / ((scale * 1000000) + uscale);
> +
> +	switch (gain) {
> +	case 1:
> +	case 4:
> +		return gain;
Odd to calculate it if we don't need it
		return MICRO / (scale * MICRO + uscale);=20
use constants as it's easy to drop a 0 in these without anyone noticing.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

> +static int ads1119_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +	unsigned int index =3D chan->address;
> +
> +	if (index >=3D st->num_channels_cfg)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +			return ads1119_single_conversion(st, chan, val, false);
> +		unreachable();
> +	case IIO_CHAN_INFO_OFFSET:
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> +			return ads1119_single_conversion(st, chan, val, true);
> +		unreachable();
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D st->vref_uV / 1000;
> +		*val /=3D st->channels_cfg[index].gain;
> +		*val2 =3D chan->scan_type.realbits - 1;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->channels_cfg[index].datarate;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
Can't get here so drop this.=20

> +	return 0;
> +}
> +
> +static int ads1119_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +	unsigned int index =3D chan->address;
> +	int ret;
> +
> +	if (index >=3D st->num_channels_cfg)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D ads1119_validate_gain(st, val, val2);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->channels_cfg[index].gain =3D ret;
> +		break;

		return 0; etc
No point in a reader having to go look for the what happens after
the switch statement if nothing does.


> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D ads1119_validate_datarate(st, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->channels_cfg[index].datarate =3D ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

> +static int ads1119_set_trigger_state(struct iio_trigger *trig, bool stat=
e)
> +{
> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->client->dev;
> +	unsigned int index;
> +	int ret;
> +
> +	index =3D find_first_bit(indio_dev->active_scan_mask,
> +			       indio_dev->masklength);
> +
> +	if (index >=3D st->num_channels_cfg)
> +		return -EINVAL;
> +
> +	st->num_bytes_sample =3D
> +		indio_dev->channels[index].scan_type.storagebits / 8;
> +
> +	ret =3D ads1119_set_conv_mode(st, state);
> +	if (ret)
> +		return ret;
> +
> +	if (!state) {
> +		pm_runtime_mark_last_busy(dev);
> +		return pm_runtime_put_autosuspend(dev);
> +	}

When a trigger is tightly coupled to a device, the boundaries between
what makes sense in trigger_ops and what makes sense in the buffer ones
gets blurry.

To make it easier to relax need for the trigger (typical for some boards
to not wire the interrupt), in which case we set the device going and read
at a known lower rate using a hrtimer trigger or similar, I'd suggest
moving at least some of this.

I'd expect the interrupt source enabling if it's independent of enabling
capture in here and stuff more related to channel configuration either
in update_scan_modes, or in preenable for the buffer.

So almost everything in here belongs in the preenable for the buffer and
postdisable I think...



> +
> +	ret =3D ads1119_configure_channel(st,
> +					st->channels_cfg[index].mux,
> +					st->channels_cfg[index].gain,
> +					st->channels_cfg[index].datarate);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return ret;
> +
> +	return ads1119_cmd(st, ADS1119_CMD_START_SYNC);
> +}


> +static int ads1119_init(struct ads1119_state *st, bool vref_external)
> +{
> +	int ret;
> +
> +	ret =3D ads1119_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	if (vref_external)
> +		return ads1119_update_config_reg(st,
> +						 ADS1119_CONFIG_VREF_FIELD,
> +						 FIELD_PREP(ADS1119_CONFIG_VREF_FIELD,
> +							    ADS1119_VREF_EXTERNAL));
> +	return 0;
> +}
> +

Single blank line

> +
> +static int ads1119_map_analog_inputs_mux(int ain_pos, int ain_neg, bool =
differential)
...

> +
> +static int ads1119_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads1119_state *st;
> +	struct device *dev =3D &client->dev;
> +	bool vref_external =3D true;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate IIO device\n");
> +
> +	st =3D iio_priv(indio_dev);
> +	st->client =3D client;
> +
> +	indio_dev->name =3D "ads1119";
> +	indio_dev->info =3D &ads1119_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	st->vref_uV =3D devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (st->vref_uV =3D=3D -ENODEV) {
> +		vref_external =3D false;
> +		st->vref_uV =3D ADS1119_VREF_INTERNAL_VAL;
> +	} else if (st->vref_uV < 0) {
> +		return dev_err_probe(dev, st->vref_uV, "Failed to get vref\n");
> +	}
> +
> +	st->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
> +				     "Failed to get reset gpio\n");
> +
> +	ret =3D ads1119_alloc_and_config_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	init_completion(&st->completion);
> +
> +	if (client->irq > 0) {
> +		ret =3D devm_request_threaded_irq(dev,
> +						client->irq,
> +						ads1119_irq_handler,
> +						NULL,
> +						IRQF_TRIGGER_FALLING,
> +						"ads1119",
> +						indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to allocate irq\n");
> +
> +		st->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						  indio_dev->name,
> +						  iio_device_id(indio_dev));
> +		if (!st->trig)
> +			return dev_err_probe(dev, -ENOMEM,
> +					     "Failed to allocate IIO trigger\n");
> +
> +		st->trig->ops =3D &ads1119_trigger_ops;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +
> +		ret =3D devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to register IIO trigger\n");
> +
> +		indio_dev->trig =3D iio_trigger_get(st->trig);
> +
> +		ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +						      ads1119_trigger_handler,
> +						      NULL);

Is the device unable to use other triggers? You have the trigger validating
it is being used with the device, but nothing stopping the device being
disconnected from it's own trigger and connected to another one.
The validate_trigger callback IIRC.
We also have iio_trigger_set_immutable() to stop the unbind.

If it's not too hard to make it work with other triggers that can be
a very useful feature.


> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to setup IIO buffer\n");
> +	}

...

> +
> +static int ads1119_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +
> +	return ads1119_cmd(st, ADS1119_CMD_POWERDOWN);

I'd like an additional call of this power down command in the driver remova=
l path
via a devm_add_action_or_reset() as we always want to leave a device
powered down if we rip out the userspace intefaces!

In many cases it might be powered down anyway due to runtimepm, but
it might not by coincidence of timing, or because runtime_pm isn't built
or enabled for some reason.


> +}
> +
> +/*
> + * The ADS1119 does not require a resume function because it automatical=
ly powers
> + * on after a reset.
> + * After a power down command, the ADS1119 can still communicate but tur=
ns off its
> + * analog parts. To resume from power down, the device will power up aga=
in
> + * upon receiving a start/sync command.
> + */
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1119_pm_ops,
> +				 ads1119_runtime_suspend,
> +				 NULL,
> +				 NULL);
> +
Single blank line here, not 2.
> +
> +static const struct of_device_id __maybe_unused ads1119_of_match[] =3D {


