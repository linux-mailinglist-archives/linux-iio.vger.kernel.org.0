Return-Path: <linux-iio+bounces-23987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC0B53489
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EC73B4A63
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50233A029;
	Thu, 11 Sep 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="5k78R2l/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56249335BAC;
	Thu, 11 Sep 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598746; cv=none; b=Xg+2g1kTIBjyhzUdZNfxrTPstDoMSprQE5M6wFIjm2Qftgw+Mgl07Wt9rqGoerwoELhrZ4sJjM3k3cIMAgWAgCbzCoTI9s7Czp//pugVpxfxrnJZpeK2mZ/jlhj9m1nJ9vvHYq6/qaLxwj7yOoiDZWiwj0C5MoTh6ehsUb2Pde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598746; c=relaxed/simple;
	bh=ugGrOHFKwLpQ/FAqUj88ex9ecPMgeZ93Xz/F6kz7Ipk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLLl/aMFqzp0nkTFYvXASV6CDEoGiq/vrZPqZx869/8kUUZbnatfrjkILv1KgJW68sVvVJuds22cxRv43ubHDvttbFkD+MpNJQPGEkMGqKiYV8D6XdjfBFadWcirzmJTdkgHC95L5XzG5qNBfDEUZ+nurtwys/WGKN+jYSUV3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=5k78R2l/; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id EE96D173BE2;
	Thu, 11 Sep 2025 16:52:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757598737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByB8m0XZGJjjWznPQz1By0Xd5aiH/40HjBA/ZE/FsJk=;
	b=5k78R2l/zhDR+Izq0IKJTG+iiuyxV9fVUoTp4V0jcnjeSD8Z5PR/eerR03d8tBnDHXM69Q
	zl8Blt8eQ/knQk6pe+DXwVeIGFP1jULb7t2ru7loat7N6dK665TA76e8g2FcjcQmyNdhEA
	kSQW+kIXeYgY/W1r0B2qTWIpI5xefN3YHeOE0xJ/d8OFkJ0miXEehOlYOcEc5kmUiCl9N5
	XPTtswmvK/Q/uAefOby8ocLwlCW8D5TwGSjrHCgknOg3cs5hCG7nErO5QyRXgTF18ocgeZ
	6T2RVvZumVFnKI3VBA7rnWsHpTw8m2HEaN6qCgCVbZXnP+KEARh7k+GrZ2UBeg==
Date: Thu, 11 Sep 2025 16:52:14 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
Message-ID: <aMLUDkKhF_jhios0@sunspire>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
 <a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org>
 <aMLCWFatVkePTxCa@sunspire>
 <391229ff-d85a-4707-8e7c-ea64e0e3d7cb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iH+gifm7e0GKs+gM"
Content-Disposition: inline
In-Reply-To: <391229ff-d85a-4707-8e7c-ea64e0e3d7cb@kernel.org>


--iH+gifm7e0GKs+gM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello.

On Thu, Sep 11, 2025 at 03:07:05PM +0200, Krzysztof Kozlowski wrote:
> On 11/09/2025 14:36, Petre Rodan wrote:
> >=20
> > Hi Krzysztof,
> >=20
> > On Thu, Sep 11, 2025 at 09:35:52AM +0200, Krzysztof Kozlowski wrote:
> >> On 10/09/2025 09:57, Petre Rodan wrote:
> >>> Bring all configuration registers to default values during device pro=
be().
> >>>
> >>> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> >>> ---
> >>>  drivers/iio/accel/bma220_core.c | 71 ++++++++++++++++++++++++++++---=
----------
> >>>  1 file changed, 49 insertions(+), 22 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma2=
20_core.c
> >>> index b6f1374a9cca52966c1055113710061a7284cf5a..322df516c90a7c645eeca=
579cae9803eb31caad1 100644
> >>> --- a/drivers/iio/accel/bma220_core.c
> >>> -static int bma220_init(struct spi_device *spi)
> >>> +static int bma220_reset(struct spi_device *spi, bool up)
> >>>  {
> >>> -	int ret;
> >>> -	static const char * const regulator_names[] =3D { "vddd", "vddio", =
"vdda" };
> >>> +	int i, ret;
> >>> =20
> >>> -	ret =3D devm_regulator_bulk_get_enable(&spi->dev,
> >>
> >>
> >> You just added this code in patch 6. Don't add code which immediately
> >> you remove. I understand you re-add this later, so basically it is a
> >> move, but such patch diff is still confusing.
> >=20
> > sorry, but this is an artefact of 'git diff' I don't think I have no co=
ntrol of.
>=20
>=20
> Don't think so. Before bma220_init() was above bma220_power(). After
> your patch bma220_init() is BELOW bma220_power(), so that's a move.

you are correct, these two functions did change places due to the fact that
_init() started using _power(). I preffered to do the move instead
of adding a forward declaration and leaving _power() between _init() and _d=
einit().
the code was optimized for how it will look at the end of all this patching.

I thought you ment the code that was added the previous patch was not remov=
ed per
se from _init(), which was not the case.

best regards,
peter

--iH+gifm7e0GKs+gM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmjC1A4ACgkQzyaZmYRO
fzDYSQ/+NsIyCuq4KGRtaJoCaj7kcc0VV6PmmVj+EYZVFOZmI9BaOzIDx3WjamLs
d/oPMJ5ZywrFyAn0151VCYD2AW/wkAgQpa2Pvqyr1UfDWwAtwDO3Ou8w4VQFRyh1
0/vuWknS80S9Ji4PrCUOnJgH19HynkKnssFd6tpnHbGixvBb4+WzeF7bGzsKCmn9
fTg8zRRyh2WUWOC08xAL2QqycPHbldNrY5/PwmpRrcaEWTNgxKB2NrRuP7UwdsTE
tVXeVKMvjIm73uHpt8v5qBcj4y6WPl5AT7Nn+sul54p1F3aBeaaFYpdViHxEVXHs
yI2MpXYRo64bV+9q2Ga9Zfa9oB4ZhPWIIFZgswfVvJbe/FSTBKP7YS4nc2/45ksI
S4SGEsJiGJ7L2RjOeYXjgASLYl9t23s/UXIF0y0WznfOwI3tY8QL3JJO8VlEsa6P
6gHIvwnrdXqY4x+RKVPb/Q2wGFikKHCAKQtpBzfPPxoHZ8ou2Qyf370U6LUZbwfT
AT1InecZKUhq6o9BSZugF6c9wJrGZyN/Z7SDtM+qi61Kt/KIeCRjFhq4FNUEYWCz
tIPdM6FIbeRyMR+V5D0l43ki6EjGXOYCsKv2rc2cCKokSeoPcJ5UzbFHmdR3Iwqq
RdRuQIVCYgP8HW1p8fpN0eNYkPEECt4tD/+rrMC/2jXQmYRm+zI=
=HF3r
-----END PGP SIGNATURE-----

--iH+gifm7e0GKs+gM--

