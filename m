Return-Path: <linux-iio+bounces-16528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D772DA56AA8
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E0E7A54D5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC4921C176;
	Fri,  7 Mar 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3fs8try"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEC21ABC3;
	Fri,  7 Mar 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358455; cv=none; b=dc/1t77VICnvjTw/yGRSgXwz+2LRY37lVaCfMg4cULSVPd5W7q7seP4HvJR3HXOLO3z0Ijc91yTrlTUvLYyFz0doUiCaA+WV2kB5KsQdjG9za6atfrVBQ0lVlB0TLA+xg8JeadZhowxJym6bsqSoY4IkPAsaHMc6Qxrf8MnaEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358455; c=relaxed/simple;
	bh=gqX4hzoJ+7QuIXnn42nyeKsoGFR9a03BNc0pBhEEqDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSAKRi9wkZLB6s9AUdB9rZX2V6fisgM9k75qO60LA1rfPvHtmVQQiR9CFOfmUWybolkNfXYWfQiXVDQLj9QWomTajaNFRQdxahkBstrWo9l+QnzGIUjsKVwgvk4GD8ZpFGr8xx8i+QHNgcoAqYf4CEydLf26xIvsMU9t9YooTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3fs8try; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06349C4CED1;
	Fri,  7 Mar 2025 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741358455;
	bh=gqX4hzoJ+7QuIXnn42nyeKsoGFR9a03BNc0pBhEEqDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3fs8tryLeCeqoR6gkGGpggRU0Apu4sSNSVQi1oBZYBUmSsMmRzNqowPnkJt7SFiw
	 JK2A5vZDvMSaG0oWWahrDnrv1v1i+X+xB/OGEN0q/KuO/mI+8fN+EMoLLdsiaPkZfN
	 V6FZKXEWHP8Xiu7nmXcGWQBqhnoLClWjHc5dL7ZBFiQIaSTARiIyOjUqNVIID1P6za
	 rpJWtwep+Hn/tPbCoNilLIpWVh+3dLR5Lhrs2P/rUt14NlPj3xz4nRH+GOtEaWiBuK
	 wIum5IhwbMYES5Mid/CC9/Xd6LIqoggx1SUaXwxYFv7SoJ7KiCKpONAcY6QQhQdrQu
	 IzMcyQ4w8hQwg==
Date: Fri, 7 Mar 2025 15:40:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Silvano Seva <s.seva@4sigma.it>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"open list:ST LSM6DSx IMU IIO DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO
 read
Message-ID: <Z8sFdGG4bDyALrsi@lore-desk>
References: <20250303132124.52811-2-s.seva@4sigma.it>
 <Z8nDzyVO596rW0Mf@lore-desk>
 <CALKJsrqc__ZeLoZ5V+hBxVMU+Crpv_YG0KM69N1CXuHc_rM-FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oUCIrKhfoEupLwpQ"
Content-Disposition: inline
In-Reply-To: <CALKJsrqc__ZeLoZ5V+hBxVMU+Crpv_YG0KM69N1CXuHc_rM-FQ@mail.gmail.com>


--oUCIrKhfoEupLwpQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Mar 6, 2025 at 4:48=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:
> >
> > > Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
> > > from falling in an infinite loop in case pattern_len is equal to zero=
 and
> > > the device FIFO is not empty.
> > >
> > > Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index 0a7cd8c1aa33..7f343614f8a5 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -395,12 +395,17 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *=
hw)
> > >       fifo_len =3D (le16_to_cpu(fifo_status) & fifo_diff_mask) *
> > >                  ST_LSM6DSX_CHAN_SIZE;
> > >       fifo_len =3D (fifo_len / pattern_len) * pattern_len;
> > > +     if (!fifo_len)
> > > +             return 0;
> >
> > I do not think this check is necessary since if fifo_len is 0 we will n=
ot run
> > the for loop, right?
>=20
> This check is present in the st_lsm6dsx_read_tagged_fifo() function, i
> added it here for consistency. I agree with you that is not strictly
> necessary.
>=20
> >
> > >
> > >       acc_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > >       gyro_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> > >       if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
> > >               ext_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0=
]);
> > >
> > > +     if (!pattern_len)
> > > +             pattern_len =3D ST_LSM6DSX_SAMPLE_SIZE;
> >
> > same here, I do not think pattern_len can be 0 since hw->sip must be gr=
eater
> > than 0 in order to enable the FIFO. Moreover, this check should be some=
 lines
> > above since we have already divided fifo_len by pattern_len here.
> >
>=20
> There is a situation causing the subsequent for loop to never
> terminate, hanging the kernel boot process: given a system which
> doesn't have an hardware reset line allowing the kernel to
> re-initialize the IMU hardware, in case of an hot reboot the driver
> probe() function attempts to flush the FIFO, which may contain some
> data, while the hw->sip is zero.
> The complete execution path is the following:
> - call of st_lsm6dsx_probe();
> - allocation of the st_lsm6dsx_hw structure via the devm_kzalloc,
> zero-initializing the sip field;
> - call of st_lsm6dsx_init_device();
> - call of st_lsm6dsx_reset_device();
> - call of st_lsm6dsx_flush_fifo();
> - call of st_lsm6dsx_read_fifo/st_lsm6dsx_read_tagged_fifo via the
> fifo_ops function pointer.

ack, I can see the issue now, thx for pointing this out. I should we should=
 set
pattern_len to ST_LSM6DSX_SAMPLE_SIZE or ST_LSM6DSX_TAGGED_SAMPLE_SIZE if i=
t is
0. Can you please move the check before updating fifo_len in
st_lsm6dsx_read_fifo()?

Regards,
Lorenzo

>=20
> An alternative solution to solve this situation is initializing the
> hw->sip field to a sane default value in either the probe() or
> init_device() function.
>=20
> > > +
> > >       for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern=
_len) {
> > >               err =3D st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_O=
UTL_ADDR,
> > >                                           hw->buff, pattern_len,
> > > @@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx=
_hw *hw)
> > >       if (!fifo_len)
> > >               return 0;
> > >
> > > +     if (!pattern_len)
> > > +             pattern_len =3D ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
> >
> > for the reason above, this is not necessary.
> >
> > Regards,
> > Lorenzo
> >
> > > +
> > >       for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern=
_len) {
> > >               err =3D st_lsm6dsx_read_block(hw,
> > >                                           ST_LSM6DSX_REG_FIFO_OUT_TAG=
_ADDR,
> > > --
> > > 2.48.1
> > >

--oUCIrKhfoEupLwpQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ8sFdAAKCRA6cBh0uS2t
rKn+AQD6DYrrbcyM5r9RwPVBgWd6ZHejDs4Bc4gvn+vJU7JNygEA+YKCHSuJ2RKX
D4s0eQ3y/D/VFULCAElOvu1tjuJNYQw=
=fTxQ
-----END PGP SIGNATURE-----

--oUCIrKhfoEupLwpQ--

