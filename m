Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4727B376430
	for <lists+linux-iio@lfdr.de>; Fri,  7 May 2021 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhEGLDG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 May 2021 07:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhEGLDG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 07:03:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49B8061458;
        Fri,  7 May 2021 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620385326;
        bh=1Is7GZlkae695L/SfsF9GM0WLKe5uXTf2NsgISds2tI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dh/BvJ5Wj2NrvNUcSHL+vXHMFqQYt9QvEmA2X/+Iu3MdltwYizxpvM1IZWMjTzos9
         Ggf8MifUEwD7Za9Xo+xbc7X4Yc0LL5g7aKi0spR24FPqE4Wd9GOVVRqP4qJukkcbW2
         MuoSM8pCEfxhAExc79Nc0Ln0HlQufUbjPdE99/2y5EPolQc38DEMvPbSCdRgVv99Xl
         /EgW4zdvcsRWIH0XlQRSnnQwGbfuWG4BoFwJjPcm4r1/1b7PNy1QRhOC8pLyY9xlcG
         0eF88+zZF6sPrFwCV5Mu+A/bfLs0AO+DQAvaonfxOUeeta20NNnEujirSDXHbOrF67
         AUFyV/YXkJqjA==
Date:   Fri, 7 May 2021 13:02:02 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
Message-ID: <YJUeKhjooi8lAN1Q@lore-desk>
References: <20210507103220.2194009-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fHLAPTSBpAepRvOs"
Content-Disposition: inline
In-Reply-To: <20210507103220.2194009-1-sean@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--fHLAPTSBpAepRvOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The correct way to set the sampling rate to 12.5 Hz before
> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
> was to write 13 Hz to sampling_frequency.
> Before this patch writing 13 to samplerate results in sample rate set
> to 26 Hz.
> Now we return EINVAL if the sampling rate is not in table.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

I think this patch is breaking i2c-master support available in st_lsm6dsx, =
have you tested it?

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index a3ab16615729..a14a1df8537b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1427,7 +1427,7 @@ int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *=
sensor, u32 odr, u8 *val)
>  		 * ext devices can run at different odr respect to
>  		 * accel sensor
>  		 */
> -		if (odr_table->odr_avl[i].milli_hz >=3D odr)
> +		if (odr_table->odr_avl[i].milli_hz =3D=3D odr)
>  			break;
>  	}
> =20
> --=20
> 2.31.0
>=20

--fHLAPTSBpAepRvOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYJUeJwAKCRA6cBh0uS2t
rAwDAP96GLxn+6Dp5l4s7dD1hVs0/PpZ70fvoyTH73V4IZVUpgEA29c2heItETIF
2sy77XkgLnYyvqvdi8Wyh/c4Wn4mkQU=
=Tf4M
-----END PGP SIGNATURE-----

--fHLAPTSBpAepRvOs--
