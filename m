Return-Path: <linux-iio+bounces-22738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A10B267FE
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 15:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C3660132B
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EC030148F;
	Thu, 14 Aug 2025 13:38:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724CD306D34
	for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178702; cv=none; b=gte7MztQ8F47U9UWoOkcAbbQ0BYv9Vgz0fD9dvnYAkl+e76XauhaWFsBsHGg5tHPvivzOc7AJ7ScwpnSRb6X6jyjwLymLmiGyCsDi5BtI2G01s11Pv77RDl67IePzDHiuEdSKTEFNCaadDoJG1PmIgtA7aRZgen26Gl44w2X0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178702; c=relaxed/simple;
	bh=kjNhRQU46zPw6eZW1goIH1qTFXm0+Dww60I9vuUUvuQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEzPOUKRdbwcjEmXEiOfve8WeDbughcCvQ7fDbPupkibi8SYf/VZYB4g5s8Uk082VU8qpQeGxVR+ibHCweM6WY98wFfdetkxCOAx8Jsu0moE9pcluAAB+jBPx0gv/mK1ndwyJVMKVXnJK+rgEZTEpNneZ516o8F6ns3jEl3Gsqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 09:38:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>, 
	Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081409-ubiquitous-cuckoo-76acbd@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
 <2025081408-umber-axolotl-e6c6dd@boujee-and-buff>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zwmlvwkrslhe7sks"
Content-Disposition: inline
In-Reply-To: <2025081408-umber-axolotl-e6c6dd@boujee-and-buff>
X-Migadu-Flow: FLOW_OUT


--zwmlvwkrslhe7sks
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
MIME-Version: 1.0

On Thu, Aug 14, 2025 at 09:06:39AM -0500, Ben Collins wrote:
> On Wed, Aug 13, 2025 at 05:52:04PM -0500, David Lechner wrote:
> > On 8/13/25 10:15 AM, Ben Collins wrote:
> > > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> ...=20
> > >  static int mcp9600_read(struct mcp9600_data *data,
> > > @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio=
_dev,
> > >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > >  		*val =3D mcp9600_tc_types[data->thermocouple_type];
> > >  		return IIO_VAL_CHAR;
> > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > +		*val =3D data->filter_level;
> >=20
> > We can't just pass the raw value through for this. The ABI is defined
> > in Documentation/ABI/testing/sysfs-bus-iio and states that the value
> > is the frequency in Hz.
> ...
> > For example, for 3 Hz sample rate (18-bit samples), I got:
> >=20
> >   n  f_3dB (Hz)
> >   1  0.58774
> >   2  0.24939
> >   3  0.12063
> >   4  0.05984
> >   5  0.02986
> >   6  0.01492
> >   7  0.00746
> >=20
> > I had to skip n=3D0 though since that is undefined. Not sure how we
> > handle that since it means no filter. Maybe Jonathan can advise?
>=20
> Thanks for notes. If I'm reading for datasheet formula right,
>=20
> k =3D 2 / (2^n + 1)
>=20
> So n=3D0 would be k=3D1. I did this formula for n=3D[0-7] and get:
>=20
> n	k
> 0	1.00000
> 1	0.66667
> 2	0.40000
> 3	0.22222
> 4	0.11765
> 5	0.06061
> 6	0.03077
> 7	0.01550
>=20
> I'm not versed in filter frequency, but would these be the correct
> values to use for the coefficients?

This seems to be what I was looking for:

Got it. For a 1-pole IIR low-pass of the form
y_t =3D y_{t-1} + k(x_t - y_{t-1}), the =E2=80=933 dB cutoff is

f_c =3D \frac{-\ln(1-k)}{2\pi}\,f_s

Using your k=3D\frac{2}{2^n+1} and a sample rate f_s =3D 3\ \text{Hz}, the =
equivalent =E2=80=933 dB cutoff frequencies are:

n	k		f_c (Hz)	time constant =CF=84 (s) =3D 1/(2=CF=80 f_c)
0	1.0000000000	=E2=88=9E		0.0000
1	0.6666666667	0.5245487288	0.3034
2	0.4000000000	0.2439012692	0.6525
3	0.2222222222	0.1199938006	1.3264
4	0.1176470588	0.0597609987	2.6632
5	0.0606060606	0.0298512716	5.3316
6	0.0307692308	0.0149219903	10.6658
7	0.0155038760	0.0074605397	21.3329

Notes:
	=E2=80=A2	n=3D0 (k=3D1) is just =E2=80=9Ctrack the input=E2=80=9D (no smoo=
thing), so f_c\to\infty.
	=E2=80=A2	If you=E2=80=99re using a different sampling rate, multiply the =
f_c values above by \frac{f_s}{3}.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--zwmlvwkrslhe7sks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmid5rkACgkQXVpXxyQr
Is9fyQ/+OKoIn9Epb1KWsfjJww7W4m6YWnMhPXqMHAs+mrfMkdLeDtIZWRMXKQPS
YjClxXItlARNxkqLIJQXu4rG/XMFqlQQEtflM4UVxtjgeiaomwF06gX5rhRLcHA0
2ytmxQvxixWNBA4n8gJWqqIk3Uqbsyk0LtsHezXaQz9RgyP+6Q3WT6nGP35pIRyv
BLYinLeREUlH7s6xn2Kho1wW0F2JNjxhT9MuvVH3LulWPl4UPuMtYRXR/XDTqEpD
6RMrjRqh7yNeM5retwEq3gdahOlyd6cP0EY0IZsCZTFkA55YpWL0LjdoaUFAdFVs
gwmDhWzFubk3Hb/dyZ7Y+83B3JTtHOVElgk4IW7qP8x00RQX/C6ye4YuZeq8dc/U
8tb/PVfvR/i9EdkCGokuBk+o3dnL+OT+CqLFzwvLeOF+lyQKbJ7rCxypdMpxy8JW
Gaz2ZDVU21ZurN10sDNheoTQfjEclWzmmFAJCv4QUmoLdw3EzyjSB+7GD2NqaCBb
hIm2MR7DgaUaENCFOw9ZLsUApVf2ZZSVbM27xGlppHf9fQz8VuIO7cS7zonqKFqJ
75x7sAao2pYJW7FFm2rlP1kvzSENSkwblzBrF7k6aWhUevMk0N31Qn+4ZxLMldWi
jfS1V87ksxvGRWWXxwrlfsZTKTxMTd92b5n2XYBUNsy2Q4w5/LI=
=nMht
-----END PGP SIGNATURE-----

--zwmlvwkrslhe7sks--

