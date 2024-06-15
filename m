Return-Path: <linux-iio+bounces-6311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AC7909990
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 20:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0C71F2176F
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881250A63;
	Sat, 15 Jun 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB4UeNqH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178D49626;
	Sat, 15 Jun 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718475838; cv=none; b=EFMLl0ZFDeg+ensHuSwLWIFA9lacCMXI/JlYLLgeyst6He13XY3J/duEBvwEpul2GlNmTc0whQyaqhqtRJRJt8cS7TY4zSTxR3T+Gv32OhNvpaLgQJBgwtW3S1x90QYExUehnNJQRX5mR9mHAG7VEtHwQNqHs55pzT+5pSQYkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718475838; c=relaxed/simple;
	bh=8L7WZRWFBbTxgfJWpOu50eGPhEZ1YsqYOd+XvpOAOyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUDZhWMPsqk4Ax5zqTYiigjXVRxT5TFm4xGkTy0r2jtRlM9G5OuM6uGHWaPuvSh4an66BJv6MEfBKefvwMyOpCx/j1589LzZtwawON3xl/TB2AqV+eA6RvM1j/k6isrPWF0lQNWBGO02+k+Q/gmgJ5WjT3qg7HgvJFg9J/s2gDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB4UeNqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9273EC4AF1C;
	Sat, 15 Jun 2024 18:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718475837;
	bh=8L7WZRWFBbTxgfJWpOu50eGPhEZ1YsqYOd+XvpOAOyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vB4UeNqHgjBq8CMKfjjETS/Rk3oNajyyhlSK3S8QurxkvlNgLKcLKc0649pYvKnBn
	 pryXKGkQO4omPo0NMyv5QdxgT6zzGWKBrf9zy16E8mjszxGYlUbyASSHWuUOGZpXsp
	 AF/8ZnD0mVRWSd2Kd9pFy/Puml5EnJUmIFHrd9hN057vj/UfAnWb1926T+2PFvEdrR
	 XcrU362KaA1LgzFkZGiAneXhI00C09mdPpVui7XY+yWGFCS79ON17UtpVxCM0AhlkR
	 eTv8Wicmr2MZDcADUJx2GHrhdk4FofkhTdGHzJmiu0n61odd5OSpo7TAmyeSHUbYXA
	 ePYcj6Rh8QQsg==
Date: Sat, 15 Jun 2024 19:23:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, lars@metafoo.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, ivan.orlov0322@gmail.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, "Haikola, Heikki"
 <Heikki.Haikola@fi.rohmeurope.com>, "Mutanen, Mikko"
 <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240615192348.182eb1b8@jic23-huawei>
In-Reply-To: <c9c0d585-617d-4181-afa2-c5743848f5c9@gmail.com>
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
	<20240606162948.83903-2-muditsharma.info@gmail.com>
	<20240608172227.17996c75@jic23-huawei>
	<CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
	<20240611181407.00003f61@Huawei.com>
	<c9c0d585-617d-4181-afa2-c5743848f5c9@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 09:07:01 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 6/11/24 20:14, Jonathan Cameron wrote:
> > On Mon, 10 Jun 2024 08:58:44 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  =20
> >> la 8. kes=C3=A4k. 2024 klo 19.22 Jonathan Cameron (jic23@kernel.org) k=
irjoitti: =20
> >>>
> >>> On Thu,  6 Jun 2024 17:29:42 +0100
> >>> Mudit Sharma <muditsharma.info@gmail.com> wrote:
> >>>    =20
> >>>> Add support for BH1745, which is an I2C colour sensor with red, gree=
n,
> >>>> blue and clear channels. It has a programmable active low interrupt
> >>>> pin. Interrupt occurs when the signal from the selected interrupt
> >>>> source channel crosses set interrupt threshold high or low level.
> >>>>
> >>>> This driver includes device attributes to configure the following:
> >>>> - Interrupt pin latch: The interrupt pin can be configured to
> >>>>    be latched (until interrupt register (0x60) is read or initialize=
d)
> >>>>    or update after each measurement.
> >>>> - Interrupt source: The colour channel that will cause the interrupt
> >>>>    when channel will cross the set threshold high or low level.
> >>>>
> >>>> This driver also includes device attributes to present valid
> >>>> configuration options/values for:
> >>>> - Integration time
> >>>> - Interrupt colour source
> >>>> - Hardware gain
> >>>>    =20
> >> =20
> >>>> +
> >>>> +#define BH1745_CHANNEL(_colour, _si, _addr)                        =
           \
> >>>> +     {                                                             =
        \
> >>>> +             .type =3D IIO_INTENSITY, .modified =3D 1,             =
            \
> >>>> +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),       =
          \
