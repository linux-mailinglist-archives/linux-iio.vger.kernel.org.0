Return-Path: <linux-iio+bounces-8944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B396770B
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 16:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395761F215F0
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047B17F500;
	Sun,  1 Sep 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWDHAnMe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C813D606;
	Sun,  1 Sep 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725200634; cv=none; b=C/Ko/5IZtCf4rlpNhnM1BJY99epc/bVl2LBj8d7sl8vqYyftffz6iPgqWPPKYNV1/jw5I+desw06Zswhkg/hPqbo1V4ppXp17AFMwMPYA3q7ZLrnH+utn2lrfVfbfpfqXF8JQrTvc+H0ysU9j3n4xlcXwqcGmp4MV75tGtqJU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725200634; c=relaxed/simple;
	bh=zSobwp7oh2TA8YTcBou4k1iduzlWERahemknlMuDCJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMj+9j50mZD/KJt29PdDvPQFzOpNkbiU9f1/WWPD8snHJWIoQJmTmhuJRVqyqbcpVmU/s572FWKHAmk7J6lcxsqqgsi58u2VP99dPSLJZ55yyZYY24AUPJS7kD2/kXuiLGqrsAz/VMbbCbzBKnahMvxFIi84+Xa516eX2aHyGwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWDHAnMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E8EC4CEC3;
	Sun,  1 Sep 2024 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725200633;
	bh=zSobwp7oh2TA8YTcBou4k1iduzlWERahemknlMuDCJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UWDHAnMe8lPIoTmRPbYnGOR3d6rN835wAz6+iDakN3mrHVO/2JZApJM5pyADZdFa/
	 twn+agcPl8uythWecuI3SD/mdYEkH66glcdI2DZ1HueDKGhlaSgG/emNtdOZCUHGiD
	 sabMxg96rP0gmjkSc4CBiDR2PKmft2YskdJK73Vrn1lkeVuNWM0TcGV5l9xoVlHBtW
	 siXByeHbq/VEcjtCRWM/nzmQpjS3CKMgFzA/Uzl7FDcMp0DicRmxl9uCniGWXUAqaj
	 wf0dcnOheXBnM5SiadCPghx7lWSuht/oIYJREsAWCO1eG04SNnWNUaotLmEIGGcA+W
	 mF9Eyw7xjcRvg==
Date: Sun, 1 Sep 2024 15:23:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: jason liu <jasonliu10041728@gmail.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
 "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
Message-ID: <20240901152346.45b096c3@jic23-huawei>
In-Reply-To: <CAJci1vCztZAnmHrVn=4b9hnRmMCQE=6R7uQnznPQ0FSpFHQK5w@mail.gmail.com>
References: <20240825063938.56319-1-jasonliu10041728@gmail.com>
	<FR3P281MB1757A595F22A1F9AE50B76B1CE8B2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20240826111858.7824a811@jic23-huawei>
	<CAJci1vCztZAnmHrVn=4b9hnRmMCQE=6R7uQnznPQ0FSpFHQK5w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 1 Sep 2024 13:04:59 +0800
jason liu <jasonliu10041728@gmail.com> wrote:

> Hi, I would like to know your current opinion on this patch.
>=20
> Let me explain the reason for proposing this patch.
>=20
> First, through __spi_register_driver, we know that when registering an SPI
> driver, if an id_table is present, it matches the id_table; otherwise, it
> matches the SPI device's driver_name.
> Then, in inv_icm_42600spi.c, driver name is "inv-icm42600-spi", but the
> compatible is compatible =3D "invensense,icm42600".
>=20
> so I think, it's necessary to add an id_table in the inv_icm42600 driver.

The quest Jean-Baptiste was raising was whether it would match on the
of_match_id table instead if it was present.  __spi_register_driver
does that so I think perhaps what you are actually referring to is
the comment in there.

	/*
	 * For Really Good Reasons we use spi: modaliases not of:
	 * modaliases for DT so module autoloading won't work if we
	 * don't have a spi_device_id as well as a compatible string.
	 */

The actually matching is done in spi_match_device.

Anyhow, the comment suggests strongly that we do still need the
spi_device_id table. I'm not 100% sure on the i2c equivalent, but
I'm fine with adding both.  Please fix up the formatting as requested
below and send a v2.

>=20
>=20
> Jonathan Cameron <jic23@kernel.org> =E4=BA=8E2024=E5=B9=B48=E6=9C=8826=E6=
=97=A5=E5=91=A8=E4=B8=80 18:27=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > On Mon, 26 Aug 2024 08:22:11 +0000
> > Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > =20
> > > Hello,
> > >
> > > I was believing that id tables weren't required anymore when using of=
 =20
