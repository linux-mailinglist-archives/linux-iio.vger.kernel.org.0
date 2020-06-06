Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E164A1F0701
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jun 2020 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFFOdw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Jun 2020 10:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgFFOdv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jun 2020 10:33:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472252073E;
        Sat,  6 Jun 2020 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591454029;
        bh=R/5KZpXB16XBum5tHOuiplKSRrW1pCKI4oSJjCOaeq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vEofTC2lEJI+Axx0rVAld1byi0RnlTb/ZXGLKXoq3eM9zobfeU2INUpFPfNLV8e3/
         rv2zysZU9LSE/hbhM96bgzwtCE4lQ93Qdo6Jrkrh+3QinohaPt2nJTqnqx45RQiv0C
         qULVh6TfpcS1tIbhBQYdHEME5M2dWmGj6cVwdlFs=
Date:   Sat, 6 Jun 2020 15:33:43 +0100
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
Subject: Re: [PATCH v2 04/12] iio: imu: inv_icm42600: add gyroscope IIO
 device
Message-ID: <20200606153343.3672ccd7@archlinux>
In-Reply-To: <MN2PR12MB4422A323E043F4786E12E18FC48B0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-5-jmaneyrol@invensense.com>
        <20200531125415.6904a94d@archlinux>
        <MN2PR12MB4422A323E043F4786E12E18FC48B0@MN2PR12MB4422.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Jun 2020 09:10:29 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hi Jonathan,
>=20
> for the calibration bias, value is expressed in g unit, fixed,
> independant from any scale value. So I can switch to g instead of SI
> unit, but this will still not be like raw data which are dependent of
> the scale value. That's why I used SI units.
>=20
> Another solution, would be to adapt the value depending on the scale
> setting. So that it will correspond to raw data. But this also
> invovles complex computation.
>=20
> Tell me what you prefer.

I'm not actually that fussed, because the vast majority of
users will never touch this due to need to perform a calibration
procedure to know what to set it to.  We have always left
it loosely defined, so perhaps our best plan is to not tighten
that up.

However, I would like part specific ABI docs to state the units
you have have for it.  Otherwise no user will have any way of=20
knowing what they should do if they are in a position to do
high accuracy calibration.

Alternative would be to make it in raw units and deal with the
dependence between scale and the value here.   That's kind of
my ideal option, but I understand its complex to do and of little
utility on a calibration twiddle.

Jonathan


