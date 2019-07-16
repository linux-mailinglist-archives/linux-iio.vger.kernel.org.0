Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC56A239
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 08:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfGPGYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 02:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730300AbfGPGYH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 02:24:07 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC8420880;
        Tue, 16 Jul 2019 06:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563258245;
        bh=u5wNVmTMWjA6/sAGliqPDwCvMWMhnxcmUl7qib4rwOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW2BttD6/OWGOkB/13J/O7S4+kfHB6yB4TNboDHNfQzEBrRXqZI1NFOS+E6xJsIDa
         cnfFq1k3HqG6p+MJdYCnGX8v81CirGEPHzUvjc2N5lf6qd0CleOmNO9FGpk2iWbTRA
         /KZQ3lcJQ/W9weo5L4dys90Akd7as0JOsXcVikJI=
Date:   Tue, 16 Jul 2019 08:24:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jic23@kernel.org, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: inline acc/gyro output regs
Message-ID: <20190716062400.GF23126@localhost.localdomain>
References: <cover.1563226641.git.lorenzo@kernel.org>
 <ee4a6be25cc7cf59d90de1b8a463d5908b282ebe.1563226641.git.lorenzo@kernel.org>
 <7d42aba0-c98c-5ffb-2a1d-473ad5607ad5@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <7d42aba0-c98c-5ffb-2a1d-473ad5607ad5@puri.sm>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 15.07.19 23:42, Lorenzo Bianconi wrote:
> > Remove output register definitions and inline register values since
> > they are used only for iio channel definitions. This is a preliminary
> > patch to add support for LSM9DS1 sensor to st_lsm6dsx driver
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 26 +++++---------------
> >  1 file changed, 6 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 9aa109428a52..0abd5b85b398 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -61,14 +61,6 @@
> >  #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
> >  #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
> > =20
> > -#define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR		0x28
> > -#define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR		0x2a
> > -#define ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR		0x2c
> > -
> > -#define ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR	0x22
> > -#define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
> > -#define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> > -
> >  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] =
=3D {
> >  	{
> >  		.wai =3D 0x69,
> > @@ -701,22 +693,16 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  };
> > =20
> >  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
> > -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR,
> > -			   IIO_MOD_X, 0),
> > -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR,
> > -			   IIO_MOD_Y, 1),
> > -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR,
> > -			   IIO_MOD_Z, 2),
> > +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> > +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> > +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
> >  	IIO_CHAN_SOFT_TIMESTAMP(3),
> >  };
> > =20
> >  static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] =3D {
> > -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR,
> > -			   IIO_MOD_X, 0),
> > -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR,
> > -			   IIO_MOD_Y, 1),
> > -	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR,
> > -			   IIO_MOD_Z, 2),
> > +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
> > +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
> > +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x26, IIO_MOD_Z, 2),
> >  	IIO_CHAN_SOFT_TIMESTAMP(3),
> >  };
> > =20
> >=20
>=20
> The definitions don't hurt, even if only used once, or do they?
>=20
> thanks,

we can avoid multiple definitions in this way

Lorenzo

>                              martin
>=20

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS1tfgAKCRA6cBh0uS2t
rDFlAQDVrkl5c3VXTik4R9yaQ3+AqKKVlsCvsH9RIT4Sf96zNAD/TrwOHSJXUfBK
QaaznjyR9sf+bS/0oDD8mV+FyD4/eQA=
=QHXx
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
