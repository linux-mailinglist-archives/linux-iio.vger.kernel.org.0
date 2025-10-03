Return-Path: <linux-iio+bounces-24688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F3BB7323
	for <lists+linux-iio@lfdr.de>; Fri, 03 Oct 2025 16:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532951896C5A
	for <lists+linux-iio@lfdr.de>; Fri,  3 Oct 2025 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14420F08D;
	Fri,  3 Oct 2025 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eMQTxe5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE31F582B
	for <linux-iio@vger.kernel.org>; Fri,  3 Oct 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502172; cv=none; b=RSPQ2jHlpiQk5dIioiNVArMnaWSq0m2flpdwGXPleKuAH2k1AqgYWxQHikGOdNY4OrnGAQ0Mui2CxyBQ9WiZeOvuTT7Oq1wcZZ11TiLseh4XxXYQxJFp6UpXVeqIM6wK+v80zSh0hIuQ0WfIy1Z0UKxn5JcP4CxtNceSdpN143Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502172; c=relaxed/simple;
	bh=VyohuO4CZGUcGR62GS+0n04Mx5bz3VjGW5hDt2YqbmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7bEjSIhP3tJY6vIv8pQ4wukKPFE2fcplQAufRJ+p6kPsGVB2SKolxpNtfYlb5QPooh0l9xlQElaXziGDZLD/8ldGWs4zwr3GHx70jK/XCoFrTj4+hOmNXJwtd8wwtFD4SomomsHgFEjYej9WVgYM6MfhC/4+sOqHisaJb4OnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eMQTxe5P; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AEE611A10D5;
	Fri,  3 Oct 2025 14:36:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7DFAB60683;
	Fri,  3 Oct 2025 14:36:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E4BD6102F1B8A;
	Fri,  3 Oct 2025 16:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759502167; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7ENhq4LPUBj+5tdkC5VWGQKUjz+S/mLq1l/k1oBmWF4=;
	b=eMQTxe5PK2DpR3qfK4LbwutTQbIoLivxguVmJQIcLxBA/1R9sPXFDdP0/mR54JIBSTgyJX
	14uqxisQdKpT4CyiYu3bKsPCGIBDIQOnAnBwyRPHBiRLNHy1kuEu3ojPlUTszjSVOMDiIy
	D5xexCWCMgtcNbe/5xV9HCLi9b2sEOoWkTgXI4v6nZtN1AEzGepP8Ojf7q3wwrRi+HHosl
	qggAuElvSY6POoHkzshV3vmTKJW7tKSUjWDXcL0uYOgM2nwJPRnZO4auwKVtsccPP4dR1s
	KpFQeUiWsH2vVLB+kMepRDLkQyQUSTddOpDBpX0eRp8C4BmFPOUNx0tIs3VGiQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: add processed write API
Date: Fri, 03 Oct 2025 16:35:59 +0200
Message-ID: <2406495.tdWV9SEqCh@fw-rgant>
In-Reply-To:
 <CAMknhBG_o=jTKtHHDyK=bq7wcHMnDM1ZHaYAfX0K2hjHfkX3Bg@mail.gmail.com>
References:
 <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <5015441.GXAFRqVoOG@fw-rgant>
 <CAMknhBG_o=jTKtHHDyK=bq7wcHMnDM1ZHaYAfX0K2hjHfkX3Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2710806.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3

--nextPart2710806.irdbgypaU6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 2/5] iio: add processed write API
Date: Fri, 03 Oct 2025 16:35:59 +0200
Message-ID: <2406495.tdWV9SEqCh@fw-rgant>
MIME-Version: 1.0

