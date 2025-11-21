Return-Path: <linux-iio+bounces-26349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C166DC77DC5
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 09:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8AE7A31BA0
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D27331234;
	Fri, 21 Nov 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/GoWnsM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131C280327;
	Fri, 21 Nov 2025 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713177; cv=none; b=pcIiKzMZQUQgt0zZaT8CC3GMJLNdLumm9f8LS8WEiAafNneCad+6GT+LuGBfLMWkp1v5ITH5ZHjCwk/sJjh9DXjHnje6KqSuL0b4DYEcBN3/JSlIV0LKg0WTJNf+flIa4BE92l05x3tvkmNWhVVNiZJhJ0eYEsrHLxaddEfSDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713177; c=relaxed/simple;
	bh=N/GYv0Gu6gVRCoOrZHCGIXRkZXOT9SOK/vC8m1Yo3mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzEv0R4ek34PRAUHvpHFXFWE1IubwLFX2PnZ+R3+PnfS2tpNKbVbFxblZNiGOEdfbvcuuSvx5r0KUF8r4D6jfRttxS+xz5Por/kqxvEw18jkL0wK09ZezklAcP9HrkaBcBr8grgCn6FcLdMg2u3X90u+tQn90jiqx6oQxUh4L0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/GoWnsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D65CC4CEF1;
	Fri, 21 Nov 2025 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763713177;
	bh=N/GYv0Gu6gVRCoOrZHCGIXRkZXOT9SOK/vC8m1Yo3mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/GoWnsM0dRP/GTX4LKvaegI/oeYXzoy5bZEq0su8v9Tnq+fotRGDYZ9zteaySGZv
	 J6Eu6Jo6T1RloFfyPz8j3s2oH0mW/9co6weqKkAy+48bDGL4/8KbDaOdCTOxFuw5Ou
	 NIKMfBJIR5NUZaEd8T5DeVyLeQiOAFDLv+nw8DLN8iU8VUc3cg+SgoNd17oZM++xbf
	 f3+oV/mYV5ZQUbfoZo9dLfZ0T1hdtbd/qAvTtk6Tfk/DqqPz801ouzeMyNMuPQabey
	 TPmsnxL9vywMjajA0FPLzAgR2y8iYTGz7Uo0/BrQuMQYNZThSsPvG52TVY/SM7DtlY
	 2+kScHGCHMgug==
Date: Fri, 21 Nov 2025 09:19:35 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] iio: imu: st_lsm6dsx: add tap event detection
Message-ID: <aSAgl6B5NKSmY1Fz@lore-desk>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-10-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="syni4/nOxkzo7mrv"
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-10-flavra@baylibre.com>


