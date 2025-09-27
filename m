Return-Path: <linux-iio+bounces-24513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBBBA6430
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 00:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FACC7AB67A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC921D3D2;
	Sat, 27 Sep 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjZrdZmo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B476715855E;
	Sat, 27 Sep 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012271; cv=none; b=k73shRqsajmfuV53aO3BXXev7106E5lBJnaLBSz6m2de7jsFh1Qz3iG5L6SPH3/Jm1EIeUjMcNU+evuJYwHvfx6TqVcIbk0AIQp7oHPb1QTN+gIQJuSDtQYiLxWPxANbd388+jsrVf/1lxFs83eD/ZJ9wTpNM4gAZQD+30w6rsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012271; c=relaxed/simple;
	bh=dBMCnwC/+O9FTfXLyAEIuZ0DdSHoOWe/DqAJ60jmJB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXNBPMCLBuk3iE0lhCDMvJZ2YctpL8l/hBfytPS1ZdeGaEcWAbpgJJlQvNAeQnkymjQFtoMHDqTzcgkg++2FeV9heY/tAE+rUg8s6hjDkXWDS7f/73n+y+hhIShvS1kZiKZ6IUEZGtNa/GPvRYStruLvpJ00JIpdyyF5ZaMIBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjZrdZmo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67297C4CEE7;
	Sat, 27 Sep 2025 22:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759012271;
	bh=dBMCnwC/+O9FTfXLyAEIuZ0DdSHoOWe/DqAJ60jmJB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjZrdZmoYtbyhNPG7F3XzGd74PCHvufvfo+0H4pTRUJOgLW05CU5xQyJU0hAvZTH0
	 MQzNCNFOrQ4I+JCd7yNy8sBQkyqb+D7P724ui6/6F4Hpl3vSStdYfv+7eS0QuIRSCS
	 ibjablqCjJSDSoaJE88jILyZ0wCwbn8kEJq9V+XNDp7LTbnvSkdi1FohOUtqNeerTy
	 akPCP+27p2SVL4GM4o/GpsFzYWxwwZaTa5PW4XdhbCyxFCkOuimLmztv+pp6PY69wY
	 jAU4sfYrinKIGI+A6CMi00v30UemeczhLqkgdUs+pb+fMHJ4F1kt1iS8f7ShwqNUyL
	 jrmxALXQ83jnQ==
Date: Sat, 27 Sep 2025 23:31:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/5] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator
Message-ID: <20250927-spoon-yearning-c1a8df796173@spud>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-1-bb61a401a0dc@bootlin.com>
 <20250925-pushchair-charity-9ccee20d8a6e@spud>
 <5331035.LvFx2qVVIh@fw-rgant>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dO2l03q4ujQbw8Xs"
Content-Disposition: inline
In-Reply-To: <5331035.LvFx2qVVIh@fw-rgant>


--dO2l03q4ujQbw8Xs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 05:59:48PM +0200, Romain Gantois wrote:
> Hello Conor,
>=20
> On Thursday, 25 September 2025 21:27:06 CEST Conor Dooley wrote:
> > On Thu, Sep 25, 2025 at 02:37:33PM +0200, Romain Gantois wrote:
> ...
> > > +properties:
> > > +  compatible:
> > > +    const: adi,ltm8054
> > > +
> > > +  enable-gpios:
> > > +    description: GPIO connected to the RUN pin.
> > > +    maxItems: 1
> > > +
> >=20
> > > +  lltc,fb-voltage-divider:
> > Why does this property have a ?linear? vendor prefix?
> > Shouldn't it be adi to match the other property and compatible?
>=20
> This component was originally from Linear Technology, before it was acqui=
red=20
> by Analog Devices. The new properties and compatibles have the Analog Dev=
ices=20
> prefix, but the "fb-voltage-divider" property is already used by the LTC3=
676=20
> and LTC3589 regulators, so I left the Linear Technology prefix for this o=
ne to=20
> avoid introducing a new property just to specify a vendor prefix change.
>=20
> I don't have a strong opinion about this though.

Do they share the same driver?

--dO2l03q4ujQbw8Xs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNhlqQAKCRB4tDGHoIJi
0t74AQCabvjJlJT7JwqpnsYqKxgYWhQ/m7pHQbMZB2cZ2tUcDgD/bwEavC33iHAB
OMsQgRoetYt6nmPa+Fm0cxjAGDT24wc=
=ACPw
-----END PGP SIGNATURE-----

--dO2l03q4ujQbw8Xs--