>=20
> Thanks,
> JB
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, May 31, 2020 13:54
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
> Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org
> <robh@kernel.org>; mchehab+huawei@kernel.org
> <mchehab+huawei@kernel.org>; davem@davemloft.net
> <davem@davemloft.net>; gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org>; linux-iio@vger.kernel.org
> <linux-iio@vger.kernel.org>; devicetree@vger.kernel.org
> <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org
> <linux-kernel@vger.kernel.org> Subject: Re: [PATCH v2 04/12] iio:
> imu: inv_icm42600: add gyroscope IIO device CAUTION: This email
> originated from outside of the organization. Please make sure the
> sender is who they say they are and do not click links or open
> attachments unless you recognize the sender and know the content is
> safe.
>=20
> On Wed, 27 May 2020 20:57:03 +0200
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
>=20
> > Add IIO device for gyroscope sensor with data polling interface.
> > Attributes: raw, scale, sampling_frequency, calibbias.
> >=20
> > Gyroscope in low noise mode.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> =20
>=20
> Unusual to have a calibration offset specified in output units,
> which contributes a lot of the complexity in here.
> Normally those are strictly front end (output of some calibration
> DAC). So if they have units (and often they don't) I'd expect them to
> be the same as _raw.
>=20
> We need to tidy up the docs on this though as it doesn't express
> any sort of preference.=C2=A0 It's hard to be specific as often the
> calibration scales are defined - they are just like tweaking a POT on
> an analog sensor board.
>=20
> A few trivial other things inline, including a suggestion to modify
> the layering of the driver a tiny bit during probe.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >=C2=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=C2=A0 |=C2=A0=C2=A0 =
4 +
> >=C2=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=C2=A0 | 600
> >++++++++++++++++++ 3 files changed, 610 insertions(+)
> >=C2=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro=
.c
> >=20
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600.h index
> > 14c8ef152418..c1023d59b37b 100644 ---
> > a/drivers/iio/imu/inv_icm42600/inv_icm42600.h +++
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600.h @@ -120,6 +120,8 @@
> > struct inv_icm42600_suspended {
> >=C2=A0=C2=A0 *=C2=A0 @orientation:=C2=A0=C2=A0=C2=A0 sensor chip orienta=
tion relative to main
> >hardware.
> >=C2=A0=C2=A0 *=C2=A0 @conf:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 chip sensors configurations.
> >=C2=A0=C2=A0 *=C2=A0 @suspended:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suspended sensors configuration.
> > + *=C2=A0 @indio_gyro:=C2=A0=C2=A0=C2=A0=C2=A0 gyroscope IIO device.
> > + *=C2=A0 @buffer:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data=
 transfer buffer aligned for DMA.
> >=C2=A0=C2=A0 */
> >=C2=A0 struct inv_icm42600_state {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock;
> > @@ -131,6 +133,8 @@ struct inv_icm42600_state {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_mount_matrix orien=
tation;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_conf conf;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_suspended=
 suspended;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_gyro;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t buffer[2] ____cacheline_aligned;
> >=C2=A0 };
> >=C2=A0=20
> >=C2=A0 /* Virtual register addresses: @bank on MSB (4 upper bits),
> >@address on LSB */
> > @@ -369,4 +373,6 @@ int inv_icm42600_debugfs_reg(struct iio_dev
> > *indio_dev, unsigned int reg,
> >=C2=A0 int inv_icm42600_core_probe(struct regmap *regmap, int chip,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 inv_icm42600_bus_setup bus_setup);
> >=C2=A0=20
> > +int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
> > +
> >=C2=A0 #endif
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c index
> > 81b171d6782c..dccb7bcc782e 100644 ---
> > a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c +++
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c @@ -510,6
> > +510,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int
> > chip,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_gyro_init(st);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* setup runtime power manage=
ment */
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_set_active=
(dev);
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c new file mode
> > 100644 index 000000000000..9d9672989b23
> > --- /dev/null
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> > @@ -0,0 +1,600 @@
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
> > +
> > +#include "inv_icm42600.h"
> > +
> > +#define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .type =3D IIO_ANGL_VEL,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .modified =3D 1,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .channel2 =3D _modifier,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_separate =3D
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_RAW) |
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_CALIB=
BIAS),
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_shared_by_type =3D
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE=
),
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_shared_by_type_available =3D
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE=
) |
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_CALIB=
BIAS),
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_shared_by_all =3D
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_=
FREQ),
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_shared_by_all_available =3D
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_=
FREQ),
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_index =3D _index,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_type =3D {
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sign =3D 's',
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .realbits =3D 16,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .storagebits =3D 16,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D IIO_BE,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 },
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .ext_info =3D _ext_info,
> > =C2=A0 \
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +enum inv_icm42600_gyro_scan {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_SCAN_X,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_SCAN_Y,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_SCAN_Z,
> > +};
> > +
> > +static const struct iio_chan_spec_ext_info
> > inv_icm42600_gyro_ext_infos[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL,
> > inv_icm42600_get_mount_matrix),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {},
> > +};
> > +
> > +static const struct iio_chan_spec inv_icm42600_gyro_channels[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_X, INV_ICM4260=
0_GYRO_SCAN_X,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inv_icm42600_gyro_ext_infos),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Y, INV_ICM4260=
0_GYRO_SCAN_Y,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inv_icm42600_gyro_ext_infos),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM4260=
0_GYRO_SCAN_Z,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 inv_icm42600_gyro_ext_infos),
> > +};
> > +
> > +static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state
> > *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct iio_chan_spec const
> > *chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int16_t *val)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D
> > INV_ICM42600_SENSOR_CONF_INIT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 __be16 *data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_ANGL_VEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (chan->channel2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_X:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_X;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Y:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_Y;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Z:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_GYRO_DATA_Z;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* enable gyro sensor */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_LOW_NO=
ISE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf,=
 NULL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto exit;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* read gyro register data */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 data =3D (__be16 *)&st->buffer[0];
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_read(st->map, reg, data, =
sizeof(*data));
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto exit;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D (int16_t)be16_to_cpup(data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (*val =3D=3D INV_ICM42600_DATA_INVALID)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D -EINVAL;
> > +exit:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +/* IIO format int + nano */
> > +static const int inv_icm42600_gyro_scale[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 2000dps =3D> 0.001065264 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_2000DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_2000DPS + 1] =3D 10=
65264,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 1000dps =3D> 0.000532632 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_1000DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_1000DPS + 1] =3D 53=
2632,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 500dps =3D> 0.000266316 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_500DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_500DPS + 1] =3D 266=
316,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 250dps =3D> 0.000133158 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_250DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_250DPS + 1] =3D 133=
158,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 125dps =3D> 0.000066579 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_125DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_125DPS + 1] =3D 665=
79,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 62.5dps =3D> 0.000033290 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_62_5DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_62_5DPS + 1] =3D 33=
290,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 31.25dps =3D> 0.000016645 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_31_25DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_31_25DPS + 1] =3D 1=
6645,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* +/- 15.625dps =3D> 0.000008322 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_15_625DPS] =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 [2 * INV_ICM42600_GYRO_FS_15_625DPS + 1] =3D =
8322,
> > +};
> > +
> > +static int inv_icm42600_gyro_read_scale(struct inv_icm42600_state
> > *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t *val, int *val2)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int idx;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 idx =3D st->conf.gyro.fs;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D inv_icm42600_gyro_scale[2 * idx];
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D inv_icm42600_gyro_scale[2 * idx + 1=
];
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT_PLUS_NANO;
> > +}
> > +
> > +static int inv_icm42600_gyro_write_scale(struct inv_icm42600_state
> > *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int val, int val2)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int idx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D
> > INV_ICM42600_SENSOR_CONF_INIT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42600=
_gyro_scale); idx
> > +=3D 2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (val =3D=3D inv_icm42600_gyro_scale[idx] &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 val2 =3D=3D inv_icm42600_gyro_scale[idx + 1])
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (idx >=3D ARRAY_SIZE(inv_icm42600_gyro_sca=
le))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 conf.fs =3D idx / 2;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf,=
 NULL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +/* IIO format int + micro */
