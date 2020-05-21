Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7C1DD4DA
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 19:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgEURsK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 13:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbgEURrs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 13:47:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E023207F7;
        Thu, 21 May 2020 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083264;
        bh=A6ifyThG56DoM4Y4LQciY/Wuv+NsIXoZNHloPs0Cgb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZuL9yEtXD4Bz+1wxidcQU/1WZl1J+4ptSI6qkajCPykw6pkep9+v7fPXuIJsBWRYn
         vKjA4zT5wAbRQlpZG8jZ57T/FNCzaMUyYKRZwMmdX+EsRrSWbr76Wz++viBg1A4QoH
         DM29RlpwETBSTZbidGNvKTAXX2HPE95rvy8/nh5U=
Date:   Thu, 21 May 2020 18:47:38 +0100
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
Subject: Re: [PATCH 01/12] iio: imu: inv_icm42600: add core of new
 inv_icm42600 driver
Message-ID: <20200521184738.70444f1a@archlinux>
In-Reply-To: <MN2PR12MB44227D5AEA06F37269C03BCBC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-2-jmaneyrol@invensense.com>
        <20200508142820.000057f8@Huawei.com>
        <MN2PR12MB44227D5AEA06F37269C03BCBC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 May 2020 14:14:26 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> thanks for the feedbacks, I'm sorry but I will not be able to have a corr=
ect email formatting to respond you inline.
>=20
> No problem with all the comments. For iio_device_get_drvdata, it would ma=
ke more sense to use a const struct iio_dev * as argument. I am obliged to =
do the pointer conversion since iio_get_mount_matrix requires the use of a =
const struct iio_dev *.

Absolutely.  My argument was that we should change
iio_device_get_drvdata to take a const struct iio_dev * as well.
Seems logical. dev_get_drvdata takes a const device * and
that's all that is being called inside there.

That change can happen in parallel to this set so no problem
if you would rather leave it alone for now.

Jonathan



