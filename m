Return-Path: <linux-iio+bounces-1970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C083F502
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811CC2829E8
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jan 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77A1DDC5;
	Sun, 28 Jan 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvoNkCfr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0A1805E;
	Sun, 28 Jan 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438306; cv=none; b=A7MMY9HH0OM6gSs+bQhD6cwvI8pMtFSeH0dpvSl01pZVQtXi8ZivI2OAsEPj0l+uWconC08i4tr2S7ikdnUYVAe9OVQT5gLevLlg2ntgnY7GuZfSs0CBIbwFex9nKYR7lZui7nl/+AX9xsdUZo/iUv5FXSYGx8isDB8ovj+tGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438306; c=relaxed/simple;
	bh=XqKgliSvXDKPITcMaa3PJu3i7PhsBr24bTo+nC1CuCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJjK6ItfvlAR7yYIWJP79Ww0Yo95z2cEQQO9lkYkquh7Z1ilWL1BgYvkdLOHGKJdXevEdW5m8YjxZDGhv5sb9pabzsRkT9UzC+3O4cp29SUrZ3HSyLd+LbipwWI6LNXcIYqrG+YO/szmAMWRBzbEeVnQWv/qtlSulpcmhyuq+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvoNkCfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD80AC433C7;
	Sun, 28 Jan 2024 10:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706438306;
	bh=XqKgliSvXDKPITcMaa3PJu3i7PhsBr24bTo+nC1CuCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvoNkCfr6jczH+cKaZmDxYUxCCyv+jKaV+126ezJFt/D6Don8PihLEIaNfyz+mqmR
	 Jkzwf6UPUfe1c6VTjWTxUFz8B+ShpqLUBYoi2X+0ujUI2CtQ5mHUWoa598vqSlJpJO
	 yvmYp6BgakHmKaItmj1ruZ3oSF1BL2jSgjhioxMNG2j+BvCQMpTEIhQLq+0rpB6AMH
	 8Fe4Cz5v6LkIYPTwTXwlrirlKrFjCXho1kr3vKSpFs1himU9/L/pmWAlwCdZRwTO6b
	 jcBNohANIOS6w/Srq/EJcJx3SmgTE80OZ3vQ+r00Nv4aSW89QmjzRt+85n8fW0j8+u
	 puKHHaVhA38UQ==
Date: Sun, 28 Jan 2024 11:38:22 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
	devicetree@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add support to ASM330LHHXG1
Message-ID: <ZbYungPhhzx2xREi@lore-desk>
References: <cover.1706093274.git.lorenzo@kernel.org>
 <eda2aac7da048e4ef1e1ea659ed4993f424ac810.1706093274.git.lorenzo@kernel.org>
 <20240127150029.1a9b49b2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yS6MFG0ib1zDYRxx"
Content-Disposition: inline
In-Reply-To: <20240127150029.1a9b49b2@jic23-huawei>


--yS6MFG0ib1zDYRxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 24 Jan 2024 11:52:33 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Add support to STM ASM330LHHXG1 (accelerometer and gyroscope) Mems
> > sensor.
> > The ASM330LHHXG1 sensor can use ASM330LHHX as fallback device since it
> > implements all the ASM330LHHXG1 features currently implemented in
> > st_lsm6dsx.
> >=20
> > Link: https://www.st.com/resource/en/datasheet/asm330lhhxg1.pdf
> Datasheet:
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo.
>=20
> A few comments inline.  Mostly about make it less noisy to
> add additional devices in future.
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/Kconfig            |  4 +-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 48 ++++++++++---------
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  2 +-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |  5 ++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  5 ++
> >  6 files changed, 43 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_ls=
m6dsx/Kconfig
> > index 5865a295a4df..645039edd606 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> > +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> > @@ -14,8 +14,8 @@ config IIO_ST_LSM6DSX
> >  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> >  	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, asm330lhhx, lsm6dsr,
> >  	  lsm6ds3tr-c, ism330dhcx, lsm6dsrx, lsm6ds0, lsm6dsop, lsm6dstx,
> > -	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, lsm6dst
> > -	  and the accelerometer/gyroscope of lsm9ds1.
> > +	  lsm6dsv, lsm6dsv16x, lsm6dso16is, ism330is, asm330lhb, asm330lhhxg1,
> > +	  lsm6dst and the accelerometer/gyroscope of lsm9ds1.
>=20
> I think it is worth a precursor to reformat this into a one entry per line
> list so that changes become less noisy (and easier to deal with merge con=
flicts)
> There are some examples of lists in drivers/hid/Kconfig and they look
> find in menuconfig etc.
>=20
> If I were not requesting other changes I'd have suggested this as a follo=
w up
> patch but given you are going to be respinning again, it would be neater
> as a precursor!

