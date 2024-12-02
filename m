Return-Path: <linux-iio+bounces-12942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965109DFFB3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562D5280C84
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D91FCFDF;
	Mon,  2 Dec 2024 11:07:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910C1FCF78;
	Mon,  2 Dec 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137634; cv=none; b=SjnOLP07hSWvMX93npGk9KNmFT+7soKo8Q0yaZUQW7Sotaogsl+SJHuMHzKO09EAxTrLjJm5lThQ+8WIyxh6y6aLUON9wv+Ws8Pb7niHQh1dEPxZ2UUVtL4aa6oufY969rhKHhOo9p2jzmdbRoMQASWg0PdQftSWGmMnYAB/Lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137634; c=relaxed/simple;
	bh=gaLi0t3pOgvvRebFeqYHgal3DPCr2aNHTYP62H2tbaU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3/bN/TLE9nQexsDntTkysvVwQzddBEwzWQ/7OczrY8gG2Y9BI7X1OJyY5EwqtxQxUzK5Pt9iAItdIvMmtPH86Pnxrg6rFRuI2foam+xCXJGZ5YkW0RDPQuKcmyO6cMJ5GSckxQKF6Yu47zQY2qNBktfSYssboZQRpYzZ2G7hn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y218t3JpZz6K6XG;
	Mon,  2 Dec 2024 19:02:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 24E97140122;
	Mon,  2 Dec 2024 19:07:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Dec
 2024 12:07:02 +0100
Date: Mon, 2 Dec 2024 11:06:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Paul Kocialkowski <paulk@sys-base.io>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for the TI OPT4048 color
 sensor
Message-ID: <20241202110659.00000171@huawei.com>
In-Reply-To: <Z0yjTkXt0JhqdD15@collins>
References: <20241130174212.3298371-1-paulk@sys-base.io>
	<20241130174212.3298371-2-paulk@sys-base.io>
	<20241201115529.1375c6c3@jic23-huawei>
	<Z0yjTkXt0JhqdD15@collins>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 1 Dec 2024 18:56:30 +0100
Paul Kocialkowski <paulk@sys-base.io> wrote:

> Hi Jonathan,
>=20
> Le Sun 01 Dec 24, 11:55, Jonathan Cameron a =E9crit :
> > On Sat, 30 Nov 2024 18:42:12 +0100
> > Paul Kocialkowski <paulk@sys-base.io> wrote:
> >  =20
> > > The Texas Instruments OPT4048 is a XYZ tristimulus color sensor,
> > > with an additional wide (visible + IR) channel.
> > >=20
> > > This driver implements support for all channels, with configurable
> > > integration time and auto-gain. Both direct reading and
> > > triggered-buffer modes are supported.
> > >=20
> > > Note that the Y channel is also reported as a separate illuminance
> > > channel, for which a scale is provided (following the datasheet) to
> > > convert it to lux units. Falling and rising thresholds are supported
> > > for this channel.
> > >=20
> > > The device's interrupt can be used to sample all channels at the end
> > > of conversion and is optional.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io> =20
> > Hi Paul,
> >=20
> > Various comments inline. Most significant is that this seems to be
> > suitable for a simple dataready trigger that will make your various
> > interrupt and non interrupt flows more similar. =20
>=20
> And thanks for the fast review and insightful comments!
>=20
> I considered implementing a trigger in the driver, but the issue I found
> is that the trigger is expected to be called from hard irq context,
> while the new values are read in the bottom half.=20

The trigger can be called from either the hard irq context or from
a thread.  See iio_trigger_poll_nested()
There is a quirk that you then don't end up calling the registered
hard irq handler for the trigger so sometimes a bit of fiddly code
is needed to ensure timestamps etc are grabbed.  Not sure that matters
here.

> I understand the triggered
> buffer callbacks are executed as a thread as well, so there would be race
> between the two which could result in previous values being returned.

With the above nested call it is all run in the same thread
See handle_nested_irq() in particular the function docs.
https://elixir.bootlin.com/linux/v6.12.1/source/kernel/irq/chip.c#L459

> So I concluded that it was more beneficial to preserve the synchronous re=
ading
> mechanism over implementing the trigger.

Definite preference for a trigger approach, but I may well still be missing
a detail.

Jonathan

