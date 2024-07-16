Return-Path: <linux-iio+bounces-7636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35363932CC1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7811F245D6
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCEB19EEDB;
	Tue, 16 Jul 2024 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff73kK0S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EC1DDCE;
	Tue, 16 Jul 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145464; cv=none; b=hm1m4TZ7dA86q0FHMH011k9aiy0i8WULz5ptN8GmmfLu3Co3pj8EdejtV4JX6kLiSnrOWZdIiLN3ZXUpK+f1ALhRKxvQIn5VFjhB/V1JN4FazAqTIBMQDfemAmSHEW9Q0H1zdcJe9KpchCLE9FZB4w4YclW0C1DtZn0nTnr1rFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145464; c=relaxed/simple;
	bh=Zw/kZfjD/Bz3Q0bzXVETkeh8TLPo0MzUudpzhmC0zAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXCDGSS2MIuOU4llVHnPLX72OM+pDGRLxd4FNS0FVQkIs7PZ7Vw4F1jCr8o2JN8RevOCdktOubk195Iffv5PAFTyua+c6eQ1BQThYI3sBLBDxRnHZgwRHoepZgS8dbSj4/qh01di3VUV2n9zJbTBlli0HZEXfs6ERrpnfQMTy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff73kK0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E653C4AF0D;
	Tue, 16 Jul 2024 15:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721145464;
	bh=Zw/kZfjD/Bz3Q0bzXVETkeh8TLPo0MzUudpzhmC0zAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ff73kK0SsxtPU0jNZC8CPayq1bhwDTXqyhJn+xItFyiEzUlCQDoJiwDVojePN3xzO
	 v2FyMIXbXk1V+Im+sz1Vao6fB3N+USvJL73YFYyC4axFYEBFaxsLM9QKGas+MRg9/z
	 mvs46jiXAy2HRI+LCAlWsA6DAxnx/2+NFbc7JRfZaY/qyQM3rrJ2Uf1BhfjIKxHJDC
	 SFI6TDYWcUnAuwo6UK9SjujbSfXG/6BwhInFWZiW3iG/qCEOM9/6uqks5aHifMVqtd
	 6Sj9dz01eUXv5/9kiT5Nv42n392MRnb/t8hq67/SCQk1fwpv2p+PgH4Z6lLSwLqond
	 fC7FbGwjN6wMg==
Date: Tue, 16 Jul 2024 16:57:39 +0100
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
Message-ID: <20240716-supremacy-reseller-4fd6207d2099@spud>
References: <20240714133000.5866-1-kimseer.paller@analog.com>
 <20240714133000.5866-5-kimseer.paller@analog.com>
 <20240715-numbness-chooser-d1bcb0438ba5@spud>
 <PH0PR03MB7141E98ECA32AF462D3AFF15F9A22@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S/Sq9SflmPly9HBb"
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141E98ECA32AF462D3AFF15F9A22@PH0PR03MB7141.namprd03.prod.outlook.com>


--S/Sq9SflmPly9HBb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 01:50:23AM +0000, Paller, Kim Seer wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, July 16, 2024 12:18 AM
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
> > On Sun, Jul 14, 2024 at 09:29:58PM +0800, Kim Seer Paller wrote:
> > > Add documentation for ltc2664.
> > >
> > > Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> >=20
> > IIRC I gave you a reviewed-by on v5, was there a particular reason you =
didn't
> > add it?
>=20
> I made changes to the 'output-range-microvolt' logic in v6, which I thoug=
ht
> might require a new review. If your 'Reviewed-by' tag still applies, plea=
se let me know.

IIRC what I said was along the lines of "with the logic from the
previous version, Reviewed-by: Conor Dooley <conor.dooley@microchip.com>".
Is that what you did?

--S/Sq9SflmPly9HBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpaYcwAKCRB4tDGHoIJi
0jtJAQD4yF6w6+ILWKBYeXOSNpSJMoQxbyyP3ys/dPPXs0r7cQD9FU17Mb2OWwUC
6JzcppMb0rWtnUWlH75LHLKz1jPMPgo=
=EUfU
-----END PGP SIGNATURE-----

--S/Sq9SflmPly9HBb--

