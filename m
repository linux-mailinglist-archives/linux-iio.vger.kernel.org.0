Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83E1DD543
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgEURuu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 13:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgEURuu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 13:50:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E65A20829;
        Thu, 21 May 2020 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083449;
        bh=Wp+e4k0Gm6wwc+49pvGCVYbp2wmKK1DlqvylU2yKfkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sik5qTK1zZuHrnrOBRRtNE203wxAgWuBOmXc6ynZLg8S3haOhdJJoDaLYbUx4IQK5
         5OOidP8kMGmib6qWZEx8FeJrp7Zc68F06anKVk8J4MMXjr16PGCYho3mbOBQ7u3ZXc
         UPhC/v0OYkUavZuofRq5e+sGVo4PLmTqUAQAhYNw=
Date:   Thu, 21 May 2020 18:50:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] iio: imu: inv_icm42600: add I2C driver for
 inv_icm42600 driver
Message-ID: <20200521185038.47ead7ee@archlinux>
In-Reply-To: <MN2PR12MB44228DAD29335621D4047260C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-3-jmaneyrol@invensense.com>
        <20200508144406.00006b8c@Huawei.com>
        <MN2PR12MB44228DAD29335621D4047260C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 May 2020 14:19:11 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> I am using generic device_get_match_data because I was thinking it was no=
w the way to go. But since only of is supported with the driver, I can swit=
ch to using of_device_get_match_data instead.
>=20
> Tell me what do you think is better.
Leave it as you have it.  We can look at if we can tidy up
what I was rambling about as a separate exercise.

J

>=20
> I could definitely use the new probe interface indeed, good idea.
>=20
> Thanks,
> JB
>=20
>=20
>=20
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>=20
> Sent: Friday, May 8, 2020 15:44
>=20
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
>=20
> Cc: jic23@kernel.org <jic23@kernel.org>; robh+dt@kernel.org <robh+dt@kern=
el.org>; robh@kernel.org <robh@kernel.org>; mchehab+huawei@kernel.org <mche=
hab+huawei@kernel.org>; davem@davemloft.net <davem@davemloft.net>; gregkh@l=
inuxfoundation.org <gregkh@linuxfoundation.org>;
>  linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.k=
ernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux=
-kernel@vger.kernel.org>
>=20
> Subject: Re: [PATCH 02/12] iio: imu: inv_icm42600: add I2C driver for inv=
_icm42600 driver
>=20
> =C2=A0
>=20
>=20
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
>=20
>=20
> On Thu, 7 May 2020 16:42:12 +0200
>=20
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
>=20
>=20
> > Add I2C driver for InvenSense ICM-426xxx devices. =20
>=20
> >  =20
>=20
> > Configure bus signal slew rates as indicated in the datasheet. =20
>=20
> >  =20
>=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
> Some incoherent rambling inline. + a few comments
>=20
>=20
>=20
> Jonathan
>=20
>=20
>=20
> > --- =20
>=20
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c=C2=A0=C2=A0 | 117 +++=
+++++++++++++++ =20
>=20
> >=C2=A0 1 file changed, 117 insertions(+) =20
>=20
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.=
c =20
>=20
> >  =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_i2c.c =20
>=20
> > new file mode 100644 =20
>=20
> > index 000000000000..b61f993beacf =20
>=20
> > --- /dev/null =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c =20
>=20
> > @@ -0,0 +1,117 @@ =20
>=20
> > +// SPDX-License-Identifier: GPL-2.0-or-later =20
>=20
> > +/* =20
>=20
> > + * Copyright (C) 2020 InvenSense, Inc. =20
>=20
> > + */ =20
>=20
> > + =20
>=20
> > +#include <linux/device.h> =20
>=20
> > +#include <linux/module.h> =20
>=20
> > +#include <linux/i2c.h> =20
>=20
> > +#include <linux/regmap.h> =20
>=20
> > +#include <linux/of_device.h> =20
>=20
>=20
>=20
> Why?=C2=A0 Looks like you need the table and the device property stuff ne=
ither
>=20
> of which are in that file.
>=20
>=20
>=20
> linux/mod_devicetable.h
>=20
> linux/property.h
>=20
>=20
>=20
>=20
>=20
> > + =20
>=20
> > +#include "inv_icm42600.h" =20
>=20
> > + =20
>=20
> > +static int inv_icm42600_i2c_bus_setup(struct inv_icm42600_state *st) =
=20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* setup interface registers */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_INTF_CONFIG6_MASK; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_INTF_CONFIG6_I3C_EN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_INTF_CONFIG6, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, val); =20
>=20
>=20
>=20
> I'd put the values inline where they are simple like these rather than
>=20
> using local variables.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_INTF_CONFIG4_I3C_BUS_ON=
LY; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_INTF_CONFIG4, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set slew rates for I2C and SPI */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_DRIVE_CONFIG_I2C_MASK |=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV=
_ICM42600_DRIVE_CONFIG_SPI_MASK; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_DRIVE_CONFIG_I2C(INV_ICM=
42600_SLEW_RATE_12_36NS) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_DRIVE_CONFIG_SPI(INV_ICM42600_SLEW_RATE_12_36NS); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_DRIVE_CONFIG, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* disable SPI bus */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_INTF_CONFIG0_UI_SIFS_CF=
G_MASK; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG=
_SPI_DIS; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return regmap_update_bits(st->map, INV_ICM426=
00_REG_INTF_CONFIG0, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, val); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int inv_icm42600_probe(struct i2c_client *client, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct i2c_device_id *id) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const void *match; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42600_chip chip; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *regmap; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!i2c_check_functionality(client->adapter,=
 I2C_FUNC_SMBUS_I2C_BLOCK)) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENOTSUPP; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 match =3D device_get_match_data(&client->dev)=
