Return-Path: <linux-iio+bounces-5317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C28CF4C3
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 17:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F55D1C2090F
	for <lists+linux-iio@lfdr.de>; Sun, 26 May 2024 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F3179BC;
	Sun, 26 May 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFLlqHZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FBB17C60;
	Sun, 26 May 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716738176; cv=none; b=fefi37gOZRNi89+z1v+xk8H+CqW+25EZNoNmMksZde4i9k7IJsy+7N4Vj+92xpbRza3ovkoQajHwKtfZGJ67x7ZyDBLcBq/Qp5cvvE7YCejYAkokw+QigKTRCxpTHpaMFq4KtajqANH4BaTXCUHgBxANekh9yMgHC5Mna3lxmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716738176; c=relaxed/simple;
	bh=w1hV+o9VMoEuHtxMcY5o2sdXb9ZgHMWgw7Zcrosmm9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsAnTTQwGmwuW221D4b/1+OXu9Y48XnE8aIABF/od00MItvq8pqfno+kxt/hTG7Wcxyan5us7LtxYQpOK8dn4ySbNKdTEXScZDwtvcKnH9BW/zTQJfyS1SJMfXeioava6J9ijm1yAysciOBe99NK/5mH8CeTveUd65jF0hr2P1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFLlqHZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43538C2BD10;
	Sun, 26 May 2024 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716738175;
	bh=w1hV+o9VMoEuHtxMcY5o2sdXb9ZgHMWgw7Zcrosmm9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFLlqHZj5dP1+EsmPRPfJRKKlDubmvVR2+GtJtV/+s6tuToyvZpYHHvYnanLKRlLx
	 JhwbPLXhz5pDWE8IYQjuPlhmqlhifCnTV46E7b6Sm2V/zXPfSzwmc3HOHYgBEO+bSy
	 +XZWocMZp2z/Yu+byru68egErXTi02yfF53W2Gvk3s6hPjQgKRLs/RN1GNKR8r8HOg
	 +FqMUrgk8d0s1VIqfFzx6z0e0mcVSuCDjHX89DGFPloL66xoFDIGBuQsIoZBmxRqGz
	 fUqafOP9CpI/X3VGbKFKpA5pdxQqgR4rCznXzpMhgFbjc//+wEV2nILhxmXU+GnSt5
	 45SXQ5WRfKKuw==
Date: Sun, 26 May 2024 16:42:50 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Mark Brown <broonie@kernel.org>,
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
Message-ID: <20240526-spotting-relapsing-ffb60b535c18@spud>
References: <CAMknhBE5XJzhdJ=PQUXiubw_CiCLcn1jihiscnQZUzDWMASPKw@mail.gmail.com>
 <20240514-aspire-ascension-449556da3615@spud>
 <CAMknhBFFpEGcMoLo5gsC11Syv+CwUM0mnq1yDMUzL1uutUtB+Q@mail.gmail.com>
 <20240516-rudder-reburial-dcf300504c0a@spud>
 <CAMknhBF_s0btus4yqPe-T=F3z7Asi9KkRGsGr7FHDFi=k4EQjw@mail.gmail.com>
 <20240519-abreast-haziness-096a57ef57d3@spud>
 <CAMknhBHvEse2FyDoBXR1PvymGpSGq8dotKfm+8XH+0+k+xKtQw@mail.gmail.com>
 <20240522-gullible-ibuprofen-cf9111c25f6f@spud>
 <5ad0b5782434eaf4cf565cffb0e4c14b7414ae38.camel@gmail.com>
 <6e929426-25fa-4e91-8790-0774d59b34e0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="38StDdanHQmO3L2P"
Content-Disposition: inline
In-Reply-To: <6e929426-25fa-4e91-8790-0774d59b34e0@baylibre.com>


--38StDdanHQmO3L2P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 10:05:49AM -0500, David Lechner wrote:
> On 5/23/24 7:15 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2024-05-22 at 19:24 +0100, Conor Dooley wrote:
> >> On Tue, May 21, 2024 at 09:54:39AM -0500, David Lechner wrote:
> >>> On Sun, May 19, 2024 at 7:53=E2=80=AFAM Conor Dooley <conor@kernel.or=
g> wrote:
> >>>>
> >>>> On Fri, May 17, 2024 at 11:51:58AM -0500, David Lechner wrote:
> >>>>> On Thu, May 16, 2024 at 4:32=E2=80=AFPM Conor Dooley <conor@kernel.=
org> wrote:
> >>>>>> On Tue, May 14, 2024 at 05:56:47PM -0500, David Lechner wrote:
> >>>>
>=20
> ...
>=20
> >> To remind myself, "Application 2" featured an offload engine designed
> >> specifically to work with a particular data format that would strip a
> >> CRC byte and check the validity of the data stream.
> >>
> >=20
> > I think the data manipulation is not really a property of the engine. T=
ypically data
> > going out of the offload engine goes into another "data reorder" block =
that is pure
> > HW.
> >=20
> >> I think you're right something like that is a stretch to say that that
> >> is a feature of the SPI controller - but I still don't believe that
> >> modelling it as part of the ADC is correct. I don't fully understand t=
he
> >> io-backends and how they work yet, but the features you describe there
> >> seem like something that should/could be modelled as one, with its own
> >> node and compatible etc. Describing custom RTL stuff ain't always
> >> strightforward, but the stuff from Analog is versioned and documented
> >> etc so it shouldn't be quite that hard.
> >>
> >=20
> > Putting this in io-backends is likely a stretch but one thing to add is=
 that the
