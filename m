Return-Path: <linux-iio+bounces-6724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F19135B6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5528C1F22E48
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533651C3E;
	Sat, 22 Jun 2024 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnPvq4F4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394E5103F;
	Sat, 22 Jun 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719081857; cv=none; b=uwEkAVD8nndSy/Hiy9A7s86spC+weAx+4o60eDkfFEjEdVMCs5a9xQFc8EOWFtvBhvhXFCw+Kq63cTOr7ky6592ToHtL85QpMNMcxQdj8zSaslRb05nTj05qE7pYf/Acyt8CwEhBJaQONv0sCRQT0fNPX5Du174oIAnuYD44Idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719081857; c=relaxed/simple;
	bh=4m4catJM9yC+Ooh4BvXUL2litsSYs5Z0g3MiscvRwPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edMCs8V820p7tuFnWdnTXNgQ7fO2Xx3sDFwy0/E4mb/qwcXfpsspzrZ2vIG0RR/fBzzP+3ayBFPRoh2pyGlxL/FUNoSjTIT45Mpk0lTlR8sOWUZm/rKBjuJ1NntjwXIV5k+DHTlNx7c2E/uqksChTBYfYy/eK9sKA235VxU2CNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnPvq4F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828C7C32781;
	Sat, 22 Jun 2024 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719081856;
	bh=4m4catJM9yC+Ooh4BvXUL2litsSYs5Z0g3MiscvRwPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KnPvq4F450anA9CYzJWhS7iA8AyrpCvDnOk2qlEDBpBzBXNITggnZqXFn9WBAKZ2g
	 0dXvxzXR73k0t/AO2nspfeIeb7BVqmLT/uZvo8YYBg6f7lnV2KRxf/a8twghA6w/0j
	 9Ht6PP6U/F1d6fKq0MXRlouiV7HdL/lyIfS3mUDY8KOOqLHrIWYjSXukxDVbU5Y/Xw
	 Ps7XLYSUpwv1qLPB3dRnLWtsl1PsdGL8AHJgaCjd0LmNXgdrY9e4eIgWg1o7K3eQDk
	 xYd1YJIdhul+LjtRl3XBer/dIj1iz3o9amJwSBs7hMfijSlvvFnJpkndau70WfvjZh
	 PKcPbRhM57i/Q==
Date: Sat, 22 Jun 2024 19:44:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <20240622194407.4ee2a342@jic23-huawei>
In-Reply-To: <20240617183905.4685-1-francesco@dolcini.it>
References: <20240617183215.4080-1-francesco@dolcini.it>
	<20240617183905.4685-1-francesco@dolcini.it>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 20:39:05 +0200
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
> mode only one channel can be scanned at a time.
>=20
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Hi. My suggested changes are minor, so I just made them whilst applying.
Please check the result!

Applied with these tweaks a few more whitespace things checkpatch --strict
pointed out to the togreg branch of iio.git and pushed out as testing for
0-day to see what we missed.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
> new file mode 100644
> index 000000000000..ccf259ebae08
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1119.c
> @@ -0,0 +1,839 @@

> +
> +#define ADS1119_V_CHAN(_chan, _chan2, _addr) {			\
Why pass in the parameters as you use this in one place and they
are all 0?

Just put this definition inline where you use it as

	const struct iio_chan_spec ads1119_channel =3D
		(const struct iio_chan_spec) {
			.type =3D IIO_VOLTAGE,=20
	etc.
(or something along these lines.

		};
> +	.type =3D IIO_VOLTAGE,					\
> +	.indexed =3D 1,						\
> +	.address =3D _addr,					\
> +	.channel =3D _chan,					\
> +	.channel2 =3D _chan2,					\
> +	.info_mask_separate =3D					\
> +		BIT(IIO_CHAN_INFO_RAW) |			\
> +		BIT(IIO_CHAN_INFO_SCALE) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET) |			\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.info_mask_shared_by_all_available =3D			\
> +		BIT(IIO_CHAN_INFO_SCALE) |			\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.scan_index =3D _addr,					\
> +	.scan_type =3D {						\
> +		.sign =3D 's',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +		.endianness =3D IIO_CPU,				\
> +	},							\
> +}
> +
> +struct ads1119_channel_config {
> +	int gain;
> +	int datarate;
> +	int mux;
> +};
> +
> +struct ads1119_state {
> +	struct completion completion;
> +	struct i2c_client *client;
> +	struct gpio_desc *reset_gpio;
> +	struct iio_trigger *trig;
> +	struct ads1119_channel_config *channels_cfg;
> +	unsigned int num_channels_cfg;
> +	unsigned int cached_config;
> +	int vref_uV;
> +};
> +
> +static const char * const ads1119_power_supplies[] =3D {
> +	"avdd", "dvdd"
> +};
> +
> +static const int ads1119_available_datarates[] =3D {
> +	20, 90, 330, 1000,
> +};
> +
> +static const int ads1119_available_gains[] =3D {
> +	1, 1,
> +	1, 4,
> +};
> +
> +static int ads1119_upd_cfg_reg(struct ads1119_state *st, unsigned int fi=
elds,
> +			       unsigned int val)
> +{
> +	unsigned int config =3D st->cached_config;
> +	int ret;
> +
> +	config &=3D ~fields;
> +	config |=3D val;
> +
> +	ret =3D i2c_smbus_write_byte_data(st->client, ADS1119_CMD_WREG, config);
> +	if (ret)
> +		return ret;
> +
> +	st->cached_config =3D config;
> +
> +	return 0;
> +}
> +
> +static bool ads1119_data_ready(struct ads1119_state *st)
> +{
> +	int status;
> +
> +	status =3D i2c_smbus_read_byte_data(st->client, ADS1119_CMD_RREG_STATUS=
);
> +	if (status < 0)
> +		return false;
> +
> +	return !!FIELD_GET(ADS1119_STATUS_DRDY_FIELD, status);

The !! doesn't add anything as the cast to bool effectively does the same t=
hing


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
Slightly neater to do this at declaration fo variables.

	int mux =3D st->...
etc.

> +
> +	if (calib_offset)
> +		mux =3D ADS1119_MUX_SHORTED;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		goto pdown;
> +
> +	ret =3D ads1119_configure_channel(st, mux, gain, datarate);
> +	if (ret)
> +		goto pdown;
> +
> +	ret =3D i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
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
> +	return ret;
> +}

