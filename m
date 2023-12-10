Return-Path: <linux-iio+bounces-786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BDB80BA59
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E336280DA5
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201568820;
	Sun, 10 Dec 2023 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR9pEbWZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D18848A
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 11:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE21C433C8;
	Sun, 10 Dec 2023 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702207627;
	bh=ZL7DrbYdpWvTGgW5Rr71xDfCB8dk6bWmsKG5P9gIXXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sR9pEbWZrYRJHaqiOdDscBrHPYPHSlrXnFk4r4j9r8CAtFAOSQBBZv/hhpPeHJVmw
	 62XIdJPSgIKlvlQnkFIUcl2gPDuVzfXSVNzzKSmOqKNTNklP8eZzjyc4okm84lc6I4
	 /jIk7C34i/m0vND0THrK+IxcPYpAPhKga3MpZw3i3iyjSXNzJ6R5JojqT81jVqyQEP
	 R/vhZX2e/heAIJfPbl/TWqgXxZlpnDWkhsnDgwybHvJkOfb0oadplWHWzBx0ENYHnM
	 SwGcHFLI4t08266YFuLgyTRY9Sa3d5stSvC7aPLcBmwZ/tu+ivK7r+3C0++WWOBIjs
	 cQeKIeHhjdTGw==
Date: Sun, 10 Dec 2023 11:27:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/8] iio: adc: ad9467: fix scale setting
Message-ID: <20231210112700.57fcdbf5@jic23-huawei>
In-Reply-To: <5a157ef34eb4c713f66ee49f088747135d4d1cd9.camel@gmail.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	<20231205-iio-backend-prep-v1-4-7c9bc18d612b@analog.com>
	<CAMknhBF84oWxgGpyj=6S013qCrqHXRFk6Apub94FN6SUcWSmsA@mail.gmail.com>
	<5a157ef34eb4c713f66ee49f088747135d4d1cd9.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Dec 2023 11:02:36 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-12-06 at 17:01 -0600, David Lechner wrote:
> > On Tue, Dec 5, 2023 at 11:06=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > When reading in_voltage_scale we can get something like:
> > >=20
> > > root@analog:/sys/bus/iio/devices/iio:device2# cat in_voltage_scale
> > > 0.038146
> > >=20
> > > However, when reading the available options:
> > >=20
> > > root@analog:/sys/bus/iio/devices/iio:device2# cat
> > > in_voltage_scale_available
> > > 2000.000000 2100.000006 2200.000007 2300.000008 2400.000009 2500.0000=
10
> > >=20
> > > which does not make sense. Moreover, when trying to set a new scale we
> > > get an error because there's no call to __ad9467_get_scale() to give =
us
> > > values as given when reading in_voltage_scale. Fix it by computing the
> > > available scales during probe and properly pass the list when
> > > .read_available() is called.
> > >=20
> > > While at it, change to use .read_available() from iio_info. Also note
> > > that to properly fix this, adi-axi-adc.c has to be changed accordingl=
y.
> > >=20
> > > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad9467.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 47 +++++++++++++++++++++++
> > > =C2=A0drivers/iio/adc/adi-axi-adc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 74 ++++++++-----------------------------
> > > =C2=A0include/linux/iio/adc/adi-axi-adc.h |=C2=A0 4 ++
> > > =C2=A03 files changed, 66 insertions(+), 59 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index badbef2ce9f8..3c8bd6c821a4 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> > > @@ -120,6 +120,7 @@ struct ad9467_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_device=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 *spi;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *clk;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 output_mode;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (*scales)[2];
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *pwrdown_gpio;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* ensure consistent state=
 obtained on multiple related accesses */
> > > @@ -216,6 +217,7 @@ static void __ad9467_get_scale(struct adi_axi_adc=
_conv *conv,
> > > int index,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .channel =3D _chan,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .info_mask_shared_by_type =
=3D BIT(IIO_CHAN_INFO_SCALE) |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ),=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .info_mask_shared_by_type_avail=
able =3D BIT(IIO_CHAN_INFO_SCALE), \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .scan_index =3D _si,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .scan_type =3D {=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .sign =3D _sign,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > @@ -370,6 +372,26 @@ static int ad9467_write_raw(struct adi_axi_adc_c=
onv *conv,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > >=20
> > > +static int ad9467_read_avail(struct adi_axi_adc_conv *conv,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *length,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 long mask)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct adi_axi_adc_chip_i=
nfo *info =3D conv->chip_info;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ad9467_state *st =3D adi=
_axi_adc_conv_priv(conv);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (mask) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *vals =3D (const int *)st->scales;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *type =3D IIO_VAL_INT_PLUS_MICRO;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Values are stored in a 2D matrix */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *length =3D info->num_scales * 2; =20
> >=20
> > Maybe use ARRAY_SIZE(*info->scales) here instead of hard-coding 2? =20
>=20
> Not to keen on that as the comment should already say everything about th=
e hardcoded
> 2.
>=20
I don't mind either way, but the comment only says it's a 2D matrix, not th=
at the dimension
is 2 * num_scales - it could easily be 14 * num_scales

> - Nuno S=C3=A1
>=20
>=20


