Return-Path: <linux-iio+bounces-12923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97C9DF6DA
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 18:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CCE162DDD
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72251D7E57;
	Sun,  1 Dec 2024 17:56:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4191BC094;
	Sun,  1 Dec 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075808; cv=none; b=mnWfrhHlPXGDpKNEmA10KOavzbX3d6dsNySzi7h4ib7RL5nuHtfGz/r/S67MysL+KKdq8sgmG4hQNn/L8iHBh3PIB2QGtKMvfi15jSEHiaNnbJgF0ZYQJE/1yRd9XdseUh7Vfn6LMAX7++BZLQ+iV5FmS7eFBD5EsVrrmPrRSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075808; c=relaxed/simple;
	bh=/326QE/G4bus2Q/nGoUJyLvNCJpV5BKn5yWdHbNNXeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at0faTbcJwp3cTGfiWJCT+NYXBYpRtc4gdW0y0AKd8Elu4ngZvod2JqENJ11v19fzlz7HA2rMrU7G4Dr3qctCz0hfpu2WPiO9eN53Mw6zRXSRIFVXPanDXfuyQs9vcDagJfTfTe5WWh9dN3mlmdch65dj3w7+d9ShbkUnS3ToAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 1F9A01F0004B;
	Sun,  1 Dec 2024 17:56:34 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 6D4CCA66BA5; Sun,  1 Dec 2024 17:56:33 +0000 (UTC)
X-Spam-Level: 
Received: from collins (unknown [192.168.1.1])
	by laika.paulk.fr (Postfix) with ESMTPSA id 53B86A66BA1;
	Sun,  1 Dec 2024 17:56:32 +0000 (UTC)
Date: Sun, 1 Dec 2024 18:56:30 +0100
From: Paul Kocialkowski <paulk@sys-base.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for the TI OPT4048 color
 sensor
Message-ID: <Z0yjTkXt0JhqdD15@collins>
References: <20241130174212.3298371-1-paulk@sys-base.io>
 <20241130174212.3298371-2-paulk@sys-base.io>
 <20241201115529.1375c6c3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b2b5nMyhgyxyw4km"
Content-Disposition: inline
In-Reply-To: <20241201115529.1375c6c3@jic23-huawei>


--b2b5nMyhgyxyw4km
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Le Sun 01 Dec 24, 11:55, Jonathan Cameron a =C3=A9crit :
> On Sat, 30 Nov 2024 18:42:12 +0100
> Paul Kocialkowski <paulk@sys-base.io> wrote:
>=20
> > The Texas Instruments OPT4048 is a XYZ tristimulus color sensor,
> > with an additional wide (visible + IR) channel.
> >=20
> > This driver implements support for all channels, with configurable
> > integration time and auto-gain. Both direct reading and
> > triggered-buffer modes are supported.
> >=20
> > Note that the Y channel is also reported as a separate illuminance
> > channel, for which a scale is provided (following the datasheet) to
> > convert it to lux units. Falling and rising thresholds are supported
> > for this channel.
> >=20
> > The device's interrupt can be used to sample all channels at the end
> > of conversion and is optional.
> >=20
> > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> Hi Paul,
>=20
> Various comments inline. Most significant is that this seems to be
> suitable for a simple dataready trigger that will make your various
> interrupt and non interrupt flows more similar.

And thanks for the fast review and insightful comments!

I considered implementing a trigger in the driver, but the issue I found
is that the trigger is expected to be called from hard irq context,
while the new values are read in the bottom half. I understand the triggered
buffer callbacks are executed as a thread as well, so there would be race
between the two which could result in previous values being returned.
So I concluded that it was more beneficial to preserve the synchronous read=
ing
mechanism over implementing the trigger.

But maybe I missed/misunderstood something here.

> Jonathan
>=20
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index 321010fc0b93..f2031e6236f9 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -42,6 +42,7 @@ obj-$(CONFIG_MAX44009)		+=3D max44009.o
> >  obj-$(CONFIG_NOA1305)		+=3D noa1305.o
> >  obj-$(CONFIG_OPT3001)		+=3D opt3001.o
> >  obj-$(CONFIG_OPT4001)		+=3D opt4001.o
> > +obj-$(CONFIG_OPT4048)		+=3D opt4048.o
> >  obj-$(CONFIG_PA12203001)	+=3D pa12203001.o
> >  obj-$(CONFIG_ROHM_BU27008)	+=3D rohm-bu27008.o
> >  obj-$(CONFIG_ROHM_BU27034)	+=3D rohm-bu27034.o
> > diff --git a/drivers/iio/light/opt4048.c b/drivers/iio/light/opt4048.c
> > new file mode 100644
> > index 000000000000..1ad5e6586aad
> > --- /dev/null
> > +++ b/drivers/iio/light/opt4048.c
> > @@ -0,0 +1,1145 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2024 Paul Kocialkowski <paulk@sys-base.io>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/log2.h>
> > +#include <linux/module.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define OPT4048_CH0_DATA0			0x0
> > +#define OPT4048_CH0_DATA1			0x1
> > +#define OPT4048_CH1_DATA0			0x2
> > +#define OPT4048_CH1_DATA1			0x3
> > +#define OPT4048_CH2_DATA0			0x4
> > +#define OPT4048_CH2_DATA1			0x5
> > +#define OPT4048_CH3_DATA0			0x6
> > +#define OPT4048_CH3_DATA1			0x7
> > +
> > +#define OPT4048_CH_DATA0_MSB_VALUE(v)		((v) & GENMASK(11, 0))
> > +#define OPT4048_CH_DATA0_EXPONENT_VALUE(v)	(((v) & GENMASK(15, 12)) >>=
 12)
>=20
> For all these - just define the masks and use FIELD_GET() / FIELD_PREP()
> inline.  Masks should be defined with names that make it clear what they =
are
> masking and in what registers.

I see. Note that I generally tried to follow the datasheet's terminology for
convenience.

