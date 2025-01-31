Return-Path: <linux-iio+bounces-14762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E738A24202
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BA41673DB
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302511F03D2;
	Fri, 31 Jan 2025 17:41:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FC1C54BE;
	Fri, 31 Jan 2025 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345288; cv=none; b=eswwG+zMB+cYPS0+LkXWDG6O6gCPMy1p6+RFK9KkYlZsCv6ydyJPhf3mKrFfk6j2zLvq/jqIZS/jgkffqGSsoRvFdPKPQhClbnVBkUprX7Bs+shhLW/D80cXBmGH3I+MP28bwmh8E+pfp5/j15ryprsTYdTVXXjsfLOPFy68wt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345288; c=relaxed/simple;
	bh=0sDpVMs6huC5XPo/xexV+Tv3v5ObAoG9XqoejU4Id4c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSzGFy9/+Ji2LimDC4sMhl0O7FBbDhq8zv/ZdgZU0hbw3JQkOcJxNWKGfvCQmNH74ZR7RrFXpNUSM6nscNwBfUUHXwuapMPq+ziLXhOmZJ//dkVlUvUd1CP9xKcMORDVVF6Djfx3PVJzQVARIUOwhxp47HsCVCu+O//HxeQ4nRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl38735Vkz6K61f;
	Sat,  1 Feb 2025 01:40:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9491C140B67;
	Sat,  1 Feb 2025 01:41:21 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 18:41:20 +0100
Date: Fri, 31 Jan 2025 17:41:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones
	<lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij
	<linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>, David Lechner
	<dlechner@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, "Trevor
 Gamblin" <tgamblin@baylibre.com>, Matteo Martelli
	<matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
Subject: Re: [RFC PATCH 3/5] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250131174118.0000209a@huawei.com>
In-Reply-To: <e44851669ce7e91d1295ab7352535c93b89d35bf.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
	<e44851669ce7e91d1295ab7352535c93b89d35bf.1738328714.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 15:37:48 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> an automatic measurement mode, with an alarm interrupt for out-of-window
> measurements. The window is configurable for each channel.
>=20
> The I2C protocol for manual start of the measurement and data reading is
> somewhat peculiar. It requires the master to do clock stretching after
> sending the I2C slave-address until the slave has captured the data.
> Needless to say this is not well suopported by the I2C controllers.

=46rom what I recall that is in the I2C spec, so in theory should be supporte=
d.
Ah well.

>=20
> Thus the driver does not support the BD79124's manual measurement mode
> but implements the measurements using automatic measurement mode relying
> on the BD79124's ability of storing latest measurements into register.
>=20
> The driver does also support configuring the threshold events for
> detecting the out-of-window events.
>=20
> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> out of the configured window. Thus the driver disables the event when
> first event is handled. This prevents the user-space from choking on the
> events - but it also requires the user space to reconfigure and
> re-enable the monitored event when it wants to keep monitoring for new
> occurrences.
>=20
> It is worth noting that the ADC input pins can be also configured as
> general purpose outputs. The pin mode should be configured using pincmux
> driver.

We shouldn't be presenting channels that are configure for GPIOs as
ADC channels.  It is very rare that there is a usecase for any
dynamic switching. Normally it's a case of what is wired and
so static.  Hence build the iio_chan_spec array for just the
channels you want, not the the lot.  Channel sub nodes in the
DT are how we most commonly specify what is wired.

Few other comments inline,

Jonathan

>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
>=20
> Regarding disabling the event upon reception - is this totally strange?
> Is regular userspace compeletely unprepared for this, and better
> prepared for handling large amounts of continuous events?
>=20
> The BD79124 should not cause a total CPU-blocking IRQ storm because the
> driver uses the autonomous sequencer mode - which has minimum of 0.75
> millisecond delay between measurements. So, new IRQs can be raised with
> this interval. (The 0.75 mS includes handling and acking / status reading
> delays - so there is still not much time for things done outside of the
> IRQ handling...)

