Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C9E1F0712
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgFFOmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 10:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgFFOmh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 10:42:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07A120723;
        Sat,  6 Jun 2020 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591454552;
        bh=hhYuhXbk+zEuLzTZLW0lRgb6uYZvrW5XFZXfHNOGBn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ghU/yUbLCQdd6KhJldPDbpKAxAvVYlOLsEEAbD//DosR0Irj7kwtIHYmi7MnacolS
         wkJr0rFsiOqF9RtmifSX5D9iBe4VP82UltRqj3KmvXnFR9GaW4aPb1Zh8NoAEjxVMh
         BffcwrCFXJSJ4Bav2peaw4Uh8u8PxUtoJhLR0I3o=
Date:   Sat, 6 Jun 2020 15:42:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/12] iio: imu: inv_icm42600: add buffer support in
 iio devices
Message-ID: <20200606154228.674dc475@archlinux>
In-Reply-To: <MN2PR12MB4422CB235D2E2F0C37E86C37C48B0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-10-jmaneyrol@invensense.com>
        <20200531135615.7938fb96@archlinux>
        <MN2PR12MB4422CB235D2E2F0C37E86C37C48B0@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Jun 2020 12:57:26 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> I agree that this multiplexed watermark computation value is anything exc=
ept simple and clear to understand.
> I will add more documentation about it. And it also triggered a
> kbuild robot issue, because it is using 64 bits modulo without using
> math64 macros.
>=20
> For buffer preenable/postenable/..., the sequence I am using
> currently is:
> - preenable -> turn chip on (pm_runtime_get)
> - update_scan_mode -> set FIFO en bits configuration (which sensor
> data is going into the fifo)
> - hwfifo_watermark -> compute and set watermark value
> - postenable -> turn FIFO on (and multiplexed with a FIFO on counter
> since used by accel & gyro)
> - predisable -> turn FIFO off (multiplexed with counter)
> - postdisable -> turn chip off (pm_runtime_put)
>=20
> This setting is working well. Good to note that if there is an error
> when enabling the buffer, postdisable will always get called after
> preenable. So it ensures pm_runtime reference counter to be always OK.
>=20
> Another way would be to only store configuration in internal state
> with update_scan_mode and hwfifo_watermark, and do everything in
> postenable/predisable. This is a possibility, but makes things a
> little more complex.

What you have here is fine.  Thanks for the explanation.

>=20
> For hwfifo flush, this is an interesting feature when there is a need
> to have data immediately. Or when there is a need to do a clean
> change of configuration. In Android systems, Android framework is
> mainly using FIFO flush to change the sensor configuration (ODR,
> watermark) in a clean way. For our case with the FIFO interleaved
> this is a not an issue. If there are samples from the 2 sensors, it
> means the 2 buffers are enabled. And if data is coming to the iio
> buffer sooner than expected, that should not be a problem. The
> limitation I see when the 2 sensors are runnings, is that we will
> return less data than should have been possible. I limit FIFO reading
> to the provided n bytes, so we could read less than n samples of 1
> sensor.

Yes.  I'm a little nervous about unexpected impacts of this last
case.  As you say early data rarely matters but late data can
potentially be an issue as software will assume it didn't get the
data because it didn't yet exist.

>=20
> Something I have in mind, that would be really interesting to be able
> to set/change watermark value when the buffer is enabled. Otherwise,
> we are always loosing events by turning sensor off when we want to
> change the value. Is there any limitation to work this way, or should
> it be possible to implement this feature in the future ?

I can't see why it would particularly matter in general if we did this
whilst 'live'. However, potentially we have sensors where reducing the
value could result in not getting an interrupt from a hw fifo.
(unwise design perhaps but we all know those exist :)

So care would be needed - perhaps some kind of opt in?

>=20
> Thanks,
> JB

Please remember to wrap our email if possible.

Thanks,

Jonathan



