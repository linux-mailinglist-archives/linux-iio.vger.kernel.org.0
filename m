Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9012D975AD
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 11:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfHUJJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Aug 2019 05:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfHUJJF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Aug 2019 05:09:05 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317F422DA7;
        Wed, 21 Aug 2019 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566378544;
        bh=hDaAZ9xHf7qqtmPVQR5FTy7Bni6GFVqIfLICzjW/uJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=acehRPzUVYFoIQBm84kYSWucAIFsnLUDDoNok+YqzqYKVKhwDzXjoXa+XqfgroU/3
         snma3LQz1Nh7k0qkQy/s1L/+dnYbvkkcJ76UAflQFPZbsrqw10VJEHcVlf/xvkXY5+
         6GJ/o3i2eYW9GIQ06hp5o76ldaoNL0J/ZaGSZKqY=
Date:   Wed, 21 Aug 2019 11:08:58 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
Message-ID: <20190821090858.GC13516@localhost.localdomain>
References: <20190813073533.8007-1-martin.kepplinger@puri.sm>
 <20190813073533.8007-3-martin.kepplinger@puri.sm>
 <20190819094845.GB17835@localhost.localdomain>
 <6c739681-d46e-b4f7-9831-bdf1e9bcd540@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <6c739681-d46e-b4f7-9831-bdf1e9bcd540@puri.sm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (se=
parately
> >> supported in iio/magnetometer/st_magn*) are located on a separate i2c =
addresses
> >> on the bus.
> >>
> >> For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9ds=
1.pdf
> >>
> >> Treat it just like the LSM6* devices and, despite it's name, hook it up
> >> to the st_lsm6dsx driver, using it's basic functionality.
> >>
> >> accelerometer and gyroscope are not independently clocked. It runs at =
the gyro
> >> frequencies if both are enabled, see chapter 7.12 of the datasheet.
> >> We could have handled this as a single IIO device but we have split
> >> it up to be more consistent with the other more flexible devices.
> >>
> >> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> >=20
> > Hi Martin,
> >=20
> > most of comments are nitpicks (inline), the only issue I can see here i=
s we can enable
> > hw fifo for lsm6ds0/lsm9ds1 and read_fifo routine pointer is not curren=
tly
> > initialized so we will end up with a NULL pointer dereference. Since we=
 will
> > need a different update FIFO routine for lsm6ds0/lsm9ds1 I am adding an
> > update_fifo function pointer in fifo_ops in order to fix this issue.
> >=20
> > Regards,
> > Lorenzo
> >=20
> >> ---

[...]

> >=20
> > should be called 'lsm9ds1_imu' since lsm9ds1 is a 9-axis device? what d=
o you
> > think?
> >=20
> >> =20
> >>  enum st_lsm6dsx_hw_id {
> >>  	ST_LSM6DS3_ID,
> >> @@ -37,6 +38,7 @@ enum st_lsm6dsx_hw_id {
> >>  	ST_LSM6DSR_ID,
> >>  	ST_LSM6DS3TRC_ID,
> >>  	ST_ISM330DHCX_ID,
> >> +	ST_LSM9DS1_ID,
> >=20
> > same here..ST_LSM9DS1_IMU_ID
>=20
> I wouldn't add "imu" to the actual part name, see below...
>=20
> >=20
> >>  	ST_LSM6DSX_MAX_ID,
> >>  };
> >> =20

[...]

> >> +};
> >> +
> >=20
> > why not st_lsm6ds0_gyro_channels?
>=20
> Would be ok with me. I'll remember this if I do a new iteration.
>=20
> >=20

[...]

> >> index 15c6aa5b6caa..2f1b30ff083b 100644
> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> >> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_=
match[] =3D {
> >>  		.compatible =3D "st,ism330dhcx",
> >>  		.data =3D (void *)ST_ISM330DHCX_ID,
> >>  	},
> >> +	{
> >> +		.compatible =3D "st,lsm9ds1",
> >=20
> > same here, what is the right compatible string? "st,lsm9ds1 or
> > "st,lsm9ds1_imu"?
>=20
> well, I'm open for this change, but "imu" doesn't really mean much
> technically, so I would stick with the device name. "imu" is not part of
> the "part" name...
>=20

I have not a strong opinion on it but IMU means 'Inertial Measurement Unit'=
 and
it used to indicate a device that runs a combination of accelerometer and
gyroscope. I think using LSM9DS1 as device name it is weird since I would
expect even the magn in this case (all supported devices by st_lsm6dsx are =
just
IMU). I am not sure if "st,lsm9ds1_imu" is the right compatible string but I
would indicate this node does not run a magn device.

@Jonathan: what do you think?

Regards,
Lorenzo

> >=20
> >> +		.data =3D (void *)ST_LSM9DS1_ID,
> >> +	},
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> >> @@ -99,6 +103,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id=
_table[] =3D {
> >>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> >>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> >>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> >> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> >> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> >> index a8430ee11310..421ce704f346 100644
> >> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> >> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> >> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_=
match[] =3D {
> >>  		.compatible =3D "st,ism330dhcx",
> >>  		.data =3D (void *)ST_ISM330DHCX_ID,
> >>  	},
> >> +	{
> >> +		.compatible =3D "st,lsm9ds1",
> >> +		.data =3D (void *)ST_LSM9DS1_ID,
> >> +	},
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> >> @@ -99,6 +103,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id=
_table[] =3D {
> >>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> >>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> >>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> >> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
> >> --=20
> >> 2.20.1
> >>
>=20

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXV0KJwAKCRA6cBh0uS2t
rKi/AP9cwBGDlhI0BhmnTs8UumYUGi28HsylkDfMBVcjg+VbdwEAmwwyCgwL+bj+
60MK3unYa5T02cuYvsQ8kguN7tXU6Qc=
=Rcl6
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
