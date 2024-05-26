Return-Path: <linux-iio+bounces-5319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C5B8CF516
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 19:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B5F1C20BA9
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BAF6BB29;
	Sun, 26 May 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTllzFZ/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0CD5FB8B;
	Sun, 26 May 2024 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716744912; cv=none; b=cjqxIXNEZsQuWK3uLzTR/q9jNn2AdKcLe5kuVaJp+I8MIyUWmzj96W56CxaVUgJNhFupl9+NKWedGb5fz8y+6CajvDVa5EWfroiOdbciwKOG2+mhwhMEIGdK8AERxOhOE52KjxK7N2qtLpCekjDsL13p7Y4Px2yUiL46DAtDtb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716744912; c=relaxed/simple;
	bh=IzDnJEdVx1v2rrzV/rd8P+bEHnIH4yb3AD4Oiu9Y76k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oM/Y478Ocl1XEXGNiJamzeEwGuGbE1dNyxuPTA5EYaK1kP2lmU7JwtZiZfTW4KKQJZlXIj0/pqyAgAkNBWugIPIPTBSJ5whamAu+sRaKhEP3jZA+Od6WAYc9QUDTVyzy2DXsl1jh3hccFGIGnesoXm49yhyBtrXS7c8OSMirbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTllzFZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42021C32781;
	Sun, 26 May 2024 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716744912;
	bh=IzDnJEdVx1v2rrzV/rd8P+bEHnIH4yb3AD4Oiu9Y76k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rTllzFZ/Dl533ve7/fDkLc/MpEAl+ijDFjZRYL1+RZiUijO1qMH2Xk3Rur950x+e/
	 SakJgWyjyHB0cmWqzA8jKlMPeqyHSc8KXmu73wwATjSLdQF+VBL+efRvUQWujXJc4s
	 BeRkJiHVxrvQARR8mhima3jDhEtL4lwevE00f/eZ77GK5Viww0t2i7bkLG0ffNd45o
	 a+ib10LvG6nALsKO5XtD/TMkaLXVe2wZBK6kCJUy6nCsVvetLqFudG1YzXqCFsm4y/
	 vDTxs1AzlfTJx/plTFMJoVeiLCMl26MtohLRLEYx6Qt55Ivo0eAcQ95zrLLELyUoap
	 wV7Ua/nqzdzBg==
Date: Sun, 26 May 2024 18:35:07 +0100
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
Message-ID: <20240526-peculiar-panama-badda4f02336@spud>
References: <20240513-headsman-hacking-d51fcc811695@spud>
 <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m4VkfGK+SP6sTPQb"
Content-Disposition: inline
In-Reply-To: <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>


--m4VkfGK+SP6sTPQb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 02:15:35PM +0200, Nuno S=E1 wrote:
> On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:

> >=20
> > To remind myself, "Application 2" featured an offload engine designed
> > specifically to work with a particular data format that would strip a
> > CRC byte and check the validity of the data stream.
> >=20
>=20
> I think the data manipulation is not really a property of the engine. Typ=
ically data
> going out of the offload engine goes into another "data reorder" block th=
at is pure
> HW.
>=20
> > I think you're right something like that is a stretch to say that that
> > is a feature of the SPI controller - but I still don't believe that
> > modelling it as part of the ADC is correct. I don't fully understand the
> > io-backends and how they work yet, but the features you describe there
> > seem like something that should/could be modelled as one, with its own
> > node and compatible etc. Describing custom RTL stuff ain't always
> > strightforward, but the stuff from Analog is versioned and documented
> > etc so it shouldn't be quite that hard.
> >=20
>=20
> Putting this in io-backends is likely a stretch but one thing to add is t=
hat the
> peripheral is always (I think) kind of the consumer of the resources.

Could you explain you think why making some additional processing done to
the data an io-backend is a stretch? Where else can this RTL be
represented? hint: it's not part of the ADC, just like how if you have
some custom RTL that does video processing that is not part of the
camera!

> Taking the
> trigger (PWM) as an example and even when it is directly connected with t=
he offload
> block, the peripheral still needs to know about it. Think of sampling fre=
quency...
> The period of the trigger signal is strictly connected with the sampling =
frequency of
> the peripheral for example. So I see 2 things:
>=20
> 1) Enabling/Disabling the trigger could be easily done from the periphera=
l even with
> the resource in the spi engine. I think David already has some code in th=
e series
> that would make this trivial and so having the property in the spi contro=
ller brings
> no added complexity.
>=20
> 2) Controlling things like the trigger period/sample_rate. This could be =
harder to do
> over SPI (or making it generic enough) so we would still need to have the=
 same
