Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C80FF1178D3
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2019 22:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIVs6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Dec 2019 16:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIVs6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Dec 2019 16:48:58 -0500
Received: from localhost.localdomain (unknown [66.187.232.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 670A1205C9;
        Mon,  9 Dec 2019 21:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575928138;
        bh=9gyMGCpUfK0Z2nH5lmis/XJn1df0ZkjTJ8u3LzW7ht4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8TXP/UK+Ia3jwN75ugXmLIBe9iFqd2l3M/ebMy4aX7+X/CELQheqSis4WHFVhZuU
         yr4Uq9XkQ6oHNKsjtGgzgcq6rwN6y/UQjh3moTzcyJduyUsa0/DphIId9dfz96KEVH
         JIovK5PMuI8QGr+lpbB0pZ95NRLNK+qgJhf0oiHY=
Date:   Mon, 9 Dec 2019 22:48:52 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix selection of ST_LSM6DS3_ID
Message-ID: <20191209214852.GA2485@localhost.localdomain>
References: <20191209170541.198206-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20191209170541.198206-1-stephan@gerhold.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> At the moment, attempting to probe a device with ST_LSM6DS3_ID
> (e.g. using the st,lsm6ds3 compatible) fails with:
>=20
>     st_lsm6dsx_i2c 1-006b: unsupported whoami [69]
>=20
> ... even though 0x69 is the whoami listed for ST_LSM6DS3_ID.
>=20

Hi Stephan,

thx for working on this. I guess we can skip 'void' iterations defining the
array real size, do you agree?

Regards,
Lorenzo

> This happens because st_lsm6dsx_check_whoami() also attempts
> to match unspecified (zero-initialized) entries in the "id" array.
> ST_LSM6DS3_ID =3D 0 will therefore match any entry in
> st_lsm6dsx_sensor_settings (here: the first), because none of them
> actually have all 12 entries listed in the "id" array.
>=20
> Avoid this by additionally checking if "name" is set,
> which is only set for valid entries in the "id" array.
>=20
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index a7d40c02ce6b..b921dd9e108f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1301,7 +1301,8 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6ds=
x_hw *hw, int id,
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>  		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> -			if (id =3D=3D st_lsm6dsx_sensor_settings[i].id[j].hw_id)
> +			if (st_lsm6dsx_sensor_settings[i].id[j].name &&
> +			    id =3D=3D st_lsm6dsx_sensor_settings[i].id[j].hw_id)
>  				break;
>  		}
>  		if (j < ST_LSM6DSX_MAX_ID)
> --=20
> 2.24.0
>=20

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXe7BQQAKCRA6cBh0uS2t
rGbZAQD9aJzFBRQPLrP0yRNxHaxmdFcGIHsFFBbhgHNeV4Ip1QD/RgfUJKxuV74S
5qYpMmK/hwqXeBMzhdvQBTaEf41GjQk=
=5yLa
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
