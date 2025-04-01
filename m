Return-Path: <linux-iio+bounces-17500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BBAA7747C
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F5518874E9
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 06:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0961E1C29;
	Tue,  1 Apr 2025 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHFvZeVO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369F1DFE00
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488988; cv=none; b=ti0/a6duO4rg6IZVfC4RAOZEwXL4a3xM3VZ4M8Z6kku10+LOV8s55/cJ+1NZrsuVaTEum1lC8k1FOkKIjxm8XLsrseG52eyF3FYS9QixKf195Gs7TrM4zN3ekP6oOXMfCSk6xDU3YI3rhrsacvOQ1s36lJCF4St93K2BJMcRvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488988; c=relaxed/simple;
	bh=NYSLOa3ahgk8l2PEqlDhlUslrk8PpM0I96D5HWG1Ops=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqtd+hK1gLni2vFzW9r/6+qcfctTIDSpw9vFXmi+k4jVl/xeLSCjhlF5rjw5EZ211k96HJJyS6X0Nq8WSSH6I/KcIy2rZT92ZHRvjssd8DvVmXG9vuCNqVwZWylpWdE7qu8utHDC1etubAfm98QariLjQSd/yxPRm66zSqEsfiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHFvZeVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54459C4CEE8;
	Tue,  1 Apr 2025 06:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743488988;
	bh=NYSLOa3ahgk8l2PEqlDhlUslrk8PpM0I96D5HWG1Ops=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHFvZeVO/wt2zcHEo4Zh23iHtSv4766tthzEIJojZugy9CtqlsQxAbptJZf0dM4YA
	 3q/JvkSuwY/fZn1bdnFcoko9XIsz4kbL+SqfnHDYvp1ICRBAbHa0D003GyAo4MN+hY
	 0c5OzSoyXGwf397ZUex3X2T2hxVgvy6Q62HGVKKzyouXaBk0sJQU8m54+PBNVooCCh
	 WEMY42x2gNghOPqhAd7QUaXf7K2px98viLa+lQIFYx219NGfI6S+65GvkIgEb3hgnd
	 ozkzPb+3q9cRLSkW586cqzKDB9WX4Y+nWuOT5Fcezz6kjH1jTMNJJstSJpVmnzLZVJ
	 CQRZ7LfaXH5Pw==
Date: Tue, 1 Apr 2025 08:29:46 +0200
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
Subject: Re: [PATCH 20/37] iio: imu: st_lsm6dsx: Switch to sparse friendly
 iio_device_claim/release_direct()
Message-ID: <Z-uH2jYGKXt6w8V3@lore-desk>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-21-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvW8XjschqHDj1KA"
Content-Disposition: inline
In-Reply-To: <20250331121317.1694135-21-jic23@kernel.org>


--cvW8XjschqHDj1KA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index 17a74f5adfc0..3c5e65dc0f97 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -558,12 +558,11 @@ st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
> =20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(iio_dev);
> -		if (ret)
> -			break;
> +		if (!iio_device_claim_direct(iio_dev))
> +			return -EBUSY;
> =20
>  		ret =3D st_lsm6dsx_shub_read_oneshot(sensor, ch, val);
> -		iio_device_release_direct_mode(iio_dev);
> +		iio_device_release_direct(iio_dev);
>  		break;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val =3D sensor->ext_info.slv_odr / 1000;
> @@ -657,13 +656,12 @@ st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
>  {
>  	int ret;
> =20
> -	ret =3D iio_device_claim_direct_mode(iio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(iio_dev))
> +		return -EBUSY;
> =20
>  	ret =3D __st_lsm6dsx_shub_write_raw(iio_dev, chan, val, val2, mask);
> =20
> -	iio_device_release_direct_mode(iio_dev);
> +	iio_device_release_direct(iio_dev);
> =20
>  	return ret;
>  }
> --=20
> 2.48.1
>=20

--cvW8XjschqHDj1KA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+uH2gAKCRA6cBh0uS2t
rGKEAP9O/C/S1POIfGPWyURiZBf2iJUAd5lhrKBkGlTy4mRsIAEA6ZfenTn66ubv
jT8+fOEQmmfLaKfNsdnT7cctVnihqQo=
=ltiR
-----END PGP SIGNATURE-----

--cvW8XjschqHDj1KA--

