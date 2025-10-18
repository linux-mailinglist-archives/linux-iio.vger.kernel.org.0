Return-Path: <linux-iio+bounces-25217-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD215BECCAA
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC23BB3E9
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B35285CB9;
	Sat, 18 Oct 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv1gDrZ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5142620E4;
	Sat, 18 Oct 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760780022; cv=none; b=V7+I0ZpRXx1svbzpNiCes6vtXDAhQ0eIHsC+hjznwLMWTrefQoG1UuPxyeanNHhYSDDcrWBylczWi4oS0/r2yB2Na3jx1kd4NJG3+lxpdV2dbGcgvukItTu8/Pe3e+AWOwj97smnsS2dhniUzVNVlT/dgsg56k+hd6j8azrtte0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760780022; c=relaxed/simple;
	bh=SyWZ/X1HeimDJIqB36pL4lX+V8efNvJBhXHvgyur5vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5IOcxwNFXitfAyr+bJjJ9FL5uToFT3UfQVbps0Ovfc86qISFegQo0TuvlXRfED0AiDQMU1n/7oIz5fmFqO2Aamicc54vxl8PUa4lTeNRU+8gNmzWViBl16i20Bbx3MjV2QYT/xN57AGoHG4ZlFhr+5BjxvoDlheLZmP2WrFvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv1gDrZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F590C4CEF8;
	Sat, 18 Oct 2025 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760780022;
	bh=SyWZ/X1HeimDJIqB36pL4lX+V8efNvJBhXHvgyur5vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lv1gDrZ28P0Cl3sVkOQMaAY2tLB06f1ASVwUqcbd7F+R2nedSwjhIn9FTw4kciNLf
	 B8zwHhvI8NrlCUJuQPY4CVxfGdx2yOnEMq0blaV0qLmd71rvE2N9X0J+Xgmtai6ot0
	 9YIUiefsm2OJgQLiBp2RRSfjz0odnbjnxTRmRPrl7BAboSfqzSXvjq76cDaxG2PATr
	 pcLO0CeqhRvC/v1PsWcqCq732uLniQutx4JV3AFA066M0yqbhqu1Tz3qKSeTaxWKSa
	 7qgVo65AmF44Zv9eKpsMh4Hb4AIuRFEM4HjFPETMHjTNbjD4A7/hp3sZFIZ7brkiC8
	 odGNL4I5bDKlg==
Date: Sat, 18 Oct 2025 11:33:39 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix array size for
 st_lsm6dsx_settings fields
Message-ID: <aPNe89G5mNxhMEbo@lore-desk>
References: <20251017173208.1261990-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMSeJ7rw5cSv6CJV"
Content-Disposition: inline
In-Reply-To: <20251017173208.1261990-1-flavra@baylibre.com>


--qMSeJ7rw5cSv6CJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The `decimator` and `batch` fields of struct st_lsm6dsx_settings
> are arrays indexed by sensor type, not by sensor hardware
> identifier; moreover, the `batch` field is only used for the
> accelerometer and gyroscope.
> Change the array size for `decimator` from ST_LSM6DSX_MAX_ID to
> ST_LSM6DSX_ID_MAX, and change the array size for `batch` from
> ST_LSM6DSX_MAX_ID to 2; move the enum st_lsm6dsx_sensor_id
> definition so that the ST_LSM6DSX_ID_MAX value is usable within
> the struct st_lsm6dsx_settings definition.
>=20
> Fixes: 801a6e0af0c6c ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 3cd520bdec46..a4f558899767 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -252,6 +252,15 @@ struct st_lsm6dsx_event_settings {
>  	u8 wakeup_src_x_mask;
>  };
> =20
> +enum st_lsm6dsx_sensor_id {
> +	ST_LSM6DSX_ID_GYRO,
> +	ST_LSM6DSX_ID_ACC,
> +	ST_LSM6DSX_ID_EXT0,
> +	ST_LSM6DSX_ID_EXT1,
> +	ST_LSM6DSX_ID_EXT2,
> +	ST_LSM6DSX_ID_MAX,
> +};
> +
>  enum st_lsm6dsx_ext_sensor_id {
>  	ST_LSM6DSX_ID_MAGN,
>  };
> @@ -337,23 +346,14 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_odr_table_entry odr_table[2];
>  	struct st_lsm6dsx_samples_to_discard samples_to_discard[2];
>  	struct st_lsm6dsx_fs_table_entry fs_table[2];
> -	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> -	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> +	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_ID_MAX];
> +	struct st_lsm6dsx_reg batch[2];
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
>  	struct st_lsm6dsx_shub_settings shub_settings;
>  	struct st_lsm6dsx_event_settings event_settings;
>  };
> =20
> -enum st_lsm6dsx_sensor_id {
> -	ST_LSM6DSX_ID_GYRO,
> -	ST_LSM6DSX_ID_ACC,
> -	ST_LSM6DSX_ID_EXT0,
> -	ST_LSM6DSX_ID_EXT1,
> -	ST_LSM6DSX_ID_EXT2,
> -	ST_LSM6DSX_ID_MAX,
> -};
> -
>  enum st_lsm6dsx_fifo_mode {
>  	ST_LSM6DSX_FIFO_BYPASS =3D 0x0,
>  	ST_LSM6DSX_FIFO_CONT =3D 0x6,
> --=20
> 2.39.5
>=20

--qMSeJ7rw5cSv6CJV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaPNe8wAKCRA6cBh0uS2t
rOt7APsF2vUunuaXfc9x9FSpXNkU2ROeoiSBlvzIpuT0co9ElQD/Xh1Cuxi1v74B
vdHvg/Pe1Gz1lSaXoyJq02h5iciyggI=
=skr4
-----END PGP SIGNATURE-----

--qMSeJ7rw5cSv6CJV--