>=20
> But maybe I missed/misunderstood something here.
>=20
> > Jonathan
> >  =20
> > > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > > index 321010fc0b93..f2031e6236f9 100644
> > > --- a/drivers/iio/light/Makefile
> > > +++ b/drivers/iio/light/Makefile
> > > @@ -42,6 +42,7 @@ obj-$(CONFIG_MAX44009)		+=3D max44009.o
> > >  obj-$(CONFIG_NOA1305)		+=3D noa1305.o
> > >  obj-$(CONFIG_OPT3001)		+=3D opt3001.o
> > >  obj-$(CONFIG_OPT4001)		+=3D opt4001.o
> > > +obj-$(CONFIG_OPT4048)		+=3D opt4048.o
> > >  obj-$(CONFIG_PA12203001)	+=3D pa12203001.o
> > >  obj-$(CONFIG_ROHM_BU27008)	+=3D rohm-bu27008.o
> > >  obj-$(CONFIG_ROHM_BU27034)	+=3D rohm-bu27034.o
> > > diff --git a/drivers/iio/light/opt4048.c b/drivers/iio/light/opt4048.c
> > > new file mode 100644
> > > index 000000000000..1ad5e6586aad
> > > --- /dev/null
> > > +++ b/drivers/iio/light/opt4048.c
> > > @@ -0,0 +1,1145 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright 2024 Paul Kocialkowski <paulk@sys-base.io>
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/iio/events.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > > +#include <linux/log2.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#define OPT4048_CH0_DATA0			0x0
> > > +#define OPT4048_CH0_DATA1			0x1
> > > +#define OPT4048_CH1_DATA0			0x2
> > > +#define OPT4048_CH1_DATA1			0x3
> > > +#define OPT4048_CH2_DATA0			0x4
> > > +#define OPT4048_CH2_DATA1			0x5
> > > +#define OPT4048_CH3_DATA0			0x6
> > > +#define OPT4048_CH3_DATA1			0x7
> > > +
> > > +#define OPT4048_CH_DATA0_MSB_VALUE(v)		((v) & GENMASK(11, 0))
> > > +#define OPT4048_CH_DATA0_EXPONENT_VALUE(v)	(((v) & GENMASK(15, 12)) =
>> 12) =20
> >=20
> > For all these - just define the masks and use FIELD_GET() / FIELD_PREP()
> > inline.  Masks should be defined with names that make it clear what the=
y are
> > masking and in what registers. =20
>=20
> I see. Note that I generally tried to follow the datasheet's terminology =
for
> convenience.

Understood, but you can stay near to that with well named masks etc
and generally it remains pretty readable and compact.


