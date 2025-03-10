Return-Path: <linux-iio+bounces-16658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3BA58E7A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD556188C696
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DF6224252;
	Mon, 10 Mar 2025 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="JBtCstpm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E9224241
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596362; cv=none; b=tL/pxErhvJ+R4hWQS4TJnS8Y2zA3q6LhZYbr3LItIAem03kUb1gcNx85ErmKtPpAywQqbVXoE8GHFrk2B0+BRiokQZUpibzDFXveMIwNMP61AQPvewvMcRGEw0BS3oaQuZlUFKtA0cZ8A2bjbQ7ZXKS+jASwjx59W3ruTQzZBx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596362; c=relaxed/simple;
	bh=0w1TgQzISAr8i+4WRfQJcWw1/xqHrdODd50KfsR9/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiqdjf2+sudZOahx3xJKniXTcDf/wAI+cXRuPGXLmEdaatVtPLXNy8Ss4rxlJy4dhLAiFdsNdnyFfjGf8FAu392qnJbD7ho25qAmipOu5Eat/RqyPvKXjwSBn7Y+xWGC7fddzPEVLI0vCUGnXGh0d1Yeo3In8oGQjd2cQOJPjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=JBtCstpm; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=80uCm2kn3K3NcR4Sztxqu4bumx6uvoO71bXTneb6OBk=;
	b=JBtCstpmlwBcCCf4JHltkqAAyxEtoF3O1dKxalhy6avPiHYDQ3ZbsguQUp9aknD/+MgMJgil+psu3
	 lq6TNmfaT6keJ01ksV/StRqALBvTN6IjRDWynAIGvMcYKzTsrr1a4bE8g7+nZ27tDXdoIfMOdXg+rP
	 eXr0mef/fGlwFtE4h7vP45MdRTT/8RduEetgh8VqYs2FisxECLNmTMinN55PfFFU67bNNXj4rKyiMm
	 raD7DEmZ5VY5OHZ3B9cPeboWbOlkhznZ4YO8F4S+NxpLdMy2Jk4PZJ+zzcrnLAVeCd2eSm/sk5JXMi
	 27Gd/lR5ObZG+wm5BNdAEqDou0YPd6g==
X-MSG-ID: 118667f3-fd8c-11ef-8b4e-005056817704
Date: Mon, 10 Mar 2025 09:45:49 +0100
From: David Jander <david@protonic.nl>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <20250310094549.2d78bec7@erd003.prtnl>
In-Reply-To: <20250309173250.68956c88@jic23-huawei>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<6c6cqaxmsy7miesel4ghdeiea6nrpe4gti4xf5enfyg4uqro5u@vpmtd2t7gydi>
	<20250305164046.4de5b6ef@erd003.prtnl>
	<mzxammninwmak5ti4c6is4pbdx3xzzziiwbxiwrldjyxgae4ok@ocec24vu4txa>
	<20250306102540.7f0f6146@erd003.prtnl>
	<20250309173250.68956c88@jic23-huawei>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hi Jonathan,

On Sun, 9 Mar 2025 17:32:50 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 6 Mar 2025 10:25:40 +0100
> David Jander <david@protonic.nl> wrote:
>=20
> > On Thu, 6 Mar 2025 00:21:22 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:
> >  =20
> [...]
> > >=20
> > > Sad, so a userspace process still has to know some internal things ab=
out
> > > the motor it drives. :-\   =20
> >=20
> > Unfortunately that is almost impossible to avoid entirely.
> > You can replace one stepper motor driver with another that might have
> > different micro-stepping subdivision, by looking at struct
> > mot_capabilities.subdiv, but a simple brushed DC motor just isn't able =
to
> > replace a stepper motor in all but the most trivial applications. I als=
o think
> > that burdening the kernel with all sorts of complicated math to model t=
he
> > mechanical conversion factors involved in anything that's connected to =
the
> > motor drive shaft is overkill. As well as trying to emulate all missing
> > capabilities from a motion device that is lacking that functionality na=
tively.
> >=20
> > So just like in IIO you cannot just replace one ADC with any other, in =
LMC you
> > also cannot replace any device with any other.
> >=20
> > That's why there is struct mot_capabilities and MOT_IOCTL_GET_CAPA. It =
enables
> > user-space to optionally support different devices more easily. It is p=
robably
> > best used in conjunction with a LMC user-space library, although I don'=
t want
> > to rely on such a library for being able to use LMC. There is some midd=
le
> > ground here I guess... just like in IIO.
> >=20
> > One thing I could try to improve though, is to include some additional
> > information in struct mot_capabilities that tells something more about =
the
> > nature of the used units, just like the speed_conv and accel_conv const=
ants do
> > for time conversion. Something that can be placed in the device tree (p=
ossibly
> > in a motor child-node connected to the motor-controller) that contains =
some
> > conversion constant for distance. That way, if one were to (for example)
> > replace a stepper motor with a BLDC motor + encoder in a new hardware
> > revision, this constant could be used to make the units backwards compa=
tible.
> >=20
> > As background information: A stepper motor controller counts distance i=
n steps
> > and/or micro-steps. There are mot_capabilities.subdiv micro-steps in ea=
ch
> > step. The amount of angle the actual motor shaft advances with each who=
le step
> > depends on the motor construction and is often 200 steps per revolution=
 (1.8
> > degrees), but can vary from 4 to 400 steps per revolution depending on =
the
> > motor. So it is not only the controller that matters but also the type =
of
> > motor. This suggests the need of motor sub-nodes in the device-tree if =
one
> > wanted to extend the hardware knowledge further down from the motor dri=
ver.
> > But then there are gear boxes, pulleys, etc... it's basically conversion
> > factors all the way down. How many of them is sensible to bother the ke=
rnel
> > with? =20
>=20
> I'd have a motor description that is sufficient to be able to swap steppe=
rs
> between hardware versions and present sufficient info to userspace to all=
ow
> a library to hide those differences. That description might well be of
> an aggregate device consisting of motor and whatever mechanics to get you
> to the point you care about (actuator motion).  Hardest bit will be docum=
enting
> 'where' in the system the DT is describing.

