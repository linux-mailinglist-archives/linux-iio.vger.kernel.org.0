Return-Path: <linux-iio+bounces-22344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA188B1C8E1
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A18623A8C
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1C292912;
	Wed,  6 Aug 2025 15:40:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2826D19A
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494832; cv=none; b=h4T60Drdk4r3ioxkPhGvrwxrEAniUxyRPIuU2c+9Q+oiyzq7bWp6o8G6l6W8eGOmHEaOfg9zVnaFTvXzDlSZ7BzT7BKaZJ43O34lPgYx/FfnZc92lo+vlQebjxRmxZ7wDbXY05VDfw3dxJhkgBAhf6BUT3XVhNo6XAdu/A/70QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494832; c=relaxed/simple;
	bh=zBg5x/WbrKXN1kVTE0d0LMFCeNSPjqkSW7620T7o7jI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjyY+K6Y/U2X0fmGMwmNka6hXrTnqbtrDkpgM8y+LOYTH4pjbGjIkw+v5MQnPVoxKM2xoJzwgHdN1lStqsJGGmdCaTWwyMBtUa9sAyY+BD49ahHWD2DSKKwHY0eW2Ip8zgJXV2ZSiBHkqAVuKzUAAQMwnIz1giuaqQgWAyxBcvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxvZT3CZQz6L55D;
	Wed,  6 Aug 2025 23:38:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 56FCC1402EC;
	Wed,  6 Aug 2025 23:40:28 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 17:40:27 +0200
Date: Wed, 6 Aug 2025 16:40:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shen Jianping
	<Jianping.Shen@de.bosch.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
Message-ID: <20250806164025.000052f6@huawei.com>
In-Reply-To: <CAHp75VeH2R28=kVQcVGOZTZ0wGTtHB_1AmhnwVUofcOsT2g8mw@mail.gmail.com>
References: <20250802171539.518747-1-jic23@kernel.org>
	<CAHp75VfuLcV5Bv1WG3hbRr3P1-kxusN1Gf2dge1mC68cYGfxvw@mail.gmail.com>
	<20250804114819.0000795a@huawei.com>
	<CAHp75VeH2R28=kVQcVGOZTZ0wGTtHB_1AmhnwVUofcOsT2g8mw@mail.gmail.com>
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

On Mon, 4 Aug 2025 14:52:23 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 4, 2025 at 12:48=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> > On Sun, 3 Aug 2025 21:46:50 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > On Sat, Aug 2, 2025 at 7:15=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote: =20
>=20
> ...
>=20
> > > > +       /* Walk remaining bits of active_scan_mask */
> > > > +       in_ind =3D find_next_bit(indio_dev->active_scan_mask, maskl=
ength,
> > > > +                              in_ind + 1);
> > > > +       while (in_ind !=3D masklength) { =20
> > >
> > > for_each_set_bit_from() ? =20
> >
> > Would work but then takes the style away from the code above that this
> > effectively duplicates.  I'd need to have a closer look to see if we
> > can potentially convert that as well.  I don't want two very different
> > looking bits of code effectively doing the same thing under subtly
> > different constraints. =20
>=20
> I see. But can we have this as a fix followed by the conversion patch
> in one series, so we won't forget about that?

Maybe.  This is a nasty bug so I'm not sure I want to delay the fix
whilst I work out how to cleanup the section above.

I'll see if I can find time to work on this. The time is mostly on
building test cases rather than the code.
>=20
> > > > +               ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
> > > > +               if (ret < 0)
> > > > +                       goto error_clear_mux_table;
> > > > +
> > > > +               length =3D ret;
> > > > +               /* Make sure we are aligned */
> > > > +               in_loc =3D roundup(in_loc, length) + length;
> > > > +               in_ind =3D find_next_bit(indio_dev->active_scan_mas=
k,
> > > > +                                      masklength, in_ind + 1);
> > > > +       } =20
>=20
>=20


