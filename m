Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C626C19F475
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 13:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDFLUO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 07:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgDFLUN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 07:20:13 -0400
Received: from lore-desk-wlan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C070206F5;
        Mon,  6 Apr 2020 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586172013;
        bh=fGQhadMhJmDGDppfU2HYv0Smkyp/qbALVqGc9UmyZ/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyewfDpXxas+6yH4QfyQ2ilkzTp2SLQ96NhSk6tY2ETE/2klp5/oBU9If+TIcEeap
         /dkHBh9s/sbLVIirBkUA2wL0MBL890l2L6Bvy+QQ97UgzZerON1/3H5XpxOdlR5nCr
         2d3senMW6xuSv/Ppe0UQO0/EA6LpKf3sm41PfTF4=
Date:   Mon, 6 Apr 2020 13:20:06 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        lorenzo.bianconi@redhat.com,
        Jimmy Assarsson <jimmyassarsson@gmail.com>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: drop huge include in sensor-hub
 driver
Message-ID: <20200406112006.GA5890@lore-desk-wlan>
References: <8593125b207045797adb9406aa2d3d2f43c30153.1586170271.git.lorenzo@kernel.org>
 <CAHp75VcqZ_VDD69wToo6LQqsawkEA_oPFQanSoFOT1gSgOrXZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <CAHp75VcqZ_VDD69wToo6LQqsawkEA_oPFQanSoFOT1gSgOrXZQ@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 6, 2020 at 1:52 PM Lorenzo Bianconi <lorenzo@kernel.org> wrot=
e:
> >
> > st_sensors.h contains common stm sensor definitions but in
>=20
> > st_lsm6dsx_shub driver it is used just to introduce the default
>=20
> Still doesn't fully clear why only this part of the st_lsm6dsx is not
> okay with the header.
> You need to explain that common/st_sensors is for separate ST sensor
> drivers, while LSM6DSx is a driver for certain IMU which *does not*
> use ST common infrastructure.

I guess it is pretty simple and evident: we did not use it at all before
the LISM3DL commit and at moment we need it just for ST_SENSORS_DEFAULT_WAI=
_ADDRESS
definition. It is better to hard code the value directly.

>=20
> > wai address for LIS3MDL sensor.
> > Drop this largely unconnected include and introduce the default wai
> > address in st_lsm6dsx_ext_dev_settings register map
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes since v1:
> > - improve commit message
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index 280925dd8edb..947ca3a7dcaf 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -28,7 +28,6 @@
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/bitfield.h>
> >
> > -#include <linux/iio/common/st_sensors.h>
> >  #include "st_lsm6dsx.h"
> >
> >  #define ST_LSM6DSX_SLV_ADDR(n, base)           ((base) + (n) * 3)
> > @@ -93,7 +92,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_ls=
m6dsx_ext_dev_table[] =3D {
> >         {
> >                 .i2c_addr =3D { 0x1e },
> >                 .wai =3D {
> > -                       .addr =3D ST_SENSORS_DEFAULT_WAI_ADDRESS,
> > +                       .addr =3D 0x0f,
> >                         .val =3D 0x3d,
> >                 },
> >                 .id =3D ST_LSM6DSX_ID_MAGN,
> > --
> > 2.25.1
> >
>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXosQZAAKCRA6cBh0uS2t
rPMpAQDwpRrjJv0tPuO/gkm5Y2jDJFFL/pQzaBeTerEAJ/VwBQEAzkpRWi5jUuTH
JgImPowL/5WQ5Vh9PTDzzFXr1RP4sAs=
=SoO5
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
