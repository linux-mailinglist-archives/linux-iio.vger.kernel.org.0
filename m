Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C300AF6828
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 10:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfKJJ2A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 04:28:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfKJJ2A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 04:28:00 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3651F207FA;
        Sun, 10 Nov 2019 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573378078;
        bh=VKWEPk+qt+1gVy1uW6l+oCoe6wl+EJlMhy46Eijn3yM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Va3/8fGLOntWtGEwNKxVXrzBCcdsVGkAqpAM/SlRKskDHz5zD4Uv58yzPtUp39v+w
         VTqaywsreAl3sHKbp6XzAk7XTcqcC6Mjbbhn83SQ4vqPAT+DnxwdCInTv986s74BVV
         LfMZoyE9evLYmvfR9haTZMS439TBVCwJirjSLzwk=
Date:   Sun, 10 Nov 2019 11:27:49 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, mario.tesi@st.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: imu: st_lsm6dsx: express odr in mHZ
Message-ID: <20191110092749.GA28227@localhost.localdomain>
References: <cover.1572810064.git.lorenzo@kernel.org>
 <2b3c301e7fc808e19c5ad04a34a3bf1fa301da3c.1572810064.git.lorenzo@kernel.org>
 <20191109131940.54bbe6b4@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20191109131940.54bbe6b4@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun,  3 Nov 2019 20:47:18 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Express available frequencies in mHZ in order to support even
> > rational ODRs. This patch is need to fix an Android CTS failure
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> I've pulled the earlier fix across from the fixes-togreg branch as
> I 'think' I'll get a pull request out before the merge window
> whereas fixes will now be after.
>=20
> One thing inline that I'll fix up.
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   6 +-
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |   9 +-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 197 +++++++++---------
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  31 +--
> >  4 files changed, 126 insertions(+), 117 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 9ffc8e06f73d..8ea969e1b72b 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -106,7 +106,7 @@ struct st_lsm6dsx_sensor;
> >  struct st_lsm6dsx_hw;
> > =20
> >  struct st_lsm6dsx_odr {
> > -	u16 hz;
> > +	u32 hz; /* expressed in mHZ */
> Don't call it hz and express in it in milli hz!
>=20
> 	u32 milli_hz; will do nicely. + no
> need for comment then...

right :) Do you want to me to send a v3?

Regards,
Lorenzo

>=20
> >  	u8 val;
> >  };
> > =20
> > @@ -330,7 +330,7 @@ struct st_lsm6dsx_sensor {
> >  	struct st_lsm6dsx_hw *hw;
> > =20
> >  	u32 gain;
> > -	u16 odr;
> > +	u32 odr;
> > =20
> >  	u16 watermark;
> >  	u8 sip;
> > @@ -415,7 +415,7 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *=
hw,
> >  			     enum st_lsm6dsx_fifo_mode fifo_mode);
> >  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
> >  int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
> > -int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8=
 *val);
> > +int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8=
 *val);