On Wednesday, 1 October 2025 12:03:21 CEST David Lechner wrote:
> On Wed, Oct 1, 2025 at 9:19=E2=80=AFAM Romain Gantois <romain.gantois@boo=
tlin.com>
>=20
=2E..
> > > > +           case IIO_VAL_INT_PLUS_MICRO:
> > > > +           case IIO_VAL_INT_PLUS_NANO:
> > > > +                   break;
> > > > +           case IIO_VAL_FRACTIONAL:
> > > > +                   offset_val /=3D offset_val2;
> > > > +                   break;
> > > > +           case IIO_VAL_FRACTIONAL_LOG2:
> > > > +                   offset_val >>=3D offset_val2;
> > > > +                   break;
> > > > +           default:
> > > > +                   return -EINVAL;
> > > > +           }
> > > > +
> > > > +           *raw -=3D offset_val;
> > > > +   }
> > >=20
> > > There are some rounding biases in this function, but I'm not sure if
> > > it is worth trying to make a perfectly fair function.
> >=20
> > I'm unfamiliar with the notion of rounding bias, does it mean that nest=
ed
> > calls of this function would tend to amplify rounding errors? In this
> > case,
> > would rounding to the nearest integer instead of whatever is being done=
 by
> > the
> > integer division here be a good solution?
>=20
> In this case, the issue is when you are taking multiple samples. When you
> look at the average of all of the samples, you will be able to see the
> bias. For example, in one of the drivers I was looking at there is an
> offset of xxxx.6. Since the IIO_VAL_INT_PLUS_MICRO case is just dropping
> any fractional part, the raw value will be on average 0.6 lsb lower that
> the requested value. This could be a problem in an application where high
> precision is required. But probably not noticeable in cases where 1 lsb is
> less than the noise level.
>=20

Thanks a lot for the detailed explanation. For the IIO_VAL_INT_PLUS_MICRO/N=
ANO=20
cases, I think that scaling by MICRO/NANO, then subtracting the offset, the=
n=20
dividing and rounding to the closest would give a small precision improveme=
nt=20
in some cases. It would be a bit slower though, but for low sample-rate=20
devices like the ones in IIO I don't think it would be noticeable. I'll giv=
e=20
it a try.

> The floor division for IIO_VAL_FRACTIONAL creates a similar bias.
> DIV_ROUND_CLOSEST can help there, but even that has a small bias because
> values of exactly 0.5 always get rounded in the same direction. That kind
> of bias is much smaller though, so easier to ignore.
>=20

DIV_ROUND_CLOSEST would indeed reduce the bias at no substantial cost,=20
so I think I'll go with that.

Thanks,

=2D-=20
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart2710806.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmjf308ACgkQKCYAIARz
eA4YERAAm4m2/w4+jcoswY51aGJZqKrSPOzOpO8q6r9YFkh7HwV1oCP/ChhhdBXF
fY0mg8b9JgN/9kk2tSSjnhf8yhxNQu9U/j3W+pnFV5LNZPhqxJgdjQDmg4NnVaEm
yUA+cf7/RAVlJz8RTPZJi5NlTdZbTQUiPDV2GBGjFwejtlg1Nf1LArXfQmVB8kS4
ZWvyTc3HaWHHcrjlz6EV534ewUTURMT1hH5uUVbdv7OKva7LRkbskHBMDvwTs+UF
DLztHWy4h2CFmPMN0/qlF6hIUrNVPkR0FoMtFRYbwpREDfWLsGdSsz5Jo/0Rc3Kf
E8zzwb7ghaC8JD0evSLoSJ9ie8S5hMhqvCXc66ZSagoE9xA0V0ZWEc9a0UbcVh2m
+e/q2N9xsDSjrAPJZLlU0E3AHelhRjMQOEq4iESPld2rM5IJb3HDEBjQzCNWz86k
ZBprOos/x8XXHaWg31s1cSdU0owOfzZ2I1wptwIer6k18hvwYzBuyCXZcfcSyWjY
RDU40EibBcglu0imyRhwW5rkRhsfulUkkM7D2s8PDh0fblNBf12wRBtQraRoEmCp
/XHxZ0T206JkI3jjgq7MkxHEzcMcCrcCYiv3h26beu3WmTC1FGdVeHMnBC0A7E6d
farq3q/R3hZas94F3irQJjakRXyGV8/+C1embayiuxBM81qLE/A=
=gBYg
-----END PGP SIGNATURE-----

--nextPart2710806.irdbgypaU6--