ack, I will fix it in v2.

>=20
>=20
> > =20
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called st_lsm6dsx.
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index c19237717e81..78d12d3c2759 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -15,29 +15,30 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/regulator/consumer.h>
> > =20
> > -#define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
> > -#define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> > -#define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
> > -#define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
> > -#define ST_ISM330DLC_DEV_NAME	"ism330dlc"
> > -#define ST_LSM6DSO_DEV_NAME	"lsm6dso"
> > -#define ST_ASM330LHH_DEV_NAME	"asm330lhh"
> > -#define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
> > -#define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
> > -#define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
> > -#define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
> > -#define ST_LSM9DS1_DEV_NAME	"lsm9ds1-imu"
> > -#define ST_LSM6DS0_DEV_NAME	"lsm6ds0"
> > -#define ST_LSM6DSRX_DEV_NAME	"lsm6dsrx"
> > -#define ST_LSM6DST_DEV_NAME	"lsm6dst"
> > -#define ST_LSM6DSOP_DEV_NAME	"lsm6dsop"
> > -#define ST_ASM330LHHX_DEV_NAME	"asm330lhhx"
> > -#define ST_LSM6DSTX_DEV_NAME	"lsm6dstx"
> > -#define ST_LSM6DSV_DEV_NAME	"lsm6dsv"
> > -#define ST_LSM6DSV16X_DEV_NAME	"lsm6dsv16x"
> > -#define ST_LSM6DSO16IS_DEV_NAME	"lsm6dso16is"
> > -#define ST_ISM330IS_DEV_NAME	"ism330is"
> > -#define ST_ASM330LHB_DEV_NAME	"asm330lhb"
> > +#define ST_LSM6DS3_DEV_NAME		"lsm6ds3"
> > +#define ST_LSM6DS3H_DEV_NAME		"lsm6ds3h"
> > +#define ST_LSM6DSL_DEV_NAME		"lsm6dsl"
> > +#define ST_LSM6DSM_DEV_NAME		"lsm6dsm"
> > +#define ST_ISM330DLC_DEV_NAME		"ism330dlc"
> > +#define ST_LSM6DSO_DEV_NAME		"lsm6dso"
> > +#define ST_ASM330LHH_DEV_NAME		"asm330lhh"
> > +#define ST_LSM6DSOX_DEV_NAME		"lsm6dsox"
> > +#define ST_LSM6DSR_DEV_NAME		"lsm6dsr"
> > +#define ST_LSM6DS3TRC_DEV_NAME		"lsm6ds3tr-c"
> > +#define ST_ISM330DHCX_DEV_NAME		"ism330dhcx"
> > +#define ST_LSM9DS1_DEV_NAME		"lsm9ds1-imu"
> > +#define ST_LSM6DS0_DEV_NAME		"lsm6ds0"
> > +#define ST_LSM6DSRX_DEV_NAME		"lsm6dsrx"
> > +#define ST_LSM6DST_DEV_NAME		"lsm6dst"
> > +#define ST_LSM6DSOP_DEV_NAME		"lsm6dsop"
> > +#define ST_ASM330LHHX_DEV_NAME		"asm330lhhx"
> > +#define ST_LSM6DSTX_DEV_NAME		"lsm6dstx"
> > +#define ST_LSM6DSV_DEV_NAME		"lsm6dsv"
> > +#define ST_LSM6DSV16X_DEV_NAME		"lsm6dsv16x"
> > +#define ST_LSM6DSO16IS_DEV_NAME		"lsm6dso16is"
> > +#define ST_ISM330IS_DEV_NAME		"ism330is"
> > +#define ST_ASM330LHB_DEV_NAME		"asm330lhb"
> > +#define ST_ASM330LHHXG1_DEV_NAME	"asm330lhhxg1"
>=20
> Too much noise. I don't care if they are all aligned the same.
> If you really want to do this, break it out to a precursor patch.
> I'd just have one entry with a different indent :)

