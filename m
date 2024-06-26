Return-Path: <linux-iio+bounces-6969-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D1E918655
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DBA28290F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385CB18E758;
	Wed, 26 Jun 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZQ2DnBV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D736FEEDD;
	Wed, 26 Jun 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417337; cv=none; b=K9ZeLcYB7981XWrJztu7g+HqE9/dd9Vdn8x7mnewF+t1t/zMNz7NiBAAUkW87zdBNb+lwO+0TXT5Tkasw1GCsHEBI/C+ddXDATUPkITgpupadc7tTzwBqRaP2QqLYoJZqltvuDCUteOzt9S2Nm8QOjoPmzQVJnHK1gM8pqCoYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417337; c=relaxed/simple;
	bh=aZhjheroGM3PhnAd8eVih56JfOOjzPFgLT/88yyoZpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DA8PiR6gtzsKou9W57VNrdwoeKShYBvAK92MsD/EOR2Dy/09EXqUPaQVivTFps46D2XxPjLBqC83IbUSHOrKTAjDhBiknT8eWiGymZAY3KQrymcZNO2v3UlpH4sW3ONZGKr7vM510vydTWZi59CFxW8hUiym7I8MGaRPrWyUhfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZQ2DnBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFECC116B1;
	Wed, 26 Jun 2024 15:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417336;
	bh=aZhjheroGM3PhnAd8eVih56JfOOjzPFgLT/88yyoZpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZQ2DnBVDYfMqGSFTFT4EziRBaW0rA55SWt2gP9D2wnkXstId0laKpOMpq3PenGwj
	 ojUA6s9LK6AD+OTNwqq5SWAj4x2yH3k8o40HtlNmZOE1ZoMgrgIYjdFX9d4PxUsgD/
	 Y2Xq64DvLhoh7rCyaq2+cDH8xQi2uWxGiiifcaeN7TIwvljCkICGHJdvJRyM8NTVZ6
	 /UAoctTCx8XpxBNKwYVZGI5Lc0DXDFEOK+AcLNdDLRMLpREH2tOcPfgAza2j1wb8P8
	 RpiQg52ci5SMpyVShui2ai3Nxxopi/mRyjI9+Syk7jDitjj1ZCgmIY66QEub11GNWW
	 7bxw6EoDG1vVA==
Date: Wed, 26 Jun 2024 16:55:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/7] dt-bindings: iio: adc: Add AD4000
Message-ID: <20240626-corny-haunt-c4b4e0bae170@spud>
References: <cover.1719351923.git.marcelo.schmitt@analog.com>
 <10678612efbbd97bb47a31f4a062607cf35b03f9.1719351923.git.marcelo.schmitt@analog.com>
 <20240626-handbrake-mustang-38c2aab3f04b@spud>
 <ZnwY4MqCYFKUNtL3@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WsUBhFv2b0Y63I3q"
Content-Disposition: inline
In-Reply-To: <ZnwY4MqCYFKUNtL3@debian-BULLSEYE-live-builder-AMD64>


--WsUBhFv2b0Y63I3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 10:34:24AM -0300, Marcelo Schmitt wrote:
> On 06/26, Conor Dooley wrote:
> > On Tue, Jun 25, 2024 at 06:55:03PM -0300, Marcelo Schmitt wrote:
> > > Add device tree documentation for AD4000 series of ADC devices.
> > >=20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad4000.yaml          | 190 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   7 +
> ...
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - const: adi,ad4000
> > > +      - items:
> > > +          - enum:
> > > +              - adi,ad4004
> > > +              - adi,ad4008
> > > +          - const: adi,ad4000
> >=20
> > > +      - const: adi,ad4001
> > > +      - items:
> > > +          - enum:
> > > +              - adi,ad4005
> > > +          - const: adi,ad4001
> >=20
> > > +      - const: adi,ad4002
> > > +      - items:
> > > +          - enum:
> > > +              - adi,ad4006
> > > +              - adi,ad4010
> > > +          - const: adi,ad4002
> >=20
> > > +      - const: adi,ad4003
> > > +      - items:
> > > +          - enum:
> > > +              - adi,ad4007
> > > +              - adi,ad4011
> > > +          - const: adi,ad4003
> >=20
> > > +      - const: adi,ad4020
> > > +      - items:
> > > +          - enum:
> > > +              - adi,ad4021
> > > +              - adi,ad4022
> > > +          - const: adi,ad4020
> >=20
> > > +      - const: adi,adaq4001
> >=20
> > > +      - const: adi,adaq4003
> >=20
> > I think some blank lines, maybe like the above, would go a long way with
> > this list of compatibles.
> >=20
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  spi-max-frequency:
> > > +    maximum: 102040816 # for VIO > 2.7 V, 81300813 for VIO > 1.7 V
> > > +
> > > +  adi,sdi-pin:
> > > +    $ref: /schemas/types.yaml#/definitions/string
> > > +    enum: [ high, low, cs ]
> >=20
> >     enum: [ high, low, cs, sdi ]
> >     default: sdi
> >=20
> > I'd do this, so that the default is documented in the binding, not in
> > the description text.
> >=20
> > Otherwise, this looks good to me.
>=20
> Ack, will do.

With those,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--WsUBhFv2b0Y63I3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnw58wAKCRB4tDGHoIJi
0iTxAQDZvlnSXLuFR5FfpYAXVuqG0jsGWFbU4Y8aZbmRMtE/NQD/dQkJmaR2py6B
eySLOx9DCP6+56PfTnOXvKH2I4gm6gc=
=LhQS
-----END PGP SIGNATURE-----

--WsUBhFv2b0Y63I3q--

