Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A541DD556
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 19:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgEUR5H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 13:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgEUR5G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 13:57:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4001820759;
        Thu, 21 May 2020 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590083821;
        bh=aTGCfJuhevQVjVC7yhyAvyw3whHtRVK8n3TaUe1ERsw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NeePgtGE5VY/quyeSaj5K4USQGJ7od+YqbW1A+HLZvA/Gu3RimWEFGijjTMqqt1ri
         fsZXnvOSTot3QZeslIAS5Zs+lFe5Z9j+ePWhP2r0g4E7InvlzGtiuw4Zx9xW1stv7Q
         qHqYNkP9h3c7Osrtl1pWOHL8/8Y3mu+ShZjErrO0=
Date:   Thu, 21 May 2020 18:56:56 +0100
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
Subject: Re: [PATCH 09/12] iio: imu: inv_icm42600: add buffer support in iio
 devices
Message-ID: <20200521185656.0df6ef69@archlinux>
In-Reply-To: <MN2PR12MB4422FF4727BB2D8344B9CAC8C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-10-jmaneyrol@invensense.com>
        <20200508151933.00007d56@Huawei.com>
        <MN2PR12MB4422FF4727BB2D8344B9CAC8C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 May 2020 15:32:27 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> no problem with the comments.
>=20
> fifo_decode_packet will move to source code,=C2=A0
>=20
> For the following sleep comment:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_gyro > sleep_temp)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleep); =20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_gyro > sleep_temp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 msleep(sleep_gyro);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>                 msleep(sleep_temp);
>=20
> I am using an intermediate local variable to avoid a call to msleep(0) wh=
ich is in fact sleeping for real for 1 jiffies as far as I understand. So i=
s it OK to keep it as is?
Doh.  I missed that for some reason. Absolutely fine as
it is!

