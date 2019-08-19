Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A2920A3
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfHSJsw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Aug 2019 05:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfHSJsw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Aug 2019 05:48:52 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A9B20989;
        Mon, 19 Aug 2019 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566208131;
        bh=IRqIYND2H55iD5ZGvMJvn8Fyh39/XC4THrmPC6qL87E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tigh+z9rBDtJK7COaUGfdZ5ludsY8pYvzwAru23w7aODCNgGIyNYsAIJ9z9WSNCZw
         wZr9W1vr+vMAce7ML+1Jk0SyDdQPF3vmASfwOZJy98YclkldrVSQm+au+eHwCs5ZvX
         2Zl2ZkEwURKKR/22ycWC7wpRtebLehqIocYZEHcY=
Date:   Mon, 19 Aug 2019 11:48:45 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: imu: st_lsm6dsx: add support for accel/gyro
 unit of lsm9sd1
Message-ID: <20190819094845.GB17835@localhost.localdomain>
References: <20190813073533.8007-1-martin.kepplinger@puri.sm>
 <20190813073533.8007-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20190813073533.8007-3-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--uZ3hkaAS1mZxFaxD
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
> accelerometer and gyroscope are not independently clocked. It runs at the=
 gyro
> frequencies if both are enabled, see chapter 7.12 of the datasheet.
> We could have handled this as a single IIO device but we have split
> it up to be more consistent with the other more flexible devices.
>=20
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Hi Martin,

most of comments are nitpicks (inline), the only issue I can see here is we=
 can enable
hw fifo for lsm6ds0/lsm9ds1 and read_fifo routine pointer is not currently
initialized so we will end up with a NULL pointer dereference. Since we will
need a different update FIFO routine for lsm6ds0/lsm9ds1 I am adding an
update_fifo function pointer in fifo_ops in order to fix this issue.

Regards,
Lorenzo

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig           |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 87 ++++++++++++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  5 ++
>  5 files changed, 100 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6=
dsx/Kconfig
> index 939058b27746..77aa0e77212d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -12,7 +12,7 @@ config IIO_ST_LSM6DSX
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
>  	  ism330dlc, lsm6dso, lsm6dsox, asm330lhh, lsm6dsr, lsm6ds3tr-c,
> -	  ism330dhcx
> +	  ism330dhcx and the accelerometer/gyroscope of lsm9ds1.
> =20
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index c8f333902eb7..d03b5a2d8549 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -24,6 +24,7 @@
>  #define ST_LSM6DSR_DEV_NAME	"lsm6dsr"
>  #define ST_LSM6DS3TRC_DEV_NAME	"lsm6ds3tr-c"
>  #define ST_ISM330DHCX_DEV_NAME	"ism330dhcx"
> +#define ST_LSM9DS1_DEV_NAME	"lsm9ds1"

should be called 'lsm9ds1_imu' since lsm9ds1 is a 9-axis device? what do you
think?

> =20
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -37,6 +38,7 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSR_ID,
>  	ST_LSM6DS3TRC_ID,
>  	ST_ISM330DHCX_ID,
> +	ST_LSM9DS1_ID,

same here..ST_LSM9DS1_IMU_ID

>  	ST_LSM6DSX_MAX_ID,
>  };
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 56e1c5262a2c..f038bb06f635 100644
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
> @@ -70,7 +79,85 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_chan=
nels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> =20
> +static const struct iio_chan_spec st_lsm9dsx_gyro_channels[] =3D {
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x18, IIO_MOD_X, 0),
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1a, IIO_MOD_Y, 1),
> +	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1c, IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +

why not st_lsm6ds0_gyro_channels?

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
> +		.channels =3D {
> +			[ST_LSM6DSX_ID_ACC] =3D {
> +				.chan =3D st_lsm6dsx_acc_channels,
> +				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> +			},
> +			[ST_LSM6DSX_ID_GYRO] =3D {
> +				.chan =3D st_lsm9dsx_gyro_channels,
> +				.len =3D ARRAY_SIZE(st_lsm9dsx_gyro_channels),
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
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 15c6aa5b6caa..2f1b30ff083b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_mat=
ch[] =3D {
>  		.compatible =3D "st,ism330dhcx",
>  		.data =3D (void *)ST_ISM330DHCX_ID,
>  	},
> +	{
> +		.compatible =3D "st,lsm9ds1",

same here, what is the right compatible string? "st,lsm9ds1 or
"st,lsm9ds1_imu"?

> +		.data =3D (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -99,6 +103,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_ta=
ble[] =3D {
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_spi.c
> index a8430ee11310..421ce704f346 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -83,6 +83,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_mat=
ch[] =3D {
>  		.compatible =3D "st,ism330dhcx",
>  		.data =3D (void *)ST_ISM330DHCX_ID,
>  	},
> +	{
> +		.compatible =3D "st,lsm9ds1",
> +		.data =3D (void *)ST_LSM9DS1_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -99,6 +103,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_ta=
ble[] =3D {
>  	{ ST_LSM6DSR_DEV_NAME, ST_LSM6DSR_ID },
>  	{ ST_LSM6DS3TRC_DEV_NAME, ST_LSM6DS3TRC_ID },
>  	{ ST_ISM330DHCX_DEV_NAME, ST_ISM330DHCX_ID },
> +	{ ST_LSM9DS1_DEV_NAME, ST_LSM9DS1_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
> --=20
> 2.20.1
>=20

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXVpweQAKCRA6cBh0uS2t
rErQAQC4QMiXhYVvdFCQwrXCAqWss0XDBLOa+7Izz/ME/KDMJQEA6pEpmxuNLJcg
NmW2NefN9QlGEmBQECUmZJf6XJz6QQk=
=eOzO
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