>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, May 31, 2020 14:56
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel=
.org>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemlo=
ft.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfound=
ation.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetr=
ee@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.o=
rg <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2 09/12] iio: imu: inv_icm42600: add buffer support =
in iio devices=20
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> On Wed, 27 May 2020 20:57:08 +0200
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
> > Add all FIFO parsing and reading functions. Add accel and gyro
> > kfifo buffer and FIFO data parsing. Use device interrupt for
> > reading data FIFO and launching accel and gyro parsing.
> >=20
> > Support hwfifo watermark by multiplexing gyro and accel settings.
> > Support hwfifo flush. =20
>=20
> Both of these are complex given the interactions of the two sensors
> types and to be honest I couldn't figure out exactly what the intent was.
> Needs more docs!
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > ---
> >=C2=A0 drivers/iio/imu/inv_icm42600/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >=C2=A0 drivers/iio/imu/inv_icm42600/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 8 +
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 160 ++++-
> >=C2=A0 .../imu/inv_icm42600/inv_icm42600_buffer.c=C2=A0=C2=A0=C2=A0 | 55=
5 ++++++++++++++++++
> >=C2=A0 .../imu/inv_icm42600/inv_icm42600_buffer.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 98 ++++
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=C2=A0 |=C2=A0 30 +
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=C2=A0 | 160 ++++-
> >=C2=A0 8 files changed, 1011 insertions(+), 2 deletions(-)
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buff=
er.c
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buff=
er.h
> >=20
> > diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv=
_icm42600/Kconfig
> > index 22390a72f0a3..50cbcfcb6cf1 100644
> > --- a/drivers/iio/imu/inv_icm42600/Kconfig
> > +++ b/drivers/iio/imu/inv_icm42600/Kconfig
> > @@ -2,6 +2,7 @@
> >=C2=A0=20
> >=C2=A0 config INV_ICM42600
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate
> > +=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BUFFER
> >=C2=A0=20
> >=C2=A0 config INV_ICM42600_I2C
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "InvenSense ICM-426x=
x I2C driver"
> > diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/in=
v_icm42600/Makefile
> > index 48965824f00c..0f49f6df3647 100644
> > --- a/drivers/iio/imu/inv_icm42600/Makefile
> > +++ b/drivers/iio/imu/inv_icm42600/Makefile
> > @@ -5,6 +5,7 @@ inv-icm42600-y +=3D inv_icm42600_core.o
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_gyro.o
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_accel.o
> >=C2=A0 inv-icm42600-y +=3D inv_icm42600_temp.o
> > +inv-icm42600-y +=3D inv_icm42600_buffer.o
> >=C2=A0=20
> >=C2=A0 obj-$(CONFIG_INV_ICM42600_I2C) +=3D inv-icm42600-i2c.o
> >=C2=A0 inv-icm42600-i2c-y +=3D inv_icm42600_i2c.o
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/=
imu/inv_icm42600/inv_icm42600.h
> > index 43749f56426c..4d5811562a61 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > @@ -14,6 +14,8 @@
> >=C2=A0 #include <linux/pm.h>
> >=C2=A0 #include <linux/iio/iio.h>
> >=C2=A0=20
> > +#include "inv_icm42600_buffer.h"
> > +
> >=C2=A0 enum inv_icm42600_chip {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42600,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_CHIP_ICM42602,
> > @@ -123,6 +125,7 @@ struct inv_icm42600_suspended {
> >=C2=A0=C2=A0 *=C2=A0 @indio_gyro:=C2=A0=C2=A0=C2=A0=C2=A0 gyroscope IIO =
device.
> >=C2=A0=C2=A0 *=C2=A0 @indio_accel:=C2=A0=C2=A0=C2=A0 accelerometer IIO d=
evice.
> >=C2=A0=C2=A0 *=C2=A0 @buffer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 data transfer buffer aligned for DMA.
> > + *=C2=A0 @fifo:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 FIFO management structure.
> >=C2=A0=C2=A0 */
> >=C2=A0 struct inv_icm42600_state {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock;
> > @@ -137,6 +140,7 @@ struct inv_icm42600_state {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_gyro;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_accel;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t buffer[2] ____cacheli=
ne_aligned;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo fifo;
> >=C2=A0 };
> >=C2=A0=20
> >=C2=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @addr=
ess on LSB */
> > @@ -377,6 +381,10 @@ int inv_icm42600_core_probe(struct regmap *regmap,=
 int chip, int irq,
> >=C2=A0=20
> >=C2=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
> >=C2=A0=20
> > +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev);
> > +
> >=C2=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st);
> >=C2=A0=20
> > +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
> > +
> >=C2=A0 #endif
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > index 6a615d7ffb24..c73ce204efc6 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > @@ -11,9 +11,12 @@
> >=C2=A0 #include <linux/delay.h>
> >=C2=A0 #include <linux/math64.h>
> >=C2=A0 #include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/kfifo_buf.h>
> >=C2=A0=20
> >=C2=A0 #include "inv_icm42600.h"
> >=C2=A0 #include "inv_icm42600_temp.h"
> > +#include "inv_icm42600_buffer.h"
> >=C2=A0=20
> >=C2=A0 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > @@ -64,6 +67,76 @@ static const struct iio_chan_spec inv_icm42600_accel=
_channels[] =3D {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_TEMP_CHAN(INV_IC=
M42600_ACCEL_SCAN_TEMP),
> >=C2=A0 };
> >=C2=A0=20
> > +/* IIO buffer data: 8 bytes */
> > +struct inv_icm42600_accel_buffer {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t padding;
> > +};
> > +
> > +#define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_ICM42600_ACCEL_SCAN_X) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_ACCEL_SCAN_Y) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_ACCEL_SCAN_Z))
> > +
> > +#define INV_ICM42600_SCAN_MASK_TEMP=C2=A0 BIT(INV_ICM42600_ACCEL_SCAN_=
TEMP)
> > +
> > +static const unsigned long inv_icm42600_accel_scan_masks[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis accel + temperature */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SCAN_MASK_ACCEL_3AXIS | INV_ICM4=
2600_SCAN_MASK_TEMP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0,
> > +};
> > +
> > +/* enable accelerometer sensor and FIFO write */
> > +static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_d=
ev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D INV_=
ICM42600_SENSOR_CONF_INIT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_temp =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_accel =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP)=
 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable temp sensor */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_temp_conf(st, true, &sleep_temp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_TEMP;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL=
_3AXIS) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable accel sensor */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_LOW_NOISE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_accel);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_ACCEL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* update data FIFO write */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, f=
ifo_en | st->fifo.en);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st);
> > +
> > +out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* sleep maximum required time */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_accel > sleep_temp)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleep);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> >=C2=A0 static int inv_icm42600_accel_read_sensor(struct inv_icm42600_sta=
te *st,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int16_t *val)
> > @@ -248,7 +321,12 @@ static int inv_icm42600_accel_write_odr(struct inv=
_icm42600_state *st,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_acce=
l_conf(st, &conf, NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_fifo_period(st);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_watermark(st);
> >=C2=A0=20
> > +out_unlock:
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev=
);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(de=
v);
> > @@ -563,12 +641,51 @@ static int inv_icm42600_accel_write_raw_get_fmt(s=
truct iio_dev *indio_dev,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=C2=A0 }
> >=C2=A0=20
> > +static int inv_icm42600_accel_hwfifo_set_watermark(struct iio_dev *ind=
io_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned in=
t val)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.watermark.accel =3D val;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 unsigned int count)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (count =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, =
count);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D st->fifo.nb.accel;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> >=C2=A0 static const struct iio_info inv_icm42600_accel_info =3D {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_raw =3D inv_icm42600_ac=
cel_read_raw,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_avail =3D inv_icm42600_=
accel_read_avail,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw =3D inv_icm42600_a=
ccel_write_raw,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw_get_fmt =3D inv_ic=
m42600_accel_write_raw_get_fmt,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .debugfs_reg_access =3D inv_i=
cm42600_debugfs_reg,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .update_scan_mode =3D inv_icm42600_accel_upda=
te_scan_mode,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_set_watermark =3D inv_icm42600_accel_=
hwfifo_set_watermark,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_acce=
l_hwfifo_flush,
> >=C2=A0 };
> >=C2=A0=20
> >=C2=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st)
> > @@ -576,6 +693,7 @@ int inv_icm42600_accel_init(struct inv_icm42600_sta=
te *st)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap=
_get_device(st->map);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_buffer *buffer;
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D devm_kasprintf(dev, =
GFP_KERNEL, "%s-accel", st->name);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!name)
> > @@ -585,14 +703,54 @@ int inv_icm42600_accel_init(struct inv_icm42600_s=
tate *st)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!indio_dev)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 buffer =3D devm_iio_kfifo_allocate(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!buffer)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENOMEM;
> > +
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_set_drvdata(indio_=
dev, st);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->dev.parent =3D dev;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name =3D name;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->info =3D &inv_icm4=
2600_accel_info;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE | INDI=
O_BUFFER_SOFTWARE;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D inv_i=
cm42600_accel_channels;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D A=
RRAY_SIZE(inv_icm42600_accel_channels);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_icm42=
600_accel_scan_masks;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->setup_ops =3D &inv_icm42600_buffer=
_ops;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_attach_buffer(indio_dev, buffer);
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->indio_accel =3D indio_dev;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_device_regist=
er(dev, st->indio_accel);
> >=C2=A0 }
> > +
> > +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t i, size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const void *accel, *gyro, *timestamp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const int8_t *temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_accel_buffer buffer =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .padding =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* parse all fifo packets */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < st->fifo.count; i +=3D size=
) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size =3D inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &accel, &gyro, &temp, &timestamp, &odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* quit if error or FIFO is empty */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (size <=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* skip packet if no accel data or data is invalid */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (accel =3D=3D NULL || !inv_icm42600_fifo_is_data_valid(accel))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* fill and push data buffer */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(&buffer.accel, accel, sizeof(buffer.accel));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 buffer.temp =3D temp ? *temp : 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_push_to_buffers(indio_dev, &buffer);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > new file mode 100644
> > index 000000000000..c91075f62231
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
> > @@ -0,0 +1,555 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2020 Invensense, Inc.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/delay.h>
> > +#include <linux/math64.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +
> > +#include "inv_icm42600.h"
> > +#include "inv_icm42600_buffer.h"
> > +
> > +/* FIFO header: 1 byte */
> > +#define INV_ICM42600_FIFO_HEADER_MSG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BIT(7)
> > +#define INV_ICM42600_FIFO_HEADER_ACCEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(6)
> > +#define INV_ICM42600_FIFO_HEADER_GYRO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(5)
> > +#define INV_ICM42600_FIFO_HEADER_TMST_FSYNC=C2=A0 GENMASK(3, 2)
> > +#define INV_ICM42600_FIFO_HEADER_ODR_ACCEL=C2=A0=C2=A0 BIT(1)
> > +#define INV_ICM42600_FIFO_HEADER_ODR_GYRO=C2=A0=C2=A0=C2=A0 BIT(0)
> > +
> > +struct inv_icm42600_fifo_1sensor_packet {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t header;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp;
> > +} __packed;
> > +#define INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> > +
> > +struct inv_icm42600_fifo_2sensors_packet {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t header;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 timestamp;
> > +} __packed;
> > +#define INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16
> > +
> > +ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void=
 **accel,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void **gyro, const int8_t **temp,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void **timestamp, unsigned int *odr)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_fifo_1sensor_packet=
 *pack1 =3D packet;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_fifo_2sensors_packe=
