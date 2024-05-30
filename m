Return-Path: <linux-iio+bounces-5516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1F8D5230
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 21:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9881C22831
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1777F49A;
	Thu, 30 May 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPqvRC57"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5565A7F465;
	Thu, 30 May 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096703; cv=none; b=gUD+qmZaIuMRO/Wy7a5i92lMI1x2XauCCdZTZx81FnMP5vlDlub8KQBmIU17RJdtn63E27444iA98fzhPOLsnm7Y5UCbl3JZzotEwxbO9hCZvZ7LmbZlAGwPd6/spOQ4QzXGdF0AcoY8xp0Op9jy4MuWAUdJrJ5bVFQZCYLOmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096703; c=relaxed/simple;
	bh=DV0gTwi9e+ykWbycF2YHU6XgDG4jgojQVkSBsMq7j+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVomA10OiDCPAM8uLvAC/Pc1FGMG/K9BjoRsG8wnOhrllyxT3duA0Wi4t3Ix45K5yzNPYN7Xf/78MCXDVfKOqob00JqLVqtt/K7Se35IRXQeqMZRQ6XS8rlM1PLwA1MCphK/nxZBr2GUxcnPAW92aqpgd5WL5SobDobmrQYGfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPqvRC57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEF6C2BBFC;
	Thu, 30 May 2024 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717096703;
	bh=DV0gTwi9e+ykWbycF2YHU6XgDG4jgojQVkSBsMq7j+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPqvRC57wovO6itmkrfi6klZBnUzkdkQ7ZBwKZcGeZGNo9hYF9XKBlGAcxF+2ej+U
	 WSUzrvBkVTRPX5ulAM0g3WondbRTQ/O0IdHKQe3HFkVlWuGFGT+llF92NmsrspTglr
	 1cqnUZUcqIkvsPTm2d02RYgzxh1VgN8OkGlcTrn9hZeEmrMimTb+Uf+1psfFo61tpr
	 eUCkpQvVJLhML9CarNJ2PaJU5rR+o6SR3mLdVvB/4GSFQF80Qj+zddiAI8d8K5NTzP
	 xoSp8BWZZ1d9hS87HBz9ZqtF2IuagbgDMJAsgQxkYewEeMhXiN+TZgPmfQT/Ctl9qo
	 8L90sY0Kah2CQ==
Date: Thu, 30 May 2024 20:18:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] spi: dt-bindings: spi-peripheral-props: add
 spi-offloads property
Message-ID: <20240530-petunia-genre-2731493dbd0f@spud>
References: <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <20240526-peculiar-panama-badda4f02336@spud>
 <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXsMtB1rodpQwBun"
Content-Disposition: inline
In-Reply-To: <10991373cb9603803df63d8236c475807f6dde68.camel@gmail.com>


--OXsMtB1rodpQwBun
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 10:07:37AM +0200, Nuno S=E1 wrote:
> On Sun, 2024-05-26 at 18:35 +0100, Conor Dooley wrote:
> > On Thu, May 23, 2024 at 02:15:35PM +0200, Nuno S=E1 wrote:
> > > On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:

> > > Taking the
> > > trigger (PWM) as an example and even when it is directly connected wi=
th the
> > > offload
> > > block, the peripheral still needs to know about it. Think of sampling
> > > frequency...
> > > The period of the trigger signal is strictly connected with the sampl=
ing
> > > frequency of
> > > the peripheral for example. So I see 2 things:
> > >=20
> > > 1) Enabling/Disabling the trigger could be easily done from the perip=
heral even
> > > with
> > > the resource in the spi engine. I think David already has some code i=
n the series
> > > that would make this trivial and so having the property in the spi co=
ntroller
> > > brings
> > > no added complexity.
> > >=20
> > > 2) Controlling things like the trigger period/sample_rate. This could=
 be harder
> > > to do
> > > over SPI (or making it generic enough) so we would still need to have=
 the same
> > > property on the peripheral (even if not directly connected to it). I =
kind of
> > > agree
> > > with David that having the property both in the peripheral and contro=
ller is a
> > > bit
> > > weird.
> >=20
> > Can you explain what you mean by "same property on the peripheral"? I
> > would expect a peripheral to state its trigger period (just like how it
> > states the max frequency) and for the trigger period not to appear in
> > the controller.
> >=20
>=20
> Just have the same 'pwms' property on both the controller and peripheral.=
=2E.

Yeah, no... Opinion unchanged since my last message.

