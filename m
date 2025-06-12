Return-Path: <linux-iio+bounces-20570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0684AD7A07
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 20:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25833A30DB
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B352BE7D6;
	Thu, 12 Jun 2025 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="bEFAWNrq"
X-Original-To: linux-iio@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4E52C3270;
	Thu, 12 Jun 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749754455; cv=none; b=Ds5ung1EcEH0n3iDBPrsrxtv9tpbe57PaRKa7QiOhpOBV/D8O905x1ceMisrjTrNMmP4gfjqAEh400Q/00boUcfCn2dbawPKXHaWexi+mnIvSk0a4FByVFOLM4scS8fWy4C9tv4DPQ/EfchbKt8jOhNzzTVt7c7lrYJEUZrd0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749754455; c=relaxed/simple;
	bh=l4HVZo42yb0sCmOdBLNZ2lYvjl0jAUDtUuuSHXF+7nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf803Zdcru/Hfk/GI5C+4zvTU6W4R370AHQwx5qrOt741gS8CgG3nhBKl9NJbWZT3Kf/LQkjz985DZUAAH6M8hpZ78D8HRZYQSSR2x/urkfeEYecmpNM3NUSINMTBcOfCVtFYnytI0q8RfVula8Y9gamWu6HkCioFK0BhAvLXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=bEFAWNrq; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0D12D1C00B7; Thu, 12 Jun 2025 20:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1749754448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ES0AMk0wkXmaqMy9pIGghKd77rIPki0K7cABoa+Z/Lw=;
	b=bEFAWNrqxiDB3hTLYkNNin93KGymmobI30NxboUjySkMZZbQ1tDkw60ZqsrwZWSPzNXRLT
	19enMfhHWWz0Q5ewQBDGlyH0l4C9Yl59JXD+rK7DCySYJz3mn+lT8d5y3fwG56k5w4oziS
	988hpv7ySCcn9jbXEUW0jKpc8UQ+ntg=
Date: Thu, 12 Jun 2025 20:54:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: David Lechner <dlechner@baylibre.com>,
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
Message-ID: <aEsiTy++yKGe1p9W@duo.ucw.cz>
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com>
 <aEqbQPvz0FsLXt0Z@duo.ucw.cz>
 <2243943.irdbgypaU6@workhorse>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qHcR0wTfGJLS0CPf"
Content-Disposition: inline
In-Reply-To: <2243943.irdbgypaU6@workhorse>


--qHcR0wTfGJLS0CPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> I thought I'd chime in as someone uninvolved because this seemed
> interesting.
>=20
> On Thursday, 12 June 2025 11:17:52 Central European Summer Time Pavel Mac=
hek wrote:
> > Hi!
> >=20
> > > Jonathan mentioned recently that he would like to get away from using
> > > memset() to zero-initialize stack memory in the IIO subsystem. And we
> > > have it on good authority that initializing a struct or array with =
=3D { }
> > > is the preferred way to do this in the kernel [1]. So here is a series
> > > to take care of that.
> >=20
> > 1) Is it worth the churn?
> >=20
> > 2) Will this fail to initialize padding with some obscure compiler?
>=20
> as of right now, the only two C compilers that are supported are
> GCC >=3D 8.1, and Clang >=3D 13.0.1. If anyone even manages to get the
> kernel

Well... I'm pretty sure parts of this would make it into -stable as a
dependency, or because AUTOSEL decides it is a bugfix. So..

GNU C                  4.9              gcc --version
Clang/LLVM (optional)  10.0.1           clang --version

:-).

Best regards,
									Pavel
--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, and Musk!

--qHcR0wTfGJLS0CPf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaEsiTwAKCRAw5/Bqldv6
8rWCAJ9iuK1SPCz8Iqmtg2YYJA3QcN1ZcQCcCDOYZeP9LCuc6TXu3fDJPaQEqxk=
=IRlm
-----END PGP SIGNATURE-----

--qHcR0wTfGJLS0CPf--

