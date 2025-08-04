Return-Path: <linux-iio+bounces-22280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009CB1A045
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F901888CDE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF4246761;
	Mon,  4 Aug 2025 11:07:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78711F582F
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305674; cv=none; b=oUKtq3OBXJiDDQM4Ab8Hj7rI8HbeuXnvv30hM+kxe9sUFWRJEMxgUPuPbyKylSYH28V9zGInUFcVzuonxpMakaU8x5hjsY99udrBzlGec0qHZi0cjALCjVpbJZyCIfSXy9ONfkJ+oPd+dO9bhfEeTI9Z5sMemklubC7RBSK931I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305674; c=relaxed/simple;
	bh=KySrllzE6sUissMxqiKMnwuM0dGSS6IQpgxd2wnnVfA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+3aR9QVkCWrDPNRiHpYO0Rf6Ap9lHI1BPckNahtDnEHYhMfvb872ec+tCYc6ncHGuIv4+GZ24K0HP9133g1yl25JHj5Ihr4Cd7Fc+wBhVPDsC5WT+/0/UV51GR4Omaq9fJUGwnble+iyVV03imEfnxO3bWTulaEw+yUIUXBjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bwYC13M8Sz6D9C2;
	Mon,  4 Aug 2025 18:46:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B62D140133;
	Mon,  4 Aug 2025 18:48:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 4 Aug
 2025 12:48:20 +0200
Date: Mon, 4 Aug 2025 11:48:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Shen Jianping
	<Jianping.Shen@de.bosch.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
Message-ID: <20250804114819.0000795a@huawei.com>
In-Reply-To: <CAHp75VfuLcV5Bv1WG3hbRr3P1-kxusN1Gf2dge1mC68cYGfxvw@mail.gmail.com>
References: <20250802171539.518747-1-jic23@kernel.org>
	<CAHp75VfuLcV5Bv1WG3hbRr3P1-kxusN1Gf2dge1mC68cYGfxvw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 3 Aug 2025 21:46:50 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Aug 2, 2025 at 7:15=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The IIO channel demultiplexer code is there to deal with a mismatch bet=
ween
> > the channels captured and those requested by user space either due to
> > driver supporting only particular channel combinations
> > (available_scan_masks) or due to multiple concurrent consumers (e.g.
> > userspace IIO buffered interfaces and an inkernel consumer such as a
> > touch screen).
> >
> > Whilst this code is exercised by many drivers, a corner case has been
> > hiding there all along.
> >
> > Consider an input of (postfix is the channel size) =20
>=20
> size in bits
>=20
> > a_32, b_32, c_32, d_32, ts_64
> >
> > and desired output of
> >
> > a32, b_32, ts_64 =20
>=20
> You missed underscore here and below.
>=20
> > the current code ends up with
> >
> > a32, b_32, c_32, d_32
> >
> > because of a failure to iterate over the tail of unwanted channels
> > (here c_32 and d_32).
> >
> > Fix this by adding the code to walk the channels in the gap.
> >
> > Reported-by: Jianping Shen <Jianping.Shen@de.bosch.com>
> > Closes: https://lore.kernel.org/all/AM8PR10MB4721FB1A78F25B204BE3A26ACD=
5FA@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
>=20
> Fixes?
>=20
> ...
>=20
> > Whilst this is being tested I'll try to figure out a Fixes tag.
> > There is some code movement so needs more digging that I have time for
> > today. =20
>=20
> Ah, okay.
>=20
>=20
> > +       /* Walk remaining bits of active_scan_mask */
> > +       in_ind =3D find_next_bit(indio_dev->active_scan_mask, masklengt=
h,
> > +                              in_ind + 1);
> > +       while (in_ind !=3D masklength) { =20
>=20
> for_each_set_bit_from() ?

Would work but then takes the style away from the code above that this
effectively duplicates.  I'd need to have a closer look to see if we
can potentially convert that as well.  I don't want two very different
looking bits of code effectively doing the same thing under subtly
different constraints.

Jonathan

>=20
> > +               ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
> > +               if (ret < 0)
> > +                       goto error_clear_mux_table;
> > +
> > +               length =3D ret;
> > +               /* Make sure we are aligned */
> > +               in_loc =3D roundup(in_loc, length) + length;
> > +               in_ind =3D find_next_bit(indio_dev->active_scan_mask,
> > +                                      masklength, in_ind + 1);
> > +       } =20
>=20
>=20


