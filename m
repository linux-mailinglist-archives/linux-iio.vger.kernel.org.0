Return-Path: <linux-iio+bounces-22468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5DFB1EA8E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBF21C223C3
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23127EC99;
	Fri,  8 Aug 2025 14:44:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E8282FA;
	Fri,  8 Aug 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664240; cv=none; b=UvGfbFk0oSxUbnYEJHlShXrxr7/cMdLkBS/yaHnmx5x3lG1HWfbf5zKaTk1kMpGgkBgeG+xP1x2fGbBOhL/hakLDwX2XEoSu9WKupS80kFrQmEoAMKlsAkcEAcr197NtGUI7qiwDkG38H5U/e/DhEtyA0HzhYwa5xeQesLzEHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664240; c=relaxed/simple;
	bh=AT22WWEWgRGbWpfHF+5iKTCOx/Zy+q6eIlXaAXk0YO0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cs6GQrcCxNskM2MrJghJlnnfF6oa5BodaGUNnRtCiHs59r5DlBNNWM9t1GEuM7Ede+xK0f9145tmpzgmHG7Z9lzg66Im/97NmdDrpxNobZ2x/7GYmG4zLQf+0sz6Tye+Oe0VW50yFUsQWXAA0bcx9ogOnmGect0dUIvNkN1STAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz69b1n74z6L4xr;
	Fri,  8 Aug 2025 22:39:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C0B7140427;
	Fri,  8 Aug 2025 22:43:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 16:43:53 +0200
Date: Fri, 8 Aug 2025 15:43:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, David Lechner
	<dlechner@baylibre.com>, Salah Triki <salah.triki@gmail.com>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Cameron
	<jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: ad4170-4: Use ERR_PTR() with %pe to
 improve error logging
Message-ID: <20250808154351.000054da@huawei.com>
In-Reply-To: <CAHp75VfWsyj6q1dYK2dL7Mp3W=98SMGJT=ner3k6ty_NFVYM+Q@mail.gmail.com>
References: <aJReTh-t5D45aZNV@pc>
	<fe98c2a2-ec8d-4352-a9fb-6f0e798f7268@baylibre.com>
	<CAHp75VfH6xuiPNZA_eGmFgMGxdGTf-y6o+SEKeCbG=wsUOJYfg@mail.gmail.com>
	<CAHp75VfEC3qUurUO4LKA1d6_Ot15AHY2zG9tk3wWrtYAgHrHgQ@mail.gmail.com>
	<c8189da5-f660-4500-b3b3-246913453ad5@baylibre.com>
	<aJXonEh2W8NNDMZU@debian-BULLSEYE-live-builder-AMD64>
	<CAHp75VfWsyj6q1dYK2dL7Mp3W=98SMGJT=ner3k6ty_NFVYM+Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 8 Aug 2025 14:30:53 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 8, 2025 at 2:07=E2=80=AFPM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> > On 08/07, David Lechner wrote: =20
> > > On 8/7/25 4:02 PM, Andy Shevchenko wrote: =20
> > > > On Thu, Aug 7, 2025 at 11:01=E2=80=AFPM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote: =20
> > > >> On Thu, Aug 7, 2025 at 6:03=E2=80=AFPM David Lechner <dlechner@bay=
libre.com> wrote: =20
> > > >>> On 8/7/25 3:05 AM, Salah Triki wrote: =20
>=20
> ...
>=20
> > > >>>>       ret =3D __ad4170_read_sample(indio_dev, chan, val);
> > > >>>>       if (ret) {
> > > >>>> -             dev_err(dev, "failed to read sample: %d\n", ret);
> > > >>>> +             dev_err(dev, "failed to read sample: %pe\n", ERR_P=
TR(ret));
> > > >>>>
> > > >>>>               ret2 =3D ad4170_set_channel_enable(st, chan->addre=
ss, false);
> > > >>>>               if (ret2)
> > > >>>> -                     dev_err(dev, "failed to disable channel: %=
d\n", ret2);
> > > >>>> +                     dev_err(dev, "failed to disable channel: %=
pe\n", ERR_PTR(ret2));
> > > >>>>
> > > >>>>               return ret;
> > > >>>>       } =20
> > > >>>
> > > >>> Interesting, I didn't know we had this format specifier. But I th=
ink
> > > >>> this is something we would want to do kernel-wide or not at all t=
o stay
> > > >>> consistent. =20
> > > >>
> > > >> I'm sorry but I didn't follow. This is a kernel-wide format specif=
ier. =20
> > >
> > > I meant that it would be strange to make this change just in one
> > > driver and not do the same everywhere else. =20
> >
> > Casting error values to pointers is already being done by many IIO driv=
ers
> > if we consider the use of dev_err_probe().
> > __dev_probe_failed() does the casting from within dev_err_probe()
> > https://elixir.bootlin.com/linux/v6.15.9/source/drivers/base/core.c#L50=
26 =20
>=20
> This is a manipulation. The dev_err_probe() and __dev_probe_failed()
> are parts of the core where we specifically bend the rules for all in
> one place just for a reason to avoid this spreading (and avoid
> creating specific APIs).
>=20
> > Thus, I think this patch makes the error messaging from ad4170
> > more consistent and, because of that, I also see this as a good change.
> >
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com> =20
>=20
> Thanks for the review...
>=20
> > Though, I'm also totally fine if maintainers prefer not to take this ch=
ange for
> > whatever reason. =20
>=20
> ...but the below still stays...
>=20
> > > > And to be clear: I am not in favour of this change exactly due to a
> > > > bit weird (for the reader) castings just for the sake of use of %pe=
. =20
>=20

Agreed.  To me having this cast broadly used in drivers is just too weird.

I'd prefer we dig down a little further and use what %pe is using directly.

#include <linux/errname.h>

printk(... %s\n", errname(ret));

It's not much used so far though but there is precedence via a wrapper
in bcachefs. We'd probably want to select CONFIG_SYMBOLIC_ERRNAME for IIO
though (rather than every driver).

Jonathan




