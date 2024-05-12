Return-Path: <linux-iio+bounces-4977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E668C363A
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 13:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E99F1F21284
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C931E894;
	Sun, 12 May 2024 11:42:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289891CA96
	for <linux-iio@vger.kernel.org>; Sun, 12 May 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715514124; cv=none; b=to/qlmBXWn1hnHzvVEz1ZQSTL6BVwVXj/bY8jl5Q5asKR2WvzgeBY8yCI5NktIktCmgSqJuRsurZZwi4BX+7qP475fvKdsTTRnWI5o9lzXI+ptUUerYxQWCgy27zj0C6HoK3ddlXuNVH+CBuEaLyuE8Im51kF1izbBYocfkyy9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715514124; c=relaxed/simple;
	bh=QDlvU/N/aQj+fCoXkB2FswSB6YI97uBetmTRmIgdN7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/zzbDE/xYhB9JMwoOD55InLzj9j1WUIMjNhlfSWQvRwzUHByYsXinNHMke7ofgm1AQ8tdZbrdKdDHNS62+edUUE0C/hN2ETaIMG3SuE4rg6WTWS+O0EWcwU1o443mElfKXqr10F7ksAjKQrhFg1GGcA1a/zDROVG1LmTAIZmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s67aS-0005CD-RH; Sun, 12 May 2024 13:41:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s67aS-000ySf-0e; Sun, 12 May 2024 13:41:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s67aR-002une-2x;
	Sun, 12 May 2024 13:41:51 +0200
Date: Sun, 12 May 2024 13:41:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de
Subject: Re: [PATCH] iio: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-ID: <vffn6ntzcnps64kczm5rryuiqcjpz4sev2y4nier6divyg5srx@rdzojlblraqb>
References: <20240508072928.2135858-2-u.kleine-koenig@pengutronix.de>
 <20240511142006.27facd74@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rwwblfyhxja4yfb"
Content-Disposition: inline
In-Reply-To: <20240511142006.27facd74@jic23-huawei>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--6rwwblfyhxja4yfb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Sat, May 11, 2024 at 02:20:06PM +0100, Jonathan Cameron wrote:
> On Wed,  8 May 2024 09:29:27 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > These drivers don't use the driver_data member of struct i2c_device_id,
> > so don't explicitly initialize this member.
> >=20
> > This prepares putting driver_data in an anonymous union which requires
> > either no initialization or named designators. But it's also a nice
> > cleanup on its own.
> >=20
> > While add it, also remove commas after the sentinel entries.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > I didn't add all the individual maintainers to Cc and put the iio chang=
es in a
> > single patch. If you want I can split per driver (or per iio subdirecto=
ry?),
> > just tell me if you prefer it that way.
>=20
> I don't mind a single patch as resolving any backporting issues around th=
is
> should be easy.=20

*nod*

> Whilst your changes for driver_data in struct i2c_device_id obviously don=
't
> need it, maybe it's worth similar patches to cleanup acpi_device_id and
> of_device_id tables with pointless 0 initialisation?

Yup, I'm aware of these. I'll tackle them once I'm through with i2c.

> Applied this with some conflicts in bmi160 resolved by hand.
>=20
> Applied to the togreg branch of iio.git but only pushed out for now as te=
sting
> to let 0-day look at it. I'll rebase on 6.10-rc1 once available.

Sounds good. I didn't find a public branch on
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/ that
contains your adaption of my patch. Otherwise I'd have double checked
your conflict resolution. Feel free to tell me once it's there (or where
I missed it).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6rwwblfyhxja4yfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZAqv4ACgkQj4D7WH0S
/k68WAf+Ll9uZTSGA7kGG7Xu1U6Xuk5ByIhlPA3bq8byhrQBSGPlfiSAAo94dmnF
Gdi/kV7qBPghQOLUBBH5dH89Z8J2NbiiQ2CLa2ELkG01zciEh0YpTXtryNCcNoA+
YsCoSNs+PyNyPcLLb8ON+1CYDrghGquFhrSeNLWWZugSq3Lyah5AVSUWzTW3/4KP
cyku61IsOLEEJWyZ5Zz8gWkygPIyQM9VZ+NvgyRYaJXEDdONcLjKdQPKld2XSWB0
ecysQ9deBeusjC3aNH4vz9Nbx2psvWpLSyJV9ZWX2eO1wYVC9G8G2Pd4T9+N60qm
bGVe/ny4Um85Kk9E/33MIhz5ATahGA==
=7MfF
-----END PGP SIGNATURE-----

--6rwwblfyhxja4yfb--

