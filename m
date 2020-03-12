Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E596182B92
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 09:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCLIvX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 04:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgCLIvX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 12 Mar 2020 04:51:23 -0400
Received: from lore-desk-wlan (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F374D20578;
        Thu, 12 Mar 2020 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584003082;
        bh=UOIuWREpcZYyUKAISo4TYAVsg/r8eiZjUF7sQ2zpQ1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnXG51XW8F+tYRPC4X0EMjSofvpI+tVA8gAdv0OrrKjExVfe08xZLhPQiKdM54HX9
         sz9Z5ol76Dir7XyBdBTctsnbcBEambMhx7kxRd4//mf5Lei6EdlWZxUdF8+1+oSqIF
         nF4wGwHi4vTb9znXQ2MvQPQexG6r0BqGEQ0TuFL4=
Date:   Thu, 12 Mar 2020 09:51:17 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jimmy Assarsson <jimmyassarsson@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: Use LIS3MDL with LSM6DSM sensor-hub
Message-ID: <20200312085117.GA2125633@lore-desk-wlan>
References: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <f8489de0-c6a4-f786-b936-679eba6d6804@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hi,

Hi Jimmy,

>=20
> We are working on a project where we want to connect LS6DSM (via SPI), and
> connect LIS3MDL via the sensor hub, as I2C slave device.
>=20
> We would like to add settings/configuration for LIS3MDL, to the shub
> source, since currently only LIS2MDL is supported. We've made an attempt,
> see diff at end of this mail.
>=20
> 1. LIS2MDL only got a single full scale setting, hence it is not possible
>    to change. While LIS3MDL got four possible settings. Is it enough to a=
dd
>    a corresponding function like st_lsm6dsx_shub_set_fs_val() and call it
>    from st_lsm6dsx_shub_write_raw(), when mask =3D=3D IIO_CHAN_INFO_SCALE?

I think so, the other routines are already there

> 2. LIS3MDL got 8 possible ODR settings, however ST_LSM6DSX_ODR_LIST_SIZE =
is
>    defined to 6 (st_lsm6dsx.h). Is it fine to increase
>    ST_LSM6DSX_ODR_LIST_SIZE to 8? This will also affect odr_table in
>    struct st_lsm6dsx_settings.

I think it is ok since the real table size is indicated in the odr_len field

> 3. In the patch, we've tried to copy the correct registers and values from
>    magnetometer/st_magn_core.c, does it look ok?

I have not double checked, but I guess they should be ok if you copied them
=66rom st_magn_core.c

Does it work?

Regards,
Lorenzo

>=20
> The IIO subsystem is new to use, we possibly miss fundamental knowledge.
>=20
> Regards,
> jimmy
>=20
> ---
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index eea5556..8621dba 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -88,6 +88,69 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm=
6dsx_ext_dev_table[] =3D {
>  			.len =3D 6,
>  		},
>  	},
> +	/* LIS3MDL */
> +	{
> +		.i2c_addr =3D { 0x1e },
> +		.wai =3D {
> +			.addr =3D 0x0f,
> +			.val =3D 0x3d,
> +		},
> +		.id =3D ST_LSM6DSX_ID_MAGN,
> +		.odr_table =3D {
> +			.reg =3D {
> +				.addr =3D 0x20,
> +				.mask =3D GENMASK(4, 2),
> +			},
> +			.odr_avl[0] =3D {  1000, 0x0 },
> +			.odr_avl[1] =3D {  2000, 0x1 },
> +			.odr_avl[2] =3D {  3000, 0x2 },
> +			.odr_avl[3] =3D {  5000, 0x3 },
> +			.odr_avl[4] =3D { 10000, 0x4 },
> +			.odr_avl[5] =3D { 20000, 0x5 },
> +			.odr_avl[6] =3D { 40000, 0x6 },
> +			.odr_avl[7] =3D { 80000, 0x7 },
> +			.odr_len =3D 8,
> +		},
> +		.fs_table =3D {
> +			.reg =3D {
> +				.addr =3D 0x21,
> +				.mask =3D GENMASK(6, 5),
> +			},
> +			.fs_avl[0] =3D {
> +				.gain =3D 146,
> +				.val =3D 0x00,
> +			}, /* 4000 uG/LSB */
> +			.fs_avl[1] =3D {
> +				.gain =3D 292,
> +				.val =3D 0x01,
> +			}, /* 8000 uG/LSB */
> +			.fs_avl[2] =3D {
> +				.gain =3D 438,
> +				.val =3D 0x02,
> +			}, /* 12000 uG/LSB */
> +			.fs_avl[3] =3D {
> +				.gain =3D 584,
> +				.val =3D 0x03,
> +			}, /* 16000 uG/LSB */
> +			.fs_len =3D 4,
> +		},
> +		.pwr_table =3D {
> +			.reg =3D {
> +				.addr =3D 0x22,
> +				.mask =3D GENMASK(1, 0),
> +			},
> +			.off_val =3D 0x2,
> +			.on_val =3D 0x0,
> +		},
> +		.bdu =3D {
> +			.addr =3D 0x24,
> +			.mask =3D BIT(6),
> +		},
> +		.out =3D {
> +			.addr =3D 0x28,
> +			.len =3D 6,
> +		},
> +	},
>  };

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXmn4AgAKCRA6cBh0uS2t
rNW7AQDBlQu65kVZp8YfBP6InSdxgH1y3L5qLCV0V2D9iBDHpwEAnO22vq7xXbhr
oAvn7rvyjnbpbtPeqLqROe8UT2vzlQg=
=ZOxb
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
