Return-Path: <linux-iio+bounces-27287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5ACD4410
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D68703007613
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF154287510;
	Sun, 21 Dec 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcpHZkUS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B32236F3;
	Sun, 21 Dec 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766342508; cv=none; b=lYzIhj46RRdjmovEHZ/eRlf6IK5MZVkaWgpTb2LfwfdzTrjWccxz6gdK1NF7ucNmURticrpT8FOz4u9rAcaadWfXoLOffiT4q/o1lREe67tbx3J1PgZoSo5jy7t13rmGqAZf/GTzHEXag4MazWS7qKVQjw/t4dJWg9Bkn8UWlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766342508; c=relaxed/simple;
	bh=iTAioDNIVMSoAk8ZF4aROFEIP5mRNtVX1Hs5JoJg6BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAb4zVydKjmYvmapcAjFC9JtmsRDr1wSB/kOK8xXCCDhXnVRI+nHdiQxJJqYK8z7d4wVwd3MmQEpvKrMExCDbCvhjOBQGqVEkpRtPz9X0MN2Ht2S8TkU56gotREclBig0mOaCqXrM17sYKAKjTGeUjN0uXR2BdymoCZu78+rfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcpHZkUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CACC4CEFB;
	Sun, 21 Dec 2025 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766342508;
	bh=iTAioDNIVMSoAk8ZF4aROFEIP5mRNtVX1Hs5JoJg6BQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IcpHZkUSNVDWobq/midlLjOM6CVdAqIV8a7cwH8lmDdqP1fiLth4z94mK2OK2AMyA
	 6j8ipmz19rWQLFM4bvIRAMTXhxh30QyKAagS26/K26Dx9SRTJ6doqip8XQiTyD/VPG
	 rC5OcNSfJHRf80oAIN1/5hhYVd56n2ITzoXu2VlOesm47DJAn6yU5TdhYlnsMb4IrA
	 BUK/b/l53EyQXLYUJhqbKPU2Lu8Pne5k2YDplIiULIENX+gq2P6h98q+1D4/SOsK0R
	 IA5lGN8Qfj/3QuIhIHTFRYHtWrIh/HEfL0U7DMQTKklv+iyFiu48ELgpG9JD9ZgGC1
	 Zt9uOGcTX4oXA==
Date: Sun, 21 Dec 2025 18:41:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Remi Buisson <remi.buisson@tdk.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix temperature offset
 reporting
Message-ID: <20251221184139.7b253cdd@jic23-huawei>
In-Reply-To: <20251218-inv-icm45600-fix-temperature-offset-reporting-v1-1-4872f381cbc2@tdk.com>
References: <20251218-inv-icm45600-fix-temperature-offset-reporting-v1-1-4872f381cbc2@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Dec 2025 11:30:59 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com=
@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Correct temperature computation is (raw + offset) * scale and not
> apply scale and offset afterward.
> Fix temperature offset reporting to the correct value and update
> commentaries for the new computation.
>=20
> Fixes: 27e072bc34d1 ("iio: imu: inv_icm45600: add IMU IIO gyroscope devic=
e")
>=20
No blank line here.  That breaks a bunch of scripts and is checked for
in upstream trees so with the line break this would be rejected.
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: stable@vger.kernel.org
Applied to the fixes-togreg tree.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/i=
io/imu/inv_icm45600/inv_icm45600_core.c
> index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..25bd9757a594d0180d7f53b49=
f959a49a50c64a9 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> @@ -960,16 +960,17 @@ int inv_icm45600_temp_read_raw(struct iio_dev *indi=
o_dev,
>  		return IIO_VAL_INT;
>  	/*
>  	 * T=C2=B0C =3D (temp / 128) + 25
> -	 * Tm=C2=B0C =3D 1000 * ((temp * 100 / 12800) + 25)
> -	 * scale: 100000 / 13248 =3D 7.8125
> -	 * offset: 25000
> +	 * Tm=C2=B0C =3D ((temp + 25 * 128) / 128)) * 1000
> +	 * Tm=C2=B0C =3D (temp + 3200) * (1000 / 128)
> +	 * scale: 1000 / 128 =3D 7.8125
> +	 * offset: 3200
>  	 */
>  	case IIO_CHAN_INFO_SCALE:
>  		*val =3D 7;
>  		*val2 =3D 812500;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val =3D 25000;
> +		*val =3D 3200;
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>=20
> ---
> base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
> change-id: 20251218-inv-icm45600-fix-temperature-offset-reporting-190a09a=
dfdad
>=20
> Best regards,