> diff --git a/drivers/iio/adc/rohm-bd79124-adc.c b/drivers/iio/adc/rohm-bd=
79124-adc.c
> new file mode 100644
> index 000000000000..7c95a1de1e71
> --- /dev/null
> +++ b/drivers/iio/adc/rohm-bd79124-adc.c
> @@ -0,0 +1,890 @@

> +enum {
> +	BD79124_CH_0,

If they just map to integers of the same name, may not be worth bothering
with the enum!

> +	BD79124_CH_1,
> +	BD79124_CH_2,
> +	BD79124_CH_3,
> +	BD79124_CH_4,
> +	BD79124_CH_5,
> +	BD79124_CH_6,
> +	BD79124_CH_7,
> +	BD79124_MAX_NUM_CHANNELS
> +};

> +struct bd79124_raw {
> +	u8 bit0_3; /* Is set in high bits of the byte */
> +	u8 bit4_11;
> +};
> +#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
You could do this as an endian conversion and a single shift I think.
Might be slightly simpler.

> +
> +/*
> + * The high and low limits as well as the recent result values are store=
d in
> + * the same way in 2 consequent registers. The first register contains 4=
 bits
> + * of the value. These bits are stored in the high bits [7:4] of registe=
r, but
> + * they represent the low bits [3:0] of the value.
> + * The value bits [11:4] are stored in the next register.
> + *
> + * Read data from register and convert to integer.
> + */
> +static int bd79124_read_reg_to_int(struct bd79124_data *d, int reg,
> +				   unsigned int *val)
> +{
> +	int ret;
> +	struct bd79124_raw raw;
> +
> +	ret =3D regmap_bulk_read(d->map, reg, &raw, sizeof(raw));
> +	if (ret)
> +		dev_dbg(d->dev, "bulk_read failed %d\n", ret);

If it failed, then shouldn't set *val.

> +	*val =3D BD79124_RAW_TO_INT(raw);
> +
> +	return ret;
> +}
> +
> +/*
> + * The high and low limits as well as the recent result values are store=
d in
> + * the same way in 2 consequent registers. The first register contains 4=
 bits
> + * of the value. These bits are stored in the high bits [7:4] of registe=
r, but
> + * they represent the low bits [3:0] of the value.
> + * The value bits [11:4] are stored in the next regoster.
> + *
> + * Conver the integer to register format and write it using rmw cycle.
> + */
> +static int bd79124_write_int_to_reg(struct bd79124_data *d, int reg,
> +				    unsigned int val)
> +{
> +	struct bd79124_raw raw;
> +	int ret, tmp;
> +
> +	raw.bit4_11 =3D (u8)(val >> 4);
> +	raw.bit0_3 =3D (u8)(val << 4);
> +
> +	ret =3D regmap_read(d->map, reg, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	raw.bit0_3 |=3D (0xf & tmp);
> +
> +	return regmap_bulk_write(d->map, reg, &raw, sizeof(raw));
> +}
> +
> +static const struct iio_event_spec bd79124_events[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_RISING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_FALLING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
> +};
> +
> +#define BD79124_CHAN(idx) {						\
> +	.type =3D IIO_VOLTAGE,						\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.indexed =3D 1,							\
> +	.channel =3D idx,							\
> +}
> +
> +#define BD79124_CHAN_EV(idx) {						\
> +	.type =3D IIO_VOLTAGE,						\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.indexed =3D 1,							\
> +	.channel =3D idx,							\
> +	.event_spec =3D bd79124_events,					\
> +	.num_event_specs =3D ARRAY_SIZE(bd79124_events),			\
> +}
> +
> +static const struct iio_chan_spec bd79124_channels[] =3D {
> +	BD79124_CHAN_EV(0),
> +	BD79124_CHAN_EV(1),
> +	BD79124_CHAN_EV(2),
> +	BD79124_CHAN_EV(3),
> +	BD79124_CHAN_EV(4),
> +	BD79124_CHAN_EV(5),
> +	BD79124_CHAN_EV(6),
> +	BD79124_CHAN_EV(7),
> +};
> +
> +static const struct iio_chan_spec bd79124_channels_noirq[] =3D {
> +	BD79124_CHAN(0),
> +	BD79124_CHAN(1),
> +	BD79124_CHAN(2),
> +	BD79124_CHAN(3),
> +	BD79124_CHAN(4),
> +	BD79124_CHAN(5),
> +	BD79124_CHAN(6),
> +	BD79124_CHAN(7),
> +};
> +
> +/*
> + * The BD79124 supports muxing the pins as ADC inputs or as a general pu=
rpose
> + * output. This muxing is handled by a pinmux driver. Here we just check=
 the
> + * settings from the register, and disallow using the pin if pinmux is s=
et to
> + * GPO.
> + *
> + * NOTE: This driver does not perform any locking to ensure the pinmux s=
tays
> + * toggled to ADC for the duration of the whatever operation is being do=
ne.
> + * It is responsibility of the user to configure the pinmux.
> + */
> +static bool bd79124_chan_is_adc(struct bd79124_data *d, unsigned int off=
set)
> +{
> +	int ret, val;
> +
> +	ret =3D regmap_read(d->map, BD79124_REG_PINCFG, &val);
> +	/* If read fails, don't allow using as AIN (to be on a safe side) */
> +	if (ret)
> +		return 0;
> +
> +	return !(val & BIT(offset));
> +}
> +
> +static int bd79124_read_event_value(struct iio_dev *idev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int *val,
> +				    int *val2)
> +{
> +	struct bd79124_data *d =3D iio_priv(idev);
> +	int ret, reg;
> +
> +	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	/* ensure pinmux is set to ADC */
> +	if (!bd79124_chan_is_adc(d, chan->channel))
> +		return -EBUSY;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
> +		else if (dir =3D=3D IIO_EV_DIR_FALLING)
> +			reg =3D BD79124_GET_LOW_LIMIT_REG(chan->channel);
> +		else
> +			return -EINVAL;
> +
> +		ret =3D bd79124_read_reg_to_int(d, reg, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_EV_INFO_HYSTERESIS:
> +		reg =3D BD79124_GET_HYSTERESIS_REG(chan->channel);
> +		ret =3D regmap_read(d->map, reg, val);
> +		if (ret)
> +			return ret;
> +		/* Mask the non hysteresis bits */
> +		*val &=3D BD79124_MASK_HYSTERESIS;
> +		/*
> +		 * The data-sheet says the hysteresis register value needs to be
> +		 * sifted left by 3 (or multiplied by 8, depending on the
> +		 * page :] )
> +		 */
> +		*val <<=3D 3;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bd79124_start_measurement(struct bd79124_data *d, int chan)
> +{
> +	int val, ret, regval;
> +
> +	/* ensure pinmux is set to ADC */
> +	if (!bd79124_chan_is_adc(d, chan))
> +		return -EBUSY;
> +
> +	/* See if already started */
> +	ret =3D regmap_read(d->map, BD79124_REG_AUTO_CHANNELS, &val);
> +	if (val & BIT(chan))
> +		return 0;
> +
> +	/* Stop the sequencer */
> +	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +				BD79124_MASK_SEQ_START);
> +	if (ret)
> +		return ret;
> +
> +	/* Add the channel to measured channels */
> +	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS, val | BIT(chan)=
);
> +	if (ret)
> +		return ret;
> +
> +	/* Restart the sequencer */
> +	ret =3D regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +			      BD79124_MASK_SEQ_START);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Start the measurement at the background. Don't bother checking if
> +	 * it was started, regmap has cache
> +	 */
> +	regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_AUTO);
> +
> +	return regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
> +				BD79124_MASK_CONV_MODE, regval);
> +}
> +
> +static int bd79124_stop_measurement(struct bd79124_data *d, int chan)
> +{
> +	int val, ret;
> +
> +	/* Ensure pinmux is set to ADC */
> +	if (!bd79124_chan_is_adc(d, chan))
> +		return -EBUSY;
> +
> +	/* If alarm is requested for the channel we won't stop measurement */
> +	if (d->alarm_monitored[chan])
> +		return 0;
> +
> +	/* See if already stopped */
> +	ret =3D regmap_read(d->map, BD79124_REG_AUTO_CHANNELS, &val);
> +	if (!(val & BIT(chan)))
> +		return 0;
> +
> +	/* Stop the sequencer */
> +	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +				BD79124_MASK_SEQ_START);
> +
> +	/* Clear the channel from the measured channels */
> +	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS,
> +			   (~BIT(chan)) & val);
> +	if (ret)
> +		return ret;
> +
> +	/* Stop background conversion if it was the last channel */
> +	if (!((~BIT(chan)) & val)) {
> +		int regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE,
> +					BD79124_CONV_MODE_MANSEQ);
> +
> +		ret =3D regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
> +					 BD79124_MASK_CONV_MODE, regval);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Restart the sequencer */
> +	return regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +			       BD79124_MASK_SEQ_START);
> +}
> +
> +static int bd79124_read_event_config(struct iio_dev *idev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct bd79124_data *d =3D iio_priv(idev);
> +	int val, ret, reg, disabled;
> +
> +	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	/* ensure pinmux is set to ADC */
> +	if (!bd79124_chan_is_adc(d, chan->channel))
> +		return -EBUSY;
> +
> +	ret =3D regmap_read(d->map, BD79124_REG_ALERT_CH_SEL, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* The event is disabled if alerts for the channel are disabled */
> +	if (!(val & BIT(chan->channel)))
> +		return 0;
> +
> +	/*
> +	 * If alerts are on, then the event may be disabled if limit is set to
> +	 * the one extreme. (HW does not support disabling rising/falling
> +	 * thresholds independently. Hence we resort to setting high limit to
> +	 * MAX, or low limit to 0 to try effectively disable thresholds).
> +	 */
> +	if (dir =3D=3D IIO_EV_DIR_RISING) {
> +		reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
> +		disabled =3D BD79124_HIGH_LIMIT_MAX;
> +	} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
> +		reg =3D BD79124_GET_LOW_LIMIT_REG(chan->channel);
> +		disabled =3D BD79124_LOW_LIMIT_MIN;
> +	} else {
> +		return -EINVAL;
> +	}
> +	ret =3D bd79124_read_reg_to_int(d, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	return val !=3D disabled;
> +}
> +
> +static int bd79124_disable_event(struct bd79124_data *d,
> +				 enum iio_event_direction dir, int channel)
> +{
> +	int dir_bit =3D BIT(dir), reg;
> +	unsigned int limit;
> +
> +	d->alarm_monitored[channel] &=3D (~dir_bit);
> +	/*
> +	 * Set thresholds either to 0 or to 2^12 - 1 as appropriate to prevent
> +	 * alerts and thus disable event generation.
> +	 */
> +	if (dir =3D=3D IIO_EV_DIR_RISING) {
> +		reg =3D BD79124_GET_HIGH_LIMIT_REG(channel);
> +		limit =3D BD79124_HIGH_LIMIT_MAX;
> +	} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
> +		reg =3D BD79124_GET_LOW_LIMIT_REG(channel);
> +		limit =3D BD79124_LOW_LIMIT_MIN;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Stop measurement if there is no more events to monitor.
> +	 * We don't bother checking the retval because the limit
> +	 * setting should in any case effectively disable the alarm.
> +	 */
> +	if (!d->alarm_monitored[channel]) {
> +		bd79124_stop_measurement(d, channel);
> +		regmap_clear_bits(d->map, BD79124_REG_ALERT_CH_SEL,
> +			       BIT(channel));
> +	}
> +
> +	return bd79124_write_int_to_reg(d, reg, limit);
> +}
> +
> +/* Do we need to disable the measurement for the duration of the limit c=
onf ? */
> +static int bd79124_write_event_config(struct iio_dev *idev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, bool state)
> +{
> +	struct bd79124_data *d =3D iio_priv(idev);
> +	int dir_bit =3D BIT(dir);
> +
> +	guard(mutex)(&d->mutex);
> +
> +	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	/* ensure pinmux is set to ADC */
> +	if (!bd79124_chan_is_adc(d, chan->channel))
> +		return -EBUSY;
> +
> +	if (state) {
> +		int ret;
> +
> +		/* Set channel to be measured */
> +		ret =3D bd79124_start_measurement(d, chan->channel);
> +		if (ret)
> +			return ret;
> +
> +		d->alarm_monitored[chan->channel] |=3D dir_bit;
> +
> +		/* Add the channel to the list of monitored channels */
> +		ret =3D regmap_set_bits(d->map, BD79124_REG_ALERT_CH_SEL,
> +				      BIT(chan->channel));
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Enable comparator. Trust the regmap cache, no need to check
> +		 * if it was already enabled.
> +		 *
> +		 * We could do this in the hw-init, but there may be users who
> +		 * never enable alarms and for them it makes sense to not
> +		 * enable the comparator at probe.
> +		 */
> +		return regmap_set_bits(d->map, BD79124_REG_GEN_CFG,
> +				      BD79124_MASK_DWC_EN);
> +	}
> +
> +	return bd79124_disable_event(d, dir, chan->channel);
> +}
> +
> +static int bd79124_write_event_value(struct iio_dev *idev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info, int val,
> +				     int val2)
> +{
> +	struct bd79124_data *d =3D iio_priv(idev);
> +	int reg;
> +
> +	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	/* ensure pinmux is set to ADC */
> +	if (!bd79124_chan_is_adc(d, chan->channel))
> +		return -EBUSY;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
> +		else if (dir =3D=3D IIO_EV_DIR_FALLING)
> +			reg =3D BD79124_GET_LOW_LIMIT_REG(chan->channel);
> +		else
> +			return -EINVAL;
> +
> +		return bd79124_write_int_to_reg(d, reg, val);
> +
> +	case IIO_EV_INFO_HYSTERESIS:
> +			reg =3D BD79124_GET_HYSTERESIS_REG(chan->channel);
> +			val >>=3D 3;
> +
> +		return regmap_update_bits(d->map, reg, BD79124_MASK_HYSTERESIS,
> +					  val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int bd79124_read_last_result(struct bd79124_data *d, int chan,
> +				    int *result)
> +{
> +	struct bd79124_raw raw;
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(d->map, BD79124_GET_RECENT_RES_REG(chan), &raw,
> +			       sizeof(raw));
> +	if (ret)
> +		return ret;
> +
> +	*result =3D BD79124_RAW_TO_INT(raw);
> +
> +	return 0;
> +}
> +

> +static int bd79124_single_chan_seq_end(struct bd79124_data *d, int old)
> +{
> +	int ret;
> +
> +	/* Stop the sequencer */

Fairly obvious from code. Maybe drop these sequencer related comments.

> +	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +				BD79124_MASK_SEQ_START);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS, old);
> +	if (ret)
> +		return ret;
> +
> +	/* Restart the sequencer */
> +	return regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +			      BD79124_MASK_SEQ_START);
> +}
> +
> +static int bd79124_read_raw(struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long m)
> +{
> +	struct bd79124_data *d =3D iio_priv(idev);
> +	int ret;
> +
> +	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
> +		return -EINVAL;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		int old_chan_cfg, tmp;
> +		int regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE,
> +					BD79124_CONV_MODE_AUTO);
> +
> +		guard(mutex)(&d->mutex);
> +
> +		/* ensure pinmux is set to ADC */
> +		if (!bd79124_chan_is_adc(d, chan->channel))
> +			return -EBUSY;

