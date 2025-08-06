Return-Path: <linux-iio+bounces-22342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D34B1C8D7
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92F0188B716
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0A28DB78;
	Wed,  6 Aug 2025 15:36:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120DAD5A
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494581; cv=none; b=MhDcNA7frXOh1v3GJ/2OghIb4sFR7xQMv+jtQFqnohW/+Qx5pys0PRzE5gsuehYJTxykXKSiIIGDXK9GHxK9Sk2R3p/drZRG0q/VbLzuovX1u2YogkpUKSZRYb1SPnp+shjjxmafp/IY2OKeux0Ry1jbqfj4BPhAljopb983c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494581; c=relaxed/simple;
	bh=O1yxPhLAmi0iDESb4NA3PD7b+Kt74eOEiExACAQKMWo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3/yE34FrfTRaoLssx7GHiM+LpWo3QkUSqgp+lnaWdWOFOh6rkgNOQHSll1UkFrC7oRZ1IHbNmldr2q1l742WM+ixRve2fy1fGq33m/jqT+LDDomU2uw7Dg8kQLZrfl6L4y5+jid+v/pXxrHLD8ZMoo7/wMog+baEZUSXfBAyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxvR22qJGz6GDH9;
	Wed,  6 Aug 2025 23:31:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D7CBD1402EC;
	Wed,  6 Aug 2025 23:36:15 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 17:36:14 +0200
Date: Wed, 6 Aug 2025 16:36:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Jonathan Cameron
	<jic23@kernel.org>, <linux-iio@vger.kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Shen Jianping <Jianping.Shen@de.bosch.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
Message-ID: <20250806163613.00003788@huawei.com>
In-Reply-To: <CAHp75VcWepvA73Pv=JHZn3BAnnO=NcaEvU85p2yQrVJW_pXFmw@mail.gmail.com>
References: <20250802171539.518747-1-jic23@kernel.org>
	<73r5iyaprblcalagi7gt3bxjdnoudfyagwgz3n7dvmjhzjvure@2yekmv62faa4>
	<CAHp75VcuWfQtxrhdZeX4cZ3aNnCZb1mKbZaUPVwF8oOnfpPcFw@mail.gmail.com>
	<zaymyis6xp4t6qz6se2xehj4gp4lzaybuu2vzabew3pxqoxtsf@36dykzwuloq6>
	<CAHp75VcWepvA73Pv=JHZn3BAnnO=NcaEvU85p2yQrVJW_pXFmw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 5 Aug 2025 14:41:03 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Aug 5, 2025 at 10:16=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> > On Mon, Aug 04, 2025 at 06:02:22PM +0200, Andy Shevchenko wrote: =20
> > > On Mon, Aug 4, 2025 at 5:37=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote: =20
> > > > On Sat, Aug 02, 2025 at 06:15:39PM +0100, Jonathan Cameron wrote: =
=20
>=20
> ...
>=20
> > > > > +     /* Walk remaining bits of active_scan_mask */
> > > > > +     in_ind =3D find_next_bit(indio_dev->active_scan_mask, maskl=
ength,
> > > > > +                            in_ind + 1); =20
> > > >
> > > > I wonder if it matters to check that in_ind + 1 is in fact lower th=
an
> > > > masklength? Not that it will be an issue for find_next_bit() but we=
 will
> > > > fail the expectation:
> > > >
> > > > if (unlikely(__start >=3D sz)) [1]
> > > >
> > > > And being this a sensible path, I thought it's worth (at least) que=
stioning... =20
> > >
> > > It doesn't matter. The find_*_bit() are all aligned to return sz for
> > > anything "not found anymore" cases, so it will be okay. =20
> >
> > I know :):
> >
> > "...Not that it will be an issue for find_next_bit()..."
> >
> > I was mostly worried by performance as we'll have a compiler hint that
> > will pretty much fail (that =C2=B4if (unlikely(__start >=3D sz))' for e=
very sample we push and
> > I guess the CPU will have to unroll that prediction. Maybe it will be s=
mart enough to
> > adapt. =20
>=20
> Ah, I see now. Yeah, there might be a hint to skip the branch which is
> unlikely() for.

Assuming I remember how this all works...

This doesn't happen on the fast path (pushing samples)
It's a setup activity on a buffer being enabled.  The code is
generating a table of offsets and sizes that are then used to
on every sample.  So I don't think it's worth bothering to optimize it.

Jonathan

>=20
> > But as I said, it might be neglectable but still worth at least
> > questioning...
> > =20
> > > > Other than that kind of nit comment, patch looks good.
> > > >
> > > > [1]: https://elixir.bootlin.com/linux/v6.16/source/lib/find_bit.c#L=
50 =20
> > > =20
> > > > > +     while (in_ind !=3D masklength) {
> > > > > +             ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
> > > > > +             if (ret < 0)
> > > > > +                     goto error_clear_mux_table;
> > > > > +
> > > > > +             length =3D ret;
> > > > > +             /* Make sure we are aligned */
> > > > > +             in_loc =3D roundup(in_loc, length) + length;
> > > > > +             in_ind =3D find_next_bit(indio_dev->active_scan_mas=
k,
> > > > > +                                    masklength, in_ind + 1);
> > > > > +     } =20
>=20


