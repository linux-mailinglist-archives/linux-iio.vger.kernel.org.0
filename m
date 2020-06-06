Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B812E1F06FB
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 16:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgFFO3c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 10:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgFFO3b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 10:29:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E4C2073E;
        Sat,  6 Jun 2020 14:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591453770;
        bh=KizlQgkCVmkJJTWfCl3vKx9pREwBcRLkglQYNTI2Y2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AEIEbxHjBzU31PjTAeGctO0I5udQiQsbr45JbQXhfbBCF86bc1ZQSCJH7WS5tCLse
         OUutJGdV1IJreZwOiI8cWoTjcoepJeSl8XID9g1kbfCr79CagMSf7cc/S8tr4iMADB
         DS5EfJTOVm09orfsSQ8uXtZp5i75TdX7YMk/73+E=
Date:   Sat, 6 Jun 2020 15:29:26 +0100
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
Subject: Re: [PATCH v2 01/12] iio: imu: inv_icm42600: add core of new
 inv_icm42600 driver
Message-ID: <20200606152926.7bfb1ad0@archlinux>
In-Reply-To: <SA0PR12MB442938879EF3BDB4B813EC59C48B0@SA0PR12MB4429.namprd12.prod.outlook.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-2-jmaneyrol@invensense.com>
        <20200531123437.05b3df36@archlinux>
        <SA0PR12MB442938879EF3BDB4B813EC59C48B0@SA0PR12MB4429.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Jun 2020 07:56:49 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> I've given my review tag for the const change of iio_device_get_drvdata()=
. Would be perfect to have this cleaned up for the v3.

It's in my testing branch now..

>=20
> For vddio regulator you are missing something. In all suspend callbacks (=
system and runtime) I am calling directly regulator_disable to shut vddio o=
ff at then end. And in all resume callbacks I am calling inv_icm42600_enabl=
e_regulator_vddio() that is turning vddio regulator back on and is sleeping=
 to wait a little for the supply ramp.
>=20
> Indeed this doesn't look symmetric, but I was not very happy to add a inv=
_icm42600_disable_regulator_vddio() that would just do regulator_disable, o=
r copy/paste the sleeping value in all resume handlers.

Indeed I missed that function for some reason.

It's fine as is.

Jonathan

>=20
> Tell me what you prefer.
>=20
> Thanks,
> JB
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, May 31, 2020 13:34
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel=
.org>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemlo=
ft.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfound=
ation.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetr=
ee@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.o=
rg <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2 01/12] iio: imu: inv_icm42600: add core of new inv=
_icm42600 driver=20
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> On Wed, 27 May 2020 20:57:00 +0200
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
> > Core component of a new driver for InvenSense ICM-426xx devices.
> > It includes registers definition, main probe/setup, and device
> > utility functions.
> >=20
> > ICM-426xx devices are latest generation of 6-axis IMU,
> > gyroscope+accelerometer and temperature sensor. This device
> > includes a 2K FIFO, supports I2C/I3C/SPI, and provides
> > intelligent motion features like pedometer, tilt detection,
> > and tap detection.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
> A few things inline.
>=20
> Either I'm missing something or I'm guessing vddio is not controllable
> on your test board.
>=20
> > ---
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=C2=A0=C2=A0 | 372 +++=
+++++++
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=C2=A0 | 635 ++++++++=
++++++++++
> >=C2=A0 2 files changed, 1007 insertions(+)
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600.h
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_core=
.c
> >  =20
>=20
> ...
>=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_core.c
> > new file mode 100644
> > index 000000000000..81b171d6782c
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c =20
>=20
> > +const struct iio_mount_matrix *
> > +inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 const struct iio_chan_spec *chan)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const struct inv_icm42600_state *st =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_get_drvdata(=
(struct iio_dev *)indio_dev); =20
>=20
> If you review my patch to the core, I can get that applied and we can drop
> the ugly cast from here!
>=20
> Just waiting for someone to sanity check it.
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return &st->orientation;
> > +} =20
> ...
>=20
> > +/* Runtime suspend will turn off sensors that are enabled by iio devic=
es. */
> > +static int __maybe_unused inv_icm42600_runtime_suspend(struct device *=
dev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D dev_get_drv=
data(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* disable all sensors */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_IC=
M42600_SENSOR_MODE_OFF,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 INV_ICM42600_SENSOR_MODE_OFF, false,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto error_unlock;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 regulator_disable(st->vddio_supply); =20
>=20
> Don't seem to turn this on again in runtime_resume..
> Why?=C2=A0 Definitely needs at least a comment.
>=20
> > +
> > +error_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +/* Sensors are enabled by iio devices, no need to turn them back on he=
re. */
> > +static int __maybe_unused inv_icm42600_runtime_resume(struct device *d=
ev)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D dev_get_drv=
data(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_enable_regulator_vddio(s=
t);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +const struct dev_pm_ops inv_icm42600_pm_ops =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 SET_SYSTEM_SLEEP_PM_OPS(inv_icm42600_suspend,=
 inv_icm42600_resume)
> > +=C2=A0=C2=A0=C2=A0=C2=A0 SET_RUNTIME_PM_OPS(inv_icm42600_runtime_suspe=
nd,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inv_i=
cm42600_runtime_resume, NULL)
> > +};
> > +EXPORT_SYMBOL_GPL(inv_icm42600_pm_ops);
> > +
> > +MODULE_AUTHOR("InvenSense, Inc.");
> > +MODULE_DESCRIPTION("InvenSense ICM-426xx device driver");
> > +MODULE_LICENSE("GPL"); =20

