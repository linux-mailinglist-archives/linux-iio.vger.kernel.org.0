Return-Path: <linux-iio+bounces-6178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B827904217
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210011C20A03
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47FE40861;
	Tue, 11 Jun 2024 17:02:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56B1EB31;
	Tue, 11 Jun 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125338; cv=none; b=GocXEXtQ3dUaYNDFPkZivFRq5eHsrWoSb+0zFS6U6Gy4g4i1wM3+IYUkH/VdqCHLAo1f7jjJM6eG6s7SHAlKzJOanV9Lk3gIQHO/+bEEuLGEjubJBbnS1XuMSXo1ZLF7BzLo0Ff+PAKd65hZnn9AYhpfo/smu9QuMe27SdsrKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125338; c=relaxed/simple;
	bh=vqJwh1ZTKRcGC6rpPG/75qkN5daDxSCuDaDr2116EpM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paZ1zJOQxYvuLygofhLZ3ydUls4Rgs4FojUc7liooR4juyggExZSiba9+9W9cnYsuLuHZvxeXRVuTxqSO52EnEvLBGdm9UWuZYYILKJmyxdhTy83j2LijeA+CaYAv5nyoRjYt5i3aFftCYBAnsOQqEEPM4imWrBcv0EQEaZT6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzFGS2VWmz6J9x8;
	Wed, 12 Jun 2024 00:57:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 337E0140516;
	Wed, 12 Jun 2024 01:02:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 18:02:11 +0100
Date: Tue, 11 Jun 2024 18:02:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Petar Stoykov <pd.pstoykov@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Angel Iglesias
	<ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240611180210.00006f23@Huawei.com>
In-Reply-To: <CADFWO8FGqD5GyrRtvFptjMdYBhfFFwOzgZ1XnVVEPeY3E8CZPg@mail.gmail.com>
References: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
	<20240505181829.49864540@jic23-huawei>
	<CADFWO8FGqD5GyrRtvFptjMdYBhfFFwOzgZ1XnVVEPeY3E8CZPg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 10 Jun 2024 10:58:35 +0200
Petar Stoykov <pd.pstoykov@gmail.com> wrote:

> On Sun, May 5, 2024 at 7:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Tue, 30 Apr 2024 17:27:24 +0200
> > Petar Stoykov <pd.pstoykov@gmail.com> wrote:
> > =20
> > > From 6ae7537517f551540121ca6fb3b99080b7580410 Mon Sep 17 00:00:00 2001
> > > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > > Date: Mon, 15 Jan 2024 12:21:26 +0100
> > > Subject: [PATCH 2/3] iio: pressure: Add driver for Sensirion SDP500
> > >
> > > Sensirion SDP500 is a digital differential pressure sensor. The senso=
r is
> > > accessed over I2C.
> > >
> > > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com> =20
> > Hi Petar
> >
> > Ignoring the patch formatting which others have already given feedback =
on,
> > a few minor comments inline.
> >
> > Also, I'd expect some regulator handling to turn the power on.
> > Obviously on your particular board there may be nothing to do but good =
to
> > have the support in place anyway and it will be harmless if the power
> > is always on.
> >
> > Jonathan
> > =20
> Hi Jonathan,
>=20
> Thank you for looking past the formatting!
>=20
> I wrongly assumed the power regulator would be handled automatically :)
> I see examples of how to do it in other pressure drivers now.
>=20
> > >  st_pressure-$(CONFIG_IIO_BUFFER) +=3D st_pressure_buffer.o
> > > diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp=
500.c
> > > new file mode 100644
> > > index 000000000000..7efcc69e829c
> > > --- /dev/null
> > > +++ b/drivers/iio/pressure/sdp500.c
> > > @@ -0,0 +1,144 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <linux/i2c.h>
> > > +#include <linux/crc8.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <asm/unaligned.h>
> > > +
> > > +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normaliz=
ed to 0x31)
> > > +#define SDP500_READ_SIZE        3
> > > +#define SDP500_CRC8_WORD_LENGTH 2 =20
> >
> > As below. I'd establish these off the data the are the lengths of by us=
ing
> > a structure definition.  That will be more obvious and less fragile than
> > defines hiding up here.
> >
> > =20
> > > +#define SDP500_CRC8_INIT        0x00 =20
> >
> > I'd just use the number inline.  Can't see what the define is adding. =
=20
>=20
> I've been taught to avoid magic numbers as much as possible.
> Giving it a define directly explains what the number is, even if it's use=
d once.
> But I'll follow the community (in this case, you) for this.