> +static int ads1119_poll_data_ready(struct ads1119_state *st,
> +				   struct iio_chan_spec const *chan)
> +{
> +	unsigned int datarate =3D st->channels_cfg[chan->address].datarate;
> +	unsigned long wait_time;
> +	bool data_ready;
> +
> +	/* Poll 5 times more than the data rate */
> +	wait_time =3D DIV_ROUND_CLOSEST(MICRO, 5 * datarate);
> +
> +	return read_poll_timeout(ads1119_data_ready, data_ready,
> +				 data_ready =3D=3D true, wait_time,

checkpatch --strict pointed out that you might as well just use dataready
as the conditional, rather than dataready =3D=3D true.

> +				 ADS1119_MAX_DRDY_TIMEOUT, false, st);
> +}

> +
> +static int ads1119_alloc_and_config_channels(struct iio_dev *indio_dev)
> +{
> +	const struct iio_chan_spec ads1119_channel =3D ADS1119_V_CHAN(0, 0, 0);
> +	const struct iio_chan_spec ads1119_ts =3D IIO_CHAN_SOFT_TIMESTAMP(0);
> +	struct ads1119_state *st =3D iio_priv(indio_dev);
> +	struct iio_chan_spec *iio_channels, *chan;
> +	struct device *dev =3D &st->client->dev;
> +	unsigned int num_channels, i;
> +	bool differential;
> +	u32 ain[2];
> +	int ret;
> +
> +	st->num_channels_cfg =3D device_get_child_node_count(dev);
> +	if (st->num_channels_cfg > ADS1119_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Too many channels %d, max is %d\n",
> +				     st->num_channels_cfg,
> +				     ADS1119_MAX_CHANNELS);
> +
> +	st->channels_cfg =3D devm_kcalloc(dev, st->num_channels_cfg,
> +					sizeof(*st->channels_cfg), GFP_KERNEL);
> +	if (!st->channels_cfg)
> +		return -ENOMEM;
> +
> +	/* Allocate one more iio channel for the timestamp */
> +	num_channels =3D st->num_channels_cfg + 1;
> +	iio_channels =3D devm_kcalloc(dev, num_channels,
> +				    sizeof(*iio_channels),
> +				    GFP_KERNEL);
Can wrap that on one fewer line.
> +	if (!iio_channels)
> +		return -ENOMEM;
> +
> +	i =3D 0;
> +
>
>
> +static int ads1119_probe(struct i2c_client *client)
> +{
...

> +	if (client->irq > 0) {
> +		ret =3D devm_request_threaded_irq(dev,
> +						client->irq,
Can combine some of these lines under 80 chars.
> +						ads1119_irq_handler,
> +						NULL,
> +						IRQF_TRIGGER_FALLING,
> +						"ads1119",
> +						indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to allocate irq\n");
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
> +	}
> +
> +	ret =3D ads1119_init(st, vref_external);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to initialize device\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, ADS1119_SUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_set_active(dev);
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable pm runtime\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, ads1119_powerdown, st);
Hmm. This naturally (I think anyway) pairs with the reset in ads1119_init()
so it's a little odd to find it down here.=20

I assume the reasoning was that the runtime PM might result in it being on?
However I think the worst that can happen is that runtime pm powers down
the powered down device just before it is stopped by the devm_pm_runtime
enable cleanup. So this ordering doesn't matter.

Hence I'll leave it alone, but it did make me think for a few minutes.


> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add powerdown action\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> +/*
> + * The ADS1119 does not require a resume function because it automatical=
ly
> + * powers on after a reset.
> + * After a power down command, the ADS1119 can still communicate but tur=
ns off
> + * its analog parts. To resume from power down, the device will power up=
 again
> + * upon receiving a start/sync command.
> + */
> +static DEFINE_RUNTIME_DEV_PM_OPS(ads1119_pm_ops,
> +				 ads1119_runtime_suspend,
> +				 NULL,
> +				 NULL);

Trivial but can rewrap those lines to save 2 lines without significant loss
of readability.



