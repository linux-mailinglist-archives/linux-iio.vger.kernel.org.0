Return-Path: <linux-iio+bounces-6297-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C7E909836
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C1A281875
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2545945;
	Sat, 15 Jun 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY9cHTAb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0E45020;
	Sat, 15 Jun 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453892; cv=none; b=RUQcWDz3+O1N9fNTWJ5+UZtXrDtY0sHewBzayN+4znX0ZQMvF6sfUqlkofO0TgcT4T/FowqS4XFYl34LZUbzQXiy6ykrGsSIwak5ZC0oVgQUpdjtBCg/nRCH03aoW8eriWGfdUvF4/qe/XpKDXqp+1to3DL0ZibOLJfKP3vFACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453892; c=relaxed/simple;
	bh=PAmHyt7Df6oYdQZUf6lZ39aqd5apsf+H+9AsntTxOlE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ro5EiTqTlafFC01pM2GtObzoqmyNYKwnYY1gCOGmbyOIqdepUvB6lhzG3UV3fG3tt8MX3zj595H4S6dxlrLXW3cIQcIPlCdZ0eBpo5b4eEywzB6gx/QNkqsglCUfPkIPC/CLwXHUMAYufgtZe71tF6zmlJazVyNpI509cTqRNZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY9cHTAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1234C116B1;
	Sat, 15 Jun 2024 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453892;
	bh=PAmHyt7Df6oYdQZUf6lZ39aqd5apsf+H+9AsntTxOlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CY9cHTAbujXGslZop/tmUqibAFS/x88HYKyDVbIt9Pr+fQ5ZUkktCsSYraecu1E3V
	 GgyAKgudMMZEJE2SPSvYtW+t9Eiy7m17YqRZOvX876O2IzS7hm0aQWrXRwDt/Ul/Kw
	 j6YCgKJCEaq63yrAg+mLP8hExtuG/6yOQg+U7Pp7PjZT6qNM4XyAnCLP315W+kM/Nb
	 HwK5rgPmRixG9ue8+zDIzLLAo18SlESm7oCyOIkw3cqIxe2ooHI76jDBtu5J5/ST2y
	 QEzm2I3WV3Dj+EgPX5azsyjcGodR3lT28tNFdlDxws9G8zL7FN3otGBrfJvPeu5yRR
	 IuUG18+1lFbKA==
Date: Sat, 15 Jun 2024 13:18:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Mark Brown
 <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: ad7944: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240615131804.7865d878@jic23-huawei>
In-Reply-To: <1f02200d-e38f-47f1-a6dd-def7225e5426@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
	<20240612-iio-adc-ref-supply-refactor-v2-5-fa622e7354e9@baylibre.com>
	<6f607e60a781f74b3cde2405c8c6659d0e304c96.camel@gmail.com>
	<1f02200d-e38f-47f1-a6dd-def7225e5426@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 10:19:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/14/24 10:16 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2024-06-12 at 16:03 -0500, David Lechner wrote: =20
> >> This makes use of the new devm_regulator_get_enable_read_voltage()
> >> function to reduce boilerplate code.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>
> >> v2 changes:
> >> - don't read voltage from refin regulator
> >> - avoid else in return value checks
> >> ---
> >> =C2=A0drivers/iio/adc/ad7944.c | 54 +++++++++++-----------------------=
--------------
> >> =C2=A01 file changed, 12 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> >> index e2cb64cef476..f8bf03feba07 100644
> >> --- a/drivers/iio/adc/ad7944.c
> >> +++ b/drivers/iio/adc/ad7944.c
> >> @@ -464,23 +464,17 @@ static const char * const ad7944_power_supplies[=
] =3D {
> >> =C2=A0	"avdd",	"dvdd",	"bvdd", "vio"
> >> =C2=A0};
> >> =C2=A0
> >> -static void ad7944_ref_disable(void *ref)
> >> -{
> >> -	regulator_disable(ref);
> >> -}
> >> -
> >> =C2=A0static int ad7944_probe(struct spi_device *spi)
> >> =C2=A0{
> >> =C2=A0	const struct ad7944_chip_info *chip_info;
> >> =C2=A0	struct device *dev =3D &spi->dev;
> >> =C2=A0	struct iio_dev *indio_dev;
> >> =C2=A0	struct ad7944_adc *adc;
> >> -	bool have_refin =3D false;
> >> -	struct regulator *ref;
> >> +	bool have_refin;
> >> =C2=A0	struct iio_chan_spec *chain_chan;
> >> =C2=A0	unsigned long *chain_scan_masks;
> >> =C2=A0	u32 n_chain_dev;
> >> -	int ret;
> >> +	int ret, ref_mv;
> >> =C2=A0
> >> =C2=A0	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> >> =C2=A0	if (!indio_dev)
> >> @@ -531,47 +525,23 @@ static int ad7944_probe(struct spi_device *spi)
> >> =C2=A0	 * - external reference: REF is connected, REFIN is not connect=
ed
> >> =C2=A0	 */
> >> =C2=A0
> >> -	ref =3D devm_regulator_get_optional(dev, "ref");
> >> -	if (IS_ERR(ref)) {
> >> -		if (PTR_ERR(ref) !=3D -ENODEV)
> >> -			return dev_err_probe(dev, PTR_ERR(ref),
> >> -					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get REF supply\n");
> >> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> >> +	if (ret < 0 && ret !=3D -ENODEV)
> >> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> >> =C2=A0
> >> -		ref =3D NULL;
> >> -	}
> >> +	ref_mv =3D ret =3D=3D -ENODEV ? 0 : ret / 1000;
> >> =C2=A0
> >> =C2=A0	ret =3D devm_regulator_get_enable_optional(dev, "refin");
> >> -	if (ret =3D=3D 0)
> >> -		have_refin =3D true;
> >> -	else if (ret !=3D -ENODEV)
> >> -		return dev_err_probe(dev, ret,
> >> -				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get and enable REFIN supply\n=
");
> >> +	if (ret < 0 && ret =3D=3D -ENODEV)
> >> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
> >> + =20
> >=20
> > ret !=3D -ENODEV right? =20
>=20
> oof, yeah messed that one too
>=20
Fixed up as well and applied.

Enough patches bouncing around that I'd rather clear these little things by
hand than see the patch again :)

Jonathan

> >=20
> > - Nuno S=C3=A1
> >=20
> >  =20
>=20