> > peripheral is always (I think) kind of the consumer of the resources. T=
aking the
> > trigger (PWM) as an example and even when it is directly connected with=
 the offload
> > block, the peripheral still needs to know about it. Think of sampling f=
requency...
> > The period of the trigger signal is strictly connected with the samplin=
g frequency of
> > the peripheral for example. So I see 2 things:
> >=20
> > 1) Enabling/Disabling the trigger could be easily done from the periphe=
ral even with
> > the resource in the spi engine. I think David already has some code in =
the series
> > that would make this trivial and so having the property in the spi cont=
roller brings
> > no added complexity.
> >=20
> > 2) Controlling things like the trigger period/sample_rate. This could b=
e harder to do
> > over SPI (or making it generic enough) so we would still need to have t=
he same
> > property on the peripheral (even if not directly connected to it). I ki=
nd of agree
> > with David that having the property both in the peripheral and controll=
er is a bit
> > weird.
> >=20
> > And the DMA block is a complete different story. Sharing that data back=
 with the
> > peripheral driver (in this case, the IIO subsystem) would be very inter=
esting at the
> > very least. Note that the DMA block is not really something that is par=
t of the
> > controller nor the offload block. It is an external block that gets the=
 data coming
> > out of the offload engine (or the data reorder block). In IIO, we alrea=
dy have a DMA
> > buffer interface so users of the peripheral can get the data without an=
y intervention
> > of the driver (on the data). We "just" enable buffering and then everyt=
hing happens
> > on HW and userspace can start requesting data. If we are going to attac=
h the DMA in
> > the controller, I have no idea how we can handle it. Moreover, the offl=
oad it's
> > really just a way of replaying the same spi transfer over and over and =
that happens
> > in HW so I'm not sure how we could "integrate" that with dmaengine.
> >=20
> > But maybe I'm overlooking things... And thinking more in how this can b=
e done in SW
> > rather than what makes sense from an HW perspective.
> >=20
> >=20
> >> continuation:
> >> If offload engines have their own register region in the memory map,
> >=20
> >=20
> > Don't think it has it's own register region... David?
>=20
> I think the question here was if the CRC checker IP block (or descrambler=
 shown
> in the link below, or whatever) had registers in the offload/SPI controll=
er
> to control that extra part or if they had their own dedicated registers.

I don't think there was a question here at all. I was simply stating
that if the offload engine was not just a subordinate feature of the SPI
controller, but also provided additional data processing features then
treating the offload engine as a component of the SPI controller would
not be accurate.

> So far,
> these have been fixed-purpose, so have no registers at all. But I could s=
ee
> needing a register, e.g. for turning it on or off. In this case, I think =
it
> does become something like an io-backend. Or would we add this on/off swi=
tch
> to the AXI SPI Engine registers?

Seems to be that the CRC checking is a separate piece of IP though, and
so is not part of the offload engine at all, so my concern was
misplaced. I think whether or not you have registers to control it, it
should be represented in DT. How do you know it is there otherwise?

> Also, as shown in the link below, the extra bits share a clock domain wit=
h the
> AXI SPI Engine. So, yes, technically I suppose they could/should? be inde=
pendent
> consumers of the same clock like Conor suggests below. It does seems kind=
 of
> goofy if we have to write a driver just to turn on a clock that is already
> guaranteed to be on though.

You wouldn't necessarily need to write a driver for it, you could reach
out and turn it on from the backend consumer for example. And, obviously
there may be other ways that the FPGA design is configured where the
clock is not shared with the SPI controller or the offload engine.

--38StDdanHQmO3L2P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlNYegAKCRB4tDGHoIJi
0p//AP94S+X1TgXzvOP8jFQtnTOXCYT5iXNNaILC5azI/oPwmAEAhpLXc29r8igQ
eiVFFU2qSsUCwA+W1hiajgJZLdKtDQA=
=zON3
-----END PGP SIGNATURE-----

--38StDdanHQmO3L2P--

