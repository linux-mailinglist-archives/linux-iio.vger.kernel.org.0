Return-Path: <linux-iio+bounces-22624-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A14CB22CC9
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC591A2374A
	for <lists+linux-iio@lfdr.de>; Tue, 12 Aug 2025 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32DF2F28E7;
	Tue, 12 Aug 2025 15:57:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528532F659C
	for <linux-iio@vger.kernel.org>; Tue, 12 Aug 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014275; cv=none; b=QZTcHc0fAOtoZJ1OUmWKjs99V2HhOi0FOg4bhM4Sz5cDjrWnf3korLLxlxUoEolukW+lwv6HbUzwX4rf4YvlVuW53+PRJ4r3Kk+D+1mwl5MNNuT40TJhE5bos3MC9/0A00rPkiejtmHKgTPOCpZ3yXbsThE9wgenK0PnXHkIhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014275; c=relaxed/simple;
	bh=zi6WOuYT2pYtUEozYEHyKfjfL6zvhxBFG3qFuzTmOVA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPeNqs4/4QaRu7VaI+Bd0g+xrQdBgP255/zADA61VcijqQLKVCGOzCDqVqRdFjgkbOfdJEHefRVAjyWfGQhKVqWl5INdVVkRCCMSOMuYoXFWMlYU7kenbfzUqATbIcTRt13DGIg2LqXqFhxWBoUeUU5vKPutNbvbyOzqeNK/L2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c1bhC02Clz6M4c0;
	Tue, 12 Aug 2025 23:55:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 732D51402EC;
	Tue, 12 Aug 2025 23:57:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 12 Aug
 2025 17:57:50 +0200
Date: Tue, 12 Aug 2025 16:57:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Hans de Goede <hansg@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
	Matteo Martelli <matteomartelli3@gmail.com>, Liam Beguin
	<liambeguin@gmail.com>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] iio: consumers: Fix handling of negative channel
 scale in iio_convert_raw_to_processed()
Message-ID: <20250812165749.00001d29@huawei.com>
In-Reply-To: <CAHp75VckeZczX4yniOy30PFg7TZRJM2D=GJEKX8s2EAcBK9F9g@mail.gmail.com>
References: <20250811155453.31525-1-hansg@kernel.org>
	<20250811155453.31525-2-hansg@kernel.org>
	<CAHp75VckeZczX4yniOy30PFg7TZRJM2D=GJEKX8s2EAcBK9F9g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 11 Aug 2025 21:19:36 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 11, 2025 at 5:55=E2=80=AFPM Hans de Goede <hansg@kernel.org> =
wrote:
> >
> > There is an issue with the handling of negative channel scales
> > in iio_convert_raw_to_processed_unlocked() when the channel-scale
> > is of the IIO_VAL_INT_PLUS_[MICRO|NANO] type:
> >
> > Things work for channel-scale values > -1.0 and < 0.0 because of
> > the use of signed values in:
> >
> >         *processed +=3D div_s64(raw64 * (s64)scale_val2 * scale, 100000=
0LL);
> >
> > Things will break however for scale values < -1.0. Lets for example say
> > that raw =3D 2, (caller-provided)scale =3D 10 and (channel)scale_val =
=3D -1.5.
> >
> > The result should then be 2 * 10 * -1.5 =3D -30.
> >
> > channel-scale =3D -1.5 means scale_val =3D -1 and scale_val2 =3D 500000,
> > now lets see what gets stored in processed:
> >
> > 1. *processed =3D raw64 * scale_val * scale;
> > 2. *processed +=3D raw64 * scale_val2 * scale / 1000000LL;
> >
> > 1. Sets processed to 2 * -1 * 10 =3D -20
> > 2. Adds 2 * 500000 * 10 / 1000000 =3D 10 to processed
> >
> > And the end result is processed =3D -20 + 10 =3D -10, which is not corr=
ect.
> >
> > Fix this by always using the abs value of both scale_val and scale_val2
> > and if either is negative multiply the end-result by -1.
> >
> > Note there seems to be an unwritten rule about negative
> > IIO_VAL_INT_PLUS_[MICRO|NANO] values that:
> >
> > i.   values > -1.0 and < 0.0 are written as val=3D0 val2=3D-xxx
> > ii.  values <=3D -1.0 are written as val=3D-xxx val2=3Dxxx
> >
> > But iio_format_value() will also correctly display a third option:
> >
> > iii. values <=3D -1.0 written as val=3D-xxx val2=3D-xxx
> >
> > Since iio_format_value() uses abs(val) when val2 < 0.
> >
> > This fix also makes iio_convert_raw_to_processed() properly handle
> > channel-scales using this third option. =20
>=20
> ...
>=20
> > +               switch (scale_type) {
> > +               case IIO_VAL_INT_PLUS_MICRO: denominator =3D MICRO; bre=
ak;
> > +               case IIO_VAL_INT_PLUS_NANO: denominator =3D NANO; break;
> > +               } =20
>=20
> Now wondering if checkpatch et al. are happy with this style. Not a
> big deal personally to me, but if we have warnings from the tools
> perhaps it's better to avoid them.
Agreed, whilst it's a minor thing let's burn some lines to keep this more
standard looking.

		case IIO_VAL_INT_PLUS_MICRO:
			denominator =3D MICRO;
			break;

		case IIO_VAL_INT_PLUS_NANO:
			denominator =3D NANO;
			break;
		}

>=20
>=20


