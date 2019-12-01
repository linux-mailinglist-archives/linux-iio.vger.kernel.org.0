Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9CE10E383
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 22:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLAVEf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 16:04:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfLAVEf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 16:04:35 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47752082E;
        Sun,  1 Dec 2019 21:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575234273;
        bh=aTj00xVxGABTEueFhLZdMkIabOwKpqgPTN1Q+eEDRQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yefIhDYC305svqRCjjgR8QFamXA9athzOgT3Vd2NVGMw/CtW+I/+lskaOd0OoUtxe
         3xarrTk/sQ60lwj+HNjgLIZh5Mm06/oJ5llMvQ9W9eytXnYEX2YEjnjLOOP5ae0tst
         NQ13W8p0iEkeTygtSGb9IE/NVjA5IOzmD8IVF8Yk=
Date:   Sun, 1 Dec 2019 23:04:26 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        sean@geanix.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: track hw FIFO buffering with
 fifo_mask
Message-ID: <20191201210426.GA11638@localhost.localdomain>
References: <844cd314df8ff354859bad1e43b13778f60b08bb.1574954314.git.lorenzo@kernel.org>
 <20191201204936.0c4c3ded@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <20191201204936.0c4c3ded@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 28 Nov 2019 17:42:30 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Track hw FIFO state introducing fifo_mask since now the accel sensor
> > can be enabled during suspend/resume in order to trigger the wake-up
> > enabling the FIFO in st_lsm6dsx_resume even if it was disabled before
> > the suspend
>=20
> What is the user visible result of not having this patch?
>=20
> Otherwise looks fine to me.

Hi Jonathan,

I discovered the issue looking at the code. The main point here is after co=
mmit
4c997dfa692d enable_mask can be modified even by event code and not just by
FIFO one, so it can't be used to track FIFO status (e.g during suspend-resu=
me).

Regards,
Lorenzo

>=20
> Jonathan
>=20
> >=20
> > Fixes: 4c997dfa692d ("iio: imu: st_lsm6dsx: add wakeup-source option")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +--
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 25 +++++++++++--------
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  4 +--
> >  3 files changed, 18 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index c605b153be41..b54aefcdaad4 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -351,9 +351,9 @@ struct st_lsm6dsx_sensor {
> >   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
> >   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
> >   * @page_lock: Mutex to prevent concurrent memory page configuration.
> > - * @fifo_mode: FIFO operating mode supported by the device.
> >   * @suspend_mask: Suspended sensor bitmask.
> >   * @enable_mask: Enabled sensor bitmask.
> > + * @fifo_mask: Enabled hw FIFO bitmask.
> >   * @ts_gain: Hw timestamp rate after internal calibration.
> >   * @ts_sip: Total number of timestamp samples in a given pattern.
> >   * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
> > @@ -373,9 +373,9 @@ struct st_lsm6dsx_hw {
> >  	struct mutex conf_lock;
> >  	struct mutex page_lock;
> > =20
> > -	enum st_lsm6dsx_fifo_mode fifo_mode;
> >  	u8 suspend_mask;
> >  	u8 enable_mask;
> > +	u8 fifo_mask;
> >  	s64 ts_gain;
> >  	u8 ts_sip;
> >  	u8 sip;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index d416990ae309..bfd4c6306c0b 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -176,17 +176,10 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw=
 *hw,
> >  			     enum st_lsm6dsx_fifo_mode fifo_mode)
> >  {
> >  	unsigned int data;
> > -	int err;
> > =20
> >  	data =3D FIELD_PREP(ST_LSM6DSX_FIFO_MODE_MASK, fifo_mode);
> > -	err =3D st_lsm6dsx_update_bits_locked(hw, ST_LSM6DSX_REG_FIFO_MODE_AD=
DR,
> > -					    ST_LSM6DSX_FIFO_MODE_MASK, data);
> > -	if (err < 0)
> > -		return err;
> > -
> > -	hw->fifo_mode =3D fifo_mode;
> > -
> > -	return 0;
> > +	return st_lsm6dsx_update_bits_locked(hw, ST_LSM6DSX_REG_FIFO_MODE_ADD=
R,
> > +					     ST_LSM6DSX_FIFO_MODE_MASK, data);
> >  }
> > =20
> >  static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
> > @@ -608,11 +601,17 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *h=
w)
> >  int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enab=
le)
> >  {
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +	u8 fifo_mask;
> >  	int err;
> > =20
> >  	mutex_lock(&hw->conf_lock);
> > =20
> > -	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS) {
> > +	if (enable)
> > +		fifo_mask =3D hw->fifo_mask | BIT(sensor->id);
> > +	else
> > +		fifo_mask =3D hw->fifo_mask & ~BIT(sensor->id);
> > +
> > +	if (hw->fifo_mask) {
> >  		err =3D st_lsm6dsx_flush_fifo(hw);
> >  		if (err < 0)
> >  			goto out;
> > @@ -642,15 +641,19 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sens=
or *sensor, bool enable)
> >  	if (err < 0)
> >  		goto out;
> > =20
> > -	if (hw->enable_mask) {
> > +	if (fifo_mask) {
> >  		/* reset hw ts counter */
> >  		err =3D st_lsm6dsx_reset_hw_ts(hw);
> >  		if (err < 0)
> >  			goto out;
> > =20
> >  		err =3D st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > +		if (err < 0)
> > +			goto out;
> >  	}
> > =20
> > +	hw->fifo_mask =3D fifo_mask;
> > +
> >  out:
> >  	mutex_unlock(&hw->conf_lock);
> > =20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 11b2c7bc8041..6f628c3cd133 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2300,7 +2300,7 @@ static int __maybe_unused st_lsm6dsx_suspend(stru=
ct device *dev)
> >  		hw->suspend_mask |=3D BIT(sensor->id);
> >  	}
> > =20
> > -	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS)
> > +	if (hw->fifo_mask)
> >  		err =3D st_lsm6dsx_flush_fifo(hw);
> > =20
> >  	return err;
> > @@ -2336,7 +2336,7 @@ static int __maybe_unused st_lsm6dsx_resume(struc=
t device *dev)
> >  		hw->suspend_mask &=3D ~BIT(sensor->id);
> >  	}
> > =20
> > -	if (hw->enable_mask)
> > +	if (hw->fifo_mask)
> >  		err =3D st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> > =20
> >  	return err;
>=20

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXeQq1wAKCRA6cBh0uS2t
rFnxAQCZ7iEdbeso4av3117cohpMH/wf12x4ljCzi9zr7zi/ygEAlWEcQQbwd53i
xoYvTcZ0KxFK9OYjVQi0I+7XZlF//ww=
=PTzJ
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
