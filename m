Return-Path: <linux-iio+bounces-15505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB10A34F27
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 21:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28DA16DDE2
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14824BC19;
	Thu, 13 Feb 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqdZwsfx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58132222DE;
	Thu, 13 Feb 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477733; cv=none; b=XxedS2Ad6IAUwDySCl5mgvog7jFBRo5VuVY+J/AxhcZITwtPDYQbEk+vCen2SugVeBqUYX6KSzDM72/vbJVjhhK0tSW1tc1B7U4+/nQUPeEe9m0D/BMkwQWr5Rn4QngcYDQ7DqbflaHic3+lhTdg6gof3F8Br9FnESYK9zENk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477733; c=relaxed/simple;
	bh=gFS8GPR4Ajl60UP7+4KVw9gDH4TZ0PhIA+MKoUXArxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml4M4yEPNAPXsipqUw65uv+IYHENcdt53D2Od1wV6Y5/9raUZsydxzaIt26tDvCbcc5BkEI+9U5rSH/SSa9oCTDiadFN1yIJ7AyNZDcTqoDmrS665o+4lJ+MAyYQgoLurYK6eIV9VsrJe445HbBSbiPGqDYSRu+Cwn8TH3Bt1PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqdZwsfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39819C4CED1;
	Thu, 13 Feb 2025 20:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477733;
	bh=gFS8GPR4Ajl60UP7+4KVw9gDH4TZ0PhIA+MKoUXArxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TqdZwsfx82xJagVlpspFyy/Vqw95aHWlQwiSyeXIdxGnjLmYIMhY9zqVEA+DoEkY4
	 lcDlxACjZbZmLgFNIlt9Ic2vOKl/55wjlk8re2mb/TUUQGNz58EYUwWf8QXmPN/+rK
	 Wogs0dSQiqmX5ixXI1DeRb7X7BPfxILNLZn/8nGD2EMu+G+3qMmMm0lqjN8SC3YiJh
	 4LSMSWX8nax7zC6KcxhBb2PCP4xlaIths1HfnKr1/3Y/vsS9y18Bdt6oUU0dW0hXok
	 1WsvsGjcng0HOhvXddBUxeF5NBXUermedA2vQUJwBlr8ideBdv4vsOXs4kdHZ0PWh4
	 jauAh15stszMQ==
Date: Thu, 13 Feb 2025 20:15:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a
 support
Message-ID: <20250213-reflex-earlobe-ebbeaece6fad@spud>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-2-clamor95@gmail.com>
 <20250212-unwritten-compile-7011777a11b3@spud>
 <CAPVz0n0xR_nGPdWn800H=HhMCPqnRUhqP-s1P4eMhtpZdxpxzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7dqWvGhGUC+okugZ"
Content-Disposition: inline
In-Reply-To: <CAPVz0n0xR_nGPdWn800H=HhMCPqnRUhqP-s1P4eMhtpZdxpxzg@mail.gmail.com>


--7dqWvGhGUC+okugZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 09:39:06PM +0200, Svyatoslav Ryhel wrote:
> =D1=81=D1=80, 12 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 21:20 Co=
nor Dooley <conor@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Wed, Feb 12, 2025 at 08:46:55AM +0200, Svyatoslav Ryhel wrote:
> > > AL3000a is an ambient light sensor quite closely related to
> > > exising AL3010 and can re-use exising schema for AL3010.
> >
> > Quite close you say, but the driver is entirely different it seems. How
> > closely related is the hardware itself?
> >
>=20
> Well, I can simply duplicate al3010 or al3320a schema if re-using
> schema is not allowed. AL3000a has no available datasheet online.
> Downstream code for al3000a and al3010 seems to have same principles,
> apart from light measurements.

It's probably more of a question as to why you're duplicating the driver
for them, rather than telling you not to put both bindings together.
That said, information on what's actually different is helpful in the
binding, to explain why you're not using a fallback compatible etc.

>=20
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++=
--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al=
3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.ya=
ml
> > > index a3a979553e32..6db4dfd5aa6c 100644
> > > --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.ya=
ml
> > > +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.ya=
ml
> > > @@ -4,14 +4,16 @@
> > >  $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
> > >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > >
> > > -title: Dyna-Image AL3010 sensor
> > > +title: Dyna-Image AL3000a/AL3010 sensor
> > >
> > >  maintainers:
> > >    - David Heidelberg <david@ixit.cz>
> > >
> > >  properties:
> > >    compatible:
> > > -    const: dynaimage,al3010
> > > +    enum:
> > > +      - dynaimage,al3010
> > > +      - dynaimage,al3000a
> > >
> > >    reg:
> > >      maxItems: 1
> > > --
> > > 2.43.0
> > >

--7dqWvGhGUC+okugZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ65S3gAKCRB4tDGHoIJi
0pBLAP9DAfvM0GW8mfJUiDrGHRO8QboPxmy+oxCqMZyJ3p0YuwD/VCGGvaVtnZ7a
l9NBlucIVYIqUW1e7vIi8IqvOfjpdgs=
=U7G9
-----END PGP SIGNATURE-----

--7dqWvGhGUC+okugZ--