Normally I agree with the magic number case, but this
is an actual value.  We are saying continue the CRC from
0 (i.e. nothing). It's kind of the logical default value
so seeing it in line makes it clear we aren't continuing form
a prior crc etc.

...

> > =20
> > > +    },
> > > +};
> > > +
> > > +static int sdp500_read_raw(struct iio_dev *indio_dev,
> > > +              struct iio_chan_spec const *chan,
> > > +              int *val, int *val2, long mask)
> > > +{
> > > +    int ret;
> > > +    u8 rxbuf[SDP500_READ_SIZE]; =20
> > You could define this as a struct so all the data types are obvious.
> >
> >         struct {
> >                 __be16 data;
> >                 u8 crc;
> >         } __packed rxbuf;
> > The  __packed let's you use sizeof(rxbuf) for the transfer size.
> > Beware though as IIRC that will mean data is not necessarily aligned
> > so you'll still need the unaligned accessors.
> > =20
>=20
> I know, but I prefer to receive data in simple arrays and then deal with =
it.
The disadvantage is you loose the readability a structure brings, but
meh, I don't care that much.=20

>=20
> > > +    u8 rec_crc, calculated_crc;
> > > +    s16 dec_value;
> > > +    struct sdp500_data *data =3D iio_priv(indio_dev);
> > > +    struct i2c_client *client =3D to_i2c_client(data->dev);
> > > +
> > > +    switch (mask) {
> > > +    case IIO_CHAN_INFO_PROCESSED:
> > > +        ret =3D i2c_master_recv(client, rxbuf, SDP500_READ_SIZE);
> > > +        if (ret < 0) {
> > > +            dev_err(indio_dev->dev.parent, "Failed to receive data");
> > > +            return ret;
> > > +        }
> > > +        if (ret !=3D SDP500_READ_SIZE) {
> > > +            dev_err(indio_dev->dev.parent, "Data is received wrongly=
"); =20
> >
> > I'd guess indio_dev->dev.parent =3D=3D data->dev
> > If so use data->dev as more compact and that's where you are getting the
> > i2c_client from.
> > =20
>=20
> Makes sense.
>=20
> > > +            return -EIO;
> > > +        }
> > > +
> > > +        rec_crc =3D rxbuf[2];
> > > +        calculated_crc =3D crc8(sdp500_crc8_table, rxbuf,
> > > SDP500_CRC8_WORD_LENGTH, =20
> >
> > I'd use the number 2 for length directly as it's useful to know this is=
 the
> > __be16 only, or sizeof(__be16)
> > What is the point in rec_crc local variable? =20
>=20
> Ok, I will use sizeof(rxbuff) - 1 instead of the define.
That's obscure and another reason I'd rather see a structure so this
becomes sizeof(a.data)

> The rec_crc is again for readability, like the SDP500_CRC8_INIT define.
> I will change it to "received_crc" which is clearer though.
The fact you compare it with the crc makes that pretty obvious, but
fair enough I guess if you think it helps.

>=20
> > =20
> > > +            SDP500_CRC8_INIT);
> > > +        if (rec_crc !=3D calculated_crc) {
> > > +            dev_err(indio_dev->dev.parent, "calculated crc =3D 0x%.2=
X,
> > > received 0x%.2X",
> > > +                calculated_crc, rec_crc);
> > > +            return -EIO;
> > > +        }
> > > +
> > > +        dec_value =3D get_unaligned_be16(rxbuf);
> > > +        dev_dbg(indio_dev->dev.parent, "dec value =3D %d", dec_value=
); =20
> >

>=20
> > > +};
> > > +module_i2c_driver(sdp500_driver);
> > > +
> > > +MODULE_AUTHOR("Thomas Sioutas <thomas.sioutas@prodrive-technologies.=
com>");
> > > +MODULE_DESCRIPTION("Driver for Sensirion SDP500 differential pressur=
e sensor");
> > > +MODULE_LICENSE("GPL"); =20
> > =20
>=20
> I will test the driver with the suggested changes as soon as I get the
> hardware again
> and I will try using the b4 tool with "web submission endpoint". Thanks a=
gain!
>=20
Good luck! (it should be fine but I've never tried it :)

Jonathan