> >  int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
> >  int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool =
enable);
> >  int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 31cd90d2c60e..d416990ae309 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -91,7 +91,7 @@ static int st_lsm6dsx_get_decimator_val(u8 val)
> >  }
> > =20
> >  static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
> > -				       u16 *max_odr, u16 *min_odr)
> > +				       u32 *max_odr, u32 *min_odr)
> >  {
> >  	struct st_lsm6dsx_sensor *sensor;
> >  	int i;
> > @@ -106,16 +106,17 @@ static void st_lsm6dsx_get_max_min_odr(struct st_=
lsm6dsx_hw *hw,
> >  		if (!(hw->enable_mask & BIT(sensor->id)))
> >  			continue;
> > =20
> > -		*max_odr =3D max_t(u16, *max_odr, sensor->odr);
> > -		*min_odr =3D min_t(u16, *min_odr, sensor->odr);
> > +		*max_odr =3D max_t(u32, *max_odr, sensor->odr);
> > +		*min_odr =3D min_t(u32, *min_odr, sensor->odr);
> >  	}
> >  }
> > =20
> >  static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
> >  {
> > -	u16 max_odr, min_odr, sip =3D 0, ts_sip =3D 0;
> >  	const struct st_lsm6dsx_reg *ts_dec_reg;
> >  	struct st_lsm6dsx_sensor *sensor;
> > +	u16 sip =3D 0, ts_sip =3D 0;
> > +	u32 max_odr, min_odr;
> >  	int err =3D 0, i;
> >  	u8 data;
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 2f9396745bc8..03e5cd0cfcba 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -127,12 +127,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x20,
> >  					.mask =3D GENMASK(7, 5),
> >  				},
> > -				.odr_avl[0] =3D {  10, 0x01 },
> > -				.odr_avl[1] =3D {  50, 0x02 },
> > -				.odr_avl[2] =3D { 119, 0x03 },
> > -				.odr_avl[3] =3D { 238, 0x04 },
> > -				.odr_avl[4] =3D { 476, 0x05 },
> > -				.odr_avl[5] =3D { 952, 0x06 },
> > +				.odr_avl[0] =3D {  10000, 0x01 },
> > +				.odr_avl[1] =3D {  50000, 0x02 },
> > +				.odr_avl[2] =3D { 119000, 0x03 },
> > +				.odr_avl[3] =3D { 238000, 0x04 },
> > +				.odr_avl[4] =3D { 476000, 0x05 },
> > +				.odr_avl[5] =3D { 952000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -140,12 +140,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 5),
> >  				},
> > -				.odr_avl[0] =3D {  15, 0x01 },
> > -				.odr_avl[1] =3D {  60, 0x02 },
> > -				.odr_avl[2] =3D { 119, 0x03 },
> > -				.odr_avl[3] =3D { 238, 0x04 },
> > -				.odr_avl[4] =3D { 476, 0x05 },
> > -				.odr_avl[5] =3D { 952, 0x06 },
> > +				.odr_avl[0] =3D {  14900, 0x01 },
> > +				.odr_avl[1] =3D {  59500, 0x02 },
> > +				.odr_avl[2] =3D { 119000, 0x03 },
> > +				.odr_avl[3] =3D { 238000, 0x04 },
> > +				.odr_avl[4] =3D { 476000, 0x05 },
> > +				.odr_avl[5] =3D { 952000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -229,12 +229,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -242,12 +242,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -395,12 +395,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -408,12 +408,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -570,12 +570,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -583,12 +583,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -747,12 +747,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -760,12 +760,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -944,12 +944,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -957,12 +957,12 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -1121,12 +1121,12 @@ static const struct st_lsm6dsx_settings st_lsm6=
dsx_sensor_settings[] =3D {
> >  					.addr =3D 0x10,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  			[ST_LSM6DSX_ID_GYRO] =3D {
> > @@ -1134,12 +1134,12 @@ static const struct st_lsm6dsx_settings st_lsm6=
dsx_sensor_settings[] =3D {
> >  					.addr =3D 0x11,
> >  					.mask =3D GENMASK(7, 4),
> >  				},
> > -				.odr_avl[0] =3D {  13, 0x01 },
> > -				.odr_avl[1] =3D {  26, 0x02 },
> > -				.odr_avl[2] =3D {  52, 0x03 },
> > -				.odr_avl[3] =3D { 104, 0x04 },
> > -				.odr_avl[4] =3D { 208, 0x05 },
> > -				.odr_avl[5] =3D { 416, 0x06 },
> > +				.odr_avl[0] =3D {  12500, 0x01 },
> > +				.odr_avl[1] =3D {  26000, 0x02 },
> > +				.odr_avl[2] =3D {  52000, 0x03 },
> > +				.odr_avl[3] =3D { 104000, 0x04 },
> > +				.odr_avl[4] =3D { 208000, 0x05 },
> > +				.odr_avl[5] =3D { 416000, 0x06 },
> >  				.odr_len =3D 6,
> >  			},
> >  		},
> > @@ -1358,7 +1358,7 @@ static int st_lsm6dsx_set_full_scale(struct st_ls=
m6dsx_sensor *sensor,
> >  	return 0;
> >  }
> > =20
> > -int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8=
 *val)
> > +int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8=
 *val)