J
>=20
> Thanks,
> JB
>=20
>=20
>=20
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
>=20
> Sent: Friday, May 8, 2020 16:19
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
> Subject: Re: [PATCH 09/12] iio: imu: inv_icm42600: add buffer support in =
iio devices
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
> On Thu, 7 May 2020 16:42:19 +0200
>=20
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
>=20
>=20
> > Use triggered buffer by parsing FIFO data read in device trigger. =20
>=20
> > Support hwfifo watermark by multiplexing gyro and accel settings. =20
>=20
> > Support hwfifo flush. =20
>=20
> >  =20
>=20
> > Simply use interrupt timestamp first. =20
>=20
> >  =20
>=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
> > --- =20
>=20
> >=C2=A0 drivers/iio/imu/inv_icm42600/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +- =20
>=20
> >=C2=A0 drivers/iio/imu/inv_icm42600/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 + =20
>=20
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 8 + =20
>=20
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 183 +++++++++ =20
>=20
> >=C2=A0 .../imu/inv_icm42600/inv_icm42600_buffer.c=C2=A0=C2=A0=C2=A0 | 35=
3 ++++++++++++++++++ =20
>=20
> >=C2=A0 .../imu/inv_icm42600/inv_icm42600_buffer.h=C2=A0=C2=A0=C2=A0 | 16=
2 ++++++++ =20
>=20
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=C2=A0 |=C2=A0 23 ++ =
=20
>=20
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=C2=A0 | 183 ++++++++=
+ =20
>=20
> >=C2=A0 .../imu/inv_icm42600/inv_icm42600_trigger.c=C2=A0=C2=A0 |=C2=A0 1=
5 +- =20
>=20
> >=C2=A0 9 files changed, 928 insertions(+), 3 deletions(-) =20
>=20
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buff=
er.c =20
>=20
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buff=
er.h =20
>=20
> >  =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv=
_icm42600/Kconfig =20
>=20
> > index 7b3eaeb2aa4a..8c0969319c49 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_icm42600/Kconfig =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/Kconfig =20
>=20
> > @@ -2,7 +2,8 @@ =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 config INV_ICM42600 =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_TRIGGER =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BUFFER =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_TRIGGERED_BUFFER =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 config INV_ICM42600_I2C =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "InvenSense ICM-426x=
x I2C driver" =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/in=
v_icm42600/Makefile =20
>=20
> > index e1f2aacbe888..d6732118010c 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_icm42600/Makefile =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/Makefile =20
>=20
> > @@ -6,6 +6,7 @@ inv-icm42600-y +=3D inv_icm42600_gyro.o =20
>=20
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_accel.o =20
>=20
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_temp.o =20
>=20
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_trigger.o =20
>=20
> > +inv-icm42600-y +=3D inv_icm42600_buffer.o =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 obj-$(CONFIG_INV_ICM42600_I2C) +=3D inv-icm42600-i2c.o =20
>=20
> >=C2=A0 inv-icm42600-i2c-y +=3D inv_icm42600_i2c.o =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/=
imu/inv_icm42600/inv_icm42600.h =20
>=20
> > index 175c1f67faee..947ca4dd245b 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h =20
>=20
> > @@ -15,6 +15,8 @@ =20
>=20
> >=C2=A0 #include <linux/iio/iio.h> =20
>=20
> >=C2=A0 #include <linux/iio/trigger.h> =20
>=20
> >=C2=A0  =20
>=20
> > +#include "inv_icm42600_buffer.h" =20
>=20
> > + =20
>=20
> >=C2=A0 enum inv_icm42600_chip { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42600, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42602, =20
>=20
> > @@ -124,6 +126,7 @@ struct inv_icm42600_suspended { =20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @indio_gyro:=C2=A0=C2=A0=C2=A0=C2=A0 gyroscope IIO =
device. =20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @indio_accel:=C2=A0=C2=A0=C2=A0 accelerometer IIO d=
evice. =20
>=20
> >=C2=A0=C2=A0 *=C2=A0 @trigger:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device internal interrupt =
trigger =20
>=20
> > + *=C2=A0 @fifo:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 FIFO management structure. =20
>=20
> >=C2=A0=C2=A0 */ =20
>=20
> >=C2=A0 struct inv_icm42600_state { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock; =20
>=20
> > @@ -138,6 +141,7 @@ struct inv_icm42600_state { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_gyro; =
=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_accel; =
=20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_trigger *trigger; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo fifo; =20
>=20
> >=C2=A0 }; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @addr=
ess on LSB */ =20
>=20
> > @@ -378,8 +382,12 @@ int inv_icm42600_core_probe(struct regmap *regmap,=
 int chip, int irq, =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st); =20
>=20
> >=C2=A0  =20
>=20
> > +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts=
); =20
>=20
> > + =20
>=20
> >=C2=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st); =20
>=20
> >=C2=A0  =20
>=20
> > +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t t=
s); =20
>=20
> > + =20
>=20
> >=C2=A0 int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int =
irq, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 int irq_type); =20
>=20
> >=C2=A0  =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_accel.c =20
>=20
> > index 74dac5f283d4..4206be54d057 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c =20
>=20
> > @@ -10,9 +10,13 @@ =20
>=20
> >=C2=A0 #include <linux/regmap.h> =20
>=20
> >=C2=A0 #include <linux/delay.h> =20
>=20
> >=C2=A0 #include <linux/iio/iio.h> =20
>=20
> > +#include <linux/iio/buffer.h> =20
>=20
> > +#include <linux/iio/triggered_buffer.h> =20
>=20
> > +#include <linux/iio/trigger_consumer.h> =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 #include "inv_icm42600.h" =20
>=20
> >=C2=A0 #include "inv_icm42600_temp.h" =20
>=20
> > +#include "inv_icm42600_buffer.h" =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \ =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > @@ -46,6 +50,7 @@ enum inv_icm42600_accel_scan { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_SCAN_Y, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_SCAN_Z, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_SCAN_TEMP,=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_SCAN_TIMESTAMP, =20
>=20
> >=C2=A0 }; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext=
_infos[] =3D { =20
>=20
> > @@ -61,8 +66,100 @@ static const struct iio_chan_spec inv_icm42600_acce=
l_channels[] =3D { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ACCEL_CHAN(IIO_M=
OD_Z, INV_ICM42600_ACCEL_SCAN_Z, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_accel_ext_infos), =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_TEMP_CHAN(INV_IC=
M42600_ACCEL_SCAN_TEMP), =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SC=
AN_TIMESTAMP), =20
>=20
> >=C2=A0 }; =20
>=20
> >=C2=A0  =20
>=20
> > +/* IIO buffer data */ =20
>=20
> > +struct inv_icm42600_accel_buffer { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data accel; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t timestamp; =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_ICM42600_ACCEL_SCAN_X) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_ACCEL_SCAN_Y) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_ACCEL_SCAN_Z)) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_SCAN_MASK_TEMP=C2=A0 BIT(INV_ICM42600_ACCEL_SCAN_=
TEMP) =20
>=20
> > + =20
>=20
> > +static const unsigned long inv_icm42600_accel_scan_masks[] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel + temperature */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SCAN_MASK_ACCEL_3AXIS | INV_ICM4=
2600_SCAN_MASK_TEMP, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +static irqreturn_t inv_icm42600_accel_handler(int irq, void *_data) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_poll_func *pf =3D _data; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D pf->indio_dev; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const size_t fifo_nb =3D st->fifo.nb.total; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* exit if no sample */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_nb =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_accel_parse_fifo(indio_d=
ev, pf->timestamp); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(regmap_get_device(st->map), "accel fifo error %d\n", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret); =20
>=20
> > + =20
>=20
> > +out: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_notify_done(indio_dev->trig); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +/* enable accelerometer sensor and FIFO write */ =20
>=20
> > +static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_d=
ev, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D INV_=
ICM42600_SENSOR_CONF_INIT; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_temp =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_accel =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP)=
 { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable temp sensor */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_temp_conf(st, true, &sleep_temp); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_TEMP; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL=
_3AXIS) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable accel sensor */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_LOW_NOISE; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_accel); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_ACCEL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* update data FIFO write and FIFO watermark =
*/ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, f=
ifo_en | st->fifo.en); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st); =20
>=20
> > + =20
>=20
> > +out_unlock: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* sleep maximum required time */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_accel > sleep_temp) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleep); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> >=C2=A0 static int inv_icm42600_accel_read_sensor(struct inv_icm42600_sta=
te *st, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int16_t *val) =20
>=20
> > @@ -250,6 +347,8 @@ static int inv_icm42600_accel_write_odr(struct inv_=
icm42600_state *st, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf.odr =3D inv_icm42600_acc=
el_odr_conv[idx / 2]; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_acce=
l_conf(st, &conf, NULL); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_fifo_period(st); =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_watermark(st); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev=
); =20
>=20
> > @@ -512,12 +611,51 @@ static int inv_icm42600_accel_write_raw_get_fmt(s=
truct iio_dev *indio_dev, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> >=C2=A0 } =20
>=20
> >=C2=A0  =20
>=20
> > +static int inv_icm42600_accel_hwfifo_set_watermark(struct iio_dev *ind=
io_dev, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned in=
t val) =20
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.watermark.accel =3D val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st); =20
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
> > +static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev, =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 unsigned int count) =20
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (count =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, =
count); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D st->fifo.nb.accel; =20
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
> >=C2=A0 static const struct iio_info inv_icm42600_accel_info =3D { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_raw =3D inv_icm42600_ac=
cel_read_raw, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_avail =3D inv_icm42600_=
accel_read_avail, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw =3D inv_icm42600_a=
ccel_write_raw, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw_get_fmt =3D inv_ic=
m42600_accel_write_raw_get_fmt, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .debugfs_reg_access =3D inv_i=
cm42600_debugfs_reg, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .update_scan_mode =3D inv_icm42600_accel_upda=
te_scan_mode, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_set_watermark =3D inv_icm42600_accel_=
hwfifo_set_watermark, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_acce=
l_hwfifo_flush, =20
>=20
> >=C2=A0 }; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st) =20
>=20
> > @@ -525,6 +663,7 @@ int inv_icm42600_accel_init(struct inv_icm42600_sta=
te *st) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap=
_get_device(st->map); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D devm_kasprintf(dev, =
GFP_KERNEL, "%s-accel", st->name); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!name) =20
>=20
> > @@ -541,7 +680,51 @@ int inv_icm42600_accel_init(struct inv_icm42600_st=
ate *st) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DI=
RECT_MODE; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D inv_i=
cm42600_accel_channels; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D A=
RRAY_SIZE(inv_icm42600_accel_channels); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_icm42=
600_accel_scan_masks; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D devm_iio_triggered_buffer_setup(dev, =
indio_dev, NULL, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_accel_handler, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &inv_icm42600_buffer_ops); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->trig =3D iio_trigger_get(st->trigg=
er); =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->indio_accel =3D indio_dev=
; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_device_regist=
er(dev, st->indio_accel); =20
>=20
> >=C2=A0 } =20
>=20
> > + =20
>=20
> > +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t t=
s) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const size_t accel_nb =3D st->fifo.nb.accel; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t i, size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const void *accel, *gyro, *temp, *timestamp; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_accel_buffer buffer; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* exit if no accel sample */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (accel_nb =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* parse all fifo packets */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < st->fifo.count; i +=3D size=
) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size =3D inv_icm42600_fifo_decode_packet(&st->fifo.data[i], =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &accel, &gyro, &temp, &timestamp, &odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_dbg(regmap_get_device(st->map), "accel packet size =3D %zd\n", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* quit if error or FIFO is empty */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (size <=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* skip packet if no accel data or data is invalid */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (accel =3D=3D NULL || !inv_icm42600_fifo_is_data_valid(accel)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(regmap_get_devi=
ce(st->map), "skip accel data\n"); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(&buffer.accel, accel, sizeof(buffer.accel)); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(&buffer.temp, temp, sizeof(buffer.temp)); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_buffer.c =20
>=20
> > new file mode 100644 =20
>=20
> > index 000000000000..b428abdc92ee =20
>=20
> > --- /dev/null =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c =20
>=20
> > @@ -0,0 +1,353 @@ =20
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
> > +#include <linux/mutex.h> =20
>=20
> > +#include <linux/pm_runtime.h> =20
>=20
> > +#include <linux/regmap.h> =20
>=20
> > +#include <linux/delay.h> =20
>=20
> > +#include <linux/math64.h> =20
>=20
> > +#include <linux/iio/iio.h> =20
>=20
> > +#include <linux/iio/buffer.h> =20
>=20
> > +#include <linux/iio/triggered_buffer.h> =20
>=20
> > +#include <linux/iio/trigger_consumer.h> =20
>=20
> > + =20
>=20
> > +#include "inv_icm42600.h" =20
>=20
> > +#include "inv_icm42600_buffer.h" =20
>=20
> > + =20
>=20
> > +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state =
*st) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t period_gyro, period_accel, period; =
=20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.en & INV_ICM42600_SENSOR_GYRO) =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_gyro =3D inv_icm42600_odr_to_period(st->conf.gyro.odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_gyro =3D U32_MAX; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.en & INV_ICM42600_SENSOR_ACCEL) =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_accel =3D inv_icm42600_odr_to_period(st->conf.accel.odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_accel =3D U32_MAX; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (period_gyro <=3D period_accel) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period =3D period_gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period =3D period_accel; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.period =3D period; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* update only FIFO EN bits */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC=
_EN | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_FIFO_CONFIG1_TEMP_EN | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_FIFO_CONFIG1_GYRO_EN | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_FIFO_CONFIG1_ACCEL_EN; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_en & INV_ICM42600_SENSOR_GYRO) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_GYRO_EN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_en & INV_ICM42600_SENSOR_ACCEL) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_ACCEL_EN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_en & INV_ICM42600_SENSOR_TEMP) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_TEMP_EN; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_FIFO_CONFIG1, =20
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.en =3D fifo_en; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_fifo_period(st); =
=20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static size_t inv_icm42600_get_packet_size(unsigned int fifo_en) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t packet_size; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if ((fifo_en & INV_ICM42600_SENSOR_GYRO) && =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (fifo_en & INV_ICM42600=
_SENSOR_ACCEL)) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 packet_size =3D INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 packet_size =3D INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return packet_size; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static unsigned int inv_icm42600_wm_truncate(unsigned int watermark, =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t packet_size) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t wm_size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int wm; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_size =3D watermark * packet_size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (wm_size > INV_ICM42600_FIFO_WATERMARK_MAX=
) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 wm_size =3D INV_ICM42600_FIFO_WATERMARK_MAX; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm =3D wm_size / packet_size; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return wm; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st=
) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t packet_size, wm_size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int wm_gyro, wm_accel, watermark; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t period_gyro, period_accel, period; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t latency_gyro, latency_accel, latency;=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bool restore; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __le16 raw_wm; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 packet_size =3D inv_icm42600_get_packet_size(=
st->fifo.en); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* get minimal latency, depending on sensor w=
atermark and odr */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_gyro =3D inv_icm42600_wm_truncate(st->fifo=
.watermark.gyro, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 packet_size); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_accel =3D inv_icm42600_wm_truncate(st->fif=
o.watermark.accel, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 packet_size); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 period_gyro =3D inv_icm42600_odr_to_period(st=
->conf.gyro.odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 period_accel =3D inv_icm42600_odr_to_period(s=
t->conf.accel.odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 latency_gyro =3D (int64_t)period_gyro * (int6=
4_t)wm_gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 latency_accel =3D (int64_t)period_accel * (in=
t64_t)wm_accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (latency_gyro =3D=3D 0) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 latency =3D latency_accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D wm_accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else if (latency_accel =3D=3D 0) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 latency =3D latency_gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D wm_gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* compute the smallest latency that is a multiple of both */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (latency_gyro <=3D latency_accel) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency =3D latency_gyr=
o; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency -=3D latency_ac=
cel % latency_gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency =3D latency_acc=
el; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency -=3D latency_gy=
ro % latency_accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* use the shortest period */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (period_gyro <=3D period_accel) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period =3D period_gyro;=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period =3D period_accel=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* all this works because periods are multiple of each others */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D div_s64(latency, period); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (watermark < 1) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watermark =3D 1; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_size =3D watermark * packet_size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(regmap_get_device(st->map), "watermar=
k: %u (%zu)\n", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark, wm_size); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* changing FIFO watermark requires to turn o=
ff watermark interrupt */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_INT_SOURCE0_FIFO_THS_IN=
T1_EN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits_check(st->map, INV=
_ICM42600_REG_INT_SOURCE0, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, va=
l, &restore); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 raw_wm =3D INV_ICM42600_FIFO_WATERMARK_VAL(wm=
_size); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_write(st->map, INV_ICM426=
00_REG_FIFO_WATERMARK, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &raw_wm, sizeof(raw_wm)); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* restore watermark interrupt */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (restore) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mask =3D INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val =3D INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mask, val); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(dev); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev) =
=20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sensor; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *watermark; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D INV_=
ICM42600_SENSOR_CONF_INIT; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (indio_dev =3D=3D st->indio_gyro) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sensor =3D INV_ICM42600_SENSOR_GYRO; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D &st->fifo.watermark.gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else if (indio_dev =3D=3D st->indio_accel) =
{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sensor =3D INV_ICM42600_SENSOR_ACCEL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D &st->fifo.watermark.accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, s=
t->fifo.en & ~sensor); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *watermark =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sensor =3D=3D INV_ICM42600_SENSOR_GYRO) =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, &sleep); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep); =20
>=20
> > + =20
>=20
> > +out_unlock: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleep); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(dev); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +const struct iio_buffer_setup_ops inv_icm42600_buffer_ops =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .preenable =3D inv_icm42600_buffer_preenable,=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .postenable =3D iio_triggered_buffer_postenab=
le, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .predisable =3D iio_triggered_buffer_predisab=
le, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .postdisable =3D inv_icm42600_buffer_postdisa=
ble, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 raw_fifo_count; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t max_count; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t i, size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const void *accel, *gyro, *temp, *timestamp; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* reset all samples counters */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.count =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.gyro =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.accel =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.total =3D 0; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* compute maximum FIFO read size */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (max =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_count =3D sizeof(st->fifo.data); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_count =3D max * inv_icm42600_get_packet_size(st->fifo.en); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* read FIFO count value */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_read(st->map, INV_ICM4260=
0_REG_FIFO_COUNT, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &raw_fifo_count, sizeof(raw_fifo_count)); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.count =3D be16_to_cpu(raw_fifo_count=
); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "FIFO count =3D %zu\n", st->fifo=
.count); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* check and sanitize FIFO count value */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.count =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.count > max_count) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.count =3D max_count; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* read all FIFO data in internal buffer */ =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_noinc_read(st->map, INV_ICM426=
00_REG_FIFO_DATA, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.data, st->fifo.count); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* compute number of samples for each sensor =
*/ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < st->fifo.count; i +=3D size=
) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size =3D inv_icm42600_fifo_decode_packet(&st->fifo.data[i], =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &accel, &gyro, &temp, &timestamp, &odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (size <=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (gyro !=3D NULL && inv_icm42600_fifo_is_data_valid(gyro)) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.gyro++; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (accel !=3D NULL && inv_icm42600_fifo_is_data_valid(accel)) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.accel++; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.nb.total++; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int count) =
=20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t ts_gyro, ts_accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(regmap_get_device(st->map), "FIFO flu=
sh %u\n", count); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ts_gyro =3D iio_get_time_ns(st->indio_gyro); =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ts_accel =3D iio_get_time_ns(st->indio_accel)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_fifo_read(st, cou=
nt); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.nb.total =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_gyro_parse_fifo(st->indi=
o_gyro, ts_gyro); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return inv_icm42600_accel_parse_fifo(st->indi=
o_accel, ts_accel); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_init(struct inv_icm42600_state *st) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Default FIFO configuration (bits 7 to=
 5) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - use invalid value =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - FIFO count in bytes =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - FIFO count in big endian =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D GENMASK(7, 5); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_=
ENDIAN; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_INTF_CONFIG0, =20
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Enable FIFO partial read and continuo=
us watermark interrupt. =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Disable all FIFO EN bits. =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D GENMASK(6, 5) | GENMASK(3, 0); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_FIFO_CONFIG1_RESUME_PART=
IAL_RD | =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_FIFO_CONFIG1_WM_GT_TH; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return regmap_update_bits(st->map, INV_ICM426=
00_REG_FIFO_CONFIG1, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, val); =20
>=20
> > +} =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_buffer.h =20
>=20
> > new file mode 100644 =20
>=20
> > index 000000000000..74b91c0e664b =20
>=20
> > --- /dev/null =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h =20
>=20
> > @@ -0,0 +1,162 @@ =20
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
> > +#ifndef INV_ICM42600_BUFFER_H_ =20
>=20
> > +#define INV_ICM42600_BUFFER_H_ =20
>=20
> > + =20
>=20
> > +#include <linux/kernel.h> =20
>=20
> > +#include <linux/bits.h> =20
>=20
> > + =20
>=20
> > +struct inv_icm42600_state; =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_SENSOR_GYRO=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > +#define INV_ICM42600_SENSOR_ACCEL=C2=A0=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_SENSOR_TEMP=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2) =20
>=20
> > + =20
>=20
> > +struct inv_icm42600_fifo { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int en; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t period; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } watermark; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t count; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t total; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } nb; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t data[2080]; =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +/* FIFO header: 1 byte */ =20
>=20
> > +#define INV_ICM42600_FIFO_HEADER_MSG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(7) =20
>=20
> > +#define INV_ICM42600_FIFO_HEADER_ACCEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(6) =20
>=20
> > +#define INV_ICM42600_FIFO_HEADER_GYRO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5) =20
>=20
> > +#define INV_ICM42600_FIFO_HEADER_TMST_FSYNC=C2=A0 GENMASK(3, 2) =20
>=20
> > +#define INV_ICM42600_FIFO_HEADER_ODR_ACCEL=C2=A0=C2=A0 BIT(1) =20
>=20
> > +#define INV_ICM42600_FIFO_HEADER_ODR_GYRO=C2=A0=C2=A0=C2=A0 BIT(0) =20
>=20
> > + =20
>=20
> > +/* FIFO data packet */ =20
>=20
> > +struct inv_icm42600_fifo_sensor_data { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 x; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 y; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 z; =20
>=20
> > +} __packed; =20
>=20
> > +#define INV_ICM42600_FIFO_DATA_INVALID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -32768 =20
>=20
> > + =20
>=20
> > +struct inv_icm42600_fifo_1sensor_packet { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t header; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data data; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp; =20
>=20
> > +} __packed; =20
>=20
> > +#define INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8 =20
>=20
> > + =20
>=20
> > +struct inv_icm42600_fifo_2sensors_packet { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t header; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data accel; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 timestamp; =20
>=20
> > +} __packed; =20
>=20
> > +#define INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16 =20
>=20
> > + =20
>=20
> > +static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return be16_to_cpu(d); =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static inline bool =20
>=20
> > +inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_=
data *s) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int16_t x, y, z; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 x =3D inv_icm42600_fifo_get_sensor_data(s->x)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 y =3D inv_icm42600_fifo_get_sensor_data(s->y)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 z =3D inv_icm42600_fifo_get_sensor_data(s->z)=
; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (x =3D=3D INV_ICM42600_FIFO_DATA_INVALID &=
& =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y =3D=3D INV_ICM42600_F=
IFO_DATA_INVALID && =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 z =3D=3D INV_ICM42600_F=
IFO_DATA_INVALID) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return true; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +static inline ssize_t inv_icm42600_fifo_decode_packet(const void *pack=
et, =20
>=20
>=20
>=20
> Bit big to be in the header..
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const void **accel, const void **gyro, const void **temp, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const void **timestamp, unsigned int *odr) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_fifo_1sensor_packet=
 *pack1 =3D packet; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_fifo_2sensors_packe=
