Return-Path: <linux-iio+bounces-17498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F646A77476
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99CB3A90F6
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 06:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD90F1E1021;
	Tue,  1 Apr 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATcAp+8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69216C684
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488860; cv=none; b=h92xj7ATY9m1k3hd2hMivvNgXCC94whcbFR/y2wC/kSjfrgEbFYIsKL4U6Ly++frKgKvwqG4mGI/ejaOP+XkwlDbq1LM+M8u412Bqx90WrzRrTAK53RXcKIPyFbVzqherOkujcWRzGboKjlNH4vWVV7DrQ2fRK3e/m9Z+BeXwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488860; c=relaxed/simple;
	bh=1b/VfZ3BzGsq4okw8Ym39UODVHHMfVev7nPp0lItVO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovUxvyo6COU32OlBEvr18hoPw+4Z2ZtegRiy8mCPmSP+G7Z72z4ZNgL/8Gj9eQ9+agjcuN09/vrI0OS2RlzIR4UMtoqets9UXLaYtx4XlJpG2EcJYRAwFKy7rPfrlbUgOLfKUHcKEgoUSAzDv/Pv0H6H2uCmNu3FKIlldlkEBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATcAp+8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B3BC4CEE9;
	Tue,  1 Apr 2025 06:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743488859;
	bh=1b/VfZ3BzGsq4okw8Ym39UODVHHMfVev7nPp0lItVO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATcAp+8VPbCr1N6OmJ1bfPu0OwWqCOjxf2wbsmVK4Dcy+w/foaCF3QnAboftBaWfI
	 odKM5fJj15b8bwmgEYIKn94LQrOwl8UBH86DI8EPaLyYj9BD6Vn3RxWqh/JYesmgr4
	 sI4qP+hroAOHpTmQQrme2Y1IGHcExnsea6ssKSAoGQfJyixf4fo2JWpb5vKm97Pwy3
	 HXh/yPP5VOFMEVRAA3OPX0C1+5OLCGKw0GYhanCzUkap5azyRAgSntCoPkSzpfzVe+
	 FmGpt5E5UAdUKBqwL6lr5Tz8Mz7zHl9CJyEOxnvVplplzALhQVxGFldwIFWdnE5nF2
	 lYa141Rua4X/Q==
Date: Tue, 1 Apr 2025 08:27:37 +0200
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
Subject: Re: [PATCH 18/37] iio: imu: st_lsm6dsx: Factor out parts of
 st_lsm6dsx_shub_write_raw() to allow direct returns
Message-ID: <Z-uHWYQ8tLU63B1T@lore-desk>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-19-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cCyhYw81pHGT7F27"
Content-Disposition: inline
In-Reply-To: <20250331121317.1694135-19-jic23@kernel.org>


--cCyhYw81pHGT7F27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> By factoring out all the code that occurs with direct mode claimed
> to a helper function, that helper function can directly return simplifying
> code flow.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 65 +++++++++++---------
>  1 file changed, 35 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_shub.c
> index c1b444520d2a..17a74f5adfc0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -614,53 +614,58 @@ st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_se=
nsor *sensor,
>  }
> =20
>  static int
> -st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> -			  struct iio_chan_spec const *chan,
> -			  int val, int val2, long mask)
> +__st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
>  {
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>  	int err;
> =20
> -	err =3D iio_device_claim_direct_mode(iio_dev);
> -	if (err)
> -		return err;
> -
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +		struct st_lsm6dsx_sensor *ref_sensor;
> +		u8 odr_val;
>  		u16 data;
> +		int odr;
> =20
>  		val =3D val * 1000 + val2 / 1000;
>  		err =3D st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
> -		if (!err) {
> -			struct st_lsm6dsx_hw *hw =3D sensor->hw;
> -			struct st_lsm6dsx_sensor *ref_sensor;
> -			u8 odr_val;
> -			int odr;
> -
> -			ref_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> -			odr =3D st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
> -			if (odr < 0) {
> -				err =3D odr;
> -				goto release;
> -			}
> -
> -			sensor->ext_info.slv_odr =3D val;
> -			sensor->odr =3D odr;
> -		}
> -		break;
> +		if (err)
> +			return err;
> +
> +		ref_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +		odr =3D st_lsm6dsx_check_odr(ref_sensor, val, &odr_val);
> +		if (odr < 0)
> +			return odr;
> +
> +		sensor->ext_info.slv_odr =3D val;
> +		sensor->odr =3D odr;
> +		return 0;
>  	}
>  	case IIO_CHAN_INFO_SCALE:
> -		err =3D st_lsm6dsx_shub_set_full_scale(sensor, val2);
> -		break;
> +		return st_lsm6dsx_shub_set_full_scale(sensor, val2);
>  	default:
> -		err =3D -EINVAL;
> -		break;
> +		return -EINVAL;
>  	}
> +}
> +
> +static int
> +st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(iio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __st_lsm6dsx_shub_write_raw(iio_dev, chan, val, val2, mask);
> =20
> -release:
>  	iio_device_release_direct_mode(iio_dev);
> =20
> -	return err;
> +	return ret;
>  }
> =20
>  static ssize_t
> --=20
> 2.48.1
>=20

--cCyhYw81pHGT7F27
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+uHWQAKCRA6cBh0uS2t
rPpQAQC5sK6w8OHlwLrK4oUWulVhnSgVCz+H/6DG/kGZfucIfAD7BWvTWXYbS4Tg
B5z5Rt4S6shVGbqsC/1cMx22LBZgGQ0=
=vXFX
-----END PGP SIGNATURE-----

--cCyhYw81pHGT7F27--

