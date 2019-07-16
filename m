Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E303B6A5D0
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 11:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbfGPJsK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 05:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfGPJsK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 05:48:10 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929EB2064B;
        Tue, 16 Jul 2019 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563270489;
        bh=EzqVw9kpLAhkRr4eBfArHTiE/LCcjaWz+TfLD8GZXfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPTOe36qookTMo14Ivqws+PhVTIZIj8BaboxvcSF2/4f68cZu967n3qayjLTckvTM
         im4p3Xz6DqMcReQJc+FrDHyanq+n3pGZkVx+PltyuuWZaSsWUgN94FPidOCBolYl8r
         eQuPhYiC585VzFv5ubiID0MxaTnnqed5C2BOt0/A=
Date:   Tue, 16 Jul 2019 11:48:03 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
Message-ID: <20190716094803.GD13440@localhost.localdomain>
References: <20190716093325.7683-1-martin.kepplinger@puri.sm>
 <20190716093325.7683-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20190716093325.7683-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Hf61M2y+wYpnELGG
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

I think LSM9DS1 relies on LSM6DS0 for acc and gyro part so I guess we can u=
se
this name here, what do you think?

>=20
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>=20
>=20
> This is already based on Lorenzo's recent changes:
> https://lore.kernel.org/linux-iio/853f216a-7814-cb79-180b-078ac5e8a359@pu=
ri.sm/T/#u
> https://lore.kernel.org/linux-iio/501b0db9-63cb-905c-c09b-682eb73f1ff3@pu=
ri.sm/T/#u
>=20
> revision history:
> v2: overall further simplification
>=20
> thanks
>                        martin
>=20
>=20
>=20
>  drivers/iio/imu/st_lsm6dsx/Kconfig           |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 94 +++++++++++++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  5 ++
>  5 files changed, 104 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6=
dsx/Kconfig
> index 2d8b2e1edfce..4a57bfb3c12e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -11,6 +11,7 @@ config IIO_ST_LSM6DSX
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
>  	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c
> +	  and the accelerometer/gyroscope of lsm9ds1.
> =20
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 3c47f5d27d30..9a30cc717de2 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -23,6 +23,7 @@
>  #define ST_LSM6DSOX_DEV_NAME	"lsm6dsox"
>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>  #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"
> =20
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -35,6 +36,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSOX_ID,
>  	ST_LSM6DSR_ID,
>  	ST_LSM6DS3TRC_ID,
> +	ST_LSM9DS1_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index e0d2149625cc..2f3d2bf25646 100644
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
> @@ -64,7 +73,72 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> =20
> +#define ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR	0x18
> +#define ST_LSM9DSX_REG_GYRO_OUT_Y_L_ADDR	0x1a
> +#define ST_LSM9DSX_REG_GYRO_OUT_Z_L_ADDR	0x1c
> +
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] =3D=
 {
> +	{
> +		.wai =3D 0x68,
> +		.int1_addr =3D 0x0c,
> +		.int2_addr =3D 0x0d,
> +		.reset_addr =3D 0x22,
> +		.max_fifo_size =3D 32,
> +		.id =3D {
> +			{
> +				.hw_id =3D ST_LSM9DS1_ID,
> +				.name =3D ST_LSM9DS1_DEV_NAME,
> +			},
> +		},
> +		.odr_table =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D {
> +				.reg =3D {
> +					.addr =3D 0x20,
> +					.mask =3D GENMASK(7, 5),
> +				},
> +				.odr_avl[0] =3D {  10, 0x01 },
> +				.odr_avl[1] =3D {  50, 0x02 },
> +				.odr_avl[2] =3D { 119, 0x03 },
> +				.odr_avl[3] =3D { 238, 0x04 },
> +				.odr_avl[4] =3D { 476, 0x05 },
> +				.odr_avl[5] =3D { 952, 0x06 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] =3D {
> +				.reg =3D {
> +					.addr =3D 0x10,
> +					.mask =3D GENMASK(7, 5),
> +				},
> +				.odr_avl[0] =3D {  15, 0x01 },
> +				.odr_avl[1] =3D {  60, 0x02 },
> +				.odr_avl[2] =3D { 119, 0x03 },
> +				.odr_avl[3] =3D { 238, 0x04 },
> +				.odr_avl[4] =3D { 476, 0x05 },
> +				.odr_avl[5] =3D { 952, 0x06 },
> +			},
> +		},
> +		.fs_table =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D {
> +				.reg =3D {
> +					.addr =3D 0x20,
> +					.mask =3D GENMASK(4, 3),
> +				},
> +				.fs_avl[0] =3D {  599, 0x0 },
> +				.fs_avl[1] =3D { 1197, 0x2 },
> +				.fs_avl[2] =3D { 2394, 0x3 },
> +				.fs_avl[3] =3D { 4788, 0x1 },
> +			},
> +			[ST_LSM6DSX_ID_GYRO] =3D {
> +				.reg =3D {
> +					.addr =3D 0x10,
> +					.mask =3D GENMASK(4, 3),
> +				},
> +				.fs_avl[0] =3D { IIO_DEGREE_TO_RAD(245), 0x0 },
> +				.fs_avl[1] =3D { IIO_DEGREE_TO_RAD(500), 0x1 },
> +				.fs_avl[2] =3D { IIO_DEGREE_TO_RAD(0), 0x2 },
> +				.fs_avl[3] =3D { IIO_DEGREE_TO_RAD(2000), 0x3 },
> +			},
> +		},
> +	},
>  	{
>  		.wai =3D 0x69,
>  		.int1_addr =3D 0x0d,
> @@ -733,6 +807,16 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_ch=
annels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> =20
> +static const struct iio_chan_spec st_lsm9dsx_gyro_channels[] =3D {
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, ST_LSM9DSX_REG_GYRO_OUT_X_L_ADDR,
> +			   IIO_MOD_X, 0),

I guess you can use 0x18, 0x1a and 0x1c here and remove the definitions

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
> @@ -1278,7 +1362,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx=
_hw *hw)
> =20
>  static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  					       enum st_lsm6dsx_sensor_id id,
> -					       const char *name)
> +					       const char *name, int hw_id)
>  {
>  	struct st_lsm6dsx_sensor *sensor;
>  	struct iio_dev *iio_dev;
> @@ -1308,7 +1392,11 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  			  name);
>  		break;
>  	case ST_LSM6DSX_ID_GYRO:
> -		iio_dev->channels =3D st_lsm6dsx_gyro_channels;
> +		if (hw_id =3D=3D ST_LSM9DS1_ID)
> +			iio_dev->channels =3D st_lsm9dsx_gyro_channels;
> +		else
> +			iio_dev->channels =3D st_lsm6dsx_gyro_channels;
> +
>  		iio_dev->num_channels =3D ARRAY_SIZE(st_lsm6dsx_gyro_channels);
>  		iio_dev->info =3D &st_lsm6dsx_gyro_info;
> =20
> @@ -1354,7 +1442,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, i=
nt hw_id,
>  		return err;
> =20
>  	for (i =3D 0; i < ST_LSM6DSX_ID_EXT0; i++) {
> -		hw->iio_devs[i] =3D st_lsm6dsx_alloc_iiodev(hw, i, name);
> +		hw->iio_devs[i] =3D st_lsm6dsx_alloc_iiodev(hw, i, name, hw_id);
>  		if (!hw->iio_devs[i])
>  			return -ENOMEM;
>  	}
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 28581eb0532c..c36a057c36ee 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -79,6 +79,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_mat=
ch[] =3D {
>  		.compatible =3D "st,lsm6ds3tr-c",
>  		.data =3D (void *)ST_LSM6DS3TRC_ID,
>  	},
> +	{
> +		.compatible =3D "st,lsm9ds1",
> +		.data =3D (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -94,6 +98,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_tab=
le[] =3D {
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_spi.c
> index 0371e8b94a3e..138e3b985865 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -79,6 +79,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_mat=
ch[] =3D {
>  		.compatible =3D "st,lsm6ds3tr-c",
>  		.data =3D (void *)ST_LSM6DS3TRC_ID,
>  	},
> +	{
> +		.compatible =3D "st,lsm9ds1",
> +		.data =3D (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -94,6 +98,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_tab=
le[] =3D {
>  	{ ST_LSM6DSOX_DEV_NAME, ST_LSM6DSOX_ID },
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
> --=20
> 2.20.1
>=20

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS2dUQAKCRA6cBh0uS2t
rOj5AP9OOv82J4Zego70/iF6IsEichJMRn2iFmBHmgtsN62qawEAtmQBpaQGtBS0
Lb9LhTQIB1KJn1ZuXP8igBJtOn4cPA8=
=SVQf
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
