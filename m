Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76C392276
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 13:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfHSLdP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Aug 2019 07:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfHSLdO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Aug 2019 07:33:14 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC92220851;
        Mon, 19 Aug 2019 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566214394;
        bh=lFgUwN+mEKLWMP+NbGrkKMvvXfwKq4GJKm745lG5vDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w9Yp8/U6H3H2tqY1hubgdoGyc0kfA49kb9T0RgNn6vEjFxsp5IpbNZs+9St0k0UfU
         FG68qEGemPdfFff/ch9akNnzn/KoQaTNpVzPsCvj6CNvEQnMmkD/zZrFpcb22LtzKF
         JuOG3A3jGdsLZ2rnP2LZOxxzDkVrIpiEqaRnEqK8=
Date:   Mon, 19 Aug 2019 13:33:08 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     jic23@kernel.org, lorenzo.bianconi@redhat.com,
        linux-iio@vger.kernel.org, martin.kepplinger@puri.sm
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: introduce update_fifo function
 pointer
Message-ID: <20190819113308.GC17835@localhost.localdomain>
References: <0f40946687ebed533028e2a8eb2bf6756e49b6e1.1566208999.git.lorenzo@kernel.org>
 <20190819115126.0000185d@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <20190819115126.0000185d@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 19 Aug 2019 12:06:05 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Introduce update_fifo routine pointer in st_lsm6dsx_fifo_ops data
> > structure since we will need a different update FIFO configuration
> > callback adding support for lsm6ds0/lsm9ds1 imu device
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> I'm fine with the patch itself, but would much rather pick this up as a f=
irst
> patch in the series that makes use of it.  Right now it is an unjustified=
 bit
> of refactoring..

Martin can fold this as first patch of v5, up to you.

Regards,
Lorenzo

>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 ++++
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 19 +++++++++++++++----
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  6 ++++++
> >  3 files changed, 25 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 4e8e67ae1632..055e52dec36a 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -75,6 +75,7 @@ struct st_lsm6dsx_reg {
> >  	u8 mask;
> >  };
> > =20
> > +struct st_lsm6dsx_sensor;
> >  struct st_lsm6dsx_hw;
> > =20
> >  struct st_lsm6dsx_odr {
> > @@ -101,12 +102,14 @@ struct st_lsm6dsx_fs_table_entry {
> > =20
> >  /**
> >   * struct st_lsm6dsx_fifo_ops - ST IMU FIFO settings
> > + * @update_fifo: Update FIFO configuration callback.
> >   * @read_fifo: Read FIFO callback.
> >   * @fifo_th: FIFO threshold register info (addr + mask).
> >   * @fifo_diff: FIFO diff status register info (addr + mask).
> >   * @th_wl: FIFO threshold word length.
> >   */
> >  struct st_lsm6dsx_fifo_ops {
> > +	int (*update_fifo)(struct st_lsm6dsx_sensor *sensor, bool enable);
> >  	int (*read_fifo)(struct st_lsm6dsx_hw *hw);
> >  	struct {
> >  		u8 addr;
> > @@ -327,6 +330,7 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
> >  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val=
);
> >  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
> >  				u16 watermark);
> > +int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enab=
le);
> >  int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
> >  int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
> >  			     enum st_lsm6dsx_fifo_mode fifo_mode);
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 2c03a5b80f80..b0f3da1976e4 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -602,9 +602,8 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
> >  	return err;
> >  }
> > =20
> > -static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
> > +int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enab=
le)
> >  {
> > -	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> >  	int err;
> > =20
> > @@ -676,12 +675,24 @@ static irqreturn_t st_lsm6dsx_handler_thread(int =
irq, void *private)
> > =20
> >  static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
> >  {
> > -	return st_lsm6dsx_update_fifo(iio_dev, true);
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +
> > +	if (!hw->settings->fifo_ops.update_fifo)
> > +		return -ENOTSUPP;
> > +
> > +	return hw->settings->fifo_ops.update_fifo(sensor, true);
> >  }
> > =20
> >  static int st_lsm6dsx_buffer_postdisable(struct iio_dev *iio_dev)
> >  {
> > -	return st_lsm6dsx_update_fifo(iio_dev, false);
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +
> > +	if (!hw->settings->fifo_ops.update_fifo)
> > +		return -ENOTSUPP;
> > +
> > +	return hw->settings->fifo_ops.update_fifo(sensor, false);
> >  }
> > =20
> >  static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops =3D {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 85824d6739ee..0aa93b45d772 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -154,6 +154,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  		},
> >  		.fifo_ops =3D {
> > +			.update_fifo =3D st_lsm6dsx_update_fifo,
> >  			.read_fifo =3D st_lsm6dsx_read_fifo,
> >  			.fifo_th =3D {
> >  				.addr =3D 0x06,
> > @@ -262,6 +263,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  		},
> >  		.fifo_ops =3D {
> > +			.update_fifo =3D st_lsm6dsx_update_fifo,
> >  			.read_fifo =3D st_lsm6dsx_read_fifo,
> >  			.fifo_th =3D {
> >  				.addr =3D 0x06,
> > @@ -379,6 +381,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  		},
> >  		.fifo_ops =3D {
> > +			.update_fifo =3D st_lsm6dsx_update_fifo,
> >  			.read_fifo =3D st_lsm6dsx_read_fifo,
> >  			.fifo_th =3D {
> >  				.addr =3D 0x06,
> > @@ -490,6 +493,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  		},
> >  		.fifo_ops =3D {
> > +			.update_fifo =3D st_lsm6dsx_update_fifo,
> >  			.read_fifo =3D st_lsm6dsx_read_tagged_fifo,
> >  			.fifo_th =3D {
> >  				.addr =3D 0x07,
> > @@ -616,6 +620,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  		},
> >  		.fifo_ops =3D {
> > +			.update_fifo =3D st_lsm6dsx_update_fifo,
> >  			.read_fifo =3D st_lsm6dsx_read_tagged_fifo,
> >  			.fifo_th =3D {
> >  				.addr =3D 0x07,
> > @@ -719,6 +724,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
> >  			},
> >  		},
> >  		.fifo_ops =3D {
> > +			.update_fifo =3D st_lsm6dsx_update_fifo,
> >  			.read_fifo =3D st_lsm6dsx_read_tagged_fifo,
> >  			.fifo_th =3D {
> >  				.addr =3D 0x07,
>=20
>=20

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXVqI8QAKCRA6cBh0uS2t
rL1BAQC6jzVvLyVtYAVECHw9wk/WHxCkxHNzSTV9vRm0A2KZKwD8CXI3MEv1b6aO
ZTHGW6dK2/gOfVHWcfUAVVecIjepCgs=
=x/9C
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