> property on the peripheral (even if not directly connected to it). I kind=
 of agree
> with David that having the property both in the peripheral and controller=
 is a bit
> weird.

Can you explain what you mean by "same property on the peripheral"? I
would expect a peripheral to state its trigger period (just like how it
states the max frequency) and for the trigger period not to appear in
the controller.

I think a way that this could be modelled to reduce some software
complexity is considering that the periodic trigger is a clock, not
a PWM, provided you are only interested in the period. That'd give you
an interface that was less concerned about what the provider of the
periodic trigger is. After all, I doubt the ADC cares how you decide to
generate the trigger, as long as the periodicity is correct.
With the examples provided, you'd get something like:

pwm {
}

pclk {
	compatible =3D pwm-clock
	pwms =3D <&pwm 0 x>
}

spi {
	compatible =3D spi-engine
	clocks =3D <&clks SPI>, <&pwm>
	clock-names =3D "bus", "offload"
}

The pwm-clock driver (clk-pwm.c) doesn't implement .set_rate though, but
maybe you don't need that or maybe it could be added if needed.

> And the DMA block is a complete different story. Sharing that data back w=
ith the
> peripheral driver (in this case, the IIO subsystem) would be very interes=
ting at the
> very least. Note that the DMA block is not really something that is part =
of the
> controller nor the offload block. It is an external block that gets the d=
ata coming
> out of the offload engine (or the data reorder block). In IIO, we already=
 have a DMA
> buffer interface so users of the peripheral can get the data without any =
intervention
> of the driver (on the data). We "just" enable buffering and then everythi=
ng happens
> on HW and userspace can start requesting data. If we are going to attach =
the DMA in
> the controller, I have no idea how we can handle it. Moreover, the offloa=
d it's
> really just a way of replaying the same spi transfer over and over and th=
at happens
> in HW so I'm not sure how we could "integrate" that with dmaengine.
>=20
> But maybe I'm overlooking things... And thinking more in how this can be =
done in SW
> rather than what makes sense from an HW perspective.

I don't think you're overlooking things at all, I'm intentionally being
a bit difficult and ignoring what may be convenient for the adc driver.
This is being presented as a solution to a generic problem (and I think
you're right to do that), but it feels as if the one implementation is
all that's being considered here and I'm trying to ensure that what we
end up with doesn't make limiting assumptions.

Part of me says "sure, hook the DMAs up to the devices, as that's what
happens for other IIO devices" but at the same time I recognise that the
DMA isn't actually hooked up like that and the other IIO devices I see
like that are all actually on the SoC, rather than connected over SPI.
It might be easy to do it this way right now, but be problematic for a
future device or if someone wants to chuck away the ADI provided RTL and
do their own thing for this device. Really it just makes me wonder if
what's needed to describe more complex data pipelines uses an of_graph,
just like how video pipelines are handled, rather than the implementation
of io-backends that don't really seem to model the flow of data.

> > continuation:
> > If offload engines have their own register region in the memory map,
>=20
>=20
> Don't think it has it's own register region... David?
>=20
> > their own resources (the RTL is gonna need at the very least a clock)
> > and potentially also provide other services (like acting as an
> > io-backend type device that pre-processes data) it doesn't sound like
> > either the controller or peripheral nodes are the right place for these
> > properties. And uh, spi-offloads gets a phandle once more...
> >=20
>=20
> But then it would be valid for both peripheral and controller to referenc=
e that
> phandle right (and get the resources of interest)?

Sure. But to assume that, for example, the provider of data processing
services also provided the periodic polling trigger would be incorrect
even if in the only currently existing case it does. Nothing is stopping
someone splitting those into different blocks, after all this is "random"
RTL in an FPGA :)

> FWIW, maybe look at the below usecase. It has some block diagrams that ma=
y be helpful
> to you:
>=20
> https://wiki.analog.com/resources/eval/user-guides/ad463x/hdl

Yeah, they're a good reference, thanks.

I had to go AFK in the middle of this, I have a nagging feeling that I
forgot to say something but I cannot recall what.

Cheers,
Conor.

--m4VkfGK+SP6sTPQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlNyywAKCRB4tDGHoIJi
0rMZAP97is6BrH21b+W8jp5WHAZWlcL+sL5JJBGfvH+Cek3K1wEAu+nE5Db4zn21
jWEa1dDsYFgPjF1xjU+v8+b3KpxbTgE=
=mmOM
-----END PGP SIGNATURE-----

--m4VkfGK+SP6sTPQb--