> >  {
> >  	const struct st_lsm6dsx_odr_table_entry *odr_table;
> >  	int i;
> > @@ -1380,14 +1380,15 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sens=
or *sensor, u16 odr, u8 *val)
> >  	return odr_table->odr_avl[i].hz;
> >  }
> > =20
> > -static u16 st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u=
16 odr,
> > -					   enum st_lsm6dsx_sensor_id id)
> > +static int
> > +st_lsm6dsx_check_odr_dependency(struct st_lsm6dsx_hw *hw, u32 odr,
> > +				enum st_lsm6dsx_sensor_id id)
> >  {
> >  	struct st_lsm6dsx_sensor *ref =3D iio_priv(hw->iio_devs[id]);
> > =20
> >  	if (odr > 0) {
> >  		if (hw->enable_mask & BIT(id))
> > -			return max_t(u16, ref->odr, odr);
> > +			return max_t(u32, ref->odr, odr);
> >  		else
> >  			return odr;
> >  	} else {
> > @@ -1395,7 +1396,8 @@ static u16 st_lsm6dsx_check_odr_dependency(struct=
 st_lsm6dsx_hw *hw, u16 odr,
> >  	}
> >  }
> > =20
> > -static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 re=
q_odr)
> > +static int
> > +st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
> >  {
> >  	struct st_lsm6dsx_sensor *ref_sensor =3D sensor;
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > @@ -1409,7 +1411,7 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_s=
ensor *sensor, u16 req_odr)
> >  	case ST_LSM6DSX_ID_EXT1:
> >  	case ST_LSM6DSX_ID_EXT2:
> >  	case ST_LSM6DSX_ID_ACC: {
> > -		u16 odr;
> > +		u32 odr;
> >  		int i;
> > =20
> >  		/*
> > @@ -1449,7 +1451,7 @@ int st_lsm6dsx_sensor_set_enable(struct st_lsm6ds=
x_sensor *sensor,
> >  				 bool enable)
> >  {
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > -	u16 odr =3D enable ? sensor->odr : 0;
> > +	u32 odr =3D enable ? sensor->odr : 0;
> >  	int err;
> > =20
> >  	err =3D st_lsm6dsx_set_odr(sensor, odr);
> > @@ -1475,7 +1477,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6=
dsx_sensor *sensor,
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	delay =3D 1000000 / sensor->odr;
> > +	delay =3D 1000000000 / sensor->odr;
> >  	usleep_range(delay, 2 * delay);
> > =20
> >  	err =3D st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
> > @@ -1507,8 +1509,9 @@ static int st_lsm6dsx_read_raw(struct iio_dev *ii=
o_dev,
> >  		iio_device_release_direct_mode(iio_dev);
> >  		break;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		*val =3D sensor->odr;
> > -		ret =3D IIO_VAL_INT;
> > +		*val =3D sensor->odr / 1000;
> > +		*val2 =3D (sensor->odr % 1000) * 1000;
> > +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> >  		break;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val =3D 0;
> > @@ -1541,6 +1544,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *i=
io_dev,
> >  	case IIO_CHAN_INFO_SAMP_FREQ: {
> >  		u8 data;
> > =20
> > +		val =3D val * 1000 + val2 / 1000;
> >  		val =3D st_lsm6dsx_check_odr(sensor, val, &data);
> >  		if (val < 0)
> >  			err =3D val;
> > @@ -1730,8 +1734,9 @@ st_lsm6dsx_sysfs_sampling_frequency_avail(struct =
device *dev,
> > =20
> >  	odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
> >  	for (i =3D 0; i < odr_table->odr_len; i++)
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> > -				 odr_table->odr_avl[i].hz);
> > +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> > +				 odr_table->odr_avl[i].hz / 1000,
> > +				 odr_table->odr_avl[i].hz % 1000);
> >  	buf[len - 1] =3D '\n';
> > =20
> >  	return len;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index e029cc05a17f..3a0cb71ce926 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -51,10 +51,10 @@ static const struct st_lsm6dsx_ext_dev_settings st_=
lsm6dsx_ext_dev_table[] =3D {
> >  				.addr =3D 0x60,
> >  				.mask =3D GENMASK(3, 2),
> >  			},
> > -			.odr_avl[0] =3D {  10, 0x0 },
> > -			.odr_avl[1] =3D {  20, 0x1 },
> > -			.odr_avl[2] =3D {  50, 0x2 },
> > -			.odr_avl[3] =3D { 100, 0x3 },
> > +			.odr_avl[0] =3D {  10000, 0x0 },
> > +			.odr_avl[1] =3D {  20000, 0x1 },
> > +			.odr_avl[2] =3D {  50000, 0x2 },
> > +			.odr_avl[3] =3D { 100000, 0x3 },
> >  			.odr_len =3D 4,
> >  		},
> >  		.fs_table =3D {
> > @@ -94,11 +94,11 @@ static const struct st_lsm6dsx_ext_dev_settings st_=
lsm6dsx_ext_dev_table[] =3D {
> >  static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
> >  {
> >  	struct st_lsm6dsx_sensor *sensor;
> > -	u16 odr;
> > +	u32 odr;
> > =20
> >  	sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > -	odr =3D (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 13;
> > -	msleep((2000U / odr) + 1);
> > +	odr =3D (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 12=
500;
> > +	msleep((2000000U / odr) + 1);
> >  }
> > =20
> >  /**
> > @@ -318,7 +318,7 @@ st_lsm6dsx_shub_write_with_mask(struct st_lsm6dsx_s=
ensor *sensor,
> > =20
> >  static int
> >  st_lsm6dsx_shub_get_odr_val(struct st_lsm6dsx_sensor *sensor,
> > -			    u16 odr, u16 *val)
> > +			    u32 odr, u16 *val)
> >  {
> >  	const struct st_lsm6dsx_ext_dev_settings *settings;
> >  	int i;
> > @@ -337,7 +337,7 @@ st_lsm6dsx_shub_get_odr_val(struct st_lsm6dsx_senso=
r *sensor,
> >  }
> > =20
> >  static int
> > -st_lsm6dsx_shub_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
> > +st_lsm6dsx_shub_set_odr(struct st_lsm6dsx_sensor *sensor, u32 odr)
> >  {
> >  	const struct st_lsm6dsx_ext_dev_settings *settings;
> >  	u16 val;
> > @@ -442,7 +442,7 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sens=
or *sensor,
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	delay =3D 1000000 / sensor->odr;
> > +	delay =3D 1000000000 / sensor->odr;
> >  	usleep_range(delay, 2 * delay);
> > =20
> >  	len =3D min_t(int, sizeof(data), ch->scan_type.realbits >> 3);
> > @@ -482,8 +482,9 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
> >  		iio_device_release_direct_mode(iio_dev);
> >  		break;
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		*val =3D sensor->odr;
> > -		ret =3D IIO_VAL_INT;
> > +		*val =3D sensor->odr / 1000;
> > +		*val2 =3D (sensor->odr % 1000) * 1000;
> > +		ret =3D IIO_VAL_INT_PLUS_MICRO;
> >  		break;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val =3D 0;
> > @@ -514,6 +515,7 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> >  	case IIO_CHAN_INFO_SAMP_FREQ: {
> >  		u16 data;
> > =20
> > +		val =3D val * 1000 + val2 / 1000;
> >  		err =3D st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
> >  		if (!err)
> >  			sensor->odr =3D val;
> > @@ -540,9 +542,10 @@ st_lsm6dsx_shub_sampling_freq_avail(struct device =
*dev,
> > =20
> >  	settings =3D sensor->ext_info.settings;
> >  	for (i =3D 0; i < settings->odr_table.odr_len; i++) {
> > -		u16 val =3D settings->odr_table.odr_avl[i].hz;
> > +		u32 val =3D settings->odr_table.odr_avl[i].hz;
> > =20
> > -		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d ", val);
> > +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> > +				 val / 1000, val % 1000);
> >  	}
> >  	buf[len - 1] =3D '\n';
> > =20
>=20

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXcfYEgAKCRA6cBh0uS2t
rJ4jAP43UhXgrdASg56PVGhY0s3PMLcnRdrJYk+ZXsPG66l+7gEAyCjXNo9trnVv
v2RXUkA5yyj4tRokisXTaKXwZrAWbgs=
=n2u0
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
