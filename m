Return-Path: <linux-iio+bounces-27830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BAED24B80
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCD5F3090A43
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2639E6D3;
	Thu, 15 Jan 2026 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka7A0EgV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F47394485;
	Thu, 15 Jan 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483117; cv=none; b=VUTmo5uV5heqYdU6UVnf/3P38w1G0duKw8REMNOHczhNOn4gIOQdpXuDJalf6btgIj6laY7bsexdUYuKooQyJ1z3vEUUEycXQN/Nt9chty2oatrxWWMbzkdpUGtr5fKJ20n1KI1WBcUAfqkLK5LKumbyeTfe0ENT4S6m3MaJ7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483117; c=relaxed/simple;
	bh=CRCLuo9ENdeKoASGDcPr1c7+DUkR/b+fIQXKJjGRsDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqMa5oGFNqIE+x5eF4GJMRb49PZarcUDvh5noxcqN6E+N2Hs5JDkV6qgfqigkxdgXPlci/T/MEGmy/3+BAkR/Wv9tTKbMF/o7ayLTOJT/PTgMSasXyfqjOsZTISk5I6UOgVefQu8wVH3hg1uPZd8KLPN+IjtTrrKxTJdFR9/6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka7A0EgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E49C16AAE;
	Thu, 15 Jan 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768483116;
	bh=CRCLuo9ENdeKoASGDcPr1c7+DUkR/b+fIQXKJjGRsDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ka7A0EgVCwlV2b53L895V/L5tnYXOo49fTYTUI/oAkwp7rUtVWI8FGiu+8Pw3g3De
	 HTceUMe6dIOnSOf89qM/A7Dq7yVivPuGyUXJi3vjrALqFwcSC88HtjoaWoxdhar+0t
	 Tvf5fgaJ7bvROBM6+P0RBLunAEKVzwQ3inwHVWVIl0cbCZ2iu32OOcM1C9X92ytYQG
	 iQdYsIpiDNtWVwzsM6u8SC/i89jQZhjcqQXRYhOqr1Tlwk2xuQKoPloVH82hTpiTgG
	 TYq2n7BEL3G5Bjz4be9UR+82N3x1AAHEp5PUjcGaEAuPPyLGcgB6nN6eGErr5XmFCP
	 iED3jn/5l5znA==
Date: Thu, 15 Jan 2026 14:18:34 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: imu: st_lsm6dsx: Set buffer sampling
 frequency for accelerometer only
Message-ID: <aWjpKnYHkJI5EhdE@lore-desk>
References: <20260115122431.1014630-1-flavra@baylibre.com>
 <20260115122431.1014630-3-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3DKJzccKU6If4ao"
Content-Disposition: inline
In-Reply-To: <20260115122431.1014630-3-flavra@baylibre.com>


--q3DKJzccKU6If4ao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
> writes the buffer sampling frequency sysfs attribute, calls
> st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> `sensor->id`; since this array is only 2 entries long, an access for any
> sensor type other than accelerometer or gyroscope is an out-of-bounds
> access.
>=20
> To prevent userspace from triggering an out-of-bounds array access, and to
> support the only use case for which FIFO sampling frequency values
> different from the sensor sampling frequency may be needed (which is for
> keeping FIFO data rate low while sampling acceleration data at high rates
> for accurate event detection), do not create the buffer sampling frequency
> attribute for sensor types other than the accelerometer.
>=20
> Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO=
 batch data rate")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 1ee2fc5f5f1f..cde29b2e6f34 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  	int i, ret;
> =20
>  	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		const struct iio_dev_attr **attrs;
> +
>  		if (!hw->iio_devs[i])
>  			continue;
> =20
> +		/*
> +		 * For the accelerometer, allow setting FIFO sampling frequency
> +		 * values different from the sensor sampling frequency, which
> +		 * may be needed to keep FIFO data rate low while sampling
> +		 * acceleration data at high rates for accurate event detection.
> +		 */
> +		attrs =3D (i =3D=3D ST_LSM6DSX_ID_ACC) ? st_lsm6dsx_buffer_attrs : NUL=
L;

Nit: you do not need brackets here:
		attrs =3D i =3D=3D ST_LSM6DSX_ID_ACC ? st_lsm6dsx_buffer_attrs : NULL;

Regards,
Lorenzo

>  		ret =3D devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
>  						      &st_lsm6dsx_buffer_ops,
> -						      st_lsm6dsx_buffer_attrs);
> +						      attrs);
>  		if (ret)
>  			return ret;
>  	}
> --=20
> 2.39.5
>=20

--q3DKJzccKU6If4ao
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWjpKgAKCRA6cBh0uS2t
rEB4AQDA5JUe0RJH0PpaKxD1ivHf+ka4hEZS8awbMN5Lq9Pr5wEA5gzrb64gVu1y
pyEXK2CTo1GI3EuC1tMSpCoSci2ZYgo=
=1yfV
-----END PGP SIGNATURE-----

--q3DKJzccKU6If4ao--

