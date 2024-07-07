Return-Path: <linux-iio+bounces-7409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED279298A9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 17:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03671C21442
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BADD3A29A;
	Sun,  7 Jul 2024 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYMAdewH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D52C87A;
	Sun,  7 Jul 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720366490; cv=none; b=rTDGcOXMiDU4xN4C6zbiZitajg+yOPmnHy5GcJXe8xEjDxYMkh2uA3EGt8esozgBdP1EbxUwn/PiRco3nrJHSuj+ydECXCIDFgkGrzTjUr/H5MJaGADwGcSXSX4r1Ppy2LO/vvi8CRZIbjYkg2nKo03dK4QT5IIor0XC4tVIINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720366490; c=relaxed/simple;
	bh=yeQt0xBLWuvv7mtjalWkhObeOLcq5FmgaYYEQtqOphc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HljiLgMyjgTBb1swZFRD4Kr0Cizgx4d9B3PYKnTUNFQ1Jo3YFqnu1mMxDfdORfuertO1yWSpgvblUsJpI/LgnqM1Q7caHlv2NzVfbBYEuB0GIT+scuJtcJlNtlvHEU9ibK7kg6+NXQggm0TQjPlrWMXzLrQdBz5bsnXUuGOqg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYMAdewH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A56C3277B;
	Sun,  7 Jul 2024 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720366489;
	bh=yeQt0xBLWuvv7mtjalWkhObeOLcq5FmgaYYEQtqOphc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kYMAdewHXr9iPVGonq3LOHSOGBhMjKRji7IFfVU5e/dw0Ti0P9ywWwzvgVzfPwg6y
	 mQD+Fte8Z/0jV75yMHU3UL8k+TbbR3zxzx6cqAIBpvDjy+GNH0/O/X4XatBgMAsb9R
	 wHKejCDocBDJe6RIWhDlr5b4zhrOA7qSDE2ZzWwhOb4gZkIcKom+xIQDZ+og6losJ3
	 bMN0uxivUMf4RQVlaVuIevmwx85dX/W/eBV9BU/yOpxg2O3ssEs3qzSfIEzNmvdAoK
	 9ikmtxZMPLWKVKYpoQIUQlcKYJkmGUuicM5LCmeGVHm3NwR2epm8oMMJ282eJEQdqu
	 qIjopE6/UjBHA==
Date: Sun, 7 Jul 2024 16:34:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240707163441.22d31247@jic23-huawei>
In-Reply-To: <CADFWO8E_yHdbnC7BtOXODYnKgmP9t-4sXANsveYOxw89N8V3Fw@mail.gmail.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
	<20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
	<20240702211615.0334c2e6@jic23-huawei>
	<CADFWO8E_yHdbnC7BtOXODYnKgmP9t-4sXANsveYOxw89N8V3Fw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jul 2024 10:09:26 +0200
Petar Stoykov <pd.pstoykov@gmail.com> wrote:

> On Tue, Jul 2, 2024 at 10:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 02 Jul 2024 16:59:09 +0200
> > Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> w=
rote:
> > =20
> > > From: Petar Stoykov <pd.pstoykov@gmail.com>
> > >
> > > Sensirion SDP500 is a digital differential pressure sensor. The senso=
r is
> > > accessed over I2C.
> > >
> > > Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com> =20
> > Hi Petar
> >
> > Given you are going to be doing a v4, a few comments inline on things
> > to tidy up in here.
> >
> > Note that I've already tagged what may be the last pull request from me
> > for the 6.11 merge window, so this is probably 6.12 material now anyway.
> > Hence plenty of time to tidy up.
> >
> > Jonathan
> > =20
>=20
> Hi Jonathan,
> I have no rush, thank you for the explanation!
>=20
> > > diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp=
500.c
> > > new file mode 100644
> > > index 000000000000..661c70bc1b5b
> > > --- /dev/null
> > > +++ b/drivers/iio/pressure/sdp500.c
> > > @@ -0,0 +1,153 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Driver for Sensirion sdp500 and sdp510 pressure sensors
> > > + *
> > > + * Datasheet: https://sensirion.com/resource/datasheet/sdp600
> > > + */
> > > +
> > > +#include <linux/i2c.h>
> > > +#include <linux/crc8.h>
> > > +#include <linux/iio/iio.h> =20
> >
> > #include <linux/mod_devicetable.h> appropriate for the id tables. =20
>=20
> I don't understand. Why add an extra header to a working driver?
> I will add it and test the driver in the meantime.

It's included via another path today (at least on the architectures
you've tested with), but we more or less prefer to operate on an
include what you use principle.

There are exceptions where it is considered very obvious that
the headers will always be included but this isn't one of them.
(there is no hard list of which ones are included though :(
>=20
> > =20
> > > +#include <linux/regulator/consumer.h>
> > > +#include <asm/unaligned.h>
> > > +
> > > +#define SDP500_CRC8_POLYNOMIAL  0x31   // x8 + x5 + x4 + 1 (normaliz=
ed to 0x31) =20
> >
> > For IIO we tend to just use c style comments /* xxx */
> > and not c++ ones. =20
>=20
> I try to follow this rule but once in a while I slip to my old habits.
> My teachers all used // for C for whatever reason. Will fix.
>=20
> > =20
> > > +#define SDP500_READ_SIZE        3 =20
> > =20
> > > +static int sdp500_read_raw(struct iio_dev *indio_dev,
> > > +                       struct iio_chan_spec const *chan,
> > > +                       int *val, int *val2, long mask)
> > > +{
> > > +     int ret;
> > > +     u8 rxbuf[SDP500_READ_SIZE];
> > > +     u8 received_crc, calculated_crc;
> > > +     struct sdp500_data *data =3D iio_priv(indio_dev);
> > > +     struct i2c_client *client =3D to_i2c_client(data->dev);
> > > +
> > > +     switch (mask) {
> > > +     case IIO_CHAN_INFO_RAW:
> > > +             ret =3D i2c_master_recv(client, rxbuf, SDP500_READ_SIZE=
);
> > > +             if (ret < 0) {
> > > +                     dev_err(data->dev, "Failed to receive data");
> > > +                     return ret;
> > > +             }
> > > +             if (ret !=3D SDP500_READ_SIZE) {
> > > +                     dev_err(data->dev, "Data is received wrongly");
> > > +                     return -EIO;
> > > +             }
> > > +
> > > +             received_crc =3D rxbuf[2];
> > > +             calculated_crc =3D crc8(sdp500_crc8_table, rxbuf, sizeo=
f(rxbuf) - 1, 0x00); =20
> > A line break in here to keep it under 80 chars would be good (see below=
). =20
>=20
> I find the 80 chars too constraining and also saw that the limit was upda=
ted
> to 100 somewhere in kernel.org which made me happy. But.. you seem to
> feel strongly enough about this so I'll trim lines to 80.

100 is fine if it helps readability.  I'd argue it doesn't significantly
help here.

Some parts of the kernel are fussier than others, but it's rare you'll get
told to increase your wrap length above 80 unless there is a readability
advantage.

Jonathan