> >>>> +             .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_HARDWA=
REGAIN) | \ =20
> >>>
> >>> Provide _SCALE instead of HARDWAREGAIN
> >>> As it's an intensity channel (and units are tricky for color sensors =
given
> >>> frequency dependence etc) all you need to do is ensure that if you ha=
lve
> >>> the _scale and measure the same light source, the computed
> >>> _RAW * _SCALE value remains constant. =20
> >>
> >> ...Which is likely to cause also the integration time setting to
> >> impact the SCALE.
> >>
> >> You may or may not want to see the GTS-helpers
> >> (drivers/iio/industrialio-gts-helper.c) - which have their own tricky
> >> corners. I think Jonathan once suggested to me to keep the
> >> HARDWAREGAIN as a read-only attribute to ease seeing what is going on.
> >> For the last couple of days I've been reworking the BU27034 driver to
> >> work with the new sensor variant - and I can definitely see the value
> >> of the read-only HARDWAREGAIN when we have per channel gain settings +
> >> integration time setting which all contribute to the scale... =20
> >=20
> > I'm wondering if that was good advice, but it's definitely better
> > than letting userspace control the gain and integration time separately=
 =20
>=20
> I woke up last night at 03.14 AM thinking of this :rolleyes:

Ah.  I'm one for failing to get to sleep due to late night musing.
No idea if I muse because I'm not sleeping, or not sleep because
of musing!

>=20
> > as there is no sensible way to know how to control that beyond - =20
>=20
> I agree and disagree :)
> I agree that it is simpler to just change the scale when readings get=20
> saturated - or when more accuracy is needed. Hence, implementing the=20
> scale change as is done now makes very much sense.
>=20
> However, I can imagine that sometimes the measurement time plays a role=20
> - and people would like to have more fine grained control over things.=20
> In that case, if driver only allows changing things via the scale, then=20
> the driver is probably doing autonomous choices regarding the=20
> integration time - which may not be optimal for all cases (*citation=20
> needed).

Agreed even without the complexity you mention later- there will be cases
where people want ugly (noisy) data quickly so will crank the gain up
to reduce the integration time.
How often they apply to light sensors is an interesting question.

>=20
> As you may remember, I implemented the ROHM RGB and ALS sensors (the=20
> BU270xx series) so that the integration time can be set as well as the=20
> gain. These sensors (at least the BU27034, don't remember all the dirty=20
> details of the RGB sensors) had per-channel gain and a global=20
> integration time settings. Hence, the scale can be set separately for=20
> each channel. I invented a restriction that setting the per-channel=20
> scale tried to maintain the integration time and change the gain - but=20
> if it was not possible, the scale change changes also the integration=20
> time in order to yield the desired scale.
>=20
> Problem was that the integration time was a global setting, and changing=
=20
> it for one channel results scale change also on the other channel(s).
>=20
> To mitigate such side-effects I implemented logic that the scale change=20
> for other channels (caused by the integration time change) is=20
> compensated by changing the gain for these unrelated channels. Eg, if=20
> scale change for channel #1 required doubling the integration time -=20
> which effectively doubled the "gain contributed by integration time"=20
> also for the channel #2 and #3 - then the HARDWAREGAIN for the unrelated=
=20
> channels #2 and #3 is halved in order to keep their scale unchanged. Grea=
t.
>=20
> Except that this is not always possible. The HWGAIN for these unrelated=20
> channels may have been already set to the other extreme, and further=20
> reducing/increasing is not possible. Or, there may be unsupported=20
> multipliers (gaps) in the gain range, so that setting the hardwaregain=20
> to required value is not possible.
>=20
> Here I just decided to return an error to caller and disallow such scale=
=20
> change.
>=20
> This is very much annoying solution but I ran out of good ideas. Adding=20
> more logic to the driver to work around this felt like asking for a=20
> nose-bleed. I was sure I ended up adding a bug or two, and resulting=20
> code that was so hairy I could never look at it again :) We can call=20
> that as an unmaintainable mess.
>=20

Yeah. I vaguely recall this one was a bit nasty and result wasn't
entirely satisfying.

