Return-Path: <linux-iio+bounces-25110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF1BDFF11
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 19:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23FC734AE25
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8D52FB967;
	Wed, 15 Oct 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqudt4rb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93E1547EE;
	Wed, 15 Oct 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550618; cv=none; b=tk+4uuIroBX45j9AOugflwqHal534WLrfuhbF3yHfarJP0/xl2Fuefh8wqGjDVULBoNM/5hTF5fU5X1cIxm6lsTbqFao8op1MzhHNBaBMgfVDDoOya0SldD1C2A70A6fmj85GzM6MCDN1tm+uelignXPIvtRL/prKysQWp1sa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550618; c=relaxed/simple;
	bh=FFGZQ8Iwn7Z2cApC4Nm1wj3uEBVZaeD7lM9HEqR6tE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVODgQUCF7OSYxMIpLf9FBVtcy+hF5a86WoWmwVokuGv7NA8Gdq4l1RQcQd+Vnf2lUiDE6bPLztWcwGqzqrH48NINuPaOD3gzEzOvXFDxHfouLxl8HbDBLxRm5ev7aHqonhTl/Paj/YYDGAUkG9idWPiobWUecIP7aYRglRd2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqudt4rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A277C4CEF8;
	Wed, 15 Oct 2025 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760550618;
	bh=FFGZQ8Iwn7Z2cApC4Nm1wj3uEBVZaeD7lM9HEqR6tE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zqudt4rbQGns20go909NZJKMZmGYTWbCSCn7zmlKnC3e0/ceHHXstkfcWj4/+IHP3
	 ObKQWK3hD4XE5wvMlJBO9QgSKwZ3Fg6V9LhFpsEfIQYjBFKgx40Xc9dmaPxNgy4mYA
	 dbvLHFuOzyYjptfPjKu7iVAN/IUDgK0aE8GuJeOLVN8hV7dp1n+7rRxpFySJdIaBkD
	 TcyCmwNoF43netNkgMGm5t+m4s5CdE8su3oqU91xEDyB9hsuoxMeRqmmIAq/p9zYcY
	 bSgMarBFqwB62iwKqMAIox5toRf7vVkgFIlReFPH1CAcY5rvaED5HCjAsSitRkQjxe
	 zNQBeycbfyqag==
Date: Wed, 15 Oct 2025 19:50:16 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mario Tesi <martepisa@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: st_lsm6dsx: Fixed calibrated timestamp calculation
Message-ID: <aO_e2DEGsO-kJQFx@lore-desk>
References: <20251015161619.GA87736@ctocxl9700.cto.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H2hlv9x1VAXUxSmR"
Content-Disposition: inline
In-Reply-To: <20251015161619.GA87736@ctocxl9700.cto.st.com>


