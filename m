Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54C4428CF2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 14:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbhJKMYY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 08:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235265AbhJKMYY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Oct 2021 08:24:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FAE96103C;
        Mon, 11 Oct 2021 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633954944;
        bh=/QnEv1xD/5F9URyth9vOu5zJtPpK8bHG/0gUXBb2tD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mo2bIH80bHWD/H0LfDIxbWThcvfqc46xSFmqeGEz9RQFFpd3oPKWJdVOpXKId7qkC
         XU2LCqJxoHZPkx5Q+FnPrCFzj2phWq3U3vKJVwLBRpxuPuU6Yqec5NJOTETwVfz06/
         bVoOpwlXE5eRq+OI2pzbauaw33t6THOdeq8nyb2sBkxUJ/6fve+HFk47j6Y3bTiWsK
         mSz7M/OU5XSRv69wSYFFxrSPC/kNyWSzJJ8vN5LUET3WU6BReqpTM6lfwAlZpsOQ2T
         1LVja+2cb+UeYYdA776X6fqe2oYGQfpRR+iDY/OLmS8D/fKBzEJ00X/eLSFNfPeHal
         FmAgSQdrM72TQ==
Date:   Mon, 11 Oct 2021 14:22:19 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Teng Qi <starmiku1207184332@gmail.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        islituo@gmail.com, baijiaju1990@gmail.com,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: Fix an array overflow in
 st_lsm6dsx_set_odr()
Message-ID: <YWQse08lZHMBe+LX@lore-desk>
References: <20211011114003.976221-1-starmiku1207184332@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2KpGVdIh+KuPc6U4"
Content-Disposition: inline
In-Reply-To: <20211011114003.976221-1-starmiku1207184332@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--2KpGVdIh+KuPc6U4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The length of hw->settings->odr_table is 2 and ref_sensor->id is an enum
> variable whose value is between 0 and 5.
> However, the value ST_LSM6DSX_ID_MAX (i.e. 5) is not catched properly in
>  switch (sensor->id) {
>=20
> If ref_sensor->id is ST_LSM6DSX_ID_MAX, an array overflow will ocurrs in
> function st_lsm6dsx_check_odr():
>   odr_table =3D &sensor->hw->settings->odr_table[sensor->id];
>=20
> and in function st_lsm6dsx_set_odr():
>   reg =3D &hw->settings->odr_table[ref_sensor->id].reg;
>=20
> To fix this array overflow, handle ST_LSM6DSX_ID_GYRO explicitly and=20
> return -EINVAL for the default case.
>=20
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Teng Qi <starmiku1207184332@gmail.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ---
> v2:
> * explicitly handle ST_LSM6DSX_ID_GYRO and return -EINVAL for the default
> case instead of adding an if statement behind the switch statement.
>   Thank Lars-Peter Clausen for helpful and friendly advice.
>=20
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index db45f1fc0b81..8dbf744c5651 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1279,6 +1279,8 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor=
, u32 req_odr)
>  	int err;
> =20
>  	switch (sensor->id) {
> +	case ST_LSM6DSX_ID_GYRO:
> +		break;
>  	case ST_LSM6DSX_ID_EXT0:
>  	case ST_LSM6DSX_ID_EXT1:
>  	case ST_LSM6DSX_ID_EXT2:
> @@ -1304,8 +1306,8 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor=
, u32 req_odr)
>  		}
>  		break;
>  	}
> -	default:
> -		break;
> +	default: /* should never occur */
> +		return -EINVAL;
>  	}
> =20
>  	if (req_odr > 0) {
> --=20
> 2.25.1
>=20

--2KpGVdIh+KuPc6U4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYWQsewAKCRA6cBh0uS2t
rJRWAP9CkcfmV7Pu2wSiMOuexrKseKLKswds6xDcSISAWMUDkQEAko4bYSceDztN
6B37279yEtGu4BxzoBB3fm9FC6ox9A4=
=l7Sn
-----END PGP SIGNATURE-----

--2KpGVdIh+KuPc6U4--
