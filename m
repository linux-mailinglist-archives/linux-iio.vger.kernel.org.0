Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD74A6CB5
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 09:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbiBBIJm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 03:09:42 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54773 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbiBBIJl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 03:09:41 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E44D2C000B;
        Wed,  2 Feb 2022 08:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643789378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlfikBSEBHkH6aEfnCqxCDO10QCW/ujic2cPoQq74M4=;
        b=O73605ktAGomK8EYdkubVbRKqvbmkYV6RoGiscqvOOZSIKhFk40jp4STv1Muf5/pmuJSRJ
        ep/pj68ZfgXkcpD8h34Ee3nAGKDoYaXKNWjQvYceQBQsWV3+LCxei9OO1EkODkTUKXj5Xl
        3W9J8N5Je6vnjk6d+xW4aSd9B7aC7oSQoHm1FtBHk4y/tQXXGXVTI5S5CqOwp3hqRqT58V
        HV40kDG/FWlYZyJ+PxSyom7MM2m4wbo02ruToKhYV5Nvrr50nYPvx9NNED66Npi2asJi40
        vw63cDaZ9xQ5TfMQKCuFZ8vQ9pqTxQYjjuCsMum5HKRaqzY+taVyv01TUtXQOQ==
Date:   Wed, 2 Feb 2022 09:09:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 09/10] iio: core: Simplify the registration of kfifo
 buffers
Message-ID: <20220202090936.3621d0eb@xps13>
In-Reply-To: <20220115171246.59915cd2@jic23-huawei>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-10-miquel.raynal@bootlin.com>
        <CA+U=Dsoi2jPgqrqmbdq7GBknUiR9Y30t_tDQQo3ps3M2EmdsFw@mail.gmail.com>
        <20220115171246.59915cd2@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 15 Jan 2022 17:12:46 +0000:

> On Thu, 16 Dec 2021 09:52:38 +0200
> Alexandru Ardelean <ardeleanalex@gmail.com> wrote:
>=20
> > On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote: =20
> > >
> > > Among all the users of the kfifo buffers, no one uses the
> > > INDIO_BUFFER_HARDWARE mode. So let's take this as a general rule and
> > > simplify a little bit the internals - overall the documentation - by
> > > eliminating unused specific cases. Use the INDIO_BUFFER_SOFTWARE mode=
 by
> > > default with kfifo buffers, which will basically mimic what all the "=
non
> > > direct" modes do.
> > >   =20
> >=20
> > I think this patch here (and 10/10) can be part of a separate series.
> > This discussion is important enough to have it's own series.
> > It's a bit of an API discussion.
> > =20
> One question inline.
> =20
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/iio/accel/fxls8962af-core.c                  |  1 -
> > >  drivers/iio/accel/sca3000.c                          |  1 -
> > >  drivers/iio/accel/ssp_accel_sensor.c                 |  1 -
> > >  drivers/iio/adc/ina2xx-adc.c                         |  1 -
> > >  drivers/iio/adc/ti_am335x_adc.c                      |  4 +---
> > >  drivers/iio/buffer/kfifo_buf.c                       | 12 ++--------=
--
> > >  .../common/cros_ec_sensors/cros_ec_sensors_core.c    |  3 +--
> > >  drivers/iio/common/scmi_sensors/scmi_iio.c           |  1 -
> > >  drivers/iio/gyro/ssp_gyro_sensor.c                   |  1 -
> > >  drivers/iio/health/max30100.c                        |  1 -
> > >  drivers/iio/health/max30102.c                        |  1 -
> > >  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c    |  1 -
> > >  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c     |  1 -
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c       |  1 -
> > >  drivers/iio/light/apds9960.c                         |  1 -
> > >  drivers/staging/iio/impedance-analyzer/ad5933.c      |  1 -
> > >  include/linux/iio/kfifo_buf.h                        |  5 ++---
> > >  17 files changed, 6 insertions(+), 31 deletions(-)

[...]

> > > --- a/drivers/iio/adc/ti_am335x_adc.c
> > > +++ b/drivers/iio/adc/ti_am335x_adc.c
> > > @@ -376,9 +376,7 @@ static int tiadc_iio_buffered_hardware_setup(stru=
ct device *dev,
> > >  {
> > >         int ret;
> > >
> > > -       ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev,
> > > -                                         INDIO_BUFFER_SOFTWARE,
> > > -                                         setup_ops);
> > > +       ret =3D devm_iio_kfifo_buffer_setup(dev, indio_dev, setup_ops=
);
> > >         if (ret)
> > >                 return ret;
> > >
> > > diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfif=
o_buf.c
> > > index 416d35a61ae2..f17473e06ee8 100644
> > > --- a/drivers/iio/buffer/kfifo_buf.c
> > > +++ b/drivers/iio/buffer/kfifo_buf.c
> > > @@ -197,7 +197,7 @@ static const struct iio_buffer_access_funcs kfifo=
_access_funcs =3D {
> > >         .set_length =3D &iio_set_length_kfifo,
> > >         .release =3D &iio_kfifo_buffer_release,
> > >
> > > -       .modes =3D INDIO_BUFFER_SOFTWARE | INDIO_BUFFER_TRIGGERED,
> > > +       .modes =3D INDIO_BUFFER_SOFTWARE, =20
>=20
> Why is this safe to do?  Don't we need triggered buffers to match mode
> when used with a kfifo?
>=20
> If I'm remembering / reading how the mode matching works, this breaks the
> industrialio-triggered-buffer.c case where it sets the mode to
> INDIO_BUFFER_TRIGGERED (mostly I think to make sure we get a warning in
> iio_verify_update() if no trigger is supplied - I can't remember what oth=
er
> difference it makes (or if it does).

Mmmh that's right, I overlooked that part. Indeed we still need to
support the INDIO_BUFFER_TRIGGERED mode in the kfifo_access_funcs
modes.

Do you think the rest of the patch is still legit? I believe it stills
simplifies the logic for the user but if you disagree I'll drop it off
entirely.

Thanks,
Miqu=C3=A8l
