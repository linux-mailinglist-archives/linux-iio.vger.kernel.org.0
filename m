Return-Path: <linux-iio+bounces-20616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF896AD9A88
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 08:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DA2168CFD
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B31C3C18;
	Sat, 14 Jun 2025 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="CJtZWBrc"
X-Original-To: linux-iio@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F882AE99;
	Sat, 14 Jun 2025 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749883658; cv=none; b=IY6cJtzW/MksQfFLuhkzVRiszYzQc4FOyjUZOBwRkDUlP7lAPDmBbG3oly/+QLzRiIfvBWK57oP6iRZvTbzqYRgiX74rPxSPbTsHSlnAxZ1eQgElOPcwwKqan2Ww2SNHPydo5cdijpq+jdD7AmXIcd0kiaG1I/fg6BOfBX1l19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749883658; c=relaxed/simple;
	bh=c9aLFkS7uYUN5AL2JbojVvkXL0o0tJER4HjUA+ljhRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F80YpJPtGb8rjhIXiUFRJIfxZYvG8EJU6VcXpr/IR/YogxAg1cROHgUtXqDuGriNpVs63SaURjmF/wT0DKiRFfOSMzvCNH1SK4g6uDmyG8NwCrh8l4igx/6LFfYyHiqhCoa74Qh6+KscuZDl+sx6sZg0ECmJD+N5bnq6g/JVjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=CJtZWBrc; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7C4A51C00A4; Sat, 14 Jun 2025 08:47:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1749883645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nq2VMzusQXJdAZDR0PVqMFoxiMFSHB1Zq1d1MUyO7/M=;
	b=CJtZWBrchouIXzaomFU7ufFekRA9oTEVUBcRxPh1aGCtkolSl3PPeUm6Vdy4Zi/qq+BbIL
	y2+ONs7eJB1n3//ZNGV+92vplpiqJ2BlqPTy1sNLOONnGZeMEAgOBFJnqxNXIKKVm7uBAk
	4iLfWoLwa540gktZliYA0g8h3ffD41Y=
Date: Sat, 14 Jun 2025 08:47:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-rockchip@lists.infradead.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	kernel@pengutronix.de, Oleksij Rempel <o.rempel@pengutronix.de>,
	Roan van Dijk <roan@protonic.nl>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/28] iio: zero init stack with { } instead of memset()
Message-ID: <aE0a/Y9qVByfA2vI@duo.ucw.cz>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
 <aEqbQPvz0FsLXt0Z@duo.ucw.cz>
 <2243943.irdbgypaU6@workhorse>
 <aEsiTy++yKGe1p9W@duo.ucw.cz>
 <aEsmDyc44P8amm5p@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8EN7Mf+Ky8207VFl"
Content-Disposition: inline
In-Reply-To: <aEsmDyc44P8amm5p@smile.fi.intel.com>


--8EN7Mf+Ky8207VFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2025-06-12 22:10:07, Andy Shevchenko wrote:
> On Thu, Jun 12, 2025 at 08:54:07PM +0200, Pavel Machek wrote:
> > > On Thursday, 12 June 2025 11:17:52 Central European Summer Time Pavel=
 Machek wrote:
> > > >=20
> > > > > Jonathan mentioned recently that he would like to get away from u=
sing
> > > > > memset() to zero-initialize stack memory in the IIO subsystem. An=
d we
> > > > > have it on good authority that initializing a struct or array wit=
h =3D { }
> > > > > is the preferred way to do this in the kernel [1]. So here is a s=
eries
> > > > > to take care of that.
> > > >=20
> > > > 1) Is it worth the churn?
> > > >=20
> > > > 2) Will this fail to initialize padding with some obscure compiler?
> > >=20
> > > as of right now, the only two C compilers that are supported are
> > > GCC >=3D 8.1, and Clang >=3D 13.0.1. If anyone even manages to get the
> > > kernel
> >=20
> > Well... I'm pretty sure parts of this would make it into -stable as a
> > dependency, or because AUTOSEL decides it is a bugfix. So..
> >=20
> > GNU C                  4.9              gcc --version
> > Clang/LLVM (optional)  10.0.1           clang --version
>=20
> Even though, what the kernel versions are you referring to? I am sure the=
re
> plenty of cases with {} there.

5.10, for example. I'm sure they are, uninitialized padding is a
security hole, but rather hard to detect if they are not specifically
looking.

BR,
								Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--8EN7Mf+Ky8207VFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE0a/QAKCRAw5/Bqldv6
8s8GAJwP0O7BqJu50EUbwvpDrfK4gyMKdACfahroIQZ2mLJdQs4CjH06C6Xtr0Q=
=2Vk7
-----END PGP SIGNATURE-----

--8EN7Mf+Ky8207VFl--

