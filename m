Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD169E8E
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2019 23:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfGOVt1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Jul 2019 17:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbfGOVt1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Jul 2019 17:49:27 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6692086C;
        Mon, 15 Jul 2019 21:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563227365;
        bh=8Fj6fQ+IHvyEjrlhShFe5T2apErAkOW1vs46drBaWHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIdl59B/s+/j1G0oxywBB4yA+BuzRTIpbT83oUviQgfDp22yygtKWEzZS7ytjQxmJ
         R4/mY41n1WfVu9PJS+rjdSm/Yfh1gferMGDzQmhvw2MYJjsF/SZ34PJcqGMKtYkMMk
         cukKj8o+gNcPwRkOTx8Z4pc9DeabWEi+Cb/H2kL8=
Date:   Mon, 15 Jul 2019 23:49:20 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
Message-ID: <20190715214920.GB23126@localhost.localdomain>
References: <20190715131919.31938-1-martin.kepplinger@puri.sm>
 <20190715131919.31938-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20190715131919.31938-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The LSM9DS1's accelerometer / gyroscope unit and it's magnetometer (separ=
ately
> supported in iio/magnetometer/st_magn*) are located on a separate i2c add=
resses
> on the bus.
>=20
> For the datasheet, see https://www.st.com/resource/en/datasheet/lsm9ds1.p=
df
>=20
> Treat it just like the LSM6* devices and, despite it's name, hook it up
> to the st_lsm6dsx driver, using it's basic functionality.
>=20
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>=20
> What do you think about an addition like this? How confusing is it to sup=
port
> an LSM9 module by the lsm6 driver, despite it's name? It requires almost =
no
> code, so why not think about it, right?

I am fine with (it was on my ToDo list, so thanks for working on this).
I have just posted the following series that will help you adding support f=
or
LSM9DS1
https://patchwork.kernel.org/cover/11045061/
I think you just need to take care of gyro channels allocating iio devices =
(you
probably need to pass hw_id to st_lsm6dsx_alloc_iiodev())

>=20
> Oh, I'm not 100% convinced by my new "if" in probe(), but even that is
> not too confusing I guess.
>=20
> thanks,
>=20
>                            martin
>=20
> p.s.: todos:
> * hook up the fifo / buffer / trigger functionality,
> * (off-topic a bit) move the (currently strange) gyro-only support
>   for lsm9ds0 to this driver as well.

Regarding FIFO I guess it is enough to set decimator factor to 1 for both a=
ccel
and gyro.

Regards,
Lorenzo

