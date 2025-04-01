Return-Path: <linux-iio+bounces-17501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B7A77489
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE523A925D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778F1E22FC;
	Tue,  1 Apr 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+jH6uAA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BEB1D63F7
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489097; cv=none; b=iZi6W9wJcNkAArXfenmpAdf41ucFu2xkOt/Yz9N50C2BlreT4jhI3DMIJpUzeA2YkDc7+PBsM5jRBDIX17cQLjoIfULvOZ7UdQFlqHoSDK33J/PMEw8sYEMtZbp10fip6Ie1XwIDVwN8sz3xV4HalWVu/iIJ5hRno6kSoBaJdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489097; c=relaxed/simple;
	bh=Oklh6D9QCAfQT3mUKoc12UHgx+8o8PQqL3ZuYC+sU7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8w2qotKtjGOTswybbj2Ufi0/XEMqfva1n1CXW9yee+EC3OPFOcQ7H4OYNrwuHJYEsMiUFAf5s7tO5wK2noSbfcv/3uYA53hGUPywwil4stOu5YJOtsJlegJ/6C7H3GADjdCP3k+sV0kGsgNV7cHaDKmB1VTL6zL//cKJbVub2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+jH6uAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDA7C4CEE8;
	Tue,  1 Apr 2025 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743489097;
	bh=Oklh6D9QCAfQT3mUKoc12UHgx+8o8PQqL3ZuYC+sU7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+jH6uAATWS0sHQ9LLPFgs42YqGpBQ1tjFmfROrMOQbGFzmcXioJiNRiTfs4vD7Ji
	 6+ScBoyqfnikkF4aLxrMxgg2YKdAA9I5DpkCUC+fZvNckIp/Mw12dKUGYtmBoAU+ep
	 oKFS1enDjhpdZVWvp66RxP71WgZhhgj9VTIRRGXKhHVDGics2ZF1lJiHt/ucmZeosc
	 0n1EVmFZAK8Fcbsgog8EJe6fV9PV3zh/oW9cBNRncxtEdhTDIYAm35RSMBGscqk5hT
	 quw0ttimwA/uM4NaO0J6j7rxxvgbLPRFVw2IOluxBsPo63SQ5SX9FPeWwGaiRBXUiT
	 zh/BZZdiNeD5A==
Date: Tue, 1 Apr 2025 08:31:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 19/37] iio: imu: st_lsm6dsx: Switch to sparse friendly
 claim/release_direct()
Message-ID: <Z-uIRiwXVz2S-C0z@lore-desk>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-20-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ts7SMauCzh7jJVDP"
Content-Disposition: inline
In-Reply-To: <20250331121317.1694135-20-jic23@kernel.org>


--ts7SMauCzh7jJVDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This driver caused a false positive with __cond_lock() style solution
> but is fine with the simple boolean return approach now used.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 4fdcc2acc94e..670cd217eb50 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1804,12 +1804,11 @@ static int st_lsm6dsx_read_raw(struct iio_dev *ii=
o_dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(iio_dev);
> -		if (ret)
> -			break;
> +		if (!iio_device_claim_direct(iio_dev))
> +			return -EBUSY;
> =20
>  		ret =3D st_lsm6dsx_read_oneshot(sensor, ch->address, val);
> -		iio_device_release_direct_mode(iio_dev);
> +		iio_device_release_direct(iio_dev);
>  		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val =3D sensor->odr / 1000;
> @@ -1834,11 +1833,10 @@ static int st_lsm6dsx_write_raw(struct iio_dev *i=
io_dev,
>  				int val, int val2, long mask)
>  {
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> -	int err;
> +	int err =3D 0;
> =20
> -	err =3D iio_device_claim_direct_mode(iio_dev);
> -	if (err)
> -		return err;
> +	if (!iio_device_claim_direct(iio_dev))
> +		return -EBUSY;
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -1860,7 +1858,7 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio=
_dev,
>  		break;
>  	}
> =20
> -	iio_device_release_direct_mode(iio_dev);
> +	iio_device_release_direct(iio_dev);
> =20
>  	return err;
>  }
> --=20
> 2.48.1
>=20

--ts7SMauCzh7jJVDP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+uIRgAKCRA6cBh0uS2t
rP5jAQDzew0CQmJ7lfUkAHolrJIafVEPkv1A1e7FhYJ4jhUfoQD+JbKJqYx7BGay
Lbq8D006FzLVN+aDWkda9jR3ZTpsmwo=
=U6e3
-----END PGP SIGNATURE-----

--ts7SMauCzh7jJVDP--