ack, I will fix it in v2.
>=20
>=20
> > =20
> >  enum st_lsm6dsx_hw_id {
> >  	ST_LSM6DS3_ID =3D 1,
> > @@ -63,6 +64,7 @@ enum st_lsm6dsx_hw_id {
> >  	ST_LSM6DSO16IS_ID,
> >  	ST_ISM330IS_ID,
> >  	ST_ASM330LHB_ID,
> > +	ST_ASM330LHHXG1_ID,
> >  	ST_LSM6DSX_MAX_ID,
> >  };
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 066fe561c5e8..5d9539822ec6 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -15,7 +15,7 @@
> >   * value of the decimation factor and ODR set for each FIFO data set.
> >   *
> >   * LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/LSM6DSRX/ISM330DHCX/
> > - * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB:
> > + * LSM6DST/LSM6DSOP/LSM6DSTX/LSM6DSV/ASM330LHB/ASM330LHHXG1:
>=20
> A list here as well would help.

ack, I will fix it in v2.

>=20
> >   * The FIFO buffer can be configured to store data from gyroscope and
> >   * accelerometer. Each sample is queued with a tag (1B) indicating data
> >   * source (gyroscope, accelerometer, hw timer).
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index b6e6b1df8a61..27ecf2a5d0bc 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -27,7 +27,7 @@
> >   *   - FIFO size: 4KB
> >   *
> >   * - LSM6DSO/LSM6DSOX/ASM330LHH/ASM330LHHX/LSM6DSR/ISM330DHCX/LSM6DST/=
LSM6DSOP/
> > - *   LSM6DSTX/LSM6DSO16IS/ISM330IS:
> > + *   LSM6DSTX/LSM6DSO16IS/ISM330IS/ASM330LHHXG1:
>=20
> Another place where reformatting as a list would make adding new entries =
less noisy
> + whilst doing that, please fix the ordering to be alphabetical.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> >   *   - Accelerometer/Gyroscope supported ODR [Hz]: 12.5, 26, 52, 104, =
208, 416,
> >   *     833
> >   *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> > @@ -820,6 +820,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.hw_id =3D ST_ASM330LHHX_ID,
> >  				.name =3D ST_ASM330LHHX_DEV_NAME,
> >  				.wai =3D 0x6b,
> > +			}, {
> > +				.hw_id =3D ST_ASM330LHHXG1_ID,
> > +				.name =3D ST_ASM330LHHXG1_DEV_NAME,
> > +				.wai =3D 0x6b,
> >  			}, {
> >  				.hw_id =3D ST_LSM6DSTX_ID,
> >  				.name =3D ST_LSM6DSTX_DEV_NAME,
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > index 911444ec57c0..cddf41cc0ca9 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > @@ -134,6 +134,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of=
_match[] =3D {
> >  		.compatible =3D "st,asm330lhb",
> >  		.data =3D (void *)ST_ASM330LHB_ID,
> >  	},
> > +	{
> > +		.compatible =3D "st,asm330lhhxg1",
> > +		.data =3D (void *)ST_ASM330LHHXG1_ID,
> > +	},
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> > @@ -168,6 +172,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id=
_table[] =3D {
> >  	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
> >  	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
> >  	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
> > +	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > index f56c170c41a9..c122c8831365 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > @@ -129,6 +129,10 @@ static const struct of_device_id st_lsm6dsx_spi_of=
_match[] =3D {
> >  		.compatible =3D "st,asm330lhb",
> >  		.data =3D (void *)ST_ASM330LHB_ID,
> >  	},
> > +	{
> > +		.compatible =3D "st,asm330lhhxg1",
> > +		.data =3D (void *)ST_ASM330LHHXG1_ID,
> > +	},
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> > @@ -157,6 +161,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id=
_table[] =3D {
> >  	{ ST_LSM6DSO16IS_DEV_NAME, ST_LSM6DSO16IS_ID },
> >  	{ ST_ISM330IS_DEV_NAME, ST_ISM330IS_ID },
> >  	{ ST_ASM330LHB_DEV_NAME, ST_ASM330LHB_ID },
> > +	{ ST_ASM330LHHXG1_DEV_NAME, ST_ASM330LHHXG1_ID },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>=20

--yS6MFG0ib1zDYRxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZbYungAKCRA6cBh0uS2t
rLpgAQDqDdy3smktHV76+7TlL/lTpHMajj6sZ7RwDNyWJ5/g+AEAqK7YndY+JAAg
llmjHSVlYEL8OQIaZ/zPg/Rly1TAfgo=
=I9Yb
-----END PGP SIGNATURE-----

--yS6MFG0ib1zDYRxx--