> > tables. =20
> > >
> > > Jonathan,
> > > can you help on this subject?
> > >
> > > If we have to add id tables, then we need to add all supported chips =
=20
> > (missing here icm42686 and icm42688).
> >
> > There were some oddities around autoloading for some busses a while
> > back but I can't find the reference.
> >
> > +CC Mark + Wolfram for input.
> > Do we currently need i2c_device_id and spi_device_id tables for
> > autoprobing on DT only platforms?
> >
> > A few minor comments inline.
> >
> >
> >
> > =20
> > >
> > > Thanks,
> > > JB
> > >
> > > ________________________________________
> > > From: Jason Liu <jasonliu10041728@gmail.com>
> > > Sent: Sunday, August 25, 2024 08:39
> > > To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > > Cc: jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <
> > lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=
; =20
> > linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; Jason Liu =
< =20
> > jasonliu10041728@gmail.com>
> > > Subject: [PATCH] iio/inv_icm42600: add inv_icm42600 id_table
> > >
> > > This Message Is From an Untrusted Sender
> > > You have not previously corresponded with this sender.
> > >
> > > Add the id_table of inv_icm42600, so the device can probe correctly.
> > >
> > > Signed-off-by: Jason Liu <jasonliu10041728@gmail.com>
> > > ---
> > >  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 15 +++++++++++++++
> > >  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 15 +++++++++++++++
> > >  2 files changed, 30 insertions(+)
> > >
> > > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c =20
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c =20
> > > index ebb31b385881..8cc550b8cfc3 100644
> > > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> > > @@ -71,6 +71,20 @@ static int inv_icm42600_probe(struct i2c_client =20
> > *client) =20
> > >                                      inv_icm42600_i2c_bus_setup);
> > >  }
> > >
> > > +/*
> > > + * device id table is used to identify what device can be
> > > + * supported by this driver
> > > + */
> > > +static const struct i2c_device_id inv_icm42600_id[] =3D {
> > > +     {"icm42600", INV_CHIP_ICM42600}, =20
> > Spaces after { and before } =20
> > > +     {"icm42602", INV_CHIP_ICM42602},
> > > +     {"icm42605", INV_CHIP_ICM42605},
> > > +     {"icm42622", INV_CHIP_ICM42622},
> > > +     {"icm42631", INV_CHIP_ICM42631},
> > > +     {} =20
> > { }
> >
> > I'm trying to standardize this in IIO.
> > =20
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> > > +
> > >  static const struct of_device_id inv_icm42600_of_matches[] =3D {
> > >       {
> > >               .compatible =3D "invensense,icm42600",
> > > @@ -104,6 +118,7 @@ static struct i2c_driver inv_icm42600_driver =3D {
> > >               .of_match_table =3D inv_icm42600_of_matches,
> > >               .pm =3D pm_ptr(&inv_icm42600_pm_ops),
> > >       },
> > > +     .id_table =3D inv_icm42600_id,
> > >       .probe =3D inv_icm42600_probe,
> > >  };
> > >  module_i2c_driver(inv_icm42600_driver);
> > > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c =20
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c =20
> > > index eae5ff7a3cc1..5fe078ddc8a1 100644
> > > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> > > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> > > @@ -67,6 +67,20 @@ static int inv_icm42600_probe(struct spi_device *s=
pi)
> > >                                      inv_icm42600_spi_bus_setup);
> > >  }
> > >
> > > +/*
> > > + * device id table is used to identify what device can be
> > > + * supported by this driver
> > > + */
> > > +static const struct spi_device_id inv_icm42600_id[] =3D {
> > > +     {"icm42600", INV_CHIP_ICM42600},
> > > +     {"icm42602", INV_CHIP_ICM42602},
> > > +     {"icm42605", INV_CHIP_ICM42605},
> > > +     {"icm42622", INV_CHIP_ICM42622},
> > > +     {"icm42631", INV_CHIP_ICM42631},
> > > +     {}
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
> > > +
> > >  static const struct of_device_id inv_icm42600_of_matches[] =3D {
> > >       {
> > >               .compatible =3D "invensense,icm42600",
> > > @@ -100,6 +114,7 @@ static struct spi_driver inv_icm42600_driver =3D {
> > >               .of_match_table =3D inv_icm42600_of_matches,
> > >               .pm =3D pm_ptr(&inv_icm42600_pm_ops),
> > >       },
> > > +     .id_table =3D inv_icm42600_id,
> > >       .probe =3D inv_icm42600_probe,
> > >  };
> > >  module_spi_driver(inv_icm42600_driver); =20
> >
> > =20