Is it really the purpose of a DT to describe mechanical aspects of a machin=
e?
Aren't we stretching things here?

In case this makes sense, it would need to be optional. Only the electronics
are on the "board", the rest can vary beyond the scope of the DT: one can
connect different motors to a stepper motor controller and often that's the
purpose. Just as one can connect anything to a USB port.

Sometimes the controller is single purpose, just as some USB ports that hav=
e a
fixed device connected to it on the board, like a USB-ethernet interface for
example, which also has a certain fixed phy hooked up to it, etc...

If the purpose of the DT is to potentially go beyond the borders of a PCB (=
or
stack of PCB's) and even beyond the realm of electronic parts into mechanic=
al
parts, wouldn't we need a way to describe a lot of things, like gearboxes,
pulleys, etc...?

Also, in the spirit of the DT, shouldn't that description be complete and
independent of the software (or even OS) involved? If that's the case, I fe=
ar
that "...to the point you care about..." is probably not enough?

> It's not that heavily used but we do have analog front ends in IIO that
> provide a not dissimilar thing to the various potential mechanisms here.

AFE's are still part of the electronics and often also part of the same boa=
rd,
so there it does make more sense. I've used them.

Don't get me wrong, if there is general agreement that information
about mechanical things like a motor, gearbox or other mechanical
transformation of motion should be contained in the DT, I'm fine with it.
Maybe we should create an example to have something to talk about?

Take for example the extruder of a 3D printer:

Complete description of the mechanics, including the stepper motor of type
17HS4401 from a Chinese manufacturer called "songshine" and the extruder,
which consists of a gear reduction and a hobbled shaft pressing the filament
into the hot-end. The stepper motor does one full 360 degree turn per 200
whole steps. The extruder then pushes 2178 micrometer of filament into the
hot-end per whole turn of the motor shaft. We will assume that the extruder
itself is not a standard part that can be ordered and could not have a
standardize compatible string. The motor... could. Or it could be a generic
motor with some parameters in the DT, like this:

&spi2 {
	...
	stepper-controller3: tmc5240@0 {
		compatible =3D "adi,tmc5240";
		reg =3D <3>;
		spi-max-frequency =3D <10000000>;
		interrupts-extended =3D <&gpiok 6 IRQ_TYPE_LEVEL_LOW>;
		clocks =3D <&clock_tmc5240>;

		motor0 {
			compatible =3D "bipolar-stepper-motor";
			run-current-ma =3D <1300>;
			hold-current-ma =3D <260>;
			rated-voltage-mv =3D <3600>;
			induction-uh =3D <2800>;
			dc-resistance-mohm =3D <1500>;
			holding-torque-nmm =3D <400>;
			detent-torque-nmm =3D <22>;
			steps-per-turn =3D <200>;

			extruder0 {
				compatible =3D "rotation-to-linear";
				distance-per-turn-um =3D <2178>;
			};
		};
	};
};

Or the motor could be a reusable part with its own entry in some
"bipolar-stepper-motors.c" database under a compatible string:

&spi2 {
	...
	stepper-controller3: tmc5240@0 {
		compatible =3D "adi,tmc5240";
		reg =3D <3>;
		spi-max-frequency =3D <10000000>;
		interrupts-extended =3D <&gpiok 6 IRQ_TYPE_LEVEL_LOW>;
		clocks =3D <&clock_tmc5240>;

		motor0 {
			compatible =3D "songshine,17HS4401";

			extruder0 {
				compatible =3D "rotation-to-linear";
				distance-per-turn-um =3D <2178>;
			};
		};
	};
};

Or one could just condense all the information of the motor and mechanics i=
nto
one node with the needed properties to obtain the conversion factors the
motion framework needs. But that would make the DT dependent on the software
used, and AFAIK this is not the purpose of a DT, right? It might look like
this:

&spi2 {
	...
	stepper-controller3: tmc5240@0 {
		compatible =3D "adi,tmc5240";
		reg =3D <3>;
		spi-max-frequency =3D <10000000>;
		interrupts-extended =3D <&gpiok 6 IRQ_TYPE_LEVEL_LOW>;
		clocks =3D <&clock_tmc5240>;

		motor0 {
			compatible =3D "stepper-linear-actuator";
			run-current-ma =3D <1300>;
			hold-current-ma =3D <260>;
			steps-per-turn =3D <200>;
			...
			distance-per-turn-um =3D <2178>;
		};
	};
};

I've left out properties like reg, #address-cells and #size-cells here for =
brevity.

Let me know if you think any of this makes sense.

Best regards,

--=20
David Jander