> > I think a way that this could be modelled to reduce some software
> > complexity is considering that the periodic trigger is a clock, not
> > a PWM, provided you are only interested in the period. That'd give you
> > an interface that was less concerned about what the provider of the
> > periodic trigger is. After all, I doubt the ADC cares how you decide to
> > generate the trigger, as long as the periodicity is correct.
> > With the examples provided, you'd get something like:
> >=20
>=20
> Unfortunately that's not the case.

Ahh, that sucks. Oh well.

> For instance, in the design on the link I gave you
> on the last reply we do have an averaging mode where we actually need an =
offset
> (effort for supporting that in PWM is already ongoing) between the offloa=
d trigger
> and the peripheral conversion signal (so assuming we only care about peri=
od will fail
> pretty soon :)).

> > > And the DMA block is a complete different story. Sharing that data ba=
ck with the
> > > peripheral driver (in this case, the IIO subsystem) would be very int=
eresting at
> > > the
> > > very least. Note that the DMA block is not really something that is p=
art of the
> > > controller nor the offload block. It is an external block that gets t=
he data
> > > coming
> > > out of the offload engine (or the data reorder block). In IIO, we alr=
eady have a
> > > DMA
> > > buffer interface so users of the peripheral can get the data without =
any
> > > intervention
> > > of the driver (on the data). We "just" enable buffering and then ever=
ything
> > > happens
> > > on HW and userspace can start requesting data. If we are going to att=
ach the DMA
> > > in
> > > the controller, I have no idea how we can handle it. Moreover, the of=
fload it's
> > > really just a way of replaying the same spi transfer over and over an=
d that
> > > happens
> > > in HW so I'm not sure how we could "integrate" that with dmaengine.
> > >=20
> > > But maybe I'm overlooking things... And thinking more in how this can=
 be done in
> > > SW
> > > rather than what makes sense from an HW perspective.
> >=20
> > I don't think you're overlooking things at all, I'm intentionally being
> > a bit difficult and ignoring what may be convenient for the adc driver.
> > This is being presented as a solution to a generic problem (and I think
> > you're right to do that), but it feels as if the one implementation is
> > all that's being considered here and I'm trying to ensure that what we
> > end up with doesn't make limiting assumptions.
>=20
> Yeah, I know and I do agree we need something generic enough and not some=
thing that
> only fits a couple usecases.

If only we had another user... I suppose you lads are the market leader
in these kinds of devices. If I did happen to know if Microchip was
working on anything similar (which I don't, I work on FPGAs not these
kinds of devices) I couldn't even tell you. I suppose I could ask around
and see. Do you know if TI is doing anything along these lines?

> > Part of me says "sure, hook the DMAs up to the devices, as that's what
> > happens for other IIO devices" but at the same time I recognise that the
> > DMA isn't actually hooked up like that and the other IIO devices I see
> > like that are all actually on the SoC, rather than connected over SPI.
>=20
> Yeah, I know... But note (but again, only for ADI designs) that the DMA r=
ole is
> solely for carrying the peripheral data. It is done like this so everythi=
ng works in
> HW and there's no need for SW to deal with the samples at all. I mean, on=
ly the
> userspace app touches the samples.
>=20
> TBH, the DMA is the bit that worries me the most as it may be overly comp=
lex to share
> buffers (using dma-buf or something else) from the spi controller back to=
 consumers
> of it (IIO in this case). And I mean sharing in a way that there's no nee=
d to touch
> the buffers.

<snip>

> Maybe having an offload dedicated API (through spi) to get/share a DMA ha=
ndle would
> be acceptable. Then we could add support to "import" it in the IIO core. =
Then it
> would be up to the controller to accept or not to share the handle (in so=
me cases the
> controller could really want to have the control of the DMA transfers).

Yeah, that is about what I was thinking. I wasn't expecting the spi code
to grow handing for dmabuf or anything like that, just a way for the
offload consumer to say "yo, can you tell me what dma buffer I can
use?". Unless (until?) there's some controller that wants to manage it,
I think that'd be sufficient?

--OXsMtB1rodpQwBun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZljQ+QAKCRB4tDGHoIJi
0rcVAQDksNa1bcy9bBtAYdALc7iTiXJWHwV++XiZuYLtCQ+hYQEA/x3izx7ZHysk
2zPidF0nzLC+8hQ808rWNW3qJU9zEwY=
=kZh4
-----END PGP SIGNATURE-----

--OXsMtB1rodpQwBun--