> > +static const int inv_icm42600_gyro_odr[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 12.5Hz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 12, 500000,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 25Hz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 25, 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 50Hz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 50, 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 100Hz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 100, 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 200Hz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 200, 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 1kHz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 1000, 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 2kHz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 2000, 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 4kHz */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 4000, 0,
> > +};
> > +
> > +static const int inv_icm42600_gyro_odr_conv[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_12_5HZ,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_25HZ,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_50HZ,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_100HZ,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_200HZ,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_1KHZ_LN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_2KHZ_LN,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM42600_ODR_4KHZ_LN,
> > +};
> > +
> > +static int inv_icm42600_gyro_read_odr(struct inv_icm42600_state
> > *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int =
*val2)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 odr =3D st->conf.gyro.odr;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(inv_icm42600_gyr=
o_odr_conv); ++i) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (inv_icm42600_gyro_odr_conv[i] =3D=3D odr)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (i >=3D ARRAY_SIZE(inv_icm42600_gyro_odr_c=
onv))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D inv_icm42600_gyro_odr[2 * i];
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D inv_icm42600_gyro_odr[2 * i + 1];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int inv_icm42600_gyro_write_odr(struct inv_icm42600_state
> > *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val,=
 int val2)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int idx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_sensor_conf conf =3D
> > INV_ICM42600_SENSOR_CONF_INIT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 for (idx =3D 0; idx < ARRAY_SIZE(inv_icm42600=
_gyro_odr); idx +=3D
> > 2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (val =3D=3D inv_icm42600_gyro_odr[idx] &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 val2 =3D=3D inv_icm42600_gyro_odr[idx + 1])
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (idx >=3D ARRAY_SIZE(inv_icm42600_gyro_odr=
))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 conf.odr =3D inv_icm42600_gyro_odr_conv[idx /=
 2];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf,=
 NULL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(dev);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +/*
> > + * Calibration bias values, IIO range format int + nano.
> > + * Value is limited to +/-64dps coded on 12 bits signed. Step is
> > 1/32 dps.
> > + */
> > +static int inv_icm42600_gyro_calibbias[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 -1, 117010721,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* min: -1.117010721 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 0, 545415,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* step: 0.000545415 rad/s */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 1, 116465306,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* max: 1.116465306 rad/s */
> > +};
> > +
> > +static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state
> > *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct iio_chan_spec const
> > *chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int *val, int *val2)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t val64;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int32_t bias;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int16_t offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t data[2];
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_ANGL_VEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (chan->channel2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_X:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_OFFSET_USER0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Y:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_OFFSET_USER1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Z:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_OFFSET_USER3;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_read(st->map, reg, st->bu=
ffer,
> > sizeof(data));
> > +=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(data, st->buffer, sizeof(data));
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* 12 bits signed value */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (chan->channel2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_X:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 offset =3D sign_extend32(((data[1] & 0x0F) << 8) |
> > data[0], 11);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Y:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 offset =3D sign_extend32(((data[0] & 0xF0) << 4) |
> > data[1], 11);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Z:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 offset =3D sign_extend32(((data[1] & 0x0F) << 8) |
> > data[0], 11);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * convert raw offset to dps then to rad=
/s
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 12 bits signed raw max 64 to dps: 64 =
/ 2048
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dps to rad: Pi / 180
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * result in nano (1000000000)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (offset * 64 * Pi * 1000000000) / (20=
48 * 180)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val64 =3D (int64_t)offset * 64LL * 3141592653=
LL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* for rounding, add + or - divisor (2048 * 1=
80) divided by 2
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (val64 >=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val64 +=3D 2048 * 180 / 2;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val64 -=3D 2048 * 180 / 2;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 bias =3D div_s64(val64, 2048 * 180);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D bias / 1000000000L;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D bias % 1000000000L;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT_PLUS_NANO;
> > +}
> > +
> > +static int inv_icm42600_gyro_write_offset(struct
> > inv_icm42600_state *st,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct iio_chan_spec const
> > *chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 int val, int val2)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int64_t val64, min, max;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg, regval;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int16_t offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_ANGL_VEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (chan->channel2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_X:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_OFFSET_USER0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Y:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_OFFSET_USER1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Z:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 reg =3D INV_ICM42600_REG_OFFSET_USER3;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* inv_icm42600_gyro_calibbias: min - step - =
max in nano */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 min =3D (int64_t)inv_icm42600_gyro_calibbias[=
0] * 1000000000LL +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (int64_t)=
inv_icm42600_gyro_calibbias[1];
> > +=C2=A0=C2=A0=C2=A0=C2=A0 max =3D (int64_t)inv_icm42600_gyro_calibbias[=
4] * 1000000000LL +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (int64_t)=
inv_icm42600_gyro_calibbias[5];
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val64 =3D (int64_t)val * 1000000000LL + (int6=
4_t)val2;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (val64 < min || val64 > max)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * convert rad/s to dps then to raw value
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * rad to dps: 180 / Pi
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * dps to raw 12 bits signed, max 64: 20=
48 / 64
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * val in nano (1000000000)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * val * 180 * 2048 / (Pi * 1000000000 *=
 64)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 val64 =3D val64 * 180LL * 2048LL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* for rounding, add + or - divisor (31415926=
53 * 64) divided
> > by 2 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (val64 >=3D 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val64 +=3D 3141592653LL * 64LL / 2LL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 val64 -=3D 3141592653LL * 64LL / 2LL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D div64_s64(val64, 3141592653LL * 64=
LL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 /* clamp value limited to 12 bits signed */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (offset < -2048)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 offset =3D -2048;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 else if (offset > 2047)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 offset =3D 2047;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_get_sync(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&st->lock);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (chan->channel2) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_X:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* OFFSET_USER1 register is shared */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_read(st->map,
> > INV_ICM42600_REG_OFFSET_USER1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &regval);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->buffer[0] =3D offset & 0xFF;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->buffer[1] =3D (regval & 0xF0) | ((offset & 0xF00)
> > >> 8);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Y:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* OFFSET_USER1 register is shared */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_read(st->map,
> > INV_ICM42600_REG_OFFSET_USER1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &regval);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->buffer[0] =3D ((offset & 0xF00) >> 4) | (regval &
> > 0x0F);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->buffer[1] =3D offset & 0xFF;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_MOD_Z:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* OFFSET_USER4 register is shared */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D regmap_read(st->map,
> > INV_ICM42600_REG_OFFSET_USER4,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &regval);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->buffer[0] =3D offset & 0xFF;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 st->buffer[1] =3D (regval & 0xF0) | ((offset & 0xF00)
> > >> 8);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out_unlock;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_write(st->map, reg, st->b=
uffer, 2);
> > +
> > +out_unlock:
> > +=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&st->lock);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_put_autosuspend(dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +}
> > +
> > +static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_cha=
n_spec const
> > *chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int =
*val2, long mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D
> > iio_device_get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int16_t data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_ANGL_VEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (mask) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D iio_device_claim_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_gyro_read_sensor(st, chan, &data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_device_release_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *val =3D data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_VAL_INT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return inv_icm42600_gyro_read_scale(st, val, val2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SAMP_FREQ:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return inv_icm42600_gyro_read_odr(st, val, val2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_CALIBBIAS:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return inv_icm42600_gyro_read_offset(st, chan, val,
> > val2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +static int inv_icm42600_gyro_read_avail(struct iio_dev *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct iio_chan_spec const
> > *chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst int **vals,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t *type, int *length, long
> > mask) +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_ANGL_VEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (mask) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *vals =3D inv_icm42600_gyro_scale;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *type =3D IIO_VAL_INT_PLUS_NANO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *length =3D ARRAY_SIZE(inv_icm42600_gyro_scale);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_AVAIL_LIST;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SAMP_FREQ:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *vals =3D inv_icm42600_gyro_odr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *type =3D IIO_VAL_INT_PLUS_MICRO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *length =3D ARRAY_SIZE(inv_icm42600_gyro_odr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_AVAIL_LIST;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_CALIBBIAS:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *vals =3D inv_icm42600_gyro_calibbias;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *type =3D IIO_VAL_INT_PLUS_NANO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_AVAIL_RANGE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +static int inv_icm42600_gyro_write_raw(struct iio_dev *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct i=
io_chan_spec const
> > *chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val,=
 int val2, long mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct inv_icm42600_state *st =3D
> > iio_device_get_drvdata(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_ANGL_VEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (mask) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D iio_device_claim_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_gyro_write_scale(st, val, val2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_device_release_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SAMP_FREQ:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return inv_icm42600_gyro_write_odr(st, val, val2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_CALIBBIAS:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D iio_device_claim_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D inv_icm42600_gyro_write_offset(st, chan, val,
> > val2);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_device_release_direct_mode(indio_dev);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ret;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +static int inv_icm42600_gyro_write_raw_get_fmt(struct iio_dev
> > *indio_dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec
> > const *chan,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chan->type !=3D IIO_ANGL_VEL)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 switch (mask) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SCALE:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_VAL_INT_PLUS_NANO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SAMP_FREQ:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_VAL_INT_PLUS_MICRO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_CALIBBIAS:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return IIO_VAL_INT_PLUS_NANO;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +static const struct iio_info inv_icm42600_gyro_info =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .read_raw =3D inv_icm42600_gyro_read_raw,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .read_avail =3D inv_icm42600_gyro_read_avail,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw =3D inv_icm42600_gyro_write_raw,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .write_raw_get_fmt =3D inv_icm42600_gyro_writ=
e_raw_get_fmt,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 .debugfs_reg_access =3D inv_icm42600_debugfs_=
reg,
> > +};
> > +
> > +int inv_icm42600_gyro_init(struct inv_icm42600_state *st) =20
>=20
> This feels like the layering would be clearer if this
> returned the struct iio_dev * and the assignment happened in the
> core driver.
>=20
> Then state parameter can be const and it'll be obvious it has
> no side effects on the state structure.
>=20
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(st->=
map);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 const char *name;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-=
gyro", st->name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!name)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENOMEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev =3D devm_iio_device_alloc(dev, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!indio_dev)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -ENOMEM;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_set_drvdata(indio_dev, st);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->dev.parent =3D dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->name =3D name;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->info =3D &inv_icm42600_gyro_info;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D inv_icm42600_gyro_cha=
nnels;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D
> > ARRAY_SIZE(inv_icm42600_gyro_channels); +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 st->indio_gyro =3D indio_dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_device_register(dev, st->indi=
o_gyro);
> > +} =20