t *pack2 =3D packet;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t header =3D *((const uint8_t *)packet);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* FIFO empty */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_MSG) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *odr =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* handle odr flags */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *odr =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_GYR=
O)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *odr |=3D INV_ICM42600_SENSOR_GYRO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_ACC=
EL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *odr |=3D INV_ICM42600_SENSOR_ACCEL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* accel + gyro */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if ((header & INV_ICM42600_FIFO_HEADER_ACCEL)=
 &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (header & INV_ICM4260=
0_FIFO_HEADER_GYRO)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D &pack2->accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D &pack2->gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D &pack2->temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D &pack2->timestamp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* accel only */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_ACCEL) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D &pack1->data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D &pack1->temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* gyro only */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (header & INV_ICM42600_FIFO_HEADER_GYRO) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *accel =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *gyro =3D &pack1->data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *temp =3D &pack1->temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *timestamp =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* invalid packet if here */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > +}
> > +
> > +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state =
*st)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t period_gyro, period_accel, period;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.en & INV_ICM42600_SENSOR_GYRO)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_gyro =3D inv_icm42600_odr_to_period(st->conf.gyro.odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_gyro =3D U32_MAX;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.en & INV_ICM42600_SENSOR_ACCEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_accel =3D inv_icm42600_odr_to_period(st->conf.accel.odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period_accel =3D U32_MAX;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (period_gyro <=3D period_accel)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period =3D period_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 period =3D period_accel;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.period =3D period;
> > +}
> > +
> > +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask, val;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* update only FIFO EN bits */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mask =3D INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC=
_EN |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_FIFO_CONFIG1_TEMP_EN |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_FIFO_CONFIG1_GYRO_EN |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_en & INV_ICM42600_SENSOR_GYRO)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_GYRO_EN;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_en & INV_ICM42600_SENSOR_ACCEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (fifo_en & INV_ICM42600_SENSOR_TEMP)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_TEMP_EN;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_FIFO_CONFIG1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mask, val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.en =3D fifo_en;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_fifo_period(st);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +static size_t inv_icm42600_get_packet_size(unsigned int fifo_en)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t packet_size;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if ((fifo_en & INV_ICM42600_SENSOR_GYRO) &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (fifo_en & INV_ICM426=
00_SENSOR_ACCEL))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 packet_size =3D INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 packet_size =3D INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return packet_size;
> > +}
> > +
> > +static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t packet_size)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t wm_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int wm;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_size =3D watermark * packet_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (wm_size > INV_ICM42600_FIFO_WATERMARK_MAX)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 wm_size =3D INV_ICM42600_FIFO_WATERMARK_MAX;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm =3D wm_size / packet_size;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return wm;
> > +}
> > + =20
>=20
> I think some overview docs on how this is working would be good.
> Set out the aims for the watermark selected and how it is achieved.
>=20
> > +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t packet_size, wm_size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int wm_gyro, wm_accel, watermark;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t period_gyro, period_accel, period;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t latency_gyro, latency_accel, latency;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bool restore;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __le16 raw_wm;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 packet_size =3D inv_icm42600_get_packet_size(=
st->fifo.en);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* get minimal latency, depending on sensor w=
atermark and odr */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_gyro =3D inv_icm42600_wm_truncate(st->fifo=
.watermark.gyro,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 packet_size);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_accel =3D inv_icm42600_wm_truncate(st->fif=
o.watermark.accel,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 packet_size);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 period_gyro =3D inv_icm42600_odr_to_period(st=
->conf.gyro.odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 period_accel =3D inv_icm42600_odr_to_period(s=
t->conf.accel.odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 latency_gyro =3D (int64_t)period_gyro * (int6=
4_t)wm_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 latency_accel =3D (int64_t)period_accel * (in=
t64_t)wm_accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (latency_gyro =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 latency =3D latency_accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D wm_accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else if (latency_accel =3D=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 latency =3D latency_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D wm_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* compute the smallest latency that is a multiple of both */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (latency_gyro <=3D latency_accel) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency =3D latency_gyr=
o;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency -=3D latency_ac=
cel % latency_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency =3D latency_acc=
el;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 latency -=3D latency_gy=
ro % latency_accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* use the shortest period */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (period_gyro <=3D period_accel)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period =3D period_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 period =3D period_accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* all this works because periods are multiple of each others */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D div_s64(latency, period);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (watermark < 1)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watermark =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0 wm_size =3D watermark * packet_size;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* changing FIFO watermark requires to turn o=
ff watermark interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits_check(st->map, INV=
_ICM42600_REG_INT_SOURCE0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM4=
2600_INT_SOURCE0_FIFO_THS_INT1_EN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, &rest=
ore);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 raw_wm =3D INV_ICM42600_FIFO_WATERMARK_VAL(wm=
_size);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(st->buffer, &raw_wm, sizeof(raw_wm));
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_write(st->map, INV_ICM426=
00_REG_FIFO_WATERMARK,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->buffer, sizeof(raw_wm));
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* restore watermark interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (restore) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +/*
> > + * update_scan_mode callback is turning sensors on and setting data FI=
FO enable
> > + * bits.
> > + */
> > +static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* exit if FIFO is already on */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.on) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_on;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set FIFO threshold interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_INT_SOURCE0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* flush FIFO data */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_SIGNAL_PATH_RESET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_I=
CM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set FIFO in streaming mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_FIFO_CONFIG,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_I=
CM42600_FIFO_CONFIG_STREAM);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* workaround: first read of FIFO count after=
 reset is always 0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_read(st->map, INV_ICM4260=
0_REG_FIFO_COUNT, st->buffer, 2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +out_on:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* increase FIFO on counter */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.on++;
> > +out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* exit if there are several sensors using th=
e FIFO */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.on > 1) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_off;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* set FIFO in bypass mode */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_FIFO_CONFIG,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_I=
CM42600_FIFO_CONFIG_BYPASS);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* flush FIFO data */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(st->map, INV_ICM42600_RE=
G_SIGNAL_PATH_RESET,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_I=
CM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* disable FIFO threshold interrupt */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_INT_SOURCE0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN, 0=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +out_off:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* decrease FIFO on counter */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.on--;
> > +out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sensor;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *watermark;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D INV_=
ICM42600_SENSOR_CONF_INIT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_temp =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_sensor =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (indio_dev =3D=3D st->indio_gyro) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sensor =3D INV_ICM42600_SENSOR_GYRO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D &st->fifo.watermark.gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else if (indio_dev =3D=3D st->indio_accel) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sensor =3D INV_ICM42600_SENSOR_ACCEL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 watermark =3D &st->fifo.watermark.accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, s=
t->fifo.en & ~sensor);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *watermark =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sensor =3D=3D INV_ICM42600_SENSOR_GYRO)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, &sleep_sensor);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_accel_conf(st, &conf, &sleep_sensor);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* if FIFO is off, turn temperature off */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!st->fifo.on)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_temp_conf(st, false, &sleep_temp);
> > +
> > +out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* sleep maximum required time */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_sensor > sleep_temp)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_sensor;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleep);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +const struct iio_buffer_setup_ops inv_icm42600_buffer_ops =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .preenable =3D inv_icm42600_buffer_preenable,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .postenable =3D inv_icm42600_buffer_postenabl=
e, =20
>=20
> We've been slowly eroding the difference between preenable and posteenabl=
e.
> Would be good to understand why you need to define both?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .predisable =3D inv_icm42600_buffer_predisabl=
e,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .postdisable =3D inv_icm42600_buffer_postdisa=
ble,
> > +};
> > +
> > +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t max_count;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 *raw_fifo_count;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t i, size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const void *accel, *gyro, *timestamp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const int8_t *temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* reset all samples counters */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.count =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.gyro =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.accel =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.total =3D 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* compute maximum FIFO read size */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (max =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_count =3D sizeof(st->fifo.data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 max_count =3D max * inv_icm42600_get_packet_size(st->fifo.en);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* read FIFO count value */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 raw_fifo_count =3D (__be16 *)st->buffer;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_read(st->map, INV_ICM4260=
0_REG_FIFO_COUNT,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 raw_fifo_count, sizeof(*raw_fifo_count));
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.count =3D be16_to_cpup(raw_fifo_coun=
t);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* check and clamp FIFO count value */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.count =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.count > max_count)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.count =3D max_count;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* read all FIFO data in internal buffer */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_noinc_read(st->map, INV_ICM426=
00_REG_FIFO_DATA,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.data, st->fifo.count);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* compute number of samples for each sensor =
*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < st->fifo.count; i +=3D size=
) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size =3D inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &accel, &gyro, &temp, &timestamp, &odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (size <=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (gyro !=3D NULL && inv_icm42600_fifo_is_data_valid(gyro))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.gyro++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (accel !=3D NULL && inv_icm42600_fifo_is_data_valid(accel))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.nb.accel++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->fifo.nb.total++;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.nb.total =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.nb.gyro > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.nb.accel > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int count)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_fifo_read(st, cou=
nt);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret; =20
> Definitely searching my memory for how this works in the core, so
> I may have it wrong.
>=20
> This is a bit unusual (I think).=C2=A0 The intent of the flush
> is to read up to 'n' bytes because someone just did a read on the buffer
> or select, and there was data in the hwfifo capable of satisfying the read
> even though we haven't yet reached the watermark.
>=20
> Given both sensor types are coming from one buffer, do we have a potential
> issue here or under serving even though data is available?
>=20
> The case I worry may be served late is when an poll / select
> is waiting for sufficient data.
>=20
> So what should we be doing?=C2=A0 We want to guarantee to provide data
> for each sensor type if it's in the hwfifo. As such we could keep reading
> until we have enough, but that could cause some issues if the two data ra=
tes
> are very different (overflow on the other kfifo)
>=20
> Maybe what you have here is the best we can do.=20
>=20
> I'm assuming the watermark level has a similar problem.=C2=A0 One value r=
epresents
> the sum of the two types of data.
>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.nb.total =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.nb.gyro > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.nb.accel > 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_accel_parse_fifo(st->indio_accel);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +}
> > +
> > +int inv_icm42600_buffer_init(struct inv_icm42600_state *st)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Default FIFO configuration (bits 7 to=
 5)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - use invalid value
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - FIFO count in bytes
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - FIFO count in big endian
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_=
ENDIAN;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_update_bits(st->map, INV_ICM42=
600_REG_INTF_CONFIG0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(7, 5), val);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Enable FIFO partial read and continuo=
us watermark interrupt.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Disable all FIFO EN bits.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val =3D INV_ICM42600_FIFO_CONFIG1_RESUME_PART=
IAL_RD |
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42=
600_FIFO_CONFIG1_WM_GT_TH;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return regmap_update_bits(st->map, INV_ICM426=
00_REG_FIFO_CONFIG1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GENMASK(6, 5) | GENMASK(3, 0), val);
> > +}
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drive=
rs/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> > new file mode 100644
> > index 000000000000..de2a3949dcc7
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
> > @@ -0,0 +1,98 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2020 Invensense, Inc.
> > + */
> > +
> > +#ifndef INV_ICM42600_BUFFER_H_
> > +#define INV_ICM42600_BUFFER_H_
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/bits.h>
> > +
> > +struct inv_icm42600_state;
> > +
> > +#define INV_ICM42600_SENSOR_GYRO=C2=A0=C2=A0=C2=A0=C2=A0 BIT(0)
> > +#define INV_ICM42600_SENSOR_ACCEL=C2=A0=C2=A0=C2=A0 BIT(1)
> > +#define INV_ICM42600_SENSOR_TEMP=C2=A0=C2=A0=C2=A0=C2=A0 BIT(2)
> > +
> > +/**
> > + * struct inv_icm42600_fifo - FIFO state variables
> > + * @on:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 reference counter for FIFO on.
> > + * @en:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 bits field of INV_ICM42600_SENSOR_* for FIFO EN bits.
> > + * @period:=C2=A0 FIFO internal period.
> > + * @watermark:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watermark configura=
tion values for accel and gyro.
> > + * @count:=C2=A0=C2=A0 number of bytes in the FIFO data buffer.
> > + * @nb:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 gyro, accel and total samples in the FIFO data buffer.
> > + * @data:=C2=A0=C2=A0=C2=A0 FIFO data buffer aligned for DMA (2kB + 32=
 bytes of read cache).
> > + */
> > +struct inv_icm42600_fifo {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int on;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int en;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t period;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 unsigned int accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } watermark;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 size_t count;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t accel;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size_t total;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } nb;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t data[2080] ____cacheline_aligned;
> > +};
> > +
> > +/* FIFO data packet */
> > +struct inv_icm42600_fifo_sensor_data {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 x;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 y;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 z;
> > +} __packed; =20
>=20
> Why packed?=C2=A0 Should be anyway I think.
>=20
> > +#define INV_ICM42600_FIFO_DATA_INVALID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -32768
> > +
> > +static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return be16_to_cpu(d);
> > +}
> > +
> > +static inline bool
> > +inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_=
data *s)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int16_t x, y, z;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 x =3D inv_icm42600_fifo_get_sensor_data(s->x);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 y =3D inv_icm42600_fifo_get_sensor_data(s->y);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 z =3D inv_icm42600_fifo_get_sensor_data(s->z);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (x =3D=3D INV_ICM42600_FIFO_DATA_INVALID &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 y =3D=3D INV_ICM42600=
_FIFO_DATA_INVALID &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 z =3D=3D INV_ICM42600=
_FIFO_DATA_INVALID)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > +}
> > +
> > +ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void=
 **accel,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void **gyro, const int8_t **temp,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst void **timestamp, unsigned int *odr);
