Return-Path: <linux-iio+bounces-20450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E46AAD5B4C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 17:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 741CE7AAE9B
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7351DF270;
	Wed, 11 Jun 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVayobUV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B101A8F82;
	Wed, 11 Jun 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657588; cv=none; b=G7HceuA6XXg5UJZGyFwrcn5euhqpHzI3ERd106F0WQMpqK9jzrCkRbQIeuy+VHEUIE6IWrA8dIyFrUgXK4Dz+zuRqYmRDotKOqqgKyEa5huFZT31fBDC6+c8p6thN+ZT08bC/uzfZgxZqrjZMB8HlJo0fhUev5UJbFZsMTBfnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657588; c=relaxed/simple;
	bh=89BiTjHBE1lw2kMhVAJalnI8x+UkGxbeH28FkW7pcDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXwn4X0qz0E8aWhn0etX5nw6PnYZNXu8meprgD47tlUULZKk7X4oNqFhf+PTWge49xlMPmIzXN4C7qv4j4IbOoA/edAuUNE9TcKOxmyTPeCsfIqEZvQ2SrDBJ0dErijnOce3BQZqe2FpK3zpiDMiQptooBSnnD6f8KyZWw9xSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVayobUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF130C4CEEA;
	Wed, 11 Jun 2025 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749657587;
	bh=89BiTjHBE1lw2kMhVAJalnI8x+UkGxbeH28FkW7pcDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SVayobUVp3aRvF48EyWbLwH90CUS9XtWd6DT2NJPPfkvZi4/Ej9I43IKWun+HFcb0
	 nRHltTxYcB6Qxfz61p7XckqnhXfyontfKCIS5mkY8AoLiPX9THBWd1JBhCK+fT8MMZ
	 So91hBGYyqiJywryQwG23FzmWNoX+YFgmL1mzQ7o/Uj2TBCTh/j6xbjgGMzlK0GZHk
	 A/Xeguy7nCljEZwEx+wlIvaq16xUqMQwqlEZ+QCyIFqLhc5aIQPHpgiZoakb9odsVT
	 Z17Jukibctyn3iQJwUA2pW9TNYzuf0Va0YRhuRWZZLuWmO01nmPzeI7I/mhiR65gV+
	 rCk7FwINZM5TQ==
Date: Wed, 11 Jun 2025 16:59:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marius.Cristea@microchip.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 broonie@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC194X
Message-ID: <20250611165939.45bb50ad@jic23-huawei>
In-Reply-To: <3d95641d-c1c2-44bc-8478-c60734bcf420@baylibre.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
	<20250606093929.100118-3-marius.cristea@microchip.com>
	<1c7946f1-d712-4baa-8243-be6a55eec528@baylibre.com>
	<1b8b10816d1f2f34724e77c68de869422d6c84b6.camel@microchip.com>
	<3d95641d-c1c2-44bc-8478-c60734bcf420@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Jun 2025 11:11:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/10/25 10:07 AM, Marius.Cristea@microchip.com wrote:
> > On Fri, 2025-06-06 at 12:02 -0500, David Lechner wrote: =20
>=20
> ...
>=20
> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> >>> b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> >>> new file mode 100644
> >>> index 000000000000..ae88eac354a4
> >>> --- /dev/null
> >>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
> >>> @@ -0,0 +1,17 @@
> >>> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >>> /sys/bus/iio/devices/iio:deviceX/slow_alert1_cfg
> >>> +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.16
> >>> +Contact:=C2=A0=C2=A0=C2=A0=C2=A0 linux-iio@vger.kernel.org
> >>> +Description:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 A read/write property used to route, inside the PAC
> >>> device, a specific ALERT
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 signal to the SLOW/ALERT1 pin. The SLOW/ALERT1 pin
> >>> must be configured for the
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ALERT function in order to control the device
> >>> hardware pin (this is the default
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 functionality of the device hardware pin).
> >>> +
> >>> +What:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> >>> /sys/bus/iio/devices/iio:deviceX/gpio_alert2_cfg
> >>> +KernelVersion:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.16
> >>> +Contact:=C2=A0=C2=A0=C2=A0=C2=A0 linux-iio@vger.kernel.org
> >>> +Description:
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 A read/write property used to route, inside the PAC
> >>> device, a specific ALERT
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 signal to the GPIO/ALERT2 hardware pin. The
> >>> GPIO/ALERT2 pin must be configured
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 for ALERT function in order to control the device
> >>> hardware pin (this is the
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 default functionality of the device hardware pin). =20
> >>
> >>
> >> What is the use case for needing these? In otherwords, why can't the
> >> driver just
> >> make best use of available resources as it sees fit?
> >> =20
> >=20
> > Here inside the PAC the user could choose what limit to be routeed
> > outside the chip. For sure, all of the limits could be routed to the
> > same hardware pin, but there are some use cases where the user will
> > want to connect that output pin to a safety hardware (e.g. over-current
> > protection or over-voltage and over-current) and in this case we need a
> > way to allow the user to do the setup.
> >  =20
>=20
> This sounds like it depends on what is wired to the alert pin, so sounds
> like something that should be specified in the devicetree.

Absolutely agree.

These corners tend to be tricky to handle cleanly
in either DT or userspace interfaces though and sometimes we've
just decided not to be fully flexible to keep that sane.

>=20
> I.e. in the devicetree, have a bool property microchip,alert1-is-safety
> to indicate the ALERT1 pin is wired to the safety hardware. (It could
> still be also wired as an interrupt input at the same time - or not,
> doesn't really matter.)
>=20
> Then, on the event attributes add a boolean "safety" attribute to allow
> routing the signal to either the pin that was flagged as the safety pin
> or not. This would allow the user to chose which signals control the
> safety hardware at runtime without them having to know how the hardware
> is actually wired up.

I'd question if the use cases are such that it makes sense to expose the
option to user space. Generally if you have a way to trigger a safety circu=
it
it's there for a reason and you want it always on for that reason (i.e.
you might tweak exactly when a cut off on power usage fires, but you always
do it on power usage).