t *pack2 =3D packet; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t header =3D *((const uint8_t *)packet)=
; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* FIFO empty */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_MSG) { =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *odr =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* handle odr flags */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *odr =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_GYR=
O) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *odr |=3D INV_ICM42600_SENSOR_GYRO; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_ACC=
EL) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *odr |=3D INV_ICM42600_SENSOR_ACCEL; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* accel + gyro */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if ((header & INV_ICM42600_FIFO_HEADER_ACCEL)=
 && =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (header & INV_ICM42600_=
FIFO_HEADER_GYRO)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D &pack2->accel; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D &pack2->gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D &pack2->temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D &pack2->timestamp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* accel only */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_ACCEL) =
{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D &pack1->data; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D &pack1->temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* gyro only */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_GYRO) {=
 =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D &pack1->data; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D &pack1->temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D NULL; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* invalid packet if here */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops; =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_init(struct inv_icm42600_state *st); =20
>=20
> > + =20
>=20
> > +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state =
*st); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st=
); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max); =20
>=20
> > + =20
>=20
> > +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int count);=
 =20
>=20
> > + =20
>=20
> > +#endif =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c =20
>=20
> > index 1102c54396e3..689089065ff9 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c =20
>=20
> > @@ -14,6 +14,7 @@ =20
>=20
> >=C2=A0 #include <linux/iio/iio.h> =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 #include "inv_icm42600.h" =20
>=20
> > +#include "inv_icm42600_buffer.h" =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[]=
 =3D { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { =20
>=20
> > @@ -515,6 +516,11 @@ int inv_icm42600_core_probe(struct regmap *regmap,=
 int chip, int irq, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> >=C2=A0  =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* setup FIFO buffer */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_init(st); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* setup interrupt trigger */=
 =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_trigger_=
init(st, irq, irq_type); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > @@ -559,6 +565,16 @@ static int __maybe_unused inv_icm42600_suspend(str=
uct device *dev) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> >=C2=A0  =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* disable FIFO data streaming */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_buffer_enabled(st->indio_gyro) || =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_buffer_enabled(st->=
indio_accel)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* set FIFO in bypass mode */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_FIFO_CONFIG_BYPASS)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_pwr_=
mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 INV_ICM42600_SENSOR_MODE_OFF, false, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 NULL); =20
>=20
> > @@ -594,6 +610,13 @@ static int __maybe_unused inv_icm42600_resume(stru=
ct device *dev) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> >=C2=A0  =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* restore FIFO data streaming */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_buffer_enabled(st->indio_gyro) || =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_buffer_enabled(st->=
indio_accel)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_FIFO_CONFIG_STREAM)=
; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> >=C2=A0 out_unlock: =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_gyro.c =20
>=20
> > index c0164ab2830e..dafb104abc77 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c =20
>=20
> > @@ -10,9 +10,13 @@ =20
>=20
> >=C2=A0 #include <linux/regmap.h> =20
>=20
> >=C2=A0 #include <linux/delay.h> =20
>=20
> >=C2=A0 #include <linux/iio/iio.h> =20
>=20
> > +#include <linux/iio/buffer.h> =20
>=20
> > +#include <linux/iio/triggered_buffer.h> =20
>=20
> > +#include <linux/iio/trigger_consumer.h> =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 #include "inv_icm42600.h" =20
>=20
> >=C2=A0 #include "inv_icm42600_temp.h" =20
>=20
> > +#include "inv_icm42600_buffer.h" =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > @@ -46,6 +50,7 @@ enum inv_icm42600_gyro_scan { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_SCAN_Y, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_SCAN_Z, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_SCAN_TEMP, =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_SCAN_TIMESTAMP, =20
>=20
> >=C2=A0 }; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_=
infos[] =3D { =20
>=20
> > @@ -61,8 +66,100 @@ static const struct iio_chan_spec inv_icm42600_gyro=
_channels[] =3D { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_CHAN(IIO_MO=
D_Z, INV_ICM42600_GYRO_SCAN_Z, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_gyro_ext_infos), =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_TEMP_CHAN(INV_IC=
M42600_GYRO_SCAN_TEMP), =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCA=
N_TIMESTAMP), =20
>=20
> >=C2=A0 }; =20
>=20
> >=C2=A0  =20
>=20
> > +/* IIO buffer data */ =20
>=20
> > +struct inv_icm42600_gyro_buffer { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t timestamp; =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_SCAN_MASK_GYRO_3AXIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_ICM42600_GYRO_SCAN_X) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_GYRO_SCAN_Y) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_GYRO_SCAN_Z)) =20
>=20
> > + =20
>=20
> > +#define INV_ICM42600_SCAN_MASK_TEMP=C2=A0 BIT(INV_ICM42600_GYRO_SCAN_T=
EMP) =20
>=20
> > + =20
>=20
> > +static const unsigned long inv_icm42600_gyro_scan_masks[] =3D { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro + temperature */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SCAN_MASK_GYRO_3AXIS | INV_ICM42=
600_SCAN_MASK_TEMP, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0, =20
>=20
> > +}; =20
>=20
> > + =20
>=20
> > +static irqreturn_t inv_icm42600_gyro_handler(int irq, void *_data) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_poll_func *pf =3D _data; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D pf->indio_dev; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const size_t fifo_nb =3D st->fifo.nb.total; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* exit if no sample */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_nb =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_gyro_parse_fifo(indio_de=
v, pf->timestamp); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_err(regmap_get_device(st->map), "gyro fifo error %d\n", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret); =20
>=20
> > + =20
>=20
> > +out: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_notify_done(indio_dev->trig); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> > +/* enable gyroscope sensor and FIFO write */ =20
>=20
> > +static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_de=
v, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D INV_=
ICM42600_SENSOR_CONF_INIT; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_gyro =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_temp =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP)=
 { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable temp sensor */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_temp_conf(st, true, &sleep_temp); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_TEMP; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_GYRO_=
3AXIS) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable gyro sensor */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_LOW_NOISE; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, &sleep_gyro); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_GYRO; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* update data FIFO write and FIFO watermark =
*/ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, f=
ifo_en | st->fifo.en); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock; =20
>=20
>=20
>=20
> blank line
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st); =20
>=20
> > + =20
>=20
> > +out_unlock: =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* sleep maximum required time */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_gyro > sleep_temp) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_temp; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleep); =20
>=20
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_gyro > sleep_temp)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 msleep(sleep_gyro);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 msleep(sleep_temp);
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> > +} =20
>=20
> > + =20
>=20
> >=C2=A0 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_stat=
e *st, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int16_t *val) =20
>=20
> > @@ -262,6 +359,8 @@ static int inv_icm42600_gyro_write_odr(struct inv_i=
cm42600_state *st, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conf.odr =3D inv_icm42600_gyr=
o_odr_conv[idx / 2]; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_gyro=
_conf(st, &conf, NULL); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_fifo_period(st); =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_watermark(st); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev=
); =20
>=20
> > @@ -524,12 +623,51 @@ static int inv_icm42600_gyro_write_raw_get_fmt(st=
ruct iio_dev *indio_dev, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> >=C2=A0 } =20
>=20
> >=C2=A0  =20
>=20
> > +static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indi=
o_dev, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)=
 =20
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.watermark.gyro =3D val; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st); =20
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
> > +static int inv_icm42600_gyro_hwfifo_flush(struct iio_dev *indio_dev, =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 unsigned int count) =20
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
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (count =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock); =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, =
count); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D st->fifo.nb.gyro; =20
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
> >=C2=A0 static const struct iio_info inv_icm42600_gyro_info =3D { =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_raw =3D inv_icm42600_gy=
ro_read_raw, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_avail =3D inv_icm42600_=
gyro_read_avail, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw =3D inv_icm42600_g=
yro_write_raw, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw_get_fmt =3D inv_ic=
m42600_gyro_write_raw_get_fmt, =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .debugfs_reg_access =3D inv_i=
cm42600_debugfs_reg, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .update_scan_mode =3D inv_icm42600_gyro_updat=
e_scan_mode, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_set_watermark =3D inv_icm42600_gyro_h=
wfifo_set_watermark, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_gyro=
_hwfifo_flush, =20
>=20
> >=C2=A0 }; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st) =20
>=20
> > @@ -537,6 +675,7 @@ int inv_icm42600_gyro_init(struct inv_icm42600_stat=
e *st) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap=
_get_device(st->map); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret; =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D devm_kasprintf(dev, =
GFP_KERNEL, "%s-gyro", st->name); =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!name) =20
>=20
> > @@ -553,7 +692,51 @@ int inv_icm42600_gyro_init(struct inv_icm42600_sta=
te *st) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DI=
RECT_MODE; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D inv_i=
cm42600_gyro_channels; =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D A=
RRAY_SIZE(inv_icm42600_gyro_channels); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_icm42=
600_gyro_scan_masks; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D devm_iio_triggered_buffer_setup(dev, =
indio_dev, NULL, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_gyro_handler, =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &inv_icm42600_buffer_ops); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->trig =3D iio_trigger_get(st->trigg=
er); =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->indio_gyro =3D indio_dev;=
 =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_device_regist=