>=20
>=20
>=20
>  drivers/iio/imu/st_lsm6dsx/Kconfig           |   3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   4 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 105 ++++++++++++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |   5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |   5 +
>  5 files changed, 117 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6=
dsx/Kconfig
> index 002a423eae52..0b5a568e4c16 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -10,7 +10,8 @@ config IIO_ST_LSM6DSX
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> -	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr
> +	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr and the
> +	  accelerometer/gyroscope of lsm9ds1.
> =20
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index f072ac14f213..8af9641260fa 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -22,6 +22,7 @@
>  #define ST_ASM330LHH_DEV_NAME	"asm330lhh"
>  #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"
> =20
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -33,6 +34,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_ASM330LHH_ID,
>  	ST_LSM6DSOX_ID,
>  	ST_LSM6DSR_ID,
> +	ST_LSM9DS1_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
> =20
> @@ -230,6 +232,8 @@ enum st_lsm6dsx_sensor_id {
>  	ST_LSM6DSX_ID_EXT0,
>  	ST_LSM6DSX_ID_EXT1,
>  	ST_LSM6DSX_ID_EXT2,
> +	ST_LSM9DSX_ID_GYRO,
> +	ST_LSM9DSX_ID_ACC,
>  	ST_LSM6DSX_ID_MAX,
>  };
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 7a4fe70a8f20..6acfe63073de 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -10,6 +10,8 @@
>   * +-125/+-245/+-500/+-1000/+-2000 dps
>   * LSM6DSx series has an integrated First-In-First-Out (FIFO) buffer
>   * allowing dynamic batching of sensor data.
> + * LSM9DSx series is similar but includes an additional magnetometer, ha=
ndled
> + * by a different driver.
>   *
>   * Supported sensors:
>   * - LSM6DS3:
> @@ -30,6 +32,13 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-=
2000
>   *   - FIFO size: 3KB
>   *
> + * - LSM9DS1:
> + *   - Accelerometer supported ODR [Hz]: 10, 50, 119, 238, 476, 952
> + *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> + *   - Gyroscope supported ODR [Hz]: 15, 60, 119, 238, 476, 952
> + *   - Gyroscope supported full-scale [dps]: +-245/+-500/+-2000
> + *   - FIFO size: 32
> + *
>   * Copyright 2016 STMicroelectronics Inc.
>   *
>   * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> @@ -64,6 +73,10 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> =20
> +#define ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR	0x18
> +#define ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR	0x1a
> +#define ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR	0x1c
> +
>  static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] =
=3D {
>  	[ST_LSM6DSX_ID_ACC] =3D {
>  		.reg =3D {
> @@ -88,6 +101,30 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm=
6dsx_odr_table[] =3D {
>  		.odr_avl[3] =3D { 104, 0x04 },
>  		.odr_avl[4] =3D { 208, 0x05 },
>  		.odr_avl[5] =3D { 416, 0x06 },
> +	},
> +	[ST_LSM9DSX_ID_ACC] =3D {
> +		.reg =3D {
> +			.addr =3D 0x20,
> +			.mask =3D GENMASK(7, 5),
> +		},
> +		.odr_avl[0] =3D {  10, 0x01 },
> +		.odr_avl[1] =3D {  50, 0x02 },
> +		.odr_avl[2] =3D { 119, 0x03 },
> +		.odr_avl[3] =3D { 238, 0x04 },
> +		.odr_avl[4] =3D { 476, 0x05 },
> +		.odr_avl[5] =3D { 952, 0x06 },
> +	},
> +	[ST_LSM9DSX_ID_GYRO] =3D {
> +		.reg =3D {
> +			.addr =3D 0x10,
> +			.mask =3D GENMASK(7, 5),
> +		},
> +		.odr_avl[0] =3D {  15, 0x01 },
> +		.odr_avl[1] =3D {  60, 0x02 },
> +		.odr_avl[2] =3D { 119, 0x03 },
> +		.odr_avl[3] =3D { 238, 0x04 },
> +		.odr_avl[4] =3D { 476, 0x05 },
> +		.odr_avl[5] =3D { 952, 0x06 },
>  	}
>  };
> =20
> @@ -111,10 +148,43 @@ static const struct st_lsm6dsx_fs_table_entry st_ls=
m6dsx_fs_table[] =3D {
>  		.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(17500), 0x1 },
>  		.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(35000), 0x2 },
>  		.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(70000), 0x3 },
> +	},
> +	[ST_LSM9DSX_ID_ACC] =3D {
> +		.reg =3D {
> +			.addr =3D 0x20,
> +			.mask =3D GENMASK(4, 3),
> +		},
> +		.fs_avl[0] =3D {  599, 0x0 },
> +		.fs_avl[1] =3D { 1197, 0x2 },
> +		.fs_avl[2] =3D { 2394, 0x3 },
> +		.fs_avl[3] =3D { 4788, 0x1 },
> +	},
> +	[ST_LSM9DSX_ID_GYRO] =3D {
> +		.reg =3D {
> +			.addr =3D 0x10,
> +			.mask =3D GENMASK(4, 3),
> +		},
> +		.fs_avl[0] =3D { IIO_DEGREE_TO_RAD(245), 0x0 },
> +		.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(500), 0x1 },
> +		.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(0), 0x2 },
> +		.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(2000), 0x3 },
>  	}
>  };
> =20
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] =3D=
 {
> +	{
> +		.wai =3D 0x68,
> +		.reg_int1_addr =3D 0x0c,
> +		.reg_int2_addr =3D 0x0d,
> +		.reg_reset_addr =3D 0x22,
> +		.max_fifo_size =3D 32,
> +		.id =3D {
> +			{
> +				.hw_id =3D ST_LSM9DS1_ID,
> +				.name =3D ST_LSM9DS1_DEV_NAME,
> +			},
> +		},
> +	},
>  	{
>  		.wai =3D 0x69,
>  		.reg_int1_addr =3D 0x0d,
> @@ -492,6 +562,16 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_ch=
annels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> =20
> +static const struct iio_chan_spec st_lsm9dsx_gyro_channels[] =3D {
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR,
> +			   IIO_MOD_X, 0),
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR,
> +			   IIO_MOD_Y, 1),
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR,
> +			   IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
>  {
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
> @@ -1056,6 +1136,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(stru=
ct st_lsm6dsx_hw *hw,
> =20
>  	switch (id) {
>  	case ST_LSM6DSX_ID_ACC:
> +	case ST_LSM9DSX_ID_ACC:
>  		iio_dev->channels =3D st_lsm6dsx_acc_channels;
>  		iio_dev->num_channels =3D ARRAY_SIZE(st_lsm6dsx_acc_channels);
>  		iio_dev->info =3D &st_lsm6dsx_acc_info;
> @@ -1068,6 +1149,14 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  		iio_dev->num_channels =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels);
>  		iio_dev->info =3D &st_lsm6dsx_gyro_info;
> =20
> +		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
> +			  name);
> +		break;
> +	case ST_LSM9DSX_ID_GYRO:
> +		iio_dev->channels =3D st_lsm9dsx_gyro_channels;
> +		iio_dev->num_channels =3D ARRAY_SIZE(st_lsm9dsx_gyro_channels);
> +		iio_dev->info =3D &st_lsm6dsx_gyro_info;
> +
>  		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
>  			  name);
>  		break;
> @@ -1109,10 +1198,18 @@ int st_lsm6dsx_probe(struct device *dev, int irq,=
 int hw_id,
>  	if (err < 0)
>  		return err;
> =20
> -	for (i =3D 0; i < ST_LSM6DSX_ID_EXT0; i++) {
> -		hw->iio_devs[i] =3D st_lsm6dsx_alloc_iiodev(hw, i, name);
> -		if (!hw->iio_devs[i])
> -			return -ENOMEM;
> +	if (hw_id =3D=3D ST_LSM9DS1_ID) {
> +		for (i =3D ST_LSM9DSX_ID_GYRO; i <=3D ST_LSM9DSX_ID_ACC; i++) {
> +			hw->iio_devs[i] =3D st_lsm6dsx_alloc_iiodev(hw, i, name);
> +			if (!hw->iio_devs[i])
> +				return -ENOMEM;
> +		}
> +	} else {
> +		for (i =3D 0; i < ST_LSM6DSX_ID_EXT0; i++) {
> +			hw->iio_devs[i] =3D st_lsm6dsx_alloc_iiodev(hw, i, name);
> +			if (!hw->iio_devs[i])
> +				return -ENOMEM;
> +		}
>  	}
> =20
>  	err =3D st_lsm6dsx_init_device(hw);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index b3211e0ac07b..a684e7db1299 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -75,6 +75,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_mat=
ch[] =3D {
>  		.compatible =3D "st,lsm6dsr",
>  		.data =3D (void *)ST_LSM6DSR_ID,
>  	},
> +	{
> +		.compatible =3D "st,lsm9ds1",
> +		.data =3D (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -89,6 +93,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_tab=
le[] =3D {
>  	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_spi.c
> index c9d3c4711018..709769177e91 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -75,6 +75,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_mat=
ch[] =3D {
>  		.compatible =3D "st,lsm6dsr",
>  		.data =3D (void *)ST_LSM6DSR_ID,
>  	},
> +	{
> +		.compatible =3D "st,lsm9ds1",
> +		.data =3D (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -89,6 +93,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_tab=
le[] =3D {
>  	{ ST_ASM330LHH_DEV_NAME, ST_ASM330LHH_ID },
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
> --=20
> 2.20.1
>=20

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXSz03AAKCRA6cBh0uS2t
rD8JAPwKvRhU0aFfBA29F+DYdajJpKTmFoucevwd8l6DdfOXZwEAkyKFbvgwLlfF
C+tQIsjcNpLd2Od0rwj+B+YgTH+6Dgw=
=bubu
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