> > +
> > +extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops;
> > +
> > +int inv_icm42600_buffer_init(struct inv_icm42600_state *st);
> > +
> > +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state =
*st);
> > +
> > +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en);
> > +
> > +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st=
);
> > +
> > +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int max);
> > +
> > +int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st);
> > +
> > +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int count);
> > +
> > +#endif
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c
> > index 246c1eb52231..6f1c1eb83953 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > @@ -18,6 +18,7 @@
> >=C2=A0 #include <linux/iio/iio.h>
> >=C2=A0=20
> >=C2=A0 #include "inv_icm42600.h"
> > +#include "inv_icm42600_buffer.h"
> >=C2=A0=20
> >=C2=A0 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[]=
 =3D {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> > @@ -429,6 +430,18 @@ static irqreturn_t inv_icm42600_irq_handler(int ir=
q, void *_data)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status & INV_ICM42600_INT=
_STATUS_FIFO_FULL)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_warn(dev, "FIFO full data lost!\n");
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* FIFO threshold reached */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_THS=
) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_buffer_fifo_read(st, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "FIFO read=
 error %d\n", ret);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_buffer_fifo_parse(st);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "FIFO pars=
ing error %d\n", ret);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> >=C2=A0 out_unlock:
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;
> > @@ -600,6 +613,10 @@ int inv_icm42600_core_probe(struct regmap *regmap,=
 int chip, int irq,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_init(st);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_gyro_ini=
t(st);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
> > @@ -645,6 +662,14 @@ static int __maybe_unused inv_icm42600_suspend(str=
uct device *dev)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* disable FIFO data streaming */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.on) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_FIFO_CONFIG_BYPASS);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_pwr_=
mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 INV_ICM42600_SENSOR_MODE_OFF, false,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 NULL);
> > @@ -684,6 +709,11 @@ static int __maybe_unused inv_icm42600_resume(stru=
ct device *dev)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto out_unlock;
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* restore FIFO data streaming */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->fifo.on)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_FIFO_CONFIG_STREAM);
> > +
> >=C2=A0 out_unlock:
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > index 38654e0d217b..b05c33876b8d 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > @@ -11,9 +11,12 @@
> >=C2=A0 #include <linux/delay.h>
> >=C2=A0 #include <linux/math64.h>
> >=C2=A0 #include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/kfifo_buf.h>
> >=C2=A0=20
> >=C2=A0 #include "inv_icm42600.h"
> >=C2=A0 #include "inv_icm42600_temp.h"
> > +#include "inv_icm42600_buffer.h"
> >=C2=A0=20
> >=C2=A0 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > @@ -64,6 +67,76 @@ static const struct iio_chan_spec inv_icm42600_gyro_=
channels[] =3D {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_TEMP_CHAN(INV_IC=
M42600_GYRO_SCAN_TEMP),
> >=C2=A0 };
> >=C2=A0=20
> > +/* IIO buffer data: 8 bytes */
> > +struct inv_icm42600_gyro_buffer {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_fifo_sensor_data gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int8_t temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t padding;
> > +};
> > +
> > +#define INV_ICM42600_SCAN_MASK_GYRO_3AXIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 (BIT(INV_ICM42600_GYRO_SCAN_X) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_GYRO_SCAN_Y) |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 BIT(INV_ICM42600_GYRO_SCAN_Z))
> > +
> > +#define INV_ICM42600_SCAN_MASK_TEMP=C2=A0 BIT(INV_ICM42600_GYRO_SCAN_T=
EMP)
> > +
> > +static const unsigned long inv_icm42600_gyro_scan_masks[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 3-axis gyro + temperature */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_SCAN_MASK_GYRO_3AXIS | INV_ICM42=
600_SCAN_MASK_TEMP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0,
> > +};
> > +
> > +/* enable gyroscope sensor and FIFO write */
> > +static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_de=
v,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D INV_=
ICM42600_SENSOR_CONF_INIT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int fifo_en =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_gyro =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep_temp =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int sleep;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP)=
 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable temp sensor */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_temp_conf(st, true, &sleep_temp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_TEMP;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_GYRO_=
3AXIS) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* enable gyro sensor */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_LOW_NOISE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, &sleep_gyro);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fifo_en |=3D INV_ICM42600_SENSOR_GYRO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* update data FIFO write */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, f=
ifo_en | st->fifo.en);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st);
> > +
> > +out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* sleep maximum required time */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep_gyro > sleep_temp)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sleep =3D sleep_temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (sleep)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 msleep(sleep);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> >=C2=A0 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_stat=
e *st,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int16_t *val)
> > @@ -260,7 +333,12 @@ static int inv_icm42600_gyro_write_odr(struct inv_=
icm42600_state *st,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_gyro=
_conf(st, &conf, NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_fifo_period(st);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 inv_icm42600_buffer_update_watermark(st);
> >=C2=A0=20
> > +out_unlock:
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev=
);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(de=
v);
> > @@ -574,12 +652,51 @@ static int inv_icm42600_gyro_write_raw_get_fmt(st=
ruct iio_dev *indio_dev,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=C2=A0 }
> >=C2=A0=20
> > +static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indi=
o_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int val)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->fifo.watermark.gyro =3D val;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_update_watermark(=
st);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +static int inv_icm42600_gyro_hwfifo_flush(struct iio_dev *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 unsigned int count)
> > +{ =20
>=20
> Nothing to do with this patch, but I realised reading this that we have
> some 'unusual' use of the word flush here.=C2=A0 It's a straight forward
> read function so not sure why we called it flush.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (count =3D=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, =
count);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D st->fifo.nb.gyro;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> >=C2=A0 static const struct iio_info inv_icm42600_gyro_info =3D {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_raw =3D inv_icm42600_gy=
ro_read_raw,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .read_avail =3D inv_icm42600_=
gyro_read_avail,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw =3D inv_icm42600_g=
yro_write_raw,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw_get_fmt =3D inv_ic=
m42600_gyro_write_raw_get_fmt,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .debugfs_reg_access =3D inv_i=
cm42600_debugfs_reg,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .update_scan_mode =3D inv_icm42600_gyro_updat=
e_scan_mode,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_set_watermark =3D inv_icm42600_gyro_h=
wfifo_set_watermark,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_gyro=
_hwfifo_flush,
> >=C2=A0 };
> >=C2=A0=20
> >=C2=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st)
> > @@ -587,6 +704,7 @@ int inv_icm42600_gyro_init(struct inv_icm42600_stat=
e *st)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap=
_get_device(st->map);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_buffer *buffer;
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D devm_kasprintf(dev, =
GFP_KERNEL, "%s-gyro", st->name);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!name)
> > @@ -596,14 +714,54 @@ int inv_icm42600_gyro_init(struct inv_icm42600_st=
ate *st)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!indio_dev)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -ENOMEM;
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 buffer =3D devm_iio_kfifo_allocate(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!buffer)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENOMEM;
> > +
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_set_drvdata(indio_=
dev, st);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->dev.parent =3D dev;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name =3D name;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->info =3D &inv_icm4=
2600_gyro_info;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE | INDI=
O_BUFFER_SOFTWARE;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D inv_i=
cm42600_gyro_channels;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D A=
RRAY_SIZE(inv_icm42600_gyro_channels);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D inv_icm42=
600_gyro_scan_masks;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->setup_ops =3D &inv_icm42600_buffer=
_ops;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_attach_buffer(indio_dev, buffer);
> >=C2=A0=20
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->indio_gyro =3D indio_dev;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_device_regist=
er(dev, st->indio_gyro);
> >=C2=A0 }
> > +
> > +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D iio_device_=
get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ssize_t i, size;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const void *accel, *gyro, *timestamp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const int8_t *temp;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_gyro_buffer buffer =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .padding =3D 0, =20
>=20
> Might be worth a comment here or where the structure is defined
> on why we make padding explicit.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* parse all fifo packets */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < st->fifo.count; i +=3D size=
) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 size =3D inv_icm42600_fifo_decode_packet(&st->fifo.data[i],
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 &accel, &gyro, &temp, &timestamp, &odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* quit if error or FIFO is empty */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (size <=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return size;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* skip packet if no gyro data or data is invalid */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (gyro =3D=3D NULL || !inv_icm42600_fifo_is_data_valid(gyro))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* fill and push data buffer */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 buffer.temp =3D temp ? *temp : 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_push_to_buffers(indio_dev, &buffer);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > +} =20

