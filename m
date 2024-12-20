Return-Path: <linux-iio+bounces-13696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E209F8F6A
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0FB1895E98
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21541B6D08;
	Fri, 20 Dec 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRWKxUyP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCF1AA1F4;
	Fri, 20 Dec 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688562; cv=none; b=QejJDX0IewRITOOcYt4rAH9GT1CwGBzp8NlekEnWbiGa9Rrt6rR/+qkAAqcA1Vtpgj7GDxxOsuLW3coZju9hjM3+jmwqXEsGyQhSDUKWIlyJ949C7Li821VH9ck1Zo1bNukkT50pMDjkZvUxfZmuWq62RuYFvaHbDk5SXQKXMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688562; c=relaxed/simple;
	bh=Vgmqw7RLh6LSeQ4KsWocrWkyAkBnXZCFAbIFEspou/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzaOkPlRgn4iMfEU9KbmLydFvvHrK5GXcYprsYW/cf/sRsdWZVLiYlWGhiLeFx6GBmrn/mp5caF4XEXGCX4hLl4EB4dlqusOsvzIRIuzMKpCjfsoV8zIwtQNrjMcYBTqU3FI6K0xjZvYMrJtwRfO92nwBHkaeLKw0L9PEw/6Ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRWKxUyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802EDC4CECD;
	Fri, 20 Dec 2024 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734688562;
	bh=Vgmqw7RLh6LSeQ4KsWocrWkyAkBnXZCFAbIFEspou/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tRWKxUyPGGhsgYuT38runu+HdMdSxF009XhHhGkx0dMkb3p+HJt9W+XXp1xtfV0vf
	 xbat0uN5pHH2ME+ypNASB5/kvK9gx4d8iGOfxvBVZG6C0wqfNWm5/e7aZJA7vbSABJ
	 rrUZTIbu3kWRRloP+C9phQLu0RnQ5hcKdPO0JZR+PDHFnOulS9pYtY8o1JuSb5QTpo
	 M/uIMB5rDFZBAATwRyo9MVAeLHhRfsBjhqe8LjB5POlM12TCYAaAtvUJWsR3sNSDf+
	 MbM2DR2oh8gFf9Ae6eNYrpFZRJXWEVtHnMS+R/VseUIC65vYJWHOh7r3Ib/zccxdBd
	 RH1bgatxnls2g==
Date: Fri, 20 Dec 2024 09:55:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] iio: dac: ad3552r-hs: exit for error on wrong chip id
Message-ID: <20241220-probe-outrage-7620d0cbc9d3@spud>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
 <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-6-856ff71fc930@baylibre.com>
 <20241219165446.7b8d0a9a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2I69WoCsvm9pepVy"
Content-Disposition: inline
In-Reply-To: <20241219165446.7b8d0a9a@jic23-huawei>


--2I69WoCsvm9pepVy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 04:54:46PM +0000, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 21:36:26 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>=20
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Exit for error on wrong chip id, otherwise driver continues
> > with wrong assumptions.
> Why? Chip ID does not define all future compatible parts, just the
> ones we know about today.
>=20
> The reason not failing is that the moment we do exit on a mismatch
> we can never support fallback device tree compatible IDs.  Is there
> no chance that ADI will release a backwards compatible part in the
> future that we'd like to work with old kernels?
>=20
> Any mismatch in DT vs hardware present is considered a firmware
> bug, not a kernel problem.
> We used to reject missmatched IDs but after a long discussion with
> DT maintainers it became clear that broke their model.

I'd probably still say the warning of the info message is still too
harsh, and that it should be something like "Chip ID mismatch, operating
detected 0x%x as a 0x%x" ;)

> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  drivers/iio/dac/ad3552r-hs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index 8974df625670..e613eee7fc11 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state=
 *st)
> > =20
> >  	id |=3D val << 8;
> >  	if (id !=3D st->model_data->chip_id)
> > -		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
> > -			 AD3552R_ID, id);
> > +		return dev_err_probe(st->dev, -ENODEV,
> > +				     "chip id error, expected 0x%x, got 0x%x\n",
> > +				     st->model_data->chip_id, id);
> > =20
> >  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> >  	ret =3D st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
> >=20
>=20

--2I69WoCsvm9pepVy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2U/LQAKCRB4tDGHoIJi
0t2pAP9csKUXSrKxjHOYaZxni9eqigMkZisA1iuHC3o6E4fIPQEA8RE1jfdsqmdY
FgEP37Q60wMzBrdS3GBIgMGoF46yaQE=
=ai0l
-----END PGP SIGNATURE-----

--2I69WoCsvm9pepVy--

