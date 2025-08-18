Return-Path: <linux-iio+bounces-22933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F32B2AF42
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E0DD4E3642
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CC2356A4;
	Mon, 18 Aug 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+WMttaC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C321F91C8;
	Mon, 18 Aug 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537614; cv=none; b=hTUEDrj+naFSTWauBg4dfHku53lm6J4XV1aj5ZZiV1xykm9DYUwygnpHwjaTiEa3YcwkCOab+yc5bcLq5nW/EAcFfe9ZlG2VYPkpj4eh1nxkSQ3C1U4cAnOuXJzDV4dz8Q9zA3bIO02I5ofj/g1bEjyoo7mG1VWysl6hFV7uiC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537614; c=relaxed/simple;
	bh=E11dK3FYT6Ml9nmOMIUnAM2Fz9JmU9Xtv7UOfHCb+tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7DzgwjN7u+H3O5vqzjoiLova/7SKn6VjKYk6FMDZ/xVfG93OAjG7tqFV+8tE5qO7HecphKw7soF161BW3dDUDBNve/uSHyTlDfzLvLO/vGUuOEgFSfluAap2GMbEPMAJJ+UGHcpa28dh7A7fcc4HC6dwg4KFEEacBMKohO0gKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+WMttaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7DFC4CEEB;
	Mon, 18 Aug 2025 17:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755537614;
	bh=E11dK3FYT6Ml9nmOMIUnAM2Fz9JmU9Xtv7UOfHCb+tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K+WMttaC1O9hi7rpl97qqYudfL+t/uXf2mSgraCsYPeY0vM2WBHSWS3pd7KEWJUJm
	 Ecpvjck+wpvCaQMDe5bGhUEvw6LJBvDteImw1JEZGMGc3B50YjSVz7tmxjV09HDqDP
	 +eeE0zjwHOUYMByjPEZx8eooKcBFXQScN+RjvKJa++U5++pBOyRIhMWV1wX12t1mfz
	 fkyn8R3F2kdyiNYFCPKzcFxulNMsphTFqVJADTfbskRNTVfh41ZAmyRyQKsvv25Zmi
	 jNkPT3W3Nz2IwKt35WDvY1PB/an3jvLQdi8ebOAR5K9twveAnOt0g1JfH2e0fu7CWG
	 k2GxGLzRAWIAA==
Date: Mon, 18 Aug 2025 18:20:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ben Collins <bcollins@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Ben Collins <bcollins@watter.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: iio: mcp9600: Add microchip,mcp9601
 and add constraints
Message-ID: <20250818-platinum-elude-894088c738d2@spud>
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-2-bcollins@kernel.org>
 <cb826943-69d8-4fc9-8597-fbb2439f04f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9HYvEexqxeK9/fff"
Content-Disposition: inline
In-Reply-To: <cb826943-69d8-4fc9-8597-fbb2439f04f2@kernel.org>


--9HYvEexqxeK9/fff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 08:28:30AM +0200, Krzysztof Kozlowski wrote:
> On 18/08/2025 05:59, Ben Collins wrote:
> >    interrupts:
> >      minItems: 1
> > -    maxItems: 6
> > +    maxItems: 4
>=20
> Why?
> I did not find explanation of this in commit msg.

It's also not correct, since the outermost constraint remains 6 after
the patch, so the if/else should reduce the constraints, rather than
increase it as is done here.

>=20
> > =20
> >    interrupt-names:
> >      minItems: 1
> > -    maxItems: 6
> >      items:
> > -      enum:
> > -        - open-circuit
> > -        - short-circuit
> > -        - alert1
> > -        - alert2
> > -        - alert3
> > -        - alert4
> > +      - const: alert1
> > +      - const: alert2
> > +      - const: alert3
> > +      - const: alert4
>=20
> Neither this and it is ABI break. ABI breaking needs clear reasoning why
> and some evaluation of impact on users.

I think it should be a standalone patch too, since it is a fix for the
existing mcp9600 device rather than something for the mcp9601 device
that is being added by this patch...
>=20
>=20
> > =20
> >    thermocouple-type:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > +    default: 3

As is this, which is codifying the existing restriction rather than
being something new as 0x03 is what THERMOCOUPLE_TYPE_K is defined to
be.

> >      description:
> >        Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
> >        Use defines in dt-bindings/iio/temperature/thermocouple.h.

--9HYvEexqxeK9/fff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKNgyQAKCRB4tDGHoIJi
0sXWAP9JCGXBBPthOxpSomXlDG+knctam0O5gcVjqRNdWIOQWgD/encff2KHr1D9
Eg2Om5A2W7Nc+HhhOR1lpLQRmmqeDwg=
=ZxR8
-----END PGP SIGNATURE-----

--9HYvEexqxeK9/fff--