> > +
> > +#define OPT4048_CH_DATA1_CRC_VALUE(v)		((v) & GENMASK(3, 0))
> > +#define OPT4048_CH_DATA1_COUNTER_VALUE(v)	(((v) & GENMASK(7, 4)) >> 4)
> > +#define OPT4048_CH_DATA1_LSB_VALUE(v)		(((v) & GENMASK(15, 8)) >> 8)
> > +
> > +#define OPT4048_THRESHOLD_L			0x8
> > +#define OPT4048_THRESHOLD_H			0x9
> > +
> > +#define OPT4048_THRESHOLD_RESULT(v)		((v) & GENMASK(11, 0))
> > +#define OPT4048_THRESHOLD_RESULT_MAX		((1 << 12) - 1)
> > +#define OPT4048_THRESHOLD_EXPONENT(v)		(((v) << 12) & GENMASK(15, 12))
> > +#define OPT4048_THRESHOLD_EXPONENT_MAX		((1 << 4) - 1)
> > +
> > +#define OPT4048_CFG0				0xa
> > +#define OPT4048_CFG0_FAULT_COUNT_1		0
> > +#define OPT4048_CFG0_FAULT_COUNT_2		1
> > +#define OPT4048_CFG0_FAULT_COUNT_4		2
> > +#define OPT4048_CFG0_FAULT_COUNT_8		3
> > +#define OPT4048_CFG0_INT_POL_ACTIVE_LOW		0
> > +#define OPT4048_CFG0_INT_POL_ACTIVE_HIGH	BIT(2)
> > +#define OPT4048_CFG0_LATCH			BIT(3)
> > +#define OPT4048_CFG0_OP_MODE_POWER_DOWN		0
> > +#define OPT4048_CFG0_OP_MODE_ONESHOT_AUTORANGE	(1 << 4)
> > +#define OPT4048_CFG0_OP_MODE_ONESHOT		(2 << 4)
> > +#define OPT4048_CFG0_OP_MODE_CONTINUOUS		(3 << 4)
> > +#define OPT4048_CFG0_CONVERSION_TIME(v)		(((v) << 6) & GENMASK(9, 6))
> > +#define OPT4048_CFG0_RANGE(v)			(((v) << 10) & GENMASK(13, 10))
> > +#define OPT4048_CFG0_RANGE_AUTO			(12 << 10)
> > +#define OPT4048_CFG0_QWAKE			BIT(15)
> > +
> > +#define OPT4048_CFG1				0xb
> > +#define OPT4048_CFG1_I2C_BURST			BIT(0)
> > +#define OPT4048_CFG1_INT_CFG_ALERT		0
> > +#define OPT4048_CFG1_INT_CFG_DATA_READY_NEXT	(1 << 2)
> > +#define OPT4048_CFG1_INT_CFG_DATA_READY_ALL	(3 << 2)
> > +#define OPT4048_CFG1_INT_DIR_IN			0
> > +#define OPT4048_CFG1_INT_DIR_OUT		BIT(4)
> > +#define OPT4048_CFG1_THRESHOLD_CH_SEL(i)	(((i) << 5) & GENMASK(6, 5))
> > +#define OPT4048_CFG1_RESERVED			(0x80 << 7)
> > +
> > +#define OPT4048_STATUS				0xc
> > +#define OPT4048_STATUS_FLAG_L			BIT(0)
> > +#define OPT4048_STATUS_FLAG_H			BIT(1)
> > +#define OPT4048_STATUS_CONV_READY_FLAG		BIT(2)
> > +#define OPT4048_STATUS_OVERLOAD_FLAG		BIT(3)
> > +
> > +#define OPT4048_DID				0x11
> > +#define OPT4048_DID_L_VALUE(v)			(((v) & GENMASK(13, 12)) >> 12)
> > +#define OPT4048_DID_H_VALUE(v)			((v) & GENMASK(11, 0))
>=20
> Just define the masks and use FIELD_GET() to extract the fields.
>=20
> > +#define OPT4048_DID_VALUE(l, h)			(((h) << 2) | (l))
> Use FIELD_PREP for this.
>=20
> > +
> > +#define OPT4048_DID_OPT4048			0x2084
> > +
> > +#define OPT4048_SCALE_ULUX			2150
> > +
> > +struct opt4048_sensor_state {
> > +	bool active;
> > +	u8 conversion_time_index;
>=20
> Whilst I don't normally care that much, this is really bad for packing.
> Put like types together.

Sure.

> > +	u16 threshold_low[2];
> > +	bool threshold_low_active;
> > +	u16 threshold_high[2];
> > +	bool threshold_high_active;
> > +	u16 status;
> > +};
> > +
> > +struct opt4048_sensor_scan {
> > +	u32 channels[5];
> > +	s64 timestamp __aligned(8);
>=20
> aligned_s64 is now available upstream.

Alright.

> > +};
> > +
> > +struct opt4048_sensor {
> > +	struct device *dev;
> > +	struct i2c_client *i2c_client;
> > +	struct iio_dev *iio_dev;
> > +
> > +	struct regulator *vdd_supply;
> > +
> > +	struct opt4048_sensor_state state;
>=20
> > +	struct opt4048_sensor_scan scan;
>=20
> As below. I think you should just always do the read in the trigger handl=
er.

As far as I could see the hardware doesn't guarantee that values come from
the same read sequence (even if read as a single i2c transaction). This is =
why
my approach was to read them as early as possible after the irq is signaled
and cache them here, instead of doing the actual read in the trigger handler
or sysfs read callback (which may have both values from the previous and ne=
xt
reads).

The only thing the hardware guarantees is that the DATA1 value is latched w=
hen
DATA0 is read.

> > +	bool scan_sync;
>=20
> This needs a comment.  Interrupts and sync aren't something that normally=
 goes
> together so the name is somewhat confusing.

Okay. The idea is to have a synchronous read where all channels are read as
soon as conversion done is signaled.

> > +	struct mutex lock;
>=20
> Locks should always have a comment to say what data they are protecting.
>=20
> > +};
>=20
>=20
> > +
> > +static int opt4048_data_read(struct opt4048_sensor *sensor, u8 address,
> > +			     u32 *channel_value)
> > +{
> > +	struct i2c_client *i2c_client =3D sensor->i2c_client;
> > +	u16 value, result_msb, result_lsb, exponent;
> > +	unsigned int index =3D 0;
> > +	u8 values[4] =3D { 0 };
> > +	int ret;
> > +
> > +	/* Read all values in one transaction to ensure coherency. */
> > +	ret =3D i2c_smbus_read_i2c_block_data(i2c_client, address, 4, values);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	value =3D values[index] << 8 | values[index + 1];
> As below. Use a __be16 and suitable conversion funcitons.
> > +	index +=3D 2;
> > +
> > +	result_msb =3D OPT4048_CH_DATA0_MSB_VALUE(value);
> > +	exponent =3D OPT4048_CH_DATA0_EXPONENT_VALUE(value);
> > +
> > +	value =3D values[index] << 8 | values[index + 1];
> > +
> > +	result_lsb =3D (u16)OPT4048_CH_DATA1_LSB_VALUE(value);
> > +
> > +	*channel_value =3D opt4048_data_value(result_msb, result_lsb, exponen=
t);
> > +
> > +	return 0;
> > +}
> > +
> > +static int opt4048_data_scan(struct opt4048_sensor *sensor,
> > +			     struct opt4048_sensor_scan *scan)
> > +{
> > +	struct i2c_client *i2c_client =3D sensor->i2c_client;
> > +	unsigned int index =3D 0;
> > +	u8 values[16] =3D { 0 };
>=20
> Looks like an array of __be16.  Cleaner to define it like that.
>=20
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	/* Read all values in one transaction to ensure coherency. */
> > +	ret =3D i2c_smbus_read_i2c_block_data(i2c_client, OPT4048_CH0_DATA0, =
16,
> > +					    values);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	for (i =3D 0; i < 4; i++) {
> > +		u16 value, result_msb, result_lsb, exponent;
> > +
> > +		value =3D values[index] << 8 | values[index + 1];
> get_unaligned_be16()=20
>=20
> or better still make values an array of __be16 and use
> be16_to_cpu()

Indeed all that will make things easier.

> > +		index +=3D 2;
> > +
> > +		result_msb =3D (u16)OPT4048_CH_DATA0_MSB_VALUE(value);
> > +		exponent =3D (u16)OPT4048_CH_DATA0_EXPONENT_VALUE(value);
>=20
> Use FIELD_GET() and suitable masks for this.
>=20
> > +
> > +		value =3D values[index] << 8 | values[index + 1];
> > +		index +=3D 2;
> > +
> as above..
>=20
> > +		result_lsb =3D (u16)OPT4048_CH_DATA1_LSB_VALUE(value);
> > +
> > +		scan->channels[i] =3D
> > +			opt4048_data_value(result_msb, result_lsb, exponent);
> > +	}
> > +
> > +	/* Report illuminance using Y intensity value. */
>=20
> That seems 'interesting'.  Why?

The Y channel is defined by CIE1931 to match the (photopic) illuminance res=
ponse
curve. The main difference is that Y is unit-less while illuminance is defi=
ned
in lux. This specific channel gets an extra scale property to report the
conversion coefficient for lux.

However we still need the Y value to be reported as such in order to be rel=
ated
to X and Z.

> > +	scan->channels[4] =3D scan->channels[1];
> > +
> > +	return 0;
> > +}
> > +
> > +static int opt4048_identify(struct opt4048_sensor *sensor)
> > +{
> > +	struct device *dev =3D sensor->dev;
> > +	int ret;
> > +	u16 id, low, high;
> > +
> > +	ret =3D pm_runtime_resume_and_get(dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D i2c_smbus_read_word_swapped(sensor->i2c_client, OPT4048_DID);
> > +	if (ret < 0)
> > +		goto complete;
> > +
> > +	low =3D (u16)OPT4048_DID_L_VALUE(ret);
> > +	high =3D (u16)OPT4048_DID_H_VALUE(ret);
> > +
> > +	id =3D OPT4048_DID_VALUE(low, high);
> > +
> > +	switch (id) {
> > +	case OPT4048_DID_OPT4048:
> > +		dev_info(dev, "identified OPT4048 sensor\n");
> This isn't useful information and can be easily established once the
> driver has loaded.  So dev_dbg() at most.

Honestly I see a bunch of driver doing that (especially camera sensors)
and find it generally useful. But I don't mind getting rid of it.

> > +		ret =3D 0;
> > +		break;
> > +	default:
> > +		dev_err(dev, "unknown sensor with id: %#x\n", id);
> > +		ret =3D -ENODEV;
> We shouldn't treat a failure to match the ID as a reason to fail probe.
> Consider the use of fallback IDs in device tree with older kernels.
> If a new device comes along that is backwards compatible, we want that
> to work with out driver modifications.

Honestly this is really just a way to check that i2c transaction are workin=
g,
that the device is actually there and to report when it's not.

I'm not sure it's such a good idea to assume that other IDs would not be
a sign that something very wrong is going on (typically some other device
connected on the same i2c address). Failing to probe will prevent
misconfiguring another device.

Just adding another case here if a new device is ever introduced doesn't
sound like such a big drawback in comparison.

> It's fine to print an dev_info message though so the user is aware
> that we are ignoring the missmatch.
>=20
> > +		break;
> > +	}
> > +
> > +complete:
> > +	pm_runtime_put_sync(dev);
> > +
> > +	return ret;
> > +}
> > +
> > +static int opt4048_power(struct opt4048_sensor *sensor, bool on)
> > +{
> > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > +	int ret;
> > +
> > +	mutex_lock(&sensor->lock);
> guard()
> > +
> > +	state->active =3D on;
> > +	ret =3D opt4048_state_configure_cfg0(sensor);
> > +
> > +	mutex_unlock(&sensor->lock);
> > +
> > +	return ret;
> > +}
>=20
> > +static int opt4048_state_configure_cfg1(struct opt4048_sensor *sensor)
> > +{
> > +	u16 value;
> > +	int ret;
> I don't really see any advantage in these wrappers.   I'd just have
> the code inline in  opt4048_state_configure()=20

Well I do think they are important to make the code more digest.

> > +
> > +	/* Assign threshold to the Y channel for illuminance. */
> > +	value =3D OPT4048_CFG1_I2C_BURST |
> > +		OPT4048_CFG1_INT_DIR_OUT |
> > +		OPT4048_CFG1_THRESHOLD_CH_SEL(1) |
> > +		OPT4048_CFG1_RESERVED;
>=20
> combine these on fewer lines.  Just generally stay below 80 chars unless
> there is a strong readability reason to go longer.

I find it a lot more readable with one item per line.

> > +
> > +	if (sensor->scan_sync)
> > +		value |=3D OPT4048_CFG1_INT_CFG_DATA_READY_ALL;
> > +	else
> > +		value |=3D OPT4048_CFG1_INT_CFG_ALERT;
> > +
> > +	ret =3D i2c_smbus_write_word_swapped(sensor->i2c_client, OPT4048_CFG1,
> > +					   value);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
>=20
> > +
> > +static int opt4048_state_configure(struct opt4048_sensor *sensor)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&sensor->lock);
> guard() See below.
>=20
> > +
> > +	ret =3D opt4048_state_configure_cfg0(sensor);
> > +	if (ret)
> > +		goto complete;
> > +
> > +	ret =3D opt4048_state_configure_cfg1(sensor);
> > +	if (ret)
> > +		goto complete;
> > +
> > +	ret =3D opt4048_state_configure_threshold(sensor);
> > +	if (ret)
> > +		goto complete;
> > +
> > +complete:
> > +	mutex_unlock(&sensor->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void opt4048_state_reset(struct opt4048_sensor *sensor)
> > +{
> > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > +
> > +	state->active =3D false;
> > +
> > +	/* Start with a 25 ms integration time. */
> > +	state->conversion_time_index =3D 6;
> > +
> > +	state->threshold_low_active =3D false;
> > +	state->threshold_high_active =3D false;
> > +}
> > +
> > +/* IIO */
> > +
> > +static const struct iio_event_spec opt4048_iio_events[] =3D {
> > +	{
> > +		.type		=3D IIO_EV_TYPE_THRESH,
> > +		.dir		=3D IIO_EV_DIR_RISING,
> > +		.mask_separate	=3D
> > +			BIT(IIO_EV_INFO_ENABLE) |
> > +			BIT(IIO_EV_INFO_VALUE),
> > +	},
> > +	{
> > +		.type		=3D IIO_EV_TYPE_THRESH,
> > +		.dir		=3D IIO_EV_DIR_FALLING,
> > +		.mask_separate	=3D
> > +			BIT(IIO_EV_INFO_ENABLE) |
> > +			BIT(IIO_EV_INFO_VALUE),
> > +	},
> > +};
> > +
> > +static const struct iio_chan_spec opt4048_iio_channels[] =3D {
> > +	{
> > +		.type			=3D IIO_INTENSITY,
> > +		.channel2		=3D IIO_MOD_X,
> > +		.address		=3D OPT4048_CH0_DATA0,
> > +		.modified		=3D 1,
> > +
> > +		.scan_index		=3D 0,
> > +		.scan_type		=3D {
> > +			.sign		=3D 'u',
> > +			.realbits	=3D 28,
> > +			.storagebits	=3D 32,
> > +			.endianness	=3D IIO_LE,
> > +		},
> > +
> > +		.info_mask_separate =3D
> > +			BIT(IIO_CHAN_INFO_RAW),
> 		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>=20
> still a short line. So don't wrap too aggressively.
>=20
>=20
> > +		.info_mask_shared_by_all =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.info_mask_shared_by_all_available =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +	},
> > +	{
> > +		.type			=3D IIO_INTENSITY,
> > +		.channel2		=3D IIO_MOD_Y,
> > +		.address		=3D OPT4048_CH1_DATA0,
> > +		.modified		=3D 1,
> > +
> > +		.scan_index		=3D 1,
> > +		.scan_type		=3D {
> > +			.sign		=3D 'u',
> > +			.realbits	=3D 28,
> > +			.storagebits	=3D 32,
> > +			.endianness	=3D IIO_LE,
> > +		},
> > +
> > +		.info_mask_separate =3D
> > +			BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_all =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.info_mask_shared_by_all_available =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +	},
> > +	{
> > +		.type			=3D IIO_INTENSITY,
> > +		.channel2		=3D IIO_MOD_Z,
> > +		.address		=3D OPT4048_CH2_DATA0,
> > +		.modified		=3D 1,
> > +
> > +		.scan_index		=3D 2,
> > +		.scan_type		=3D {
> > +			.sign		=3D 'u',
> > +			.realbits	=3D 28,
> > +			.storagebits	=3D 32,
> > +			.endianness	=3D IIO_LE,
> > +		},
> > +
> > +		.info_mask_separate =3D
> > +			BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_all =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.info_mask_shared_by_all_available =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +	},
> > +	{
> > +		.type			=3D IIO_INTENSITY,
> > +		.channel2		=3D IIO_MOD_LIGHT_BOTH,
> > +		.address		=3D OPT4048_CH3_DATA0,
> > +		.modified		=3D 1,
> > +
> > +		.scan_index		=3D 3,
> > +		.scan_type		=3D {
> > +			.sign		=3D 'u',
> > +			.realbits	=3D 28,
> > +			.storagebits	=3D 32,
> > +			.endianness	=3D IIO_LE,
> > +		},
> > +
> > +		.info_mask_separate =3D
> > +			BIT(IIO_CHAN_INFO_RAW),
> > +		.info_mask_shared_by_all =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.info_mask_shared_by_all_available =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +	},
> > +	{
> > +		.type			=3D IIO_LIGHT,
> > +		.address		=3D OPT4048_CH1_DATA0,
> > +
> > +		.scan_index		=3D 4,
> > +		.scan_type		=3D {
> > +			.sign		=3D 'u',
> > +			.realbits	=3D 28,
> > +			.storagebits	=3D 32,
> > +			.endianness	=3D IIO_LE,
> > +		},
> > +
> > +		.info_mask_separate =3D
> > +			BIT(IIO_CHAN_INFO_RAW) |
> > +			BIT(IIO_CHAN_INFO_SCALE),
> > +		.info_mask_shared_by_all =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +		.info_mask_shared_by_all_available =3D
> > +			BIT(IIO_CHAN_INFO_INT_TIME),
> > +	},
> > +	IIO_CHAN_SOFT_TIMESTAMP(5),
> > +};
> > +
> > +static int opt4048_iio_read_raw(struct iio_dev *iio_dev,
> > +				struct iio_chan_spec const *channel,
> > +				int *value_first, int *value_second, long mask)
> > +{
> > +	struct opt4048_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > +	struct device *dev =3D sensor->dev;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> Need define scope {}
>=20
> > +		unsigned int scan_index;
> > +
> > +		ret =3D iio_device_claim_direct_mode(iio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret =3D pm_runtime_resume_and_get(dev);
> > +		if (ret < 0)
> > +			goto release_direct_mode;
> > +
> > +		if (sensor->scan_sync) {
>=20
> So this is curious. You just power up sensor and let it run until interru=
pt.
> I'd expect to have interrupt disabled unless buffered capture is in use.
> It would be fine to turn it on for a single cycle though if that makes ca=
pturing
> on demand simpler.

So that reflects the fact that getting synchronous readings from the sensor
does require reading the channels "soon after" the interrupt.

> > +			scan_index =3D channel->scan_index;
> > +
> > +			mutex_lock(&sensor->lock);
> > +			*value_first =3D (int)sensor->scan.channels[scan_index];
> > +			mutex_unlock(&sensor->lock);
> > +		} else {
> > +			ret =3D opt4048_data_read(sensor, channel->address,
> > +						(u32 *)value_first);
> > +		}
> > +
> > +		pm_runtime_mark_last_busy(dev);
> > +		pm_runtime_put_autosuspend(dev);
> > +
> > +release_direct_mode:
>=20
> I'd factor out the code above into a another function, then can avoid
> the ugly goto within a switch statement.

Okay.

> > +		iio_device_release_direct_mode(iio_dev);
> > +
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*value_first =3D 0;
> > +		*value_second =3D OPT4048_SCALE_ULUX;
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	case IIO_CHAN_INFO_INT_TIME:
> > +		unsigned int index =3D 2 * state->conversion_time_index;
> > +
> > +		*value_first =3D opt4048_conversion_time_available[index];
> > +		index++;
> > +		*value_second =3D opt4048_conversion_time_available[index];
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
>=20
> > +
> > +static int opt4048_iio_write_event_value(struct iio_dev *iio_dev,
> > +					 struct iio_chan_spec const *channel,
> > +					 enum iio_event_type type,
> > +					 enum iio_event_direction direction,
> > +					 enum iio_event_info info,
> > +					 int value_first, int value_second)
> > +{
> > +	struct opt4048_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > +	u32 value;
> > +	int ret;
> > +
> > +	switch (direction) {
> > +	case IIO_EV_DIR_RISING:
> > +		value =3D (u32)value_first;
> > +		opt4048_threshold_convert(value, state->threshold_high);
> > +		break;
> > +
> > +	case IIO_EV_DIR_FALLING:
> > +		value =3D (u32)value_first;
> > +		opt4048_threshold_convert(value, state->threshold_low);
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (pm_runtime_suspended(sensor->dev))
> > +		return 0;
> I'm curious. Why isn't this an error return?  Check for other cases of th=
is.
> I think they should all return an error so userspace knows something unex=
pected
> is going on.

I'd expect userspace to be able to configure the threshold without anything
reading values at that moment. The point is to keep the sensor off.

> > +
> > +	ret =3D opt4048_state_configure_threshold(sensor);
> > +	if (ret)
> > +		return ret;
>=20
> 	return opt...
>=20
> > +
> > +	return 0;
> > +}
>=20
> > +
> > +static int opt4048_iio_write_event_config(struct iio_dev *iio_dev,
> > +					  struct iio_chan_spec const *channel,
> > +					  enum iio_event_type type,
> > +					  enum iio_event_direction direction,
> > +					  int active)
> Now takes a bool.  Rebase on either my iio.git / testing branch or
> rc1 once available (probably later today).

Will do!

> > +{
> > +	struct opt4048_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > +	int ret =3D 0;
> > +
> > +	/* Threshold active are read in IRQ thread. */
> > +	mutex_lock(&sensor->lock);
>=20
> guard()
>=20
> > +
> > +	switch (direction) {
> > +	case IIO_EV_DIR_RISING:
> > +		state->threshold_high_active =3D !!active;
>=20
> This is why the signature became bool. All drivers had the same handling
> which made no sense :(
>=20
> FWIW you don't need the !! even before that change.

Yeah bool isn't really a thing in C but it just feels more consistent.
It would be necessary if I had defined threshold_high_active as a single-bit
field though.

>=20
>=20
> > +		break;
> > +
> > +	case IIO_EV_DIR_FALLING:
> > +		state->threshold_low_active =3D !!active;
> > +		break;
> > +
> > +	default:
> > +		ret =3D -EINVAL;
> When using guard. Can just return -EINVAL;
> > +		goto complete;
> > +	}
> > +
> > +	if (pm_runtime_suspended(sensor->dev))
> > +		goto complete;
> As above - direct return.
> Though fun question of what you should do if this does fail as
> we are then in a weird unknown state.
> why not an error return?

It's really not an error if it fails and the state handling is written to a=
llow
configuring it with the device off. It just updates the states without reac=
hing
the device and the state gets applied at the next resume.

> > +
> > +	ret =3D opt4048_state_configure_threshold(sensor);
> Will become
> 	return opt4048_*
> > +
> > +complete:
> > +	mutex_unlock(&sensor->lock);
> > +
> > +	return ret;
> > +}
> };
> > +
> > +static irqreturn_t opt4048_iio_buffer_trigger(int irq, void *data)
> > +{
> > +	struct iio_poll_func *poll_func =3D data;
> > +	struct iio_dev *iio_dev =3D poll_func->indio_dev;
> > +	struct opt4048_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct opt4048_sensor_scan scan =3D { 0 };
> > +	s64 timestamp;
> > +	unsigned int index =3D 0;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	/* Capture timestamp just before reading values. */
> > +	timestamp =3D iio_get_time_ns(iio_dev);
> > +
> > +	mutex_lock(&sensor->lock);
> > +
> > +	if (!sensor->scan_sync) {
> > +		ret =3D opt4048_data_scan(sensor, &sensor->scan);
> So you have a weird hybrid of capture in the data ready interrupt and her=
e.

The point is to allow both interrupt-based and interrupt-less operation her=
e.

> Why not just kick this off by having a data ready trigger and
> using iio_trigger_poll() to effectively call this on the data ready
> interrupt or on an other trigger.  That way should need no special handli=
ng
> for your sync scan.

See the comment above, maybe I missed something though.

>=20
>=20
> > +		if (ret)
> > +			goto complete;
> > +	}
> > +
> > +	for_each_set_bit(i, iio_dev->active_scan_mask, iio_dev->masklength) {
> > +		/* Assume scan index matches array index. */
> > +		const struct iio_chan_spec *channel =3D &opt4048_iio_channels[i];
> > +		unsigned int scan_index =3D channel->scan_index;
> > +
> > +		/* Only active channels are reported, in order. */
> > +		scan.channels[index] =3D sensor->scan.channels[scan_index];
> > +		index++;
>=20
> If you are always reading all channels, set avail_scan_masks and let the
> demux in the IIO core deal with this data rearranging.

Ah I didn't know we could do that!

> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(iio_dev, &scan, timestamp);
> > +
> > +complete:
> > +	mutex_unlock(&sensor->lock);
> > +
> > +	iio_trigger_notify_done(iio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
>=20
> ...
>=20
>=20
> > +static const struct iio_buffer_setup_ops opt4048_iio_buffer_setup_ops =
=3D {
> > +	.preenable =3D opt4048_iio_buffer_preenable,
> > +	.postdisable =3D opt4048_iio_buffer_postdisable,
> > +};
> > +
> > +static int opt4048_iio_setup(struct opt4048_sensor *sensor)
> This function doesn't add much. I'd just put the code inline in prbe.

I just like splitting framework-specific init, it makes things more readabl=
e.

> > +{
> > +	struct iio_chan_spec *channels;
> > +	struct iio_dev *iio_dev =3D sensor->iio_dev;
> Just pass it the iio_dev in.

My taste is rather to have a device-wide structure that is used in all
functions that are not callbacks from the framework/bus/device.

> > +	struct device *dev =3D sensor->dev;
> > +	unsigned int channels_count;
> > +	int ret;
> > +
> > +	channels_count =3D ARRAY_SIZE(opt4048_iio_channels);
> > +
> > +	if (sensor->i2c_client->irq > 0) {
> > +		channels =3D devm_kzalloc(dev, sizeof(opt4048_iio_channels),
> > +					GFP_KERNEL);
>=20
> kmemdup.  However I'd rather just see this picking between two static
> const arrays of channels.  There are only two cases so it isn't worth dyn=
amic
> channel setup complexity.

Well they would be 99 % identical. I don't really see how this would be a
beneficial duplication versus the low complexity of these few lines.

> > +
> > +		memcpy(channels, opt4048_iio_channels,
> > +		       sizeof(opt4048_iio_channels));
> > +
> > +		/* Attach threshold events to the illuminance channel. */
> > +		channels[3].event_spec =3D opt4048_iio_events;
> > +		channels[3].num_event_specs =3D ARRAY_SIZE(opt4048_iio_events);
> > +	} else {
> > +		/* Threshold events are not available without an irq. */
> > +		channels =3D (struct iio_chan_spec *)opt4048_iio_channels;
> > +	}
> > +
> > +	iio_dev->info =3D &opt4048_iio_info;
> > +	iio_dev->name =3D "opt4048";
> > +	iio_dev->channels =3D channels;
> > +	iio_dev->num_channels =3D channels_count;
> > +	iio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +	ret =3D devm_iio_triggered_buffer_setup(dev, iio_dev, NULL,
> > +					      opt4048_iio_buffer_trigger,
> > +					      &opt4048_iio_buffer_setup_ops);
> > +	if (ret) {
> > +		dev_err(dev, "failed to setup iio triggered buffer\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D iio_device_register(iio_dev);
>=20
> As below. No reason not to use devm_iio_device_register() and avoid
> need to manually unwind.

Oh sure!

> > +	if (ret) {
> > +		dev_err(dev, "failed to register iio device\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void opt4048_iio_cleanup(struct opt4048_sensor *sensor)
> > +{
> > +	iio_device_unregister(sensor->iio_dev);
> This wrapper doesn't add anything useful so put the code inline.
> Though as below, it shouldn't be called directly at all.
>=20
>=20
> > +}
> > +
> > +/* IRQ */
> Comment doesn't add anything that isn't obvious from the code.
> So don't have it.

These are meant as categories to make it clear what the following code is
related to.

> > +
> > +static irqreturn_t opt4048_irq(int irq, void *data)
> > +{
> > +	struct opt4048_sensor *sensor =3D data;
> > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > +	struct iio_dev *iio_dev =3D sensor->iio_dev;
>=20
> Set data =3D iio_dev and then use iio_priv() on that.
> There shouldn't be a need to go back the other way.

Not really my taste, sorry.

> > +	bool threshold_rising;
> > +	bool threshold_falling;
> > +	s64 timestamp;
> > +	u64 code;
> Might as well combine elements of same type.  Saves a few lines of code
> and doesn't harm readability much.

Sure.

> > +	u16 status;
> > +	int ret;
> > +
> > +	timestamp =3D iio_get_time_ns(iio_dev);
> > +
> > +	ret =3D i2c_smbus_read_word_swapped(sensor->i2c_client, OPT4048_STATU=
S);
> > +	if (ret < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	status =3D (u16)ret;
> > +
> > +	mutex_lock(&sensor->lock);
> Use=20
> 	guard(mutex)(&sensor->lock);
> and include cleanup.h
>=20
> That will simplify this function as you can then do direct returns
> instead of gotos.
>=20
> > +
> > +	if (!state->active)
> Perhaps add a comment for this. I guess it's about preventing a race?

Yes although I'm not even 100% sure it can really happen.

> + the lock prevents concurrent power down.
>=20
> I'd be tempted to just do a pm_runtime_resume_and_get()
> Vast majority of the time the device will be powered up and you won't
> need to do anything.  The race will be closed as in the rare corner
> case w will be able ot read the data.
>=20
> I'm also curious that you can still read status after powering down.
> Maybe add a comment about that always being safe.

Mhh that's a good point. Status read should really fail indeed.
I guess I'll need to rework this.

> > +		goto complete;
> > +
> > +	if (status & OPT4048_STATUS_CONV_READY_FLAG)
> > +		opt4048_data_scan(sensor, &sensor->scan);
>=20
> Superficially this looks like a data ready trigger should be used.
> So register a trigger and do the read in the trigger handler in all
> cases rather than here.
>=20
> > +
> > +	threshold_falling =3D (status & OPT4048_STATUS_FLAG_L) &&
> > +			    !(state->status & OPT4048_STATUS_FLAG_L);
> > +
> > +	if (state->threshold_low_active && threshold_falling) {
> > +		code =3D IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 3, IIO_EV_TYPE_THRESH,
> > +					    IIO_EV_DIR_FALLING);
> > +		iio_push_event(iio_dev, code, timestamp);
> > +	}
> > +
> > +	threshold_rising =3D (status & OPT4048_STATUS_FLAG_H) &&
> > +			   !(state->status & OPT4048_STATUS_FLAG_H);
> > +
> > +	if (state->threshold_high_active && threshold_rising) {
> > +		code =3D IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 3, IIO_EV_TYPE_THRESH,
> > +					    IIO_EV_DIR_RISING);
> > +		iio_push_event(iio_dev, code, timestamp);
> > +	}
> > +
> > +	state->status =3D status;
> Add a comment on why you are saving this (I guess because the device
> interrupts every time otherwise).  Does it interrupt on the reverse
> direction?  If not how is this cleared?

Ah I thought it was clear from the fact that we use it in the statements ab=
ove
to find out if we just crossed a threshold.

The device reports "value above/below threshold" at every reading and not
"threshold crossed" so I need to compare with previous state to derive
rising/falling.

> > +
> > +complete:
> > +	mutex_unlock(&sensor->lock);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/* PM */
> Structural comments like this don't add much after a driver is
> written and often become wrong as a driver develops over time.
> I'd drop them.
>=20
> > +
> > +static int opt4048_suspend(struct device *dev)
> > +{
> > +	struct opt4048_sensor *sensor =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret =3D opt4048_power(sensor, 0);
> > +	if (ret)
> > +		goto error;
> > +
> > +	ret =3D regulator_disable(sensor->vdd_supply);
> > +	if (ret)
> > +		goto error;
> > +
> > +	return 0;
> > +
> > +error:
> > +	return -EAGAIN;
> Direct returns preferred over both eating the error codes and
> a goto like this.

Hehe the suspend callback doesn't work that way. If you *ever* return somet=
hing
else than -EAGAIN, it will never attempt to resume the device again. This is
documented in the runtime pm semantics.

So it is very crucial to eat the error code and return -EAGAIN if we want to
have a chance at it again. Many drivers get this wrong.

> > +}
> > +
> > +static int opt4048_resume(struct device *dev)
> > +{
> > +	struct opt4048_sensor *sensor =3D dev_get_drvdata(dev);
> > +	unsigned long sleep_min;
> > +	unsigned int index;
> > +	int ret;
> > +
> > +	ret =3D regulator_enable(sensor->vdd_supply);
> > +	if (ret)
> > +		goto error;
> > +
> > +	/* Wait for the regulator to settle and the chip to power-on. */
> > +	udelay(30);
> > +
> > +	ret =3D opt4048_state_configure(sensor);
> > +	if (ret)
> > +		goto error_regulator;
> > +
> > +	ret =3D opt4048_power(sensor, 1);
> > +	if (ret)
> > +		goto error_regulator;
> > +
> > +	/* Wait for conversion to be ready for all channels. */
> We might not have powered up for that reason but I guess this does
> little harm.

By design this driver only powers up the device for readings. Everything el=
se
is kept staging in the state structure.

> > +	index =3D 2 * sensor->state.conversion_time_index + 1;
> > +	sleep_min =3D opt4048_conversion_time_available[index] * 4;
> > +
> > +	usleep_range(sleep_min, 5 * sleep_min / 4);
>=20
> Perhaps use fsleep() to avoid anyone needing to reason about the margins
> etc.
>=20
> > +
> > +	return 0;
> > +
> > +error_regulator:
> > +	regulator_disable(sensor->vdd_supply);
> > +
> > +error:
> Direct returns make for easier to review code as following an error
> path doesn't require checking to see what the cleanup is.

I prefer it over duplication.

> > +	return -EAGAIN;
> > +}
> > +
> > +static const struct dev_pm_ops opt4048_pm_ops =3D {
> > +	.runtime_suspend	=3D opt4048_suspend,
> > +	.runtime_resume		=3D opt4048_resume,
> > +};
> > +
> > +/* I2C */
> Not a particularly useful comment. I'd drop it.
> > +
> > +static int opt4048_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev =3D &client->dev;
> > +	struct opt4048_sensor *sensor;
> > +	struct iio_dev *iio_dev;
> > +	int irq =3D client->irq;
> > +	int ret;
> > +
> > +	iio_dev =3D devm_iio_device_alloc(dev, sizeof(*sensor));
> > +	if (!iio_dev)
> > +		return -ENOMEM;
> > +
> > +	sensor =3D iio_priv(iio_dev);
> > +
> > +	sensor->dev =3D dev;
> > +	sensor->i2c_client =3D client;
> > +	sensor->iio_dev =3D iio_dev;
> That is almost always a sign that you have a less than ideal layering
> in the driver.

I disagree, my preference is to have a top-level device-specific structures
that holds everything else and is used in all local functions. It find it
a lot more convenient and readable.

> > +
> > +	i2c_set_clientdata(client, sensor);
> > +
> > +	mutex_init(&sensor->lock);
> 	ret =3D devm_mutex_init()
> 	if (ret)
> 		return ret;
> > +
> > +	sensor->vdd_supply =3D devm_regulator_get(dev, "vdd");
>=20
> Given runtime PM may not even be enabled, you should turn the power on.
> Unconditionally.

The driver definitely depends on runtime PM being enabled (and I think it's
a good thing to keep the device off when it's not used).

> > +	if (IS_ERR(sensor->vdd_supply)) {
> > +		dev_err(dev, "failed to get VDD regulator\n");
>=20
> For error returns and messages in probe use return dev_err_probe()
> It will do various useful things for deferred and out of memory
> error prints.  Find to use it in all code only called from the probe
> callback.

Ah right, I forgot about it.

> > +		return PTR_ERR(sensor->vdd_supply);
> > +	}
> > +
> > +	opt4048_state_reset(sensor);
> > +
> > +	devm_pm_runtime_enable(dev);
> Can fail so check for that.
>=20
> > +
> > +	ret =3D opt4048_identify(sensor);
> > +	if (ret)
> As above, failure to match should not be a reason to fail probe.
> > +		return ret;
> > +
> > +	pm_runtime_set_autosuspend_delay(dev, 5000);
> > +	pm_runtime_use_autosuspend(dev);
> > +
> > +	if (irq > 0) {
> > +		ret =3D devm_request_threaded_irq(dev, irq, NULL, opt4048_irq,
> > +						IRQF_TRIGGER_FALLING |
> > +						IRQF_ONESHOT,
> Direction should come from firmware (so don't specify it here).
> It's reasonably common to find an inverter in the path for an interrupt
> and so we can't know the sense in the driver.

Understood.

> > +						"opt4048", sensor);
> > +		if (ret) {
> > +			dev_err(dev, "failed to request irq\n");
> > +			return ret;
> > +		}
> > +
> > +		sensor->scan_sync =3D true;
> > +	}
> > +
> > +	ret =3D opt4048_iio_setup(sensor);
> As above, I'd put the contents of that function here as well. Whilst
> I guess you wanted to keep functions small, sometimes that just leads
> to less readable code than a long function with everything we expect
> in it.
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> =09
> > +}
> > +
> > +static void opt4048_remove(struct i2c_client *client)
> > +{
> > +	struct opt4048_sensor *sensor =3D i2c_get_clientdata(client);
> > +
> > +	opt4048_iio_cleanup(sensor);
> For a simple single call like this, use a devm_add_action_or_reset()
> so that the cleanup is associated directly with the setup function and
> we don't need a remove() callback at all.
>=20
> Given all it does is iio_device_unregister() just use devm_device_registe=
r()
> in the first place and drop this.

Alright.

> > +}
> > +
> > +static const struct i2c_device_id opt4048_id[] =3D {
> > +	{ "opt4048" },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, opt4048_id);
> > +
> > +static const struct of_device_id opt4048_of_match[] =3D {
> > +	{ .compatible =3D "ti,opt4048" },
> > +	{ }
> > +};
> Similar to below, fairly standard to group the id table and
> MODULE_DEVICE_TABLE but not having a blank line.

I don't particularly like it.

> > +
> > +MODULE_DEVICE_TABLE(of, opt4048_of_match);
> > +
> > +static struct i2c_driver opt4048_driver =3D {
> > +	.driver =3D {
> > +		.name		=3D "opt4048",
> > +		.of_match_table =3D opt4048_of_match,
> > +		.pm		=3D &opt4048_pm_ops,
> > +	},
> > +	.id_table	=3D opt4048_id,
> > +	.probe		=3D opt4048_probe,
> > +	.remove		=3D opt4048_remove,
> > +};
> > +
> It's common to not put a blank line here given how closely coupled this
> macro is to the structure.
> > +module_i2c_driver(opt4048_driver);
> > +
> > +MODULE_AUTHOR("Paul Kocialkowski <paulk@sys-base.io>");
> > +MODULE_DESCRIPTION("Texas Instruments OPT4048 XYZ tristimulus color se=
nsor driver");
> > +MODULE_LICENSE("GPL");
>=20

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--b2b5nMyhgyxyw4km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmdMo04ACgkQhP3B6o/u
lQwDfQ/+L45HkENQOLdKmuEtcVwRoKIH5WSEVT1Im1Q43nwsjFh/hvWfNm7VKLpx
TNciNkbP6aWWN8udpm3dsVSYbdC645bRyIlCNIodQkj6wDzu9fDA5ktweWcNGaXF
MBdTZjzo5U4TJoyhP4mpYhY5csRrVf9OgZJbCe8+/wKMwtquqvBrJ2Iw5bS3bqF8
Oy3aFBxKg4rKICNyqZ452Y/eeTD+/4+6YSYDayyJc007LCfbKGOecLxH0hiUWsa2
U8ZzFFaKFCGrHeNMuN5o13csKOpotFo2q2/RDMezpxF+wDnhm3xpSB3xdAgr01RI
WcPspe+//LBM6OsiG41Lgz/SV5il/VGQ6/V5J68VZXmJ6E9f4rWg71LtZWekC20T
7GuUkxM+h8pVOPa511/YR1DGwkq48U/5Xh3gvPHoZPTrAJKeIuzfm4gtcBliHFFU
ttGiueIOCo2Pn2ubzNYSbvF3tR99ZJv/Z6cLWiDN4925mEDRctARV3f0+DAvfdFd
3vKiZpFThk6w2fjtocUrATeoh+ny7dzmFS3xZcMDk3jUtMtSODlNr6EcCLK2QCwk
z4umpswBQDm1Cnlu0377la0nN6hNL3JFQC0ZmPfqZYun5zZz3N7SUKBecypix1qu
N6VLBAsUpDni7JTSOevZwZwyPIDerlGVuA0mh8O0MNB3p+CbCpo=
=iYG0
-----END PGP SIGNATURE-----

--b2b5nMyhgyxyw4km--

