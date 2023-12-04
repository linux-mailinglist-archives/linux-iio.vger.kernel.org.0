Return-Path: <linux-iio+bounces-558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EFE802EF2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 10:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A031F21070
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 09:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AABC1C6B0;
	Mon,  4 Dec 2023 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyUwmHe4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A98168B6;
	Mon,  4 Dec 2023 09:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8994FC433C8;
	Mon,  4 Dec 2023 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701682926;
	bh=XrenbCCTdGXlEOxkDWc34E9QbP9g/lZxyxwOkJJWXeg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZyUwmHe4oVNmRXSWmRDb3GxHNO03t017k9iIewJS6AzZJ7VNkLiWXpJPsYK6+KAsy
	 KGr4x66lKRC3oABCMIxYSagV6JgqfJxD15eO84RDUNpxgj9IMfADLKO0P4VZ/md3Z0
	 uwiavKyB6CA4eZB8a7rICcocLAQLIyeX5jxJXkMvvKTSxfO6NIS4lufcXrN0h/d3D9
	 3/XRmIbBF6buFGqzyPEvgAImVbW9wuOWAawXMSZwjDg0mNrRSzL10HINLTubAAlf65
	 Q5Y8/ZPEdbpDi/uDRfllkGDMHRnGwp31hEfB+4SsPiehWsxTyiQOPs9dXTzI9Q0OHK
	 JL2vwMweCNWJg==
Date: Mon, 4 Dec 2023 09:41:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <Marius.Cristea@microchip.com>
Cc: <conor@kernel.org>, <robh+dt@kernel.org>, <conor+dt@kernel.org>,
 <devicetree@vger.kernel.org>, <lars@metafoo.de>,
 <linux-iio@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Message-ID: <20231204094157.775f604e@jic23-huawei>
In-Reply-To: <1fb7d32772cb5e76a5f1fd6b8f3b32754f8a9395.camel@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
	<20231025134404.131485-2-marius.cristea@microchip.com>
	<20231025-cheddar-tucking-b2ea777ed4f9@spud>
	<937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
	<20231026-perkiness-financial-55313e297230@spud>
	<20231027152625.44b26d80@jic23-huawei>
	<1fb7d32772cb5e76a5f1fd6b8f3b32754f8a9395.camel@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2023 08:55:48 +0000
<Marius.Cristea@microchip.com> wrote:

> Hi
>=20
> On Fri, 2023-10-27 at 15:26 +0100, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > On Thu, 26 Oct 2023 17:08:07 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >  =20
> > > On Thu, Oct 26, 2023 at 03:23:46PM +0000,
> > > Marius.Cristea@microchip.com=C2=A0wrote: =20
> > > > Hi Conor,
> > > >=20
> > > > On Wed, 2023-10-25 at 16:08 +0100, Conor Dooley wrote: =20
> > > > > Hey Marius,
> > > > >=20
> > > > > On Wed, Oct 25, 2023 at 04:44:03PM +0300,
> > > > > marius.cristea@microchip.com=C2=A0wrote: =20
> > > > > > From: Marius Cristea <marius.cristea@microchip.com>
> > > > > >=20
> > > > > > This is the device tree schema for iio driver for
> > > > > > Microchip PAC193X series of Power Monitors with Accumulator.
> > > > > >=20
> > > > > >  =20
> ......
> > > > > > +
> > > > > > +=C2=A0 reg:
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 "#address-cells":
> > > > > > +=C2=A0=C2=A0=C2=A0 const: 1
> > > > > > +
> > > > > > +=C2=A0 "#size-cells":
> > > > > > +=C2=A0=C2=A0=C2=A0 const: 0
> > > > > > +
> > > > > > +=C2=A0 interrupts:
> > > > > > +=C2=A0=C2=A0=C2=A0 description: IRQ line of the ADC
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 drive-open-drain:
> > > > > > +=C2=A0=C2=A0=C2=A0 description: The IRQ signal is configured a=
s open-drain.
> > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > +
> > > > > > +=C2=A0 microchip,slow-io:
> > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > +=C2=A0=C2=A0=C2=A0 description: |
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A GPIO used to trigger a change=
 is sampling rate
> > > > > > (lowering
> > > > > > the chip power consumption).
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In default mode, if this pin is=
 forced high, sampling