>=20
> > > +};
> > > +
> > > +struct opt4048_sensor {
> > > +	struct device *dev;
> > > +	struct i2c_client *i2c_client;
> > > +	struct iio_dev *iio_dev;
> > > +
> > > +	struct regulator *vdd_supply;
> > > +
> > > +	struct opt4048_sensor_state state; =20
> >  =20
> > > +	struct opt4048_sensor_scan scan; =20
> >=20
> > As below. I think you should just always do the read in the trigger han=
dler. =20
>=20
> As far as I could see the hardware doesn't guarantee that values come from
> the same read sequence (even if read as a single i2c transaction). This i=
s why
> my approach was to read them as early as possible after the irq is signal=
ed
> and cache them here, instead of doing the actual read in the trigger hand=
ler
> or sysfs read callback (which may have both values from the previous and =
next
> reads).

As above, if you do it via handle_nested_irq, it ends up being very nearly =
the
same time as you have it here (a few calls later).

>=20
> The only thing the hardware guarantees is that the DATA1 value is latched=
 when
> DATA0 is read.
Ah good. So no tearing at least.

Does it actually matter if you get reads from neighbouring samples?  Light =
sensors
tend not to be measuring anything particularly dynamic.  I doubt you'll hav=
e problems
anyway, but if you do I'm not sure I see it as mattering.

>=20
> > > +	bool scan_sync; =20
> >=20
> > This needs a comment.  Interrupts and sync aren't something that normal=
ly goes
> > together so the name is somewhat confusing. =20
>=20
> Okay. The idea is to have a synchronous read where all channels are read =
as
> soon as conversion done is signaled.

That's not synchronous though, as they are done on an async interrupt.
So maybe thing of a different term.

> > > +
> > > +	/* Report illuminance using Y intensity value. */ =20
> >=20
> > That seems 'interesting'.  Why? =20
>=20
> The Y channel is defined by CIE1931 to match the (photopic) illuminance r=
esponse
> curve. The main difference is that Y is unit-less while illuminance is de=
fined
> in lux. This specific channel gets an extra scale property to report the
> conversion coefficient for lux.

Ah I had it in my head that the curves were similar but not the same.
Fair enough.=20

>=20
> However we still need the Y value to be reported as such in order to be r=
elated
> to X and Z.
>=20
> > > +	scan->channels[4] =3D scan->channels[1];
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int opt4048_identify(struct opt4048_sensor *sensor)
> > > +{
> > > +	struct device *dev =3D sensor->dev;
> > > +	int ret;
> > > +	u16 id, low, high;
> > > +
> > > +	ret =3D pm_runtime_resume_and_get(dev);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret =3D i2c_smbus_read_word_swapped(sensor->i2c_client, OPT4048_DID=
);
> > > +	if (ret < 0)
> > > +		goto complete;
> > > +
> > > +	low =3D (u16)OPT4048_DID_L_VALUE(ret);
> > > +	high =3D (u16)OPT4048_DID_H_VALUE(ret);
> > > +
> > > +	id =3D OPT4048_DID_VALUE(low, high);
> > > +
> > > +	switch (id) {
> > > +	case OPT4048_DID_OPT4048:
> > > +		dev_info(dev, "identified OPT4048 sensor\n"); =20
> > This isn't useful information and can be easily established once the
> > driver has loaded.  So dev_dbg() at most. =20
>=20
> Honestly I see a bunch of driver doing that (especially camera sensors)
> and find it generally useful. But I don't mind getting rid of it.
I try to squash them.  Spend too long staring at enormously long kernel
boot logs :)  I'm fine if it provides extra info though. Some devices have
serial numbers or firmware version numbers etc.

>=20
> > > +		ret =3D 0;
> > > +		break;
> > > +	default:
> > > +		dev_err(dev, "unknown sensor with id: %#x\n", id);
> > > +		ret =3D -ENODEV; =20
> > We shouldn't treat a failure to match the ID as a reason to fail probe.
> > Consider the use of fallback IDs in device tree with older kernels.
> > If a new device comes along that is backwards compatible, we want that
> > to work with out driver modifications. =20
>=20
> Honestly this is really just a way to check that i2c transaction are work=
ing,
> that the device is actually there and to report when it's not.
>=20
> I'm not sure it's such a good idea to assume that other IDs would not be
> a sign that something very wrong is going on (typically some other device
> connected on the same i2c address). Failing to probe will prevent
> misconfiguring another device.
>=20
> Just adding another case here if a new device is ever introduced doesn't
> sound like such a big drawback in comparison.

I used to agree with you, but view of DT maintainers if that if you have a =
broken
board or device or a wrong firmware then it isn't the bindings or Linux's p=
roblem
to solve.  Given we have a 'lot' of fallback compatibles now I'm now pretty
convinced on this.

An info message should be enough to show something is odd and give the brea=
dcrumbs
needed to debug.


>=20
> > It's fine to print an dev_info message though so the user is aware
> > that we are ignoring the missmatch.
> >  =20
> > > +		break;
> > > +	}
> > > +
> > > +complete:
> > > +	pm_runtime_put_sync(dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int opt4048_power(struct opt4048_sensor *sensor, bool on)
> > > +{
> > > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&sensor->lock); =20
> > guard() =20
> > > +
> > > +	state->active =3D on;
> > > +	ret =3D opt4048_state_configure_cfg0(sensor);
> > > +
> > > +	mutex_unlock(&sensor->lock);
> > > +
> > > +	return ret;
> > > +} =20
> >  =20
> > > +static int opt4048_state_configure_cfg1(struct opt4048_sensor *senso=
r)
> > > +{
> > > +	u16 value;
> > > +	int ret; =20
> > I don't really see any advantage in these wrappers.   I'd just have
> > the code inline in  opt4048_state_configure()  =20
>=20
> Well I do think they are important to make the code more digest.

As someone who digested it. They don't make it easier. They just
make me scroll backwards and forwards a lot whilst reviewing.

>=20
> > > +
> > > +	/* Assign threshold to the Y channel for illuminance. */
> > > +	value =3D OPT4048_CFG1_I2C_BURST |
> > > +		OPT4048_CFG1_INT_DIR_OUT |
> > > +		OPT4048_CFG1_THRESHOLD_CH_SEL(1) |
> > > +		OPT4048_CFG1_RESERVED; =20
> >=20
> > combine these on fewer lines.  Just generally stay below 80 chars unless
> > there is a strong readability reason to go longer. =20
>=20
> I find it a lot more readable with one item per line.

Hmm. In this particular case I don't mind that much.=20
It is common for these to be come stupidly long for no real readability
advantage.

>=20
> > > +
> > > +	if (sensor->scan_sync)
> > > +		value |=3D OPT4048_CFG1_INT_CFG_DATA_READY_ALL;
> > > +	else
> > > +		value |=3D OPT4048_CFG1_INT_CFG_ALERT;
> > > +
> > > +	ret =3D i2c_smbus_write_word_swapped(sensor->i2c_client, OPT4048_CF=
G1,
> > > +					   value);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return 0;
> > > +} =20

> > > +static int opt4048_iio_read_raw(struct iio_dev *iio_dev,
> > > +				struct iio_chan_spec const *channel,
> > > +				int *value_first, int *value_second, long mask)
> > > +{
> > > +	struct opt4048_sensor *sensor =3D iio_priv(iio_dev);
> > > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > > +	struct device *dev =3D sensor->dev;
> > > +	int ret;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_RAW: =20
> > Need define scope {}
> >  =20
> > > +		unsigned int scan_index;
> > > +
> > > +		ret =3D iio_device_claim_direct_mode(iio_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret =3D pm_runtime_resume_and_get(dev);
> > > +		if (ret < 0)
> > > +			goto release_direct_mode;
> > > +
> > > +		if (sensor->scan_sync) { =20
> >=20
> > So this is curious. You just power up sensor and let it run until inter=
rupt.
> > I'd expect to have interrupt disabled unless buffered capture is in use.
> > It would be fine to turn it on for a single cycle though if that makes =
capturing
> > on demand simpler. =20
>=20
> So that reflects the fact that getting synchronous readings from the sens=
or
> does require reading the channels "soon after" the interrupt.

For the direct read it is fine to grab them in the interrupt.  Just run
it with direct mode claimed an a check in your interrupt handler on whether
the buffer is enabled.  iio_device_claim_direct_mode() will prevent any
transitions happening into buffered mode concurrent with this single shot
read. =20

>=20


> > > +static int opt4048_iio_write_event_value(struct iio_dev *iio_dev,
> > > +					 struct iio_chan_spec const *channel,
> > > +					 enum iio_event_type type,
> > > +					 enum iio_event_direction direction,
> > > +					 enum iio_event_info info,
> > > +					 int value_first, int value_second)
> > > +{
> > > +	struct opt4048_sensor *sensor =3D iio_priv(iio_dev);
> > > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > > +	u32 value;
> > > +	int ret;
> > > +
> > > +	switch (direction) {
> > > +	case IIO_EV_DIR_RISING:
> > > +		value =3D (u32)value_first;
> > > +		opt4048_threshold_convert(value, state->threshold_high);
> > > +		break;
> > > +
> > > +	case IIO_EV_DIR_FALLING:
> > > +		value =3D (u32)value_first;
> > > +		opt4048_threshold_convert(value, state->threshold_low);
> > > +		break;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (pm_runtime_suspended(sensor->dev))
> > > +		return 0; =20
> > I'm curious. Why isn't this an error return?  Check for other cases of =
this.
> > I think they should all return an error so userspace knows something un=
expected
> > is going on. =20
>=20
> I'd expect userspace to be able to configure the threshold without anythi=
ng
> reading values at that moment. The point is to keep the sensor off.

Ah. I misread this. How is the race prevented with it being enabled
at this point?
=20
>=20
> > > +
> > > +	ret =3D opt4048_state_configure_threshold(sensor);
> > > +	if (ret)
> > > +		return ret; =20
> >=20
> > 	return opt...
> >  =20
> > > +
> > > +	return 0;
> > > +} =20

> > > +
> > > +	switch (direction) {
> > > +	case IIO_EV_DIR_RISING:
> > > +		state->threshold_high_active =3D !!active; =20
> >=20
> > This is why the signature became bool. All drivers had the same handling
> > which made no sense :(
> >=20
> > FWIW you don't need the !! even before that change. =20
>=20
> Yeah bool isn't really a thing in C but it just feels more consistent.
> It would be necessary if I had defined threshold_high_active as a single-=
bit
> field though.
Don't do that.  Looses the clear meaning as a true / false field.
In kernel c bool is well defined (and in more recent C specs).

>=20
> >=20
> >  =20
> > > +		break;
> > > +
> > > +	case IIO_EV_DIR_FALLING:
> > > +		state->threshold_low_active =3D !!active;
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL; =20
> > When using guard. Can just return -EINVAL; =20
> > > +		goto complete;
> > > +	}
> > > +
> > > +	if (pm_runtime_suspended(sensor->dev))
> > > +		goto complete; =20
> > As above - direct return.
> > Though fun question of what you should do if this does fail as
> > we are then in a weird unknown state.
> > why not an error return? =20
>=20
> It's really not an error if it fails and the state handling is written to=
 allow
> configuring it with the device off. It just updates the states without re=
aching
> the device and the state gets applied at the next resume.

I'd misread the code.  Feels like there is a race here however.=20

>=20
> > > +
> > > +	ret =3D opt4048_state_configure_threshold(sensor); =20
> > Will become
> > 	return opt4048_* =20
> > > +
> > > +complete:
> > > +	mutex_unlock(&sensor->lock);
> > > +
> > > +	return ret;
> > > +} =20
> > }; =20
> > > +
> > > +static irqreturn_t opt4048_iio_buffer_trigger(int irq, void *data)
> > > +{
> > > +	struct iio_poll_func *poll_func =3D data;
> > > +	struct iio_dev *iio_dev =3D poll_func->indio_dev;
> > > +	struct opt4048_sensor *sensor =3D iio_priv(iio_dev);
> > > +	struct opt4048_sensor_scan scan =3D { 0 };
> > > +	s64 timestamp;
> > > +	unsigned int index =3D 0;
> > > +	unsigned int i;
> > > +	int ret;
> > > +
> > > +	/* Capture timestamp just before reading values. */
> > > +	timestamp =3D iio_get_time_ns(iio_dev);
> > > +
> > > +	mutex_lock(&sensor->lock);
> > > +
> > > +	if (!sensor->scan_sync) {
> > > +		ret =3D opt4048_data_scan(sensor, &sensor->scan); =20
> > So you have a weird hybrid of capture in the data ready interrupt and h=
ere. =20
>=20
> The point is to allow both interrupt-based and interrupt-less operation h=
ere.
>=20
> > Why not just kick this off by having a data ready trigger and
> > using iio_trigger_poll() to effectively call this on the data ready
> > interrupt or on an other trigger.  That way should need no special hand=
ling
> > for your sync scan. =20
>=20
> See the comment above, maybe I missed something though.

I think you do need a path for an early read, but that doesn't stop you
doing simple triggered capture in the trigger handler (allowing multiple ty=
pes
of trigger).  Just need to fix the mode so we don't enter buffered mode (se=
e above
stuff on claiming direct mode) then check for whether the buffer is enabled
here.  Grab a copy it if it isn't.=20

>=20
> >=20
> >  =20
> > > +		if (ret)
> > > +			goto complete;
> > > +	}
> > > +
> > > +static const struct iio_buffer_setup_ops opt4048_iio_buffer_setup_op=
s =3D {
> > > +	.preenable =3D opt4048_iio_buffer_preenable,
> > > +	.postdisable =3D opt4048_iio_buffer_postdisable,
> > > +};
> > > +
> > > +static int opt4048_iio_setup(struct opt4048_sensor *sensor) =20
> > This function doesn't add much. I'd just put the code inline in prbe. =
=20
>=20
> I just like splitting framework-specific init, it makes things more reada=
ble.
I'm not convinced.  I wouldn't mind you doing some sub steps such
as buffer setup, trigger setup etc.

Maybe it's because it is the ordering in that code that goes wrong most
often + I'd rather all the stuff was grouped by functionality, not by
subsystem.  So register trigger than get interrupt etc.  Similar with buffe=
r.
Then finally see that the exposure of sysfs controls is done in
probe()

>=20
> > > +{
> > > +	struct iio_chan_spec *channels;
> > > +	struct iio_dev *iio_dev =3D sensor->iio_dev; =20
> > Just pass it the iio_dev in. =20
>=20
> My taste is rather to have a device-wide structure that is used in all
> functions that are not callbacks from the framework/bus/device.

We have had a lot of broken code via sensor->iio_dev type
code in the past. I'm not going down that route again so=20
no to having a sensor->iio_dev.

Structures should have clean nesting. It can be done either way
around - but it's a case of pick one and stick to it.

1. Subsystem structure inside the device specific one.
2. Device specific one inside the subsystem one.

IIO does 2.  So I don't want to see mixing and matching the two
models.


>=20
> > > +	struct device *dev =3D sensor->dev;
> > > +	unsigned int channels_count;
> > > +	int ret;
> > > +
> > > +	channels_count =3D ARRAY_SIZE(opt4048_iio_channels);
> > > +
> > > +	if (sensor->i2c_client->irq > 0) {
> > > +		channels =3D devm_kzalloc(dev, sizeof(opt4048_iio_channels),
> > > +					GFP_KERNEL); =20
> >=20
> > kmemdup.  However I'd rather just see this picking between two static
> > const arrays of channels.  There are only two cases so it isn't worth d=
ynamic
> > channel setup complexity. =20
>=20
> Well they would be 99 % identical. I don't really see how this would be a
> beneficial duplication versus the low complexity of these few lines.

Generally static const data ends up cleaner in the long run, but sure
we can refactor when it becomes more complex.

A lot of drivers become very very complex in this regard and we end
up ripping out code like this a lot in favor of const data.



> > Comment doesn't add anything that isn't obvious from the code.
> > So don't have it. =20
>=20
> These are meant as categories to make it clear what the following code is
> related to.

Sure.  They seem like a good idea when people write new drivers and then we
have to go repair them when they break.  They do that far too often.
Hence, preference to not have them in the first place.
Don't need a comment about irq to tell a function that is well named
like this one is about irqs!

>=20
> > > +
> > > +static irqreturn_t opt4048_irq(int irq, void *data)
> > > +{
> > > +	struct opt4048_sensor *sensor =3D data;
> > > +	struct opt4048_sensor_state *state =3D &sensor->state;
> > > +	struct iio_dev *iio_dev =3D sensor->iio_dev; =20
> >=20
> > Set data =3D iio_dev and then use iio_priv() on that.
> > There shouldn't be a need to go back the other way. =20
>=20
> Not really my taste, sorry.

See above.  Very strong preference for not mixing and matching
styles. =20




> > > +
> > > +	state->status =3D status; =20
> > Add a comment on why you are saving this (I guess because the device
> > interrupts every time otherwise).  Does it interrupt on the reverse
> > direction?  If not how is this cleared? =20
>=20
> Ah I thought it was clear from the fact that we use it in the statements =
above
> to find out if we just crossed a threshold.
>=20
> The device reports "value above/below threshold" at every reading and not
> "threshold crossed" so I need to compare with previous state to derive
> rising/falling.

Ok.  So it interrupts every time out of the window. That's horrible.
Maybe add a comment on that. I was kind of assuming it didn't interrupt aga=
in,
just that the status bits were set.



> > > +
> > > +static int opt4048_suspend(struct device *dev)
> > > +{
> > > +	struct opt4048_sensor *sensor =3D dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret =3D opt4048_power(sensor, 0);
> > > +	if (ret)
> > > +		goto error;
> > > +
> > > +	ret =3D regulator_disable(sensor->vdd_supply);
> > > +	if (ret)
> > > +		goto error;
> > > +
> > > +	return 0;
> > > +
> > > +error:
> > > +	return -EAGAIN; =20
> > Direct returns preferred over both eating the error codes and
> > a goto like this. =20
>=20
> Hehe the suspend callback doesn't work that way. If you *ever* return som=
ething
> else than -EAGAIN, it will never attempt to resume the device again. This=
 is
> documented in the runtime pm semantics.
>=20
> So it is very crucial to eat the error code and return -EAGAIN if we want=
 to
> have a chance at it again. Many drivers get this wrong.

There is an argument that if you fail in any of the above calls the state
is completely unknown and the right thing to do is never resume.  It's
a case of cross your fingers and hope.

>=20
> > > +}
> > > +
> > > +static int opt4048_resume(struct device *dev)
> > > +{
> > > +	struct opt4048_sensor *sensor =3D dev_get_drvdata(dev);
> > > +	unsigned long sleep_min;
> > > +	unsigned int index;
> > > +	int ret;
> > > +
> > > +	ret =3D regulator_enable(sensor->vdd_supply);
> > > +	if (ret)
> > > +		goto error;
> > > +
> > > +	/* Wait for the regulator to settle and the chip to power-on. */
> > > +	udelay(30);
> > > +
> > > +	ret =3D opt4048_state_configure(sensor);
> > > +	if (ret)
> > > +		goto error_regulator;
> > > +
> > > +	ret =3D opt4048_power(sensor, 1);
> > > +	if (ret)
> > > +		goto error_regulator;
> > > +
> > > +	/* Wait for conversion to be ready for all channels. */ =20
> > We might not have powered up for that reason but I guess this does
> > little harm. =20
>=20
> By design this driver only powers up the device for readings. Everything =
else
> is kept staging in the state structure.

I'd misread some of the earlier code. Thanks for the clarification.

>=20
> > > +	index =3D 2 * sensor->state.conversion_time_index + 1;
> > > +	sleep_min =3D opt4048_conversion_time_available[index] * 4;
> > > +
> > > +	usleep_range(sleep_min, 5 * sleep_min / 4); =20
> >=20
> > Perhaps use fsleep() to avoid anyone needing to reason about the margins
> > etc.
> >  =20
> > > +
> > > +	return 0;
> > > +
> > > +error_regulator:
> > > +	regulator_disable(sensor->vdd_supply);
> > > +
> > > +error: =20
> > Direct returns make for easier to review code as following an error
> > path doesn't require checking to see what the cleanup is. =20
>=20
> I prefer it over duplication.

Hmm. We disagree on this.  What I see is code where I have to go
check the error handler on paths where it is completely pointless as
it's not doing anything and I could have just seen the return at
the goto.

>=20
> > > +	return -EAGAIN;
> > > +}
> > > +
> > > +static const struct dev_pm_ops opt4048_pm_ops =3D {
> > > +	.runtime_suspend	=3D opt4048_suspend,
> > > +	.runtime_resume		=3D opt4048_resume,
> > > +};
> > > +
> > > +/* I2C */ =20
> > Not a particularly useful comment. I'd drop it. =20
> > > +
> > > +static int opt4048_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev =3D &client->dev;
> > > +	struct opt4048_sensor *sensor;
> > > +	struct iio_dev *iio_dev;
> > > +	int irq =3D client->irq;
> > > +	int ret;
> > > +
> > > +	iio_dev =3D devm_iio_device_alloc(dev, sizeof(*sensor));
> > > +	if (!iio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	sensor =3D iio_priv(iio_dev);
> > > +
> > > +	sensor->dev =3D dev;
> > > +	sensor->i2c_client =3D client;
> > > +	sensor->iio_dev =3D iio_dev; =20
> > That is almost always a sign that you have a less than ideal layering
> > in the driver. =20
>=20
> I disagree, my preference is to have a top-level device-specific structur=
es
> that holds everything else and is used in all local functions. It find it
> a lot more convenient and readable.

See above.  Whilst we are going to disagree on this, I'm going to hold firm
because I do not want other driver authors copying this pattern. It makes
my job as a reviewer harder because there are two ways to do things when
there should only be one.

>=20
> > > +
> > > +	i2c_set_clientdata(client, sensor);
> > > +
> > > +	mutex_init(&sensor->lock); =20
> > 	ret =3D devm_mutex_init()
> > 	if (ret)
> > 		return ret; =20
> > > +
> > > +	sensor->vdd_supply =3D devm_regulator_get(dev, "vdd"); =20
> >=20
> > Given runtime PM may not even be enabled, you should turn the power on.
> > Unconditionally. =20
>=20
> The driver definitely depends on runtime PM being enabled (and I think it=
's
> a good thing to keep the device off when it's not used).

Generally a driver should depend on runtime_pm.   What in here makes
that necessary (rather than a good idea for power saving!)?

If it does depend on it, then require it via kconfig depends.
But be prepared for push back on that as it shouldn't be necessary.


Jonathan



