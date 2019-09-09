Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C35AD85A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfIILzm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 07:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbfIILzm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 07:55:42 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EDD1218DE;
        Mon,  9 Sep 2019 11:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568030141;
        bh=pXjmfgtrpj8ykRrx+Seo1MZ8JDzcWGpkJJiP3UY+Ly8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/EviCcSLVZ1CXrDW/8re4LDTIou1k6K1OReHKjttnvjniFHgxKdzhfdTGUNcZ7Qt
         LL9XYOyNOokze3DyWs1uXO7xBKnNfdg5GGQ3mPrEU0+YDfLOZV4VDN5U7/v9HzVt3p
         P8APw87bQgOZvRP5fqv0QMhvD9yb1dkPoekVJjeM=
Date:   Mon, 9 Sep 2019 13:55:35 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v6 6/6] iio: imu: st_lsm6dsx: prohibit the use of events
 and buffered reads simultaneously
Message-ID: <20190909115535.GD2990@localhost.localdomain>
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-6-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <20190909112846.55280-6-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--a2FkP9tdjPU2nyhF
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
>  * Use fifo configuration mutex to prevent a race in hw->enable_event che=
ck.
>=20
> Changes since v5:
>  * Updated do not return without unlocking mutexes
>  * Lock mutex before unlock
>  * Runtime tested ;-)
>=20

[...]

> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1340,8 +1340,12 @@ static int st_lsm6dsx_write_event_config(struct ii=
o_dev *iio_dev,
>  	if (type !=3D IIO_EV_TYPE_THRESH)
>  		return -EINVAL;
> =20
> -	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS)
> -		return -EBUSY;
> +	mutex_lock(&hw->conf_lock);
> +
> +	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS) {
> +		err =3D -EBUSY;
> +		goto out;
> +	}

This patch is still broken!!! Returning in case of error you need to relase=
 the
lock.

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

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXY9tAAKCRA6cBh0uS2t
rNIQAQCRjPYpgZSqtFZhNjyjc7G9xTcuMMO9YOV6TZX2eaojNgEAm0twbzc9Ymwa
r42wNMYMpxKjxNmLFsOoX+W33FiYpgA=
=XjjF
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
