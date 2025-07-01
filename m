Return-Path: <linux-iio+bounces-21196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2392AF0207
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 19:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EDD1C055E5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783C327BF85;
	Tue,  1 Jul 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYxLQCQc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3371126B775;
	Tue,  1 Jul 2025 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391498; cv=none; b=gkwbJP9TButdLFHT4dX93f1w6HhgYHZ8E/kYrRpJWrOyZlkgaxbIXoucH987n/F2lx6t4h/AaFeO8aPGKAeiDcVgGO1A7JjRKU3B+jYGbVu+ljjxbhRE2htvFWWZUtlC9zD6BWApe+SEjO6zYqLllnUh2ubu5V9xMemP54PGZ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391498; c=relaxed/simple;
	bh=D3A0lYLe+yApG+3rVZ1Qzgn09968mOxvOAVPGctv9bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHmm9ziztnYXk+cISvXwDK/S5+dGGl/+24Pe28x3u818/J1xF88cclT4B7vCREGnCh5OGHEjtCSoJeUTg/EdhjJgpby59kKJzk33/7E8gMqW8/9RcDzravGJP+B67MWdPpt0Fl2udeGgu4jMY74wPqEgdUR7PksDpRD80vvqnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYxLQCQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE39C4CEEB;
	Tue,  1 Jul 2025 17:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751391497;
	bh=D3A0lYLe+yApG+3rVZ1Qzgn09968mOxvOAVPGctv9bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bYxLQCQcRrRtTMvSHHvdzYvhll+Ju2UDIGkd0thVlkzkUU3a1QMJIQkM2hwgaFlNo
	 8gVnWHjrxzlxjqSk7Urh0spdoKl6PBVZfHlBO4eFa4QYVphzHt4+j4nCFz2iCTW+or
	 GtolkDz74gGjI0JNVINWEV/x9kKMsR6eH0eu/Jg1gOYlgAEREFVwYLaoRlnVdP8SCK
	 o1PoY5y80ZErwCSkwatcniAROlpsQ70EPrjqXwY9DveH1r+UMvspyhkrsgeVCPwTSc
	 CXNmN39+AO98qhNO/r2OYBTcqgRjwLzhLAeYCMFSnQTViTpIhBDwNyDr3NKYGXKZja
	 oI+4AEX6quNgw==
Date: Tue, 1 Jul 2025 18:37:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: drop use of chip info array
Message-ID: <20250701183751.5701fb7e@jic23-huawei>
In-Reply-To: <pmqc36lr7filq6gu6bplg62qb4bx7cc7nx3ylsjuczv52cdlxr@2bdgzwobw3mv>
References: <20250628-iio-const-data-5-v1-1-9e56c2f77979@baylibre.com>
	<20250629182531.6666f690@jic23-huawei>
	<pmqc36lr7filq6gu6bplg62qb4bx7cc7nx3ylsjuczv52cdlxr@2bdgzwobw3mv>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jun 2025 10:15:14 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello Jonathan,
>=20
> On Sun, Jun 29, 2025 at 06:25:31PM +0100, Jonathan Cameron wrote:
> > > ---
> > >  drivers/iio/adc/ad7124.c | 36 ++++++++++++++----------------------
> > >  1 file changed, 14 insertions(+), 22 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > > index 92596f15e797378329d2072bff71e392664c69db..9808df2e92424283a86e9=
c105492c7447d071e44 100644
> > > --- a/drivers/iio/adc/ad7124.c
> > > +++ b/drivers/iio/adc/ad7124.c
> > > @@ -94,11 +94,6 @@
> > > =20
> > >  /* AD7124 input sources */
> > > =20
> > > -enum ad7124_ids {
> > > -	ID_AD7124_4,
> > > -	ID_AD7124_8,
> > > -};
> > > -
> > >  enum ad7124_ref_sel {
> > >  	AD7124_REFIN1,
> > >  	AD7124_REFIN2,
> > > @@ -193,17 +188,16 @@ struct ad7124_state {
> > >  	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD712=
4_MAX_CONFIGS);
> > >  };
> > > =20
> > > -static struct ad7124_chip_info ad7124_chip_info_tbl[] =3D {
> > > -	[ID_AD7124_4] =3D {
> > > -		.name =3D "ad7124-4",
> > > -		.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_4,
> > > -		.num_inputs =3D 8,
> > > -	},
> > > -	[ID_AD7124_8] =3D {
> > > -		.name =3D "ad7124-8",
> > > -		.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_8,
> > > -		.num_inputs =3D 16,
> > > -	},
> > > +static const struct ad7124_chip_info ad7124_4_chip_info =3D {
> > > +	.name =3D "ad7124-4",
> > > +	.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_4,
> > > +	.num_inputs =3D 8,
> > > +};
> > > +
> > > +static const struct ad7124_chip_info ad7124_8_chip_info =3D {
> > > +	.name =3D "ad7124-8",
> > > +	.chip_id =3D AD7124_ID_DEVICE_ID_AD7124_8,
> > > +	.num_inputs =3D 16,
> > >  };
> > > =20
> > >  static int ad7124_find_closest_match(const int *array,
> > > @@ -1341,17 +1335,15 @@ static int ad7124_probe(struct spi_device *sp=
i)
> > >  }
> > > =20
> > >  static const struct of_device_id ad7124_of_match[] =3D {
> > > -	{ .compatible =3D "adi,ad7124-4",
> > > -		.data =3D &ad7124_chip_info_tbl[ID_AD7124_4], },
> > > -	{ .compatible =3D "adi,ad7124-8",
> > > -		.data =3D &ad7124_chip_info_tbl[ID_AD7124_8], },
> > > +	{ .compatible =3D "adi,ad7124-4", .data =3D &ad7124_4_chip_info },
> > > +	{ .compatible =3D "adi,ad7124-8", .data =3D &ad7124_8_chip_info },
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ad7124_of_match);
> > > =20
> > >  static const struct spi_device_id ad71124_ids[] =3D {
> > > -	{ "ad7124-4", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_4] },
> > > -	{ "ad7124-8", (kernel_ulong_t)&ad7124_chip_info_tbl[ID_AD7124_8] },
> > > +	{ "ad7124-4", (kernel_ulong_t)&ad7124_4_chip_info },
> > > +	{ "ad7124-8", (kernel_ulong_t)&ad7124_8_chip_info },
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(spi, ad71124_ids); =20
>=20
> The patch looks fine for me. I remember having considered creating such
> a patch, too.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
Applied.  Thanks

>=20
> Best regards
> Uwe


