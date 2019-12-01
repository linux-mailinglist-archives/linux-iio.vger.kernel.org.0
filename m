Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7A110E386
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 22:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLAVHf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 16:07:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfLAVHe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 16:07:34 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A481C20865;
        Sun,  1 Dec 2019 21:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575234453;
        bh=cuSlEG1GQQmHc4bZWhkgI61EDZfrxMD+Q/WrgWXNnIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gsaCHjFwewXoRhloCPM0oLoYkkx6hMegJIiBYMUrhbEouyvgwZz/DakgjDV+7Fgsp
         aNuHa4HK5AvA4ERI/sTurmNGZrSKLNXvblqZCscZfUOSJT461wBUu7G4oNr35yMyIM
         ycexMcQ9p9Rs9dBvxQm0ek5Ynxs6Ke5r+mDHrAM4=
Date:   Sun, 1 Dec 2019 23:07:27 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        sean@geanix.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not power-off accel if events
 are enabled
Message-ID: <20191201210727.GB11638@localhost.localdomain>
References: <f245c67b9eff976fbc264affb1f6135c51222b4d.1575019621.git.lorenzo@kernel.org>
 <20191201210151.5aa8c4c3@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20191201210151.5aa8c4c3@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 29 Nov 2019 11:37:24 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Do not power-off accel unconditionally if wake-up events are enabled
> > powering off the hw FIFO. At the same time do not power-off the accel
> > sensor if it is 'batched' in the hw FIFO disabling sensor events
> >=20
> > Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> > Tested-by: Sean Nyekjaer <sean@geanix.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Not applied as this seems to be dependent on one of the earlier patches.
> Please put them in a series and resend.

Hi Jonathan,

Sorry for the noise, but I discovered the issue after I have already sent
the other patch out. I will post them together in v2.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
> > ---
> > This patch is based on https://patchwork.kernel.org/patch/11266301/
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++++---
> >  1 file changed, 26 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 13590c041d22..990643da9f4e 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1447,8 +1447,9 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sens=
or, u32 req_odr)
> >  	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
> >  }
> > =20
> > -int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> > -				 bool enable)
> > +static int
> > +__st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> > +			       bool enable)
> >  {
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> >  	u32 odr =3D enable ? sensor->odr : 0;
> > @@ -1466,6 +1467,26 @@ int st_lsm6dsx_sensor_set_enable(struct st_lsm6d=
sx_sensor *sensor,
> >  	return 0;
> >  }
> > =20
> > +static int
> > +st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
> > +{
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +
> > +	if (sensor->id =3D=3D ST_LSM6DSX_ID_GYRO || enable)
> > +		return 0;
> > +
> > +	return hw->enable_event;
> > +}
> > +
> > +int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> > +				 bool enable)
> > +{
> > +	if (st_lsm6dsx_check_events(sensor, enable))
> > +		return 0;
> > +
> > +	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
> > +}
> > +
> >  static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
> >  				   u8 addr, int *val)
> >  {
> > @@ -1662,7 +1683,7 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio=
_dev,
> >  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> >  	u8 enable_event;
> > -	int err =3D 0;
> > +	int err;
> > =20
> >  	if (type !=3D IIO_EV_TYPE_THRESH)
> >  		return -EINVAL;
> > @@ -1690,7 +1711,8 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio=
_dev,
> >  		return err;
> > =20
> >  	mutex_lock(&hw->conf_lock);
> > -	err =3D st_lsm6dsx_sensor_set_enable(sensor, state);
> > +	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
> > +		err =3D __st_lsm6dsx_sensor_set_enable(sensor, state);
> >  	mutex_unlock(&hw->conf_lock);
> >  	if (err < 0)
> >  		return err;
>=20

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeQrjAAKCRA6cBh0uS2t
rIeoAQDQH5CzLYbZtQudLZcYwt2FdT6C6EbeFIwk0lLGt8ObagD/VF66aL/FZ5jd
WCglyoLmTwSNzZk0vHa1wK+wd4v6rwI=
=IeFZ
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