er(dev, st->indio_gyro); =20
>=20
> >=C2=A0 } =20
>=20
> > + =20
>=20
> > +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts=
) =20
>=20
> > +{ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const size_t gyro_nb =3D st->fifo.nb.gyro; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t i, size; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const void *accel, *gyro, *temp, *timestamp; =
=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_gyro_buffer buffer; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* exit if no gyro sample */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (gyro_nb =3D=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0; =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* parse all fifo packets */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < st->fifo.count; i +=3D size=
) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size =3D inv_icm42600_fifo_decode_packet(&st->fifo.data[i], =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &accel, &gyro, &temp, &timestamp, &odr); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dev_dbg(regmap_get_device(st->map), "gyro packet size =3D %zd\n", =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* quit if error or FIFO is empty */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (size <=3D 0) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size; =20
>=20
>=20
>=20
> blank line here.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* skip packet if no gyro data or data is invalid */ =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (gyro =3D=3D NULL || !inv_icm42600_fifo_is_data_valid(gyro)) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(regmap_get_devi=
ce(st->map), "skip gyro data\n"); =20
>=20
>=20
>=20
> Very noisy logging. I'd drop it for the final version of the driver.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro)); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(&buffer.temp, temp, sizeof(buffer.temp)); =20
>=20
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 buffer.temp =3D temp;
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0; =20
>=20
> > +} =20
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c b/driv=
ers/iio/imu/inv_icm42600/inv_icm42600_trigger.c =20
>=20
> > index 7a5e76305f0b..5667e0204722 100644 =20
>=20
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c =20
>=20
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c =20
>=20
> > @@ -13,6 +13,7 @@ =20
>=20
> >=C2=A0 #include <linux/iio/trigger_consumer.h> =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 #include "inv_icm42600.h" =20
>=20
> > +#include "inv_icm42600_buffer.h" =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 static irqreturn_t inv_icm42600_trigger_timestamp(int irq, void *=
_data) =20
>=20
> >=C2=A0 { =20
>=20
> > @@ -45,8 +46,18 @@ static irqreturn_t inv_icm42600_trigger_int_handler(=
int irq, void *_data) =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_warn(dev, "FIFO full data lost!\n"); =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FIFO threshold reached */ =
=20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_THS=
) =20
>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_trigger_poll_chained(st->trigger); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_THS=
) { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_buffer_fifo_read(st, 0); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "FIFO read=
 error %d\n", ret); =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else { =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.count =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.nb.gyro =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.nb.accel =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.nb.total =3D 0; =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> > + =20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_trigger_poll_chained(st->trigger); =20
>=20
> >=C2=A0  =20
>=20
> >=C2=A0 out_unlock: =20
>=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock); =20
>=20
>=20
>=20
>=20
>=20
>=20

