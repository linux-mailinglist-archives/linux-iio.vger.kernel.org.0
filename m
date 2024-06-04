Return-Path: <linux-iio+bounces-5778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB34B8FBAF5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2401F214CA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D5114A600;
	Tue,  4 Jun 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2TEtUJB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B725814A4F3;
	Tue,  4 Jun 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523527; cv=none; b=ZvibLY/ZDagwtLunCh5gIj35qtAIAVgavQhEHs1n27bXfMxpUYzJLi3QvmofyXkYLPUT6YZ5Xi1BlpQNTZZC4Mf1Rd9aGeUD8dd5SB8Op6he4UtGGH4C3ccnB7MQ4n6h6sxla8aOzXeoFO82oRiUIzpiEAEAjsGg+0SOkeTkKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523527; c=relaxed/simple;
	bh=g/+clNdeDrCvJkbqS6hHDLJsY21YGq0LBFprJnyXIeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAON1aRauoHhv/ILNdFK5i2UygZzSinnpjXpyDDSVpaqdSS9rZ5n5IO9k/Y2EdUUiCwqfYQP8B+cqbqTbJ2abhhmhrP0HhKB27AtYoJUCEpj4V4GueWWtZa1R7fjdHk/qSqvi4JzojRO5sqIr9zBvsbl1qKQRbHWCXDiUPVqr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2TEtUJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B281BC32782;
	Tue,  4 Jun 2024 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717523527;
	bh=g/+clNdeDrCvJkbqS6hHDLJsY21YGq0LBFprJnyXIeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2TEtUJB7j/pNK5ZVvAoVsFUspTmkhCVpruoaiqeNIhk/cf2R0JHitTcQDCmcluNJ
	 f5x6nNN7kSuaJ9KlIv1KKfFXhjIT1KoSaK/hkwJ8h5dEZD0W/oOzSiT5Uzx0/2t+Pj
	 Qnmoa4ntu+tt2zl634jLTe9RiATwnWr+XoPfegjqQFhuSZ8e9n24YZDn/2voTk27gR
	 9cAzWM3NtX7b4A52yLqk2d1rAOrtkiUyWoBlaL0ewR9ej1h4xkKcaSm3MDfGuwIpR5
	 k31KOZemstIAb3c3zmiBx7ShTf2pkeTVx/xXnpsNzAUASzcyQO6fLAcPHWwbpYUy4t
	 qpnwb2uTPKdtQ==
Date: Tue, 4 Jun 2024 18:52:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
	linux-iio@vger.kernel.org, denis.ciocca@st.com,
	devicetree@vger.kernel.org, linus.walleij@linaro.org,
	robh+dt@kernel.org
Subject: Re: [PATCH v3] iio: accel: st_accel: add LIS2DS12
Message-ID: <20240604-trustable-duke-d70014e1cbff@spud>
References: <20240601192914.141906-1-kauschluss@disroot.org>
 <20240601-spouse-hurler-e7b93ac26f86@spud>
 <20240602095459.4a2cdc54@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kQCHB0RliGUnxLgJ"
Content-Disposition: inline
In-Reply-To: <20240602095459.4a2cdc54@jic23-huawei>


--kQCHB0RliGUnxLgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 09:54:59AM +0100, Jonathan Cameron wrote:
> On Sat, 1 Jun 2024 20:49:25 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Sun, Jun 02, 2024 at 12:56:41AM +0530, Kaustabh Chakraborty wrote:
> > > diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_=
accel_i2c.c
> > > index fd3749871121..329a4d6fb2ec 100644
> > > --- a/drivers/iio/accel/st_accel_i2c.c
> > > +++ b/drivers/iio/accel/st_accel_i2c.c
> > > @@ -102,6 +102,10 @@ static const struct of_device_id st_accel_of_mat=
ch[] =3D {
> > >  		.compatible =3D "st,lis2de12",
> > >  		.data =3D LIS2DE12_ACCEL_DEV_NAME,
> > >  	},
> > > +	{
> > > +		.compatible =3D "st,lis2ds12",
> > > +		.data =3D LIS2DS12_ACCEL_DEV_NAME,
> > > +	},
> > >  	{
> > >  		.compatible =3D "st,lis2hh12",
> > >  		.data =3D LIS2HH12_ACCEL_DEV_NAME, =20
> >=20
> > > diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_=
accel_spi.c
> > > index f72a24f45322..825adab37105 100644
> > > --- a/drivers/iio/accel/st_accel_spi.c
> > > +++ b/drivers/iio/accel/st_accel_spi.c
> > > @@ -64,6 +64,10 @@ static const struct of_device_id st_accel_of_match=
[] =3D {
> > >  		.compatible =3D "st,lis2dh12-accel",
> > >  		.data =3D LIS2DH12_ACCEL_DEV_NAME,
> > >  	},
> > > +	{
> > > +		.compatible =3D "st,lis2ds12",
> > > +		.data =3D LIS2DS12_ACCEL_DEV_NAME,
> > > +	},
> > >  	{
> > >  		.compatible =3D "st,lis3l02dq",
> > >  		.data =3D LIS3L02DQ_ACCEL_DEV_NAME, =20
> >=20
> > Any new compatibles need to be documented in st,st-sensors.yaml
>=20
> At the moment the st_sensors core is doing hard matching against whoami v=
alues
> which isn't good.  That should ideally be fixed and the binding for this
> device should use a fallback compatible if the statement about compatibil=
ity
> is accurate.

Ye, at worst, drivers should moan when the whoami value doesn't match...

> It may just be a case of relaxing the check in st_sensors_verify_id()
> to printing a warning not an error message and not returning an error code
> (reserving error returns in that function for bus error etc.

=2E..which seems to be what you suggest here.

> That doesn't need to be in this patch though.  Just have the fallback
> stuff in the binding and for now we can rely on matching the more
> precise compatible.

That seems ideal. At least get the ball rolling and make it more likely
that we'll direct future additions to fallbacks. With things like
sensors (and especially with the st driver) it can be hard for someone
like myself to figure out what is an isn't compatible without digging
through datasheets, and at least I would start asking.

--kQCHB0RliGUnxLgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9UQwAKCRB4tDGHoIJi
0sg+AQC2MGjMk0uJl1DV9pLwaAsyT8UYWogmCsrrP1f8QRlSawEAxoPZ5Z3RzfXN
UwQM2IwuDB8gwKrqECH/B5Uy/PBa1QA=
=nEaX
-----END PGP SIGNATURE-----

--kQCHB0RliGUnxLgJ--