> > > > > > rate
> > > > > > is forced to eight
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 samples/second. When it is forc=
ed low, the sampling
> > > > > > rate is
> > > > > > 1024 samples/second unless
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a different sample rate has bee=
n programmed. =20
> > > > >=20
> > > > > This description doesn't really make sense to me - if a GPIO is
> > > > > used
> > > > > to
> > > > > drive the pin low or high, why do we need a property? A DT
> > > > > property
> > > > > implies that this is a static configuration depending on the
> > > > > board,
> > > > > but
> > > > > reading the description this seems to be something that can be
> > > > > toggled
> > > > > at runtime.
> > > > > I do note though, that this GPIO is not documented in the
> > > > > binding, so
> > > > > I
> > > > > suppose what really needs to happen here is document the gpio
> > > > > so that
> > > > > the driver can determine at runtime what state this pin is in?
> > > > >=20
> > > > > Also, you say "In default mode", but don't mention what the
> > > > > non-
> > > > > default
> > > > > mode is. What happens in the other mode? =20
> > >  =20
> > > > This is a "double function" pin. On the PAC193x there is the
> > > > SLOW/ALERT
> > > > pin. At runtime this pin could be configured as an input to the
> > > > PAC and
> > > > the functionality will be "SLOW" that means if it is forced high,
> > > > the
> > > > PAC will work in low power mode by changing the sample rate to 8
> > > > SPS.
> > > > If it's forced low the PAC will work at it's full sample rate. =20
> > >=20
> > > Since this is a runtime thing, it doesn't make sense to have a
> > > property
> > > that is set at dts creation time that decides what mode the pin is
> > > in.
> > >  =20
> > > > "SLOW" is the default function of the pin but it may be
> > > > programmed to
> > > > function as ALERT pin (Open Collector when functioning as ALERT,
> > > > requires pull-up resistor to VDD I/O). This time the pin will be
> > > > set as
> > > > output from PAC (ALERT functionality) to trigger an interrupt to
> > > > the
> > > > system (this is covered by the interrupts and drive-open-drain). =20
> > >=20
> > > Hmm, at the risk of getting out of my depth with what the GPIO
> > > subsystem
> > > is capable of doing, I would expect to see something like
> > >=20
> > > sampling-rate-gpios:
> > > =C2=A0 description:
> > > =C2=A0=C2=A0=C2=A0 <what you have above>
> > > =C2=A0 maxItems: 1
> > >=20
> > > Which would allow the driver to either drive this pin via the gpio
> > > subsystem, or to use the interrupt property to use it as an
> > > interrupt
> > > instead.
> > >=20
> > > Perhaps Jonathan etc knows better for these sort of dual mode pins. =
=20
> >=20
> > Beyond them being a pain? The fun is they may get wired to interrupt
> > controllers that are also GPIOs or they may not (and the other way
> > around
> > with them wired to GPIO pins that aren't interrupt pins).
> >=20
> > I don't understand the usecase for the SLOW control.
> > Given it seems software can override the use for SLOW I'd be tempted
> > to
> > always do that.
> > Thus making this pin useable only as an optional interrupt.
> >=20
> > If someone hard wires it to high or low that is harmless if we aren't
> > letting it control anything.
> >  =20
>=20
> Here I was trying to define/describe 3 possible situations:
> - 1) the pin is not used at all, so it doesn't matter if it's connected
> somewhere
>=20
> - 2) the pin is user configured as "interrupt" and it's connected to
> the interrupt controller (this case is not supported in the driver
> right now)
>=20
> - 3) the pin is user configured as "SLOW" (this case is not supported
> in the driver right now). That means it should be connected to a GPIO
> pin. This function (SLOW control) will automatically change the PAC
> internal sampling frequency to lower the PAC internal power
> consumption. For example, the PAC could be configured to a sample rate
> of 1024 samples/s (it will consume maximum current). Using the SLOW
> control, the chip will internally change to 8 samples/s but the math
> internally will "behave" as the 1024 samples/s but at a much lower
> power consumption. It's very useful in case the system wants to lower
> power consumption (we still need to measure battery power consumption
> even if the system is put into a low power state). PAC internal power
> consumption is proportional to the number of channels used and also the
> sampling frequency.

So far so good, but how does 3 differ from just setting the chip to sample
at 8 samples/s, which I believe we can do from software?

Anyhow, for a DT binding, provide both gpio and interrupt as optional
and the driver can make up it's mind on what to do if both are provided.

Jonathan

>=20
>=20
>=20
> > >  =20
> > > > The system could work fine without this pin. The driver doesn't
> > > > use
> > > > interrupt at this time, but it could be extended. =20
> > >=20
> > > Cheers,
> > > Conor. =20
> >  =20
>=20
> Thanks,
> Marius


