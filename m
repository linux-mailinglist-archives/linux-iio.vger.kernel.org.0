Return-Path: <linux-iio+bounces-4953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DE8C3108
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC891F216DF
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2855C1A;
	Sat, 11 May 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O63uNW5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837F54FB8;
	Sat, 11 May 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428488; cv=none; b=tURIRSDfXpqfLPNI1njcUsjTxOajzRl+bHj2NWZz6keWCB7ykHoKRXjXYtxfiF3zWL3pM0qkDWtL4pqkS6TDDRUzthaJwjTFqunqoGxq1LhqTpsYdRn6tg1vUKhtFvlJ7eN2AgSo2dyFeErZ4H7J/rPwpp5jKxYRweA1gCU1F5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428488; c=relaxed/simple;
	bh=BX2HA1FzgL9T4H4tH/EC2Gaq/JIJdDQvLFfl1ZYXuDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjBM0CTVudWYo+LZ5tQU2DC7YxrHv1VSDPbg39JMN1yemvRdOeHtKqnUv1peIYybNMGcr+env8KFS6uznnM+nOTybuXb0cdXe8+j1r2NtE8fwq3xBdV7nAlAqqNq2W/sj85sLxq49Y1/TJwmdjSSS8lv7/LtNKanHUQAWXhddns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O63uNW5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56922C2BBFC;
	Sat, 11 May 2024 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715428487;
	bh=BX2HA1FzgL9T4H4tH/EC2Gaq/JIJdDQvLFfl1ZYXuDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O63uNW5hA0g8BvW47MGCqluTGcSE+h2hNfeNRTdWZTmuosaA+XSCvF8M3rnLqhFtC
	 1pDWWK7tyEExxKfMbs00UvoqfIJy4C3M/RU6s8dECgMWt9D/ABVeTfAZS13d2xpmKU
	 VLdaLglMSCCHLCRkAiBlLcUKsSdVSh3c/wR9O6e4dhwyFqHs+RWB1yBoOkLjBCWIUY
	 9qBvRS/ZzyYXsWjS382vYEIEzNfIMF6vx/Cvwbf6D+kaZWxIucNQhen45M650xrIam
	 XHECuj/o9XBDIzzdLUwBgudq9eLAyHfPBA7G6BBB9guJ4DapiGCs+WNUsktvSjA8sp
	 IGEsFW4vtJXgA==
Date: Sat, 11 May 2024 12:54:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v2 1/2] iio: imu: bmi160: add support for bmi120
Message-ID: <20240511125436.520e3ff4@jic23-huawei>
In-Reply-To: <CAMknhBFUOUy+TVi+baCN-FoLT8N=G4vOD5CgVgaKzvsu502CDQ@mail.gmail.com>
References: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
	<20240504-bmi120-v2-1-3b3ce6e1c3c6@gmail.com>
	<CAMknhBFUOUy+TVi+baCN-FoLT8N=G4vOD5CgVgaKzvsu502CDQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 7 May 2024 17:05:18 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Sat, May 4, 2024 at 8:01=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n <tr=
abarni@gmail.com> wrote:
> >
> > From: Danila Tikhonov <danila@jiaxyga.com>
> >
> > Add support for bmi120 low power variant of bmi160.
> >
> > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > Co-developed-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> > Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> > ---
> >  drivers/iio/imu/bmi160/bmi160_core.c | 26 ++++++++++++++++++++------
> >  drivers/iio/imu/bmi160/bmi160_i2c.c  |  3 +++
> >  drivers/iio/imu/bmi160/bmi160_spi.c  |  3 +++
> >  3 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi=
160/bmi160_core.c
> > index a77f1a8348ff..468aa80318fc 100644
> > --- a/drivers/iio/imu/bmi160/bmi160_core.c
> > +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> > @@ -26,6 +26,7 @@
> >  #include "bmi160.h"
> >
> >  #define BMI160_REG_CHIP_ID     0x00
> > +#define BMI120_CHIP_ID_VAL     0xD3
> >  #define BMI160_CHIP_ID_VAL     0xD1
> >
> >  #define BMI160_REG_PMU_STATUS  0x03
> > @@ -112,6 +113,11 @@
> >         .ext_info =3D bmi160_ext_info,                            \
> >  }
> >
> > +const u8 bmi_chip_ids[] =3D {
> > +       BMI120_CHIP_ID_VAL,
> > +       BMI160_CHIP_ID_VAL,
> > +};
> > +
> >  /* scan indexes follow DATA register order */
> >  enum bmi160_scan_axis {
> >         BMI160_SCAN_EXT_MAGN_X =3D 0,
> > @@ -704,6 +710,16 @@ static int bmi160_setup_irq(struct iio_dev *indio_=
dev, int irq,
> >         return bmi160_probe_trigger(indio_dev, irq, irq_type);
> >  }
> >
> > +static int bmi160_check_chip_id(const u8 chip_id)
> > +{
> > +       for (int i =3D 0; i < ARRAY_SIZE(bmi_chip_ids); i++) {
> > +               if (chip_id =3D=3D bmi_chip_ids[i])
> > +                       return 0; =20
>=20
> It looks like this will match either chip to either ID. If we do this,
> then why check the ID at all?
>=20
> Another approach could be to put the chip ID as the match data in
> bmi160_*_match, then you would get the right ID based on the
> compatible string.

It is useful as a sanity check to at least hint to the user that we either
recognise the device or not.  It's annoyingly common for vendors
to switch out a chip for one where the vendor driver reads the ID from the
device and deals with completely incompatible parts. They do this without
updating the firmware.

In one or two cases we've had to wrap multiple Linux drivers up to paper
over this garbage. (It seems to be more common for ACPI tables, where
we can push that as a platform quirk :)

If we end up with this driver supporting slightly incompatible variants then
adding that info to the ID table is useful because then, if we fail to match
ID here (because someone is using a fallback compatible) we can pick the
device that their firmware is claiming the replacement is backwards compati=
ble
with.

For now, just warning here on no match and carrying on is the right
approach.
=20
>=20
> > +       }
> > +
> > +       return -ENODEV;
> > +}
> > +
> >  static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> >  {
> >         int ret;
> > @@ -737,12 +753,10 @@ static int bmi160_chip_init(struct bmi160_data *d=
ata, bool use_spi)
> >                 dev_err(dev, "Error reading chip id\n");
> >                 goto disable_regulator;
> >         }
> > -       if (val !=3D BMI160_CHIP_ID_VAL) {
> > -               dev_err(dev, "Wrong chip id, got %x expected %x\n",
> > -                       val, BMI160_CHIP_ID_VAL);
> > -               ret =3D -ENODEV;
> > -               goto disable_regulator;
> > -       }
> > +
> > +       ret =3D bmi160_check_chip_id(val);
> > +       if (ret)
> > +               dev_warn(dev, "Chip id not found: %x\n", val); =20
>=20
> This changes the error with probe failure to a warning, but the commit
> message doesn't explain why. We always want to know why changes were
> made. :-)
>=20
> Should also probably be in a separate patch since changing the
> behavior here is a separate change from adding support for a new chip.
True, separate patch would be ideal as maybe someone will backport this cha=
nge and
not the rest.
>=20
> >
> >         ret =3D bmi160_set_mode(data, BMI160_ACCEL, true);
> >         if (ret) =20
>=20
> ...