--H2hlv9x1VAXUxSmR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The calibrated timestamp is calculated from the nominal value using the
> formula:
>   ts_gain[ns] =E2=89=88 ts_sensitivity - (ts_trim_coeff * val) / 1000.
>=20
> The values of ts_sensitivity and ts_trim_coeff are not the same for all
> devices, so it is necessary to differentiate them based on the part name.
> For the correct values please consult the relevant AN.
>=20
> Signed-off-by: Mario Tesi <mario.tesi@st.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 18 ++++++++++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 19 ++++++++-----------
>  2 files changed, 26 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index c225b246c8a5..f8486a1b02d0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -192,6 +192,22 @@ struct st_lsm6dsx_fifo_ops {
>   * @fifo_en: Hw timer FIFO enable register info (addr + mask).
>   * @decimator: Hw timer FIFO decimator register info (addr + mask).
>   * @freq_fine: Difference in % of ODR with respect to the typical.
> + * @ts_sensitivity: Nominal timestamp sensitivity.
> + * @ts_trim_coeff: Coefficient for calculating the calibrated timestamp =
gain.
> + *                 This coefficient comes into play when linearizing the=
 formula
> + *                 used to calculate the calibrated timestamp (please se=
e the
> + *                 relevant formula in the AN for the specific IMU).
> + *                 For example, in the case of LSM6DSO we have:
> + *
> + *                  1 / (1 + x) ~=3D 1 - x (Taylor=E2=80=99s Series)
> + *                  ttrim[s] =3D 1 / (40000 * (1 + 0.0015 * val)) (from =
AN5192)
> + *                  ttrim[ns] ~=3D 25000 - 37.5 * val
> + *                  ttrim[ns] ~=3D 25000 - (37500 * val) / 1000
> + *
> + *                  so, replacing ts_sensitivity =3D 25000 and
> + *                  ts_trim_coeff =3D 37500
> + *
> + *                  ttrim[ns] ~=3D ts_sensitivity - (ts_trim_coeff * val=
) / 1000
>   */
>  struct st_lsm6dsx_hw_ts_settings {
>  	struct st_lsm6dsx_reg timer_en;
> @@ -199,6 +215,8 @@ struct st_lsm6dsx_hw_ts_settings {
>  	struct st_lsm6dsx_reg fifo_en;
>  	struct st_lsm6dsx_reg decimator;
>  	u8 freq_fine;
> +	u16 ts_sensitivity;
> +	u16 ts_trim_coeff;
>  };
> =20
>  /**
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index d8cb4b0218d5..a2daf0c14d96 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -94,8 +94,6 @@
> =20
>  #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
> =20
> -#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
> -
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
>  	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
>  	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> @@ -983,6 +981,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  				.mask =3D GENMASK(7, 6),
>  			},
>  			.freq_fine =3D 0x63,
> +			.ts_sensitivity =3D 25000,
> +			.ts_trim_coeff =3D 37500,
>  		},
>  		.shub_settings =3D {
>  			.page_mux =3D {
> @@ -1196,6 +1196,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  				.mask =3D GENMASK(7, 6),
>  			},
>  			.freq_fine =3D 0x63,
> +			.ts_sensitivity =3D 25000,
> +			.ts_trim_coeff =3D 37500,
>  		},
>  		.event_settings =3D {
>  			.enable_reg =3D {
> @@ -1371,6 +1373,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  				.mask =3D GENMASK(7, 6),
>  			},
>  			.freq_fine =3D 0x4f,
> +			.ts_sensitivity =3D 21701,
> +			.ts_trim_coeff =3D 28212,
>  		},
>  		.shub_settings =3D {
>  			.page_mux =3D {
> @@ -2248,20 +2252,13 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm=
6dsx_hw *hw)
>  	}
> =20
>  	/* calibrate timestamp sensitivity */
> -	hw->ts_gain =3D ST_LSM6DSX_TS_SENSITIVITY;
> +	hw->ts_gain =3D ts_settings->ts_sensitivity;
>  	if (ts_settings->freq_fine) {
>  		err =3D regmap_read(hw->regmap, ts_settings->freq_fine, &val);
>  		if (err < 0)
>  			return err;
> =20
> -		/*
> -		 * linearize the AN5192 formula:
> -		 * 1 / (1 + x) ~=3D 1 - x (Taylor=E2=80=99s Series)
> -		 * ttrim[s] =3D 1 / (40000 * (1 + 0.0015 * val))
> -		 * ttrim[ns] ~=3D 25000 - 37.5 * val
> -		 * ttrim[ns] ~=3D 25000 - (37500 * val) / 1000
> -		 */
> -		hw->ts_gain -=3D ((s8)val * 37500) / 1000;
> +		hw->ts_gain -=3D ((s8)val * ts_settings->ts_trim_coeff) / 1000;
>  	}
> =20
>  	return 0;
> --=20
> 2.25.1
>=20

--H2hlv9x1VAXUxSmR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaO/e2AAKCRA6cBh0uS2t
rKnYAP4gpIJWcS/HFgC560Mw6wXDVq+fW8GUbXjDw5SicSdX5QD+K4H4uuRFgfFf
ehJObG2WNuq31M9TpnQQO5nsoYq/vgE=
=Bzqz
-----END PGP SIGNATURE-----

--H2hlv9x1VAXUxSmR--

