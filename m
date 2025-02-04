Return-Path: <linux-iio+bounces-14974-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6330A274C5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 15:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF997A1474
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F552139CE;
	Tue,  4 Feb 2025 14:46:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419D2135D1;
	Tue,  4 Feb 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680397; cv=none; b=ZI+ANdLWLJqUGpLFnmzVVM3lE9QISFhFgp+JdbZOFI9xMfx5mfn2L+DhLjcXpDNzbeBLtNMvOkjT0qqdCrTd9eYCPAOwgQReSz3qjbFte8p5uwe2Hg15IOVYa2MQgJIQLJ1ela5KTnq/Ef0O3Mp4D/ZQyc9c+j2YIPy4pYgMwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680397; c=relaxed/simple;
	bh=7SnvNHCDheUVJ61s+3mFp+3r46huwqptDX6SjVXuvB4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBUaEyDfjuj6BLw0TpKYR6tUV28f+tQLuGPmLuSOvpy/qSs5X0aGhdjoVPU8vgYwmh1Uc6t7t1YMBOy3sYRLYl5ARXKp7ATLIdFxexRjIq6umpuZ6ogMR/RmKvIM65JhkCaN48LzVzXwE9bNHZmivRIflDCmqmMQ8fjXtPk23nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnR4N5YpCz6J9xh;
	Tue,  4 Feb 2025 22:45:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 926711400CA;
	Tue,  4 Feb 2025 22:46:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 15:46:33 +0100
Date: Tue, 4 Feb 2025 14:46:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eraretuya@gmail.com>
Subject: Re: [PATCH v1 01/12] iio: accel: adxl345: migrate constants to core
Message-ID: <20250204144632.00006a73@huawei.com>
In-Reply-To: <CAFXKEHaaYXpcQ92ahWwuBbsCJYEzCi=tUSkpjWMkzhfrCOT_Tg@mail.gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
	<20250128120100.205523-2-l.rubusch@gmail.com>
	<20250201163559.015b343d@jic23-huawei>
	<CAFXKEHaaYXpcQ92ahWwuBbsCJYEzCi=tUSkpjWMkzhfrCOT_Tg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 15:13:34 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sat, Feb 1, 2025 at 5:36=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Tue, 28 Jan 2025 12:00:49 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > The set of constants does not need to be exposed. Move constants to c=
ore
> > > to reduce namespace polution.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Hi Lothar,
> >
> > =20
> > > -#define ADXL345_REG_INT_MAP          0x2F
> > > -#define ADXL345_REG_INT_SOURCE               0x30
> > > -#define ADXL345_REG_INT_SOURCE_MSK   0xFF
> > >  #define ADXL345_REG_DATA_FORMAT              0x31 =20
> >
> > Normally I'd be entirely in favour of this, but...
> > I'm not sure we want to leave one random register here
> > and move the rest.
> >
> > Se can move the stuff that isn't register related, but
> > for the registers I'd prefer to keep them in one place
> > and I can't see a clean way to move them all to the core.c
> > file. Even separating reg address and fields within it
> > makes for a harder check against a datasheet etc.
> >
> > So I think all we can move is the fifo size :(
> > =20
>=20
> I understood that it could be one of the first follow up patches to move =
those
> defines (parts of them?) over to core, as here in this mail:
> https://lore.kernel.org/linux-iio/20241214123926.0b42ea59@jic23-huawei/
> Anyway, I already had presented moving the constants before, when you
> had decided to keep them in the header. I thought you changed your mind
> on that, but I don't want to bother you with the same issue over and over
> again, probably I missunderstood that here.

I'd failed to realize we had to leave one behind :(=20

Sorry for the misdirection!

Jonathan
>=20
> I leave the constants in the .h file then, no problem. :) I can understan=
d the
> intention to keep the things rather together in one place. There seem to =
be
> pros & cons for both.
>=20
> > =20
> > > -#define ADXL345_REG_XYZ_BASE         0x32
> > > -#define ADXL345_REG_DATA_AXIS(index)                         \
> > > -     (ADXL345_REG_XYZ_BASE + (index) * sizeof(__le16)) =20
> > =20
>=20


