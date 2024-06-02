Return-Path: <linux-iio+bounces-5636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D88D76C8
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81989B20C4A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CF846436;
	Sun,  2 Jun 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDX8i3Du"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17220B35;
	Sun,  2 Jun 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342582; cv=none; b=S97tYAQ3HQ3TC4U00MN6eOiNlNHEzF3nQ1YJQV2zXM0BKGSts/SMkxZplvtj74aoAxvmGFCKuq44PCpsx93WfcmZXUZ6vawvxDA7eNEbJJ9NLCVI+aKHTuaQHKA7rJ5LNGHO5djCsb0FrAiTW2bOjCVfLFsxdVyVOjHU4TyfInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342582; c=relaxed/simple;
	bh=8Dr7rZ1zuN2YQAyrhN+qL+kKArlF05H8WIKw/8Tg8TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMOFHH3G3g/UxcnkDfF4Zrqy+ovzCfk6t/6q2vjipLyZJqY+YcbCNlHoGs4tEP+MDDGJtub4rN9j2ho4BBpLj2uzsco2sILFzBui24JolTzzwq7YDtvR+rCAkoeSknG26T4wgy3AEVebtGpc3FMT9Q8evLDC4PUB7ohE/UK+YyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDX8i3Du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4388EC2BBFC;
	Sun,  2 Jun 2024 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717342582;
	bh=8Dr7rZ1zuN2YQAyrhN+qL+kKArlF05H8WIKw/8Tg8TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dDX8i3DuZ/dBVt1JOjwAxWQJNnukp52C21xo2EDfg3mvgEc+iHjin3m4YSAyRfPRb
	 yKfwIMx13/yRrB0AJ72Ef4APkKxIqq6TBVvYrIGQUb21fgZoFgLcr73DMj5uoTjMsL
	 Wst0jS7TijNyjZRqbWWDkoWbBzG4+dNqolQIeWs8XNwBt99ohzeS/OnfxvG+yvsjQm
	 +3hC7pnnaRmgRzxhuaQ93v30EqZWzJlj84/Ht3buyxHOjMCYoIZmILvfS824xI0/0p
	 Q43wzJkbckT6NdT4OA+TsAz2vmGb3lA6ew4LBG7uhvvraUqBohbTK1rx+Jk+8PGiMC
	 Z8SId0eMRnriA==
Date: Sun, 2 Jun 2024 16:36:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <20240602163610.4374d51a@jic23-huawei>
In-Reply-To: <20240527154050.24975-3-francesco@dolcini.it>
References: <20240527154050.24975-1-francesco@dolcini.it>
	<20240527154050.24975-3-francesco@dolcini.it>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 May 2024 17:40:50 +0200
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

Hi Francesco,

Some comments inline. Other than the DT binding discussions this is
a nice driver so mostly trivial stuff or places where I think there
is a little bit too much abstraction.

Thanks,

Jonathan



> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> new file mode 100644
> index 000000000000..bcc1877b686f
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -0,0 +1,815 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Texas Instruments ADS1119 ADC driver.
> + *
> + * Copyright 2024 Toradex
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define ADS1119_DRIVER	"ads1119"

Put the string inline.  These defines tend to imply that a bunch
of strings should be the same when in many cases that's just one option.
Much easier to review code where I can see the actual string being used.

> +
> +#define ADS1119_CMD_RESET		0x06
> +#define ADS1119_CMD_POWERDOWN		0x02
> +#define ADS1119_CMD_START_SYNC		0x08
> +#define ADS1119_CMD_RDATA		0x10
> +#define ADS1119_CMD_RREG_CONFIG		0x20
> +#define ADS1119_CMD_RREG_STATUS		0x24
> +#define ADS1119_CMD_WREG		0x40
> +
> +#define ADS1119_CMD_RREG(reg)		(0x20 | ((reg) << 2))
> +
> +/* Config register */
> +#define ADS1119_REG_CONFIG	0x00
> +#define ADS1119_CONFIG_VREF(val)	(val)
> +#define ADS1119_CONFIG_VREF_MASK	BIT(0)
> +#define ADS1119_CONFIG_CONV_MODE(val)	((val) << 1)
> +#define ADS1119_CONFIG_CM_MASK		BIT(1)
> +#define ADS1119_CONFIG_DATARATE(val)	((val) << 2)
> +#define ADS1119_CONFIG_DR_MASK		GENMASK(3, 2)
> +#define ADS1119_CONFIG_GAIN(val)	((val) << 4)
> +#define ADS1119_CONFIG_GAIN_MASK	BIT(4)
> +#define ADS1119_CONFIG_MUX(val)		((val) << 5)

