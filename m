Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B42DD39FA8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfFHM04 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 08:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfFHM04 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 08:26:56 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C7B32080C;
        Sat,  8 Jun 2019 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559996814;
        bh=8j8HHa7IO2HMZJoEB1xXTzYAxvrBRo4Ug3eV1/fJhyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvF3igzuyBOV9Q+7cgfKIAg4TKOi5tqaJyKtdDuuXAq6CgkXZH80qDLAfuFXGeHiO
         VCsoaUi2nNq4FTVgLvhoU8NcfBOv2m77usNACW+FiOeRBd/A/HGLvNwEJl4AmGY01x
         gHv/90G+PY1cA1FPok39uLuZ7T77MRSYfJ3Kfygk=
Date:   Sat, 8 Jun 2019 14:26:49 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Vitor.Soares@synopsys.com, boris.brezillon@collabora.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: get device name from
 st_lsm6dsx_sensor_settings
Message-ID: <20190608122648.GA14299@localhost.localdomain>
References: <22ad57099bf50226027e7f5c537207a5b4a6f99b.1559941022.git.lorenzo@kernel.org>
 <20190608124738.6af7e4ee@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20190608124738.6af7e4ee@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri,  7 Jun 2019 23:00:20 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Introduce sensor name in st_lsm6dsx_sensor_settings table. This is
