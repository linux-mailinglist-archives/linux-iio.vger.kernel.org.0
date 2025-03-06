Return-Path: <linux-iio+bounces-16480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1CA54F7F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 16:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918CA188D895
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8685211282;
	Thu,  6 Mar 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxh7bD2K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6B17995E;
	Thu,  6 Mar 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276115; cv=none; b=XhfvHywiaGg7RoUvWj+YGYBOZw4TEnDVxDWPTXR11hiSJccKbQ61xLT01fhGgo0O+KYsefkdfqpx+Tbq/uuU6i272YHtI4Ejc1too1aGGrNZxRLKWzCWRpMyJAAldFW3xiRGoZ0wbaMiy1u0D9x7AiMT+Dcdv90Q1aqOYgk/Bhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276115; c=relaxed/simple;
	bh=PDJ75QttWLXTpda8lbsTkqPOcwBPVsB29z11KajauSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMDchWSVaE8kC/s+Fkiy8nMuuUeVqwg5MAh74/ZJDZbWuxG8mTv+uhhIzpHMkKqB/KbS7mMW1xR7rtctOCMiQYkn72/ym+Y3WJVCshTfGXCbcKx0bwmsGS0nHUrbvldLP6dkQ60CaSHO8qQznyi7RZgUjvuAGojN4sBIzqhRBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxh7bD2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923FBC4CEE8;
	Thu,  6 Mar 2025 15:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741276113;
	bh=PDJ75QttWLXTpda8lbsTkqPOcwBPVsB29z11KajauSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gxh7bD2KfRm/zIyyBKVZGuPR0ZdEqMVyIayfMUtF/umRbiPCARd3V7xr6v2YMMyiI
	 BcyJAwHsZl0d8D6Yb4CAx2KLXX7nPP25rLuRSZs3HxBTeXTMIfDOdpZ3WrdUVUqZGB
	 g5xetXuZnsaut08DyRv5hD/9Nhj3YfBO91UFFwiY85mia7pH6SR2j50btdgBfBO4th
	 qzZQSKBahdPiAS7DfapsPnexmRpoPn22OixcY2501EYfaIa8T6X0xz1sZTAM5Ob3l7
	 n/HJR98hiUYL8uKHKfhMI+qettf9qggSF6IB30cyHm/lxxCVxWJYcbBuMH8cdKE5ZF
	 bYM7czwLWHTmQ==
Date: Thu, 6 Mar 2025 16:48:31 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Silvano Seva <s.seva@4sigma.it>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"open list:ST LSM6DSx IMU IIO DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO
 read
Message-ID: <Z8nDzyVO596rW0Mf@lore-desk>
References: <20250303132124.52811-2-s.seva@4sigma.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jIYADJ6xeaDfrRk2"
Content-Disposition: inline
In-Reply-To: <20250303132124.52811-2-s.seva@4sigma.it>


--jIYADJ6xeaDfrRk2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
> index 0a7cd8c1aa33..7f343614f8a5 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -395,12 +395,17 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	fifo_len =3D (le16_to_cpu(fifo_status) & fifo_diff_mask) *
>  		   ST_LSM6DSX_CHAN_SIZE;
>  	fifo_len =3D (fifo_len / pattern_len) * pattern_len;
> +	if (!fifo_len)
> +		return 0;

I do not think this check is necessary since if fifo_len is 0 we will not r=
un
the for loop, right?

> =20
>  	acc_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
>  	gyro_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
>  	if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
>  		ext_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0]);
> =20
> +	if (!pattern_len)
> +		pattern_len =3D ST_LSM6DSX_SAMPLE_SIZE;

same here, I do not think pattern_len can be 0 since hw->sip must be greater
than 0 in order to enable the FIFO. Moreover, this check should be some lin=
es
above since we have already divided fifo_len by pattern_len here.

> +
>  	for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_len) {
>  		err =3D st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
>  					    hw->buff, pattern_len,
> @@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw =
*hw)
>  	if (!fifo_len)
>  		return 0;
> =20
> +	if (!pattern_len)
> +		pattern_len =3D ST_LSM6DSX_TAGGED_SAMPLE_SIZE;

for the reason above, this is not necessary.

Regards,
Lorenzo

> +
>  	for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_len) {
>  		err =3D st_lsm6dsx_read_block(hw,
>  					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
> --=20
> 2.48.1
>=20

--jIYADJ6xeaDfrRk2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ8nDzwAKCRA6cBh0uS2t
rNrsAQCt/2kEIeYw3RhVJeUiSsUinpgqHklJ0PLaJocnRAdqDgEA/pIyU/bbKsjl
Wv0S0zV2oJ09LA/ZJ1AVOlSvLtNUjgw=
=UeEg
-----END PGP SIGNATURE-----

--jIYADJ6xeaDfrRk2--