Use FIELD_PREP() inline and don't have these macros to
set values. That just takes the mask and figures out the necessary
shift from that.

> +#define ADS1119_CONFIG_MUX_MASK		GENMASK(7, 5)
> +
> +
> +
> +/* Timeout based on the minimum sample rate of 20 SPS (50000us) */
> +#define ADS1119_MAX_DRDY_TIMEOUT	85000
> +
> +/*
> + * Static allocate buffer for scans assuming one channel sample (2 or 4 =
bytes)
> + * + timestamp (8 bytes).
> + */
> +#define ADS1119_SCAN_BUFFER_SIZE	12
16. The timestamp is naturally aligned.  __aligned(8)

I've been meaning to make the runtime checks handle undersized cases but too
busy recently to actually write the patch.
It will make the push_to_buffers calls take a max size of data they are pro=
viding
and hence cases like this will be caught without needing to spot them in re=
view.

> +
> +struct ads1119_data {
> +	const struct iio_chan_spec *channels;
> +	const struct iio_info *info;
> +	const unsigned long *available_scan_masks;
> +	int num_channels;
> +	int vref_internal_uv;
> +};
> +
> +struct ads1119_channel_config {
> +	int gain;
> +	int datarate;
> +};
> +
> +struct ads1119_state {
> +	struct i2c_client *client;
> +	struct gpio_desc *reset_gpio;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	struct regulator *vref;
> +	const struct ads1119_data *data;
> +	struct completion completion;
> +	u8 scan_buf[ADS1119_SCAN_BUFFER_SIZE];
> +	struct ads1119_channel_config *channels_cfg;
> +	unsigned int num_bytes_sample;
> +};
> +
> +static const unsigned long ads1119_available_scan_masks[] =3D {
> +	BIT(ADS1119_MUX_AIN0_AIN1),
> +	BIT(ADS1119_MUX_AIN2_AIN3),
> +	BIT(ADS1119_MUX_AIN1_AIN2),
> +	BIT(ADS1119_MUX_AIN0),
> +	BIT(ADS1119_MUX_AIN1),
> +	BIT(ADS1119_MUX_AIN2),
> +	BIT(ADS1119_MUX_AIN3),
> +	0
> +};
> +
> +static int ads1119_cmd(struct ads1119_state *st, unsigned int cmd)
> +{
> +	dev_dbg(&st->client->dev, "send command: %#x\n", cmd);
> +
> +	return i2c_smbus_write_byte(st->client, cmd);

This definitely doesn't feel like regmap is a perfect fit.

> +}
> +
> +static int ads1119_cmd_wreg(struct ads1119_state *st, unsigned int val)
> +{
> +	dev_dbg(&st->client->dev, "wreg: %#x\n", val);
> +
> +	return i2c_smbus_write_byte_data(st->client, ADS1119_CMD_WREG, val);
> +}
> +
> +static int ads1119_cmd_rreg(struct ads1119_state *st, unsigned int cmd,
> +			    unsigned int *val)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_byte_data(st->client, cmd);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(&st->client->dev, "rreg %#x: %#x\n", cmd, ret);
> +
> +	*val =3D ret;
> +
> +	return 0;
> +}
> +
> +static int ads1119_cmd_rdata(struct ads1119_state *st, unsigned int *val)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_swapped(st->client, ADS1119_CMD_RDATA);

Bypassing regmap for one access type isn't particularly elegant. Can you do
a bulk read, possibly implementing that regmap. Or maybe just rip out
regmap as this isn't quite a register mapped interface.



> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(&st->client->dev, "rdata: %#x\n", ret);
> +
> +	*val =3D ret;
> +
> +	return 0;
> +}
> +
> +static bool ads1119_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	return (reg =3D=3D ADS1119_REG_CONFIG);
> +}
> +
> +static int ads1119_reg_read(void *context, unsigned int reg, unsigned in=
t *val)
> +{
> +	return ads1119_cmd_rreg(context, ADS1119_CMD_RREG(reg), val);

Squash the actual calls in here.  Don't need this extra layer to wrap one a=
rguement.

> +}
> +
> +static int ads1119_reg_write(void *context, unsigned int reg, unsigned i=
nt val)
> +{
> +	return ads1119_cmd_wreg(context, val);

Just squash the actual bus access in here.  Too many levels of wrapping cur=
rently!

> +}