> > a preliminary patch to add I3C support to st_lsm6dsx since i3c_device_id
> > data structure does not contain a name field
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > changes since v1:
> > - move sensor name in st_lsm6dsx_sensor_settings =20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  9 ++--
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 53 +++++++++++++++-----
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  3 +-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  3 +-
> >  4 files changed, 48 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 004a8a1a0027..a736829d25cd 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -198,7 +198,7 @@ struct st_lsm6dsx_ext_dev_settings {
> >   * struct st_lsm6dsx_settings - ST IMU sensor settings
> >   * @wai: Sensor WhoAmI default value.
> >   * @max_fifo_size: Sensor max fifo length in FIFO words.
> > - * @id: List of hw id supported by the driver configuration.
> > + * @id: List of hw id/device name supported by the driver configuratio=
n.
> >   * @decimator: List of decimator register info (addr + mask).
> >   * @batch: List of FIFO batching register info (addr + mask).
> >   * @fifo_ops: Sensor hw FIFO parameters.
> > @@ -208,7 +208,10 @@ struct st_lsm6dsx_ext_dev_settings {
> >  struct st_lsm6dsx_settings {
> >  	u8 wai;
> >  	u16 max_fifo_size;
> > -	enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
> > +	struct {
> > +		enum st_lsm6dsx_hw_id hw_id;
> > +		const char name[32];
>=20
> Given these are only ever set once, you can just use
> const char *name;
>=20
> That lets the compiler do things like merging different
> instances.

ack, thx for the hint. v3 on the way

Regards,
Lorenzo

>=20
> > +	} id[ST_LSM6DSX_MAX_ID];
> >  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> >  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> >  	struct st_lsm6dsx_fifo_ops fifo_ops;
> > @@ -302,7 +305,7 @@ struct st_lsm6dsx_hw {
> >  static const unsigned long st_lsm6dsx_available_scan_masks[] =3D {0x7,=
 0x0};
> >  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
> > =20
> > -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const cha=
r *name,
> > +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> >  		     struct regmap *regmap);
> >  int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> >  				 bool enable);
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index cf82c9049945..04233928d23e 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -125,7 +125,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  		.wai =3D 0x69,
> >  		.max_fifo_size =3D 1365,
> >  		.id =3D {
> > -			[0] =3D ST_LSM6DS3_ID,
> > +			{
> > +				.hw_id =3D ST_LSM6DS3_ID,
> > +				.name =3D ST_LSM6DS3_DEV_NAME,
> > +			},
> >  		},
> >  		.decimator =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> > @@ -172,7 +175,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  		.wai =3D 0x69,
> >  		.max_fifo_size =3D 682,
> >  		.id =3D {
> > -			[0] =3D ST_LSM6DS3H_ID,
> > +			{
> > +				.hw_id =3D ST_LSM6DS3H_ID,
> > +				.name =3D ST_LSM6DS3H_DEV_NAME,
> > +			},
> >  		},
> >  		.decimator =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> > @@ -219,9 +225,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  		.wai =3D 0x6a,
> >  		.max_fifo_size =3D 682,
> >  		.id =3D {
> > -			[0] =3D ST_LSM6DSL_ID,
> > -			[1] =3D ST_LSM6DSM_ID,
> > -			[2] =3D ST_ISM330DLC_ID,
> > +			{
> > +				.hw_id =3D ST_LSM6DSL_ID,
> > +				.name =3D ST_LSM6DSL_DEV_NAME,
> > +			}, {
> > +				.hw_id =3D ST_LSM6DSM_ID,
> > +				.name =3D ST_LSM6DSM_DEV_NAME,
> > +			}, {
> > +				.hw_id =3D ST_ISM330DLC_ID,
> > +				.name =3D ST_ISM330DLC_DEV_NAME,
> > +			},
> >  		},
> >  		.decimator =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> > @@ -268,8 +281,13 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  		.wai =3D 0x6c,
> >  		.max_fifo_size =3D 512,
> >  		.id =3D {
> > -			[0] =3D ST_LSM6DSO_ID,
> > -			[1] =3D ST_LSM6DSOX_ID,
> > +			{
> > +				.hw_id =3D ST_LSM6DSO_ID,
> > +				.name =3D ST_LSM6DSO_DEV_NAME,
> > +			}, {
> > +				.hw_id =3D ST_LSM6DSOX_ID,
> > +				.name =3D ST_LSM6DSOX_DEV_NAME,
> > +			},
> >  		},
> >  		.batch =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> > @@ -334,7 +352,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  		.wai =3D 0x6b,
> >  		.max_fifo_size =3D 512,
> >  		.id =3D {
> > -			[0] =3D ST_ASM330LHH_ID,
> > +			{
> > +				.hw_id =3D ST_ASM330LHH_ID,
> > +				.name =3D ST_ASM330LHH_DEV_NAME,
> > +			},
> >  		},
> >  		.batch =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> > @@ -373,7 +394,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  		.wai =3D 0x6b,
> >  		.max_fifo_size =3D 512,
> >  		.id =3D {
> > -			[0] =3D ST_LSM6DSR_ID,
> > +			{
> > +				.hw_id =3D ST_LSM6DSR_ID,
> > +				.name =3D ST_LSM6DSR_DEV_NAME,
> > +			},
> >  		},
> >  		.batch =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> > @@ -471,13 +495,14 @@ int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw,=
 bool enable)
> >  	return err;
> >  }
> > =20
> > -static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
> > +static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > +				   const char **name)
> >  {
> >  	int err, i, j, data;
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> >  		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > -			if (id =3D=3D st_lsm6dsx_sensor_settings[i].id[j])
> > +			if (id =3D=3D st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> >  				break;
> >  		}
> >  		if (j < ST_LSM6DSX_MAX_ID)
> > @@ -500,6 +525,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6ds=
x_hw *hw, int id)
> >  		return -ENODEV;
> >  	}
> > =20
> > +	*name =3D st_lsm6dsx_sensor_settings[i].id[j].name;
> >  	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > =20
> >  	return 0;
> > @@ -1041,11 +1067,12 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(=
struct st_lsm6dsx_hw *hw,
> >  	return iio_dev;
> >  }
> > =20
> > -int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const cha=
r *name,
> > +int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
> >  		     struct regmap *regmap)
> >  {
> >  	const struct st_lsm6dsx_shub_settings *hub_settings;
> >  	struct st_lsm6dsx_hw *hw;
> > +	const char *name =3D NULL;
> >  	int i, err;
> > =20
> >  	hw =3D devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
> > @@ -1066,7 +1093,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq,=
 int hw_id, const char *name,
> >  	hw->irq =3D irq;
> >  	hw->regmap =3D regmap;
> > =20
> > -	err =3D st_lsm6dsx_check_whoami(hw, hw_id);
> > +	err =3D st_lsm6dsx_check_whoami(hw, hw_id, &name);
> >  	if (err < 0)
> >  		return err;
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > index f54370196098..47581a4e456e 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> > @@ -36,8 +36,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *cl=
ient,
> >  		return PTR_ERR(regmap);
> >  	}
> > =20
> > -	return st_lsm6dsx_probe(&client->dev, client->irq,
> > -				hw_id, id->name, regmap);
> > +	return st_lsm6dsx_probe(&client->dev, client->irq, hw_id, regmap);
> >  }
> > =20
> >  static const struct of_device_id st_lsm6dsx_i2c_of_match[] =3D {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > index 4a4abb2935da..facf66978a4b 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> > @@ -36,8 +36,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *sp=
i)
> >  		return PTR_ERR(regmap);
> >  	}
> > =20
> > -	return st_lsm6dsx_probe(&spi->dev, spi->irq,
> > -				hw_id, id->name, regmap);
> > +	return st_lsm6dsx_probe(&spi->dev, spi->irq, hw_id, regmap);
> >  }
> > =20
> >  static const struct of_device_id st_lsm6dsx_spi_of_match[] =3D {
>=20

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXPuphQAKCRA6cBh0uS2t
rB/RAP9+7AY1EfnLbt4Z8DtYryzJeyHY/McnOWg+7emTVUCzSgEAu8b48bUtHJVI
SP4PwbvPzUj7Ip61ppP61QJLXIylrQQ=
=JhZP
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
