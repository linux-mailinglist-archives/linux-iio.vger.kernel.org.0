Return-Path: <linux-iio+bounces-15052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48401A29A6A
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594F47A3AE0
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1296920C026;
	Wed,  5 Feb 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDykrvRI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B7155335;
	Wed,  5 Feb 2025 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785163; cv=none; b=uYo2USIc9ArQOy+amGX0+s6YpdMw1wvdCirYKHVFvT4jcZevJHgAzCHxMgdVApwjJS7zayIZgCh+wqJ2tRUClm/Yr5KQFGf38M6lMgkcff4p253jepb4JHNRt9Y+0QPXBBzj1AUvG0bEcc3b9Rjuf/dr3CW11ewbyvVJA41w1eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785163; c=relaxed/simple;
	bh=Bv6VrTP0baa+38fXseu4H6lY+zxHwgylRB0FdkDUSv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYPFi0qA328nLsbRRc+l5flrBGt8v/I1nf95aHkkyIKJtKkXyjaOGri/dRtKG3AYVdJ96p3ylVhzZ/1ght2HV6SJEMm92fOOoRk7qGeoEtYCGwXtCXMqJpGCNE/c4kk0doAsGKvIfKEBJOCYNMtAtHKbWNpfIRjMPYTAc2pzmVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDykrvRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805E4C4CED1;
	Wed,  5 Feb 2025 19:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785163;
	bh=Bv6VrTP0baa+38fXseu4H6lY+zxHwgylRB0FdkDUSv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDykrvRIMHbvX2mkngYAekcdYAG5dkg+dAn3mJ2JH1XFIT9ma3sgfRLwhaJuxO7Ju
	 F9+udl/dTzHzQ14BLhanNF81ncBD8jux3Ete2Hk3iOA1Z+NCusnqGtu48Fxw7+F99V
	 8GEylz8uYSUIAWMgzDyZUu/91RETYGwprdnEI9Pe9nkffkJ0jbxcTQvnpxnAZ4J3rf
	 gUWl+jcgEwJgrcnJq3l0E8kQLvCy8D9Q0MQZqZkLPwN1vX9Y2YU1C5uw1zLI180r56
	 eyy7K+q4urdcy9FzmGLhjqrih5+Kouj7FV62nX+xizjCIsCzqqtqWmXPd24fyd+9Nm
	 4X1NZcgc0Q20Q==
Date: Wed, 5 Feb 2025 19:52:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Robert Budai <robert.budai@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Paul Cercueil <paul@crapouillou.net>,
	David Lechner <dlechner@baylibre.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20250205-styling-chirpy-79eae9437b3b@spud>
References: <20250204143612.85939-1-robert.budai@analog.com>
 <20250204143612.85939-5-robert.budai@analog.com>
 <20250204-helium-marbled-a0863a0a18a8@spud>
 <15065d0cd19f39d92ce860cd03802c368df74b34.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qKt5HoGX5mxGGLac"
Content-Disposition: inline
In-Reply-To: <15065d0cd19f39d92ce860cd03802c368df74b34.camel@gmail.com>


--qKt5HoGX5mxGGLac
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 04:11:51PM +0000, Nuno S=E1 wrote:
> On Tue, 2025-02-04 at 19:25 +0000, Conor Dooley wrote:
> > On Tue, Feb 04, 2025 at 04:36:08PM +0200, Robert Budai wrote:
> > > Document the ADIS16550 device devicetree bindings.
> > >=20
> > > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > > ---
> > >=20
> > > v6:
> > > - applied blank line suggestions
> > > - added clock-frequency dependency change suggestions
> > > - yamllint corrections
> > >=20
> > > =A0.../bindings/iio/imu/adi,adis16550.yaml=A0=A0=A0=A0=A0=A0 | 83 +++=
++++++++++++++++
> > > =A0MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 9 ++
> > > =A02 files changed, 92 insertions(+)
> > > =A0create mode 100644
> > > Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.=
yaml
> > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > new file mode 100644
> > > index 000000000000..8750bb937979
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > @@ -0,0 +1,83 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices ADIS16550 and similar IMUs
> > > +
> > > +maintainers:
> > > +=A0 - Nuno Sa <nuno.sa@analog.com>
> > > +=A0 - Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > +=A0 - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > +
> > > +properties:
> > > +=A0 compatible:
> > > +=A0=A0=A0 enum:
> > > +=A0=A0=A0=A0=A0 - adi,adis16550
> > > +
> > > +=A0 reg:
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 spi-cpha: true
> > > +=A0 spi-cpol: true
> > > +
> > > +=A0 spi-max-frequency:
> > > +=A0=A0=A0 maximum: 15000000
> > > +
> > > +=A0 vdd-supply: true
> > > +
> > > +=A0 interrupts:
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 reset-gpios:
> > > +=A0=A0=A0 description:
> > > +=A0=A0=A0=A0=A0 Must be the device tree identifier of the RESET pin.=
 If specified,
> > > +=A0=A0=A0=A0=A0 it will be asserted during driver probe. As the line=
 is active low,
> > > +=A0=A0=A0=A0=A0 it should be marked GPIO_ACTIVE_LOW.
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 clocks:
> > > +=A0=A0=A0 description: If not provided, then the internal clock is u=
sed.
> > > +=A0=A0=A0 maxItems: 1
> > > +
> > > +=A0 clock-frequency:
> > > +=A0=A0=A0 description: Clock frequency in Hz when an external clock =
is used.
> > > +=A0=A0=A0 oneOf:
> > > +=A0=A0=A0=A0=A0 - minimum: 1
> > > +=A0=A0=A0=A0=A0=A0=A0 maximum: 128
> > > +=A0=A0=A0=A0=A0 - minimum: 3000
> > > +=A0=A0=A0=A0=A0=A0=A0 maximum: 4500
> >=20
> > I don't get why this is a property, to be honest. When you've got an
> > external clock, why isn't the frequency obtained from the clock provider
> > node?
> >=20
>=20
> The main purpose of this property is actually to show/document the constr=
ains of
> the external clock. We can very well just error out in the driver (and we=
 do
> that) and not have this property. I mentioned this property to Robert some
> revisions ago and I also pointed out that I wasn't really sure if it shou=
ld be
> used or not=A0(I guess this is more for fixed clock providers...). IIRC, =
I did
> asked for some advice/comments but we got none so I assume Robert just de=
cided
> to use it and see what you guys had to say about it.

NGL, this is one of the kinda of things where if you're relying on
dt-bindings to avoid cocking up your board design, things have already
gotten pretty badly wrong! That said, "clock-frequency" is a
property for cpus, fixed-frequency clock providers and i2c buses, you'd
need a vendor prefix and a unit suffix here IMO. Also, I don't really
think that it actually does anything at all, given it does not constrain the
clock you're linking to with the clocks property. This may as well just be
a comment in the description of the clocks property, for all that it does.

--qKt5HoGX5mxGGLac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6PBhQAKCRB4tDGHoIJi
0jALAP9HiOmol4F0aUFuG4sftrs9MLQ+t4nmrapcxBFu3CQq9QD/XltVxGmoV5j0
Hh57FFzdGdKr5OdxpNhJMsJo9aQ6OQw=
=jbCM
-----END PGP SIGNATURE-----

--qKt5HoGX5mxGGLac--

