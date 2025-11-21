Return-Path: <linux-iio+bounces-26345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1263C77C25
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 08:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B4DAA2E94F
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5FC1C5D59;
	Fri, 21 Nov 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOWxk8Y0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA016279DA2;
	Fri, 21 Nov 2025 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711437; cv=none; b=ov/ZqivGXj2NcrATUEBbwG53GvHD8NZKgIqMvpBPvGd7CpojiMSqOL+bZJlP0soVmxK5FO3CF7oj5dYrcAZXtXtNe6qGPtOrSpgKubCe5yl2bN2F8mYLdVKfpnXoSifOq7wVwFeyhJL+tJ8G8DFi+YKVwKKpUqdLZfJPjny8Rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711437; c=relaxed/simple;
	bh=v3ojaLrv4fpBGkDt0UPOBs4pfLwMz41Hw5DOKHirYeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+VN6U84a0BnwBrJNYm2iehj0dt27lBY4x9Hqk2SNPENnKjl0An2lN8fPfbFhay1bDVbpUHGBrUMoHSTCkPtj/Xs1LKFgEiSANxEhzBSzaSCgIhzTkLkdEOKl3/3ox+v56F0WBJdMtUeQvPcrsrHWQA2SmYYL4rqSjzvCupH+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOWxk8Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A66C113D0;
	Fri, 21 Nov 2025 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763711437;
	bh=v3ojaLrv4fpBGkDt0UPOBs4pfLwMz41Hw5DOKHirYeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cOWxk8Y0Aon1Bc8ugXKbuLND0k30GLeOOpHpf+dRRo+w5GEgtCsu8Aip4nZMo9uFC
	 z61cqjNVFzkevM8eOKVV1/T2+wxKAwSSmMX/4dxkMgTFf+ohbibkyamAET1sdcV+qy
	 D22b2+MZxSfPuVV0QjAAlUf3whmXvJHqP4ImKBi2HN0L2fI1i83cnmFRBBBZ5h5wBJ
	 k4MqiL6PIydAtYy43ymX0Vg5MlhJONat57kjLdtrJMDjX1j0KYtZ+ayB3LCcVsxiKL
	 VCe+nm+jJE1/7ZEs+HpASPM18DrJfhY5s+KJrEkpq86P3/ef9I5O0kbzz/hA8JH8Wv
	 4+Zvpv+IxyLow==
Date: Fri, 21 Nov 2025 08:50:34 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] iio: imu: st_lsm6dsx: fix iio_chan_spec for
 sensors without event detection
Message-ID: <aSAZyjAvBpzKsa4-@lore-desk>
References: <20251120082615.3263892-1-flavra@baylibre.com>
 <20251120082615.3263892-2-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z7oW0FEYeedHhEzm"
Content-Disposition: inline
In-Reply-To: <20251120082615.3263892-2-flavra@baylibre.com>


--Z7oW0FEYeedHhEzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The st_lsm6dsx_acc_channels array of struct iio_chan_spec has a non-NULL
> event_spec field, indicating support for IIO events. However, event
> detection is not supported for all sensors, and if userspace tries to
> configure accelerometer wakeup events on a sensor device that does not
> support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences a NULL
> pointer when trying to write to the wakeup register.
> Define an additional struct iio_chan_spec array whose members have a NULL
> event_spec field, and use this array instead of st_lsm6dsx_acc_channels f=
or
> sensors without event detection capability.
>=20
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 216160549b5a..a09df9d772dd 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -103,6 +103,13 @@ static const struct iio_chan_spec st_lsm6dsx_acc_cha=
nnels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> =20
> +static const struct iio_chan_spec st_lsm6ds0_acc_channels[] =3D {
> +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> +	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
>  static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] =3D {
>  	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
>  	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
> @@ -144,8 +151,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  		},
>  		.channels =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> +				.chan =3D st_lsm6ds0_acc_channels,
> +				.len =3D ARRAY_SIZE(st_lsm6ds0_acc_channels),
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
>  				.chan =3D st_lsm6ds0_gyro_channels,
> @@ -1445,8 +1452,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  		},
>  		.channels =3D {
>  			[ST_LSM6DSX_ID_ACC] =3D {
> -				.chan =3D st_lsm6dsx_acc_channels,
> -				.len =3D ARRAY_SIZE(st_lsm6dsx_acc_channels),
> +				.chan =3D st_lsm6ds0_acc_channels,
> +				.len =3D ARRAY_SIZE(st_lsm6ds0_acc_channels),
>  			},
>  			[ST_LSM6DSX_ID_GYRO] =3D {
>  				.chan =3D st_lsm6dsx_gyro_channels,
> --=20
> 2.39.5
>=20

--Z7oW0FEYeedHhEzm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaSAZygAKCRA6cBh0uS2t
rNA4AQDXT86jj3gd3vDX89jXk2tVrmc6mWyzn5Qs2wmh7FRLtAD+I2VoJKU/yi7T
Gx7yDeF0FheHijZxwS+RubDNZ99SUQE=
=CgUl
-----END PGP SIGNATURE-----

--Z7oW0FEYeedHhEzm--

