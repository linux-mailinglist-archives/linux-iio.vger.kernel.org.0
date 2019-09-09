Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB82AD709
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfIIKkm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 06:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfIIKkm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 06:40:42 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B20F2086D;
        Mon,  9 Sep 2019 10:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568025641;
        bh=32c+HNdFGsjT/s/hEv+Ik9zsAW/BsQRzll/yK22hDs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jpg2c6QKuSkcP9JvR4ttlQgqraX1e0rr7n9V5yhEycl7hAntFhst4s7qyStosv9tK
         v3RngL6hWI71iqzeXYebtC4SkD4CjBu+vc1zZ4Ma4+G4oHZkmzd6sJVUqBTFibSUQi
         YlWkL+iWpctN8u+mJByKkQYeaSyDa7dvIdeqs1fY=
Date:   Mon, 9 Sep 2019 12:40:35 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v5.1 6/6] iio: imu: st_lsm6dsx: prohibit the use of
 events and buffered reads simultaneously
Message-ID: <20190909104035.GB2990@localhost.localdomain>
References: <20190909094506.51792-6-sean@geanix.com>
 <20190909095618.70801-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20190909095618.70801-1-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When events and buffered reads is enabled simultaneously, and the first
> event accours the interrupt pin stays high.
>=20
> This can be reverted when we find a solution to allow events and
> buffered reads simultaneously.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v4:
>  * Use fifo configuration mutex to prevent a race in hw->enable_event
>    check.
>=20
> Changes since v5:
>  * Updated do not return without unlocking mutexes
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  5 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 13 ++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index ef579650fd52..b87a1872bc60 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -603,6 +603,11 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor =
*sensor, bool enable)
> =20
>  	mutex_lock(&hw->conf_lock);
> =20
> +	if (hw->enable_event) {
> +		err =3D -EBUSY;
> +		goto out;
> +	}
> +
>  	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS) {
>  		err =3D st_lsm6dsx_flush_fifo(hw);
>  		if (err < 0)
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 00ba14d15c13..a13d0c154b82 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1340,8 +1340,12 @@ static int st_lsm6dsx_write_event_config(struct ii=
o_dev *iio_dev,
>  	if (type !=3D IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
> =20
> -	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS)
> -		return -EBUSY;
> +	mutex_unlock(&hw->conf_lock);

I _really_ do not think you are testing these patches since there are plent=
y of
errors here:

1- mutex_unlock instead of mutex_lock
2- returning without releasing the lock

Please put more attention next time and test you patches

Lorenzo

> +
> +	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS) {
> +		err =3D -EBUSY;
> +		goto out;
> +	}
> =20
>  	/* do not enable events if they are already enabled */
>  	if (state && hw->enable_event)
> @@ -1357,7 +1361,10 @@ static int st_lsm6dsx_write_event_config(struct ii=
o_dev *iio_dev,
> =20
>  	hw->enable_event =3D state;
> =20
> -	return 0;
> +out:
> +	mutex_unlock(&hw->conf_lock);
> +
> +	return err;
>  }
> =20
>  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
> --=20
> 2.23.0
>=20

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXYsIQAKCRA6cBh0uS2t
rDJwAQDohtkoPc1pDOOclCeLyb0iY9BEK0D2XyWWhCnM1j+B8QD+IbEt1HRA3TxE
nlYcOIw8g+Sg8/H7gy43Ab1amFw8wAA=
=4sAO
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
