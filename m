Return-Path: <linux-iio+bounces-6295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA7909824
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0DA1F21C7F
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A0045020;
	Sat, 15 Jun 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaoQcW8r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C29433C1;
	Sat, 15 Jun 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453667; cv=none; b=Cikfhi712FBZ0C+wMSGcydjJg+oTcFaZzUE048H/nHRsig7JkiG1P/2cVuqT1f9tuhcJ/V+MXTF+q3/eeAj8v1GNjvaA095XaeaY9cvW9xNOVqnwPZz+Olu0K6Ud052Oo/etnarHsMMm4ZUyvwk82auNLFsZK9EBs2uN/K7nu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453667; c=relaxed/simple;
	bh=OXaRvGK9YhpiNpQtteaABhrLSobVro6J5d7sXvHNJio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0eoPi4EANsYnmLW1A4jKb9aXS6nR8iaF/hgUmSkVuo9zxDcA4wTMLg6WdoNFMh42zk/gJk+ANr6MPgpZtGwkfPkFDPib3fce4Nc/KpD52B+lcgJwEzI95Y3UJzkEBb0ofah352seQRhbs+UnG9AhDlvIlcTTEtiAUDmDDUR35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaoQcW8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FB5C116B1;
	Sat, 15 Jun 2024 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453667;
	bh=OXaRvGK9YhpiNpQtteaABhrLSobVro6J5d7sXvHNJio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CaoQcW8r9AUGO/lMuYBfEA61Ve8JKozJglBw7OdZsJVSFzrjRedqgUa1xV86rGDtA
	 9IK8B6cNUjnIHqsatPlkGZpKj0VSaXA9CHU2z3jG8g4Ye3s5gDljuoF6kcDBenBVUk
	 JEFGmWFi82BnptYhILVkgEzhArBd3wXlZk+uCQdx7yEMgs6UWFCsifMXPkve4suz4R
	 nWIJeintZNiho0Obbe3SOuMNxKHRoKY+58JsPS0+PWX3W8ju2/jhtdoBbFf37kck+E
	 Fr1YeXrB1KL9LyKv71OL1900X5hRQXG4fVyoHQwGbujxdBRQ2ynz6QHeqBJvnVZSbs
	 +dN7hHSuqa+Vw==
Date: Sat, 15 Jun 2024 13:14:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Mark Brown
 <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: ad7292: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240615131419.459532df@jic23-huawei>
In-Reply-To: <a9e4b62f-7021-4939-82a5-8b2089cd7193@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
	<20240612-iio-adc-ref-supply-refactor-v2-3-fa622e7354e9@baylibre.com>
	<f45d0cba3e3fc087d0a3b8c5af5401a5c38ec162.camel@gmail.com>
	<a9e4b62f-7021-4939-82a5-8b2089cd7193@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jun 2024 10:16:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/14/24 10:11 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2024-06-12 at 16:03 -0500, David Lechner wrote: =20
> >> This makes use of the new devm_regulator_get_enable_read_voltage()
> >> function to reduce boilerplate code.
> >>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >> v2 changes:
> >> * avoid else in return value check
> >> * use macro instead of comment to document internal reference voltage
> >> ---
> >> =C2=A0drivers/iio/adc/ad7292.c | 36 ++++++----------------------------=
--
> >> =C2=A01 file changed, 6 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> >> index 6aadd14f459d..87ffe66058a1 100644
> >> --- a/drivers/iio/adc/ad7292.c
> >> +++ b/drivers/iio/adc/ad7292.c
> >> @@ -17,6 +17,8 @@
> >> =C2=A0
> >> =C2=A0#define ADI_VENDOR_ID 0x0018
> >> =C2=A0
> >> +#define AD7292_INTERNAL_REF_MV 1250
> >> +
> >> =C2=A0/* AD7292 registers definition */
> >> =C2=A0#define AD7292_REG_VENDOR_ID		0x00
> >> =C2=A0#define AD7292_REG_CONF_BANK		0x05
> >> @@ -79,7 +81,6 @@ static const struct iio_chan_spec ad7292_channels_di=
ff[] =3D {
> >> =C2=A0
> >> =C2=A0struct ad7292_state {
> >> =C2=A0	struct spi_device *spi;
> >> -	struct regulator *reg;
> >> =C2=A0	unsigned short vref_mv;
> >> =C2=A0
> >> =C2=A0	__be16 d16 __aligned(IIO_DMA_MINALIGN);
> >> @@ -250,13 +251,6 @@ static const struct iio_info ad7292_info =3D {
> >> =C2=A0	.read_raw =3D ad7292_read_raw,
> >> =C2=A0};
> >> =C2=A0
> >> -static void ad7292_regulator_disable(void *data)
> >> -{
> >> -	struct ad7292_state *st =3D data;
> >> -
> >> -	regulator_disable(st->reg);
> >> -}
> >> -
> >> =C2=A0static int ad7292_probe(struct spi_device *spi)
> >> =C2=A0{
> >> =C2=A0	struct ad7292_state *st;
> >> @@ -277,29 +271,11 @@ static int ad7292_probe(struct spi_device *spi)
> >> =C2=A0		return -EINVAL;
> >> =C2=A0	}
> >> =C2=A0
> >> -	st->reg =3D devm_regulator_get_optional(&spi->dev, "vref");
> >> -	if (!IS_ERR(st->reg)) {
> >> -		ret =3D regulator_enable(st->reg);
> >> -		if (ret) {
> >> -			dev_err(&spi->dev,
> >> -				"Failed to enable external vref supply\n");
> >> -			return ret;
> >> -		}
> >> -
> >> -		ret =3D devm_add_action_or_reset(&spi->dev,
> >> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7292_regulator_disable, s=
t);
> >> -		if (ret)
> >> -			return ret;
> >> -
> >> -		ret =3D regulator_get_voltage(st->reg);
> >> -		if (ret < 0)
> >> -			return ret;
> >> +	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
> >> +	if (ret < 0 && ret =3D=3D -ENODEV) =20
> >=20
> > ret !=3D -ENODEV? =20
>=20
> yup, I messed this one up
Fixed up whilst applying.  Applied
>=20
> >=20
> > - Nuno S=C3=A1
> >  =20
>=20