>=20
> For resume/suspend, I will add commentaries to explain what it is really =
doing and for which purpose. Sensor states save and restore will remain in =
this patch, since it makes more sense to have it as a core functionnality, =
as much as gyro/accel turn on/off.
>=20
> Thanks.
> JB
>=20
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>=20
> Sent: Friday, May 8, 2020 15:28
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
> Subject: Re: [PATCH 01/12] iio: imu: inv_icm42600: add core of new inv_ic=
m42600 driver
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
> On Thu, 7 May 2020 16:42:11 +0200
>=20
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
>=20
>=20
> > Core component of a new driver for InvenSense ICM-426xx devices. =20
>=20
> > It includes registers definition, main probe/setup, and device =20
>=20
> > utility functions. =20
>=20
> >  =20
>=20
> > ICM-426xx devices are latest generation of 6-axis IMU, =20
>=20
> > gyroscope+accelerometer and temperature sensor. This device =20
>=20
> > includes a 2K FIFO, supports I2C/I3C/SPI, and provides =20
>=20
> > intelligent motion features like pedometer, tilt detection, =20
>=20
> > and tap detection. =20
>=20
> >  =20
>=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
>=20
>=20
> Hi Jean-Baptiste,
>=20
>=20
>=20
> A few minor things inline.
>=20
>=20
>=20
> Thanks,
>=20
>=20
>=20
> Jonathan
>=20
>=20
>=20
> > --- =20
>=20
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=C2=A0=C2=A0 | 372 +++=
++++++++ =20
>=20
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=C2=A0 | 618 ++++++++=
++++++++++ =20
>=20
> >=C2=A0 2 files changed, 990 insertions(+) =20
>=20
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h =20
>=20
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core=
.c =20
>=20
> >  =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/=
imu/inv_icm42600/inv_icm42600.h =20
>=20
> > new file mode 100644 =20
>=20
> > index 000000000000..8da4c8249aed =20
>=20
> > --- /dev/null =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h =20
>=20
> > @@ -0,0 +1,372 @@ =20
>=20
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */ =20
>=20
> > +/* =20
>=20
> > + * Copyright (C) 2020 Invensense, Inc. =20
>=20
> > + */ =20
>=20
> > + =20
>=20
> > +#ifndef INV_ICM42600_H_ =20
>=20
> > +#define INV_ICM42600_H_ =20
>=20
> > + =20
>=20
> > +#include <linux/bits.h> =20
>=20
> > +#include <linux/bitfield.h> =20
>=20
> > +#include <linux/regmap.h> =20
>=20
> > +#include <linux/mutex.h> =20
>=20
> > +#include <linux/regulator/consumer.h> =20
>=20
> > +#include <linux/pm.h> =20
>=20
> > +#include <linux/iio/iio.h> =20
>=20
> > + =20
>=20
> > +enum inv_icm42600_chip { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42600, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42602, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42605, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42622, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_NB, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* serial bus slew rates */ =20
>=20
> > +enum inv_icm42600_slew_rate { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SLEW_RATE_20_60NS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SLEW_RATE_12_36NS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SLEW_RATE_6_18NS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SLEW_RATE_4_12NS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SLEW_RATE_2_6NS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SLEW_RATE_INF_2NS, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +enum inv_icm42600_sensor_mode { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SENSOR_MODE_OFF, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SENSOR_MODE_STANDBY, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SENSOR_MODE_LOW_POWER, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SENSOR_MODE_LOW_NOISE, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SENSOR_MODE_NB, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* gyroscope fullscale values */ =20
>=20
> > +enum inv_icm42600_gyro_fs { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_2000DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_1000DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_500DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_250DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_125DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_62_5DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_31_25DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_15_625DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_FS_NB, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* accelerometer fullscale values */ =20
>=20
> > +enum inv_icm42600_accel_fs { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_FS_16G, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_FS_8G, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_FS_4G, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_FS_2G, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_FS_NB, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* ODR suffixed by LN or LP are Low-Noise or Low-Power mode only */ =20
>=20
> > +enum inv_icm42600_odr { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_8KHZ_LN =3D 3, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_4KHZ_LN, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_2KHZ_LN, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_1KHZ_LN, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_200HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_100HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_50HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_25HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_12_5HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_6_25HZ_LP, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_3_125HZ_LP, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_1_5625HZ_LP, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_500HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_NB, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +enum inv_icm42600_filter { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Low-Noise mode sensor data filter (3rd ord=
er filter by default) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_FILTER_BW_ODR_DIV_2, =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Low-Power mode sensor data filter (averagi=
ng) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_FILTER_AVG_1X =3D 1, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_FILTER_AVG_16X =3D 6, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +struct inv_icm42600_sensor_conf { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int mode; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int fs; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int filter; =20
>=20
> > +}; =20
>=20
> > +#define INV_ICM42600_SENSOR_CONF_INIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {-1, -1, -1, -1} =
=20
>=20
> > + =20
>=20
> > +struct inv_icm42600_conf { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bool temp_en; =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +struct inv_icm42600_suspended { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42600_sensor_mode gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42600_sensor_mode accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bool temp; =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* =20
>=20
> /**
>=20
>=20
>=20
> It's valid kernel doc so lets mark it as such.
>=20
>=20
>=20
> > + *=C2=A0 struct inv_icm42600_state - driver state variables =20
>=20
> > + *=C2=A0 @lock:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 chip access lock. =20
>=20
>=20
>=20
> Nice to be a bit more specific on that.=C2=A0 What about the chip needs
>=20
> a lock at this level as opposed to bus locks etc?
>=20
>=20
>=20
> > + *=C2=A0 @chip:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 chip identifier. =20
>=20
> > + *=C2=A0 @name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 chip name. =20
>=20
> > + *=C2=A0 @map:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 regmap pointer. =20
>=20
> > + *=C2=A0 @vdd_supply:=C2=A0=C2=A0=C2=A0=C2=A0 VDD voltage regulator fo=
r the chip. =20
>=20
> > + *=C2=A0 @vddio_supply:=C2=A0=C2=A0 I/O voltage regulator for the chip=
. =20
>=20
> > + *=C2=A0 @orientation:=C2=A0=C2=A0=C2=A0 sensor chip orientation relat=
ive to main hardware. =20
>=20
> > + *=C2=A0 @conf:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 chip sensors configurations. =20
>=20
> > + *=C2=A0 @suspended:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suspended sensors configuration. =20
>=20
> > + */ =20
>=20
> > +struct inv_icm42600_state { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42600_chip chip; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const char *name; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *map; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct regulator *vdd_supply; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct regulator *vddio_supply; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_mount_matrix orientation; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_conf conf; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_suspended suspended; =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* Virtual register addresses: @bank on MSB (4 upper bits), @address o=
n LSB */ =20
>=20
> > + =20
>=20
> > +/* Bank selection register, available in all banks */ =20
>=20
> > +#define INV_ICM42600_REG_BANK_SEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x76 =20
>=20
> > +#define INV_ICM42600_BANK_SEL_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GE=
NMASK(2, 0) =20
>=20
> > + =20
>=20
> > +/* User bank 0 (MSB 0x00) */ =20
>=20
> > +#define INV_ICM42600_REG_DEVICE_CONFIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0011 =20
>=20
> > +#define INV_ICM42600_DEVICE_CONFIG_SOFT_RESET=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0) =
=20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_DRIVE_CONFIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0013 =20
>=20
> > +#define INV_ICM42600_DRIVE_CONFIG_I2C_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(5, 3) =20
>=20
> > +#define INV_ICM42600_DRIVE_CONFIG_I2C(_rate)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(INV_ICM42600_DRIVE_CONFIG_I2C_MASK, (_rate)) =20
>=20
> > +#define INV_ICM42600_DRIVE_CONFIG_SPI_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(2, 0) =20
>=20
> > +#define INV_ICM42600_DRIVE_CONFIG_SPI(_rate)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(INV_ICM42600_DRIVE_CONFIG_SPI_MASK, (_rate)) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_INT_CONFIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x001=
4 =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT2_LATCHED=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT2_PUSH_PULL=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4) =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT2_ACTIVE_HIGH=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT2_ACTIVE_LOW=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00 =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT1_LATCHED=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2) =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT1_ACTIVE_HIGH=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(0) =20
>=20
> > +#define INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00 =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_FIFO_CONFIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0016 =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(7, 6) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG_BYPASS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 0) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG_STREAM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 1) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG_STOP_ON_FULL=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 2) =20
>=20
> > + =20
>=20
> > +/* all sensor data are 16 bits (2 registers wide) in big-endian */ =20
>=20
> > +#define INV_ICM42600_REG_TEMP_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
001D =20
>=20
> > +#define INV_ICM42600_REG_ACCEL_DATA_X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x001F =20
>=20
> > +#define INV_ICM42600_REG_ACCEL_DATA_Y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0021 =20
>=20
> > +#define INV_ICM42600_REG_ACCEL_DATA_Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0023 =20
>=20
> > +#define INV_ICM42600_REG_GYRO_DATA_X=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0025 =20
>=20
> > +#define INV_ICM42600_REG_GYRO_DATA_Y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0027 =20
>=20
> > +#define INV_ICM42600_REG_GYRO_DATA_Z=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0029 =20
>=20
> > +#define INV_ICM42600_DATA_INVALID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 -32768 =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_INT_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x002=
D =20
>=20
> > +#define INV_ICM42600_INT_STATUS_UI_FSYNC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(6) =20
>=20
> > +#define INV_ICM42600_INT_STATUS_PLL_RDY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_INT_STATUS_RESET_DONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4) =20
>=20
> > +#define INV_ICM42600_INT_STATUS_DATA_RDY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_INT_STATUS_FIFO_THS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2) =20
>=20
> > +#define INV_ICM42600_INT_STATUS_FIFO_FULL=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_INT_STATUS_AGC_RDY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +/* =20
>=20
> > + * FIFO access registers =20
>=20
> > + * FIFO count is 16 bits (2 registers) big-endian =20
>=20
> > + * FIFO data is a continuous read register to read FIFO content =20
>=20
> > + */ =20
>=20
> > +#define INV_ICM42600_REG_FIFO_COUNT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x002=
E =20
>=20
> > +#define INV_ICM42600_REG_FIFO_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
0030 =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_SIGNAL_PATH_RESET=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x004B =20
>=20
> > +#define INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN=C2=A0=C2=A0 BIT(6) =
=20
>=20
> > +#define INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET BIT(5) =20
>=20
> > +#define INV_ICM42600_SIGNAL_PATH_RESET_RESET=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_SIGNAL_PATH_RESET_TMST_STROBE=C2=A0=C2=A0 BIT(2) =
=20
>=20
> > +#define INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH=C2=A0=C2=A0=C2=A0 BI=
T(1) =20
>=20
> > + =20
>=20
> > +/* default configuration: all data big-endian and fifo count in bytes =
*/ =20
>=20
> > +#define INV_ICM42600_REG_INTF_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x004C =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG0_FIFO_HOLD_LAST_DATA=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(7) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_REC=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(6) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_ENDIAN=C2=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG0_SENSOR_DATA_ENDIAN BIT(4) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK=C2=A0=C2=A0 GENMASK=
(1, 0) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK, 2) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(INV_ICM42600_INTF_CONFIG0_UI_SIFS_CFG_MASK, 3) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_INTF_CONFIG1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x004D =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG1_ACCEL_LP_CLK_RC=C2=A0=C2=A0=C2=A0 BI=
T(3) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_PWR_MGMT0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x=
004E =20
>=20
> > +#define INV_ICM42600_PWR_MGMT0_TEMP_DIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_PWR_MGMT0_IDLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4=
) =20
>=20
> > +#define INV_ICM42600_PWR_MGMT0_GYRO(_mode)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(3, 2), (_mode)) =20
>=20
> > +#define INV_ICM42600_PWR_MGMT0_ACCEL(_mode)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(1, 0), (_mode)) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_GYRO_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x004F =20
>=20
> > +#define INV_ICM42600_GYRO_CONFIG0_FS(_fs)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(7, 5), (_fs)) =20
>=20
> > +#define INV_ICM42600_GYRO_CONFIG0_ODR(_odr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(3, 0), (_odr)) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_ACCEL_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0050 =20
>=20
> > +#define INV_ICM42600_ACCEL_CONFIG0_FS(_fs)=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(7, 5), (_fs)) =20
>=20
> > +#define INV_ICM42600_ACCEL_CONFIG0_ODR(_odr)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(3, 0), (_odr)) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_GYRO_ACCEL_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0052 =20
>=20
> > +#define INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(_f)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(7, 4), (_f)) =20
>=20
> > +#define INV_ICM42600_GYRO_ACCEL_CONFIG0_GYRO_FILT(_f)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 FIELD_PREP(GENMASK(3, 0), (_f)) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_TMST_CONFIG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0054 =20
>=20
> > +#define INV_ICM42600_TMST_CONFIG_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(4, 0) =20
>=20
> > +#define INV_ICM42600_TMST_CONFIG_TMST_TO_REGS_EN=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(4) =20
>=20
> > +#define INV_ICM42600_TMST_CONFIG_TMST_RES_16US=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_TMST_CONFIG_TMST_DELTA_EN=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2) =20
>=20
> > +#define INV_ICM42600_TMST_CONFIG_TMST_FSYNC_EN=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_TMST_CONFIG_TMST_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_FIFO_CONFIG1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x005F =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD=C2=A0 BIT(6) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG1_WM_GT_TH=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC_EN=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG1_TEMP_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG1_GYRO_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_FIFO_CONFIG1_ACCEL_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +/* FIFO watermark is 16 bits (2 registers wide) in little-endian */ =20
>=20
> > +#define INV_ICM42600_REG_FIFO_WATERMARK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x0060 =20
>=20
> > +#define INV_ICM42600_FIFO_WATERMARK_VAL(_wm)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_to_le16((_wm) & GENMASK(11, 0)) =20
>=20
> > +/* FIFO is 2048 bytes, let 12 samples for reading latency */ =20
>=20
> > +#define INV_ICM42600_FIFO_WATERMARK_MAX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (2048 - 12 * 16) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_INT_CONFIG1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0064 =20
>=20
> > +#define INV_ICM42600_INT_CONFIG1_TPULSE_DURATION=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(6) =20
>=20
> > +#define INV_ICM42600_INT_CONFIG1_TDEASSERT_DISABLE=C2=A0=C2=A0 BIT(5) =
=20
>=20
> > +#define INV_ICM42600_INT_CONFIG1_ASYNC_RESET=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_INT_SOURCE0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0065 =20
>=20
> > +#define INV_ICM42600_INT_SOURCE0_UI_FSYNC_INT1_EN=C2=A0=C2=A0=C2=A0 BI=
T(6) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE0_PLL_RDY_INT1_EN=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE0_RESET_DONE_INT1_EN=C2=A0 BIT(4) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE0_UI_DRDY_INT1_EN=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN=C2=A0=C2=A0=C2=A0 BI=
T(2) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE0_FIFO_FULL_INT1_EN=C2=A0=C2=A0 BIT(1) =
=20
>=20
> > +#define INV_ICM42600_INT_SOURCE0_UI_AGC_RDY_INT1_EN=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_WHOAMI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0075 =20
>=20
> > +#define INV_ICM42600_WHOAMI_ICM42600=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x40 =20
>=20
> > +#define INV_ICM42600_WHOAMI_ICM42602=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x41 =20
>=20
> > +#define INV_ICM42600_WHOAMI_ICM42605=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x42 =20
>=20
> > +#define INV_ICM42600_WHOAMI_ICM42622=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x46 =20
>=20
> > + =20
>=20
> > +/* User bank 1 (MSB 0x10) */ =20
>=20
> > +#define INV_ICM42600_REG_SENSOR_CONFIG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x1003 =20
>=20
> > +#define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_SENSOR_CONFIG0_YG_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4) =20
>=20
> > +#define INV_ICM42600_SENSOR_CONFIG0_XG_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_SENSOR_CONFIG0_ZA_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2) =20
>=20
> > +#define INV_ICM42600_SENSOR_CONFIG0_YA_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_SENSOR_CONFIG0_XA_DISABLE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +/* Timestamp value is 20 bits (3 registers) in little-endian */ =20
>=20
> > +#define INV_ICM42600_REG_TMSTVAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0x1062 =20
>=20
> > +#define INV_ICM42600_TMSTVAL_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 GENMASK(19, 0) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_INTF_CONFIG4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x107A =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG4_I3C_BUS_ONLY=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(6) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG4_SPI_AP_4WIRE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_INTF_CONFIG6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x107C =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG6_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(4, 0) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG6_I3C_EN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG6_I3C_IBI_BYTE_EN=C2=A0=C2=A0=C2=A0 BI=
T(3) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG6_I3C_IBI_EN=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG6_I3C_DDR_EN=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_INTF_CONFIG6_I3C_SDR_EN=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +/* User bank 4 (MSB 0x40) */ =20
>=20
> > +#define INV_ICM42600_REG_INT_SOURCE8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x404F =20
>=20
> > +#define INV_ICM42600_INT_SOURCE8_FSYNC_IBI_EN=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5) =
=20
>=20
> > +#define INV_ICM42600_INT_SOURCE8_PLL_RDY_IBI_EN=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(4) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE8_UI_DRDY_IBI_EN=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(3) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE8_FIFO_THS_IBI_EN=C2=A0=C2=A0=C2=A0=C2=
=A0 BIT(2) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE8_FIFO_FULL_IBI_EN=C2=A0=C2=A0=C2=A0 BI=
T(1) =20
>=20
> > +#define INV_ICM42600_INT_SOURCE8_AGC_RDY_IBI_EN=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4077 =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4078 =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x4079 =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x407A =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x407B =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER5=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x407C =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER6=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x407D =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER7=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x407E =20
>=20
> > +#define INV_ICM42600_REG_OFFSET_USER8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x407F =20
>=20
> > + =20
>=20
> > +/* Sleep times required by the driver */ =20
>=20
> > +#define INV_ICM42600_POWER_UP_TIME_MS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100 =20
>=20
> > +#define INV_ICM42600_RESET_TIME_MS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1 =20
>=20
> > +#define INV_ICM42600_ACCEL_STARTUP_TIME_MS=C2=A0=C2=A0 20 =20
>=20
> > +#define INV_ICM42600_GYRO_STARTUP_TIME_MS=C2=A0=C2=A0=C2=A0 60 =20
>=20
> > +#define INV_ICM42600_GYRO_STOP_TIME_MS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 150 =20
>=20
> > +#define INV_ICM42600_TEMP_STARTUP_TIME_MS=C2=A0=C2=A0=C2=A0 14 =20
>=20
> > +#define INV_ICM42600_SUSPEND_DELAY_MS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2000 =20
>=20
> > + =20
>=20
> > +typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *); =20
>=20
> > + =20
>=20
> > +extern const struct regmap_config inv_icm42600_regmap_config; =20
>=20
> > +extern const struct dev_pm_ops inv_icm42600_pm_ops; =20
>=20
> > + =20
>=20
> > +const struct iio_mount_matrix * =20
>=20
> > +inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct iio_chan_spec *chan); =20
>=20
> > + =20
>=20
> > +uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf *conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *sleep); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf *conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsigned int *sleep); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool ena=
ble, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsigned int *sleep); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int r=
eg, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int writeval, unsigned int *readval); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_core_probe(struct regmap *regmap, int chip, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 inv_icm42600_bus_setup bus_setup); =20
>=20
> > + =20
>=20
> > +#endif =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c =20
>=20
> > new file mode 100644 =20
>=20
> > index 000000000000..35bdf4f9d31e =20
>=20
> > --- /dev/null =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c =20
>=20
> > @@ -0,0 +1,618 @@ =20
>=20
> > +// SPDX-License-Identifier: GPL-2.0-or-later =20
>=20
> > +/* =20
>=20
> > + * Copyright (C) 2020 Invensense, Inc. =20
>=20
> > + */ =20
>=20
> > + =20
>=20
> > +#include <linux/device.h> =20
>=20
> > +#include <linux/module.h> =20
>=20
> > +#include <linux/slab.h> =20
>=20
> > +#include <linux/delay.h> =20
>=20
> > +#include <linux/interrupt.h> =20
>=20
> > +#include <linux/regulator/consumer.h> =20
>=20
> > +#include <linux/pm_runtime.h> =20
>=20
> > +#include <linux/regmap.h> =20
>=20
> > +#include <linux/iio/iio.h> =20
>=20
> > + =20
>=20
> > +#include "inv_icm42600.h" =20
>=20
> > + =20
>=20
> > +static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] =3D =
{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .name =3D "user banks", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .range_min =3D 0x0000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .range_max =3D 0x4FFF, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .selector_reg =3D INV_ICM42600_REG_BANK_SEL, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .selector_mask =3D INV_ICM42600_BANK_SEL_MASK, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .selector_shift =3D 0, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .window_start =3D 0, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .window_len =3D 0x1000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +const struct regmap_config inv_icm42600_regmap_config =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .reg_bits =3D 8, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .val_bits =3D 8, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .max_register =3D 0x4FFF, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .ranges =3D inv_icm42600_regmap_ranges, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .num_ranges =3D ARRAY_SIZE(inv_icm42600_regma=
p_ranges), =20
>=20
> > +}; =20
>=20
> > +EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config); =20
>=20
> > + =20
>=20
> > +struct inv_icm42600_hw { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t whoami; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const char *name; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_conf *conf; =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* chip initial default configuration */ =20
>=20
> > +static const struct inv_icm42600_conf inv_icm42600_default_conf =3D { =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .gyro =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .mode =3D INV_ICM42600_SENSOR_MODE_OFF, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .fs =3D INV_ICM42600_GYRO_FS_2000DPS, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .odr =3D INV_ICM42600_ODR_50HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .filter =3D INV_ICM42600_FILTER_BW_ODR_DIV_2, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .accel =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .mode =3D INV_ICM42600_SENSOR_MODE_OFF, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .fs =3D INV_ICM42600_ACCEL_FS_16G, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .odr =3D INV_ICM42600_ODR_50HZ, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .filter =3D INV_ICM42600_FILTER_BW_ODR_DIV_2, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .temp_en =3D false, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +static const struct inv_icm42600_hw inv_icm42600_hw[] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [INV_CHIP_ICM42600] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM42600, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .name =3D "icm42600", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .conf =3D &inv_icm42600_default_conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [INV_CHIP_ICM42602] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM42602, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .name =3D "icm42602", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .conf =3D &inv_icm42600_default_conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [INV_CHIP_ICM42605] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM42605, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .name =3D "icm42605", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .conf =3D &inv_icm42600_default_conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [INV_CHIP_ICM42622] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .whoami =3D INV_ICM42600_WHOAMI_ICM42622, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .name =3D "icm42622", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .conf =3D &inv_icm42600_default_conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +const struct iio_mount_matrix * =20
>=20
> > +inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct iio_chan_spec *chan) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_state *st =3D =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_get_drvdata(=
(struct iio_dev *)indio_dev); =20
>=20
>=20
>=20
> Interesting... iio_device_get_drvdata is never going to modify
>=20
> the struct iio_dev.=C2=A0 Should we just change that to take a
>=20
> const struct iio_dev * ?
>=20
>=20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return &st->orientation; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 static uint32_t odr_periods[INV_ICM42600_ODR_=
NB] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* reserved values */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0, 0, 0, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 8kHz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 125000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 4kHz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 250000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 2kHz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 500000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 1kHz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 1000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 200Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 5000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 100Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 10000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 50Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 20000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 25Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 40000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 12.5Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 80000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 6.25Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 160000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 3.125Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 320000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 1.5625Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 640000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 500Hz */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 2000000, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return odr_periods[odr]; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int inv_icm42600_set_pwr_mgmt0(struct inv_icm42600_state *st, =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42=
600_sensor_mode gyro, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42=
600_sensor_mode accel, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool temp, uns=
igned int *sleep) =20
>=20
>=20
>=20
> msleep or similar that indicates the units of the sleep time.
>=20
>=20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42600_sensor_mode oldgyro =3D st-=
>conf.gyro.mode; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 enum inv_icm42600_sensor_mode oldaccel =3D st=
->conf.accel.mode; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bool oldtemp =3D st->conf.temp_en; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleepval; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* if nothing changed, exit */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (gyro =3D=3D oldgyro && accel =3D=3D oldac=
cel && temp =3D=3D oldtemp) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_PWR_MGMT0_GYRO(gyro) | =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_PWR_MGMT0_ACCEL(accel); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!temp) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_PWR_MGMT0_TEMP_DIS; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(regmap_get_device(st->map), "pwr_mgmt=
0: %#02x\n", val); =20
>=20
>=20
>=20
> I wonder if you have a little too much in the way of debug prints.
>=20
> These are internal to the code and so could only be wrong due to a local
>=20
> bug.=C2=A0 Once you've finished writing the driver I'd hope we won't need=
 these!
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_PWR_MGMT0, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->conf.gyro.mode =3D gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->conf.accel.mode =3D accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->conf.temp_en =3D temp; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* compute required wait time for sensors to =
stabilize */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 sleepval =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* temperature stabilization time */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (temp && !oldtemp) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (sleepval < INV_ICM42600_TEMP_STARTUP_TIME_MS) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleepval =3D INV_ICM426=
00_TEMP_STARTUP_TIME_MS; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* accel startup time */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (accel !=3D oldaccel && oldaccel =3D=3D IN=
V_ICM42600_SENSOR_MODE_OFF) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* block any register write for at least 200 =C2=B5s */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 usleep_range(200, 300); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (sleepval < INV_ICM42600_ACCEL_STARTUP_TIME_MS) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleepval =3D INV_ICM426=
00_ACCEL_STARTUP_TIME_MS; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (gyro !=3D oldgyro) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* gyro startup time */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (oldgyro =3D=3D INV_ICM42600_SENSOR_MODE_OFF) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* block any register w=
rite for at least 200 =C2=B5s */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usleep_range(200, 300);=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sleepval < INV_ICM4=
2600_GYRO_STARTUP_TIME_MS) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sleepval =3D INV_ICM42600_GYRO_STARTUP_TIME_MS; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* gyro stop time */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else if (gyro =3D=3D INV_ICM42600_SENSOR_MODE_OFF) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sleepval < INV_ICM4=
2600_GYRO_STOP_TIME_MS) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sleepval =3D=C2=A0 INV_ICM42600_GYRO_STOP_TIME_MS;=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* deferred sleep value if sleep pointer is p=
rovided or direct sleep */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *sleep =3D sleepval; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else if (sleepval) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleepval); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf *conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *sleep) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf *oldconf =3D =
&st->conf.accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* Sanitize missing values with current value=
s */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->mode < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->mode =3D oldconf->mode; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->fs < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->fs =3D oldconf->fs; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->odr < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->odr =3D oldconf->odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->filter < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->filter =3D oldconf->filter; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set ACCEL_CONFIG0 register (accel fullscal=
e & odr) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->fs !=3D oldconf->fs || conf->odr !=
=3D oldconf->odr) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val =3D INV_ICM42600_ACCEL_CONFIG0_FS(conf->fs) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_CONFIG0_ODR(conf=
->odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_dbg(regmap_get_device(st->map), "accel_config0: %#02x\n", val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_ACCEL_CONFIG0, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 oldconf->fs =3D conf->fs; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 oldconf->odr =3D conf->odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set GYRO_ACCEL_CONFIG0 register (accel fil=
ter) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->filter !=3D oldconf->filter) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(conf->filter) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_ACCEL_CONFIG0_GYR=
O_FILT(st->conf.gyro.filter); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_dbg(regmap_get_device(st->map), "gyro_accel_config0: %#02x\n", val)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 oldconf->filter =3D conf->filter; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set PWR_MGMT0 register (accel sensor mode)=
 */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return inv_icm42600_set_pwr_mgmt0(st, st->con=
f.gyro.mode, conf->mode, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 st->conf.temp_en, sleep); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_set_gyro_conf(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf *conf, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsigned int *sleep) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf *oldconf =3D =
&st->conf.gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* sanitize missing values with current value=
s */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->mode < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->mode =3D oldconf->mode; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->fs < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->fs =3D oldconf->fs; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->odr < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->odr =3D oldconf->odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->filter < 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf->filter =3D oldconf->filter; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set GYRO_CONFIG0 register (gyro fullscale =
& odr) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->fs !=3D oldconf->fs || conf->odr !=
=3D oldconf->odr) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val =3D INV_ICM42600_GYRO_CONFIG0_FS(conf->fs) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_CONFIG0_ODR(conf-=
>odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_dbg(regmap_get_device(st->map), "gyro_config0: %#02x\n", val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_CONFIG0, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 oldconf->fs =3D conf->fs; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 oldconf->odr =3D conf->odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set GYRO_ACCEL_CONFIG0 register (gyro filt=
er) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (conf->filter !=3D oldconf->filter) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL_FILT(st->conf.accel.filte=
r) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_ACCEL_CONFIG0_GYR=
O_FILT(conf->filter); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_dbg(regmap_get_device(st->map), "gyro_accel_config0: %#02x\n", val)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_GYRO_ACCEL_CONFIG0, val)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 oldconf->filter =3D conf->filter; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set PWR_MGMT0 register (gyro sensor mode) =
*/ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return inv_icm42600_set_pwr_mgmt0(st, conf->m=
ode, st->conf.accel.mode, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 st->conf.temp_en, sleep); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool ena=
ble, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 unsigned int *sleep) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return inv_icm42600_set_pwr_mgmt0(st, st->con=
f.gyro.mode, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 st->conf.accel.mode, enable, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 sleep); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int r=
eg, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int writeval, unsigned int *readval) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (readval) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_read(st->map, reg, readval); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, reg, writeval); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int inv_icm42600_set_conf(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_conf *conf) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set PWR_MGMT0 register (gyro & accel senso=
r mode, temp enabled) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_PWR_MGMT0_GYRO(conf->gyr=
o.mode) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_PWR_MGMT0_ACCEL(conf->accel.mode); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!conf->temp_en) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_PWR_MGMT0_TEMP_DIS; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_PWR_MGMT0, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set GYRO_CONFIG0 register (gyro fullscale =
& odr) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_GYRO_CONFIG0_FS(conf->gy=
ro.fs) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_GYRO_CONFIG0_ODR(conf->gyro.odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_GYRO_CONFIG0, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set ACCEL_CONFIG0 register (accel fullscal=
e & odr) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_ACCEL_CONFIG0_FS(conf->a=
ccel.fs) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_ACCEL_CONFIG0_ODR(conf->accel.odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_ACCEL_CONFIG0, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set GYRO_ACCEL_CONFIG0 register (gyro & ac=
cel filters) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_GYRO_ACCEL_CONFIG0_ACCEL=
_FILT(conf->accel.filter) | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_GYRO_ACCEL_CONFIG0_GYRO_FILT(conf->gyro.filter); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_GYRO_ACCEL_CONFIG0, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* update internal conf */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->conf =3D *conf; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +/** =20
>=20
> > + *=C2=A0 inv_icm42600_setup() - check and setup chip. =20
>=20
>=20
>=20
> If doing kernel-doc (which is good) you should do it all.
>=20
> So document the parameters as well.
>=20
> It's worth running the kernel-doc script over any file where
>=20
> you put some and fixing up any warnings / errors.
>=20
>=20
>=20
> > + */ =20
>=20
> > +static int inv_icm42600_setup(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 inv_icm42600_bus_setup bus_setup) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_hw *hw =3D &inv_icm=
42600_hw[st->chip]; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct device *dev =3D regmap_get_devic=
e(st->map); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* check chip self-identification value */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(st->map, INV_ICM42600_REG=
_WHOAMI, &val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (val !=3D hw->whoami) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, hw->whoami, hw->na=
me); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENODEV; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(dev, "found %s (%#02x)\n", hw->name,=
 hw->whoami); =20
>=20
>=20
>=20
> Hmm. I'm never that keen on this sort of log noise.=C2=A0 Why do you need=
 it
>=20
> except for initial debug?
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->name =3D hw->name; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* reset to make sure previous state are not =
there */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_DEVICE_CONFIG, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_I=
CM42600_DEVICE_CONFIG_SOFT_RESET); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 msleep(INV_ICM42600_RESET_TIME_MS); =20
>=20
>=20
>=20
> blank line here to separate two logical blocks of code.
>=20
> Slightly helps readability.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(st->map, INV_ICM42600_REG=
_INT_STATUS, &val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!(val & INV_ICM42600_INT_STATUS_RESET_DON=
E)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "reset error, reset done bit not set\n"); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENODEV; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set chip bus configuration */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bus_setup(st); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* sensor data in big-endian (default) */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_INTF_CONFIG0_SENSOR_DAT=
A_ENDIAN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_INTF_CONFIG0_SENSOR_DATA=
_ENDIAN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_INTF_CONFIG0, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, val); =20
>=20
>=20
>=20
> Long line, but I'd rather you just didn't bother will local variables
>=20
> in cases like this where you just set them to a constant.
>=20
> Take the 80 chars thing as guidance not a rule :)
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return inv_icm42600_set_conf(st, hw->conf); =
=20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_sta=
te *st) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regulator_enable(st->vddio_supply); =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* wait a little for supply ramp */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 usleep_range(3000, 4000); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static void inv_icm42600_disable_regulators(void *_data) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D _data; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct device *dev =3D regmap_get_devic=
e(st->map); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regulator_disable(st->vddio_supply); =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "failed to disable vddio error %d\n", ret); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regulator_disable(st->vdd_supply); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "failed to disable vdd error %d\n", ret); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static void inv_icm42600_disable_pm(void *_data) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D _data; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_sync(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(dev); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_core_probe(struct regmap *regmap, int chip, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 inv_icm42600_bus_setup bus_setup) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(regm=
ap); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BUILD_BUG_ON(ARRAY_SIZE(inv_icm42600_hw) !=3D=
 INV_CHIP_NB); =20
>=20
>=20
>=20
> Why not just give the array an explicit size when you define it above?
>=20
> I guess it would in theory be possible to not instantiate all of the array
>=20
> but relying on different size of a variable length array seems less than
>=20
> ideal.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chip < 0 || chip >=3D INV_CHIP_NB) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "invalid chip =3D %d\n", chip); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENODEV; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st =3D devm_kzalloc(dev, sizeof(*st), GFP_KER=
NEL); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!st) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENOMEM; =20
>=20
> nitpick: blank line here.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 dev_set_drvdata(dev, st); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->chip =3D chip; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->map =3D regmap; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D iio_read_mount_matrix(dev, "mount-mat=
rix", &st->orientation); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(dev, "failed to retrieve mounting matrix %d\n", ret); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->vdd_supply =3D devm_regulator_get(dev, "v=
dd"); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->vdd_supply)) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return PTR_ERR(st->vdd_supply); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->vddio_supply =3D devm_regulator_get(dev, =
"vddio"); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(st->vddio_supply)) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return PTR_ERR(st->vddio_supply); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regulator_enable(st->vdd_supply); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 msleep(INV_ICM42600_POWER_UP_TIME_MS); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_enable_regulator_vddio(s=
t); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 regulator_disable(st->vdd_supply); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D devm_add_action_or_reset(dev, inv_icm=
42600_disable_regulators, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st); =20
>=20
>=20
>=20
> I'd prefer to see two devm_add_action_or_reset calls. One for each regula=
tor.
>=20
> That means you don't have to do the extra disable logic above which is
>=20
> a bit fragile in amongst a whole load of device managed calls.
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* setup chip registers */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_setup(st, bus_setup); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* setup runtime power management */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_set_active(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_noresume(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_enable(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_set_autosuspend_delay(dev, INV_ICM=
42600_SUSPEND_DELAY_MS); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_use_autosuspend(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put(dev); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return devm_add_action_or_reset(dev, inv_icm4=
2600_disable_pm, dev); =20
>=20
> > +} =20
>=20
> > +EXPORT_SYMBOL_GPL(inv_icm42600_core_probe); =20
>=20
> > + =20
>=20
> > +static int __maybe_unused inv_icm42600_suspend(struct device *dev) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D dev_get_drv=
data(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->suspended.gyro =3D st->conf.gyro.mode; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->suspended.accel =3D st->conf.accel.mode; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->suspended.temp =3D st->conf.temp_en; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (pm_runtime_suspended(dev)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_IC=
M42600_SENSOR_MODE_OFF, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_SENSOR_MODE_OFF, false, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NULL); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(st->vddio_supply); =20
>=20
> > + =20
>=20
> > +out_unlock: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int __maybe_unused inv_icm42600_resume(struct device *dev) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D dev_get_drv=
data(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_enable_regulator_vddio(s=
t); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_disable(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_set_active(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_enable(dev); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* restore sensors state */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, st->su=
spended.gyro, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->suspended.accel, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->suspended.temp, NULL); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
>=20
>=20
> You may need this later, but for now it's a bit comic so ideally introduce
>=20
> it only when needed.
>=20
>=20
>=20
> > + =20
>=20
> > +out_unlock: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int __maybe_unused inv_icm42600_runtime_suspend(struct device *=
dev) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D dev_get_drv=
data(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* disable all sensors */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_IC=
M42600_SENSOR_MODE_OFF, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_SENSOR_MODE_OFF, false, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NULL); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto error_unlock; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(st->vddio_supply); =20
>=20
> > + =20
>=20
> > +error_unlock: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int __maybe_unused inv_icm42600_runtime_resume(struct device *d=
ev) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D dev_get_drv=
data(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
>=20
>=20
> Why don't we need to reenable all the sensors we disabled in runtime susp=
end?
>=20
> I can guess why we might not, but a comment here to explain would save on
>=20
> possible confusion..
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_enable_regulator_vddio(s=
t); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +const struct dev_pm_ops inv_icm42600_pm_ops =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend,=
 inv_icm42600_resume) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspe=
nd, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_i=
cm42600_runtime_resume, NULL) =20
>=20
> > +}; =20
>=20
> > +EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops); =20
>=20
> > + =20
>=20
> > +MODULE_AUTHOR("InvenSense, Inc."); =20
>=20
> > +MODULE_DESCRIPTION("InvenSense ICM-426xx device driver"); =20
>=20
> > +MODULE_LICENSE("GPL"); =20
>=20
>=20
>=20
>=20
>=20

