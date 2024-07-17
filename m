Return-Path: <linux-iio+bounces-7656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEE4933E90
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 16:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E745D1C22A3B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DB181BA7;
	Wed, 17 Jul 2024 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBZbTHut"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753D181304;
	Wed, 17 Jul 2024 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226836; cv=none; b=VHVcJnV6JWwplMKFhbe0tRPXvfg0qBCOwqFbUx8VRKFiK3Z9vEBlbs0E1W65uUaPRwOTanN5j9mSN9BLZWol8xwkTw1ElB6ZITZqMfVDS+M1huEJl/iJVMV7Ba8LFhrAtXPHFnB0aS99q44lMfbjKIJ+FhNPw9QbvnR+JN/Wd0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226836; c=relaxed/simple;
	bh=w2+bIdqSNI97n8C7JrsfM4dq2BUfqKSNscACXgdMYdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k05aZVHwOyAaI6k28Y1UmkOzTBEyOpbiiY0UqoiFT4RR1/64VZsAnqWU+j/oZUqx1fg8yK4Ch7oUderrvBhomyCSHtfGIg/93GgKTAeMZemxpugKnsIjGKuGU4Gfn9E5RZF6g2s5RyRpC+4scbXRlaJREgsW/BGOFtYcCbULYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBZbTHut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67534C4AF0D;
	Wed, 17 Jul 2024 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721226836;
	bh=w2+bIdqSNI97n8C7JrsfM4dq2BUfqKSNscACXgdMYdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBZbTHutpUvMn9TUlZxaRQoTgdwHSJmWD4tV9Ve4Lv7fnP5ZIv3AFNEd6iclTdzVx
	 /w+mZpnYEgCnt9xKXcZZeiL5lwL7Ys5tARW82mdl/7PHP4bM0B3dKKiYBkfZF3CNrM
	 3kHFAha4cbCsoYmapoSzX73XbPQTtNM3ajt53crwuSYeSuF2imy+QPeABXC/70UPnT
	 D2XaSM+bvcigrGKYjKkFG0JGSNLE+ENKN8c3Ys46EtlOG/MonRtJ+bAnB3p15v4H7h
	 rjqUCB+V7aROMDrPy478kBR3sJ99Hj0sj9mN4QmUdsKEA/VtCZTJN5FZ9D0mKuZW5h
	 f/62GRzcYXOmg==
Date: Wed, 17 Jul 2024 15:33:51 +0100
From: Conor Dooley <conor@kernel.org>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
Message-ID: <20240717-pardon-sake-56850ddca236@spud>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
 <20240714133000.5866-5-kimseer.paller@analog.com>
 <20240715-numbness-chooser-d1bcb0438ba5@spud>
 <PH0PR03MB7141E98ECA32AF462D3AFF15F9A22@PH0PR03MB7141.namprd03.prod.outlook.com>
 <20240716-supremacy-reseller-4fd6207d2099@spud>
 <PH0PR03MB7141D593AF504A455AABA4D6F9A32@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PH6SsJ94HfDMsrEg"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141D593AF504A455AABA4D6F9A32@PH0PR03MB7141.namprd03.prod.outlook.com>


--PH6SsJ94HfDMsrEg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 01:07:31AM +0000, Paller, Kim Seer wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, July 16, 2024 11:58 PM
> > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> > Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> > Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> > Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Hennerich, Michael
> > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > Subject: Re: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.yaml
> >=20
> > [External]
> >=20
> > On Tue, Jul 16, 2024 at 01:50:23AM +0000, Paller, Kim Seer wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > Sent: Tuesday, July 16, 2024 12:18 AM
> > > > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > > > Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> > > > devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; Da=
vid
> > > > Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.d=
e>;
> > > > Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> > <broonie@kernel.org>;
> > > > Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> > > > <krzk+dt@kernel.org>; Rob Herring <robh@kernel.org>; Conor Dooley
> > > > <conor+dt@kernel.org>; Hennerich, Michael
> > > > <Michael.Hennerich@analog.com>; Nuno S=E1 <noname.nuno@gmail.com>
> > > > Subject: Re: [PATCH v7 4/6] dt-bindings: iio: dac: Add adi,ltc2664.=
yaml
> > > >
> > > > [External]
> > > >
> > > > On Sun, Jul 14, 2024 at 09:29:58PM +0800, Kim Seer Paller wrote:
> > > > > Add documentation for ltc2664.
> > > > >
> > > > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > >
> > > > IIRC I gave you a reviewed-by on v5, was there a particular reason =
you
> > didn't
> > > > add it?
> > >
> > > I made changes to the 'output-range-microvolt' logic in v6, which I t=
hought
> > > might require a new review. If your 'Reviewed-by' tag still applies, =
please let
> > me know.
> >=20
> > IIRC what I said was along the lines of "with the logic from the
> > previous version, Reviewed-by: Conor Dooley <conor.dooley@microchip.com=
>".
> > Is that what you did?
>=20
> Yes. Additionally, considering Krzysztof's recent comment about the mixed=
=20
> indentation in the example section, should I send a new patch version that
> includes this indentation fix along with adding your Reviewed-by tag?

Seems reasonable to me, thanks.

--PH6SsJ94HfDMsrEg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpfWTwAKCRB4tDGHoIJi
0s3UAP4ypPKFqaRNt2kJ/x4C3E+ZEoFY2smeG445ObGxYWRMWAEAh4rqsXT0X/FF
LtGOAEwC/5bJ8z0365Mm60HRk9slUAE=
=ueDx
-----END PGP SIGNATURE-----

--PH6SsJ94HfDMsrEg--