> Still, what makes this even more annoying is that it might be possible=20
> to support the requested scale by selecting yet another integration=20
> time. Eg, imagine a situation where we have 2 channels. Both channels=20
> support gains
>=20
> 1x, 2x, 8x, 16x, 32x. 4x is not supported.
>=20
> Let's further say we have integration times 50mS 100mS, 200mS, 400mS -=20
> causing "effective gains" 1x, 2x, 4x and, 8x
>=20
> Now, say channel #1 is using gain 2x, channel #2 is using 8x.=20
> Integration time is set to 400mS.
>=20
> Assume the user would like to double the scale for channel #2. This=20
> means the "total gain" should be halved. The HWGAIN can't be halved=20
> because 8x =3D> 4x is not supported, so driver decides to drop the=20
> integration time from 400mS to 200mS instead. That'd do the trick.
>=20
> Then the driver goes to check if the channel #1 can maintain the scale=20
> with this integration time. Gain caused by integration time is now=20
> halved so HWGAIN for channel #1 should be doubled to mitigate the=20
> effect. Well, the new gain for channel #1 should now go from 2x =3D> 4x -=
=20
> which is not supported, and the driver returns error and rejects the chan=
ge.
>=20
> Still, the hardware could be set-up to use integration time 50mS=20
> (dropping the gain for channels from 8x =3D> 1x eg. 8 times smaller), and=
=20
> channel #2 HWGAIN go from 8x =3D> 2x (4 times smaller) thus doubling the=
=20
> scale. The channel #1 wants to maintain scale, so HWGAIN for channel #1=20
> should go 8 times greater, from 2x =3D> 16x which is possible.
>=20
> To make this even more annoying - the available_scales lists the 'halved=
=20
> scale' for the channel #1 as supported because there is a way to achieve=
=20
> it. So, the user can't really easily figure out what went wrong. Having=20
> the read-only HARDWAREGAIN and knowing the gains sensor's channels=20
> support would give a hint - but this is far from obvious. listing the=20
> supported hardwaregains might make things a bit better - but using the=20
> standard "available" entry in sysfs might make user to assume setting=20
> the hardwaregain is possible.

That would be an odd bit of interface indeed.

>=20
> We may invent a new entry to list the supported hardwaregains - and I=20
> believe adding the logic to find supported gain-timing combinations is=20
> then easier (and less error-prone) in user-land applications than it is=20
> in driver - but I am wondering if it actually would be better just allow=
=20
> setting both the hardwaregain and integration time individually for=20
> those applications which may care... Well, I am probably just missing=20
> some culprit supporting setting the hardwaregain causes.

We could do something similar to what we did recently for a power mode
switch on an IMU.  The interface is also less than ideal though but
was exploring a similar problem:
[PATCH v4 2/2] iio: imu: inv_icm42600: add support of accel low-power mode
https://lore.kernel.org/all/20240605195949.766677-3-inv.git-commit@tdk.com/

That was much simpler than this. The device has two power modes
(trading off power vs noise).  The lowest sampling frequencies only
worked in low power mode and the highest only in low noise mode.
A few in the middle were available in both modes.  We defaulted to
choosing low power if available.  The aim was to design an interface
where everything worked as normal if you didn't grab the 'expert'
controls. So it defaults to a preference for low power (here
equivalent would be defaults to lowest hardware gain) but we provided
an ability to override - if possible. So you could specify what you
wanted the gain to be and if that was possible whilst retaining the
sampling frequency (here that would be the scale) then the change
would be made. If not it wouldn't an reading the mode back (here
that would be reading hardware gain) would return the actual setting
achieved.  In that case the power mode setting isn't sticky. To enter
the low noise mode you have to be at a sampling frequency where it
is supported.  That sort of restriction might not work here.

In that case the control grabbed to override the power mode is not
standard ABI so we an be fairly sure no normal software will tweak
it but in the rare occasion where a user needs it the tweak is
available.

Here we might need a similar 'out of ABI' trick to make it clear that
scale is the main control to use.

>=20
> I believe there are many use-cases where it would work if we just=20
> allowed the channel #1 scale to change as a side-effect of changing=20
> channel #1 scale. Still, I am very reluctant to do this as there could=20
> be different type of data coming from these channels, and different=20
> consumers for this data. Allowing another application to unintentionally=
=20
> change the data for other app would in my opinion be very nasty.

You've lost me here.

>=20
> The problem is not exactly urgent though and I am not working on an=20
> application suffering from it. But it managed to interrupt my glymphatic=
=20
> system while it was cleaning-up my brains last night. I will use it as=20
> an excuse if you find any errors from this babbling :)

For this complexity I definitely want a known user who cares.
It's complex and we'd need to construct the userspace to use it.

For the IMU analogy above, it is easier to understand that use case.

Gut feeling is normally people are actually cranking scaling of light
channels up and down together as hopefully they are approximately balanced
for 'white' giving similar scales on all sensors (by filters or fixed gains)
and people would only need to care if they were trying to measure a weak
blue signal in a red world. If we have a case that doesn't work well
for that sort of global scaling (I can sort of see that as a possible
problem due to the transition states not being possible) then we
should make sure that one works!

Jonathan
=20
>=20
> Yours
> 	-- Matti
>=20


