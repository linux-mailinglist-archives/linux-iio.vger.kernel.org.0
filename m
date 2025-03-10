Return-Path: <linux-iio+bounces-16675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6227A59671
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 14:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8DC3A47A6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 13:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F17229B1F;
	Mon, 10 Mar 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4WuuU6m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CC9226545;
	Mon, 10 Mar 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613806; cv=none; b=ZSWnmklccZbdINlECX7LyNxStklIpXZvae3MohsZncYmK4A/fLKY9We8fhFjW/qa0YrKAFNvK0h+pwrJh9cJIfheTDFLAUC0rgEE6NaAI5DBGsj7ulnjHO4NImhm88o1GvmyQRD+5Hxzx2fSdZPwKKZ8pGuHw+fxgIMhxj5/giE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613806; c=relaxed/simple;
	bh=gkq/0nSAwgVmu8763+m13tE4nKdh66ZfoaCSM1sg6iw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BRmO7vi6mbOonxeJhyO5u0NspGam71kzm6c8d4sQwl0USXmvqwycdW1UBWhnVzk7ZZ+Ja+z/lkrg2uEfgkiGq4Ad33GA6Lzj2HoouHc7KILzsm9dVJihYoiobACJ3Eiaf0R3/fW4IAAQjpoG0o62jOSEYpLYfmCy6MvhKPagcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4WuuU6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB1FC4CEED;
	Mon, 10 Mar 2025 13:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741613806;
	bh=gkq/0nSAwgVmu8763+m13tE4nKdh66ZfoaCSM1sg6iw=;
	h=Date:From:To:Cc:Subject:From;
	b=W4WuuU6mkRjVcVpJHhSih8hnblkX3DgKILnkGrEiJeMXcEEngJ6lNmkHsW1SQdyG4
	 59FP4V5f+C8Z8ZSCO0d8HBdiNpyDFV8ieNi7kKGfAG0mHuouvn/9u7SrWVtW7KoZ6X
	 SohaspXsWE1rwV7m23fctsbnwd0mOaBahD/hPDmowjkG26T5QyGQ4T4BRVVx8TiJkv
	 ePXfieXcRn3HZvXnrXe6Zd0Df63vd+J0f/gmcGSvtrIwDHW85bxkdropycTgfT1hDD
	 huP9SFNKspHIJvZvMDH2a2z+9XVMrcKTPnKSSj3hSniMzBbpiPMGm67gQgmCs90Che
	 ivbVz597JwNAw==
Date: Mon, 10 Mar 2025 14:36:43 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Silvano Seva <s.seva@4sigma.it>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO
 read
Message-ID: <Z87q67AvUgd8yu7S@lore-desk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FEuVnalBfUrozhKH"
Content-Disposition: inline


--FEuVnalBfUrozhKH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I guess you missed v2 here. Moreover, can you please proper Fixes tag?

Reply-To:=20
In-Reply-To: <20250310132508.24660-2-s.seva@4sigma.it>

> Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
> from falling in an infinite loop in case pattern_len is equal to zero and
> the device FIFO is not empty.
>=20
> Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 0a7cd8c1aa33..39a7e15ae9ae 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -392,9 +392,14 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
>  		return 0;
> =20
> +	if (!pattern_len)
> +		pattern_len =3D ST_LSM6DSX_SAMPLE_SIZE;
> +
>  	fifo_len =3D (le16_to_cpu(fifo_status) & fifo_diff_mask) *
>  		   ST_LSM6DSX_CHAN_SIZE;
>  	fifo_len =3D (fifo_len / pattern_len) * pattern_len;
> +	if (!fifo_len)
> +		return 0;

this is not needed, please drop it.

Regards,
Lorenzo

> =20
>  	acc_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>  	gyro_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> @@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw =
*hw)
>  	if (!fifo_len)
>  		return 0;
> =20
> +	if (!pattern_len)
> +		pattern_len =3D ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
> +
>  	for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_len) {
>  		err =3D st_lsm6dsx_read_block(hw,
>  					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
> --=20
> 2.48.1
>=20

--FEuVnalBfUrozhKH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ87q6wAKCRA6cBh0uS2t
rLE0AQDxymrlO6OyLvggMkpo8Gq6ADN0vapD7l25vrx7kRE32gEA2+jcvVSdr6ib
H+PmvM4uARdrhc32ArG2dERy6869+g4=
=tWyy
-----END PGP SIGNATURE-----

--FEuVnalBfUrozhKH--