We probably want to propose a binding to he DT folk + take a look at
what the ABI David suggests looks like in the driver. That's
messy if it isn't double wired to the interrupt controller though as
we then have events that never fire.


> >>
> >> ...
> >> =20
> >>> +static IIO_DEVICE_ATTR(in_current1_shunt_resistor, 0644,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pac1944_shunt_value_show,
> >>> pac1944_shunt_value_store, 0);
> >>> +static IIO_DEVICE_ATTR(in_current2_shunt_resistor, 0644,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pac1944_shunt_value_show,
> >>> pac1944_shunt_value_store, 1);
> >>> +static IIO_DEVICE_ATTR(in_current3_shunt_resistor, 0644,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pac1944_shunt_value_show,
> >>> pac1944_shunt_value_store, 2);
> >>> +static IIO_DEVICE_ATTR(in_current4_shunt_resistor, 0644,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pac1944_shunt_value_show,
> >>> pac1944_shunt_value_store, 3); =20
> >>
> >> These are specified in the devicetree. Why are there also sysfs
> >> attribtes? =20
> >=20
> > Yes, you could put a generic shunt resistor into the device tree but
> > this resistor will have a tolerance. Because the end user could
> > calibrate the system, it could also save the calculated/calibrated
> > shunt resistor somewhere and restore that calibrated value each time
> > the driver is loaded.
> >  =20
>=20
> If changing the resistor value changes the measured raw value, we
> could probably use one of the existing standard calibration attributes
> instead, like calibbias or calibscale.

We have precedence for shunt resistor ABI for this reason, so I agree with
David if we were starting from scratch (and it's a viable option to
use the calibration attributes) but we can't drop the existing ABI
and it does limited harm to carry on using it.

>=20
> >  =20
> >>
> >> =20
> >>> +/* Available Sample Modes */
> >>> +static const char * const pac1944_frequency_avail[] =3D {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "1024_ADAP",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "256_ADAP",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "64_ADAP",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "8_ADAP",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "1024",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "256",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "64",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "8",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "single_shot_1x",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "single_shot_8x",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "fast",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 "burst",
> >>> +}; =20
> >> =20
> >>> =20
> > ... =20
> >>> +
> >>> +static const struct iio_chan_spec_ext_info pac1944_ext_info[] =3D {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 IIO_ENUM("sampling_frequency", IIO_SHARED_B=
Y_ALL,
> >>> &sampling_mode_enum),
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .name =3D "sampling_frequency_available",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .shared =3D IIO_SHARED_BY_ALL,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .read =3D iio_enum_available_read,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .private =3D (uintptr_t)&sampling_mode_enum,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 },
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0 { }
> >>> +}; =20
> >>
> >> sampling_frequency{_avialable} are already standard attributes in IIO
> >> and is
> >> defined to be a number in Hz. So we will need to find a way to make
> >> this
> >> work with the standard attribute (can use IIO_CHAN_INFO_SAMPLE_FREQ,
> >> by the way).
> >> And figure out how the other parts fit into other existing IIO
> >> features. =20
> >=20
> > I can change to the standard attributes but I still have some question
> > related to how to handle the ADAPTIVE sampling frequency that the chip
> > supports and that it could be used to lower the power consumption of
> > the chip.

Gah.  Second device to do something like this that we've seen this month.
(ADXL313 does something similar when enough activity detection modes are
turned on).  We don't have a good answer yet :(

> >  =20
> >> =20
>=20
> From a quick look at one of the datasheets, it sounds like this
> "adaptive" mode only applies when using an accumulator. And it doesn't
> actually change the sample rate, but rather other factors, like scale
> and the accumulator counter incitement. So it seems like it would be
> a separate custom boolean attribute.

Generally when I see this sort of thing my first instinct is hide it.
What use is it for userspace to see that the frequency is changing?
Maybe we just report the highest (or lowest?) frequency that might
be going on?  Here it doesn't seem to be coupled to anything else
though (unlikely the accelerometer) so I'm not sure how the driver
would guess it makes sense to enable it?

>=20
> Also, I noticed that the fast mode and burst mode make the sampling
> frequency dependent on the number of enabled channels. So to handle
> this, normally, that would mean that IIO_CHAN_INFO_SAMP_FREQ would
> need to be IIO_SEPARATE rather than IIO_SHARED_BY_ALL.
>=20
> But since these chips support can work both ways (there are modes
> where sample rate doesn't depend on the number of channels enabled
> and there are modes where it does), I'm not sure what the right way
> to handle that would be here. Maybe Jonathan will have some suggestion?

Oh goody a new way to stretch that already much stretched interface.
It's actually more fun because it's not the sum of the number of channels
for fast mode but 1 more than that.

Given we can't do both ways of reporting it at the same time we will
probably have to just do IIO_SHARED_BY_ALL.  We can only then report
the effective sampling frequency as it is fixed in these modes (so
we can't attempt to match a userspace request by cranking it down
if there are fewer channels enabled or similar).

So we need
sampling_frequency_available where the fastest frequency presented
changes depending on the enabled channels.  Lower values match
the 8/64/256/1024 values however many are enabled.

if sampling_frequency =3D=3D top value then we just change it if more
channels are enabled.  ABI always allows for other attributes to
change 'randomly' when you touch a different one.  That flexibility
is a pain for users but necessary for cases like this :(

I'm not sure how we pick between burst and fast mode though
as seems to be about auto offset stuff.

Jonathan