> +static int ads1119_set_conv_mode(struct ads1119_state *st, bool continuo=
us)
> +{
> +	unsigned int mode;
> +
> +	if (continuous)
> +		mode =3D ADS1119_CM_CONTINUOUS;
> +	else
> +		mode =3D ADS1119_CM_SINGLE;
> +
> +	return regmap_update_bits(st->regmap, ADS1119_REG_CONFIG,
> +				  ADS1119_CONFIG_CM_MASK,
> +				  ADS1119_CONFIG_CONV_MODE(mode));
> +}
> +
> +static int ads1119_configure_channel(struct ads1119_state *st, unsigned =
int mux,
> +				     int gain, int datarate)
> +{
> +	int ret;
> +
> +	ret =3D ads1119_set_mux(st, mux);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ads1119_set_gain(st, gain);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ads1119_set_datarate(st, datarate);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
	return ads1119_set_datarate()

There used to be an irritating script that people ran that pointed these
out, so if we didn't 'tidy' them up we'd always get a patch for it within
a week.  It's a nice trivial tidy up anyway so might as well do it even
though I've not seen 'fixes' for this for a while.

> +}
> +
> +static int ads1119_set_power(struct ads1119_state *st, bool on)

To my eye, marginal that this brings a benefit over open coding it
in the 2 call locations for each value on.  I'd not bother with this
wrapper.

