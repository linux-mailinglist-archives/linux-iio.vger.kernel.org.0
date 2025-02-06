Return-Path: <linux-iio+bounces-15081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFE6A2B099
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 19:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B6C3A26E3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1945B19D884;
	Thu,  6 Feb 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qB9g1E0u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E019D065;
	Thu,  6 Feb 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865819; cv=none; b=Z9+pYfnhjx/PTgpS6pkLOEXjum85K9FSzR8YNR4pQQJxq3yXcYjCw0TRcazHDvTUp/YaJGJwoiv5oNtbYAPSJhcc8dgUZ0NifVsTUD50XZEOt2xRvfF+ujr+/WBGgZrIPxDOt/VgQJ/PS2Rt8v+XFFNC1DMq9zWyM/uHcpY1noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865819; c=relaxed/simple;
	bh=Rp16LPq4atzj/2x6NItOSbnkpm6bl24xu//HZAo9K8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J58JVtApoBeP8uncbnwkKgotzXSr5NLwt7y6wFCsbU+08SPVH2h2B0Y/VG8QAOJHyQfFge4BnhuqhKFQd0Q5qLgSWXJG7N19VuyPM+N7wQDhODvWygX3gbf4WRyvMrepGWPdw7ifJ8Q35r4pmsJN22NRa2U8RexWLEPc48wwZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qB9g1E0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10616C4CEDD;
	Thu,  6 Feb 2025 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738865819;
	bh=Rp16LPq4atzj/2x6NItOSbnkpm6bl24xu//HZAo9K8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qB9g1E0upVXKf0Yi89P9uYwDsXu+vZgSSwkQpbE5V2oFXY8LoptD3sOxNwtoptx87
	 clCr33SJRha6h0v2A6pMZeFLQ6d+TR+gJXJln4QEaUyaFvkp67cfsw1mxCWowxmb1X
	 YGwUfyV8zs2Wj7E31uzj6Djs4CtPalJlM2BGGiaP9KU0KmSwBK6ICwILUCbtXye1ul
	 68vA3W4AM3+h/ByFlP20AfuXtcR3PzTLa4aBr1m3L+xZq+Zv2be7ImGkxAvENhcgCP
	 B+eWVyimrgWPKZ8iRiGAyNP9+TYR08CY3b2pRnD9LLio+/oYpAzk2L3z+F3KQ5TwfK
	 Res/TuGNQBJ9Q==
Date: Thu, 6 Feb 2025 18:16:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: ROHM BD79124 ADC/GPO
Message-ID: <20250206-supply-mortality-a2eca6c6a0fc@spud>
References: <cover.1738761899.git.mazziesaccount@gmail.com>
 <4e6cd143d3e896587528a415c8623ecd610fac55.1738761899.git.mazziesaccount@gmail.com>
 <20250205-stalemate-shorthand-5a29fbc4081f@spud>
 <76858097-10a8-403d-83a1-f70064f97a6c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pyNYRsL6mXJEqMtn"
Content-Disposition: inline
In-Reply-To: <76858097-10a8-403d-83a1-f70064f97a6c@gmail.com>


--pyNYRsL6mXJEqMtn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 10:39:19AM +0200, Matti Vaittinen wrote:
> On 05/02/2025 22:03, Conor Dooley wrote:
> > On Wed, Feb 05, 2025 at 03:34:29PM +0200, Matti Vaittinen wrote:
> > > Add binding document for the ROHM BD79124 ADC / GPO.
> > >=20
> > > ROHM BD79124 is a 8-channel, 12-bit ADC. The input pins can also be u=
sed
> > > as general purpose outputs.
> > >=20
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > > Revision history:
> > > RFC v1 =3D> v2:
> > >   - drop MFD and represent directly as ADC
> > >   - drop pinmux and treat all non ADC channel pins as GPOs
> > > ---
>=20
> ...
>=20
> > > +patternProperties:
> > > +  "^channel@[0-9a-f]+$":
> >=20
> > You can only have 8 channels, there's no need for this to be so
> > permissive, right?
> > Otherwise, this looks good enough to me.
>=20
> Thanks Conor!
>=20
> Indeed, I think we only need to accept channel@0 .. channel@7. Thanks!
> (And reason for this being permissive is ... drum roll ... copy-paste :)
> That's my main method of creating the yaml bindings. Swearing, sweating,
> copying and running the 'make dt_binding_check'
> :rolleyes:
>=20
> I'll wait for a while for comments to the other patches and fix this for =
v3
> :)

with it reduced,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--pyNYRsL6mXJEqMtn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ6T8lgAKCRB4tDGHoIJi
0u0fAP4hGiC88tfP2l+9PpU1bDRgbmosOv1HtZbaej4ko6+8TAD/RCgMp3IOuipP
FCi+3GOAuqWBRZgMF0xHFYquJJ1Ghgc=
=I437
-----END PGP SIGNATURE-----

--pyNYRsL6mXJEqMtn--

