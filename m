Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 865D36A23B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfGPGZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 02:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbfGPGZ3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 02:25:29 -0400
Received: from localhost.localdomain (unknown [151.66.36.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78DEC20880;
        Tue, 16 Jul 2019 06:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563258327;
        bh=WLOQmLZ12H6cG3vIMyQDSk0M+hAnV5VsbvDL+AAuVgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxMmJ0r/uAAzKwCxzeoFoGA6gTsELlc4bpRGW94G+HL51IXN0+CZTAT5525PfuPkC
         3lKi/4NfUzXAXu1NCEeM8VqVzZlZ+Z+iEAImyXS3OnDwNatlBeDAWMpa61tnrG3wGS
         1BG0txwDX3uQNZh+RCEPt/lExJVbzQH/mQPBDS2g=
Date:   Tue, 16 Jul 2019 08:25:23 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     jic23@kernel.org, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: st_lsm6dsx: move odr_table in
 st_lsm6dsx_sensor_settings
Message-ID: <20190716062523.GG23126@localhost.localdomain>
References: <cover.1563226641.git.lorenzo@kernel.org>
 <266b36facd2c0b36454f0d6023a886e246441348.1563226641.git.lorenzo@kernel.org>
 <f359967f-b696-d442-8dfd-7ee2217f215e@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <f359967f-b696-d442-8dfd-7ee2217f215e@puri.sm>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 15.07.19 23:42, Lorenzo Bianconi wrote:
> > Move sensor odr table in st_lsm6dsx_sensor_settings in order to support
> > sensors with different odr maps. This is a preliminary patch to add
> > support for LSM9DS1 sensor to st_lsm6dsx driver
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 196 ++++++++++++++++---
> >  2 files changed, 166 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index af379a5429ed..3a89f3f6e2c7 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -200,6 +200,7 @@ struct st_lsm6dsx_ext_dev_settings {
> >   * @wai: Sensor WhoAmI default value.
> >   * @max_fifo_size: Sensor max fifo length in FIFO words.
> >   * @id: List of hw id/device name supported by the driver configuratio=
n.
> > + * @odr_table: Hw sensors odr table (Hz + val).
> >   * @decimator: List of decimator register info (addr + mask).
> >   * @batch: List of FIFO batching register info (addr + mask).
> >   * @fifo_ops: Sensor hw FIFO parameters.
> > @@ -213,6 +214,7 @@ struct st_lsm6dsx_settings {
> >  		enum st_lsm6dsx_hw_id hw_id;
> >  		const char *name;
> >  	} id[ST_LSM6DSX_MAX_ID];
> > +	struct st_lsm6dsx_odr_table_entry odr_table[2];
> >  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> >  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> >  	struct st_lsm6dsx_fifo_ops fifo_ops;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index d8c4417cf4eb..b3c6c9792913 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -69,33 +69,6 @@
> >  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
> >  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> > =20
> > -static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] =
=3D {
> > -	[ST_LSM6DSX_ID_ACC] =3D {
> > -		.reg =3D {
> > -			.addr =3D 0x10,
> > -			.mask =3D GENMASK(7, 4),
> > -		},
> > -		.odr_avl[0] =3D {  13, 0x01 },
> > -		.odr_avl[1] =3D {  26, 0x02 },
> > -		.odr_avl[2] =3D {  52, 0x03 },
> > -		.odr_avl[3] =3D { 104, 0x04 },
> > -		.odr_avl[4] =3D { 208, 0x05 },
> > -		.odr_avl[5] =3D { 416, 0x06 },
> > -	},
> > -	[ST_LSM6DSX_ID_GYRO] =3D {
> > -		.reg =3D {
> > -			.addr =3D 0x11,
> > -			.mask =3D GENMASK(7, 4),
> > -		},
> > -		.odr_avl[0] =3D {  13, 0x01 },
> > -		.odr_avl[1] =3D {  26, 0x02 },
> > -		.odr_avl[2] =3D {  52, 0x03 },
> > -		.odr_avl[3] =3D { 104, 0x04 },
> > -		.odr_avl[4] =3D { 208, 0x05 },
> > -		.odr_avl[5] =3D { 416, 0x06 },
> > -	}
> > -};
> > -
> >  static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] =
=3D {
> >  	[ST_LSM6DSX_ID_ACC] =3D {
> >  		.reg =3D {
> > @@ -129,6 +102,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.name =3D ST_LSM6DS3_DEV_NAME,
> >  			},
> >  		},
> > +		.odr_table =3D {
> > +			[ST_LSM6DSX_ID_ACC] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x10,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +			[ST_LSM6DSX_ID_GYRO] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x11,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +		},
> >  		.decimator =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> >  				.addr =3D 0x08,
> > @@ -179,6 +178,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.name =3D ST_LSM6DS3H_DEV_NAME,
> >  			},
> >  		},
> > +		.odr_table =3D {
> > +			[ST_LSM6DSX_ID_ACC] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x10,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +			[ST_LSM6DSX_ID_GYRO] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x11,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +		},
> >  		.decimator =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> >  				.addr =3D 0x08,
> > @@ -238,6 +263,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.name =3D ST_LSM6DS3TRC_DEV_NAME,
> >  			},
> >  		},
> > +		.odr_table =3D {
> > +			[ST_LSM6DSX_ID_ACC] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x10,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +			[ST_LSM6DSX_ID_GYRO] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x11,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +		},
> >  		.decimator =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> >  				.addr =3D 0x08,
> > @@ -291,6 +342,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.name =3D ST_LSM6DSOX_DEV_NAME,
> >  			},
> >  		},
> > +		.odr_table =3D {
> > +			[ST_LSM6DSX_ID_ACC] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x10,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +			[ST_LSM6DSX_ID_GYRO] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x11,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +		},
> >  		.batch =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> >  				.addr =3D 0x09,
> > @@ -359,6 +436,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.name =3D ST_ASM330LHH_DEV_NAME,
> >  			},
> >  		},
> > +		.odr_table =3D {
> > +			[ST_LSM6DSX_ID_ACC] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x10,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +			[ST_LSM6DSX_ID_GYRO] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x11,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +		},
> >  		.batch =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> >  				.addr =3D 0x09,
> > @@ -401,6 +504,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.name =3D ST_LSM6DSR_DEV_NAME,
> >  			},
> >  		},
> > +		.odr_table =3D {
> > +			[ST_LSM6DSX_ID_ACC] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x10,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +			[ST_LSM6DSX_ID_GYRO] =3D {
> > +				.reg =3D {
> > +					.addr =3D 0x11,
> > +					.mask =3D GENMASK(7, 4),
> > +				},
> > +				.odr_avl[0] =3D {  13, 0x01 },
> > +				.odr_avl[1] =3D {  26, 0x02 },
> > +				.odr_avl[2] =3D {  52, 0x03 },
> > +				.odr_avl[3] =3D { 104, 0x04 },
> > +				.odr_avl[4] =3D { 208, 0x05 },
> > +				.odr_avl[5] =3D { 416, 0x06 },
> > +			},
> > +		},
> >  		.batch =3D {
> >  			[ST_LSM6DSX_ID_ACC] =3D {
> >  				.addr =3D 0x09,
> > @@ -563,20 +692,22 @@ static int st_lsm6dsx_set_full_scale(struct st_ls=
m6dsx_sensor *sensor,
> > =20
> >  int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8=
 *val)
> >  {
> > +	const struct st_lsm6dsx_odr_table_entry *odr_table;
> >  	int i;
> > =20
> > +	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> >  	for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> >  		/*
> >  		 * ext devices can run at different odr respect to
> >  		 * accel sensor
> >  		 */
> > -		if (st_lsm6dsx_odr_table[sensor->id].odr_avl[i].hz >=3D odr)
> > +		if (odr_table->odr_avl[i].hz >=3D odr)
> >  			break;
> > =20
> >  	if (i =3D=3D ST_LSM6DSX_ODR_LIST_SIZE)
> >  		return -EINVAL;
> > =20
> > -	*val =3D st_lsm6dsx_odr_table[sensor->id].odr_avl[i].val;
> > +	*val =3D odr_table->odr_avl[i].val;
> > =20
> >  	return 0;
> >  }
> > @@ -641,7 +772,7 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sen=
sor *sensor, u16 req_odr)
> >  			return err;
> >  	}
> > =20
> > -	reg =3D &st_lsm6dsx_odr_table[ref_sensor->id].reg;
> > +	reg =3D &hw->settings->odr_table[ref_sensor->id].reg;
> >  	data =3D ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
> >  	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
> >  }
> > @@ -786,11 +917,12 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct =
device *dev,
> >  {
> >  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(dev_get_drvdata(dev));
> >  	enum st_lsm6dsx_sensor_id id =3D sensor->id;
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> >  	int i, len =3D 0;
> > =20
> >  	for (i =3D 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> >  		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> > -				 st_lsm6dsx_odr_table[id].odr_avl[i].hz);
> > +				 hw->settings->odr_table[id].odr_avl[i].hz);
> >  	buf[len - 1] =3D '\n';
> > =20
> >  	return len;
> > @@ -1040,7 +1172,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(st=
ruct st_lsm6dsx_hw *hw,
> >  	sensor =3D iio_priv(iio_dev);
> >  	sensor->id =3D id;
> >  	sensor->hw =3D hw;
> > -	sensor->odr =3D st_lsm6dsx_odr_table[id].odr_avl[0].hz;
> > +	sensor->odr =3D hw->settings->odr_table[id].odr_avl[0].hz;
> >  	sensor->gain =3D st_lsm6dsx_fs_table[id].fs_avl[0].gain;
> >  	sensor->watermark =3D 1;
> > =20
> >=20
>=20
> Makes sense to me, thanks! What tree do you build this against though?
> At least to the current -next tree, this doesn't apply.
>=20

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
testing branch

Lorenzo

> thanks,
>=20
>                                martin
>=20

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS1t0AAKCRA6cBh0uS2t
rDrDAQDEHtTnwDX2TWbNsQNOltPRmJd8Gbyix0cADHffi4IFUQD/Ru1oCTRAuPsb
j7M3A8kM2mTvtpP+0A6WOmpmPQWfhQY=
=mrQH
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
