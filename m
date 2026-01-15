Return-Path: <linux-iio+bounces-27829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D0D24B1F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F85309708F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A219399A5B;
	Thu, 15 Jan 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeSpANz3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E4035F8B1;
	Thu, 15 Jan 2026 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482784; cv=none; b=TUfPEJdZ/L+h65bPv0RCL3sHlnAYrGcFYimsc4T6sA7le9MAeorwqOR7k6lKedOeYAHkQsvaw3IyU0IX+gYDPkhs0JKghDXlvRTe+sRV9RjbqOsyDfXSEM1DaIll3NtEsJOyE2ahxVPFAoECjwbWygNYtDIGDiN9qHyhoBPv/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482784; c=relaxed/simple;
	bh=5pIovo5wkz6NB68yl+j59aG86ffZUM6L9P41ET1LZFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhqYFEgqqzyuPdaF3KMJXsVQuA1ERQQHNRUJxmKJEcSOp8Onh34ftbxjOl66RGgj+tj41p43p/JObmxLfIds4FMrt2KbRmOZOAK7gCs6W+FIGrUhcAcDfLV+fl9HtvOahGwQbFHYbcnltqLBdPebnvFyXAB3vvyXVmMp/jNjiIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeSpANz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD4BC116D0;
	Thu, 15 Jan 2026 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768482784;
	bh=5pIovo5wkz6NB68yl+j59aG86ffZUM6L9P41ET1LZFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KeSpANz3JJALiwu43uzOEKvc9bG4FMAwiy52UGlpajv+Ej+YKJMUuLa7PlcuJndfV
	 mGDnAZbYzKNuHJ6ccDhEvNRYO3XDFpwOuR4QVTlPBeihLwzwEEz/e4tMTOOCc5XCXm
	 FPe+68awVdrfYzz2Sh0/nxQkOYFqjIiPGIHE1Jb0YwaaH1+kvPT0JWG4rBNTjrzLsd
	 PyR37ljCRkHSgpng6ELeOPplwgDdky7UB29Meq3fOGHGs5r45cuSAcDnLAk8+ZjNaH
	 l0Q0Czbb1jppHa4RF5/4nvGKaFpZMl5sEQi8U3yliqiJG6UaiTiPOwEUQ+yICRQFNR
	 HuOAT7l7caI2w==
Date: Thu, 15 Jan 2026 14:13:01 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: imu: st_lsm6dsx: Set FIFO ODR for
 accelerometer and gyroscope only
Message-ID: <aWjn3cCNhm9t_DCe@lore-desk>
References: <20260115122431.1014630-1-flavra@baylibre.com>
 <20260115122431.1014630-2-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IBwO7o9I9E3EtrpM"
Content-Disposition: inline
In-Reply-To: <20260115122431.1014630-2-flavra@baylibre.com>


--IBwO7o9I9E3EtrpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
> disabling the hardware FIFO, checks the contents of the hw->settings->bat=
ch
> array at index sensor->id, and then sets the current ODR value in sensor
> registers that depend on whether the register address is set in the above
> array element. This logic is valid for internal sensors only, i.e. the
> accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: im=
u:
> st_lsm6dsx: add i2c embedded controller support"), this function is called
> also when configuring the hardware FIFO for external sensors (i.e. sensors
> accessed through the sensor hub functionality), which can result in
> unrelated device registers being written.
>=20
> Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
> not touch any registers unless it is called for internal sensors.
>=20
> Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller s=
upport")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 55d877745575..1ee2fc5f5f1f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx=
_sensor *sensor,
>  	const struct st_lsm6dsx_reg *batch_reg;
>  	u8 data;
> =20
> +	/* Only internal sensors have a FIFO ODR configuration register. */
> +	if (sensor->id >=3D ARRAY_SIZE(hw->settings->batch))
> +		return 0;

I guess it is more clear to check if the sensor is acc or gyro here.
What do you think? Something like:

	if (sensor->id !=3D ST_LSM6DSX_ID_GYRO &&
	    sensor->id !=3D ST_LSM6DSX_ID_ACC)
	    return 0;

Regards,
Lorenzo

> +
>  	batch_reg =3D &hw->settings->batch[sensor->id];
>  	if (batch_reg->addr) {
>  		int val;
> --=20
> 2.39.5
>=20

--IBwO7o9I9E3EtrpM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWjn3QAKCRA6cBh0uS2t
rNgXAQDpZVA/gEht9q1infofttjKDR/L3pHyQWAdQJCjoHfomAD+Mqzk4z/q8y9b
PGRSx/xz9i5ogqyF+yyVPpG4Kz8H9AA=
=aTVO
-----END PGP SIGNATURE-----

--IBwO7o9I9E3EtrpM--