; =20
>=20
>=20
>=20
> Hmm. Annoyingly if one were to call the of specific option
>=20
> of i2c_of_match_device it would handle the old style i2c match just fine =
without
>=20
> needing special handling.=C2=A0 However, it would fail to handle PRP0001 =
ACPI.
>=20
>=20
>=20
> Rather feels like there should be something similar for
>=20
> device_get_match_data so we could use the probe_new version of i2c device
>=20
> probing.
>=20
>=20
>=20
> Oh well. I guess thats a separate question for another day ;)
>=20
>=20
>=20
> Mind you can we actually probe this driver via the sysfs route?
>=20
> If not why do we need to handle the non firmware case at all?
>=20
> =C2=A0
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (match) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 chip =3D (enum inv_icm42600_chip)match; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else if (id) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 chip =3D (enum inv_icm42600_chip)id->driver_data; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 regmap =3D devm_regmap_init_i2c(client, &inv_=
icm42600_regmap_config); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(regmap)) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return PTR_ERR(regmap); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return inv_icm42600_core_probe(regmap, chip, =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm4=
2600_i2c_bus_setup); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static const struct of_device_id inv_icm42600_of_matches[] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .compatible =3D "invensense,icm42600", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .data =3D (void *)INV_CHIP_ICM42600, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .compatible =3D "invensense,icm42602", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .data =3D (void *)INV_CHIP_ICM42602, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .compatible =3D "invensense,icm42605", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .data =3D (void *)INV_CHIP_ICM42605, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .compatible =3D "invensense,icm42622", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .data =3D (void *)INV_CHIP_ICM42622, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {} =20
>=20
> > +}; =20
>=20
> > +MODULE_DEVICE_TABLE(of, inv_icm42600_of_matches); =20
>=20
> > + =20
>=20
> > +static const struct i2c_device_id inv_icm42600_ids[] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {"icm42600", INV_CHIP_ICM42600}, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {"icm42602", INV_CHIP_ICM42602}, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {"icm42605", INV_CHIP_ICM42605}, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {"icm42622", INV_CHIP_ICM42622}, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {} =20
>=20
> > +}; =20
>=20
> > +MODULE_DEVICE_TABLE(i2c, inv_icm42600_ids); =20
>=20
> > + =20
>=20
> > +static struct i2c_driver inv_icm42600_driver =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D inv_icm42600_probe, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .id_table =3D inv_icm42600_ids, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .driver =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .of_match_table =3D inv_icm42600_of_matches, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .name =3D "inv-icm42600-i2c", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .pm =3D &inv_icm42600_pm_ops, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +}; =20
>=20
> > +module_i2c_driver(inv_icm42600_driver); =20
>=20
> > + =20
>=20
> > +MODULE_AUTHOR("InvenSense, Inc."); =20
>=20
> > +MODULE_DESCRIPTION("InvenSense ICM-426xx I2C driver"); =20
>=20
> > +MODULE_LICENSE("GPL"); =20
>=20
>=20
>=20
>=20
>=20

