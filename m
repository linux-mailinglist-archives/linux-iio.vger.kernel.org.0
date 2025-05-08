Return-Path: <linux-iio+bounces-19308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B72CAAFDAC
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 16:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35964C6E20
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7227876E;
	Thu,  8 May 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egxYxSVm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E621DC988;
	Thu,  8 May 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715686; cv=none; b=eLfhxHleL3Rp+53D/ZdbPaUF7eVkhh56IVccb7vYE1zV8yZky/HgZg3kwaDvruHN8ukDTZiEx3Q72EMrd4CoX5cPtKUlRzlv0MMVVLIh9J2S5bI3jzF+rgzeJh87o/yQJI4WdCCNeRbYI1xrjZPAWYbJH0gYUEqbB6ncZ7jhZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715686; c=relaxed/simple;
	bh=FMMo1NiH6RdH+2yuH9IfA46b5LATQ4bbazGrNJmBDSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaD+aM4J9GnrtkI1SoGar2+mgZ6Q9KH+iilCeDARg6yoSx1j7vLQevaAFh7SNGaj8TqyAwGZ5spXWpIZOj2ZBJv2Jz3dMJ1MiWbcQzD8TSvm4ltdtXdlZ7arj1mRShkyzLqb0N27VCV4bfOuN5npU5gM2t++NDkDotvauZMdZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egxYxSVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F7DC4CEE7;
	Thu,  8 May 2025 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746715686;
	bh=FMMo1NiH6RdH+2yuH9IfA46b5LATQ4bbazGrNJmBDSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egxYxSVms4ygR1CTUZWw7Vs835GYMgta3+GdB3YM281qfW3LLrSDdQ83RD4jSrHfC
	 luLg84ovwNTl6CLIiMMD+AMgqFX+ytvymVfA+4L8GCw/Ef6vkajGECJ7IiODC3ph7j
	 ou+K7TPtig4arEMS2FdSZLageLoZBXKGYAbmhUl27ACtkGGVXFi7+JaU5NkjGJvl+d
	 /Lu7A0MBauiTuHXSws5kO9k3UoaKx3bEPSN96ic+ud/WG9IPB88cXMs2jw2r4Oz9fb
	 uaR5n6N/jgPUu1T1s2UDeTzxrHYZQDiZcylBpV/2SZX4lbLgRSxLbKT9j1nSRsGACD
	 CrARvwpDvQhxw==
Date: Thu, 8 May 2025 15:48:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: adc: adi,ad7606: add gain
 calibration support
Message-ID: <20250508-everybody-tissue-b7bfb726ae99@spud>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
 <20250508-wip-bl-ad7606-calibration-v4-4-91a3f2837e6b@baylibre.com>
 <174670267187.3889412.7858960687511929039.robh@kernel.org>
 <bttbhfjxwtfc4rxqde5rc6s6gqpgutsya4s2mezjl5t37yuuoh@lgayj2yp2mva>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0GRueCO7wZXO4BSF"
Content-Disposition: inline
In-Reply-To: <bttbhfjxwtfc4rxqde5rc6s6gqpgutsya4s2mezjl5t37yuuoh@lgayj2yp2mva>


--0GRueCO7wZXO4BSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 02:09:12PM +0200, Angelo Dureghello wrote:
> Hi Rob,
>=20
> On 08.05.2025 06:11, Rob Herring (Arm) wrote:
> >=20
> > On Thu, 08 May 2025 12:06:08 +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Add gain calibration support by a per-channel resistor value.
> > >=20
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > >  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 29 ++++++++++++=
++++++++++
> > >  1 file changed, 29 insertions(+)
> > >=20
> >=20
> > My bot found errors running 'make dt_binding_check' on your patch:
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> >=20
> >=20
> > doc reference errors (make refcheckdocs):
> >=20
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2025=
0508-wip-bl-ad7606-calibration-v4-4-91a3f2837e6b@baylibre.com
> >=20
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
> >=20
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >=20
> > pip3 install dtschema --upgrade
> >=20
> > Please check and re-submit after running the above command yourself. No=
te
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> > your schema. However, it must be unset to test all examples with your s=
chema.
> >=20
>=20
> I am getting no errors at all by:
>=20
> make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings=
/iio/adc
> make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings=
/iio/adc/adi,ad7606.yaml

I think the bot do be wildin'

--0GRueCO7wZXO4BSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzEIQAKCRB4tDGHoIJi
0jncAP9zBkLBBhL3hxzr33U8uvRkUaMRmvcdksf89pNUNEjlKQD/X1d9vV8GohTT
i2nIb12grgxv2NSgsE6Z2ibdBEorEQY=
=q2tQ
-----END PGP SIGNATURE-----

--0GRueCO7wZXO4BSF--