If you are exposing the channel in sysfs it better not be set to be
a GPIO.  You need to generate the chan_spec from what is wired
for ADC usage vs what is wired for GPIO.

> +
> +		/*
> +		 * Start the automatic conversion. This is needed here if no
> +		 * events have been enabled.
> +		 */
> +		ret =3D regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
> +			BD79124_MASK_CONV_MODE, regval);
		ret =3D regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
				         BD79124_MASK_CONV_MODE,
					 FIELD_PREP(BD79124_MASK_CONV_MODE,
> +						    BD79124_CONV_MODE_AUTO));

Is a tiny bit long but meh, it keeps the information all in one place so
I think still worth doing it in one go. If not, just set regval the line
above this call.

> +		if (ret)
> +			return ret;
> +
> +		ret =3D bd79124_single_chan_seq(d, chan->channel, &old_chan_cfg);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * The maximum conversion time is 6 uS. Ensure the sample is
> +		 * ready
The second bit not needed.
		/* Maximum conversion time is 6 usecs */
is fine.

> +		 */
> +		udelay(6);
> +
> +		ret =3D bd79124_read_last_result(d, chan->channel, val);
> +		/* Try unconditionally returning the chan config */

We can see the return to old config from the code. Comment should say why i=
nstead.

> +		tmp =3D bd79124_single_chan_seq_end(d, old_chan_cfg);
> +		if (tmp)
> +			dev_err(d->dev,
> +				"Failed to return config. Alarms may be disabled\n");
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D d->vmax / 1000;
> +		*val2 =3D BD79124_ADC_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static irqreturn_t bd79124_event_handler(int irq, void *priv)
> +{
> +	int ret, i_hi, i_lo, i;
> +	struct iio_dev *idev =3D priv;
> +	struct bd79124_data *d =3D iio_priv(idev);
> +
> +	/*
> +	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
> +	 * subsystem to disable the offending IRQ line if we get a hardware
> +	 * problem. This behaviour has saved my poor bottom a few times in the
> +	 * past as, instead of getting unusably unresponsive, the system has
> +	 * spilled out the magic words "...nobody cared".
*laughs*.  Maybe the comment isn't strictly necessary but it cheered
up my Friday.
> +	 */
> +	ret =3D regmap_read(d->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret =3D regmap_read(d->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	if (!i_lo && !i_hi)
> +		return IRQ_NONE;
> +
> +	for (i =3D 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
> +		u64 ecode;
> +
> +		if (BIT(i) & i_hi) {
Maybe cleaner as a pair of

for_each_set_bit() loops.

> +			ecode =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
> +
> +			iio_push_event(idev, ecode, d->timestamp);
> +			/*
> +			 * The BD79124 keeps the IRQ asserted for as long as
> +			 * the voltage exceeds the threshold. It may not serve
> +			 * the purpose to keep the IRQ firing and events
> +			 * generated in a loop because it may yield the
> +			 * userspace to have some problems when event handling
> +			 * there is slow.
> +			 *
> +			 * Thus, we disable the event for the channel. Userspace
> +			 * needs to re-enable the event.

That's not pretty. So I'd prefer a timeout and autoreenable if we can.

> +			 *
> +			 * We don't check the result as there is not much to do.
> +			 * Also, this should not lead to total IRQ storm
> +			 * because the BD79124 is running in autonomous mode,
> +			 * which means there is by minimum 0.75 mS idle time
> +			 * between changing the channels. That should be
> +			 * sufficient to show some life on system, even if the
> +			 * event handling couldn't keep up.
> +			 */
> +			bd79124_disable_event(d, IIO_EV_DIR_RISING, i);
> +		}
> +		if (BIT(i) & i_lo) {
> +			ecode =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
> +					IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
> +
> +			iio_push_event(idev, ecode, d->timestamp);
The same interrupt thing doesn't apply to falling? That's odd.

> +		}
> +	}
> +
> +	ret =3D regmap_write(d->map, BD79124_REG_EVENT_FLAG_HI, i_hi);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	ret =3D regmap_write(d->map, BD79124_REG_EVENT_FLAG_LO, i_lo);
> +	if (ret)
> +		return IRQ_NONE;
> +
> +	return IRQ_HANDLED;
> +}

> +static int bd79124_hw_init(struct bd79124_data *d)
> +{
> +	int ret, regval;
> +
> +	/* Stop auto sequencer */
> +	ret =3D regmap_clear_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +				BD79124_MASK_SEQ_START);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable writing the measured values to the regsters */
> +	ret =3D regmap_set_bits(d->map, BD79124_REG_GEN_CFG,
> +				 BD79124_MASK_STATS_EN);

Check alignment of that second line. Generally align to just after (

> +	if (ret)
> +		return ret;
> +
> +	/* Set no channels to be auto-measured */
> +	ret =3D regmap_write(d->map, BD79124_REG_AUTO_CHANNELS, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set no channels to be manually measured */
> +	ret =3D regmap_write(d->map, BD79124_REG_MANUAL_CHANNELS, 0x0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the measurement interval to 0.75 mS */
> +
> +	regval =3D FIELD_PREP(BD79124_MASK_AUTO_INTERVAL, BD79124_INTERVAL_075);
> +	ret =3D regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
> +			BD79124_MASK_AUTO_INTERVAL, regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Sequencer mode to auto */
> +	ret =3D regmap_set_bits(d->map, BD79124_REG_SEQUENCE_CFG,
> +			      BD79124_MASK_SEQ_SEQ);
> +	if (ret)
> +		return ret;
> +
> +	regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
> +	/* Don't start the measurement */
> +	return regmap_update_bits(d->map, BD79124_REG_OPMODE_CFG,
> +			BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
> +
> +}
> +
> +#define BD79124_VDD_MAX 5250000
> +#define BD79124_VDD_MIN 2700000
They are real numbers, so if you need them but them values inline.

> +
> +static int bd79124_probe(struct platform_device *pdev)
> +{
> +	struct bd79124_data *d;
> +	struct iio_dev *idev;
Maybe copy more common naming  iio_dev, indio_dev etc
just for familiarity.  For device data, d is a little brief!
> +	int ret, irq, *parent_data;
> +
> +	idev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*d));
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	d =3D iio_priv(idev);
> +
> +	parent_data =3D dev_get_drvdata(pdev->dev.parent);
> +	if (!parent_data)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "reference voltage missing\n");
> +
> +	/*
> +	 * Recommended VDD voltage from the data-sheet:
> +	 * Analog/Digital Supply Voltage VDD 2.70 - 5.25 V
> +	 */
> +	d->vmax =3D *parent_data;
> +	if (d->vmax < BD79124_VDD_MIN || d->vmax > BD79124_VDD_MAX) {

Normally we consider this 'not our problem'.  If someone has wired
their system wrong we don't bother to tell them.  I don't mind having
the check though if you find it particularly useful.

> +		return dev_err_probe(d->dev, -EINVAL,
> +				     "VDD (%d) out of range [%d - %d]\n",
> +				     d->vmax, BD79124_VDD_MIN, BD79124_VDD_MAX);
> +
> +		return -EINVAL;
Already returned.

> +	}
> +
> +	irq =3D platform_get_irq_byname_optional(pdev, "thresh-alert");

Is there more than one?  If not why do we need to do it by name?

> +	if (irq < 0) {
> +		if (irq =3D=3D -EPROBE_DEFER)
> +			return irq;
> +
> +		idev->channels =3D &bd79124_channels_noirq[0];
> +		idev->num_channels =3D ARRAY_SIZE(bd79124_channels_noirq);
> +		dev_dbg(d->dev, "No IRQ found, events disabled\n");
> +	} else {
> +		idev->channels =3D &bd79124_channels[0];
> +		idev->num_channels =3D ARRAY_SIZE(bd79124_channels);
> +	}
> +
> +	idev->info =3D &bd79124_info;
> +	idev->name =3D "bd79124";
> +	idev->modes =3D INDIO_DIRECT_MODE;
> +
> +	d->dev =3D &pdev->dev;
> +	d->map =3D dev_get_regmap(d->dev->parent, NULL);
> +	if (!d->map)
> +		return dev_err_probe(d->dev, -ENODEV, "No regmap\n");
> +
> +	mutex_init(&d->mutex);
> +
> +	ret =3D bd79124_hw_init(d);
> +	if (ret)
> +		return ret;
> +
> +	if (irq > 0) {
> +		ret =3D devm_request_threaded_irq(d->dev, irq, bd79124_irq_handler,
> +					&bd79124_event_handler, IRQF_ONESHOT,
> +					"adc-thresh-alert", idev);
> +		if (ret)
> +			return dev_err_probe(d->dev, ret,
> +					     "Failed to register IRQ\n");
> +	}
> +
> +	return devm_iio_device_register(d->dev, idev);
> +}

