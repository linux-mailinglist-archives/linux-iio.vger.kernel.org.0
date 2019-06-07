Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5723138692
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2019 10:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfFGIz5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jun 2019 04:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfFGIz4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Jun 2019 04:55:56 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04FA72089E;
        Fri,  7 Jun 2019 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559897755;
        bh=IvLBKDDfH1X/y3ASBeZRvI4TAvNfCDmw2ao7jli1B7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhn8tDa0ybWFaAlS0j7qUq/xbRZ4TcBL1DkFmNKG8NliNlR4OL3MY6ieDDFJV7X/s
         LWf3c0zZMojJqASffujo6NFuMK1E9cde2quCPuiumBNUHmeGDKifUiqonGtgF17ykQ
         VTF7Cpu6tLhYsUI3bZBzyo4ung4ei8iFl8dwLGis=
Date:   Fri, 7 Jun 2019 10:55:50 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Vitor.Soares@synopsys.com, boris.brezillon@collabora.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: get device name from
 st_lsm6dsx_dev_name
Message-ID: <20190607085548.GA10501@localhost.localdomain>
References: <2531966256f991d802a775d953656b92ae8216bd.1559862531.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <2531966256f991d802a775d953656b92ae8216bd.1559862531.git.lorenzo@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Introduce st_lsm6dsx_dev_name lookup table to get device name. This is
> a preliminary patch to add I3C support to st_lsm6dsx since i3c_device_id
> data structure does not contain a name field
>=20

Hi Jonathan,

please hold on with this patch, I will post a v2 moving device name in
st_lsm6dsx_settings

Regards,
Lorenzo

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 +--
>  4 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 004a8a1a0027..71627206fc30 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -302,7 +302,7 @@ struct st_lsm6dsx_hw {
>  static const unsigned long st_lsm6dsx_available_scan_masks[] =3D {0x7, 0=
x0};
>  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
> =20
> -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char =
*name,
> +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap);
>  int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
>  				 bool enable);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index cf82c9049945..339b75040732 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -70,6 +70,18 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> =20
> +static const char st_lsm6dsx_dev_name[][32] =3D {
> +	[ST_LSM6DS3_ID] =3D ST_LSM6DS3_DEV_NAME,
> +	[ST_LSM6DS3H_ID] =3D ST_LSM6DS3H_DEV_NAME,
> +	[ST_LSM6DSL_ID] =3D ST_LSM6DSL_DEV_NAME,
> +	[ST_LSM6DSM_ID] =3D ST_LSM6DSM_DEV_NAME,
> +	[ST_ISM330DLC_ID] =3D ST_ISM330DLC_DEV_NAME,
> +	[ST_LSM6DSO_ID] =3D ST_LSM6DSO_DEV_NAME,
> +	[ST_ASM330LHH_ID] =3D ST_ASM330LHH_DEV_NAME,
> +	[ST_LSM6DSOX_ID] =3D ST_LSM6DSOX_DEV_NAME,
> +	[ST_LSM6DSR_ID] =3D ST_LSM6DSR_DEV_NAME,
> +};
> +
>  static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] =
=3D {
>  	[ST_LSM6DSX_ID_ACC] =3D {
>  		.reg =3D {
> @@ -1041,11 +1053,12 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(st=
ruct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
> =20
> -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char =
*name,
> +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
>  	struct st_lsm6dsx_hw *hw;
> +	const char *name;
>  	int i, err;
> =20
>  	hw =3D devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
> @@ -1070,6 +1083,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, i=
nt hw_id, const char *name,
>  	if (err < 0)
>  		return err;
> =20
> +	name =3D st_lsm6dsx_dev_name[hw_id];
>  	for (i =3D 0; i < ST_LSM6DSX_ID_EXT0; i++) {
>  		hw->iio_devs[i] =3D st_lsm6dsx_alloc_iiodev(hw, i, name);
>  		if (!hw->iio_devs[i])
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_i2c.c
> index f54370196098..47581a4e456e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -36,8 +36,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *clie=
nt,
>  		return PTR_ERR(regmap);
>  	}
> =20
> -	return st_lsm6dsx_probe(&client->dev, client->irq,
> -				hw_id, id->name, regmap);
> +	return st_lsm6dsx_probe(&client->dev, client->irq, hw_id, regmap);
>  }
> =20
>  static const struct of_device_id st_lsm6dsx_i2c_of_match[] =3D {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx_spi.c
> index 4a4abb2935da..facf66978a4b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -36,8 +36,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
>  		return PTR_ERR(regmap);
>  	}
> =20
> -	return st_lsm6dsx_probe(&spi->dev, spi->irq,
> -				hw_id, id->name, regmap);
> +	return st_lsm6dsx_probe(&spi->dev, spi->irq, hw_id, regmap);
>  }
> =20
>  static const struct of_device_id st_lsm6dsx_spi_of_match[] =3D {
> --=20
> 2.21.0
>=20

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXPomkgAKCRA6cBh0uS2t
rJqpAQCtTZmeQmRO8kqjpJ90nJJRJ0OCcPYeoLbq/bGgDZGUmAEAkiBqMlRz7ee4
J2A4ionuXY+YWXHROwsl2fXEjUd0iAE=
=XlO5
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