--syni4/nOxkzo7mrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> In order to allow sensors to advertise tap event capability and report tap
> events, define a new struct iio_event_spec array that includes a tap event
> spec, and a new struct iio_chan_spec array that references the new
> iio_event_spec array; for the LSM6DSV chip family, use the new
> iio_chan_spec array and define an event source for tap events.
> Tested on LSMDSV16X.
>=20
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 55 +++++++++++++++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 3b90261e6bb1..5d820f2a0bce 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -245,6 +245,7 @@ struct st_lsm6dsx_shub_settings {
> =20
>  enum st_lsm6dsx_event_id {
>  	ST_LSM6DSX_EVENT_WAKEUP,
> +	ST_LSM6DSX_EVENT_TAP,
>  	ST_LSM6DSX_EVENT_MAX
>  };
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 562544636f36..55cd63643c52 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -105,6 +105,21 @@ static const struct iio_event_spec st_lsm6dsx_ev_mot=
ion[] =3D {
>  	},
>  };
> =20
> +static const struct iio_event_spec st_lsm6dsx_ev_motion_tap[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +	{
> +		.type =3D IIO_EV_TYPE_GESTURE,
> +		.dir =3D IIO_EV_DIR_SINGLETAP,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
>  	ST_LSM6DSX_CHANNEL_ACC(0x28, IIO_MOD_X, 0, st_lsm6dsx_ev_motion),
>  	ST_LSM6DSX_CHANNEL_ACC(0x2a, IIO_MOD_Y, 1, st_lsm6dsx_ev_motion),
> @@ -119,6 +134,13 @@ static const struct iio_chan_spec st_lsm6ds0_acc_cha=
nnels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> =20
> +static const struct iio_chan_spec st_lsm6dsx_acc_tap_channels[] =3D {
> +	ST_LSM6DSX_CHANNEL_ACC(0x28, IIO_MOD_X, 0, st_lsm6dsx_ev_motion_tap),
> +	ST_LSM6DSX_CHANNEL_ACC(0x2a, IIO_MOD_Y, 1, st_lsm6dsx_ev_motion_tap),
> +	ST_LSM6DSX_CHANNEL_ACC(0x2c, IIO_MOD_Z, 2, st_lsm6dsx_ev_motion_tap),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] =3D {
>  	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
>  	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
> @@ -1250,8 +1272,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  		},
>  		.channels =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> +				.chan =3D st_lsm6dsx_acc_tap_channels,
> +				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_tap_channels),
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
>  				.chan =3D st_lsm6dsx_gyro_channels,
> @@ -1426,6 +1448,30 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
>  					.status_y_mask =3D BIT(1),
>  					.status_x_mask =3D BIT(2),
>  				},
> +				[ST_LSM6DSX_EVENT_TAP] =3D {
> +					.x_value =3D {
> +						.addr =3D 0x57,
> +						.mask =3D GENMASK(4, 0),
> +					},
> +					.y_value =3D {
> +						.addr =3D 0x58,
> +						.mask =3D GENMASK(4, 0),
> +					},
> +					.z_value =3D {
> +						.addr =3D 0x59,
> +						.mask =3D GENMASK(4, 0),
> +					},
> +					.enable_mask =3D BIT(6),
> +					.enable_axis_reg =3D 0x56,
> +					.enable_x_mask =3D BIT(3),
> +					.enable_y_mask =3D BIT(2),
> +					.enable_z_mask =3D BIT(1),
> +					.status_reg =3D 0x46,
> +					.status_mask =3D BIT(5),
> +					.status_x_mask =3D BIT(2),
> +					.status_y_mask =3D BIT(1),
> +					.status_z_mask =3D BIT(0),
> +				},
>  			},
>  		},
>  	},
> @@ -1939,6 +1985,8 @@ st_lsm6dsx_get_event_id(enum iio_event_type type)
>  	switch (type) {
>  	case IIO_EV_TYPE_THRESH:
>  		return ST_LSM6DSX_EVENT_WAKEUP;
> +	case IIO_EV_TYPE_GESTURE:
> +		return ST_LSM6DSX_EVENT_TAP;
>  	default:
>  		return ST_LSM6DSX_EVENT_MAX;
>  	}
> @@ -2606,6 +2654,9 @@ static bool st_lsm6dsx_report_motion_event(struct s=
t_lsm6dsx_hw *hw)
>  	events_found =3D st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP,
>  						IIO_EV_TYPE_THRESH,
>  						IIO_EV_DIR_EITHER);
> +	events_found |=3D st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_TAP,
> +						 IIO_EV_TYPE_GESTURE,
> +						 IIO_EV_DIR_SINGLETAP);
> =20
>  	return events_found;
>  }
> --=20
> 2.39.5
>=20

--syni4/nOxkzo7mrv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSAglwAKCRA6cBh0uS2t
rDJZAP4qRASfcW1TZgav5EC5XPKHNZykJS84fwOmDzsJvk8VMwEAxD4vlsoKCv9j
SgyqTdprjGk+ZRtPbIv2rCqpfLuzXwI=
=x/8B
-----END PGP SIGNATURE-----

--syni4/nOxkzo7mrv--

