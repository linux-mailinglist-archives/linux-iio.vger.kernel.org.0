Return-Path: <linux-iio+bounces-16681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C1A5997C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 16:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C6316E79E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B0F22FF41;
	Mon, 10 Mar 2025 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJJujxul"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4122FF33;
	Mon, 10 Mar 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619637; cv=none; b=tC5/J3D2Z32+NJM/b8l+AuI6WzwSEEtRiAB6YkHl9oHg1yo0HCJhG0sU4/EjKEYRnq9eY1urrNm2mSuuGMNDbDeYejBL5ODxVQR+I1vROu8cezNSOJJIFB1XKWJDt5l01z7zKMZcuq8nGs/jTfebaCfQZSP4UQPRi1PiQOBlrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619637; c=relaxed/simple;
	bh=E8j4pIgtYeVUVyPLYeWsQ6wdM/3mTyY6T0E83ZHYNzU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BI7kf2Q41HoWGbmm7ljOJ+gHIqhiaRg13xkKM9U67l9GPrpT4AVwVh9bmLEMXP3tiBkVyW029R2y608MywMGKKQXLAqXFfPWEshZWw6SVBESRLLQAtdmd+N+AxI+0/w3oxnjZPDfysGAZ4J/nHFioPPzTjdinmuPmRIXNzD7wX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJJujxul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B6C4CEED;
	Mon, 10 Mar 2025 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741619637;
	bh=E8j4pIgtYeVUVyPLYeWsQ6wdM/3mTyY6T0E83ZHYNzU=;
	h=Date:From:To:Cc:Subject:From;
	b=iJJujxulFWEs8Br8hqbYISk8Tujo00i169PIPNHrsXDEjwmWTKGeQbbQR1ptqtjOD
	 BSqcllLruqCfmW26xbmMOR8eY3v1xJDW1t67GDozmSCMt1BKQn2kl2y1TfTDgOyhYt
	 0lOrjm/qTQVdfe6dVcEPsPb/KlD3uP3AAHsrNboPK0cK8s1dArLABZHjdtvKTtWQLk
	 IwJCoNBe7esLEi0kl39cBey0pYYsQtY3/r4g++V9TlOav7pjknjitEpEnnW2W/FRH+
	 M5clvNcj8PVkFFXH/xqg6m9uAXieKswl7vYcgv6SfCT2rShQPMsaeYmHMNxIjGEN5H
	 0dm9Vr1I8oTPw==
Date: Mon, 10 Mar 2025 16:13:54 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Silvano Seva <s.seva@4sigma.it>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: fix possible lockup during FIFO
 read
Message-ID: <Z88Bstpob7Jueugd@lore-desk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TCV8Nel+ysraon/u"
Content-Disposition: inline


--TCV8Nel+ysraon/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I guess it was v3 in this case :)

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

> Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
> from falling in an infinite loop in case pattern_len is equal to zero and
> the device FIFO is not empty.
>=20
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
> Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> ---
>=20
> Changes since v1:
> * st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len =
assignment
> * st_lsm6dsx_read_fifo: dropped check for zero fifo_len
> * added Fixes tags in commit message
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 0a7cd8c1aa33..8a9d2593576a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -392,6 +392,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
>  		return 0;
> =20
> +	if (!pattern_len)
> +		pattern_len =3D ST_LSM6DSX_SAMPLE_SIZE;
> +
>  	fifo_len =3D (le16_to_cpu(fifo_status) & fifo_diff_mask) *
>  		   ST_LSM6DSX_CHAN_SIZE;
>  	fifo_len =3D (fifo_len / pattern_len) * pattern_len;
> @@ -623,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw =
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

--TCV8Nel+ysraon/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ88BsgAKCRA6cBh0uS2t
rO6cAP9lH4mAzcPivWU2YzjjjKdDQnuieoUA6RK+0d++MzaFxwEAsxwK5sOeNt5O
yeWZot/H9Wz2BM/v71/uWH2P+Iz2cgU=
=iG3h
-----END PGP SIGNATURE-----

--TCV8Nel+ysraon/u--