> +{
> +	struct device *dev =3D &st->client->dev;
> +	int ret;
> +
> +	if (on) {
> +		ret =3D pm_runtime_resume_and_get(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret =3D pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}

> +static int ads1119_read_data(struct ads1119_state *st,
> +			     struct iio_chan_spec const *chan,
> +			     unsigned int *val)
> +{
> +	unsigned int timeout;
> +	int ret;
> +
> +	timeout =3D msecs_to_jiffies(ADS1119_MAX_DRDY_TIMEOUT);
> +
> +	if (!st->client->irq)
> +		ret =3D ads1119_poll_data_ready(st, chan);
> +	else if (!wait_for_completion_timeout(&st->completion, timeout))
> +		ret =3D -ETIMEDOUT;
> +	else
> +		ret =3D 0;

int ret =3D 0; at the top and can drop this else

> +
> +	if (!ret)
> +		ret =3D ads1119_cmd_rdata(st, val);
	Use a goto to keep the error handling out of line.
	In this case can just return.
	if (ret)
		return ret;

	return ads119_cmd_rdata(st, val);

	=09
=09

> +
> +	return ret;
> +}

> +
> +static int ads1119_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +	unsigned int index =3D chan->address;
> +	int ret;
> +
> +	if (index >=3D ADS1119_MUX_SHORTED)
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
> +		if (st->vref)
> +			ret =3D regulator_get_voltage(st->vref);
This is unlikely to change after power up.  So you could use the new
devm_regulator_get_enable_read_voltage() function to simplify things.

If you do have a setup where this changes, then add a comment.
Early on, I added notifications and all sorts of fun to drivers to handle
reference voltages changing.  It never got used :( so I'm not sure any
drivers still do it!

> +		else
> +			ret =3D st->data->vref_internal_uv;
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D ret / 1000;
> +		*val /=3D st->channels_cfg[index].gain;
> +		*val2 =3D chan->scan_type.realbits - 1;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->channels_cfg[index].datarate;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +

> +
> +static const struct iio_chan_spec ads1119_channels[] =3D {
> +	ADS1119_V_DIFF_CHAN(0, 1, ADS1119_MUX_AIN0_AIN1),
> +	ADS1119_V_DIFF_CHAN(2, 3, ADS1119_MUX_AIN2_AIN3),
> +	ADS1119_V_DIFF_CHAN(1, 2, ADS1119_MUX_AIN1_AIN2),
> +	ADS1119_V_CHAN(0, ADS1119_MUX_AIN0),
> +	ADS1119_V_CHAN(1, ADS1119_MUX_AIN1),
> +	ADS1119_V_CHAN(2, ADS1119_MUX_AIN2),
> +	ADS1119_V_CHAN(3, ADS1119_MUX_AIN3),
> +	IIO_CHAN_SOFT_TIMESTAMP(ADS1119_MUX_SHORTED),

I guess there is a magic 8th channel.=20
If you want to keep that MUX_SHORTED around, fine but don't use it here,
define a ADS1119_TIMESTAMP_CHANNEL or something as equal to it
as we don't need the subtlety in places like this.

> +};
> +
> +static const struct iio_info ads1119_info =3D {
> +	.read_raw =3D ads1119_read_raw,
> +	.debugfs_reg_access =3D ads1119_debugfs_reg_access,
> +};
> +
> +static int ads1119_set_trigger_state(struct iio_trigger *trig, bool stat=
e)
> +{
> +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +	unsigned int index;
> +	int ret;
> +
> +	index =3D find_first_bit(indio_dev->active_scan_mask,
> +			       indio_dev->masklength);
> +
> +	if (index >=3D ADS1119_MUX_SHORTED)

So this is a don't enable if only the timestamp?
Probably better to use a check on it being the timestamp channel as
this is a bit obscure to read.

> +		return -EINVAL;
> +
> +	st->num_bytes_sample =3D
> +		indio_dev->channels[index].scan_type.storagebits / 8;
> +
> +	ret =3D ads1119_set_conv_mode(st, state);
> +	if (ret)
> +		return ret;
> +
> +	if (state) {
> +		ret =3D ads1119_configure_channel(st, index,
> +						st->channels_cfg[index].gain,
> +						st->channels_cfg[index].datarate);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ads1119_set_power(st, true);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ads1119_cmd(st, ADS1119_CMD_START_SYNC);
> +	} else {
> +		ret =3D ads1119_set_power(st, false);
> +	}
> +
> +	return ret;
I'd flip and deal with the !state first to drop some indent and slightly
simplify things.  This is a trade off against the nice obvious if / else pa=
ir
though so if you strongly prefer the current form I don't mind that much.

	if (!state)
		return ads1119_set_power(st, false);

	ret =3D ads1119_configure...

> +}
> +
>
> +static irqreturn_t ads1119_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf =3D private;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +	unsigned int sample;
> +	int ret;
> +
> +	ret =3D ads1119_cmd_rdata(st, &sample);
> +	if (!ret) {
> +		memcpy(st->scan_buf, &sample, st->num_bytes_sample);
> +		iio_push_to_buffers_with_timestamp(indio_dev, st->scan_buf,
> +						   iio_get_time_ns(indio_dev));
> +	} else {
> +		dev_err(&st->client->dev,
> +			"Failed to read data on trigger (%d)\n", ret);
> +	}
Prefer flipping this and using a label because it keeps the error case as t=
he
out of line one which is how kernel code is mostly structured and hence is
slightly quicker to review!


	if (ret) {
		dev_err()
		goto done;
	}

	memcpy...

done:
	iio_trigger_notify_done() etc

> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}


> +static int ads1119_alloc_and_config_channels(struct ads1119_state *st)
> +{
> +	struct device *dev =3D &st->client->dev;
> +	int num_channels, gain, datarate;
> +	struct fwnode_handle *node;
> +	int ret, index;
> +
> +	/* Last channel is not a hw channel (timestamp) */
> +	num_channels =3D st->data->num_channels - 1;
> +
> +	st->channels_cfg =3D devm_kcalloc(dev, num_channels,
> +					sizeof(*st->channels_cfg),
> +					GFP_KERNEL);
> +	if (!st->channels_cfg)
> +		return -ENOMEM;
> +
> +	for (index =3D 0; index < num_channels; index++) {
> +		st->channels_cfg[index].gain =3D ADS1119_DEFAULT_GAIN;
> +		st->channels_cfg[index].datarate =3D ADS1119_DEFAULT_DATARATE;
> +	}
> +
> +	device_for_each_child_node(dev, node) {

_scoped() variant exists now and will allow you to avoid that manual fwnode=
_handle_put()
in the error path.

> +		ret =3D fwnode_property_read_u32(node, "reg", &index);
> +		if (ret) {
> +			fwnode_handle_put(node);
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure channels\n");
> +		}
> +
> +		if (!fwnode_property_read_u32(node, "ti,gain", &gain))
> +			st->channels_cfg[index].gain =3D gain;
> +
> +		if (!fwnode_property_read_u32(node, "ti,datarate", &datarate))
> +			st->channels_cfg[index].datarate =3D datarate;
> +
> +		dev_dbg(dev, "channel config %d: gain %d, datarate %d\n",
> +			index, st->channels_cfg[index].gain,
> +			st->channels_cfg[index].datarate);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads1119_get_configs(struct ads1119_state *st)
> +{
> +	struct device *dev =3D &st->client->dev;
> +
> +	st->vref =3D devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(st->vref))
> +		return dev_err_probe(dev, PTR_ERR(st->vref),
> +				     "Failed to get vref\n");

I'm not sure this makes sense as grouping a bit beyond getting config.
I'd just put these 3 calls inline and drop this function.

> +
> +	st->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->vref),
> +				     "Failed to get reset gpio\n");
> +
> +	return ads1119_alloc_and_config_channels(st);
> +}

> +static int ads1119_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ads1119_state *st;
> +	struct device *dev =3D &client->dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate IIO device\n");
> +
> +	st =3D iio_priv(indio_dev);
> +	st->client =3D client;
> +	st->data =3D i2c_get_match_data(client);
> +	if (!st->data)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to get match data\n");
> +
> +	indio_dev->name =3D ADS1119_DRIVER;
> +	indio_dev->info =3D st->data->info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D st->data->channels;
> +	indio_dev->num_channels =3D st->data->num_channels;
> +	indio_dev->available_scan_masks =3D st->data->available_scan_masks;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret =3D ads1119_get_configs(st);
> +	if (ret)
> +		return ret;
> +
> +	if (st->vref) {
> +		ret =3D regulator_enable(st->vref);
As mentioned above.  Maybe just read the voltage at this point with
devm_regulator_get_enable_read_voltage() and assume it is fixed after power=
 up?
That gives a very simple handling of a reference voltage.
Actually you want the optional variant I think, but it works the same way.

> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to enable vref\n");
> +
> +		ret =3D devm_add_action_or_reset(dev, ads1119_disable_vref_regulator, =
st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->regmap =3D devm_regmap_init(dev, NULL, st, &ads1119_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate register map\n");
> +
> +	init_completion(&st->completion);
> +
> +	if (client->irq > 0) {
...

> +
> +	ret =3D ads1119_init(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to initialize device\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, ADS1119_SUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
It may be worth including a devm_add_action_or_reset() to force the device
with ADS1119_CMD_POWERDOWN on remove.  Potentially save some power if you
happen not to have runtime suspended before removing the driver (as used
it recently).

In reality it probably rarely matters so up to you.

> +	pm_runtime_set_active(dev);
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable pm runtime\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int ads1119_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +
> +	return ads1119_cmd(st, ADS1119_CMD_POWERDOWN);

Add a comment here on why no resume is needed.
I assume this is a device that auto powers up on first access after this?


> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1119_pm_ops,
> +				 ads1119_runtime_suspend,
> +				 NULL,
> +				 NULL);
> +
> +static const struct ads1119_data ads1119_data =3D {
> +	.channels =3D ads1119_channels,
> +	.num_channels =3D ARRAY_SIZE(ads1119_channels),
> +	.info =3D &ads1119_info,
> +	.available_scan_masks =3D ads1119_available_scan_masks,
> +	.vref_internal_uv =3D 2048000,
> +};
> +
> +static const struct of_device_id __maybe_unused ads1119_of_match[] =3D {
> +	{ .compatible =3D "ti,ads1119", .data =3D &ads1119_data, },
If you aren't planning to add more parts to this driver in the near future
usually better to not make it so adaptable but rather to introduce things
like this ads1119_data structure as a precursor patch to the series adding
a part that needs different data. =20

Experience says that at least 50% of the time that second supported part
doesn't happen that quickly and we end up carrying unused complexity in
the meantime!

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ads1119_of_match);
> +
> +static const struct i2c_device_id ads1119_id[] =3D {
> +	{ ADS1119_DRIVER, (kernel_ulong_t)&ads1119_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ads1119_id);
> +
> +static struct i2c_driver ads1119_driver =3D {
> +	.driver =3D {
> +		.name =3D ADS1119_DRIVER,
> +		.of_match_table =3D of_match_ptr(ads1119_of_match),
Don't use of_match_ptr().
It is a lot more trouble than it is worth to save a few bytes of
table!

You correctly dealt with the __maybe_unused above, but not that
this match table can be used by ACPI via PRP0001 devices (a magic
ID that basically says the description is in DT properties).

> +		.pm =3D pm_ptr(&ads1119_pm_ops),
> +	},
> +	.probe =3D ads1119_probe,
> +	.id_table =3D ads1119_id,
> +};
> +module_i2c_driver(ads1119_driver);


